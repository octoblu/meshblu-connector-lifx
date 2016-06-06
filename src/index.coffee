{EventEmitter}  = require 'events'
debug           = require('debug')('meshblu-connector-lifx:index')
lifx            = require 'lifx'
tinycolor       = require 'tinycolor2'
_               = require 'lodash'

class Lifx extends EventEmitter
  constructor: ->
    debug 'Lifx constructed'
    @UINT16_MAX = 65535
    @MAX_KELVIN = 9000
    @_lifx = undefined

  onMessage: (message) =>
    return unless message?
    { topic, devices, fromUuid } = message
    return if '*' in devices
    return if fromUuid == @uuid
    debug 'onMessage', { topic }
    {payload} = message
    @updateLifx(payload)

  onConfig: (config) =>
    return unless config?
    debug 'on config', @uuid

  updateLifx: (payload) =>
    bulb = undefined
    if payload.on == false
      payload.color = 'rgba(0,0,0,0.0)'

    hsv      = tinycolor(payload.color).toHsv()
    hue      = parseInt((hsv.h/360) * @UINT16_MAX)
    sat      = parseInt(hsv.s * @UINT16_MAX)
    bri      = parseInt(hsv.v * hsv.a * @UINT16_MAX)
    temp     = parseInt(hsv.a * @MAX_KELVIN)
    timing   = payload.timing || 0
    bulbName = payload.bulbName

    if bulbName != '*'
      debug 'searching for bulbName', bulbName
      bulb = _.find(@_lifx.bulbs, {name: bulbName})
      debug 'found bulb', bulb

    debug 'lightsOn', bulb
    @_lifx.lightsOn bulb
    debug 'lightsColour', hue, sat, bri, temp, timing, bulb
    @_lifx.lightsColour hue, sat, bri, temp, timing, bulb

  start: (device) =>
    { @uuid } = device
    debug 'started', @uuid
    @_lifx = lifx.init()

module.exports = Lifx
