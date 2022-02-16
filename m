Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D720C4B815F
	for <lists+dmaengine@lfdr.de>; Wed, 16 Feb 2022 08:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiBPHV2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Feb 2022 02:21:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiBPHV0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Feb 2022 02:21:26 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC8A205F3;
        Tue, 15 Feb 2022 23:21:11 -0800 (PST)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jz8Ry439Fz8wk6;
        Wed, 16 Feb 2022 15:17:50 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 15:21:09 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 15:21:09 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <wangzhou1@hisilicon.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: hisi_dma: fix MSI allocate fail when reload hisi_dma
Date:   Wed, 16 Feb 2022 15:21:01 +0800
Message-ID: <20220216072101.34473-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove the loaded hisi_dma driver and reload it, the driver fails
to work properly. The following error is reported in the kernel log:

[ 1475.597609] hisi_dma 0000:7b:00.0: Failed to allocate MSI vectors!
[ 1475.604915] hisi_dma: probe of 0000:7b:00.0 failed with error -28

As noted in "The MSI Driver Guide HOWTO"[1], the number of MSI
interrupt must be a power of two. The Kunpeng DMA driver allocates 30
MSI interrupts. As a result, no space left on device is reported
when the driver is reloaded and allocates interrupt vectors from the
interrupt domain.

This patch changes the number of interrupt vectors allocated by
hisi_dma driver to 32 to avoid this problem.

[1] https://www.kernel.org/doc/html/latest/PCI/msi-howto.html

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/hisi_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 97c87a7cba87..43817ced3a3e 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -30,7 +30,7 @@
 #define HISI_DMA_MODE			0x217c
 #define HISI_DMA_OFFSET			0x100
 
-#define HISI_DMA_MSI_NUM		30
+#define HISI_DMA_MSI_NUM		32
 #define HISI_DMA_CHAN_NUM		30
 #define HISI_DMA_Q_DEPTH_VAL		1024
 
-- 
2.33.0

