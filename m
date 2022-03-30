Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370EF4EBEE7
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiC3Ki7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245472AbiC3Ki6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 06:38:58 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E12C108;
        Wed, 30 Mar 2022 03:37:09 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22U97xdG012932;
        Wed, 30 Mar 2022 12:36:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=d4JOb+YHVgrwP+08iqsQrB5MreHyNjkxKYaMVDOBz7o=;
 b=Qr1MR95AWC0XJrGwqmSl7B6W+eMtKVYe2AWGbrrubN0anGR3FrbdKKOXkaFrFGMXjxdE
 NBX+MA1BKZjwVg5hMlJAT0iHHZ4b0ue4FVNReguLmDI0e+bcTgrghPFancPtk3qT62SZ
 hNQP/Y4ySqceRZ2qRAzTVscehZrUJ2jFgM/RU/OrQ69mDdYGQTe6MeZEWAdvNLJO8zYN
 mQOFow6eulzujjBb9feE3Ta0HRBCC/yEgCmDaze1rdvo0X5Xm1gCdHuo4OPoo4tCNQux
 zaeV4L2xg478vju+Cc2oBplClP5oc1sv5j0vMtcRzrgUUZy6lQYL1fVX71R5WJvURl/H uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f1s4pe9n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 12:36:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87C1710002A;
        Wed, 30 Mar 2022 12:36:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F7A521BF5E;
        Wed, 30 Mar 2022 12:36:46 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 30 Mar 2022 12:36:46
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
Subject: [PATCH] dmaengine: stm32-mdma: check the channel availability (secure or not)
Date:   Wed, 30 Mar 2022 12:36:45 +0200
Message-ID: <20220330103645.99969-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_03,2022-03-30_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32_MDMA_CCR bit[8] is used to enable Secure Mode (SM). If this bit is
set, it means that all the channel registers are write-protected. So the
channel is not available for Linux use.

Add stm32_mdma_filter_fn() callback filter and give it to
__dma_request_chan (instead of dma_get_any_slave_channel()), to exclude the
channel if it is marked Secure.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Already sent few weeks ago. No change since
https://lore.kernel.org/lkml/20220117100300.14150-1-amelie.delaunay@foss.st.com/
---
 drivers/dma/stm32-mdma.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 6f57ff0e7b37..95e5831e490a 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -73,6 +73,7 @@
 #define STM32_MDMA_CCR_WEX		BIT(14)
 #define STM32_MDMA_CCR_HEX		BIT(13)
 #define STM32_MDMA_CCR_BEX		BIT(12)
+#define STM32_MDMA_CCR_SM		BIT(8)
 #define STM32_MDMA_CCR_PL_MASK		GENMASK(7, 6)
 #define STM32_MDMA_CCR_PL(n)		FIELD_PREP(STM32_MDMA_CCR_PL_MASK, (n))
 #define STM32_MDMA_CCR_TCIE		BIT(5)
@@ -248,6 +249,7 @@ struct stm32_mdma_device {
 	u32 nr_channels;
 	u32 nr_requests;
 	u32 nr_ahb_addr_masks;
+	u32 chan_reserved;
 	struct stm32_mdma_chan chan[STM32_MDMA_MAX_CHANNELS];
 	u32 ahb_addr_masks[];
 };
@@ -1456,10 +1458,23 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
 	chan->desc_pool = NULL;
 }
 
+static bool stm32_mdma_filter_fn(struct dma_chan *c, void *fn_param)
+{
+	struct stm32_mdma_chan *chan = to_stm32_mdma_chan(c);
+	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
+
+	/* Check if chan is marked Secure */
+	if (dmadev->chan_reserved & BIT(chan->id))
+		return false;
+
+	return true;
+}
+
 static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
 	struct stm32_mdma_device *dmadev = ofdma->of_dma_data;
+	dma_cap_mask_t mask = dmadev->ddev.cap_mask;
 	struct stm32_mdma_chan *chan;
 	struct dma_chan *c;
 	struct stm32_mdma_chan_config config;
@@ -1485,7 +1500,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 	}
 
-	c = dma_get_any_slave_channel(&dmadev->ddev);
+	c = __dma_request_channel(&mask, stm32_mdma_filter_fn, &config, ofdma->of_node);
 	if (!c) {
 		dev_err(mdma2dev(dmadev), "No more channels available\n");
 		return NULL;
@@ -1615,6 +1630,10 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	for (i = 0; i < dmadev->nr_channels; i++) {
 		chan = &dmadev->chan[i];
 		chan->id = i;
+
+		if (stm32_mdma_read(dmadev, STM32_MDMA_CCR(i)) & STM32_MDMA_CCR_SM)
+			dmadev->chan_reserved |= BIT(i);
+
 		chan->vchan.desc_free = stm32_mdma_desc_free;
 		vchan_init(&chan->vchan, dd);
 	}
-- 
2.25.1

