Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75669601004
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJQNOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 09:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJQNOi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 09:14:38 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3933DEA6;
        Mon, 17 Oct 2022 06:14:34 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HCE0Eh022314;
        Mon, 17 Oct 2022 15:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Y3tbg4T/k0TWNQzttJhU7tjvx6Th49Ldu2bCDMrA3Ls=;
 b=4fBFnwBvxgk3rI4psrux/cfqJ9fk8aMc9jTxCUg+o6cv1uosNTEBY29sUR0eVCj8wxcl
 Qv4fpZHA8bYpRn/nrwmtb5Z6eqflWrzKFlOXvKM88PeOUQfjUo8wiac36y01JTnCH3tR
 9SdWZ/giIhAxQAsWucW1JyZ/UFu4IVoJJ61eGLw7KLVZU/pTGaySCl20HZ+xIWD3Sr6f
 YBtQNxkTqvjO++tzAaov0sclC2J5G3DR+bfIzUXWKYxSHfE5u7rREhAD9/AbUDaKqz0U
 wp9mjHrTroxyr5PVQUS4tvXU7U4ok3Uc03HfXY0eleBu1G3rg8BSNBAb59xKKisY+COU YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7krjmmb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 15:14:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9876710002A;
        Mon, 17 Oct 2022 15:14:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 93CE822FA3D;
        Mon, 17 Oct 2022 15:14:14 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 15:14:13 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: stm32-mdma: memset stm32_mdma_chan_config struct before using it
Date:   Mon, 17 Oct 2022 15:14:13 +0200
Message-ID: <20221017131413.202567-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_10,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

New bool m2m_hw has been added at the end of stm32_mdma_chan_config struct
to support the STM32 DMA MDMA chaining.

m2m_hw is set true in stm32_mdma_slave_config() if peripheral_size is set,
but m2m_hw is never initialized false.

To ensure this case, and any further new update of the structure, memset it
to 0 before using it.

Fixes: 696874322771 ("dmaengine: stm32-mdma: add support to be triggered by STM32 DMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32-mdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index e28acbcb53f4..b9d4c843635f 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1539,6 +1539,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 	}
 
+	memset(&config, 0, sizeof(config));
 	config.request = dma_spec->args[0];
 	config.priority_level = dma_spec->args[1];
 	config.transfer_config = dma_spec->args[2];
-- 
2.25.1

