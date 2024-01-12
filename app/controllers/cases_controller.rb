# frozen_string_literal: true

class CasesController < ApplicationController
  def create
    @case = Case.new(case_params)

    authorize @case
    respond_to do |format|
      if @case.save
        format.json { render json: { success: true, message: 'Case was successfully created.', case: @case } }
      else
        format.json { render json: { success: false, message: @case.errors.full_messages.join(', ') }, status: :unprocessable_entity }
      end
    end
  end

  private

  def case_params
    params.require(:case).permit(
      :case_type, :case_relation, :short_description, :case_description,
      :supporting_file, :claim_sum, :total_funds, :case_duration,
      :know_defendant, :know_jurisdiction, :previous_judgement,
      :legal_strategy, :signed_contract, :risk_level,
      :plaintiff_payout, :investor_payout, :lix_payout, :case_status,
      :author_id, category_ids: []
    )
  end
end
