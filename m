Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6E734781
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjFRSKV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFRSKQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:10:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0AE74;
        Sun, 18 Jun 2023 11:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC6UMsVYgSqELiMBBXID2iM55+4iwuPJYh5Tg4E0n5vXMtk6TKzz3e63YvBWlkifB7D/iX7FhPCtbortqs3JIed75KGxaORuQ0zgvUi6SwZuLxNZUG9ioZk+iQaWtmVSyr0Yp8T+zgvTIEoBkd+DelDsX2Vb9Ga2ANAprCHU9YUE5/Xo1ArFneaG/Ml6mpXiKODfqDs96aKGX7qvmBomilnKxrq1J4NZdzxolMhdLZi1okU8OCcQjqSY6tIsuW9x4Qab9xECfDiL6Wu6Kc9X5IcWoJRyamfy9u6M6gEZExBeURopdTJCjCn/mneci06MHU+vdtHkR9qScIhmcWJ9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=In55gcnisLkuUkfxV2zRufPnzkYw04amV3oN6xmgwoWjcVEwK3S2NUOxJWzIfoHz2Zm0aB8sF8FCuaCkkQtjXzctqQzhbc8y5VIPfd2BkpSPQSrR6u4rhx+ECxhv5NyQ/99xuuyfPK+bxYI9H/eelxRUvOMCmr1kPwf0eyvGa24WBUbVFyv+SORaKlHNAJH1XRBt/7Peql6tW5Iua6bfB0rWsyzhJDK7TeBSONZlZPr+zrWkIJSKgyqbLUY/Q4FehN+AveCGnXVFZnCU+j9tVaxjDmCY+K6RpU0CpjNv2vXrEZ4xoLZcXIXN3P5HfVgGpcMKXa36MUeRgfbZ46FkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=gu8nNF/ipnOeXsy9zP/8maUfMdukh76S56kPfB5K5OgotuUGXpfNk3VrCihEB2/ZWG+2SmJ6lLjEni2+0Gpr/uzRSdtIUVHZ3sVKtrLYOb36PKjZGNPuYB211xbg1mj0CTJ+cvq37O9PTkXI+sOqP68Irg7YB4PWvoIbp0KOTfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Sun, 18 Jun 2023 14:09:19 -0400
Message-Id: <20230618180925.2350169-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9f1af9-f269-4d4b-4830-08db70273d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fooUI8GjIWT881jiMJlAPdyUpRxBHw435xQwAs8sX+DICB71M9JyMwHueddnTPz+jJv7dSvT3gde9cUcE6OC1NHzC1cdV65t3ZCTgb1RhSU9d+TJ0un3COh4YCC/TLYTFVn+gpm05MjYjxfJ4GxM+LbpROKAC/kgKE/OYkSFo1WYwIHMewqGMnaE1HClok/DvYGsuBsGF61L7Qv9OA5CanoRtEUM5NFNKwyTecKm3WWQbLkOYVdwvYonyyrXyF/zR6xEQkSFFne+cJjBYTccxlkhgCkDuU6B465Soxh1pIRQs7oJDZ9UeGRbCdON0GZSq5MLZjkhmVPYWJxSyGroQ8oDc090ghCe9ZLZuxuUepMSvnNC8gESPDwQAh2fYzSV4fXwxXXCCtZFnN4oqV2C7Kr+4DtmEy46m37p5kXH0srQt/oe/ga8aQZjMma++KFm238UUE+anAvBz0fZozOP7mZXXHksDsLPsDV0gVfxRjarJZ0M8HOHfgqRHTMEdp2yMq9TsLWFzHcrxBossfkRa8OO8kqVH3xU50K72CuVV6asIp5A9PD4C0IFcJ3T/2+zpwyXcxu2nAvSFugNVdYYGW5c0aZoEgVlYhNmNR7Cv6MNoXDttc2sBD+L0ul79STz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?014pLfs6v9eRK2lNU8wKIidNcpbGhwBGRY0RCCF5IQUoAEx9jky2pBEICc8K?=
 =?us-ascii?Q?dZSPkrdXNqwPDMNq5CrT6U8zj0Yta6E+K4p8W3OQUz9xPLT2uzDZEO6yBVnc?=
 =?us-ascii?Q?bCcoKI01vQU/PTuzURZ3dw4YOHbYqy4945MBMYe0hnTZmxCMFv3VkyCPy7qH?=
 =?us-ascii?Q?ZiFLg1EBpeF8MxCDeICJzoleahJG0F0gVt+I4NmTOjid3gSNRMelSa4X4qgF?=
 =?us-ascii?Q?7KN26SBfcrB6pgnMjcV/a/MPZ2p/eaSvd5JVzd26uaMQZsMCwJ5Dfd3+TSRc?=
 =?us-ascii?Q?qxawc0enIBKbL6URLIE6LCwZ1rBR8v1hshk9z26xsl2C11UySdCr9DARCR43?=
 =?us-ascii?Q?b46x/naAMHTZu4ObYqHVVncCgSju7U7lrNCidnaZsJjGw8v9gmcwa/ga1l+2?=
 =?us-ascii?Q?Bcojfb4AE03P4Jivx2k7r+nww+qv1BqDjG1eNHk7/3wzBflToriQI5yM44Bm?=
 =?us-ascii?Q?Zzzr/h2zj2jotntbUQIkk2qvlKno1LPOJV84RXHXqTLezFnlkQ3gllYi7Bq1?=
 =?us-ascii?Q?Xjfst1y2uG0MvkEfP5iTnqsf/ZfciTHnXt/hMWG2PzNt63cl/Otj1yR8PNxh?=
 =?us-ascii?Q?gEbapcwjWNFUdzYSbyXAXzBgJehCvUPIrlW2ABIsrrFlGyhSxlOhO/v+/Drd?=
 =?us-ascii?Q?/sy9DJxXPdzV+rGaC3E3PfHFGl1I6hM02UfkA7ynPeGUBcbDMEy0LURMh7/W?=
 =?us-ascii?Q?1yByI1mtxtEv2PVOf+zZwi0LaFuFVMQ8bNogob3C/WI8okB2HOlvBBNjfXyt?=
 =?us-ascii?Q?tT89ywuv0DijPaQl7OaqfJBq+mX0NTKdA5Ba4Ke75+efAxbM6e68gtfjEGqq?=
 =?us-ascii?Q?Hb4QeDV+SRfn7IkwIDsULXeaDZlWU/sTjj+Hfb+ZDXQbZvB6/G7JkxeDsQup?=
 =?us-ascii?Q?7F0K4woHV9+OAePfLMmwsM/fITmRagKA7QQWN9yN4getcgxjlbBcFQVLlY5/?=
 =?us-ascii?Q?mCyPLql/YWE7ryixmwSeauGbvRxRL97IaCDwcWDxcbGkklkzn8QXMVIocqxs?=
 =?us-ascii?Q?hwrUWkXz+0btx5YLVrLO1W69+qPXz3F3Go4SeQFHy4G1+Vv4Z9WzsNEJvGFI?=
 =?us-ascii?Q?O/s/1RaiYtdfGRDW47BeN+exeb/023k/ZEePBekgqPevuOz+6YaAY2b1l2/2?=
 =?us-ascii?Q?xmQGmcQMS8xJrCyXJvybCJp4Oq1E+QV/c7VC69H8iJnXGLKAPlrGCtLLwXUW?=
 =?us-ascii?Q?vOwbHcs6zAG5EjFt0NSf3DKSDs3yF7RNhvKWS1GObJgidlk9ozgy/GS4PhTb?=
 =?us-ascii?Q?wC0DNnHsj0mZqZvT6eeLw6udKkuyAdY4Rwm3WyeA9gu11FZ1w6gmTYdMVLDF?=
 =?us-ascii?Q?042vynZC4IBMmXbY6nU9cWSA+C3Q5TMOpyiOGYw6hsR/9Q1Yun4dP+qiC1BZ?=
 =?us-ascii?Q?aBH+SmRVeBbVnkMe/boW/b9eGaLWs4EJvkUudqDtW1a0O7evpa6ALTlDxU4o?=
 =?us-ascii?Q?U8DezthT+2iFAxH4HjBdx5PNvF3rUB5k2qnIm0Yp3YnuAcVKY+s4zjxUQph6?=
 =?us-ascii?Q?SPOGhsAMpSZHLYcbnWr9Ab/h/ZZU8oUGp33uwZ5RJa638eTtN2vUxd72Sj7w?=
 =?us-ascii?Q?UyAmbsCt6coLV6n6Rnu6RvM+gSaAn+llMsCqSIon?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9f1af9-f269-4d4b-4830-08db70273d3e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:03.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKRPafkscm1IPxE3TU6iWolFTzJZ73jhol60Lluwv9z8iRchNSvoHPHwl3RnNFVETr72MMV5C9ftun3v/Wkupw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

