Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A17605753
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJTGaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJTG36 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 02:29:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F923E95
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 23:29:55 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtHkr61NTzHv8t;
        Thu, 20 Oct 2022 14:29:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 14:29:25 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 14:29:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <dmaengine@vger.kernel.org>
CC:     <vigneshr@ti.com>, <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: fix memory leak when register device fail
Date:   Thu, 20 Oct 2022 14:28:27 +0800
Message-ID: <20221020062827.2914148-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If device_register() fails, it should call put_device() to give
up reference, the name allocated in dev_set_name() can be freed
in callback function kobject_cleanup().

Fixes: 5b65781d06ea ("dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/dma/ti/k3-udma-glue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 4fdd9f06b723..4f1aeb81e9c7 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -299,6 +299,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	ret = device_register(&tx_chn->common.chan_dev);
 	if (ret) {
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
+		put_device(&tx_chn->common.chan_dev);
 		tx_chn->common.chan_dev.parent = NULL;
 		goto err;
 	}
@@ -917,6 +918,7 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 	ret = device_register(&rx_chn->common.chan_dev);
 	if (ret) {
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
+		put_device(&rx_chn->common.chan_dev);
 		rx_chn->common.chan_dev.parent = NULL;
 		goto err;
 	}
@@ -1048,6 +1050,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 	ret = device_register(&rx_chn->common.chan_dev);
 	if (ret) {
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
+		put_device(&rx_chn->common.chan_dev);
 		rx_chn->common.chan_dev.parent = NULL;
 		goto err;
 	}
-- 
2.25.1

