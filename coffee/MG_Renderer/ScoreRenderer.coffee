MG = @MG || (module? && require? && require('./musical').MG ) || {}


clearCanvas = (c)->
  c.getContext('2d').clearRect 0,0, c.width,c.height
  return

class @ScoreRenderer
  constructor: (c, p)->
    @real_canvas = document.getElementById c
    @real_canvas.width = 1000
    @real_canvas.height = 800
    @real_ctx = @real_canvas.getContext('2d')
    @hidden_canvas = document.createElement('canvas')
    @hidden_canvas.width = 1000
    @hidden_canvas.height = 800
    @vfr = new Vex.Flow.Renderer @hidden_canvas, Vex.Flow.Renderer.Backends.CANVAS
    @vfr.resize(1000,800)
    @vf_ctx = @vfr.getContext()
    @geo =
      page_width: 1000, page_height: 800,
      system_width: 900, system_height: 80, system_interval: 50,
      left_padding: 30, top_padding: 70, reserved_width: 55
    @layout =
      measure_per_system: 4,
      system_per_page: 5
    @numPage = 1
    @currentPage = 1
    @measures = []
    @pages = []
    pager = $('#midi_pager')
    @UI =
      prev: pager.find('.prev'),
      next: pager.find('.next'),
      page_num: pager.find('.page_num'),
      page_count: pager.find('.page_count')

    @UI.prev.on 'click', ()=>
      if @currentPage <= 1
        return
      @currentPage--
      @renderPage(@currentPage-1)


    @UI.next.on 'click', ()=>
      if @currentPage >= @numPage
        return
      @currentPage++
      @renderPage(@currentPage-1)


    # if p?
    #   @p = new fabric.StaticCanvas(p, {
    #     width: $('.canvas-wrapper').width(),
    #     height: $('.canvas-wrapper').width() * 2,
    #     backgroundColor: 'rgba(240,250,240, 5)'
    #   })

  # m-th measure
  newStave: (m, clef)->
    clef ?= 'treble'
    i = m % @layout.measure_per_system;
    j = (m // @layout.measure_per_system) % @layout.system_per_page
    w = @geo.system_width // @layout.measure_per_system
    x = @geo.left_padding + i * w
    y = @geo.top_padding + j * (@geo.system_height + @geo.system_interval)
    console.log(x,y,w)
    if i == 0
      return new Vex.Flow.Stave(x, y, w).addClef(clef)
    else
      return new Vex.Flow.Stave(x, y, w)

  toBit = (i, base)->
    base ?= 2
    res = [];
    j = 1
    while i>0
      #console.log i,j
      if (j & i) > 0
        res.unshift(j)
        i -= j
      j <<= 1
    # console.log res
    return res

  toBit: toBit
  dur_obj = (sum, dur)->
    if sum == 0
      return{
        sum: dur,
        dur: toBit(dur)
      }

    r = toBit(sum + dur)

    p = 0
    r1 = r.map (e)-> p+= e
    i = 0
    while sum > r1[i]
      i++
    ret = r.slice(i+1)
    remain = r1[i] - sum # >0
    if remain == 0
      return {
        sum: sum + dur,
        dur: ret
      }

    #pre = sum - (r1[i-1] || 0)
    # pre + remain == r[i]
    rs = toBit(sum)
    rs = rs.slice(i)
    ret2 = []
    while remain > 0
      ret2.push(rs[rs.length-1])
      remain -= ret2[ret2.length - 1]
      rs[rs.length-1] *= 2
      while rs.length > 1 && rs[rs.length - 1] == rs[rs.length - 2]
        rs.pop()
        rs[rs.length - 1] *= 2
    ret = ret2.concat(ret)
    #console.log 'final remain', remain
    return {
      sum: dur + sum,
      dur: ret
    }

  renderPage: (num)->

    if num < 0 || num >= @numPage
      return
    if @pages[num]?
      clearCanvas(@real_canvas)
      @real_ctx.drawImage @pages[num], 0, 0
      @UI.page_num.html(num+1)
      return
    console.log 'render page', num+1
    
    start = @layout.measure_per_system * @layout.system_per_page
    last = (num+1) * start
    start = last - start
    if last >= @measures.length
      last = @measures.length
    ctx = @vf_ctx
    clearCanvas(@hidden_canvas)
  
    for i in [start...last] by 1
      e = @measures[i]
      #Format and justify the notes
      formatter = new Vex.Flow.Formatter().
        joinVoices(e.voices).
        format(e.voices, e.w)
      e.stave.setContext(ctx).draw()
      e.voices.forEach (v) -> v.draw(ctx, e.stave)
      e.beams.forEach (v)-> v.setContext(ctx).draw()
      e.ties.forEach (v)-> v.setContext(ctx).draw()
    @pages[num] = c = document.createElement('canvas')
    c.width = @geo.page_width
    c.height = @geo.page_height
    c.getContext('2d').drawImage @hidden_canvas, 0, 0
    @renderPage(num)
    return



  render: (s)->

    @s = s
    @layout.measure_per_system = if s.ctrl_per_beat > 16 then 2 else 3


    @measures = []
    melody = s.tracks[0]
    time_sig = melody.info.time_sigs[0] ? s.time_sig
    key_sig = melody.info.key_sigs[0] ? s.key_sig
    sharp = MG.key_sig[key_sig] >= 0
    toScale = MG.pitchToScale(s.scale, key_sig)

    @geo.reserved_width = 30 + 5 * Math.abs(MG.key_sig[key_sig])


    #console.log 'info', melody.info
    #console.log melody
    for  i in [0...melody.length] by 1
      #console.log 'render measure', i


      stave = this.newStave(i)
      add_key_sig = false
      w = @geo.system_width // @layout.measure_per_system
      if melody.info.key_sigs[i]?
        key_sig = melody.info.key_sigs[i]
        sharp = MG.key_sig[key_sig] >= 0
        toScale = MG.pitchToScale(s.scale, key_sig)
        console.log 'key_sig change', key_sig
        add_key_sig = true

      if add_key_sig || i % @layout.measure_per_system == 0
        @geo.reserved_width = 28 + 6 * Math.abs(MG.key_sig[key_sig])
        stave.addKeySignature(key_sig)
        w -= @geo.reserved_width



      if melody.info.time_sigs[i]?
        time_sig = melody.info.time_sigs[i]
        stave.addTimeSignature(time_sig.join('/'))
        w -= 20



      notes = []
      ties = []
      later_tie = []
      sum = 0
      #console.log i
      melody[i].forEach (e)->
        {sum, dur} = dur_obj(sum, 16 * e[0] / s.ctrl_per_beat)
        durs = []
        pd = 0
        dur.forEach (d)->
          if d == pd
            durs[durs.length - 1] += 'd'
          else
            durs.push(''+(16 * time_sig[1] / d))
          pd = d/2

        keys = []
        if typeof e[1] == 'number'
          e[1] = [e[1]]

        e[1].forEach (e1)->
          if e1<21 || e1>108
            return
          tmp = toScale(e1)

          key = MG.scale_keys[key_sig][tmp[0]]
          # adjust
          key += '/' + ( (e1//12) - 1 + ({'Cb':1, 'B#':-1}[key] || 0))
          if tmp[2] != 0
            key = MG.pitchToKey(e1, sharp).join('/')
          if key?
            keys.push key

        rest = false
        if keys.length <= 0
          rest = true
          keys.push 'Bb/4' # rest
          durs = durs.map (d)-> d+'r'


        durs.forEach (d)->
          res = new Vex.Flow.StaveNote {keys:keys, duration: d, auto_stem: true}
          r = /d+/.exec(d)
          if r?
            for iii in [0...r[0].length] by 1
              res.addDotToAll()
          notes.push(res)
        if !rest && durs.length > 1
          #console.log 'tie'
          start = notes.length - durs.length
          indices = Array(keys.length).fill(0).map (ee,index)->
            return index
          for ii in [1...durs.length] by 1

            tie = new Vex.Flow.StaveTie({
              first_note: notes[start + ii - 1]
              last_note: notes[start + ii]
              first_indices: indices
              last_indices: indices
            })
            ties.push(tie)
        if e[2] == true
          later_tie.push notes.length - 1



      later_tie.forEach (ii)->
        indices = Array(notes[ii].keys.length).fill(0).map (ee,index)->
          return index
        tie = new Vex.Flow.StaveTie({
          first_note: notes[ii]
          last_note: notes[ii + 1]
          first_indices: indices
          last_indices: indices
        })
        ties.push(tie)
        return


      num_beats = sum // 16
      # console.log 'time_sig', time_sig, sum, notes

      voice = new Vex.Flow.Voice {
        num_beats: num_beats,
        beat_value: time_sig[1],
        resolution: Vex.Flow.RESOLUTION
      }
      #voice.setStrict(true)

      # Add notes to voice
      try
        voice.addTickables(notes)
      catch err
        console.log err.message
        continue

      # Add accidental
      Vex.Flow.Accidental.applyAccidentals([voice], key_sig)
      # Add beams
      beams = Vex.Flow.Beam.applyAndGetBeams(voice)

      if i % @layout.measure_per_system == 0
        w -= 20 # minus space for clef

      @measures.push {w: w - 10, voices:[voice],stave:stave, beams:beams, ties:ties}

    @numPage = Math.ceil(@measures.length / @layout.measure_per_system / @layout.system_per_page)
    @UI.page_count.html(@numPage)
    @currentPage = 1
    @pages.forEach (c,i)=>
      delete @pages[i]
    @pages = []
    @renderPage(@currentPage-1);
