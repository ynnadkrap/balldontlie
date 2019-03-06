class AddPostseasonToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :postseason, :boolean, default: false

    ActiveRecord::Base.connection.execute("UPDATE games SET postseason = false")
    ActiveRecord::Base.connection.execute <<~SQL
      UPDATE games SET postseason = true
      WHERE (season = 1979 and date >= '1980-04-02')
      OR (season = 1980 and date >= '1981-03-31')
      OR (season = 1981 and date >= '1982-04-20')
      OR (season = 1982 and date >= '1983-04-19')
      OR (season = 1983 and date >= '1984-04-17')
      OR (season = 1984 and date >= '1985-04-17')
      OR (season = 1985 and date >= '1986-04-17')
      OR (season = 1986 and date >= '1987-04-23')
      OR (season = 1987 and date >= '1988-04-28')
      OR (season = 1988 and date >= '1989-04-27')
      OR (season = 1989 and date >= '1990-04-26')
      OR (season = 1990 and date >= '1991-04-25')
      OR (season = 1991 and date >= '1992-04-23')
      OR (season = 1992 and date >= '1993-04-29')
      OR (season = 1993 and date >= '1994-04-28')
      OR (season = 1994 and date >= '1995-04-27')
      OR (season = 1995 and date >= '1996-04-25')
      OR (season = 1996 and date >= '1997-04-24')
      OR (season = 1997 and date >= '1998-04-23')
      OR (season = 1998 and date >= '1999-05-08')
      OR (season = 1999 and date >= '2000-04-22')
      OR (season = 2000 and date >= '2001-04-21')
      OR (season = 2001 and date >= '2002-04-20')
      OR (season = 2002 and date >= '2003-04-19')
      OR (season = 2003 and date >= '2004-04-17')
      OR (season = 2004 and date >= '2005-04-23')
      OR (season = 2005 and date >= '2006-04-22')
      OR (season = 2006 and date >= '2007-04-21')
      OR (season = 2007 and date >= '2008-04-19')
      OR (season = 2008 and date >= '2009-04-18')
      OR (season = 2009 and date >= '2010-04-17')
      OR (season = 2010 and date >= '2011-04-16')
      OR (season = 2011 and date >= '2012-04-28')
      OR (season = 2012 and date >= '2013-04-20')
      OR (season = 2013 and date >= '2014-04-19')
      OR (season = 2014 and date >= '2015-04-18')
      OR (season = 2015 and date >= '2016-04-16')
      OR (season = 2016 and date >= '2017-04-15')
      OR (season = 2017 and date >= '2018-04-14')
    SQL

    change_column_null :games, :postseason, false
  end
end
