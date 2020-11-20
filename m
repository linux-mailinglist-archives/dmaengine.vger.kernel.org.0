Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9002BABEC
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgKTOdo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Nov 2020 09:33:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51276 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727560AbgKTOdn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Nov 2020 09:33:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKEW5S9018622;
        Fri, 20 Nov 2020 15:33:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Q/Gjr3ITiryqY9OUE5GqxlvOOPrVt6lzWL9Ty4Gmi2g=;
 b=wPHkOlhHS0IAw6vqlLmel19PYgB1hRbX1z5NozqpBgD3kCmPSY6+dR3OhrF5gOTMDs3V
 XD0KKea6xmgB77RzuzD0OzLlJUMMHAR5b8oiBm68ZlOpVvW5ndd11slLW2utkToiW78O
 hvdx8KJQmNMRIYoLfBPRTrvgwYgOUw9eYFyCFiuStMxzB7GKOFQhC9xB716dA/3vRWOT
 NQZkj9d6l0AXIK82KD68XtOF1bSEVVBo/oaXNsvGQOUGG4PnHW0KXUmZx6bA0Mfn9lcW
 dGzqdLx0ZCvQpbkAIVjfpFBE48f1mx3ihNn2rxYpv7q/9R5LHqisJV3jatJVCgmPKY+N Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t70h7n0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 15:33:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A24E10002A;
        Fri, 20 Nov 2020 15:33:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A49A2777DE;
        Fri, 20 Nov 2020 15:33:26 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov 2020 15:33:25
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
Subject: [PATCH 0/4] Bunch of improvements for STM32 DMA controllers
Date:   Fri, 20 Nov 2020 15:33:16 +0100
Message-ID: <20201120143320.30367-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_07:2020-11-20,2020-11-20 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series brings 3 patches for STM32 DMA and 1 for STM32 MDMA.
They increase the reliability and the efficiency of the transfers.

Amelie Delaunay (4):
  dmaengine: stm32-dma: rework irq handler to manage error before xfer
    events
  dmaengine: stm32-dma: clean channel configuration when channel is
    freed
  dmaengine: stm32-dma: take address into account when computing max
    width
  dmaengine: stm32-mdma: rework interrupt handler

 drivers/dma/stm32-dma.c  | 47 +++++++++++++++++++----------
 drivers/dma/stm32-mdma.c | 64 +++++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 46 deletions(-)

-- 
2.17.1

