Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE1104774
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 01:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUAWs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 19:22:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAWr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Nov 2019 19:22:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXaF9-0001CB-1h; Thu, 21 Nov 2019 01:22:43 +0100
Date:   Thu, 21 Nov 2019 01:22:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck, Tony" <tony.luck@intel.com>
cc:     Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, dan.j.williams@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, mingo@redhat.com, fenghua.yu@intel.com,
        hpa@zytor.com
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
In-Reply-To: <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1911210120410.29534@nanos.tec.linutronix.de>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com> <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com> <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
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

On Wed, 20 Nov 2019, Luck, Tony wrote:
> On Wed, Nov 20, 2019 at 10:53:39PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
> > > +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> > > +				    size_t count)
> > 
> > An iosubmit function which returns void and doesn't tell its callers
> > whether it succeeded or not? That looks non-optimal to say the least.
> 
> That's the underlying functionality of the MOVDIR64B instruction. A
> posted write so no way to know if it succeeded. When using dedicated
> queues the caller must keep count of how many operations are in flight
> and not send more than the depth of the queue.
> 
> > Why isn't there a fallback function which to call when the CPU doesn't
> > support movdir64b?
> 
> This particular driver has no option for fallback. Descriptors can
> only be submitted with MOVDIR64B (to dedicated queues ... in later
> patch series support for shared queues will be added, but those require
> ENQCMD or ENQCMDS to submit).
> 
> The driver bails out at the beginning of the probe routine if the
> necessary instructions are not supported:
> 
> +       /*
> +        * If the CPU does not support write512, there's no point in
> +        * enumerating the device. We can not utilize it.
> +        */
> +       if (!cpu_has_write512())
> +               return -ENXIO;
> 
> Though we should always get past that as this PCI device ID shouldn't
> every appear on a system that doesn't have the support. Device is on
> the die, not a plug-in card.

Then the condition in the iosubmit function is just prone to silently paper
over any bug in a driver:

> +       if (!cpu_has_write512())
> +               return;

This should at least issue a WARN_ON_ONCE()

Thanks,

	tglx
