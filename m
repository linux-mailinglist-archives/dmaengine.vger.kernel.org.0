Return-Path: <dmaengine+bounces-4045-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEBA9F8A0A
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 03:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E29C16967D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2024 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD0A179BD;
	Fri, 20 Dec 2024 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKKB2ti1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328E259494;
	Fri, 20 Dec 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660716; cv=fail; b=Um+lRQxq/To54EypB1tg4a41TldOH5hnX7cVpKv9iISnJHOkK7HLlh+q44mH/XtQ+JUdenBHkQCMUmex+cXOEq4w2domKGTtIIt0hVu8fda1lSdoqsfy4Q2Qz/bNtwe4WcC+iNZtElCyTwVmQ08EwKPR8KzFqey9GLSlsUzT/7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660716; c=relaxed/simple;
	bh=wFpxUicdgO7eCfpQjZvFwMtYVYUxyGLSsCibfWZl0es=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=icULt7CIFpLS/iYDZtL30j89vyPha3kH79byMdF0VYqpGisa8iXhOsQPwl36Bc+GQNI9deBnxdcq4qpGkSsAFjnqgj2iJqvO8NXXGnG29AAQfRQnyjwkrnT1t3IwrpI+ir0b8+uUt0YGqIDaubPwo1k/b0GnuQ6W01fKAiRAf7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TKKB2ti1; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEWpildQQmwwWvir/Cw5LHL+ZoSMhxrNrRDbWLOPQTKwh9yl6Q7uNHHCspqbSZT8dVMR9zEIuvQeEIgnEp/fLNiMb+EeF1XxYe7cDp0VOp/dqdarIicxoGmwxdh9RICYxG+N6sgNYB6qH1jgulhhGXY5cH1uUtM9iRHiTarpUog7xTS5gtjg7gv5dvT8NVrfwl3Nvk9emAZZQup7MqXmwoZsfpW/LFKBGNzwRt/XLkE8lqMyC/rIipp6LwJXIoDg+YjVodeoH4EeIDedt873MEyia0F9eBGd4a3fWqpG/V8AI2qkLtIhAY5ocvHal7ifBnk29MoxXH8Y3DxkLA/UDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHmyHCNLQ3IpaWusqGtA45cV2HbIeB3HMirXPIDdU74=;
 b=MuwHtFo1dXN055Oz8EQ3M+j6fy0PVAG9J0JZav0nVzBGAUSTVu4bT/LUjjojboavFpModaxf7+dHNLBzEuBPClNKt3eMs0naLYq57ze22pdsdwnVO2KsySIb72HoohijOWSyfTaQVUP7Td3XTwaMFJxBbwq/P7ajZDpGncGGTZ/q9/WQ+EG/uRtgRncJjSi4jCBJn/qQ8oOKhG2Z/oNbzunjhNQH/4PGe9mZ3/Fx9Ts9BDH94C9D68Both9jkiyNfc01yatkhTckFkKVqMKFxoF+reeP3UCIV0P5Jk8l7yTn8n5xVjILLKUCtYTFgGiAOyDRqbUQMJVuxX02R3Y6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHmyHCNLQ3IpaWusqGtA45cV2HbIeB3HMirXPIDdU74=;
 b=TKKB2ti1LES0pSco5wQ7vxx3A2i9uCmMTmgCd+AZQBrRwotSgiebu5LP1CuxQOMXdjkZm14EhCbc3iWZdXnLEK8b4+dP71DbgFrmUvdC51Bza521/GC6jlR+D4vr8znasmjXYYwThdl3+acIZsrWIlVmzz9bCPyQHy5bhxgRNgLi7jCxlkgL6/p6dO/M1HPfygD0I6Z+oMzFkpKO14jI83EtTmiJ86/ZLh7ll+nzfLUdogAjDQ+FQuRaNoleK+KoFU28zNUdzoTScoR9ecTVz4R7Vv5K2pBq3SRFkH1MjnLBX/Kn+D2si6iSZ+/2BCl65GBjlsZQxHZqmBiEcsYI3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:11:50 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 02:11:50 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org,
	shengjiu.wang@nxp.com
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: fsl-edma: add runtime suspend/resume support
Date: Fri, 20 Dec 2024 10:11:09 +0800
Message-Id: <20241220021109.2102294-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd83313-8787-4912-b8b2-08dd209baa14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+Ru3ALe4GBz0UW5yAvhTRIEMpB6WzVXIt+F9oK5qOhPZx74H0GptT72ZmvX?=
 =?us-ascii?Q?oIgelfOxI+WrM9G+aanTkT9jIEF5B4EAvZ6TjOqqa/bZ6kcBAC0UaLe88Zjm?=
 =?us-ascii?Q?8tUTehmNLk5S1GOslmVskVzkos2Na3CmyJxy8ljFzVMl99apLggkCF4okJGq?=
 =?us-ascii?Q?xgkASI6MqkrDuu4EOqc26UCgtjNGPEMi5UPEpnN+fYzZxm0NZj3MIe0P7qIL?=
 =?us-ascii?Q?Me+jEgzBd/nrWzlg2W7JS0hgitysNg8OILm4QICAXxKp2bwpUfMJx3eP3rTj?=
 =?us-ascii?Q?K7OUfxHNrYlsu6Eaiyaht6ua8GM75BsVeCcQNHR5ielWuowLfdhsKVxxtfR7?=
 =?us-ascii?Q?TDuuOv7Ei40Dl11tQSMLDbfdwcDisRsyDK28tuVGx7Fr+9NEA/zHA4JjKW/u?=
 =?us-ascii?Q?srcGgIDUyRx0SZ8DwSYzv7xk0egOXbA06Rkpcg8h81u16LPTLSsU3tKu1f2h?=
 =?us-ascii?Q?FwCDxQ8xuJYX4jPFr+gbzSIHlmom75zSoNDE7skIWWD/qE4BP7DnUXM5yOB8?=
 =?us-ascii?Q?WmHPXNRf96SGm3uJ6x5l88PW/dHCItFmaT60uKE4eK8PLJwBcBdSs0l7vOAC?=
 =?us-ascii?Q?CmD4rMZ47Zwl2P+wGkniJA/ONAxgl4WnUCnMc/BJAWK46hj1hmvf/WJfwj8E?=
 =?us-ascii?Q?kvSU1V4mmQECXmnsr2Kr802L+QjKQRCrhvyshv4WN7dtWaLqLqJujWs8n+bQ?=
 =?us-ascii?Q?TBPq3USl7iDYYeaFpMG6bBqL+5H+/tMYEv5TaTkYWvhuBR4rAsMjmT9P5lJ3?=
 =?us-ascii?Q?l9+gHnwgcfEFjeyMr2i1T5LYnN3VF5KDRanTmimR3yHMYmmCZYB853rBRdQ8?=
 =?us-ascii?Q?cUwKqY9AhpLun8cnxpeemCCA7XECdRmP/OYHdtIfZT5hb54i3x6fiz4vNH0I?=
 =?us-ascii?Q?DkmeyVDXDI/23qsjobOKNc93Hq3FrprLvG9Bg74MTQ4bpvUtOQ7WQ5+HZyuk?=
 =?us-ascii?Q?MydbmtjISwGtXSG08gDYf5f2miFxTd5C4OZrSiFwC16YcJkNOz9twCXNjlM1?=
 =?us-ascii?Q?UcLUUN9RsZA8888oeaiMQJNlQhWyrBQM4qdx5ziMvUZLAWyMxXs6YbXORyNu?=
 =?us-ascii?Q?5zWusLsbG+2bmbvc55jewjhB3ciittleMbTr4lDOu780a3c0LyuR5ikENBo5?=
 =?us-ascii?Q?gp55jYtGfFipYNZzotov7PLsSO2W8eWlgR/vourYmhBOagovqKpKClSuYGut?=
 =?us-ascii?Q?L5Sc2m6O0LFQ2pGt0G7ecPf+OPLB8pAKpsPwK/k6XvZmwjJj9TvhDM7Q5XYD?=
 =?us-ascii?Q?6rjb7z3ODJqo90WkiM6sbYjAb0qyehmTez2JCTN/fPKuX2XGzOaYdzAn/Ckq?=
 =?us-ascii?Q?AedVFHgDzkAIj1w4MP4xq9DPhcS/EM7dbGM0FwPCHGo2VMIH9lZvss1yE3OI?=
 =?us-ascii?Q?oqIXgOG5iJGs7VhjwwQ+M5J64Dmz0on7RzB0NfmaukVsIlE2DRIltczmSE0f?=
 =?us-ascii?Q?KpVK+dJQJEX9htJdgGUmWr0+cbPC4vOF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9TVhTmw36ApPqoRD20qM/8NNBm4Y5X2uTmicUXCqVb6Ta61j/j1bjaFJ1Ga?=
 =?us-ascii?Q?SD/pEwm8/hAH4AE6UB+nOB+gp1tKCg6KxBk1UiajtKgUteFT/qFLZGx9/smW?=
 =?us-ascii?Q?nLyuHDtsFkGags4JL6yWKBUXu/5hg3fb20RHAeGzNtf8alVwQOeMA7M5SPF1?=
 =?us-ascii?Q?/yIwfSW1hFo+a3e8+BkVcqSukKXLGIYgKJ40iAGc5rg084BaZ28MJTmmipPN?=
 =?us-ascii?Q?2iAzJx7Y+6XW3eIbUE5US9bc9OTqfQX5aOg3WC0OYrFQmqDR+f2h5noJw9yo?=
 =?us-ascii?Q?3exT65ZD+DljXR1FaJM5DaISpFCC9xDHpllgoMITl3Z+fVo8t8hM++bQJM8U?=
 =?us-ascii?Q?tSOSIkaZrjkIfhrv8n3DUa7GFEtAYwVcirGOeYhmKvrxJTjwqKiAHkcHSmPC?=
 =?us-ascii?Q?OpaW28ee7GRWWJ5cdD7q8cQuEoSVUAq3fdgd/ppyUMBLx4MPFNmJTb43oBQg?=
 =?us-ascii?Q?+7fDqQLixbrQgAN2PTeqQDeOiZcfSQ2m4LkJAtLBDWJDdxDfc3pRWc97wCsX?=
 =?us-ascii?Q?uvWY9FPIa1LgYELAtt0yrqgpKIsP6xn3/BKbVIlfy5m4/wA+fJv44bSW4kgB?=
 =?us-ascii?Q?Vw7FBm15L18Qxvj1mqMZ2/xDQyL7Ur4Fdvc3tVaBrIJG57OBtzFmciSvkxPC?=
 =?us-ascii?Q?q00485Amk467MRRSwztY7lLYVsqTHM1cImzwyQENM5ii/pIvfDPt8Nr36wye?=
 =?us-ascii?Q?w0Y3WVmwFZB4myMtLwAUHhdQyHtlYoohVEi3fy7HdUDQiQM5sHb+jIeyrTem?=
 =?us-ascii?Q?81esVHY9895xHZYejaB7H6lpPaVOXcWR2FIlYQ36N7Xf9BYzGK8wQtxqpw7l?=
 =?us-ascii?Q?eDJH+bSd3iUfLcDS/ivP0WvXI083vn/LtVa1DdkSsG+GvcfOLKJ7l9mzlWkW?=
 =?us-ascii?Q?hCrCJcQM3LkYmeiX3ifaOZqKECDfKYM6IYVcgQGLoTHf9hXZeTOf/m0Z/bOq?=
 =?us-ascii?Q?QA/paU7QwRJ8v0vhZpOOFr4FSXBQ8+qA/VLU2u32S04vvsXw0l8Gh2ehDz/N?=
 =?us-ascii?Q?9Iro/cGwkighpmV8PM8cYKn9aVBCbhUD30GxGqApZ7oEGBNDqXXjfAcnrKEH?=
 =?us-ascii?Q?RgMBoYxZW18+h5MP0ErJ2ZKxP5lDhUZpVZI9Y4RwONRS/owggOQ9Y3m4xt+n?=
 =?us-ascii?Q?pcVk5G869gzuwlfrzC+DEuAyOS0DtpmbUKoRa7r2VjQSpACp0RQImmx9BV/+?=
 =?us-ascii?Q?wyOwLBW7ZfmMnCJTBo53Vauj9qE21YREz3bLTDFyd9ZihfADtDLrYMO1QGas?=
 =?us-ascii?Q?rT1w9xZZztzFTgf+jiupv2E/qFv2tTpE+FC+VVQ8zkB47SrJF0jg3KHDbMVW?=
 =?us-ascii?Q?eQrxBWNEV6F+2AgAgW2PUOr/uD4odN+LUUCXYWPtoX0AFn1OhNn7aKOLA2pS?=
 =?us-ascii?Q?ApGk2XztFDmQDEIVZi9UsXp8GBvl/VFZaxrDKoSeqUDq0m9cd3nHc7Q3oyEv?=
 =?us-ascii?Q?qC7/qv/xat0Ahjv96rlRxDDa2jKdRkpI3TUuDp/mo+qH6+Xj1Eby9woc7hce?=
 =?us-ascii?Q?ibpqLDK3nzcPaU7/isuifLzPNPMWbBii274BnH60gkO+vdzEkotQvGVfZuxW?=
 =?us-ascii?Q?H0dW64yOtuqLXIW3iaeHpi9GcBtpJjwH9U+jmMTy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd83313-8787-4912-b8b2-08dd209baa14
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:11:50.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0bvMfjUnCJEKJCGiD0vAmO5X1h6zSpUw/pzfASdk381KnwIthovXwU0bnvCOZ4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

Implement runtime suspend and resume functions for the eDMA engine and
individual channels.

Link per-channel power domain device to eDMA per-channel device instead of
eDMA engine device. So Power Manage framework manage power state of linked
domain device when per-channel device request runtime resume/suspend.

Trigger the eDMA engine's runtime suspend when all channels are suspended,
disabling all common clocks through the runtime PM framework.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  15 ++---
 drivers/dma/fsl-edma-main.c   | 115 ++++++++++++++++++++++++++++++----
 2 files changed, 110 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b7f15ab96855..fcdb53b21f38 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -243,9 +243,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 
@@ -805,8 +802,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret;
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_prepare_enable(fsl_chan->clk);
+	ret = pm_runtime_get_sync(&fsl_chan->vchan.chan.dev->device);
+	if (ret < 0) {
+		dev_err(&fsl_chan->vchan.chan.dev->device, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(&fsl_chan->vchan.chan.dev->device);
+		return ret;
+	}
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
@@ -819,6 +820,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 
 		if (ret) {
 			dma_pool_destroy(fsl_chan->tcd_pool);
+			pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 			return ret;
 		}
 	}
@@ -851,8 +853,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 60de1003193a..75d6c8984c8e 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
 static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	struct fsl_edma_chan *fsl_chan;
-	struct device_link *link;
 	struct device *pd_chan;
 	struct device *dev;
 	int i;
@@ -439,24 +438,39 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 			return -EINVAL;
 		}
 
-		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_RPM_ACTIVE);
-		if (!link) {
-			dev_err(dev, "Failed to add device_link to %d\n", i);
-			return -EINVAL;
-		}
-
 		fsl_chan->pd_dev = pd_chan;
-
-		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
-		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
-		pm_runtime_set_active(fsl_chan->pd_dev);
 	}
 
 	return 0;
 }
 
+/* Per channel dma power domain */
+static int fsl_edma_chan_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+	int ret = 0;
+
+	clk_disable_unprepare(fsl_chan->clk);
+
+	return ret;
+}
+
+static int fsl_edma_chan_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(fsl_chan->clk);
+
+	return ret;
+}
+
+static struct dev_pm_domain fsl_edma_chan_pm_domain = {
+	.ops = {
+		RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
+	}
+};
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -583,10 +597,15 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
+		if (fsl_chan->pd_dev)
+			pm_runtime_get_sync(fsl_chan->pd_dev);
+
 		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
 			clk_disable_unprepare(fsl_chan->clk);
+		if (fsl_chan->pd_dev)
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
@@ -645,6 +664,34 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		struct device *chan_dev;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		chan_dev = &fsl_chan->vchan.chan.dev->device;
+		dev_set_drvdata(chan_dev, fsl_chan);
+		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
+
+		if (fsl_chan->pd_dev) {
+			struct device_link *link;
+
+			link = device_link_add(chan_dev, fsl_chan->pd_dev, DL_FLAG_STATELESS |
+									   DL_FLAG_PM_RUNTIME |
+									   DL_FLAG_RPM_ACTIVE);
+			if (!link)
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "Failed to add device_link to %d\n", i);
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+		}
+
+		pm_runtime_enable(chan_dev);
+	}
+
 	ret = of_dma_controller_register(np,
 			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
 			fsl_edma);
@@ -685,6 +732,13 @@ static int fsl_edma_suspend_late(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
@@ -711,6 +765,13 @@ static int fsl_edma_resume_early(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->srcid != 0)
@@ -723,6 +784,33 @@ static int fsl_edma_resume_early(struct device *dev)
 	return 0;
 }
 
+/* edma engine runtime system/resume */
+static int fsl_edma_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
+		clk_disable_unprepare(fsl_edma->muxclk[i]);
+
+	clk_disable_unprepare(fsl_edma->dmaclk);
+
+	return 0;
+}
+
+static int fsl_edma_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
+		clk_prepare_enable(fsl_edma->muxclk[i]);
+
+	clk_prepare_enable(fsl_edma->dmaclk);
+
+	return 0;
+}
+
 /*
  * eDMA provides the service to others, so it should be suspend late
  * and resume early. When eDMA suspend, all of the clients should stop
@@ -731,6 +819,7 @@ static int fsl_edma_resume_early(struct device *dev)
 static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.suspend_late   = fsl_edma_suspend_late,
 	.resume_early   = fsl_edma_resume_early,
+	 RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
 };
 
 static struct platform_driver fsl_edma_driver = {
-- 
2.37.1


