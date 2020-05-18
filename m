Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888841D87A4
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgERSxk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 14:53:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:56326 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgERSxk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 May 2020 14:53:40 -0400
IronPort-SDR: jcnwODvfpev9B0EhM6k1Ec9U21LrZe372uHgf24hfn3Zbqd5XD9wcySI7v+aYrAa4CRjTJWcu7
 2YY/kqeujcxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 11:53:40 -0700
IronPort-SDR: 7shbM997NYsct24qGQHZHio+5kZ2YaV3EMSEq+8b/kvG4b20a2N807TsQfr+u0L3Xu1dc+PtD7
 i/qNom4gmMKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="465686625"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2020 11:53:39 -0700
Subject: [PATCH v2 3/9] x86/asm: add enqcmds() to support ENQCMDS instruction
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, dan.j.williams@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com, dave.hansen@intel.com
Date:   Mon, 18 May 2020 11:53:39 -0700
Message-ID: <158982801913.37989.12577827391856760995.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
References: <158982749959.37989.2096629611303670415.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
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
 arch/x86/include/asm/io.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 56421666115e..049d78d85226 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -424,4 +424,32 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
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
+		     "setz %0\t\n"
+		     : "=r"(retry) : "a" (dst), "d" (src));
+	/* Submission failure is indicated via EFLAGS.ZF=1 */
+	if (retry)
+		return false;
+
+	return true;
+}
+
 #endif /* _ASM_X86_IO_H */

