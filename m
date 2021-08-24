Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384173F6AFA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Aug 2021 23:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhHXVZY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Aug 2021 17:25:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:52528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhHXVZY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Aug 2021 17:25:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204537477"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="204537477"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 14:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="597724658"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 14:24:39 -0700
Subject: [PATCH] dmaengine: idxd: remove interrupt disable for cmd_lock
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 24 Aug 2021 14:24:39 -0700
Message-ID: <162984027930.1939209.15758413737332339204.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The cmd_lock spinlock is not being used in hard interrupt context. There is
no need to disable irq when acquiring the lock. Convert all cmd_lock
acquisition to plain spin_lock() calls.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3e6c4f6f5f8b..83a5ff2ecf2a 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -460,7 +460,6 @@ int idxd_device_init_reset(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
 	union idxd_command_reg cmd;
-	unsigned long flags;
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
@@ -470,13 +469,13 @@ int idxd_device_init_reset(struct idxd_device *idxd)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.cmd = IDXD_CMD_RESET_DEVICE;
 	dev_dbg(dev, "%s: sending reset for init.\n", __func__);
-	spin_lock_irqsave(&idxd->cmd_lock, flags);
+	spin_lock(&idxd->cmd_lock);
 	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
 
 	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) &
 	       IDXD_CMDSTS_ACTIVE)
 		cpu_relax();
-	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
+	spin_unlock(&idxd->cmd_lock);
 	return 0;
 }
 
@@ -485,7 +484,6 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 {
 	union idxd_command_reg cmd;
 	DECLARE_COMPLETION_ONSTACK(done);
-	unsigned long flags;
 	u32 stat;
 
 	if (idxd_device_is_halted(idxd)) {
@@ -500,7 +498,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	cmd.operand = operand;
 	cmd.int_req = 1;
 
-	spin_lock_irqsave(&idxd->cmd_lock, flags);
+	spin_lock(&idxd->cmd_lock);
 	wait_event_lock_irq(idxd->cmd_waitq,
 			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
 			    idxd->cmd_lock);
@@ -517,10 +515,10 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 * After command submitted, release lock and go to sleep until
 	 * the command completes via interrupt.
 	 */
-	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
+	spin_unlock(&idxd->cmd_lock);
 	wait_for_completion(&done);
 	stat = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
-	spin_lock_irqsave(&idxd->cmd_lock, flags);
+	spin_lock(&idxd->cmd_lock);
 	if (status)
 		*status = stat;
 	idxd->cmd_status = stat & GENMASK(7, 0);
@@ -528,7 +526,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
 	/* Wake up other pending commands */
 	wake_up(&idxd->cmd_waitq);
-	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
+	spin_unlock(&idxd->cmd_lock);
 }
 
 int idxd_device_enable(struct idxd_device *idxd)
@@ -636,7 +634,6 @@ int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
 	struct device *dev = &idxd->pdev->dev;
 	u32 operand, status;
 	union idxd_command_reg cmd;
-	unsigned long flags;
 
 	if (!(idxd->hw.cmd_cap & BIT(IDXD_CMD_RELEASE_INT_HANDLE)))
 		return -EOPNOTSUPP;
@@ -654,13 +651,13 @@ int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
 
 	dev_dbg(dev, "cmd: %u operand: %#x\n", IDXD_CMD_RELEASE_INT_HANDLE, operand);
 
-	spin_lock_irqsave(&idxd->cmd_lock, flags);
+	spin_lock(&idxd->cmd_lock);
 	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
 
 	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) & IDXD_CMDSTS_ACTIVE)
 		cpu_relax();
 	status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
-	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
+	spin_unlock(&idxd->cmd_lock);
 
 	if ((status & IDXD_CMDSTS_ERR_MASK) != IDXD_CMDSTS_SUCCESS) {
 		dev_dbg(dev, "release int handle failed: %#x\n", status);


