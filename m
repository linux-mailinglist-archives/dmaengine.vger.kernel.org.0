Return-Path: <dmaengine+bounces-4-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BA7DABB6
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 09:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A65D28173F
	for <lists+dmaengine@lfdr.de>; Sun, 29 Oct 2023 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3C7FB;
	Sun, 29 Oct 2023 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7A2117
	for <dmaengine@vger.kernel.org>; Sun, 29 Oct 2023 08:00:58 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3BC9;
	Sun, 29 Oct 2023 01:00:56 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vv31XWv_1698566451;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0Vv31XWv_1698566451)
          by smtp.aliyun-inc.com;
          Sun, 29 Oct 2023 16:00:52 +0800
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
Subject: [PATCH v1 1/2] dmaengine: idxd: Protect int_handle field in hw descriptor
Date: Sun, 29 Oct 2023 16:00:48 +0800
Message-Id: <20231029080049.1482701-2-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
References: <20231029080049.1482701-1-guanjun@linux.alibaba.com>
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

Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
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


