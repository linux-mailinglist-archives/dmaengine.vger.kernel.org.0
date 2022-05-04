Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B651A490
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352855AbiEDP5e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 May 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbiEDP5d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 May 2022 11:57:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15E4614C;
        Wed,  4 May 2022 08:53:57 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EaEtA026474;
        Wed, 4 May 2022 17:53:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=pXUx8kWfnqdiCoNzlXrT4VSy1bUDFwsBeS/sZv4Bm+E=;
 b=gNsO7KDlclnEG1JxjL/chJTpYRQiNJdxtb6V3Dl+vB6Ncyzvrw5dljiB/0ZKGfGnVqLu
 NZv9H4vP81Dvwokcj61ow21uAq5Znt2ZG1ySdEW7oFrmj6cCK3w+Y0Xfq5tJUe8qagrb
 z1wYS/rMcrDsf9WzxMm5Hbv6NuBuYUcb5Pivrx1Fy4GaDNPsbJFX1CNyVEDBo07YunjW
 s8NTU3px4tWf16J1msyg13cw2v5w5rZdsi39AFA+2F+AQhmGc7KAY07lIlPp6B/aFBnc
 SIC+1RyxqgsdY8wVbRj5+YEjjJd84w3uJbauzSACV9xRfjSyr8HEqveASoj9XZkQI1Y/ tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frt88xpj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 17:53:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E1B510002A;
        Wed,  4 May 2022 17:53:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 77F5322A6E3;
        Wed,  4 May 2022 17:53:39 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 17:53:38
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/3] dmaengine: stm32-mdma: fix chan initialization in stm32_mdma_irq_handler()
Date:   Wed, 4 May 2022 17:53:21 +0200
Message-ID: <20220504155322.121431-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
References: <20220504155322.121431-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The parameter to pass back to the handler function when irq has been
requested is a struct stm32_mdma_device pointer, not a struct
stm32_mdma_chan pointer.
Even if chan is reinit later in the function, remove this wrong
initialization.

Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 57f0eb8a18fc..a5cbfbbb93d1 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1318,7 +1318,7 @@ static void stm32_mdma_xfer_end(struct stm32_mdma_chan *chan)
 static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 {
 	struct stm32_mdma_device *dmadev = devid;
-	struct stm32_mdma_chan *chan = devid;
+	struct stm32_mdma_chan *chan;
 	u32 reg, id, ccr, ien, status;
 
 	/* Find out which channel generates the interrupt */
-- 
2.25.1

