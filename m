Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB2275688
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWKmI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKmD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 06:42:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB6C0613CE
        for <dmaengine@vger.kernel.org>; Wed, 23 Sep 2020 03:42:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d1300e5068c8a3292d31d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:e506:8c8a:3292:d31d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 925411EC0409;
        Wed, 23 Sep 2020 12:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600857720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mZ44VK00oyAW9zTeN7/p+FrZ3CRlHQjymafdlc3xK8o=;
        b=L/wQbhB7bwaUyRmOBDJhYFkrEnTmEvJQum8y3w4RbwnwF1lUFwzQvniPc8VfMiKuxAQV2V
        /XJKOThKGtI4/rULGRA/QkKkOb0m2riO8fblOBba5KY6U9AMFKN9TE2Z1VJz0IpK4DpEWM
        9WsSq/09TLxvAqYmpYTfBsVr6qOiH2Q=
Date:   Wed, 23 Sep 2020 12:41:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] x86/asm: move the raw asm in iosubmit_cmds512()
 to special_insns.h
Message-ID: <20200923104158.GG28545@zn.tnic>
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
 <160037731654.3777.18071122574577972463.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160037731654.3777.18071122574577972463.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Subject: Re: [PATCH v4 1/5] x86/asm: move the raw asm in iosubmit_cmds512() to special_insns.h

Start patch name with a capital letter: "Move the asm definition.."

Also, calling stuff "raw" and "core" is misleading in the kernel context
- you wanna say simply: "Carve out a generic movdir64b() helper... "

On Thu, Sep 17, 2020 at 02:15:16PM -0700, Dave Jiang wrote:
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 59a3e13204c3..7bc8e714f37e 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -234,6 +234,23 @@ static inline void clwb(volatile void *__p)
>  
>  #define nop() asm volatile ("nop")
>  
> +static inline void movdir64b(void *__dst, const void *src)

Make __dst be the function local variable name and keep "dst", i.e.,
without the underscores, the function parameter name.

> +	/*
> +	 * Note that this isn't an "on-stack copy", just definition of "dst"
> +	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
> +	 * In the MOVDIR64B case that may be needed as you can use the
> +	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
> +	 * lets the compiler know how much gets clobbered.
> +	 */
> +	volatile struct { char _[64]; } *dst = __dst;
> +
> +	/* MOVDIR64B [rdx], rax */
> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +		     : "=m" (dst)
> +		     : "d" (src), "a" (dst));
> +}
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* _ASM_X86_SPECIAL_INSNS_H */
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
