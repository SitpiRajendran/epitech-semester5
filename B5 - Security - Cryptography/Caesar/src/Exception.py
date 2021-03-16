class _Exception(Exception):
    def __init__(self, m):
        self.message = m
    def __str__(self):
        return self.message
    def WhatError(message: str):
        print("ERROR: " + message)
        exit(84)