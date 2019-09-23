Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9AABB5E5
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2019 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408218AbfIWN6Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Sep 2019 09:58:16 -0400
Received: from mx1.emlix.com ([188.40.240.192]:42102 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408172AbfIWN6Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Sep 2019 09:58:16 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 4AA10600EF;
        Mon, 23 Sep 2019 15:58:14 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     jlu@pengutronix.de, yibin.gong@nxp.com, fugang.duan@nxp.com,
        l.stach@pengutronix.de, dan.j.williams@intel.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
Date:   Mon, 23 Sep 2019 15:58:06 +0200
Message-Id: <20190923135808.815-2-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923135808.815-1-philipp.puschmann@emlix.com>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
buffer, when 0 ARM owns it. When processing the buffers in
sdma_update_channel_loop the ownership of the currently processed
buffer was set to SDMA again before running the callback function of
the buffer and while the sdma script may be running in parallel. So
there was the possibility to get the buffer overwritten by SDMA before
it has been processed by kernel leading to kind of random errors in the
upper layers, e.g. bluetooth.

Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---

Changelog v5:
 - no changes

Changelog v4:
 - fixed the fixes tag
 
Changelog v3:
 - use correct dma_wmb() instead of dma_wb()
 - add fixes tag

Changelog v2:
 - add dma_wb()
 
 drivers/dma/imx-sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9ba74ab7e912..b42281604e54 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		*/
 
 		desc->chn_real_count = bd->mode.count;
-		bd->mode.status |= BD_DONE;
 		bd->mode.count = desc->period_len;
 		desc->buf_ptail = desc->buf_tail;
 		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
@@ -817,6 +816,9 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 		spin_lock(&sdmac->vc.lock);
 
+		dma_wmb();
+		bd->mode.status |= BD_DONE;
+
 		if (error)
 			sdmac->status = old_status;
 	}
-- 
2.23.0

