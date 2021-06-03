Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B5839A9A5
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFCSDl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 14:03:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:61165 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhFCSDl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 14:03:41 -0400
IronPort-SDR: KQ9EANFLs7ZTa8tsPUV5zj8Lr9nu5gm04s/+2JPpOu7+8smqpJPHEcfvMvPdHoJ4XIKs/LMNO6
 MqyHnGq3NImw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204135340"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="204135340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:01:38 -0700
IronPort-SDR: DymM4fCgctRMaP8orLTXM4VcLYUmsfXoSy2hvPwQKG3Ll6K9LJ/mXIoIhTMSjxFS3xPsJbLItZ
 Mv//EofMWqbg==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="417474282"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:01:38 -0700
Subject: [PATCH] dmaengine: idxd: have command status always set
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Ramesh Thomas <ramesh.thomas@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 03 Jun 2021 11:01:37 -0700
Message-ID: <162274329740.1822314.3443875665504707588.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The cached command status is only set when the write back status is
is passed in. Move the variable set outside of the check so it is
always set.

Fixes: 0d5c10b4c84d ("dmaengine: idxd: add work queue drain support")
Reported-by: Ramesh Thomas <ramesh.thomas@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 420b93fe5feb..5357dfdd02bb 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -481,6 +481,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	union idxd_command_reg cmd;
 	DECLARE_COMPLETION_ONSTACK(done);
 	unsigned long flags;
+	u32 stat;
 
 	if (idxd_device_is_halted(idxd)) {
 		dev_warn(&idxd->pdev->dev, "Device is HALTED!\n");
@@ -513,11 +514,11 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
 	 */
 	spin_unlock_irqrestore(&idxd->cmd_lock, flags);
 	wait_for_completion(&done);
+	stat = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
 	spin_lock_irqsave(&idxd->cmd_lock, flags);
-	if (status) {
-		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
-		idxd->cmd_status = *status & GENMASK(7, 0);
-	}
+	if (status)
+		*status = stat;
+	idxd->cmd_status = stat & GENMASK(7, 0);
 
 	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
 	/* Wake up other pending commands */


