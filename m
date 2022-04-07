Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028934F76D8
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiDGHK7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 03:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiDGHK5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 03:10:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369EB17067
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 00:08:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncMGC-00030f-DQ; Thu, 07 Apr 2022 09:08:52 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncMGB-0004DK-Vx; Thu, 07 Apr 2022 09:08:51 +0200
Date:   Thu, 7 Apr 2022 09:08:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 15/20] ASoC: fsl_micfil: simplify clock setting
Message-ID: <20220407070851.GZ4012@pengutronix.de>
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
 <20220405075959.2744803-16-s.hauer@pengutronix.de>
 <CAA+D8AOWVaaAEvR-tK=fL9KL463-NwKGvtdPOXcs0AZ0WOgZDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AOWVaaAEvR-tK=fL9KL463-NwKGvtdPOXcs0AZ0WOgZDA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:07:10 up 7 days, 19:36, 62 users,  load average: 0.14, 0.46, 0.44
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

On Thu, Apr 07, 2022 at 01:09:37PM +0800, Shengjiu Wang wrote:
>    On Tue, Apr 5, 2022 at 4:00 PM Sascha Hauer <[1]s.hauer@pengutronix.de>
>    wrote:
> 
>      The reference manual has this for calculating the micfil internal clock
>      divider:
> 
>               MICFIL Clock rate
>      clkdiv = -----------------
>               8 * OSR * outrate
> 
>      (with OSR == Oversampling Rate, outrate == output sample rate)
> 
>      The driver first sets the MICFIL Clock rate to (outrate * 1024) and then
>      calculates back the clkdiv value from the above calculation.
> 
>      Simplify this by using a fixed clkdiv value of 8 and set the MICFIL
>      Clock rate to (outrate * clkdiv * OSR * 8).
> 
>      While at it drop disabling the clock before setting its rate. The MICFIL
>      module is disabled when the rate is changed and it is also resetted
>      before it is started again, so I doubt it's necessary to disable the
>      clock.
> 
>      Signed-off-by: Sascha Hauer <[2]s.hauer@pengutronix.de>
>      ---
>       sound/soc/fsl/fsl_micfil.c | 45 ++++----------------------------------
>       1 file changed, 4 insertions(+), 41 deletions(-)
> 
>      diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
>      index 8335646a84d17..fd3b168a38661 100644
>      --- a/sound/soc/fsl/fsl_micfil.c
>      +++ b/sound/soc/fsl/fsl_micfil.c
>      @@ -111,19 +111,6 @@ static const struct snd_kcontrol_new
>      fsl_micfil_snd_controls[] = {
>                           snd_soc_get_enum_double, snd_soc_put_enum_double),
>       };
> 
>      -static inline int get_clk_div(struct fsl_micfil *micfil,
>      -                             unsigned int rate)
>      -{
>      -       long mclk_rate;
>      -       int clk_div;
>      -
>      -       mclk_rate = clk_get_rate(micfil->mclk);
>      -
>      -       clk_div = mclk_rate / (rate * micfil->osr * 8);
>      -
>      -       return clk_div;
>      -}
>      -
>       /* The SRES is a self-negated bit which provides the CPU with the
>        * capability to initialize the PDM Interface module through the
>        * slave-bus interface. This bit always reads as zero, and this
>      @@ -147,24 +134,6 @@ static int fsl_micfil_reset(struct device *dev)
>              return 0;
>       }
> 
>      -static int fsl_micfil_set_mclk_rate(struct fsl_micfil *micfil,
>      -                                   unsigned int freq)
>      -{
>      -       struct device *dev = &micfil->pdev->dev;
>      -       int ret;
>      -
>      -       clk_disable_unprepare(micfil->mclk);
>      -
>      -       ret = clk_set_rate(micfil->mclk, freq * 1024);
>      -       if (ret)
>      -               dev_warn(dev, "failed to set rate (%u): %d\n",
>      -                        freq * 1024, ret);
>      -
>      -       clk_prepare_enable(micfil->mclk);
>      -
>      -       return ret;
>      -}
>      -
>       static int fsl_micfil_startup(struct snd_pcm_substream *substream,
>                                    struct snd_soc_dai *dai)
>       {
>      @@ -238,13 +207,12 @@ static int fsl_micfil_trigger(struct
>      snd_pcm_substream *substream, int cmd,
>       static int fsl_set_clock_params(struct device *dev, unsigned int rate)
>       {
>              struct fsl_micfil *micfil = dev_get_drvdata(dev);
>      -       int clk_div;
>      +       int clk_div = 8;
>              int ret;
> 
>      -       ret = fsl_micfil_set_mclk_rate(micfil, rate);
>      -       if (ret < 0)
>      -               dev_err(dev, "failed to set mclk[%lu] to rate %u\n",
>      -                       clk_get_rate(micfil->mclk), rate);
>      +       ret = clk_set_rate(micfil->mclk, rate * clk_div * micfil->osr *
>      8);
> 
>    Please make sure micfil->osr is assigned.

Should also be MICFIL_OSR_DEFAULT instead. The micfil->osr field sneaked
in during development and I decided against it finally.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
