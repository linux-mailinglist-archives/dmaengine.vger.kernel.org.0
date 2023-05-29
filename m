Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CE715048
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE2UGr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjE2UGp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:06:45 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3DDF9;
        Mon, 29 May 2023 13:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhomHdxFmKRFAoWeF2Q3/f6fxe7kEvfhEi3KIDXIrfbv6aIpyQeL0NgX5SCv1dqLY6PAxxtB4Ujh7sN7vRc6LyXa0WGzCFWtDeorhR7klXUp0cyzlrwJhwqQKjp6M0pNiFufwkuhxGT2sV9Z7SRZwSXEjcvBOTejSDfeOnO+bPosbD95jQ2IAoVhsjqSxmwUuhsuAUUQwAkPHH/IX4Z29iG0Qa2zukHgdb/ADVIQAogS8GwCq2AFyRKiXZaxJ4EBeTqq2VjiYi1fkE/IkeJ74sGc/cqVgIF0cvEJYZNjury5bxNgmw1p6IKxuNZEtidXwAxcxWIicdhu2q7KRyBjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYC6iFkeYIBf1sHD4vzUmRzUWEV8BcYvdT86nMRXy30=;
 b=C1Ma3kxY888SCnswEpBstWuRF3w30SIgop9vFvSNjfiMugI/y3BkDAjLv79nQ/Dqqa36PmdvvQsKtUVO0411R7hdpR7lpWfXJq3d5QWQr3gTuUP2jru8jjxuiwz5DgMd21N2UpBrrxn6IKSa6uEMDT/lc8GwJx/2G9QvM5Klx8HNJkhX7YwjI0DVqBZOtlXIjTISFQsWD2OHqs7flYSD1hGuxYG4w2jrn8hRb+r7EdA83kdc2+7yVj+DMO4q5KbkZfyqtfMdF1ZtXh0pL8E8TK4fXFYVQLYrNZ+QSeg8cSjRW3WfTnt5eV7xooXyhpw2f/abSeLxXykj1VyXo6LbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYC6iFkeYIBf1sHD4vzUmRzUWEV8BcYvdT86nMRXy30=;
 b=oV/eSRF+P4tn6YnVUhKaZ9uExt+GfNASP9IX0BLuJFHLGJsdnA0Pwrs+qBc89VUx5EUFsf2FS9YWXbCeiMqYLNjsXLs87eH+SyOlRl4WZNcOk+gQ4SpmsSIoid3twSRJAR/M6uY42kiUBj5ZHaPiSMNsXULwGbfcz0gY7Cgt0g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:30 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Mon, 29 May 2023 16:04:47 -0400
Message-Id: <20230529200453.1423796-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d09193a-8fd0-48b9-c565-08db60800d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pr/HA9TuCBDXxknmXvwNz3fd5ncy/DHTWRQ3q8Joek1QTO3E02viPpgiaSgrNb5B3jlG3fmjuaU9HH9cQf0hGDmdIudlqwUTEmOcjOeo6x9Yig/b/Zz9qVr2iqpN/P/Jj0ThMbWtyEs/DHMDui4Di8ldVLUyf9v5q4mPs0q5W7L2CN8CiiTr93GVngIuctbnwVum8KhpgoraInU/Et07dg8IkdTfqTZauqt3y0qkxxJAE71L63X2CCjzn+iA5NsTIcBxiDtLrwku91mY7MxJjGByQv4NlB+EyrluvgE23RpYsdCH9egV43aHXruzWQEY2ebdmHUWfQovhql3404ShbAlwlP0cq8ewgMlv4mK5B9wbtVjFbFrJg8fqSGlGu/pgUDlhohJh4HU/nEF+esjUMkAWXIQNf7MQ8o8yIf5tLga3MDkbKsl2h3WHjVqm6mxKMvSIATsPD7ezYL8KVmyY9eR0W+Nx03i0RdAyj9Z2wco/qItXnyEjSWBDIYkiq6xqZI5fv6uT5H+6EaFXNy8D9sNr2DjflHrHB7/xV8R5+PdMctrj2eWIiB3SLHwNdS3jC+qixrYy3lDMoc27Op64btWLfrPLTM4VseACnM7Z2Wq90yMmiE/N+FWn6+8LBQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQlGzrPhQlD8q0OHS5t9+AyaUcHODS5P6RGv/7ijcmq+YNgQ7eTssX2PmsXG?=
 =?us-ascii?Q?XO3HgqjXLnpxNfVq9+cAddswhL6smT1oAyqvLnO/z3KAZ3ctQTiDI9tiMtc1?=
 =?us-ascii?Q?ck+fnN6FxaV4JqyRH3Bm0vDRoSTdL0kXOb94kM5RXNM7t1hx9puszGDFOdYI?=
 =?us-ascii?Q?/cSmp+AX8H3iCLtYaX/aa4v/iBQfNiIyc7631wfKd+KEr5kAALmkKuYCYGQS?=
 =?us-ascii?Q?c8XasRlkmI+26g19hyVOoKQVD+YOVTXy+0QyNGm8EJiKDJDIuxzR0Xpv6euH?=
 =?us-ascii?Q?0xpdxsvSmOSnoRgkF9++pMu55gwuI6Xs3AiaUU0lA4tdkW8uWns0fciwkSac?=
 =?us-ascii?Q?uZ9PVZpAqJcQ6KXUy+X2lfpCIQlJLd12CBSZCvOhWMEKasnGmR4Rz4+zbf2Z?=
 =?us-ascii?Q?BLF4AsMSfKn6h0V5Zd7AaSNaXcJ6+V5vWrJSTJJQDLAIZdsxf1m2qUkYfUpD?=
 =?us-ascii?Q?NLihNEazZkmceJu37tQiTvJVnXyp8I19dKzinbgdOLD9Fq8BlYGlfLgPJ2R6?=
 =?us-ascii?Q?yKfrRxg05gAQoqG1DlvJ5DIw8PuIrBmFVp0/eMHZBuqlF/QMSNCvE040Z5kG?=
 =?us-ascii?Q?s2ZNBmpqRBCgOwsq4ZX0cjvMh1NQX6ulo2jlX+0vgyv+dz2MohEBJswm1HQ4?=
 =?us-ascii?Q?vWijZz1uy3HObF73/SMPfyjYEz1L33L4r/WjazLOfHMgOvEu4P966WdTKb9A?=
 =?us-ascii?Q?zlE2polsQM7TZTQ05R0KNQSy9tou3TZe1KMiwo0q664pTwrCPZzZMSj8VIa2?=
 =?us-ascii?Q?/80kEiciWB943y8fvp4EV19OuR9gD9E4Ilqjhaf0uVxXjIDb9m4jDFCraJa4?=
 =?us-ascii?Q?1f28LLFFLCtrcWiXvcAomzah78pm0JkoE70Zw+zevfgOSM3p2GVW7jRsxbNJ?=
 =?us-ascii?Q?ebLVsoYg+1PC9miAOeUIIXip2wZCvH592yHUc7Y8/C5BvzPL4oFBGveEfflU?=
 =?us-ascii?Q?NGy45FAiNlEZ/Nro/1IxGn3Ldbt4HEXbLWGFxMCLxui9czjoXUZNnueJRLO9?=
 =?us-ascii?Q?dDBt7epf8KDwSBFdz2rVEPzYXiQcNX60g9oo+h83A4LdE1FL1fX46V5z+Sag?=
 =?us-ascii?Q?8CNmEZ9cHymUbY2JA9sgLQ7KV6ux2gcWEnuDroYqy9LxJ7tRf2WWq7lZXwNl?=
 =?us-ascii?Q?WVi8Pt8XI1Zyf/VQn6u02QHj58Pwi0PjLaxz3cb0jwUAsCNOCBwJI6O1jX57?=
 =?us-ascii?Q?HwdqSA3vU6aQQk35scsCXTIvt8EYdwhhIV8apETRxfoBUnmyIRid7tLdUeXN?=
 =?us-ascii?Q?5Ccuz0GRatzFlnZPlhnmvEaDDQ9HtfRpH8F737T6THHS3Bmpitk9ftr1zRXp?=
 =?us-ascii?Q?3hT33PvoNsqpx7c8x0K0yisRk3e4075u/19s0bDN2QZDa67LwBb88TIfzZnv?=
 =?us-ascii?Q?3zNc5AiEMKVvFONw5ehRo4F7BD3l/aQYNj9/6iObbH7rrFt5GXAKTwsQjdGr?=
 =?us-ascii?Q?u2CpljB1HnmN/XEgO0JohponIpXczJkDIRmp0gRkjpbjd++d1WdvVuz/Ub20?=
 =?us-ascii?Q?0iMIDvvE3x2vBNaUKO7JPkZhKqpT+eMCXAxSLAf8ZX0atFgzCrazcTyIWtWf?=
 =?us-ascii?Q?ISEHk18n1K8BVrJlxoxqz2/Ae+Q29yOW2X2Mtqkc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d09193a-8fd0-48b9-c565-08db60800d55
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:30.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+O9oNlNSyBzUF7zb3vwqAPra6D8Ni1Cg/nGxlPs2j5qyvSo/YawnQHvyoENHXD9B14zW2vCsJDQitopBxbheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 839471c42758..659bef4a3b23 100644
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
index 71e19e20f1cb..3991956dbc11 100644
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

