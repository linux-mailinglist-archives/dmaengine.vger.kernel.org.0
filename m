Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A314A02B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgA0IyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 03:54:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgA0IyD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 03:54:03 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8qifU031730;
        Mon, 27 Jan 2020 09:53:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=nJTPWGwcja3w9ZoU3k/ButKD5zeX6d6eHIc6z80GWEw=;
 b=rFfoaJ0Qdlar+izTeCy4zIdmXw7XGJC+2VuzI3PLAsUvFhavi13VCAbrgkzPGcrrRxUg
 6+CjuLAGr6E0l0zw0/O/hdXarmea8UVDBA+Rf5q1scVNlULLpK6HjORzenL8ZR7pQavU
 /ukO4GO2Nu3azopIS8b6HDZ+vDsCZCzBlNuCIwxYOyA2sNkm5Bzad9O4a4Ziw6JZhAXl
 sKcGjLZGA1AIDieFW6YHRg2bfg0KV4w9RKqwzZwlMvY9v0edpswQ+MXrbF/m8f04oYP6
 doUjvvdOOAgm8OCltLLuzRxrBdLrCi39XMuQ92417RL+hynp9guFtOOxYIU6KIfHCmME ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdek7tsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 09:53:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E36A10003E;
        Mon, 27 Jan 2020 09:53:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 324AF21CA6A;
        Mon, 27 Jan 2020 09:53:44 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
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
Subject: [PATCH 3/6] dmaengine: stm32-mdma: disable clock in case of error during probe
Date:   Mon, 27 Jan 2020 09:53:31 +0100
Message-ID: <20200127085334.13163-4-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127085334.13163-1-amelie.delaunay@st.com>
References: <20200127085334.13163-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

This patch disables the clock in case of error during probe. The unneeded
err_unregister label is renamed err_clk instead.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-mdma.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index a0fb80dfb2e9..f23c82e3990c 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1637,25 +1637,27 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	}
 
 	dmadev->irq = platform_get_irq(pdev, 0);
-	if (dmadev->irq < 0)
-		return dmadev->irq;
+	if (dmadev->irq < 0) {
+		ret = dmadev->irq;
+		goto err_clk;
+	}
 
 	ret = devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handler,
 			       0, dev_name(&pdev->dev), dmadev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		return ret;
+		goto err_clk;
 	}
 
 	ret = dmaenginem_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	ret = of_dma_controller_register(of_node, stm32_mdma_of_xlate, dmadev);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"STM32 MDMA DMA OF registration failed %d\n", ret);
-		goto err_unregister;
+		goto err_clk;
 	}
 
 	platform_set_drvdata(pdev, dmadev);
@@ -1668,7 +1670,9 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_unregister:
+err_clk:
+	clk_disable_unprepare(dmadev->clk);
+
 	return ret;
 }
 
-- 
2.17.1

