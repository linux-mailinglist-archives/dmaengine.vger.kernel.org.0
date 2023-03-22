Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998A6C46F9
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 10:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCVJtg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCVJtH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 05:49:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAB2CC75;
        Wed, 22 Mar 2023 02:48:36 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BA79D24E047;
        Wed, 22 Mar 2023 17:48:34 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Mar
 2023 17:48:35 +0800
Received: from localhost.localdomain (183.27.97.64) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Mar
 2023 17:48:33 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v6 4/4] riscv: dts: starfive: add dma controller node
Date:   Wed, 22 Mar 2023 17:48:20 +0800
Message-ID: <20230322094820.24738-5-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230322094820.24738-1-walker.chen@starfivetech.com>
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the dma controller node for the Starfive JH7110 SoC.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 17220576b21c..b503b6137743 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -510,6 +510,24 @@
 			#gpio-cells = <2>;
 		};
 
+		dma: dma-controller@16050000 {
+			compatible = "starfive,jh7110-axi-dma";
+			reg = <0x0 0x16050000 0x0 0x10000>;
+			clocks = <&stgcrg JH7110_STGCLK_DMA1P_AXI>,
+				 <&stgcrg JH7110_STGCLK_DMA1P_AHB>;
+			clock-names = "core-clk", "cfgr-clk";
+			resets = <&stgcrg JH7110_STGRST_DMA1P_AXI>,
+				 <&stgcrg JH7110_STGRST_DMA1P_AHB>;
+			interrupts = <73>;
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			snps,dma-masters = <1>;
+			snps,data-width = <3>;
+			snps,block-size = <65536 65536 65536 65536>;
+			snps,priority = <0 1 2 3>;
+			snps,axi-max-burst-len = <16>;
+		};
+
 		aoncrg: clock-controller@17000000 {
 			compatible = "starfive,jh7110-aoncrg";
 			reg = <0x0 0x17000000 0x0 0x10000>;
-- 
2.17.1

