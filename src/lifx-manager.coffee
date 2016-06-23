_               = require 'lodash'
Lifx            = require 'lifx'
tinycolor       = require 'tinycolor2'
debug           = require('debug')('meshblu-connector-lifx:lifx-manager')

UINT16_MAX = 65535
MAX_KELVIN = 9000

class LifxManager
  constructor: ->
    # hook for testing
    @Lifx = Lifx

  connect: ({@bulbName}, callback) =>
    @lifx = @Lifx.init()
    callback()

  _getBulb: =>
    _.find @lifx.bulbs, { name: @bulbName }

  changeLight: ({color, transitionTime}, callback) =>
    bulb = @_getBulb()
    return callback new Error 'Bulb not found' unless bulb?

    hsv  = tinycolor(color).toHsv()
    hue  = parseInt((hsv.h/360) * UINT16_MAX)
    sat  = parseInt(hsv.s * UINT16_MAX)
    bri  = parseInt(hsv.v * hsv.a * UINT16_MAX)
    temp = parseInt(hsv.a * MAX_KELVIN)

    @lifx.lightsOn bulb
    @lifx.lightsColour hue, sat, bri, temp, transitionTime, bulb

    callback()

  turnOff: (callback) =>
    bulb = @_getBulb()
    return callback new Error 'Bulb not found' unless bulb?

    @lifx.lightsOff bulb
    callback()

module.exports = LifxManager
