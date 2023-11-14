Return-Path: <dmaengine+bounces-101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77A7EB009
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 13:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E01281203
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC17A33987;
	Tue, 14 Nov 2023 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCB3FB0C
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 12:43:40 +0000 (UTC)
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6F184;
	Tue, 14 Nov 2023 04:43:37 -0800 (PST)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
	by mail.pcs.gmbh with ESMTPA
	; Tue, 14 Nov 2023 13:22:06 +0100
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
	by mail.csna.de with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
	; Tue, 14 Nov 2023 13:22:06 +0100
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 14 Nov 2023 13:22:06 +0100
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 14 Nov 2023 13:22:06 +0100
Date: Tue, 14 Nov 2023 13:22:06 +0100
From: Thomas Pfaff <tpfaff@pcs.com>
To: <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>
CC: <nicolas.ferre@microchip.com>, <vkoul@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 1/2 stable-6.1] dmaengine: at_hdmac: get next dma transfer
 from the right list
Message-ID: <15c92c2f-71e7-f4fd-b90b-412ab53e5a25@pcs.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14.11.2023 10:04:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled

From: Thomas Pfaff <tpfaff@pcs.com>

In kernel 6.1, atc_advance_work and atc_handle_error are checking for the 
next dma transfer inside active list, but the descriptor is taken from the 
queue instead.

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 858bd64f1313..68c1bfbefc5c 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -490,6 +490,27 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 	}
 }
 
+/**
+ * atc_start_next - start next pending transaction if any
+ * @atchan: channel where the transaction ended
+ *
+ * Called with atchan->lock held
+ */
+static void atc_start_next(struct at_dma_chan *atchan)
+{
+	struct at_desc *desc = NULL;
+
+	if (!list_empty(&atchan->active_list))
+		desc = atc_first_active(atchan);
+	else if (!list_empty(&atchan->queue)) {
+		desc = atc_first_queued(atchan);
+		list_move_tail(&desc->desc_node, &atchan->active_list);
+	}
+
+	if (desc)
+		atc_dostart(atchan, desc);
+}
+
 /**
  * atc_advance_work - at the end of a transaction, move forward
  * @atchan: channel where the transaction ended
@@ -513,11 +534,7 @@ static void atc_advance_work(struct at_dma_chan *atchan)
 
 	/* advance work */
 	spin_lock_irqsave(&atchan->lock, flags);
-	if (!list_empty(&atchan->active_list)) {
-		desc = atc_first_queued(atchan);
-		list_move_tail(&desc->desc_node, &atchan->active_list);
-		atc_dostart(atchan, desc);
-	}
+	atc_start_next(atchan);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 }
 
@@ -529,7 +546,6 @@ static void atc_advance_work(struct at_dma_chan *atchan)
 static void atc_handle_error(struct at_dma_chan *atchan)
 {
 	struct at_desc *bad_desc;
-	struct at_desc *desc;
 	struct at_desc *child;
 	unsigned long flags;
 
@@ -543,11 +559,7 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	list_del_init(&bad_desc->desc_node);
 
 	/* Try to restart the controller */
-	if (!list_empty(&atchan->active_list)) {
-		desc = atc_first_queued(atchan);
-		list_move_tail(&desc->desc_node, &atchan->active_list);
-		atc_dostart(atchan, desc);
-	}
+	atc_start_next(atchan);
 
 	/*
 	 * KERN_CRITICAL may seem harsh, but since this only happens



