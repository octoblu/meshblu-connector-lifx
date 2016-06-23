{EventEmitter}  = require 'events'
debug           = require('debug')('meshblu-connector-lifx:index')
LifxManager     = require './lifx-manager'

class Connector extends EventEmitter
  constructor: ->
    @lifx = new LifxManager

  changeLight: (data, callback) =>
    @lifx.changeLight data, callback

  isOnline: (callback) =>
    callback null, running: true

  close: (callback) =>
    debug 'on close'
    callback()

  onConfig: (device={}, callback=->) =>
    { @options } = device
    debug 'on config', @options
    { bulbName } = @options ? {}
    @lifx.connect { bulbName }, callback

  start: (device, callback) =>
    debug 'started'
    @onConfig device, callback

  turnOff: (callback) =>
    @lifx.turnOff callback

module.exports = Connector
