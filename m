Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18AD26E733
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIQVPW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 17:15:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:2663 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQVPW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 17:15:22 -0400
IronPort-SDR: iXQDXbaET1tn5QLY1YjlbeNoE20iryi24WRUZ7JzJ/W5j5Bf+txZp+KuSWtpwD3pXtBL0G4p3Q
 SDJy4pWZ2R5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="223966023"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="223966023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:18 -0700
IronPort-SDR: QjZkLlL+BWh4ysl4CEu7/0e8OWxF50gSe+5SdpW8qJHjAFvvI6GW35VmIKtCWqjxKvqR4NaTSL
 v9ZOxt7ZI7AA==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="483910059"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:17 -0700
Subject: [PATCH v4 1/5] x86/asm: move the raw asm in iosubmit_cmds512() to
 special_insns.h
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 14:15:16 -0700
Message-ID: <160037731654.3777.18071122574577972463.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The MOVDIR64B instruction can be used by other wrapper instructions. Move
the core asm code to special_insns.h and have iosubmit_cmds512() call the
core asm function.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/io.h            |   17 +++--------------
 arch/x86/include/asm/special_insns.h |   17 +++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)

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
index 59a3e13204c3..7bc8e714f37e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,23 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+static inline void movdir64b(void *__dst, const void *src)
+{
+	/*
+	 * Note that this isn't an "on-stack copy", just definition of "dst"
+	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
+	 * In the MOVDIR64B case that may be needed as you can use the
+	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
+	 * lets the compiler know how much gets clobbered.
+	 */
+	volatile struct { char _[64]; } *dst = __dst;
+
+	/* MOVDIR64B [rdx], rax */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     : "=m" (dst)
+		     : "d" (src), "a" (dst));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */

