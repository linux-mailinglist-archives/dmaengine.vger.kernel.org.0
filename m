Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAC3B2B93
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFXJmk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 05:42:40 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:21690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232004AbhFXJmj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Jun 2021 05:42:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O9c7k6004760;
        Thu, 24 Jun 2021 11:40:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=9K0el6v2S3oKMB5e1ZaxFrvwWS0dlKkQ3UZ872NGc4Y=;
 b=AdVlWRK2w8f7UVERcqRWi4Mzb445fmvGbq+ovAx28WncX4MndbuJMve8H3gyGSftpxgR
 9UXTMlvDMD0g9lI6fLZsj5PChu0tKJ7T8akQDTCvGgHsEC8hPGk/wF90ev4QdXT8mFmd
 prWKYFOmg3dBW42DDbYFLXrkw8FveOZ0ebLoNR9w1qqsAfdrRuHFmTC7a2Z6tBjbjmPT
 HVhatxSscaZv60jKozTRjV01vNW1fl8OQhHLbgJwVgAdIStOFWqVTfYrptl5KELXmcWq
 vvUs82xEsGcJAJiQebHZvNE+7NAvkqzRRPeG3PluV4vftSU+s8595MD48zFrrR0Tcbg3 DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39chf6jsvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 11:40:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D9AA100034;
        Thu, 24 Jun 2021 11:40:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1377921B518;
        Thu, 24 Jun 2021 11:40:05 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Jun 2021 11:40:04
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 2/2] dmaengine: stm32-dma: add alternate REQ/ACK protocol management
Date:   Thu, 24 Jun 2021 11:39:59 +0200
Message-ID: <20210624093959.142265-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624093959.142265-1-amelie.delaunay@foss.st.com>
References: <20210624093959.142265-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_06:2021-06-24,2021-06-24 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32 USART/UART is not managing correctly the default DMA REQ/ACK protocol
leading to possibly lock the DMA stream.
Default protocol consists in maintaining ACK signal up to the removal of
REQuest and the transfer completion.
In case of alternative REQ/ACK protocol, ACK de-assertion does not wait the
removal of the REQuest, but only the transfer completion.

This patch retrieves the need of the alternative protocol through the
device tree, and sets the protocol accordingly.
It also unwrap STM32_DMA_DIRECT_MODE_GET macro definition for consistency
with new STM32_DMA_ALT_ACK_MODE_GET macro definition.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index f54ecb123a52..d3aa34b3d2f7 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -60,6 +60,7 @@
 #define STM32_DMA_SCR_PSIZE_GET(n)	((n & STM32_DMA_SCR_PSIZE_MASK) >> 11)
 #define STM32_DMA_SCR_DIR_MASK		GENMASK(7, 6)
 #define STM32_DMA_SCR_DIR(n)		((n & 0x3) << 6)
+#define STM32_DMA_SCR_TRBUFF		BIT(20) /* Bufferable transfer for USART/UART */
 #define STM32_DMA_SCR_CT		BIT(19) /* Target in double buffer */
 #define STM32_DMA_SCR_DBM		BIT(18) /* Double Buffer Mode */
 #define STM32_DMA_SCR_PINCOS		BIT(15) /* Peripheral inc offset size */
@@ -138,8 +139,9 @@
 #define STM32_DMA_THRESHOLD_FTR_MASK	GENMASK(1, 0)
 #define STM32_DMA_THRESHOLD_FTR_GET(n)	((n) & STM32_DMA_THRESHOLD_FTR_MASK)
 #define STM32_DMA_DIRECT_MODE_MASK	BIT(2)
-#define STM32_DMA_DIRECT_MODE_GET(n)	(((n) & STM32_DMA_DIRECT_MODE_MASK) \
-					 >> 2)
+#define STM32_DMA_DIRECT_MODE_GET(n)	(((n) & STM32_DMA_DIRECT_MODE_MASK) >> 2)
+#define STM32_DMA_ALT_ACK_MODE_MASK	BIT(4)
+#define STM32_DMA_ALT_ACK_MODE_GET(n)	(((n) & STM32_DMA_ALT_ACK_MODE_MASK) >> 4)
 
 enum stm32_dma_width {
 	STM32_DMA_BYTE,
@@ -1252,6 +1254,8 @@ static void stm32_dma_set_config(struct stm32_dma_chan *chan,
 	chan->threshold = STM32_DMA_THRESHOLD_FTR_GET(cfg->features);
 	if (STM32_DMA_DIRECT_MODE_GET(cfg->features))
 		chan->threshold = STM32_DMA_FIFO_THRESHOLD_NONE;
+	if (STM32_DMA_ALT_ACK_MODE_GET(cfg->features))
+		chan->chan_reg.dma_scr |= STM32_DMA_SCR_TRBUFF;
 }
 
 static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
-- 
2.25.1

