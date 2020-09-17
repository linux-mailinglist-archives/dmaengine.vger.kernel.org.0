Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B726E735
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIQVP1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 17:15:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:41547 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQVP0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 17:15:26 -0400
IronPort-SDR: LdcCmzKcNAHgY/OUGccitDvn4M6dorFJt+mXEK/SAC1WaQHslRWcYJQK027c9419wq6My+XQpP
 O9JSRzXLlXdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221351879"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="221351879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:24 -0700
IronPort-SDR: JpnNrI7fyoMY2DWA7h8P92iuVyGi1Ukn3TW4EiUI8BoCcjlwW1se8Rv5CANbSOtXXAseZoKUX2
 BDFOxmzDAipQ==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="452477865"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:15:23 -0700
Subject: [PATCH v4 2/5] x86/asm: add enqcmds() to support ENQCMDS instruction
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 14:15:23 -0700
Message-ID: <160037732334.3777.8083106831110728138.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, the MOVDIR64B instruction is used to atomically
submit 64-byte work descriptors to devices. Although it can
encounter errors like faults, MOVDIR64B can not report back on
errors from the device itself. This means that MOVDIR64B users
need to separately interact with a device to see if a descriptor
was successfully queued, which slows down device interactions.

ENQCMD and ENQCMDS also atomically submit 64-byte work
descriptors to devices. But, they *can* report back errors
directly from the device, such as if the device was busy, or
there was an error made in composing the descriptor. This
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

Add enqcmds() in x86 io.h instead of special_insns.h. MOVDIR64B
instruction can be used for other purposes. A wrapper was introduced
in io.h for its command submission usage. ENQCMDS has a single
purpose of submit 64-byte commands to supported devices and should
be called directly.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/io.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index d726459d08e5..b7af0bf8a018 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -424,4 +424,33 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
 	}
 }
 
+/**
+ * enqcmds - copy a 512 bits data unit to single MMIO location
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: source
+ *
+ * Submit data from kernel space to MMIO space, in a unit of 512 bits.
+ * Order of data access is not guaranteed, nor is a memory barrier
+ * performed afterwards. The command returns false (0) on failure, and true (1)
+ * on success.
+ *
+ * Warning: Do not use this helper unless your driver has checked that the CPU
+ * instruction is supported on the platform.
+ */
+static inline bool enqcmds(void __iomem *dst, const void *src)
+{
+	bool retry;
+
+	/* ENQCMDS [rdx], rax */
+	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90\t\n"
+		     CC_SET(z)
+		     : CC_OUT(z) (retry)
+		     : "a" (dst), "d" (src));
+	/* Submission failure is indicated via EFLAGS.ZF=1 */
+	if (retry)
+		return false;
+
+	return true;
+}
+
 #endif /* _ASM_X86_IO_H */

