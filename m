Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD424174B
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHKHkE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:04 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:49159
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgHKHkD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUQJgkSkCinawk6+D6g1BEiavKbfjaYuoWxBUX4cn1WEo6ka+lEnaTxXnNZbVXpQT5W2DDKCP9d8TJyBpakDyMhER8m8PzHyo96u8m3e88WEQQhmZ8evEMs6Cfh+UnL0aJz5vpd9le/LmZLhzjPya7U9OrERmUqg7VU3CURvE4q/JD2XcA3v/zX4aZM7dd73qp1AxSjKSCcBj/Bf5NgH8hdw/Xw1NWl0ySIec8L6t7ErHkZWo1VXDCqyZwRJymf6XYhdCz3LVp2L+n1v+/JRQg6LAQJvNS4Of198vv88Cjb3Wz8w+HXUv+yaoY9D/W5zTqymWBDZE0tXdEcMQdu9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdptsqF/BWMVGMcs2QnzmQDQwBwZuTq/BYSygQZL8U=;
 b=h0viw+xVGxmQp6ORIadM5p0rDf4SS+Y1J1bSEd5K4wCxqKWJ9obxkYw5lfpXOn6jeQJ42T4c/UfAl3DH0gfNytKgsG0HIkOhbT/JWso5iFV2Ko0LT134XjosqRRKB7/1TiF2nkNougT9b/eClZRIxNTd/CjkQzZxWRkUqOk6Y3w8rZ2bKjhUjrnN8fKC/YRxlqOKmGA7T5HNIry1WGvPk1NMChQSgAmEwZXESjd6v8s5F3Qne4ETG4ma9XiBV8P5wLFlI4BQ6FBd8Q8+1P7pw8xzltx5FTY7gL7p0on1LOvo3hrsUOagZxQuXqZL8KTF+wSBBy8NGIbyGd+o/209Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfdptsqF/BWMVGMcs2QnzmQDQwBwZuTq/BYSygQZL8U=;
 b=dB4OeSBPpIRCnUmKilQFdu7K8irSBo5p35VvkEaYo05UqPtLh/w+e4Wj1fPWcIDJ8OMe4/pP+NHzx7EhNvz9Ou90SjXiJ3GDhMUfc9C0PSx21A6nuSJ3+prWuSxjuox9oc5z+Klu+i6jl2Wqhz5PRnBi7W15LxYWDKiN3YP1MdA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:39:57 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:39:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
Date:   Tue, 11 Aug 2020 23:53:41 +0800
Message-Id: <1597161231-32303-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:39:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c849331-6e68-4f94-3308-08d83dc9bebc
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB346403E87ED284EAA041278A89450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq8BF4piUfrjHy4F6/JL0iYVvlgIKTPrWW/LcMGRkaqznMGhxQyGPZI/WoFjdA+5LLPhDrxYFqwxthT9s1i0OvCl8J9o6/nTGFeEyXm+QMt2v0FIwDfbDxZ7ukOmu4dcRb5fUtW5VbgfhnL0rNT3ZnKO5SggAcYx9+ZZDrl28Mi2U98E5galOF0fpDUgSK0+HA6iC4gHE8amoJRd1D0tJkeW/XUKVPTkeHRC23+S3F8CHLZi3AmJGB6xc7qLkKTkQ0wZZ0rVgoYNUfkTsA9JcUoIZCWCpB53V2GCkzlZAyYP4Nq4c6Y/mjel1ny8SIeeGOti8n1H7pTBxAKmcfeBWSsULdHSH84unxOzt0WgtwOcxKimHZdqWFzeaaEP3gdgr1ItxuBpOBcyJsk9fiUO7LPpTh8lzR+QqSJVTAHPhcj6ozXY4Hx5Gapy0i57w95gWPu3hDu13N8va0yz2iETEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vi1DXK1h/6fimEf4DlolF+SDoNIyV127GaJ0Gsa6/zDQ2j3FKYnsMQBSn5fANYPj19ztmPNDITsirvYr7LFUFJxd7cgUCuFsPHuvbtbfvzXOeLOukimdOXSRa7+woLOtUqvuKmu88xooTlPtUxhwSHw4fP3XL2zqqD4gJIKBUAjtxjyv+Eg5fDfvdy1mdCKvNYlFBAIlhQ8MEH7s/YW/Ynjt1YvIMhb+qW6XCE364W/LUo+dv8txKu0aT4qmrcIYctlzVuA3oLg6Smaj4G9BTlwUK7pZp2Puaz81Ez1Eo2HyB6jQ0WsBUy7BGqAuXflQ7wzxHeKPu+FTP3lZh8Hrud6H3NfFH3Gs7IeOPf0CzeD4SigM3LCGGxuh4mSAB1TsLtM/DiovCPdnXsvDD+X/DJB8jbDMC+gwszGkymZqCEcfnQQ4tvccL8ZNSRNYQSMQWdIGaDlOHaF5v4Z50T79lH3UL3QTMgsX4p2lx4VhHGBBZH5TAjJb+J/bmV7bphzwNA9sw+kjDxjVPzUnexq93Py55/PgVYKlkjVDdhG//0fbwIpy0ANNLaxC1YBpEigrQ33hQ8gHMG7GgpU6+4E0B8CsY7FkBxuupvGf7Gzkhx3mnEHbTtx110kaNQh768efAhlj+Qk9/nqNHn+e0xnuAg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c849331-6e68-4f94-3308-08d83dc9bebc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:39:57.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2FpfwAz9gA44Z2MyKVL/qR1gasvGOGu9xzKOicjb9/t9Td1LlokjLDI9PCpX9Lpi0H/w6g4yuFjHEudLBzf9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

