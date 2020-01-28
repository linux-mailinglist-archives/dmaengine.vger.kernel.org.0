Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37F514B1E7
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 10:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgA1Jmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 04:42:33 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4856 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgA1Jm1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 04:42:27 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S9X0HB000609;
        Tue, 28 Jan 2020 10:42:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=q0/ZRftGwXUvPNBAcTtwgWBj7A7urGK8v4Z7CD9K7Jo=;
 b=weScv0PxU3WhSRqruB7mNIdHIvaRB4mta0p5p/YpScu9AIZBWDtOaCkX+JVDFX27LoxQ
 EDKrP0KdR75kLDwtjDwJyE1+OIli04hY1NSF//hgI/GrvkUXpwcDMTY9mdi9X3oQsJNr
 h1gJjnMB5634/IhUTmtFO4JdCCZjuUKT7foW8+fw6Mc8YbGXwFW/VvAoQA+I1zTHl4nj
 un5HdOBWLhCgbJkr3p/mdlAVRzEqycUH5SfEDx9MeP3y0EVEm42aXLTazhY3EG8NG9lq
 FJ+ZENon9dQa9vjx8J9TLjhhn1JzpAs0p51hejrRdA2hii3e/SX0YzTZzPwarnyzKjV1 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxw22c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:42:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4A6310002A;
        Tue, 28 Jan 2020 10:42:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C990A21D3C0;
        Tue, 28 Jan 2020 10:42:10 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 10:42:10
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
Subject: [PATCH 4/4] dmaengine: stm32-dmamux: driver defers probe for clock and reset
Date:   Tue, 28 Jan 2020 10:41:58 +0100
Message-ID: <20200128094158.20361-5-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128094158.20361-1-amelie.delaunay@st.com>
References: <20200128094158.20361-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Changes STM32 DMAMUX driver to defer its probe operation when
reset controller is expected but has not been probed yet.

Changes error traces when failing to get a system resource so that
it is not printed on failure with deferred probing.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-dmamux.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 1dfecbac64cf..12f7637e13a1 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -254,8 +254,8 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	stm32_dmamux->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(stm32_dmamux->clk)) {
 		ret = PTR_ERR(stm32_dmamux->clk);
-		if (ret == -EPROBE_DEFER)
-			dev_info(&pdev->dev, "Missing controller clock\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Missing clock controller\n");
 		return ret;
 	}
 
@@ -266,7 +266,11 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	}
 
 	rst = devm_reset_control_get(&pdev->dev, NULL);
-	if (!IS_ERR(rst)) {
+	if (IS_ERR(rst)) {
+		ret = PTR_ERR(rst);
+		if (ret == -EPROBE_DEFER)
+			goto err_clk;
+	} else {
 		reset_control_assert(rst);
 		udelay(2);
 		reset_control_deassert(rst);
@@ -291,7 +295,12 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	ret = of_dma_router_register(node, stm32_dmamux_route_allocate,
 				     &stm32_dmamux->dmarouter);
 	if (ret)
-		clk_disable_unprepare(stm32_dmamux->clk);
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(stm32_dmamux->clk);
 
 	return ret;
 }
-- 
2.17.1

