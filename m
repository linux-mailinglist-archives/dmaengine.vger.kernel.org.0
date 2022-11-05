Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7661D91E
	for <lists+dmaengine@lfdr.de>; Sat,  5 Nov 2022 10:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKEJan (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Nov 2022 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEJam (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Nov 2022 05:30:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB264240BB
        for <dmaengine@vger.kernel.org>; Sat,  5 Nov 2022 02:30:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N4Bwq0zsrzJnQP;
        Sat,  5 Nov 2022 17:27:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 17:30:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 5 Nov
 2022 17:30:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <dmaengine@vger.kernel.org>
CC:     <vkoul@kernel.org>, <dave.jiang@intel.com>, <jsnitsel@redhat.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v2] dmaengine: fix possible memory leak in while registering device channel
Date:   Sat, 5 Nov 2022 17:29:23 +0800
Message-ID: <20221105092923.2844847-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If device_register() returns error, the name allocated by
dev_set_name() need be freed. As comment of device_register()
says, it should use put_device() to give up the reference in
the error path. So fix this by calling put_device(), then the
name can be freed in kobject_cleanup(), the dma_chan_dev will
be freed in chan_dev_release(), set 'chan->dev' to null in the
error path to avoid it be freed again by kfree().

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Add fix tag and update commit message.
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

