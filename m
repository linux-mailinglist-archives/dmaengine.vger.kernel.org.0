Return-Path: <dmaengine+bounces-987-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9484EE83
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 02:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A8DB22BB2
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6515C8;
	Fri,  9 Feb 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z1wBiHvc"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C0A34;
	Fri,  9 Feb 2024 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707440703; cv=fail; b=N4tBUwzgt6zslth5rPTjeGAPoWXRTdLQDqvsOytx5Qin2Zhhgq3escdpPztnTm2ynxzi6kvTKv/7onjIL8WtMJBVFzC4xnj9/k7747BaeLO+A1QHp3FZZqHnLB60fM3aBEIKoM06OKF8PjHG0oLvJrk+3N+uDjYdnPTtbgn6Hy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707440703; c=relaxed/simple;
	bh=dRfOZuqRUtFaArT6hOmglas/LsidRqw/YQI6KbBnLt8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbO+6c0caopcnDRk3urI7OYT3AEBxlnGjzgwW5ulhR4LxZO8YSkaWsBtVVjeYPitGU9U8dQnRbGE2fiRn4e9rvHJ8vsLfLRnOVqaNAq+N1mJQ8685bITbvsVMwV5Qxsc1/dCpMZGOVXDsufLXwc4HhgEjQW3upMZLeKaxVywUGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z1wBiHvc; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvj9CGkRDAbb3xNMA2h8FiP2B/1xQ3UFrmAlDAGC42AAb1riQM8pNeJh/20ZL1Z2N/5pfwPBcr5soH6gN4X5mmibdjWa7+o2epqqIGebjXjafLPmTU/mchxVx0p48YnOKV7QICYuBtcGg3F43GLaASGqQNVu04YkHAQ5NLVEIFKtLcdlzKimkE7U9RVOsgxb6g9lHehI4k9XtkwPXEV2EFrKsndqXmw2lJAsO8SJfRsjRAwcfv0nF+4h+2eU8qBO1Xpi98ynDnfHQSFuA448aDGcJwsgrHvES/3InSOBiadCT5f/R5YPLqpcz28NdSdUJ53HYZyuip4gASDVD7VLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUees2+CYuNSMnVFfpburGEEfa/Pi0zJJBFblNMWZYQ=;
 b=oRxvDrHoLxbB4/z8j/jCVvfG/ijXY7gZj3MQQJzXS2wum/unV2VD4ATvYgcA3SQpjp4V0wZUHcbwpNZKeusIdCHR9no63yitnrbWWn1AubHCl+F/dCsE9Fa60SN8Ft14uibXvOJDpWHKmcM8c1THYP0rHpQGjuwgerwQs3XfK7Rp09hLLNwx6enfdN/llVUZ2BvUPchoqFV8KrUPxuY0BCu3wiERxjTHB2v5rUWX3iKQaTaIYV3mM3lK4XuwoBRFh78+rp/bmSwFe2KiNF/tcsPIUKWDVtULKJUQy37Mq/acbBo3ykADNkcZlT9grSNVZDjRdiJnC4zgVocJoo8M+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUees2+CYuNSMnVFfpburGEEfa/Pi0zJJBFblNMWZYQ=;
 b=Z1wBiHvcwsLD16rSokdQ9PSKwkJYpjkqAklfF8LicRoCczWUbfu3OifJZESYW4taBMpXDC5cM7fqNcs3+GTpso332nYYmpyNeDwMiS+uI2EfEC2oEc/cxhw7QYn+uEUnWtdi9xL3mKGjUbtrZLHfPaXBZVNHL5WNWO/YUKO1qHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9764.eurprd04.prod.outlook.com (2603:10a6:800:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.43; Fri, 9 Feb
 2024 01:04:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 01:04:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] dmaengine: fsl-edma: use _Generic to handle difference type
Date: Thu,  8 Feb 2024 20:04:23 -0500
Message-Id: <20240209010425.2001891-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209010425.2001891-1-Frank.Li@nxp.com>
References: <20240209010425.2001891-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5c4360-eff5-42de-217b-08dc290b217a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KoQN9Y8MB2e2G2GMRMEij+W1u6gjT4qhG44RZ9PVbWih8eyG6Q6nWWIm5t3vhXmes2Xwbxq0szJlASSZs+rCDX1UuhRxD/E0QBIrIhj8XHGq5EdAY4bGXWecGqMztHpcVFy7riZOZHemm90tz1JQy+PZFhfY99vqBPG3VuSULW2ZXa47KeAucl6w9Ue1f6F+s9Gr4IR5VvLg6aDYoMZsYxZ4oavNU5v1Wqji0Fdgf2toXGlijUmDbbSb8hoqhqYaXT0qAVkEyl6heYK8bCv43bJBDXGukLLidf2jR9QC5DWw6FVtFO9S2vQ8gPnXv4x2smGcyCGqxdvM9hI1zBPA6fSO7ABc8ldRH1vY8FB7glFq6Z5ehEQRuFvRTyldC98wlKpxo5CrP1BxpaIIyn2OrXIg0nQvZ8ToW766MatsmfFXwBKFNj8T2qf7ie6JndMAobRhuGdUoERsJyINGd0W0nIerrBjMNtYFpE0e0hsR2BfX+lbpu2alb/PIfAZFXxW3oDMBI5qn1ibcIpKlZDDpD2kQgEX7UIGYPo4m9iT77LOgDz3w+sUhZprnOfBX0T9mPAi+U8bQ3a4VwUusM8qysCRcB85flhqD353r01xh9r6rXpMex5ntS7PuypZkjpd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(8676002)(8936002)(5660300002)(83380400001)(2616005)(26005)(38100700002)(1076003)(36756003)(86362001)(38350700005)(66946007)(66476007)(66556008)(316002)(6666004)(52116002)(6506007)(6512007)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSEaH78ZxhL58gMIuUhY5Bdqx5sBXhaLkybXflR+Oy4O+G1qA7YOR6DFqXfw?=
 =?us-ascii?Q?HQifxrq6AjLxfEZVdZ36WZfcObid2ewI4NwA+lKftONRk/IrRatmbUp/r7AG?=
 =?us-ascii?Q?3A0p1UA7ljFwcdPfPYyg7KmIDW3t4/du+cgZJPirJiX0I0IYlUwXHuGAROIV?=
 =?us-ascii?Q?cYHv6dfJY64O2+TMBi4tH62aLJOfWdGmRZCbI/hGeJ8wFlTtFqeRKB+60E4o?=
 =?us-ascii?Q?7ec/OO+YvxpX72N1Pokh6a3uAQ9aAMofjHFyehLWf3fn75guI+TxqZyGAc7A?=
 =?us-ascii?Q?tqET43QFYEyd1+aApZWE+06FPEtkkPNQ8DQLxgfQvHvEuyjjiCD4K/fDZK7i?=
 =?us-ascii?Q?OriPPX2kXlInZ37jb4J35CpMoi8b/gQxFq63LOdczTcH8oY6sIIsS5oHuAeN?=
 =?us-ascii?Q?l4Z1mhDUfqcrCF05QEsPxAD6jvraEvUWsv6B9QtAn7e8K+0i1Tathv5H/OvE?=
 =?us-ascii?Q?KNSPQbMtZCggtBMrUwE4+JnsNlPJiCifxrJlEQHASzfNP05rjEcAosAp/bYb?=
 =?us-ascii?Q?tTFshJkumxtjCO44YGykBNQzdNk/i/59ERBS9Tezv8LZiaId0YOTBUrtlgkZ?=
 =?us-ascii?Q?frpO/l7TVSd/IB6OZuEr6dCUbmug6EYka0YYcVimzAx9uXSSrmgvXkNbIddp?=
 =?us-ascii?Q?ML+RucjQAbBxW6h/o5FvX4qOn9JN81jGkbnUhzRUjwRpVOqbSWBPejd2VcGL?=
 =?us-ascii?Q?R6pdTJEU0fkMGbRePmxpHNqznlfdZR4PyrL5hwAXHfmyqAIY+q5g7aBh48n8?=
 =?us-ascii?Q?rYW+CFzj1xSKdtVHHBRmcvgcIXjsLnDm0hnLBH4iAXuhHBKdmLKjIoCHyCsq?=
 =?us-ascii?Q?GSb0ppfEoPdmvvesGW8z1zCPEg/3VuEjn1FBHOG57wvfdMwFtz3zpLnX1gGw?=
 =?us-ascii?Q?XB5EANVf1ZhHzmwvrm3TA3w/sUTHF41DNxm2h+yY8oxf22MANDFhH7vVpvrJ?=
 =?us-ascii?Q?dIn061PQudjbmnTGSyWJW7M2CwvVA3bJIloI9qVigTOysb5VjRCFxVK1hU8H?=
 =?us-ascii?Q?U5nLZ2WU6IRuLvnVxc3RIJ8t39B+shqhVN+dyV6EfWo6HyclU/eSeM5APZ6F?=
 =?us-ascii?Q?u+/3KRQEErE3qX2eyOrOw8ZhPqtR6rKAqRNcNf+cZnO+z9tFf+l9yTinya96?=
 =?us-ascii?Q?mXKdaSkhyt27DNvqIN+fOLS3k68VQM/ZTtce9Kl65NjtVUIPK9hLyGbpA7fz?=
 =?us-ascii?Q?Penuyi5oqt3JFzpUWhGNbWCWXFOQXdtf1ZtRFNACFBqe2QH9t0jOi1jWLGOm?=
 =?us-ascii?Q?k1NZG3QB1l80oJFDaVkRw6mF8U2z3hSwMVqG3xo9joW+JdE49sWpTKECnSY/?=
 =?us-ascii?Q?8Fzbb3wFAUY6+o4sOdEBRBcc4MknO1qOAP/CQ2HT2U0XmQ+cf3568c3Ot27/?=
 =?us-ascii?Q?vcJWx3DxncCiLm0rOL6FfzMM2dZZno7Ood5qrMRYooKADIMZ8R8LhFK24M7u?=
 =?us-ascii?Q?yZMFFgLBh/OxREdqpqKP0gMpvIVXP8MeVapxph/OylfsZ23z2E16ZhUwv2on?=
 =?us-ascii?Q?sjDcyWTKN7t1HNgoswJLw1lovc9wVEqrPipJgE7l28NDvhgfsdIcddtxVW3g?=
 =?us-ascii?Q?ZxlPhLDqoFh8Ecra3CQAb04Ir4RTd2IEk9EC20eg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5c4360-eff5-42de-217b-08dc290b217a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 01:04:56.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUlFVrWy2PYa7M78ZL3vhTCAIOdpZwNj0XbxypjylgQPatf/F2hqVGRwz5XokRxu8tUQ4KDKxd5j2vmZfVsgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9764

Introduce the use of C11 standard _Generic in the fsl-edma driver for
handling different TCD field types. Improve code clarity and help
compiler optimization.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 59 +++++++++++++----------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 365affd5b0764..fabd2d73a7c22 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -255,12 +255,11 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
 }
 
 #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
-(sizeof((_tcd)->__name) == sizeof(u64) ?				\
-	edma_readq(chan->edma, &(_tcd)->__name) :			\
-		((sizeof((_tcd)->__name) == sizeof(u32)) ?		\
-			edma_readl(chan->edma, &(_tcd)->__name) :	\
-			edma_readw(chan->edma, &(_tcd)->__name)		\
-		))
+_Generic(((_tcd)->__name),						\
+	__le64 : edma_readq(chan->edma, &(_tcd)->__name),		\
+	__le32 : edma_readl(chan->edma, &(_tcd)->__name),		\
+	__le16 : edma_readw(chan->edma, &(_tcd)->__name)		\
+	)
 
 #define edma_read_tcdreg(chan, __name)								\
 ((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?						\
@@ -269,22 +268,12 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
 )
 
 #define edma_write_tcdreg_c(chan, _tcd, _val, __name)				\
-do {										\
-	switch (sizeof(_tcd->__name)) {						\
-	case sizeof(u64):							\
-		edma_writeq(chan->edma, (u64 __force)_val, &_tcd->__name);	\
-		break;								\
-	case sizeof(u32):							\
-		edma_writel(chan->edma, (u32 __force)_val, &_tcd->__name);	\
-		break;								\
-	case sizeof(u16):							\
-		edma_writew(chan->edma, (u16 __force)_val, &_tcd->__name);	\
-		break;								\
-	case sizeof(u8):							\
-		edma_writeb(chan->edma, (u8 __force)_val, &_tcd->__name);	\
-		break;								\
-	}									\
-} while (0)
+_Generic((_tcd->__name),							\
+	__le64 : edma_writeq(chan->edma, _val, &_tcd->__name),			\
+	__le32 : edma_writel(chan->edma, _val, &_tcd->__name),			\
+	__le16 : edma_writew(chan->edma, _val, &_tcd->__name),			\
+	u8 : edma_writeb(chan->edma, _val, &_tcd->__name)			\
+	)
 
 #define edma_write_tcdreg(chan, val, __name)							   \
 do {												   \
@@ -325,9 +314,11 @@ do {	\
 						 (((struct fsl_edma_hw_tcd *)_tcd)->_field))
 
 #define fsl_edma_le_to_cpu(x)						\
-(sizeof(x) == sizeof(u64) ? le64_to_cpu((__force __le64)(x)) :		\
-	(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) :	\
-				    le16_to_cpu((__force __le16)(x))))
+_Generic((x),								\
+	__le64 : le64_to_cpu((x)),					\
+	__le32 : le32_to_cpu((x)),					\
+	__le16 : le16_to_cpu((x))					\
+)
 
 #define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)				\
 (fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ?				\
@@ -335,19 +326,11 @@ do {	\
 	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd *)_tcd)->_field))
 
 #define fsl_edma_set_tcd_to_le_c(_tcd, _val, _field)					\
-do {											\
-	switch (sizeof((_tcd)->_field)) {						\
-	case sizeof(u64):								\
-		*(__force __le64 *)(&((_tcd)->_field)) = cpu_to_le64(_val);		\
-		break;									\
-	case sizeof(u32):								\
-		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);		\
-		break;									\
-	case sizeof(u16):								\
-		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);		\
-		break;									\
-	}										\
-} while (0)
+_Generic(((_tcd)->_field),								\
+	u64 : (_tcd)->_field = cpu_to_le64(_val),					\
+	u32 : (_tcd)->_field = cpu_to_le32(_val),					\
+	u16 : (_tcd)->_field = cpu_to_le16(_val)					\
+)
 
 #define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
 do {								\
-- 
2.34.1


