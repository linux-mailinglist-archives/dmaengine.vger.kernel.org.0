Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDE14B1E3
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 10:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgA1Jm1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 04:42:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36502 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725271AbgA1Jm0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 04:42:26 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S9WY2Y031223;
        Tue, 28 Jan 2020 10:42:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=+sBJ5wscdYLYeiF4DeuorI/LsDqHFHp2G8EwB/5qkCw=;
 b=OZPFB8fOFpQ0iagujnOK0ewnRVGKCKaqL3mAGlE+IZkMVt9HEPM5Qxy915L+cPzmFnyp
 GEcHANaXEDp/7t7OZFXVZOy6Q8B7Y3lRBAS0BQvl9mKHp8/kV0y8vPfWpGvywrG1sUrL
 3iyRS2U229GhPZu/iCI3dnEBVJD+bOvnFt5JgKquriv4wYXUaWDh2mrj2dppixVkHpOi
 eFbilKrzu0HM8ipZbckUeQ8ROnlKn7p8ojYtmvkqn34B+jd4I9OArJ4xNhWIv5uIGnZ9
 WU4C994/o3vN2RGIWv/BBs3SKyyxSzNVdcAI2BNOgG+6NX+q0uPT1Wxj8611hRtBE9cA pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekd0me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:42:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16B5110003E;
        Tue, 28 Jan 2020 10:42:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B10521D3C0;
        Tue, 28 Jan 2020 10:42:08 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 10:42:07
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
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
Subject: [PATCH 1/4] dmaengine: stm32-dmamux: add suspend/resume power management support
Date:   Tue, 28 Jan 2020 10:41:55 +0100
Message-ID: <20200128094158.20361-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128094158.20361-1-amelie.delaunay@st.com>
References: <20200128094158.20361-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Add suspend/resume power management relying on PM Runtime engine.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dmamux.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 3c89bd39e096..08d2395c8943 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -41,6 +41,9 @@ struct stm32_dmamux_data {
 	u32 dmamux_requests; /* Number of DMA requests routed toward DMAs */
 	spinlock_t lock; /* Protects register access */
 	unsigned long *dma_inuse; /* Used DMA channel */
+	u32 ccr[STM32_DMAMUX_MAX_DMA_REQUESTS]; /* Used to backup CCR register
+						 * in suspend
+						 */
 	u32 dma_reqs[]; /* Number of DMA Request per DMA masters.
 			 *  [0] holds number of DMA Masters.
 			 *  To be kept at very end end of this structure
@@ -318,7 +321,54 @@ static int stm32_dmamux_runtime_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_dmamux_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	int i, ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < stm32_dmamux->dma_requests; i++)
+		stm32_dmamux->ccr[i] = stm32_dmamux_read(stm32_dmamux->iomem,
+							 STM32_DMAMUX_CCR(i));
+
+	pm_runtime_put_sync(dev);
+
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int stm32_dmamux_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	int i, ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < stm32_dmamux->dma_requests; i++)
+		stm32_dmamux_write(stm32_dmamux->iomem, STM32_DMAMUX_CCR(i),
+				   stm32_dmamux->ccr[i]);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+#endif
+
 static const struct dev_pm_ops stm32_dmamux_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_dmamux_suspend, stm32_dmamux_resume)
 	SET_RUNTIME_PM_OPS(stm32_dmamux_runtime_suspend,
 			   stm32_dmamux_runtime_resume, NULL)
 };
-- 
2.17.1

