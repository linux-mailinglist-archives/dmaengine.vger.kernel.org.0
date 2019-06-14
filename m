Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B2457B9
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfFNIiS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 04:38:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34288 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfFNIiS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 04:38:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D726200E49;
        Fri, 14 Jun 2019 10:38:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 808C1200E52;
        Fri, 14 Jun 2019 10:38:11 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A2DE7402E6;
        Fri, 14 Jun 2019 16:38:05 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        vkoul@kernel.org, dan.j.williams@intel.com, thesven73@gmail.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
Date:   Fri, 14 Jun 2019 16:39:59 +0800
Message-Id: <20190614083959.37944-1-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

It is possible for an irq triggered by channel0 to be received later
after clks are disabled once firmware loaded during sdma probe. If
that happens then clearing them by writing to SDMA_H_INTR won't work
and the system will hang processing infinite interrupts. Actually,
don't need interrupt triggered on channel0 since it's pollling
SDMA_H_STATSTOP to know channel0 done rather than interrupt in
current code, just clear BD_INTR to disable channel0 interrupt to
avoid the above case.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
---
 drivers/dma/imx-sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index deea9aa..b5a1ee2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -742,7 +742,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	spin_lock_irqsave(&sdma->channel_0_lock, flags);
 
 	bd0->mode.command = C0_SETPM;
-	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
+	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
 	bd0->mode.count = size / 2;
 	bd0->buffer_addr = buf_phys;
 	bd0->ext_buffer_addr = address;
@@ -1064,7 +1064,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	context->gReg[7] = sdmac->watermark_level;
 
 	bd0->mode.command = C0_SETDM;
-	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
+	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
 	bd0->mode.count = sizeof(*context) / 4;
 	bd0->buffer_addr = sdma->context_phys;
 	bd0->ext_buffer_addr = 2048 + (sizeof(*context) / 4) * channel;
-- 
2.7.4

