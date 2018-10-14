# frozen_string_literal: true

require "logger"
require "thread"
require "forwardable"

require_relative 'finite_machine/logger'
require_relative 'finite_machine/definition'
require_relative 'finite_machine/state_machine'
require_relative 'finite_machine/threadable'
require_relative 'finite_machine/version'

module FiniteMachine
  # Default state name
  DEFAULT_STATE = :none

  # Initial default event name
  DEFAULT_EVENT_NAME = :init

  # Describe any state transition
  ANY_STATE = :any

  # Describe any event name
  ANY_EVENT = :any_event

  # Returned when transition has successfully performed
  SUCCEEDED = 1

  # Returned when transition is cancelled in callback
  CANCELLED = 2

  # When transition between states is invalid
  TransitionError = Class.new(::StandardError)

  # Raised when transitining to invalid state
  InvalidStateError = Class.new(::ArgumentError)

  InvalidEventError = Class.new(::NoMethodError)

  # Raised when a callback is defined with invalid name
  InvalidCallbackNameError = Class.new(::StandardError)

  # Raised when event has no transitions
  NotEnoughTransitionsError = Class.new(::ArgumentError)

  # Raised when initial event specified without state name
  MissingInitialStateError = Class.new(::StandardError)

  # Raised when event queue is already dead
  MessageQueueDeadError = Class.new(::StandardError)

  # Raised when argument is already defined
  AlreadyDefinedError = Class.new(::ArgumentError)

  class << self
    attr_accessor :logger

    # TODO: this should instantiate system not the state machine
    # and then delegate calls to StateMachine instance etc...
    #
    # @example
    #   FiniteMachine.define do
    #     ...
    #   end
    #
    # @return [FiniteMachine::StateMachine]
    #
    # @api public
    def define(*args, &block)
      StateMachine.new(*args, &block)
    end
    alias_method :new, :define
  end
end # FiniteMachine

FiniteMachine.logger = Logger.new(STDERR)
