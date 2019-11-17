require 'dry/schema'

Dry::Schema.load_extensions(:monads)
Dry::Validation.load_extensions(:monads)
Dry::Validation.load_extensions(:predicates_as_macros)
