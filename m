Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A589E1C05BF
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD3TJ2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 15:09:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:54754 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD3TJ2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Apr 2020 15:09:28 -0400
IronPort-SDR: lMXKv8CZd277E7UMwjGhigiRoE18Lsoe8favnKZJB99IxN9TmK6jCK4E1iKm6g0HheH5NalTkM
 6b77iLXJvxBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 12:09:27 -0700
IronPort-SDR: GvWVVWkIfEGBtoExQDC0FzSWhxDHAo5NShZ0MfOhEhH1xWsI3iAdnT16Thtzr3XYVS84MsGQU2
 DKCSDHy4hZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="261879029"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2020 12:09:27 -0700
Subject: [PATCH] dmaengine: idxd: fix interrupt completion after unmasking
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, sanjay.k.kumar@intel.com
Date:   Thu, 30 Apr 2020 12:09:26 -0700
Message-ID: <158827376688.38097.4542597770783489258.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current implementation may miss completions after we unmask the
interrupt. In order to make sure we process all competions, we need to:
1. Do an MMIO read from the device as a barrier to ensure that all PCI
   writes for completions have arrived.
2. Check for any additional completions that we missed.

Fixes: 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    7 +++++++
 drivers/dma/idxd/irq.c    |   24 +++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f6f49f0f6fae..8d79a8787104 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -62,6 +62,13 @@ int idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id)
 	perm.ignore = 0;
 	iowrite32(perm.bits, idxd->reg_base + offset);
 
+	/*
+	 * A readback from the device ensures that any previously generated
+	 * completion record writes are visible to software based on PCI
+	 * ordering rules.
+	 */
+	perm.bits = ioread32(idxd->reg_base + offset);
+
 	return 0;
 }
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index d6fcd2e60103..306c9b9c5c36 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -218,10 +218,9 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 	return queued;
 }
 
-irqreturn_t idxd_wq_thread(int irq, void *data)
+static int idxd_desc_process(struct idxd_irq_entry *irq_entry)
 {
-	struct idxd_irq_entry *irq_entry = data;
-	int rc, processed = 0, retry = 0;
+	int rc, processed, total = 0;
 
 	/*
 	 * There are two lists we are processing. The pending_llist is where
@@ -244,15 +243,26 @@ irqreturn_t idxd_wq_thread(int irq, void *data)
 	 */
 	do {
 		rc = irq_process_work_list(irq_entry, &processed);
-		if (rc != 0) {
-			retry++;
+		total += processed;
+		if (rc != 0)
 			continue;
-		}
 
 		rc = irq_process_pending_llist(irq_entry, &processed);
-	} while (rc != 0 && retry != 10);
+		total += processed;
+	} while (rc != 0);
+
+	return total;
+}
+
+irqreturn_t idxd_wq_thread(int irq, void *data)
+{
+	struct idxd_irq_entry *irq_entry = data;
+	int processed;
 
+	processed = idxd_desc_process(irq_entry);
 	idxd_unmask_msix_vector(irq_entry->idxd, irq_entry->id);
+	/* catch anything unprocessed after unmasking */
+	processed += idxd_desc_process(irq_entry);
 
 	if (processed == 0)
 		return IRQ_NONE;

