Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74947B1B7
	for <lists+dmaengine@lfdr.de>; Mon, 20 Dec 2021 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhLTQ6u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Dec 2021 11:58:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48192 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231579AbhLTQ6u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Dec 2021 11:58:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKAxI08029724;
        Mon, 20 Dec 2021 17:58:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=t9KotEOtaUjd/KKdckEBhPCxa4PXFHnRLpPF61TOvNw=;
 b=Y+zi37jyu+mL0uYAzkH3j+KcCaNGazX12tmu6OCOrB2V3cgWgnoS6vqFJKnDdNTcyViX
 H0Dn8VXxsOBEtWhlpO8cAZLOdcR8paEwMmCFYwqLwcFCg4ipA/Z9v+zW4+5IoCNA2ZH0
 X3fIhMaHeWl3QpkGO5UilcxitAqy5tusfbHPlkkjOerR9u08G47cjU7YeQaiKLMO9ANx
 1p9NN5tdCxfuBvkBAMNa+7gAFPjJVKhO+ujcnwXKBXhBmUp6u9wHB+yCdYX+wfrbgdeS
 +/y71YK6SxSVHKUyDsVCGKsvRp/bhRQsjNaFfGw6mM7ZxyhrP/eZZaqKAcRTND5IbPf8 sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d2kerbrhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 17:58:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EBE410002A;
        Mon, 20 Dec 2021 17:58:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3718520B20C;
        Mon, 20 Dec 2021 17:58:28 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 17:58:27
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] dmaengine: stm32-mdma: fix STM32_MDMA_CTBR_TSEL_MASK
Date:   Mon, 20 Dec 2021 17:58:27 +0100
Message-ID: <20211220165827.1238097-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_08,2021-12-20_01,2021-12-02_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch fixes STM32_MDMA_CTBR_TSEL_MASK, which is [5:0], not [7:0].

Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 76cf2e333e63..6f57ff0e7b37 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -157,7 +157,7 @@
 #define STM32_MDMA_CTBR(x)		(0x68 + 0x40 * (x))
 #define STM32_MDMA_CTBR_DBUS		BIT(17)
 #define STM32_MDMA_CTBR_SBUS		BIT(16)
-#define STM32_MDMA_CTBR_TSEL_MASK	GENMASK(7, 0)
+#define STM32_MDMA_CTBR_TSEL_MASK	GENMASK(5, 0)
 #define STM32_MDMA_CTBR_TSEL(n)		FIELD_PREP(STM32_MDMA_CTBR_TSEL_MASK, (n))
 
 /* MDMA Channel x mask address register */
-- 
2.25.1

