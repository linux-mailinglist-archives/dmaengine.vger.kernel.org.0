Return-Path: <dmaengine+bounces-1476-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DC88793C
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB701F21B24
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F724535CE;
	Sat, 23 Mar 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QYzvSvt9"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486F4DA14;
	Sat, 23 Mar 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208127; cv=fail; b=tnjm+Ggqf12PH0Nn+X19ygzcmqQ+G/zwhB+ywKlunmVFKx/9ox+ss8VjbkLz4GiUQHmphaSnF/ruXexbz+rteUbCCTzXrk6b+rjyRmllVAJ8IObbrTO3C+nuSjuk2HRCroWu58d9IUBsIJw4wMinJH/o0G5SDeCOa/zK6R8LA9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208127; c=relaxed/simple;
	bh=1SY1nKChJ4s31bmrpysVWazodvllDv9ahLCc/bCrYcQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r4SeVWYUp0OH1vKo9aNhAZJ901mudaOXuTeTLkEUXGdBTMBDBDuLQsYcOWZUZqJAzBctTcDVfrVVgwt8mBpRdm7/C+sg6dAZfk3ISt9LDkCXz3QgfJkUijXZq2/bm4fAFuk6yDD0iYf2ggSWxAX0jZKUeWb1DxGajBPO6R1IiUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QYzvSvt9; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apa85V1ARItm1HjQH7fkVWls12s3h8MZLYBuuqckF8iG9kuz2jiMgrOG3n+tD5sJlG4/UX1NuWc+RXKx1a7I73IYbXUNNS+OCXxHo123akbU6oeiClMJDSsqBzbvDSaGXqE7aGTzn3qsMx1a/tE9uENn+cAghpmoOI2nadTYNys+HVrm5bmmlonYObkfIezqVmt6QzJBlHdALG3HEmoXCs8TtFtD2/t3zhMl5IARZvHVvX9twI14k9DfIN/i/fMYet7yz664/UUQo1L0G8cFK1L24ESWD3RxiEIjlO/b5mCK4/zXHb6xr2JcBPCauEcbp62cx5tFRetpLr7btukcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3UHH8qhH5HTx8E0tLZorZnJnKCrjOdx/qvKkcds5Vg=;
 b=FmprJKJNUMcYD8QNA55sD84WJ+SrNfcytPZDQ1MbuFlmrSgNM0gVqlFWCgF+6nHnH79mNtL+B7OH59vWmKS1fdy4H70uOdIj1+pxJ5522Cb72I/QZaHTEKYTUYg/xJCDZ6Lw7XWBeWEcV2pVIkt9jnHn63UvGa6nmLSE50GLWMVwejpnNf/hqX5cgv7oByePuXGEft37dORsPdbBMMnkm6btVhCEbQknWyEx99Xjw2TsUwGUF5t3t+D4W3XWZtSPKtmBpByYI0scBnpNx0pBKw5+X3t8bbs1Stx7ZgKL3msrgvhKf9sIhZUJAAw+PxAt15F7+XwMURXYtUObVQN6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3UHH8qhH5HTx8E0tLZorZnJnKCrjOdx/qvKkcds5Vg=;
 b=QYzvSvt95FNDjXZjiDYZme3dFDq5X6XjgR6YUxKXZwPSeYMwdkGO1xhPpLbBOsFTMdO/HshpKX6OArkKNgghaEPPCJcJG/vEr81VuDOGC7nIDnakhBw21smNWgWracI6w2At1Y0Si6+AChqOaWnho2v2iUKNyinp1KW6l1lLIw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 15:35:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 15:35:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 23 Mar 2024 11:34:52 -0400
Subject: [PATCH v3 3/5] dmaengine: fsl-edma: clean up chclk and
 FSL_EDMA_DRV_HAS_CHCLK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-8ulp_edma-v3-3-c0e981027c05@nxp.com>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
In-Reply-To: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711208112; l=1717;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1SY1nKChJ4s31bmrpysVWazodvllDv9ahLCc/bCrYcQ=;
 b=EbMQ1Hmzfp2ZeSfzVh+E7pKfhXDUcrvIATEVHmyDfuxcKzaqKqLM2VQhyznRY5Ndjd59tyr4Q
 LC2tght7BQ4Dq/PqUGUlKdRNv3+7vlyj9BuliNAn1qvnoz6yGLXjYcH
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
X-MS-Office365-Filtering-Correlation-Id: f1f056dc-5b46-4275-fe93-08dc4b4edacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwWL6zGmVSWPbQ6G581pwMU/gMT/+Cta8at25MRH+mSk1Q+obsNySMcU8niJmkWRbm2l9GPnKO7vhwmY4/L2IZCCdzkwF39yYRUWWh/GfY2TIQ6RaBUo+rn5gJ153d0LVBVVX7nVVSEl3RIP0p5m7FuqfDEAatYVgwwWom1QO6s8iPJdg0WfF6tdJ0eukdawbFmFhsLOwTUmsEIvcIIvrczSYfByQDAzdpAfcPU67TxIhLyyYXQGxugf7rCfDV/8d8Op6emNp9st8QU262NqpLw4bzGVWitKGY4nihE5sWANKN+DkSU61CN4ZDTmM04Ue56XslrvGesNbod/7rgonCH0KrBYR4acwA89Q/IXgTRXY5OLkIIvFzR324ywJ/O/1f/SsUN0Ir0QqVMTwNxePtTnk36l3NngWUmvZgbHcXzHK1bN9um8RvSMi8H4Fiq7wkgAXtjbK4aGLXsCR/wankgIzcOuZGtxfL0CgQMFNrmm+EmpT/AS7vlLKBMKbR6UwdjlaZqLEXsmBCoMqdO44mIA9Sr95axfZ6KdodTxjk9ILJMLoAP+GUSvpGBQsmZrY0NayhueM8ED+xGor+RIHchhBip9jgBrTHmI0tkdEzykRKr55hT4QIf75wowvDBchffMRWIAe2Ih8b68nHqbEeHsN+5FZD9uiv7JI310FsDn+nokYSxjDntfmTkUloNekstaymOBeHEEn9wl2Yq5ZWHxssmGY5EBFGrCm3DJR0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGdPcVU4YlJOYVhGa2R3NG84clNObVR3bktqbmFHNUd3UGExLzdHZW5SSFp2?=
 =?utf-8?B?RUd4cEl0ZGozekZIU2pGK1BtYXVFT2VpdkMzNzBRWEJocDFGK2Q0S3B1VW5i?=
 =?utf-8?B?S2ljdFRLbTQ5ekt1OGpPNUx1VnZUOHZSTklNdGVoZGYrS3hScm9peVdTQ3pB?=
 =?utf-8?B?SDRsdkc3TmYxZUtuc25ETkhKOE5wM0F2MXVaUEgvOUlXY3BWa1hGSU9JdGM4?=
 =?utf-8?B?UzVxSVhIeGZ5cXh1Wit1cVRUWVZ0bFBHMS9XR3paUFQwc1NISGdtdjJnc0lv?=
 =?utf-8?B?dmZmMk04ZzJUL2NjbHhqbWZ2YzZScW1aUXhJYzhrZHAyaHJldG5ESllRUlQw?=
 =?utf-8?B?RkliK29JRXFtUFA4ckY0bWpOeDJQSlpZdU1nVUlYNWxlcDhpT2tTVTVXL1Ay?=
 =?utf-8?B?Q040RzlJUTE1R2NpZTROS2NTcnFrY3BQV1Z6RHc2Z01FbzJsdVArRlM4aVBO?=
 =?utf-8?B?T3BXSEd0WXB6ZW5YckV2bzlPSkxmcXYweER0aTdDQ3hkRCtHSXB1d3ZxWmZI?=
 =?utf-8?B?RXZ0b242dE5uQXlZUDdSaFluU0NxVWNUanU3eTlsTU5KNWxKV1FJZzhUcUVI?=
 =?utf-8?B?dlZwV242Qytnb3JiVFJvMm5WQ2NEVVlndk5LRnNkbmtqSVZhWkptWEl6K3VD?=
 =?utf-8?B?bS8vKzU4TzdLcUVjVnNaeVVlRDUxWG5VRG40MDBNNGh0WGlVcFFQbi9CbEdK?=
 =?utf-8?B?U1drbDRCemEzenFjdmpsTWdoUDMzUzdEUytDVGY3V25PS3NuZG83YStaY29n?=
 =?utf-8?B?RlBKNTZFS3owdU94cG1NcDlCSDVZdC80M093dXhYWWE5S1o1dXpwMlFac3NU?=
 =?utf-8?B?ZnNpZDcwaGRuYk51MU1sVW83QlZjZmlVV1p4VHVNeWcxZ2RyeEZkUUl4c203?=
 =?utf-8?B?YlZyejJIT3QyK3M0MXkvTnRDVFptZXlHVHBwbDFWR2NFVzFsZ0FvT2cyeERE?=
 =?utf-8?B?SUdQeGRnOUc1K1BrOU1NVzhmVmZzTDRCRXZRcFRVYWc5ZVNDVE1naEFsTE9m?=
 =?utf-8?B?MEY5RmpOMkZKR1czY0VoWldkUENscmJOTUhKbW56dUEzb3ZNOGllQXg1M3hk?=
 =?utf-8?B?THc1MVpNSnFNcUNXZHRiZm5aS1VMVnpGM0ZVT3ZlMlJlYUVVQ201dmFPd0Nh?=
 =?utf-8?B?UHd1YUZFNDVNL0Yzcjk5WEl6NUwyRlZOSzNrLzl4Q25HN3dhS21YZi9KaW5s?=
 =?utf-8?B?OTNtMmJ2NzZSQnRDNUVyVHBlMW1iSzExZENDSlJMekgxUkxJREVOUExDV25u?=
 =?utf-8?B?MzlhSnNhNkZtd3dRTGE2TVdiQzNoTzBqdFZqUzBaUWxrVTkyWGNDTTVIUnAv?=
 =?utf-8?B?b0dwMnFhNTlCc3hGaDFmTWNkaFVKU0dXSkxjaVY2N25vaHAycE5VbERaUVA0?=
 =?utf-8?B?WWJUc0pkU043ZXkwcllkeFkxdmJkNWRIYzVuNE9LSHhWL0paeGY4bzlCVDQ4?=
 =?utf-8?B?TkJCT1ZpbUNVVXVwUnlBTC9OME00VDFRcnNpMzJEQ09lUWxpcUJka0w5Q1Ra?=
 =?utf-8?B?eEtXUTdCTG5RWU5hdm44a1N4TXZmeHgwcTg3TU0wOERpVC8xMHVlVDNDcDY2?=
 =?utf-8?B?ck1CSDZ2S1lCTWZTS3ZWLzJraVBaelRySWNNVkNjMkszVjBkT1phSTlUMk8v?=
 =?utf-8?B?dDNBa3pPOTBsUy8vSy90KzVPU2ZUQTVSNjJmV05YaGdMRnFSZElSSUFGQW8z?=
 =?utf-8?B?c2tIb3g5dG0wN21OMEJKQ1RhWlFGNFZYVmJkN1BUZkhOVDBtV05rbmM3YlIx?=
 =?utf-8?B?Z2tNSkpjaWptRE1HNEdiaTZyQ2ZsYTUwK0d5TFJwSUJGU3ZrdDI3OC92K3Qy?=
 =?utf-8?B?WjR1NmI1aGNEVnNURTdpaWpXQjdlQTZ6Sy85WGVKcUE5ZVJyd3VIS2ZwakdE?=
 =?utf-8?B?WEdlRUhsOWE0ZnNjUll2cjM3ajlGN3pxb2ltdFZqcERiYUJudWtJQVdvWTRn?=
 =?utf-8?B?TE1FTHg5UUY4b2pFUWxHU2FWSmhqNFMyUjhtU3NUb25WT2dsQUR0MFlXVmMy?=
 =?utf-8?B?NHlPQjVyQzl4dnY1MWp3cDg3YVRzZThjaG1ST0x1TGZyRUdLNmVvNGlpNWh6?=
 =?utf-8?B?N284S3lJU0p6a0ExcXJQa1VmTUc5a3pDb3B0RjNHV3VuZW5CUk9yalRvZkZ3?=
 =?utf-8?Q?aKRMkmg8aYEoUrPpTkzHIPK/n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f056dc-5b46-4275-fe93-08dc4b4edacc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 15:35:23.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKevAS0hdKkYPHHG7xk57fX1CUaPowOFJf8dHRShePaArIjp1paRcvtdn/4c5++zMCEkaPKpg5wThqfqyeBaeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

No device currently utilizes chclk and FSL_EDMA_DRV_HAS_CHCLK features.
Removes these unused features.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 --
 drivers/dma/fsl-edma-main.c   | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 4cf1de9f0e512..532f647e540e7 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -192,7 +192,6 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
-#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 /* imx8 QM audio edma remote local swapped */
 #define FSL_EDMA_DRV_QUIRK_SWAPPED	BIT(8)
@@ -237,7 +236,6 @@ struct fsl_edma_engine {
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct clk		*dmaclk;
-	struct clk		*chclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 2148a7f1ae843..41c71c360ff1f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -483,14 +483,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
-		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
-		if (IS_ERR(fsl_edma->chclk)) {
-			dev_err(&pdev->dev, "Missing MP block clock.\n");
-			return PTR_ERR(fsl_edma->chclk);
-		}
-	}
-
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
 
 	if (ret > 0) {

-- 
2.34.1


