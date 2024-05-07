Return-Path: <dmaengine+bounces-2002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361338BE2DE
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 14:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A5D1F22F1C
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74615E5B6;
	Tue,  7 May 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="e0HLY+I/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45B15CD55;
	Tue,  7 May 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086704; cv=none; b=jfXykUXZFlSKDou8gL+VcIArgxiS45hN9hVOrmLe1iBu71um+5v5DvHhMTOl6zSI1MdztxgD0GhF3qDHReO3S51VcPvZc1lfXNkJYbNLHWtHeaKMT3f9IxPdj7VHs4pe4X1/ETi206jPbCRWnPHzbBjWl+fYtX4uYVZ4A/RbM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086704; c=relaxed/simple;
	bh=US3Ro54elQbhrmTXVpQeKPpfr3YcjmmpVKvk1eLBbc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrDQHYpb/SNj7l7T3GdhoJu2sBfk+uYd/gF+zDK1wlR2b80XEbPU16u/bQmL0VeV4V1TuhTBzeBOrcvIge1hCOGn+H7Lan7L5yh22lWx39tToZmWxJYieePyp9PNltMDl/QGuA3lYp0zMC2fjZjxl39KdOpvsV3SHZHJqF0Rs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=e0HLY+I/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447BCcrk001210;
	Tue, 7 May 2024 14:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=OzrCQo0hpWSO9pso58zSn8WSa87BgyfCcJpHJH1EMEE=; b=e0
	HLY+I/wrNHysZzR809wcSV4my4hqEcdtRU740FAqz9p0EkMMMwnho723iTxYzTui
	avXgRm7ALmOqjWZCUfadIJSw+6ezKuOFnd5zijJlUTZlKusJUb+ODYmMzYFQzrbT
	wiUaBj3W7WXOWxVjR5bwFKOpJk2tco8IDY5qjvVkzoO5YUzmNiMRFulq576swjWr
	D3Xi6aeyAZ2KdtZlOZTJD9mEiwW8UGhS/AdCitMWPqIldV7rH3WdLXyDUiMVsDiN
	bhKj+qAdho/1FQ5YgRTHh2GdReKmMSZOi6h7Re1iyFSMLgfnEYQ7L3CqhWxoShxg
	m5zIF0ZH4nBGzHv9IgoQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwbwckpyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:57:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D7AD940046;
	Tue,  7 May 2024 14:57:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A35721A91F;
	Tue,  7 May 2024 14:57:11 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 14:57:10 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>
Subject: [PATCH v2 12/12] arm64: dts: st: add HPDMA nodes on stm32mp251
Date: Tue, 7 May 2024 14:54:42 +0200
Message-ID: <20240507125442.3989284-13-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
References: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

The High Performance Direct Memory Access (HPDMA) controller is used to
perform programmable data transfers between memory-mapped peripherals
and memories (or between memories) via linked-lists.

There are 3 instances of HPDMA on stm32mp251, using stm32-dma3 driver, with
16 channels per instance and with one interrupt per channel.
Channels 0 to 7 are implemented with a FIFO of 8 bytes.
Channels 8 to 11 are implemented with a FIFO of 32 bytes.
Channels 12 to 15 are implemented with a FIFO of 128 bytes.
Thanks to stm32-dma3 bindings, the user can ask for a channel with specific
FIFO size.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
v2: use SoC specific compatible st,stm32mp25-dma3
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 5dd4f3580a60..73125657e7f0 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -123,6 +123,75 @@ soc@0 {
 		interrupt-parent = <&intc>;
 		ranges = <0x0 0x0 0x0 0x80000000>;
 
+		hpdma: dma-controller@40400000 {
+			compatible = "st,stm32mp25-dma3";
+			reg = <0x40400000 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ck_icn_ls_mcu>;
+			#dma-cells = <3>;
+		};
+
+		hpdma2: dma-controller@40410000 {
+			compatible = "st,stm32mp25-dma3";
+			reg = <0x40410000 0x1000>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ck_icn_ls_mcu>;
+			#dma-cells = <3>;
+		};
+
+		hpdma3: dma-controller@40420000 {
+			compatible = "st,stm32mp25-dma3";
+			reg = <0x40420000 0x1000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ck_icn_ls_mcu>;
+			#dma-cells = <3>;
+		};
+
 		rifsc: rifsc-bus@42080000 {
 			compatible = "simple-bus";
 			reg = <0x42080000 0x1000>;
-- 
2.25.1


