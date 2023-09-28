Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02297B1551
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjI1HtU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjI1HtT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:49:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151997;
        Thu, 28 Sep 2023 00:49:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A57C433C8;
        Thu, 28 Sep 2023 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695887357;
        bh=Gs6aFP7wkoeloUPjh3P+7ZqWXKrUV+lmRvPOXvjf8Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C07hz1x9ZBOot13NmBg/w+8/7UOMHZqam5kdmBhRs0FIMx+p817yeI0/AwYqADdFf
         LyROsByfc7udfgvzO+iVFxt40scEHqiTsEuBV2anPvz2pvOqA5rNaglngGFVYkDqNi
         8llzR1bKPikKnXdUU/UiExt0M1sNhonfI2Tg9VWZ4Ep2jjWHYlWMlubIYLpGAoPemh
         /llBuONh0YVRMZh24Aia4Qvo0KfHmtLVm+XDoqoKF4CTK02whHvixcoVQ+egWgMk7x
         FTO4SCB3n9ecoNHU2OdnjDnT9Gq59BrqP6Jgw3zOEG+2pLxraJj4zpxQ8BtWBKRvcG
         KuqZYg3uAID5g==
Date:   Thu, 28 Sep 2023 13:19:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Olivier Dautricourt <olivierdautricourt@gmail.com>,
        Stefan Roese <sr@denx.de>, dmaengine@vger.kernel.org,
        kernel@pengutronix.de, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Yangtao Li <frank.li@vivo.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, Lizhi Hou <lizhi.hou@amd.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>
Subject: Re: [PATCH 00/59] dma: Convert to platform remove callback returning
 void
Message-ID: <ZRUv+WgkovPotwIr@matsya>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-09-23, 15:31, Uwe Kleine-König wrote:
> Hello,
> 
> this series convert nearly all platform drivers below drivers/dma to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.

I have applied this, with change of subsystem to dmaengine: xxx
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> There are 4 drivers I didn't convert in this series:
> 
> 	drivers/dma/milbeaut-hdmac.c
> 	drivers/dma/milbeaut-xdmac.c
> 	drivers/dma/uniphier-mdmac.c
> 	drivers/dma/uniphier-xdmac.c
> 
> These all might return early in .remove() if dmaengine_terminate_sync()
> fails. I only looked deeper into the first one, and this shows exactly
> the error that is easy to make with .remove() returning an int: When
> returning early from .remove(), some cleanup (here:
> dma_async_device_unregister()) is skipped. So the dma device stays
> known, but the device is still unregistered and the devm allocated stuff
> (here e.g. *mdev) is freed. So it can probably easily happen, that
> something tries to use the dma device and this will likely result in an
> oops.

We should convert these too, thanks for your work for the conversion

-- 
~Vinod
