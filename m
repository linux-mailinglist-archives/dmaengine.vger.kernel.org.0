Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDE106875
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 10:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVJAC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 04:00:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfKVJAC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 04:00:02 -0500
Received: from zn.tnic (p200300EC2F0E97008857C615A913C712.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:8857:c615:a913:c712])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5CDA1EC0CFF;
        Fri, 22 Nov 2019 10:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574413200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xt3eUqUxMoHmDLQQAfp7TrWtxgeicOBhMVygJJdRbFk=;
        b=XIdLPdCS3UbL7AiaHYzRZ6C99+uAYuPyKioP89oKtpSq3u6EEi1XLPU6qJlj1LNeGg3Dem
        b5CuqmwZRrDvl+AJ7Dz2QFAFxnHgkHCY81sp3CJGVUMR3Y9yadCkO7vGLUGqneB+JCZs0l
        0pcHbb8vXdNiPUyaqORE3xZwSyFTlWM=
Date:   Fri, 22 Nov 2019 09:59:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
Message-ID: <20191122085953.GA6289@zn.tnic>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
 <20191121105913.GB6540@zn.tnic>
 <ef6bc4a4-b307-9bc4-f3be-f7ab7232d303@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6bc4a4-b307-9bc4-f3be-f7ab7232d303@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Nov 21, 2019 at 09:52:19AM -0700, Dave Jiang wrote:
> No what I mean was those primitives are missing the checks and we should
> probably address that at some point.

Oh, patches are always welcome! :)

> How would I detect that? Add a size (in bytes) parameter for the total
> source data?

Sure.

So, here's the deal: the more I look at this thing, the more I think
this iosubmit_cmds512() function should not be in a generic header but
in an intel-/driver-specific one. Why?

Well, movdir64b is Intel-only for now, you don't have a fallback
option for the platforms which do not support that insn and it is more
preferential for you to do the feature check once at driver init and
then call the function because you *know* you have movdir64b support
and not have any feature check in the function itself, not even a fast
static_cpu_has() one.

And this way you can do away with alignment and size checks because you
control what your driver does.

If it turns out that this function needs to be shared with other
platforms, then we can consider lifting it into a generic header and
making it more generic.

Ok?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
