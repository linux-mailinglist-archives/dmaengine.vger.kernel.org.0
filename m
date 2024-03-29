Return-Path: <dmaengine+bounces-1658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6207D891FE6
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF0E1F30C6C
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B09D85623;
	Fri, 29 Mar 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VG/rXU3i"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2110.outbound.protection.outlook.com [40.107.8.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A028383;
	Fri, 29 Mar 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722917; cv=fail; b=B8GvMVk+HVHdHL+9z8G2o1vrR2nUovtaABbnxLITLzUJv+AxsswCgRBANO8It3WTpy0HjN2lIJ3YG6c0ugItOO2ihXATE8h5Dy475+sRLI3Pi7viUCem6ZoHEOMWPaA12/cMEFzBb2nWPSqya/NSKiu+fGbGDDqxeHeRmWgS0fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722917; c=relaxed/simple;
	bh=pkEVvWOsGPC8GRmMAKNJcok9PfGzxBg+simpRDnERxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cf2iLXNNAsE+pqSet37YEs6LSBTJn45U0PKpoFVQ9m5A2aZGxBs7FL6UsUYI+aBz17HLQw4+eBCMxt5PZiKwDekUoS59MR2W5UBEWGmfsyP6mZFE362lWD4qNETFEJVBVcBW5GVyKTOIkisUkRu7YpHtSCUPuLJbLpo4Y2tq/zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VG/rXU3i; arc=fail smtp.client-ip=40.107.8.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2IG99KKq7D7aiA6evL27ILl9dlaCO2kNxuTK12dVKYxLxSsZky0sB7yV/c2z4ISOWrRcpeSgPnL1jg3IOOK8pBJX4uCZ0NZJxlBgbuQG1FPs0IHnrFi0E/wWOiWKGK3FTa9XRRt2vbI3UC8iXwNrgKw9K35kc4Tyd8jvnJxS4jOR17XQ9XfbzJ8SXLNccsDJwYn17Wif5GWJdQJ1iv+g8R96jKF1LkPn8DgyC179x2UM+g3U6vnv6YwNoF6Pr6CDc8dtQykMr+g4EI3dmLH9GBNJOTQTXHf/z5dZgjoYfDFvFjLvlkH6+Jwgv7X4AsskYdGLCWu5pp2w5paH5yr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=OQETLLN8IOXDLfIznJdHax/PB/tRC6cqojA3U0WAsmJcZK0WyzHWFIIJV5gcp87Y/R3hAO/NsWJGtFJvsYVKt59O/S5dZXQjaLRxdz7E9MlaOY21t8ftswNdPpumqFPCo18ZP1L3fdcAcIUgNYNuVkfu7Ul1OMvn6x9AbyXBatiw1VzHVHPmLiMrrA4YWsOSgZzvtSc8UJcjPZacXhh8tqB8qrirLcsYiF90My6QRpIlw+PUwSwL7ptDJdOZ4QbhC4DVU0JIPRHv1gT2dbVxFGHBw3N5HGtTXxAKvC6oIQ3rTEBwRD4HpRgIK/4tK93L4mnM1ehXPlvjTNB1F+M6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=VG/rXU3itKTw0vanpvq3TH++XbnKaBZat+1FHLFKBzj/c65sYqYeRKukfsgoQwZ7+u01lmj6ouXpzHyzFYbxW+wAYTA6GU9HZzdxsXtHJu4NrpzJQQfVV/WXvJPik1aRCEvyIlgf23stLXiYkM4su4Zidnm247myHCKsze6bN6U=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 14:35:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:35:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 29 Mar 2024 10:34:41 -0400
Subject: [PATCH v4 1/5] dmaengine: imx-sdma: Support allocate memory from
 internal SRAM (iram)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sdma_upstream-v4-1-daeb3067dea7@nxp.com>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
In-Reply-To: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Nicolin Chen <b42378@freescale.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711722904; l=4382;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=35WKrihwsy+0gjRgHH1219vF/6YHpbFAEnJbyCUA0F4=;
 b=8FQewc4AtWErArOu5ERlHECcf9kFO4oB7cXVz0gS7aQQbVo1Jl/U0e4bq7Si4v4LQukc5niJz
 AL6s/M03Td0BWIWFlOmcNc3hFxVRKQ6o/tw6WlO6Y93i25zI7Q2efSi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zOLLoYU/6JuAYy2YkGDdQ6BMA1edzPcCcU9pcCZpfASdtOathn0KAc2ul5MLR8hWo5GNBnknqAtdap/5O5d9Q1O+gU2VBkGk/VA3r8iGxfMIVWa1IZ0Jm7QqZarZ9oIixKMdOiMdm20NvQFq7VsQNdrAB1n880yCOh0YQ9ilmgLpYtKy7qX/8RU4ST++JL3q7/k/xQZfrgiwFNWGF0B2qXNSpLo4MtPjrHq9cSOWd1/UYQAagZaqxh7nvm9+yCi2O7xl8IOTUJ5NKyRkR/nAL0v9bvl8h1HgN1CTP6eqaPzz0AgKWDYZ/tXlgz1X928VugfiyorxZJrooRxvF/+jwTZQUHrNFjQ1rIRlqgB4dIJfD/TbnkoKoJBmG5oUU8Cf0Jk9OGJO4Q37bHnb9cndHEIjXT2+oGdkA8q0vChNAqEuzh6efXOnhCfl6tnB4p6GvvjO+i4xVu22gGOebTx/nSmH5NvJ5xLaAGOKfOCQou1lBwTz1X/En64FzRNne3ZqnRQ0W2YMudnRgPnp2UIeGe/JOnJiPagT1cntEAM6khYXXayKo8SlXZNCwIeaeZCDDLxkygdtDZSC3P/T7f5WbciDK0c63gzypLG61Mx7QE6mvSnqPHTE+TsOZUry24fW/otk9JfvJnLnyGryFXenNNqBjJ7D8Py/UOR5Mvv1by2ick0quv3S/xpIiV86Hi6i0qByFDBlB+cYmgP7iODCpp3m37aINvtyx5fcZ7xn7uI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhTUGt1Nk0vUDg1V3RicE90RUhZak0wYmpYOW9SeFM5eEhITzBsQXBGcHpH?=
 =?utf-8?B?bzJDdUZWbVZDMUJwUkg4VndZN2QrZ1ZCbTZPUnZXTjZPcWN4bE9xTENoU1dU?=
 =?utf-8?B?N2ZEU3RuQWFBaG5YY1E2c2ZUeGNRenAxVHp6OHFORFVpUzEwWGdobzZNcUNz?=
 =?utf-8?B?YlRBZ2kvb3hrdXpGYXRYV29uNnlaVjhGS3hWQjI2RHBFeFVxZ0w3OVhFSUJD?=
 =?utf-8?B?Rkw1Y0dENlg0YU1uMllHb2kxMXkwcnNtTG1FOHJTZy9tK00wN1VHTUxhUjdC?=
 =?utf-8?B?WS9oazNBaUt1WWN6bUVndmlkL3V6SWlBTEc4ck1OSHEyMzdRNmpqZk9XNlZs?=
 =?utf-8?B?eWJObThJUkFwNHh0Z2FNWnFnWFcyM0k3ZkpyTWU2LzV1Zk5jM09aR2Nwdk9I?=
 =?utf-8?B?YXExdllkdW9CT3FRdXdWcnZ3WGlQWnoxL3VqWHAwK1cxWXI5SmdtaDNSNGM1?=
 =?utf-8?B?ekZFTDVBVFlQVDQ5ZnRLbmVWTUcxSHdxZmZkSGdKem44cVRPWU9pbzExN0ta?=
 =?utf-8?B?aVZXLzl3VkxxUkYxaXhkUUo2UDBKYUZNLzB5endnRXpDcEl1ZzVRZy9WdWF4?=
 =?utf-8?B?ZlRlRnp0RlhSS1A1bWsvUUJDbFVYak1mMzV3bEJUR3BWd1h4TWozLzdTUWZi?=
 =?utf-8?B?cnJUSWdHWENvUnlXMXBIKzFXNFlSZ0pCbjZPeTNZbFQ5ZmZsSHFUVm45NzI5?=
 =?utf-8?B?anNabkNvZ0VIZU1lZnJlRUlLUUZxeUNZVEhISXcyU0tnaWNURDMxRUhrbTJv?=
 =?utf-8?B?MFRhV3BNSS9qalJVTE9yR2hDaFNIcFVMSE5jS0lCWWhkRzZZVCtMRU9ZNTFj?=
 =?utf-8?B?dTA3YWgxTkhpc2tobHJ6d2hzcGJrWUYvZWJrTUJ1aUk1enJFYjhtbUU0dFhJ?=
 =?utf-8?B?TjdTMmU1cHBRaytWRVd1NDdTL09leDFZMWxDWUpweXErZDlqK3VscnlPTFpY?=
 =?utf-8?B?K3p5Z0lFSXo5TzdnTFd5S3doOUlqcjNXYjMrdHEzazUyZXNTbXpoK1JsZmZ2?=
 =?utf-8?B?NDRETTNPRmsvUWV5VEhLMDVvZGtNVjFWWFNNRE94R09kQ0hsaGQ3NllZQzgr?=
 =?utf-8?B?elk1NzFSdmh2NThvcU9kMk9SKzlndTZhU2htZ3VJN3ZIdEJsNTk3SzlGTjNE?=
 =?utf-8?B?azNwT3I1d0d6cEdibE9JODcwdUI0Q2NyM3p1TkUrL1FCUWJ5TTMxRzNTY1dI?=
 =?utf-8?B?RnJHa25CV3BuNUpFT29LQ2dkUFVsbmN0QWlDam5VMytXbVFiYm9iclNxeHNJ?=
 =?utf-8?B?bXA4Q1ppbVpnM3NNQ25ZNDJQV1JtWXZPSVB3UWZoQmxQdy9KdDZzYWlld1lK?=
 =?utf-8?B?dmJVODdycmcyT1FuOUlQbk1PRVFESjhXQWZPOEFuczAyaVliUElVT0FnMUNo?=
 =?utf-8?B?VWNjUFg2eUVVNFBKcHhPVmZFc1lDRWRMa1BWU2gweEg0NjIyRTBnb2ZOT3c5?=
 =?utf-8?B?MU9zU0ZuTnM0anQ3cHdHbnlwV3NhMDVGQkNLOEo4WjdTaTZMcFovMjBSU290?=
 =?utf-8?B?N1plbWl2d0dVU3hyZFk3Q0oyUlYwNlVTWFZyMnlXME9rMElzb3BlZTNFNENT?=
 =?utf-8?B?NG13b2dZZ05xTTFPODgwMldhUHFxM1RTKzRZTzkvdFlOcmE4WGNDMVRPN3pJ?=
 =?utf-8?B?bUl5bDNPN1ZWWHdaMElUa3ZMdHpOSFlpYXZHUEZUU015N2tVcHBISW83VW5T?=
 =?utf-8?B?azVTUkdYTVFOMDFoVmVRSkFkWXBYWGtuYjg4RGxQbWV3MUU3TityVnVoUHli?=
 =?utf-8?B?Y05aaTdTOFQ5N2dvQ21sYUtNOHpNUEhSTVFWK1oyTnlGV01icFA2QXBNMDFB?=
 =?utf-8?B?Z24rcFp2djdYekFucThBVlYrUDhsdzdMcG90dzdZajNhZGg5TkdkT05oZnht?=
 =?utf-8?B?WDc3T2NIUXJPK1puaTlGTjJlQysvRDk0VWREMFdDeHJwc29XMXBaQnJONkFq?=
 =?utf-8?B?WHE0SnM5RStTbHRBejh2d1NvbTAzaHdtc0V6Q3ZCS2RVMXM0dkh3bkVsbHZG?=
 =?utf-8?B?RnovYnY0dGVsenJHTTdHYXIyYVNlWUZUa1Rab1RVRC84VzhCRWRXQ25ic2pR?=
 =?utf-8?B?dStydkxNL2NrSGNVTkt3bW4waXZvbnFwOVlBS0pvMEEyUWlLRUhETlRjc05u?=
 =?utf-8?Q?XndNsPpatKgUb50WZo3TeZpNX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577fa877-4713-411f-b6cc-08dc4ffd7223
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:35:14.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zen0XB4vsWNAu3ECNWaEZDIV9seMTCJmhTm9YnomvhPrXfWKpcVch4X1y6DFeLhcSwitbM2/Pnhp3p7vVPqZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

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


