Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56FD2771D0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 15:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIXNHz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIXNHz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 09:07:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C37C0613CE;
        Thu, 24 Sep 2020 06:07:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c9500832c6260210b2089.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:832c:6260:210b:2089])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 347BE1EC03F0;
        Thu, 24 Sep 2020 15:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600952873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pPCkHSTlJNBGoTx2iGF/ZWSi//3FBF/3q6vcbe65064=;
        b=XR25InTP1OiI7NkNDQQAy4UHFpR73tQOozoongeAVPC/jth/KYFbj/ZVQcUEYCSQMo7Kye
        UZ+g0IEr3tr1r47iw7CRW905bstbdVlMJm5DTxI75CuYCHllptBfRLPgGu43/Trd/M+LUz
        PxFPgOjItb1fbKKmne2+XV3Td7mkk4s=
Date:   Thu, 24 Sep 2020 15:07:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@ACULAB.COM, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: Re: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Message-ID: <20200924130746.GF5030@zn.tnic>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 23, 2020 at 04:10:43PM -0700, Dave Jiang wrote:
> +/* The dst parameter must be 64-bytes aligned */
> +static inline void movdir64b(void *dst, const void *src)
> +{
> +	/*
> +	 * Note that this isn't an "on-stack copy", just definition of "dst"
> +	 * as a pointer to 64-bytes of stuff that is going to be overwritten.
> +	 * In the MOVDIR64B case that may be needed as you can use the
> +	 * MOVDIR64B instruction to copy arbitrary memory around. This trick
> +	 * lets the compiler know how much gets clobbered.
> +	 */
> +	volatile struct { char _[64]; } *__dst = dst;
> +
> +	/* MOVDIR64B [rdx], rax */
> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +		     :
> +		     : "m" (*(struct { char _[64];} **)src), "a" (__dst)
> +		     : "memory");
> +}

Ok, Micha and I hashed it out on IRC, here's what you do. Please keep
the comments too because we will forget soon again.

static inline void movdir64b(void *__dst, const void *src)
{
	struct { char _[64]; } *__src = src;
	struct { char _[64]; } *__dst = dst;

	/*
	 * MOVDIR64B %(rdx), rax.
	 *
	 * Both __src and __dst must be memory constraints in order to tell the
	 * compiler that no other memory accesses should be reordered around
	 * this one.
	 *
	 * Also, both must be supplied as lvalues because this tells
	 * the compiler what the object is (its size) the instruction accesses.
	 * I.e., not the pointers but what they point, thus the deref'ing '*'.
	 */
	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
		     : "+m" (*__dst)
		     :  "m" (*__src), "a" (__dst), "d" (__src));
}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
