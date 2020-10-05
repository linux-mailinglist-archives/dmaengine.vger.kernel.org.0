Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1F283935
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgJEPLy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 11:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgJEPLr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 11:11:47 -0400
Received: from localhost (unknown [192.55.55.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D115208A9;
        Mon,  5 Oct 2020 15:11:46 +0000 (UTC)
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v7 2/5] x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction
Date:   Mon,  5 Oct 2020 08:11:23 -0700
Message-Id: <20201005151126.657029-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005151126.657029-1-dave.jiang@intel.com>
References: <20201005151126.657029-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, the MOVDIR64B instruction is used to atomically submit
64-byte work descriptors to devices. Although it can encounter errors
like device queue full, command not accepted, device not ready, etc when
writing to a device MMIO, MOVDIR64B can not report back on errors from
the device itself. This means that MOVDIR64B users need to separately
interact with a device to see if a descriptor was successfully queued,
which slows down device interactions.

ENQCMD and ENQCMDS also atomically submit 64-byte work descriptors
to devices. But, they *can* report back errors directly from the
device, such as if the device was busy, or device not enabled or does
not support the command. This immediate feedback from the submission
instruction itself reduces the number of interactions with the device
and can greatly increase efficiency.

ENQCMD can be used at any privilege level, but can effectively only
submit work on behalf of the current process. ENQCMDS is a ring0-only
instruction and can explicitly specify a process context instead of
being tied to the current process or needing to reprogram the IA32_PASID
MSR.

Use ENQCMDS for work submission within the kernel because a Process
Address ID (PASID) is setup to translate the kernel virtual address
space. This PASID is provided to ENQCMDS from the descriptor structure
submitted to the device and not retrieved from IA32_PASID MSR, which is
setup for the current user address space.

See Intel Software Developer’s Manual for more information on the
instructions.

 [ bp:
   - Make operand constraints like movdir64b() because both insns are
     basically doing the same thing, more or less.
   - Fixup comments and cleanup. ]

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200924180041.34056-3-dave.jiang@intel.com
---
 arch/x86/include/asm/special_insns.h | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2258c7d6e281..83f7c1a391e0 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -256,6 +256,48 @@ static inline void movdir64b(void *dst, const void *src)
 		     :  "m" (*__src), "a" (__dst), "d" (__src));
 }
 
+/**
+ * enqcmds - Enqueue a command in supervisor (CPL0) mode
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: 512 bits memory operand
+ *
+ * The ENQCMDS instruction allows software to write a 512-bit command to
+ * a 512-bit-aligned special MMIO region that supports the instruction.
+ * A return status is loaded into the ZF flag in the RFLAGS register.
+ * ZF = 0 equates to success, and ZF = 1 indicates retry or error.
+ *
+ * This function issues the ENQCMDS instruction to submit data from
+ * kernel space to MMIO space, in a unit of 512 bits. Order of data access
+ * is not guaranteed, nor is a memory barrier performed afterwards. It
+ * returns 0 on success and -EAGAIN on failure.
+ *
+ * Warning: Do not use this helper unless your driver has checked that the
+ * ENQCMDS instruction is supported on the platform and the device accepts
+ * ENQCMDS.
+ */
+static inline int enqcmds(void __iomem *dst, const void *src)
+{
+	const struct { char _[64]; } *__src = src;
+	struct { char _[64]; } *__dst = dst;
+	int zf;
+
+	/*
+	 * ENQCMDS %(rdx), rax
+	 *
+	 * See movdir64b()'s comment on operand specification.
+	 */
+	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
+		     CC_SET(z)
+		     : CC_OUT(z) (zf), "+m" (*__dst)
+		     : "m" (*__src), "a" (__dst), "d" (__src));
+
+	/* Submission failure is indicated via EFLAGS.ZF=1 */
+	if (zf)
+		return -EAGAIN;
+
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
-- 
2.26.2

