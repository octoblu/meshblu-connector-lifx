http = require 'http'

class ChangeLight
  constructor: ({@connector}) ->
    throw new Error 'ChangeLight requires connector' unless @connector?

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.on is required') unless data?.on?

    {
      color
      transitionTime
    } = data

    @connector.changeLight { color, transitionTime, on: data.on }, callback

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = ChangeLight
