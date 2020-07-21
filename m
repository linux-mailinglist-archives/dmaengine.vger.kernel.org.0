Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85F02288AA
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jul 2020 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgGUS5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jul 2020 14:57:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:54962 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgGUS5N (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jul 2020 14:57:13 -0400
IronPort-SDR: P+qbRrN7QYZlQz9MerLXlQBw4loPxqPEqOm5OC2KpclhbrGLFBIFzKWhjuWckCBwxpyt4Wrffq
 RtKMiuYUtPpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="235077530"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="235077530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 11:57:12 -0700
IronPort-SDR: oDR1fihwK5z0aBbIQHxwMP+qTgnssSKjJNW9HqvnXJ6zDbgeOI5hOkBhtr/FQtK1Z8AXy8vCsl
 LPuEkWPPZ/Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="301708291"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2020 11:57:11 -0700
Subject: [PATCH] dmaengine: idxd: reset states after device disable or reset
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Mona Hossain <mona.hossain@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 21 Jul 2020 11:57:11 -0700
Message-ID: <159535783121.44497.13003335997381621798.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The state for WQs should be reset to disabled when a device is reset or
disabled.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Reported-by: Mona Hossain <mona.hossain@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 14b45853aa5f..d0290072d558 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -414,6 +414,7 @@ int idxd_device_disable(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	u32 status;
+	int i;
 
 	if (!idxd_is_enabled(idxd)) {
 		dev_dbg(dev, "Device is not enabled\n");
@@ -429,13 +430,33 @@ int idxd_device_disable(struct idxd_device *idxd)
 		return -ENXIO;
 	}
 
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		if (wq->state == IDXD_WQ_ENABLED) {
+			idxd_wq_disable_cleanup(wq);
+			wq->state = IDXD_WQ_DISABLED;
+		}
+	}
 	idxd->state = IDXD_DEV_CONF_READY;
 	return 0;
 }
 
 void idxd_device_reset(struct idxd_device *idxd)
 {
+	int i;
+
 	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		if (wq->state == IDXD_WQ_ENABLED) {
+			idxd_wq_disable_cleanup(wq);
+			wq->state = IDXD_WQ_DISABLED;
+		}
+	}
+	idxd->state = IDXD_DEV_CONF_READY;
 }
 
 /* Device configuration bits */

