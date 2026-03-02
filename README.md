# PostgreSQL MVCC, Locking, and Concurrency Examples

This repository contains a hands-on, reproducible environment to demonstrate how PostgreSQL handles concurrent transactions. It provides step-by-step SQL scripts to simulate race conditions, test pessimistic locking, and intentionally trigger database deadlocks.

It serves as the companion code repository for my deep-dive blog post on PostgreSQL concurrency.

## Blog Reference

For a complete breakdown of the theory behind these scripts—including how Multi-Version Concurrency Control (MVCC) works, the anatomy of 8KB pages, and why deadlocks form—please read the full article on my blog:
https://sohardh.com/blog-post/postgres-mvcc

## Getting Started

This project includes a `docker-compose.yml` file to instantly spin up a PostgreSQL 18 environment.

### 1. Start the Database
Make sure you have Docker installed, then run:
```bash
docker-compose up -d