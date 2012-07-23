
git svn rebase
move to https://github.com/panlm/puppet

git remote add p git@github.com:panlm/puppet
git push -u p master



== example ==

modify source code

git commit -m 'comments' -a

git svn rebase
<<<<<<< HEAD

git svn dcommit 

=======
git svn dcommit
>>>>>>> b74a45c0b10c01bd2d83762592318cc96e15e9f5
git pull puppet master

git push


