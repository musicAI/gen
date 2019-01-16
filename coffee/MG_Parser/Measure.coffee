MG = @MG || (module? && require? && require('./musical').MG) || {}


###
  measure with data(pitch, dur) and properties
###
class @Measure
  constructor: (@time_sig, @tatum)->
    @pitch = []
    @dur = []
    @time_sig ?= [4,4]
    @tatum ?= 8

  copy: (measure)->
    # copy this measure
    if(arguments.length == 0)
      measure = new Measure(MG.clone(@time_sig), @tatum)
      measure.pitch = MG.clone(@pitch)
      measure.dur = MG.clone(@dur)
      MG.condCopy(@, measure, ['tie', 'incomplete_start', 'harmony'])
      return measure
    # copy from other measure
    @time_sig = MG.clone(measure.time_sig)
    @tatum = measure.tatum
    @pitch = MG.clone(measure.pitch)
    @dur = MG.clone(measure.dur)
    MG.condCopy(measure, @, ['tie','incomplete_start', 'harmony'])

  add: (pitch, dur)->
    @pitch.push pitch
    @dur.push dur
    return

  # get note
  note: (i)->
    [@dur[i], @pitch[i]]
  last: ->
    @note(@len() - 1)
  first: ->
    @note(0)

  setNote: (i, note)->
    @dur[i] = note[0]
    @pitch[i] = note[1]

  len: ->
    @dur.length

  incomplete: ->
    return math.sum(@dur) < @tatum * @time_sig[0]
  overflow: ->
    return math.sum(@dur) > @tatum * @time_sig[0]
  # get pitch at pos, not tested yet
  pos: (beat, tatum)->
    if @dur.length == 0
      return null
    tatum ?= 0
    offset = beat * @tatum + tatum
    d_i = 0
    while d_i < @dur.length && offset > 0
      offset -= @dur[d_i]
      d_i++
    if offset < 0
      d_i--

    if d_i >= @dur.length
      d_i = @dur.length - 1
    return @pitch[d_i]