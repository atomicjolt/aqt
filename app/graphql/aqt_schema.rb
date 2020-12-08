class AqtSchema < GraphQL::Schema
  use GraphQL::Batch

  mutation(Types::AqtMutationType)
  query(Types::AqtQueryType)
end
