Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443072A98BA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Nov 2020 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgKFPnq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 10:43:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3018 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFPnp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Nov 2020 10:43:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa56f2f0000>; Fri, 06 Nov 2020 07:43:43 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 15:43:45 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 15:43:41 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/4] arm64: tegra: Rename ADMA device nodes for Tegra210
Date:   Fri, 6 Nov 2020 21:13:30 +0530
Message-ID: <1604677413-20411-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604677423; bh=zb891QpXLeXZXfTv5XnBODNkkVbDqOwpv9kH7oIWm3w=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=pnVMlCCFKghFFwpg984uQBsiyHQztXddN/7mPaXptNgLq+RaFPNOpS+PXGtO+qeKS
         7qBH0cXFJ8+aPmvojXOAXb3DqJKMCwAf8T98bjOql3wFKSUqbTfrYMYTzyE0/eJy02
         V6H7mZ+UDqSLYJX2BoImah33ElzDy2gZYQkqMtmWHT9xViHIbzcLXFhOgtF4xmxOOh
         LE0OquIYeEYoHehoptYDbUsTOaabKFc4eTTX3bDMZjto6jz+gKTt1bbySyY3nDBQxg
         YBvBqeQ/vdnoEL/Oj4NU+aSthlrr9Cr98e2WBcgOhUdEVRQN+cwqaVUBERYC8v7gBb
         c9Cd1Dg78yFDg==
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

