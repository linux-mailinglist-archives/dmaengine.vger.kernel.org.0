Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476B5ED2CC
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiI1Bua (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 21:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiI1Bu3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 21:50:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DDD112FE1
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 18:50:27 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McfTG1387zHtlc;
        Wed, 28 Sep 2022 09:45:38 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 09:50:25 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <fenghua.yu@intel.com>, <dave.jiang@intel.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH RESEND] dmaengine: idxd: Remove unused struct idxd_fault
Date:   Wed, 28 Sep 2022 01:47:47 +0000
Message-ID: <20220928014747.106808-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since fault processing code has been removed, struct idxd_fault is not used any
more and can be removed as well.
Fixes: commit 0e96454ca26c ("dmaengine: idxd: remove fault processing code")

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/dma/idxd/irq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 5b9921475be6..6dc299182933 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -17,12 +17,6 @@ enum irq_work_type {
 	IRQ_WORK_PROCESS_FAULT,
 };
 
-struct idxd_fault {
-	struct work_struct work;
-	u64 addr;
-	struct idxd_device *idxd;
-};
-
 struct idxd_resubmit {
 	struct work_struct work;
 	struct idxd_desc *desc;
-- 
2.17.1

