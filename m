Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C291776B8
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2020 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgCCNMO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Mar 2020 08:12:14 -0500
Received: from smaract.com ([82.165.73.54]:46097 "EHLO smaract.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgCCNMO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Mar 2020 08:12:14 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 08:12:13 EST
Received: from mx1.smaract.de (staticdsl-213-168-205-127.ewe-ip-backbone.de [213.168.205.127])
        by smaract.com (Postfix) with ESMTPSA id A1623A17BC;
        Tue,  3 Mar 2020 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smaract.com;
        s=default; t=1583240742;
        bh=AMMfXSx0nmTaloZKYs3RYdMbrVSUtRzPFHkG5Ki/ddU=; l=1669;
        h=Received:From:To:Subject;
        b=mIZ2X5xoYH/wk6XmTWwXBnxWmhTginsbOOBpSc7vCCy6gW79NlU9MnwgKKamE08XP
         H4DOo4Bm/dl+ttTJbYWxV3aQTFNbsdvbCbvi/8wvGpJSxPWyyVAP//l1BTxBq4c+rX
         MlDd9XPUjvMjoWeieisJJrRJEnkEIZXFoEXctQ1Y=
Authentication-Results: smaract.com;
        spf=pass (sender IP is 213.168.205.127) smtp.mailfrom=vonohr@smaract.com smtp.helo=mx1.smaract.de
Received-SPF: pass (smaract.com: connection is authenticated)
Received: from sebastian-VirtualBox.smaract.local (10.100.203.42) by
 ols12mx1.smaract.local (172.16.16.90) with Microsoft SMTP Server (TLS) id
 15.1.225.42; Tue, 3 Mar 2020 14:05:42 +0100
From:   Sebastian von Ohr <vonohr@smaract.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Sebastian von Ohr <vonohr@smaract.com>
Subject: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Date:   Tue, 3 Mar 2020 14:05:18 +0100
Message-ID: <20200303130518.333-1-vonohr@smaract.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ols12mx1.smaract.local (172.16.16.90) To
 ols12mx1.smaract.local (172.16.16.90)
X-PPP-Message-ID: <158324074274.49694.10099073382789235699@smaract.com>
X-PPP-Vhost: mario.smaract.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA transfer might finish just after checking the state with
dma_cookie_status, but before the lock is acquired. Not checking
for an empty list in xilinx_dma_tx_status may result in reading
random data or data corruption when desc is written to. This can
be reliably triggered by using dma_sync_wait to wait for DMA
completion.

Signed-off-by: Sebastian von Ohr <vonohr@smaract.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a9c5d5cc9f2b..5d5f1d0ce16c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1229,16 +1229,16 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 		return ret;
 
 	spin_lock_irqsave(&chan->lock, flags);
-
-	desc = list_last_entry(&chan->active_list,
-			       struct xilinx_dma_tx_descriptor, node);
-	/*
-	 * VDMA and simple mode do not support residue reporting, so the
-	 * residue field will always be 0.
-	 */
-	if (chan->has_sg && chan->xdev->dma_config->dmatype != XDMA_TYPE_VDMA)
-		residue = xilinx_dma_get_residue(chan, desc);
-
+	if (!list_empty(&chan->active_list)) {
+		desc = list_last_entry(&chan->active_list,
+				       struct xilinx_dma_tx_descriptor, node);
+		/*
+		 * VDMA and simple mode do not support residue reporting, so the
+		 * residue field will always be 0.
+		 */
+		if (chan->has_sg && chan->xdev->dma_config->dmatype != XDMA_TYPE_VDMA)
+			residue = xilinx_dma_get_residue(chan, desc);
+	}
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	dma_set_residue(txstate, residue);
-- 
2.17.1

