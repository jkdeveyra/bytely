# Generate unique hourly click stat for a given date range
# Uniqueness is identified by the session id associated with the click record.
#
# params: { id, after (pagination), from, to}
class Link::Stat < Operation
  def run(params)
    after = params[:after].present? ? Integer(params[:after]) : 0

    match_pipe = { '$match': { link_code: params[:id] }}
    date_filter = created_at_filter(params)
    match_pipe[:$match][:created_at] = date_filter if date_filter

    Click.collection.aggregate([
      match_pipe,
      { '$group': {
        _id: {
          year: { '$year': '$created_at' },
          month: { '$month': '$created_at' },
          day: { '$dayOfMonth': '$created_at' },
          hour: { '$hour': '$created_at' }
        },
        sessions: { '$addToSet': '$session_id' },
      }},
      { '$project': { _id: 0, date: '$_id', count: { '$size': '$sessions' } }},
      { '$limit': 30 },
      { '$skip': after }
    ])
  end

  private
  def created_at_filter(params)
    from = parse_datetime(params[:from])
    to = parse_datetime(params[:to])
    filter = {}
    filter[:$gte] = from if from
    filter[:$lte] = to.end_of_day if to
    filter.presence
  end

  def parse_datetime(value, default = nil)
    Time.zone.parse(value.to_s)
  rescue ArgumentError
    default
  end
end
