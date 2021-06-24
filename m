Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2213B380D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 22:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhFXUpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 16:45:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:25845 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXUpx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 16:45:53 -0400
IronPort-SDR: VaWR29zln8vGIT4g0KeTDPuuQLmq69ceXtPHpYoMDYKnLukJaAySde1/j5N2RS2Xlngi/ZsGKm
 IEYLIlG/cdpA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="187244845"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="187244845"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:43:32 -0700
IronPort-SDR: utiE9GequYX62yq0IWC5eqBANayQZYQoU82XWF5tejJp4wILdE1JaiWS7hkVTlCNVmyGb71nX5
 fTfsOxqzjahA==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="474641300"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:43:32 -0700
Subject: [PATCH] dmaengine: idxd: fix setup sequence for MSIXPERM table
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 24 Jun 2021 13:43:32 -0700
Message-ID: <162456741222.1138073.1298447364671237896.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The MSIX permission table should be programmed BEFORE request_irq()
happens. This prevents any possibility of an interrupt happening before the
MSIX perm table is setup, however slight.

Fixes: 6df0e6c57dfc ("dmaengine: idxd: clear MSIX permission entry on shutdown")
Sign-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2286232ebc7b..dd3aa2b31b1c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -102,6 +102,8 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 		spin_lock_init(&idxd->irq_entries[i].list_lock);
 	}
 
+	idxd_msix_perm_setup(idxd);
+
 	irq_entry = &idxd->irq_entries[0];
 	rc = request_threaded_irq(irq_entry->vector, NULL, idxd_misc_thread,
 				  0, "idxd-misc", irq_entry);
@@ -148,7 +150,6 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	}
 
 	idxd_unmask_error_interrupts(idxd);
-	idxd_msix_perm_setup(idxd);
 	return 0;
 
  err_wq_irqs:
@@ -162,6 +163,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
  err_misc_irq:
 	/* Disable error interrupt generation */
 	idxd_mask_error_interrupts(idxd);
+	idxd_msix_perm_clear(idxd);
  err_irq_entries:
 	pci_free_irq_vectors(pdev);
 	dev_err(dev, "No usable interrupts\n");


