Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B07AD47B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Sep 2023 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjIYJ1T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Sep 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjIYJ1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Sep 2023 05:27:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1C1C0
        for <dmaengine@vger.kernel.org>; Mon, 25 Sep 2023 02:27:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qkhrx-0000ed-7D; Mon, 25 Sep 2023 11:27:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qkhrw-008poP-I8; Mon, 25 Sep 2023 11:27:08 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qkhrw-00BOJa-FQ; Mon, 25 Sep 2023 11:27:08 +0200
Date:   Mon, 25 Sep 2023 11:27:08 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Message-ID: <20230925092708.GX637806@pengutronix.de>
References: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
 <20230925092004.natij4i364yupevi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925092004.natij4i364yupevi@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 25, 2023 at 11:20:04AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Sep 21, 2023 at 09:57:11AM +0000, Tim van der Staaij | Zign wrote:
> > dev_warn internally acquires the lock that is already held when
> > sdma_update_channel_loop is called. Therefore it is acquired twice and
> > this is detected as a deadlock. Temporarily release the lock while
> > logging to avoid this.
> > 
> > Signed-off-by: Tim van der Staaij <tim.vanderstaaij@zigngroup.com>
> > Link: https://lore.kernel.org/all/AM0PR08MB308979EC3A8A53AE6E2D3408802CA@AM0PR08MB3089.eurprd08.prod.outlook.com/
> > ---
> >  drivers/dma/imx-sdma.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 51012bd39900..3a7cd783a567 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -904,7 +904,10 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
> >  	 * owned buffer is available (i.e. BD_DONE was set too late).
> >  	 */
> >  	if (sdmac->desc && !is_sdma_channel_enabled(sdmac->sdma, sdmac->channel)) {
> > +		spin_unlock(&sdmac->vc.lock);
> >  		dev_warn(sdmac->sdma->dev, "restart cyclic channel %d\n", sdmac->channel);
> > +		spin_lock(&sdmac->vc.lock);
> > +
> 
> I don't know if Sascha's patch helps

I do ;)

I inserted a dev_info() into the imx-sdma driver and got said circular
locking warning. With my patch applied it's gone. Nevertheless I would
wait for Tims feedback and resend it with some more people on Cc. I
never used lockdep_set_subclass() and I am not sure if it's legal to
put it into the UART startup function like I did.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
