Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9097A958
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfG3NUc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 09:20:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56734 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfG3NUc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jul 2019 09:20:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6UDKRib110036;
        Tue, 30 Jul 2019 08:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564492827;
        bh=udC4eB7/7djyKfo+FEyGPgDOqsWoiwYjF6+4BMQvCno=;
        h=From:To:CC:Subject:Date;
        b=fFmBjHr0CSc8kKbP+Uj3HUkwn9NBfq+fto3YHooYhd3kb/+Wy2/y6qRJCp0D7z3Fw
         PlnpyGgoZrvStEJa25oIhqIYv/Vfp8bJ+lF7iXL8Yk8gxKFPLdWXZKtlHJYDoZa1Pq
         tycdWXlrCM/TSXroPWHZ7SGOwJ5Vg52Og/kfXeuA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6UDKRmQ083638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 08:20:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 08:20:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 08:20:26 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6UDKPO6056322;
        Tue, 30 Jul 2019 08:20:25 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: omap-dma: Remove variable override in omap_dma_tx_status()
Date:   Tue, 30 Jul 2019 16:20:29 +0300
Message-ID: <20190730132029.2971-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to fetch local omap_desc since the desc we have is the
correct one already when we need to check the channel status.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/omap-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 3b57b68df896..9f359ec3386d 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -860,7 +860,6 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 		 * accordingly and mark it as completed
 		 */
 		if (!(ccr & CCR_ENABLE)) {
-			struct omap_desc *d = c->desc;
 			ret = DMA_COMPLETE;
 			omap_dma_start_desc(c);
 			vchan_cookie_complete(&d->vd);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

