Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661E02574AC
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHaHuv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:50:51 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:64790
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbgHaHur (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs+SFbApOwmcpKNlM8Rg0jLlsFXRVrfZdO87bfSTZuyT91UR2uS9vngB2wRSkuOLAwHQJr1wpouR6e2+l57QJbgYtLkfQf82WRrLYhU9ai75uu0Unx4/fmDn/st4sSV/XVCKNxZC3zIbVhZmCtSQHmiY4dWkHLVtq2cWXYucmrMQ/VZlXTsdVaqG1oVvdZPlM/yADBSNos6NKbiag90lR26HGYBQc3F6Xv7+UWNG0ONqxvQl3Wsb4LK+o4i5qAQAJyv06PCBVHAKW/VPOOqFHLkl4ea23rClXqoF5MFng3y5BUDdBrt7GdOpC+xihh/+oAGRY1wM2or14duahIYAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iM2HUDRzfF9jaEUIMRjB1aJlm2kyt8x/+8OUSJxnmw=;
 b=U8mgFAOlq4M9dkNasvml98CzKp5EkF97Faw0PKapQE4l6e48tSb/9F7vfJumSF18o+pVXiAvDVhepe8nkd0NQZyvptfnKSCOuXABGYk9bhbBLSU+TnsouxSaOEzzAyQ/zIZct4CjkIEzWO9shvZL2RNYkBYWt6eCS9Lq5IvhmRkvORDsDHfCWT5T2p6QeDpiMkecGlRaHN+/up9+A5kmAuPgJ+f/mzHJfRfOGHhFmuCL3jDdSjHCtCLpN22dA2PkqaKld2JXC6EpfG/wyvoFbDsnNw3Co13JiZfD6Qzb21QaMBgbNQ0DAXvMY/Y8tEnbfe+IQKCGZjJB5CoErDv4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iM2HUDRzfF9jaEUIMRjB1aJlm2kyt8x/+8OUSJxnmw=;
 b=scVmhO9PBd77EUddyaDN8FX3dcO6aBxydqfeZcOuq7hnZJGXVy9qL02aXMMbbyTXKYqB8TiOFSVeM6tA015Ciuk4jwCBe6wJgm22BE2ATad8ct4Cv2I+FGfsErG2aUaOI18DAHsOyHyAf/sYx8WnIkjFrUscYBSWcNrcmVKgy2M=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:50:41 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:50:41 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Tue,  1 Sep 2020 00:03:15 +0800
Message-Id: <1598889805-30399-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:50:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79b149c4-833d-43a5-83b4-08d84d828eff
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB569477FD4996A2F1F24C53A589510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkBT6xIyQfXJk18R5XS0smbwUOE1Pa4N8i45/1PrZY/yEwJSbBb7/599Scg4/73EJGf2IfoxJBCxCeN3X9sYh6UE3q4yvu9VkhdELxqXpY5MVybzOwWv7ek0Y0nKnv7NUNbYukboVFezuI8EjS074ovNX4psKHMX5LQyNxXWniYCz3Yss/Of4xxlfJYO0+NUU7ACZJDp9g44DAqBym2i/oNfu9+JJ/QbeL+PbxLxgtrEswV0POlhtQ1KkbZE4Xi6oxt3i6GycIECV2c6QFVpLyMDc+zuTCfCi2vN5VikTWh1YJHP/gdTqBtyDXOAnkZKShcyxAV3P311pvFyNWiJWQMSckGvObppgsyaAYZbCAhuqkqC+WHtTPDS8bUat3exBupmpcPCqB9toUF3l9pTsuLIk5/KP11jy1iNrgDwIoTc2OtrbsPZVeKU5eWnmlHubBqtVo0OW3UpBFUyIBcJ+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DDf27H18lsYK9LlfAyvGJh/qJyhpE8NRMR8QMopGEqphbn8bcZldLXLbk7pz3IKqpdqrnDvA7lIjJCgIqYF/JRam/GdZJeAaQlbTlD9u6g2/zZ5PQqRtiBmYX0FDmSYCKIH0dVhuCiRjAsNgJsJiHwc04ToKR4xYjY1QavTMQAVVuI/GmmNwAvYLy533XhgJCf93OxTB8GnlG1ZnqZewnv9GbESU0HMgJUl8i/PX8DcD9un0hgIxCz104GSki0tKOac++UoSHvEYc+s5er3PbNCy4GjfUfF2N/clrU8p0hXoNA5kW08MLURqGLww3YUFbSEQZTWfDh4fslW/SzX14EL1rO2Qo+BamLbla11Ai+ZAAIONBdT4ufstrTMR2ZJ1GSXDmNCh12a+iyqQvaPF4zjhfEHfXjxubS/+OXAc5oHDZKU68BvNLBibdMGj09vstYO6mG54XyEPnrzxcSpjfZFdnagdhjR+GNvAf252VRzlsNeHMWKmQ7lYjsm5ZgU9UG3lV33rb/IXfwQOx6U67QrTQK580MVu09SZWM5F57S3kt8mTlZFlaEFKjus9J5vafFFkH6UQG3R1LrdC9SWTH/79sciGkJJH9QCXXbsCEJMp9m0nFaFjF4MaeIf6ruUMXNwdixsGan6L/Oi1L2msQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b149c4-833d-43a5-83b4-08d84d828eff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:50:41.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M60RFKV2Z7WbXQKm9mcyl5D2zLvkDKqQN745inq3NbUfwiuaYbeLIXlv16J5e75PV/clLRqHCprETfs+1zP9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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
index de6daa7..f18fee70 100644
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

