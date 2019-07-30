Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2F57A956
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfG3NUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 09:20:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52186 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfG3NUU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jul 2019 09:20:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6UDKEUS033907;
        Tue, 30 Jul 2019 08:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564492814;
        bh=GidekszOWXOz65DaNrv6Onij2HIr4p8/rU9ABITd7Tw=;
        h=From:To:CC:Subject:Date;
        b=VICm1HNiA02wiFecChDGeVxDnuTH7Jza8utcA1nE0fkS/wzFj51wCaNzQL87sqzVq
         RgLr53SPBfubmfLEVRvfSXaOwbDQd8KtnBa0nO4tjHi4/H3P3SSm83oAjeyEPbTUMZ
         mW9Wj66dg69cL2IQceyX4jC6BG8Lmnp2IcKqDSn0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6UDKDaj077063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 08:20:13 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 08:20:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 08:20:13 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6UDKBgk056060;
        Tue, 30 Jul 2019 08:20:11 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: omap-dma: Remove 'Assignment in if condition'
Date:   Tue, 30 Jul 2019 16:20:15 +0300
Message-ID: <20190730132015.2863-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While the compiler does not have problem with how it is implemented,
checkpatch does give en ERROR for this arrangement.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/omap-dma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index a4a63425dc0b..3b57b68df896 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -814,7 +814,6 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
-	struct virt_dma_desc *vd;
 	enum dma_status ret;
 	unsigned long flags;
 	struct omap_desc *d = NULL;
@@ -841,10 +840,14 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 			pos = 0;
 
 		txstate->residue = omap_dma_desc_size_pos(d, pos);
-	} else if ((vd = vchan_find_desc(&c->vc, cookie))) {
-		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
 	} else {
-		txstate->residue = 0;
+		struct virt_dma_desc *vd = vchan_find_desc(&c->vc, cookie);
+
+		if (vd)
+			txstate->residue = omap_dma_desc_size(
+						to_omap_dma_desc(&vd->tx));
+		else
+			txstate->residue = 0;
 	}
 
 out:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

