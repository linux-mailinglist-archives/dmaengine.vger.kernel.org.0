Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54664F77CA
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiDGHlK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbiDGHlJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 03:41:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2C7E5A5
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 00:39:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncMjN-0008Ay-8r; Thu, 07 Apr 2022 09:39:01 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncMjL-0005lq-5S; Thu, 07 Apr 2022 09:38:59 +0200
Date:   Thu, 7 Apr 2022 09:38:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 05/19] ASoC: fsl_micfil: use GENMASK to define
 register bit fields
Message-ID: <20220407073859.GB4012@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-6-s.hauer@pengutronix.de>
 <CAA+D8APTMSLSCb386XvN3bu+uq3F1VK9NopJYpgumDF=TCCgEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8APTMSLSCb386XvN3bu+uq3F1VK9NopJYpgumDF=TCCgEw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:28:01 up 7 days, 19:57, 63 users,  load average: 0.14, 0.16, 0.18
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

On Thu, Apr 07, 2022 at 10:08:38AM +0800, Shengjiu Wang wrote:
>    On Mon, Mar 28, 2022 at 7:28 PM Sascha Hauer <[1]s.hauer@pengutronix.de>
>    wrote:
> 
>      Use GENMASK along with FIELD_PREP and FIELD_GET to access bitfields in
>      registers to straighten register access and to drop a lot of defines.
> 
>      Signed-off-by: Sascha Hauer <[2]s.hauer@pengutronix.de>
>      ---
> 
>      Notes:
>          Changes since v1:
>          - add missing include linux/bitfield.h
> 
>       sound/soc/fsl/fsl_micfil.c |  52 ++++++-------
>       sound/soc/fsl/fsl_micfil.h | 147 ++++++++-----------------------------
>       2 files changed, 58 insertions(+), 141 deletions(-)
> 
>      diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
>      index 878d24fde3581..cfa8af668d921 100644
>      --- a/sound/soc/fsl/fsl_micfil.c
>      +++ b/sound/soc/fsl/fsl_micfil.c
>      @@ -1,6 +1,7 @@
>       // SPDX-License-Identifier: GPL-2.0
>       // Copyright 2018 NXP
> 
>      +#include <linux/bitfield.h>
>       #include <linux/clk.h>
>       #include <linux/device.h>
>       #include <linux/interrupt.h>
>      @@ -116,23 +117,22 @@ static inline int get_pdm_clk(struct fsl_micfil
>      *micfil,
>              int bclk;
> 
>              regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
>      -       osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
>      -                   >> MICFIL_CTRL2_CICOSR_SHIFT);
>      -       qsel = ctrl2_reg & MICFIL_CTRL2_QSEL_MASK;
>      +       osr = 16 - FIELD_GET(MICFIL_CTRL2_CICOSR, ctrl2_reg);
>      +       qsel = FIELD_GET(MICFIL_CTRL2_QSEL, ctrl2_reg);
> 
>              switch (qsel) {
>      -       case MICFIL_HIGH_QUALITY:
>      +       case MICFIL_QSEL_HIGH_QUALITY:
>                      bclk = rate * 8 * osr / 2; /* kfactor = 0.5 */
>                      break;
>      -       case MICFIL_MEDIUM_QUALITY:
>      -       case MICFIL_VLOW0_QUALITY:
>      +       case MICFIL_QSEL_MEDIUM_QUALITY:
>      +       case MICFIL_QSEL_VLOW0_QUALITY:
>                      bclk = rate * 4 * osr * 1; /* kfactor = 1 */
>                      break;
>      -       case MICFIL_LOW_QUALITY:
>      -       case MICFIL_VLOW1_QUALITY:
>      +       case MICFIL_QSEL_LOW_QUALITY:
>      +       case MICFIL_QSEL_VLOW1_QUALITY:
>                      bclk = rate * 2 * osr * 2; /* kfactor = 2 */
>                      break;
>      -       case MICFIL_VLOW2_QUALITY:
>      +       case MICFIL_QSEL_VLOW2_QUALITY:
>                      bclk = rate * osr * 4; /* kfactor = 4 */
>                      break;
>              default:
>      @@ -244,8 +244,8 @@ static int fsl_micfil_trigger(struct
>      snd_pcm_substream *substream, int cmd,
>                       * 11 - reserved
>                       */
>                      ret = regmap_update_bits(micfil->regmap,
>      REG_MICFIL_CTRL1,
>      -                                        MICFIL_CTRL1_DISEL_MASK,
>      -                                        (1 <<
>      MICFIL_CTRL1_DISEL_SHIFT));
>      +                               MICFIL_CTRL1_DISEL,
>      +                               FIELD_PREP(MICFIL_CTRL1_DISEL,
>      MICFIL_CTRL1_DISEL_DMA));
> 
>    Alignment should match open parenthesis?

Generally yes, but in this case this would introduce an additional
linebreak inside the FIELD_PREP macro which reduces readability:

Instead of:

	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
			MICFIL_CTRL1_DISEL,
			FIELD_PREP(MICFIL_CTRL1_DISEL, MICFIL_CTRL1_DISEL_DMA));

We would have:

	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
				 MICFIL_CTRL1_DISEL,
				 FIELD_PREP(MICFIL_CTRL1_DISEL,
				 MICFIL_CTRL1_DISEL_DMA));

> 
>                      ret = regmap_update_bits(micfil->regmap,
>      REG_MICFIL_CTRL1,
>      -                                        MICFIL_CTRL1_DISEL_MASK,
>      -                                        (0 <<
>      MICFIL_CTRL1_DISEL_SHIFT));
>      +                               MICFIL_CTRL1_DISEL,
>      +                               FIELD_PREP(MICFIL_CTRL1_DISEL,
>      MICFIL_CTRL1_DISEL_DISABLE));
> 
>    Alignment should match open parenthesis? 

Same here.

>     
> 
>                      if (ret) {
>                              dev_err(dev, "failed to update DISEL bits\n");
>                              return ret;
>      @@ -300,8 +300,8 @@ static int fsl_set_clock_params(struct device *dev,
>      unsigned int rate)
> 
>              /* set CICOSR */
>              ret |= regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
>      -                                MICFIL_CTRL2_CICOSR_MASK,
>      -                                MICFIL_CTRL2_OSR_DEFAULT);
>      +                                MICFIL_CTRL2_CICOSR,
>      +                                FIELD_PREP(MICFIL_CTRL2_CICOSR,
>      MICFIL_CTRL2_CICOSR_DEFAULT));
> 
>     Alignment should match open parenthesis? 

This is fixed in one of the next patches where the '|=' is replaced with '='.
It reduces the number of lines changed in that patch, so I think this is ok
here.

> 
>              if (ret)
>                      dev_err(dev, "failed to set CICOSR in reg 0x%X\n",
>                              REG_MICFIL_CTRL2);
>      @@ -312,7 +312,8 @@ static int fsl_set_clock_params(struct device *dev,
>      unsigned int rate)
>                      ret = -EINVAL;
> 
>              ret |= regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
>      -                                MICFIL_CTRL2_CLKDIV_MASK, clk_div);
>      +                                MICFIL_CTRL2_CLKDIV,
>      +                                FIELD_PREP(MICFIL_CTRL2_CLKDIV,
>      clk_div));
> 
>    Alignment should match open parenthesis?

Ditto.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
