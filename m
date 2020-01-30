Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0914D9FA
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 12:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgA3Llp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 06:41:45 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58480 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3Llp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 06:41:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfaQq040404;
        Thu, 30 Jan 2020 05:41:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580384496;
        bh=PfhZB0u6qpTnrrmiZMWeOdG8bOIriv2FsGz0GCJxGRo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O1fVRAUlVu57jX5tpNGS2/OLcyJOx2lsd0CX5z7ZV6hK/gdWqe5EB8br9K1K8Kt92
         BK8A3uzeaF4zjOAbJPnj6un04jvoi3nXWx20mcEbinX1IESQaX9PEsHxWOFNhXEUWP
         GnYwsPkH3TRMHO4tlXL6Q+JyVAFHs7/1tOM2QSHw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfa8w008703;
        Thu, 30 Jan 2020 05:41:36 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 05:41:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 05:41:36 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfW7X104655;
        Thu, 30 Jan 2020 05:41:34 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH 1/2] dmaengine: Cleanups for the slave <-> channel symlink support
Date:   Thu, 30 Jan 2020 13:42:19 +0200
Message-ID: <20200130114220.23538-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130114220.23538-1-peter.ujfalusi@ti.com>
References: <20200130114220.23538-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No need to use goto to jump over the
return chan ? chan : ERR_PTR(-EPROBE_DEFER);
We can just revert the check and return right there.

Do not fail the channel request if the chan->name allocation fails, but
print a warning about it.

Change the dev_err to dev_warn if sysfs_create_link() fails as it is not
fatal.

Only attempt to remove the DMA_SLAVE_NAME symlink if it is created - or it
was attempted to be created.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 7b1cefc3213a..75516f9fbab4 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -756,22 +756,24 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	}
 	mutex_unlock(&dma_list_mutex);
 
-	if (!IS_ERR_OR_NULL(chan))
-		goto found;
-
-	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
+	if (IS_ERR_OR_NULL(chan))
+		return chan ? chan : ERR_PTR(-EPROBE_DEFER);
 
 found:
-	chan->slave = dev;
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
-	if (!chan->name)
-		return ERR_PTR(-ENOMEM);
+	if (!chan->name) {
+		dev_warn(dev,
+			 "Cannot allocate memory for slave symlink name\n");
+		return chan;
+	}
+	chan->slave = dev;
 
 	if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
 			      DMA_SLAVE_NAME))
-		dev_err(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
+		dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
 	if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
-		dev_err(dev, "Cannot create DMA %s symlink\n", chan->name);
+		dev_warn(dev, "Cannot create DMA %s symlink\n", chan->name);
+
 	return chan;
 }
 EXPORT_SYMBOL_GPL(dma_request_chan);
@@ -830,13 +832,14 @@ void dma_release_channel(struct dma_chan *chan)
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
+
 	if (chan->slave) {
+		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
 		sysfs_remove_link(&chan->slave->kobj, chan->name);
 		kfree(chan->name);
 		chan->name = NULL;
 		chan->slave = NULL;
 	}
-	sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

