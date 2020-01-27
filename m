Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE51214A034
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 09:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgA0IyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 03:54:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18142 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgA0IyF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 03:54:05 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8rKu2011537;
        Mon, 27 Jan 2020 09:53:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=d0DekDJ1zvoLH3rRFnt/nO3/KohuERZXWlQkB9inrfo=;
 b=AJ8Ol0bIN0qZ94UyTsXG2BlgU9T09DW4ExsfIAmE9S4ypHsOeAXk48hksvvYQ6F1yPgW
 9QtvCX8yithY7/5yCqMMKOd7M/GhKe0NM7h6B/uPcIjYy0Y8kK25py2sTwRvzSjj5e9j
 RFNH9BH7vUGG1VXmoUQmbC59fURzmb7PdIwegbtpDJHmc1Chw9QCTxF4rx2cLYy1R79H
 rfF1Xtmk9EMv9Sd7Jy7xqEsQfA1ZpebwRvu50+SNDHJ1kmzdraNS1rl+nkbaL9KFkIcM
 M2jXt6Ztk0ES1mO2EkihzeFGmLUB6Sbsn/lpenfZ60xonm1U/a0ozkrwabj7V73eDZkA Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrbpar4t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 09:53:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C67DC100042;
        Mon, 27 Jan 2020 09:53:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB48121CA6A;
        Mon, 27 Jan 2020 09:53:44 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jan 2020 09:53:44
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
Subject: [PATCH 4/6] dmaengine: stm32-mdma: driver defers probe for clock and reset
Date:   Mon, 27 Jan 2020 09:53:32 +0100
Message-ID: <20200127085334.13163-5-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127085334.13163-1-amelie.delaunay@st.com>
References: <20200127085334.13163-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch changes error log when failing to get the clock so that it is
not printed on failure with probe deferring.

It also defers probe when reset controller is expected but has not been
probed yet when MDMA device is probed.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/dma/stm32-mdma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index f23c82e3990c..2dbd1f38a6f5 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1579,8 +1579,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	dmadev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dmadev->clk)) {
 		ret = PTR_ERR(dmadev->clk);
-		if (ret == -EPROBE_DEFER)
-			dev_info(&pdev->dev, "Missing controller clock\n");
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Missing clock controller\n");
 		return ret;
 	}
 
@@ -1591,7 +1591,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
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
-- 
2.17.1

