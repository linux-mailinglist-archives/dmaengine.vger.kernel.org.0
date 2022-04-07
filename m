Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171784F76C2
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 09:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiDGHHA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbiDGHG7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 03:06:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896524B5CF
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 00:05:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncMCK-0002PS-Os; Thu, 07 Apr 2022 09:04:52 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncMCK-00043z-0E; Thu, 07 Apr 2022 09:04:52 +0200
Date:   Thu, 7 Apr 2022 09:04:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 14/20] ASoC: fsl_micfil: Drop get_pdm_clk()
Message-ID: <20220407070451.GY4012@pengutronix.de>
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
 <20220405075959.2744803-15-s.hauer@pengutronix.de>
 <CAA+D8AMMDF1eL_sdE_zF-52ZoaxyWjAtCOQyOZ71+ozzfqf1qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMMDF1eL_sdE_zF-52ZoaxyWjAtCOQyOZ71+ozzfqf1qg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:04:04 up 7 days, 19:33, 61 users,  load average: 0.26, 0.73, 0.52
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 07, 2022 at 11:41:52AM +0800, Shengjiu Wang wrote:
>    On Tue, Apr 5, 2022 at 4:00 PM Sascha Hauer <[1]s.hauer@pengutronix.de>
>    wrote:
> 
>      get_pdm_clk() calculates the PDM clock based on the quality setting,
>      but really the PDM clock is independent of the quality, it's always
>      rate * 4 * micfil->osr. Just drop the function and do the calculation
>      in the caller.
> 
>      Signed-off-by: Sascha Hauer <[2]s.hauer@pengutronix.de>
>      ---
>       sound/soc/fsl/fsl_micfil.c | 38 +-------------------------------------
>       1 file changed, 1 insertion(+), 37 deletions(-)
> 
>      diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
>      index 4b4b7fbbf5c4f..8335646a84d17 100644
>      --- a/sound/soc/fsl/fsl_micfil.c
>      +++ b/sound/soc/fsl/fsl_micfil.c
>      @@ -111,42 +111,6 @@ static const struct snd_kcontrol_new
>      fsl_micfil_snd_controls[] = {
>                           snd_soc_get_enum_double, snd_soc_put_enum_double),
>       };
> 
>      -static inline int get_pdm_clk(struct fsl_micfil *micfil,
>      -                             unsigned int rate)
>      -{
>      -       u32 ctrl2_reg;
>      -       int qsel;
>      -       int bclk;
>      -       int osr = MICFIL_OSR_DEFAULT;
>      -
>      -       regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
>      -       qsel = FIELD_GET(MICFIL_CTRL2_QSEL, ctrl2_reg);
>      -
>      -       switch (qsel) {
>      -       case MICFIL_QSEL_HIGH_QUALITY:
>      -               bclk = rate * 8 * osr / 2; /* kfactor = 0.5 */
>      -               break;
>      -       case MICFIL_QSEL_MEDIUM_QUALITY:
>      -       case MICFIL_QSEL_VLOW0_QUALITY:
>      -               bclk = rate * 4 * osr * 1; /* kfactor = 1 */
>      -               break;
>      -       case MICFIL_QSEL_LOW_QUALITY:
>      -       case MICFIL_QSEL_VLOW1_QUALITY:
>      -               bclk = rate * 2 * osr * 2; /* kfactor = 2 */
>      -               break;
>      -       case MICFIL_QSEL_VLOW2_QUALITY:
>      -               bclk = rate * osr * 4; /* kfactor = 4 */
>      -               break;
>      -       default:
>      -               dev_err(&micfil->pdev->dev,
>      -                       "Please make sure you select a valid
>      quality.\n");
>      -               bclk = -1;
>      -               break;
>      -       }
>      -
>      -       return bclk;
>      -}
>      -
>       static inline int get_clk_div(struct fsl_micfil *micfil,
>                                    unsigned int rate)
>       {
>      @@ -155,7 +119,7 @@ static inline int get_clk_div(struct fsl_micfil
>      *micfil,
> 
>              mclk_rate = clk_get_rate(micfil->mclk);
> 
>      -       clk_div = mclk_rate / (get_pdm_clk(micfil, rate) * 2);
>      +       clk_div = mclk_rate / (rate * micfil->osr * 8);
> 
>    Where is micfil->osr assigned a value?

Should be MICFIL_OSR_DEFAULT instead.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
