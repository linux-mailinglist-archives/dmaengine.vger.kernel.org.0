Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847DE495BF9
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbiAUIdc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 03:33:32 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:35584 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiAUIdc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jan 2022 03:33:32 -0500
Received: by mail-ua1-f52.google.com with SMTP id m90so15643527uam.2;
        Fri, 21 Jan 2022 00:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n56f2PNNQdieA9k1jX9tvG8Cwk+6C0TIvBu9rWE3i4o=;
        b=QbQBhVon6CGgyVP4NfdQD6+d63EVSsCSNxREo0BDwJj6wdoyQ3fKqdwaP0In9I99Bw
         /fKlfdC3atQEJ0xkBsY5/Q/DUUG6NHdF2v0kHnLPOXfVtLgFWqyyJsfRZVkPWhrKodlC
         j2A05Jgl9zpMJL8+bdbZqfm4gSWrd5Jc7XvUHYRbBQb7HOMrFG4vH5YxXGNuAdQPou/0
         mXTMNLwZEZnV14eW7EWyk1uRwBwPQVywwx4v2+zsEN+9RvcfwxitFB/biaiILVroUMXN
         ovbWoFQxPjQQwYvgQRBBGMMckazQKMFxEYUtKR+rJc40gxY4cL3OfzIIdzxKQqsZ+Pvb
         QmPg==
X-Gm-Message-State: AOAM533FSRNGyz5B9poHPL1QhY+lck3tla30C0kICpEWH+9v+C0PvLy+
        LZV25YP4G+BUY1WFN593ryIZoYyr0UvmVQ==
X-Google-Smtp-Source: ABdhPJypt9cmefiwLeDdEsItwAFhWRMiubZQNDRBH1LY5vjk3S/ZCjDW1jCGAafFx3v+soBoYZxZJQ==
X-Received: by 2002:a67:e014:: with SMTP id c20mr1202803vsl.21.1642754011241;
        Fri, 21 Jan 2022 00:33:31 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id g190sm1196346vke.11.2022.01.21.00.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 00:33:30 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 19so5132508vkl.2;
        Fri, 21 Jan 2022 00:33:30 -0800 (PST)
X-Received: by 2002:a1f:5702:: with SMTP id l2mr1220320vkb.33.1642754010512;
 Fri, 21 Jan 2022 00:33:30 -0800 (PST)
MIME-Version: 1.0
References: <0d0b0a3ad703f5ef50611e2dd80439675bda666a.1642383007.git.zong.li@sifive.com>
 <mhng-5b3e2596-3558-4534-9229-26885ee4cc5c@palmer-ri-x1c9> <CANXhq0ruGxjO0WPUipzZ7QQM1oEapyHAvb_aVQ_CMqVxbjc_BQ@mail.gmail.com>
In-Reply-To: <CANXhq0ruGxjO0WPUipzZ7QQM1oEapyHAvb_aVQ_CMqVxbjc_BQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 09:33:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVh_cXpbUeOmr_1K0dOJwGHSO0Ao=W43j5mpgvOiNyV9w@mail.gmail.com>
Message-ID: <CAMuHMdVh_cXpbUeOmr_1K0dOJwGHSO0Ao=W43j5mpgvOiNyV9w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Zong, Palmer,

On Fri, Jan 21, 2022 at 3:21 AM Zong Li <zong.li@sifive.com> wrote:
> On Fri, Jan 21, 2022 at 2:52 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Sun, 16 Jan 2022 17:35:28 PST (-0800), zong.li@sifive.com wrote:
> > > It currently assumes that there are always four channels, it would
> > > cause the error if there is actually less than four channels. Change
> > > that by getting number of channel from device tree.
> > >
> > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > is no 'dma-channels' information in dts.
> >
> > Some of the same wording issues here as those I pointed out in the DT
> > bindings patch.
> >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>

> > > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > > @@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
> > >  static int sf_pdma_probe(struct platform_device *pdev)
> > >  {
> > >       struct sf_pdma *pdma;
> > > -     struct sf_pdma_chan *chan;
> > >       struct resource *res;
> > > -     int len, chans;
> > >       int ret;
> > >       const enum dma_slave_buswidth widths =
> > >               DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> > > @@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
> > >               DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> > >               DMA_SLAVE_BUSWIDTH_64_BYTES;
> > >
> > > -     chans = PDMA_NR_CH;
> > > -     len = sizeof(*pdma) + sizeof(*chan) * chans;
> > > -     pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> > > +     pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
> > >       if (!pdma)
> > >               return -ENOMEM;
> > >
> > > -     pdma->n_chans = chans;
> > > +     ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > > +                                &pdma->n_chans);
> > > +     if (ret) {
> > > +             dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> > > +             pdma->n_chans = PDMA_MAX_NR_CH;
> > > +     }
> > > +
> > > +     if (pdma->n_chans > PDMA_MAX_NR_CH) {
> > > +             dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
> > > +             return -EINVAL;
> >
> > Can we get away with just using only the number of channels the driver
> > actually supports?  ie, just never sending an op to the channels above
> > MAX_NR_CH?  That should leave us with nothing to track.

In theory we can...

> It might be a bit like when pdma->n_chans is bigger than the maximum,
> set the pdma->chans to PDMA_MAX_NR_CH, then we could ensure that we
> don't access the channels above the maximum. If I understand
> correctly, I gave the similar thought in the thread of v2 patch, and
> there are some discussions on that, but this way seems to lead to
> hard-to-track problems.

... but that would mean that when a new variant appears that supports
more channels, no error is printed, and people might not notice
immediately that the higher channels are never used.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
