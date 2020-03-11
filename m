Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2318131B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgCKIfa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:35:30 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:58965
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728263AbgCKIfa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:35:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyZUfyxaSsVfJ9ueopj2GIqecgKgNloUCzYsRgx3UZDaRRhVLndCBMw0X58CP00IfQw/qL1KzYB4vIif8h2+nnGysde34ProFuCgj/ResPlJ2IanebiWVBak1wGeReUXVQrnoc1VKzB4CRq8aadHJHFzgDBJhRqTq37y3bRnLswsQdV8ZPNw/jdOUfCJXFx/bqIvSCH+sSbE6DKpHuQN6CL+z8hyi5NRgG2MY9dhT3/MO67vJF2gkZqe2MLt55oTTAiy9HJRhS1Mo5jZ840Q1ChxNQWBORWhZfhxcW0AtYrJaIfb5Anho9aIC+BOuDqGilObT45UEKa+d6fQFib15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98+ZGiqA7mJBWYCJHE3+e27bEEc4CJ1c7Ivsg0bvtK4=;
 b=fipQxbXPT4Yq6vn14Uj2IWgAf0XFxC96mE1ejw28NwwNfB8AfLQ1WQEPPZE2W5RMbC/noOqhFqJBWTcmJOZJ91sUILcznWueOGK+oxxCvRbyvyBy2GSy3x1ctXeO19waAfMqfIgq2jcf5da+iez7tszQ5t6m1MfJAwSOWcUb5Zn03Y/hAz+wtpGh064dTxc8EvT9+F4E+dEpa0Eo7LpuS5EOOsvtVOgM5eWL1Y2h/+XvpiffpKcxy3DqtkBmBR60PPKx3GGCULsvfNYJUQJdRr2viaHccvyN71BQ1b2XmExMper4/uq6BGDwnxW9fVaekdn2LH2nZZRljg0i2m22bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98+ZGiqA7mJBWYCJHE3+e27bEEc4CJ1c7Ivsg0bvtK4=;
 b=gg9quR1ae7AKQBbRcYvtUwNNLERDLQc9kbnbcIL9GGnp6pITmR/VR10dBDbaRdv/bF8B3AGngdgHQTu3UMzyEqGiiBqUSZXL/WQaWA7Z3gk3NKkrfLoPxXf6M7KOojGx7P1d0kRQPgfs1FR/ZdkNHI04+b8k2UNra60flltxePs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6702.eurprd04.prod.outlook.com (20.179.234.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 08:35:26 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:35:26 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Thu, 12 Mar 2020 00:36:25 +0800
Message-Id: <1583944596-23410-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:35:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58be8af1-34a7-41e2-b2c3-08d7c597254f
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:|VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6702594E1C3169B008A78F9D89FC0@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(956004)(6486002)(2616005)(2906002)(7416002)(66476007)(66946007)(8676002)(66556008)(316002)(86362001)(52116002)(478600001)(81166006)(6512007)(26005)(81156014)(6506007)(8936002)(36756003)(5660300002)(16526019)(4326008)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6702;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZgFsEthgXfHpC7oqXkf45rdDf4kaki/9lGd1/rVtulY0yT47kJrGDWIWunoATk3/f3VUlmWT5e+dumNIbwOjZCpSAIBvSNdJhF0aQM+agxUYKwyrw72S1N+TJG+xkCL8NJc9zGUMzTnA/z3oi9LK2FFY29xLo2VQGwmRrrk2mRKrNbBCJT/y4X2z10wCM0KAngIBBDeZQfJYlyRNsFF5prn6FLKwUjU9jBkO44KezDmk1bDzG++lcMSG+WlBywXBlTSqEiszeU2qY+zJjdhsa7KbVMFXE13dFEZBv8HooTmscq08BMeczpd9IrpcQN8QBRHwMeSjYsX+D2zqGjI/yRHiGxNqzVyr0lyL5iKORwHbS3AYSm9rSYl7pjo981JXGebLmOs5xh4e8NeSdUSHHS80fY9DA16byqgiFMuH/gMdkCNWC8xCZEE/ioGyS6Mh2kpZqvk5rE/spnAxcReupy4V85wS316/+zPAaFu4T/KN1sMYZ+ZbXdGsSv0c3GLorjBbuLB/zDFtXbUniMPSc4daq/BxM6Rsyyxpujq6Tacvp6FV4XRMd0e9jg9N+m0c2pS5vU4wRyasET+IJ5otg==
X-MS-Exchange-AntiSpam-MessageData: pt/nSYXEza+W5/E32cYhFK62D8NGj+lIWpgBxu2EmQsXtfPjAw/cjTsYTw/mn2nXjXOTvNhU243UiqFjtVTnPSsauvam5Qc5MHvjWT4PyqzZ93dc11vP1dKEUrCPax+n3RYdfJuzplkwSaRkO3oT1A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58be8af1-34a7-41e2-b2c3-08d7c597254f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:35:25.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGsCrege3c87no7vTq5h5QUMZpWjKO5DmCrGpa3TgtMAY0blIyZwnFbsZQnjMJ9S7OQbaPhoYhj0NPOQvkYArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are two ways for SDMA accessing SPBA devices: one is SDMA->AIPS
->SPBA(masterA port), another is SDMA->SPBA(masterC port). Please refer
to the 'Figure 58-1. i.MX 6Dual/6Quad SPBA connectivity' of i.mx6DQ
Reference Manual. SDMA provide the corresponding app_2_mcu/mcu_2_app and
shp_2_mcu/mcu_2_shp script for such two options. So both AIPS and SPBA
scripts should keep the same behaviour, the issue only caught in AIPS
script sounds not solide.
The issue is more likely as the ecspi errata
ERR009165(http://www.nxp.com/docs/en/errata/IMX6DQCE.pdf):
eCSPI: TXFIFO empty flag glitch can cause the current FIFO transfer to
           be sent twice
So revert commit 'dd4b487b32a3' firstly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70fb8b5..ff197b5 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -337,7 +337,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -351,7 +351,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -365,7 +365,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -379,7 +379,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
 						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 9 8 1>, <&sdma 10 8 2>;
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.4

