Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7301516AB
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 09:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgBDICI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 03:02:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44017 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgBDICI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 03:02:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so17544249oif.10;
        Tue, 04 Feb 2020 00:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dum+o5gu2gGFpSl+O8wsomQ94Fs2sL9d8ohYuPebAnY=;
        b=ns192hVFZLPa4xwD+cCtN++jd0e7NrjqVwQ2e49oDjaLNhpOUm/Bu5kJ5a4d1lgosZ
         TVlJ/oOUVGyp5LEq+2VxMJRPMh8sLMzj3oi+ms1wJ7GiTdLp0+pop+ISVGvhyPILgUZI
         1k7J2R1U6/1y8Qfqd5XeKpshgkilbPJiOsB32iW8KxoZG4nXFqeG05SceaVXIPGY/1Nz
         GzGWAIHK0r7SXnIGwuSv8BePCNKYWBW3GgPmEkDMWRbx/pUkfK41/5hSbwlqYNnGyg34
         0aDiv+dpr8yazbNJdtwXU2Oefr8FCq/cEo4rJmfe2yjTjSX6QaWZl6X0JwRfCtmGpSsN
         SHnQ==
X-Gm-Message-State: APjAAAUQGwSL/O+4LDLfB9hZmiUtemXsVbAEjPbZVlgohb0erih9g1mw
        9fQg+VLAuAfxF5RtnjkEEqCOhYHg1LjMMX+A7Mg=
X-Google-Smtp-Source: APXvYqzzEX39mrChEWmOwQfxI4cvrJqp32wsemcpmKn2mv1qMu0WlwDSpDrURvjggP7ZnFmlvGoXXaie/JESZoxAYEY=
X-Received: by 2002:a54:4707:: with SMTP id k7mr2486144oik.153.1580803327484;
 Tue, 04 Feb 2020 00:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com> <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com> <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com>
In-Reply-To: <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Feb 2020 09:01:55 +0100
Message-ID: <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
> > On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
> >>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
> >>
> >> FWIW, there is a patch set by Yoshinori Sato to add device tree support
> >> for classical SuperH hardware. It was never merged, unfortunately :(.
> >
> > True.
> >
> >>> Anyone who cares for DMA on SuperH?
> >>
> >> What is DMA used for on SuperH? Wouldn't dropping it cut support for
> >> essential hardware features?
> >
> > It may make a few things slower.
>
> I would not drop DMA support but I would suggest to add dma_slave_map
> for non DT boot so the _compat() can be dropped.

Which is similar in spirit to gpiod_lookup and clk_register_clkdev(),
right?

> Imho on lower spec SoC (and I believe SuperH is) the DMA makes big
> difference offloading data movement from the CPU.

Assumed it is actually used...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
