Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347AE51BC41
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbiEEJhK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353819AbiEEJhA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 05:37:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E111160;
        Thu,  5 May 2022 02:33:21 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kv7fs6mBMzHnVX;
        Thu,  5 May 2022 17:28:37 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 17:33:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <rgumasta@nvidia.com>, <pkunapuli@nvidia.com>,
        <treding@nvidia.com>, <digetx@gmail.com>, <akhilrajeev@nvidia.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: tegra: Fix build error without IOMMU_API
Date:   Thu, 5 May 2022 17:32:36 +0800
Message-ID: <20220505093236.15076-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/tegra186-gpc-dma.c: In function ‘tegra_dma_probe’:
drivers/dma/tegra186-gpc-dma.c:1364:24: error: ‘struct iommu_fwspec’ has no member named ‘ids’
  stream_id = iommu_spec->ids[0] & 0xffff;
                        ^~

Make TEGRA186_GPC_DMA depends on IOMMU_API to fix this.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc1464e4acde..857b2174a4cb 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -632,6 +632,7 @@ config TXX9_DMAC
 config TEGRA186_GPC_DMA
 	tristate "NVIDIA Tegra GPC DMA support"
 	depends on (ARCH_TEGRA || COMPILE_TEST) && ARCH_DMA_ADDR_T_64BIT
+	depends on IOMMU_API
 	select DMA_ENGINE
 	help
 	  Support for the NVIDIA Tegra General Purpose Central DMA controller.
-- 
2.17.1

