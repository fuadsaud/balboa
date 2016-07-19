# Balboa

[![Gem Version](https://badge.fury.io/rb/balboa.svg)](https://badge.fury.io/rb/balboa)

## Installation

    $ gem install balboa

## Usage

A good way to start is:

    $ balboa -h

Let's suppose you just want to punch (it will punch from the day after the last punch until it can not punch anymore):

    $ balboa punch
    
Let's suppose you want to skip 11/11/2011, 12/12/2012 and 13/12/2012 (it will skip weekends and ask for punch on holidays):

    $ balboa punch -s '11/11/2011,12/12/2012,13/12/2012'
    
Let's suppose you will work for sometime in another project:

    $ balboa punch -w 'Another Project'
    
Let's suppose you did not input your password (or changed it after setting balboa up) on the first run. You can either:

    $ balboa reset # Or
    $ balboa punch -p 'New Password'
    
Let's suppose you don't have phantomjs on your machine. Balboa doesn't care, it will install it for you. Just punch normally.

    $ balboa punch

Let's suppose you don't understand what those `|number|` means. It is the calculated default schedule. Just press enter and Balboa will fill it up for you.

```
First shift: |8| 

Lunch: |12| 

Second shift: |13| 

Leave: |18| 
```

Let's suppose your schedule is different from the default. Balboa will help you out.

```
First shift: |8| 10

Lunch: |14| 15

Second shift: |16|

Leave: |19|
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/balboa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
