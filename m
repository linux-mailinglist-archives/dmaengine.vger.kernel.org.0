Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40544640D17
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiLBSZX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiLBSZS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 13:25:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B3D9697;
        Fri,  2 Dec 2022 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670005518; x=1701541518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HnbQEP+pYHTspRPq2P1wRPnq956BiDmItso67GhhB1k=;
  b=ZKI9AiDf/LSV3VGC4Pv/MMYR+rRIy0Qhi0VO/kRXW6URhXRe/J4I1ZgW
   5US4uOlQJf8qIiVuKv6TCezXVdhkpd935Ji6uneVXhzCszkxQBpCrFNKO
   Cn7XOyFohbQ24ZQkjjwzlRLsyORGDvjbkDW5KrCErB6PTVg3QENlVsgfo
   pRbREkrlGZgG9CLDtrib9whDXDGChnHITiX0ZkNsWaE1vOhb44PzI88pS
   /aBqTIjOoWENC2sz2UsHbcwjDvV5V+tWtWbmhROE/QrVoGU+hVlYYAljG
   V81+uWjrveRVYsUJ77Xx4LaNnpDDFpIPyrMQWMc71lBNhRahPDBw02OER
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378166724"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378166724"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622786443"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622786443"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dmaengine: idxd: Do not call DMX TX callbacks during workqueue disable
Date:   Fri,  2 Dec 2022 10:25:06 -0800
Message-Id: <93b5d144bfc16e0c0f640d5f7cfaeda6bf08753f.1670005163.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670005163.git.reinette.chatre@intel.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On driver unload any pending descriptors are flushed and pending
DMA descriptors are explicitly completed:
idxd_dmaengine_drv_remove() ->
	drv_disable_wq() ->
		idxd_wq_free_irq() ->
			idxd_flush_pending_descs() ->
				idxd_dma_complete_txd()

With this done during driver unload any remaining descriptor is
likely stuck and can be dropped. Even so, the descriptor may still
have a callback set that could no longer be accessible. An
example of such a problem is when the dmatest fails and the dmatest
module is unloaded. The failure of dmatest leaves descriptors with
dma_async_tx_descriptor::callback pointing to code that no longer
exist. This causes a page fault as below at the time the IDXD driver
is unloaded when it attempts to run the callback:
 BUG: unable to handle page fault for address: ffffffffc0665190
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page

Fix this by clearing the callback pointers on the transmit
descriptors only when workqueue is disabled.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---

History of refactoring made the Fixes: hard to identify by me.

 drivers/dma/idxd/device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b4d7bb923a40..2ac71a34fa34 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1156,6 +1156,7 @@ int idxd_device_load_config(struct idxd_device *idxd)
 
 static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
 {
+	struct dma_async_tx_descriptor *tx;
 	struct idxd_desc *desc, *itr;
 	struct llist_node *head;
 	LIST_HEAD(flist);
@@ -1175,6 +1176,15 @@ static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
 	list_for_each_entry_safe(desc, itr, &flist, list) {
 		list_del(&desc->list);
 		ctype = desc->completion->status ? IDXD_COMPLETE_NORMAL : IDXD_COMPLETE_ABORT;
+		/*
+		 * wq is being disabled. Any remaining descriptors are
+		 * likely to be stuck and can be dropped. callback could
+		 * point to code that is no longer accessible, for example
+		 * if dmatest module has been unloaded.
+		 */
+		tx = &desc->txd;
+		tx->callback = NULL;
+		tx->callback_result = NULL;
 		idxd_dma_complete_txd(desc, ctype, true);
 	}
 }
-- 
2.34.1

