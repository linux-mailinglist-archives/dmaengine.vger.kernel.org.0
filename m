Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB924C2B05
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiBXLg6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 06:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiBXLg5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 06:36:57 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6C29A549;
        Thu, 24 Feb 2022 03:36:25 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B6E6F100004;
        Thu, 24 Feb 2022 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645702584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLhjYbXeZP/7sHaaf5jCo45XaOnT58BV5y0fnJ9Ge/Y=;
        b=acHxcqFtwxrYxmnUU3d3kLDGXmnpAOTU+wLlurAFYvEsa35Xrjb2twvtTclOOUUuRzAdsi
        OH7yYOB/eD4i/XmAH7tqZrIEQExI4hS5AyBBUK+uNtb+k4FFWDgVhx71lGhiqxGYGo4tje
        xgQjIFPKWbyzKSXmdinLjQlCVqEG+t/6596HOcFuJPindVg6IaqwkSdOgZZi0YDTwyaoTj
        O3hvQWal2/QzIFc2dnoLS5RqbgGJ0KuUgkorRWrG0BOT+sFHRkc+jcc8fXQDUijyMD94YN
        DO+ETv2Hi64HoNn5RC/NzyUDo+2d5iquxRWRalBP/Q+3y1uB74ZhhyfcIo/4tQ==
Date:   Thu, 24 Feb 2022 12:36:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <20220224123620.02740e8c@xps13>
In-Reply-To: <CAMuHMdWtx5jnyZ0vhCVvM=nTv9H4tD7+g0YTWX8MALc_hR5x4g@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-5-miquel.raynal@bootlin.com>
        <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
        <20220223174902.3a9b85ea@xps13>
        <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
        <20220224102724.74e2c406@xps13>
        <CAMuHMdWtx5jnyZ0vhCVvM=nTv9H4tD7+g0YTWX8MALc_hR5x4g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

> > > > > > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +       struct device_node *mux_node = pdev->dev.of_node;
> > > > > > +       const struct of_device_id *match;
> > > > > > +       struct device_node *dmac_node;
> > > > > > +       struct rzn1_dmamux_data *dmamux;
> > > > > > +
> > > > > > +       dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
> > > > > > +       if (!dmamux)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       mutex_init(&dmamux->lock);
> > > > > > +
> > > > > > +       dmac_node = of_parse_phandle(mux_node, "dma-masters", 0);
> > > > > > +       if (!dmac_node)
> > > > > > +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DMA master node\n");
> > > > > > +
> > > > > > +       match = of_match_node(rzn1_dmac_match, dmac_node);
> > > > > > +       if (!match) {
> > > > > > +               of_node_put(dmac_node);
> > > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
> > > > > > +       }
> > > > > > +
> > > > > > +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dmac_requests)) {
> > > > > > +               of_node_put(dmac_node);
> > > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC requests information\n");
> > > > > > +       }
> > > > > > +
> > > > > > +       of_node_put(dmac_node);  
> > > > >
> > > > > When hardcoding dmac_requests to 16, I guess the whole dmac_node
> > > > > handling can be removed?  
> > > >
> > > > Not really, I think the following checks are still valid and fortunate,
> > > > and they need some of_ handling to work properly:
> > > > - verify that the chan requested is within the range of dmac_requests
> > > >   in the _route_allocate() callback
> > > > - ensure the dmamux is wired to a supported DMAC in the DT (this
> > > >   condition might be loosen in the future if needed or dropped entirely
> > > >   if considered useless)
> > > > - I would like to add a check against the number of requests supported
> > > >   by the dmamux and the dmac (not done yet).
> > > > For the record, I've taken inspiration to write these lines on the other
> > > > dma router driver from TI.

        ^^^^^^^^^^^
... these checks

> > > >
> > > > Unless, and I know some people think like that, we do not try to
> > > > validate the DT and if the DT is wrong that is none of our business.
> > > >  
> > > > >  
> > > > > > +
> > > > > > +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dmamux_requests)) {  
> > > > >
> > > > > Don't obtain from DT, but fix to 32?  
> > > >
> > > > I believe the answer to the previous question should give me a clue
> > > > about why you would prefer hardcoding than reading from the DT such
> > > > an information. Perhaps I should mention that all these properties are
> > > > already part of the bindings, and are not specific to the driver, the
> > > > information will be in the DT anyway.  
> > >
> > > The 32 is a property of the hardware (32 bits in DMAMUX register).
> > > So IMHO it falls under the "differentiate by compatible value,
> > > not by property" rule.  
> >
> > I agree this is a property of the hardware and feels redundant here.
> >
> > What about the checks below, do you agree with the fact that I should
> > keep them or do you prefer dropping them (all? partially?)?  
> 
> There are no checks below?

I meant above /o\ ...

> /me confused.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

