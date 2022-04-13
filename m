Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA964FF604
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiDMLtd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDMLtc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 07:49:32 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 04:47:11 PDT
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0C853B42;
        Wed, 13 Apr 2022 04:47:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1FA2F454CF;
        Wed, 13 Apr 2022 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1649849861; x=
        1651664262; bh=nt+H8nVF77Sn8FWBw2z4vHK5Yf8N/vEddSQZADOz7cI=; b=g
        wSfw8944Ohmpty+OhSWeCRQ00owtwkGboucBHqPVydB2BEGYwfi/nhj1j9GxFPTE
        m53YgW3+0BH3ZivTH8WxxC/1Y7wiQsvxBby0vZt696ZWrT0UfB0dIAv4T5DYgsmg
        mDcSSNURm6C4T3U/n6aPfdcfh3x5K2gBNuiInR66jQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WC27he5aZ9y8; Wed, 13 Apr 2022 14:37:41 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3B3E645490;
        Wed, 13 Apr 2022 14:37:41 +0300 (MSK)
Received: from ubuntu.yadro.com (10.199.0.41) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 Apr 2022 14:37:39 +0300
From:   <i.m.novikov@yadro.com>
To:     <sanju.mehta@amd.com>
CC:     <i.m.novikov@yadro.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@yadro.com>
Subject: [PATCH] dmaengine: PTDMA: support polled mode
Date:   Wed, 13 Apr 2022 14:37:33 +0300
Message-ID: <20220413113733.59041-1-i.m.novikov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.41]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Ilya Novikov <i.m.novikov@yadro.com>

If the DMA_PREP_INTERRUPT flag is not provided, run in polled mode,
which significantly improves IOPS: more than twice on chunks < 4K.

Signed-off-by: Ilya Novikov <i.m.novikov@yadro.com>
---
 drivers/dma/ptdma/ptdma-dev.c       | 36 +++++++++++++++--------------
 drivers/dma/ptdma/ptdma-dmaengine.c | 16 ++++++++++++-
 drivers/dma/ptdma/ptdma.h           | 13 +++++++++++
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index daafea5bc35d..377da23012ac 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -100,6 +100,7 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 			     struct pt_passthru_engine *pt_engine)
 {
 	struct ptdma_desc desc;
+	struct pt_device *pt = container_of(cmd_q, struct pt_device, cmd_q);
 
 	cmd_q->cmd_error = 0;
 	cmd_q->total_pt_ops++;
@@ -111,17 +112,12 @@ int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 	desc.dst_lo = lower_32_bits(pt_engine->dst_dma);
 	desc.dw5.dst_hi = upper_32_bits(pt_engine->dst_dma);
 
-	return pt_core_execute_cmd(&desc, cmd_q);
-}
-
-static inline void pt_core_disable_queue_interrupts(struct pt_device *pt)
-{
-	iowrite32(0, pt->cmd_q.reg_control + 0x000C);
-}
+	if (cmd_q->int_en)
+		pt_core_enable_queue_interrupts(pt);
+	else
+		pt_core_disable_queue_interrupts(pt);
 
-static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
-{
-	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_control + 0x000C);
+	return pt_core_execute_cmd(&desc, cmd_q);
 }
 
 static void pt_do_cmd_complete(unsigned long data)
@@ -144,14 +140,10 @@ static void pt_do_cmd_complete(unsigned long data)
 	cmd->pt_cmd_callback(cmd->data, cmd->ret);
 }
 
-static irqreturn_t pt_core_irq_handler(int irq, void *data)
+void pt_check_status_trans(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
 {
-	struct pt_device *pt = data;
-	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
 	u32 status;
 
-	pt_core_disable_queue_interrupts(pt);
-	pt->total_interrupts++;
 	status = ioread32(cmd_q->reg_control + 0x0010);
 	if (status) {
 		cmd_q->int_status = status;
@@ -162,11 +154,21 @@ static irqreturn_t pt_core_irq_handler(int irq, void *data)
 		if ((status & INT_ERROR) && !cmd_q->cmd_error)
 			cmd_q->cmd_error = CMD_Q_ERROR(cmd_q->q_status);
 
-		/* Acknowledge the interrupt */
+		/* Acknowledge the completion */
 		iowrite32(status, cmd_q->reg_control + 0x0010);
-		pt_core_enable_queue_interrupts(pt);
 		pt_do_cmd_complete((ulong)&pt->tdata);
 	}
+}
+
+static irqreturn_t pt_core_irq_handler(int irq, void *data)
+{
+	struct pt_device *pt = data;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+
+	pt_core_disable_queue_interrupts(pt);
+	pt->total_interrupts++;
+	pt_check_status_trans(pt, cmd_q);
+	pt_core_enable_queue_interrupts(pt);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index 91b93e8d9779..ea07cc42f4d0 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -171,6 +171,7 @@ static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
 	vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
 	desc->pt = chan->pt;
+	desc->pt->cmd_q.int_en = !!(flags & DMA_PREP_INTERRUPT);
 	desc->issued_to_hw = 0;
 	desc->status = DMA_IN_PROGRESS;
 
@@ -257,6 +258,17 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
+enum dma_status
+pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
+		struct dma_tx_state *txstate)
+{
+	struct pt_device *pt = to_pt_chan(c)->pt;
+	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+
+	pt_check_status_trans(pt, cmd_q);
+	return dma_cookie_status(c, cookie, txstate);
+}
+
 static int pt_pause(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
@@ -291,8 +303,10 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	unsigned long flags;
+	struct pt_cmd_queue *cmd_q = &chan->pt->cmd_q;
 	LIST_HEAD(head);
 
+	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vchan_get_all_descriptors(&chan->vc, &head);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
@@ -362,7 +376,7 @@ int pt_dmaengine_register(struct pt_device *pt)
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
 	dma_dev->device_prep_dma_interrupt = pt_prep_dma_interrupt;
 	dma_dev->device_issue_pending = pt_issue_pending;
-	dma_dev->device_tx_status = dma_cookie_status;
+	dma_dev->device_tx_status = pt_tx_status;
 	dma_dev->device_pause = pt_pause;
 	dma_dev->device_resume = pt_resume;
 	dma_dev->device_terminate_all = pt_terminate_all;
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index afbf192c9230..d093c43b7d13 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -206,6 +206,9 @@ struct pt_cmd_queue {
 	unsigned int active;
 	unsigned int suspended;
 
+	/* Interrupt flag */
+	bool int_en;
+
 	/* Register addresses for queue */
 	void __iomem *reg_control;
 	u32 qcontrol; /* Cached control register */
@@ -318,7 +321,17 @@ void pt_core_destroy(struct pt_device *pt);
 int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
 			     struct pt_passthru_engine *pt_engine);
 
+void pt_check_status_trans(struct pt_device *pt, struct pt_cmd_queue *cmd_q);
 void pt_start_queue(struct pt_cmd_queue *cmd_q);
 void pt_stop_queue(struct pt_cmd_queue *cmd_q);
 
+static inline void pt_core_disable_queue_interrupts(struct pt_device *pt)
+{
+	iowrite32(0, pt->cmd_q.reg_control + 0x000C);
+}
+
+static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
+{
+	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_control + 0x000C);
+}
 #endif
-- 
2.25.1

