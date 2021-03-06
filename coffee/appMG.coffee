MG = @MG || (module? && require? && require('./musical').MG) || {}


class @Analyzer
  constructor: (@key_sig, @scale_name)->
    @scale = MG.scale_class[@scale_name]
    @key_ref = MG.key_class[@key_sig]
    @toScale = MG.pitchToScale(@scale_name, @key_sig)
    @key_sig_acc = MG.key_sig[@key_sig]
  pitch_info: (pitch, chord)->
    info = {}
    if chord?
      if typeof chord == 'string'
        chord = MG.getChords(chord,3,@key_sig)
      info.isChordTone = false
      for i,p of chord[1]
        if (chord[0]+p-pitch)%12 == 0
          info.isChordTone = true
          break

    tmp = @toScale(pitch)
    info.inScale = tmp[2] == 0

    key = MG.scale_keys[s.key_sig][tmp[0]]
    # adjust
    sharp = MG.key_sig[@key_sig] >= 0
    info.keyName = if info.inScale then [key, pitch//12 - ({'Cb':0, 'B#':2}[key] || 1)] else MG.pitchToKey(pitch, sharp)
    return info

obj_sort = (data) ->
  MG.obj_sort(data, true)

MG.midi_statistics = midi_statistics = (obj) ->
  info =
    rhythm: {}
    melody:
      one: {}
      two: {}
    range:[]
  one = {}
  two = {}
  n_one = 0
  n_two = 0


  obj.forEach (e,ii) ->
    measure = _.unzip(e)
    r = measure[0]
    info.rhythm[r] = 1 + (info.rhythm[r] || 0)
    r = measure[1]
    info.range.push _.max(r) - _.min(r)

    if r.length < 2
      return
    c = [
      r[0] % 12
      (r[1] - (r[0])) % 12
    ]
    one[c] ?= 0
    one[c]++
    n_one++
    i = 2
    while i < r.length
      c = [
        r[i - 1] % 12
        (r[i] - (r[i - 1])) % 12
      ]
      one[c] = 1 + (one[c] or 0)
      n_one++
      c = [
        r[i - 2] % 12
        (r[i - 1] - (r[i - 2])) % 12
        c[1]
      ]
      two[c] = 1 + (two[c] or 0)
      n_two++
      ++i
    return
  info =
    rhythm: MG.obj_sort(info.rhythm, true)
    melody:
      one: MG.obj_sort(one, true)
      two: MG.obj_sort(two, true)
      n: [
        0
        n_one
        n_two
      ]
    range: info.range




class @AppMG
  constructor: (@ui, options) ->
    tracks_container = $(@ui.tracks_container)
    options_container = $(@ui.options_container)
    @tracks_tabs = tracks_container.children('.nav-tabs')
    @tracks_contents = tracks_container.children('.tab-content')
    @options_tabs = options_container.children('.nav-tabs')
    @options_contents = options_container.children('.tab-content')
    @renderer = new ScoreRenderer(@ui.renderer[0], undefined,  @ui.renderer[1])


    @editor = {}
    @ui.editor[0].forEach (id,i)=>
      # append new tabs
      wrapper = "track_#{i}"
      ele = $('<li data-toggle="tab" data-target="#'+wrapper+'"><a href="#'+wrapper+'">'+id[0].toUpperCase()+id.substr(1)+'</a></li>')
      ele.children().append($('<span class="glyphicon glyphicon-play"></span>'))
      @tracks_tabs.children('li.tab_plus').before(ele)
      ele = $('<div class="tab-pane" id="'+wrapper+'"><div class="editor" id="ace_' + id.toLowerCase()+'" style="height:300px"></div></div>')
      @tracks_contents.append(ele)
      editor = ace.edit('ace_'+id.toLowerCase())
      editor.setTheme("ace/theme/clouds")
      editor.getSession().setMode("ace/mode/" + @ui.modes[0][i])
      # editor.getSession().setUseWrapMode(true);
      editor.setFontSize(16)
      editor.$blockScrolling = Infinity
      @editor[id] = editor
    @tracks_tabs.children().first().addClass('active')
    @tracks_contents.children().first().addClass('active in')
    @ui.editor[1].forEach (id, i)=>
      wrapper = "options_#{i}"
      ele = $('<li data-toggle="tab" data-target="#'+wrapper+'"><a href="#'+wrapper+'">'+id[0].toUpperCase()+id.substr(1)+'</a></li>')
      @options_tabs.children('li.tab_plus').before(ele)
      ele = $('<div class="tab-pane" id="'+wrapper+'"><div class="editor" id="ace_' + id.toLowerCase()+'" style="height:300px"></div></div>')
      @options_contents.append(ele)
      editor = ace.edit('ace_'+id.toLowerCase())
      editor.setTheme("ace/theme/clouds")
      editor.getSession().setMode("ace/mode/"+@ui.modes[1][i])
      editor.getSession().setUseWrapMode(true);
      editor.setFontSize(14)
      editor.$blockScrolling = Infinity
      @editor[id] = editor
    @options_tabs.children().first().addClass('active')
    @options_contents.children().first().addClass('active in')
    @player = null

    @playbtns = @ui.playbtns.map (id, i)=>
      ret = $(id+'>span.glyphicon')
      ret.on('click', =>
        @play(i)
      )
      ret

    @reset(options)



    return

  reset: (options)->
    if options?
      version = options.version
      version ?= "0.1"
      switch version
        when "0.1"
          {@schema, @settings, @contents}  = options
        when "0.2"
          {@schema, @settings}  = options
          @contents = {}
          for ele in options.contents
            @contents[ele.mode] = ele.data
          @contents.harmony = options.harmony

      @obj = options
    else
      @schema = MG.circularClone(MG.schema_summer)
      @settings = MG.circularClone(MG.score_summer.settings)
      @contents = MG.circularClone(MG.score_summer.contents)
      @obj = null



    playbtns = @playbtns
    @player = new MG.seqPlayer()
    @player.onend = (n)->
      i = @cur_i[n]
      if i>0 && i<@tracks[n].length
        return
      playbtns[n].toggleClass('glyphicon-play glyphicon-pause')
    @updateEditor()


  export: ->
      version: "0.2"
      settings: @settings
      schema: @schema
      harmony: @contents.harmony
      contents: [
        {
          "mode": "melody",
          "data": @contents.melody
        },
        {
          "mode": "texture",
          "data": @contents.texture
        }
      ]

  updateEditor: ->
    _.flatten(@ui.editor).forEach (e) =>
      if e == 'schema'
        ret = MG.schema_parser.produce(@schema)
      else if @contents[e]?
        ret =  @contents[e].join('\n')
      else
        ret = JSON.stringify(@[e], null, 2)
      @editor[e].setValue ret, -1
      return


  play: (n)->
    if !@player.playing[n]
      @player.play(n)
    else
      @player.pause(n)
    @playbtns[n].toggleClass('glyphicon-play glyphicon-pause')

  parse: ->
    try
      @settings = JSON.parse(@editor.settings.getValue())
    catch e
      $.notify('Bad score format!', 'warning')
    try
      @schema = MG.schema_parser.parse(@editor.schema.getValue());
    catch e
      console.log e.message
      $.notify('Bad schema format!', 'warning')
    ['melody','harmony','texture'].forEach (e)=>
      @contents[e] = @editor[e].getValue().split(/[\n]+/)
    @obj = new ScoreObj(@settings, @contents)
    @player.fromScore(@obj)
    return @obj

  generate: ->
    @settings = JSON.parse(@editor.settings.getValue())
    try
      @schema = MG.schema_parser.parse(@editor.schema.getValue());
    catch e
      console.log e.message
      $.notify('Bad schema format!', 'warning')
    generator = new Generator(@settings, @schema);
    generator.generate();
    score = generator.toScoreObj()
    # console.log('to Text')
    @contents.melody = score.toText();
    @contents.harmony = score.harmony_text
    @updateEditor();

  # analyze midi file
  analysis: (data, ctrl_per_beat) ->
    data ?= MIDI.Player.currentData
    ctrl_per_beat ?=  8
    m = MidiFile(data)
    settings = {
      key_sig: MG.key_sig_rev[m.getKeySignature()[0]],
      time_sig: m.getTimeSignature(),
      ctrl_per_beat: ctrl_per_beat
    }
    q = m.quantize(ctrl_per_beat)
    tracks = q.map((track) ->
      res = []
      tmp = []
      # handle
      delta = 0
      track.forEach (e) ->
        if e[0] > delta
          if tmp.length > 0
            res.push [
              e[0] - delta
              tmp
            ]
            tmp = []
          else
            res.push [
              e[0] - delta
              [ 0 ]
            ]
          #rest
          delta = e[0]
        # ignore 'noteOff' and velocity == 0

        if e[1] == 'noteOn' and e[3] != 0
          tmp.push e[2]
        else if e[1] == 'timeSignature'
          console.log 'time_sig change', e
        else if e[1] == 'keySignature'
          console.log 'key_sig change', e

        #noteNumber
        return
      res = _.unzip(res)
      res =
        dur: res[0]
        pitch: res[1]
      ret = Generator::b2score.call {}, res, ctrl_per_beat * settings.time_sig[0]
      ret.info = midi_statistics(Generator::b2score.call {}, res, ctrl_per_beat)
      return ret
    )

    obj = new ScoreObj(settings)

    obj.setMelody tracks[0], true
    obj.setTexture tracks[1], [], true
    @obj = obj
    @editor.settings.setValue(JSON.stringify(@obj.getSettings(),null,2), -1);
    @editor.melody.setValue(@obj.toText().join('\n'), -1);
    #@renderer.render(@obj)
    info =  tracks.map (e)-> e.info
    #console.log info
    MG.ref_midi_info = info[0]
    return info




