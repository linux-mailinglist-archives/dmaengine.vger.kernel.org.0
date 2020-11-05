Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6192A7B96
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 11:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgKEKYw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 05:24:52 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17698 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgKEKYv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 05:24:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa3d2f40000>; Thu, 05 Nov 2020 02:24:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 10:24:50 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Nov 2020 10:24:46 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/4] arm64: tegra: Rename ADMA device nodes for Tegra210
Date:   Thu, 5 Nov 2020 15:54:03 +0530
Message-ID: <1604571846-14037-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604571892; bh=zb891QpXLeXZXfTv5XnBODNkkVbDqOwpv9kH7oIWm3w=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=VH1i8h8e3kmsHk6WDokbFoT2V5VWFyNT7MnCXST/NCbatvcpJDwDKqvpvgDytOLh7
         LlhNkBt+akiM29eGuH3k6NChS+amDTbKnycpn/ARzauAUJM15TtY3j6FL9q5YDpjrj
         agvsHhdVXPAYbxplHQVMAqyCmNbOP0It4Rlz60ZJBScuBBpRqtLZiDCxcUQmJM/x2v
         IWnbZwJeUtiWuPwkdcesjT8QcmbVEdD/7f5XsvaM+FoVMHFihAe5KWnVWwpkul0h9P
         IPMZxjw5GgzMFWllWADfpYnI9Hmi05IK/MgvEtTU0GtFXDg9TR5FzcS3lffQooFguI
         Zgxz//rUPVI1Q==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA device nodes should follow regex pattern of "^dma-controller(@.*)?$".
This is a preparatory patch to use YAML doc format for ADMA.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      | 2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index dab24b4..e9f8410 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -120,7 +120,7 @@
 	aconnect@702c0000 {
 		status = "okay";
 
-		dma@702e2000 {
+		dma-controller@702e2000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 1216b65c8..f8e8bcf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -630,7 +630,7 @@
 	aconnect@702c0000 {
 		status = "okay";
 
-		dma@702e2000 {
+		dma-controller@702e2000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index bd78378..131c064 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1717,7 +1717,7 @@
 	aconnect@702c0000 {
 		status = "okay";
 
-		dma@702e2000 {
+		dma-controller@702e2000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index d47c889..d41eb12 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1344,7 +1344,7 @@
 		ranges = <0x702c0000 0x0 0x702c0000 0x00040000>;
 		status = "disabled";
 
-		adma: dma@702e2000 {
+		adma: dma-controller@702e2000 {
 			compatible = "nvidia,tegra210-adma";
 			reg = <0x702e2000 0x2000>;
 			interrupt-parent = <&agic>;
-- 
2.7.4

