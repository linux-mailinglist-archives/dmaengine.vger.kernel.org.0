Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37E51A492
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbiEDP5f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 May 2022 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350669AbiEDP5d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 May 2022 11:57:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D045AFC;
        Wed,  4 May 2022 08:53:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EghZO001510;
        Wed, 4 May 2022 17:53:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Q6KyqjPjjOTk3BmOK5hia+7CtTxIiidvABdtdvOQnNs=;
 b=ETmzha3D6ASiP/NoeMi/nftDnWTbYvh2iiVwr0qAy5McMFVYJKYkQ8MBAp/n0FKF5CxM
 yiC0AZiF+FdCvJadRFA3mNzZCon0LDLvFaN+KXocO42XevRNqRC8Y4VB7XVeUq2Q80XQ
 3GVU9RHA5dYZ8wiX/iwqRZKDN6jJDqmotnvJQCoY+nwRoNjRLqjIUqySnzJ0sDOy9zos
 +YrXtfmFeVwxPJlDJ/SLvmszBSgzAswJnkM7iOPY2y+UjBuVZszyYHV3i7DNx7X6Mqlx
 JsIrLugWW/Z6y/QmEDrvPamAIWIiqDUlguumlk5VH8T/z8uGdOt3TthvAIxBlOJ6SCtl DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0gecfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 17:53:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A99210002A;
        Wed,  4 May 2022 17:53:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63AFE22A6E3;
        Wed,  4 May 2022 17:53:38 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 17:53:37
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/3] dmaengine: stm32-mdma: remove GISR1 register
Date:   Wed, 4 May 2022 17:53:20 +0200
Message-ID: <20220504155322.121431-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
References: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

GISR1 was described in a not up-to-date documentation when the stm32-mdma
driver has been developed. This register has not been added in reference
manual of STM32 SoC with MDMA, which have only 32 MDMA channels.
So remove it from stm32-mdma driver.

Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 95e5831e490a..57f0eb8a18fc 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -34,7 +34,6 @@
 #include "virt-dma.h"
 
 #define STM32_MDMA_GISR0		0x0000 /* MDMA Int Status Reg 1 */
-#define STM32_MDMA_GISR1		0x0004 /* MDMA Int Status Reg 2 */
 
 /* MDMA Channel x interrupt/status register */
 #define STM32_MDMA_CISR(x)		(0x40 + 0x40 * (x)) /* x = 0..62 */
@@ -169,7 +168,7 @@
 
 #define STM32_MDMA_MAX_BUF_LEN		128
 #define STM32_MDMA_MAX_BLOCK_LEN	65536
-#define STM32_MDMA_MAX_CHANNELS		63
+#define STM32_MDMA_MAX_CHANNELS		32
 #define STM32_MDMA_MAX_REQUESTS		256
 #define STM32_MDMA_MAX_BURST		128
 #define STM32_MDMA_VERY_HIGH_PRIORITY	0x3
@@ -1324,21 +1323,11 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 
 	/* Find out which channel generates the interrupt */
 	status = readl_relaxed(dmadev->base + STM32_MDMA_GISR0);
-	if (status) {
-		id = __ffs(status);
-	} else {
-		status = readl_relaxed(dmadev->base + STM32_MDMA_GISR1);
-		if (!status) {
-			dev_dbg(mdma2dev(dmadev), "spurious it\n");
-			return IRQ_NONE;
-		}
-		id = __ffs(status);
-		/*
-		 * As GISR0 provides status for channel id from 0 to 31,
-		 * so GISR1 provides status for channel id from 32 to 62
-		 */
-		id += 32;
+	if (!status) {
+		dev_dbg(mdma2dev(dmadev), "spurious it\n");
+		return IRQ_NONE;
 	}
+	id = __ffs(status);
 
 	chan = &dmadev->chan[id];
 	if (!chan) {
-- 
2.25.1

