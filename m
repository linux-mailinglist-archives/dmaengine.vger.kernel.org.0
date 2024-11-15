Return-Path: <dmaengine+bounces-3737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6D9CDD14
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 11:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B791F226F4
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB61B4F0A;
	Fri, 15 Nov 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MPEUwo3p"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47339136338;
	Fri, 15 Nov 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668221; cv=fail; b=UaE5F59ZEjriACz0UcfiQfo1iCz5t64wIuHJb2RE06s9oio6YkLGBG1g/aARB71UdYFmL07Tn1uWfZQV0ujdE0lXwFojE4diy0TkmarzEl5eqwGrbFA97ZxyKK1R6+hUbbjDNw3FCEopdoWql6jD8aBfUXUaJdBS+DSq5S1Ndjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668221; c=relaxed/simple;
	bh=idej7V0ylHHgdF9SsDu3wLBwFBwH6tLD3x2Wy6eJkac=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ky1gf5myTXOTJGWEVmnHPH+2oucJ1/f5cw7CEFg/QJbF7By4FaZ0IAozUmwR1R8wVH3DBCHci7mMXNHuliFSYOtlRAkN0bVCy3njbFiAmgSBIf6yawLleafhnGFdcYVl4XGlh8kJgAwUMeAIj8DsT5RbxDD2NnyD1ThoyASXDi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MPEUwo3p; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtzZjv9sPjk0Ud66KYfVRiwDSgECpzSyIWQjuIaVR89g2A4iTj9HxDKj+nC4wyjlkoyo+YpTUVKk4uthGtaFnrYJWhGnkl7oIqw3fk01ZXgEIjv8eEmbfpj2zXgePLMA8U8ejSaE5LasCUOykB8StqIdI/eyYM4aiRbPL3lXEKs+N6OaAOoDV7NzId2wVGVvA96pEYqWUU1vp7Sde0sR6A3TXc0lczUwubTC+aJx6BBl3b3c3rMjS0Qw2nfsM3LGAWjXSyFI9I6F6ebhkcecumCGd6OTBCkdMHamN6h1j8YdyjUDYrvlYm1/Tygy4FrMFGy9N07nBZNnZnhaGvIdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1KV7aI61MGC2nTtRCRB5TVlCBfpV4dZUl6F9lJX2ok=;
 b=YNFMiTFGurRRkea3mAY7Ztbp5SxCn/WKaIiPqtYdYAA3M9z67uD0vHP14B5wJ/4rwh/Hgiq77ANEa9w7MEjOmL3czCvM/G47zs9SJKlLiMHOEA7CgOCma1zPYd/D8d9jjOAu2OQJIHeTmgUoX+dIj3Nw5prMs8lEhbD8zZQ5rIqplm5JacTA15OZSeag/msGwmEoW6PVZXUguPUyGakumdPRssr7UWA/z0dUtTfWgpkH3yEztcyJvS6VbMnrJh995CaJ/HNT9h9oW/JOCNpj/ZZrqopsDP8/ctZNXWbe58R9SGz+BXGB1NqC6csZ+IhFZr9aDYr+ou18j2+1J8Lh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1KV7aI61MGC2nTtRCRB5TVlCBfpV4dZUl6F9lJX2ok=;
 b=MPEUwo3p5PV0eq510CLxVpQgclezswbIWZSD9uvtT1/2ffujxApeMjK2OgNw/2Hx9PRymRxUxoL4shtN1cEXi8eXiFvRWo/zhkydya2iIXysL9m1y6TyG/c81f4Lom2ST1NuCNPGNXxSUk7RTMaRI6JwOV7CU/5GXuq3LOC87QgwKfp1lyUR13NevwLm0JB8nZoqu8kHb5dqju7Joo2j+Vs9Llqp2gkw8ejTK8CaTncvWgnzzV6b36YKyZdYCGUkibR5ShnG+aqRnPFg2ezhWBBB0VyJUUIYF4Zv6d5nMDNL/Al1WVfzlq47FcW9cj3SgMCbfsby10srSKbFLX+Yxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:56:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:56:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
Date: Fri, 15 Nov 2024 18:56:28 +0800
Message-Id: <20241115105629.748390-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f9031d-d241-435b-f3ed-08dd05643814
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbd//TdgQa4EfgyLo3zC5ERtfev214c7uB0t9FfoU9LiyiK3pBnVJnS9q8fv?=
 =?us-ascii?Q?Te9ZD5oX4AmrFSXLtefVoR4C7z3sYLhFYyuooyr48ZuVoNAtJqqesdBxHPed?=
 =?us-ascii?Q?vIqrJYPYnnXh+QgOqBlvviVO6uhVUBumazCph8JfVwqBeQhOpSaKzIhXb4Zf?=
 =?us-ascii?Q?8C6asH+gsXOFN8hLAjpXNlpps/Oa5QKDo5b8dqSBEjSKeoCCoC6ZosXLXV15?=
 =?us-ascii?Q?ior1XHLMYQeCjYnbVRKwqe0vQ/0fmgr5nFmGNU9E8isYXAlRtTWxqE+GWo8T?=
 =?us-ascii?Q?5ZQU+nERIIMku4LiiFjn8QGiDMnM6BcPW6xTNhYY61iQkNQDII7DX/gJ74de?=
 =?us-ascii?Q?+22Kpsy90emmTTW8gblVBIcKRv0QlzLQUo0OHGGohkVCElVgrS5Y3IBF9GdJ?=
 =?us-ascii?Q?YTxb0adL9AOF9hxClBbWjNRl4EKsFFtuFqqKrtNScVB0qaGFzuFBMQl2NsCK?=
 =?us-ascii?Q?A6sx72I+ZOHrtQNxowIBTp/Vs8InYIaiqyoThcMmvEO+hBIdljBksNla6xD2?=
 =?us-ascii?Q?3KZqryY846f1pGo2br2GXAwKWEBdA9FFV9jeQdsW+RI1I55cZpTsGjch5a3V?=
 =?us-ascii?Q?dwO27fdb/cWuUzgS3Xmz7z2Dx20A+gyZePl6TBo40PVxYuSq+3Xp/R89CiB8?=
 =?us-ascii?Q?e+0/+hSIDQQITgZ0yRbULQ7njFoW0+CWSHefs8435Aiw58yynxi0W6hGK4LH?=
 =?us-ascii?Q?n3D+qv+eaDBSid04nGyL19OcpPub9TEFwL069/Yyb6DvntPembOkwm2n6XGN?=
 =?us-ascii?Q?1Z2Su38KOhDfm9NXYE+3IqUnO2NJpLfAEGnTFqbh9ABHd/maV0XXvLpWxheZ?=
 =?us-ascii?Q?x2L6Xc7u9IXdS1yT+i4uJwrYLmIJZxaola3+uOdycGw4EN7lIfx1CYN6Cqxx?=
 =?us-ascii?Q?GY0dZkwjxR3/s+vRAsfj8I/VFGIhgzyeN+2nEsUaHgHU9XaAzPiq5JQ7IGZm?=
 =?us-ascii?Q?FPwG9xsFRzPgD2KP36G7kXhwqGAZwHJbJYo2xoDYgnmSpJNzCwJi57J+irHb?=
 =?us-ascii?Q?PpiTkmEXkzRr9xf/GoHXU1JbQTW084os3qV8zyYohLsEQSjoSZ3NFQC+h8cX?=
 =?us-ascii?Q?HuzKzHHTgeyvM4JXRIrpQHNJRFnYq7D72h9bSOarUDwMHrqS0HLUk/+cw7Am?=
 =?us-ascii?Q?msFTkDteudL4ZfAyo2RI8KzUvJTeYkk3bu9BHHL2pkY0Smt4rmSGim8gKaiF?=
 =?us-ascii?Q?VsUQQ9S8OnZgOUJ3zvO4kVMZlzP3Q3+QdpYQxP1lqFMkGfVvEB6HKVI4iXj0?=
 =?us-ascii?Q?iQfYbqSxyktcgHakCWAT5Gjf02klG6YwHUYy7XxKX5VyVaVb8SR4Y/regxNU?=
 =?us-ascii?Q?ZZLK0hzsRgdQOVHbgbI8kCzcLFtNVxDM6IE9Eod/CIy3f+MvJD8tT2McmKKb?=
 =?us-ascii?Q?JJ7rR/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7oHRWrUwS+bNQnrMACQfG8GScQcW+CkNvub8kLZ+z4cgpQw2HXcgnU1ZIFEA?=
 =?us-ascii?Q?GbX4jGQtHU+/TVhSRQa3EHAbUekuYfopEkDzuoDWy3K1VgfwbEZfACETbdm+?=
 =?us-ascii?Q?XLAPZigsU6bHX+/SzlM/ADvNDRlDIpHs/32fFeVwyF5LSd5NP6+ANNkLMELR?=
 =?us-ascii?Q?osMMajF0czRhXHN93XnNC3+VNIwMZPL+tVqO/+QtklwGN++WNkqsIaI5VOpE?=
 =?us-ascii?Q?ZK8ilhyubMu59G9k3FgnLHeev0ksrIai77Je6I1ND5oqZXsIsKjgNF7XLcr7?=
 =?us-ascii?Q?tu98h86O7ox8eONT1WDI+KWd1CCcYobjeiH5U7oGS1PVK2ZHAbQURtMXrNE5?=
 =?us-ascii?Q?yQEzM+6ikJl3ZYxy4iEaEjcC6D5hKpLwaKXvDcKNaAN3Wv/PcPXOd6k0GLi9?=
 =?us-ascii?Q?Ds2HvxS9ljqa+44+DV35GlzfltAhfmqg23LixEP38WNHO7Wyw5EjEckICxex?=
 =?us-ascii?Q?AP6QAgEC/EEfakuNCws5YnGdCdsXv2MYbGrYDrKrnWNUbXq7afBY/Y4iS9Cu?=
 =?us-ascii?Q?X2vBBmiEawmQ1HzgZLsLeklnTRO8y6f53QBsP/Ggrd6ZJY4bgrZbvQiYvp/U?=
 =?us-ascii?Q?3eB7O+DgI2g1mkSWvhikALHsbZ22ENGUmIkXB9zpYhPLa1/pGZ2S/oR+87pb?=
 =?us-ascii?Q?imCu0kHBfDy1lWUrNIyDfLrKUOBLLGGtRXFr9iTJLCiLzV34Ol3ztFl2nFw3?=
 =?us-ascii?Q?wH8a4CeyCaFVIJq0mMnrXjV3FVDFYKbnM+6hfE1zr14jTF+mIvb32ND9Wla1?=
 =?us-ascii?Q?OBLuIgtnD4Qthe0YBbrWloqQd6tf927VkUMyruM+jieyHnMdvBjzUB9SMMIH?=
 =?us-ascii?Q?ylJ4Lih0QGk9Zp8nK8pJKmHVgtZKLBA0AqV7kAl7wkRPbOpqGzcG0o0EWrDm?=
 =?us-ascii?Q?UkSzmvD37ZI82bvckCnDe7JuAQ9tHYdBq9HrKnPKHjz28TniO9OiuCvlfveF?=
 =?us-ascii?Q?+3B9+3TT3h/UYMWRA2cjx/oyChUpXRo/WS869wA580hOvZy9XsEyiivojN+C?=
 =?us-ascii?Q?jud+ZNdz7mynIcSLXUEt98M1yEI1PWoIcZSm863EQFFTMuWBwMJofG1/Z+Xj?=
 =?us-ascii?Q?ccQulMI2klAE82YwuKLekVnf/vQefZF9/80DIlLrUj3GvdfOImIlZIfOH+VH?=
 =?us-ascii?Q?w6QEOy0lCW5EIhxLNwKvI+f3zpEN1go2mEsX1QDu7qz1ktR7EnhelcqT0pr/?=
 =?us-ascii?Q?NoTY/3u1hHNcKBQ8COqGDO6AWrxM5eDc+i4zRliHpgCf+c3VwqvIGSAfOX+7?=
 =?us-ascii?Q?XwBaZURpkgR4JXuzvAFoc408WXvtQ58f5MMtD1dHpsQ1nbbdKYdzQuyGkLMg?=
 =?us-ascii?Q?sgZsBjbkPNnMzXQp8a6myf5xisigiKgAcpb85LNc/YDMxUlRjPkX9KhJ/lEC?=
 =?us-ascii?Q?WR2yBAxaYRkqNbZwmC6Hgn6ynMlNRhEg/YSVBfF8kp4frqHF8VnYr9+91ZFR?=
 =?us-ascii?Q?oYcX87w/CYiwIz/pA0MvFCb8IA0MGjFaNjOolUapCdncHvicy5jotKWcQT+P?=
 =?us-ascii?Q?GihhDxXxS8vcwA0JwgP0SSwNCh2GtJYKnqqAZHbndvG7WR9TM8a6e7thX+3L?=
 =?us-ascii?Q?2cXlnqss5KwPhU2BwRtuHgmsCV2DGlgiKFpXk2Ai?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f9031d-d241-435b-f3ed-08dd05643814
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:56:55.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHSW7yDLGdLTGpZmpkLI0cvUJ0VHl2NI/hEKvEzhXrNGSYxJjU1d79pyJDvTxAcjnfJVjD1RApQUvTmBWhF6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416

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
V3:
 Add R-b
V2:
 Update commit log

 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 60de1003193a..3966320c3d73 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -668,9 +668,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
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


