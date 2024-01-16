module HomeHelper
  def format_risk(risk)
    case risk
    when 0, 1
      'High Risk'
    when 2, 3
      'Medium Risk'
    when 4, 5
      'High Risk'
    else
      'N/A'
    end
  end

  def format_duration(duration)
    case
    when duration < 6
      '< 6 months'
    when duration >= 6 && duration <= 12
      '6-12 months'
    else
      '> 12 months'
    end
  end

  def calculate_percentage_by_status(status)
    case status.to_sym
    when :case_started
      10
    when :investigation_finished
      20
    when :pleadings
      30
    when :discovery
      40
    when :pre_trial
      50
    when :trial
      60
    when :settlement
      70
    when :appeal
      80
    when :result_declared
      90
    when :other_status
      100
    else
      0
    end
  end
end