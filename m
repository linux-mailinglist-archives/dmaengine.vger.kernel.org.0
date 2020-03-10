Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE16C17EF18
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 04:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJDau (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 23:30:50 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:28762
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbgCJDat (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 23:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi+EhBj5NzRCGsfPZZogz/RLi3vqpLxL6SzObAuamkGUgxKMqKtxlSUb1cpzDANKJDO4ArBVyFldIxmxCPjw0wrP1hP1vkLTDgzqvvCXNCffgfSBBTbLufAQywippBm3TumUZjiIBbFmRiFKC9ZC3qOb6X4ZNEtgWfVWW5R3ogA0a+K3QxrZoDRdzIh5E0DA26oNmtQN52DltUHg0EkLF+KXAJvS6Qt70LUclNlGLPtl6OJq6XaUFODHFIx2+QlvQyJycnq/84Tk3fi6XpPCAFI9Hb1p4rpl9gmmmaNMXXSfZ3GOA0RxTnE1GzrzNUCfcESUPFo+8wYiT3jKF0lu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98+ZGiqA7mJBWYCJHE3+e27bEEc4CJ1c7Ivsg0bvtK4=;
 b=NTcm3SdpLwNu1v9r6GtRYV6At/U39w+VEfDyEyQFsRDxyytx4qvTFVJMHTkQ6i7zxGoAcwbvJeNYGbz+KIpEphR34Esjqe1zCjMvSS3rn4SgG9Mh3teMkNjG5m2Xxwl6o9QK19u/DraRpHD6BeXRpe8rlvvtVHV/4TmPxMnSkOtinpGrZksF+Qu7umO1TdPw2JheiRXlsAPbX3e2IxTrF7n+0TXZgHChWHSZ14L1+lhRykKxMIMJcpYNpibDLn3Bs96WAuZL7gLRq9VfHA7PrQPZdvgq8/kgATq7iOlVmIWke+t5WZhiW9VXZ2kwTEF/e2LIdzUKWPb2Wpp7IDOAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98+ZGiqA7mJBWYCJHE3+e27bEEc4CJ1c7Ivsg0bvtK4=;
 b=CxEx0t9DDUxda8KunWyGxVE49IBA6x+6pRSFNKPwccmt0Hdz1LnfdgjiHx2fDBfGn6FXUL05ifCH6BOic/01ExQjAPvKFnIW+1BlR3eunSoWI6asLOT6HVrNmEV9ndhGO9K5+gidpuZhvw6+TnNXhImahB4s+OS0K7pV9pBmGFk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6621.eurprd04.prod.outlook.com (20.179.234.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:30:46 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:30:46 +0000
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
Subject: [RESEND v6  02/13] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Tue, 10 Mar 2020 19:31:51 +0800
Message-Id: <1583839922-22699-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:30:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30fe8fdc-921c-431e-9a7c-08d7c4a36bc2
X-MS-TrafficTypeDiagnostic: VE1PR04MB6621:|VE1PR04MB6621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB662152968E0AC0F4187B59E089FF0@VE1PR04MB6621.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(4326008)(8936002)(6666004)(8676002)(81156014)(81166006)(2906002)(5660300002)(2616005)(7416002)(36756003)(66556008)(66946007)(6506007)(52116002)(316002)(956004)(26005)(478600001)(16526019)(186003)(66476007)(86362001)(6486002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6621;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywsBdE51bZCpW/+0/Zvx2qRwQiKJ4a6U9lfpijDCn7kaoGYmPX1Mls1w2C7nVpf7DiXCJZQDGCtyRNcrqbRHdR1mOx2/PkunRKi8O4aZo3ZFbm+JYJ8b7QH599UXSbNcGuNB5avohV49I06TKzbeX986TdJ9MhH9nt7UiAJy5dR/OJiBiqdrcBIu06LLWfLdKl4t2uwOCsB508EqQnBt36vA460yX1jSnInU1JQpcSU6S/Z9bZEl0sp8RHu620HrgUAPkkjPrmvzFody9KGUEMiVSl72CT7S3neRHkQeitT0UpjY1A14/bZos9iCBKMcP328PfdXawOeck/kuKWFbFkAstb9j+OCb+iD0dDb53ihVNfJg6gSwnEZjYsuEKsX3uFNTD0xOvD8sSWxgRFsDbW/kOc6zFq634SOmD7p121dzrumG06Q5yV/18ZRvEGaIA0XVuxHu0ih2oqo0B1tOtVptahJ3LGILxq9JdiNhjREu8itEGCSYk3V/HzKejbPhXrDjLc/iJ14VKF6wL3emw9Uq9jo9WvNb0S+Ja4pdgKr0ACQ1dNnDBcAWlfbfA0XtXzSGIaQ22MlH8cLC7qanw==
X-MS-Exchange-AntiSpam-MessageData: LCXbIRzOsYpFKIX9SWwMcbVFqADRgGqGUu38izS3iQGZetZhm7WqXU0G/QXzvcpxbH5Qag+zdT7BC5dm/eDEte+iZ1d9pQ5+I3tVpB+Am2PqREOb1VTJ1kQ6YlAn/qUD9UT7xOplSXF/RSQ4ohGvCg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fe8fdc-921c-431e-9a7c-08d7c4a36bc2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:30:46.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB4KJDvFqgpNU1yQLojGnaOD7MFiY3h7OUTf+CHfIcsTC5OxZQNnBUHdwqtEzVGhj8V7dBukhR5S8Mt0/tOrXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6621
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

