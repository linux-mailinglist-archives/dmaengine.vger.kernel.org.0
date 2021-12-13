Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7547345B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhLMSva (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 13:51:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:24986 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhLMSva (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 Dec 2021 13:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639421490; x=1670957490;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5mGrkgvbkMrgJxiOxwBTCCTy2WWGXgnb831DoDPL8VE=;
  b=BJ8eJ8Sjj9FtpB3HkmLZaCZRrBzfEnRdG/WzIFMQebYGvOEdc940uWSS
   +A+Stxm7izI+Vi8a3Ec82ZfWxjNdk1kgOu/1VCbVMw+6jmxRFkGSPvmv4
   1B7KQgxxS/IXjCoIpb0UFBfz3X80MbNnF3jKVL1LhJLa4MFOI726GJlQw
   07Bvij7bqrMgshmPVQG8DEm60iSQa/WzqraUtY+JNcGvD1O6AtEsodJHa
   6UgdL1pIYYDSzn1/jH32AlaqaslOhBTV3iG93xrEjYnZ5+zg5ftH7oLr2
   y0pVXFrRysx+R1XgJ4fR7bjdOlE+0I9oh49pqPxNvREmlUToifv5l8Uao
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236333765"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="236333765"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:51:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="754437626"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:51:29 -0800
Subject: [PATCH 2/3] dmaengine: idxd: fix descriptor flushing locking
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 13 Dec 2021 11:51:29 -0700
Message-ID: <163942148935.2412839.18282664745572777280.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163942143944.2412839.16850082171909136030.stgit@djiang5-desk3.ch.intel.com>
References: <163942143944.2412839.16850082171909136030.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The descriptor flushing for shutdown is not holding the irq_entry list
lock. If there's ongoing interrupt completion handling, this can corrupt
the list. Add locking to protect list walking. Also refactor the code so
it's more compact.

Fixes: 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 29c732a94027..03c735727f68 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -689,26 +689,28 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return rc;
 }
 
-static void idxd_flush_pending_llist(struct idxd_irq_entry *ie)
+static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
 {
 	struct idxd_desc *desc, *itr;
 	struct llist_node *head;
+	LIST_HEAD(flist);
+	enum idxd_complete_type ctype;
 
+	spin_lock(&ie->list_lock);
 	head = llist_del_all(&ie->pending_llist);
-	if (!head)
-		return;
-
-	llist_for_each_entry_safe(desc, itr, head, llnode)
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
-}
+	if (head) {
+		llist_for_each_entry_safe(desc, itr, head, llnode)
+			list_add_tail(&desc->list, &ie->work_list);
+	}
 
-static void idxd_flush_work_list(struct idxd_irq_entry *ie)
-{
-	struct idxd_desc *desc, *iter;
+	list_for_each_entry_safe(desc, itr, &ie->work_list, list)
+		list_move_tail(&desc->list, &flist);
+	spin_unlock(&ie->list_lock);
 
-	list_for_each_entry_safe(desc, iter, &ie->work_list, list) {
+	list_for_each_entry_safe(desc, itr, &flist, list) {
 		list_del(&desc->list);
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
+		ctype = desc->completion->status ? IDXD_COMPLETE_NORMAL : IDXD_COMPLETE_ABORT;
+		idxd_dma_complete_txd(desc, ctype, true);
 	}
 }
 
@@ -762,8 +764,7 @@ static void idxd_shutdown(struct pci_dev *pdev)
 		synchronize_irq(irq_entry->vector);
 		if (i == 0)
 			continue;
-		idxd_flush_pending_llist(irq_entry);
-		idxd_flush_work_list(irq_entry);
+		idxd_flush_pending_descs(irq_entry);
 	}
 	flush_workqueue(idxd->wq);
 }


