Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1354C1336
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiBWMu5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 07:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbiBWMuy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 07:50:54 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4231A9A6D;
        Wed, 23 Feb 2022 04:50:23 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id l42so5459218vkd.7;
        Wed, 23 Feb 2022 04:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gP4A6URoJKHDCwHV2sofk4nE+u+icS5Y2l1NiRYLZ6E=;
        b=j7hR1n9oxaz9cQ2YWtLfqChO0gtZsMRFICyPrrrFkm7Wm8uBRIyhodYbm6+Ghm+f0A
         pd7qJEPmeRfhi5x9dFyItfav/+cfnJYMTDhewwQEPY5zx/wdoidBaHtGAz0+/tfucpHw
         SM8grg/bypr0NydIuppyi23EbBJ8whWsFh8U9GKoamhEK/uN41l3wdPfI8M6Ulplp49l
         S55VAiRW42/yV/FYd3TZovQ6RQFbkvice3WIzBd1hl4E+WtOyXL8/SDVfeJvpuEe2E7v
         LA8uuP8kyqF85QEK1rALuNePJ+LfrlYWDU4K0LZ+5TpxrdjxLquO9RR2lmE/BmunWngd
         /ihg==
X-Gm-Message-State: AOAM533KMLMzLhP5dIsWKJftzRZGfYZOqjutFK18Xy0nnDzb4RXj5Ciw
        p0HMbf4UEJEiyejYKxzo7TCSXa9WsM28WQ==
X-Google-Smtp-Source: ABdhPJyveY5CqfuNnZOODe2V8hZqODIlYrb/bRj0RYvPMKfJTTUEA4FOeU1x9Ydal3eEdmiolfvgiw==
X-Received: by 2002:a05:6122:e28:b0:331:42:794d with SMTP id bk40-20020a0561220e2800b003310042794dmr11797995vkb.10.1645620622698;
        Wed, 23 Feb 2022 04:50:22 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id n62sm657094vsc.28.2022.02.23.04.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:50:22 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id j9so12173346vkj.1;
        Wed, 23 Feb 2022 04:50:21 -0800 (PST)
X-Received: by 2002:a05:6122:8ca:b0:332:64b4:8109 with SMTP id
 10-20020a05612208ca00b0033264b48109mr1591282vkg.7.1645620621829; Wed, 23 Feb
 2022 04:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com> <20220222103437.194779-7-miquel.raynal@bootlin.com>
In-Reply-To: <20220222103437.194779-7-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 13:50:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUKJ6O-W+9-Zf7ogNqv87rDQ1Qv4tX+4kzLhYk0w0Y3w@mail.gmail.com>
Message-ID: <CAMuHMdXUKJ6O-W+9-Zf7ogNqv87rDQ1Qv4tX+4kzLhYk0w0Y3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dma: dw: Add RZN1 compatible
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
> The Renesas RZN1 DMA IP is very close to the original DW DMA IP, a DMA
> routeur has been introduced to handle the wiring options that have been

router

> added.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -137,6 +137,7 @@ static void dw_shutdown(struct platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id dw_dma_of_id_table[] = {
>         { .compatible = "snps,dma-spear1340", .data = &dw_dma_chip_pdata },
> +       { .compatible = "renesas,rzn1-dma", .data = &dw_dma_chip_pdata },

I don't like all these copies of dw_dma_chip_pdata, due to it being
defined in drivers/dma/dw/internal.h, but that's a pre-existing problem.

>         {}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
