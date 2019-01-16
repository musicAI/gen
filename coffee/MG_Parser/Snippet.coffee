MG = @MG || (module? && require? && require('./musical').MG) || {}

###
  snippet
  data: array of measures
###
class @Snippet
  constructor: (pitch, dur, harmony, options)->
    if arguments.length == 0
      @data = []
      return
    while typeof dur[0] != 'number'
      dur = _.flatten(dur, true)
      pitch = _.flatten(pitch, true)

    tatum = options.tatum ? 8
    time_sig = options.time_sig ? [4,4]
    sec = tatum * time_sig[0]

    MG.condCopy(options, @, ['incomplete_start', 'tie'])

    delta = @incomplete_start ? sec

    m_i = 0
    measure = new Measure(time_sig, tatum)
    res = []
    dur.forEach (e,i)=> 

      if delta - e >= 0
        measure.pitch.push pitch[i]
        measure.dur.push e
        delta -= e
        if delta == 0
          measure.harmony = harmony[m_i]
          res.push measure
          m_i++
          measure = new Measure(time_sig, tatum)


          delta = sec
      else #tie
        while delta < e
          measure.dur.push delta
          measure.pitch.push pitch[i]
          measure.tie = true
          measure.harmony = harmony[m_i]
          res.push measure
          e -= delta
          delta = sec
          measure = new Measure(time_sig, tatum)
          m_i++
    if delta < sec
      @incomplete_end = sec - delta
      measure.harmony = harmony[m_i]
      res.push measure
    @data = res
    return
  last: ->
    if @data.length == 0
      return null
    @data[@data.length - 1]
  first: ->
    if @data.length == 0
      return null
    @data[0]
  copy: (s)->
    if arguments.length == 0
      s = new Snippet()
      s.data = @data.map (e)-> e.copy()
      MG.condCopy(@, s, ['incomplete_start', 'tie'])
      return s

    @data = s.data.map (e)-> e.copy()
    MG.condCopy(s, @, ['incomplete_start', 'tie'])



  # concat with other snippet
  join: (s, modify)->
    ret = @copy()
    s = s.copy()

    if ret.data.length > 0
      if modify? && modify.smooth?
        last_measure = ret.last()
        first_measure = s.first()
        console.log 'new smooth', last_measure, first_measure
        last_note = last_measure.last()
        first_note = first_measure.first()
        if last_measure.len() > 1
          pre_note = last_measure.note(last_measure.len() - 2)
          if (last_note[1] > pre_note[1] && last_note[1] > first_note[1]) || (last_note[1] < pre_note[1] && last_note[1] < first_note[1])
            # swap, make smooth
            last_measure.setNote(last_measure.len() - 2, last_note)
            last_note = pre_note
            pre_note = last_measure.note(last_measure.len() - 2)

        if last_note[1] - first_note[1] <= -12
          last_note[1] += 12
        else if last_note[1] - first_note[1] >= 12
          last_note[1] -= 12
        #console.log i, last_note, first_note
        last_measure.setNote(last_measure.len() - 1, last_note)
        console.log 'smooth', last_measure, first_measure

      tmp = ret.data.pop()
      measure = null
      if @incomplete_end? && s.incomplete_start?
        measure = new Measure()
        measure.harmony = MG.clone(tmp.harmony)
        measure.harmony ?= []
        measure.pitch = tmp.pitch.concat(s.data[0].pitch)
        measure.dur = tmp.dur.concat(s.data[0].dur)

        if s.data[0].harmony?
          measure.harmony = measure.harmony.concat(s.data[0].harmony)
        if s.data[0].tie? && s.data[0].tie == true
          measure.tie = s.data[0].tie
        s.data.shift()
      else
        measure = tmp.copy()
      ret.data.push measure

    ret.data = ret.data.concat(s.data)
    MG.condCopy(s, ret, ['incomplete_end'])
    console.log 'join snippet', ret.data, modify

    return ret


  cadence: (key)->
    last_measure = @last()
    last_measure.dur.sort()
    tonic = MG.key_class[key]
    last_note = last_measure.last()
    adjust = (tonic - (last_note[1] % 12)) %% 12
    if adjust > 6
      adjust -= 12
    last_note[1] += adjust
    console.log adjust, 'adjust->', last_note
    if last_measure.len() > 1
      pre_note = last_measure.note(last_measure.len() - 2)

      #console.log 'pre_note', pre_note
      if last_note[1] - pre_note[1] >= 12
        last_note[1] -= 12;
      if last_note[1] == pre_note[1]
        #console.log 'may merge last two notes', last_note
        return
    last_measure.setNote(last_measure.len() - 1, last_note)
  toScore: (key_sig)->
    key_sig ?= 'C'
    sharp = MG.key_sig[key_sig] >= 0
    @data.map (measure)->

      ret = _.zip(measure.dur, measure.pitch)
      if measure.tie? && measure.tie = true
        ret[ret.length - 1].push(true)
      measure.harmony ?= []
      durs = measure.harmony.map (e)-> e[0]
      gcd = MG.gcd.apply(null, durs)
      if gcd > 1
        measure.harmony.forEach (e)->
          e[0] /= gcd
      ret.harmony = (measure.harmony.map (e)->
        tmp = MG.pitchToKey(e[1],sharp,true) + e[2]
        if e[0] > 1
          tmp += ',' + e[0]
        tmp
      ).join(' ')
      ret
