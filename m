Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88922198670
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgC3V04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 17:26:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:39982 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgC3V04 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 17:26:56 -0400
IronPort-SDR: AxGQcCycjVMPAOYhExXm1WELb2j8UrCyZqPFQj2BY1Vx09GbGpf5yQzpxkAGFDm635qD1wu1aJ
 Kx5m6hV55WQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 14:26:55 -0700
IronPort-SDR: e3npKXjUGNbV0xQjGfxiR7Q1QZXUiYdD5Mrbh3A1G8EyuVlEoc9ou3y0H+qSgi55PYYMwv8x6L
 p9cJeM3cwhsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="327870796"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2020 14:26:55 -0700
Subject: [PATCH 1/6] x86/asm: add iosubmit_cmds512_sync() based on enqcmds
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Date:   Mon, 30 Mar 2020 14:26:54 -0700
Message-ID: <158560361480.6059.301907463786988479.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ENQCMDS is a non-posted instruction introduced to submit 64B descriptors to
accelerator devices. The CPU instruction will set 1 for the zero flag if
the device rejects the submission. An 1 is also set if the destination is
not MMIO and/or the device does not respond. iosubmit_cmds512_sync() is
introduced to support this CPU instruction and allow multiple descriptors
to be copied to the same mmio location. This allows the caller to issue
multiple descriptors that are virtually contiguous in memory if desired.

ENQCMDS requires the destination address to be 64-byte aligned. No
alignment restriction is enforced for source operand.

See Intel Software Developer’s Manual for more information on the
instruction.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 arch/x86/include/asm/io.h |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e1aa17a468a8..349e97766c02 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -435,4 +435,41 @@ static inline void iosubmit_cmds512(void __iomem *__dst, const void *src,
 	}
 }
 
+/**
+ * iosubmit_cmds512_sync - copy data to single MMIO location, in 512-bit units
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: source
+ * @count: number of 512 bits quantities to submit
+ *
+ * Submit data from kernel space to MMIO space, in units of 512 bits at a
+ * time. Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards. The command returns the remaining count that is not
+ * successful on failure. 0 is returned if successful.
+ *
+ * Warning: Do not use this helper unless your driver has checked that the CPU
+ * instruction is supported on the platform.
+ */
+static inline size_t iosubmit_cmds512_sync(void __iomem *dst, const void *src,
+					   size_t count)
+{
+	const u8 *from = src;
+	const u8 *end = from + count * 64;
+	size_t remain = count;
+	bool retry;
+
+	while (from < end) {
+		/* ENQCMDS [rdx], rax */
+		asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90\t\n"
+			     "setz %0\t\n"
+			     : "=r"(retry) : "a" (dst), "d" (from));
+		if (retry)
+			return remain;
+
+		from += 64;
+		remain--;
+	}
+
+	return 0;
+}
+
 #endif /* _ASM_X86_IO_H */

