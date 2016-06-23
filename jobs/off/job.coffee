http = require 'http'

class Off
  constructor: ({@connector}) ->
    throw new Error 'Off requires connector' unless @connector?

  do: ({data}, callback) =>
    @connector.turnOff callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = Off
