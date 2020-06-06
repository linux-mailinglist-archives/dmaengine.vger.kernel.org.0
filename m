Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6531F0753
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgFFPVc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:32 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:33664
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728660AbgFFPV2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJVuBmoKVP/yntNXT7lJbvw+ek1MqkGKWRVMk5wTrgerUaXlTphXhtO1Up41F0nqNYFOrTPu+ZpO3hUtQVqYoEL2NLShobvGRzbT7Aw0zPJhGQyO/rZyijdiOiwSyhNvqUPP18xAO/dJPirQtfJa7XO6YhfM8+4xbUCf5y/V/nnCeT9OQoRsYla1YS8jOLDuzQ31QkjClKYdszYCbCF4YubOG+3GUgPutZinwGYOxiunNo8fpl5nh8Vzg2yIADFJKkgCKZ8crORALYTTGo20AC7OITlFwd+ec+IWcdIp1Ynhj/p3A2sP55I6VmAz3EBtrETlf+F7z0Rbe9muMcFeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8bHalFai1IPzAYRt3Uf7FuWi//Xa5PjTOrdEZJL9qQ=;
 b=H4B2lQotgaFt3pPW0nro5t2ItE8t09cIpMixuk+KV5AURJYa6Qe5xe/ewzkoMHHU6qpHVwvWVt81WS98ow/sWtOocda/5WNCO9LIKsAsnQsC4vQU2QoX4RatqKZF5Xdl91v/G1O+LHJ/dTCEJA2A8t9WN3CMUG/uPDqPuRnkNtbpzxNKqC2ifq2H7vDLM4OgCOlLVJ1TFyD3x1Ha4vO6RuWBRtoz+Z7+LutQ/UUSfXOvoPp76sut2nvk2EL2ou+nTFX9RN01FYBzwv5XBOMEJiNMP1fFGe0WwOIIicbIBpTQV78QIUdpm2fJIMtqn0gOJc/dtkHkn6L696RB62JI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8bHalFai1IPzAYRt3Uf7FuWi//Xa5PjTOrdEZJL9qQ=;
 b=oY8ltAiaPaUJSWr4fF48dehsF54n4WBfK1NyeMwVJov0wfq9Zj7pmW8VcHMtjDmIDK8Vwy2aIJXture1IIolYafmZhc3rqyS18VG/bdZ8vkX1VVdwpIIGY7bLFiAf+m/2fI1WRZQbCjT8ysmPIxaRupAMp/Lpdi2gfJX5+0MzSc=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:22 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 03/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Sun,  7 Jun 2020 07:21:07 +0800
Message-Id: <1591485677-20533-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0d58d60-ed4e-4849-724a-08d80a2d4542
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB651123F9FBF72F4A85956B8B89870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 243wZ3SnFNOIPcitcVtRUpejdvt+dff/uBVdMOyQXE+E6tp5MmKwpuymqkxNOqeDzXKYl8sspdG84uXlPywrIdX1OPCkC7B5QYTnjC1bmFIeBpb6qJHVnyuvaDoFOoQ3/oKnsjsUKp1kYIiDsG3pdiJc1e3o3H76o56ulAjD+s9V21K4qfzn5h37r3BR0OvxNjQsotA6qHQ/SOvZiYvx8PreISFbT0lxrskrp8VIkjxFQ9RFhS4BNfiHpaogXByvO9WFrEsN/YtEPLdjc0I76AOIODc+LR1MAJUaVGAK5jpAi6LmOrfw/dptqiGaktK32iBkHTYViWNzAY3yCMHsbBGu6wGynhu9n3yz5m16wow/jc2m1dsaWEnDQNUsZyTZU6O/Wc7WVxaKfy0hpbAlOGjFAl/8ZdWiAB4wLBrFBjhSUxridAzLDzt3NZD12tUNEntCFVdHwu0sYQmCibt/HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(66476007)(16526019)(6506007)(66946007)(956004)(6666004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(6512007)(8676002)(83380400001)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IDxsi30zQsQhZRbv+oDwSDZqN3TcWiMeJxnqCPl6HJt+Lyr0nPdLKyBCCEt2SIlsw/LLFi70PkPN+mECKr40iy4MybehTp+3sX6k9MBDvOTrF4s8nAQHB/Jib8zIhbvSCa7In2+mLCrrrp7XuAChF+00LS+17QhZbw8KX5JA+R+xVlPbqOVO16ikYjHl1KkDxKYGPc5Nvzuk2Ia3iMtoV8qI/KAj7qR2/N/aQVOGUJgkcp+uK/T0zpGLryr3PHKEiaez9Hej53CkO5P+lnyY0zGRCWDBbd0VjG2+Zdn4pvvOPPX+YglLnUeIQ7rLO51NShB1CfVykuxXp40Tk4ReZGFqC5XVf7xAAfEYZveVtH7sjE59RQPOd1/HrjZDBmcQJseju/SlalkniIwC0ch7ynucqlNSShwxauEWB6skQTJg3U/EqVYVSflkPoRnpQC2aFlXvg0zWI4rVcTK5N+GkOqozOd7DH5iDQ6Zk3EpnHk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d58d60-ed4e-4849-724a-08d80a2d4542
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:22.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EcOm8FYGgc0woMHR2LcdJ9I47E1rGy65rmezu691MhehvMTXBfBoeG+6tV40txs7MelYx9qgfD375q0GgBdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
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
index 32114cf..9479a90 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -338,7 +338,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -352,7 +352,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -366,7 +366,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -380,7 +380,7 @@
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

