Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E13E06DC
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfJVO4B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 10:56:01 -0400
Received: from muru.com ([72.249.23.125]:38830 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJVO4B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 10:56:01 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4734C80FA;
        Tue, 22 Oct 2019 14:56:33 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        George Cherian <george.cherian@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] dmaengine: cppi41: Fix issue with musb and ftdi uart
Date:   Tue, 22 Oct 2019 07:55:45 -0700
Message-Id: <20191022145545.6449-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The first dma call done by musb_ep_program() must wait if cppi41 is PM
runtime suspended. Otherwise musb_ep_program() continues with other
non-dma packets before the DMA transfer is started causing at least ftdi
uarts to fail to receive data.

Let's fix the issue by waking up cppi41 with PM runtime calls added to
cppi41_dma_prep_slave_sg() and return NULL if still idled. This way we
have musb_ep_program() continue with PIO until cppi41 is awake.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Cc: Bin Liu <b-liu@ti.com>
Cc: giulio.benetti@benettiengineering.com
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Skvortsov <andrej.skvortzov@gmail.com>
Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/dma/ti/cppi41.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -586,9 +586,22 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
 	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
 {
 	struct cppi41_channel *c = to_cpp41_chan(chan);
+	struct dma_async_tx_descriptor *txd = NULL;
+	struct cppi41_dd *cdd = c->cdd;
 	struct cppi41_desc *d;
 	struct scatterlist *sg;
 	unsigned int i;
+	int error;
+
+	error = pm_runtime_get(cdd->ddev.dev);
+	if (error < 0) {
+		pm_runtime_put_noidle(cdd->ddev.dev);
+
+		return NULL;
+	}
+
+	if (cdd->is_suspended)
+		goto err_out_not_ready;
 
 	d = c->desc;
 	for_each_sg(sgl, sg, sg_len, i) {
@@ -611,7 +624,13 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
 		d++;
 	}
 
-	return &c->txd;
+	txd = &c->txd;
+
+err_out_not_ready:
+	pm_runtime_mark_last_busy(cdd->ddev.dev);
+	pm_runtime_put_autosuspend(cdd->ddev.dev);
+
+	return txd;
 }
 
 static void cppi41_compute_td_desc(struct cppi41_desc *d)
-- 
2.23.0
