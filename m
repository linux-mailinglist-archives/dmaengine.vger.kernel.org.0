Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E241AF9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 06:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfFLETr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 00:19:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfFLETr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 00:19:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 71AFA3880FDC3D9E2455;
        Wed, 12 Jun 2019 12:19:44 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 12:19:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gustavo.pimentel@synopsys.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] dmaengine: dw-edma: Fix build error without CONFIG_PCI_MSI
Date:   Wed, 12 Jun 2019 12:18:01 +0800
Message-ID: <20190612041801.18300-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If CONFIG_PCI_MSI is not set, building with CONFIG_DW_EDMA
fails:

drivers/dma/dw-edma/dw-edma-core.c: In function dw_edma_irq_request:
drivers/dma/dw-edma/dw-edma-core.c:784:21: error: implicit declaration of function pci_irq_vector; did you mean rcu_irq_enter? [-Werror=implicit-function-declaration]
   err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
                     ^~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/dw-edma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index c0838ce..7ff17b2 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -2,6 +2,7 @@
 
 config DW_EDMA
 	tristate "Synopsys DesignWare eDMA controller driver"
+	depends on PCI && PCI_MSI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.7.4


