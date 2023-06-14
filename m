Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79180730863
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjFNTg3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbjFNTgU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA50D2;
        Wed, 14 Jun 2023 12:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCwJXxAmtEFRTjulR4ALX60BXbPn5zkobwtoB7SBuD0xGISOP1UoD8v7Yd+0zEvyA7Z4KQJR4XOzffe7so4wFm3fWzicur/LiZ6Ao5xCuYMtDs9UDVspZ5A2jONd1qI22sg2mmxMj1yS0qVAbkEx6rWNS2ArPcX1rneAWmWEhTKJ55xBLKqPYHPttAtcxBomdFeVDJpwLHUuqBw6UAx2578lErxyQzDxar1cpMnqIKcLIOz+4MAr/Mfukl7xypVVUdoVxuhcsl5QCdxRF1m/ku0wy1HhotVWi/iG8RhJxPFiRfoqgG9tmkib3SuyYmGgHuv3TaHCbuHVsVScHEvE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=D3IqcsiCZSgMcSKip2MS9g4ytk4pTQ0lt6bAGCjpUKyzq0qgVT4NubKCGyrYfrQSe8a97J480z4VoZlFFifuEVE58Gx8HkLN2Lh2IlvWqcqTt/cIUeymLkXyUoaV6n1FhRAUjPRbFkj2obC5r/IbTn5xbxAsi2I5f9hySuXWRDQyNcz3LnmDNSQ6RqzCK84splE6jmTMMJQPZm4KFRSmMUWu7U4KmjowMDHE32I0ew30I/nkDim8vSB2mQWECNBeaCQVnqntamtLRGhCRuu2Ku8VzFFPunPlYkb6+wPLT/RiSBtkcqJZhTtefHrGWQT/zS7qlYhK90gBcM1zgex4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=pGDkFqSghpXxBrhAnSrGnoVND1zuNUrgUlfvgr7WW7BVAeivADUH6HOaYz51uEy0fSTKzwBuNuSzfk4PuWbhBarLxgRbd4eDSz1cWWETVmfgtNzIdIuOlrQiYLhBSjPCUYU3PhJpv8wJmf+E3dJqWPK398y7rHVL0Mgr869LYg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Wed, 14 Jun 2023 15:35:38 -0400
Message-Id: <20230614193544.2114603-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6aa5e5-1e8a-432b-6ade-08db6d0e9ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWIaiRItB4t1Rs2YaeFZdo8YVisMsEFLN9Iq5N32cvIjZfpAQJtwvhc+WLEYH4MQq07c6dQh53S/hlvHXdoPMgZb/9DtILwJzQjpeBAWSb7rcvM2LV9ztT/LR82YJ0WsAdLsLKkKkKhz3hOvRwXd6lF7KqPuSbom2V2duOP53okXXrdwj6HUk1sFViX6UNmNqb0EjwHY5TtScnurygpIcwKJMSihvY/unl3wsjEC1Qq0q2CyPvZTRpDuqxItSIicmdUP7ypccPG61PgfswXRHd0vPr/43fKDDq2xWtp8dyYDhwGfWFCAUM/qiFo8veX6ftyG3P623ZTPOWg/kbVzuJQ0qGGV8K0cfFJr3+jCKWEbAZChbebQ2OdB8uCF9OXLPnHssxz8ERTcr9DX5JXvyOmv7J+g5sMaYzRAcQsa9FZczjYGmonv1zpHm3VjtZKgOIR9Fd7ZL3xWBuA8QtqdIqGwnCkK6FH0Yrzm+H8ZGLfR2hv0XJjxVInJYfJw6ageBOCCJJj4dfqFv3U+x9TIjkpZj8oLrb+0NyZsVCmxXBBu5Eyle607DvldrtpUZb2cSCQow8pN3Aw1cMMDe/KT0QBQWuVtA4xZzRCQAw9e2JYiA2QavoZ7O8RWXb6cI+9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZFbT+gIuj70NwhTQ16xPD+StqXImKcwMpvzEIcvvUcp/Z9PPpPY67x3oIWZA?=
 =?us-ascii?Q?OxOdM7v4Nkf0MOtYjGE71CL9nJzXlgs4lbQdRoJ33iA51VFsg64ugrpjfstM?=
 =?us-ascii?Q?xFB08G0jeLRscm0SggL/cz/qQhGA4ywea/0uBwH3bJeXjC8ADNYcV5ZZP57I?=
 =?us-ascii?Q?HjqNBmWhhaj2O0PpIbMeffrHYYMVF8sZfZ/DDcW3l7Tk/Rk77i2UM1Udz+Um?=
 =?us-ascii?Q?Dfumj3UQEOQFLyF9CMg/Zc+m66O78VKbe3OTVX/y9+c4T2oFxXKGOTbEndf2?=
 =?us-ascii?Q?pegX0LIyncYJtpS4w+96nZUtEyTk/jTiB0vDGfJLYRSpfjgRx2bIgODCTi4I?=
 =?us-ascii?Q?NYZl6/QWzFXX+MEztupX6c07ec+SWhixXQUgOYH+n+UdnrqUbfduOh3QDXlh?=
 =?us-ascii?Q?JT66IEIUbPhjIp4/WY/zSg4tCA/F9g6/qqR8Kymh7sYTkN2RlvUwjtHaKxzx?=
 =?us-ascii?Q?RO9Q5N5g9q/VR811j5cRdYkbsSQS1FCWB18XMyERbvey2qcly7EDKVbjaOOM?=
 =?us-ascii?Q?iT/5WaofgntdM7CVs0XCwWHFf1ZNZhN4sEHqBr8JtkZACNqXRGriNy7A5RQg?=
 =?us-ascii?Q?rI/XS1Av7QBthsjRemHoFEBWz7GHchz7Tp8Bpx2rNzgD6Ep02uOTNAnSAjaq?=
 =?us-ascii?Q?+a4MUHiTyWjyZ/nL45R/geBVhm6pDsznKR/wrxwnLLR5bLeAPNHlrUeVWCQC?=
 =?us-ascii?Q?FedBOi16fML0FQ/Lm4MDyNzToaVGSDfAsg9eHB3GEDUe2G40CzKcsPmIkP5w?=
 =?us-ascii?Q?Qg9nsTuHVTg6OUtIWUZQJ4If2EKAG+N4avWjhm9eEgjeEEH0AAJ0r1UTcEil?=
 =?us-ascii?Q?kV8aHJvjT20C5VBgylo4KHGtQmOquYmPe7JnAY6n3r1LqAvYcBcGG1MC7tYc?=
 =?us-ascii?Q?zR67EoYFjXRDduaN0w9ey2msBudNIgMHe+rbW2SPvarf6q+K9fCzESimd1B9?=
 =?us-ascii?Q?eH5CqEGKQ7cVMQAp8B809rWDoOtd72ahopWqVZpUFLCKExIZpgkwODMysPHL?=
 =?us-ascii?Q?oloTz86f+QPD0GOhoga6iOOV7cLTYQsFuz9zqXflF9kxe0d+xRnfpexIZ+BZ?=
 =?us-ascii?Q?qRX1vc/UHicN+kHvnz417vof1qZPgV+awvgm3rAvJg9CmKITT+b7SgJ8cmYf?=
 =?us-ascii?Q?L23q07jrjTnW/u5rOisoOmx1amM5myS8v7TyE9QHdnXMsO95ZUa7AYQUD9U4?=
 =?us-ascii?Q?kC7alKD+BujFmuJE2osl64lZt4rqkJtC4bt5PLdlJwnLH2vfVLppON2N52j4?=
 =?us-ascii?Q?QX/8g/WQE0GqpPDeG93T5DDERyyOqOHu45Mu38hFI8IUVTmjARy2YHnYD/r+?=
 =?us-ascii?Q?oLxAh4e9TW5IsbD7KEcPHbwT0na96qy0C8Fnx5WobseDyPlzfwOMQOxbTaFw?=
 =?us-ascii?Q?5Xv9Ou2dZ2KqBlFg1pTPa5OPFEaf1ASomRNaQVHSJnLEdJ76pkvNKI9yFZDr?=
 =?us-ascii?Q?iIfPHjAiVXWBvKGjWhO8BkSclraSZ3uhNbHJgpAowzeUwJ0LWNZpdFSyvCtF?=
 =?us-ascii?Q?LbgwyZzN3ky1744UaP4QbDYP98NctMPPWfva2KgnHC9UAIjD/LX7R9gYJj9U?=
 =?us-ascii?Q?4GmvePoBntJzx1cM7F7G3Br6YXBVIwTxnKP9ZvLe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6aa5e5-1e8a-432b-6ade-08db6d0e9ef3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:16.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCKhme10JDSz1MRZuCp2o9VehBwbet4KZ2YtCBdRefZKNNyJG+1RTJ1UTLTTDkVmjacexk4ojcGPz0XsnZY31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Removes all ATTR_DSIZE_*BIT(BYTE) and ATTR_SSIZE_*BIT(BYTE) definitions
in edma. Uses ffs() instead, as it gives identical results. This simplifies
the code and avoids adding more similar definitions in future V3 version.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 21 ++++++++-------------
 drivers/dma/fsl-edma-common.h | 10 ----------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a9d17cf142fc..51fbd7531c74 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -154,18 +154,13 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
-	switch (addr_width) {
-	case 1:
-		return EDMA_TCD_ATTR_SSIZE_8BIT | EDMA_TCD_ATTR_DSIZE_8BIT;
-	case 2:
-		return EDMA_TCD_ATTR_SSIZE_16BIT | EDMA_TCD_ATTR_DSIZE_16BIT;
-	case 4:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	case 8:
-		return EDMA_TCD_ATTR_SSIZE_64BIT | EDMA_TCD_ATTR_DSIZE_64BIT;
-	default:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	}
+	u32 val;
+
+	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	val = ffs(addr_width) - 1;
+	return val | (val << 8);
 }
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
@@ -623,7 +618,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 242ab7df8993..521b79fc3828 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -29,16 +29,6 @@
 #define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
-#define EDMA_TCD_ATTR_DSIZE_8BIT	0
-#define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
-#define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
-#define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
-#define EDMA_TCD_ATTR_SSIZE_8BIT	0
-#define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_64BIT	(EDMA_TCD_ATTR_DSIZE_64BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BYTE	(EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
 
 #define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
 #define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
-- 
2.34.1

