Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6B4C27D1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 10:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiBXJPc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 04:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiBXJPb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 04:15:31 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94D27829F;
        Thu, 24 Feb 2022 01:15:01 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id j12so854488vkr.0;
        Thu, 24 Feb 2022 01:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szuPWhHlo/neurh+t83UwTplOjXZknKUszkWMyL4t8E=;
        b=oSKb8s5WRAnL/wDp3ynvy4rpIZdskGTu/bwXy2v0wfQ+N8ytgfNjDg1KcCfUChIsYB
         4RbOXL6y5fXiC/9ZAPSC7zzZUuMZuZ8LpUEGMAH/f0zI3niUrKRrJnitT/zxFfsaFmmt
         thq3Zte2+/QDpB2C3orrsDFENnmpBjFJPFsc0AHXIjiT8zcL3WTygW7vfgw7NGrfc0l7
         qvy3nPosvTPj1+HUVIqNbR0tIrOX/p8wh1dmQVvaOIqXQMBfR/TXWld5JRXLgm3twztk
         a33g5xgTRKTYX6Hgb7khrSVqj7xDwoBwy4KfCo9B6+wTNhiNiYWafyB4hqlYkw3/49RQ
         uFww==
X-Gm-Message-State: AOAM5300xaWpTiHrSP29t16HeeX1YIG6ycWgydzqpmIX1q0WMScA/TS6
        Ck/s2NxVjDr1OTaS0DZTuT2FKHJFt/hKUA==
X-Google-Smtp-Source: ABdhPJyP9x28KDXOrPSp5xM0mk1eV58zO7e0zCfxkByJm7g6E68B04VKQnPa7SLNviwEKpHjdIGOYQ==
X-Received: by 2002:a05:6122:788:b0:331:2063:3645 with SMTP id k8-20020a056122078800b0033120633645mr670147vkr.10.1645694100552;
        Thu, 24 Feb 2022 01:15:00 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id e135sm311635vke.25.2022.02.24.01.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:15:00 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id g18so582372uak.5;
        Thu, 24 Feb 2022 01:14:59 -0800 (PST)
X-Received: by 2002:ab0:6253:0:b0:341:8be9:7a1 with SMTP id
 p19-20020ab06253000000b003418be907a1mr702769uao.114.1645694099810; Thu, 24
 Feb 2022 01:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
 <20220222103437.194779-5-miquel.raynal@bootlin.com> <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
 <20220223174902.3a9b85ea@xps13>
In-Reply-To: <20220223174902.3a9b85ea@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:14:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
Message-ID: <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Wed, Feb 23, 2022 at 5:49 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:46:11 +0100:
> > On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> > > dmamux register located in the system control area which can take up to
> > > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > > two different peripherals.
> > >
> > > We need two additional information from the 'dmas' property: the channel
> > > (bit in the dmamux register) that must be accessed and the value of the
> > > mux for this channel.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/drivers/dma/dw/dmamux.c

> > > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device_node *mux_node = pdev->dev.of_node;
> > > +       const struct of_device_id *match;
> > > +       struct device_node *dmac_node;
> > > +       struct rzn1_dmamux_data *dmamux;
> > > +
> > > +       dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
> > > +       if (!dmamux)
> > > +               return -ENOMEM;
> > > +
> > > +       mutex_init(&dmamux->lock);
> > > +
> > > +       dmac_node = of_parse_phandle(mux_node, "dma-masters", 0);
> > > +       if (!dmac_node)
> > > +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DMA master node\n");
> > > +
> > > +       match = of_match_node(rzn1_dmac_match, dmac_node);
> > > +       if (!match) {
> > > +               of_node_put(dmac_node);
> > > +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
> > > +       }
> > > +
> > > +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dmac_requests)) {
> > > +               of_node_put(dmac_node);
> > > +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC requests information\n");
> > > +       }
> > > +
> > > +       of_node_put(dmac_node);
> >
> > When hardcoding dmac_requests to 16, I guess the whole dmac_node
> > handling can be removed?
>
> Not really, I think the following checks are still valid and fortunate,
> and they need some of_ handling to work properly:
> - verify that the chan requested is within the range of dmac_requests
>   in the _route_allocate() callback
> - ensure the dmamux is wired to a supported DMAC in the DT (this
>   condition might be loosen in the future if needed or dropped entirely
>   if considered useless)
> - I would like to add a check against the number of requests supported
>   by the dmamux and the dmac (not done yet).
> For the record, I've taken inspiration to write these lines on the other
> dma router driver from TI.
>
> Unless, and I know some people think like that, we do not try to
> validate the DT and if the DT is wrong that is none of our business.
>
> >
> > > +
> > > +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dmamux_requests)) {
> >
> > Don't obtain from DT, but fix to 32?
>
> I believe the answer to the previous question should give me a clue
> about why you would prefer hardcoding than reading from the DT such
> an information. Perhaps I should mention that all these properties are
> already part of the bindings, and are not specific to the driver, the
> information will be in the DT anyway.

The 32 is a property of the hardware (32 bits in DMAMUX register).
So IMHO it falls under the "differentiate by compatible value,
not by property" rule.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
