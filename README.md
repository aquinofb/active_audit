# Active Audit
A simple way to add active audit to your Rails app

## Getting started

ActiveAudit works with Rails 4 onwards. You can add it to your Gemfile with:

```ruby
gem 'active_audit'
```

Run the bundle command to install it.

After you add it to your Gemfile, you need to create a custom module that extend `ActiveAudit::Rules::Base`, like following:

```ruby
module MyCustomActiveAudit
  extend ActiveAudit::Roles::Base
end
```

Once the custom module is created, you can configure it:

```ruby
module MyCustomActiveAudit
  extend ActiveAudit::Roles::Base

  # the attributes that you use in your rules
  attributes :name, :price, :wheight # ...

  # the required attributes
  required_attributes :name, :price # ...

  # here you configure your hook
  add_hook :before_save, :your_method_to_treat_this, if: :hook_method_condition

  # add a specific rule to the resource
  when_the :attribute_name, change_from: nil, to: "a new value", do: :doit_method, if: :a_block_or_method

  def your_method_to_treat_this
    # Ex: Notify someone
  end

  def hook_method_condition
    true
  end

  # ...
end
```

Its done! Now you just need to configure the `model` that you need to be audited:

```ruby
class Product < ActiveRecord::Base
  active_audit_by :my_custom_active_audit
end
```

## Configuration methods

### attributes
`#Todo`

### required_attributes
`#Todo`

### add_hook
`#Todo`

### when_the
`#Todo`

## Store your client rules
ActiveAudit create a table called `active_audit_rules` that you can put a json with specific rules from your client to use in the...

## TODO


## License

MIT License (MIT)

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
