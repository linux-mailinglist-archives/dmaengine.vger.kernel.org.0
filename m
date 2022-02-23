Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF74C130E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiBWMqy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 07:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBWMqx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 07:46:53 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A00A4199;
        Wed, 23 Feb 2022 04:46:25 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id u10so2973694vsu.13;
        Wed, 23 Feb 2022 04:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WN9HXFy4O8MWRcFXOM81Swa8FNpMoMf+B3dPA0jmkFc=;
        b=u+J0CFZOItMTqtP8TTb5gx/dVX+uopXobhJuPDK2rYaKeXqxrAsxwyZvpiyT4AwdFp
         2ODg3VB6vTI7oO2WjMEwI3pFBlAn8vV6GourXfcypW+SpCFja3rz4NfW5+E7dlHWI3MR
         PqtQKfIXr5KcUzlPlB2gjfDgNwsTTurW5Klz+lkNqpO07lRrK70fGLTNE5PbkU7GVqlC
         /5BjvqPgAA3tkcD0fKPi+dyFdmGm3T88/rsRiBkS/DCWjneC9mSm0MoihiiP2Wekbfu/
         aI4AWwzaQbLjoO28y7KeyCMhsDADBjOQYTACmrekkdt2BPcbO00ig/Obm5FNapv1kDq9
         sC4A==
X-Gm-Message-State: AOAM531y0kZ0LfAaReIsgy2sOMcRC4FT42VJE2TuZRX+Vz2QUhh8M4V6
        JwjlwMG8H8HSiBjEUjplgBJo3awn0M1/kA==
X-Google-Smtp-Source: ABdhPJyjm7PS+aBMQ/D6GrSN77qYkt0Az0DkUu/yySTZ5n2T3/yJidVJuflNI8V1U70dfxwAoqLpAg==
X-Received: by 2002:a67:d90b:0:b0:31b:77ac:6eb5 with SMTP id t11-20020a67d90b000000b0031b77ac6eb5mr11376086vsj.22.1645620384692;
        Wed, 23 Feb 2022 04:46:24 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id u6sm8543114vku.15.2022.02.23.04.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:46:24 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id 110so1369164uak.4;
        Wed, 23 Feb 2022 04:46:23 -0800 (PST)
X-Received: by 2002:a9f:360f:0:b0:341:8a12:8218 with SMTP id
 r15-20020a9f360f000000b003418a128218mr10583982uad.14.1645620383537; Wed, 23
 Feb 2022 04:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com> <20220222103437.194779-5-miquel.raynal@bootlin.com>
In-Reply-To: <20220222103437.194779-5-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 13:46:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
Message-ID: <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
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

On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
>
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/dma/dw/dmamux.c

rzn1-dmamux.c?

> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Schneider-Electric
> + * Author: Miquel Raynal <miquel.raynal@bootlin.com
> + * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> +
> +#define RZN1_DMAMUX_LINES      64

Unused. But using it wouldn't hurt, I guess?

> +static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +                                       struct of_dma *ofdma)
> +{
> +       struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +       struct rzn1_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +       struct rzn1_dmamux_map *map;
> +       unsigned int master, chan, val;
> +       u32 mask;
> +       int ret;
> +
> +       map = kzalloc(sizeof(*map), GFP_KERNEL);
> +       if (!map)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (dma_spec->args_count != 6)
> +               return ERR_PTR(-EINVAL);
> +
> +       chan = dma_spec->args[0];
> +       map->req_idx = dma_spec->args[4];
> +       val = dma_spec->args[5];
> +       dma_spec->args_count -= 2;
> +
> +       if (chan >= dmamux->dmac_requests) {
> +               dev_err(&pdev->dev, "Invalid DMA request line: %d\n", chan);

%u

> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (map->req_idx >= dmamux->dmamux_requests ||
> +           map->req_idx % dmamux->dmac_requests != chan) {

The reliance on .dmac_requests (i.e. "dma-requests" in the parent
DMA controller DT node) looks fragile to me.  Currently there are two
masters, each providing 16 channels, hence using all 2 x 16 =
32 bits in the DMAMUX register.
What if a variant used the same mux, and the same 16/16 split, but
the parent DMACs don't have all channels available?
I think it would be safer to hardcode this as 16 (using a #define, ofc).

> +               dev_err(&pdev->dev, "Invalid MUX request line: %d\n", map->req_idx);

%u

> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       /* The of_node_put() will be done in the core for the node */
> +       master = map->req_idx >= dmamux->dmac_requests ? 1 : 0;

The name "master" confused me: initially I thought it was used as a
boolean flag, but it really is the index of the parent DMAC.

> +       dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", master);
> +       if (!dma_spec->np) {
> +               dev_err(&pdev->dev, "Can't get DMA master\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
> +               map->req_idx, master, chan);
> +
> +       mask = BIT(map->req_idx);
> +       mutex_lock(&dmamux->lock);
> +       dmamux->used_chans |= mask;
> +       ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> +       mutex_unlock(&dmamux->lock);
> +       if (ret) {
> +               rzn1_dmamux_free(&pdev->dev, map);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return map;
> +}
> +
> +static const struct of_device_id rzn1_dmac_match[] __maybe_unused = {
> +       { .compatible = "renesas,rzn1-dma" },
> +       {},
> +};
> +
> +static int rzn1_dmamux_probe(struct platform_device *pdev)
> +{
> +       struct device_node *mux_node = pdev->dev.of_node;
> +       const struct of_device_id *match;
> +       struct device_node *dmac_node;
> +       struct rzn1_dmamux_data *dmamux;
> +
> +       dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
> +       if (!dmamux)
> +               return -ENOMEM;
> +
> +       mutex_init(&dmamux->lock);
> +
> +       dmac_node = of_parse_phandle(mux_node, "dma-masters", 0);
> +       if (!dmac_node)
> +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DMA master node\n");
> +
> +       match = of_match_node(rzn1_dmac_match, dmac_node);
> +       if (!match) {
> +               of_node_put(dmac_node);
> +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
> +       }
> +
> +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dmac_requests)) {
> +               of_node_put(dmac_node);
> +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC requests information\n");
> +       }
> +
> +       of_node_put(dmac_node);

When hardcoding dmac_requests to 16, I guess the whole dmac_node
handling can be removed?

> +
> +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dmamux_requests)) {

Don't obtain from DT, but fix to 32?

> +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing mux requests information\n");
> +       }
> +
> +       dmamux->dmarouter.dev = &pdev->dev;
> +       dmamux->dmarouter.route_free = rzn1_dmamux_free;
> +
> +       platform_set_drvdata(pdev, dmamux);
> +
> +       return of_dma_router_register(mux_node, rzn1_dmamux_route_allocate,
> +                                     &dmamux->dmarouter);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
