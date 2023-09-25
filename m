Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B7AD428
	for <lists+dmaengine@lfdr.de>; Mon, 25 Sep 2023 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjIYJGK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Sep 2023 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjIYJGJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Sep 2023 05:06:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45BD3
        for <dmaengine@vger.kernel.org>; Mon, 25 Sep 2023 02:06:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qkhXH-0005K2-Jk; Mon, 25 Sep 2023 11:05:47 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qkhXG-008pND-AF; Mon, 25 Sep 2023 11:05:46 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qkhXG-00BO8v-7Y; Mon, 25 Sep 2023 11:05:46 +0200
Date:   Mon, 25 Sep 2023 11:05:46 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix deadlock in interrupt handler
Message-ID: <20230925090546.GW637806@pengutronix.de>
References: <AM0PR08MB30897429213E8DB9BCC1D6C880F8A@AM0PR08MB3089.eurprd08.prod.outlook.com>
 <20230922095032.GU637806@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922095032.GU637806@pengutronix.de>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 22, 2023 at 11:50:32AM +0200, Sascha Hauer wrote:
> Hi Tim,
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
> 
> This is strange. Why and how does dev_warn() call back into the SDMA
> driver?
> 
> We shouldn't merge this without having a clue what exactly goes wrong
> here. Please provide the corresponding lockdep output.

I have overlooked that you actually did provide the lockdep output in a
link.

I think this is a false positive. The i.MX UART driver makes sure that
the console UART never uses DMA, so it shouldn't happen that the DMA
driver issuing console messages calls back into the DMA driver.

Could you give the following patch a test?

Sascha


-------------------------------8<------------------------------------

From 5ac9902683710c300a64a731bcda6b3b089b2706 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 25 Sep 2023 10:39:44 +0200
Subject: [PATCH] serial: imx: Put DMA enabled UART in separate lock subclass

The i.MX UART driver never uses DMA on UARTs providing the console.
Put the UART port lock in a separate subclass to avoid lockdep
complaining about possible deadlocks when the DMA driver issues
console messages under its own spinlock held.

Reported-by: Tim van der Staaij <Tim.vanderstaaij@zigngroup.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7341d060f85cb..c30113cf5db85 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1458,8 +1458,10 @@ static int imx_uart_startup(struct uart_port *port)
 	imx_uart_writel(sport, ucr4 & ~UCR4_DREN, UCR4);
 
 	/* Can we enable the DMA support? */
-	if (!uart_console(port) && imx_uart_dma_init(sport) == 0)
+	if (!uart_console(port) && imx_uart_dma_init(sport) == 0) {
+		lockdep_set_subclass(&port->lock, 1);
 		dma_is_inited = 1;
+	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.39.2

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
