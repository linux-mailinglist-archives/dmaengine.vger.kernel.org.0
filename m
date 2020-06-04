Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012531EDA93
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 03:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgFDBoD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 21:44:03 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:34810 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgFDBoD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 21:44:03 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 21:44:02 EDT
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id C4C52D7763;
        Thu,  4 Jun 2020 09:36:48 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3328T139696376096512S1591234607300874_;
        Thu, 04 Jun 2020 09:36:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cc566ee1aa824e72eaab51d6fe3dc3fa>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: vkoul@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sugar Zhang <sugar.zhang@rock-chips.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: pl330: Make sure the debug is idle before doing DMAGO
Date:   Thu,  4 Jun 2020 09:36:38 +0800
Message-Id: <1591234598-78919-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

According to the datasheet of pl330:

Example 2-1 Using DMAGO with the debug instruction registers

1. Create a program for the DMA channel
2. Store the program in a region of system memory
3. Poll the DBGSTATUS Register to ensure that the debug is idle
4. Write to the DBGINST0 Register
5. Write to the DBGINST1 Register
6. Write zero to the DBGCMD Register

so, we should make sure the debug is idle before step 4/5/6, not
only step 6. if not, there maybe a risk that fail to write DBGINST0/1.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 drivers/dma/pl330.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 88b884c..6a158ee 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -885,6 +885,12 @@ static inline void _execute_DBGINSN(struct pl330_thread *thrd,
 	void __iomem *regs = thrd->dmac->base;
 	u32 val;
 
+	/* If timed out due to halted state-machine */
+	if (_until_dmac_idle(thrd)) {
+		dev_err(thrd->dmac->ddma.dev, "DMAC halted!\n");
+		return;
+	}
+
 	val = (insn[0] << 16) | (insn[1] << 24);
 	if (!as_manager) {
 		val |= (1 << 0);
@@ -895,12 +901,6 @@ static inline void _execute_DBGINSN(struct pl330_thread *thrd,
 	val = le32_to_cpu(*((__le32 *)&insn[2]));
 	writel(val, regs + DBGINST1);
 
-	/* If timed out due to halted state-machine */
-	if (_until_dmac_idle(thrd)) {
-		dev_err(thrd->dmac->ddma.dev, "DMAC halted!\n");
-		return;
-	}
-
 	/* Get going */
 	writel(0, regs + DBGCMD);
 }
-- 
2.7.4



