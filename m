Return-Path: <dmaengine+bounces-1478-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C87887943
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8996EB22336
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B2D59141;
	Sat, 23 Mar 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lF+J4J9W"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05205788B;
	Sat, 23 Mar 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208131; cv=fail; b=rsgL0ybEKoP5VN2s7m4+/xbQgkhahzuwnN+EQbZ5dnxBT8DAdXz1T4yBTjLWcL1hlipx8sltELNlAs7114VkKMuQdFVQo3/CgQ5ASSuNY2fJxj24cQeL18K4/oHDZ+RSYh/sv6WDqWByFzFhm+7TXpIE1NgbHsNpxVUH5GakXY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208131; c=relaxed/simple;
	bh=8eI9Fc7v/8q6cY8qBofpxebszDcOATofWW0mh+BZOmk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pDHlDAfW5QPkxvuNk9bd5YebGvLN9nAur+WDlzY6zPhj8zNDvdHgYqc3bcYO0AqduHAmapghcqds/HiZoHO/2x90YwS17DSjK1SuMDvzTrPndxf5zjmLjj1t2HRg2X56AP27iw109m8IEGxXE34u7BlMQvutZrj5hC7ryOJuGcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lF+J4J9W; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPHqdrsQkg0cLnsW+xIw8RXqCCysb6REL4RpctW8rF3AAdXI4CursDpESiscjuO4IfankyeDAWOe8/OlwnJRhVZH4GbPBrrq61nx/x81epmmxufmQ2yhp50wZ+vwIOsrIMUeB+u/+UNG4f4XeRISyQHM/QCefxEZ9rgbPW0LrN5xA1BwJXmqAPvZvflTcSsfcH+4Gnvpf8+9X0hOsCLGax95xHBz5zRbWGp2H7jcvhbnTFkQe2bfQho42cInIcVZ6hWp2xCoZ/+vvodjgIXVtc20XA928+jCKpRwm19HDWylR6BeGK8U7FCBiz0imfJ8dq6kqysQYF0O0iqPC3P8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG2T4jmo6RJ3jDnBL3dbdXaECokzNHyYBvUVc8YJujA=;
 b=LBhrbGgXlH7nW9PSLe60cl5RyQJvajm3q60O7hzWnYC0nQygec+rDazzaGoI8irqtbBKGl6l8MEOzkLX4EhYHFBdBHrT6cEoassVP5XDUCV9HEt/Tk19cIJVtwnsXSYtT2DgQfYRcU5DkRENu76FrFEn+2K63OX4MWCftSt9luWPjDexwiSyt0y+h65vpU9PeS1Si5d4mTRGb5XBO434PTKBy++9fjauoUzshxelYl8X3X/ZKOMQ3bb5mZlcS426+OiklliJFZkqaDP+ikWIafdJLcvERELkgv+ql3eYp3hLXdV5h/P921tIkdRsJsua871ohlId9O1R8GfKHxuT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG2T4jmo6RJ3jDnBL3dbdXaECokzNHyYBvUVc8YJujA=;
 b=lF+J4J9WthzUpI5umiqlqoffiTzHOgLkd8LqkGEyivBqaH03Wzj2/ShyAhJbc2qw2ONKVnjnk4fnD/F9wpveYot3MjxknPhpVPvmGZPONFglBvqI+wRhOauhq8Xph6dXWprTn1bqFDXeMmFjkNBsvSR5BdtiSCet+rP0XUcXYnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 15:35:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 15:35:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 23 Mar 2024 11:34:54 -0400
Subject: [PATCH v3 5/5] dmaengine: fsl-edma: add i.MX8ULP edma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-8ulp_edma-v3-5-c0e981027c05@nxp.com>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
In-Reply-To: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711208112; l=4644;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rQTmYHe1Hb3Zayn1uN7RFTKdzjmWN287sa/6NJTu2vY=;
 b=PCstv2pDAG2RsBvgVrYibsgBRkDCbPztO/AdnD+dZ1XjG+5S73PRvgVQqMI62y+8Z76E14WGw
 xKet1OkV2B5Cfw936x8OG2Y0SNwU/PQG+THwsTZ6ai8AdURlsQZZ3Jt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fefcb54-21eb-4441-b388-08dc4b4ede10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zLPS/2Y2Kyiw3xAcD5XILMxJf92vPsgZYVac/QLgR0nvnP9u6WNoROTUW36UadsLPQx0T1mgTe/reZsSxahAlT9wNSAwz0BwXmKDY3SxTS0VL7MeSlaa0UCaJu/0sVxw6atST73wvU3PKSjWf8dz4vaOxkGn5RQFUYuSLAmem2Dqz7EQl+PXQep8Lya58B0oPeAUcUmXKVII46bgZ9VX+xhmcv1QgyJgpzfAtQfUXlBs9GwaavQg8js6+kpafyZyDKYkALwKHTyCZPTbRHUe7yyBi2mttU5lsb4yVXb5W2eaoy10HxRaR9RKoxcFmnWzbOa+HpZrMt9SJ6WAAKLWek26Aw8Xfp4d0nIULZCX3OA5e3jed0nHebVJctx7MdWm94qhnIWYiUG8CaxvTm7NP4x5PeaSkbgaIpUptktdP242JeTY/zHy7AhEqlnL8dkyn3rDsz86OUWjzo56MCgs+Y4xBFG8h0QPZbI+k3cZBzRuV+I5uoeac/nnoVjgyNz1K4WAgl2i2ltviMbFjc7mcWLpDLHGfyWXKXv/klwgB8L5dSKTNWgaTejRj/1q1gDZo1iVpdfllL1JDhzxu5VqvBmT1w/UGrHvw/4eLEtZDAzHWlK36+1nAanb7912+aExBdeFAn5kVngKtqeKkuYVI7fvxMNn/h1iX9vT+Rtmhpo1t6Dy/7psmyZJvzLHeWI2XVklZFWdRXY0AZ4tBunVXVTVTfIaVK7u8/aa5D8bbKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2ZWTThCaWdkdjdqUUpFY3NjRGordzViQjhjYmFkVElGV0hoaVdqenc5OVdO?=
 =?utf-8?B?bjJRZmRlMzQrcTY0d1pTOUdYMFhta0lNWFE0RkUxVXprUVhGZDQyR04zMXpV?=
 =?utf-8?B?aitmbjZLY29rWGttdXlJdFhHMjBoYkFTWGZ3cXU0T2xlZzJ4MU4xcXBKUTNy?=
 =?utf-8?B?R0ZRblhmRVduMW93djByTUxCYk12M2hsSEZZMDZRSndzaWNEMy90UjY0Y0lr?=
 =?utf-8?B?dlhqbno3M0ZMWXJHQ3ZnbWhpSlFGZDlkOVN2UEhlUW5vN3BnWWR0WUpKZDZ0?=
 =?utf-8?B?NlduSDZFSzFYMTY4Y2QyeVFEZ3JUL0d5NkZzSEZucnZoU1N4djBJYkQ0clFq?=
 =?utf-8?B?ZC8zZHU0TE03UU9nRzVpVFBCN2NQQVB1NFJMcGJYRzloYkNCYjM5cWtGbGdC?=
 =?utf-8?B?S24vMHJoUHhvYU1aUlFhN3IwMDlPUStucWplRWVzY1VuZ3Bic0RwYnM5eC9L?=
 =?utf-8?B?bXA4TjFJeEMvL0JRSkF1OEVORkpha0VuUDRXK2ptMC9HN3hGRHk1RVczcDdz?=
 =?utf-8?B?Q3JiNXgxSmVVbkVtWXJFcVh0a1h1ZVFkM3FQNEZEcVd6SjRmNi9TUE0yNjlz?=
 =?utf-8?B?OUVvckY3dWtjaE5jaWthQWl2cmFUcVgwcXVYYUN6dmErcVBpaWFUTlZ5Yk0r?=
 =?utf-8?B?U3lNZWEvKys3bFlIc0ROMGQzWkVjM21PYXdwV2NTMFdCU0dtU2RJTkgzem9V?=
 =?utf-8?B?bldZeFZHa2hZbW91MUVidnBvVW43N2VWdlF4VFlTbDl2dnhMSjNxZkFhSW9B?=
 =?utf-8?B?MXBQM1ZXUEkrTDIvQjlMOTNYb3JXMWxEOGFQSFRUUVNhdGZpcmdITkdvYWxo?=
 =?utf-8?B?SHZoSjFwOU05OE5LL1U5OG4zK1BpQ3R1RmY5QmNkUXJuZzZuOW52bWFPd2g5?=
 =?utf-8?B?eGxTMVRlUEgwMi9QR0QwN3NTVTFlMVljWkh0cndSRmhSTFlkK3FoZWw4RnhT?=
 =?utf-8?B?UGxLRlJPVWMreWhxcDZVdGRwMTNRcTk1dUN4MndGQ3pGdTBKRXoyWlF2dEgx?=
 =?utf-8?B?TURwV1FySGorbCs1bHdjK0NFUFdpWWQyeDZwa2xOaldTNzFYQ1VWSE9HMUdZ?=
 =?utf-8?B?ak9mYWxVZStZR2RLZ2w5S0dsY3o5NWFGS3hYc0doR1hKcmlQNU5GajNHSEJ2?=
 =?utf-8?B?cTRMODNyZStaMUg4V1pSdFcyZEI0THNybmEyeURMRW8rWmdQN3dXL2pPYjA2?=
 =?utf-8?B?U1VkUDdoaElwd2RaNXRzcUkzRFdoMU9takU2NGpXd3lmSG1qdTdLd1RlellE?=
 =?utf-8?B?ZEk5Qi8xYU9TZXRzNHcwNmthdmdtZWlyR3k2K2hPRkFPbk5sMWFMdzQ3Qm9L?=
 =?utf-8?B?M05sOHZBRWkzWEFhakVUV3pTcUtZZ3ZsK09aSG9xdnhXVXFJTFZvdTJiMWdP?=
 =?utf-8?B?anJWT3k1Z2EyaEYySmNFQmd4Mmd4WTVaY2ZKbm03ZXJKWklCSzYrdXBBZ0Fo?=
 =?utf-8?B?dWEzcUhpWU5uN2ZUU3ZMK25iWldMdUg4cnFaOTZTaWZ6cWpLNXk4eE8wWXFP?=
 =?utf-8?B?QThQNExFaVhGdSs2dVJjWWVpMU5uS1N4TzN0Z1RNNm4xQStSV3lVcEFwZVFV?=
 =?utf-8?B?V3dJdzEyR012YWd4alZobytoWDFGUExoVGIrYnVYUFVRYVdNNnVwczZSTmt6?=
 =?utf-8?B?bUovSnZJdzNjMVlkbXdhMUNpaGl5azNXaTBZUzUrN3NpSXVNNUZlK1JDQXpS?=
 =?utf-8?B?di9jZW51UUJsamZwVlhrYnpXeS9QQTlBdUxsNUhLU2xtS1MxZkpXOFdmNGJZ?=
 =?utf-8?B?U05XbElLazdMUmJqcjdTdk8vYzN4VDNORjI3YWVQK1ptWjRYVnZ6MHV1YmRq?=
 =?utf-8?B?QjdUSHBjZUNHS0xZTVErY0tka1puam1vYWFuYjRFR1hPR0wvSFRDMk84NSty?=
 =?utf-8?B?alh6VHphV0d0YXFDS3RUQWZsM1IrZjlNSmNFcjVaWXpWRW5kL1gxMXJQSEp2?=
 =?utf-8?B?KzczZTM4QVhNSUplQy9Ybkt6MXNZUllpMVo2NlBNUTRRMysxK1RXU2lqRTdD?=
 =?utf-8?B?ckxqYnJsekE5eWIxVVp2OE5WZzI0NkhIbk9vdWkwZkZ6ckx6S3VJSU4vUTl2?=
 =?utf-8?B?clFqUzRHNWI5M2FGbkIzWE5IZ3FOSXNlMWdkQWZIMXFKMTZPSU95VzhJNFRz?=
 =?utf-8?Q?veHoggkChO/J1AUaZvmOaUUDe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fefcb54-21eb-4441-b388-08dc4b4ede10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 15:35:28.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEHr3WvrkZQknuvPhO7EpTPwGc7usUQJ7kfIlYx7yn9wk/Qv2AmNkUDgZDr+uz9YSLYX8m3vHjo6XI34RzjaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

From: Joy Zou <joy.zou@nxp.com>

Add support for the i.MX8ULP platform to the eDMA driver. Introduce the use
of the correct FSL_EDMA_DRV_HAS_CHCLK flag to handle per-channel clock
configurations.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  6 ++++++
 drivers/dma/fsl-edma-common.h |  1 +
 drivers/dma/fsl-edma-main.c   | 22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b18faa7cfedb9..f9144b0154396 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2013-2014 Freescale Semiconductor, Inc
 // Copyright (c) 2017 Sysam, Angelo Dureghello  <angelo@sysam.it>
 
+#include <linux/clk.h>
 #include <linux/dmapool.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -810,6 +811,9 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
+		clk_prepare_enable(fsl_chan->clk);
+
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
@@ -838,6 +842,8 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
+		clk_disable_unprepare(fsl_chan->clk);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 532f647e540e7..01157912bfd5f 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -192,6 +192,7 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
+#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 /* imx8 QM audio edma remote local swapped */
 #define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 41c71c360ff1f..755a3dc3b0a78 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -356,6 +356,16 @@ static struct fsl_edma_drvdata imx8qm_audio_data = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static struct fsl_edma_drvdata imx8ulp_data = {
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
+		 FSL_EDMA_DRV_EDMA3,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
+	.mux_skip = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
 static struct fsl_edma_drvdata imx93_data3 = {
 	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
 	.chreg_space_sz = 0x10000,
@@ -388,6 +398,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
 	{ .compatible = "fsl,imx8qm-edma", .data = &imx8qm_data},
 	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
+	{ .compatible = "fsl,imx8ulp-edma", .data = &imx8ulp_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
 	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
@@ -441,6 +452,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma;
 	const struct fsl_edma_drvdata *drvdata = NULL;
 	u32 chan_mask[2] = {0, 0};
+	char clk_name[36];
 	struct edma_regs *regs;
 	int chans;
 	int ret, i;
@@ -550,11 +562,21 @@ static int fsl_edma_probe(struct platform_device *pdev)
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
 		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
 
+		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
+			snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
+			fsl_chan->clk = devm_clk_get_enabled(&pdev->dev,
+							     (const char *)clk_name);
+
+			if (IS_ERR(fsl_chan->clk))
+				return PTR_ERR(fsl_chan->clk);
+		}
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
 		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
+		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
+			clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);

-- 
2.34.1


