Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA77B775499
	for <lists+dmaengine@lfdr.de>; Wed,  9 Aug 2023 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjHIIAY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Aug 2023 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIIAX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Aug 2023 04:00:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965F173A;
        Wed,  9 Aug 2023 01:00:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLMr05N6XzVl7R;
        Wed,  9 Aug 2023 15:58:24 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 16:00:19 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <andriy.shevchenko@linux.intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] dmaengine: Remove unused declaration dma_chan_cleanup()
Date:   Wed, 9 Aug 2023 16:00:12 +0800
Message-ID: <20230809080012.22000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit f27c580c3628 ("dmaengine: remove 'bigref' infrastructure")
removed the implementation but left declaration in place. Remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: revise commit log
---
 include/linux/dmaengine.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c3656e590213..3df70d6131c8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -517,8 +517,6 @@ static inline const char *dma_chan_name(struct dma_chan *chan)
 	return dev_name(&chan->dev->device);
 }
 
-void dma_chan_cleanup(struct kref *kref);
-
 /**
  * typedef dma_filter_fn - callback filter for dma_request_channel
  * @chan: channel to be reviewed
-- 
2.34.1

