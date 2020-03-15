Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E571185E4A
	for <lists+dmaengine@lfdr.de>; Sun, 15 Mar 2020 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgCOPuX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Mar 2020 11:50:23 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:30341 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgCOPuX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Mar 2020 11:50:23 -0400
Received: from localhost.localdomain ([93.22.37.174])
        by mwinf5d79 with ME
        id EfqG2200B3lSDvh03fqGhy; Sun, 15 Mar 2020 16:50:18 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Mar 2020 16:50:18 +0100
X-ME-IP: 93.22.37.174
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vkoul@kernel.org, dan.j.williams@intel.com, peter.ujfalusi@ti.com,
        grygorii.strashko@ti.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix an error handling path in 'k3_udma_glue_cfg_rx_flow()'
Date:   Sun, 15 Mar 2020 16:50:15 +0100
Message-Id: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

All but one error handling paths in the 'k3_udma_glue_cfg_rx_flow()'
function 'goto err' and call 'k3_udma_glue_release_rx_flow()'.

This not correct because this function has a 'channel->flows_ready--;' at
the end, but 'flows_ready' has not been incremented here, when we branch to
the error handling path.

In order to keep a correct value in 'flows_ready', un-roll
'k3_udma_glue_release_rx_flow()', simplify it, add some labels and branch
at the correct places when an error is detected.

Doing so, we also NULLify 'flow->udma_rflow' in a path that was lacking it.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine user")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure that the last point of the description is correct. Maybe, the
'xudma_rflow_put / return -ENODEV;' should be kept in order not to
override 'flow->udma_rflow'.
---
 drivers/dma/ti/k3-udma-glue.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index dbccdc7c0ed5..890573eb1625 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -578,12 +578,12 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	if (IS_ERR(flow->udma_rflow)) {
 		ret = PTR_ERR(flow->udma_rflow);
 		dev_err(dev, "UDMAX rflow get err %d\n", ret);
-		goto err;
+		goto err_return;
 	}
 
 	if (flow->udma_rflow_id != xudma_rflow_get_id(flow->udma_rflow)) {
-		xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_rflow_put;
 	}
 
 	/* request and cfg rings */
@@ -592,7 +592,7 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!flow->ringrx) {
 		ret = -ENODEV;
 		dev_err(dev, "Failed to get RX ring\n");
-		goto err;
+		goto err_rflow_put;
 	}
 
 	flow->ringrxfdq = k3_ringacc_request_ring(rx_chn->common.ringacc,
@@ -600,19 +600,19 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!flow->ringrxfdq) {
 		ret = -ENODEV;
 		dev_err(dev, "Failed to get RXFDQ ring\n");
-		goto err;
+		goto err_ringrx_free;
 	}
 
 	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
-		goto err;
+		goto err_ringrxfdq_free;
 	}
 
 	ret = k3_ringacc_ring_cfg(flow->ringrxfdq, &flow_cfg->rxfdq_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringrxfdq %d\n", ret);
-		goto err;
+		goto err_ringrxfdq_free;
 	}
 
 	if (rx_chn->remote) {
@@ -662,7 +662,7 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	if (ret) {
 		dev_err(dev, "flow%d config failed: %d\n", flow->udma_rflow_id,
 			ret);
-		goto err;
+		goto err_ringrxfdq_free;
 	}
 
 	rx_chn->flows_ready++;
@@ -670,8 +670,18 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 		flow->udma_rflow_id, rx_chn->flows_ready);
 
 	return 0;
-err:
-	k3_udma_glue_release_rx_flow(rx_chn, flow_idx);
+
+err_ringrxfdq_free:
+	k3_ringacc_ring_free(flow->ringrxfdq);
+
+err_ringrx_free:
+	k3_ringacc_ring_free(flow->ringrx);
+
+err_rflow_put:
+	xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
+	flow->udma_rflow = NULL;
+
+err_return:
 	return ret;
 }
 
-- 
2.20.1

