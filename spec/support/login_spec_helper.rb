def log_in user = nil
  unless user
    user = create :volunteer
  end

  session[:user_id] = user.id
  session[:user_type] = user.class.to_s
end

def log_in_as user_or_factory
  if user_or_factory.kind_of? Symbol
    user = create user_or_factory
  else
    user = user_or_factory
  end

  log_in user
  return user
end

def log_out
  session[:user_id] = nil
  session[:user_type] = nil
end