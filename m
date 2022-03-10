Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7C4D522B
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiCJT0l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiCJT0k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:40 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7D14076D;
        Thu, 10 Mar 2022 11:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqNfj9cukz/UR2/eyufOsdgsLWodow06TehV/IliKhDjKLhBUXeuV2LldgrA7AzTOI4+cYCGdef1gbhHcx9FwUJbaYFBpwH7eH6y/GOCSdGqWZw04A9nOyIhjbzUoQGIQuht+8RDcl13yll4YN4N79hgLWhum+4GX6aC5awWFat0+knLAgfCv2+PRnE83PIvBvY04hURlo8maVAxehjaIHujOB6PrfC40VEAA9HnLupviUpH/x3PaCeUbDBZdCDMBlsMnrX6iGMZ+6QEeWUpRKqThBA0bZ9J0abOszMFXX8vejTkCCB+S0K9LKsiogvn2ITvdJznHKuTLkQOGZicww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnEeUzvicxWIDQw6HTw0cOCQHwjUxaABrk38tzjF6x0=;
 b=gNaR26V7YGGD19AM0gZ+O8q7dh+Ar/uE7IjRgfXv/1tNkMwr4JyzQb6ZCRDo0dkfkLGmEgI8a3fzac5FwcoyraTl+kZb49rmB93DG1nqWXahNpuTINfpEkTZFRWM7XbQzL4TcyASlihvNBsI5GfTk14KVmHtLTstMeyv3o7h3QNQcCjpWQvraaBkb10eMIKzA8/iIpGzhS5vtDyDw65VMigsMPOHYzn+owrsINjPnqsViz/vQcsVS3cieaOGbPxfPiyUYOY61LfP+30GA2fvH8fNELU57GRqZk2DtceWz1FOjL95YpIL1tQrHOGyaxOaNOJX1cIsYt74uvWE94GMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnEeUzvicxWIDQw6HTw0cOCQHwjUxaABrk38tzjF6x0=;
 b=qQlR2jm9SZ0uNXwYRS+3drmgQQUWxp0TF8LFTj25gV6VVg2zQiMej+TsIy5fe0BnVrL8Q+ZYLiW8m2p8UqV5SV+oMpFWJ5THHNFkFPjuR7oCcRpOvFDD7of5+elhlqD+Mmz6F5dU50pXu0ApIU6sDXvW/L/7UWCrnmDB1RZr8o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:36 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 5/9] dmaengine: dw-edma: Fix programming the source & dest addresses for ep
Date:   Thu, 10 Mar 2022 13:24:53 -0600
Message-Id: <20220310192457.3090-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b5d1c7f-d82d-4082-cdc5-08da02cbc0c7
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4858E7D647AAA0323ED64315880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvRqqigMmQga6ZK2EU7CILHxZXrm7fhDm1l508LDBnjfYG/741+CXMu67c6vLoETLMfdgQLYfV6kvkJHp4vfFR65v5nStKdMGUSqfF9pOAIXQiSVP3p0sZEZjRrQ1lHM11E68WQSKJfb+GT39YTe8/S/Bj5RsUn3JG+BWqKysQsW+icxQnos77ncTc9p/J+ZlWJbhFw9MX5tnUZr/z0b2vCQF4ieklI//LU9J0qTuoa78nQyZTsVQ22VlowTL0wdEQOaaFvxODsL8PSMIO3S08gAcAFNDIT03I3Bx75L6HeC7DYREuaivCa/GE7td0s18CBNzoU1MgLfNM+NhgSk1l0i5I34/Il5ljJlqBJddbZj37bfU5He6CTER0HWJU5mA+SrW3IAvJIu3AFIOKxg6tCM4x6AZVrgmyQ2buREMOM08D64/FnNLCp/r/rXnbKlSVlnAs+BQOQ5Wu+Q/2QQ/d60kuYuoMBgXXaIvKtUpHtOsoEH3UtrBgQfAez4OJVEIpmqGg/ImKiJyBjHHUOT3JbVe5GJfH3vwGof9Uiz38TEqZCHS9P36YlwL+RjuBKCwZzDRozP3sCRB9HTTO/CnSwFikv2u6Xy92/Fueljxre+QQSk5EFL+3+58d+VtO25OIPlyTl2s1I0im7UHdnZIAzZf+cFk2V4d5OAqpvO5Wz53YKSmuLflF1qBLpd4kvmslq1FDAfR3MT8bAzb7ia7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojccBwwpTdqQUgZhGy15B2a4Wte5mI+uQcrtMRjEJvHW354/wLrOfgImMDBf?=
 =?us-ascii?Q?Dkqb1BRshYE+HSo9rEYbJfKVZAWHTIEhg0i70rCEHdYGii1ekQXJy/G9LZc9?=
 =?us-ascii?Q?HDw1hx9CoR3ADZSXCwoOnbbpFM83rSRZ/b1i5K3NlGdvr+RWQSQF59hfZLFt?=
 =?us-ascii?Q?V35xgUBYSMEFxWI4fTtfkY2G7hL3mKSF0GVBdqGSYiZHVh7DtycxPC/Az9PD?=
 =?us-ascii?Q?+XrdvYnSb0/Az2hwwt44lXc8WQ8K9KWoxWEIBcKTLEE1OP6BXCHt0Y5CUq0U?=
 =?us-ascii?Q?fc87WJBINpykuNViWAMmqg67hhhj4OI+ceKb8Nn3QQ8kR6bf1HmNKaaO41mQ?=
 =?us-ascii?Q?Eom1kU2645nuWMq2Nh3vCzg2Tbk/rukaePPOociTWqRHs2bmvExtA8L+0YNf?=
 =?us-ascii?Q?jp03dz/pvC7Ke8sPoKE1OP++IpCUNtNg8KwCUgB83PktuyH3WEfhX8OQmzvE?=
 =?us-ascii?Q?P148z9vGDAgLKHmIzGMffogwVDD++PPzH8DTyhl25AAn/6TbnDOy6KmS3MV7?=
 =?us-ascii?Q?UFaJowoJTkorGsLJZ7BaDgKO/pe1J7WDMRN8izC8+yur2X4pq4ciDG32ylqJ?=
 =?us-ascii?Q?FBq9zzTUQdyGdred4dTC8C7un3i9luPkmSeaLm9EeLl8F0/aN3pxq11y2AEa?=
 =?us-ascii?Q?b6FJmzVZXWU3dPEefS7TnBzApPsT+lhMiuPXKUKuZ9z9gpuLrMQ6GEQQGLrQ?=
 =?us-ascii?Q?vk9RsanRjX+AstozVrDDsbS4/QL4dHIxb5M403bMb2xOLXEdU61am8IUhFcg?=
 =?us-ascii?Q?4lxB/gt0huPEU4o7XIDnBrE55er5XEn9LsVuFFrMFMhdSq+DiEo+cGb4/kqr?=
 =?us-ascii?Q?bcb6lUiunSwzSSaGLojax72n/4bVm+5ncJ+9V5aLYbOvL0l+or87eWE4orrU?=
 =?us-ascii?Q?r1f3d0H5ZDp/no6sWuegqdJkbbLee/GITDgLUn1TyIYZzfmitGYJwbuUKHDj?=
 =?us-ascii?Q?cEJEafN4NjGkIv240EUOVdZJWoX5YWkzsq0WBhj3vBZlgJQNhwkjlmM4u9+L?=
 =?us-ascii?Q?cZg1ITWrOV9ANlFAb7oVouixZmkiX5+bGf/RZl8znVLijIcTlAVJUgE/qCSP?=
 =?us-ascii?Q?yVAkkhP/aMpsODZsT/JuLgUVIAGyLVGmEwS58g+rj9qWFH0aUZuaHafSA9S1?=
 =?us-ascii?Q?HSNxmtaNZBlf3E6o1QmC44k4Zez83rL5rcU8fp/qxZ7imX/Z40j+L2xUzgFs?=
 =?us-ascii?Q?h0rYDUnIVOW3PuCqf7Cwb/02OfAGaorMBq/S0CsKZWM47KF5uS+bT7lNQDmR?=
 =?us-ascii?Q?nWW7G1tE1fMrWcvNvIv6tgNZK3Cm/Yr4r7lPQ1DJTB+VkLYSccK4ndq5NoFm?=
 =?us-ascii?Q?WH5bc9550YxXlv2FyOKbvlQ52IX/Jyw7qWRFtT5P+gQUmuGchiXW1C+/palL?=
 =?us-ascii?Q?s2JWTxE9oPUrKJry8S/p6efbXrJ5kVVG+t7ul0AuuTFHvNLggB3jZy/4lECW?=
 =?us-ascii?Q?xJgSnDVIOIq5pHuxOSOXfAHIm35AzgNH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5d1c7f-d82d-4082-cdc5-08da02cbc0c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:36.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/c0czBXk5lS/3ITpI142adWdCFT7PZTxwWDH5lI2UCNJ/bxO2pOjsHxMhQTMhh6Jx8JrA/gCQHCWGkK7eY0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
programs the source and destination addresses for read and write. Since the
Root complex and Endpoint uses the opposite channels for read/write, fix the
issue by finding out the read operation first and program the eDMA accordingly.

Cc: stable@vger.kernel.org
Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 3e4850cfa0b72..924f220007362 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
+	bool read = false;
 	u32 cnt = 0;
 	int i;
 
@@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
-		if (chan->dir == EDMA_DIR_WRITE) {
+		/****************************************************************
+		 *
+		 *        Root Complex                           Endpoint
+		 * +-----------------------+             +----------------------+
+		 * |                       |    TX CH    |                      |
+		 * |                       |             |                      |
+		 * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
+		 * |                       |             |                      |
+		 * |                       |             |                      |
+		 * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
+		 * |                       |             |                      |
+		 * |                       |    RX CH    |                      |
+		 * +-----------------------+             +----------------------+
+		 *
+		 * If eDMA is controlled by the Root complex, TX channel
+		 * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
+		 * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
+		 *
+		 * If eDMA is controlled by the endpoint, RX channel
+		 * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
+		 * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
+		 *
+		 ****************************************************************/
+
+		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
+		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
+			read = true;
+
+		/* Program the source and destination addresses for DMA read/write */
+		if (read) {
 			burst->sar = src_addr;
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
-- 
2.24.0.rc1

