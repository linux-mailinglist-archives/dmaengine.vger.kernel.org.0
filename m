Return-Path: <dmaengine+bounces-1297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E1875923
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 22:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CFD1C20A00
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 21:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D513A279;
	Thu,  7 Mar 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSPUuapO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DB13AA2D;
	Thu,  7 Mar 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846396; cv=fail; b=bwdILwchHhSOXR4M+39i/nxSolOlfZJo1nTJHv8950qreu0Hg0oWlxwIY4VTnHNRJiSVgmZc4baaRe9yZ1XAwYusJqTsE+sqoJb9kTRbApHmUWfmzcEoHDB3rctG1LjWIyG0VnbknjJ9BZarKajByIlRU7P4knUqn3ljXkOMv/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846396; c=relaxed/simple;
	bh=pkEVvWOsGPC8GRmMAKNJcok9PfGzxBg+simpRDnERxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H0DLZZoph67VUlvi++iQt1DUt9srJa6YJpHvEH0qoJ7TI/QCAL9zoB8GNq8njzWYFgl1S0FcyR3OnOf/Ft5qlbPYYgtuwZckxlzI/lpJmbOAVuoaNQdsxGAB3UwT4frzeRec90wSJLjirzzdcjADkcoVS4DH281YcAH2E8FZcvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MSPUuapO; arc=fail smtp.client-ip=40.107.15.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egW+Be+WTPGsksALjU7oylmHknFJlUDsU/tgWUKBDG4GxrP3fFBXwH+vPBTtkbfswO3BWT2v/rRybkL/FEOfX/AjL81DLpdVCtG4Nse08gJmyT2p5Q1DMOJVGjQvjJd1BOCquu3roHvmoLCa6GxKwWF1yg8MOF26TovJQc1sPAIefz0+5t/PBDUZtJo35jlPQ+vD/gtFz79lCH9rUy/JUlxXbGI87ptrpKM1COaqFiHKKyEajhLFYjARtiDV9/oMvTzxPEq82PBDeHmTQZNvPCrVVmvDTL95FyuM/mUCDGKA+6OxVx7CeWrNzcJ5BMhDOvnbp45HL37SDGa0oTS5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=VWIkee1s/ot6zadWfvmUzIk2PTP1RlLaynSM8mc5tN8K+0u3L8Hkjag9uLP4CZQHLfy/lyvmCW4sc8TFL2biqMKQVXqjw6YgsBcaKtJ7LC3h0EMFHEkB5mT6+MY4+jC3Y7tXcrh3q2h9kHq/LDUj+aZZYNqPeECnDuNDyOoFZm4qjcIEecZWvtar3mhJoND2i8k1asF+9ujcApQ8svg6wuPzItXoEDv6uPNphxFNTAqHNfG4QyUOFlFcdooCV90EAfeHsKJ8aQtOq5MIaLi4U5jVEp8ZtbcHtcpUExzS2D1eDbSwUphvW6+58CA94VU3rstM9V0mLXMYG23ped8/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKzF2nPeJMZc/TEzPO9lzXdhY8kN2NWlNrZ/LDL9oZI=;
 b=MSPUuapOqxiWuk4UymyAcvI8Z2tdW6qAAX+nmqj3Qk+oj6EniQB4zBqtFHGMk6NA2v8Qo/eQVM57bttX8zeflbuIJ7B0wNfUYYWtdO3vArks97hZlDuN+vDmT8tTVNFCgH1RG73sJHxsa3xACTotzoDDwhJvo+ohP5D0g0/JhZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7805.eurprd04.prod.outlook.com (2603:10a6:102:c2::12)
 by PA4PR04MB7805.eurprd04.prod.outlook.com (2603:10a6:102:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 21:19:49 +0000
Received: from PA4PR04MB7805.eurprd04.prod.outlook.com
 (fe80::b00c:ebe7:146d:f9bf%4) by PA4PR04MB7805.eurprd04.prod.outlook.com
 (fe80::b00c:ebe7:146d:f9bf%4) with TransportReplication id Version 15.20
 (Build 7362.26); Thu, 7 Mar 2024 21:19:49 +0000
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aba22f4-669a-448d-a139-08dc3eccaaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ha7s3Z2VPF5RF3bAEl7AtCkIt8QaLMn7mcc5Bz+W5x0AD947Ws0p2XX8lvz0zGK+gA7vwwt1gjFIB0m0MkGfm/YUyJqWl6WR3jF8yhOYvZKo1cu1TL50lRHoscQ32BWh43sY+UYxJ8OmhFSDyT5iiV4QQ6jDnZWTR+GXmB5SUZYZeIpP8LTz6o5dGd5zM5W/6YAff1+FoGWMtX/Quu89I248yvdQr8uVvYqghdD7eJOwUMBjvlf8FqxW9gds8YdiHS6lAN87hsiL9Va8CCHbT+tulBs4F63Udm2gVHU0llcXJLIDYk74M76ooFfI9q/EpwKyehh8t84p5TIfCZEKEfGz3EqujFiRJmAwPNrDvw3DE1NKhf/YxU7vMLGe/8QYF2kz55pIfiTz41sDwcejlev8fQ1NEb+PVCeIdakJ61ppZgDQi8JEgflRaFoY/lNyyoy3sPgyTdWxTXlTzkg/FHuOD2ZZdRejo+ERTkHvjnd6+XkAd/B4PjUKdbKUkdjtgrUIp/efTEGyco46P+HqbIjg30fv1kxqHG8bLBPAv0o7giJNqxI9IbjMEm1zhbOxaKj1w7++pNzB/f8SH5NcB+m9+tQINFP+O1lLit8BDunSZj2Fn/VX0Iipf0Wku1NGOsBngm0fTxZmDK8U7YzQnq4h8VFYKGc8OBoXC+wMFC+DVgTlHtfyZQFUNRJ2t/9sdtChN3TsM3OQUZvkgiAbiQze4UAP//rYdMOscC7CVIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7805.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmNjWi9zdnRsVW5RNHA2bFFvSDhDVi9YSkhaa3ljTURpNlJneUR4eGI5bkd0?=
 =?utf-8?B?Y3ZvN2NmV3BWL0sveWFSaDFzQ3lYS0JNNm1yMEo1b2hGY0tIeGRBYXBPTWFl?=
 =?utf-8?B?amNlMTdiNzlyNVVCUGtxZHVGRTdxWElGZTV4YVNDenpzS2xycTNEZWp5MFZM?=
 =?utf-8?B?OEN3L0ZxWkZLMnZBZ3p6aDl2ZXJrd3BSTnRXSU5ycFhnZGtNQnFVeFBzZjhD?=
 =?utf-8?B?S2wxcEZtQ3l5TjI2SFlYMHNFakVpUkE4K1ZKV0ZtR2JrMllsc0pzUnNaczZX?=
 =?utf-8?B?Ymw4dGhpdFV0YjNHVmRYMVVUOFllWEpxY1owbTM1Zjc0aUN5UkRFcndjRmRT?=
 =?utf-8?B?S2padkNQT013S2VjbERkR253SU1HUE9xY2JtcjNGaEQyU2lXdnBGdENKREFH?=
 =?utf-8?B?T0U3Z0I3amFmMC8rRjBWK0pzMjlpdVBoMVNUUjdaU3BybVpqNVFhdmJyVW1X?=
 =?utf-8?B?ak4yMC9PTGk2YXpRdC93UjJmTmR4RUxsMllsSi8yOXE1VUFtakZTbkpPNjdU?=
 =?utf-8?B?ZCtZMUNMMytsUlpjVm9NT3gwT1JPeFRDbUVrN3k0SGQ3dXM3VUxQT2hqQW12?=
 =?utf-8?B?VXo0bTVhbmFoZzB1SUllVmRnOFlwc3JQdGZiMTF1OWpYUVdkOFdvTGdrQ0k3?=
 =?utf-8?B?c2lWWVUraDRtZUQ0aFRVZER0ZVNJSTl4VE5lVFkyVEdsTmhEYndDZW1weFBZ?=
 =?utf-8?B?QXlRejM4UnUwcXR4RmJOdWZaOUx2WjNkWlV2S0JkaGNaMDZieUZ2MEkvbUFU?=
 =?utf-8?B?MGE1ZzNpNDVzOVYzRDFjRStCdEhLNXQyOW9td0dadDFUNWcvblUxY002YzZo?=
 =?utf-8?B?dWIzMEZ1L09YQzFmS3BRenZFOHdvbnY3TmlCMDFvNktrWjBsUk1CejRLSGxT?=
 =?utf-8?B?OUhad3F4b3N6SUFMWkcra2pJZWxhK3FvNk9vYWxlZjNkV1FiOGoyd2VBMklz?=
 =?utf-8?B?WUdqVnVxSFR3aDFiQmFqTiswVUg4QXYzSGFUMCtmVE9tM3lQT0xaOWRXUlE3?=
 =?utf-8?B?Z0ZzclI3Sis3Qldrck5wUDQ3V3ZSRkdJWlhjdkVvTnhqbXFBV2FJS2plQ1Vo?=
 =?utf-8?B?MmhNQytsWnpLTmdSaGdwTWFMYytqa3gxMHJMdHJ1S09IOHVyMDZYZ0ZwRGIw?=
 =?utf-8?B?bkRLZzczeXI2YVJxb01hSlROM1MvT3dCMy9IV1M3S1ZrVlU0RjZqZDV1Z2ZN?=
 =?utf-8?B?aG9La0ZZQlpHRWRwUm92eUEyQ1JUQktkU3R5OS91ZmNmdjJzRFpadzRobGYz?=
 =?utf-8?B?S1dESFR3d015d1ovNW9jei9TdHFPdVRxbm90cXA5VC93VVYyR0R2bkVGZnl4?=
 =?utf-8?B?ZWZ5dmZyTzhOYkNCLzZTb081ZDBSaEVOTFRRYTBhdFdZWTVjMVVBWWFZcVd4?=
 =?utf-8?B?dW1pWUs2cEFlNy9wWEhQOVV4cGhFMzR6UmtFWlJvYTJpR2tjNkpKWmx5U09t?=
 =?utf-8?B?alNPbmxpcUxkYWgyZGJsQVBVWW5qQ2FSRGRNU1lCSnkxWEU4RFY3Wm5DQVhV?=
 =?utf-8?B?V2JTSEFnZ2VQUXhPcUcveTRkQloxUDF2WHUyVlM1emxJcXRRNHcvT3p4a1Yw?=
 =?utf-8?B?NnE1Uml0NG1OT2d2Vmt4SzJlM0NJbVJpa05SblVoSWNoTWpaMUpHY3FBZU9t?=
 =?utf-8?B?QTc2SVhneWUvMjJYYVF3STN1RlNWa0dEaTBRaCtRR2UyUlJ5dkpyT3A1ZWU3?=
 =?utf-8?B?ZG1XZlBTc3c1UDhjMXh4bnFHL21JSFBtdFh0MlNwZDJlWDFnOUUyWFdNTlNm?=
 =?utf-8?B?UHlPRkh6aVJmcFk1Mnp4TGFSVUZ5OGgzZFZHL1dNNmRGcFN3WVBGck05RVhY?=
 =?utf-8?B?bFlheU96VS84NjBxTHVOVHV5NzdjNU1ucEYxWGJPbEZBOUhQUi9OakJlaHVG?=
 =?utf-8?B?ZnQ2d2hISDYvU0V2M3U3OXJhU3JDUlBEdEpQek9IOEt3Q2ZsQ2FEc0VPU1N6?=
 =?utf-8?B?RFordnIrWExaWmFrckRiNUhUeHFKWHZBWCs2YzZkQ3ZNT0k3Q1ZUZ1FzZmc1?=
 =?utf-8?B?THQwNy9IMnBXcEVxcXNPNHZEUGtOdURpMExWcWRId01KOUI2cWNwbXN1amlm?=
 =?utf-8?B?b1U0Umg5Qkc2Z0E0bkdibDlSbTlGS21xSDJNYitiby9iUGljMHJMMXA5a2pt?=
 =?utf-8?Q?yxJgxNduEiq9e0/THyM3+CVv8?=
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
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7805

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


