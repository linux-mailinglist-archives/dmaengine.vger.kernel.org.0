Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F54FF0F4
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiDMHzn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDMHzn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 03:55:43 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432072B257;
        Wed, 13 Apr 2022 00:53:22 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id t2so804930qtw.9;
        Wed, 13 Apr 2022 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMMD5LLs65Bc3u77xPtaDEH/2WOkZ1EKf9yfe6A/VHA=;
        b=aNOTklpO0FurKQfRPMXTzhgfxg7BcxRkedlNIXcSbk9boUOvj3yfLQSUy8MLdV07IQ
         szDAScGHyn5JIxJn1oTwG24GCEeD2rLbHe8SGOVvD1MQn9EAokhToS3nGN8hZSdnFwgt
         kXlDFP+vTyascd9e1gWuXWT+fY+l1tnk6CMg8DcC2OHrjy5iBMUfdeCQQC+lTxDogbDZ
         arZjpZ3GfmHbWODfhNV0euY4OMFNGlLJBGEHtF8WnoF8Kr7V0hifdBdygdfyVYG829i9
         IdTemqq94lcODhhccov1sN1MUX0tu9B5myT/iQMD3M8uY5XobXaYNs4sI1YilgFzOn6x
         3cag==
X-Gm-Message-State: AOAM530D1e1S3yXf6gb9tJFVam8rRcqt0n9eNFA/REb7anfQqgNYYZIT
        d1Ih7eeWo00ZiBrUY3IRl5tpJ6Z220JeEw==
X-Google-Smtp-Source: ABdhPJy0bpHgdejPJiMr/fxjkkJulmMdVMHkm1Nlg9/RCAB7rdoSKUIOH87711TQV2iDyeZczzVE2Q==
X-Received: by 2002:ac8:6f1a:0:b0:2ef:6eba:2150 with SMTP id bs26-20020ac86f1a000000b002ef6eba2150mr6271839qtb.466.1649836401253;
        Wed, 13 Apr 2022 00:53:21 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id a9-20020ac85b89000000b002e2072c9dedsm30415864qta.67.2022.04.13.00.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 00:53:20 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g34so2304630ybj.1;
        Wed, 13 Apr 2022 00:53:20 -0700 (PDT)
X-Received: by 2002:a25:2c89:0:b0:641:2884:b52e with SMTP id
 s131-20020a252c89000000b006412884b52emr13177578ybs.506.1649836400443; Wed, 13
 Apr 2022 00:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220412193936.63355-1-miquel.raynal@bootlin.com> <20220412193936.63355-6-miquel.raynal@bootlin.com>
In-Reply-To: <20220412193936.63355-6-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Apr 2022 09:53:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
Message-ID: <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Tue, Apr 12, 2022 at 9:39 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
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
> +++ b/drivers/dma/dw/rzn1-dmamux.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Schneider-Electric
> + * Author: Miquel Raynal <miquel.raynal@bootlin.com
> + * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +#include <linux/bitops.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/slab.h>
> +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> +#include <linux/types.h>
> +
> +#define RNZ1_DMAMUX_NCELLS 6
> +#define RZN1_DMAMUX_LINES 64
> +#define RZN1_DMAMUX_MAX_LINES 16
> +
> +struct rzn1_dmamux_data {
> +       struct dma_router dmarouter;
> +       unsigned long *used_chans;

Why a pointer?

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
> +       dmamux->used_chans = devm_bitmap_zalloc(&pdev->dev, 2 * RZN1_DMAMUX_MAX_LINES,
> +                                               GFP_KERNEL);

... Oh, you want to allocate the bitmap separately, although you
know it's just a single long.

You might as well declare it in rzn1_dmamux_data as:

    unsigned long used_chans[BITS_TO_LONGS(2 * RZN1_DMAMUX_MAX_LINES)];

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
