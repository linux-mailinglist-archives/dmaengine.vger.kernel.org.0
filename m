Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478E54C511D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 23:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiBYWDT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 17:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBYWDS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 17:03:18 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F869496;
        Fri, 25 Feb 2022 14:02:41 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g6so8454182ybe.12;
        Fri, 25 Feb 2022 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+b6+oake8hiYhMiw+tRXERgHNKqcFJBlff8fODarYU=;
        b=b4M47ALchiwecpDWLWwnv+1HcycN9upAGuuvTNj65F1/nZS8fwQTdSrQbmMT/8QR4S
         JjAXUaGls0tAFaXkp+YFrTiGMF9aQwBMK8ggI/NMVUlZgTDBYiopJOBLN8oEAckkY9/M
         /Rq5SxH9Gnv+uzEo57VQtn5uJKe/aPfgIR+Eg9ylxXKED+z+ujN09vE5xTQ6nqRjkhMR
         jJsT6l+6xvNv+0s5ncr5FYgjoXPsxUG4RVEPxJ8ZugExaX81qCCQFH1KNwj1SDBoaO3m
         JPBjRJUB5u8Xce+CJdw2ejX6rXzrEGvciajQQzM+IDg+zcAZa3ZRMjpr8fDgsiQPlX9E
         tV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+b6+oake8hiYhMiw+tRXERgHNKqcFJBlff8fODarYU=;
        b=xDIDPpqu87rjaehTbOwxN1B9XeLDgHu0PJ4BZOuyIZ6kuZFGqFuLTOWMIAxLU2nsSG
         GjErn8M3mN3E2RHi72sMEhckXcXvqbxU/YALJSe9LIX2WFJqt9fAJg0bJaM6th8terf4
         kUapA7kSMf4LOMM0hFMRcTwvDHQf4VTa8PKZ5CieXMexWncJdo1jvy73u+hZz3YlxtGy
         AUfmJ4alU7Uc6Fij8X5TW16mkILbsqke1/RdkDBYkpowBLJIXVsPOnJ7PLfgBBmFs5Oe
         EKKXK8z60pYvDW57yRJFygk2aTUXgj5GWm4ShT2raDM6eJ+T+dpRopJqzwQ4ll0xEZtP
         /1jA==
X-Gm-Message-State: AOAM532OwGLQeZ8XR43uQAPH6l8PJnDB2ohdj0jgTrjQSVIYNSTasWnY
        xajt7bNen4bmzfNkS3ikr+7hDmWETVRiDCnrSmU=
X-Google-Smtp-Source: ABdhPJw6jGnheN/kSTANjDauweJTFcZxMicChKUXLQrjC/eFpvYdZIS2U26Y6hOLoX6r9gvAaTVr14qrxT0VZSiDf5A=
X-Received: by 2002:a05:6902:4e2:b0:611:19fc:a30 with SMTP id
 w2-20020a05690204e200b0061119fc0a30mr9085820ybs.431.1645826561146; Fri, 25
 Feb 2022 14:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20220225112403.505562-1-miquel.raynal@bootlin.com> <20220225112403.505562-5-miquel.raynal@bootlin.com>
In-Reply-To: <20220225112403.505562-5-miquel.raynal@bootlin.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Feb 2022 22:01:00 +0000
Message-ID: <CA+V-a8usUF+ABZ30bQ0vkY3FQEzBR-vV0i=Z0uzz_-XySSjp=Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] dma: dmamux: Introduce RZN1 DMA router support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

Thank you for the patch.

On Fri, Feb 25, 2022 at 12:09 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
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
> ---
>  drivers/dma/dw/Kconfig       |   8 ++
>  drivers/dma/dw/Makefile      |   2 +
>  drivers/dma/dw/rzn1-dmamux.c | 152 +++++++++++++++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 drivers/dma/dw/rzn1-dmamux.c
>
> diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
> index db25f9b7778c..dd53d4a9fa92 100644
> --- a/drivers/dma/dw/Kconfig
> +++ b/drivers/dma/dw/Kconfig
> @@ -16,6 +16,14 @@ config DW_DMAC
>           Support the Synopsys DesignWare AHB DMA controller. This
>           can be integrated in chips such as the Intel Cherrytrail.
>
> +config RZN1_DMAMUX
> +       tristate "Renesas RZ/N1 DMAMUX driver"
> +       depends on DW_DMAC
Maybe dependencies for ARCH_RZN1and COMPILE_TEST too?

> +       help
> +         Support the Renesas RZ/N1 DMAMUX which is located in front of
> +         the Synopsys DesignWare AHB DMA controller located on Renesas
> +         SoCs.
> +
>  config DW_DMAC_PCI
>         tristate "Synopsys DesignWare AHB DMA PCI driver"
>         depends on PCI
> diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
> index a6f358ad8591..8025f75e589c 100644
> --- a/drivers/dma/dw/Makefile
> +++ b/drivers/dma/dw/Makefile
> @@ -7,5 +7,7 @@ obj-$(CONFIG_DW_DMAC)           += dw_dmac.o
>  dw_dmac-y                      := platform.o
>  dw_dmac-$(CONFIG_OF)           += of.o
>
> +obj-$(CONFIG_RZN1_DMAMUX)      += rzn1-dmamux.o
> +
>  obj-$(CONFIG_DW_DMAC_PCI)      += dw_dmac_pci.o
>  dw_dmac_pci-y                  := pci.o
> diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
> new file mode 100644
> index 000000000000..bc4e2e7c3d18
> --- /dev/null
> +++ b/drivers/dma/dw/rzn1-dmamux.c
> @@ -0,0 +1,152 @@
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
can you please check if the above four includes are really required.

> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> +
headers need to be sorted.

> +#define RZN1_DMAMUX_LINES 64
> +#define RZN1_DMAMUX_SPLIT 16
> +
> +struct rzn1_dmamux_data {
> +       struct dma_router dmarouter;
> +       u32 used_chans;
> +       struct mutex lock;
> +};
> +
> +struct rzn1_dmamux_map {
> +       unsigned int req_idx;
> +};
> +
> +static void rzn1_dmamux_free(struct device *dev, void *route_data)
> +{
> +       struct rzn1_dmamux_data *dmamux = dev_get_drvdata(dev);
> +       struct rzn1_dmamux_map *map = route_data;
> +
> +       dev_dbg(dev, "Unmapping DMAMUX request %u\n", map->req_idx);
> +
> +       mutex_lock(&dmamux->lock);
> +       dmamux->used_chans &= ~BIT(map->req_idx);
> +       mutex_unlock(&dmamux->lock);
> +
> +       kfree(map);
> +}
> +
> +static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +                                       struct of_dma *ofdma)
> +{
> +       struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +       struct rzn1_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +       struct rzn1_dmamux_map *map;
> +       unsigned int dmac_idx, chan, val;
> +       u32 mask;
> +       int ret;
> +
> +       map = kzalloc(sizeof(*map), GFP_KERNEL);
> +       if (!map)
> +               return ERR_PTR(-ENOMEM);
> +
map needs to be freed in the error path.

> +       if (dma_spec->args_count != 6)
> +               return ERR_PTR(-EINVAL);
> +
> +       chan = dma_spec->args[0];
> +       map->req_idx = dma_spec->args[4];
> +       val = dma_spec->args[5];
> +       dma_spec->args_count -= 2;
> +
> +       if (chan >= RZN1_DMAMUX_SPLIT) {
> +               dev_err(&pdev->dev, "Invalid DMA request line: %u\n", chan);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (map->req_idx >= RZN1_DMAMUX_LINES ||
> +           (map->req_idx % RZN1_DMAMUX_SPLIT) != chan) {
> +               dev_err(&pdev->dev, "Invalid MUX request line: %u\n", map->req_idx);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       dmac_idx = map->req_idx < RZN1_DMAMUX_SPLIT ? 0 : 1;
> +       dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", dmac_idx);
> +       if (!dma_spec->np) {
> +               dev_err(&pdev->dev, "Can't get DMA master\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
> +               map->req_idx, dmac_idx, chan);
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
any reason for using __maybe_unused?

> +       { .compatible = "renesas,rzn1-dma" },
> +       {},
"," not required.

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
> +       of_node_put(dmac_node);
> +       if (!match)
> +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
> +
> +       dmamux->dmarouter.dev = &pdev->dev;
> +       dmamux->dmarouter.route_free = rzn1_dmamux_free;
> +
> +       platform_set_drvdata(pdev, dmamux);
> +
> +       return of_dma_router_register(mux_node, rzn1_dmamux_route_allocate,
> +                                     &dmamux->dmarouter);
> +}
> +
> +static const struct of_device_id rzn1_dmamux_match[] = {
> +       { .compatible = "renesas,rzn1-dmamux" },
> +       {},
"," not required.

> +};
> +
> +static struct platform_driver rzn1_dmamux_driver = {
> +       .driver = {
> +               .name = "renesas,rzn1-dmamux",
> +               .of_match_table = rzn1_dmamux_match,
> +       },
> +       .probe  = rzn1_dmamux_probe,
> +};
> +module_platform_driver(rzn1_dmamux_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
> +MODULE_DESCRIPTION("Renesas RZ/N1 DMAMUX driver");
> --
> 2.27.0
>

Cheers,
Prabhakar
