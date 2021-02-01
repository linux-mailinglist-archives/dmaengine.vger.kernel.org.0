Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9604730AB3B
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhBAP1V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 10:27:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:13436 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBAP04 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 10:26:56 -0500
IronPort-SDR: PrbVy7omAVUHobl4LrZb8yDPnUm65kUfDoL7MjcwQwOI/kKocBUo8oWyknlFG5LJgPwt263emy
 fH7e4j4WvvGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="159868317"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="159868317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:26:15 -0800
IronPort-SDR: TRt2rka90dlsEurYXZDNpQsG43M8gzpBY4J2xuA6qaV9R2pmtvHtYwYql1C1C1sP8jxMEg18Ny
 7b4NPNjdpffg==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369899123"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:26:14 -0800
Subject: [PATCH v2] dmaengine: idxd: check device state before issue command
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 01 Feb 2021 08:26:14 -0700
Message-ID: <161219313921.2976211.12222625226450097465.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device state check before executing command. Without the check the
command can be issued while device is in halt state and causes the driver to
block while waiting for the completion of the command.

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Fixes: 0d5c10b4c84d ("dmaengine: idxd: add work queue drain support")
---

v2:
- simplify idxd_device_is_halted() return code (Vinod)

 drivers/dma/idxd/device.c |   23 ++++++++++++++++++++++-
 drivers/dma/idxd/idxd.h   |    2 +-
 drivers/dma/idxd/init.c   |    5 ++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 95f94a3ed6be..84a6ea60ecf0 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -398,17 +398,31 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
 	return false;
 }
 
+static inline bool idxd_device_is_halted(struct idxd_device *idxd)
+{
+	union gensts_reg gensts;
+
+	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
+
+	return (gensts.state == IDXD_DEVICE_STATE_HALT);
+}
+
 /*
  * This is function is only used for reset during probe and will
  * poll for completion. Once the device is setup with interrupts,
  * all commands will be done via interrupt completion.
  */
-void idxd_device_init_reset(struct idxd_device *idxd)
+int idxd_device_init_reset(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	union idxd_command_reg cmd;
 	unsigned long flags;
 
+	if (idxd_device_is_halted(idxd)) {
+		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
+		return -ENXIO;
+	}
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = IDXD_CMD_RESET_DEVICE;
 	dev_dbg(dev, "%s: sending reset for init.\n", __func__);
@@ -419,6 +433,7 @@ void idxd_device_init_reset(struct idxd_device *idxd)
 	       IDXD_CMDSTS_ACTIVE)
 		cpu_relax();
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	return 0;
 }
 
 static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
@@ -428,6 +443,12 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	DECLARE_COMPLETION_ONSTACK(done);
 	unsigned long flags;
 
+	if (idxd_device_is_halted(idxd)) {
+		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
+		*status = IDXD_CMDSTS_HW_ERR;
+		return;
+	}
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = cmd_code;
 	cmd.operand = operand;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 5a50e91c71bf..81a0e65fd316 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -326,7 +326,7 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
-void idxd_device_init_reset(struct idxd_device *idxd);
+int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
 void idxd_device_reset(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2c051e07c34c..fa04acd5582a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -335,7 +335,10 @@ static int idxd_probe(struct idxd_device *idxd)
 	int rc;
 
 	dev_dbg(dev, "%s entered and resetting device\n", __func__);
-	idxd_device_init_reset(idxd);
+	rc = idxd_device_init_reset(idxd);
+	if (rc < 0)
+		return rc;
+
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM)) {


