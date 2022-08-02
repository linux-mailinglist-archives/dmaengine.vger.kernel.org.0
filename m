Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF9587A7B
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiHBKPv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiHBKPf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 06:15:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160622524;
        Tue,  2 Aug 2022 03:15:33 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LxrQQ5CdZzjXfc;
        Tue,  2 Aug 2022 18:12:30 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:15:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:15:29 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <haijie1@huawei.com>, <liudongdong3@huawei.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/7] MAINTAINERS: Add myself as maintainer for hisi_dma
Date:   Tue, 2 Aug 2022 18:12:26 +0800
Message-ID: <20220802101226.9005-8-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220802101226.9005-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220802101226.9005-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add myself as a maintainer for hisi_dma.

Signed-off-by: Jie Hai <haijie1@huawei.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..b1aeffd74a37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8971,6 +8971,7 @@ F:	net/dsa/tag_hellcreek.c
 
 HISILICON DMA DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
+M:	Jie Hai <haijie1@hisilicon.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/hisi_dma.c
-- 
2.33.0

