Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3EF4F7B8
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jun 2019 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFVSDA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jun 2019 14:03:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33130 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVSDA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jun 2019 14:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YLLngcfYF+Lf6PbqhusKwH4dyS0jGxhgKdh6Y63Svz4=; b=pxYWUfYEHUZyrsHMzmYZCmeH6u
        vA66hUZenIzw17pXvXv6f93SdcQ0X7FTSnQNjotf0jmcFxwFXASe0XPpIm8aUUd127H12zRGe9rmC
        F+fh57NshmgsjRLwizN7eCwpiMTFg47U1lP20vT2lX5Rzfh+G6gXN731oR/ejxbMeF0HnZQUVXinS
        YdAr1e3Y1xVbZd1IEGCFmDsqmrDX59NKEETzvNJ9WtyAOnQFfGu1cBFQQw3XIkZ43haAXoNcgXDFX
        Vw5y0RolO9d4Syk+Q6yp9/bdu0+BVWs57oRuJaRungfh3ycXmN0X1eodZGBvG5IX9c+1zYoeAERZk
        l0sE8niQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44126 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hekLh-00056r-Bz; Sat, 22 Jun 2019 19:02:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hekLg-0002hJ-Jg; Sat, 22 Jun 2019 19:02:48 +0100
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
Subject: [PATCH] dmaengine: imx-sdma: fix incorrect conversion to
 readl_relaxed_poll_timeout_atomic()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hekLg-0002hJ-Jg@rmk-PC.armlinux.org.uk>
Date:   Sat, 22 Jun 2019 19:02:48 +0100
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When imx-sdma was converted to use readl_relaxed_poll_timeout_atomic(),
the termination condition was inverted.  Fix this.

Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the interrupt handler")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5f3c1378b90e..ba84c0444f35 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -660,7 +660,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 	sdma_enable_channel(sdma, 0);
 
 	ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
-						reg, !(reg & 1), 1, 500);
+						reg, reg & 1, 1, 500);
 	if (ret)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
-- 
2.7.4

