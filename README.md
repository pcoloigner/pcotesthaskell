# rcookhaskell

My first Haskell app on Heroku!

## Clone, build and run locally

```
git clone https://github.com/rcook/rcookhaskell.git
stack build --fast
PORT=8000 stack exec rcookhaskell
```

## Deploy to Heroku

I followed these two references:

* ["For All the World to See: Deploying Haskell with Heroku"][for-all-the-world] by James Bowen
* [heroku-buildpack-stack][heroku-buildpack-stack] by Mark Fine

## Licence

Released under [MIT License][licence]

[for-all-the-world]: https://hackernoon.com/for-all-the-world-to-see-deploying-haskell-with-heroku-7ea46f827ce
[heroku-buildpack-stack]: https://github.com/mfine/heroku-buildpack-stack
[licence]: LICENSE
