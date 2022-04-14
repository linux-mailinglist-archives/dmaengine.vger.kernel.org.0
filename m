Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED1500BDB
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 13:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiDNLND (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbiDNLMz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 07:12:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE793275F1
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 04:10:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nexMk-0004XR-Nl; Thu, 14 Apr 2022 13:10:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nexMj-0005aj-LJ; Thu, 14 Apr 2022 13:10:21 +0200
Date:   Thu, 14 Apr 2022 13:10:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v5 00/21] ASoC: fsl_micfil: Driver updates
Message-ID: <20220414111021.GK4012@pengutronix.de>
References: <20220408112928.1326755-1-s.hauer@pengutronix.de>
 <20220414075114.GC2387@pengutronix.de>
 <Ylf3fAU5TV/RnHBW@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylf3fAU5TV/RnHBW@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:06:35 up 14 days, 23:36, 64 users,  load average: 0.08, 0.23,
 0.17
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

On Thu, Apr 14, 2022 at 11:29:16AM +0100, Mark Brown wrote:
> On Thu, Apr 14, 2022 at 09:51:14AM +0200, Sascha Hauer wrote:
> 
> > Ok to apply this series? I just realized that I missed to Cc: you on
> > this series. Let me know if I should resend.
> 
> Please resend.  What's the plan with the dmaengine bits - it looks like
> the ASoC bits are relatively substatantial here?

Ok, I'll resend. I'd like to merge the dmaengine bits through your tree.
I have collected the acks from Vinod for this. I just rechecked there
are no conflicts with -next so far.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
