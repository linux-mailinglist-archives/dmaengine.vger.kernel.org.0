Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E740023220A
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2P52 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 11:57:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:41244 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2P51 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Jul 2020 11:57:27 -0400
IronPort-SDR: yoPNbm3ZvIHjhacJ5w0FVf403Vio28WWqGgQ4iPK0dVxhp4qtL3D46QvI6u8uWX3iJv36ejsgl
 W27eeDkyZXDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="169564460"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="169564460"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 08:57:27 -0700
IronPort-SDR: QEZyMpxGUINfBLwfGprKm6qeOaQ7+szO3i/czkK80JHdDxJi5/A9Z6eEj7DFwgVMXX8HGFjoOn
 U2q39SYfB7lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="304264541"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 08:57:26 -0700
Subject: [PATCH] dmaengine: idxd: clear misc interrupt cause after read
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 29 Jul 2020 08:57:26 -0700
Message-ID: <159603824665.28647.5344356370364397996.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the clearing of misc interrupt cause to immediately after reading the
register in order to allow the next interrupt to be asserted.

Suggested-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 1e9e6991f543..17a65a13fb64 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -64,6 +64,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	bool err = false;
 
 	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 
 	if (cause & IDXD_INTC_ERR) {
 		spin_lock_bh(&idxd->dev_lock);
@@ -121,7 +122,6 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		dev_warn_once(dev, "Unexpected interrupt cause bits set: %#x\n",
 			      val);
 
-	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 	if (!err)
 		goto out;
 

