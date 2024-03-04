Return-Path: <dmaengine+bounces-1234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43F86F939
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 05:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DC128111A
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 04:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA66FD0;
	Mon,  4 Mar 2024 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I+wXN/F0"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA8611A;
	Mon,  4 Mar 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526817; cv=fail; b=gT5BqVwhoXa/1lsxpYIqlP451sJLzPIBCNlwrPBP8QLgrACFt/IHjO55LtYgorkTDmZsz33/iLY8QlE9aEou/vP6uCJjC5CtaiRHTOjo3ykCbY9Fd7Bts//Q037d706p/mEcdMa1okBxsUjJ/ToHXXX7VHtZN/e11tswxdf6jO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526817; c=relaxed/simple;
	bh=LtHUazjr0YcoFnd2yodcTE4F4soI1P5M3PcQ5fD7GY8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=alRoxUXEAjYMTq3Kp668GXABskyxrb2OgLFJg7apUUOGIIfWWCUbpY4OHA/qrSJz6aQdTOu8wsXEjPUbF0LCreCEUQyjMm/2iqHVnFgG/w2ZSWKpDrDv3DSYPmFT5T7J6ol2HhfJjCM9hwnWRp7IU5tnJbnAmvzM/FrTUYllfLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I+wXN/F0; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9I9TkgVLuDiSrS68IJmzi40fqeEl84xXv1ccO0pkAKd+Sv5SuPU+eQPlDUXs1u1t7Gj0tvxBrZBT1cGc/s04LYwHAHPInjEPCpHPrBYIx838+UM1PGlr1GNl5E2/U3ajM9o8Xcfl+Js0/sqKBITyUy6mEh5e6OlsOM9CV/xVKCDluW8BLUJleCmui+MksRLxkEPflezrOo9aoXzG/Q9pDPLc9Kuse6WM3U2B+pp6VJ0g6rdUixfGjy4Az9x0du92eQZoU6WpV2zBjdKEKg4cwopTfgqjUGPeVD5Jlnd5dwt3pbJlWiRi3gyHBK9EI2psrpQz3gbbShrh+XQ7Obsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aIWq/1kZeSgYf3TtWCAY+gm9WZIIQGWBlVHSvc3x6Q=;
 b=Eao5O8L7UIxV76YAYMlO7wFEtvPG8KKAJ1USzS8kZ96i54tEBjVGJI5gpvqLuCQy5J7dCQuKC0bQ8WWxjtQJwgd3L+OURhXI0kLkNns9QyCLS56cFZboAzJSXqlRDXVrYnExIckiEQe+0zGhHXmePfREXVO1OtyluVZPuODh96Pd1GivbFfg0xffgjW0DqsuwDM65cebNqcfMKxKgOMWeGhYQw80E9Nn+tBYSpsYfspeGHFRt3RKtCnka9Kgh9raTcBBr72xzmiHc2wFSaG37BWgxcNGHwul6LHarSF3T7e7z/zvpHfty7FaLv7lNWjMNZov+nJDYm67xa58ms5zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aIWq/1kZeSgYf3TtWCAY+gm9WZIIQGWBlVHSvc3x6Q=;
 b=I+wXN/F0m9ofsEWfrWCF2QMos+ZzJzDn8DWY+aGS7TRzjFY/x1Of9g5JC88YJwwxOnhKnAHOhYBBtVltjPEgxUe2XV+ENyTkNYZOFsfQ4KQjV0ybtxBB9/Df8O9LDPId5APcPr1ahQQUBx/cgVzMB7ojo4+5pVFSFL59bkZGCfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 04:33:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 04:33:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 03 Mar 2024 23:32:53 -0500
Subject: [PATCH 1/4] dmaengine: imx-sdma: Support allocate memory from
 internal SRAM (iram)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-sdma_upstream-v1-1-869cd0165b09@nxp.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Nicolin Chen <b42378@freescale.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709526805; l=5365;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=53Xk3qLZ0MDANtYpN97MLpC1fd2Mr/1t+Y7ahd5P1V0=;
 b=IIY16/obeaotxWYvtwhO0RJug4DtDSoeYNbIoYit4Aev+ps2kL5vWuQLl5f87AQ1/+RNn9gI2
 m7j2bsCSEBeAdX3N8bfMEuErdX3aUhDafPCFarcYN2LFh6h8jyxS45+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c06f30a-ed89-46a0-9222-08dc3c043fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dhQ57kNj3/l4wE9mvbh/xu1p8rXMNUjSX0HUfOI7K911IKLcAQ9nFaDx71/1IeGDA/9rqDaNIsh1q982zk3rT1n4dzjaAx7pMqxAx+rTggXoDPvA1iZ/BZfzUl8XZ6m5rsTb3PFoWFbA2NyF8fnmAUEnlIBj8BkluvL8xVgZ0ZZNff/ZRZCJq0bYkofs86ds5b8k3gn6tABrYoObrJ9Uupq/H9VKU85pCGwLdU13I6M0kmJs4tu8ABCRWKhLnLFsKpoWgtMXgLUlesaxYXaBlwnUYKvTtFzjR/RVM/4CKw9b+JDFwox8SDCnCWDfBf8ZFEX8iFHpjl2akRXtKV6eVWnFEA3DXHJq4vFz8MOGaG5zMAJhv66BH5l+tDO6mT9J8mm0Xwc/ek9lysyXv3SOTGa7DE5XFx0XZIOl02xejJIFpr36hFwGejFBBi+UI42ZNkguhnjkXIe2yO3Dvffm93JFLVnyaeOHPNrSEpgCd41LozvtAwW55+4iZYYr5Qsamy+E1NBcVo2uOyFQM4YmJc0MDL1pJgsdNHy1wh7j2DUrY/ULd5ccBSoOYEz9F+KnDA7OMigZ45Rgx67CshygioOsowRlQOXBNbdAdkd838CJoqnsI8kkydY6eOyPxJueXmR1UlEWwxXBZlrlK8XMELgpKTd7vnwpdS4BPJw1rAMod9OIzPbq3qlqYUrZLgq7UbVyc3NYaofQC7iSFWjoeaCM2NPLYbDSPxJPYycexN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0JVbHcvaU5QZWpSTFp4YWRoZmdFam9Lb2IvRkF5dW1JVHpld2pBZEwxM2pS?=
 =?utf-8?B?NVF5czZmckV5NmpKRUQxa3FJOE9vQ3FPZzdVZGc1d0tEU2s3b2YrV3JVd0RH?=
 =?utf-8?B?NDFNbmNZQnZiK1RGYkpqck1KRVlXZ3J2b21Qc0t5blM0RFFpUFRFLzgzUDhs?=
 =?utf-8?B?L05UUUtMck96QkFQUXdVb2ZVTGVKUDRUcXhHeWFxNmszb1ZzREZBbkRPU0hN?=
 =?utf-8?B?V21IVncyVCtOeXJoUFFRQVc2ZFQxMmY2dVJwc0RqOFBsVCtqSUUrZGdsei9n?=
 =?utf-8?B?QTVWK1hZODFVMU52Nld5WHMzNFc2Sm5seVRYdmZHZzdySVBjRGc3QlE2WnAy?=
 =?utf-8?B?SExmdWw3ME4yUUliN0txcC9RcFpJaSs0Zy9HNThWZ1FsVmFWZlNQOWlIYjRi?=
 =?utf-8?B?QkNVTlFqUUZhMzExUGgzV3pvSTlmM01IeURKR1pubW4xblNHSHF2QWtLNWFK?=
 =?utf-8?B?bWZadEkrUS9YdGRyRk8vNTNscUNCNitoQzBTZDk3TThjanEwazlNaU1UZk1t?=
 =?utf-8?B?SGlmanJBa3ZSSUEwUTE3c3g0eUdRRFgxTEJwNWpJTWs5NExzaEVWbXVnUllw?=
 =?utf-8?B?dEQ3Sjl4bUR5WkxlSEU3UW1qajdzUTcrdnJzNkpMVWF5UEw0RXRUNC9ZVjYy?=
 =?utf-8?B?OWhpeHdvRDFIMmpLK3dQMk95bzN5VVdHcVIxRUxGaFQ0WUQ2VWNyMVZRVVJa?=
 =?utf-8?B?bjBjclIxOVJ1bjdFT3pQNGFnK2Z2dG1SWDZUdTJISmIvbGlIdWd4Vlg2blhv?=
 =?utf-8?B?azlTZDJVVHRpenZ5T3A1ZkdCQkNBenYvOXBUb0V2SWVzWmMwODlGOGw5cU5O?=
 =?utf-8?B?VGRCb2tEbjYyMEcwbnZUYUZZTDZQUVd5TXB6aXFZbnh3Ri95eStkVkhQWXBF?=
 =?utf-8?B?MTZRVlQvU3dQbFlqclVQUlpZS0VZV09DQk1wb1RETDdZdytzQlI1cks0Ylc0?=
 =?utf-8?B?VGl1ZEppczdSbk4vOStBT0JBUDh6SW5SbnhPZEgvdGtoL0RYWFk3b1NHZzZL?=
 =?utf-8?B?MkxkN1ZUOFpVTERkWkhOVmd5THdvZC80UGR5SVRxU2NtNDY0MTFGSTBJbGdy?=
 =?utf-8?B?ZXFGTXkvbTdUM3dHL0I3TitsSjdYUk03S2pvN0s5TU03U1pYSHd5UjNOZlZ3?=
 =?utf-8?B?RUo3bElKZ2hpL2M5ME5QZGoyR1VWM2ZRVFEzc3dsdnhpYWZteDlYSXFDcW9o?=
 =?utf-8?B?aUNTQS9ReW5FeGRIeVhQYW8xZVNKVjRJclZMOTd6K2Y5NWc0elFtdUsraDhn?=
 =?utf-8?B?MnhVZ2wzdFEzTWRTVkxhbWlqWEVrT3NjMzB0RUNwQmlhZ0F6MGw2dElJVFBL?=
 =?utf-8?B?d0VUc2ErRGwweHBCMDRjaGd4cUdlYkdxTGQwZUFRNzBYN3dGdDU4RERWK1lH?=
 =?utf-8?B?QlAwbTZ2L0dxdWZRYlc0NVFoNTlGc3N0cDk5OWw2dWMzZzZvcXYwWHdlTTZj?=
 =?utf-8?B?Tkk0VEpNaGd3NmRhTjk0clF2SGxYME4wQ0UvWFZGRGo0MW1ab2U2ZlJydTFC?=
 =?utf-8?B?d2dIMzZoRkZPbHZpWFpaYzVuZ0pBMUxoaVlZY0ZoUCsvOXZHYnIzVDBYNTJM?=
 =?utf-8?B?Q01LNlR4Z2hkNXJLdFEwbkFjeGNxVGRleWdMbVpTWUlXZ0FHUHN1Nko3QU84?=
 =?utf-8?B?eHo4dml0eGI4MUx6Z0xiV1VlbUtEaTl1ME9ZeUU0d2wxdW9Od0ZWWEtMb3VV?=
 =?utf-8?B?UUEwTjNzbFR2WFhmaVFLNS9NYW55a0luZEpsbXhnNFdNdThlalVWSHRHZ0JF?=
 =?utf-8?B?VlpoaXc3OS9ONmdXQ2pkTGdhb3d6UzNLNjRsUmp4cXBIaVNralAzRkJPYzEw?=
 =?utf-8?B?RDVpV1FDN3AycWJKQW9kQVhPZm56VXk2UU1EVXJKRVlubHdUS084ZFBQcFZu?=
 =?utf-8?B?bEhGd3JRc25nVHN3OTNrdURuM0JyUHVIOGtKVEVCUjdBcWcxNzNpVWNVOE1V?=
 =?utf-8?B?Z2tyQkZwTGU2akZMakdENGZHMXdvd2ZjamRiblQ5YjVuVXVHOEdvdXJkdlBS?=
 =?utf-8?B?TEZRT3FVQ3F5ZWdaWUdXRkVyU0RseTByVjVTOVBnMHlYbHMyaW1WYmNuUHkw?=
 =?utf-8?B?bVo2NzI0VWdQWUJnNCthNU5LampiUko1V2JreENQb1JBMWNKQW1rcm84ZWg1?=
 =?utf-8?Q?70bh1IZ01NU8pM04cywKoTcSm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c06f30a-ed89-46a0-9222-08dc3c043fae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 04:33:32.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Rf34KZ85aq60n3DVYEqru+pTAT1ODS1fOBfEJFj2B6MiHoHkswC0vPm1zssynXW6pIs8R0AmfjmcE5m85vGkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234

From: Nicolin Chen <b42378@freescale.com>

Allocate memory from SoC internal SRAM to reduce DDR access and keep DDR in
lower power state (such as self-referesh) longer.

Check iram_pool before sdma_init() so that ccb/context could be allocated
from iram because DDR maybe in self-referesh in lower power audio case
while sdma still running.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Nicolin Chen <b42378@freescale.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 53 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9b42f5e96b1e0..9a6d8f1e9ff63 100644
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
@@ -516,6 +517,7 @@ struct sdma_engine {
 	void __iomem			*regs;
 	struct sdma_context_data	*context;
 	dma_addr_t			context_phys;
+	dma_addr_t			ccb_phys;
 	struct dma_device		dma_device;
 	struct clk			*clk_ipg;
 	struct clk			*clk_ahb;
@@ -531,6 +533,7 @@ struct sdma_engine {
 	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
 	bool				clk_ratio;
 	bool                            fw_loaded;
+	struct gen_pool			*iram_pool;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -1358,8 +1361,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
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
@@ -1379,10 +1388,14 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
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
@@ -1394,9 +1407,12 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
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
@@ -2066,8 +2082,8 @@ static int sdma_get_firmware(struct sdma_engine *sdma,
 
 static int sdma_init(struct sdma_engine *sdma)
 {
+	int ccbsize;
 	int i, ret;
-	dma_addr_t ccb_phys;
 
 	ret = clk_enable(sdma->clk_ipg);
 	if (ret)
@@ -2083,10 +2099,15 @@ static int sdma_init(struct sdma_engine *sdma)
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
+		sdma->channel_control = gen_pool_dma_alloc(sdma->iram_pool,
+							   ccbsize, &sdma->ccb_phys);
+	else
+		sdma->channel_control = dma_alloc_coherent(sdma->dev, ccbsize, &sdma->ccb_phys,
+							   GFP_KERNEL);
 
 	if (!sdma->channel_control) {
 		ret = -ENOMEM;
@@ -2095,7 +2116,7 @@ static int sdma_init(struct sdma_engine *sdma)
 
 	sdma->context = (void *)sdma->channel_control +
 		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
-	sdma->context_phys = ccb_phys +
+	sdma->context_phys = sdma->ccb_phys +
 		MAX_DMA_CHANNELS * sizeof(struct sdma_channel_control);
 
 	/* disable all channels */
@@ -2121,7 +2142,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	else
 		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
 
-	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
+	writel_relaxed(sdma->ccb_phys, sdma->regs + SDMA_H_C0PTR);
 
 	/* Initializes channel's priorities */
 	sdma_set_channel_priority(&sdma->channel[0], 7);
@@ -2272,6 +2293,12 @@ static int sdma_probe(struct platform_device *pdev)
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


