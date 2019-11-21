Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA01047B9
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 01:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUAxP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 19:53:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAxP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Nov 2019 19:53:15 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXaie-0001UQ-Ct; Thu, 21 Nov 2019 01:53:12 +0100
Date:   Thu, 21 Nov 2019 01:53:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
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
In-Reply-To: <CAPcyv4gngO04iWuKu2_DV4_AXw5yssd6njTNKF=eKk+YJw3AfQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911210151590.29534@nanos.tec.linutronix.de>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com> <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com> <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <20191120232645.GO2634@zn.tnic> <CAPcyv4gngO04iWuKu2_DV4_AXw5yssd6njTNKF=eKk+YJw3AfQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 20 Nov 2019, Dan Williams wrote:
> On Wed, Nov 20, 2019 at 3:27 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Nov 20, 2019 at 03:19:23PM -0800, Luck, Tony wrote:
> > > That's the underlying functionality of the MOVDIR64B instruction. A
> > > posted write so no way to know if it succeeded.
> >
> > So how do you know whether any of the writes went through?
> 
> It's identical to the writel() mmio-write to start a SATA command
> transfer. The higher level device driver protocol validates that the
> command went through, ultimately with a timeout. There's no return
> value for iosubmit_cmds512() for the same reason there's no return
> value for the other iowrite primitives.

With the difference that other iowrite primitive have no dependencies on
cpu feature bits and cannot fail on the software level.

Thanks,

	tglx

