# System Testing with Playwright

You are going to write tests that open a real browser, click real buttons, and check what actually
appears on screen.

By the end you will have this:

```
StaycationX/tests/playwright/
    test_staycation.py     four tests that drive a real browser
    conftest.py            a fixture that signs you in
    pages.py               a class that owns the sign-in screen
```

More importantly, you will have **watched each of those tests fail first**. That is deliberate. Most
of what makes system tests hard is invisible until something breaks, so in each part you will write
the version that breaks, run it, look at the error, and then fix it.

**Work through this with both repositories open and running.**

---

## What you are testing

Two applications that talk to each other:

| | Repository | What it is |
|---|---|---|
| **The screens** | `myReactApp` | a React application in your browser, on **port 3000** |
| **The API** | `StaycationX` | a Flask REST API, on **port 5000**, with MongoDB behind it |

The React app has no data of its own. When you sign in, JavaScript in your browser sends your
credentials to the API, gets a token back, and then asks the API for the list of packages. Everything
you see on screen arrived over the network.

That is why this kind of test is worth writing. It exercises both halves together, running for real,
the way a person does.

Your tests will live in the **`StaycationX`** repository, next to the `pytest` tests already there.

---

## Test level

| Level | What is real |
|---|---|
| Unit | one function or class; everything around it is faked |
| Integration | a few pieces working together |
| **System** | the whole thing, running, through its real interfaces |

Everything in this tutorial is at the **system** level. Real browser, real React app, real API, real
database, nothing faked.

One last thing: **the tool does not decide the level.** Playwright can also test single components,
and can send API requests with no browser involved. It is running the whole system that makes this
system testing - not the fact that you imported Playwright.

### Questions to think about

1. **Scope is the obvious difference between the three levels. What else separates them?**
   Four more dimensions are worth thinking about:

   - **How many** tests of that kind a project ends up with
   - **How much setup** each one needs before it can run at all
   - **When and where** you would run them - on save, on every commit, before a release
   - **What kind of problem** each one is positioned to reveal

   Then put two of those together: if a level is cheap to set up and quick to run, does that change
   what you would use it for?

2. **Does any of this change when an LLM writes the tests?**
   A model will happily generate tests at any of the three levels, and quickly. Four things worth
   examining:

   - **A label is not a level** - open `tests/unit/test_models.py` in `StaycationX` and follow what
     `User.createUser()` actually does. Could that test run with MongoDB stopped? If a folder name
     can be wrong about the level, how much would you trust a name a model picked for you?
   - **Where the effort goes** - writing tests used to be the slow part. If it is not any more,
     what becomes the slow part?
   - **The shape of a suite** - "many fast tests, few slow ones" was originally an argument about
     how expensive tests are to *write*. If writing them is nearly free, does that advice survive?
     For the same reason, or a different one?
   - **Where the expectations come from** - you write a test from what the code *should* do. What
     does a model write one from, if all it has been shown is what the code *does*?

   Then go and find out: ask a model to write a test for something you have written, change the
   logic that test covers, and run it again. If it still passes, what was it testing?

---

# Part 0 - Get everything running

Nothing in this tutorial works until this part does. Take your time here.

### Step 1 - Start the database and load the lab data

```bash
# from the StaycationX repository
mongorestore --db staycation db_seed/staycation
```

This loads 6 packages, 6 users, and their bookings into a MongoDB database called `staycation`.

> **Remember this command.** You will use it again with `--drop` to reset your data after your tests have changed it.

### Step 2 - Start the API

```bash
# from the StaycationX repository
./start.sh
```

You should see Flask start on port 5000.

### Step 3 - Start the screens

```bash
# from the myReactApp repository
npm install
npm start
```

Your browser should open `http://localhost:3000` automatically.

### Step 4 - Sign in by hand, once

Click **STX** in the navigation bar. Sign in with:

```
User ID:   peter@cde.com
Password:  12345
```

You should see a heading that says **Listing of All Packages**, and a list of hotel names underneath.

**Do not skip this.** If you cannot sign in by hand, no test you write will be able to either - and you will waste an hour blaming Playwright for a database that was never loaded.

### Step 5 - Install Playwright

```bash
# from the StaycationX repository
source venv/bin/activate
pip install pytest-playwright
playwright install chromium
```

### Part 0 recap

You now have three things running - a database, an API, and a set of screens - plus a browser
Playwright can control. A system test needs all of them running.

---

# Part 1 - Your first system test

**What you will do:** sign in through a real browser and prove the package list appeared. This is a
complete system test, in ten lines.

### Step 1 - Write the test

Create `tests/playwright/test_staycation.py`:

```python
from playwright.sync_api import Page, expect


def test_sign_in_lists_the_packages(page: Page):
    """
    GIVEN a seeded database
    WHEN a user signs in on the STX screen
    THEN the list of packages is shown
    """
    page.goto("/STX")
    page.get_by_label("User ID:").fill("peter@cde.com")
    page.get_by_label("Password:").fill("12345")
    page.get_by_role("button", name="Login").click()

    expect(page.get_by_role("heading", name="Listing of All Packages")).to_be_visible()
```

### Step 2 - Run it

```bash
export PYTHONPATH=.
pytest tests/playwright --base-url http://localhost:3000
```

```
1 passed in 3.41s
```

### Step 3 - Now watch it

```bash
pytest tests/playwright --headed --slowmo 500 --base-url http://localhost:3000
```

A browser window opens and works through your test half a second at a time. Watch it once. It is the
quickest way to believe that this is really happening.

### Why it works

**You never created a browser.** Look at the function signature:

```python
def test_sign_in_lists_the_packages(page: Page):
```

Asking for `page` as an argument is the whole thing. Playwright's pytest plugin sees that name, starts
a browser, opens a clean tab, and hands it to you. When the test finishes it closes everything down.

**The test has three movements.** Get ready (`goto`), do something (`fill`, `click`), then check
(`expect`). Almost every test you write will have that shape.

**The check is on what a person would see.** Not on a network response, not on a database row - on the
heading that appeared on screen. That is the whole point of testing through a browser.

**`--base-url` keeps the address out of your test.** That is why you could write `page.goto("/STX")`
instead of the full URL. Run the same test against a different machine and only the command changes.

### Part 1 recap

1. Ask for `page` and you get a browser.
2. A test is: get ready, do something, check what happened.
3. Check what is on the screen.

---

# Part 2 - Finding things on the page

**What you will do:** drive the bookings table, and watch Playwright refuse to guess which button you
meant.

### Step 1 - Write the obvious version

Add a second test to the same file:

```python
def test_delete_a_booking(page: Page):
    """
    GIVEN a signed-in user with bookings
    WHEN they delete one of them
    THEN it is removed from the table
    """
    page.goto("/STX")
    page.get_by_label("User ID:").fill("peter@cde.com")
    page.get_by_label("Password:").fill("12345")
    page.get_by_role("button", name="Login").click()

    page.get_by_role("link", name="Manage").click()
    page.get_by_role("button", name="Delete").click()
```

### Step 2 - Run it and read the error

```
Error: strict mode violation:
  get_by_role("button", name="Delete")
  resolved to 11 elements:
    1) <button class="btn btn-primary">Delete</button>
    2) <button class="btn btn-primary">Delete</button>
    3) <button class="btn btn-primary">Delete</button>
    ...
```

*(The number depends on how many bookings your seeded user has.)*

The bookings table has one row per booking, and **every row has its own Delete button**. You asked for
"the Delete button" and there are multiple of them.

Playwright stopped instead of picking one. That is intentional in Playwright's strict mode.

### Step 3 - Say which one you mean

Find the row first, then find the button inside it:

```python
    row = page.get_by_role("row").filter(has_text="Capella Singapore").nth(0)
    row.get_by_role("button", name="Delete").click()
```

Run it again. It passes.

> If your seeded user has no booking for *Capella Singapore*, look at the table on screen and use a
> hotel name that is actually there.

### Why it works - a locator is a description

This line does not search the page:

```python
row = page.get_by_role("row").filter(has_text="Capella Singapore")
```

It only writes down *how to find* the row. Nothing is looked up until you use it:

```python
row.get_by_role("button", name="Delete").click()   # now it looks
```

Playwright calls this a **locator**. It is re-evaluated every single time you use it, which is why it
still works after the page has re-rendered and thrown away the old elements. It is also why chaining
works: `row.get_by_role(...)` means "search inside whatever that row turns out to be".

### Choosing what to find things by

| How you find it | Tied to | Breaks when |
|---|---|---|
| `.nth(3)` | position | the order changes |
| `page.locator("li.list-group-item > a")` | markup | someone restructures the HTML |
| `page.locator(".btn.btn-primary")` | styling | someone restyles the page |
| `page.get_by_text("Login")` | wording | the copy changes |
| `page.get_by_role("button", name="Login")` | the control and its name | the control genuinely changes |
| `page.get_by_test_id("login")` | an attribute added for tests | only when you break it yourself |

Prefer the bottom two. `get_by_role` is usually best, because it finds things the way a person does -
"the button that says Login" - so if your test can find it, a user probably can too.

### The vocabulary, in one place

```python
# finding
page.get_by_role("button", name="Login")
page.get_by_label("User ID:")
page.get_by_placeholder("Userid")
page.get_by_text("Listing of All Packages")
page.get_by_test_id("login")

# narrowing
locator.filter(has_text="Capella Singapore")
locator.nth(0)   locator.first   locator.last

# doing
locator.click()
locator.fill("peter@cde.com")      # clears the field first, then types
locator.check()                    # checkboxes
locator.select_option("2")         # dropdowns
locator.press("Enter")

# checking
expect(locator).to_be_visible()
expect(locator).to_have_text("Capella Singapore")
expect(locator).to_have_count(6)
expect(locator).to_have_value("peter@cde.com")
expect(locator).to_be_enabled()
expect(page).to_have_url("http://localhost:3000/MNG")
expect(locator).not_to_be_visible()      # proving something is absent
```

That last one matters more than it looks. Proving a control is **not** on screen is how you show
someone is not being offered something they should not have.

### One surprise: pop-up dialogs

Try clicking a package name on the STX screen:

```python
    page.get_by_text("Capella Singapore").click()
```

In your own browser that pops up an alert box. In your test, nothing happens at all.

**Playwright dismisses pop-up dialogs automatically.** Alerts and confirmation boxes never block your
test, which is usually exactly what you want. If you need to decide for yourself:

```python
    page.on("dialog", lambda dialog: dialog.accept())
```

### Part 2 recap

1. A locator describes how to find something; it looks only when you use it.
2. If a description matches more than one thing, Playwright stops. Narrow it down, then name it.
3. Prefer finding things the way a person would - by role and name.

---

# Part 3 - Waiting for the page to catch up

Your first test passed. **Do you know why?**

You clicked Login and then immediately checked for a heading. The heading cannot possibly have been
there yet. Let us prove it.

### Step 1 - Break it on purpose

In `test_sign_in_lists_the_packages`, replace the last line:

```python
    # was:
    expect(page.get_by_role("heading", name="Listing of All Packages")).to_be_visible()

    # now:
    assert page.get_by_role("heading", name="Listing of All Packages").is_visible()
```

### Step 2 - Run it

```
E   assert False
E    +  where False = is_visible()

1 failed in 1.98s
```

It fails. Run it again - it fails again. This is not flakiness; it fails **every time**.

Nothing about the application changed. The only difference is that `is_visible()` asks once,
straight away, and gets an honest answer: *no, not yet*.

### Why - two requests, and no new page in a single-page web application

Here is what actually happens when you click Login:

```
click Login
  → POST /api/user/gettoken               request 1
  → the app stores your token
  → that change triggers a second request
  → POST /api/package/getAllPackages      request 2
  → the package list is drawn on screen

the address bar:  /STX  .....................  /STX
```

**Two round trips to the API, and the browser never loaded a new page.** React simply redrew part of the screen once the data arrived. So there is no page-load event to wait for. The only honest signal that the step is done is the thing you were waiting for actually appearing.

### Step 3 - Put it back, and add another check

```python
    expect(page.get_by_role("heading", name="Listing of All Packages")).to_be_visible()
    expect(page.get_by_role("listitem")).to_have_count(6)
```

`expect()` is the wait. It checks, and if the answer is no it waits a moment and checks again, until
it passes or about five seconds have gone by. `assert` takes a single snapshot.

> The seeded database has 6 packages. If your count is different, use the number you actually see.

### You are already getting a lot of waiting for free

Before Playwright clicks or types, it waits for the element to be:

1. **visible**
2. **stable** - not still sliding or fading
3. **receiving events** - nothing covering it
4. **enabled**
5. **editable** - for typing

It keeps re-checking those until they are all true. This is why your tests need far fewer explicit
waits than you might expect.

### The one to avoid

```python
page.wait_for_timeout(1000)     # ← don't
```

This is a plain one-second sleep with a Playwright name on it. It is the trap, because it *looks* official. But it waits on a clock, not on the page: too short and your test fails on a slow machine, too long and your suite crawls. Whatever you were about to sleep for, there is a condition you can wait for instead.

### Part 3 recap

1. Actions already wait - five checks, re-tried until they pass.
2. `expect()` re-checks until it passes. `assert` looks once.
3. Never wait on a clock. That includes `page.wait_for_timeout()`.

---

# Part 4 - What your test leaves behind

**What you will do:** run your suite twice without touching anything, and watch it disagree with
itself.

### Step 1 - Just run it again

```bash
pytest tests/playwright --base-url http://localhost:3000
```

```
2 passed
```

Now run exactly the same command one more time:

```
1 failed
```

### Step 2 - Read the failure

```
Error: strict mode violation ... resolved to 0 elements
  waiting for get_by_role("row").filter(has_text="Capella Singapore")
```

Zero rows now. **Your first run deleted that booking.** The test did precisely what you told it to,
both times - but the second run started from the world the first run left behind.

This is the thing that makes system tests different from the tests you have written before. Nothing is
faked, so nothing is undone for you. Your test drives the real application, which calls the real API,
which writes to the real database. Whatever it changes, stays changed.

To get your data back:

```bash
mongorestore --drop --db staycation db_seed/staycation
```

### Why - what is isolated and what is not

```
browser         one Chromium process
  context       a fresh profile: no cookies, no storage, no session
    page        one tab
```

Every test you write gets its **own context**, automatically. That is why your second test had to sign
in again - it genuinely was a different, freshly-opened browser profile that had never seen the site.

But look at what is *not* in that diagram: the API and the database. Playwright isolates the browser
completely and the database not at all. Everything you just saw comes from that gap.

So before you write a test that changes data, ask: **what state does this need to start from, and
will it still be true the second time?**

### Step 3 - Stop repeating yourself

Both your tests start with the same four lines of signing in. Move them into a **fixture**.

Create `tests/playwright/conftest.py`:

```python
import pytest


@pytest.fixture
def signed_in(page):
    page.goto("/STX")
    page.get_by_label("User ID:").fill("peter@cde.com")
    page.get_by_label("Password:").fill("12345")
    page.get_by_role("button", name="Login").click()

    yield page

    page.get_by_role("button", name="Logout").click()
```

Now your test asks for `signed_in` instead of `page`:

```python
def test_sign_in_lists_the_packages(signed_in):
    expect(signed_in.get_by_role("heading", name="Listing of All Packages")).to_be_visible()
    expect(signed_in.get_by_role("listitem")).to_have_count(6)
```

Everything **before** `yield` is setup. Everything **after** is cleanup, and it runs even when the test
fails. Naming `signed_in` as an argument is all the wiring there is - there is nothing to register.

`pytest` already had fixtures like this, by the way. Open `tests/conftest.py` in this repository and
you will find the same three ideas: a `yield`, a scope, and one fixture taking another as an argument.

### Step 4 - Two people at once

Sometimes one test needs two separate sessions - one person doing something, another watching the
result appear:

```python
def test_two_people(browser):
    first = browser.new_context().new_page()
    second = browser.new_context().new_page()
```

Two contexts are two completely independent sessions, in one test.

> Playwright can also save a signed-in session to a file and replay it, so tests skip the login form.
> This tutorial always signs in through the screen, because signing in is one of the things worth
> testing. In this app it would not help anyway - the token is only held in memory, so there is
> nothing on disk to save.

### Part 4 recap

1. A new context is a clean browser. The database is still shared.
2. A fixture is: setup, `yield`, cleanup.
3. Decide what your test leaves behind **before** you write it.

---

# Part 5 - Putting screen knowledge in one place

Count how many times you have now typed `get_by_label("User ID:")`.

Every one of those lines knows something about how the sign-in screen is built. If someone renames
that label, you have to find and fix all of them.

### Step 1 - Move the screen into a class

Create `tests/playwright/pages.py`:

```python
class SignInPage:
    def __init__(self, page):
        self.page = page
        self.user_id = page.get_by_label("User ID:")
        self.password = page.get_by_label("Password:")
        self.login = page.get_by_role("button", name="Login")

    def sign_in(self, email, password):
        self.page.goto("/STX")
        self.user_id.fill(email)
        self.password.fill(password)
        self.login.click()
```

This is called a **page object**. Note what it is not: there is no framework, no base class, nothing
to inherit. It is an ordinary Python class.

Building the locators in `__init__` is safe for the reason you learned in Part 2 - a locator is only a
description, so the screen does not even have to exist yet.

### Step 2 - Hand it to your tests

In `conftest.py`:

```python
from pages import SignInPage


@pytest.fixture
def sign_in(page):
    return SignInPage(page)
```

And your test becomes:

```python
def test_sign_in_lists_the_packages(page, sign_in):
    sign_in.sign_in("peter@cde.com", "12345")
    expect(page.get_by_role("heading", name="Listing of All Packages")).to_be_visible()
```

Read that test out loud. It says what it is testing. It says nothing about labels or buttons.

### Why - three layers

| Layer | Example | Knows about |
|---|---|---|
| your test | `sign_in.sign_in(...)` | what is being tested |
| the page object | `get_by_label("User ID:")` | how this screen is built |
| Playwright | `fill()`, `click()`, `expect()` | how a browser works |

If a test names a label, it is doing the middle layer's job. That is the whole rule.

### Step 3 - Move the awkward bits too

That row-finding recipe from Part 2 is knowledge about a screen. Give it a name:

```python
class BookingsPage:
    def __init__(self, page):
        self.page = page

    def row(self, hotel):
        return self.page.get_by_role("row").filter(has_text=hotel)

    def delete(self, hotel):
        self.row(hotel).get_by_role("button", name="Delete").click()
```

Now a test just says `bookings.delete("Capella Singapore")`.

### Something to decide for yourself

Should a page object contain `expect(...)` checks, or only offer actions and leave the checking to the
test?

Both are defensible. Checks kept next to the screen knowledge stay correct when the screen changes.
But a test whose assertions are hidden in another file no longer tells you what it proves. Pick one
and be consistent.

### Part 5 recap

1. One screen, one owner.
2. Locators are attributes; actions are methods.
3. A test should read like the behaviour, not like the HTML.

---

# Part 6 - Running the whole suite

### The flags worth knowing

```bash
pytest tests/playwright                                  # headless, Chromium
pytest tests/playwright --headed --slowmo 500            # watch it happen
pytest tests/playwright --browser firefox                # try another browser
pytest tests/playwright --base-url http://localhost:3000
```

### Make it faster, and watch it break

System tests are the slowest tests you will write - they are running an entire application. The
obvious fix is to run them at the same time:

```bash
pip install pytest-xdist
pytest tests/playwright -n auto
```

```
2 failed, 1 passed
```

The workers started fine. Then they raced each other for the same bookings in the same database.

Remember the diagram from Part 4: **the browser context is isolated, the database is not.** Whether
your suite can run in parallel is a question about what your tests *write*, not about how fast your
machine is. Tests that only read can run in parallel all day.

### Reading a failure you did not watch

The worst failures are the ones that happen when nobody is looking. Turn on tracing:

```bash
pytest tests/playwright --tracing retain-on-failure
playwright show-trace test-results/.../trace.zip
```

A trace is a recording of the run itself - every action, the state of the page at each step, and the
network traffic. You can step through it afterwards. It turns *"it failed on someone else's machine"*
into something you can actually read.

Also useful:

```bash
pytest tests/playwright --screenshot only-on-failure --video retain-on-failure

playwright codegen http://localhost:3000    # records your clicks as code
```

```python
page.pause()      # put this in a test to open Playwright's inspector
```

`codegen` is a good way to get a first draft, but read what it writes. It tends to pick locators from
the markup - the middle of the table in Part 2, not the bottom.

### Part 6 recap

1. The browser context is isolated; the database is not.
2. Turn tracing on before you need it.
3. `codegen` writes a first draft. You still choose the locators.

---

# Appendix A - Quick reference

```bash
# setup
mongorestore --db staycation db_seed/staycation
mongorestore --drop --db staycation db_seed/staycation   # reset your data
./start.sh                                  # API   → :5000   (StaycationX)
npm start                                   # screens → :3000 (myReactApp)
pip install pytest-playwright
playwright install chromium

# running
export PYTHONPATH=.
pytest tests/playwright --base-url http://localhost:3000
pytest tests/playwright --headed --slowmo 500
pytest tests/playwright --tracing retain-on-failure
playwright show-trace test-results/.../trace.zip
```

```
Sign in with:  peter@cde.com  /  12345
Screens:       /STX  packages     /MNG  bookings
```

---

# Appendix B - When something goes wrong

| What you see | What it means |
|---|---|
| `Executable doesn't exist at .../ms-playwright/chromium-.../chrome` | You ran `pip install` but not `playwright install`. |
| `net::ERR_CONNECTION_REFUSED at http://localhost:3000` | The React app is not running. `npm start` in `myReactApp`. |
| The sign-in form never goes away | The screens are up but the API is not - or the database was never loaded. Check Part 0, steps 1 and 2. |
| `ModuleNotFoundError: No module named 'app'` | You forgot `export PYTHONPATH=.` |
| `strict mode violation ... resolved to N elements` | Your description matches several things. Narrow it down first (Part 2). |
| `strict mode violation ... resolved to 0 elements` | The thing is not there. Often your own earlier test changed the data - reseed and try again (Part 4). |
| A test passes alone but fails in the suite | Something else in the suite changed the data it needed. |

Notice how many of those are about your environment rather than your code. That is normal for system
tests: you are running a whole application, so there is a whole application's worth of things to have
forgotten. Learning to recognise which of the three processes is unhappy will save you more time than
anything else in this tutorial.
