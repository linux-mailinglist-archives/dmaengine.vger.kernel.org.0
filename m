Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99C276F39
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIXLCP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 07:02:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXLCP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 07:02:15 -0400
Received: from zn.tnic (p200300ec2f0c9500edd7635a8c92a40c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:edd7:635a:8c92:a40c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46EE91EC03D2;
        Thu, 24 Sep 2020 13:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600945334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AoWYwBf6behZg5DxLQW8BEn7Q5Lu03q3jtwWp4i/kAI=;
        b=C8WcwHgY9Xm/myNatk7G4U0C12ign5Naua2aw06f5ZoUUwyJ1LedWG4/lE+ptjLO1+HQXh
        OcUtcgMkvE8LKER+HFro/B7wM9YX5qO/DH79TLKJ9imOWw9tXbweffYpmmNOS8eSFFzzSF
        /JCM9pEFZV7cWGjQuFXr/hqCGGrh4Nw=
Date:   Thu, 24 Sep 2020 13:02:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Michael Matz <matz@suse.de>, 'Dave Jiang' <dave.jiang@intel.com>,
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
Message-ID: <20200924110207.GE5030@zn.tnic>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
 <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com>
 <20200924101506.GD5030@zn.tnic>
 <40f740d814764019ac2306800a6b68e4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40f740d814764019ac2306800a6b68e4@AcuMS.aculab.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 24, 2020 at 10:42:16AM +0000, David Laight wrote:
> The movdir64b instruction does a 'normal' read of 64 bytes (can be
> misaligned) Then a cache-bypassing (probably) write-combining single
> 64byte write to an address that must be aligned. Any reference to
> segment registers is largely irrelevant since we are not in real mode.

Sounds like you know better than the SDM.

> Mainly less lines of code to look at.

Yeah, no. Readability is what I would prefer any day of the week.

> No idea what clwb() is doing.

Sounds like you need to read another part of the SDM.

> But the "+m" (dst) tells gcc it depends on, and modifies the 64 bytes
> at *dst.
> 
> I believe the 'volatile' is pointless.

I discussed this at the time with a gcc person. And nope, it ain't
pointless.

> No, that just says the asm uses the value of the pointer.
> Not what it points to.

Err, no, it is *exactly* what it points to that is important here and
you're telling the compiler that the instruction will read that much
memory through the pointer.

Ok, I've read enough babble. I'll discuss it with a gcc person before I
take anything.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
