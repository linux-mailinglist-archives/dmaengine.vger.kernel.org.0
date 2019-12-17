Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEF122794
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 10:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfLQJWn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 04:22:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60794 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbfLQJWn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 04:22:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH9HuQK001317;
        Tue, 17 Dec 2019 10:22:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=bIVPxQpH1y2Nz/DK2A/oJ0wAran2ozG4/+vhkdgb6pc=;
 b=N0Z/2exOg83ERHatB2ajspECSMyg4lICfAkuW7kJincP8rUKG6oDKa4yv8JPa10aSH4j
 2MHyWqJ9HJxmIYmzcYl/GI1iZsKyZAGDI0e3EMRRWCCwErX9LK0bXTF8xJrPv2+/f59x
 jkkjBRMw0fmNl1E0aLz3G0NEsCYiUN0dxzZWO4xdmn8LlR5ubi90gkGMMW5vVnrGHQsG
 aN1pqunAxZCApNVvEagOk2WazPNNPm70BicZ4tWftlYaKwwkUB35siZ9ffluvqyG83bn
 jytitTmP2CfyVc/6BJAshFwPIfiSoZZL4WkkY02p7wq+2i7TAFRt1Io0Wjp5B3t1of+v GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvqgpnksy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:22:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 459E9100038;
        Tue, 17 Dec 2019 10:22:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2FE212A64E4;
        Tue, 17 Dec 2019 10:22:29 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Dec 2019 10:22:28
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/6] Convert STM32 dma to json-schema
Date:   Tue, 17 Dec 2019 10:21:55 +0100
Message-ID: <20191217092201.20022-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series convert STM32 dma, mdma and dmamux bindings to json-schema.
Yaml bindings use dma-controller and dma-router schemas where nodes names
are verified which lead to fix stm32f746, stm32f743 and stm32mp157 device
tree files.

Benjamin Gaignard (6):
  dt-bindings: dma: Convert stm32 DMA bindings to json-schema
  dt-bindings: dma: Convert stm32 MDMA bindings to json-schema
  dt-bindings: dma: Convert stm32 DMAMUX bindings to json-schema
  ARM: dts: stm32: fix dma controller node name on stm32f746
  ARM: dts: stm32: fix dma controller node name on stm32f743
  ARM: dts: stm32: fix dma controller node name on stm32mp157c

 .../devicetree/bindings/dma/st,stm32-dma.yaml      | 102 ++++++++++++++++++++
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |  52 ++++++++++
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     | 105 +++++++++++++++++++++
 .../devicetree/bindings/dma/stm32-dma.txt          |  83 ----------------
 .../devicetree/bindings/dma/stm32-dmamux.txt       |  84 -----------------
 .../devicetree/bindings/dma/stm32-mdma.txt         |  94 ------------------
 arch/arm/boot/dts/stm32f746.dtsi                   |   4 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |   6 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   6 +-
 9 files changed, 267 insertions(+), 269 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt

-- 
2.15.0

