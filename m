Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39769E141
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 14:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjBUN0Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 08:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBUN0P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 08:26:15 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4DA27D7D;
        Tue, 21 Feb 2023 05:26:14 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id h19so1433798qtk.7;
        Tue, 21 Feb 2023 05:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOflBLgkYyNU7DCD9/DC80jueE1mu7ROFrIheewJRtQ=;
        b=RA9ojgXZUFoBjSl5VHQgUGoPi+6HJ3aNxo8H20nP9YEVdpZai7hBLbzCF7t+I8fScs
         KyNMj9wfGErxQIZf4f7hWp2uQgFGr4kXYVH/bDzTIYrb0Zvjra6BL/Np4FXJQ5u7tRNx
         vQMm2L9lej2vKxnCfjWlcAz09pFhmKIFjJIb6Jek5S5vvzCUQzMi6pWbZw2oiKHPZ/X4
         RyG2gJOQnrIH5m1qZnpaHi5cxF68b34/fK6QV/BSjBDHpFj7k3cfcQa/HhfvFAa6hee3
         GW222wvBwg5/cW8unxFmCuEBn/SurOr79fFq592doq/HL3TE+y8DFGH3OU3yKNXeXzc4
         SWog==
X-Gm-Message-State: AO0yUKV7+T0LiJe0JiBibyWugjEoVT1vlyTBRfo1VrPL5V8K+QsBQ1Fm
        FQFA/C3qA14+E+pZ37qGeUnckov6lMbUyw==
X-Google-Smtp-Source: AK7set/uXwHGU7dVbofXNJhkOv4MejSkET7L2Q9FfX9QQmIlJ096TL5QYgbYFDMh8fJaczCcZzoXgQ==
X-Received: by 2002:ac8:5c0e:0:b0:3ba:2641:50d3 with SMTP id i14-20020ac85c0e000000b003ba264150d3mr7699086qti.42.1676985972961;
        Tue, 21 Feb 2023 05:26:12 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id a7-20020ac86107000000b003b6382f66b1sm285195qtm.29.2023.02.21.05.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:26:12 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id a20so3197558ybj.8;
        Tue, 21 Feb 2023 05:26:11 -0800 (PST)
X-Received: by 2002:a05:6902:2d0:b0:920:2b79:84b4 with SMTP id
 w16-20020a05690202d000b009202b7984b4mr1094608ybh.386.1676985971580; Tue, 21
 Feb 2023 05:26:11 -0800 (PST)
MIME-Version: 1.0
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com> <1675969514-3137-2-git-send-email-lizhi.hou@amd.com>
In-Reply-To: <1675969514-3137-2-git-send-email-lizhi.hou@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 14:25:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
Message-ID: <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
Subject: Re: [RESEND PATCH V12 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        tumic@gpxsee.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lizhi,

On Thu, Feb 9, 2023 at 8:18 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
> Add driver to enable PCIe board which uses XDMA (the DMA/Bridge Subsystem
> for PCI Express). For example, Xilinx Alveo PCIe devices.
>     https://www.xilinx.com/products/boards-and-kits/alveo.html
>
> The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host (C2H)
> channels. Memory transfers are specified on a per-channel basis in
> descriptor linked lists, which the DMA fetches from host memory and
> processes. Events such as descriptor completion and errors are signaled
> using interrupts. The hardware detail is provided by
>     https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
>
> This driver implements dmaengine APIs.
>     - probe the available DMA channels
>     - use dma_slave_map for channel lookup
>     - use virtual channel to manage dmaengine tx descriptors
>     - implement device_prep_slave_sg callback to handle host scatter gather
>       list
>     - implement device_config to config device address for DMA transfer
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> Tested-by: Martin Tuma <tumic@gpxsee.org>

Thanks for your patch, which is now commit 17ce252266c7f016
("dmaengine: xilinx: xdma: Add xilinx xdma driver") in dmaengine/next.

> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -735,6 +735,20 @@ config XILINX_DMA
>           the scatter gather interface with multiple channels independent
>           configuration support.
>
> +config XILINX_XDMA
> +       tristate "Xilinx DMA/Bridge Subsystem DMA Engine"
> +       depends on HAS_IOMEM
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       select REGMAP_MMIO

No platform dependencies at all, while this is a platform driver that
relies on some other not-yet-existing driver creating an "xdma"
platform device?

> +       help
> +         Enable support for Xilinx DMA/Bridge Subsystem DMA engine. The DMA
> +         provides high performance block data movement between Host memory
> +         and the DMA subsystem. These direct memory transfers can be both in
> +         the Host to Card (H2C) and Card to Host (C2H) transfers.
> +         The core also provides up to 16 user interrupt wires that generate
> +         interrupts to the host.
> +
>  config XILINX_ZYNQMP_DMA
>         tristate "Xilinx ZynqMP DMA Engine"
>         depends on ARCH_ZYNQ || MICROBLAZE || ARM64 || COMPILE_TEST

> --- /dev/null
> +++ b/drivers/dma/xilinx/xdma.c

> +/**
> + * xdma_probe - Driver probe function
> + * @pdev: Pointer to the platform_device structure
> + */
> +static int xdma_probe(struct platform_device *pdev)
> +{
> +       struct xdma_platdata *pdata = dev_get_platdata(&pdev->dev);

Platform data? No DT?
Do we still accept plain platform drivers?

> +static const struct platform_device_id xdma_id_table[] = {
> +       { "xdma", 0},
> +       { },
> +};

This table is not needed, as the single entry matches driver.name below.

> +
> +static struct platform_driver xdma_driver = {
> +       .driver         = {
> +               .name = "xdma",
> +       },
> +       .id_table       = xdma_id_table,
> +       .probe          = xdma_probe,
> +       .remove         = xdma_remove,
> +};
> +
> +module_platform_driver(xdma_driver);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
