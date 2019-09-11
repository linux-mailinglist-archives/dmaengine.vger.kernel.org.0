Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4115AFF4B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2019 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfIKOzk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Sep 2019 10:55:40 -0400
Received: from mx1.emlix.com ([188.40.240.192]:37222 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfIKOzk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Sep 2019 10:55:40 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id BEE3C5FCE8;
        Wed, 11 Sep 2019 16:50:00 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 2/4] dmaengine: imx-sdma: fix dma freezes
Date:   Wed, 11 Sep 2019 16:49:41 +0200
Message-Id: <20190911144943.21554-3-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For some years and since many kernel versions there are reports that the
RX UART SDMA channel stops working at some point. The workaround was to
disable DMA for RX. This commit tries to fix the problem itself.

Due to its license i wasn't able to debug the sdma script itself but it
somehow leads to blocking the scheduling of the channel script when a
running sdma script does not find any usable destination buffer to put its
data into.

If we detect such a potential case we manually retrigger the sdma script
for this channel and by this reenable the scipt being run by scheduler.

As sdmac->desc is constant we can move desc out of the loop.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/dma/imx-sdma.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1abb14ff394d..6a5a84504858 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
-	int error = 0;
-	enum dma_status	old_status = sdmac->status;
+	struct sdma_desc *desc = sdmac->desc;
+	int error = 0, cnt = 0;
+	enum dma_status old_status = sdmac->status;
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (sdmac->desc) {
-		struct sdma_desc *desc = sdmac->desc;
+	while (desc) {
 
 		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
 
+		cnt++;
+
 		if (bd->mode.status & BD_RROR) {
 			bd->mode.status &= ~BD_RROR;
 			sdmac->status = DMA_ERROR;
@@ -821,6 +823,18 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		if (error)
 			sdmac->status = old_status;
 	}
+
+	/* In some situations it happens that the sdma stops serving
+	 * dma interrupt requests. It happens when running dma script
+	 * does not find any usable destination buffer to put its data into.
+	 *
+	 * While there is no specific error condition we can check for, a
+	 * necessary condition is that all available buffers for the current
+	 * channel have been written to by the sdma script. In such a case we
+	 * will trigger the sdma script manually.
+	 */
+	if (cnt >= desc->num_bd)
+		sdma_enable_channel(sdmac->sdma, sdmac->channel);
 }
 
 static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
-- 
2.23.0

