{
	function pluck(n) {
      return function(x) { return x[n]; };
    }

    function catpluck(head, tail, n) {
      return [head].concat(tail.map(pluck(n)));
    }
}

Document = head:TypeDefinition tail:(nl TypeDefinition) * {
  return catpluck(head, tail, 1);
}

TypeDefinition = TypeAssertion / TypeAlias

TypeAssertion = ident:Identifier _ '::' _ type:Type { return {
  node: 'TypeAssertion',
  identifier: ident,
  type: type,
}; }

TypeAlias = 'type' _ ident:Identifier _ '=' _ t:Type { return {
  node: 'TypeAlias',
  identifier: ident,
  type: t,
}; }

Tuple 'tuple' = '(' _ head:PlainType _ tail:(',' _ PlainType _) * _ ')' {
  return catpluck(head, tail, 2);
}

Type = Function / PlainType

PlainType = CompoundType / NamedType / RecordType

NamedType = $ Identifier { return {node: 'NamedType', identifier: text()}; }

CompoundType 'compound type' = head:NamedType tail:(_ NamedType)+ { return {
  node: 'CompoundType',
  identifiers: catpluck(head, tail, 1),
}; }

RecordType 'record type literal' = '{' _ head:PropertyTypeDef tail:(',' _ PropertyTypeDef _) * _'}' { return {
  node: 'RecordType',
  attributes: catpluck(head, tail, 2).reduce(function(attrs, attr){
    attrs[attr.identifier] = attr; return attrs;
  }, {}),
}; }

PropertyTypeDef = ident:Identifier _ '::' _ t:Type { return {
  node: 'PropertyTypeDef',
  identifier: ident,
  type: t,
}; }

OneArg 'single argument' = a:PlainType { return [a]; }

Function = args:(Tuple / OneArg) _ '->' _ result:Type { return {
  node: 'Function',
  args: args,
  result: result,
}; }

Identifier 'identifier' = $ ([A-Za-z_] [A-Za-z0-9$_.]*)

_ "whitespace"
  = [ \t\n\r]*

nl 'newline' = _ [\n\r]+ _
