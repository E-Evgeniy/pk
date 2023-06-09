# frozen_string_literal: true

# Controller the API TypesOfKeysController
module Api
  module V1
    # TypesOfKeysController
    class TypesOfKeysController < BaseController
      def index
        types_of_keys = TypesOfKey.order(name: :asc)

        render(json: { types_of_keys: })
      end

      def show
        types_of_key = TypesOfKey.find(params[:id])

        render(json: { types_of_key: })
      end

      def create
        if TypesOfKey.create(type_of_key_params)
          render(json: {}, status: :created)
        else
          render json: { error: client.errors.messages }, status: 422
        end
      end

      def update
        type_of_key = TypesOfKey.find(params[:id])

        if type_of_key.update(type_of_key_params)
          render(json: {}, status: :created)
        else
          render json: { error: client.errors.messages }, status: 422
        end
      end

      def destroy
        type_of_key = TypesOfKey.find(params[:id])

        if type_of_key.destroy
          render(json: {}, status: :deleted)
        else
          render json: { error: type_of_key.errors.messages }, status: 422
        end
      end

      def find
        type_of_key = validates_type_of_key(params["inputName"], params["inputComment"])

        puts("type_of_key #{type_of_key}")

        render(json: { type_of_key: })
      end

      def find_for_edit
        puts("PARAMS #{params}")
        type_of_key_edit = TypesOfKey.find(params["id"])
        puts("type_of_key_edit.name #{type_of_key_edit.name}")

        type_of_key = validates_type_of_key(params["inputName"], params["inputComment"])
        puts("type_of_key #{type_of_key}")

        if params[:countEditName] == "0" || type_of_key_edit.name == params["inputName"]
          type_of_key["inputName"] = true
        end

        if params[:countEditComment] == "0" || type_of_key_edit.comment == params["inputComment"]
          type_of_key["inputComment"] = true
        end

        render(json: { type_of_key:, type_of_key_edit: })
      end

      private

      def validates_type_of_key(inputName, inputComment)
        type_of_key = {}
        type_of_key["inputName"] = TypesOfKey.where(name: inputName).empty?
        type_of_key["inputComment"] = TypesOfKey.where(comment: inputComment).empty?
        type_of_key
      end

      def type_of_key_params
        params.require(:type_of_key).permit(:name, :comment)
      end
    end
  end
end
