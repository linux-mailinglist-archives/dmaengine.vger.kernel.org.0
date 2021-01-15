Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269772F8816
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 23:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbhAOWCe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 17:02:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:65242 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhAOWCe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 17:02:34 -0500
IronPort-SDR: DkrxCtptYFjn8gwBwGpdkz+jN8azyJy2TVNOYVwurDrVEigzZV7CNwIoYinYhP75Wt2S1W7Isw
 EPzh82JgP/Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="263409127"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="263409127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 14:01:50 -0800
IronPort-SDR: 0IWnxSea29MAoEXV1ZCn//rKl21Zxv7BozNAnCj3htVqLReG9CfI2q/nfwlVRchXJDoYy6UV9g
 B/NZ5OM/z/4g==
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="354461486"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 14:01:50 -0800
Subject: [PATCH] dmaengine: idxd: add module parameter to force disable of SVA
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 15 Jan 2021 15:01:50 -0700
Message-ID: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a module parameter that overrides the SVA feature enabling. This keeps
the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
the descriptor fields must be programmed with dma_addr_t from the Linux DMA
API for source, destination, and completion descriptors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 25cc947c6179..9687a24ff982 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
 
+static bool sva = true;
+module_param(sva, bool, 0644);
+MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
+
 #define DRV_NAME "idxd"
 
 bool support_enqcmd;
@@ -338,12 +342,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	idxd_device_init_reset(idxd);
 	dev_dbg(dev, "IDXD reset complete\n");
 
-	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM)) {
+	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
 		rc = idxd_enable_system_pasid(idxd);
 		if (rc < 0)
 			dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
 		else
 			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+	} else if (!sva) {
+		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
 
 	idxd_read_caps(idxd);


