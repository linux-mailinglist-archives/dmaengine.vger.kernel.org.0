Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FCB4F8F01
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiDHGnE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 02:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiDHGnC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 02:43:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2FFD7472
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 23:40:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nciId-00037y-2D; Fri, 08 Apr 2022 08:40:51 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nciIb-0004Cp-Hy; Fri, 08 Apr 2022 08:40:49 +0200
Date:   Fri, 8 Apr 2022 08:40:49 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 21/21] ASoC: fsl_micfil: Remove debug message
Message-ID: <20220408064049.GM4012@pengutronix.de>
References: <20220407084936.223075-1-s.hauer@pengutronix.de>
 <20220407084936.223075-22-s.hauer@pengutronix.de>
 <CAA+D8AMyvOpy9x0sAok6z=wRVhTScJ0xeFOHuCHK_fEWzxYwbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMyvOpy9x0sAok6z=wRVhTScJ0xeFOHuCHK_fEWzxYwbA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:38:51 up 8 days, 19:08, 50 users,  load average: 0.06, 0.11, 0.15
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

On Fri, Apr 08, 2022 at 01:21:41PM +0800, Shengjiu Wang wrote:
>    On Thu, Apr 7, 2022 at 4:49 PM Sascha Hauer <[1]s.hauer@pengutronix.de>
>    wrote:
> 
>      The micfil driver prints out the IRQ numbers for each interrupt at error
>      level. This information is useful for debugging at best, remove it.
> 
>      Signed-off-by: Sascha Hauer <[2]s.hauer@pengutronix.de>
>      ---
> 
>      Notes:
>          Changes since v3:
>          - new patch
> 
>       sound/soc/fsl/fsl_micfil.c | 1 -
>       1 file changed, 1 deletion(-)
> 
>      diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
>      index 8f0ab61fd1b07..be669523a4bf7 100644
>      --- a/sound/soc/fsl/fsl_micfil.c
>      +++ b/sound/soc/fsl/fsl_micfil.c
>      @@ -597,7 +597,6 @@ static int fsl_micfil_probe(struct platform_device
>      *pdev)
>              /* get IRQs */
>              for (i = 0; i < MICFIL_IRQ_LINES; i++) {
>                      micfil->irq[i] = platform_get_irq(pdev, i);
>      -               dev_err(&pdev->dev, "GET IRQ: %d\n", micfil->irq[i]);
> 
>    dev_err to dev_dbg, is it better?

I don't think so. You can see the interrupts in /proc/interrupts and
currently the interrupts are not even used in the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
