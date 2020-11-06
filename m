Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA76B2A98B9
	for <lists+dmaengine@lfdr.de>; Fri,  6 Nov 2020 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgKFPnx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 10:43:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3038 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgKFPnw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Nov 2020 10:43:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa56f360001>; Fri, 06 Nov 2020 07:43:50 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 15:43:52 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 15:43:48 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 3/4] dt-bindings: interrupt-controller: arm,gic: Update Tegra compatibles
Date:   Fri, 6 Nov 2020 21:13:32 +0530
Message-ID: <1604677413-20411-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604677430; bh=kvzP1+o3QefuVm2M4WY6kUuSTHsekt98vQR+sG4CORw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=FMca3l3pNloYrQFWl4hnLVQQijHf5bUTnCIfn7c8/xAbdMM558u7DSmUbUKA2KNx5
         +UKl57wPuQi3fE+I2g3WaNVL0unx0+ExG0G1noIsIzTO51f6YCxboJo//9q4fgglvJ
         Rfs8K2fWoDgC8uLKGQqwj+2iMv/pJsYiZKON3ICN3QCiQ8hMseXaJ/DQYP5opEroQ0
         Si5KfwKEPGXogovDk8PC/tbfZPnbv+KhD7Qjc7v2vb3iAzg2iFZ3pAXR4x5vY+3mXC
         wmXqT9mdpp4wbgmGYtgZBaALbvc/r0afCtLqlTEPvl/p5tWMRKmsLn5+35zYrqYdwD
         BiNUWcF1dVIUw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Update Tegra compatibles to support newer Tegra chips and required
combinations.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic.yaml        | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index 0688996..ba282f4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -35,7 +35,6 @@ properties:
               - arm,gic-400
               - arm,pl390
               - arm,tc11mp-gic
-              - nvidia,tegra210-agic
               - qcom,msm-8660-qgic
               - qcom,msm-qgic2
 
@@ -53,6 +52,14 @@ properties:
           - const: brcm,brahma-b15-gic
           - const: arm,cortex-a15-gic
 
+      - oneOf:
+          - const: nvidia,tegra210-agic
+          - items:
+              - enum:
+                  - nvidia,tegra186-agic
+                  - nvidia,tegra194-agic
+              - const: nvidia,tegra210-agic
+
   interrupt-controller: true
 
   "#address-cells":
-- 
2.7.4

