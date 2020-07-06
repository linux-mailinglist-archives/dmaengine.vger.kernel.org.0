Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6356215E39
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgGFSVj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:21:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:29261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgGFSVj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 14:21:39 -0400
IronPort-SDR: 2zsI27iLv6wlzLiavrPmygR7VJutojq+Hhhg/B4mzKzvyOK+Iinv2PDGlsPgGoFScRG3ECIpli
 /v4eJCOiQ2Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="135722844"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="135722844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:21:38 -0700
IronPort-SDR: FqSu+TyLGuY3x0FnvppQHuHISp0IWyu4Rv5nY/nDQ/yCOUALg8Jgd8Np4Agne7ip8T4rQ4pbKY
 qxbLtvONOuJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="482788013"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2020 11:21:38 -0700
Subject: [PATCH v3 2/6] x86/asm: move the raw asm in iosubmit_cmds512() to
 special_insns.h
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     Tony Luck <tony.luck@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com
Date:   Mon, 06 Jul 2020 11:21:37 -0700
Message-ID: <159405969791.19216.14520281863577841635.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
References: <159405827797.19216.15283540319201919054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
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
index eb8e781c4353..fb28caec9aa0 100644
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
 

