MG = @MG || (module? && require? && require('./musical').MG) || {}


parser = MG.score_parser = @score_parser || (module? && require? && require('../coffee/score_parser')) || require('./coffee/score_parser')

###
    sample data
###
@score_summer = MG.score_summer =
  settings:
    tempo: 120,
    time_sig: [4,4],
    key_sig: 'C',
    scale: 'maj',
    ctrl_per_beat: 16,
    volumes: [110,80],
    instrs: [66,1]
  contents:
    melody: ':+ 0,2 3 1/3,1^/3,2 2 1 2 3 1,2/:- 6 3,1^/3,2 :+ 3 1/2 2,7^/2,2 1 6- 1 6- 1,2/:- 7,1^/7,4 0 :+ 3,2 1/3 3,2 3,1^ 3,4^/3,2 2 1 2 3 1,2/:- 6 3,1^/3,3 3/5,2 3 5 6,2 :+ 1,2/3 2,3 1,4/:- 6,1^/6,2 :+ 3 1'.split('/'),
    harmony: "E7/Amin/Bb7/Amin E7/Amin A7/Dmin/F7/F#min7 B7/E7/Am/Bb7/Am/D7/C Am/D7 E7/Am D7/Bm7 E7".split('/'),
    texture: "@-123 0 123/@-11-32+ 12 3 4 3/@iii-11-32+ 12 3 4 3/@-123 123 @-123 123/@-123 123 @-123 123/@-11-32+ 12 3 4 3/@-11-32+ 12 3 4 3/@-123 123 123/@-11-32+ 12 3 4 3/@-123 123 123/@-123 123 123/@-123 123 123/@-123 123 123/@-123 123 @-123 123/@-123 123 @-123 123/@-123 123 @-123 123/@-123 123 @-123 123".split('/')

MG.score_dance =
  settings:
    tempo: 188,
    time_sig: [
      6,
      8
    ],
    key_sig: "C",
    scale: "maj",
    ctrl_per_beat: 4,
    volumes: [
      110,
      80
    ],
    instrs: [
      1,
      1
    ]
  contents:
    harmony: [
      "Am7#,3 Am,4",
      "G#dim7 Am",
      "Am7#,3 Am,2 E7,2",
      "Am7b5 G#dim",
      "Am",
      "F",
      "C7",
      "C7",
      "F F7",
      "Fm Fm7#",
      "C7",
      "Fm",
      "C7",
      "F",
      "C7",
      "C7",
      "F F7",
      "Fm Fm7#",
      "C7",
      "Fm",
      "C7",
      "Fm C7",
      "C7 F7",
      "F7 ",
      "Am7#,3 Am,4",
      "G#dim7 Am",
      "Am7#,3 Am,2 E7,2",
      "Am7b5 G#dim",
      "Am",
      "Am",
      ""
    ],
  melody:[
      "%% A",
      ":+t7/8 3 4 3 2# 3 7- 1 2 1 0 :- 6 0 3 0",
      ":t6/8 7,4 3 0 :+ 1 2 1 0 3- 0",
      ":t7/8 3 4 3 2# 3 7- 1 2 1 0 :- 6 0 3 0",
      ":t6/8 6,4 6 0 7,4 5# 0",
      "6 0 :+ 1 0 3 0 6,2 0,2 1 0",
      "%% B",
      "1,3 2 1,2 4,4 3,2",
      "3,3 2,2 1",
      "1,3 2 1,2 5,4 4,2",
      "4,3 1,2 1",
      ":kAb 1,2 1 1 :- 7 6",
      "7,2 5# 3,2 3",
      "6,2 7 1+ 7 6",
      "2+,3 7,2 3+",
      ":kC+ 1,3 2 1,2 4,4 3,2",
      "3,3 2,2 1",
      "1,3 2 1,2 5,4 4,2",
      "4,3 1,2 1",
      ":kAb 1,2 1 1 :- 7 6",
      "7,2 5# 3,2 3",
      "6,2 7 1+ 7 6",
      "2+,4 7,2 :+ 3 0 4# 5 5# 7",
      "1+,2 1+ 7 6 1+ 7 0 5# 0 3 0",
      "7,2 7 6 5# 7 6 0 3 0 1# 0",
      ":kC :+ 3b,4 3,2 4 3 2# 3 4 0",
      "%% A",
      ":t7/8 3 4 3 2# 3 7- 1 2 1 0 :- 6 0 3 0",
      ":t6/8 7,4 3 0 :+ 1 2 1 0 3- 0",
      ":t7/8 3 4 3 2# 3 7- 1 2 1 0 :- 6 0 3 0",
      ":t6/8 6,4 6 0 7,4 5# 0",
      "6 :+ 1 3 1 6 5# 6,2 0,4",
      "136 0,2",
      ""]
  texture:[
      "%% A",
      ":t7/8 @1-2341+ 1 235 234 @1-231+ 1 34 23 0",
      ":t6/8 @1-234 1 234 0 @1234 1 234 0",
      ":t7/8 @1-2341+ 1 235 234 @123 1 23 @341+ 123 0",
      ":t6/8 @ii1234 14 23 0 @1231+ 14 23 0",
      "@1231+ 1 3 2 234 0,2",
      "%% B",
      "% b1",
      "@1231+ 1 23 34 1 34 23",
      "@12341+ 1 245 23 1 245 23",
      "@12341+ 2 345 345 1 345 345",
      "@1231+ 1 34 23  @1234 1 3 24",
      "@1233- 1 23 4  @124- 12 3 1",
      "@12331+ 23 1 0 34 45 0",
      "@1231- 1 23 4 1 23 4",
      "@12341+2+ 1 235 46 2 35 1 ",
      "% b2",
      "@1231+ 1 23 34 1 34 23",
      "@12341+ 1 245 23 1 245 23",
      "@12341+ 2 345 345 1 345 345",
      "@1231+ 1 34 23  @1234 1 3 24",
      "@1233- 1 23 4  @124- 12 3 1",
      "@12331+ 23 1 0 34 45 0",
      "@1231- 1 23 4 1 23 4",
      "@2341+2+ 1 245 0 134 0,2",
      "% bridge",
      "@1234 1 23 34 @i1234 1 24 23 ",
      "1 234 234 @1234- 1 23 4",
      "@12341+ 124 3 0 235 0,2",
      "%% A",
      ":t7/8 @1-2341+ 1 235 234 @1-231+ 1 34 23 0",
      ":t6/8 @1-234 1 234 0 @1234 1 234 0",
      ":t7/8 @1-2341+ 1 235 234 @123 1 23 @341+ 123 0",
      ":t6/8 @ii1234 14 23 0 @1231+ 14 23 0",
      "@1231+ 1 3 2 234 0,2",
      "@13 13 0,2",
      ""]


# @return: array of measures with info
# TODO: to Snippet with settings
MG.parseMelody = (m, options)->
  try
    obj = MG.score_parser.parse(m.join('\n')+'\n')
  catch e
    $.notify('parsing error!', 'warning')
    console.log e.message
    return

  #console.log 'parse melody', options
  ornamental = (pitch, ref, scale)->
    p = if typeof pitch is 'number' then pitch else pitch.original
    if p > scale.length
      console.log 'exceed scale length'
      p = scale.length
    else if p == 0
      # rest
      return 0
    p = ref + scale[p-1]
    if typeof pitch isnt  'number'
      pitch.ornament.forEach (e)->
        if typeof e == 'number'
          p += e
    return p

  switch obj.mode
    when 'melody'
      {scale, init_ref, harmony} = options
    when 'harmony'
      harmony = options.harmony

  tatum = options.ctrl_per_beat * options.time_sig[0]
  refc = null
  chorder = MG.harmony_progresser(harmony)
  # do something
  # 1 set up states
  scale ?= MG.scale_class['maj']
  tempo_map = {0:options.tempo}
  key_sig_map = {0:options.key_sig}
  time_sig_map = {0:options.time_sig}

  init_ref ?= MG.keyToPitch(options.key_sig + '4') ? 60 # C4
  ref = init_ref
  # 2 iterate obj.data
  res = obj.data.map (m,i)->
    #console.log 'parse measure', i
    measure = []
    dur_tot = 0

    durs = []
    m.forEach (e)->
      if e.ctrl?
        if e.t?
          tatum = e.t[0] * options.ctrl_per_beat
      else
        if typeof e.dur == 'number'
          dur_tot += e.dur
          durs.push e.dur
        else
          dur_tot += e.dur.original
          durs.push e.dur.original
    # renormalize
    r = tatum // dur_tot
    # TODO: check integer
    dur_tot = 0
    m.forEach (e)->
      if not e.ctrl?
        if typeof e.dur == 'number'
          e.dur *= r
          dur_tot += e.dur
        else
          e.dur.original *= r
          dur_tot += e.dur.original

    m.forEach (e)->

      if e.ctrl?
        # set options
        switch e.ctrl
          when 'reset'
            ref = init_ref
          when 'normal','repeat_start'
            for k,v of e
              switch k
                when 't' # set time_sig
                  time_sig_map[i] = v
                when 's' then scale = MG.scale_class[v]
                when 'k'  # set key_sig
                  key_sig_map[i] = v
                  ref = init_ref = MG.keyToPitch(v+4)
                when 'r' # set tempo
                  tempo_map[i] = v
                when 'v' then 1 # set volume
                when 'o' then 1 # set output instrument
                when 'i' then 1 # inverse chord
                when 'p' then ref += v
          when 'chord'
            ref = MG.keyToPitch('C3') # 48
            chorder.process()
            bass = chorder.bass(e.inv)
            chord = chorder.chord(e.inv)

            ref += e.transpose
            bass += ref
            refc = e.pitch.map (p)->
              return ornamental(p,bass,chord)
      else
        # add notes
        pitches = []
        e.pitch.forEach (p)->

          if typeof p == 'string'
          # handle barline
          else if refc?
            if refc[p-1]?
              pitches.push(refc[p-1])
          else
            pitches.push(ornamental(p, ref, scale))
        #console.log 'add pitch', pitches
        if typeof e.dur == 'number'
          measure.push([e.dur, pitches])
          chorder.forward(e.dur)

        else
          measure.push([e.dur.original, pitches, true]);
          chorder.forward(e.dur.original)
    if dur_tot < tatum
      console.log 'not enough'
      measure[measure.length - 1][0] += (tatum - dur_tot)
    return measure
  # TODO: move info to tracks
  res.info = {
    time_sigs: time_sig_map,
    key_sigs: key_sig_map,
    tempi: tempo_map
  }
  return res

# info must contain time_sigs, ctrl_per_beat
MG.parseHarmony = (measures, info) ->
  if typeof measures == 'undefined'
    console.log 'empty harmony'
    return
  key_sig = info.key_sigs[0] ? 'C'
  tatum = info.ctrl_per_beat * (info.time_sigs[0][0] ? 4)
  measures.map (e, i) ->
    if info.time_sigs[i]?
      tatum = info.ctrl_per_beat * info.time_sigs[i][0]
    if info.key_sigs[i]?
      key_sig = info.key_sigs[i]
    durs = []
    ret = e.trim().split(/\s+/).map (e2) ->
      terms = e2.split(',')
      chord_info = MG.getChords(terms[0],3,key_sig)
      dur =  if terms.length>=2 then parseInt(terms[1]) else 1
      durs.push dur
      [dur,chord_info[0],chord_info[1]]
    if tatum?
      r = tatum // math.sum(durs)
      durs = []
      ret.forEach (ee,ii)->
        durs.push(ret[ii][0] = Math.floor(ee[0] * r))
      if tatum > math.sum(durs)
        ret[ret.length - 1][0] += (tatum - math.sum(durs))
    ret

###
  score object, with tracks and settings
  one track is an array of measure, with property
###
ScoreObj = class @ScoreObj
  constructor: (options, contents) ->
    options ?= {}
    {@tempo, @time_sig, @key_sig, @ctrl_per_beat, @scale, @volumes, @instrs} = options

    @tempo ?= 120
    @time_sig ?= [4,4]
    @key_sig ?='C'
    @ctrl_per_beat ?= 4
    @scale ?= 'maj'
    @volumes ?= [110,80]
    @instrs ?= [1,1] #grand_piano

    @init_ref = MG.scaleToPitch(@scale, @key_sig)(4 * MG.scale_class[@scale].length)
    @init_ctrlTicks = (60000.0/@tempo/@ctrl_per_beat) >>>0

    @tracks = []
    @harmony = []
    @harmony_text = []

    if contents?
      if contents.melody?
        @setMelody(contents.melody, false)
      if contents.harmony? && contents.texture?
        @harmony_text = contents.harmony
        @setTexture(contents.texture, contents.harmony)

  getSettings: ()->
    return{
      tempo: @tempo,
      time_sig: @time_sig,
      key_sig: @key_sig,
      ctrl_per_beat: @ctrl_per_beat,
      scale: @scale,
      volumes: @volumes
      instrs: @instrs
    }

  setTrack: (i,track)->
    if i>@tracks.length
      console.log 'track number overflow'

    @tracks[i] = track

  setMelody: (melody, parsed)->
     if parsed? && parsed==true
       @setTrack 0, melody
     else
       options = @getSettings()
       options.scale = MG.scale_class[options.scale]
       options.init_ref = @init_ref
       @setTrack 0, MG.parseMelody(melody, options)

  setTexture: (texture, harmony, parsed)->
    if parsed? && parsed == true
      @harmony = harmony
      @setTrack 1, texture
    else
      info = null
      # hard coding
      if @tracks[0].info?
        info = MG.clone(@tracks[0].info)
      info.ctrl_per_beat = @ctrl_per_beat
      @harmony = MG.parseHarmony(harmony, info)
      options = @getSettings()
      options.harmony = @harmony
      @setTrack 1, MG.parseMelody(texture, options)

  setPercussion: (percussion, parsed)->


  toText: (m)->
    console.log 'to score text'
    m ?= MG.clone(@tracks[0]) # melody
    time_sigs = m.info.time_sigs
    key_sigs = m.info.key_sigs
    if ! m?
      console.log 'null melody'
      return
    toScale = MG.pitchToScale(@scale,@key_sig)
    ref_oct = 4
    res = m.map (e, e_i)->
      # e is measure
      ret = []
      if time_sigs[e_i]?
        ret.push ':t' + time_sigs[e_i].join('/')

      if key_sigs[e_i]?
        ret.push ':k' + key_sigs[e_i]

      # simplify
      durs = e.map (e1)-> e1[0]
      gcd = MG.gcd.apply(null, durs)
      if gcd > 1
        e.forEach (e1)->
          e1[0] /= gcd
          return

      e.forEach (e1)->
        o = ''
        if typeof e1[1] != 'object'
          e1[1] = [e1[1]]
        e1[1].forEach (e2)->
          if e2<21 || e2>108
            o += '0'
          else
            tmp = toScale(e2)
            diff = tmp[1]-ref_oct
            if diff < -1 || diff > 1
              o += ':'
              while diff < -1
                o += '-'
                ref_oct--
                diff++
              while diff > 1
                o += '+'
                ref_oct++
                diff--
              o += ' '

            o += 1 + tmp[0]
            o += {'-1':'-',1:'+'}[diff] || ''
            o += {1:'#',2:'##'}[tmp[2]] || ''
        if e1[2] == true
          e1[0] = (e1[0] + '^').replace('^^','^')
        if typeof e1[0] == 'string' || e1[0] > 1
          o += ',' + e1[0] # dur
        ret.push o
      return ret.join(' ')

    return res

  harmony_roman: ->
    toRoman = MG.keyToRoman(@key_sig)
    ex = /[A-G][b#]{0,2}/
    @harmony_text = @harmony_text.map (e,i)->
      e.split(/\s+/).map (e2)->
        r = ex.exec(e2)
        if r == null
          return e2
        else
          return e2.replace(r[0],toRoman(r[0])).replace(/b#/g,'').replace(/#b/g,'')
      .join(' ')
    return @harmony_text.join('\n')

  toMidi: ->
    #console.log('to midi')
    ctrlTicks = @init_ctrlTicks
    m = new simpMidi()
    m.setTimeSignature @time_sig[0], @time_sig[1]
    m.setKeySignature MG.key_sig[@key_sig], 'maj'
    m.setTempo @tempo
    m.setDefaultTempo @tempo
    # TODO: reserve channel 0x9
    nTrack = @tracks.length
    if nTrack > 9
      nTrack = 9

    time_sigs = @tracks[0].info.time_sigs
    key_sigs = @tracks[0].info.key_sigs


    for t_i in [0...nTrack] by 1
      dur_abs = 0
      if t_i != 0
        m.addTrack()
        console.log 'add track', t_i

      console.log 'info', @tracks[t_i].info
      vol = @volumes[t_i] ? @volumes[0]
      MIDI.programChange(t_i, @instrs[t_i] - 1)
      m.addEvent t_i + 1, 0, 'programChange', t_i, @instrs[t_i]-1
      notes = []
      dur = 0
      delta = 0
      @tracks[t_i].forEach (t,j)->
        if t_i == 0
          if time_sigs[j]?

            m.addEvent 0, dur_abs * ctrlTicks, 'timeSignature', time_sigs[j][0], time_sigs[j][1]
            dur_abs = 0
          if key_sigs[j]?
            m.addEvent 0, dur_abs * ctrlTicks, 'keySignature', MG.key_sig[key_sigs[j]], 'maj'
            dur_abs = 0
        i = 0
        while i < t.length
          e = t[i]
          dur_abs += e[0]
          if notes.length == 0
            if typeof e[1] == 'number'
              if e[1] >= 21 && e[1] <= 108
                notes.push = e[1]
            else
                e[1].forEach (pitch)->
                  if pitch >= 21 && pitch <= 108
                    notes.push pitch

          if notes.length == 0
            delta += e[0] # skip invalid note
          else
            dur += t[i][0]
            if t[i][2] != true
              m.addNotes t_i + 1, dur * ctrlTicks, notes, vol, 0, delta * ctrlTicks
              notes = []
              dur = 0
              delta = 0
          ++i
      if notes.length > 0
        console.log 'remain', notes
        m.addNotes t_i + 1, dur * ctrlTicks, notes, vol, 0, delta * ctrlTicks
    m.finish()
    return m

