_               = require 'lodash'
async           = require 'async'
Lifx            = require('node-lifx').Client
tinycolor       = require 'tinycolor2'
debug           = require('debug')('meshblu-connector-lifx:lifx-manager')

UINT16_MAX = 65535
MAX_KELVIN = 9000

class LifxManager
  constructor: ->
    # hooks for testing
    @Lifx = Lifx
    @lifx = new @Lifx

  connect: ({@autoDiscover, @bulbNames}, callback) =>
    @lifx.destroy()
    @lifx.init()

    callback()

  _getBulbs: =>
    return @lifx.lights() if @autoDiscover
    _.compact _.map @bulbNames, (bulbName) =>
      @lifx.light bulbName

  changeLights: ({color, transitionTime}, callback) =>
    bulbs = @_getBulbs()
    return callback new Error 'Bulbs not found' if _.isEmpty bulbs

    async.each bulbs, (bulb, next) =>
      @_changeLight {color, transitionTime, bulb}, next
    , callback

  _changeLight: ({color, transitionTime, bulb}, callback) =>
    hsv  = tinycolor(color).toHsv()
    hue = parseInt(hsv.h)
    sat = parseInt(hsv.s * 100)
    bri = parseInt((hsv.v * hsv.a) * 100)
    temp = parseInt(hsv.a * MAX_KELVIN)

    bulb.on()
    bulb.color hue, sat, bri, temp, transitionTime * 1000

    callback()

  turnOff: (callback) =>
    bulbs = @_getBulbs()
    return callback new Error 'Bulbs not found' if _.isEmpty bulbs

    _.each bulbs, (bulb) =>
      bulb.off()

    callback()

module.exports = LifxManager
