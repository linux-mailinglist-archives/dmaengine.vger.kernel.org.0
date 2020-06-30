Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6220ED58
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgF3FYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:24:40 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:35649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbgF3FYi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpeyZu21t3YjJ9v7QHv6XWQDJToxxGeP8EA2SKW+LlljiuysfLiXVyaUbdkHvKF4AUyi94LvRvolgqLzJy5pvGqFI6QhL/6hu32/FD6w5lweAG8cjNd43FmOvqTQd5u4L/l5Mi9qMNL2FLfSielGMh2iPVsihOxlocws9fbP0pk0e5szc0j1w2Q3Nl/aBBQA/Uj+ps46YQUqoIIXGT6IMVsVsFJYD2fZty1eRnTsibQ1Y7N+eHULn7whNVGosH0tSdfvs+R9C2S0rQZo9ux6f40xJagmH7PIq2hO15uoVf09di10cCOQDJY47a9kMyYwCXoMws5VpCN5IVKzXXoA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=jfHDnQ0NHIZJgphQWpYXAf0nx7QUOaN2ydSyukLNfTe9VZFGFxCYzr+LV3YAbFJ2sICS9wdfgrANp6HAsvg2d6cCvVlXXph4dPV8Yp7HoikDHq9h+7vRn66ynSdAUUXXGal87m4EotkV93ZjLv3jhmrHFuQFj+ktKqbiSXMz1XRH/rA4sgWYXh4JjYer5eMPJ4aMfIjKxVUS2xe99RqwmfqYfbseFCaI9RJ71L7idvElwXSwxA559W+15MnhpRlEXHKA76n160xKnJHdtD1y7AFofDV82sAlxf3R4xhuZlyZ/A1iDmhc7ogVVj+XDBkOvaI8iazlZVxbmiQiW0lNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izcWiIsFhbVumJfO4SdrrpucrmDe3nP9In+ncyqnZw=;
 b=V4jFSlqxnhOAgaVE8u51+DbJYQOPo5m49s2TyXQkm7kttFWzKo3Rhv6OGrHzxkROsH2LujSGJFiPU5OnP+66xg+9/V4mDag4YONJSCMFFJXV8pgF39EtugAHCfFj8AaHTDzY+bxXlE9K6RA5YiGzrX+oZP7EnvwkvilsepWACsk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:24:32 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:24:32 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
Date:   Tue, 30 Jun 2020 21:31:05 +0800
Message-Id: <1593523876-22387-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f98a71fc-f7af-4818-702a-08d81cb5deac
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6640DB24E782217A9A7362EF896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuikhDMDFjR9J5Z8QHfDvQRkE8Q3sgDfmLINSAvcyFyzrksWRZehexrBxd88papUntoDUUcRKUvBgrhKOEwu3hFONGoxi2u2ALcy0nSvTMyXwqj7dPd+7d1OGBlpQlTZfH3l8VWz9/FRSEr8pbpqmapeT3YMOVYFvouC0LdTflGKIEWptvDjug3VVIiELZA++hxeIGZLle8xK44qUkS2dtXvJwE3bivi7NANbrpeLdKQyUeDNjt/8MmrNZNlD12psKXqqS6jUVJqz/a/bFAOoA6jZDGKGs1qC7lVe1sfKH3A7UcPwcs9ZqONpKY2a58IQpdKswncrHGXhpHRGuXCW9kSN2U+4OEnmJuGP1odw9RQuUwgozQIw2wxRbkKYsTS/xhXwC6I1Kvl0olInBDVDp66bltILSCGGCGe0BN8cOeOUhXk3ZDz81Qpkib/yWDV1+D6ONRMzn7mdhblTu9bT9KEBNIxu6kjsEkaiG0fClw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5luLhOCNC3d1HKoGBGVrHETJlFU4Ol8M22oKeU4qDFrP4pBkRzvbALFUNlk63NdOndXdXxKcZIGwI6PZKhknuiOAbQLyijSV5QOZMIGUAf3URjVsv+RgJX0LtqXbHyaIwVV1OswUV9GHM6fTw/ByMc3UDnUNTYJpgqe2YA+iSc8vmM2RGx1V7+yE1bOJbRSG4ncPYWgxVVcZ9raxwe60AfEVDiHEoCL12yNTqQHad7ygs8jA2SEOhl6myj1y0MjCRJ26V92H6p8oCqKZ/gZQWQIwkszE/mpv6sKFHB+SFB+aa0eOHUeayi+d7iMuhKwH+2d+u1eXTftAWIHfKK6YARz1llqLQh+djKJOMSBvuq3kt+UG1/iM/ymRLgoMveL/mbut6K6dL4oRxORD0TXqZXlr5D2+mh5HU0eBnvN8sjWKzbaFPY6CG8xN3G2pSNBvjzk30sSnwcdVFgVld7JdyQe3YFTt9NmWls97op+XoY8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98a71fc-f7af-4818-702a-08d81cb5deac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:24:32.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu9RHoGorCdkQTlnqM2zwzl8uAha484clxXFYFfXShvM6DcmKwPYIRICf97ePO0hGROtDiKY2p/7/TxbbcPYdg==
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
So revert commit 'df07101e1c4a' firstly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 78a4d64..afdd9eb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -177,7 +177,7 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
+					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.4

