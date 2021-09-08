Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579E740418E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Sep 2021 01:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhIHXFN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 19:05:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:2301 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhIHXFN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 19:05:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200822188"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="200822188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 16:04:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="430833156"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 16:04:03 -0700
Subject: [PATCH] dmaengine: idxd: add halt interrupt support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:04:03 -0700
Message-ID: <163114224352.846654.14334468363464318828.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add halt interrupt support. Given that the misc interrupt handler already
check halt state, the driver just need to run the halt handling code when
receiving the halt interrupt.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c       |    5 +++++
 drivers/dma/idxd/registers.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index ca88fa7a328e..3261ea247e83 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -63,6 +63,9 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 	int i;
 	bool err = false;
 
+	if (cause & IDXD_INTC_HALT_STATE)
+		goto halt;
+
 	if (cause & IDXD_INTC_ERR) {
 		spin_lock(&idxd->dev_lock);
 		for (i = 0; i < 4; i++)
@@ -121,6 +124,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 	if (!err)
 		return 0;
 
+halt:
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
 		idxd->state = IDXD_DEV_HALTED;
@@ -134,6 +138,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			queue_work(idxd->wq, &idxd->work);
 		} else {
 			spin_lock(&idxd->dev_lock);
+			idxd->state = IDXD_DEV_HALTED;
 			idxd_wqs_quiesce(idxd);
 			idxd_wqs_unmap_portal(idxd);
 			idxd_device_clear_state(idxd);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index ffc7550a77ee..97ffb06de9b0 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -158,6 +158,7 @@ enum idxd_device_reset_type {
 #define IDXD_INTC_CMD			0x02
 #define IDXD_INTC_OCCUPY			0x04
 #define IDXD_INTC_PERFMON_OVFL		0x08
+#define IDXD_INTC_HALT_STATE		0x10
 
 #define IDXD_CMD_OFFSET			0xa0
 union idxd_command_reg {


