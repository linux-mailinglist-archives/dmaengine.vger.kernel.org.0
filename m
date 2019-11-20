Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53465104629
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfKTVxq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:53:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVxq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:53:46 -0500
Received: from zn.tnic (p200300EC2F0D8C00A5DC709D5356F6BE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:a5dc:709d:5356:f6be])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B16D1EC0CD7;
        Wed, 20 Nov 2019 22:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574286825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hi1ocuIZqlQuBhdEumiMdnWXbr5x8UGqHlC/LzzQczM=;
        b=MI5jPWwwOMYBOtLTyKpwSu/Ef5JWWM00DRdPg55bPo+misaiWFefs1OpWYkbC60Z9zk4ta
        EKSOgKy1MDXdTJHSB6RejWRLZlMtLl0DMFZi6CEibY9ZdSnZB5L5nD8sy2b414uuP9CgxV
        qipE8HaSd2gjP6avM1NHBjcKPT5RCvU=
Date:   Wed, 20 Nov 2019 22:53:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com, tony.luck@intel.com,
        jing.lin@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        axboe@kernel.dk, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20191120215338.GN2634@zn.tnic>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
> +/**
> + * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units

Where is the alignment check on that data before doing the copying?

> + * @dst: destination, in MMIO space (must be 512-bit aligned)
> + * @src: source
> + * @count: number of 512 bits quantities to submit

Where's that check on the data?

> + *
> + * Submit data from kernel space to MMIO space, in units of 512 bits at a
> + * time.  Order of access is not guaranteed, nor is a memory barrier
> + * performed afterwards.
> + */
> +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> +				    size_t count)

An iosubmit function which returns void and doesn't tell its callers
whether it succeeded or not? That looks non-optimal to say the least.

Why isn't there a fallback function which to call when the CPU doesn't
support movdir64b?

Because then you can use alternative_call() and have the thing work
regardless of hardware support for MOVDIR*.

> +{
> +	const u8 *from = src;
> +	const u8 *end = from + count * 64;
> +
> +	if (!cpu_has_write512())

If anything, that thing needs to go and you should use

  static_cpu_has(X86_FEATURE_MOVDIR64B)

as it looks to me like you would care about speed on this fast path?
Yes, no?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
