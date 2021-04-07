Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7AC3564E5
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346280AbhDGHP4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:15:56 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:44897
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346268AbhDGHPz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:15:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TolRM7+ubBKkOISnae3wMIREXsh+0R4u81qbr9PIp06kQi92gm+eE+5HqP1oqKxWfwQtGtWgrSHJXbl2+Rj3k8x67yjtHfM+H5feiZzJqGwLZIG/xLcuZQH3yltgzLifCYULd+mleLFDwMTGyI7mzrFe4juxyIvcI0aBDfLCbV9LMuMwrcb+n34bzcwF7uVu3T8SiLYeYl6ccQUFRe+s+bZU5CcRYZa3wG3Or4czDZiNsNek8+Wic7r75jYe96E+SuQeXwI8TwOdy0mV0plKV3xzAM1IA6DwjT5Y/XttBS9biiQ75TYCiokbr8g1skQh8V7ALfiAcdqM07JYZtVyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohpbX1KCjpCzOGoRNYXm1GGmodOK5+pSXpQ//vTgpc=;
 b=ZkXxDX9gYHpUo+Z4m6Chg/c3VQtBaUfIQOfphXICjbqRfYYx8mGcs9ASoF2xWJ5j2x6+T6i4leO1RuLV9s8FCpcjAW2AzIvvBEYbTd/yzKpdTC/1WWj1vUPWpFlAhWL+6MI9odZJvzlryNSy0u006rpkv9b9q5km3CdAVgSF1QfU2qx9QolDo2GBfsW9DoBz5jZG5yvch1B7/ZXCPK3elsnHDWMdW/PnjrzFSYOtbgNskTXOIEVNBpB+x9d6COLsQE3UXmSlMaNqadW48DtytHarXvn/W4B/n5Ox4AttGsY2H8jHIrUQtncne2bu0bK1DVweD79I1T1/z4V60/O54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohpbX1KCjpCzOGoRNYXm1GGmodOK5+pSXpQ//vTgpc=;
 b=dRT0/Oc2vGU6coHWFZ8qWTIQ+Jqz4hMRo6RyGyGr8j/83RhkuJdH0MT8iq3FBZPwtIOzy/yzNO5qIqCdhtzJFvHmghwpvbJIIb5hb8oixftiFN1Y4Q9tbBQBsK1jdqVaOjUbEMF9YxQ9Iza9ilfKgJd1Aw71AxEaPNzCTcKN8AI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 7 Apr
 2021 07:15:44 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:15:44 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Wed,  7 Apr 2021 23:30:46 +0800
Message-Id: <1617809456-17693-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4173008b-1287-4840-7a64-08d8f994f53c
X-MS-TrafficTypeDiagnostic: VE1PR04MB7326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB73269D7669577BEC21CF151789759@VE1PR04MB7326.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qi+Iz/lUFZHn1H2gP4+TMGxTBCFND4evvuFlU8/yKzas4UWWcl47II4upnF5Uxmv7OWTvUXRn+8RKJJOPLfZBfulkqHmvK6yIWHO6/ordL8CD2CuqXh6P5PTqOB5vIt6/hojclYB890ldT6r4kXqtqv0DI90d9JwwoDDdL2bCklspHPoFmuV+d+F68V6YAu58HO1zEHxO8mJP2qVc3bV4YR+D21OQLi0hIfrTnYMabSK6Ry+kEwDEeMNCAqlLWx9G8QDh/JkQROMXg5tK7LczVe08ySPHSqd2vjWj9L6yUOghxO8GT23D3ObEXwZBPcPPT1WMhiKGcC5qMWgrbSwYuKchObeF/NEoiaBFaBfXu3/nw8ARAqiGtvSTdGw9zOUh35ihuc3WnnTnD2kgs/4QR3KJ4V/rwn3iz5aUS5ZS0pIzfbQOMrRAWvfMdtHs08b7D7eIontQx7f3AagFU7QRoKrjgC52/G+GJSKFmIDV5AMuRNNOwSZc68TEzQeyZJrpQXf5OhzUs6JLjil47s+kQz2YbjoEAVt7Vt8+LaOkEZbSxhcKyPoalDbdHqHAB6yTzfc0sipuK2gBkGZ/z6LHu7PoDbEGs7qv7fGy0iSoFwfsy+AIqoyCdb7Cav2U+oMC8G9sz6mhpd7r50bk+7AZDaGpgwwnXyEBmeYJGwwS2MEnhNwAc1Jp7PGDCpTeTcUPVVAe9xnXcwuCOi2Ue2wj9d8RcUI4Tg15QGcBjetkg+Qd/+or7/bB9IiNLHafCuknkjOIdaPWAlSw5/zxDSmNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(7416002)(83380400001)(2906002)(66476007)(5660300002)(66946007)(66556008)(6666004)(38350700001)(36756003)(6512007)(16526019)(186003)(2616005)(26005)(6486002)(6636002)(86362001)(921005)(478600001)(8676002)(38100700001)(316002)(4326008)(956004)(8936002)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WXARBfCSs0B1gVdNvtWUVjJyx1qfW5zybrB9PlcmyMa8Xm5yxRYxfffa6fKw?=
 =?us-ascii?Q?stAsoW8srUXHI8LwCKWR9qSdapb27nQWhI8jFbWlL9ALJVTy28i1VwYekvHq?=
 =?us-ascii?Q?Jlu/GkBtv+eDHGkz6zEl9xiSjksremTQ2MI4yT1wanfNI9pu0uM2uh2kKOS3?=
 =?us-ascii?Q?U3uxq8tWg9Egwvi6BaspZYEyERXF1E2Dd9RvS0qqWNj/4uUgxR2pyZfQoSyI?=
 =?us-ascii?Q?kBG6hrR0z6anDZnXZPHpAzw+mp5rXJerRxbG9QoV2IeQAx5LS7Ey/k9sMtYz?=
 =?us-ascii?Q?vFSEXnSe2MoPjK1RNXBcT1eVuFrpNsMIg47dI9Reuh1bzxvHkkz9u1iv/OP3?=
 =?us-ascii?Q?xchJ0VKhEZtgCbwUxSchzrCHIQboz1+Z7R2ZifUYN10i3S8zsFQ6xJPiDJCC?=
 =?us-ascii?Q?/PH0bV0T0nSZV+fBzSJ01hQ/VxV+F9u+p59FeFYiLELCkw+aslzl9xQP/cE1?=
 =?us-ascii?Q?HedwyDLoOpTRK2mqw1llP/dctPhYdEADlcAwJuTlOPBQw/owRe18r0ZFYq6A?=
 =?us-ascii?Q?mQU/cW2oIPej1t+ipnhB1rW9DXzQZjZyef5ZtrPiJEVP3p/SbA0l7ixvxlcZ?=
 =?us-ascii?Q?YM2tZINVziPgqPTR8u63pgafK8ILWBVz2oGPfy+rJVG/RlXZRiiLpxQOEZfs?=
 =?us-ascii?Q?+gM+ARCi1wzAfymPX1x/PFWOY9gogBrkE2w/ZjboBUnIaqUQjXyih3Dly70H?=
 =?us-ascii?Q?4aYAMDRhenO4hi4lEE2wKhnaghXJsJiFOeBkcTUZdLZvmwKDT4DSZoatOynb?=
 =?us-ascii?Q?AxTLYMdZG5oKMz9E9oosxsLcpjCuW7BPlcGEiPTo7lJhqvdeE45ddHTVhUcR?=
 =?us-ascii?Q?fJ3Zni+OlKnKbYYCJGLgPnJAyVmM+jgpythRRZ4r2eqIJCXFatNNablQPjCQ?=
 =?us-ascii?Q?4KbagIx7iUch7V6mUpl4da1ZHTRUQOupIYjq28z1smyZ8ELgHm33R1KxvGdJ?=
 =?us-ascii?Q?4GbWzocjSc8e6BkYP8D41lvT3ACh6JN6kzKPO4O/SYBWaLOzrDXUe8CLlevL?=
 =?us-ascii?Q?yKAPNNP7fxpSQgE/tBDUvJ2LiXvEBl/S0HS3nDDTrszRH6BQWXL5NxDU0Nw6?=
 =?us-ascii?Q?Dmin6cUZOg5lo65yoC8LYw6qorO3Wf3WXZxZTDEdRI/xG1hkYga0FxnSc8gA?=
 =?us-ascii?Q?iyIK7kP/tYA92KghdZKATBCvdTyApwggkVmsI2InDw0SRTxiXSjaUYGhi4KY?=
 =?us-ascii?Q?7c4J+fTHlL0z44Ki/s3cEIK3DoMaR7+7Z210QXHt0S0gg7Mr7iag+cXP/bLG?=
 =?us-ascii?Q?XgP+QQMTW8cFlNzY1Vt2zSsG1M3nmHXqr1iwwP4BbYbBDkHtuTiHHeAviwWW?=
 =?us-ascii?Q?qOb/+CP6oyzmBeLCK+DiF6JN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4173008b-1287-4840-7a64-08d8f994f53c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:15:43.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wcj220AiV0MKyyiMQF/3T+t/TK0jVyADbzt4SzgCBkaTMA+xctfaESuSxm0ViU03V5bxcqltM3TsPzEQjkV7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
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

