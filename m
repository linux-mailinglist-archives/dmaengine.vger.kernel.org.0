Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF14C2896
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiBXJxB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 04:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiBXJw7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 04:52:59 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E55EBCB;
        Thu, 24 Feb 2022 01:52:30 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id p33so612659uap.8;
        Thu, 24 Feb 2022 01:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgeLEIxBxyudasfEDNt0ZffZmgYSCVMrsrr2/B3rRsw=;
        b=taw73MxMMoeqmmVJE4WtIyXa23C2y0LPulfXegC6j/YHJ984m/SO9aa0WOSNHtThiu
         OgakrCCIrBS/SQgUvKBltuPzd0U90w68Z4e/ce+D+qqKl2K8/l71nOFoqxc6T8OLMo7D
         kDsR23x5pOeNJPN/RzoTvzJIl5E5tK2h7DJ3ZS/VGdfwkrFpSLXJu4CnFzVXGPcTIx3F
         N0pSPDsLdqWNlFD+puFuqJc6Xcx6+VrN4zBoWSDwkDc22UbqYa9fPknihQlh6VbvM1j9
         OTHJFmqF19IHO48ySHc0GWwj9BMOSBKhPPCFKOB64rz4VHRD18DpcuO80UrEXYdw/GzO
         52jw==
X-Gm-Message-State: AOAM530IsKINtuWHm+GIMGQiZ9yb5Ib0FK2OlKH4kpA+rojH6Syz1c03
        cBa2ioNtGbtreEVU7I7HxjRYCMr0ChrdhQ==
X-Google-Smtp-Source: ABdhPJzOlVXslZc6S1UzKHmpquSuOpUH7eYS7vU6ydZb2rS7Q7pNsFHdkhFCr1a9a2t2e/Qc7lAApg==
X-Received: by 2002:ab0:2b8a:0:b0:33c:a7e8:273f with SMTP id q10-20020ab02b8a000000b0033ca7e8273fmr777567uar.129.1645696349103;
        Thu, 24 Feb 2022 01:52:29 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id o11sm322432vsl.0.2022.02.24.01.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:52:28 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id j9so881477vkj.1;
        Thu, 24 Feb 2022 01:52:28 -0800 (PST)
X-Received: by 2002:a05:6122:130c:b0:330:e674:ec91 with SMTP id
 e12-20020a056122130c00b00330e674ec91mr666103vkp.33.1645696348471; Thu, 24 Feb
 2022 01:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
 <20220222103437.194779-5-miquel.raynal@bootlin.com> <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
 <20220223174902.3a9b85ea@xps13> <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
 <20220224102724.74e2c406@xps13>
In-Reply-To: <20220224102724.74e2c406@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:52:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtx5jnyZ0vhCVvM=nTv9H4tD7+g0YTWX8MALc_hR5x4g@mail.gmail.com>
Message-ID: <CAMuHMdWtx5jnyZ0vhCVvM=nTv9H4tD7+g0YTWX8MALc_hR5x4g@mail.gmail.com>
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

On Thu, Feb 24, 2022 at 10:27 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Thu, 24 Feb 2022 10:14:48 +0100:
> > On Wed, Feb 23, 2022 at 5:49 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:46:11 +0100:
> > > > On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > > The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> > > > > dmamux register located in the system control area which can take up to
> > > > > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > > > > two different peripherals.
> > > > >
> > > > > We need two additional information from the 'dmas' property: the channel
> > > > > (bit in the dmamux register) that must be accessed and the value of the
> > > > > mux for this channel.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- /dev/null
> > > > > +++ b/drivers/dma/dw/dmamux.c
> >
> > > > > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct device_node *mux_node = pdev->dev.of_node;
> > > > > +       const struct of_device_id *match;
> > > > > +       struct device_node *dmac_node;
> > > > > +       struct rzn1_dmamux_data *dmamux;
> > > > > +
> > > > > +       dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
> > > > > +       if (!dmamux)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       mutex_init(&dmamux->lock);
> > > > > +
> > > > > +       dmac_node = of_parse_phandle(mux_node, "dma-masters", 0);
> > > > > +       if (!dmac_node)
> > > > > +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DMA master node\n");
> > > > > +
> > > > > +       match = of_match_node(rzn1_dmac_match, dmac_node);
> > > > > +       if (!match) {
> > > > > +               of_node_put(dmac_node);
> > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
> > > > > +       }
> > > > > +
> > > > > +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dmac_requests)) {
> > > > > +               of_node_put(dmac_node);
> > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC requests information\n");
> > > > > +       }
> > > > > +
> > > > > +       of_node_put(dmac_node);
> > > >
> > > > When hardcoding dmac_requests to 16, I guess the whole dmac_node
> > > > handling can be removed?
> > >
> > > Not really, I think the following checks are still valid and fortunate,
> > > and they need some of_ handling to work properly:
> > > - verify that the chan requested is within the range of dmac_requests
> > >   in the _route_allocate() callback
> > > - ensure the dmamux is wired to a supported DMAC in the DT (this
> > >   condition might be loosen in the future if needed or dropped entirely
> > >   if considered useless)
> > > - I would like to add a check against the number of requests supported
> > >   by the dmamux and the dmac (not done yet).
> > > For the record, I've taken inspiration to write these lines on the other
> > > dma router driver from TI.
> > >
> > > Unless, and I know some people think like that, we do not try to
> > > validate the DT and if the DT is wrong that is none of our business.
> > >
> > > >
> > > > > +
> > > > > +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dmamux_requests)) {
> > > >
> > > > Don't obtain from DT, but fix to 32?
> > >
> > > I believe the answer to the previous question should give me a clue
> > > about why you would prefer hardcoding than reading from the DT such
> > > an information. Perhaps I should mention that all these properties are
> > > already part of the bindings, and are not specific to the driver, the
> > > information will be in the DT anyway.
> >
> > The 32 is a property of the hardware (32 bits in DMAMUX register).
> > So IMHO it falls under the "differentiate by compatible value,
> > not by property" rule.
>
> I agree this is a property of the hardware and feels redundant here.
>
> What about the checks below, do you agree with the fact that I should
> keep them or do you prefer dropping them (all? partially?)?

There are no checks below?
/me confused.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
