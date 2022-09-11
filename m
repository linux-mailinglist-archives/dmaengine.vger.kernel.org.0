Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E645B4CF2
	for <lists+dmaengine@lfdr.de>; Sun, 11 Sep 2022 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIKJSV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Sep 2022 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKJSU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Sep 2022 05:18:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBBA3BC42
        for <dmaengine@vger.kernel.org>; Sun, 11 Sep 2022 02:18:20 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MQPF94my4zmVBH;
        Sun, 11 Sep 2022 17:14:37 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 17:18:18 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <vkoul@kernel.org>, <dave.jiang@intel.com>, <vinod.koul@intel.com>
CC:     <dmaengine@vger.kernel.org>
Subject: [PATCH] dmaengine: ioat: remove unused declarations in dma.h
Date:   Sun, 11 Sep 2022 17:18:17 +0800
Message-ID: <20220911091817.3214271-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ioat_ring_alloc_order and ioat_ring_max_alloc_order have
been removed since commit cd60cd96137f ("dmaengine: IOATDMA:
Removing descriptor ring reshape"), so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/dma/ioat/dma.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 140cfe3782fb..35e06b382603 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -196,10 +196,8 @@ extern const struct sysfs_ops ioat_sysfs_ops;
 extern struct ioat_sysfs_entry ioat_version_attr;
 extern struct ioat_sysfs_entry ioat_cap_attr;
 extern int ioat_pending_level;
-extern int ioat_ring_alloc_order;
 extern struct kobj_type ioat_ktype;
 extern struct kmem_cache *ioat_cache;
-extern int ioat_ring_max_alloc_order;
 extern struct kmem_cache *ioat_sed_cache;
 
 static inline struct ioatdma_chan *to_ioat_chan(struct dma_chan *c)
-- 
2.25.1

