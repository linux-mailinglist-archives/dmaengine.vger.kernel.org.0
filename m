Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2103A4C2B7F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiBXMQx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 07:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiBXMQw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 07:16:52 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDC52325E0;
        Thu, 24 Feb 2022 04:16:22 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id d11so1898342vsm.5;
        Thu, 24 Feb 2022 04:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9klOtGIegRZ7rKwwt1H5qZSXqDy38qXRG5ldgMZILY=;
        b=CHtPaiZBR0Kaqk4J7Wn9Z4kRlS3qp/uc2Y4rMQkPuGnaK0lghVOH0vmES9Vn7icWCU
         c9Ba2P6IAwYjH0fVkt+TvXPlY6sOSf/nTLyqShiTtMDFPhvrOwBRg/AMVtNjR/5GYQXd
         litwshH4HE3adaq1iKOGRKKIrH/01qRXzRye/fERfs7fie/+n8P1ABvbjKHQzQ/aZHlD
         utGZ2GbvnXpl/X3UbMWI06aMbC20KJ7masz4v5ZzMZ0xUiFApc2sSHbSCqBuASQ6vhgI
         RPTtm8ADdNc017zBsU11nwIA2A3PpJ1+oyEetEZeZlB9a2NzAwplVbLy5ezqzWJuyXHl
         xp4g==
X-Gm-Message-State: AOAM531LE6xaGtLWXEx5BXhgKII3j1UlZdhcRq7GrauKkPmJ4n14pBfw
        gqKHHOIY0QNgwS+9cuv+Dq3z1RNLLno8bg==
X-Google-Smtp-Source: ABdhPJwb8b/HnjBl+TO6YfuCgXhZu1YZvv9hvAp3LbnUXQBkC4ppBKiEobr4QE1n45xCmeyPwYZSig==
X-Received: by 2002:a67:d81e:0:b0:31b:a09a:1c4d with SMTP id e30-20020a67d81e000000b0031ba09a1c4dmr1010814vsj.0.1645704981580;
        Thu, 24 Feb 2022 04:16:21 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id l35sm349485uac.7.2022.02.24.04.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 04:16:21 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id 60so791952uae.1;
        Thu, 24 Feb 2022 04:16:21 -0800 (PST)
X-Received: by 2002:a9f:360f:0:b0:341:8a12:8218 with SMTP id
 r15-20020a9f360f000000b003418a128218mr916874uad.14.1645704980847; Thu, 24 Feb
 2022 04:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
 <20220222103437.194779-5-miquel.raynal@bootlin.com> <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
 <20220223174902.3a9b85ea@xps13> <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
 <20220224102724.74e2c406@xps13> <CAMuHMdWtx5jnyZ0vhCVvM=nTv9H4tD7+g0YTWX8MALc_hR5x4g@mail.gmail.com>
 <20220224123620.02740e8c@xps13>
In-Reply-To: <20220224123620.02740e8c@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 13:16:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWofNo5aCZscADc_LuQjzDb7YoQhZS736d7_hrswdY5DA@mail.gmail.com>
Message-ID: <CAMuHMdWofNo5aCZscADc_LuQjzDb7YoQhZS736d7_hrswdY5DA@mail.gmail.com>
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

On Thu, Feb 24, 2022 at 12:36 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> > > > > > > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +       struct device_node *mux_node = pdev->dev.of_node;
> > > > > > > +       const struct of_device_id *match;
> > > > > > > +       struct device_node *dmac_node;
> > > > > > > +       struct rzn1_dmamux_data *dmamux;
> > > > > > > +
> > > > > > > +       dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
> > > > > > > +       if (!dmamux)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       mutex_init(&dmamux->lock);
> > > > > > > +
> > > > > > > +       dmac_node = of_parse_phandle(mux_node, "dma-masters", 0);
> > > > > > > +       if (!dmac_node)
> > > > > > > +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DMA master node\n");
> > > > > > > +
> > > > > > > +       match = of_match_node(rzn1_dmac_match, dmac_node);
> > > > > > > +       if (!match) {
> > > > > > > +               of_node_put(dmac_node);
> > > > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dmac_requests)) {
> > > > > > > +               of_node_put(dmac_node);
> > > > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC requests information\n");
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       of_node_put(dmac_node);
> > > > > >
> > > > > > When hardcoding dmac_requests to 16, I guess the whole dmac_node
> > > > > > handling can be removed?
> > > > >
> > > > > Not really, I think the following checks are still valid and fortunate,
> > > > > and they need some of_ handling to work properly:
> > > > > - verify that the chan requested is within the range of dmac_requests
> > > > >   in the _route_allocate() callback
> > > > > - ensure the dmamux is wired to a supported DMAC in the DT (this
> > > > >   condition might be loosen in the future if needed or dropped entirely
> > > > >   if considered useless)
> > > > > - I would like to add a check against the number of requests supported
> > > > >   by the dmamux and the dmac (not done yet).
> > > > > For the record, I've taken inspiration to write these lines on the other
> > > > > dma router driver from TI.
>
>         ^^^^^^^^^^^
> ... these checks

I don't know. Some of them will be checked when calling into the
parent DMAC, right?

>
> > > > >
> > > > > Unless, and I know some people think like that, we do not try to
> > > > > validate the DT and if the DT is wrong that is none of our business.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dmamux_requests)) {
> > > > > >
> > > > > > Don't obtain from DT, but fix to 32?
> > > > >
> > > > > I believe the answer to the previous question should give me a clue
> > > > > about why you would prefer hardcoding than reading from the DT such
> > > > > an information. Perhaps I should mention that all these properties are
> > > > > already part of the bindings, and are not specific to the driver, the
> > > > > information will be in the DT anyway.
> > > >
> > > > The 32 is a property of the hardware (32 bits in DMAMUX register).
> > > > So IMHO it falls under the "differentiate by compatible value,
> > > > not by property" rule.
> > >
> > > I agree this is a property of the hardware and feels redundant here.
> > >
> > > What about the checks below, do you agree with the fact that I should
> > > keep them or do you prefer dropping them (all? partially?)?
> >
> > There are no checks below?
>
> I meant above /o\ ...


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
