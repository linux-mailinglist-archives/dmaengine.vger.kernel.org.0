Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275452D2720
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgLHJFb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:05:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51624 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgLHJFa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:05:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B893nWa130151;
        Tue, 8 Dec 2020 03:03:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418229;
        bh=LQWkom4AlDyOMYyG9quYjUCZhb57RJ8vj/xUJWaN+D0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t/7smbS7hKOpZSJ+/N9rlRW4XwqDyMKCYLHlnJeO+EajQrwcUgpj5ITAIFPYjCnp6
         i5Ok12+xLpMrbpgoYz8xCvEUOU21JgR6CcZXcsh51dHzy3d9AfDJtmztsTXSFoFMFT
         CO/rrg/RCz1Ja7Jy4vLR2EF5GgeCUvX1RoDBNBpA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B893nPe043566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:03:49 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:03:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:03:49 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dc7120112;
        Tue, 8 Dec 2020 03:03:46 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 02/20] dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
Date:   Tue, 8 Dec 2020 11:04:22 +0200
Message-ID: <20201208090440.31792-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208090440.31792-1-peter.ujfalusi@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Set the TDTYPE if it is supported on the platform (j721e) which will cause
UDMAP to wait for the remote peer to finish the teardown before returning
the teardown completed message.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/k3-udma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0e8426dd18a7..eee43757e774 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -86,6 +86,7 @@ struct udma_rchan {
 
 #define UDMA_FLAG_PDMA_ACC32		BIT(0)
 #define UDMA_FLAG_PDMA_BURST		BIT(1)
+#define UDMA_FLAG_TDTYPE		BIT(2)
 
 struct udma_match_data {
 	u32 psil_base;
@@ -1589,6 +1590,13 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	req_tx.tx_fetch_size = fetch_size >> 2;
 	req_tx.txcq_qnum = tc_ring;
 	req_tx.tx_atype = uc->config.atype;
+	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
+	    ud->match_data->flags & UDMA_FLAG_TDTYPE) {
+		/* wait for peer to complete the teardown for PDMAs */
+		req_tx.valid_params |=
+				TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID;
+		req_tx.tx_tdtype = 1;
+	}
 
 	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
 	if (ret)
@@ -3105,14 +3113,14 @@ static struct udma_match_data am654_mcu_data = {
 static struct udma_match_data j721e_main_data = {
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
 	.statictr_z_mask = GENMASK(23, 0),
 };
 
 static struct udma_match_data j721e_mcu_data = {
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
 	.statictr_z_mask = GENMASK(23, 0),
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

