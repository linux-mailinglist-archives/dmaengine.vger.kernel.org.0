Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5414B1E8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 10:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725271AbgA1Jmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 04:42:33 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33268 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgA1Jm1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 04:42:27 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S9g9Eo007603;
        Tue, 28 Jan 2020 10:42:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=meXrSPvvSNZwM5HWiSKL727KyNlCOtYyZ+UfmgFHvs0=;
 b=TzTK4D9ABmvIvWE5xh+svbw84ZDLMsf/RxoEK2U5EJVzxHoOe8WfLeXcnMizLgsdvoxx
 VYZ5MowTqIWcpOQTRHF0dr3yM2CZXUcsU9SrJwsqV5rydTS3R+scTBzXsYYpA6Wj5S95
 SRJf8ssKZArx/dw2NKJFVb9eEEgVGIXDxIhhC19bkjiinXoPoZeSmfkHDmgEEovx2NId
 5PAErDjGWAlLRO7cTksCTNNA9V4kKtp0MsyLcb9lj7uTrMZ48JS8jHP/dnDqRgyAdvYN
 Fbufn/DFQ8wOmWA4Q+F1x6qQFWQc1RlRaFV4sr3qksIPXHu0MSTgn19x3yBlKWJiNts5 yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrc1353nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:42:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B038E100039;
        Tue, 28 Jan 2020 10:42:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A20F321D3C0;
        Tue, 28 Jan 2020 10:42:08 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 10:42:08
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
Subject: [PATCH 2/4] dmaengine: stm32-dmamux: fix clock handling in probe sequence
Date:   Tue, 28 Jan 2020 10:41:56 +0100
Message-ID: <20200128094158.20361-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128094158.20361-1-amelie.delaunay@st.com>
References: <20200128094158.20361-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

This change ensures the DMAMUX device is reset only once it is clocked
and that clock is released in a safe state when probe operation fails.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dmamux.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 08d2395c8943..a862d3339fb7 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -259,6 +259,12 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(stm32_dmamux->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
+		return ret;
+	}
+
 	stm32_dmamux->rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (!IS_ERR(stm32_dmamux->rst)) {
 		reset_control_assert(stm32_dmamux->rst);
@@ -274,14 +280,6 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	if (!IS_ERR(stm32_dmamux->clk)) {
-		ret = clk_prepare_enable(stm32_dmamux->clk);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
-			return ret;
-		}
-	}
-
 	pm_runtime_get_noresume(&pdev->dev);
 
 	/* Reset the dmamux */
@@ -290,8 +288,12 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
-	return of_dma_router_register(node, stm32_dmamux_route_allocate,
+	ret = of_dma_router_register(node, stm32_dmamux_route_allocate,
 				     &stm32_dmamux->dmarouter);
+	if (ret)
+		clk_disable_unprepare(stm32_dmamux->clk);
+
+	return ret;
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

