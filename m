Return-Path: <dmaengine+bounces-1965-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA1F8B2A54
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 23:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A267EB21B3B
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F82155391;
	Thu, 25 Apr 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLm9MLej"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588701552F5;
	Thu, 25 Apr 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078812; cv=fail; b=U51A/tAxdklj9mKBTZGje1kI11J5exrenPxPNjoCZb0cwQZ1VWAqydd3ZFlziP6dcQE1XlqwxPLVYv3oEHN3M0uJvUfM2lixmkYs2db4bNgX+p527Mm5mWQFSMjOx5ZLevtIKlh5hk9UwnrPXqaxZpnOAPnqhOwX6drt7KTDB8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078812; c=relaxed/simple;
	bh=V4g/jDJ2D2huxmNznDQnTTTZCwXlGnGX7txvpeEIln4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+ahhHVNcbeBJ/5eHVJrg8SCrFnStI5QZmZ6DGIrMcPnQoPYrvnzG+IgKgRU1YUT3FuNbv0cxEaVcozKkXVUqkNnKMzdmMW7POU/sXA8CzWabKjSD3o0iYcWLU4Mzf9dXqUsBgzVYR1K0a1fbIPf3sC+OsU6d+6VNMC8ehqZgqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLm9MLej; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWNZyKNBpzetsBg6u8o1Cqse/Nbm1FHK3HE1FxcvMBc2Uc2lMgSeTC31feAs+Jv6AQHGgmgvwVbmWVE7BQgi99sy6bV8S12mbSGI927/8Po1zg3EJLtQlIfLtcWrT/4NtvfZ87ujpwJ4yY3yThQqfE7CoEiFfhf7S3zzOckbvU47Mhi/Tq/BUnFy+wOl3PbTr81Eak14gx8SjXF1ORrwKVW6VmwXXJte/XxwfeoSetrPU2MYsisWO0fGE9bS3xYimp3PDn3cy1tjaf70vscGoD6Kz9kgtu5dMoOoOg/w0ROMwKxFpDOdqX5Zk4iEQEzXHuqfiqE2FEcr5osbbEwZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBrZiifXGBGlemqowPWp/O/ZKsVkoL4dZ7RNw3Q42WY=;
 b=BGfYq8oHWSW8M2Of7iHddIjRzneLtwIf5wItWA7eQSWptqYhcIMnMqyL6kyOAiUlgICtGZclwQIGFLzIMmuH6eEzaOOFjuB7HxaJLwD2CQzq4JTrv+LErUA/oQ2N7FiImnpLzfyMRzf7PoJ73JKn+jwdgiwjJdB6YONPfZXQ7oHzg957WAgAg6oLgCsU0XXrBeppWdsglAsjYJQfhfGj5tXhdJSBHyZtLPh0u/o/9u/+kjtMwIqLi9NWtTwFU7/RFsi4UngDxU0D8KWCiHzxBfv7tvwfkzlNR0VJs/0hbaWSR4yY+5bcGPz+YS2lS/RdvWup55DQz+h/3CGl0Ux/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBrZiifXGBGlemqowPWp/O/ZKsVkoL4dZ7RNw3Q42WY=;
 b=WLm9MLejK7Tor16vVGG7jH8mtnP7v0fy4lcKZ1YVSanoiGuANGGL7V11sJAdxpWa/KT+/4BJqTOZkSd4yVfyfPwuv7qlcfSBBc4XGngqfJ+eVaEo3R1j9KFU2ZxLTZn1GRwthl2tn+T2NlRT/c6F7gCcSs+FPFu2aNJso7W+IKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8637.eurprd04.prod.outlook.com (2603:10a6:102:21c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 21:00:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 21:00:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH resend v2 2/2] dmaengine: fsl-edma: use _Generic to handle difference type
Date: Thu, 25 Apr 2024 16:59:46 -0400
Message-Id: <20240425205947.3436501-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425205947.3436501-1-Frank.Li@nxp.com>
References: <20240425205947.3436501-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 84857e50-2554-4fa6-952c-08dc656aaeb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epdDZKcVcIpMkD44qMzrTI7rOXAYc8tGbOGf9F2CP+T8K798yO05HNchL/+y?=
 =?us-ascii?Q?MllCuf0iL/uB/+Amk8GNosQkwuQe7zeoxP4vIPUnd1t+eyEhu68qWrdZ3DuJ?=
 =?us-ascii?Q?3UdHwYW5au/NlWxlnnX4pXnxOePaKMb3OT1LAJfwawjoJiJ3m47ii7rom9dK?=
 =?us-ascii?Q?/DamUms73BQLDqQH4GMy/8pjkK9DGk4EICxXyzyxQYejTYTLk1gjgaRfsdy9?=
 =?us-ascii?Q?83nd4XXDzL77+/mpO5XhxsMq1VThfhZ3OWLQOP59U+D4x6XsbDvpk3jDE3vt?=
 =?us-ascii?Q?LeMZc2zGwYqED0pkqpVPorifnfzuyqxcSBS6/eLkyNQ+atqZ5AnJxRoOrsb5?=
 =?us-ascii?Q?gHcvPCA9OUOeopmrKvNneV1Q1aF3LmDU1jSF1FX4RbqEzKgwE3U6gaYn280/?=
 =?us-ascii?Q?Zn5eRNbH2O17fjb0k8hvoGq8FE/sLxmzlzLqsmrD+gY7mR6SM5JxcUVrg+K4?=
 =?us-ascii?Q?8MUNPg9dOjy0Dw/GG65GKT6P8NC/SwmzveqMfoGw9hlGDjfiP92FGunN0ldh?=
 =?us-ascii?Q?mudkmFdwa9pl/Zwx6JXC0Un28buv0Qh+xFe0pXF7DlApP7ww5rL2ZInW9o0l?=
 =?us-ascii?Q?ZRaJMJ/+AhvaydNIKtlTH48n4PehcII0zZiCbEF2IYlkon+8fQwCyIgGmttK?=
 =?us-ascii?Q?QC4HcDbUtOQeYzLYPbtE8Me18euT52ZcF4w6VMFN8Q0FcA44We83z6qOedoi?=
 =?us-ascii?Q?8AsT6WxXXEsp/fMx+5ckwwABzzAts8sHMGpe41pTsrXQTtd60zN9nCwvE9nu?=
 =?us-ascii?Q?lD3TP5kS07dqqb/SIG8gbckMAePZJB119IUBri1Z2T4eugRiK3Y7WfUoW7CD?=
 =?us-ascii?Q?yfHS02Ap0iV44R/3WEBDe0y0tMxOKiDWFCz/P9QKUL3N3GUousWdoleiAKtm?=
 =?us-ascii?Q?7y2dBfICS6e3mGG56GVSvOH/EOrsgu8TmgQ7kQWXT/UPkifA8gTQN7IfYEXV?=
 =?us-ascii?Q?TSiLWCpQe7y2C0YgZGcsKhNKAmZI4qLa2Uh/E6j8PSorgowC+s/k7eeeFu4T?=
 =?us-ascii?Q?DavvhKUJ9enRpyqlJDOwU5+faailPX/SrhrLaN/qfJJDVrskhjwB/D7zZafq?=
 =?us-ascii?Q?u2BMIj3nDs9dV/keWslZyCNkHkevPsHkoT7S7UncGEv6YWz36u8iXuEUsu4E?=
 =?us-ascii?Q?LUSEyEmodTDdJ9nOkLGpYvjUELWSYOtn8w8enM5B7Ts10J/bi4a431+bletk?=
 =?us-ascii?Q?U02PTFqfpSFMZ5XhrzHRUfBrMY+O5wjHW1qpXBKWLUkZXSauP0bXLeDSqQ0B?=
 =?us-ascii?Q?1sQTt+OgPL4svVwNTBxIRGFtOmsvMcb+tLH8Tpuymix8iFa4cz1RImO1PBNs?=
 =?us-ascii?Q?Nc2KwsQdxG6s2jlx93Ggdj5EgyNLpPiawMGDlzKDS3UzPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNaHhB4khm6CjzqJM2XF/ZRsQ+rq2ZcmdXSiA7gJ+cxcsBmS7ZfHjmCNXaPx?=
 =?us-ascii?Q?+/EJHCLS25PDl1tM8/OFsjTEv80s/zCfqpDsdErGWgkbh0LFWtXeBtfQlX+1?=
 =?us-ascii?Q?DU3JHgkLgd4bzd/ixtTf/min/QUlb/ZnWkqXrO8GFyJgG3RXUz9qqNuVZHra?=
 =?us-ascii?Q?VVqAOQbdqdw1gyMdtspZWkNK0zf5FvgNpDqH3MouAOF5EU9DQ/xHjI+U6j4b?=
 =?us-ascii?Q?HG6dBBGa4OFmqQBtkNyAka/jkLTy/Qcwsh0rjqPDOuHRQuNXX0pyubsZPzkK?=
 =?us-ascii?Q?gms+bh+6BUHgUcUv0S+KBC2H2N2gx9ELl5BpoH/OpLrn4P6YynVNigYHw1Z6?=
 =?us-ascii?Q?wFRczd58aEHnYQDUHgxNWxCHIoeLDFTGWmWP+GqaJUB69qsebWKFVrhdDeaT?=
 =?us-ascii?Q?xuqGstCUSLiFlbMbjRGMgAqIDPxIlp5Pq4dYFvbMyVLEqu+4LdosWXJ/Zsyz?=
 =?us-ascii?Q?Id/PxNsjqsGRk9vMOkKyUyfE8PDqFcjxwXwXcvc2016D0ZLxn5E1v/Xh6OlU?=
 =?us-ascii?Q?3xDYngQ3ywWBnV2+YH8EhRZAXXAgwWWQLh/t+3Nj7rM2ujurKChF/WG2ctfx?=
 =?us-ascii?Q?NslP+Bdxu6MPjH+b+54aW5LQjYcKD7kNlwjyzARS0xVfslD8sQ96JHc/44H5?=
 =?us-ascii?Q?U3dDhX02bYoS8AY7IlnEUXEGKp1gSqMD25R2mny081XGAywT05JfAe8tJG/q?=
 =?us-ascii?Q?Y1nY2rd+pzCDlHnRDFPJFQqE+StdSVRZfa5DvyLwZFQj7uG7fJIz+acogE6N?=
 =?us-ascii?Q?Z8uw61xrJIBdaNoPch3kEtejaG/bh6UpwB6R/wPwQZMW3Hhq0Q+NNMa1LQPo?=
 =?us-ascii?Q?/bzIGmYdZAVHctROrwrvypPxGpqEbx+xt2ZtqU4URhi6Y0jt1tHKElc8J5pe?=
 =?us-ascii?Q?eg5vIoMNIn1HGYdwIDuXrt0bjZEwbLPRQwW9Brs/4Nlxfbl7cxFTXkxNELhz?=
 =?us-ascii?Q?awLtMcPYoGJy6gap6M/1h1BOcthp7o4XNqQBpFlzMqUnipDIL4MQABupuMp9?=
 =?us-ascii?Q?KD0rNhdcADrt2tceI1oAos4UZ7liJTP4R6srcSUbu61JWGa6VdaxhYlkHIKC?=
 =?us-ascii?Q?m2k87BgAfX2nmF5GhS5+T3OQUffqvlnZCsa767eoxiah2X1zujBTpYnMuokM?=
 =?us-ascii?Q?ReJNXP7fj7NiwkUEwVvdsNZwxEBfqKRHbXmHb5kiRzeZ633v3VrEqvbKPKrn?=
 =?us-ascii?Q?GbsJStFev6XmGG9PwFU/IpPgo76gLciFOuqcFQdEImjmUr+0sjhRuvyS06Wd?=
 =?us-ascii?Q?XA/ZlmCN0KrqA8DKfzblOPJgPczekpUAK24Lcd6iSfLQmyL0Pu35fb9++CCT?=
 =?us-ascii?Q?otdOcF3etYMY+QHCBkwycybFX9TyMr1C0lBzhkg0DQnhp8D5XIhibT7KvlhU?=
 =?us-ascii?Q?aFMnzN2YxodAv7+dU52219zFDqZd80ZfZzhzGJnr74Xw+xQasQzNd17neNFK?=
 =?us-ascii?Q?6P2CsCLNJKFyrMT2TKFemv/LUik0tpgwfOzAzqtcF3Xx6B9YlrJBsVv/PUWA?=
 =?us-ascii?Q?7/B2sYKWx1NuKhYUOVCobOuEMb1qhH4BZEjFov0vGyRwVEuNMutN3A1nsOj2?=
 =?us-ascii?Q?knK0njfAUn94YQ/pBLooO522uli5vkjvA0af7Ahp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84857e50-2554-4fa6-952c-08dc656aaeb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 21:00:05.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epzWAmcHWwz4ee1TTFOs0QBVkdHJpvsgcOi1RFggXLwF6VqTUF9JtsYzQec19dhZPdaReNOgTgIbAgE41oia8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8637

Introduce the use of C11 standard _Generic in the fsl-edma driver for
handling different TCD field types. Improve code clarity and help
compiler optimization.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 61 +++++++++++++----------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index a73af4015d4f0..fc79276ca3b33 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -254,12 +254,11 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
 }
 
 #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
-(sizeof((_tcd)->__name) == sizeof(u64) ?				\
-	edma_readq(chan->edma, &(_tcd)->__name) :			\
-		((sizeof((_tcd)->__name) == sizeof(u32)) ?		\
-			edma_readl(chan->edma, &(_tcd)->__name) :	\
-			edma_readw(chan->edma, &(_tcd)->__name)		\
-		))
+_Generic(((_tcd)->__name),						\
+	__iomem __le64 : edma_readq(chan->edma, &(_tcd)->__name),		\
+	__iomem __le32 : edma_readl(chan->edma, &(_tcd)->__name),		\
+	__iomem __le16 : edma_readw(chan->edma, &(_tcd)->__name)		\
+	)
 
 #define edma_read_tcdreg(chan, __name)								\
 ((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?						\
@@ -267,23 +266,13 @@ static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
 	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd __iomem *)chan->tcd), __name)		\
 )
 
-#define edma_write_tcdreg_c(chan, _tcd, _val, __name)				\
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
+#define edma_write_tcdreg_c(chan, _tcd, _val, __name)					\
+_Generic((_tcd->__name),								\
+	__iomem __le64 : edma_writeq(chan->edma, (u64 __force)(_val), &_tcd->__name),	\
+	__iomem __le32 : edma_writel(chan->edma, (u32 __force)(_val), &_tcd->__name),	\
+	__iomem __le16 : edma_writew(chan->edma, (u16 __force)(_val), &_tcd->__name),	\
+	__iomem u8 : edma_writeb(chan->edma, _val, &_tcd->__name)			\
+	)
 
 #define edma_write_tcdreg(chan, val, __name)							   \
 do {												   \
@@ -324,9 +313,11 @@ do {	\
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
@@ -334,19 +325,11 @@ do {	\
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
+	__le64 : (_tcd)->_field = cpu_to_le64(_val),					\
+	__le32 : (_tcd)->_field = cpu_to_le32(_val),					\
+	__le16 : (_tcd)->_field = cpu_to_le16(_val)					\
+)
 
 #define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
 do {								\
-- 
2.34.1


