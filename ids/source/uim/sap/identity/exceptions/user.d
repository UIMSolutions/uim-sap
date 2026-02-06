module uim.sap.identity.exceptions.user;

import uim.sap.identity;
@safe:

/**
 * Exception thrown when a user operation fails
 */
class IdentityUserException : IdentityException {
    int statusCode;
    
    this(string msg, int code = 0, string file = __FILE__, size_t line = __LINE__, Throwable nextInChain = null) pure nothrow @safe {
        super(msg, file, line, nextInChain);
        this.statusCode = code;
    }
}
