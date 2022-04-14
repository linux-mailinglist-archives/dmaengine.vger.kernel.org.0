Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE4500792
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 09:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiDNHxy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiDNHxy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 03:53:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B97436B76
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 00:51:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1neuG4-0003M7-Ga; Thu, 14 Apr 2022 09:51:16 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1neuG2-0000k3-Oi; Thu, 14 Apr 2022 09:51:14 +0200
Date:   Thu, 14 Apr 2022 09:51:14 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 00/21] ASoC: fsl_micfil: Driver updates
Message-ID: <20220414075114.GC2387@pengutronix.de>
References: <20220408112928.1326755-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408112928.1326755-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:24 up 14 days, 20:19, 59 users,  load average: 0.07, 0.11,
 0.09
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

Hi Mark,

Ok to apply this series? I just realized that I missed to Cc: you on
this series. Let me know if I should resend.

Sascha

On Fri, Apr 08, 2022 at 01:29:07PM +0200, Sascha Hauer wrote:
> This series has a bunch of cleanups for the FSL MICFIL driver. There is
> not much chance for regressions in this series as the driver currently
> can't work at all. The MICFIL needs multififo support in the i.MX SDMA
> engine which is added with this series, see 11/20.
> 
> The multififo support is selected in the dma phandle arguments in the
> device tree, the transfer type must be '25' aka IMX_DMATYPE_MULTI_SAI.
> This is set already to 25 in the upstream i.MX8M[NM] dtsi files, but the
> SDMA driver silently ignores unsupported values instead of throwing an
> error. This is fixed in this series and multififo support is added.
> 
> The dmaengine patches have acks from Vinod, so the series is free to
> go through the ASoC tree.
> 
> Changes since v4:
> - collect more acks
> - whitespace cleanup in 16/21
> 
> Changes since v3:
> - Add commit log to "ASoC: fsl_micfil: drop unused variables"
> - Fix include name in "ASoC: fsl_micfil: add multi fifo support"
> - Drop unnecessary temporary adding of struct fsl_micfil::osr
> - Leave default quality setting at 'medium'
> - Drop debugging message printed at error level
> - collect acks from Shengjiu Wang and Vinod Koul
> 
> Changes since v2:
> - Add forgotten commit log to dmaengine patches
> - Add patch to move include/linux/platform_data/dma-imx.h to include/linux/dma/imx-dma.h
> - Use prefix dmaengine: for dma patches
> 
> Changes since v1:
> - Drop unused variable sw_done_sel
> - Evaluate sdmac->direction directly instead of storing value in n_fifos
> - add missing include linux/bitfield.h
> 
> Sascha Hauer (21):
>   ASoC: fsl_micfil: Drop unnecessary register read
>   ASoC: fsl_micfil: Drop unused register read
>   ASoC: fsl_micfil: drop fsl_micfil_set_mclk_rate()
>   ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
>   ASoC: fsl_micfil: use GENMASK to define register bit fields
>   ASoC: fsl_micfil: use clear/set bits
>   ASoC: fsl_micfil: drop error messages from failed register accesses
>   ASoC: fsl_micfil: drop unused variables
>   dmaengine: imx: Move header to include/dma/
>   dmaengine: imx-sdma: error out on unsupported transfer types
>   dmaengine: imx-sdma: Add multi fifo support
>   ASoC: fsl_micfil: add multi fifo support
>   ASoC: fsl_micfil: use define for OSR default value
>   ASoC: fsl_micfil: Drop get_pdm_clk()
>   ASoC: fsl_micfil: simplify clock setting
>   ASoC: fsl_micfil: rework quality setting
>   ASoC: fsl_micfil: drop unused include
>   ASoC: fsl_micfil: drop only once used defines
>   ASoC: fsl_micfil: drop support for undocumented property
>   ASoC: fsl_micfil: fold fsl_set_clock_params() into its only user
>   ASoC: fsl_micfil: Remove debug message
> 
>  drivers/dma/imx-dma.c                         |   2 +-
>  drivers/dma/imx-sdma.c                        |  76 +++-
>  drivers/mmc/host/mxcmmc.c                     |   2 +-
>  drivers/spi/spi-fsl-lpspi.c                   |   2 +-
>  drivers/spi/spi-imx.c                         |   2 +-
>  drivers/tty/serial/imx.c                      |   2 +-
>  drivers/video/fbdev/mx3fb.c                   |   2 +-
>  .../dma-imx.h => dma/imx-dma.h}               |  26 +-
>  sound/soc/fsl/fsl_asrc.c                      |   2 +-
>  sound/soc/fsl/fsl_asrc_dma.c                  |   2 +-
>  sound/soc/fsl/fsl_easrc.h                     |   2 +-
>  sound/soc/fsl/fsl_micfil.c                    | 369 +++++++-----------
>  sound/soc/fsl/fsl_micfil.h                    | 269 +++----------
>  sound/soc/fsl/imx-pcm.h                       |   2 +-
>  sound/soc/fsl/imx-ssi.h                       |   2 +-
>  15 files changed, 297 insertions(+), 465 deletions(-)
>  rename include/linux/{platform_data/dma-imx.h => dma/imx-dma.h} (67%)
> 
> -- 
> 2.30.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
