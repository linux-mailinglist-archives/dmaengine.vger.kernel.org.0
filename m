Return-Path: <dmaengine+bounces-1207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9B86D5C6
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7719C1F247A2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F00156D12;
	Thu, 29 Feb 2024 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ne4H88wq"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81FF156961;
	Thu, 29 Feb 2024 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240345; cv=fail; b=h+4ouaGnafWFdQVFKFswxatOpwMKlpR7lqj7hrw1g146UhRuxN3opJKcQMiyrFeOFamjQjWgXJZXPNKah8peEXlpNH87VEnRnwcCWyhea/3EkYiGTrCJd+Lhs6F26ab5/OVG4dvU6xsbA5kM1KSF94i24qOqvV3mvH7fMn9Mvwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240345; c=relaxed/simple;
	bh=Cba1I8lPfT7XGGJBLhHLImkgVygTholVVk8WsvGvZuQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kUapWTDxxaYjomNzGdi5oCYSkVQHNE1VyXidEA/rs5Xcqz0g5sG8CgYUQWBK1oNW65Pebu+9zG1A1LlknFxj/w5Ma+Au+W1dMgZz2pYClRWTV/e24fvRDFOzpeoXzH6KmPkWWAKTgFgHB46DpQL+b+hkc7luLmq3CT/2CEiXu58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ne4H88wq; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNt5GWHW6EkvonoxRSeAa7uQwlE226Cow3djnuL8tzqCNdohj2kVT05vTAAIkL6xNq+Yb8h5358pCiNp+wBLDyv2EqXniVp3iEMIBPoJv6+WnIAuLEaJEdSuUPg7qylEB2+rFQuVCALxk0C72YAdcV6nvMvug9DAFXH9BjCU7yHGwfRDPGUn82X40nSlxSTWmzk5qzbcYFhbXj9AVCtwp3tlmuTzQ/kGQ2dBnD0Bkej5t5SlFWQfFKPyCMIJtcdqKaatvt9VqjJR/vkpJJJgIthFMGIXFqIXqXvuX4JwZJQIvxz+Ysl0NuMu1uJNPP5s5hv3/EDcMK3vpLLPyoIFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLs/58IIUeveyfmtV9PhDz6tUG0OWzPy+/o3nZ1cyIY=;
 b=UBFb2nG92MjHAO1PDhy25voNbUWnO6xhtnYn/xXJ7tnaComSK+vyqj4/hvtTruepvhM4XTeaKylt7r55Eq5Rto65nCVpcuqB0BnF5nmbVyiHyZWQdxMRw7oXWtmked1+ZN6vd7Khxib7DSqIz0gueFpAYwbBpU8mh75X6lRMSHM8I5oT4hNEcUdCMozbYKyPI3iXbpXvGD4cw3rS/N/WfqhKRXDNhvqHU7u3Rn9WNXMdy/1fYtujzQNQEA070MsNKkLj31z7D02E4237kpznU6pcDDOvlW8KbPO2G3shTMgRTYt2AnuEsBIT+nK3zqfVsoPF8sVd/uYuGhadKW3/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLs/58IIUeveyfmtV9PhDz6tUG0OWzPy+/o3nZ1cyIY=;
 b=Ne4H88wq+HHzAaLsUgMy4hPY12leRmrxVoR/EtPkFlVD1EbmbL1+XrNMgLQupkB/eEit9QZy/GmpK+Kac43vVAjnhRWoL+TUVPgcUJnXtf9bxymf4+LgmmHaK/gzeDj4Y93PTNU/sLlNfottIeywCkuhcMiFWaiBh6MixHWKOtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Thu, 29 Feb
 2024 20:59:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:59:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Feb 2024 15:58:08 -0500
Subject: [PATCH v2 2/5] dmaengine: fsl-edma: add safety check for 'srcid'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-8ulp_edma-v2-2-9d12f883c8f7@nxp.com>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
In-Reply-To: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709240333; l=901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cba1I8lPfT7XGGJBLhHLImkgVygTholVVk8WsvGvZuQ=;
 b=eaadin1fbdghmp6xGn/H3m1Pugw5hEkckIlpOSy42uL+blK41aoNXo+cWWtmHWxtxeeVdCNrY
 P9wDkD0PQNnAJZnQW7NCsmOskSg68yEPwBJkvTJT8EDCiMY+Aa5Fi22
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df85db8-1c80-4b96-b826-08dc396941ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	82KbRJX19YCs/sQ2tgOTy1b8mIiGLlHxCsctJ0VBKuxAuSVB167twS5l+fffPavd/SSchbb5wooLfvevnxpyp4RSyPDnjnHyj59/KKL1g8chXD256WDwsIJaMX5G5pLNJFpLQds2EMaUcLB8sRJDDipfEfIi7F1YC77WzC24FSokZziMD+76Wo4tcMNYlr7QcjCXDfM7pV6sMFXsXhX7tY16uX7Gn4asDfOXtJWr17r06MoN5qZXb3qBLLf6jhCF1mdzIsAG0JBY7gpop6mO6WZ0X8QID+8Dr2n5dwGUBHwpW5w71qF0JN5NB5TOYuBroTfq+feTqrzVBz+UR0+E4bLwtFoynP0IW6gesUcuwt7MpK3XLPwp2ryfle+vM1u2XznYJp2uYuyXsOzrNKxf4i7W3J4kjRYBSu+RCt1Q5o8z2+wa1dFHrXGIGpCToPS4IB06sJsKVuUST3WWKfK6WLP52ggX+RspDuILgkDIjZ/TLw26VmlaHELuxPvZeAiTppi2ZINi36dXugbW+17+dLtByYcfT/0sCZDTCq9Q9IRyjgD2CkegrTvTKuB5rktr/YkWE0vDG5qbW9fFfQnyhGMs+dhr82lP2dX2psHIvapvb2Fp6Kfj0OVMOX8mnLEGDZYpKA7KGOSFXLMNUW9Uo9K2AkOCUyXeLobPJA/Hn0ZCYvTrdcmLHS2yrSHfETsLYCtkXY9//NQ6illH1atoyP6uThRcOWVoumLOxXTHxd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak9rdllIazQyejJaR0liQnd4SzIwRmZ0T0ZGbDViL0JFZ2ZPRElvRW55SzNv?=
 =?utf-8?B?YXV0bzV6UkgyZkZrNnRGWExDbVA1OVdhT3A2RTBsUERTdDFpOUl3TW9tY1hL?=
 =?utf-8?B?L29weTl0Uko2am9Ea2hieWJmYnU2SEt2SEtRWXFmU1JzTG1xdVNoZytvSWRt?=
 =?utf-8?B?Myt0QnBiT0hOZnE3V2xCTzNXbTlsVVRPd3pUU2Z3amZvNUYzcERLRTdGWWVI?=
 =?utf-8?B?Z3F1dHc1MW90dEdjV3E2VWE3NmFMd2pWdU1qVVNGYk5EQUsrZmpuVGp3bmFy?=
 =?utf-8?B?aGtWcDlXeVNyUmVSTUxiTUF0Y2t2RUNBaDVZNWpXVEJMV1FqcXJlVVRFZzF3?=
 =?utf-8?B?Um9vM0NxOThGYTN5dG1Ybk5XNG1TTUdWb2RELzBGUEJ6RDJleFpIZXpZUHgr?=
 =?utf-8?B?RnNVMkpZeE90cmdHMGJHeVVRcjJGeEdJVEdrb001TnNDNkZrSUpZSWNIbXlB?=
 =?utf-8?B?UFU4RVorNWxxM3g0eHpFSGFRQm5UZmM0WUY2Ri9ENFJPYjlQQlFxN05WOVpq?=
 =?utf-8?B?cUhXUklKWEVVUjNIb2ZuR1hWQlVucytVM01iWlFFdmozekN5dWwvV29taDBV?=
 =?utf-8?B?Wk80WWRqMnB6bzc3U05wZmVzOFdnTklSczllMkl5ZFhBblJ1WHp2aFZ0b0VY?=
 =?utf-8?B?NmhXOHNEdjJJYjgxRUs0bVVka1Z1SHpnS0RwbWJhTnZUd0l2VUltbTBnRFNp?=
 =?utf-8?B?eHkwTm5KYU1vRVh6NDN3ajZ0d2RMVU0vQTVUSU9MaHFIR3NWazhsQmo1ZWJq?=
 =?utf-8?B?d0huTDRIUXBycEZZZHRTejNURVBBREZ1anllRG1VZEtENEx3ZTh5UnF5eE9O?=
 =?utf-8?B?SkVVSGk0bmdubkNINXVlMzkrTXhzbHR2aG5lMTRwbExGTHprRVN6RDRzN3o5?=
 =?utf-8?B?L0E2NVk5M0hkMHFibDZzbnVUakNCcGxxdU80d3pGdE1ka3pxTTU1VzRvMWV2?=
 =?utf-8?B?c1RvYWpWalRQR1B6MGNUY2NSckFKclRkR2RrOEsyVTJvWG92QXhEZHdzSkcw?=
 =?utf-8?B?TWZyck5rRXAwNGRoZmIrMEd0NHZvcGVWTUhFMzNjMHBoYkFheVlBTCs0L3do?=
 =?utf-8?B?bVViZVhocmlyWjVTK0s4UEhVL3JOUzBMeGplMldqSGUrT3BUY2hWaThvQjBC?=
 =?utf-8?B?RG9HK3NUT0Q2aTA3NUk2Tk1FYklzbjlLVFd6bFZ6Q29mZzZ4eE9Kc29JaURI?=
 =?utf-8?B?ZWdOZVk1S2t4RlY4cUZjZU1NU2YzSE1UeUM5UW54Wllna2EwT3RqSVdCRFZ0?=
 =?utf-8?B?dUhERUZsVVlLMG1naXQrMDJCb2pvMURrZld4SllUWHZ6OEJvT3RGdU9SRnB6?=
 =?utf-8?B?a3JKMk9USmlDMldDc0R0QldoZWUyWlFrcG1tTVpnOHVIWVJUVXlyaEtLTWt1?=
 =?utf-8?B?eldUMHdtT2c3VzFpWm8xdXZERzBiN2hBMUpDUFQ4M3JwYXVQZklvTG5kSkFS?=
 =?utf-8?B?R0RRd0JhT1h2bmwxMUxRNW9HdnpQWHZrUDFMcmFKMDJQVm9UemdJaFVSRlht?=
 =?utf-8?B?ZUxqL3JZVG55bjAvL2lIU25OYlAybVJ6QytZVWNCUUtKcnpPNm5OUUlONDZS?=
 =?utf-8?B?Q1pCZTQxSW5JVkJrYkVhbEIvblBPdTFCSVljcjZuTE5PK21HeXRRRExyNjlJ?=
 =?utf-8?B?cER5TTZ0M3lVakFzNlhFZU43UEd1SXU4SkdlZXdVNExWdVRvejlGN1ptd1Fa?=
 =?utf-8?B?WU1zT1ZUWGtGN1VIR0Njc3kxWXRVbkVmZUNidkt3VkE2ak5xcTdhKzZjdTBD?=
 =?utf-8?B?SnRJUUJ0UjZPZmVpZFkrZzRuSzY1UEVHekRibGZzZHd4QVNqRWs2cEdBL045?=
 =?utf-8?B?ci93U2tVdWJOMlAweHhFWWg4cHNORmE3TXJ0UDY2WnNwc2ZvME1NL2Q2ekxV?=
 =?utf-8?B?VFplY2ZoNVU0dzJVeFJZeXRESFdtaTlYcGE4MkpTV3NHc1NlU2x6eXJUeGh4?=
 =?utf-8?B?WWVHNy9mdkMwZ2N3TTNZUGl1WWYyMmJDZ0diZnZWNytjNHpFa3B5VktJeVB1?=
 =?utf-8?B?RExPSjlQRGpmcm02eTB0RFFTeWRpa2xvVDNCRm8wU3h0cjQwRmxPU1BzNjNE?=
 =?utf-8?B?elE5aWZneGpVRDBQTWJmditRcjE3bmRqbkZPUEE3TFhpb3U5cGNPbllvenFm?=
 =?utf-8?Q?9IAdIsuV+3lAWwAnhOEY4bNxU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df85db8-1c80-4b96-b826-08dc396941ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:59:01.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyxlTfKv5aOYjwi7nPdb7T8cHq6mK1AJbbYr1nRnEl7uBAJUNz7pJnXY2sGgpVFkA+FUGEqevRJlqAaq+HpNuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750

Ensure that 'srcid' is a non-zero value to avoid dtb passing invalid
'srcid' to the driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 0a6e0c4040274..2148a7f1ae843 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -115,6 +115,13 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 				chan->device->privatecnt++;
 				fsl_chan = to_fsl_edma_chan(chan);
 				fsl_chan->srcid = dma_spec->args[1];
+
+				if (!fsl_chan->srcid) {
+					dev_err(&fsl_chan->pdev->dev, "Invalidate srcid %d\n",
+						fsl_chan->srcid);
+					return NULL;
+				}
+
 				fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid,
 						true);
 				mutex_unlock(&fsl_edma->fsl_edma_mutex);

-- 
2.34.1


