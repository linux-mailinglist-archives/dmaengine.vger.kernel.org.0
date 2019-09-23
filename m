Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD2BB5E4
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2019 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408225AbfIWN6Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Sep 2019 09:58:16 -0400
Received: from mx1.emlix.com ([188.40.240.192]:42132 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408206AbfIWN6Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Sep 2019 09:58:16 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 57A3C600FF;
        Mon, 23 Sep 2019 15:58:14 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     jlu@pengutronix.de, yibin.gong@nxp.com, fugang.duan@nxp.com,
        l.stach@pengutronix.de, dan.j.williams@intel.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH v5 3/3] dmaengine: imx-sdma: drop redundant variable
Date:   Mon, 23 Sep 2019 15:58:08 +0200
Message-Id: <20190923135808.815-4-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923135808.815-1-philipp.puschmann@emlix.com>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In sdma_prep_dma_cyclic buf is redundant. Drop it.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

Changelog v3,v4,v5:
 - no changes

Changelog v2:
 - add Reviewed-by tag

 drivers/dma/imx-sdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0b1d6a62423d..0d62664e534e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1549,7 +1549,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	struct sdma_engine *sdma = sdmac->sdma;
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
-	int i = 0, buf = 0;
+	int i;
 	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
@@ -1570,7 +1570,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		goto err_bd_out;
 	}
 
-	while (buf < buf_len) {
+	for (i = 0; i < num_periods; i++) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
@@ -1597,9 +1597,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.status = param;
 
 		dma_addr += period_len;
-		buf += period_len;
-
-		i++;
 	}
 
 	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
-- 
2.23.0

