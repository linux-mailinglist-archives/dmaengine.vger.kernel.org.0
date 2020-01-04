Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CE130295
	for <lists+dmaengine@lfdr.de>; Sat,  4 Jan 2020 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgADOTB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Jan 2020 09:19:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgADOTB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 Jan 2020 09:19:01 -0500
Received: from zn.tnic (p200300EC2F18F800CC7EEF965DC10FDE.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:f800:cc7e:ef96:5dc1:fde])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8781A1EC0626;
        Sat,  4 Jan 2020 15:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578147539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=grHGSZANPdRX4GYfQm3z7DlEzhiM+6VKLUd0nRV33tA=;
        b=Y7/wS0YXsjQghvkU8yEZ40tZhEzBbsKiNBJ1HmgK5aYWcv9BkvQzjCnnOq9DqdlMvytTFd
        sgmZJm+4JvQCu43OuEd3pjOrVI+sKdsWA46seByvy6aGs2d9BXTGeR9sWGEFCREPpM/Sk2
        Q+yinBO2YOC2ZGxYyDClL8N7uGscesA=
Date:   Sat, 4 Jan 2020 15:18:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        axboe@kernel.dk, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC v3 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20200104141851.GA31856@zn.tnic>
References: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
 <157662558568.51652.16396789566261303659.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157662558568.51652.16396789566261303659.stgit@djiang5-desk3.ch.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 17, 2019 at 04:33:05PM -0700, Dave Jiang wrote:
> With the introduction of movdir64b instruction, there is now an instruction

MOVDIR64B in caps like the SDM.

> that can write 64 bytes of data atomicaly.

"atomically"

> Quoting from Intel SDM:
> "There is no atomicity guarantee provided for the 64-byte load operation
> from source address, and processor implementations may use multiple
> load operations to read the 64-bytes. The 64-byte direct-store issued
> by MOVDIR64B guarantees 64-byte write-completion atomicity. This means
> that the data arrives at the destination in a single undivided 64-byte
> write transaction."
> 
> We have identified at least 3 different use cases for this instruction in
> the format of func(dst, src, count):
> 1) Clear poison / Initialize MKTME memory
>    Destination is normal memory.
>    Source in normal memory. Does not increment. (Copy same line to all
>    targets)
>    Count (to clear/init multiple lines)

If you're going to refer to @dst, @src and @count as the arguments of
"func", then use the same spelling here too pls.

> 2) Submit command(s) to new devices
>    Destination is a special MMIO region for a device. Does not increment.
>    Source is normal memory. Increments.
>    Count usually is 1, but can be multiple.
> 3) Copy to iomem in big chunks
>    Destination is iomem and increments
>    Source in normal memory and increments
>    Count is number of chunks to copy

I could use some blurb here explaining why is this needed. As in, device
takes only 64byte writes as commands, we want it faster by shuffling
more data in one go, etc, etc.

> This commit adds support for case #2 to support device that will accept

s/This commit//

> commands via this instruction.

This is hinting at the need for the atomic 64-bit writes but an explicit
justification would be better.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  arch/x86/include/asm/io.h |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 9997521fc5cd..2d3c9dd39479 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -399,4 +399,46 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset,
>  extern bool phys_mem_access_encrypted(unsigned long phys_addr,
>  				      unsigned long size);
>  
> +static inline void __iowrite512(void __iomem *__dst, const void *src)

I don't see that function used anywhere except in iosubmit_cmds512(). If
you're not going to use it elsewhere, pls fold it into iosubmit_cmds512().

> +{
> +	/*
> +	 * Note that this isn't an "on-stack copy", just definition of "dst"
> +	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
> +	 * In the movdir64b() case that may be needed as you can use the
		  ^^^^^^^^^^^

Is that a function?

> +	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
> +	 * lets the compiler know how much gets clobbered.
> +	 */
> +	volatile struct { char _[64]; } *dst = __dst;
> +
> +	/* movdir64b [rdx], rax */

MOVDIR64B - we usually spell instruction mnemonics in all caps.

> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +			: "=m" (dst)
> +			: "d" (src), "a" (dst));
> +}
> +
> +/**
> + * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
> + * @dst: destination, in MMIO space (must be 512-bit aligned)
> + * @src: source
> + * @count: number of 512 bits quantities to submit
> + *
> + * Submit data from kernel space to MMIO space, in units of 512 bits at a
> + * time.  Order of access is not guaranteed, nor is a memory barrier
> + * performed afterwards.
> + *
> + * Warning: Do not use this helper unless your driver has checked that the CPU
> + * instruction is supported on the platform.
> + */
> +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> +				    size_t count)
> +{
> +	const u8 *from = src;
> +	const u8 *end = from + count * 64;
> +
> +	while (from < end) {
> +		__iowrite512(dst, from);
> +		from += 64;
> +	}
> +}
> +
>  #endif /* _ASM_X86_IO_H */

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
