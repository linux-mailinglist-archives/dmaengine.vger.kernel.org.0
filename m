Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD8150658
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 13:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBCMsK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 07:48:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35697 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBCMsK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 07:48:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so7544426pfg.2;
        Mon, 03 Feb 2020 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p07v49PtEWK6UbUh2LVFZtqDumji1911rjb5hk+Uiv8=;
        b=FW8oF/xj1ohlIFDmU/3cnFQw7i6XkGAidGdY2LclPV+mM8kOY4j2FYA64zdHvx8NcW
         VTx4yXbaIPoc36DmnxaKm9jZx5DZ5SFN/Jv3Y5tL2EIrZxa5jJiiSgUpMy1xpfMZXLYG
         8Y9bmsuU2cDM8gvQV4wS/a2HIHUDYIWbi/T+N1bR7lESdkyDuReASwtEQQkw5w3YGpJY
         VdCy4xj55dBfjezgKykdEho38aVGNlv0NTPoJqmiJpuR3uzlfGJcf+vJntNSgHF3pWib
         AFMXnyluL9priAHPJ4biXf63ObZutZ2IJ/zD25wUXyEiR+WeuL5tkivPVRIGxvEKuZmt
         izXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p07v49PtEWK6UbUh2LVFZtqDumji1911rjb5hk+Uiv8=;
        b=Ig7LAE8OyJFwSZdOzPLtSzevSTp89MGmoxzMHKh0OuYT/vrljaG8YUB4D87qaYhHjP
         lwJqmx1xVDvVxjuELxzeSXyoj3f8D/qIfuk4Ni31aPYlq7M3dGabVzuQdCeokq9KGaN4
         3CYIPyqzXNX77FIVk7xQd9t3Q4S1+3QNwdLVXoAn85iFTDs4XTTe1Vm25yEUb8Gxgjjv
         tQYO1HMgtNMZ98gJWlkASdqFrV2M2KUiTs6YCKfhT8XZIA5Yu1Q7rIQZb8WlvVbsYBmN
         RXKyGWHz0VU+ZNpf7i2tVM3X1JYhA9+DXVC6L9AWaXXw87/42L9B6rPXuTGeay8nJsdH
         U0MA==
X-Gm-Message-State: APjAAAVVmb4Vz12v5HZLuuyjdUvfC93DAqqmgiXG8job/XcZ6lmeDFU9
        mcRjBspjFWvoqTKCFF6UuwYLQqts8j8BgqVOF1w=
X-Google-Smtp-Source: APXvYqzXjtZD005c7kSgyTqpXbdo1LkMDVDE4IVAG/gS70JK5QFhv/RGiKtjjxPKuaO/fi+gSgpJzGkDplJhwVZ5fS0=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr24793753pgb.4.1580734089554;
 Mon, 03 Feb 2020 04:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
In-Reply-To: <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 14:48:01 +0200
Message-ID: <CAHp75VcnxUj88Vb=Fn1WKoiM0h2e8cMvG+e16h8RyerfB6WN6w@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 3, 2020 at 2:09 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/02/2020 13.16, Andy Shevchenko wrote:
> > On Mon, Feb 3, 2020 at 12:59 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 03/02/2020 12.37, Andy Shevchenko wrote:
> >>> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >
> >>>> Advise users of dma_request_slave_channel() and
> >>>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> >>>
> >>> How? There are legacy ARM boards you have to care / remove before.
> >>> DMAengine subsystem makes a p*s off decisions
> >>
> >> The dma_slave_map support is added few years back for the legacy ARM
> >> boards, because we do care.
> >> daVinci, OMAP1, pxa, s3cx4xx and even m68k/coldfire moved over.
> >
> > Then why simple not to convert (start converting) those few drivers to
> > new API and simple remove the old one?
>
> _if_ the dma_request_slave_channel_compat() is really falling back after
> dma_request_chan() - this is what it calls first, then it is not a
> simple convert to a new API.
> 1. The arch needs to define the dma_slave_map for the SoC.
> 2. The dma driver needs few lines to add it to DMAengine core (+pdata
> change).
> After this the _compat() can be replaced with dma_request_chan()
>

> In most cases I do not have access to documentation and boards to test.

So, why everyone with the boards outside of your scope has to suffer?

...

> >> Imho it is confusing to have 4+ APIs to do the same thing, but in a
> >> slightly different way.
> >
> > It was always an excuse by authors "that too many drivers to convert..."
>
> Sure, but before you accuse anyone with neglect, can you check the git
> log for 'dma_request_slave_channel' in the commit messages?

It's good people, and you, are taking care of it, but make user suffer
because somebody wants to call for *developers* is a bad idea. And it
happened not first time in the DMA engine subsystem.

...

> > No, it's a reason when you first take care of existing users and
> > decide to obsolete an API followed by removal few releases later.
>
> I'm fine to drop the pr_info()

Yes, please do.

> and the __deprecated mark for
> dma_request_slave_channel.

This OTOH is for *developers* and its scope won't scary people. So,
it's more or less fine.

> > But
> > I see no reason to keep such APIs at all, so, instead of this
> > *wonderful* messages perhaps somebody should do better work?
>
> To touch the _compat() variant one needs to have access to the
> documentation of the SoC on which the code falls back. It is not a
> matter of sloppy/poor/ignorant/etc work attitude.
> I have kept clear on touching those few drivers using it [1] as I don't
> have documentation.
>
> >> New drivers should not use the old API i new code and developers tend to
> >> pick the API they use after a quick 'git grep dma_request_' and see what
> >> the majority is using.
> >
> > Isn't it a point to do better review rather than scary end users?
>
> Sure, but we rarely CCd on new client drivers for DMAengine API usage.

Linux Next allows people to `git grep -n dma_slave_DO_NOT_CALL` and
tell developers. Isn't it the job good maintainer can do?

> [1] fwiw, there are drivers using dma_request_channel() and by the look
> their use is either _compat() or the dma_request_chan_by_mask() style
> and some even have a twist here and there...

Bottom line, if you need to tell *developers* about something, please
don't bother *end users*.

-- 
With Best Regards,
Andy Shevchenko
