Return-Path: <dmaengine+bounces-468-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88180E15A
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 03:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667031F21BE0
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35A23AE;
	Tue, 12 Dec 2023 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lt/SCGt5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A457D5
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 18:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702347724; x=1733883724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SsZ0Cj1VCqg3K4TCYEE+ZPILHx6tGaNBNDo3BJFIN2o=;
  b=Lt/SCGt5jLvvGsPpT3rJArXsLfnGBJGBMlzFjqoMTd2OiYV33CS7Ffij
   nr6aoIR8TlD8eGXrBkR4x5cP2y8dN7Fk9dC7lwDa7f91w06Vu3iNxnFFw
   4ubJ9Z5XPFRNl8+u6yJcdCujAowcFCBhf8hLsqUn7k2ZbqVHQNi2yjSdF
   EZOf7Gu4kMidIxm/EdP9vmrsEzEssxeRxyeeFPV+u1/+ZVJDTNf0v6Jcq
   D8hG99NLhMwBbW7N9NLxaNvoCM1rJt3a47MPkwgpsjCwQJ0N5SvK2O0Z5
   wK360KPsbGo5hvH79nhSYJTvS0dZp5K/wlLR96t103kA0RRZcWslaODX6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461217910"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461217910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:22:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="807556776"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="807556776"
Received: from rex-z390-aorus-pro.sh.intel.com ([10.239.161.21])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2023 18:22:00 -0800
From: Rex Zhang <rex.zhang@intel.com>
To: vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: dave.jiang@intel.com,
	fenghua.yu@intel.com,
	rex.zhang@intel.com
Subject: [PATCH] dmaengine: idxd: Move dma_free_coherent() out of spinlocked context
Date: Tue, 12 Dec 2023 10:21:57 +0800
Message-Id: <20231212022158.358619-1-rex.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Task may be rescheduled within dma_free_coherent(). So dma_free_coherent()
can't be called between spin_lock() and spin_unlock() to avoid Call Trace:
    Call Trace:
    <TASK>
    dump_stack_lvl+0x37/0x50
    __might_resched+0x16a/0x1c0
    vunmap+0x2c/0x70
    __iommu_dma_free+0x96/0x100
    idxd_device_evl_free+0xd5/0x100 [idxd]
    device_release_driver_internal+0x197/0x200
    unbind_store+0xa1/0xb0
    kernfs_fop_write_iter+0x120/0x1c0
    vfs_write+0x2d3/0x400
    ksys_write+0x63/0xe0
    do_syscall_64+0x44/0xa0
    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
Move it out of the context.

Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
Signed-off-by: Rex Zhang <rex.zhang@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8f754f922217..fa0f880beae6 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -802,6 +802,9 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 
 static void idxd_device_evl_free(struct idxd_device *idxd)
 {
+	void *evl_log;
+	unsigned int evl_log_size;
+	dma_addr_t evl_dma;
 	union gencfg_reg gencfg;
 	union genctrl_reg genctrl;
 	struct device *dev = &idxd->pdev->dev;
@@ -822,11 +825,15 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET);
 	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET + 8);
 
-	dma_free_coherent(dev, evl->log_size, evl->log, evl->dma);
 	bitmap_free(evl->bmap);
+	evl_log = evl->log;
+	evl_log_size = evl->log_size;
+	evl_dma = evl->dma;
 	evl->log = NULL;
 	evl->size = IDXD_EVL_SIZE_MIN;
 	spin_unlock(&evl->lock);
+
+	dma_free_coherent(dev, evl_log_size, evl_log, evl_dma);
 }
 
 static void idxd_group_config_write(struct idxd_group *group)
-- 
2.25.1


