Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6E3C7B6E
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhGNCIX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:23 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:36238
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237356AbhGNCIW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6eMyITtqrZZ/mkCxiyxluxRcVauHHTdY9ZxohhbrvfhBcYi3FwOjrUSEpLmvm/8GVyHmBCZVmYXeS1mfXL4ckp59A4et3M2R26RK+k4Us4LxJMtvuJTESEiWuEgR6tOE6lSaqoHNvET46RVqmHV157Jq8OKJTPtUhKJXKofKJkVRWgqIQG1DhWsyItdow53MWqTpQjJfzPcBsP0any1SP6P2MkZsbuuB0OXZBzdvbGOXPaiReULX7YivvFBxVNHKbs6TBmAu/l6DJtmezfiSl8+w25knXiN2pwy9SlQUg0FjX/aTbimygBmUpNeBV/sIAGcQblqOvrPz7whuHsY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb+X7X4L/mtWzVycwsA3YmjE5CNp5DwSoUVSouktETg=;
 b=bsmeZN5ONzswG54pSdkDpOSXVhvTYF5wUvFUP6BFNnS+rV/TvpeaDyF/n63DZAk1P1fq8qfMwIDhFGgYme4znLPmIvYijfhH1f78SsB/E8pt3ly3Vl2fI6O3f8NAPH9b19Els0A8qjrQeLfBZnHBATDjn6QpDUHqVFsYsEqAWzCwIdhc8rRKXjINThepZL3tpXQ95pSAYJelUr1QayQPQNKa9p+Gd4AbGJcm/GhNSbRnR2weelXfI3+FKVniyvvcw6PTQqz4U3kNIiLsSkI7OuN8SXjrmqu/Hh7sNi2jKthmxCdcbnEDZ9qBIjyq0n4LyDHVjJ+3c5LeWYiij0ab5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb+X7X4L/mtWzVycwsA3YmjE5CNp5DwSoUVSouktETg=;
 b=eaANw/wAGNsgNAYJxRqJeRiJD4lonTmXQsCzKxtDnbXUt/kuspUeC/kV8ox9FMKRllLAmQPnzHjAVwJoJ55MDh0J4TRRyKEYsalxxtqjbAjC0NM2QuFNX4nTCPtC8NJT/Cmh1YSG/LFvGI2Mv4vzQck+SCrhAVcoF2Gaw6u0/q0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:28 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:28 +0000
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
Subject: [PATCH v16 09/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Wed, 14 Jul 2021 18:20:49 +0800
Message-Id: <1626258052-22198-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031e0ccf-8fa3-4283-a1f9-08d9466bd9fb
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB417587216F1264C9B77E634A89139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzasPzVL4g1InZcWNeAbWEbtq1JvQuXdr7Er4tTBeKNH70bCw1wkQW4Fs5sEbQYuiGsZ8jzJKWJ39oeBOUAglfUvBO4fGSP8VW2GktiaesqEW5/ZnSAU5J3P4PvOzZZxEN3JmNOUXRZI0q9l5Ian0KnGVrl8iHGGjZO22EdB6nTykquiohGElkSVSuOhV4v7x886lex6eS18LKNMd1vem7s+iQI5ca7/fbZ591eHl3QbiaG443zVL6FVLut0FHwqDDWRJfVvMaW689e593SWvZE8saiEnINeiuaJaNqHg9dw+0x0cdxlCX4IYP2TvPeQ8ogrC3gyv2w4nBujuosIiRvpk35Q5LApcr1De93wOM9ht2ZhQY6YOnbXcrz6cuo3fn8JejR/wagdNydT8kn12DF7zJoeVdx+c81AA7ORitKODwXyQmzHHHRrO/nxzc5CjqmIWg2qVrS7fWpPPEJPovTY7PRydD+feo/OhmPLIIZQGCOXLHPU1j5Xe8ecvhOpC5ZPHZ3wWh2GRcySpZJLl6+3vDDrgftUnqELWqV3xak/TMmuaB2D4gG3j0yDVvy8SVkM1AqmW5VXl2mGhPDuiPpeylFBPizS519hxjc3OCD5pgLc56ZlspqHPSOcgOti8zNIe8kf+3YrUdkddTiFEy3Wf8uUfonMT506CzSaTXSHxqK+VQxOEZX8wx7DRdP4E6rjLfAhMWPWAwY0uczTyQ05/Ucdwr7k+xKC4DVDU2BTyt1h7J0Fgimc+BL8oiJDXIcwKXJNAzJgLS4Rr/sS/xji9ioGWR1LS4VZqQW/baJmfAVADHm6gyb/GWKmeHBn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(966005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvnZlvVK5bIYz8XqHDFwt/IjGt/+azjIquuknQHs2Okpk6UsnZ+k/i/sLQ+W?=
 =?us-ascii?Q?AJiSzFdW7lNHKHlpfKvxLGFtSZ1o8+NtJb64knoLFpqjjgJk4jDFgikAd3/u?=
 =?us-ascii?Q?2uSafgGeUi3qhiSvgFsMiGm9WzZAXS4MbdY16zHJfD4TdM1WL0y9Zic8rFNH?=
 =?us-ascii?Q?+/zG58C+nJUrAsQHG+D1JD9IMQo4YPwGqGqkF5ykefSJKqCX5WKd4OjcKBs0?=
 =?us-ascii?Q?esMtCj4JuvdbbkG3V6YUBAgQyBPDcZkA7XFadbsN7P1v9V8iYwvUV4t8Mb8u?=
 =?us-ascii?Q?kfMwGqYEMEEyoLK6tIL1xnS38ZHmzhVieAK9B3ii9dhs05UYvJHkAWedG/4g?=
 =?us-ascii?Q?NCpbRdvk845CQdvD0BOBVO2Y9Hgvy4t9U0AyYjgbslHsAjtdNWXngGkV+VG+?=
 =?us-ascii?Q?npVYRV56njHKOcE4JHA0qzb1/q7hk1+gEGGth55OXgDLknbjaU5DoQkuuqel?=
 =?us-ascii?Q?/KGJkin3CGy5nAL+0rbarAgQeFvhVNchOVT4GyfKUjYN6PLNKxyhVOKhF8Od?=
 =?us-ascii?Q?WZ7+aTV3aIQXErZFYvb6wtBVdgdc6uwwy6pRuii30Gwk5OFF13pXxr+zgQIZ?=
 =?us-ascii?Q?ov2gKbdGVy4OQNIWi74/vmRDHRvJcI/KkxqCeb6aE1Hg5Xoa6eZ3hFk3qD3w?=
 =?us-ascii?Q?uj3z9NEV3APv6AN0ns/EL8i3Bstr5gnYuhQFiq9frYAizL6r8/C/C3kTqHTW?=
 =?us-ascii?Q?HVC4zxHA3T6HvSkOOC7qAzVYRymq98/f4fdikLULk/Tr0epfTn3MKQ4/3FWn?=
 =?us-ascii?Q?thn9iwP4SeyM8Fgd/us+0SdaUbcgNmpQ+/lVq6Aqvd42fVWY/gromRumyAqK?=
 =?us-ascii?Q?bVzhZ24RXRcliRn/Q4M4ViEKVsxL8ABSOCQ7OnaL3lQHDxNbdO0vBMqy+r9Z?=
 =?us-ascii?Q?FLp4BDeo2Sq8IbGNjTgEqbAfNns9lrZN73+pTg7h580jS4jR23HEYE+HEOXQ?=
 =?us-ascii?Q?gaauPltnbPV0eP2CR4Mg7Dp/QN7BHy3JsTf2MT0s1HZtCL3eUdMM1gFaIDjr?=
 =?us-ascii?Q?cn9ONWcNW3qJthfFdqQcX4z1xEDssEaiO+cxFfmkFIB9TBmXqHTxqtR3bjyU?=
 =?us-ascii?Q?+fJ/xtDR0Oac2DuXAP3ZaPv2HtVi81dxhHhjOdifVtPmmM2bwkmIPaG6kPG7?=
 =?us-ascii?Q?t6RIM/NOSkNF9ETHOixdddwoTP7FKzqvTupZ7IlUsrxbTJGcWdnk1ngNfz1u?=
 =?us-ascii?Q?HYI5mn5xDr8prclOqUs6vmVWleu48x2ilBeXAEB6Ci9+RRnszlVeF6w2BFzN?=
 =?us-ascii?Q?DapQjv2oxb/DuD695x/dSRi1EyDRsbmyRheKtuYxrzOjMBwkzqLL84vLMeUN?=
 =?us-ascii?Q?y7MANlqfd/XHkEblKs0cmd1A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031e0ccf-8fa3-4283-a1f9-08d9466bd9fb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:28.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlO2mHe3dlA6jzoJPf4+MDn9H0F71wuJHXuiEqvI3Ms4xdpIaDwvPt3Vdw99AIYYG601oiHdbflrd28vSOoZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5969df8..cfcd413 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -476,6 +476,13 @@ struct sdma_driver_data {
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
 	bool check_ratio;
+	/*
+	 * ecspi ERR009165 fixed should be done in sdma script
+	 * and it has been fixed in soc from i.mx6ul.
+	 * please get more information from the below link:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool ecspi_fixed;
 };
 
 struct sdma_engine {
@@ -596,6 +603,13 @@ static struct sdma_driver_data sdma_imx6q = {
 	.script_addrs = &sdma_script_imx6q,
 };
 
+static struct sdma_driver_data sdma_imx6ul = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6q,
+	.ecspi_fixed = true,
+};
+
 static struct sdma_script_start_addrs sdma_script_imx7d = {
 	.ap_2_ap_addr = 644,
 	.uart_2_mcu_addr = 819,
@@ -629,6 +643,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -948,8 +963,15 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		break;
 	case IMX_DMATYPE_CSPI:
 		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
-		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
-		sdmac->is_ram_script = true;
+
+		/* Use rom script mcu_2_app if ERR009165 fixed */
+		if (sdmac->sdma->drvdata->ecspi_fixed) {
+			emi_2_per = sdma->script_addrs->mcu_2_app_addr;
+		} else {
+			emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+			sdmac->is_ram_script = true;
+		}
+
 		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
-- 
2.7.4

