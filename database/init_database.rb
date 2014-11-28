#!/usr/bin/env ruby

require "sqlite3"
require "fileutils"

tmp_dir = File.expand_path "../tmp", __FILE__
FileUtils.mkdir tmp_dir

db_path = File.join tmp_dir, "cnet.db"
db = SQLite3::Database.new db_path

sql = <<-SQL
	CREATE TABLE pages(
		url text,
		body text,
		published_at text
	);
	CREATE INDEX index_published_at ON pages(published_at);
	CREATE UNIQUE INDEX index_url ON pages(url);

	CREATE TABLE page_tags(
		page_url text,
		tag_name text
	);
	CREATE INDEX index_page_url ON page_tags(page_url);
	CREATE UNIQUE INDEX index_page_url_tag_name ON page_tags(page_url, tag_name);
SQL

db.execute_batch sql
db.close