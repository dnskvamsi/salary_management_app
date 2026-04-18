## 🚀 Prerequisites

Before you begin, ensure you have the following installed and configured on your local machine:

* **RVM** (Ruby Version Manager)
* **Ruby 3.4.0** (Set via `rvm use 3.4`)
* **Rails 8.0+**
* **Node.js** & **npm**
* **Yarn** (Recommended for JS dependency management)
* **SQLite**

## 🛠 Installation & Setup

Follow these steps to initialize your development environment:

1. **Clone the repository**
2. **Install dependencies**
    ```ruby
    bundle install
    yarn install
    ```
3. **Setup Database**
    ```ruby
    bin/rails db:prepare
    ```
### Running the project
```ruby
bin/dev
```

### Running the tests
```
bundle exec rspec
```
