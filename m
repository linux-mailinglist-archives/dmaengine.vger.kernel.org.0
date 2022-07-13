Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DB573154
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiGMIk6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 04:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiGMIkn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 04:40:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4104E8DAD
        for <dmaengine@vger.kernel.org>; Wed, 13 Jul 2022 01:40:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oBXvB-00046c-4O; Wed, 13 Jul 2022 10:40:37 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oBXvA-0005TM-Kx; Wed, 13 Jul 2022 10:40:36 +0200
Date:   Wed, 13 Jul 2022 10:40:36 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dmaengine: mxs: use platform_driver_register
Message-ID: <20220713084036.ipcd6bhcdb574w7h@pengutronix.de>
References: <20220712160909.2054141-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712160909.2054141-1-dario.binacchi@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dario,

On 22-07-12, Dario Binacchi wrote:
> Driver registration fails on SOC imx8mn as its supplier, the clock
> control module, is probed later than subsys initcall level. This driver
> uses platform_driver_probe which is not compatible with deferred probing
> and won't be probed again later if probe function fails due to clock not
> being available at that time.
> 
> This patch replaces the use of platform_driver_probe with
> platform_driver_register which will allow probing the driver later again
> when the clock control module will be available.
> 
> Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: stable@vger.kernel.org
> 
> ---
> 
> Changes in v5:
> - Update the commit message.
> - Create a new patch to remove the warning generated by this patch.

Please squash this new patch into this patch since you introduce the
warning with this patch.

Regards,
  Marco

> Changes in v4:
> - Restore __init in front of mxs_dma_probe() definition.
> - Rename the mxs_dma_driver variable to mxs_dma_driver_probe.
> - Update the commit message.
> - Use builtin_platform_driver() instead of module_platform_driver().
> 
> Changes in v3:
> - Restore __init in front of mxs_dma_init() definition.
> 
> Changes in v2:
> - Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.
> 
>  drivers/dma/mxs-dma.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 994fc4d2aca4..18f8154b859b 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -839,10 +839,6 @@ static struct platform_driver mxs_dma_driver = {
>  		.name	= "mxs-dma",
>  		.of_match_table = mxs_dma_dt_ids,
>  	},
> +	.probe = mxs_dma_probe,
>  };
> -
> -static int __init mxs_dma_module_init(void)
> -{
> -	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
> -}
> -subsys_initcall(mxs_dma_module_init);
> +builtin_platform_driver(mxs_dma_driver);
> -- 
> 2.32.0
> 
> 
> 
