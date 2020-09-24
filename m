Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B3276E68
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgIXKPQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 06:15:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgIXKPQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 06:15:16 -0400
X-Greylist: delayed 84794 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 06:15:15 EDT
Received: from zn.tnic (p200300ec2f0c9500b3077ed5fae90a35.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:b307:7ed5:fae9:a35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A1761EC037C;
        Thu, 24 Sep 2020 12:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600942514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DXqVO7HVeWlePM1INcUriyOsdG0miN23CY4cZLheeeg=;
        b=KLFUru5ki6EGsGyFSv3QT0IYhdw7z/OYlteFatkBLrGnDNe6F6WF3twRfEA1EtpE+gm531
        f4hC0oKjbJPqsfaMf7V70KmUeZpcOg2gc8bust2Svl4t5R3WtAHPatNeOTk6wKQ25QsXKp
        sEAXxZV//Bz7wTTj468292AzHM6RVRY=
Date:   Thu, 24 Sep 2020 12:15:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Laight <David.Laight@ACULAB.COM>, Michael Matz <matz@suse.de>
Cc:     'Dave Jiang' <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Message-ID: <20200924101506.GD5030@zn.tnic>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
 <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 24, 2020 at 08:24:46AM +0000, David Laight wrote:
> static inline void movdir64b(void *dst, const void *src)
> {
> 	/*
> 	 * 64 bytes from dst are marked as modified for completeness.
> 	 * Since the writes bypass the cache later reads may return
> 	 * old data anyway.
> 	 */
> 	/* MOVDIR64B [rdx], rax */
> 	asm volatile (".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 	     : "=m" ((struct { char _[64];} *)dst),
> 	     : "m" ((struct { char _[64];} *)src), "d" (src), "a" (dst));

Now since you're so generous with your advice on random threads, please
explain what you're advising here?

The destination operand - in this case in %rax - is "destination memory
address specified as offset to ES segment in the register operand."

So what is the difference between:

	...(void *dst, ... )

	volatile struct { char _[64]; } *__dst = dst;

	...

	: "=m" (__dst)
	: "a" (__dst)

and

	...(void *dst, ... )

	...

	: "=m" ((struct { char _[64];} *)dst)
	: "a" (__dst)

and why?

Point me to the gcc documentation where this is explained.

To cut to the chase, I don't think you need to do that, otherwise clwb()
would be broken too but perhaps you know something I don't.

Looking at clwb(), I believe the proper specification should be:

	volatile struct { char _[64]; } *__dst = dst;

	...

	: "+m" (__dst)
	: "a" (__dst)

And if anything, the source specification should be something like that:

	volatile struct { char x[64]; } *__src = src;

	...


	"d" (__src)

because this tells gcc that the source operand would read 64 bytes
through the pointer in the %rdx reg.

So this ends up close to what you're saying but it is using local
variables to make the asm actually readable.

Lemme add Micha to Cc for sanity-checking:

Micha, the instruction is:

MOVDIR64B %(rdx), rax

"Move 64-bytes as direct-store with guaranteed 64-byte write atomicity
from the source memory operand address to destination memory address
specified as offset to ES segment in the register operand."

Do I need to tell gcc that both operands are referencing 64 bytes,
source operand is a memory reference, destination operand is an address
specified in a register?

What we have currently is:

		volatile struct { char _[64]; } *dst = __dst;

                /* MOVDIR64B [rdx], rax */
                asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
                             : "=m" (dst)
                             : "d" (from), "a" (dst));


Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
