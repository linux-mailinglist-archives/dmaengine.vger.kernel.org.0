Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE871A099
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjFAOmE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjFAOly (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A3AE43;
        Thu,  1 Jun 2023 07:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtaPChwAYjJbXIfjvBAK1kvL9gwIo+2tw3+pWppF5MyIxSVp1fm9nS24qjgzV3ggEjGDC6q8XO6wvcfk0PS0kXBM4/g1//LxTOrAS9pq/bNpKp6ZDUutTfu7annQem2tDeAVhGuW1+UIAmwBQ8jVAefZ5be03ZxkpKfqvNbf2nu0zG53ykzuvYLQJVptSyfT5vCHsjC2H4ihDA5OHB1qM8NKT2T6uvK9Nm56KCngHFa/tzsCHr5DAhRwqn5NV+gSl57a6uFMbRv0CKO8PqGtKvcYoMhkkYjCiWBSrXfe5cWC6e6WLTaSwlizcgBHZdIuroV2Jh7b5pU4yLp5YOnvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=d5Z8oBrj8YoTTOVE4XX4DDdIW5pH044qc3zjnqtxAzYqhws9qB6QOgbwSaF/ZVanC6YnD9VKGMZ1PRDKw/QYSbOyi8lzNHHbrsOrv3Bd5YjwZYChlaDKQd2gsAH115bgyag2YkPFU5diGvm2GLrw0dhD7oavURG/GnteoHM2NtPWvucVdJ4f4DpqoDoK9gxHEyz9tHZz72g/3scnZGB23ckxYtAXcCqlgStwtkN7iyMJ+fp3O1braOsN4g2kBoeHEug2Sa/5u+m2sUKIg2qMoTjhmXvvbYUeks9E04fC+XmNU71+MEPUa47Zw8OuFZbVCVOQtqUNhXJMhzUUD4fnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=qVnXomP/gOPSv0W1Whp+1VTWvJv1/tzMwmwgpbTRzlS76sly+I55pDg4t218Ja/ZZ2wiwZxBLAZd/Qt1nYfgeDtVCHi+sRq/yeL3TyNM0oUGFpawmvTBazpQpNU8Pk7Ef3hWA7ychEeCMgehsYBulbLrLQybV7dNUY1kaBCkm/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Thu,  1 Jun 2023 10:41:01 -0400
Message-Id: <20230601144107.1636833-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: d73337f7-8a27-4944-84ca-08db62ae516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OAlNqX8wM0ocGCLTCxv5FaFRpnKkAU2jWAuW0xMXZSqqlZgI5xfE1XsEfwOsgjXmCF9uf8eTMHDEy9GhuGyu2U6HqSlh+6++FyOmUbYKglEV4uO1LVZ5WCsWx311dxX8BpuV2RKI7jpIOhwIWcHeZBFoxRfgRJElMBjwPMoCd/SJQrEeKrKDUSjLrxbBXcSvfZo7bz3xVpge19T8c+TUkMOn8lMtpASledclHJdZGw4TlOu/T7ODnlfEAB/eGS1uj25OEQi44Dy9JO0TyNSTIbWqH8YvMRgc+g5zJ04WCoYMeO8hForpWqcVCre1dCVDuDGcZZKfxr1acLiVgfIcSIAESfTb9JF3c+WRX8/PjFO9uiGzLK6EuP+QAY6HIXqO9IaUCS8ou3Wrewb/tuI4tGXWElus2Rc68p18BrenGHpL3ud6HahPFEQRZOOJk/HmmhEOG0yRrQ8wpSB2ec7373gSB4KJUjHHbXnzLVQwltn/2vukhkEkDrWPS7vnzqFdfjc3HG/Ijgi7vkYYof28vTm0eSQXXQQcBG0BNLo0zNy9t7s6anj20rf0bJKMHloWj7wh6DjacPe6asLi2Fe56zQKYe92c5D9cU2hHm8TX1U1Z/XMGn6/BXy16mI1/7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gueSlR4RHslqOv7Td2DoiVR41S02EjSaXSdIa4vDxbs2aToJCmc7JGeEUJyh?=
 =?us-ascii?Q?nt4qnabPM7gIevQ9cFn2CaNlK6y/sHxbOBGlSZyYMg1dm+/Fj31AXycXMXXY?=
 =?us-ascii?Q?sIYtatX9FtGgw1eEuAlmFxC/lQcCUTkD6ugoWvOmxYWuOsSDGOdwoarM6ijv?=
 =?us-ascii?Q?uEoL569rM2VCvjLoQ9DwgcpvOLZ/iy+X90fyfRGCjEOGxxfk3nzib6xecfu1?=
 =?us-ascii?Q?Y8gn6wlszBTS5raGtqqCe1vmPw2cH8fggkdQvUgFEne33FgRvjg1Ma7RY3Pa?=
 =?us-ascii?Q?bn5bFFjioZQq0z8/35duiehNbp/yKQm/iJUtaLfgH996XZshxXqtlsCa4YTH?=
 =?us-ascii?Q?ey4Ge7xFdCo+DnsOhR4fsTkZQwrZXvy+m3Trke3ilfvbH2AB5uioccNNoIkp?=
 =?us-ascii?Q?6q8GAB7Lj6RLre/K98FtZtnojapSCPVvMq8SvBCrxhZDioaHCYI0MqS0QfcZ?=
 =?us-ascii?Q?TsoKm2wZ7PFrgnlzvz6PXR10Sg2lKbUuD1yFIt/T+ymPyEgYcJ5ZGzCp1zTO?=
 =?us-ascii?Q?7XgdOJ+lbURGjjLr/07G8SaFZyPv8eJtsob7SZlkKtGG2KNN1GtSo6/IAUht?=
 =?us-ascii?Q?YwajHj/R6qQjBvGWb27cWWExD9Go7X9fwOtpu/px5Wujr3HWMNk16REGOP2b?=
 =?us-ascii?Q?nqmtj3032YsK9b3HhXtCxIiS5jo6gubneNL2a5GuHbI8qipBTA8KRzoIsivF?=
 =?us-ascii?Q?XbUnMBb7C3qUj1KrdD1FX0s5m+Pb0mV52Q28F9lDDuUBsqHFokNSyIRUkrHM?=
 =?us-ascii?Q?6bhDkzU2wbyk1mtdjpAmC75EegWeCKHHsAmM9TfwtkgBKgA8jCnQpbnQfFBb?=
 =?us-ascii?Q?j2gcWhYbS/wIhqQx7ZR8sCEx/YQeQEaLjt2FLI96O9FK3PqJinck1fZqGuss?=
 =?us-ascii?Q?ak7yx2Pj3XmEIMD3m2HhRGGwijwx7SHYImnWPTdqRvSWCoRBNrK3xC5jpa02?=
 =?us-ascii?Q?QyLPabOPiauS0EILHF/vOkKwUjxHPL/q21l0LgUcA1UhGrlp1txTGRWWU/8y?=
 =?us-ascii?Q?jTcnf8xfS9ICBZrBAy91GPVhqWgJT7K1BRO+Dph9sblg0gi6Ui52YqUe0zCx?=
 =?us-ascii?Q?AtFiMYY1HNSRx4cGN6UBqRFpVY73ZI0u5rdj3b5xK84vO+h6cBkKxx4T0wHm?=
 =?us-ascii?Q?Rn99lHggmGnbte7Abq5zzzJwXS3FLjmomZG7kroFrizqBD01c4OV9z7mnTma?=
 =?us-ascii?Q?+TNI4z8YJjskXWZsUAXOQCV5InhVj0N2Y6M1FfwqGR/txCxdxYSpJxnwCYT/?=
 =?us-ascii?Q?LcLYVDXTWd7SImdczdSsQTtkKzkH6/rQzQ3wwmKI6A+MfFwZ2x1OhgQEWJeW?=
 =?us-ascii?Q?IJhIloo6jbEOxxsTGLolPr99InESKK0DHNFFbL0CIwX5ZeuGRVI0uIhzDdBF?=
 =?us-ascii?Q?iqAzrHdWeXlcf7FTWG0yQiEN+jewyjlZIYU59FrlYhNErrWlfrzpMgD8nYe4?=
 =?us-ascii?Q?NslzmD5N6l0QmWpwpHosgP5xqxySbopNymLxktsE0EVixv8wLkA1fn/rMHgv?=
 =?us-ascii?Q?RQFpDCD6V4Xs8I8df2QBvdJxO/9Rsw4kJRrPHJaoK/ARWrqlGIYRs6W+twnP?=
 =?us-ascii?Q?smGnft6aOlY45KVU6qFc/TSV9H5ZW17CnKgr222i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73337f7-8a27-4944-84ca-08db62ae516c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:43.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaqY4S0uXzuLc4xukcYu/Yqn3FKQ4mkpvzIJAlzC7GNJgkMBQGFeEFIO+gVDltbBLTjlyeTiBCYs4W3VCApS1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
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

