Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4975738A3
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 16:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGMOWT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGMOWS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 10:22:18 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F232EC9;
        Wed, 13 Jul 2022 07:22:15 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DAo2xC027405;
        Wed, 13 Jul 2022 16:21:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=fyyQJuRm529q54ZzHitzFOjpOk9IVG1ad4Uu2OC7hq0=;
 b=68yKYK4wfTt3+A2MhPwOlcsYqnjQaiKkDWw1nCPfxL0sqj/O+i9200KmslXnfz0qRbcG
 KBeyAAy6gIrSX5A4PfeP2Z9gFqjhvEA34Onn9CHPhzhmVj8tybSZ89NrNWwBDoiQCF8v
 winQImR7+R3h70G7ouQBDUbjeq0QnnkynsaYE4wnqhkvTwlqmX5n9nfJ0pIRnKJOVvuD
 sZ/+vTfMBoJEp3/c3Ue48SmY0M/po9T9Jcgw50JbpO1G5oT2tnz1WxfSE+JKpNyfbFAa
 JeC4i1czLZt9z7DBFV3kTDKmpNKY8fa0yQQ5EKFLjJRnrOuwEpiufZ1WIQC7js3dSGYJ 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h93cwj2h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 16:21:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5AB8A10002A;
        Wed, 13 Jul 2022 16:21:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5564A226FC7;
        Wed, 13 Jul 2022 16:21:58 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 13 Jul
 2022 16:21:57 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 2/4] dmaengine: stm32-dmamux: set dmamux channel id in dma features bitfield
Date:   Wed, 13 Jul 2022 16:21:46 +0200
Message-ID: <20220713142148.239253-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713142148.239253-1-amelie.delaunay@foss.st.com>
References: <20220713142148.239253-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_03,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

STM32 DMAMUX is used with STM32 DMA1 and DMA2:
- DMAMUX channels 0 to 7 are connected to DMA1 channels 0 to 7
- DMAMUX channels 8 to 15 are connected to DMA2 channels 0 to 7

STM32 MDMA can be triggered by DMA1 and DMA2 channels transfer complete,
and the "request line number" is the DMAMUX channel id (e.g. DMA2 channel 0
triggers MDMA with request line 8).

To well configure MDMA, set DMAMUX channel id in DMA features bitfield,
so that DMA can update struct dma_slave_config peripheral_config properly.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
No changes in v2.
---
 drivers/dma/stm32-dmamux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index eee0c5aa5fb5..b431f9da9206 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -147,7 +147,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	mux->request = dma_spec->args[0];
 
 	/*  craft DMA spec */
-	dma_spec->args[3] = dma_spec->args[2];
+	dma_spec->args[3] = dma_spec->args[2] | mux->chan_id << 16;
 	dma_spec->args[2] = dma_spec->args[1];
 	dma_spec->args[1] = 0;
 	dma_spec->args[0] = mux->chan_id - min;
-- 
2.25.1

