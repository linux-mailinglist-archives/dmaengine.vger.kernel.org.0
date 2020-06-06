Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC771F0773
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgFFPWN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:22:13 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:14305
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbgFFPWH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDrXSNOYbKaaSgjSJjYrmefXMa64wbXVzGncIEIqZZBKsvjqOPsQcu4Gge+DDmvwQ44adUMDydlW54jaWoovKOJsr1AT787U5KB+RuFR7FBnpsPt9OJk5vwPLa7eW/ExmKbx5MwWzIW0aZEs//bqjepsAwDWIaGxzRYJUNVQEyTEBm2sldwVNbWqxP5guIAYyeo2RFMXPjils1K2P2tqjJWYGnhrLTKgUQDkkY155rvV3IqXvMMR0IIGE/n5h+wWLQvDSgP8hKYCxZEMO2lXO9BWGrsxz4vgjkgYUUB9ElXRLGGyDMMeBN9F09/VJYwZoW6OJ8I+zu07gnVmIylswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3U69uN0DL45TP1sCU2rBpvu0XorFo1Mf6dwI30ew/0=;
 b=epeRzBt4eFxeJ7ggGQGTvR+9NLz5zzQZnzStoLZlhFMDCnaG+/T2I4V9DkYEPxdIweXixfpCzVtRUz2Wo5C/tzr2gKODpsgh84h2OtNKVexQKYPVNXaWUPG1lpOFqIsW8SCqDwUyhie6ht+NFEO0uuSZ8qyBQgOvhgw3m/U+ys5cVFnzWjMrekBW7k+gGbtCbjj58rj69nvLPPGQYVj0cN9YCAnfnxM2oN9wcFuIcPO9s4kKj8nOHGtvejy+Vw0aLWYg7ee4ClKg6+6c04kCAQHT5ChApq+/AYO13FIbsvx19ofvADSOIDrv3PCeWrLJVihMGWW+lIwErdMLAQ7aAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3U69uN0DL45TP1sCU2rBpvu0XorFo1Mf6dwI30ew/0=;
 b=dBJbSvktWXO/ITTCnJdxyAjOa5FM8BVU5kcnpLVV7YmkaD5iAEqRJ9nptwoBsX9CaQMCzHvLhkMAeFm3SdbfCdU3XrQadg7pb+QGX+MozFV5jLlafTxt4m8sE/9hJqkAeLrsZnOLzVeYq0CY97hpe28ycIU28OzzFyKxdYy/Rho=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 15:22:02 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:22:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 10/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Sun,  7 Jun 2020 07:21:14 +0800
Message-Id: <1591485677-20533-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25c7d411-7cf0-4000-e367-08d80a2d5d32
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6429DF7730FEFE28E606254D89870@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YahhH+4rntuBx1x78aCh1GqljcFagQB6xK4JJlgIXGctHW537z5fMdJkxlPzBiMfYErlZxcGO0uRoTRLAxdkcwr7OsP6gKEgTZutOhn52AY/SO9SaBG3M4LtIgHpisBgihNeXk4b0bERInVruRkJ/HIOy7iyk9bqukdCqG/QBi25JwN2UNGYC+16n1D+SGa1NCt+7M/Mtpp5r0EfLdQcycVr1+frjvLrK12VxSiLHHU6Zozg0QoxlvqS9W1e1aOu1FnlbmOlbRBoE8nDUdNYtztQbMPm7i7S+119fFteoN6dQzXRVlcnGkabgOPDx1fqzcYvvaF81LTqY/1g4RzJbPJwuu9tizi4eyO04yMBFidWAiWCp2RAIqBt8tdsUSDEdU8BxKk1LyB/49aY4WKdcOkZvATKJ6oBtSy8to+qA08+kmvCG4ukRKWtKZe/ku3oF3ywvDrSMrs3MOY58vJRLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66946007)(52116002)(6512007)(66476007)(66556008)(6506007)(186003)(7416002)(16526019)(26005)(83380400001)(2906002)(86362001)(8936002)(956004)(8676002)(2616005)(6486002)(6666004)(316002)(4326008)(36756003)(478600001)(5660300002)(966005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dGmDuj+Fw0YMwdwhmBtA50bV1hSgxCBI9z6D8l0mLlR40KIxy13c7JB79/oQhAn56gcvYQq3CVj5Sz1okIp5vit1p5bleTzVBc0ZqbacgrJD6A8hPhcvulkQov8PDC3r83KdAFOr6fUSGIXrAzy5G2IdXGkncFULT3YS8nl41acwaM60MBCwWTq4ElGVd79SpSfVOcPGzDbUDCQZUPTvmSb2m4vsjEMXtgXV3C/VXgtlvDGd6a5iKXwbzxtUnTRTDO3/R6WOV1pPOcMYigzOtKfZsIRP7HTeobTgji7n6SJFahBhcbgqlJk1NsMGkyo28r5pajoASy6CIqEwRC4dpp+nKnhwbjw45RHxTgcjy6odoQHadPPKFItPQdKfhkMExRp3qk7yGsciq+OxQcmUbK9cm3AtHwywQH46zWrd9kGb746zhAKhoVoZZL1pBY3mHY2xuIn3sq6/fa9Y7xL2h9yr2Xdox3Bgzgl7xOZ4rJE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7d411-7cf0-4000-e367-08d80a2d5d32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:22:02.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqmPSMNOnFk5vKrGcy5er4A6gGB/FyheEGkKJ0Nx14+bq4QObX2ick6suGVYrY6SjtpTOv+LuS7h2pnnL8U3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index db4132f..be86ae8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -419,6 +419,13 @@ struct sdma_driver_data {
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
@@ -539,6 +546,13 @@ static struct sdma_driver_data sdma_imx6q = {
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
@@ -587,6 +601,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx6ul-sdma",
+		.driver_data = (unsigned long)&sdma_imx6ul,
+	}, {
 		.name = "imx8mq-sdma",
 		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
@@ -603,6 +620,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1169,8 +1187,17 @@ static int sdma_config_channel(struct dma_chan *chan)
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
-		} else
+		} else {
+			/*
+			 * ERR009165 fixed from i.mx6ul, no errata need,
+			 * set bit31 to let sdma script skip the errata.
+			 */
+			if (sdmac->peripheral_type == IMX_DMATYPE_CSPI &&
+			    sdmac->direction == DMA_MEM_TO_DEV &&
+			    sdmac->sdma->drvdata->ecspi_fixed)
+				__set_bit(31, &sdmac->watermark_level);
 			__set_bit(sdmac->event_id0, sdmac->event_mask);
+		}
 
 		/* Address */
 		sdmac->shp_addr = sdmac->per_address;
-- 
2.7.4

