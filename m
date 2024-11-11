Return-Path: <dmaengine+bounces-3699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7469C38FE
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 08:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8305C280F3B
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF5158535;
	Mon, 11 Nov 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AndeUi9G"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BE136A;
	Mon, 11 Nov 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309986; cv=fail; b=GD6bEeYjcuh/Oog8zwiCoTe41cLaEyVC4QnthkCVgwDx7dvbFLhMZ4HwDq1P8F2HX7tlt9fs8XjsvUg3q4iFc3RSawD8a0HcGvnXEbbD2r8vckMCgKYPh59j/kw8LgRaxoC1hiiPEUeqGVsw0FXg862E+31bPDXvjxxD16TYt2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309986; c=relaxed/simple;
	bh=y0yDb7wi13Yq8Bz2eAqntIkNUOOvEsIIFhn1Eqgqcos=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MhySO6KL86s59echW+sUilx204Y3E+ZviWTn76lWYVWgBjTGULyIeUbKSVbJ+tD8a9hb2AbJLTLyJp/zjuOy3q6UKZ3asW8uINRVFiG15nvcrZuiYPykUYZj5bvHF8s8voMSgJcoR9Vz0HrNQD5mOvls8DkKCvPaWVTMyXhagQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AndeUi9G; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMgJ+HePActns8hynGUm3j9WLSCDyyrCyZc/mP/jztyNjerH05tDaL7SxlXhy0vE9I1JLGrfvfhTW+Izs/NYSSX+S7BPbtQwM5MTXJb9GhyJ0/CN0IkV46SMnazW+s+JpNvaESpnXm9ZcDxeBdsL+dFJvQp5UpbHCtigJyBu5L8a1Q6sw5lDiW+jT8a5p588Fdyj8XHcoUZO4gDR0w3WR8AA67Vcx4SvEr82DKhHBaiBU5DhhdIV54/3/I23ducUFrDBOUqSs+EtPtyZhO/OAzQU7yOS+8kySgij1eu0sx+MOYD6e1PWVF7CusaE/p71r75+L2nEJvdkkUN7iWfKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1TMmag6hotFLU3OzdQLyDbwl0oGZUpqeE0Z2YcpNk8=;
 b=Ka3eqZshUgm5XeNarCeZV/pLHWZBIyhhllIJd/tkvGpyB2ak2Gfycbor6XpNRjm7ubOv4YDiL1wOshgk6+QZ3dH+D9tb6fB4nDXuOycC3efnLw9Uq13FaydP76RH6uH2jssr5xN4ra+18/0+rxeDlBAfnQNYXzzd/xTu5WVLCU1Ub2O8BAftEktLjJhmHF2HqNxYn2N/UsIHFNhP4ZuAbJKVLxJyV8RXPx5pxKmbNw1HWHKAeIsyGAtZToq5VtSr41AoMRkmngVJdwSxuqviVdyJXjL+/DcPmCrBsCysKAtGGxqu70SlEgL4NaqGZGH+g2NOaLOy7W2KlEXKjr1Wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1TMmag6hotFLU3OzdQLyDbwl0oGZUpqeE0Z2YcpNk8=;
 b=AndeUi9G021EdjBsgl+hYpMYJQq8Z4wwx9MjwkrvaPuQlc9Ebb4tU8L0SEhxZ3grOGYLUi+Jvi35QDPeLsR/r6mDOnj6OTfcOXJyRj3gvSeOU1TQlaxU3t4xEHKWzfn/DG+B4L1qjPoyP4RzRg3nA1awpLLD750HcFg8+R5dx8BqogfvKSsZ0Jx+MKtta9LzeaH/3kX5/8Axyk7QxUXv78acSCQS23iOjFEYLNS5GWe3K9fk0lfE/Zcxhcrsq/2rA6djIkrPCaoCyhyRuR0HMHCp+NQDx7v04Tf3AZb5ZOEDmt75OmZTmO3BpLc+aWgU9GepWhwWL14ofJPEGU8OpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10854.eurprd04.prod.outlook.com (2603:10a6:800:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 07:26:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 07:26:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
Date: Mon, 11 Nov 2024 15:26:00 +0800
Message-Id: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10854:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ad120f-74fb-4454-5978-08dd022223c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mo014/FbqAkXKOmjlTdGuB6i2k5E6yVoSUZ3SMNjV5BO4WPEncl38X4nFoK?=
 =?us-ascii?Q?s2Oa6o2v+3yuK+CGmo/wQ01hAAckLtJJ2cUaVOav6OeiVNV7MJCcWn2z6Hkt?=
 =?us-ascii?Q?SfX0uMaECEbD8L2qJmwSsL8ffdCeHuk0SO9c3VdqEcKKChuEszgGDrZY53Ve?=
 =?us-ascii?Q?sIHidMLnnDZgW9DsPU7Jl/R21SePY2PZdvQz2sFBsSGjdu3S/eR8Wt1YtUb5?=
 =?us-ascii?Q?Txtqxj41lYAa05Rmlt2/xetU+FWh5IZyCbGeiikro9JxLgV5zyGhNqD0m+7+?=
 =?us-ascii?Q?yeqs015Y5v7jafP4LIoTtBunHEwghTBkA0or6xvYdWgyHYACqYy8l0NlA8MI?=
 =?us-ascii?Q?uSPPunhcBIP0e1N/JWQyDIWJtvyCtkAvb7qvVm5zmqfY1/GWpvCmzCuTWGO8?=
 =?us-ascii?Q?Q+ShZD7Klov21vCN07ASUTUVJHz1ZlKOd5GjOR5fd+eoQLbRJj6LO6KFWh1G?=
 =?us-ascii?Q?FgH2bUc2RjMx5SH3YGOp3XG4yNXrac03Gjgzuu3zHNlsVSZXwSRfrtoBxqn3?=
 =?us-ascii?Q?8qpO1guv6rur8ubBZTjdIB8QjvnO8VPH8Nsbyr8T+1WFdl7XhFUcaL4ZJFP+?=
 =?us-ascii?Q?jRP5RXKANPRZ2iDzycJ3/Nynl0ro1m4yS7z1VFzSUSFYLKlyNxqGFmoyEzDz?=
 =?us-ascii?Q?cvrWJNhgpcy6ffcT+/KgNSyzsFeE19MtXo85Z+GZO3Z8/dceAvufBH24Wfm6?=
 =?us-ascii?Q?HpP9dPlFO23PZk63dbsWSOSEfFFMWOzdEbdelqPuODrx92EH5wHxLsdRKoB3?=
 =?us-ascii?Q?/U8znu3IOJvN6iCiDJCKwUhSdTtXJloqaC/9gpHqYn3YYxnT/3SHeFL9Dl7N?=
 =?us-ascii?Q?6BtygnsIQLaww9GDulXU/fgck/Q+hJA2lMRInyXsKiCmND15BTXETZ9ddzFp?=
 =?us-ascii?Q?s0BGJ5SZx0yMyxf68QR1z7SQKAJ4LWVs4XVvVHbNw5MNHnnwaKy31BETnX2G?=
 =?us-ascii?Q?o44xarSPSfJ3+mdpMgM8lN293MwX7uNc9Vl7oA2naPFo46XFB3B/0mO5hZAo?=
 =?us-ascii?Q?ng6fwzIcmJaMklvyXwMqV4jgW+JbZYpfwfZpIvHy63IpRqiPEnUvKVSoinwi?=
 =?us-ascii?Q?TTmQI30auYMKhjD5IRa8Jap5uY/QB2XcB7noGUhd4+e+3u6uaUBQ113lt2xJ?=
 =?us-ascii?Q?zXe2fJ7b7+MmqkXmcOq7/JTLuvWgcu8u+G9FDnNWMvch5YYsqunMHInCGnWQ?=
 =?us-ascii?Q?fMFOPc3ENM6n4SvFnsaDPLgoMPVunI8bOVTyebFMOVt51BGNvGl/UuY9z+Qj?=
 =?us-ascii?Q?wvVQaUjGtEsox4Kl28ZsN3+ZNcUHmF/VVc9wt02pxFEIYqVmygU01TEI4viJ?=
 =?us-ascii?Q?GW1a65faL0YlMX1hBTL6U90VbZBO0LilpMklqFA6E5EGI41mkHDaA2D2053s?=
 =?us-ascii?Q?I6btCBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zIzi8KsY3KMi1codqZeEz7/TVv6aXf4sO3dK+mYsmVNhZe2Snv8Yco3nRIqE?=
 =?us-ascii?Q?qmyWOgPXgIomKDQhs8AlOKv2OVsW0OSoIFMoqeyGYPBaKv6dGMCdX7sKiBtw?=
 =?us-ascii?Q?KwQJVOMIpfcnv2a+Ny3Mij7OLrd1dWolDSlaK/jCunL9h9wZSEvu1293qRxf?=
 =?us-ascii?Q?rm+zFwoVMpUD+TOjezDQ89B9wseebaKjEOvFjiyFH/ctqUdGyphUmjWWBnWE?=
 =?us-ascii?Q?Q2IMNIN0UwGA6MqNuV8HiaWLng/UPsDUDyC+UpGhQkOKtYaUl3T05bILo/lH?=
 =?us-ascii?Q?bP0vLsuOamO5W0eufw8ZxfGtDmtXMvpMCVuo8mA1N7Y2KrUVFdrFgV9rXrWH?=
 =?us-ascii?Q?qwIk17c5fN0hDshTPdHrgktm8oQj6FrxrIcMpS6VHJXUTZv3Jgo6lpDm+5go?=
 =?us-ascii?Q?kTFi4iJr2MtUJUh8lTnwOsGWgcwW4p261tSAIfHq95TjCKdHis8jdb5EFlMn?=
 =?us-ascii?Q?s2m3SQdKr2dgEtqgl2ykcyIRopHk2WwvgEsSi1d8qlcPT8yRVA2cF3swAYAP?=
 =?us-ascii?Q?ZexkXXf5rv1WJhiPqtC07nXNPP2CDRlRFvowM8tzeJ8suXvYf6dXVFs5vLMx?=
 =?us-ascii?Q?aAHlqVgmjkzc1JRdu5I0xBz2N9HF9DliQMQIqdP8VbJngI4zhMmTL2aApqsK?=
 =?us-ascii?Q?wEQ6+jXdANErA9A1Jgq9wX5um9KVY8EjfeFLKvAHC8i82z599+R3lHGxT/iN?=
 =?us-ascii?Q?2HXOLYqeA6u5xxM5s94nVUQikmFinwTi55Gcv/ci5S7WUo7AEXvBtdDAD46x?=
 =?us-ascii?Q?PwS9CW0rxl1+U+BesqCZxcnNnodf7GrbMCY8NNR+kwnmuY5ljm8TbJXHy8sa?=
 =?us-ascii?Q?w9h7wjvRECtlbcmo3sFFhc1kHBuC/LTLNG3C4rUeS7yYXXEdsvRHXy1NyU+y?=
 =?us-ascii?Q?LU5lmWfvW5JUzfhmsB0mHm3AteBRgg8vl1qxiZ/IdYe1RvcP2eWM36DM/6yB?=
 =?us-ascii?Q?5SDlw8IxZPDmpMwlN4fzYMvq11qS6pR1CudSCqp7qklrHRtkJTUnuX9A72wr?=
 =?us-ascii?Q?AorGZlrCCmCOp6Fi6pMOFelsXVn1Go254+NrlKaOKChTbF0US8sWtZCUTJus?=
 =?us-ascii?Q?XWHkPkZWTIpwX37VBn4A97BZUSdG0VsecvbnodHWVZbadNVWLmHg1XY4VLzw?=
 =?us-ascii?Q?l9vqkqVNPw1tmXfvEI3+VsMVGYpi5p4UgkRnObJWQ/cJAP8AGfBZJHX3EBqh?=
 =?us-ascii?Q?LXPAWNI1111VORTNnfijS/lw788Cz4sr9qZhIA1TlPKYNZeisNZknMl5m+Rh?=
 =?us-ascii?Q?A8i751YuuWNkhGwOs6JdDZSROH44xV/Mxb9PutqTBWXOm954rRbRt6k6heMh?=
 =?us-ascii?Q?cHWSo+uTrAQmU73v3XAhcQaH1JfFfcw70tNoTilS0llZcHoy2zclWxB+kNew?=
 =?us-ascii?Q?4wtUHKJzrEWdEcAb2B5AyI/Ld1QUhptiSXY+rbO3uMyP4H7n4HMZYJ4ZGzKw?=
 =?us-ascii?Q?hPvgVBtaksT0kKII2pYC07Fbva9rcAGC5LP0ohaGbkbmqn5hfMZ4GsVMBPRD?=
 =?us-ascii?Q?yaXg/o31Zf9QBREDLiTo+oO5sE+lJpc3BDtEZ9RrHsrVuzj2uq84Wl/yBkLr?=
 =?us-ascii?Q?XlNu9Zzz0EjHu5zT2Q8Ugk3xZfXxFrO4ZLL7bQBS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ad120f-74fb-4454-5978-08dd022223c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 07:26:21.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1W/3pm89Bk89MCyEj8k2XuTiBS36ftmvdG8XklgxxVkA7Tuoh8h7vzestpMTWVTIyBMHVoLEWeVXTw5eEAHOkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10854

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
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log

 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f9f1eda79254..01bd5cb24a49 100644
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


