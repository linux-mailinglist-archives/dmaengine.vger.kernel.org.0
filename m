Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E996189AC
	for <lists+dmaengine@lfdr.de>; Thu,  3 Nov 2022 21:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKCUjs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Nov 2022 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCUjq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Nov 2022 16:39:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD1209B9;
        Thu,  3 Nov 2022 13:39:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3Kdfbk052060;
        Thu, 3 Nov 2022 15:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667507981;
        bh=Te3maA9q1oBAmqEE7eTdUyjAvosJePhk5cDGiOG+13E=;
        h=From:To:CC:Subject:Date;
        b=KTEh/Tr2tWeakV5fPSalx3wpThLRR913UKufJrYSy140VRu6q3lc4yNqYAGDJBGm8
         MwvAkqPAJSX/nK4MAAa645FpJTQUjEYD4AMYfrKYkLP27Tu0IT/kiEMwDmDp6lsVsj
         GmKkvUCKgzCk5N/gooQtVr6W8Xoo0EExYHjdg3ss=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3KdfIg054992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 15:39:41 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 15:39:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 15:39:41 -0500
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3KdY2p002296;
        Thu, 3 Nov 2022 15:39:36 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v2] dmaengine: k3-udma: Add system suspend/resume support
Date:   Thu, 3 Nov 2022 22:30:21 +0200
Message-ID: <20221103203021.83929-1-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

The K3 platforms configure the DMA resources with the
help of the TI's System Firmware's Device Manager(DM)
over TISCI. The group of DMA related Resource Manager[1]
TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
This configuration however, does not persist in the DM
after leaving from Suspend-to-RAM state. We have to restore
the DMA channel configuration over TISCI for all configured
channels when returning from suspend.

The TISCI resource management calls for each DMA type (UDMA,
PKTDMA, BCDMA) happen in device_free_chan_resources() and
device_alloc_chan_resources(). In pm_suspend() we store
the current udma_chan_config for channels that still have
attached clients and call device_free_chan_resources().
In pm_resume() restore the udma_channel_config from backup
and call device_alloc_chan_resources() for those channels.
Drivers like CPSW can do their own DMA resource management,
so use the late system suspend/resume hooks.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[g-vlaev@ti.com: Add patch description and config backup]
[g-vlaev@ti.com: Supend only channels with clients]
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
---
Changes:

v2:
* Update the commit message
* Use list_for_each_entry() to iterate over the channel list.

 drivers/dma/ti/k3-udma.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..29844044132c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -304,6 +304,8 @@ struct udma_chan {
 
 	/* Channel configuration parameters */
 	struct udma_chan_config config;
+	/* Channel configuration parameters (backup) */
+	struct udma_chan_config backup_config;
 
 	/* dmapool for packet mode descriptors */
 	bool use_dma_pool;
@@ -5491,11 +5493,63 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int udma_pm_suspend(struct device *dev)
+{
+	struct udma_dev *ud = dev_get_drvdata(dev);
+	struct dma_device *dma_dev = &ud->ddev;
+	struct dma_chan *chan;
+	struct udma_chan *uc;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count) {
+			uc = to_udma_chan(chan);
+			/* backup the channel configuration */
+			memcpy(&uc->backup_config, &uc->config,
+			       sizeof(struct udma_chan_config));
+			dev_dbg(dev, "Suspending channel %s\n",
+				dma_chan_name(chan));
+			ud->ddev.device_free_chan_resources(chan);
+		}
+	}
+
+	return 0;
+}
+
+static int udma_pm_resume(struct device *dev)
+{
+	struct udma_dev *ud = dev_get_drvdata(dev);
+	struct dma_device *dma_dev = &ud->ddev;
+	struct dma_chan *chan;
+	struct udma_chan *uc;
+	int ret;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count) {
+			uc = to_udma_chan(chan);
+			/* restore the channel configuration */
+			memcpy(&uc->config, &uc->backup_config,
+			       sizeof(struct udma_chan_config));
+			dev_dbg(dev, "Resuming channel %s\n",
+				dma_chan_name(chan));
+			ret = ud->ddev.device_alloc_chan_resources(chan);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops udma_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
+};
+
 static struct platform_driver udma_driver = {
 	.driver = {
 		.name	= "ti-udma",
 		.of_match_table = udma_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &udma_pm_ops,
 	},
 	.probe		= udma_probe,
 };

base-commit: 81214a573d19ae2fa5b528286ba23cd1cb17feec
-- 
2.30.2

