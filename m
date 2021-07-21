Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE27E3D0E5E
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jul 2021 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhGULUb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jul 2021 07:20:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238503AbhGUK7l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jul 2021 06:59:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LBdD0L011603;
        Wed, 21 Jul 2021 13:39:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=GpaCeRZVjtH/clmvmqA7oS+5T/2FGrNjLTB526P7vpQ=;
 b=L6knxW0V5wdHd/woeqis8aK9mti6xQ0hucPzhTdsEn3kw+yQHWYC6NgrEh7wh2tjW1gf
 o0xZ8w965TK/KSjeay2hxB8GjJTOjR8us2hfL2+y2pPQSlHUGp5Zg7XMWzxSG6XoT/uy
 rHLjnIzpHOkKXwveQlQYKKCiQfsIB5FRTMqKun8fPCA7Q3b8uU/4Xgj5RVZULtmOFuQZ
 oVfMVJurDD3U0OKbPuHxmYh4SqOvDEn4JYbGXlUDsQpjJpkbReScZCFE7mX123z8Ea8P
 Bngl/2EnCyDZn1MfdECt82/8vPUuTmNcjlDYUw7N5NBv3Xvl3mXxGaYU5AJFAf2ixik7 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39xfvah3vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 13:39:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 35DBD100034;
        Wed, 21 Jul 2021 13:39:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 245B72238C3;
        Wed, 21 Jul 2021 13:39:59 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Jul 2021 13:39:58
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH 1/2] dt-bindings: dma: add alternative REQ/ACK protocol selection in stm32-dma
Date:   Wed, 21 Jul 2021 13:39:45 +0200
Message-ID: <20210721113946.81001-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721113946.81001-1-amelie.delaunay@foss.st.com>
References: <20210721113946.81001-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_05:2021-07-21,2021-07-21 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Default REQ/ACK protocol consists in maintaining ACK signal up to the
removal of REQuest and the transfer completion.
In case of alternative REQ/ACK protocol, ACK de-assertion does not wait the
removal of the REQuest, but only the transfer completion.
Due to a possible DMA stream lock when transferring data to/from STM32
USART/UART, this new bindings allow to select this alternative protocol in
device tree, especially for STM32 USART/UART nodes.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
index 2a5325f480f6..4bf676fd25dc 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
@@ -40,6 +40,13 @@ description: |
          0x0: FIFO mode with threshold selectable with bit 0-1
          0x1: Direct mode: each DMA request immediately initiates a transfer
               from/to the memory, FIFO is bypassed.
+       -bit 4: alternative DMA request/acknowledge protocol
+         0x0: Use standard DMA ACK management, where ACK signal is maintained
+              up to the removal of request and transfer completion
+         0x1: Use alternative DMA ACK management, where ACK de-assertion does
+              not wait for the de-assertion of the REQuest, ACK is only managed
+              by transfer completion. This must only be used on channels
+              managing transfers for STM32 USART/UART.
 
 
 maintainers:
-- 
2.25.1

