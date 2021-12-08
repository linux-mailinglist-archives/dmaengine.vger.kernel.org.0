Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAD46D91D
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 18:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhLHRFC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 12:05:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:44720 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhLHRFC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Dec 2021 12:05:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="324130623"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="324130623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:01:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="515835863"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:01:27 -0800
Subject: [PATCH] dmaengine: idxd: fix missed completion on abort path
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Ming Li <ming4.li@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 08 Dec 2021 10:01:27 -0700
Message-ID: <163898288714.443911.16084982766671976640.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Ming reported that with the abort path of the descriptor submission, there
can be a window where a completed descriptor can be missed to be completed
by the irq completion thread:

CPU A				CPU B
Submit (successful)

Submit (fail)
				irq_process_work_list() // empty

llist_abort_desc()
// remove all descs from pending list

				irq_process_pending_llist() // empty
				exit idxd_wq_thread() with no processing

Add opportunistic descriptor completion in the abort path in order to
remove the missed completion.

Fixes: 6b4b87f2c31a ("dmaengine: idxd: fix submission race window")
Reported-by: Ming Li <ming4.li@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index de76fb4abac2..83452fbbb168 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -106,6 +106,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 {
 	struct idxd_desc *d, *t, *found = NULL;
 	struct llist_node *head;
+	LIST_HEAD(flist);
 
 	desc->completion->status = IDXD_COMP_DESC_ABORT;
 	/*
@@ -120,7 +121,11 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 				found = desc;
 				continue;
 			}
-			list_add_tail(&desc->list, &ie->work_list);
+
+			if (d->completion->status)
+				list_add_tail(&d->list, &flist);
+			else
+				list_add_tail(&d->list, &ie->work_list);
 		}
 	}
 
@@ -130,6 +135,17 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 
 	if (found)
 		complete_desc(found, IDXD_COMPLETE_ABORT);
+
+	/*
+	 * complete_desc() will return desc to allocator and the desc can be
+	 * acquired by a different process and the desc->list can be modified.
+	 * Delete desc from list so the list trasversing does not get corrupted
+	 * by the other process.
+	 */
+	list_for_each_entry_safe(d, t, &flist, list) {
+		list_del_init(&d->list);
+		complete_desc(d, IDXD_COMPLETE_NORMAL);
+	}
 }
 
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)


