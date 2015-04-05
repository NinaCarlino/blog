---
title: "Recreational Machine Learning in Ruby"
date: 2015/04/04
author: Rick
published: false
---


Machine Learning can be intimidating. If you are dying to get your feet wet with some machine learning but feel intimidated by all the jargon, one area of ML that is easy to try out at home is the [Naive Bayes](https://en.wikipedia.org/wiki/Naive_Bayes_classifier) family of classifiers.

I won't dive into specifics about how they work in this article, but generally speaking, Naive Bayes classifiers are seen in applications such as:

 * Article categorization
 * Spam detection
 * Automatic language inference

If you are a Ruby user, there are a number of libraries available such as [Classifier](https://github.com/cardmagic/classifier), [NBayes](https://github.com/oasic/nbayes.git) and [Stuff-Classifier](https://github.com/alexandru/stuff-classifier).

Once you have taken a look at the libraries, it's time for us to solve serious problems that demand answers.

### Famous Quotes: Paris Hilton or Ben Franklin?

In the following example, we will use the [Classifier](https://github.com/cardmagic/classifier) gem to determine if a particular quote can be attributed to Paris Hilton or Benjamin Franklin. For the sake of brevity, I have removed ambiguous training data. If you would like to see the full set of training data*, check out [this gist on GitHub](https://gist.github.com/RickCarlino/afe6c5ed198b7bb0573b).

Once you have installed the gem via `gem install classifier`, you can run the code below to classify quotes:

```ruby

require 'classifier'

robot_overlord = Classifier::Bayes.new 'hilton', 'franklin'

# Train your classifier using as many quotes as possible...
robot_overlord.train_hilton("The only rule is don't be boring and dress cute"\
                            " wherever you go. Life is too short to blend in.")
robot_overlord.train_franklin("Tell me and I forget. Teach me and I remember."\
                              " Involve me and I learn.")

robot_overlord.classify "He that is good for making excuses is seldom good for"\
                        " anything else."
# => :franklin
robot_overlord.classify "One night stands are not for me. I think it's gross"\
                        " when you just give it up."
# => :hilton

```

Naive Bayes classifiers are not a magic wand that can solve any problem, but they are definitely worth a look if you want to see machine learning in action. We'd love to hear about the things you build.

* Special thanks to [BrainyQuote](http://www.brainyquote.com/) for providing the quotes.
