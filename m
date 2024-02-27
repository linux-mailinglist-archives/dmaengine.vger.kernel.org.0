Return-Path: <dmaengine+bounces-1139-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B828869D84
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1971C237E8
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D164F5EC;
	Tue, 27 Feb 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sjoFHTA9"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097B14F996;
	Tue, 27 Feb 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054551; cv=fail; b=CIbyQxN7nyxAOw3Hx3dFDqkblfeI7nooNunlY3MulSwuFLLCXow+wZPIaHPtVmZXnB/agTL4YSpr+vIEMD8UnCS9kkgsP6u/HYPubsGrJD2xwoJsCBDkMu5mCCutadV6CrHHYWlLXyhb0ntNN1y+mi9Tk/006E/u6x4PREImWyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054551; c=relaxed/simple;
	bh=sVHqn6H+sRc+UeESOOt1xPOX/umNA7g2fhLtywnubOI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YZKPv5DcONGgPBbxVCwkfrrWu5UgJmNWR2a3mCvqwhtfbTqcJY2Y5SQxh2bVyweZOW3BFiZw8a0yX3KiuFQDxKyDHdOlWgIQ7sfPdF+CoyrnIpw+kSHj5mbvbXVYAkbnJOywVP8eyelJZSjYaMCjnxst0wcM8zl1pnotbWt4MQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sjoFHTA9; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPp6ZYQaU8aK5aRRMqb8zgMyeB3QAwQtCYd0RQupr3MmwiuOJeEcyPlzQjJYbiVrSwt10rH1wGdKAuHI7+I9ikoTg4rekRFpHqgtn2tm5eFyQa4OQhH6K6PQcaf4yAUGDAwsP2ckrNwN238LrM6LOzGEhfXCoBEU00vlgFfu29LdU27WItY8bvlbyWq/8CKkUIWdyhUJ5DmiYwZ4Wh0hvw4yf/Py/LI3FBPV6O+S74XboRDeHtCzycS3z0Qzy7XMgRPtPrAc0+WUlpbsY5M3XE3uQG6YuBAYgaE0R9etEqh51bWxqwYeDqk9rTXRMTkzWj6iebv9jMV6rHwAQE/gGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xiz0Rtwc5CT1HzkoGwV9jE8Y6y1f6whfBWTv6CN9GT8=;
 b=BrEZToLtSS5uQuV1QsOTTPqxAh5h5+z5OOTXWce+xjV8MRNW/urKSt3bi8b2LY+7Iy/z+c/ovOBEn7oc7GtV+3w7nH/Y4cG851D6lQPTA+XNiv6GGWdnuh5hmxpgHznkmppoPWwm4iIHhX14cyz89O/FZa5lAYfCLIDfxMRZs4YAajZgFu2cuFWhGQI3ff8LWy+ykvz+ff9yB3t/C2YYkFTKxeId0sPvg2jsCUQ/7aHNyzsCvNMe3wzHXzHGV3p6+qL9p4HnR0Tcyv8WbQBn9bABA9A1N1z1ed2+w5E3+6vDRAhRx+9ji6RiYDD+5bJPvTgOv8VfsNV31Tr6djTS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xiz0Rtwc5CT1HzkoGwV9jE8Y6y1f6whfBWTv6CN9GT8=;
 b=sjoFHTA9pEtmEZaHhTfblPXNgUYZlfNT3MSjV4YtLoB29o/coVkq6kpHabQe7yObJeF8xDMHjJeLPorOISRXtLdC3sei8wF1K3GGpeJ+ACPAK/C4cnWlaMn+qeKcuiskCp98UgqEaZMKm+IrNDKrNoSwg+unS4fGdvzy1Ov96jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 17:22:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:22:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 12:21:57 -0500
Subject: [PATCH 5/5] dmaengine: fsl-edma: add i.MX8ULP edma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-8ulp_edma-v1-5-7fcfe1e265c2@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
In-Reply-To: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709054529; l=4648;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mZwQhUw7aTNjqUrbP8MTrIFtWNHaiIzM6PH4ott4At8=;
 b=32fZs/BoUq6FgwF3ehMYDXUqeS+dYDwR6nmJEohFku+B08QJtrLumrdeHlpC78Mwo6o8x6Hie
 2578i5CqksrBcTZQd6XihtkMXzjzIdL8xfYQlLl4WebwSWltE1oWUhs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b578e85-6f1a-4ec6-165a-08dc37b8ab09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQTxf46dAKi/h46gt02ViiY3MZEuhCTzfp2/ohsIyIhuOY2YPg4TkzhITVH9XESCyuvKSbxnSPGEOu+opA9cIw8mxmuoYzlmCjapMuqRrfdj7UC7180y1nlvNMZMFbyXV5lk6zh3g6F21NyWIG12trKwiLXyAsHYMpxFVBJGrE73UmOZoEinkAtkWvOaDxWlGqKSqj/fuucYxGJznkijnYexextwF81H1GlD6yiEnoCLXggjI/jFLIJTpN3XFfW94IJ1rxdp45rKcCJFO8elT6Lm+nblTqTVzIZx9Pw1ag8GitLL+yfWsnUx4j8NHiTOubQARfhtyp4ZdH9e+fogj8r9netFF5B6NSJ+31oV43xEfD/bKQ30SCSuAwbLtLZ9eW5Adbp5vg1yBvbn+1rT9BTSS8Bv/8YEW1U/x4lS6ycCtpEtnC13DP3c8kVsAukMf2qYNdSWeyg49rAwGEkJlk5RheVm28fsup9AsItWaXeuw+ZnaOdqGm+bZVoIuu8gglmeKqYsDMEGU5TJVyoNxxvXUWEkT9iOZpxVDlevGPTUKsKmu5lts1FPbGaIOPViMercSIzMHpBR6pOZoXXEpPARA3vbTe8EExeU0yCSCVcJxqKq0bnBPyI4fpldxQVZbCwGgpx6qJKKYXiKhS8X5dLTOErrCT/4W31hsNoebN7kEWwmzf3futnDAziMIlLMtipphsDEmjLRTp2qkEf1gzRY37BeOIE+ac9q2pa0uzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFNDTWlKUjhIZ1ExUlBjMzV5V1F3WC80TFkzcmJLK2ZrcStTZzJLN1NIOVh0?=
 =?utf-8?B?dWQ4TWdrOWo4SzYzT0ZQNCtXVUU1emg0TDFJTFMzeVA4QzdHdTlWbnFzTWxK?=
 =?utf-8?B?UGltWGxIcHMxQW1aZDZKWnZScit5azcvOGtOdlg0NGNla2dxWEllSXhPVWF3?=
 =?utf-8?B?NEZsWlhLSkVZd05rNVpEaE9jajRJSktOTUtLRWJuQWFEUjhuSGgzVktVOUQz?=
 =?utf-8?B?MWdhemtkZXQyOXp4R055dVVBMW14NjA5VitvY3llRTdaK2Y3aHo2cEJ2aUlJ?=
 =?utf-8?B?d3FiNk1yZ1RkOUVMMWQ3MGsxbkx2SjZ3Z01aMkJiOVd3ZWtWdGtVMjJuc2Zo?=
 =?utf-8?B?cUZ0NE1FQlgxbzRER3dxSndPYkdHdjY4Y0lNcy9ZTDVsNVdpTFdvc25LbW5C?=
 =?utf-8?B?eFRMeWlFSWJPWUx0SHdPSFI2Wmc4ZWo0Q0gyVzNqTFArNmRMazdudS9qZDM0?=
 =?utf-8?B?ZU96ZDZoRWtvdkdDYWMxOTQ2ZW1oSjdLTGNONXhCK2ZTZlFqWFJqOEJKTmVZ?=
 =?utf-8?B?Ymt3M0lQQkdMTFJVSDdjTFVXbWcrRHhZM1VXRWp5eGlPUVV1aDVFWDUyRmJk?=
 =?utf-8?B?eU9KV0Y2RStuUm5IbkZOVU5tVXZBb040WXNqVmNxTmJSamo5emNlYnhaekdX?=
 =?utf-8?B?R3pwTnNzRmlSM2h6M2F2d3RSNWdJZXhXNXhQd2E1MHNyOXptT0QxbEx3Z1Bs?=
 =?utf-8?B?Z1NTVmYxSHBoOGtzaEtBVzFKclBLY2JMelpNUm9JaFJLMTBNM1FLWThITzRV?=
 =?utf-8?B?ZHhvMmdDbzFjUUlKOVJPRk1XbEx2TGh3MnFBTlkyNnB4RzZuMk5vTVJjeDdT?=
 =?utf-8?B?U2VxenJJMk90QXJ2M3MzYWd1K3VQT3FOaHBrUzEwMnQ4eW5hOXd2aDBEdFNZ?=
 =?utf-8?B?L0xNWHc3L2hRYlFrclVuWVRDY0wrcGdRc2dPNUFCSk4xTk5OcE84SzlTd29T?=
 =?utf-8?B?Q1M4YUNOMyttcE1JaE1CdWMyVmZWUTZKRkZMRFdidzRCa0l6TmZIaUJac3BE?=
 =?utf-8?B?ejZmbGpXc3BvNHRwbHU1dVoyejcwQ1Z6Z004eVppbWFJSFI0R2ZhRnpzeFQr?=
 =?utf-8?B?TklIVVFsNkhpZHBDaTVMamFsQk1yeVZ3eUU5WWhJR3h0WHNvaExXU2xpZGYx?=
 =?utf-8?B?dWdnaDhlV1JsZkZDMVlCMFdJMVFScUxoYkUwb1l0dHVteFUySHV1L2IwcVUr?=
 =?utf-8?B?SnhlNjFzM0dxQ1duK29iSlgwOTV6MllzTC9TcDFCT0I2ZlJGZ0tvV2xlTGNI?=
 =?utf-8?B?OXpTNU9iMk4wWC9XQ1N0WFBFR212RVJYZmdYWXJVYkdWSVJMa21VV0VXcVRp?=
 =?utf-8?B?dEt6WUQ3ZzZLbzczZ0dtQWFaMjRBWXRDNis1anpxL0pqQURMMVRCd0ZCVHRw?=
 =?utf-8?B?cG82b0l2bGlIYTh3bWZZMEl0eURidGRNYkJPeERGTVFGR1crUFVVdU9xOEUx?=
 =?utf-8?B?d1ZISFVlOG02WTBQY2ZPS3JIMkgwYlRYN1ZsVGV6YmlFdTh4K2JvcHZTVm1n?=
 =?utf-8?B?ZHZueFJNa25nbWlJei9kRkxLV2lrSWtxbHZOanYwaDYxZmtuTTFWb2E0Rnlv?=
 =?utf-8?B?OUpYUGJ5K3RoQWYwK1dPWDYreCtweVFmTGFLcWRET21LZjJUWVR4SkR2c3VB?=
 =?utf-8?B?NFpHakh4dEx5L01DWkg3dWRZMmRwcXdxNHhWYTJDZUtNM1M0ZndZNExaRkVj?=
 =?utf-8?B?a09CejVHTFM4eUNhWnFWZk12d1ZWWmx2YVAvNUVrbnFLbDMzVWJmTktQQ3hM?=
 =?utf-8?B?UFkvb1VZRlNudGgydnhOYXZJaFBWc010aDdaUkQ2RCtFQStjd0F0Z3BBdzgx?=
 =?utf-8?B?M1N5azVWemtBZXl2dHFIMWlUOEtyaGtlSzJ5S1U2bGJkTk05K2gwbk9rS1p6?=
 =?utf-8?B?bEY5VUwyQURVcWQzMFZpWEtQMGRZMU8yWFo0N1NFWVlOYmI4VGRLZkdVWk1O?=
 =?utf-8?B?Vk9Pb3p6THlMdXNJbUZkZ2JPUmZtRXlCbk9meDFYR0lhNURNY0lKY2dWOGor?=
 =?utf-8?B?ZmdNbytNbU5tRHhKakV3NGZnTC8yU0ZtMVlwMjRpNlczZVRiKzY3VlRPZ29W?=
 =?utf-8?B?N3BsVDZWbzh5UklNclV3MUwzR0hOODF6VDBBT3Z5dk1ocXRUeVdIS1B5bkdh?=
 =?utf-8?Q?0h88dwATJWEfxSX1yPcKtmKDe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b578e85-6f1a-4ec6-165a-08dc37b8ab09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:22:26.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXcdlwG3XPSzEWoatWTfzn02cB4fUfQALFLkDFdD93zyJ2m2Y4kD/Ix15CdgRUd4kH/eiV/EAvJpAfebXuFOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408

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
index 41c71c360ff1f..0837535aa7548 100644
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
+			snprintf(clk_name, sizeof(clk_name), "CH%02d-clk", i);
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


