Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB577C913
	for <lists+dmaengine@lfdr.de>; Tue, 15 Aug 2023 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjHOIDp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjHOIDM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 04:03:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D8113
        for <dmaengine@vger.kernel.org>; Tue, 15 Aug 2023 01:03:10 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ3Zd13mXzNmpm;
        Tue, 15 Aug 2023 15:59:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 16:03:07 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <vkoul@kernel.org>, <pliem@maxlinear.com>
CC:     <lizetao1@huawei.com>, <dmaengine@vger.kernel.org>
Subject: [PATCH -next] dmaengine: lgm: Use builtin_platform_driver macro to simplify the code
Date:   Tue, 15 Aug 2023 16:02:50 +0800
Message-ID: <20230815080250.1089589-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the builtin_platform_driver macro to simplify the code, which is the
same as declaring with device_initcall().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/dma/lgm/lgm-dma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 1709d159af7e..4117c7b67e9c 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -1732,9 +1732,4 @@ static struct platform_driver intel_ldma_driver = {
  * registered DMA channels and DMA capabilities to clients before their
  * initialization.
  */
-static int __init intel_ldma_init(void)
-{
-	return platform_driver_register(&intel_ldma_driver);
-}
-
-device_initcall(intel_ldma_init);
+builtin_platform_driver(intel_ldma_driver);
-- 
2.34.1

