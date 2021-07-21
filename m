Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B03D0E5C
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jul 2021 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhGULU2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jul 2021 07:20:28 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34138 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238499AbhGUK7l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jul 2021 06:59:41 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LBdKru028532;
        Wed, 21 Jul 2021 13:40:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=WH9sfPG0sFNA7LnkNWxq7q/+Vqhs13duVaMd5M0INYY=;
 b=mfjgMnmHu2oLf9JSYyCjk//ibLydGvJN0Ht8JXZXs7OTV/cGGZ3JTAERUwkBvjfPBOUc
 3xm1LLXcsGUghlim1TlvmWvaT9KXKfj8RZDOUsR6htHIVkWIa0D0d7Sq4GeuUvvu3cwl
 8mmsRa7sl1zaWJHZ98gIpmWh94Kp0Zle+Tk0QR0N2ThSzB8r9AB2WgmFmUr75ypNFD1R
 prNGL6dqSKUaDxocFqT0d+kfh64oN7ur8LMWhU8bwa9EbM4rp/S2djSn+R5OQLVH2S9A
 QQyfuWiaSSRd9EVd3H/IS057DNW/dondUrayo2BzYxRBytWRAXA2aMVGXi+cJL9ZNS8v 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39wvs0pre5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 13:40:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A09B10002A;
        Wed, 21 Jul 2021 13:39:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 137852238C2;
        Wed, 21 Jul 2021 13:39:58 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Jul 2021 13:39:57
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
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: [RESEND PATCH 0/2] STM32 DMA alternative REQ/ACK protocol support
Date:   Wed, 21 Jul 2021 13:39:44 +0200
Message-ID: <20210721113946.81001-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_08:2021-07-21,2021-07-21 signatures=0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Default REQ/ACK protocol consists in maintaining ACK signal up to the
removal of REQuest and the transfer completion.
In case of alternative REQ/ACK protocol, ACK de-assertion does not wait the
removal of the REQuest, but only the transfer completion.
Due to a possible DMA stream lock when transferring data to/from STM32
USART/UART, add support to select alternative REQ/ACK protocol.

Amelie Delaunay (2):
  dt-bindings: dma: add alternative REQ/ACK protocol selection in
    stm32-dma
  dmaengine: stm32-dma: add alternate REQ/ACK protocol management

 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml | 7 +++++++
 drivers/dma/stm32-dma.c                                 | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.25.1

