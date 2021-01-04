Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83092E971E
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jan 2021 15:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbhADOVt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jan 2021 09:21:49 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:37452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbhADOVt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Jan 2021 09:21:49 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104EKnxS015842;
        Mon, 4 Jan 2021 15:20:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=EkPQnsrAn7KbIBVHzKphtBL1IOPfbYkV5St4CplonVQ=;
 b=0/LPJSeBMZCoybnIv2NRfUEJ44KSFtBuQO3+R/zt3XlkGFuEKWIEAOZKjQG8EKxvSCmL
 f3AyVwkT4vtMCbbznwEj9UaSBO5L8Xa0gjQ4TowCmbbHXyparqPfTv4MQ88oJVu9mXg7
 8VVR59bHQTRsXlzlHlkhhpxz2T7MV9nFC72wxiwPoTWj+db1DDwj4WZJBqrBihP3CEBs
 Jx6Qp9o3460uC0MPcY4wEe0q5BR1O0AeQ6ljO7q+bVzPcAoQ+mCdqLGomTuBA0ZkPNgW
 YpDSw841LCS91CjKz5Z2l0q3AfZ4XndVbnYBOKQil/+y9mFK8haox+n24pWSImVMdXYG 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35th25fp9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jan 2021 15:20:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38457100038;
        Mon,  4 Jan 2021 15:20:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20E3021FEA8;
        Mon,  4 Jan 2021 15:20:46 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Jan 2021 15:20:45
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH 1/1] dmaengine: stm32-mdma: fix STM32_MDMA_VERY_HIGH_PRIORITY value
Date:   Mon, 4 Jan 2021 15:20:45 +0100
Message-ID: <20210104142045.25583-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_08:2021-01-04,2021-01-04 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32_MDMA_VERY_HIGH_PRIORITY is b11 not 0x11, so fix it with 0x3.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index e4637ec786d3..36ba8b43e78d 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -199,7 +199,7 @@
 #define STM32_MDMA_MAX_CHANNELS		63
 #define STM32_MDMA_MAX_REQUESTS		256
 #define STM32_MDMA_MAX_BURST		128
-#define STM32_MDMA_VERY_HIGH_PRIORITY	0x11
+#define STM32_MDMA_VERY_HIGH_PRIORITY	0x3
 
 enum stm32_mdma_trigger_mode {
 	STM32_MDMA_BUFFER,
-- 
2.17.1

