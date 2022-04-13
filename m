Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF64FF15A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiDMIIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 04:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiDMIIR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 04:08:17 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462E2C667;
        Wed, 13 Apr 2022 01:05:56 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id x20so1017725qvl.10;
        Wed, 13 Apr 2022 01:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eShz8c4bu7O4JS8en3GZmmUYK1gOC/MkNa7sLyDYepI=;
        b=VIwvexumHEqGkbJbLA8rQfDTDbow32/ok5xtJcY5FFQ5wjjonEafgAQqnq3nP2PBwX
         duCj+pgw/I7/yqDm57no/NtBWf1E0fhCeRe6hZqlcTlDE2MwUI5DTWkshySfUH0gaHZr
         QbuI/6uacZO4GyrMeZyCaMfDCsp92NvXdswwAk0JGthFZLDX6dIkj+roOxGOzhltKe+Q
         oK7DmMRPWJ+X4s/h0a/rwb3eaWl8vdfv2vXgpNv0QOiZOW4LUTbsLJPWb2br468IxdZY
         VVUFNIT1c4QPmk/FzsSIP1eW4XVEc8MV/GKyTlYF+00DulQVQKt1YemYCFyudWEwUCJl
         /YZw==
X-Gm-Message-State: AOAM531DXfPpSAuQVYpDmLKTcREW0QfijRMnadSObsMj4qXWJdbi/F2U
        xDHQ+kAZPly+YKUhyj71NeE1OtKY+dYgFw==
X-Google-Smtp-Source: ABdhPJxVlRbM2XckZYyQcyukOtCCqPD2RXY1rCLUn68L4gujAbrEnS/GoifWwlIkD8+vKaF7ICtHug==
X-Received: by 2002:a05:6214:e4f:b0:442:88d4:ecc0 with SMTP id o15-20020a0562140e4f00b0044288d4ecc0mr34730109qvc.47.1649837155669;
        Wed, 13 Apr 2022 01:05:55 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm29430074qtd.24.2022.04.13.01.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:05:54 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ec05db3dfbso13435817b3.7;
        Wed, 13 Apr 2022 01:05:54 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr12482102ywb.256.1649837154173; Wed, 13
 Apr 2022 01:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
 <20220412193936.63355-6-miquel.raynal@bootlin.com> <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
 <20220413100026.73e11004@xps13>
In-Reply-To: <20220413100026.73e11004@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 10:05:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3pEX3oGoHQ71cm7m0DpguJOqpOTq4_kfAxD98XN325A@mail.gmail.com>
Message-ID: <CAMuHMdU3pEX3oGoHQ71cm7m0DpguJOqpOTq4_kfAxD98XN325A@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 10:00 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Wed, 13 Apr 2022 09:53:09 +0200:
> > On Tue, Apr 12, 2022 at 9:39 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
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
> > > +++ b/drivers/dma/dw/rzn1-dmamux.c
> > > @@ -0,0 +1,160 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2022 Schneider-Electric
> > > + * Author: Miquel Raynal <miquel.raynal@bootlin.com
> > > + * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > + */
> > > +#include <linux/bitops.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_dma.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> > > +#include <linux/types.h>
> > > +
> > > +#define RNZ1_DMAMUX_NCELLS 6
> > > +#define RZN1_DMAMUX_LINES 64
> > > +#define RZN1_DMAMUX_MAX_LINES 16
> > > +
> > > +struct rzn1_dmamux_data {
> > > +       struct dma_router dmarouter;
> > > +       unsigned long *used_chans;
> >
> > Why a pointer?
> >
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
> > > +       dmamux->used_chans = devm_bitmap_zalloc(&pdev->dev, 2 * RZN1_DMAMUX_MAX_LINES,
> > > +                                               GFP_KERNEL);
> >
> > ... Oh, you want to allocate the bitmap separately, although you
> > know it's just a single long.
> >
> > You might as well declare it in rzn1_dmamux_data as:
> >
> >     unsigned long used_chans[BITS_TO_LONGS(2 * RZN1_DMAMUX_MAX_LINES)];
>
> I've done that in versions v1..v8 and it was explicitly requested by
> Ilpo that I used something more specific like a bitmap (or an idr, but
> I don't think it fits well here). So now I'm using a bitmap...

Right, my bad ;-)

    DECLARE_BITMAP(used_chans, 2 * RZN1_DMAMUX_MAX_LINES);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
