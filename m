Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5C562E49
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGAIbN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 04:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGAIbM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 04:31:12 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CE1263A
        for <dmaengine@vger.kernel.org>; Fri,  1 Jul 2022 01:31:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 68A0D40884;
        Fri,  1 Jul 2022 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1656664269; x=1658478670; bh=oF8eqXf4bOgJgC9XRe/oTswU2
        et7YIkp0bdEsHKbct4=; b=Uv1LKIu69RMTXQxR1152+OtlVudmD0Kdsjg9qrdTk
        yzC5q1DLaxdlAXqextGWgV6sl0CpzDqL3yTR4kfS8rJ/bwAw1aturQzyCf8u//x/
        av7ugimlCldBcs0tAlPhdyiX/hUXxRegBEW4G1NbSnEs4anwZU+CXS8DPKzecOTd
        ik=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K6ftZzsKZOjO; Fri,  1 Jul 2022 11:31:09 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id E527E404CD;
        Fri,  1 Jul 2022 11:31:08 +0300 (MSK)
Received: from T-EXCH-06.corp.yadro.com (172.17.10.110) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 1 Jul 2022 11:31:08 +0300
Received: from v.yadro.com (10.178.114.10) by T-EXCH-06.corp.yadro.com
 (172.17.10.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Fri, 1 Jul 2022
 11:31:07 +0300
From:   Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
CC:     <dmaengine@vger.kernel.org>, <linux@yadro.com>, <vkoul@kernel.org>,
        Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Subject: [PATCH v2] dmaengine: sf-pdma: Add multithread support for a DMA channel
Date:   Fri, 1 Jul 2022 11:29:42 +0300
Message-ID: <20220701082942.12835-1-v.v.mitrofanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yqs5DrfTMyxoE6+K@matsya>
References: <Yqs5DrfTMyxoE6+K@matsya>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.114.10]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-06.corp.yadro.com (172.17.10.110)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When we get a DMA channel and try to use it in multiple threads it
will cause oops and hanging the system.

% echo 64 > /sys/module/dmatest/parameters/threads_per_chan
% echo 10000 > /sys/module/dmatest/parameters/iterations
% echo 1 > /sys/module/dmatest/parameters/run
[   89.480664] Unable to handle kernel NULL pointer dereference at virtual
               address 00000000000000a0
[   89.488725] Oops [#1]
[   89.494708] CPU: 2 PID: 1008 Comm: dma0chan0-copy0 Not tainted
               5.17.0-rc5
[   89.509385] epc : vchan_find_desc+0x32/0x46
[   89.513553]  ra : sf_pdma_tx_status+0xca/0xd6

This happens because of data race. Each thread rewrite channels's
descriptor as soon as device_prep_dma_memcpy() is called. It leads to the
situation when the driver thinks that it uses right descriptor that
actually is freed or substituted for other one.

With current fixes a descriptor changes its value only when it has
been used. A new descriptor is acquired from vc->desc_issued queue that
is already filled with descriptors that are ready to be sent. Threads
have no direct access to DMA channel descriptor. Now it is just possible
to queue a descriptor for further processing.

Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
---
Changes in v2:
 - Remove pointer check through comparison with NULL
 
 drivers/dma/sf-pdma/sf-pdma.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..ab0ad7a2f201 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -52,16 +52,6 @@ static inline struct sf_pdma_desc *to_sf_pdma_desc(struct virt_dma_desc *vd)
 static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
 {
 	struct sf_pdma_desc *desc;
-	unsigned long flags;
-
-	spin_lock_irqsave(&chan->lock, flags);
-
-	if (chan->desc && !chan->desc->in_use) {
-		spin_unlock_irqrestore(&chan->lock, flags);
-		return chan->desc;
-	}
-
-	spin_unlock_irqrestore(&chan->lock, flags);
 
 	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
 	if (!desc)
@@ -111,7 +101,6 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_addr_t dest, dma_addr_t src,
 	desc->async_tx = vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 
 	spin_lock_irqsave(&chan->vchan.lock, iflags);
-	chan->desc = desc;
 	sf_pdma_fill_desc(desc, dest, src, len);
 	spin_unlock_irqrestore(&chan->vchan.lock, iflags);
 
@@ -170,11 +159,17 @@ static size_t sf_pdma_desc_residue(struct sf_pdma_chan *chan,
 	unsigned long flags;
 	u64 residue = 0;
 	struct sf_pdma_desc *desc;
-	struct dma_async_tx_descriptor *tx;
+	struct dma_async_tx_descriptor *tx = NULL;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
-	tx = &chan->desc->vdesc.tx;
+	list_for_each_entry(vd, &chan->vchan.desc_submitted, node)
+		if (vd->tx.cookie == cookie)
+			tx = &vd->tx;
+
+	if (!tx)
+		goto out;
+
 	if (cookie == tx->chan->completed_cookie)
 		goto out;
 
@@ -241,6 +236,19 @@ static void sf_pdma_enable_request(struct sf_pdma_chan *chan)
 	writel(v, regs->ctrl);
 }
 
+static struct sf_pdma_desc *sf_pdma_get_first_pending_desc(struct sf_pdma_chan *chan)
+{
+	struct virt_dma_chan *vchan = &chan->vchan;
+	struct virt_dma_desc *vdesc;
+
+	if (list_empty(&vchan->desc_issued))
+		return NULL;
+
+	vdesc = list_first_entry(&vchan->desc_issued, struct virt_dma_desc, node);
+
+	return container_of(vdesc, struct sf_pdma_desc, vdesc);
+}
+
 static void sf_pdma_xfer_desc(struct sf_pdma_chan *chan)
 {
 	struct sf_pdma_desc *desc = chan->desc;
@@ -268,8 +276,11 @@ static void sf_pdma_issue_pending(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
-	if (vchan_issue_pending(&chan->vchan) && chan->desc)
+	if (!chan->desc && vchan_issue_pending(&chan->vchan)) {
+		/* vchan_issue_pending has made a check that desc in not NULL */
+		chan->desc = sf_pdma_get_first_pending_desc(chan);
 		sf_pdma_xfer_desc(chan);
+	}
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
@@ -298,6 +309,11 @@ static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	list_del(&chan->desc->vdesc.node);
 	vchan_cookie_complete(&chan->desc->vdesc);
+
+	chan->desc = sf_pdma_get_first_pending_desc(chan);
+	if (chan->desc)
+		sf_pdma_xfer_desc(chan);
+
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
-- 
2.25.1

