Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68818365FF4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhDTTBb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 15:01:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:15326 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233717AbhDTTBb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 15:01:31 -0400
IronPort-SDR: naA/+4NeCK5onSnnCBJ6HMd1D+GYWmkPIFecJLdescEih4JZuImrX8XwlUnqGktRNALnvfzzdB
 obSBx6J2/5Vw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="259525470"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="259525470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:00:57 -0700
IronPort-SDR: IvXjH/O9inuc2aLSRyzGXB5roQHvJ9Fc2zcrEL/CsxwTLCzQCXXDrIX3M0rmj3wB2yOyIyXc5h
 KVVkQV+MObrw==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="401167645"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:00:57 -0700
Subject: [PATCH] dmaengine: idxd: device cmd should use dedicated lock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 12:00:56 -0700
Message-ID: <161894525685.3210132.16160045731436382560.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Create a dedicated lock for device command operations. Put the device
command operation under finer grained locking instead of using the
idxd->dev_lock.

Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   18 +++++++++---------
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/init.c   |    1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3934e660d951..420b93fe5feb 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -465,13 +465,13 @@ int idxd_device_init_reset(struct idxd_device *idxd)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = IDXD_CMD_RESET_DEVICE;
 	dev_dbg(dev, "%s: sending reset for init.\n", __func__);
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
 
 	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) &
 	       IDXD_CMDSTS_ACTIVE)
 		cpu_relax();
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	return 0;
 }
 
@@ -494,10 +494,10 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	cmd.operand = operand;
 	cmd.int_req = 1;
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	wait_event_lock_irq(idxd->cmd_waitq,
 			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
-			    idxd->dev_lock);
+			    idxd->cmd_lock);
 
 	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
 		__func__, cmd_code, operand);
@@ -511,9 +511,9 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 * After command submitted, release lock and go to sleep until
 	 * the command completes via interrupt.
 	 */
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	wait_for_completion(&done);
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	if (status) {
 		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
 		idxd->cmd_status = *status & GENMASK(7, 0);
@@ -522,7 +522,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
 	/* Wake up other pending commands */
 	wake_up(&idxd->cmd_waitq);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 }
 
 int idxd_device_enable(struct idxd_device *idxd)
@@ -667,13 +667,13 @@ int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
 
 	dev_dbg(dev, "cmd: %u operand: %#x\n", IDXD_CMD_RELEASE_INT_HANDLE, operand);
 
-	spin_lock_irqsave(&idxd->dev_lock, flags);
+	spin_lock_irqsave(&idxd->cmd_lock, flags);
 	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
 
 	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) & IDXD_CMDSTS_ACTIVE)
 		cpu_relax();
 	status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 
 	if ((status & IDXD_CMDSTS_ERR_MASK) != IDXD_CMDSTS_SUCCESS) {
 		dev_dbg(dev, "release int handle failed: %#x\n", status);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7237f3e15a5e..97c96ca6ab70 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -204,6 +204,7 @@ struct idxd_device {
 	void __iomem *reg_base;
 
 	spinlock_t dev_lock;	/* spinlock for device */
+	spinlock_t cmd_lock;	/* spinlock for device commands */
 	struct completion *cmd_done;
 	struct idxd_group **groups;
 	struct idxd_wq **wqs;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 36b33eef5aa2..8003f8a25fff 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -449,6 +449,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	}
 
 	spin_lock_init(&idxd->dev_lock);
+	spin_lock_init(&idxd->cmd_lock);
 
 	return idxd;
 }


