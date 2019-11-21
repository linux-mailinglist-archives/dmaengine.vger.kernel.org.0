Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FD10509E
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 11:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfKUKhl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Nov 2019 05:37:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUKhk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Nov 2019 05:37:40 -0500
Received: from zn.tnic (p200300EC2F0F07006553A4184595DC73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:6553:a418:4595:dc73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56EAC1EC0CE8;
        Thu, 21 Nov 2019 11:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574332659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=my9hQkLlPxW1AW3Gf6LZ+XTRjwwqHQaGN1kMFbCEOqE=;
        b=Lxe4g4WvUvDvhj0e3y9i6X8rFEb/ZwgPwWLV+22CCGmthpcg/8F/AGemWTGZt97D+ZJisu
        TMqjdV8iM/oD7CTpIkXqMARMwe9RztOmT93qV8yoK1AXPakLeaa+VWzXLDzvnkz0KQNuR5
        kbkg6ZBgj+DmK0a7/3FeZqgyjFAlQaY=
Date:   Thu, 21 Nov 2019 11:37:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Jing Lin <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20191121103732.GA6540@zn.tnic>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <20191120232645.GO2634@zn.tnic>
 <CAPcyv4gngO04iWuKu2_DV4_AXw5yssd6njTNKF=eKk+YJw3AfQ@mail.gmail.com>
 <alpine.DEB.2.21.1911210151590.29534@nanos.tec.linutronix.de>
 <CAPcyv4iSv893n_gri+SC42Wcsr8EOGJfuWYUzi3v-fDnGBSriA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4iSv893n_gri+SC42Wcsr8EOGJfuWYUzi3v-fDnGBSriA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 20, 2019 at 05:32:51PM -0800, Dan Williams wrote:
> True, but that would be a driver coding mistake flagged by the
> WARN_ON_ONCE, and the failure is static. The driver must check for
> static_cpu_has(X86_FEATURE_MOVDIR64B) once at init,

So if you do that at driver init time, you don't need the static variant
- simply use boot_cpu_has(). But if this function is going to be used on
other platforms, then you need the check in the function and it must be
static_cpu_has() for speed.

The static_cpu_has() thing is a soft-of once check anyway because it
gets patched by alternatives and after that it is 0 overhead.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
