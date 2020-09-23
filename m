Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14CC276495
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 01:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIWXfT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 19:35:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:2520 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgIWXfN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Sep 2020 19:35:13 -0400
IronPort-SDR: TS/irW62IDVKftvhgx2EIfhrzzePV0K/Vg6XumymxzyMGOPgsUPSpSnPglV4jK50qlLIM5CP+p
 BG5mzHDVPs2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="158399495"
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="158399495"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 16:35:13 -0700
IronPort-SDR: pRLwnst99sOhTMJqytp+xc1X8FZKPQ+D9Mg8uaSe09R4j4N7ialVKdKAu2e6gWrSY/fPyvId0V
 8mJamgPWWwiQ==
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="486657967"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 16:35:12 -0700
Subject: [PATCH resend v5 2/5] x86/asm: Add enqcmds() to support ENQCMDS
 instruction
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Sep 2020 16:35:12 -0700
Message-ID: <160090411238.45290.9731730319044014453.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160090402526.45290.468202328615149643.stgit@djiang5-desk3.ch.intel.com>
References: <160090402526.45290.468202328615149643.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, the MOVDIR64B instruction is used to atomically
submit 64-byte work descriptors to devices. Although it can
encounter errors like device queue full, command not accepted,
device not ready, etc when writing to a device MMIO, MOVDIR64B
can not report back on errors from the device itself. This
means that MOVDIR64B users need to separately interact with a
device to see if a descriptor was successfully queued, which
slows down device interactions.

ENQCMD and ENQCMDS also atomically submit 64-byte work
descriptors to devices. But, they *can* report back errors
directly from the device, such as if the device was busy,
or device not enabled or does not support the command. This
immediate feedback from the submission instruction itself
reduces the number of interactions with the device and can
greatly increase efficiency.

ENQCMD can be used at any privilege level, but can effectively
only submit work on behalf of the current process. ENQCMDS is a
ring0-only instruction and can explicitly specify a process
context instead of being tied to the current process or needing
to reprogram the IA32_PASID MSR.

Use ENQCMDS for work submission within the kernel because a
Process Address ID (PASID) is setup to translate the kernel
virtual address space. This PASID is provided to ENQCMDS from
the descriptor structure submitted to the device and not retrieved
from IA32_PASID MSR, which is setup for the current user address space.

See Intel Software Developer’s Manual for more information on the
instructions.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/special_insns.h |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2a5abd27bb86..05f49de9f1cd 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -253,6 +253,40 @@ static inline void movdir64b(void *dst, const void *src)
 		     : "memory");
 }
 
+/**
+ * enqcmds - copy a 512 bits data unit to single MMIO location
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: source
+ *
+ * The ENQCMDS instruction allows software to write a 512 bits command to
+ * a 512 bits aligned special MMIO region that supports the instruction.
+ * A return status is loaded into the ZF flag in the RFLAGS register.
+ * ZF = 0 equates to success, and ZF = 1 indicates retry or error.
+ *
+ * The enqcmds() function uses the ENQCMDS instruction to submit data from
+ * kernel space to MMIO space, in a unit of 512 bits. Order of data access
+ * is not guaranteed, nor is a memory barrier performed afterwards. The
+ * function returns 0 on success and -EAGAIN on failure.
+ *
+ * Warning: Do not use this helper unless your driver has checked that the CPU
+ * instruction is supported on the platform and the device accepts ENQCMDS.
+ */
+static inline int enqcmds(void __iomem *dst, const void *src)
+{
+	int zf;
+
+	/* ENQCMDS [rdx], rax */
+	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
+		     CC_SET(z)
+		     : CC_OUT(z) (zf)
+		     : "a" (dst), "d" (src));
+	/* Submission failure is indicated via EFLAGS.ZF=1 */
+	if (zf)
+		return -EAGAIN;
+
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */

