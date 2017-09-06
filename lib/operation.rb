# An Operation encapsulates business logic into a separate object.
# It's essentially a service object that performs one task.
#
# Operation classes are usually namespaced with the resource classes
# they represent. Eg. Book::Search, Person::Create or User::Login
#
# Operation performs business processes such as printing PDF,
# searching users, hence they are named as verbs instead of nouns
# to denote that it's executing a command.
class Operation
  include Singleton
  include Concurrent::Async

  def self.run(*args)
    self.instance.run(*args)
  end

  # Asynchronously run the operation on the background thread
  def self.async_run(*args)
    self.instance.async.run(*args)
  end
end
