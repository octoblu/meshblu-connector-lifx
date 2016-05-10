MESSAGE_SCHEMA =
  type: 'object'
  properties:
    bulbName:
      type: 'string'
      required: true
    on:
      type: 'boolean'
      required: true
    color:
      type: 'string'
      required: true
    timing: type: 'number'
    white: type: 'number'

module.exports = {
  messageSchema: MESSAGE_SCHEMA
}
