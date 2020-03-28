Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FC1965D7
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2020 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1Lmn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Mar 2020 07:42:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgC1Lmn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 28 Mar 2020 07:42:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 087B1A2EEB246432E288;
        Sat, 28 Mar 2020 19:42:39 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Mar 2020
 19:42:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <wangzhou1@hisilicon.com>, <qiuzhenfa@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: hisilicon: Fix build error without PCI_MSI
Date:   Sat, 28 Mar 2020 19:41:33 +0800
Message-ID: <20200328114133.17560-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If PCI_MSI is not set, building fais:

drivers/dma/hisi_dma.c: In function ‘hisi_dma_free_irq_vectors’:
drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function ‘pci_free_irq_vectors’;
 did you mean ‘pci_alloc_irq_vectors’? [-Werror=implicit-function-declaration]
  pci_free_irq_vectors(data);
  ^~~~~~~~~~~~~~~~~~~~

Make HISI_DMA depends on PCI_MSI to fix this.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 092483644315..023db6883d05 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -241,7 +241,8 @@ config FSL_RAID
 
 config HISI_DMA
 	tristate "HiSilicon DMA Engine support"
-	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
+	depends on ARM64 || COMPILE_TEST
+	depends on PCI_MSI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.17.1


