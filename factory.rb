class Factory

  def self.new( *arguments, &block )

    Class.new do

      @@arguments = arguments
      arguments.each { |arg| attr_accessor arg }

      define_method :initialize do |*arg_val|
        arg_val.each_with_index { |value, index| instance_variable_set("@#{arguments[index]}", value) }
  	  end

  	  def [](index)

  	  	if index.class == String
  	  		self.instance_variable_get("@#{index}")
  	  	elsif index.integer? 
  	  		self.instance_variable_get("@#{@@arguments[index]}")
  	  	end
  	  	
  	  end

  	  yield(block) if block_given?

   end

  end


end
	
Customer = Struct.new(:name, :address, :zip) do
  def greeting
    "Hello #{name}!"
  end
end
 
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
 
puts joe.name
puts joe["address"]
puts joe[:name]
puts joe[2]

puts joe.greeting 

=begin  sript's result
	
Joe Smith
123 Maple, Anytown NC
Joe Smith
12345
Hello Joe Smith!
	
=end
