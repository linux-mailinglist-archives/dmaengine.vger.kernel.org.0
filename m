Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24420277823
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgIXSBN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 14:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgIXSBK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 14:01:10 -0400
Received: from localhost (unknown [192.55.55.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461E0208A9;
        Thu, 24 Sep 2020 18:01:09 +0000 (UTC)
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com, David.Laight@ACULAB.COM
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] x86/asm: Carve out a generic movdir64b() helper for general usage
Date:   Thu, 24 Sep 2020 11:00:37 -0700
Message-Id: <20200924180041.34056-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924180041.34056-1-dave.jiang@intel.com>
References: <20200924180041.34056-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The MOVDIR64B instruction can be used by other wrapper instructions. Move
the asm code to special_insns.h and have iosubmit_cmds512() call the
asm function.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/io.h            | 17 +++--------------
 arch/x86/include/asm/special_insns.h | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

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
index 59a3e13204c3..2258c7d6e281 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,28 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+/* The dst parameter must be 64-bytes aligned */
+static inline void movdir64b(void *dst, const void *src)
+{
+	const struct { char _[64]; } *__src = src;
+	struct { char _[64]; } *__dst = dst;
+
+	/*
+	 * MOVDIR64B %(rdx), rax.
+	 *
+	 * Both __src and __dst must be memory constraints in order to tell the
+	 * compiler that no other memory accesses should be reordered around
+	 * this one.
+	 *
+	 * Also, both must be supplied as lvalues because this tells
+	 * the compiler what the object is (its size) the instruction accesses.
+	 * I.e., not the pointers but what they point, thus the deref'ing '*'.
+	 */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     : "+m" (*__dst)
+		     :  "m" (*__src), "a" (__dst), "d" (__src));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
-- 
2.21.3

