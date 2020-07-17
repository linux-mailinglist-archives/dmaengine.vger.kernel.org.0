Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3C223B20
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 14:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGQMIC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 08:08:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49376 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgGQMIB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 08:08:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HC7wfN091207;
        Fri, 17 Jul 2020 07:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594987678;
        bh=HU5vTOrvHA5aCTGpReATK4x5iE+arqssEtZcrsTHtno=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fne9idIjomUeQOAODiDewEfwSBkkhCJvlndXjLkKR2q2eYpKjLCLc0ZIVR5x4JKEP
         U0JtRATRMlV0NlMFe5pe550lGSiyoQU+K3O8T+FuN/a+kBL0RlTrvkWtb/S/fv1mSE
         j+5Od8pvILPDQ/rFMkyhzeaPxqSzHnvg0xSIOOSs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HC7wfB014559;
        Fri, 17 Jul 2020 07:07:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 07:07:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 07:07:58 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HC7t1X043751;
        Fri, 17 Jul 2020 07:07:57 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH 1/2] dmaengine: ti: k3-udma: Use defines for capabilities register parsing
Date:   Fri, 17 Jul 2020 15:09:02 +0300
Message-ID: <20200717120903.8774-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717120903.8774-1-peter.ujfalusi@ti.com>
References: <20200717120903.8774-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add defines for the CAP register fields to make the code self explaining.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 12 ++++++------
 drivers/dma/ti/k3-udma.h |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 336fb6472cac..0ac6c440f536 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3207,13 +3207,13 @@ static int udma_setup_resources(struct udma_dev *ud)
 						    "ti,sci-rm-range-rchan",
 						    "ti,sci-rm-range-rflow" };
 
-	cap2 = udma_read(ud->mmrs[MMR_GCFG], 0x28);
-	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
+	cap2 = udma_read(ud->mmrs[MMR_GCFG], UDMA_CAP_REG(2));
+	cap3 = udma_read(ud->mmrs[MMR_GCFG], UDMA_CAP_REG(3));
 
-	ud->rflow_cnt = cap3 & 0x3fff;
-	ud->tchan_cnt = cap2 & 0x1ff;
-	ud->echan_cnt = (cap2 >> 9) & 0x1ff;
-	ud->rchan_cnt = (cap2 >> 18) & 0x1ff;
+	ud->rflow_cnt = UDMA_CAP3_RFLOW_CNT(cap3);
+	ud->tchan_cnt = UDMA_CAP2_TCHAN_CNT(cap2);
+	ud->echan_cnt = UDMA_CAP2_ECHAN_CNT(cap2);
+	ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
 	ch_count  = ud->tchan_cnt + ud->rchan_cnt;
 
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index a8ea1138e1a5..9534f0ca29f4 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -37,6 +37,12 @@
 #define UDMA_CHAN_RT_BCNT_REG		0x408
 #define UDMA_CHAN_RT_SBCNT_REG		0x410
 
+/* UDMA_CAP Registers */
+#define UDMA_CAP2_TCHAN_CNT(val)	((val) & 0x1ff)
+#define UDMA_CAP2_ECHAN_CNT(val)	(((val) >> 9) & 0x1ff)
+#define UDMA_CAP2_RCHAN_CNT(val)	(((val) >> 18) & 0x1ff)
+#define UDMA_CAP3_RFLOW_CNT(val)	((val) & 0x3fff)
+
 /* UDMA_CHAN_RT_CTL_REG */
 #define UDMA_CHAN_RT_CTL_EN		BIT(31)
 #define UDMA_CHAN_RT_CTL_TDOWN		BIT(30)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

