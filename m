Return-Path: <dmaengine+bounces-1136-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AF869D7D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F275F1C21A74
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB454EB5C;
	Tue, 27 Feb 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dbu9JDr8"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768614EFF3;
	Tue, 27 Feb 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054544; cv=fail; b=X1CR/gIFPeg6uSpib/p9P+bHJ0ZrndI9FPRmGH8p8UT9n2jDX7wpigO0vSbNW+OVcji2ldOShNIGdB6oR9fgEWcaJD8HPlJdWyryPIYDdBKPaEVN7dq/uqNkC6VAnKUt92X7OE2iYwc7lhZAIr9QIbHiEh5Z4nBb7S6xvFuyTqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054544; c=relaxed/simple;
	bh=Cba1I8lPfT7XGGJBLhHLImkgVygTholVVk8WsvGvZuQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H25vVGD+Od9kZWAysdo7uZ3xbCvpdD9i2Mqu9iiyVL3x8Guonr1w5z9ZS9UjAxhjW699VS6MIUaxqtWwB3puzC3JzKFjfJpZk25e5bGNLAIp2GbWa8VUYm1oOZZqqyChWit6e459kvv1Ln9kXH16DaKea7pe2h5Pg5m7kjSxVB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dbu9JDr8; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJaa8YzY0yU/dLMtoM5SU6YrO8j0TqJQNjuxv3ZzcCXLzymnXtXWLz3feHoJOwHVjwW4uXQx+T7zBTGpb1qev4vSB0nxMkShDph6yYJWl8QGrN6jX+m+vXiSW9rGI6Jzks+eGUbEG3a0FWrZ8zRzW12n/YsfS6hoVvk4vA+QyNPTyebaObUjry+ChaYu/qT6+8dvVe/FpBk537alq8n4NgyLUK6WxdyOL56D/tv17flFt0BJ5YXNZlE1RqH9XCiV7Gx0fu9C8x9wIeXJK+wUG7fRW62oO/cXTTbTZE++urXX0dfvltWiBKAbP6R85qiVcLE4Myf33f2hIy6iu/5p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLs/58IIUeveyfmtV9PhDz6tUG0OWzPy+/o3nZ1cyIY=;
 b=Ba3nrCNQTUMpCdcF5RETFLCRC2l8XsApsgf28lA0jf8fVEB+o2KKPZolAaWHOwi6dy3ewj5EctFh6aQwAcmRNvL1htj5Gse82nMqShBvylwko+t1jZXuSt0BzQTFPFFSw8cn0fPGXvM+k0oNTh7rLrvIJGjgKEKnQxzF/XoQZPw0FGABPMcHQr0LEi+gz2OY47dSk1QKHGgw3mgmqm+VpKOcrfkymvPUcMwV2xGb8LumPwdtyVJjfK+xMjnFITmA27ZjK1Woo5MsCFMkLaFlEytFN2uQ1SAmGpu2X/OfTIwlWrX7i394TcjR5L345iKUO3bxTSTuTKJYzn6El3yeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLs/58IIUeveyfmtV9PhDz6tUG0OWzPy+/o3nZ1cyIY=;
 b=Dbu9JDr8Hq28cT4y2zahOCHQ+K1ISKnbe6WgvqRnT7SMdRASbjbrCA9KS0mGKriBHzzhO++NrBSoylo/4vQtNv4LO2W3z/LIrJd6w+qWVrVptVBPQeODFrbNWIAVrTS9peXzG1eVVueQsqC7uf9p/8KGP16hYJUMkoIcDy3kawU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 17:22:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:22:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 12:21:54 -0500
Subject: [PATCH 2/5] dmaengine: fsl-edma: add safety check for 'srcid'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-8ulp_edma-v1-2-7fcfe1e265c2@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
In-Reply-To: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709054529; l=901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cba1I8lPfT7XGGJBLhHLImkgVygTholVVk8WsvGvZuQ=;
 b=BmFxSUdl/KUEZPYVMBtSkXMGE4o+yIg7DElAlG9Dvn9iZqgL3PJGsxSGm261NMigMG0Okfx+G
 QlPjEYBJy9VCZEOZCSLJNjSt/ReeFaw+ZHaJrFeGRE+VHkbLa1A1x02
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
X-MS-Office365-Filtering-Correlation-Id: 18ecc72e-7ce6-428a-7423-08dc37b8a5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XarjfkF6ztdFwprXzf4yUFLF7cPwZeBSVLCX3XnhCcFcG/9DaoZqVoSBbL7Cjs6+s6jaAQnvqDXNoVO07gLMRKgZNrB+PlZuRC/IJoUzg4I7x23JYcdQmO3OScD0r7RkjKWqso2wgJq0aWH8/ZtBVIHybH9bDD2pok+ET9y/IASJAiG9Hs2qc+h1xg6NR6x3jxTa6/AH3QzIIKC/R8paQ3AmwLbTUftNWQQABsylv78pKPo3AmU4WlVZykDvcDKx82J1obHW9gUxbBKJdpbeMaGA9PGYRF3SWeBc0iQDUDMnMi1qbL/67qQJKSmMVTZVLUehj1gHr66l/Vi0OTE2EG/C2D5A3RBhYQwTyrTgzJs/lJGkG95uTj443/dSb5wVIPfjqUr9vxAYJlCq1zy9qq989AfH8uhMfd7tYsKqqT20N39xffCrUXVs3uCvhyT7KSPK/SsR00qtNYvCPMMDdMZEVrq7tCv6ngeaM1zd86Fu1JmdbjkPcYIbNu/9Y51XGcd0Gga2V/G2kZD1MbIb67TuyqDpjr+8rhc+UD124s6O0ohPbeiFm9beNlxjx8hci3HQMMGTLFMRrvhDa71nBqk7P8pmrz4AQ8IL5EAdAnJSO0NDtG+mB452CruFQ0UB96GXcItIyHPE5K0V33sKYComAUR0KRniRP0C+pXvA8aEHV8CBFgvzxE3qqhlJfYA82IrVthJRAyIC9jt9V2bMPiyRM1+ria2FMmD9DnNaIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWxqL1h6VHluTDJndG85NkNZOHE3aG1sdmQ1Z0JHU0puRGYzVHljM0ZWdlZT?=
 =?utf-8?B?T3NsVjdISGM2MFE5Ly9xNDdKMkVFdUdWdTBGYmJ0RjBrZGxSY0JKOERoQ01T?=
 =?utf-8?B?MkpGWTFSSnpWdjhZMFgvRDNLbTA1V0VDMi96aUJtKzJlODBncEN3T3hTV2RF?=
 =?utf-8?B?dDFHOG5nT3JOcHFva1BkdDZIaFc2QU5wS0RnYWhjOGpTeUpNV2hXMFZtUmZF?=
 =?utf-8?B?Nk9zb0V3ODhMdUxCUmk0OUt0VFpUV2JPZHhvblRteEJFUnc3emY1T1h4cFh3?=
 =?utf-8?B?L2oySjd3NzNFVksrOXp2b2R6ZTdiNTB4V3Z3UzhvWGpXYU9JNXNyY2JwQ1Jk?=
 =?utf-8?B?T052Rk9zY3o5K0c5cTZPcDdsRXJnRFVxZTJ5aEFyUkxIemFmOC9LaFNHNnFU?=
 =?utf-8?B?T2tMVnlwUUdnY3RRU1ZETXROdjNoejNVOUdsWVJ5eHNnTkVMK0R3UlQxWlZn?=
 =?utf-8?B?ckxSQ2Jra0NDM09WSTZQRXNqNWRuS0tQbFJYOHIyMXJBU080UnpJMDFZaE9T?=
 =?utf-8?B?YTZZeDBqbXF6Z2dVQnpPVitnS1VSTVFmZTVqbzZaK2JQVE8wbXBEUU9ocWVU?=
 =?utf-8?B?K2Npb2NWaUlHZjFwYjdyVThCbDBVc0NpNzB4bGZpWWg1cDFRRm9HK1ZsaG8y?=
 =?utf-8?B?bmdVTlR3dS8vaXpOZFBsVHlpclVMdkIraGp1UU9XVjBJT0Q4M05hYmhYbi96?=
 =?utf-8?B?ZERwTjdMWTFSRCtNMW9SMEJVSGEreE1PUmdhU0JWVHdzN0hIdHRMS0R5ZmZq?=
 =?utf-8?B?VHgyVVA2VFBaWVcxZmtCY0pabUExZFBNcVMrbUNqb1VSbFV6U3hsdGk4S2VB?=
 =?utf-8?B?UVpFWGpFYXRpVTJ1NEdHdDFEUkV1TWlqUHpGYjJIZXFUN3Y4M21LZlN4RGNt?=
 =?utf-8?B?NTF6YnBRZ1NzVXNrekU5aW13YWxJTGdhZnpwRC9GK01mejJ2dzAvTDR0d1dz?=
 =?utf-8?B?WkN4VVBOOEhjcXB5WENFYmpyU3Rha1Q3aGRVaThveXljTjRNSUlIUWxFdWo1?=
 =?utf-8?B?Zk13RUhYblBRUVZpak5MZ3NOUlExM0kxZElkRDNNM0Y5SlNvWjhGNi9GQ3Aw?=
 =?utf-8?B?MkcxTWMwV2swZm42MUFDeCt6TjJ1a045VWQrcGJXZndMN255RU5lVFA3WDJ3?=
 =?utf-8?B?aU92VGhwZkxIREZqTGFPeVhkb2h4c0lkUDk0aDlLR21YT0Uzbyt3SFVwbnFh?=
 =?utf-8?B?VnlhUys0VWNQSDNTTFdiS09VUDR4amVsdGYvaStqTVNpMU0rSzlMaTNsUGpt?=
 =?utf-8?B?M2k2VW1ZSDRKdWQwSVdBUGV3VHhJcVd0emoyeGcwYkhmZW9weTRkTDRoeXdQ?=
 =?utf-8?B?b1R3ZVBxMjdiVTVjeUd5SFJCOFBmK2lsV1d6Uk4raXRWUnpvd1NEdFFjNkd5?=
 =?utf-8?B?UnlPR3lLd21Ec2xhS0ozbWZDTWlXS28vR1RmZnd0U2hJT3FMV05NUTk0T25i?=
 =?utf-8?B?c3E5bExUcEdaaDMzbnJvaWk0a1RFU3RONmtZU2lLck93aW9QMDFNQ3FKSWNM?=
 =?utf-8?B?c3ZSeGdmcG9JMDh1dmQ3a1dVMmZrbWVkNXg3dWMvcXp0cmZlRENGb3FFYXRr?=
 =?utf-8?B?b3hWTWZPd2lBcVZlMXpYL3d4N0I2bnRHQVBHWDNybFZIYkRaNWNzY3JUd3Uv?=
 =?utf-8?B?bE5VdVlKQm5FZ0RubnFBVmx6QmN0NnVWQzJoMGFDWldyYmZURUZtbTB6QXJy?=
 =?utf-8?B?b2w5SXdVN2NyMXdUQTJFYzNaK2xzZ2pyZ3B2Skh4dVZyRUdINFBzV1ZidUZn?=
 =?utf-8?B?aHNYSU5yTHE4M0ZpL2FDbEs3SUdBNEJiYTZoMEFZWEpjNEtwZUF6QnlXQTFj?=
 =?utf-8?B?TVo2RDBKRURBK2pVeGxSb2lWekFXdDBTRkNmbkdwMU00bXBENVgvbW5sdFlD?=
 =?utf-8?B?SjM4cm5oTTZSQkIvYWVGRThOUzBDSVZmdEVobUR0SXQ4eHcrVGJ0V2FCKzNo?=
 =?utf-8?B?R2hoOUxicXZKR1VoUUltaFlUZ0NpdVpqS1FORzFJTlRLT0xTaTc4NU9lZ3dL?=
 =?utf-8?B?ZjFkWmg1bFBCWlJaN2YwbXN0NnI4ZkpxSmhYbVNwQll4cTlRdTZDQkNDd0hX?=
 =?utf-8?B?UXJ0eThwakpZbk01VW1PZjROdXVIc1F4ZWlpOFlpSGhNRlhrdUNpaXpDTVJU?=
 =?utf-8?Q?WhNImIni60WS73eWlyIlrd4gM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ecc72e-7ce6-428a-7423-08dc37b8a5d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:22:17.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w1LFTRIkZ+ZXYp58HsAkcKsVTraj6Z2nS7WKim559ZQ0SeOMfRYdtqXq9wlzKmzIZ64giZy0yiYwra3gux2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408

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


