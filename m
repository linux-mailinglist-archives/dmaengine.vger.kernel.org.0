Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F368A107789
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 19:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKVSoj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 13:44:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfKVSoj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 13:44:39 -0500
Received: from zn.tnic (p200300EC2F0E9700A48BABEEDD6DAF21.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:a48b:abee:dd6d:af21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7F6F1EC0D17;
        Fri, 22 Nov 2019 19:44:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574448278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i2mjzwfhazpfHjoTpwzg4AZKFO47Z387qbpzjhfHyno=;
        b=UXiFlopsCyXQCA8mhRhahc/KpgFSewAMBSMNZU5wKIV68nkE+nYn+g6K0yoKwZgy/O2IGI
        /yf6KpvgdPZPjTpj+Yr2aMsB1qgahaoHk9EdW82QCGM1lLfWaaEP2rR6GvHm3u0zTxRR5Y
        MXys5Wme4dzOQT6/gDkmffRmnxgYriU=
Date:   Fri, 22 Nov 2019 19:44:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20191122184435.GK6289@zn.tnic>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
 <20191121105913.GB6540@zn.tnic>
 <ef6bc4a4-b307-9bc4-f3be-f7ab7232d303@intel.com>
 <20191122085953.GA6289@zn.tnic>
 <CAPcyv4isyT3FOPARBc8cSANbRWjhAsJrZTkT-fYivPZZJzF=tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4isyT3FOPARBc8cSANbRWjhAsJrZTkT-fYivPZZJzF=tw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 22, 2019 at 09:20:39AM -0800, Dan Williams wrote:
> For those cases the thought would be to have memset512() for case1 and
> __iowrite512_copy() for case3. Where memset512() writes a
> non-incrementing source to an incrementing destination, and
> __iowrite512_copy() copies an incrementing source to an incrementing
> destination. Those 2 helpers *would* have fallbacks, but with the
> option to use something like cpu_has_write512() to check in advance
> whether those routines will fallback, or not.
> 
> That can be a discussion for a future patchset when those users arrive.

Oh, sure, of course.

My only angle is very simple: if the MOVDIR* et al is only supported on
upcoming Intel platforms and looking at the use cases:

1. clear poison/MKTME
3. copy iomem in big chunks

I'm going to venture a guess that those two cases are going to be
happening only on Intel platforms which already support MODVIR*. So
wouldn't really need to do any generic helpers because those use cases
are very specific already. Which would make your feature detection a
one-time, driver-init time thing anyway...

Unless I misunderstand those cases and there really is a use case
where the thing would fallback and the fallback would really be for an
"unenlightened" platform without that MOVDIR* hw support...?

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
