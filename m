Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5127AFF41
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2019 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfIKOzk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Sep 2019 10:55:40 -0400
Received: from mx1.emlix.com ([188.40.240.192]:37216 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbfIKOzk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Sep 2019 10:55:40 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id BC6E95FC57;
        Wed, 11 Sep 2019 16:50:00 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 1/4] dmaengine: imx-sdma: fix buffer ownership
Date:   Wed, 11 Sep 2019 16:49:40 +0200
Message-Id: <20190911144943.21554-2-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the buffer,
when 0 ARM owns it. When processing the buffers in
sdma_update_channel_loop the ownership of the currently processed buffer
was set to SDMA again before running the callback function of the the
buffer and while the sdma script may be running in parallel. So there was
the possibility to get the buffer overwritten by SDMA before it has been
processed by kernel leading to kind of random errors in the upper layers,
e.g. bluetooth.

It may be further a good idea to make the status struct member volatile or
access it using writel or similar to rule out that the compiler sets the
BD_DONE flag before the callback routine has finished.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/dma/imx-sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a01f4b5d793c..1abb14ff394d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		*/
 
 		desc->chn_real_count = bd->mode.count;
-		bd->mode.status |= BD_DONE;
 		bd->mode.count = desc->period_len;
 		desc->buf_ptail = desc->buf_tail;
 		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
@@ -817,6 +816,8 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 		spin_lock(&sdmac->vc.lock);
 
+		bd->mode.status |= BD_DONE;
+
 		if (error)
 			sdmac->status = old_status;
 	}
-- 
2.23.0

