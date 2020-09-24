Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77FF2778CE
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgIXS6b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 14:58:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35612 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgIXS6a (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 14:58:30 -0400
Received: from zn.tnic (p200300ec2f0c9500731208bb5d5e764a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:7312:8bb:5d5e:764a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 367141EC02F2;
        Thu, 24 Sep 2020 20:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600973909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pvXTnmWGvKtgmruVF9CFH80cOq+coBlIBCsP6YrIMN8=;
        b=Bthia61HoShSvGYZn5f8yiSeXycGFpDA/+s/JDURnJYeh3pcJtbsG0zKvQ3pNvJqEiw5NO
        wOWGlvegmhAVt972XZqY/WZwHwyc4SiJJ9gtutGLw1slMteXePkmS7wEyWLtxjuJ5HPnv6
        KqtywLs7OyRQdZGDTzbQqr25f3YYoMM=
Date:   Thu, 24 Sep 2020 20:58:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@ACULAB.COM, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] x86/asm: Add enqcmds() to support ENQCMDS
 instruction
Message-ID: <20200924185822.GQ5030@zn.tnic>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-3-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924180041.34056-3-dave.jiang@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 24, 2020 at 11:00:38AM -0700, Dave Jiang wrote:
> +/**
> + * enqcmds - copy a 512 bits data unit to single MMIO location

You forgot to fix this.

> + * @dst: destination, in MMIO space (must be 512-bit aligned)
> + * @src: source
> + *
> + * The ENQCMDS instruction allows software to write a 512 bits command to
> + * a 512 bits aligned special MMIO region that supports the instruction.
> + * A return status is loaded into the ZF flag in the RFLAGS register.
> + * ZF = 0 equates to success, and ZF = 1 indicates retry or error.
> + *
> + * The enqcmds() function uses the ENQCMDS instruction to submit data from
> + * kernel space to MMIO space, in a unit of 512 bits. Order of data access
> + * is not guaranteed, nor is a memory barrier performed afterwards. The
> + * function returns 0 on success and -EAGAIN on failure.
> + *
> + * Warning: Do not use this helper unless your driver has checked that the CPU
> + * instruction is supported on the platform and the device accepts ENQCMDS.
> + */
> +static inline int enqcmds(void __iomem *dst, const void *src)
> +{
> +	int zf;
> +
> +	/* ENQCMDS [rdx], rax */
> +	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
> +		     CC_SET(z)
> +		     : CC_OUT(z) (zf)
> +		     : "a" (dst), "d" (src));

Those operands need to be specified the same way as for movdir64b.

I've done that to save roundtrip time - simply replace yours with this
one after having tested it on actual hardware, of course.

---
From 39cbdc81d657efcb73c0f7d7ab5e5c53f439f267 Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 24 Sep 2020 11:00:38 -0700
Subject: [PATCH] x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index 2f0c8a39c796..2c18c780b2d5 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -262,6 +262,48 @@ static inline void movdir64b(void *dst, const void *src)
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
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
