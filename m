Return-Path: <dmaengine+bounces-978-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298084D25A
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54741F2452B
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51D84FC7;
	Wed,  7 Feb 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="shsPJOFM"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CF84FBE;
	Wed,  7 Feb 2024 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335271; cv=fail; b=OUC+tm+4jV/MogeMNkp+iCHsjLaUrm3PE+GapOV1EywiRsJiqFZ3E4Uh375wHYmZ9Ghzh0dT9es7Qx07kVFeBj5RQVHPnGfAJz/EwbGZuCP9sG4S6XdDZzj1ux1UY/lIy5WV9SZjN6H2TxRpNEj33zCOFXdskas535bMu/RGixY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335271; c=relaxed/simple;
	bh=BjXtj35R4FLozm0+b86OIV0vSF7x3nMRu+WtEUvNaXE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KhLdRD5aodv5QX41ahSBue1bwPdQa0SAk8/ePR3rWJg7sM/6p7bC3c2v3tK5JcLe7WVqZnFl6q/jAY4eGqV/AOuxsBP4QExqWl0SJPhmN0FJ5ywRZlBQ3Rao/2Lo+cSbfrGt7vJlFPKYgntO8fmy+I1eUd9ymIdyEK5s1QmomCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=shsPJOFM; arc=fail smtp.client-ip=40.107.6.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT5U2QfWsYEYZP7G51valwdCxE7/8HC0EPLQ9FBCcYED/inAYyW9/d+nGO5NBn01MIn6Yj/LXLOpPtR0NfWMNvxb1hwH7wwyPPUeqJ5UDJ3B1ekratJP9t5hozGpFIMKuHmNqioamHju8/bt3DqZp7Ls3xeYyMRtRIG7p9J2CPfBXkgT1AziVdzYNvuY1JaLt5EzKq8IznUCxCmC38xcPXP5Dqusjd8r5kbNlHWpFfrm1KSms15UUqVKo2gvnVm+eTQIqc/X4EiOXhG8Kl9h93nHxJOPvdRRNOUKDqi+DO2wE+LLktm9zefKYmixz0zkrP2BYBLilNEmEsYIlCzNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5u4GFTBTkLFs0HW7CVeKgiWXG2w3rKOuywRXhwMIRA=;
 b=AywqYjIG6fMWmx9/py0J3D9tZCxPjkEvKhB2etbvtTKjFYx5IOaRI8adEF+3Gymv8rfFuU7fSP8s+sYWVLzATlUj4TTuukP1XvTxCH8lNJXYP1gLBd12BfCGVM5TjOm3dmjTQ/CCZ13KfHFJw8FV2A1cf/q6l39w6bihWt29sEfKmJovAxXWuf4YNpJzHdbchTslcswJwf47aaGousqxd0TnITOnhj4pzR55Dkb65YnrsKYkpAXL9QKQzbye5i8j82EIQKgmYK87+rhvjTREb8O8P26b+eMyHkPeOBGEx5z96ppmm+g0OUvLOugMtqLx89PgPZ3S5N4Db8MTHZwcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5u4GFTBTkLFs0HW7CVeKgiWXG2w3rKOuywRXhwMIRA=;
 b=shsPJOFMyvEuGSonkPtqRYTM3eGuGrYqyUoxdxSmcg8+sehVH9Bp9jrEiDkHifGAEP9u1w8mQqadgFtSW7uoRZbCMnCJNydmnaH8DBGAOk/3ak7Pk8tIvb0QQLJyoL5P6Uc5MwsO1QS1DF/RLXuKaS/Efns/7S5NFHwPDq/w2gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 19:47:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 19:47:46 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dmaengine: fsl-edma: correct max_segment_size setting
Date: Wed,  7 Feb 2024 14:47:32 -0500
Message-Id: <20240207194733.2112870-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: bc373c2d-77fe-42ce-aa7a-08dc2815a88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C15fPmipPJjc1CCMRiT5RiS5Ulo/7Nb2mEM35JS7S4Ief+v7Biy3UALSfGTAhWZUuiysRw+EU6T6qDjUkTGssS/pldwaEltFe70pWa7s8X2ce/oLhWI9DNK0ea5I3QIJ2FIIIjlB22piEmZRdmhtxHS55th4Ig/9RjDq0GfyvF7PHLssXm2LZYObNgHhRm0gA1yODjh2+4MAozuR4Gp07bW3JLNCPQEsa5+dLhC4aoYHDLQiphFJFXrFwL2wEMathUUH5TMTCKWUFLwN1IrT88I+PU4yXm9rv/vzSd9/8Lx2RuY/o+67HOjm0U8Xw4UWAU3/tuKGSmWscHAhd2J8CvbZOyw22QAx+/bIXujgWmZQbGZMCF31+uTH37Z7emC/GiMuFFv8eFrFe1TUNjHb/8mGDWheyQGFZO/IucrHENHiPgXzUKbOmvbtg5GwsQ1AhCdrW6qqfoJ/Xy8nBQDEg06OecgPoBBoTuuFpyJXYmMtGl0IrcV3xz8m5nY1zITcJzNerKpVjIYF7EKGj3caJI4gZwmJ8OwEGsmInwfWi7uMsFOHxegfaGOx7F/dfLZFZi5Y8et6UmUVg/4nylDfA6eOtZKSdCTjMNwGaaygZWvX2LYwgyqfTj0JyaKB4w3K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(66476007)(6486002)(66946007)(110136005)(52116002)(6512007)(6506007)(478600001)(66556008)(6666004)(41300700001)(316002)(8676002)(38350700005)(8936002)(26005)(86362001)(2616005)(1076003)(38100700002)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?twp9i22IYco2cyawE294GQWzRHFQ8jbHMsAl6TT2eO1NETYFXwo1EaoHGZpj?=
 =?us-ascii?Q?8ZP2NNHrEhwoW2ESz8lgCg/LQPEMaIuzfGtnRQqfFM2Z4joItAy82WtY0B7w?=
 =?us-ascii?Q?QvNht/etjQG37LtoxYxVau3Vkl2bepxKAkMdA+hlAZpooARcHYxghmUGQDuE?=
 =?us-ascii?Q?OzTmLm3aJt8k3ZROo6JVO5p0k38ZSwZ0zy4mlKK6+VXN8Y8Ey0XFUAeizSz1?=
 =?us-ascii?Q?1lr9rCgfJ9NO5T7S8sDoX5RAATiARJOM9Qrtn+HWbEa96jc6ls5sRTATIWFp?=
 =?us-ascii?Q?ZqAHZt/76X/bGMszatj7DUjE7KY2Ssalsf6SX/jx7zosbKusjoAmIpdflH7x?=
 =?us-ascii?Q?5iwFAowiLcsZ9dior71ObPUO13hKXBPiyIIMKThc/SZU2vjuWM/owiVOYiOJ?=
 =?us-ascii?Q?LOWdi+0+7fcFEB6JH1lYj9Fh76dRX9sDlJaj3WMrcOU+NziRwtDL0ejUxwz9?=
 =?us-ascii?Q?k8HjZMxM7R2mTFEzzl4uv3o/Nlti+/8rzyMhkpP5ikHIpC+XpblzM9pX3sGK?=
 =?us-ascii?Q?17/09ARvvSWnvx8AkndxS+WkOQ+nODcjwK7BT/NQ7UoXD8thvUXH9a4QCRSH?=
 =?us-ascii?Q?LrOTkyBkam7i4nd1LMAULlWe1ZpunovBB2yLBOaLmonM2J7yLZPeLHTYtY/F?=
 =?us-ascii?Q?SijcjT081HuTueh0a3TrUREX1YBNMZSWzBxCLsTOuGE7W+aUX7aL/gsufRjm?=
 =?us-ascii?Q?/7b4cLhwTLgRIC6Z9c8Lmtt42T5xKXLD/L4KXoiusq6S7bMZoWFfAZKfF93t?=
 =?us-ascii?Q?4oCsJe2Cjnu9mjfhuPKjPYD1CAXutGDittDSGalZv6BfgqjlQKUoK8ZbzcTg?=
 =?us-ascii?Q?n0PHXDZb+YQjKz5WFtbvaSG1iYfad7S9EUtT6BhF+dbuz+ZZ7osA2a5nUY0F?=
 =?us-ascii?Q?67xgpjOzbXfKTpVdlKIgMIy6I9PpbWcbTsPNlgSlwAO9UspDRXmnjaOcroIq?=
 =?us-ascii?Q?mSv4+Fn4xNgPEls46EkVCUx4BMcXoWIY5qfJwCe5dDWCBOcJbQo9t31JlMTy?=
 =?us-ascii?Q?gJtn9it4h7/pKVo9KccmwdBgYS5Qk7kO3Cw+RTfQdUFnRx+zw1+1FIc5Ion1?=
 =?us-ascii?Q?eRxmreVpue4CahReFgbt89k956LVlWr4gBwBXthkDQOKGtplOwbrkR071iVi?=
 =?us-ascii?Q?ymXJxJOtL2Ohpg0i7pSV+2P5aQzfygiKQkU7CD/Hyk9Rsa2MtfhiGDNY0Ex1?=
 =?us-ascii?Q?rbSkrwPZbBDWI2Hg6GogZnAbJP/eATWZy2GvNrroLKrKvSGCey7jPQBjDWwq?=
 =?us-ascii?Q?BspbdXqp2eEZFjUUYjbUgM03IuMLfinalQK2Oy/XjhVpPUzD+zCS4rcq/5Si?=
 =?us-ascii?Q?L6KVCpGEa2zXvKqa2MhT88J8CD2A26Mv1/xM4uTVGEQpbKO82pq3RRWNTHim?=
 =?us-ascii?Q?TqXL2Zlz5A/frSWDoezMTFzzhKcc7Oeb8RDMcfOUIiM1exDycgxfmzihrRBH?=
 =?us-ascii?Q?BvfMMN2txvvMcUYmi05SKNT3PX++mUOlsDRyDbh7Vks3QbgRjq7EkTDJTvIx?=
 =?us-ascii?Q?7+8c91NvfepotUabzxfhW5BMl7Ia3em/wlWpht65o0aUHjk/uPOUwW4k94kT?=
 =?us-ascii?Q?/33mIongmBj02XK+oprrJ2Yol+LQ9IWhN+W3wzC1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc373c2d-77fe-42ce-aa7a-08dc2815a88c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 19:47:46.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZzmWqUVnrF3DDzXeT9E4Hp3ll7iyQb7OuinDASHOv3eO8xxFCUxA/RhzEvmNCOCKe1KSKPeLeB6y+p/rKxdhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769

Correcting the previous setting of 0x3fff to the actual value of 0x7fff.

Introduced new macro 'EDMA_TCD_ITER_MASK' for improved code clarity and
utilization of FIELD_GET to obtain the accurate maximum value.

Cc: stable@vger.kernel.org
Fixes: e06748539432 ("dmaengine: fsl-edma: support edma memcpy")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 5 +++--
 drivers/dma/fsl-edma-main.c   | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index a05a1f283ece2..7bf0aba471a8c 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -30,8 +30,9 @@
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
 
-#define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
-#define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
+#define EDMA_TCD_ITER_MASK		GENMASK(14, 0)
+#define EDMA_TCD_CITER_CITER(x)		((x) & EDMA_TCD_ITER_MASK)
+#define EDMA_TCD_BITER_BITER(x)		((x) & EDMA_TCD_ITER_MASK)
 
 #define EDMA_TCD_CSR_START		BIT(0)
 #define EDMA_TCD_CSR_INT_MAJOR		BIT(1)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index c2c0c3effc8cb..fa8b1e6f57859 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -600,7 +601,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 					DMAENGINE_ALIGN_32_BYTES;
 
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
-	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev,
+			     FIELD_GET(EDMA_TCD_ITER_MASK, EDMA_TCD_ITER_MASK));
 
 	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
-- 
2.34.1


