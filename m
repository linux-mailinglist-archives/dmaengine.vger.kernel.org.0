Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497C605774
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJTGjT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 02:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJTGjS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 02:39:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB51C19F1
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 23:39:14 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtHrK3gfQzmVBR;
        Thu, 20 Oct 2022 14:34:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 14:39:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 14:39:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <dmaengine@vger.kernel.org>
CC:     <vkoul@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] dmaengine: fix possible memory leak in while registering device channel
Date:   Thu, 20 Oct 2022 14:38:30 +0800
Message-ID: <20221020063830.3013799-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
bus_id string array"), the name of device is allocated dynamically,
if device_register() fails, it should call put_device() to give up
reference, the name can be freed in callback function kobject_cleanup().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/dma/dmaengine.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c741b6431958..46adfec04f0c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1068,8 +1068,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	dev_set_name(&chan->dev->device, "dma%dchan%d",
 		     device->dev_id, chan->chan_id);
 	rc = device_register(&chan->dev->device);
-	if (rc)
+	if (rc) {
+		put_device(&chan->dev->device);
+		chan->dev = NULL;
 		goto err_out_ida;
+	}
 	chan->client_count = 0;
 	device->chancnt++;
 
-- 
2.25.1

