Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8094EBC18
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiC3HwT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiC3HwR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 03:52:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84263B8
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 00:50:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nZT5y-0005w4-Ou; Wed, 30 Mar 2022 09:50:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nZT5y-0002Om-Ak; Wed, 30 Mar 2022 09:50:22 +0200
Date:   Wed, 30 Mar 2022 09:50:22 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 11/19] ASoC: fsl_micfil: add multi fifo support
Message-ID: <20220330075022.GO22780@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-12-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328112744.1575631-12-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:43 up 109 days, 16:35, 78 users,  load average: 0.02, 0.08,
 0.08
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 28, 2022 at 01:27:36PM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

This also lacks a commit message. Will add:

    The micfil hardware provides the microphone data on multiple successive
    FIFO registers, one register per stereo pair. Also to work properly the
    SDMA_DONE0_CONFIG_DONE_SEL bit in the SDMA engines SDMA_DONE0_CONFIG
    register must be set. This patch provides the necessary information to
    the SDMA engine driver.

Sascha

>  sound/soc/fsl/fsl_micfil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index ffca56d72562d..fe3e1319b35fd 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -16,6 +16,7 @@
>  #include <linux/regmap.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> +#include <linux/platform_data/dma-imx.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
> @@ -35,6 +36,7 @@ struct fsl_micfil {
>  	struct clk *busclk;
>  	struct clk *mclk;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
> +	struct sdma_peripheral_config sdmacfg;
>  	unsigned int dataline;
>  	char name[32];
>  	int irq[MICFIL_IRQ_LINES];
> @@ -324,6 +326,10 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
>  		return ret;
>  	}
>  
> +	micfil->dma_params_rx.peripheral_config = &micfil->sdmacfg;
> +	micfil->dma_params_rx.peripheral_size = sizeof(micfil->sdmacfg);
> +	micfil->sdmacfg.n_fifos_src = channels;
> +	micfil->sdmacfg.sw_done = true;
>  	micfil->dma_params_rx.maxburst = channels * MICFIL_DMA_MAXBURST_RX;
>  
>  	return 0;
> -- 
> 2.30.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
