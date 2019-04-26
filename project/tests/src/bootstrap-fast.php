<?php
/**
 * @file
 *   A bootstrap file for `phpunit` test runner.
 *
 * This bootstrap file from DTT is fast and customizable.
 *
 * If you get 'class not found' 'during test running, you may add copy and add
 * the missing namespaces to bottom of this file. Then specify that file for
 * PHPUnit bootstrap.
 *
 * Alternatively, use the bootstrap.php file in this same directory which is slower
 * but registers all the namespaces that Drupal tests expect.
 */

use weitzman\DrupalTestTraits\AddPsr4;

list($finder, $class_loader) = AddPsr4::add();
$root = $finder->getDrupalRoot();

// Needed for kernel tests.
$GLOBALS['namespaces'] = [];

// Register more namespaces, as needed. These are only necessary for code
// referenced in the test files (such as class constants, traits, etc). Once
// the test is running, autoloading works as normal once Drupal is bootstrapped.
$class_loader->addPsr4('Drupal\Tests\block\\', "$root/core/modules/block/tests/src");
