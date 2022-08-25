Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A255A1B02
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiHYVZi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHYVZi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 17:25:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342523ED4D;
        Thu, 25 Aug 2022 14:25:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso3393941wma.2;
        Thu, 25 Aug 2022 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nls6DGbfFRAP957pxJ4lCmbOvdtMF+yoGyK/eIAHqyg=;
        b=dlpbM58i2Zl35pjmx5L7mRNtdc5YCm71F9sFmlELYER6ov9p1Zhw7Uryp66w+fECkw
         uWkzwI4ANxiJqV2NAH5qiBvSocnn8gCiQ2esbEPyK9VfrLMG6MP+UW57WsLhfQeb18Xm
         ywTHy3WQy2y0FYikqc1VoN0s6VRtWmBPqvQ7ayhaGh2a543N2UKdV/DJLzBcZZCckZJ6
         ioibCRuSXHClGOmbzN9j5ra8iRima6daMxIf45aGXMyoGgBcf5Q8AplMooQ7YxG8j1KJ
         +wVv5gF0Swo9gXi4Wnksh6Jhf6DtKC3uqCuZv3IfpxDnq0EW8o52F4JCeA7KQe1HLfXz
         RrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nls6DGbfFRAP957pxJ4lCmbOvdtMF+yoGyK/eIAHqyg=;
        b=S0GrtkDDxcvDMwrwLo76N8UgGrW6ZwzmfLgdWdKFy7ZQZ6K9CRkHwy/kcbFMrycQPS
         7YrvwD+c3k8LfQpvsSmxNjol0ZTcXu0dtPN7S6zJs7JYfd2etKPW16let78diEu9Raj7
         fbQ+7nd7f4NLuK7h1svSEIcusxF27fa6sQolCIVaqpKq9Csj2LhoArWkq8kzkNnCsLSm
         NFfAyqMkzVgUfdXofASKxuSd17gppxbd/d9yf9fCMW056SjQQqVyic38XOp8tFrVeykN
         MqzHlu11DfhNMmiFa+0ei5IRgqxUzs7fef58Advlgvdv2AvUJmfIn7zkbI1N61AFWnIm
         djTQ==
X-Gm-Message-State: ACgBeo37cG1CCJ1GTBVVM7/J3p/aT8IoWwZHnf7G0oWtEv/JwnE6xphp
        kbg6qqizQ6J/OJ+mKfCztno=
X-Google-Smtp-Source: AA6agR4u4BAmHRat5LFEkPb1QUEY6oOp43RCL7jbGC6PWwiKhCvUcU/tuSQkwukDJ89Tw4ddFY+90Q==
X-Received: by 2002:a05:600c:b47:b0:3a5:a431:ce36 with SMTP id k7-20020a05600c0b4700b003a5a431ce36mr3484083wmr.89.1661462735769;
        Thu, 25 Aug 2022 14:25:35 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b003a64f684704sm7324411wmq.40.2022.08.25.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:25:35 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     vkoul@kernel.org, Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, lars@metafoo.de,
        Eugeniy.Paltsev@synopsys.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        alim.akhtar@samsung.com, green.wan@sifive.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        wens@csie.org, samuel@sholland.org, ldewangan@nvidia.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        peter.ujfalusi@gmail.com, michal.simek@xilinx.com,
        tony@atomide.com, trix@redhat.com, radhey.shyam.pandey@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH] dmaengine: drivers: Use devm_platform_ioremap_resource()
Date:   Thu, 25 Aug 2022 23:25:33 +0200
Message-ID: <1922204.usQuhbGJ8B@kista>
In-Reply-To: <20220820130925.589472-1-tudor.ambarus@microchip.com>
References: <20220820130925.589472-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dne sobota, 20. avgust 2022 ob 15:09:25 CEST je Tudor Ambarus napisal(a):
> platform_get_resource() and devm_ioremap_resource() are wrapped up in the
> devm_platform_ioremap_resource() helper. Use the helper and get rid of the
> local variable for struct resource *. We now have a function call less.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/dma/bcm2835-dma.c                      |  4 +---
>  drivers/dma/dma-axi-dmac.c                     |  4 +---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  4 +---
>  drivers/dma/fsl-edma.c                         |  8 +++-----
>  drivers/dma/fsl-qdma.c                         | 10 +++-------
>  drivers/dma/idma64.c                           |  4 +---
>  drivers/dma/img-mdc-dma.c                      |  4 +---
>  drivers/dma/imx-dma.c                          |  4 +---
>  drivers/dma/imx-sdma.c                         |  4 +---
>  drivers/dma/mcf-edma.c                         |  5 +----
>  drivers/dma/mediatek/mtk-hsdma.c               |  4 +---
>  drivers/dma/mmp_pdma.c                         |  4 +---
>  drivers/dma/mmp_tdma.c                         |  4 +---
>  drivers/dma/moxart-dma.c                       |  4 +---
>  drivers/dma/mv_xor_v2.c                        |  7 ++-----
>  drivers/dma/mxs-dma.c                          |  4 +---
>  drivers/dma/nbpfaxi.c                          |  4 +---
>  drivers/dma/pxa_dma.c                          |  4 +---
>  drivers/dma/qcom/bam_dma.c                     |  4 +---
>  drivers/dma/s3c24xx-dma.c                      |  4 +---
>  drivers/dma/sf-pdma/sf-pdma.c                  |  4 +---
>  drivers/dma/sh/usb-dmac.c                      |  4 +---
>  drivers/dma/stm32-dma.c                        |  4 +---
>  drivers/dma/stm32-dmamux.c                     |  4 +---
>  drivers/dma/stm32-mdma.c                       |  4 +---
>  drivers/dma/sun4i-dma.c                        |  4 +---
>  drivers/dma/sun6i-dma.c                        |  4 +---

For sun4i-dma.c and sun6i-dma.c:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/dma/tegra210-adma.c                    |  4 +---
>  drivers/dma/ti/cppi41.c                        | 10 +++-------
>  drivers/dma/ti/omap-dma.c                      |  4 +---
>  drivers/dma/xilinx/zynqmp_dma.c                |  4 +---
>  31 files changed, 38 insertions(+), 106 deletions(-)



