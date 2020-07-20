Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0FB2257B2
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jul 2020 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGTGeu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jul 2020 02:34:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18520 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgGTGet (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jul 2020 02:34:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f153afb0002>; Sun, 19 Jul 2020 23:34:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jul 2020 23:34:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jul 2020 23:34:48 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 06:34:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jul 2020 06:34:43 +0000
Received: from rgumasta-linux.nvidia.com (Not Verified[10.19.66.108]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f153b000002>; Sun, 19 Jul 2020 23:34:43 -0700
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, <rgumasta@nvidia.com>
Subject: [Patch v1 4/4] arm64: tegra: Add GPCDMA node in dt
Date:   Mon, 20 Jul 2020 12:04:16 +0530
Message-ID: <1595226856-19241-5-git-send-email-rgumasta@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595226875; bh=tc/XzjGQyzMqGlRhGZ2uP3xW0f0gkcCZd8iJhKBcbso=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DBt1PS1fQt2dZ2ukyVKd1eVcRXK90yZ5a7LPApGRLTAQ+/wsGyvWgDt5RmQQq4aMI
         Ml+YpBj/cLUMXUERKWaOq6ZtUDmzVIB2LVqJr4rXa3hHd3k8aVreYX0rmv/huABrRR
         SI6vf0UXznGbl/RcGZ+BDGjaTEzGdnomEl655wtfy9f7v52c0Lt6lxLcOonjA5PFh9
         MXY+hU7gxsWhyClEhHjJQQ+9O9mCY8efKN541KZl962YnfUuznRSd3yWHxfaOmCdPQ
         cQIJVtcyEeYpsqMWv7YzzkvyS9j4VB/1IlqY10KaU5ZESSot39eGcuzbQHD+SQRYfK
         H2qwbC6juhljA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device tree node for GPCDMA controller on Tegra186 target
and Tegra194 target.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 46 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 44 ++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index 2fcaa2e..56ed8d8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -54,6 +54,10 @@
 		};
 	};
 
+	dma@2600000 {
+		status = "okay";
+	};
+
 	memory-controller@2c00000 {
 		status = "okay";
 	};
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 58100fb..91bb17e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -70,6 +70,52 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra186-gpcdma";
+			reg = <0x0 0x2600000 0x0 0x210000>;
+			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+			dma-coherent;
+			nvidia,start-dma-channel-index = <1>;
+			dma-channels = <31>;
+			status = "disabled";
+		};
+
 	aconnect {
 		compatible = "nvidia,tegra186-aconnect",
 			     "nvidia,tegra210-aconnect";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 4bc187a..0bd67bd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -68,6 +68,50 @@
 			snps,rxpbl = <8>;
 		};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra194-gpcdma";
+			reg = <0x0 0x2600000 0x0 0x210000>;
+			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			nvidia,start-dma-channel-index = <1>;
+			dma-channels = <31>;
+			status = "disabled";
+		};
+
 		aconnect@2900000 {
 			compatible = "nvidia,tegra194-aconnect",
 				     "nvidia,tegra210-aconnect";
-- 
2.7.4

