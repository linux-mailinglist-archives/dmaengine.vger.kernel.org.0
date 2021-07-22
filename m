Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925143D2D69
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhGVTaS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 15:30:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:8260 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhGVTaS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Jul 2021 15:30:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="192005164"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="192005164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:10:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="470787520"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:10:51 -0700
Subject: [PATCH] dmaengine: idxd: fix abort status check
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        dmaengine@vger.kernel.org
Date:   Thu, 22 Jul 2021 13:10:51 -0700
Message-ID: <162698465160.3560828.18173186265683415384.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Coverity static analysis of linux-next found issue.

The check (status == IDXD_COMP_DESC_ABORT) is always false since status
was previously masked with 0x7f and IDXD_COMP_DESC_ABORT is 0xff.

Fixes: 6b4b87f2c31a ("dmaengine: idxd: fix submission race window")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 4e3a7198c0ca..78de2ac1520e 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -269,7 +269,11 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
 
 		if (status) {
-			if (unlikely(status == IDXD_COMP_DESC_ABORT)) {
+			/*
+			 * Check against the original status as ABORT is software defined
+			 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
+			 */
+			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
 				complete_desc(desc, IDXD_COMPLETE_ABORT);
 				(*processed)++;
 				continue;
@@ -333,7 +337,11 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 	list_for_each_entry(desc, &flist, list) {
 		u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
 
-		if (unlikely(status == IDXD_COMP_DESC_ABORT)) {
+		/*
+		 * Check against the original status as ABORT is software defined
+		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
+		 */
+		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
 			complete_desc(desc, IDXD_COMPLETE_ABORT);
 			continue;
 		}


