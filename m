Return-Path: <dmaengine+bounces-4593-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD36A49204
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 08:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D0C3B4394
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952F1C3C1D;
	Fri, 28 Feb 2025 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GyNZqINP"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B9276D12;
	Fri, 28 Feb 2025 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727108; cv=fail; b=R33uSb730HCJtwRXdmmz2uuv85wJ5HYEilE1tD8ah/hJ/p+jL6R0gkyTIxo4CG3OBD6x4AktHlz8yb9hWD4yb5iUuhmsCC8jizG7QJhaE0sz6p5xsrkNr3k1rQRqDR/tU/y7f27Xqod9s1jAWTA9k/O50xkknK7LFiy5PX2M0zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727108; c=relaxed/simple;
	bh=YYMxUWKJCZ5vn7scW6G7tPKpsyyj9kl7xXyGX32xtAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hde46G68ykgXh4rBwPg/JnjB7mayBsHxAN6f+CTsJbai/RbrBD8EYMQqij0HFOXtU5rV8WooRRT1yHb5xqhoV/uIodPKMxK5ox2wRd8hpr0UMKLykaRN976MenYKTWIb8ml+8bR8H69bT3B+Ok0lWQocN58xhJ6zb8bZkjKkvI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GyNZqINP; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKnvVLu+vEtCMNQJaIaXrdu4hTzdDUFc8+/CVgZhIR7eKVl8r/cxVF7sqCmzRGw1Eq1aVVp+6ReLCUYq42zsY6CkRWCaC6XLdD/88882BttaA0fUT+3RTGOLM/9EQ4mQxsrCF/DkKbrlCZTe4i3XLR1TSlCV2DoECHpyZlOoXcmW5skeoFGchqseLYGg69lj/aTUd/v1hpL1Qy92xgABsMtlYx3zuuppbKBZrfoMzB2uJN5bZhUdr/cw16b9VKXgVxyoJD2D4knC4lELgSV6bgiwo1xRDiga+SkYILnYV4HJnASAOiygpW5MhMocRfqXojF5wTshhLv6cfWTFutXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlIYcCBH/bNJp0ufj+/bA0t11S4KBsNYXHuzaBvJ4/w=;
 b=IZWxQ0mXwIYd7R1J1+YNjCJL7Fy8cW/5/6l/m7y2VOr7BQIJSCPElbyATs71alr9nQWzIWCUGrmChs19HF3+3KAdcBfW7rG2n516CE6akSXgPPlWUcf0Ye82hJniCjXmAmvd5dCAeZGZow8xlQ546Gbu4E6ZupQ9GSkCzX96U4Z9460QnXe/MMrYKLQMFWLIsSevJFeWUrkKfeGkBW0d5h/UU9+N4buu7E4kFCSV6GnhtClpnoxI4rrE24qWqi4GOAvPFeIOCWV/E3SALvn7wZRLA585lD02QgEWOzLLoaKhDYIaojhQ4IhxF1kXD0JoP0UUwJ+OJsQHy9dcoI6X3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlIYcCBH/bNJp0ufj+/bA0t11S4KBsNYXHuzaBvJ4/w=;
 b=GyNZqINPBtcJk09cg8gNUGTxsyPl8xrZ9AzWOF7DgJTbRKTkr5KEWfD6Xzep11FlbrNjORLNm0sgWaVsBW56Dt2vK7c1ln4WhoI7P3l1QhZPFFwOifcC5cI8qlVWyHpV8AjTvVc5G+CLjirXNGRKYRWhUNkefDXJA5NYMQbVCMZgj487/Q4o6kMip0e0KQdnFf1yOuocNqp6lpSPg6We73GY8c5obKDmkt7ajrrtrHretoQzXdDy2VbNqgvueMVyU3h70j8GFH5kn7NxFgvs9naB9q3r1z2oafkPLwPGvaxN3fZ4YJ0ZJLue/FUVbbwbLnUurm9S+qUlujbJdRR6LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8511.eurprd04.prod.outlook.com (2603:10a6:102:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 07:18:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Fri, 28 Feb 2025
 07:18:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 RESEND 1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
Date: Fri, 28 Feb 2025 15:17:19 +0800
Message-Id: <20250228071720.3780479-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 98da5dbe-000d-4062-c840-08dd57c815c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkIkYq4SR9h46FFRnZy5k48sIVoB/tK+x5maaqY1mcq8adATSXHdgCxi6nAC?=
 =?us-ascii?Q?UttNZyc2Ql91cc+TyXXSVQaA9ZlNVE7Kmg5bVg6GClBM43cn5s7NNlgdhFrA?=
 =?us-ascii?Q?ael2BuyA5eRx5oCj+n3aae14tEcBBms1rSaCoY7pPOtag21XTEs5REtUS/Mw?=
 =?us-ascii?Q?4kRaq7XM79RDy212EfFwNhiYrr8VBv9dU/mlBv4a+IKKXPnWQBC7SJjGq6Vi?=
 =?us-ascii?Q?wkeutFrEz+EzPSnz9um9ahd4vYfd4/uPQPjF/NaJKaOOzQerb0irt5BaggeB?=
 =?us-ascii?Q?wd38/5OiPhWt/Oa1py1cFNqQV226ytiAuRCehFJ6F4Aogp3oLgI1GUrMa9pZ?=
 =?us-ascii?Q?yY9XiGJktLIQYa/tbV4u5P6NyrlePlmsDhGzjcEqKXBWCTreFSMP9KVPFJdP?=
 =?us-ascii?Q?7BY1qNT1SDhDYxxV/MNeKH7ydfOsWIFls50SMxVutWEWmO7SZJcyDwJjsu0x?=
 =?us-ascii?Q?VX8M2m5B5I3ItBlW/esQiE2JwOEFNAgjHRVQP29bcaObjqXn6cjonQGcWdAm?=
 =?us-ascii?Q?waieSl0rMZxkzmuudVOhFlYJI4SkhOQQ1RVdUBkf6Kt+BeTfVwIRjJwbfX9+?=
 =?us-ascii?Q?Jfra1Ja9onKEox72XrJ4NCRFItNdk6hLDQEnIfuu5VLeLGHuqqig9Ozq42rc?=
 =?us-ascii?Q?T+OlwL8fSov+/Lbo7asQpb8FMNu1wjwxDY/7afLyST2Dnbtgt5s34V48VzTd?=
 =?us-ascii?Q?+g4zWGgcuf/d8cPyCF8rAh2YaIFNNxdskh/ac78oz5uVKK+jMjwZtNTz/FbF?=
 =?us-ascii?Q?RHTMxpY5FuDKPVJFfqc7ZwNqV5qc2Cr01wqyfWHd4ysYzJrv6O3vlOKIyWJa?=
 =?us-ascii?Q?KccBJ59op2YT/2LIHh5SxyizXLbPCbZn0DIkGS1GxYtW899sMdMM+eAgTdud?=
 =?us-ascii?Q?W+sSLkWsAMz0oRi3q/RGUzzNRq9Mh0hLapTjPO0tVHxgv7X/I9cLTAM/25Mx?=
 =?us-ascii?Q?atO/MUiKwDMkU/rXP2IXKaQGkZ5f+X0IBbJL96P7uVMyo0ew1m03hDR4ToNC?=
 =?us-ascii?Q?Rl5XPgpmO4JN6p0xVuiY5uALOFRuOBSoZ9LNUpOiYTGKwDe0qf4v1L1qu615?=
 =?us-ascii?Q?De6Bqj+raBbBBYLaGBAZ4Rb4snY9Pl/PUoi7EFAE6LtKPs1P7yBPSir9+MQ8?=
 =?us-ascii?Q?wiRykCIwfSzmfov8H1dOBQq762rhxXW+0S7Ale51iiTLDYgA4fUu4pZlcpn1?=
 =?us-ascii?Q?XqpgSAYjyO2+8p0HEYijnIo7eWAx3V2DgpL4zpcCFdV5BJjWLSMWRDJqZ3Bh?=
 =?us-ascii?Q?Hbx+i3bOZJHWPt8y/AM0hShzLO3Jvb2Xf68XX7OZ9FdgCbvQPfMp81cs0Y1Z?=
 =?us-ascii?Q?dU4eM2wJVIrVxWS4FjSo0IXLIu+az/Z3swTH+dWUZMZwVmPaJ1D/vmFaZjJE?=
 =?us-ascii?Q?m8X5rDydq1gp0LqakGCgYljRJpcI5AZw86CsPIXLMuHB2OSTGxwWqZmVvah+?=
 =?us-ascii?Q?kjZntqNyEoCuD4dfWTsN3oOZHbvqjE7G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IirA6fiTSEiQhMOOF1jjhu5VxK6RUHfTqo5KUp0rV4Y20J+EmxuHvsJf1QpB?=
 =?us-ascii?Q?EXUfds9RS1zzu7ibQm4qGf6u3Qd53I33cn0KrOqrFRavm6X1p7dzP0sYZNdP?=
 =?us-ascii?Q?fq5NBSycxHr5wevgwaPUNgyn9OtUwKCF1lSFN3FVGLXB5sKoreXnBx6r7nTw?=
 =?us-ascii?Q?VjOsuYQUCPfEiVw+IfaPQY96i953ir6ilppff11QnJjfz3y1ZD97CqHaW1Fq?=
 =?us-ascii?Q?oTZspq7u6Vnmxq2m/+VPDamn/9DOXestWUN+6NkqfZ+osv27OBklL3a8h7P2?=
 =?us-ascii?Q?IsK23iN1IiVZAeoeJwHlZfp+0UbvyjTRvDoJw5MtxqGTjWtUbBugEfxgdBFD?=
 =?us-ascii?Q?ve8/Tt/Z8XhfVIUSSaNmh7AosfEO9xg0HQQDfXW1g9gr3eHWz2wJQbs4hmxR?=
 =?us-ascii?Q?6f/ypsSQprk54bGunVgfUewsEY+TsZ+1Hl/472n1MzdGLvEkg/5qyFvCF4xA?=
 =?us-ascii?Q?r1xRtSfDoFI+z9yU2KMB8gDzHz2f/X3ecr0vC2jb6Vw/AqKSsmyDXr4wQy9T?=
 =?us-ascii?Q?gOdDFgsFrpZjP+mKr0KkXfBgZLQiKxOUUzpO44Zn9OP0Fcb2Q5Ff0EUEloig?=
 =?us-ascii?Q?/sRiw76nbSsOHnCVQZVF2wto0N1J83HakpjBbe4hN4uXCNgoOGgMZhW142C9?=
 =?us-ascii?Q?ezpQgmBGH8q6UpvbNJYLQCX38BQwSrStbolWBEwqhDzCyJME2Li5QzsouQrY?=
 =?us-ascii?Q?p4ATWMAoR1WQLXoAIRHFDNOIaZlEMyvu3/odTzmxTPSA0dHBajjUMqaVyF+Q?=
 =?us-ascii?Q?eC/mgCriEGHvVY+yQRszpblQew7gnIVUr5BsHdGlvTeBsfMPAIUfA4NuZ2mr?=
 =?us-ascii?Q?TTtZrFg9YGo86vLeUb8ptPZSX4N7VALxS5l8DzfZbkZYIQBpcwy4YYcdpOeJ?=
 =?us-ascii?Q?vKOr+5EQpKpWOPeQnB5hXhjhGnWLfzqXRxgMbDkdYuh8eqcbD8cPLuigEBqL?=
 =?us-ascii?Q?GEjH4QlPUzjcEKkbZZPTyDUlCE8i2G/cKDG0VXavRh1o8J83qlLLihtZIce+?=
 =?us-ascii?Q?V4dAlFdNgM7t64BWc0vv2foLMkm8ih5ao8ThY3Y2fylhVsmobwH3pVRCY4zt?=
 =?us-ascii?Q?KciP5dxAhvi0Z+kMDpKjPa+BTTq9Z1SxJ8/Cs/aRU7z3czA5AJaaeoDV9AfX?=
 =?us-ascii?Q?lxVPE7tVYahanxDps+519ILv4IJM3U2eFb8CGUInCYkDWCHcQvJjT+Y5YY8P?=
 =?us-ascii?Q?FD8O0ft6Hx7P2GNl2iCpoU/EbjQeUJn5FqparedQlffwxyHllzr2eMA8tc4B?=
 =?us-ascii?Q?cvWPS0Z9a1RhYU7vjaJpP4fb+o8sZ3b67WtLDKuxlvjmEcMlJDYtfdR5tlQL?=
 =?us-ascii?Q?mLyOovgjQxcGgZGhpldPwJ+4Qqpq1yKAW6Q+ghL1Eevx3xPHuJay9KdyX34T?=
 =?us-ascii?Q?+dm1XShK9IpRln2GW/uKM4V9n1UV9OJzEl5cKzEzQrGo/Cr3DErJ9sjqsXal?=
 =?us-ascii?Q?IRqmIBM9S79wSUhgjiTDNddZCNL3+icXgPqowkFrNlmMgIiscKRGPcr+Lk3z?=
 =?us-ascii?Q?pwBDJJNyfffku9/RuGsI1QFw1d3V6Ui9eEm7bhAQ28gLc0C5dx2QwIUpsNMJ?=
 =?us-ascii?Q?hYpkUE+160N2Fah4sJkJjfDbbt3HoltfQqC4qtXt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98da5dbe-000d-4062-c840-08dd57c815c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:18:23.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0LibMGvMILOmXm0EZhqNtmQ/xxz+421T+50lvWs6hIErapTUbuI8ppnYmDboBnBYITp8Mc0f7gP8YISINpPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8511

From: Peng Fan <peng.fan@nxp.com>

There is kernel dump when do module test:
sysfs: cannot create duplicate filename
/devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0
 __dma_async_device_channel_register+0x128/0x19c
 dma_async_device_register+0x150/0x454
 fsl_edma_probe+0x6cc/0x8a0
 platform_probe+0x68/0xc8

fsl_edma_cleanup_vchan will unlink vchan.chan.device_node, while
dma_async_device_unregister  needs the link to do
__dma_async_device_channel_unregister. So need move fsl_edma_cleanup_vchan
after dma_async_device_unregister to make sure channel could be freed.

So clean up chan after dma_async_device_unregister to address this.

Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 None
V3:
 Add R-b
V2:
 Update commit log

 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 760c9e3e374c..7eb4d898434b 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -802,9 +802,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
+	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }
 
-- 
2.37.1


