Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8252D5248D4
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351968AbiELJXW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351949AbiELJWl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 05:22:41 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 02:22:28 PDT
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95D52E5A;
        Thu, 12 May 2022 02:22:28 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id EBDDD41263;
        Thu, 12 May 2022 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1652346841; x=
        1654161242; bh=6CKUUGiEfJJY6nOsVYJXO5jvAWuz+fxsRrRh0XO1fNg=; b=V
        X+Jz3UAq7V11zajUqpOBhdlUIfASwYAih5jXFp7KQU1aViL9ltB3LsqgW38qKkvh
        /2Ei6QBc9grESkv96yB6jCKL/dP9jyoHzq8bMBB+B6ItkiNPadwbES2cxJsVRb/6
        mZYfZNZ+TYR8FPBHAhxZyf1kgWZgILeJiCmUayzYFA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SpVT0JrDacfB; Thu, 12 May 2022 12:14:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4F6C74125E;
        Thu, 12 May 2022 12:14:01 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 12 May 2022 12:14:01 +0300
Received: from v.yadro.com (10.199.17.194) by T-Exch-05.corp.yadro.com
 (172.17.10.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Thu, 12 May 2022
 12:14:00 +0300
From:   Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <david.abdurachmanov@sifive.com>, <linux@yadro.com>,
        Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Subject: [PATCH] dmaengine: sf-pdma: Add multithread support for a DMA channel
Date:   Thu, 12 May 2022 12:13:27 +0300
Message-ID: <20220512091327.349563-1-v.v.mitrofanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.17.194]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-Exch-05.corp.yadro.com (172.17.10.109)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

With current fixes a descriptor changes it's value only when it has
been used. A new descriptor is acquired from vc->desc_issued queue that
is already filled with descriptors that are ready to be sent. Threads
have no direct access to DMA channel descriptor, now it is just possible
to queue a descriptor for further processing.

Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..70bb032c59c2 100644
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
+	if ((chan->desc == NULL) && vchan_issue_pending(&chan->vchan)) {
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

