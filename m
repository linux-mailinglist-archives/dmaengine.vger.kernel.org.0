Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380CD1219A1
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 20:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPTBr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 14:01:47 -0500
Received: from ale.deltatee.com ([207.54.116.67]:34928 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfLPTBZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 14:01:25 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcR-0005jH-3f; Mon, 16 Dec 2019 12:01:23 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1igvcQ-0005Zm-Mi; Mon, 16 Dec 2019 12:01:22 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 16 Dec 2019 12:01:20 -0700
Message-Id: <20191216190120.21374-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216190120.21374-1-logang@deltatee.com>
References: <20191216190120.21374-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH 5/5] dmaengine: ioat: Support in-use unbind
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Don't allocate memory using the devm infrastructure and instead call
kfree with the new dmaengine device_release call back. This ensures
the structures are available until the last reference is dropped.

We also need to ensure we call ioat_shutdown() in ioat_remove() so
that all the channels are quiesced and further transaction fails.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/ioat/init.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index a6a6dc432db8..60e9afbb896c 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -556,10 +556,6 @@ static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
 	ioat_kobject_del(ioat_dma);
 
 	dma_async_device_unregister(dma);
-
-	dma_pool_destroy(ioat_dma->completion_pool);
-
-	INIT_LIST_HEAD(&dma->channels);
 }
 
 /**
@@ -589,7 +585,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);
 
 	for (i = 0; i < dma->chancnt; i++) {
-		ioat_chan = devm_kzalloc(dev, sizeof(*ioat_chan), GFP_KERNEL);
+		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
 		if (!ioat_chan)
 			break;
 
@@ -624,12 +620,16 @@ static void ioat_free_chan_resources(struct dma_chan *c)
 		return;
 
 	ioat_stop(ioat_chan);
-	ioat_reset_hw(ioat_chan);
 
-	/* Put LTR to idle */
-	if (ioat_dma->version >= IOAT_VER_3_4)
-		writeb(IOAT_CHAN_LTR_SWSEL_IDLE,
-			ioat_chan->reg_base + IOAT_CHAN_LTR_SWSEL_OFFSET);
+	if (!test_bit(IOAT_CHAN_DOWN, &ioat_chan->state)) {
+		ioat_reset_hw(ioat_chan);
+
+		/* Put LTR to idle */
+		if (ioat_dma->version >= IOAT_VER_3_4)
+			writeb(IOAT_CHAN_LTR_SWSEL_IDLE,
+			       ioat_chan->reg_base +
+			       IOAT_CHAN_LTR_SWSEL_OFFSET);
+	}
 
 	spin_lock_bh(&ioat_chan->cleanup_lock);
 	spin_lock_bh(&ioat_chan->prep_lock);
@@ -1322,16 +1322,28 @@ static struct pci_driver ioat_pci_driver = {
 	.err_handler	= &ioat_err_handler,
 };
 
+static void release_ioatdma(struct dma_device *device)
+{
+	struct ioatdma_device *d = to_ioatdma_device(device);
+	int i;
+
+	for (i = 0; i < IOAT_MAX_CHANS; i++)
+		kfree(d->idx[i]);
+
+	dma_pool_destroy(d->completion_pool);
+	kfree(d);
+}
+
 static struct ioatdma_device *
 alloc_ioatdma(struct pci_dev *pdev, void __iomem *iobase)
 {
-	struct device *dev = &pdev->dev;
-	struct ioatdma_device *d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
+	struct ioatdma_device *d = kzalloc(sizeof(*d), GFP_KERNEL);
 
 	if (!d)
 		return NULL;
 	d->pdev = pdev;
 	d->reg_base = iobase;
+	d->dma_dev.device_release = release_ioatdma;
 	return d;
 }
 
@@ -1400,6 +1412,8 @@ static void ioat_remove(struct pci_dev *pdev)
 	if (!device)
 		return;
 
+	ioat_shutdown(pdev);
+
 	dev_err(&pdev->dev, "Removing dma and dca services\n");
 	if (device->dca) {
 		unregister_dca_provider(device->dca, &pdev->dev);
-- 
2.20.1

