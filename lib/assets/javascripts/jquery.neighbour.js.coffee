$.fn.neighbour = (context, offset) ->
  self = this[0]
  result = null
  nodes = $(context)
  nodes.each (i, node) ->
    result = nodes[i+offset] if node is self
  result = null if typeof result is "undefined"
  result
