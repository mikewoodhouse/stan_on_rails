module BowlingHelper
  def overs_and_balls(overs, balls)
    overs, balls = (6 * overs + balls).divmod(6)
    "#{overs}.#{balls}"
  end
end
