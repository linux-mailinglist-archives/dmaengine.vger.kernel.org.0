Return-Path: <dmaengine+bounces-21-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5E7DC48B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52471B20D6A
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF67F2;
	Tue, 31 Oct 2023 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E515CF
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:37:13 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A88C5;
	Mon, 30 Oct 2023 19:37:07 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvFqPhN_1698719822;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFqPhN_1698719822)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:37:03 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: dave.jiang@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	tony.luck@intel.com,
	fenghua.yu@intel.com
Cc: jing.lin@intel.com,
	ashok.raj@intel.com,
	sanjay.k.kumar@intel.com,
	megha.dey@intel.com,
	jacob.jun.pan@intel.com,
	yi.l.liu@intel.com,
	tglx@linutronix.de
Subject: [PATCH v3 1/2] dmaengine: idxd: Protect int_handle field in hw descriptor
Date: Tue, 31 Oct 2023 10:36:59 +0800
Message-Id: <20231031023700.1515974-2-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
References: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

The int_handle field in hw descriptor should also be protected
by wmb() before possibly triggering a DMA read.

Fixes: ec0d64231615 (dmaengine: idxd: embed irq_entry in idxd_wq struct)
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/submit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index c01db23e3333..3f922518e3a5 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -182,13 +182,6 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 
 	portal = idxd_wq_portal_addr(wq);
 
-	/*
-	 * The wmb() flushes writes to coherent DMA data before
-	 * possibly triggering a DMA read. The wmb() is necessary
-	 * even on UP because the recipient is a device.
-	 */
-	wmb();
-
 	/*
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
@@ -199,6 +192,13 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 		llist_add(&desc->llnode, &ie->pending_llist);
 	}
 
+	/*
+	 * The wmb() flushes writes to coherent DMA data before
+	 * possibly triggering a DMA read. The wmb() is necessary
+	 * even on UP because the recipient is a device.
+	 */
+	wmb();
+
 	if (wq_dedicated(wq)) {
 		iosubmit_cmds512(portal, desc->hw, 1);
 	} else {
-- 
2.39.3


