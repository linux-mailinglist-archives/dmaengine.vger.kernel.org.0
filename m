Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4114A033
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 09:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgA0IyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 03:54:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18112 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729424AbgA0IyF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 03:54:05 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8rFdG011482;
        Mon, 27 Jan 2020 09:53:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=LtSHbdDzwkhiZy1H0EyZ/LNU5Qx0QFD829og3RZwGKs=;
 b=YImN5QDAJ5SKzsF1n+ufDKihYRX45WURp8FPosQTzM0WVB9mujnHP6WlH4LkNSscIlts
 KGd8oFY4DRHUB6sdbgkNVWazgrbM9aiEasOIAMds5Ms4Hy42Xf2xTPkcrr8Rk9aru7nB
 Bq22vnQ3Zix3LKxXKUuVM3+9JGK+i66E/Ukcu6Wp5FQJ5Fd3lA/tb2UUaqWyD6ai44lj
 zuuC1U6fZciw9HQ+phYRtCOs0g5RTongw7XV9vkOjrYNkPZQG+0jy8p7CHM+1TsN0etg
 emFcN3Y/jsFtGti0+RC2tP1kOPMJJuv6DGZpRcpldeL5ijE6YNneUnEs7q0EQ+kXAiyQ 6g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpar4sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 09:53:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F15DD10003B;
        Mon, 27 Jan 2020 09:53:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E54F021CA6A;
        Mon, 27 Jan 2020 09:53:42 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jan 2020 09:53:42
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
Subject: [PATCH 1/6] dmaengine: stm32-mdma: add suspend/resume power management support
Date:   Mon, 27 Jan 2020 09:53:29 +0100
Message-ID: <20200127085334.13163-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127085334.13163-1-amelie.delaunay@st.com>
References: <20200127085334.13163-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Add suspend/resume power management relying on PM Runtime engine.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-mdma.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 5838311cf990..2898411941d5 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1697,7 +1697,40 @@ static int stm32_mdma_runtime_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_mdma_pm_suspend(struct device *dev)
+{
+	struct stm32_mdma_device *dmadev = dev_get_drvdata(dev);
+	u32 ccr, id;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+
+	for (id = 0; id < dmadev->nr_channels; id++) {
+		ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(id));
+		if (ccr & STM32_MDMA_CCR_EN) {
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
+static int stm32_mdma_pm_resume(struct device *dev)
+{
+	return pm_runtime_force_resume(dev);
+}
+#endif
+
 static const struct dev_pm_ops stm32_mdma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_mdma_pm_suspend, stm32_mdma_pm_resume)
 	SET_RUNTIME_PM_OPS(stm32_mdma_runtime_suspend,
 			   stm32_mdma_runtime_resume, NULL)
 };
-- 
2.17.1

