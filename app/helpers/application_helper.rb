module ApplicationHelper
  def player_name(p)
    return p.surname +
             (p.firstname ?
               ", " + p.firstname :
               +(p.initial ? ", " + p.initial : ""))
  end

  def highest_score(score, notout)
    score.to_s + (notout ? "*" : "")
  end
end
