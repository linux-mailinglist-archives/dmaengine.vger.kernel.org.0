Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF614CD97
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgA2PhJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 10:37:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29536 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgA2Pg4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 10:36:56 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TFNArj019435;
        Wed, 29 Jan 2020 16:36:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=F7q/g3bH1EGFK9krPt73RxMiWkr9k9tY9L3hNSfOodM=;
 b=hzk6S6sSp8iIzAWVBlccDrSLCLZQjXJNf92jRCrvb2WS6EoATt8j4e238FnxMxx+kLuf
 87TMCx8Q5JRfPKqHen480iQ3iaHQtRwR6C4WIHBIq0KM6OkQkl6tEr8z8gnI4SO10nJ8
 eKhXhWAbtucW3BJpwT2CSnRZIfTAXj5qhZZbabvC3RzT+FQY4bMvy4OmNgXqPBpwzksp
 hr7kH5vJc78uQipUkr0C+wgKQ4oIoephewVFGqXH3aJj8kjs1NHzLKqu6qF58KlwlI6j
 7SDHy5Lot4WrKXC7vcMhzS1dN+FDSiR/UMHy7cKFyqjeu8UNBykcltCm4askgh0jHXfq aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcay3vb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 16:36:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 228DD100038;
        Wed, 29 Jan 2020 16:36:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10A732BC7C2;
        Wed, 29 Jan 2020 16:36:35 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Jan 2020 16:36:34
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
Subject: [PATCH 1/8] dmaengine: stm32-dma: add suspend/resume power management support
Date:   Wed, 29 Jan 2020 16:36:21 +0100
Message-ID: <20200129153628.29329-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129153628.29329-1-amelie.delaunay@st.com>
References: <20200129153628.29329-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_03:2020-01-28,2020-01-29 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Add suspend/resume power management relying on PM Runtime engine.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dma.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 5989b0893521..136deabd1aa3 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1427,7 +1427,39 @@ static int stm32_dma_runtime_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_dma_suspend(struct device *dev)
+{
+	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
+	int id, ret, scr;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+
+	for (id = 0; id < STM32_DMA_MAX_CHANNELS; id++) {
+		scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
+		if (scr & STM32_DMA_SCR_EN) {
+			dev_warn(dev, "Suspend is prevented by Chan %i\n", id);
+			return -EBUSY;
+		}
+	}
+
+	pm_runtime_put_sync(dev);
+
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int stm32_dma_resume(struct device *dev)
+{
+	return pm_runtime_force_resume(dev);
+}
+#endif
+
 static const struct dev_pm_ops stm32_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_dma_suspend, stm32_dma_resume)
 	SET_RUNTIME_PM_OPS(stm32_dma_runtime_suspend,
 			   stm32_dma_runtime_resume, NULL)
 };
-- 
2.17.1

