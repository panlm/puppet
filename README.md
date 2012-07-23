
git svn rebase
move to https://github.com/panlm/puppet

git remote add p git@github.com:panlm/puppet
git push -u p master



== example ==

modify source code

git commit -m 'comments' -a
git svn rebase
git svn dcommit
git pull puppet master
git push


