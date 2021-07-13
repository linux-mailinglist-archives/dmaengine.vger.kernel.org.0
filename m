Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27E83C6E8A
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhGMK3T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:29:19 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:49633
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235760AbhGMK3S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzX9rj28NwKkRcLcRplILpYJ+I7MDisVyNeynYlkIAdXhQZIPBg3jg0F+LZsARpyphAu2y1fCjeBrEZaDX85MM25T7+2+9SyHAGpL7V6a8Pcw0ZMXh5QtpvWcVa8d0mrEbAcQjkM5//ZOnz76S6+czzXN0FT+Kn0A0gHeimGdeqwUjgu0I2mPwk66iYtPQN8JOXmS5DEIYWEiC3CkT8/V8PYQ5J9gHpVinEj0sglAO2ROVW8Lhy2YhNPMGqTNujVrPA9tswEZnlIbXMN/+I+2Ayl1EcWx8VbdhqokIJYjkQ50IRJNqDq+2EAazMtQjNZ0RaUdaUI0+KHxA0Ps2g/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEjpmt29fN/46Q58M7W7iDkd/eTz7X5EFhbFaAXZtHQ=;
 b=jsGYTZ9qzlSLQW6LunTnPAQSerIzK4POavYZp5Ca78CRHcKu1EvwHCdVmrOTXasBt0lXtnhleWW7j8pWJEYfR/CWARf+ZZNKL+VBHdeLidqkNEaJSGW/E3mMAx42SrYwNFpF1WbDS/JpE4Si7fu17oSTaTR1nhjSJgecrM/dmhus61ItASDSgslkvI6Ieb8sW/T/RbEGamKj2vwUL8xCbXYOVBxi8hKskvj4N8g0HgFPqiTpN91aJWSfeQgAqs5VJ6h7Xd4i5hBAn4GkLA/v/TMf4yuYzdsRZLqVNeGlbC+3FTC7yMpaX0pSYGHvHcq+lM/QFGuz5RbLdKuxRTwCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEjpmt29fN/46Q58M7W7iDkd/eTz7X5EFhbFaAXZtHQ=;
 b=KJZfv6USIis3YVoajlS3KIRcuHWbeXmj8mfcMjU//DQ9SPNMI+UM3rSTNegcxeYZ9dwJ6TQ++64F/a0sARZbVnEIasljCWBvUIs8eAVX/q4/5Xc+7fyzophEO8ZQZ0agUT+MK7ERrTxYWc0m1miy9o8sLAnXgy0kcL5L+fuVCqw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB6798.eurprd04.prod.outlook.com (2603:10a6:803:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 10:26:25 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:25 +0000
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
Subject: [PATCH v15 09/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Wed, 14 Jul 2021 02:41:46 +0800
Message-Id: <1626201709-19643-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:26:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca04f06-8e56-459d-dd94-08d945e8aa9b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6798E96323138FCE76328B7589149@VI1PR04MB6798.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/TVlzEIYPtAiG2SfBjwawIWflj0CjsoU40EN4yZruwn9clwPpAtIQ2t13YqHtjPMtxT/G1Qm4fzoYzQekGvl2DjO9EI3dPJq2+c0WCFwuluiUEaN1r06bq8IdbGNDzfpreysEdNgk1RxREkHX8FEEpEL6xGPML7DIIbGPSS3SlBoTLmgtpGPQak637ANHpmK7CkExR70KRS7KnwZdkmzSo6rO1CLLY+xP8b7tsICNI62yg5cm69l9eaiFPTHe9YgHfjlsxbyn6eFJXbOTK0lPr1fqLN3TD2sNmEYd18Cla65Fc7E5jqfehGyGJPYGMCtkOywtTUE2avAOxzb6aLQ3BngJL7d69Xsq+UI1MtwU5I1gFFKPc+et+t491te6VZNIyzPxuHu8jhmBwNChhTRWIOld8rU0ui0BMXTgQHHlzHmoUdv6Y0oeA2pigtdC7fjXcInlAxMYxGAeVP8sFx3EOJA7nSlXQ5gd93yGgfnZoNAhT+q9TzKU0YgWGZv7W2bJkLWgdp+n6bWiBo9QNk+dWicphHmRmnECjIlZ5xrIVlV2gxrtUwyRANMQgRBfpvBWwozoey+EYvkXQXDb8dfEBJTMATVf/6Z2cZlKONHOHUO/lglpVP/vx110EVCOeE4ZXg7jnD4GWY/U9Hfjeg+Ma1w0WleRyRMUr3+ilVW77Nw91Hy7Ax4oSZYiPjlrbvDKsYs6Xu/dfr1rC/US0I9r8CajIqCWgI9Rsg1ocyq69xdtY3+NYRRegxDWV17INzcfzO8mypr9EhgrhPOECXEGwHL1N8ufVLGHPcK/WOsDwnprz20HJWRVje2af3JO7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39840400004)(396003)(376002)(921005)(316002)(7416002)(8676002)(52116002)(86362001)(6512007)(38350700002)(38100700002)(4326008)(6666004)(36756003)(66556008)(83380400001)(66476007)(66946007)(6636002)(6506007)(26005)(6486002)(2906002)(2616005)(956004)(5660300002)(8936002)(966005)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajVanS6MQKcrJmznbA/WVd8q9ZNH/ON98VhiaUE1bobtMBkol58bnePgnxeQ?=
 =?us-ascii?Q?8xXI+MRWE7CiUu0aACdBx+c3o5b/OYZ6PxK3pE9n24F7Hbw4aJCL/zP3UPO2?=
 =?us-ascii?Q?ZH4Vx5dHvN5fhYTo9Xmf/b2MNd8O308ytTlPGEvVZA9quPJ/2FSm21i4a/Xd?=
 =?us-ascii?Q?bm3mjJ8rsn1eLgAk0miImC2c6LyYbsd3b1fIXyibm5sSARHKkvGwR34dingx?=
 =?us-ascii?Q?Bvpyc++gUhCfJdlbpaUTdmZLyzvJeW59yGHM1zUSC2jekIhCnegAyUjzRagW?=
 =?us-ascii?Q?jM8/E7I+IXKgr1eQiJeNDIwESvcl7zcdK+CECTROibprp5AvXuP6/x+uUEsT?=
 =?us-ascii?Q?m6QikXiOZ6VPVMMutrQFF/51E6SybkSBQh5iODMxrqetdyx0zYMkSw9izL/m?=
 =?us-ascii?Q?Z/oDUbeG8E3byCRserO3vyQ9/PP+FaRK+F4a1BbVTi1nLuomrr/MbxbF30bj?=
 =?us-ascii?Q?UbZsuhToUg1cHZKTFXnEV3KONdetV3a6P41m/aZDNUaMgJOw92ac1HMUx28W?=
 =?us-ascii?Q?e+r3jZGACM3jNwfahdQza8n9K2UGFX16fawyXLeXx6d6rmN50daaiLhaLg6f?=
 =?us-ascii?Q?qOlott/3cwwwTgfNa33Fj028192z5uHw0pfC9JyIg8sfrlcsdnU0EpU5tB5C?=
 =?us-ascii?Q?v/BXcw1s+/IIFQGtyUsze0ZU/lwAy9CvjOsvVQ5+x2M1OnmFIuNkXvKxirpI?=
 =?us-ascii?Q?OMGIj5ywBXPA+yS8WugxHvxKZL9OACgxiBD/elxO1d4oHHXPSPBKfhpSj0r/?=
 =?us-ascii?Q?2NFpxyvle3y2yiMklPBK7QcjNx33kWgxA3JIjAs+qiYTEnhPSzBDGeTj8c5Z?=
 =?us-ascii?Q?sXAZfYdI1UsJarM+1rG78FKYoK6U8s0XzHTx3HBQysGO92DPJ9GSU8MD4EkA?=
 =?us-ascii?Q?v83380Ujh0GR4yXckVolk+w9kU0koZ9DDsJMymP2vxnA844lRIKOInkJ3Mmg?=
 =?us-ascii?Q?vQfj4UESLdr5toCXm+EbfZT2C6SenM8reuwLyiced2xRebtw2Jp8KzmeQvzy?=
 =?us-ascii?Q?jlgulcA87YZh88gfX45L6EeSDWncrHaFQ+ZbIWCph2l6GSjXo9DvXSXSEUJs?=
 =?us-ascii?Q?iXLxiLV4lvbOWo9GWF2x2B82d1Fl+J6J4WjfiYiJ+cfp0Xya3g4Fzcph/UqS?=
 =?us-ascii?Q?RfHsm94RyvV3d5EHrLTuXZNE0P51kiCVg6glSffJvPf/BWStL9zO8Oj3OiU6?=
 =?us-ascii?Q?L2j+CYFog/8aBkyxMZ7TTAVnzO43CHICbOXhiGE700xR+8j1Ata+1VDOGFba?=
 =?us-ascii?Q?cn2v9fcHNgKuwGuUwAp9z/Gi2U//b7ktipQoFceQ2Zem/l9CBPE3u8wd+I1G?=
 =?us-ascii?Q?t2e/TU8unhGJJhduybHViP9+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca04f06-8e56-459d-dd94-08d945e8aa9b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:24.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KewOoG876+UMPd03W+3MStiu+QfFVTxsLe4DfipDnUFafcg6Mcev82+e1+Aj0/YaegSJX5dtSuhgbCDEIEripw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6798
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4cb2e84..211299f 100644
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
@@ -947,8 +962,16 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		break;
 	case IMX_DMATYPE_CSPI:
 		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
-		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
-		sdmac->is_ram_script = true;
+
+		/* Use rom script mcu_2_app if ERR009165 fixed */
+		if (sdmac->sdma->drvdata->ecspi_fixed) {
+			emi_2_per = sdma->script_addrs->mcu_2_app_addr;
+			sdmac->is_ram_script = false;
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

