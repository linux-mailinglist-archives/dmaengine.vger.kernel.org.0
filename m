Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593A255089
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0VYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 17:24:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:47683 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgH0VYt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 Aug 2020 17:24:49 -0400
IronPort-SDR: 8CatsQierH9ZfRdNXdS/OQ4ji1RPSGJ3jB4FEhmHIFTY1+WaYnAxq3iSFxBtqrvC1xPv7OwY8w
 qfN8p/Skznpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="241383946"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="241383946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 14:24:48 -0700
IronPort-SDR: mtYn0FoPZLPApruL8pjQ9DWFTJRPf+agxSWP3Xsg2v+JRM1i2Ree4etrio1o9QTqabN/ISGI8c
 a2dl9RuFuxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="323755189"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2020 14:24:48 -0700
Subject: [PATCH] dmaengine: idxd: add command status to idxd sysfs attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 27 Aug 2020 14:24:48 -0700
Message-ID: <159856348828.3418.7745506843326238999.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Export admin command status to sysfs attribute in order to allow user to
retrieve configuration error. Allows user tooling to retrieve the command
error and provide more user friendly error messages.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    6 +++++-
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |   10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 00dab1465ca3..bdca1bc55cfa 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -368,6 +368,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
 		__func__, cmd_code, operand);
 
+	idxd->cmd_status = 0;
 	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
 	idxd->cmd_done = &done;
 	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
@@ -379,8 +380,11 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	wait_for_completion(&done);
 	spin_lock_irqsave(&idxd->dev_lock, flags);
-	if (status)
+	if (status) {
 		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
+		idxd->cmd_status = *status & 0xff;
+	}
+
 	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
 	/* Wake up other pending commands */
 	wake_up(&idxd->cmd_waitq);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index e8bec6eb9f7e..c64df197e724 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -156,6 +156,7 @@ struct idxd_device {
 	unsigned long flags;
 	int id;
 	int major;
+	u8 cmd_status;
 
 	struct pci_dev *pdev;
 	void __iomem *reg_base;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index c5f19802cb9e..1db8d021f5ae 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1395,6 +1395,15 @@ static ssize_t cdev_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(cdev_major);
 
+static ssize_t cmd_status_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
+
+	return sprintf(buf, "%#x\n", idxd->cmd_status);
+}
+static DEVICE_ATTR_RO(cmd_status);
+
 static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_version.attr,
 	&dev_attr_max_groups.attr,
@@ -1413,6 +1422,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_max_tokens.attr,
 	&dev_attr_token_limit.attr,
 	&dev_attr_cdev_major.attr,
+	&dev_attr_cmd_status.attr,
 	NULL,
 };
 

