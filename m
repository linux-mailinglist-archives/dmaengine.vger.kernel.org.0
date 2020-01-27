Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD814A02A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgA0IyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 03:54:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31804 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgA0IyD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 03:54:03 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8rFdH011482;
        Mon, 27 Jan 2020 09:53:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ybVfpMeDlc5p2YDDGL962NAZ9hW9uDc+ClDS8oLK3fg=;
 b=QnWPCrR6J2AlcZRlppZY07IClKIM/8cmUzMWi+tRVJHF+I08IsvEceBIM1m/Y9zGKU3t
 IlZyTLwBqI5ulqa+6o+RL1WQDgeJCOAG16OjnKr/PksCGOfq0VdTM7BKUuxYS64eVDXt
 dw3YOh7j7yLWIPK9EGrxKIopEJlQUIhnePcb9X0o31+5GDGHHZW0g0ltSfujUCCjUpC1
 mbihkPnPzu38gIIystdhnzFbpWjPwjFRrPQwIVVOpZZdwmkho/Ogsf6jsW+4A0nJxg5i
 fegp7wIqBYYVZwjMTSGzfjbhzRPSOjM7xF4zuJzEd6NDueoxV4+SsqC3U6OYozNpC9eF 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpar4sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 09:53:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A143610003D;
        Mon, 27 Jan 2020 09:53:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9495F21CA6A;
        Mon, 27 Jan 2020 09:53:43 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jan 2020 09:53:43
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
Subject: [PATCH 2/6] dmaengine: stm32-mdma: use reset controller only at probe time
Date:   Mon, 27 Jan 2020 09:53:30 +0100
Message-ID: <20200127085334.13163-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127085334.13163-1-amelie.delaunay@st.com>
References: <20200127085334.13163-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Remove reset controller reference from device instance since it is
used only at probe time.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-mdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 2898411941d5..a0fb80dfb2e9 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -273,7 +273,6 @@ struct stm32_mdma_device {
 	void __iomem *base;
 	struct clk *clk;
 	int irq;
-	struct reset_control *rst;
 	u32 nr_channels;
 	u32 nr_requests;
 	u32 nr_ahb_addr_masks;
@@ -1532,6 +1531,7 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	struct dma_device *dd;
 	struct device_node *of_node;
 	struct resource *res;
+	struct reset_control *rst;
 	u32 nr_channels, nr_requests;
 	int i, count, ret;
 
@@ -1590,11 +1590,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
-	if (!IS_ERR(dmadev->rst)) {
-		reset_control_assert(dmadev->rst);
+	rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
 		udelay(2);
-		reset_control_deassert(dmadev->rst);
+		reset_control_deassert(rst);
 	}
 
 	dd = &dmadev->ddev;
-- 
2.17.1

