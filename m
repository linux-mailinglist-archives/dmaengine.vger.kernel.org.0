Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2136110459A
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTVXv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:23:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:25136 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVXv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:23:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381506479"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 13:23:49 -0800
Subject: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:23:49 -0700
Message-ID: <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the introduction of movdir64b instruction, there is now an instruction
that can write 64 bytes of data atomicaly.

Quoting from Intel SDM:
"There is no atomicity guarantee provided for the 64-byte load operation
from source address, and processor implementations may use multiple
load operations to read the 64-bytes. The 64-byte direct-store issued
by MOVDIR64B guarantees 64-byte write-completion atomicity. This means
that the data arrives at the destination in a single undivided 64-byte
write transaction."

We have identified at least 3 different use cases for this instruction in
the format of func(dst, src, count):
1) Clear poison / Initialize MKTME memory
   Destination is normal memory.
   Source in normal memory. Does not increment. (Copy same line to all
   targets)
   Count (to clear/init multiple lines)
2) Submit command(s) to new devices
   Destination is a special MMIO region for a device. Does not increment.
   Source is normal memory. Increments.
   Count usually is 1, but can be multiple.
3) Copy to iomem in big chunks
   Destination is iomem and increments
   Source in normal memory and increments
   Count is number of chunks to copy

This commit adds support for case #2 to support device that will accept
commands via this instruction.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 arch/x86/include/asm/io.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/io.h        |   11 +++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 6bed97ff6db2..3126f6e1d5b8 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -403,5 +403,49 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 
 extern bool phys_mem_access_encrypted(unsigned long phys_addr,
 				      unsigned long size);
+#include <linux/cpufeature.h>
+static inline bool cpu_has_write512(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_MOVDIR64B);
+}
+
+#define cpu_has_write512 cpu_has_write512
+
+static inline void __iowrite512(void __iomem *__dst, const void *src)
+{
+	volatile struct { char _[64]; } *dst = __dst;
+
+	/* movdir64b [rdx], rax */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+			: "=m" (dst)
+			: "d" (src), "a" (dst));
+}
+
+/**
+ * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: source
+ * @count: number of 512 bits quantities to submit
+ *
+ * Submit data from kernel space to MMIO space, in units of 512 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ */
+static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
+				    size_t count)
+{
+	const u8 *from = src;
+	const u8 *end = from + count * 64;
+
+	if (!cpu_has_write512())
+		return;
+
+	while (from < end) {
+		__iowrite512(dst, from);
+		from += 64;
+	}
+}
+
+#define iosubmit_cmds512 iosubmit_cmds512
 
 #endif /* _ASM_X86_IO_H */
diff --git a/include/linux/io.h b/include/linux/io.h
index accac822336a..ca14af3e84de 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -20,6 +20,17 @@ __visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count
 void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
+#ifndef cpu_has_write512
+#define cpu_has_write512() (0)
+#endif
+
+#ifndef iosubmit_cmds512
+static inline void iosubmit_cmds512(void __iomem *to, const void *from,
+				    size_t count)
+{
+}
+#endif
+
 #ifdef CONFIG_MMU
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		       phys_addr_t phys_addr, pgprot_t prot);

