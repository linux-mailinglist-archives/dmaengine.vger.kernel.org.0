Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E443D9E3A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 09:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhG2HS3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhG2HS2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Jul 2021 03:18:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB32C061757
        for <dmaengine@vger.kernel.org>; Thu, 29 Jul 2021 00:18:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90JC-000823-TG; Thu, 29 Jul 2021 09:18:22 +0200
Received: from [2a0a:edc0:0:900:2e4d:54ff:fe67:bfa5] (helo=ginster)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90JB-0002Hk-1m; Thu, 29 Jul 2021 09:18:21 +0200
Received: from jbe by ginster with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90JB-0002Zi-0i; Thu, 29 Jul 2021 09:18:21 +0200
From:   Juergen Borleis <jbe@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     linux-imx@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org, kernel@pengutronix.de
Subject: [PATCH] dma: imx-dma: configure the generic DMA type to make it work
Date:   Thu, 29 Jul 2021 09:18:21 +0200
Message-Id: <20210729071821.9857-1-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit dea7a9f
  dmaengine: imx-dma: remove dma_slave_config direction usage

changes the method from a "configuration when called" to an "configuration
when used". Due to this, only the cyclic DMA type gets configured
correctly, while the generic DMA type is left non-configured.

Without this additional call, the struct imxdma_channel::word_size member
is stuck at DMA_SLAVE_BUSWIDTH_UNDEFINED and imxdma_prep_slave_sg() always
returns NULL.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/dma/imx-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 7f116bb..2ddc31e 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -812,6 +812,8 @@ static struct dma_async_tx_descriptor *imxdma_prep_slave_sg(
 		dma_length += sg_dma_len(sg);
 	}
 
+	imxdma_config_write(chan, &imxdmac->config, direction);
+
 	switch (imxdmac->word_size) {
 	case DMA_SLAVE_BUSWIDTH_4_BYTES:
 		if (sg_dma_len(sgl) & 3 || sgl->dma_address & 3)
-- 
2.20.1

