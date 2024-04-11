Return-Path: <dmaengine+bounces-1823-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406B58A2052
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 22:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6452833DD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC01863F;
	Thu, 11 Apr 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mozCfBQP"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5A10A1F;
	Thu, 11 Apr 2024 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867993; cv=fail; b=aovo7v2jY3AAeuXrJr9ddrs2cl1n6st/fobISKx9MaSyStggQMIlPNk3G5PxgbGi8Kerv5aZm4fR+CTk5Do10pURPk13+r31Azek42nxI8IYfWW8UX3mSpv8o5jZ7ph/W+HpTs9EpWj0+SUzFq0j8MX3XfaadFNTNthkIjRPy1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867993; c=relaxed/simple;
	bh=1SG0bsy20tt+zCVBP1of7Iaff6KZ4ZjuezgVf0oUwnI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EgSyJzIrjcpqsiXgBOwFz/GvrGXB11HgNCO3n/Kjeb9kSiJgmOMQPwoQhdR9DRiIfXKR0U9b5qRv0W1MSZXffc9ja7ZnFuf9gcBYu6GIU9ZX5jLyqKbL10cPdZPmReQug0oazzlrVQMdjYfzFj+euyrM8tPpfOosLjYpYe3OQSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mozCfBQP; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnvrbHXNAG/E6zagF4Ybpoy8xtAhsYMbTUkO4GSqPsJIbu/ymZJzsKyAQ0ZQSJgkIoprtFu2S9j7kO9OMD6ZKD9+1uvHciebm0OfgvrQDjgQCyOmrUGocJHVQCx7bCURLI7X5V4knGY1x0knvADl1dVSuc5StThFMB+9BAfnIjN6dgTUb+aFNAOs6VfBn9nnh1ojmudJHXqXjVW95+0V/wxRTEaITNNCq64TuKCNvzUpoqh7eqqKPOiWVQQacRcSxQ7yiBVgJ8A/e90uGigCXM9c3FVaSeUbZ+a9NlDjlYkX72EO4FQA1tIAYC7RReOv1tOHGxZ48p5drwpyMYs6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkmccOg8OksDogaLgy8mxAAKJEEugDBeayYla6B4qDY=;
 b=Y4ogIlYhN5fVjzcii8gLtHWU707Pu8lgIsSrJGDy9j6bN7RB/tVWFuCzzyVFwO0UbvFPxMHktXQ0haew6aRiWrJdQdCUq8xjEJSMwVQZxBuLDrGyXMQE+fnNpHqIWO/0Qm0n/gk5wGcJQNJ9reSnz9M0gLI4AI8UASPIbQS8h66EGFAcjWDDeOuBpGFTfvWkaQndO4nKdl8sJ/S1OGZem7MyBRTEzUWV7hGwg4djY4Ow7t6Zxaq1c1eRbUlluaa6vxoBxiQCyF4+j2p0AVnA+WidW+xl8zHpZO1ixHJ5quWFLUkKpgRm7aahCqew0B/2inPGbraSlWY5LMCyZ3mZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkmccOg8OksDogaLgy8mxAAKJEEugDBeayYla6B4qDY=;
 b=mozCfBQPipIPdMw4V4kKY8mfPWfMxk6Zt9r9n+6MTx6RByAWyKoCksEAuO87ZSeFGGvYJH8xj7J4XsFCf0lAfOfMZmvP+LNNdELOLwKVcLOQQaJ8ysZHTeOrAJlrm69CJjScIhPQUZMnkzgu2FxyjRYQ+QiGpL9Aht1XrmDCoZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 20:39:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 20:39:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] dmaengine: fsl-edma: fix miss mutex unlock at an error return path
Date: Thu, 11 Apr 2024 16:39:35 -0400
Message-Id: <20240411203935.3137158-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0179.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::9) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: df256812-52da-4021-f650-08dc5a678776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BvxXcopQedTgxpsW0Kpd9OlZdRJdgvmbwWhSl1A6tIEn4SLoKaaXuXz/jO7/0EkNmgUxPM4DQGIC5n/SJhegMZ1donDs4z4HycFG/sI4vzrRNlHmVjNDA56mLe0dDqUaDwMu8/P3CBT0ygh8MPthZgkYYoMAAKlv/I2IxMbIIxqscG2MhMtESoc1sjfy2HhTX9/7gNO45CgF0+7igYUzr3UMvekrplRINqwSPqYhib5Me7bPAMzSG2u6Cc3sVRRl/jjdBUIphudHXOaHnsAbnl9qC9FtvhUuDK5J/ZtGfgdci0FSEjyScf83KIwvzagL2E9n1t9v9T8zmyaD8NyzWZWzASGStXkYsgp5tlX95uQo/YBwxMc5o7cGYkgVND6IwBqiQk98oPwVexv2qSxr4eReUZBUKdRraWSyFKE05fpezi/C3RW2wYHu6hh1FXTUV3sUzyfsECjOCi/7Y9emBdhe506XBjMVN6tX5DI7Hz9UcYEIhPZhquHuiDNdTK9xO51S0XzouzxoF9MO8gxZHpohB0Okf2cG27WyYINCFOP79cWhnT6Vdx/LlSh2EhTx50KnO6fyU19Do7k2m6+sdy7KUkSam8RdjPTSSvTl3glfg9HaiRxxRpkWZhtiTrSVsCz2fXsrOaF84/VD44xHMw9nmpQcFwFH+gHFnko7gvGTcErXceEQxDTwxJxO1MRheMRPPZey54h8zJWWUhJ/kRPYZoNWjCaJT68PE1ubOoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DsUaj/G2RT4uaAN0g3A1z0A+DM1jwXUpNVH1hL1NyZj8nHEU4tdSjlN24qF9?=
 =?us-ascii?Q?bXkRlVkJacY/VtUffDbUc2YiEBZG559oMa8eutT9JRJl/t8+jnPDMN3LQbL4?=
 =?us-ascii?Q?Eis4+7HzjytaF/3ITyTizVJj4aeR7YW3SpcCh1AiaCyZLg8Essj2wKG14pfi?=
 =?us-ascii?Q?oFDGuKnVv5BAWm4fjIRWJNVwY5x6bEXKYB63lQafy01oIn3APrg6CzQ7vwoZ?=
 =?us-ascii?Q?Ow9t77r42loA5/c625Y3e5MwYs0YbjQBm1AAQP9kd9IMFYrdtJ+imKw7NJVL?=
 =?us-ascii?Q?kd41YmrbsqpSOE4auxVyfbTZFBN6U0XG2ZnbWcpRjNcoHCPyZimS7OSzEC5+?=
 =?us-ascii?Q?1jGmLyKOjoaz7vw0WCL51E/H2c9lZWS7BrbHLTwopZSiBB4ksQloqqetDh5/?=
 =?us-ascii?Q?2KUro4beZlKkw4l6qyZF+7Qxrb4Lw74seqC2X3FL/5gOe9yIOxFJnzIz0u9l?=
 =?us-ascii?Q?IsCJberfIHBeo1Pq0dDC9M7LKiSy0oUpG/JCb+IvmfLEhV+PNG7o8nWtkTfU?=
 =?us-ascii?Q?W3/SpLJAQKV2MrxyXTqM8Qn/4bYQOmn/6vks783Y7iAt3FeAxTgPp37niJj1?=
 =?us-ascii?Q?tnbapmz6ElPDXWhFNiFGi13+WMHXeptb3ycZA14N3VZ3R/x+jezF2uetOeVH?=
 =?us-ascii?Q?b7x9pBN0zqoHl4XcTqCDbD2m9Z3g5giq4CfmD0LO/nF4RfKax19ySc29zTvC?=
 =?us-ascii?Q?wYJ6b/M7MZZpcDO/9yQsTHXntvmTMB9dXJdxH4oWQ00p4JGudDBBbJuKChF/?=
 =?us-ascii?Q?1tCf0E4eGuAyaTFEl9PxR/9355s0BRrFEleF4cmA1YKkseU7lavy/LgnEO7x?=
 =?us-ascii?Q?BbIe9Pkz8qG6oxzF8HJEfpQ3Zp0Smp/RqpDw12zGWsPr0ng2txo4KyylRrjw?=
 =?us-ascii?Q?CR/EPaqs0kcfbAlm9xeIGE+o1TmPU+XOyFpnrWgkMDJ3hcyRDDhZKH7iKdUz?=
 =?us-ascii?Q?6QBBo2w7x525Ic8q2maXWl0CrbSPWtL0HtcQXqvcWvsstMWliYwnAUKprjBJ?=
 =?us-ascii?Q?taB01fQrfjonVtLhTdTv8eGpTwREzOkCbVDC7b2PG1KiW65JeFL06WiPes36?=
 =?us-ascii?Q?DcTCJh+4JhDFPzMGHrZW919QZA+2EsvUFtcndPyN/mcqSj7mS/c3x+7RNY3g?=
 =?us-ascii?Q?gCYorUD4KYgFN9YrzKiz++JH+exPhxqzsIe20vZBajdwty0VrDknwR6KqHFg?=
 =?us-ascii?Q?7R8nhHRYDk4lHynVp2sFtBkdc2iZSn4cltJRgtna/0uHvJqkVRpV0Iw1XN8H?=
 =?us-ascii?Q?gOxJGR6O/0Mv5n+DHZQwSjYhfLJPMZ20sV4z1HJVGGtb90p42Ljm/5wGjOJZ?=
 =?us-ascii?Q?XxQSqOEAFFDkSxr1AwMcBkUx4HvaYeSzXqyhEDZQAug4Oy9xAQVM8hlewih/?=
 =?us-ascii?Q?17wIENn2VB31kmIyNpAYezgppTyPs5TZbBb5D2HFafXnswYnxo33IqKR8KdC?=
 =?us-ascii?Q?gvqONkPzScCl7sM/wy7/V503rhHE3jvwdHoAGNPBjYXuHPwNA/EjwhidNGAt?=
 =?us-ascii?Q?svcaE3fXnABaG5hBpkftlypBnCg/Z+/Zyzjjl0T4AMvk/dY4pL58urP4jzBc?=
 =?us-ascii?Q?5vODAAQLZ77VoGrySCmPorxYaxT2kPY3T01MTvKl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df256812-52da-4021-f650-08dc5a678776
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 20:39:48.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUP8VzKLElJ3yPPBNh6szValDQ/W0omHvMUG21/ZE5TDcm6rjoHSRO4TheWQpXsRGCuUTQh5lcZu8mToi0wKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274

Use cleanup to manage mutex. Let compiler to do scope guard automatically.

Fixes: 6aa60f79e679 ("dmaengine: fsl-edma: add safety check for 'srcid'")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202404110915.riwV3ZAC-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 1 +
 drivers/dma/fsl-edma-main.c   | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index f9144b0154396..73628eac8aadc 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2013-2014 Freescale Semiconductor, Inc
 // Copyright (c) 2017 Sysam, Angelo Dureghello  <angelo@sysam.it>
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dmapool.h>
 #include <linux/module.h>
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 755a3dc3b0a78..de03148aed0b3 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -105,7 +105,8 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 2)
 		return NULL;
 
-	mutex_lock(&fsl_edma->fsl_edma_mutex);
+	guard(mutex)(&fsl_edma->fsl_edma_mutex);
+
 	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
 		if (chan->client_count)
 			continue;
@@ -124,12 +125,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 
 				fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid,
 						true);
-				mutex_unlock(&fsl_edma->fsl_edma_mutex);
 				return chan;
 			}
 		}
 	}
-	mutex_unlock(&fsl_edma->fsl_edma_mutex);
 	return NULL;
 }
 
-- 
2.34.1


