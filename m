Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833982756D7
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIWLIq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWLIp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 07:08:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909BFC0613CE;
        Wed, 23 Sep 2020 04:08:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d13006bfbbaac21a5376c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:6bfb:baac:21a5:376c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBF6C1EC0445;
        Wed, 23 Sep 2020 13:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600859324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8IZo3CWRXJtiTiLfrNSgkG9waQamx4FDxHZUEDGYM8=;
        b=Vz2sK9dO9MXnh7NRaaeCAITabzPj8R505yEKcROShGBtiARdVsSwwW3dAGYhGDD6gXqcY0
        aRxFYByKrTAWcwOGM8rur0sqoMNQwDqoJEpyodRqRsE+X6kFHZydPkkI28Ej0kD3PvNads
        k6/KOxg37lv62T7IZFbAEDvjq3O5DEE=
Date:   Wed, 23 Sep 2020 13:08:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] x86/asm: add enqcmds() to support ENQCMDS
 instruction
Message-ID: <20200923110837.GH28545@zn.tnic>
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
 <160037732334.3777.8083106831110728138.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <160037732334.3777.8083106831110728138.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 17, 2020 at 02:15:23PM -0700, Dave Jiang wrote:
> Add enqcmds() in x86 io.h instead of special_insns.h.

Why? It is an asm wrapper for a special instruction.

> MOVDIR64B
> instruction can be used for other purposes. A wrapper was introduced
> in io.h for its command submission usage. ENQCMDS has a single
> purpose of submit 64-byte commands to supported devices and should
> be called directly.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/io.h |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index d726459d08e5..b7af0bf8a018 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -424,4 +424,33 @@ static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
>  	}
>  }
>  
> +/**
> + * enqcmds - copy a 512 bits data unit to single MMIO location

Your #319433 doc says

"ENQCMDS — Enqueue Command Supervisor"

Now *how* that enqueueing is done you can explain in the comment below.

> + * @dst: destination, in MMIO space (must be 512-bit aligned)
> + * @src: source
> + *
> + * Submit data from kernel space to MMIO space, in a unit of 512 bits.
> + * Order of data access is not guaranteed, nor is a memory barrier
> + * performed afterwards. The command returns false (0) on failure, and true (1)
> + * on success.

The command or the function?

From what I see below, the instruction sets ZF=1 to denote that it needs
to be retried and ZF=0 means success, as the doc says. And in good UNIX
tradition, 0 means usually success and !0 failure.

So why are you flipping that?

> + * Warning: Do not use this helper unless your driver has checked that the CPU
> + * instruction is supported on the platform.
> + */
> +static inline bool enqcmds(void __iomem *dst, const void *src)
> +{
> +	bool retry;
> +
> +	/* ENQCMDS [rdx], rax */
> +	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90\t\n"
								    ^^^^
No need for those last two chars.

> +		     CC_SET(z)
> +		     : CC_OUT(z) (retry)
> +		     : "a" (dst), "d" (src));

<---- newline here.

> +	/* Submission failure is indicated via EFLAGS.ZF=1 */
> +	if (retry)
> +		return false;
> +
> +	return true;
> +}
> +
>  #endif /* _ASM_X86_IO_H */

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
