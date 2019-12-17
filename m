Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD001227A1
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 10:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLQJXH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 04:23:07 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12634 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfLQJXH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 04:23:07 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH9I2xu021244;
        Tue, 17 Dec 2019 10:22:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=li5jTmOrL8ac5KRD157xhCy6Bk2QBacNcgnf1zwb4C0=;
 b=00CE2ysvBnlhcCa4k5rQyxQJMwt53Lk9i5wb0h8lRtHl1TduUomGXTZw5GFcSVC5UCHA
 jx8DcGsso7Vp0JT9K7Cz7hYHiqFlom+VobOGuxBoQSWElEymqtNYTdTVWJlW3oIySFt0
 8c+8rDNjJ7/Oo/Cx27ksWKpuZVMSbmP54m08Dg5FdMnjWAzgiF/w5kvRoq5mGspkvCOg
 6Jmg60QlS7TUV+CPTAZK9HC/nSTHRPeahn6hgMOAILYmy2v20D1koRWkvE0/BouqinA8
 r4l3vNIKufxDOKStwIHzuGXPTj8ELdGQ+xrAM1vaHPazxuBKye7naMUZtCGkJFEuYMH7 kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp36x09y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:22:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 233AD100034;
        Tue, 17 Dec 2019 10:22:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16CB72A64E4;
        Tue, 17 Dec 2019 10:22:57 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Dec 2019 10:22:56
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 6/6] ARM: dts: stm32: fix dma controller node name on stm32mp157c
Date:   Tue, 17 Dec 2019 10:22:01 +0100
Message-ID: <20191217092201.20022-7-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191217092201.20022-1-benjamin.gaignard@st.com>
References: <20191217092201.20022-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Modify dma controller nodes name to fit with the standard naming.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9b11654a0a39..8fac522b1bc9 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -949,7 +949,7 @@
 			status = "disabled";
 		};
 
-		dma1: dma@48000000 {
+		dma1: dma-controller@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -966,7 +966,7 @@
 			dma-requests = <8>;
 		};
 
-		dma2: dma@48001000 {
+		dma2: dma-controller@48001000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48001000 0x400>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
@@ -1248,7 +1248,7 @@
 			status = "disabled";
 		};
 
-		mdma1: dma@58000000 {
+		mdma1: dma-controller@58000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x58000000 0x1000>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.15.0

