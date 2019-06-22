Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32674F7DC
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jun 2019 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFVS4D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jun 2019 14:56:03 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33764 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFVS4D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jun 2019 14:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9L4EdajO6Xbwxdr23bMsOgh5jRoyTsPUINWDgSc18DQ=; b=ODoS1pCbMNS2pbN3tuZXPP2DpU
        btyD2EpGAffay9u7xn0lhGx7Z5QM76wHruQiLRF3PTGbMNaP/RlTXLxo/t3eATwQFo7vA/QSqM7zm
        nSp1btztbTwNTGKJXsS+bigdDUzJc52IGi2S57gF3QAWnNIgNHHeiwxPPSyhQuIN3ny7tqCN58cuZ
        y3KG8IN1SBmNVyBq2cjPWY4NxRXLz1J25I9Mz9dZkqzGLIs5ZhzJvi4Qn0bPmukjVRHaeuAozUNFT
        qJPgI/kQbQUR3nQhz4eZQGT2v7MwdjbjWF8vEvevzWTX6Qh8CT09nQ48BbpkWMWNCyGW03Qkao/kU
        bZDa33+Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:54250 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1helB3-0005N2-Ql; Sat, 22 Jun 2019 19:55:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1helB3-0005d6-7m; Sat, 22 Jun 2019 19:55:53 +0100
In-Reply-To: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2] dmaengine: imx-sdma: fix incorrect conversion to
 readl_relaxed_poll_timeout_atomic()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1helB3-0005d6-7m@rmk-PC.armlinux.org.uk>
Date:   Sat, 22 Jun 2019 19:55:53 +0100
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When imx-sdma was converted to use readl_relaxed_poll_timeout_atomic(),
the termination condition was inverted.  Fix this.

Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the interrupt handler")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/dma/imx-sdma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5f3c1378b90e..c45cbdb09714 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -655,15 +655,21 @@ static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 static int sdma_run_channel0(struct sdma_engine *sdma)
 {
 	int ret;
-	u32 reg;
+	u32 reg, mask;
+
+	// Disable channel 0 interrupt
+	mask = readl_relaxed(sdma->regs + SDMA_H_INTRMSK);
+	writel_relaxed(mask & ~1, sdma->regs + SDMA_H_INTRMSK);
 
 	sdma_enable_channel(sdma, 0);
 
-	ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
-						reg, !(reg & 1), 1, 500);
+	ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_INTR,
+						reg, reg & 1, 1, 500);
 	if (ret)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
+	writel_relaxed(mask, sdma->regs + SDMA_H_INTRMSK);
+
 	/* Set bits of CONFIG register with dynamic context switching */
 	reg = readl(sdma->regs + SDMA_H_CONFIG);
 	if ((reg & SDMA_H_CONFIG_CSM) == 0) {
-- 
2.7.4

