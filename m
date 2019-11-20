Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94831046EB
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 00:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKTXTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 18:19:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:55062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfKTXTb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 18:19:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 15:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381539125"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 15:19:24 -0800
Date:   Wed, 20 Nov 2019 15:19:23 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, jing.lin@intel.com, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120215338.GN2634@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 20, 2019 at 10:53:39PM +0100, Borislav Petkov wrote:
> On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
> > +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> > +				    size_t count)
> 
> An iosubmit function which returns void and doesn't tell its callers
> whether it succeeded or not? That looks non-optimal to say the least.

That's the underlying functionality of the MOVDIR64B instruction. A
posted write so no way to know if it succeeded. When using dedicated
queues the caller must keep count of how many operations are in flight
and not send more than the depth of the queue.

> Why isn't there a fallback function which to call when the CPU doesn't
> support movdir64b?

This particular driver has no option for fallback. Descriptors can
only be submitted with MOVDIR64B (to dedicated queues ... in later
patch series support for shared queues will be added, but those require
ENQCMD or ENQCMDS to submit).

The driver bails out at the beginning of the probe routine if the
necessary instructions are not supported:

+       /*
+        * If the CPU does not support write512, there's no point in
+        * enumerating the device. We can not utilize it.
+        */
+       if (!cpu_has_write512())
+               return -ENXIO;

Though we should always get past that as this PCI device ID shouldn't
every appear on a system that doesn't have the support. Device is on
the die, not a plug-in card.

> Because then you can use alternative_call() and have the thing work
> regardless of hardware support for MOVDIR*.
> 
> > +{
> > +	const u8 *from = src;
> > +	const u8 *end = from + count * 64;
> > +
> > +	if (!cpu_has_write512())
> 
> If anything, that thing needs to go and you should use
> 
>   static_cpu_has(X86_FEATURE_MOVDIR64B)
> 
> as it looks to me like you would care about speed on this fast path?
> Yes, no?

That might be a better.

-Tony
