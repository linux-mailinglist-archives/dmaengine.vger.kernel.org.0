Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C22104772
	for <lists+dmaengine@lfdr.de>; Thu, 21 Nov 2019 01:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfKUAVS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 19:21:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38259 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUAVS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Nov 2019 19:21:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so1578018oid.5
        for <dmaengine@vger.kernel.org>; Wed, 20 Nov 2019 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InRuHr3W77Nv6V1yM3zDnBudo6+MLUc6w96cK0lUxNw=;
        b=s5RDdIke4ZEiA2L1vbsTbYfPBv2dMoqm5GydLq9nTf3LzpTnkhfaWCPF2sKBg8lHXG
         qXKzFZx44HST5dHAfo3edgvzRZXer+avSJm7T2AS9uVs3NAcSyMZaByGdQEkHyh+cnw0
         mFnzGJMgktA+KpQ2wr3tX8YD2zxXjz6H9NzPSafoY0NLB3RZdz/lvq6vhkZNMfegf9mf
         GBrE77QYoUymGM+8uQQD5Hx6J/bBDtpyjXFvcFH7zotDgZtN2i9WcCfZu24vBFzoSlQ/
         7z99VziPIDrz9+5BgWb+4c+nMM8nPKXtlCBpIRSc5FT/G2xHPS8MPpNLSjlLjKyTRJze
         gSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InRuHr3W77Nv6V1yM3zDnBudo6+MLUc6w96cK0lUxNw=;
        b=UNTsY6kHkkUX7OqgpF+0qfk+P+1gmY/gZkX05X06CjavxJA0Rz6TE06CivPWBUb/GP
         RLcKQLbQAxfTC6FcVLZUQtGuAquCn3A0LdkMxsQXjXVERY3rYudTgNTyJR6xDRukyMQo
         Gx84QRxW4hZHqGyTekMctg/v7p5LHDGEwZaLIpQ/7jZlezQBSA9ryDuFhtL90hlokV7e
         6YbGXCPiF2m7767eFWdyxo5MRXWR2tnlQFpXiBLq7qghz777DDxKrwCwv8RTLOtZgvHl
         Ipf2yeQD85mY/34x1Xn+Q1jzMphG3BX3N9Ru14TUarFdLrl+3yuGOFI7dIlLjWBzq5EP
         7/6w==
X-Gm-Message-State: APjAAAVo3yhRxfuqOnwDRQ+uLs3aFeZY5V89W+UkrbR6nq0dl6khcaVo
        3bpSWooqVEDj8RlR72//0lsDsX3QTKDpeqxQRSKidg==
X-Google-Smtp-Source: APXvYqycfhAdOODIwqfsyZfuQDL7XLgR05P7kMUtARAmo01Rk0YMv7+4vmHRY2LqoIWV2tLkOIkOpZN1HlR2HLdhfgs=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr5016276oih.73.1574295676969;
 Wed, 20 Nov 2019 16:21:16 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 16:21:05 -0800
Message-ID: <CAPcyv4g2uYjqSx3qe6g6PYzVJcRrn3HgsmksV-+vvGm-vLhY9A@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Jing Lin <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 20, 2019 at 3:19 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 10:53:39PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
> > > +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> > > +                               size_t count)
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

I think
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
>
> > Because then you can use alternative_call() and have the thing work
> > regardless of hardware support for MOVDIR*.
> >
> > > +{
> > > +   const u8 *from = src;
> > > +   const u8 *end = from + count * 64;
> > > +
> > > +   if (!cpu_has_write512())
> >
> > If anything, that thing needs to go and you should use
> >
> >   static_cpu_has(X86_FEATURE_MOVDIR64B)
> >
> > as it looks to me like you would care about speed on this fast path?
> > Yes, no?
>
> That might be a better.

It's meant to be identical.

The expectation was that cpu_has_write512() could be used generically
in drivers like the pmem driver that have a use for movdir64b outside
of DSA command submission use case. On x86 it would just be #define'd
to static_cpu_has(X86_FEATURE_MOVDIR64B), on other archs something
else in the future. For pmem if cpu_has_write512() is false it falls
back to talking to platform firmware for error management. Case1 from
the changelog.
