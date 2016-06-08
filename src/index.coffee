_               = require 'lodash'
{EventEmitter}  = require 'events'
lifx            = require 'lifx'
tinycolor       = require 'tinycolor2'
debug           = require('debug')('meshblu-connector-lifx:index')

class Lifx extends EventEmitter
  constructor: ->
    @UINT16_MAX = 65535
    @MAX_KELVIN = 9000

  onMessage: (message={}) =>
    { payload } = message
    @updateLifx payload

  getBulb: (bulbName) =>
    return _.first @_lifx.bulbs unless bulbName
    return _.first @_lifx.bulbs unless '*'
    debug 'searching for bulbName', bulbName
    return _.find @_lifx.bulbs, { name: bulbName }

  updateLifx: (payload={}) =>
    payload.on ?= true
    payload.color = 'rgba(0,0,0,0.0)' unless payload.on
    hsv      = tinycolor(payload.color).toHsv()
    hue      = parseInt((hsv.h/360) * @UINT16_MAX)
    sat      = parseInt(hsv.s * @UINT16_MAX)
    bri      = parseInt(hsv.v * hsv.a * @UINT16_MAX)
    temp     = parseInt(hsv.a * @MAX_KELVIN)
    timing   = payload.timing || 0
    bulbName = payload.bulbName

    bulb = @getBulb bulbName
    return console.error('Unable to find bulb') unless bulb?
    @_lifx.lightsOn bulb
    @_lifx.lightsColour hue, sat, bri, temp, timing, bulb

  start: =>
    @_lifx = lifx.init()

module.exports = Lifx
