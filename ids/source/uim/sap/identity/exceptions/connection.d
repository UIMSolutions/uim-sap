module uim.sap.identity.exceptions.connection;

import uim.sap.identity;
@safe:

/**
 * Exception thrown when a connection error occurs
 */
class IdentityConnectionException : IdentityException {
    this(string msg, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @nogc @safe {
        super(msg, file, line, nextInChain);
    }
}