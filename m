Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61B151A491
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352859AbiEDP5f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 May 2022 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352591AbiEDP5d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 May 2022 11:57:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3234614D;
        Wed,  4 May 2022 08:53:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EghZP001510;
        Wed, 4 May 2022 17:53:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=mzzwNarX6y/uXSlhjavJ8tl8qTIckcIr1Wld2u6gD7I=;
 b=Oy5HHofgB19KxswbY1DM0SRBCX3W4aKIrv/JHpB3oCMB+K15LVs8mz/3J03PrPd0wdi8
 NXNxtWx176SxFvxUpXn3xTkqm8jeOP9uchRH1UH5Mo0WzJi841GNf7kHGTThJGVj9bDB
 MwxnanbmY4RB0r9w0EjpI+We+l4laLndbdA4PHnu8WXjgiJK14t7OKZ+Ym7Y/esMzLKY
 YAMlNc2qrsHDqHT1HefW970F3KiFf9/xyTLshVeTEPNkTGIFhw6CxsOkvjSNicnRqF3C
 VFV5rz0yjk5tYTjK4L0mILNzj1dcFi5UrQfPXp6fxy0WjK1zzAtvxjQOShOjIk7Br8Mz Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0gecft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 17:53:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 900D810002A;
        Wed,  4 May 2022 17:53:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8987D22A6E3;
        Wed,  4 May 2022 17:53:40 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 17:53:39
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
Subject: [PATCH 3/3] dmaengine: stm32-mdma: use dev_dbg on non-busy channel spurious it
Date:   Wed, 4 May 2022 17:53:22 +0200
Message-ID: <20220504155322.121431-4-amelie.delaunay@foss.st.com>
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

If interrupt occurs while !chan->busy, it means channel has been disabled
between the raise of the interruption and the read of status and ien, so,
spurious interrupt can be silently discarded.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index a5cbfbbb93d1..caf0cce8f528 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1345,9 +1345,12 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 
 	if (!(status & ien)) {
 		spin_unlock(&chan->vchan.lock);
-		dev_warn(chan2dev(chan),
-			 "spurious it (status=0x%04x, ien=0x%04x)\n",
-			 status, ien);
+		if (chan->busy)
+			dev_warn(chan2dev(chan),
+				 "spurious it (status=0x%04x, ien=0x%04x)\n", status, ien);
+		else
+			dev_dbg(chan2dev(chan),
+				"spurious it (status=0x%04x, ien=0x%04x)\n", status, ien);
 		return IRQ_NONE;
 	}
 
-- 
2.25.1

