Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECF51BEA8
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiEEMAN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 08:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359013AbiEEMAL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 08:00:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31754F81;
        Thu,  5 May 2022 04:56:32 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458kmoi001608;
        Thu, 5 May 2022 13:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=UArImUFvNKHacRXvpNLIfvx/nkVFBIIqhhzgSK6NXF4=;
 b=mLRGkq8qlXVf/8FwGKXek0wYWMD/IPIH7pZqetyugc5CSw1ExMv1szrOwZcNhKTESXAW
 Qw2A3oKXUUhOXE9E5a79mzxD+srvGD3Cfk/+mvsZL/kRCeF2R/OvgkYAhl9Xbh1BBNyf
 GsdDDAPEluShIMP0ayzryEjngGhbG+KgaNNdL3l7A8kscegApu49ZdDdY7L3fYnKJBAV
 lz+ad9o++zU6xqJ+ZFNFX0s19QCURYQMmSfCV9DjRSwQ9h6Vs/+5soy/0Jytp854912/
 w/aKRo8o+hp2r+Bnten0J6xAgiyD9aq7lPt1Kp72ZvmZlVqQV7QSMD53m48JK/oOCXrh vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0gkbdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:56:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6576810002A;
        Thu,  5 May 2022 13:56:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F67621B50C;
        Thu,  5 May 2022 13:56:23 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 5 May 2022 13:56:22
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
Subject: [PATCH 3/4] dmaengine: stm32-dma: rename pm ops before dma pause/resume introduction
Date:   Thu, 5 May 2022 13:56:10 +0200
Message-ID: <20220505115611.38845-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
References: <20220505115611.38845-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmaengine framework offers device_pause and device_resume ops to pause an
on-going transfer and resume it later.
To avoid any misunderstanding with system sleep pm ops, rename pm ops into
stm32_dma_pm_suspend and stm32_dma_pm_resume.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index eecd13795943..0b35c5178501 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1486,7 +1486,7 @@ static int stm32_dma_runtime_resume(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-static int stm32_dma_suspend(struct device *dev)
+static int stm32_dma_pm_suspend(struct device *dev)
 {
 	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
 	int id, ret, scr;
@@ -1510,14 +1510,14 @@ static int stm32_dma_suspend(struct device *dev)
 	return 0;
 }
 
-static int stm32_dma_resume(struct device *dev)
+static int stm32_dma_pm_resume(struct device *dev)
 {
 	return pm_runtime_force_resume(dev);
 }
 #endif
 
 static const struct dev_pm_ops stm32_dma_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_dma_suspend, stm32_dma_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_dma_pm_suspend, stm32_dma_pm_resume)
 	SET_RUNTIME_PM_OPS(stm32_dma_runtime_suspend,
 			   stm32_dma_runtime_resume, NULL)
 };
-- 
2.25.1

