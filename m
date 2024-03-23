Return-Path: <dmaengine+bounces-1474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D03887936
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768631C20CA2
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95945BF9;
	Sat, 23 Mar 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AaDruzr1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F243AA4;
	Sat, 23 Mar 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208122; cv=fail; b=k6X22ASQl+NKIZq8rirHyU4Or0epxDAlnOx1rPfVlFYhdJw1eSOknl+XzrqSmSLRPXYCMJzl/eo2ZmLsR6zFgBKd1s2GfZE9AdvQ0tWqxzKb1Nh94FNhl2eWkkYAqtSc1t1Zvt+hvak+2ONUE2Lg7qthbi/qWdkrhIIlVt1X3Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208122; c=relaxed/simple;
	bh=YZqvNpVwks9iUdy1m5WD7RpsLTnC33dYL8qYlc2nwns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fl1vmAXy0uivoVgmEhroPJpyDXNSdrhYOUQOU5Kden5DMr6pYUGUSYBZ8ZvfwOwvGnkruI+uCKOWR1kdwsYPnnFh/508tDJtyvG1h4aOMzt0jM+qqARDXVtWLDIZtKq7QIb9f765mQOslmSeLbmi+zrZoyqZ4XcEIz+HLVYcWBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AaDruzr1; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2aIpqZyxaqYZkGSEFeY5HP5ru9pOMNFLJ4MJltIdA8498oPnigIvdQFjl0N6zcGihL0YsPU0ZKL9Dr5JYRKvcwOjiEJ2slMfIaL5MxrE+aNbXiwlJSJlI2tczrAwdPrcdhLKQajffrSACfWlWGjtcKBQlZsRICi4KfRKr6u+0GVe3ziOwNzEMPmzqD+VRqXUUWh+b+kcT/QTePHeWBTHl996bJp2k4dBmQiFN59T7qVNemmOiXRiuJWHXoX8k+MEHzUI+h86n9Uqu7d70mJT2cu8Zmq1KXKGK+oSh2/uK+Rfm0Lv/5N5TNUvSeOuLmMHw0TID0ZA/oPtHE0e0/hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9vB4OwEoRdCLUY1BP0w7hccRMhYCWqyz+SfWM5vr7Q=;
 b=hpoKRbCwERdt7Fne0MAm0QUirUhY6Js0nDLsn4WVJvLJeD+DVSRKGy4mypAPN+hwpPD3zfOEScO7r8D0XrW/TyjwjyrSAlijGWBjLo45qDyf0nUTWUtUVvtFDA64M0N7g6JoiYwn/0FPrzXreMrta6vDUX6WwGjdvTz/PW9LM3wu1VGl2NgpQlqa9QXLoQaxkofab8252o+goKMnysO8oy2Uu3Yb8u9y+R5507yv2Lbd64FgzhOIIqp2tlu86T39CyvmLMzwxRvSQiU4eMSZ7Thz/gYy8Nu2D1lZ49mI1UUy+9aCr33sE+hX7qJvkKWQsK7zzbD+iB9yAz1I+17RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9vB4OwEoRdCLUY1BP0w7hccRMhYCWqyz+SfWM5vr7Q=;
 b=AaDruzr1PW1GBliEM0/06zs1PmywtRpbdRdhuEscSr5XUVjla1BEZnmgVDtYJb6zQ+2O7cyyVeV4nC+NzHxnEh7xklHQaVovTqKsvB/eo32GLv5CGbZo0hZ04MnJRl9DbCIj78uEZSBDBD1FjDmzsDrEcZE35677zd58ySrOZfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 15:35:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 15:35:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 23 Mar 2024 11:34:50 -0400
Subject: [PATCH v3 1/5] dmaengine: fsl-edma: remove 'slave_id' from
 fsl_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-8ulp_edma-v3-1-c0e981027c05@nxp.com>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
In-Reply-To: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711208112; l=3059;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YZqvNpVwks9iUdy1m5WD7RpsLTnC33dYL8qYlc2nwns=;
 b=ZME4FrkELQeoxQ5v4CRXpaW8znrNij9uFs5XGdzBjHbDP+J7JeM6EssYVhlwEde2OX9L7iV6y
 FRVpsqgOREGDsd48J4NMZ5kxQc2bjEUMhpY3z7Jv+dzA1QcOkxaiSlA
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
X-MS-Office365-Filtering-Correlation-Id: a38658ed-79b5-48a4-6629-08dc4b4ed7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hotaWqInP7h5c1TiGalovpjDERcVeH8U886KfQcLMsFM5/WRN/FNP8xLuz3ijnNxRqq66mPTdM0g7HKSzyDY9gBJv9Z8tS6Zyohi5csuoje9vOfEQcDEJbcgwvj/nw2/DGnwHctUfVxMBGRN9ElLaM7/O7DThthlEAkzzKSwXVAN+HTf8juuVAHxhERS4s00isvMVXsEZmy4AsD10PwUf41UVWQDDiEJzkQPBxp6cQINIMbqvdBI2gzm8A5rHGyHlaXc4EjB14KGgH0DF9+7mOhqCmxcMomBlWh7JnQz0cfx/PkysSxt7w0FQ7s4PhaE9y90/3FcapzmWLHoMDamMr2A360C7H8XYP2a4pHb4Wi+UyBzHvfzyrk0S64CydIqjEt7unGle/z4ez2Wfxydco6e8SXsrUTVQMCIJTOG8pEzUxi/MlreuVvQ9qmCJm8QxQee3Qj7a3t6BbqMHI0dkwF9ovZi3F+r2pL4lTzVplFMAv27Cjy59hEi9qqZ8fzjMJTsXFRY9xfreDMRzxKVW5IM3o3Nq3skBcdtO+P78PsyQ5xhqMtSduhslg6M1G+FTDzOmR6YA4U9ggx3aHPiPoKxz2zXfqATgNTcQ6H/JgsyRWLiEAG/g3ynYZmzrkz/ZcfNLR05hqOwxfevST7JvZbFrBNMcIY2xib42M5Vr5PWDpRPMSNVyyTn+BRQOjkNYZFuZzUkp0IgyinrgQN8CkWuKRZI8BtH+fhYow6PyvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5IOWpDcTB2a2h1VFJjOFFkNGJySDIzTE1FMys5SSthTTJXc1c4YStPRUov?=
 =?utf-8?B?ZERrYmFrbEdmSkozME1LcHlWaUNOaXB1MnQ2NzBYa2lMa2Y2UGIxVG5BbU90?=
 =?utf-8?B?aVR2cklta203aFBkZ3A3V2sxUWpZc1dYNm1QcEF5TUx1ZUh1WVZsTkQza2xt?=
 =?utf-8?B?Qy80TjVWYkV5bzIzajBSME5KSFBvMW8zb2Q2WW9NLzJPSzU1K2EwUzZTVGZT?=
 =?utf-8?B?RThRSmN2WDVWbEJCalc2eVNKWm1WdWhnZEorblZBY2pCeWs5cnI5b3R6UHhF?=
 =?utf-8?B?ZFlCbVI4QmdYNnh2a0puVGlZdnZQM2ozWE84ZUh6SUJsSnBmMVdnWFdVK0R0?=
 =?utf-8?B?RElucEpkU1FkbWxVbmJlTW5NdUQyQTdyWkdRSmp2K1NkSWRGRHdwYlRzSGpO?=
 =?utf-8?B?eEZReHEzQmJoR1NCb1FlNUpZTlZRZS9GRE1KQWFmUkR6QXhnWWhJYkFPekw0?=
 =?utf-8?B?azJkZjUvK3FlOXNEcHRKaFA3MW5GeHA5WE5jb05jZFc2Y05mbXhWamc1TlJP?=
 =?utf-8?B?N2ZodDVpNXJXVmZvR2txYWM1RGRNemxjd0Z3RGdJcUxheS90aU1maTZoMXdr?=
 =?utf-8?B?TCsweGJ0UXdqdjZIbngwcVJPWWViRDNjaFRrREczMGZobCt6L2E0cVk0cFFB?=
 =?utf-8?B?Y3NmSE4vWVUycVBZVlcwcnlXOVh2amlDQVczdHh1SHA3endZa1hlRkg4WDhT?=
 =?utf-8?B?MUxoZEhOTWpVV0JGZ0dUZUc3OS9uSXcvbHFZdGdEUERDYTFNN2pQMVcyTnhi?=
 =?utf-8?B?em5PcDlWN05Pc3lFVDl4S2VHVUxXSm1LM3pUbUFVdEV2Z2hvN3RqOUhMbXpC?=
 =?utf-8?B?NnYwN2dteEQxRHJPUVpITDAyWHRYazBYTnU4dTV6VVhIRDFDY1h1b0haNkFT?=
 =?utf-8?B?eWg1RWk2dmQ1SnFJNkRaREFJOUhsa0kxdVN1ZUhBUUxaUEJYQnhSQWlNWlZs?=
 =?utf-8?B?VUVtanpGRitLWnhLL0ZsNEppY2J3b1B2RDhqTHcxUTdhMnBtQ0dSMlF1WG83?=
 =?utf-8?B?Rlg5Q2pCV1dwOHZGN2JmOWZmclE2QjJCbjRTQjNQMjQzdjJkdjRGZ001RnBr?=
 =?utf-8?B?Z2Ywb3FvQ0U5TjNnMzh6NTBXVkJPTDhWbmFNWlozWEpteHBIbUd5K2ZGRU1v?=
 =?utf-8?B?VTBsd0s0eWhnNExvcTZBbnV2cDNLWHZ2V3E0amptMXJLeHJMRTk1aVlWWFRu?=
 =?utf-8?B?YmFyRnY3cGpDMGIyQ04zYUVzT2VmbFc1eXZIUFd4MkkrUUYwODVIbjdmNTlC?=
 =?utf-8?B?KzRYcGU4dy9QWmNkeUFqU1ZNTjBKK1cvRjhBMVQ4MmY2L0wwT3lqTi9xT2dS?=
 =?utf-8?B?U3FkVDhsSFZkSnZScStvUzRJS3lBQVViY3JUS0VQeDQ0V0RuU1ltS1IrUzc1?=
 =?utf-8?B?MHoyVEY3djVZeFFnWmxlczd6QVhldDFMaGVaL2dib2pBNnVVZ3JUZE84SG5l?=
 =?utf-8?B?MHY5ekdleVdSZXVXcDE5S1AyZVJ5aExiM3VQZDhWb01KNHc1WmlVSm1WQUVM?=
 =?utf-8?B?S0E1QjJWNnlJVktzS3pVbXpTVlh6MEp5OEdWeVkwNGxWTlpNa2N3L1ZnTjBw?=
 =?utf-8?B?eWRadkdCdW11UDJ3dHJETlJralk5NlNyb3F5NkJaODY4bm11dE1iZzBFYWlV?=
 =?utf-8?B?TzhMamRWYTdzVWhmYlZMUXlsVHRRTWt6d3JWT0wzSVFkMmhHK0ZvV05aeWVy?=
 =?utf-8?B?VWJucUFnWnc4VlJBRkY1TFk3UzJWNWE0RmpJeEI1cmoyRk5aR25tNHE3cnFH?=
 =?utf-8?B?c1l3RXJlZWQ5YmZLZC9vTlI0QjVLSXVsdDI5ZkVZYzZ5V0xhTnhOelRpRVEv?=
 =?utf-8?B?dStEQjdaTVlXVlFZaDV4U21RNEpMSVZjeXFreFZjMWZ5cGRPMGZITWNhSEZ0?=
 =?utf-8?B?QXkvRVI3VXFnbTdORVhaNGRpUm1CMXByMTN5cXRPbzVOSm1DY29pSDBHZWVW?=
 =?utf-8?B?OEFidEJ6TnlOTGpDclpuWU5FWDdvN0U3WnRXaVhTNlpXdWpnRitFUUs3a3Bh?=
 =?utf-8?B?QUdTRThXZGV5OXd6cURNLzNjWWJ2VDhweVVKWDZObHhSRHA4T0Mrd0RaU2Z3?=
 =?utf-8?B?R1FucVMrdmlULzNTdnhPbWluaUpNeDB0OTM5cUo3ZUNmWjlic3owQVBQc2p3?=
 =?utf-8?Q?oETofzXyHQVHDgb1baMyNy0/K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38658ed-79b5-48a4-6629-08dc4b4ed7c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 15:35:17.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfKTaojHNzbp21yBb7apmnlk/GmCmmRTsT7Ne7Kh+fvDIACzLglBBHjjnPSrY0Npcy7ouf5ENxMrLNKViJwx/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

The 'slave_id' field is redundant as it duplicates the functionality of
'srcid'. Remove 'slave_id' from fsl_edma_chan to eliminate redundancy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 10 +++++-----
 drivers/dma/mcf-edma-main.c   |  4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 7bf0aba471a8c..4cf1de9f0e512 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -151,7 +151,6 @@ struct fsl_edma_chan {
 	enum dma_status			status;
 	enum fsl_edma_pm_state		pm_state;
 	bool				idle;
-	u32				slave_id;
 	struct fsl_edma_engine		*edma;
 	struct fsl_edma_desc		*edesc;
 	struct dma_slave_config		cfg;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 402f0058a180c..0a6e0c4040274 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -114,8 +114,8 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 			if (chan) {
 				chan->device->privatecnt++;
 				fsl_chan = to_fsl_edma_chan(chan);
-				fsl_chan->slave_id = dma_spec->args[1];
-				fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id,
+				fsl_chan->srcid = dma_spec->args[1];
+				fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid,
 						true);
 				mutex_unlock(&fsl_edma->fsl_edma_mutex);
 				return chan;
@@ -540,7 +540,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
-		fsl_chan->slave_id = 0;
+		fsl_chan->srcid = 0;
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
@@ -682,8 +682,8 @@ static int fsl_edma_resume_early(struct device *dev)
 			continue;
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
-		if (fsl_chan->slave_id != 0)
-			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
+		if (fsl_chan->srcid != 0)
+			fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid, true);
 	}
 
 	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index dba6317838767..78c606f6d0026 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -195,7 +195,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		struct fsl_edma_chan *mcf_chan = &mcf_edma->chans[i];
 
 		mcf_chan->edma = mcf_edma;
-		mcf_chan->slave_id = i;
+		mcf_chan->srcid = i;
 		mcf_chan->idle = true;
 		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
@@ -277,7 +277,7 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
 	if (chan->device->dev->driver == &mcf_edma_driver.driver) {
 		struct fsl_edma_chan *mcf_chan = to_fsl_edma_chan(chan);
 
-		return (mcf_chan->slave_id == (uintptr_t)param);
+		return (mcf_chan->srcid == (uintptr_t)param);
 	}
 
 	return false;

-- 
2.34.1


