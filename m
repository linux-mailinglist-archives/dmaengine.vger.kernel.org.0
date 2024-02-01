Return-Path: <dmaengine+bounces-927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2284631B
	for <lists+dmaengine@lfdr.de>; Thu,  1 Feb 2024 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE35BB211FD
	for <lists+dmaengine@lfdr.de>; Thu,  1 Feb 2024 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215053F8D9;
	Thu,  1 Feb 2024 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQqCKMSM"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE43EA73;
	Thu,  1 Feb 2024 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825068; cv=fail; b=D3dFBwpHwRGYqPYjHyyzlKyQ6a6GTkDOX1R0Jh7aKYECM2l17vngxBq34pro92ow/CjlmZRo9cK6UyLkRxtbBmdYpR1SsFgLQBGgabAcKCJ2TvJDwPnWJWSOnKp/bR02+KeATCt1oFlQCI9vNh/x1km1ledy5UrZYPgLTFmzQxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825068; c=relaxed/simple;
	bh=1TThJiN4PltRkrVv+YmIJ3O/w0P7qRX1PDVF67zGONY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p9BgPZ8F1/31Qq0DeBQdKkmp8vd7DlV3KLR7rRnYWxuk6VUzNyd3VDKcCnvBMEP8tRaHkFWW3dxDvLoBC8GtBxDUGQNGeBnvQWOud4zwIXCBz6kF4PiwKq6VuQhOJzLCG6XpB/ftoCfcDs91buxDBcrzvW2GVF1g89yCgCFX0/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XQqCKMSM; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLoh+PpL+ZStr69aC3VpeCJCJle8CLNXjpHYOR1Pbsncus4c6+vzPHj8LPabQagQzQJAWvsbkAHC7elUqKJXqVbC6GIgbZJIXY57QRUjsbw2NT7CEYsTzWp54f+QsRauos90FPp/7L6CQlq6wga1Mbq+WncCUrfVhR/IlDdvYj1Z9HLv3Ye8REgDnvK9WMS6w5lmp68TOeFAz3ea3tdOmxATS9eUpYoMjRdV5Ri7T8PsZ6++Zv5K5J3Sf3hrkwD8ERYUv+oJbGCVVmqGpaGqF4+uhI2bfpDWQDSABvfONarO7va74sIJBl0GuEd6rLHb7QvoXhf4rjFMB8943t+P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSgNPz8CmIltSj3gDgNz2pVw039Oe834NuUVUrJvH24=;
 b=hdVV2k7q1w9RTicWS4wJEFMtZ7GTgMIkN4Agxj1TZMzqCvOtnUwmxh1HPrRpIg2BSbE4APCgZZ+HlUydoud7HlPMS4Qs3LeeKsxLkdIOTOxMohG1vcCALfDzE+N+7n/quFXQMqzt1MtbWW6cN5j/XX08qKElCqs64JaG4q8Usar/zHvkbM73+AE2DM/OrQJ+E0714H9vDifiMByb4IjO9NIVCxRm5QrREmoel7B/4XpE1ijK6OO6UzNKZsl0LXAfCs4rkHMJLb5hDS+15ar9WGPRpyGOnETkgkUwab6rVCxmD49pWj6Dn9o0okKS+2fEV94jhUIsQNel0Uqh+ztWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSgNPz8CmIltSj3gDgNz2pVw039Oe834NuUVUrJvH24=;
 b=XQqCKMSMDzvTzaAI6/zsM3xvMMGWgLomMpDKtqdNhUF23kFpF5NoXElhlzQQtliw+QBtwlS726kt66024P4BIF0wQUm0/kxiXL1gyr8bIKc1Zldnve1BRHd2j7dJTtWkCMlgS1P1vCJRh7KRgSjHujuXIXiuCsGiYrMLyfeEPLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 22:04:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 22:04:22 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Peng Ma <peng.ma@nxp.com>,
	Jiaheng Fan <jiaheng.fan@nxp.com>,
	Wen He <wen.he_1@nxp.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fsl-qdma: init irq after reg initialization
Date: Thu,  1 Feb 2024 17:04:06 -0500
Message-Id: <20240201220406.440145-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2514c916-e507-4301-899f-08dc2371bea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ROpOb96rL+X4rHs1ZZICU/TCK0JEFgy4Fz2mcjaLbT+Av9blJDSZQvqIVgb5PW6Ohm47tb4ZwBe4KwoVmsbz+G8crhMD/fo/gSnImQ5G/xsoVvHfUPe3RNXQUW9KXhU5nm6S1ARaCKSC6j1WDWFHBGUT0H8m8qKECCkSDIiv/XKUqg1Qp3M8wRi6xINKJ39gUa2UaRv2Hj/+nASBXjwQZvy4n6Mngptfm0qbx1pEXXTw8uhclFd18CcVRlFhk1e52Ww6C6mH/tDEq0ATxB9mHOF6xpKX14Cin5kiolvBYsrVV0MXCZ81ACLXOnOVywv30VWTjPMkybwloN23miDjweipxew4wSLDDFKi0poO89mloR34e5Qm6l3dmohT6MSInfiS922waTnD5afnBCLY74Ak84Dxesjh+cPDm+hidsaYhuCwivF6MpjBKj/uvx07wbiUV72n3g728yqlZZbEYEeOepz8mOfVBkKHCEdia+69F+duE3v1XgluKwqdH6wWr7k3qMNQNUeaqiUptcm4FmAdrht7ioORl8DQqv6FVUYq7cbm1SbKp/NWN+HKr2AucmtDOyVgM1T3vWl7+eRS0Wmg9uLXF2S+RDN4IApyUAJgLGsAxvAuDJBE8I5rdy9E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(316002)(66946007)(66556008)(2906002)(4326008)(8676002)(8936002)(36756003)(6512007)(38350700005)(86362001)(38100700002)(5660300002)(110136005)(83380400001)(26005)(1076003)(2616005)(6666004)(6486002)(6506007)(52116002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h7bX9YJEnkBAM3N36Q9cqvflYTj0JFh+X/toEEgilfZFusJ8GtBx70BY97Wb?=
 =?us-ascii?Q?zsCemUJgqL8dA5K8nz6rCU63/nZf3W21sN7zXyfur13MhMqQ/ZjwISKa+XC6?=
 =?us-ascii?Q?UhCQtIYESH8N4iFuK5d9uTUwHA3twB8QU0R5O37Xvb0CWX3IDN8SnGqDtsvi?=
 =?us-ascii?Q?p6T7R3xr0Usu5wXeTwhnxjm2DhtRN4eWleWWvLFGY1C9TFYYOw0d3CIHNDEl?=
 =?us-ascii?Q?msgcJuCVcstXn9Ug5rnCqtnbhgV+jhjU4EQDlIy0paYUHlFNtzEKQ/NVO0dB?=
 =?us-ascii?Q?rxAnNaAf6FlLOF5HDfpOaNVKG3bSQtWjCEhX9K51RD2kYS47ndESY1VG6B5k?=
 =?us-ascii?Q?xSNUgNuTc1pOem2wFANNQWYzfe0pAuOB0cbdU5R1oLZO52Kcs5B7z6I/O8cp?=
 =?us-ascii?Q?4av6dKuTRDdyXZgzdPSC11eT757GsLBEnptVR3qAnA29VQrefCDrckc6po8k?=
 =?us-ascii?Q?o+hTAUZ58wlJwaqipsIQYM1GRlYBYSjMlULw6r1Y0h0GFM7mSZN5mJOpSsR4?=
 =?us-ascii?Q?CgEze28x6J19xWO9zkivb0MqFVKeKfr4gef4IljvPOtzCdD8NxWGvPa1Z33s?=
 =?us-ascii?Q?KGsFaW8uLera/FpFue2orIJnAC4ehtYRg93dkiYW610oRx9IO9i1OOx9znAv?=
 =?us-ascii?Q?JhFKgv3hW7fx7GpZy08S/FwX7M3uYNZEWxJzGTiTTcZTUvhXp35ng4KM82ox?=
 =?us-ascii?Q?tQLQMqGNoMtSbVunOukhAmCO0Z9w9g/PaqrSbnlIchVenE+uUuuFK4vurgAW?=
 =?us-ascii?Q?3sE0AxUN0QlF33g+jug4dagJdonMmEj1/QXzQT8MPk8THDPlNHT+erhZK+BA?=
 =?us-ascii?Q?g5obPZXiiHZ2YF2sYX0W9gAmWfw22q4FxF3H6fdJE1wD1s2q1fnNluJRIrko?=
 =?us-ascii?Q?ND3PSoKS0/nZe4dUxY3Kzkg/fZyc0pm4FuoT/ZsAWLQkTxe3pzyVpfhCiMTF?=
 =?us-ascii?Q?WEjQPUZfQDmbw/kxrOgfzSA1A0enron/jZQ2DkBenEmIliUNj6zxfdgA3RSA?=
 =?us-ascii?Q?v9XCMAdcT2vtlwOqrOK/zMGQVquK4V7R+zw9uv3jBlhhXUd4jLLE8Vdrb0zc?=
 =?us-ascii?Q?yTVg33FAqchaodfTXlyTwqda76Vy4WAcwBeKvaDxWbGSl2WKmdWDcul572sm?=
 =?us-ascii?Q?myS3bxBhG7vGjttL1NbRQl7tkc+2kovfce2+FAedfuV3qU5hNCbywSADjYOa?=
 =?us-ascii?Q?g8RB8Ow7BalBhesJ7jvgMgV7+Qj9Zw7N9mdvKCp5XMqFR5N1DACZgengBFIR?=
 =?us-ascii?Q?eMbOGCZCOxdYQD/rqxgM9g3iJ8NriAViCJhn1+GKDoQQrldTiPuZFphHI1EF?=
 =?us-ascii?Q?rhitecvAU3/Vxw+ycKFMH1p+pBFCPOPLnX2FuzRgiNXYUp6TPVRtsJib/rwy?=
 =?us-ascii?Q?8p23xaag75DFuf1CzwkOSHOfBp6dIFY2+/JQSmgWcJnNFVbz7SnvuADw9TQr?=
 =?us-ascii?Q?0CYORbBokwvZRi86YUyw0sOY8bQDDD8/+4rfPupyKZO6DngHrEGipUJVbz8z?=
 =?us-ascii?Q?C5OTtT/rE99xlWILaYZ8Ubp6ob3rsbm3vyMVchV4/cW/G+AE3Du4yZt+APeR?=
 =?us-ascii?Q?muPbL06XutExT5hmU1OdvtFRFotxECNx6s8nqjl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2514c916-e507-4301-899f-08dc2371bea6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:04:22.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZZmF3kgbHzommMiJSqbaIC5hsDNzlkBIDIUIp6ZlD02gd7N52fLulkRWVUJSaaaehXYBps+hMAF7NR7VEgckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763

From: Curtis Klein <curtis.klein@hpe.com>

Initialize the qDMA irqs after the registers are configured so that
interrupts that may have been pending from a primary kernel don't get
processed by the irq handler before it is ready to and cause panic with
the following trace:

  Call trace:
   fsl_qdma_queue_handler+0xf8/0x3e8
   __handle_irq_event_percpu+0x78/0x2b0
   handle_irq_event_percpu+0x1c/0x68
   handle_irq_event+0x44/0x78
   handle_fasteoi_irq+0xc8/0x178
   generic_handle_irq+0x24/0x38
   __handle_domain_irq+0x90/0x100
   gic_handle_irq+0x5c/0xb8
   el1_irq+0xb8/0x180
   _raw_spin_unlock_irqrestore+0x14/0x40
   __setup_irq+0x4bc/0x798
   request_threaded_irq+0xd8/0x190
   devm_request_threaded_irq+0x74/0xe8
   fsl_qdma_probe+0x4d4/0xca8
   platform_drv_probe+0x50/0xa0
   really_probe+0xe0/0x3f8
   driver_probe_device+0x64/0x130
   device_driver_attach+0x6c/0x78
   __driver_attach+0xbc/0x158
   bus_for_each_dev+0x5c/0x98
   driver_attach+0x20/0x28
   bus_add_driver+0x158/0x220
   driver_register+0x60/0x110
   __platform_driver_register+0x44/0x50
   fsl_qdma_driver_init+0x18/0x20
   do_one_initcall+0x48/0x258
   kernel_init_freeable+0x1a4/0x23c
   kernel_init+0x10/0xf8
   ret_from_fork+0x10/0x18

Cc: stable@vger.kernel.org
Fixes: b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs")
Signed-off-by: Curtis Klein <curtis.klein@hpe.com>
Signed-off-by: Yi Zhao <yi.zhao@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-qdma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 11d10dcd8b45d..af7a86a3384ac 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1199,10 +1199,6 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	if (!fsl_qdma->queue)
 		return -ENOMEM;
 
-	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
-	if (ret)
-		return ret;
-
 	fsl_qdma->irq_base = platform_get_irq_byname(pdev, "qdma-queue0");
 	if (fsl_qdma->irq_base < 0)
 		return fsl_qdma->irq_base;
@@ -1241,16 +1237,19 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-	ret = dma_async_device_register(&fsl_qdma->dma_dev);
+	ret = fsl_qdma_reg_init(fsl_qdma);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register NXP Layerscape qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
 		return ret;
 	}
 
-	ret = fsl_qdma_reg_init(fsl_qdma);
+	ret = fsl_qdma_irq_init(pdev, fsl_qdma);
+	if (ret)
+		return ret;
+
+	ret = dma_async_device_register(&fsl_qdma->dma_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't Initialize the qDMA engine.\n");
+		dev_err(&pdev->dev, "Can't register NXP Layerscape qDMA engine.\n");
 		return ret;
 	}
 
-- 
2.34.1


