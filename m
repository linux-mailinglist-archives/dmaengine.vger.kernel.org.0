Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD747572D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbhLOLBc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23495 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241878AbhLOLBb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566092; x=1671102092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3k8a8xCqtq8m/zip3YHJv9qzx7jb4XAorSSZVUzxzPw=;
  b=MdatmI+cyz21E5COhcTreNAKJyD41RzM2DwPo+eudPaaUbuq1ct0Asw5
   svtSUfinW0GS9B80ktebPR/p5Qf7lU+Zcui888SU12JyzIFR+VMpA+9Ph
   ie8wA1EHrrI9ckkeTw7p4GCGDYuNe617OJuo0Zd8H3h7LI1ZbNyvD30Wy
   I67X5+nXRgcMZ2LYeZwLP/LjTINKOcLz1bdoZzAjiX8Su3AUg/RpaEh2r
   Oks0zzkteblI8oPoGiTH39kw1lm1YWQWLDxZV+sCrLaVZsxUVbdWBgPzq
   mtOq9PusTAVuMgRl4G2HfegFZHcFE3H0VU2BWAM8bz+m1ocayTIaciGuS
   A==;
IronPort-SDR: mxQk44P8fKjrH3MGpoj26/z9Z2F54hSlvCknTspKuGZHLO+FyWmY03WQO2//StEO8Z8PLpUJMN
 oN6qDgp4/rK+y+FyapAvme9GE7wy7fYftuR9bDUDcvyek0kBHqPd8YrlAB90GPtvBNQnVSaugl
 QW9D+NAQ5KEN7OmS0CRChgXR5GwXD3GJx5JI/oB5+I6YyW2Ga6Ug9PJ2lHguYTpQfBqvux7ir1
 Upf6welnS4wf7dgAguKrg+BACWAC7nPfashZjC6XNBBgllEw5zl2y+T8AfIHPfnX/iLlXWMrXm
 l3QzkxkjucUm81gX4/1t6wB1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="142483354"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:25 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 03/12] dmaengine: at_xdmac: Print debug message after realeasing the lock
Date:   Wed, 15 Dec 2021 13:01:06 +0200
Message-ID: <20211215110115.191749-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is desirable to do the prints without the lock held if possible, so
move the print after the lock is released.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c3d3e1270236..7d3560acedbb 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -473,10 +473,12 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_irqsave(&atchan->lock, irqflags);
 	cookie = dma_cookie_assign(tx);
 
-	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
-		 __func__, atchan, desc);
 	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
 	spin_unlock_irqrestore(&atchan->lock, irqflags);
+
+	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
+		 __func__, atchan, desc);
+
 	return cookie;
 }
 
-- 
2.25.1

