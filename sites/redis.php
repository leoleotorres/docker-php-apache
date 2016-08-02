<?php

$redis = new Redis();
$redis->connect('172.17.0.1');
$redis->select(10);
$redis->set('x', '54');