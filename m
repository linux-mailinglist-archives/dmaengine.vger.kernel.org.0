Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7112120ED5A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgF3FYp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:24:45 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:35649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgF3FYm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:24:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuohOX7msN/wn1O9mX5ikubqdlH1vtst1L7s4fb1dnEDyIxzrYeBhdLMLQmneEe8xrLPSNn21hh6aPt9dUiBmlPbu/7wss64HqpT16gIV30r9cWLCB7hm/YGufGSd37AqtGVu1UNWzyiPUlU5VkZ024J8OzJtnkWadwhqG4/Spe3QZaOWyB5dk4pIxtMyLDmnMxdCaw8LDfKTbR1Ub4gYovUv7WvloSMjj0qBSBc+MIuz11frAzKOZF08H+UlNPSM/2KXMdmo75F9/t1A+kQOealYTQ4d0RqCYdYaWH0b5fYFh9gRkdHev9mbd9KU49nF/3fTYdFK6i27pBcIO4FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdptsqF/BWMVGMcs2QnzmQDQwBwZuTq/BYSygQZL8U=;
 b=JeFjuX0Jh4XqYNC5bBhfvjMOs8el0zRZOpgotlbvzpRzy6SbZ9eWO9qIqJUp2ghopJQIHoj2qnivEw3VypBoWoQiIms57zNu4b1rkOULEDLrDJSbcdgUlJFAMzV1rJ912X7dxTknzgW79htkaC2ZN7cQIG9TzyTl6cQqFUBPgc8jpF4wdWqwuPguPgZ9CsetSjbvA6qDd/Vi2Ub0Zya1+u2y7kU2vwenM4E1KzW6y5C2ApcYmh/mzimSVI6rm26EDy4nBS8jo75LvrPSOBq+4MBLkNsuX1Q9exWa2tFx3QQnjbqhj0RqiXvtIPzIS5xRf/tlIzcEvmdquWVNpPhgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdptsqF/BWMVGMcs2QnzmQDQwBwZuTq/BYSygQZL8U=;
 b=kNrhqiD6Xspc3wxHQq8z0RTsUrfQe5ZHU3WSsvx0Pk7C6nyZKqvcBEOgeLHdb60OVgxm/pNzjdPb1tDNXUZTZSiRyyS3glWYFgegP+j1NlsfOFV5SpM3crIVzij3gDZq2WSfFOoVVPtuJPSNM7VUKZPOrlA719zw7AvPxMyoFeQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:24:38 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:24:38 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Tue, 30 Jun 2020 21:31:06 +0800
Message-Id: <1593523876-22387-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cb7d8e5-0ac0-4854-6e55-08d81cb5e20b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6640DA2D0748049E4DE0E75B896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeZqEsW2OJVgSWbYf+g/ecP0cRLJ5k3CcmQ+ztWd6qNqBLJFOcxnrdEueg8X3AJfMt9/ZiFc5BY54BiDsMOJseGSArACOXmvpaAOnNrxk1XayOvzP9VeCBnDPui7CZbUMCYGssKe0Z2JKWoreubGh2cRelKis+rCihrn+cU/i0T4xr2NnkE0BBDJ6iWixF2p1wkXrU5urPQ3yYNxxe+qiX3+8Cn9ZYmClO90v1H4rkxgH4ZEU3aKyAseegd1lAUM5UV7UtD+/RIoWIlubECbWUk8UkO0p7dT5kAxGJ7+Tg9sOtyY3kydJGoDkisPtxS9ogo0xbh7nF7Ksm5b8hI5n3Fk0jLInkWT534VlnLTIH3xGqjwY04EO+lZEirw/Aigtae4OSnJrKjxE07ignDq6sBmgoyni3o6n+4hRUcMOYslC+bOgO709v2Ptlgsr35PwRCuaUP1xSG3RyY6fS5B7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7XYxF5Grt+yVzbYiNi1rylqO4K7w11L91/ZzN4FR4U52HXIVNEKsvA9Hxy4lgtlPjbHJa4FJSIR8T0d+QI8LgVobUgGW0ml9rbCLZEOx4CMehXQZSQ+21XQ8TqMEFPky50u/WfsQTTScrCvPufPXdRgSqUknihzLEYed/E3SX/uUjpJ6qal3uzJZ5NyZT58G5DsN+05m0jMFZ+6jukGsv1bBrKytx9xHMLFe1ytNPKwLOk733Zhp0fkSv4/6EoR8rZq3eApCH1Vqshc21CJB6IXgUbpnNnyNcHiiLlzjCZgIXCJnfkp1dQ6UHt0J9n2ngj9cjFmBwHrCLz36xZWHJ+oPQaivlOtbUssfiOsg0mh3D+H9wz3MAHbc6uBTFz7T1/G/24QMk2IbpCN8JQwKhH+oc+/tkPRp2UI/XWAQebCfkoTzkdQECFctokOADt1qZg8wXyLF7BFEDLxm/rnNn7i9qs2rGavTX1WyDQB9rfY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb7d8e5-0ac0-4854-6e55-08d81cb5e20b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:24:38.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDF2aYHsyAW/8e62KD+brBDB6WI7I507Uc6eNbyp8kN9R9petDXuL4gmIoENi1zyE1IlCdCxokd6Mxuv2zNFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 346a52f..a8dedeb 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -327,7 +327,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -341,7 +341,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -355,7 +355,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -369,7 +369,7 @@
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

