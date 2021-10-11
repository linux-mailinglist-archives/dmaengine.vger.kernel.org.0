Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6164289EC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhJKJpZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 05:45:25 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51862 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235626AbhJKJpV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 05:45:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B7vWne014070;
        Mon, 11 Oct 2021 11:43:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xcge6Tmp8n1Scab5wy+5ZALoDl294NFVjrwUjkjXu/Q=;
 b=EsqTpSAUtYI9/6GlAWdAUvACFFkiZPukMajqPObihvVMPWzTXsRWmS4Xz0XWpazynxqs
 /39JsSUZ1Ve06TdZU298DIAjLS+S//VkRq2VPiLpyhU5R0sVqIx5BLiYjTQADfze0MAm
 iY8ITJsnyjf8qvxTKLz6vcpP/40sfPn4RsEctGoqW+Q8yWOHlxdZeXG1N9uurDQZbBi6
 Mylredubg2sXYU51yNy/lJZhzvi3BU+XPa/OlpKzdPC2occt1PEi0rlBPqT45fQQYWPg
 FziT8INl0suqcTcOV5mm68zxwsvEunNv6Jy9S0PI0uiYgbfzHkYZpagp992uZcMrCNTt aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bmasq2my0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 11:43:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F81310002A;
        Mon, 11 Oct 2021 11:43:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3839021B50C;
        Mon, 11 Oct 2021 11:43:09 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 11 Oct 2021 11:43:08
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: [PATCH 3/3] dmaengine: stm32-dma: fix burst in case of unaligned memory address
Date:   Mon, 11 Oct 2021 11:42:59 +0200
Message-ID: <20211011094259.315023-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
References: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Theorically, address pointers used by STM32 DMA must be chosen so as to
ensure that all transfers within a burst block are aligned on the address
boundary equal to the size of the transfer.
If this is always the case for peripheral addresses on STM32, it is not for
memory addresses if the user doesn't respect this alignment constraint.
To avoid a weird behavior of the DMA controller in this case (no error
triggered but data are not transferred as expected), force no burst.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 6e4ef44941ef..2283c500f4ce 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -753,8 +753,14 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		if (src_bus_width < 0)
 			return src_bus_width;
 
-		/* Set memory burst size */
-		src_maxburst = STM32_DMA_MAX_BURST;
+		/*
+		 * Set memory burst size - burst not possible if address is not aligned on
+		 * the address boundary equal to the size of the transfer
+		 */
+		if (buf_addr % buf_len)
+			src_maxburst = 1;
+		else
+			src_maxburst = STM32_DMA_MAX_BURST;
 		src_best_burst = stm32_dma_get_best_burst(buf_len,
 							  src_maxburst,
 							  fifoth,
@@ -803,8 +809,14 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		if (dst_bus_width < 0)
 			return dst_bus_width;
 
-		/* Set memory burst size */
-		dst_maxburst = STM32_DMA_MAX_BURST;
+		/*
+		 * Set memory burst size - burst not possible if address is not aligned on
+		 * the address boundary equal to the size of the transfer
+		 */
+		if (buf_addr % buf_len)
+			dst_maxburst = 1;
+		else
+			dst_maxburst = STM32_DMA_MAX_BURST;
 		dst_best_burst = stm32_dma_get_best_burst(buf_len,
 							  dst_maxburst,
 							  fifoth,
-- 
2.25.1

