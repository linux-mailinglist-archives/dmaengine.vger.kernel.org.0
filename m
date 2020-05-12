Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332091CF610
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 15:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgELNpC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 09:45:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52050 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNpB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 09:45:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CDiw8Y099102;
        Tue, 12 May 2020 08:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589291098;
        bh=aklv9x1Vb3Ybn91wDtlirJy1TWpEFpZbHh7Wmja4jHA=;
        h=From:To:CC:Subject:Date;
        b=G62J7I/imsK19tt0LSAKTEAK1IXFVvjY1rvVneHwsHNXVvKfAzhs8zaPm5LMnRPpG
         DV16ga1PC8ogyzjzqCMkQnrrA3wrPLM41cEEgZeEQKepqNN//XBI8c0aNNJdzsd9Ln
         5kxPkpS+l3L1+wy69PnJOBzwI1i5D0xY/KJfCm+4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CDiwMY095647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 08:44:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 08:44:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 08:44:57 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDiuri062493;
        Tue, 12 May 2020 08:44:57 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix TR mode flags for slave_sg and memcpy
Date:   Tue, 12 May 2020 16:45:31 +0300
Message-ID: <20200512134531.5742-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

cppi5_tr_csf_set() clears previously set Configuration Specific Flags.
Setting the EOP flag clears the SUPR_EVT flag for the last TR which is not
desirable as we do not want to have events from the TR.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 89d025a5c599..20b1f94de86c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2157,7 +2157,8 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 		d->residue += sg_dma_len(sgent);
 	}
 
-	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, CPPI5_TR_CSF_EOP);
+	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
+			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
 
 	return d;
 }
@@ -2734,7 +2735,8 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		tr_req[1].dicnt3 = 1;
 	}
 
-	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags, CPPI5_TR_CSF_EOP);
+	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags,
+			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
 
 	if (uc->config.metadata_size)
 		d->vd.tx.metadata_ops = &metadata_ops;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

