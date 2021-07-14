Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2883C7B52
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhGNCHe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:07:34 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:45953
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237441AbhGNCHe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwRVvoMplVB+1nj6DwmweDXl3C+/wqvFcgOBHXTnTg4z/OO2C9/knLsHcJXiesPKmjAUOtRgI9G9+2eCiu/p73zANh+jYNjv6YDvQsuVR7y8SAXASbElnfqVLaNA0shIFAiF88OEXeWwKHFOtYcXaoav21zRJURh69kbKQDXaOqR9UObLS1f8KELPe+xVVXdjlDbqNmmk+V2SSyta1zx1+c6YJU5FmaMDQiQR2KHkj65pA548uKSgZDiEam6h78WoZ1dh9No2egAoVxxTL5klUXKfAIzAqengSg1sniSkKNQ27Ar/jF/NrLAQUF5D5xhygfWFvSLqNyW5COTZwXi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohpbX1KCjpCzOGoRNYXm1GGmodOK5+pSXpQ//vTgpc=;
 b=TIeQPjDN+M2FbtLO/VggM+pySVspeE1WdcvoCW9FYu2NGZsnnJYRee+JxfZdUmih8COHPAsinI4tD3N4HNxzJhIlC1cGCgpZws7bJ4waMJao9Pp4cnRfW/t/Y9NnTH1xjyXwOoZUFVgVbXHgk5D1RFIHBtTlo/XOkFlC/bD8RiXb91ZKGcXWKYT481ZyGeyYJqUMOy6s6TDkN12st8g/yZxxgOXzamC2GbO2bH6EMkNUvsycIjCl4BEyEBDGmR9cfhMQ0B6qyr/Xcn1S/T6XLQjfi3bjdCxJHZrG0Bo+VZB6QnTaIPAufAqDVyxoHV8rhBRgVKPX0A6AOZIifUfwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohpbX1KCjpCzOGoRNYXm1GGmodOK5+pSXpQ//vTgpc=;
 b=DKZhO2exOXfggvfnY86QXuFuvObCm6Xwrc3Yr35nINr5Ye5drW8KQ6FqeWPakycmMTLQiT42cI58plD/xCRF2BRUMdhzhSD+Geaks9PRmVv7NFo3/0UwzEK8WFYxDuSE73EjRxTIvj9ERLfzNns7f1N+ULs3dgHmPIUUkc7jC2s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:04:40 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:04:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Wed, 14 Jul 2021 18:20:42 +0800
Message-Id: <1626258052-22198-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:04:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ff3821-b971-4a99-cabc-08d9466bbcf3
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB417530E18589A83B0E9005D289139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09HmalenueCBsq/veUmZnvJiJNG6pdoHpP1E8MgUaokvuxT3uD1qLzP1lTQFpnMHB66+k0bWOk9n0jSXwb4Z6Ptp5SzHMH2poYZfcs1QOYdQcstYTrnzoyP8qPiZYhTDSIMKR6cjANi7SgoPm+V47LZF1EaRppdMyZF6DwCh+as0iq8WOMgfxQPylviefdYf3gPQMLDxHL1++Mg/sQf2TOEd+OTOTlSGzcEwTYuPOzYojj7q59OJjBofWsep5DmBoKbO30DhbWS+39NTqDJ5g5ZcDs8Xn5+uSJpMffbbFeScWY49DVjQwoHOL2/LWJXhejGwmP4t0oKk3bU0ybbBEcGTo54K/vh1DRU3iUvZrO13Vul10tLEMiMFlvj/HtyxT6ryRlq3WzZWlxI9IV2j3xYL6QfQOpEzUuyA0WSZq75aQg36box3dalDP5WVqccFgydkGpau9SoA2jtofoonKzmufWL1vAfQqj2A9NA1iObrk/wvpvSQtlFRbZF7LN3ukSnoN/d756iWzoEK2pamaJEJq7XPVh7AXDeQlEeNhM+fOsN4duKtwGWplswBqa1fdXHukTIJxW4fVggiM7gtvdq/BxifeQ3qNqTEecf/a/AoLZrHTS+8xabvdxJzSQq11SGK+iFvcjaN6lqYwu6FPq2BsiAXHRYtiGUJ0WQgbyGwt4V8rDquThT7iLOzmPTAtITq075rN5gSKA1X2AS/84LVRgYUOaPUrwFj5EQJTx3i7utdHzdzOU6SomRbxbvpZMRAKiGpc6u0ytXA3kCe+ruJZb/KVWLo12bKONUQhEhozwNiQv2/yqENUU+QUlt2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpGg2S1xa9i3X2gTHYafKC2NKVvgy5KEo4qUSNUOj1iNRH4XA0bfksJtIQeD?=
 =?us-ascii?Q?0a7pHkYvfHskDu4pjhvxZHfUvrZuWBPH6Kuwi67SNeyBMTVIFWIKjhB6Vxxf?=
 =?us-ascii?Q?E2jHe1iDIwv151UL1lRhpFG44MN8olly835asRLeRPvf+h6qrkJlmmIKP0XQ?=
 =?us-ascii?Q?bajTPk5uljQjzWvImi7j0i7zFXXtOINyWOjcPoxT5HqzOcC1tXN/jQIsY88F?=
 =?us-ascii?Q?XECIupDKaeOHxcRHtk7rMuviYeIy5hmK4Et6pVcMiqbpERwKrILOL1PkW/JF?=
 =?us-ascii?Q?6MnA/kePRY51919pvt61X5RIIGN/rjTJI52FqIcRT2kYacfLboWy9HU7EJKr?=
 =?us-ascii?Q?+Bw/mn7LWzZs0fb+xgvp4ljrm8LUX1TYFg/el3QG9cD4gG/6R6YT2Y//g9AJ?=
 =?us-ascii?Q?joyLHpEuK0Gd4GS/KCZQdoO8bDkP+x3FoPqX/eL0L2zwp8i78UbMmZQ7IN3d?=
 =?us-ascii?Q?Wvj1WknrinqGsquARHi0uPqkn5ouexhjr2o0wduiWYOVB2mcWqCahZ9CDfpP?=
 =?us-ascii?Q?I2T4r4uNuse2ni5PxaEy0RtwNvXKsZTpy4pSrpGNwIaVDIM5Wi2SZRY810iW?=
 =?us-ascii?Q?AxhcCDAYos6vQA9gMMoRsHhZcRlSfcsUPrQrii1IN+hVusWLvcW6l65nghcA?=
 =?us-ascii?Q?Y5P7J8Bklwz4Y5jRUj54Zb3Wt/QKINOHfp8d0uBFFVOF9J2Nn8l6vPWmCLZ9?=
 =?us-ascii?Q?818Eqf+VwnLm5lT+647zkL5sZ2ooC/n+DHSicxP06ZhJL3f8yomWFFe+6Txc?=
 =?us-ascii?Q?+lte1hR9xe0CZEzi3ihIwZkJItDsC5aNW1K+0AXD+MSAKBGGUDPmJ5COyuMv?=
 =?us-ascii?Q?fnaXvxAcbcUEnfHamXKILYGTFRRdItKUrpOdubZ0H3sosWfB0qQvQ1oRiMxr?=
 =?us-ascii?Q?d/R09c38mEZYtM75LQGpugRR3Bo2HvLi4g9Vyv9G+6S6KoYHhmjWKkgHwcBr?=
 =?us-ascii?Q?SWuAO0Mc2hZDaEYdJ7mSYt2T+LDCQNOan3g8SHTGCUycol9mh0mvtMapWdsu?=
 =?us-ascii?Q?U5Nh5hQwIjlS+bQ1Z5Wvdb6bACTZPedIpmty/kQWGi84x8V3eXpHY9p/YC6U?=
 =?us-ascii?Q?l5BBVAUBMSw3UZC6mq9xf+QFPv7lUgzBy3rD6YbwFSz7AQjFpK9iX/H94EHP?=
 =?us-ascii?Q?gPKztpjfUCiEhENtqpWNa5xRChx9NCi8MlfMoHF744+QXj+zFrJNtPlheeKl?=
 =?us-ascii?Q?uvO+BrSglFVLuGQ9xL1Iy/6ejGsf661g4b6ZeypCBcVurWsDQgpD+BsTa3RS?=
 =?us-ascii?Q?QOZhSqGo2cWpLtFV12I1cjKyukT0SrySVYASTg04llSHB4BxqHTylogcfPIp?=
 =?us-ascii?Q?XIZZycP0TR0As+aRaBzDDVht?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ff3821-b971-4a99-cabc-08d9466bbcf3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:04:39.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH3BwmuU8G2aPzqb82aCArO9ZHorgnnesgBl92b/eEH76afsm1+gDsfrbPtalBm1UFOP9sLPYuZS49Qc2+3vqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
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
index 82e01ce..89c342f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -334,7 +334,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -348,7 +348,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -362,7 +362,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -376,7 +376,7 @@
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

