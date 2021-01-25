Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF50E302EB9
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 23:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbhAYWId (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Jan 2021 17:08:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:44199 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733103AbhAYWGM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Jan 2021 17:06:12 -0500
IronPort-SDR: Wc5jgjOu5RMPR5NymNRuMfy+21rbOZLs6CygARw71IJ7rhthBELhWB0F9skaWn2R+wAWciDZcO
 WnAsVbBgYJIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="167484044"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="167484044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 14:05:13 -0800
IronPort-SDR: WKH2VipUhMunVEUwEHWU/zo+O30lZr7qGzyHYbSwYNTfpqPVIXSQc2U02oSUTAiPlHrIeCEqOe
 G0BIzuQDWLuA==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="472515304"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 14:05:13 -0800
Subject: [PATCH] dmaengine: idxd: check device state before issue command
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 25 Jan 2021 15:05:13 -0700
Message-ID: <161161231309.406594.6061304765472136401.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/device.c |   25 ++++++++++++++++++++++++-
 drivers/dma/idxd/idxd.h   |    2 +-
 drivers/dma/idxd/init.c   |    5 ++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 95f94a3ed6be..45077727ce5b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -398,17 +398,33 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
 	return false;
 }
 
+static inline bool idxd_device_is_halted(struct idxd_device *idxd)
+{
+	union gensts_reg gensts;
+
+	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
+
+	if (gensts.state == IDXD_DEVICE_STATE_HALT)
+		return true;
+	return false;
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
@@ -419,6 +435,7 @@ void idxd_device_init_reset(struct idxd_device *idxd)
 	       IDXD_CMDSTS_ACTIVE)
 		cpu_relax();
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	return 0;
 }
 
 static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
@@ -428,6 +445,12 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
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


