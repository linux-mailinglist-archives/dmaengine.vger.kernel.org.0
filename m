Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22D543B1FF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJZMMX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 08:12:23 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:37826 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhJZMMS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Oct 2021 08:12:18 -0400
Received: by mail-ua1-f48.google.com with SMTP id f4so28634135uad.4
        for <dmaengine@vger.kernel.org>; Tue, 26 Oct 2021 05:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlXL0oYAWVyUjB2OHBsaA+1QF5bRIUEYkW5xQ1fDeY0=;
        b=jwFWfaxpamYZH2mLOvCR6cLed4X5pPplj8tHHjuKOs+bKQmzSbg0ouY0YHSSS1NGyF
         MtsJvEkh2xwHEtZjuLQ5idikTmQr7PXkG2p0r2esfUq6NyniqTEhjI6LBIw+/0dSqWre
         CH1wBOe8X/5akOKVWGw5pZooAgxbAzp6/k08YUJbLfuiHAg/T/SrqDvY3S/EDaf4vVr+
         bmojTGrH7sWWM4RMvXWRuooWq/zvWb+kpQoF/WB0PsF3X/oVc+q5dP/0KqAmjgGKCEss
         YokVVZGALS30cfQFw70OG2VuAhg8lIkjDEqgYTkj2kCrjcBs0PdRXQJReTLuhZ2h9lik
         IxAw==
X-Gm-Message-State: AOAM532Kp7fUTWg6icseIhiS2zu38b6x3WdBXMe1T4wLbuMgdSBvoyMY
        NWHlXGPff0VCbPsYdaWDrOYrj4gJJ9iDAw==
X-Google-Smtp-Source: ABdhPJzYp2hKB4LKvhDbLKihojSllyMEIHh2IVlw8WTQFJH1TMC8YrLWqZDnKeSFM7dr0axIrg0lFw==
X-Received: by 2002:a67:6c06:: with SMTP id h6mr12246219vsc.9.1635250194252;
        Tue, 26 Oct 2021 05:09:54 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ba22sm2082094vkb.7.2021.10.26.05.09.53
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 05:09:53 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id d130so2344839vke.0
        for <dmaengine@vger.kernel.org>; Tue, 26 Oct 2021 05:09:53 -0700 (PDT)
X-Received: by 2002:a1f:1841:: with SMTP id 62mr22028141vky.26.1635250193576;
 Tue, 26 Oct 2021 05:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211001140812.24977-1-pandith.n@intel.com> <20211001140812.24977-2-pandith.n@intel.com>
In-Reply-To: <20211001140812.24977-2-pandith.n@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 14:09:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWEa+YCXKAjhz7SX7DtSf=dFW8s8vyTfvwq6AuetcMeQ@mail.gmail.com>
Message-ID: <CAMuHMdUWEa+YCXKAjhz7SX7DtSf=dFW8s8vyTfvwq6AuetcMeQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS
 > 8
To:     pandith.n@intel.com
Cc:     Vinod <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com,
        kenchappa.demakkanavar@intel.com,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Zhu <michael.zhu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pandith,

On Fri, Oct 1, 2021 at 4:13 PM <pandith.n@intel.com> wrote:
> From: Pandith N <pandith.n@intel.com>
>
> Added support for DMA controller with more than 8 channels.
> DMAC register map changes based on number of channels.
>
> Enabling DMAC channel:
> DMAC_CHENREG has to be used when number of channels <= 8
> DMAC_CHENREG2 has to be used when number of channels > 8
>
> Configuring DMA channel:
> CHx_CFG has to be used when number of channels <= 8
> CHx_CFG2 has to be used when number of channels > 8
>
> Suspending and resuming channel:
> DMAC_CHENREG has to be used when number of channels <= 8 DMAC_CHSUSPREG
> has to be used for suspending a channel > 8
>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch, which is now commit 824351668a413af7
("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8") in
dmaengine/next.

> ---
> Changes V1-->V2:
> Initialize register values in channel resume and pause Removed unwanted
> braces in flow control setting.
>
> Changes from v2->v3
> check if channel is enabled, before suspending.

I couldn't find these versions in the archive, so I don't know if my
comments below were made before...

> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

> @@ -1120,10 +1150,17 @@ static int dma_chan_pause(struct dma_chan *dchan)
>
>         spin_lock_irqsave(&chan->vc.lock, flags);
>
> -       val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
> -       val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
> -              BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
> -       axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
> +       if (chan->chip->dw->hdata->reg_map_8_channels) {
> +               val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
> +               val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
> +                       BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
> +               axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
> +       } else {
> +               val = 0;

So unlike for the DMAC_CHEN register, you don't have to retain the old
values for the DMAC_CHSUSPREG register?

> +               val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
> +                       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;

Why not "val = BIT(...) | BIT(...)"?

> +               axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
> +       }
>
>         do  {
>                 if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
