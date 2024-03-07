Return-Path: <dmaengine+bounces-1291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5324875540
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 18:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1414C1C231B1
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F0130E53;
	Thu,  7 Mar 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSPUuapO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F3130E2B;
	Thu,  7 Mar 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832797; cv=fail; b=V88pOqex034/1z0rOiQRd9JDz6UYtHZ6BtBkQBz5+wvBmegQHezTTxHdhSrdm8Ym9FI2bAciKUABBU0ZBpdCM8lzzW68ibkCVfOx9mCHODXn308czes5nQlUE4nfIYeu75MQCfhw79z0SWmTFMqSNRnY21+/m1cOkTUyJzA8jIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832797; c=relaxed/simple;
	bh=pkEVvWOsGPC8GRmMAKNJcok9PfGzxBg+simpRDnERxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hfEx87hcXVxVOBC4qag1qoMygduImIE2DVEBk4FdQuUxpk8I/qrA+8GLmuPN4HBlZcmEsjSeDF2aNRRHqwL20h5gl0mKiwftsqUKFntuNAU3zpQk/76KOryci4ntFQHfF6bPjYDZojvdLTIFUTgKB5CncV25IcjXi9PaCihHvh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MSPUuapO; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHwV/d0vJ+VV/6rODpNoDW7EoH98/4XqdQPoHZOFARz1tieivrAhKMCIHrbri3oT1xlV8qoA1kK9Oci0ttnuJhdpzCuhBsLlxff7P5xAJ3gkhhw0PgyeQ/ns+WPPxfyiinz4/GzGhPm1FWzYMlS5ZvsGzFiOtntgmOvTjgjpojuhN6IKTOyQYtlAScPXOpfkTcxig+Df0yw78mOHZ1jEDcgm3Nhf14Y1s0/9AEajdhsN66JoeZgSCY8OV2YX7BFBs642PQUs2J0sQCi91UN+qC3zSRvxkmYfKTsbA2Pd8vycmXWtO7n0OXc07X2q91DlTZDdq9oOf5Mc0zsyQu9FYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=VrevS/OkvODLNY4qvBJR4/OlfbMPl3CO8NwyH9RnVzO+aF6UqGn7JBVlvGKxUWZFiCb2MjHWOcdb594Xg6lC0E2HMYl2rsMbGnZxdShrdw4Bk5Nan5ZE1WPFfUqCS+mcjQJBS33YlXEL/UCJ+TcRJuWexLFt49sBqSBvbhTZrgAXl4cQ0abNHA2RKIIsb0BL2ObhdkAAo5VkZRD0S/x65pig3w5MBv0EinXHAzCi2IUbuZulSDPWOXL2s7XTfCHkHVh29GCaKee04YTv7tuSuyPBu8O/J3UpUwT8x2qhyCO2z7VuZYpYrHyfvZel+8qmhECjhByNQyAg+YGxebdE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=MSPUuapOqxiWuk4UymyAcvI8Z2tdW6qAAX+nmqj3Qk+oj6EniQB4zBqtFHGMk6NA2v8Qo/eQVM57bttX8zeflbuIJ7B0wNfUYYWtdO3vArks97hZlDuN+vDmT8tTVNFCgH1RG73sJHxsa3xACTotzoDDwhJvo+ohP5D0g0/JhZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:33:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:33:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 12:32:41 -0500
Subject: [PATCH v2 1/4] dmaengine: imx-sdma: Support allocate memory from
 internal SRAM (iram)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-sdma_upstream-v2-1-e97305a43cf5@nxp.com>
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
In-Reply-To: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Nicolin Chen <b42378@freescale.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709832785; l=4382;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=35WKrihwsy+0gjRgHH1219vF/6YHpbFAEnJbyCUA0F4=;
 b=vcZYt+q+JPNhDZADrJ8xEuQU2gQsKT0AhUjpPtWnLqayoowZlXem5NABkmNzGxC8/pQzoUE43
 0jbU2gYQXx+AOcxroFBvl7J7zpDFzwr0rZj94HvbyKt9ab0aUy6o7Iv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aba22f4-669a-448d-a139-08dc3eccaaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pBZpCuP/tWfUApXM4ucPGSbBKor7/vW7MYRtRNudmr84KQUOe98aRpFK9Vk6khZefqA5bIDWvBTAasyne4cLQ7ETjgLNK6nYJwVp4g7XnjAx8rWuETjt/RX7di1z/Vrc4l10KpbV2lye0vkHa7Nv8YACQBsTiURQ5/RW2Wiuj5HBFl9/yRubsMPl6WMvvzpgBNqXIBpyN7QTJur8iFeHAxhGf23w/6n7NOSuV6yBIAAMW/U78F467S37CbNoEAH5+GZ5drTWgaCu2FIvGsrbe0qr92HUuPz6TboyGioy8BepAaybEXdYugDT47RBLS/UDhSOVX1638UfOS8IBBp2RZJ+cAhm2WEZr2Cn/dnDJ0w/DcoEe5eillOwPTz2RiGIbbmFlnQn9/Mn64fc2ybJ5MerTxppW6VQhE6j7waYULyjXmhlELCnCbz23+uqDaya9oIuIo83LUJUwBNdDhTHudJT5lqIBZDVNZ/PnLP45JifJ48q8JWsVzTJYih5f1YzgY/IY3g3S07FsMaT9xhQ59PAwsEkmTUNXVGiUy4XQ0TibFenPK3pWQGy19gSkxRJ3fuNDdCiSxvonx+zJG0JE64pWXyFVqc5xUX+UoRybY9uYWzqVgizuKz9x3rVfinWmrh1QfaBjCcdpBxJEXaPAdwp46o/1EDoYcOe8k68n+m8JBKi+mk3VyFf3l5KFWY+DuSLKB9itPgMZ6jBqWMM26/eIC/wZoPTbLsOVmsBAns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3dVVkZiYk44NFk3QXgrZlpnM0p4SmVPcFFJR1dudVUzSHNBd0FpdCtKN0xF?=
 =?utf-8?B?UXNUOHZHMDNEZXFxSC80U25vUjdHOFRzUzBPSjlzRjFOL3JoOHlkYThCK0JP?=
 =?utf-8?B?RVREK0hTK1gwckhCUXI5blZubHRxVzQwYjZ0SU9YZVRXSEsrTkV1cTJCM1Bt?=
 =?utf-8?B?azVSWU51WURkM1hBY3hrUCtpMVVXN2ptdjRWcUswUzlESXF2eldUbnNwd3Zt?=
 =?utf-8?B?N3JmZ0RjRlgvdUVSaStlb2xtQmlBQm1sTUVFUjhqQTdqMXFNcC94MXFyT1hX?=
 =?utf-8?B?MVc4cUNPTk1SVko4MU9qMUxYYVU2SDA5bCs2SDZhZXdoZllzMXg3MjBKYU5W?=
 =?utf-8?B?aFcybE1CMEowblYzMUlnYnNSSnZyZ1Y3Z3kxdUFiN0t3LzVySlY4TUZqcjdx?=
 =?utf-8?B?b2JKYWNLMitNcmVjelNYdkZwcDA5cEs4VWNhK3RXV1lZTFVaYkhuUlJEelV6?=
 =?utf-8?B?bzR5ZXErNGNzRkVyTEh5TUREa3dUM2JaaFpCZGFoMmcvRzdMZDBqSmIyOGFo?=
 =?utf-8?B?VnRoL1V4NzVDZ3BpVFVQbldiMUUwL3EwRXZSc0ZQTHN6UjhWc0hYWnlubGRH?=
 =?utf-8?B?M1ZGODl4MmNBckFoWXk5VW5jL1k2VmRiZkZ6Zkc1V0ZhL0hxOTh2QkFLWWlu?=
 =?utf-8?B?ZXBpUjJCUjZveDNxSWVFcllESENjVk5KVlA4VWxmVnZyMlYxaWEyS2RkSWVk?=
 =?utf-8?B?SnVucUdVOGM5RndmSngrSmZpR3ZoSE9taktSOVBHUHNGQVRGaTBnZk5sVGVk?=
 =?utf-8?B?VElWdzUweFdqWHFWZTlBTWxMem1rT1VSM2JiQ1RDdkRWQ0VPK245QVBuS040?=
 =?utf-8?B?YmtjWGRTRGNSOXk1cDhab2lyQmtEM3dYZyt3SUY0bW4zNDB3VzIvc2U2c3ND?=
 =?utf-8?B?OW5ySG11aWUvNk0ra1VxRU9WV3JJa0ZTSDBsNzRUUDBHMTFWa0ZnZENSMTlD?=
 =?utf-8?B?SXJ0ZmZZYTRuRUpLN1pDN0I4dXJoWHMvcnpxV3dvS3FoaGZhekxodHNuZWh3?=
 =?utf-8?B?Q2VkN1k2N2s5L3QvR3k4ZzB5cndoSHo4aTU5NXUxL2c1UEdoVytsRXhoWlhZ?=
 =?utf-8?B?ZHFtZnU1VjI5NlZNWWt1ZGh0a2VLRVg4eEF1U0pYTWZUQlI2eG9Uc2JCSEVH?=
 =?utf-8?B?eVVJWjJobHpxdzgwVjlIaVNvMHhlY01wODNkWnZxUlVDc0FXaVdONjdod1Zu?=
 =?utf-8?B?aHJXbjRlZDFDM2hKWUVhc2hzNkI2VDk2UUgvcHlTTXpwb0JtcWxUS2hTQkVI?=
 =?utf-8?B?SkdiS3FlS3hhVjdiNG5IRDRIZFZ2NVRPSW4vdFlXSjRxdkF4TDNsamdEVm1s?=
 =?utf-8?B?NFU2TG9TRm91NjIxazh2R29tTS94LzV5T21iVnZCbi85ZXppN0Z0cWdMY2lr?=
 =?utf-8?B?Z2t6V1poeHh4eEFZMWxkbFNabUwyVDJqNDhlSTY4clJqRHdQejl3bEsrNksv?=
 =?utf-8?B?T1ZTUXE0aWJIRmdBRngxcUhxQVJ2UGlJZjFRMi85QThoZlR5dktlZDltRHdw?=
 =?utf-8?B?bE9xK0xVekRDYnh4ZThHM1c0aE85R0hGM25lamQ5bWZnWXhHVG9xeXBhRFZV?=
 =?utf-8?B?cHI4MDB4dVJDOUVIZjRsY2drNHVIcHNMeGdKbFpxQ0ppSjc2aEs1M295YUJG?=
 =?utf-8?B?dzdXb3VONTBQamp3RnEyTnRkZTNUNFN4QUwxNE9lb0lyeTY1bmVCMWhVRU9T?=
 =?utf-8?B?bFNyNHhxWXN1SjNOeUpkTjRCSlh2d09BL0NrMzRPVnp2Q1cybkN5QTRWM3lS?=
 =?utf-8?B?dC9ZZ3NONzhaenZZQUpQTWJqRXJldmJwL0Vpd0xESmF3ZzdLUTFqOTJ0cjQ0?=
 =?utf-8?B?WGRaSWl0WUE4RUxZVHlkZW9kb1hvRGNjSWpVczdFb1Z2WW9zUmdJMnMvbmR6?=
 =?utf-8?B?d3pSRDBtNklhUHBQSy9WcncveWEvQ1NPUnFwcUc5cUREakZYdlBpMUMwK3JB?=
 =?utf-8?B?RW9IaW5FVVJLOUUrakwxUGxaQStqYVRDWFBnbW1lNUUxaEdja3ZNT0lwRDlB?=
 =?utf-8?B?Skdnb0ZjbWtkTS9SSkdDcm5TY2piOUVxbXlKUGdFWCtnYy96YXcxRVF5cjhY?=
 =?utf-8?B?aXI3dWJJZnJCdE9HNENQUTFsaWlaR0MvK1RnbDdIV3MyWkllUHdvclowYVFM?=
 =?utf-8?Q?wpVE6cWw6qL6YbiZxD0dZKmOW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aba22f4-669a-448d-a139-08dc3eccaaa3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:33:13.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZc6s2AYkgHGjLCc8TPeAdtmWksSDzsZKgzzewPbCU1XTYpHp6MBzjNZnFAKQtW3V7j9weaNwEpqIz1q6fAXpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

From: Nicolin Chen <b42378@freescale.com>

Allocate memory from SoC internal SRAM to reduce DDR access and keep DDR in
lower power state (such as self-referesh) longer.

Check iram_pool before sdma_init() so that ccb/context could be allocated
from iram because DDR maybe in self-referesh in lower power audio case
while sdma still running.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Nicolin Chen <b42378@freescale.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9b42f5e96b1e0..4f1a9d1b152d6 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,6 +24,7 @@
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/genalloc.h>
 #include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
@@ -531,6 +532,7 @@ struct sdma_engine {
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
 	bool                            fw_loaded;
+	struct gen_pool			*iram_pool;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -1358,8 +1360,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 {
 	int ret = -EBUSY;
 
-	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
-				       GFP_NOWAIT);
+	if (sdma->iram_pool)
+		sdma->bd0 = gen_pool_dma_alloc(sdma->iram_pool,
+					sizeof(struct sdma_buffer_descriptor),
+					&sdma->bd0_phys);
+	else
+		sdma->bd0 = dma_alloc_coherent(sdma->dev,
+					sizeof(struct sdma_buffer_descriptor),
+					&sdma->bd0_phys, GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
@@ -1379,10 +1387,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 static int sdma_alloc_bd(struct sdma_desc *desc)
 {
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	struct sdma_engine *sdma = desc->sdmac->sdma;
 	int ret = 0;
 
-	desc->bd = dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
-				      &desc->bd_phys, GFP_NOWAIT);
+	if (sdma->iram_pool)
+		desc->bd = gen_pool_dma_alloc(sdma->iram_pool, bd_size, &desc->bd_phys);
+	else
+		desc->bd = dma_alloc_coherent(sdma->dev, bd_size, &desc->bd_phys, GFP_NOWAIT);
+
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1394,9 +1406,12 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 static void sdma_free_bd(struct sdma_desc *desc)
 {
 	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	struct sdma_engine *sdma = desc->sdmac->sdma;
 
-	dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd,
-			  desc->bd_phys);
+	if (sdma->iram_pool)
+		gen_pool_free(sdma->iram_pool, (unsigned long)desc->bd, bd_size);
+	else
+		dma_free_coherent(desc->sdmac->sdma->dev, bd_size, desc->bd, desc->bd_phys);
 }
 
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -2068,6 +2083,7 @@ static int sdma_init(struct sdma_engine *sdma)
 {
 	int i, ret;
 	dma_addr_t ccb_phys;
+	int ccbsize;
 
 	ret = clk_enable(sdma->clk_ipg);
 	if (ret)
@@ -2083,10 +2099,14 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
-	sdma->channel_control = dma_alloc_coherent(sdma->dev,
-			MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control) +
-			sizeof(struct sdma_context_data),
-			&ccb_phys, GFP_KERNEL);
+	ccbsize = MAX_DMA_CHANNELS * (sizeof(struct sdma_channel_control)
+		  + sizeof(struct sdma_context_data));
+
+	if (sdma->iram_pool)
+		sdma->channel_control = gen_pool_dma_alloc(sdma->iram_pool, ccbsize, &ccb_phys);
+	else
+		sdma->channel_control = dma_alloc_coherent(sdma->dev, ccbsize, &ccb_phys,
+							   GFP_KERNEL);
 
 	if (!sdma->channel_control) {
 		ret = -ENOMEM;
@@ -2272,6 +2292,12 @@ static int sdma_probe(struct platform_device *pdev)
 			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
+	if (np) {
+		sdma->iram_pool = of_gen_pool_get(np, "iram", 0);
+		if (sdma->iram_pool)
+			dev_info(&pdev->dev, "alloc bd from iram.\n");
+	}
+
 	ret = sdma_init(sdma);
 	if (ret)
 		goto err_init;

-- 
2.34.1


