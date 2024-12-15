# MD5 Reference Implementation in C as per RFC1321 #

The [MD5](https://en.wikipedia.org/wiki/MD5) cryptographic hash function is fully specified in [RFC 1321](https://www.ietf.org/rfc/rfc1321.txt)[1]. This document contains a reference implementation in the C programming language in its appendices (Appendix A, specifically). This repository contains what is largely a copy-paste of this implementation for both pedagogical and convenience purposes.

Quoting Appendix A directly:

 >  This appendix contains the following files taken from RSAREF: A
 >  Cryptographic Toolkit for Privacy-Enhanced Mail:
 > 
 >    global.h -- global header file
 >
 >    md5.h -- header file for MD5
 > 
 >    md5c.c -- source code for MD5
 > 
 >  For more information on RSAREF, send email to <rsaref@rsa.com>.
 > 
 >  The appendix also includes the following file:
 > 
 >    mddriver.c -- test driver for MD2, MD4 and MD5
 > 
 >  The driver compiles for MD5 by default but can compile for MD2 or MD4
 >  if the symbol MD is defined on the C compiler command line as 2 or 4.
 > 
 >  The implementation is portable and should work on many different
 >  plaforms. However, it is not difficult to optimize the implementation
 >  on particular platforms, an exercise left to the reader. For example,
 >  on "little-endian" platforms where the lowest-addressed byte in a 32-
 >  bit word is the least significant and there are no alignment
 >  restrictions, the call to Decode in MD5Transform can be replaced with
 >  a typecast.

Any file within this repository that is not on this list is not part of the original RFC.

Additionally, Ronald Rivest's contact information is listed as:

 > Ronald L. Rivest
 >
 > Massachusetts Institute of Technology
 >
 > Laboratory for Computer Science
 >
 > NE43-324
 >
 > 545 Technology Square
 >
 > Cambridge, MA  02139-1986
 > 
 >
 > Phone: (617) 253-5880
 >
 > EMail: rivest@theory.lcs.mit.edu

## Modifications ##

The original reference implementation in the RFC is intended for 32-bit machines. Due to the lack of standard integer types (a la `stdint.h`) at the time, `unsigned long int` was typecast to `UINT4` (and similarly for `UINT2`). When compiling on modern 64-bit machines these invariants of course break. As such, I have modified these type aliases accordingly. The Git-flavoured diff for this change is as follows:

```diff
diff --git a/global.h b/global.h
index 2ed41be..bc5029d 100644
--- a/global.h
+++ b/global.h
@@ -1,5 +1,6 @@
 /* GLOBAL.H - RSAREF types and constants
  */
+#include <stdint.h>
 
 /* PROTOTYPES should be set to one if and only if the compiler supports
   function argument prototyping.
@@ -14,10 +15,10 @@ The following makes PROTOTYPES default to 0 if it has not already
 typedef unsigned char *POINTER;
 
 /* UINT2 defines a two byte word */
-typedef unsigned short int UINT2;
+typedef uint16_t UINT2;
 
 /* UINT4 defines a four byte word */
-typedef unsigned long int UINT4;
+typedef uint32_t UINT4;
 
 /* PROTO_LIST is defined depending on how PROTOTYPES is defined above.
 If using PROTOTYPES, then PROTO_LIST returns the list, otherwise it
```

## Security ##

As of the time of writing, MD5 has long been known to be cryptographically broken. Please consult RFC 6151[2] for technical guidance on its use.

## Bibliography ##

 1. R. Rivest, "The MD5 Message-Digest Algorithm," RFC 1321, Internet Engineering Task Force (IETF), Apr. 1992. [Online]. Available: https://www.rfc-editor.org/rfc/rfc1321. [Accessed: Dec. 15, 2024].
 2. L. Turner and S. Chen, "Updated Security Considerations for the MD5 Message-Digest and the HMAC-MD5 Algorithms," RFC 6151, Internet Engineering Task Force (IETF), Mar. 2011. [Online]. Available: https://www.rfc-editor.org/rfc/rfc6151. [Accessed: Dec. 15, 2024].

