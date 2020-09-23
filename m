Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE2276497
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 01:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWXfN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 19:35:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:39739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgIWXfI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Sep 2020 19:35:08 -0400
IronPort-SDR: KHijUnqgKh9lvn53wnozlDKTlLLGxBTsuJ7968XBj8HFwjmu5kS2F8zuOCuFGJFq5LNVQBdL8m
 D80RZ8aExEfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225177341"
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="225177341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 16:35:07 -0700
IronPort-SDR: ffVCwNLmC2oSbtMtzbpABS1Qk/BUxEgESw51hL4TBoDmq6yth3JMuliujOyhR6XwLyY07dC7tf
 zXs6ZpTkZn7Q==
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="335696642"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 16:35:07 -0700
Subject: [PATCH resend v5 1/5] x86/asm: Carve out a generic movdir64b()
 helper for general usage
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Sep 2020 16:35:06 -0700
Message-ID: <160090410685.45290.18178329260065780041.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160090402526.45290.468202328615149643.stgit@djiang5-desk3.ch.intel.com>
References: <160090402526.45290.468202328615149643.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The MOVDIR64B instruction can be used by other wrapper instructions. Move
the asm code to special_insns.h and have iosubmit_cmds512() call the
asm function.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/io.h            |   17 +++--------------
 arch/x86/include/asm/special_insns.h |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e1aa17a468a8..d726459d08e5 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -401,7 +401,7 @@ extern bool phys_mem_access_encrypted(unsigned long phys_addr,
 
 /**
  * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
- * @__dst: destination, in MMIO space (must be 512-bit aligned)
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
  * @src: source
  * @count: number of 512 bits quantities to submit
  *
@@ -412,25 +412,14 @@ extern bool phys_mem_access_encrypted(unsigned long phys_addr,
  * Warning: Do not use this helper unless your driver has checked that the CPU
  * instruction is supported on the platform.
  */
-static inline void iosubmit_cmds512(void __iomem *__dst, const void *src,
+static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
 				    size_t count)
 {
-	/*
-	 * Note that this isn't an "on-stack copy", just definition of "dst"
-	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
-	 * In the MOVDIR64B case that may be needed as you can use the
-	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
-	 * lets the compiler know how much gets clobbered.
-	 */
-	volatile struct { char _[64]; } *dst = __dst;
 	const u8 *from = src;
 	const u8 *end = from + count * 64;
 
 	while (from < end) {
-		/* MOVDIR64B [rdx], rax */
-		asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
-			     : "=m" (dst)
-			     : "d" (from), "a" (dst));
+		movdir64b(dst, from);
 		from += 64;
 	}
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..2a5abd27bb86 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,25 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+/* The dst parameter must be 64-bytes aligned */
+static inline void movdir64b(void *dst, const void *src)
+{
+	/*
+	 * Note that this isn't an "on-stack copy", just definition of "dst"
+	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
+	 * In the MOVDIR64B case that may be needed as you can use the
+	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
+	 * lets the compiler know how much gets clobbered.
+	 */
+	volatile struct { char _[64]; } *__dst = dst;
+
+	/* MOVDIR64B [rdx], rax */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     :
+		     : "m" (*(struct { char _[64];} **)src), "a" (__dst)
+		     : "memory");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */

