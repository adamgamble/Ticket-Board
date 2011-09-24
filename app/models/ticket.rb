class Ticket < ActiveRecord::Base
  belongs_to :project


  scope :for_project, lambda {|project| where(["project_id = ?",project.id])}
  scope :for_state, lambda {|state| where(["state = ?",state])}
  state_machine :state, :initial => :fridge do
    state :fridge do
      def advance_state!
        move_to_development!
      end

      def reverse_state!
      end
    end

    state :development do
      def advance_state!
        move_to_peer_review!
      end

      def reverse_state!
        move_back_to_fridge!
      end
    end

    state :peer_review do
      def advance_state!
        move_to_user_acceptance!
      end

      def reverse_state!
        move_back_to_development!
      end
    end

    state :user_acceptance do
      def advance_state!
        move_to_archive!
      end

      def reverse_state!
        move_back_to_development!
      end
    end

    state :archive do
      def advance_state!
      end

      def reverse_state!
      end
    end

    event :move_to_development do
      transition :fridge => :development
    end

    event :move_back_to_fridge do
      transition :development => :fridge
    end

    event :move_to_peer_review do
      transition :development => :peer_review
    end

    event :move_back_to_development do
      transition [:peer_review, :user_acceptance] => :development
    end

    event :move_to_user_acceptance do
      transition :peer_review => :user_acceptance
    end

    event :move_to_archive do
      transition :user_acceptance => :archive
    end
  end
end
