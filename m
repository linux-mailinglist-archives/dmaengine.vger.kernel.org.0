Return-Path: <dmaengine+bounces-1475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30214887939
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 16:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87BF1F21B13
	for <lists+dmaengine@lfdr.de>; Sat, 23 Mar 2024 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641A4D9E3;
	Sat, 23 Mar 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HR8Kp1Q/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F14776F;
	Sat, 23 Mar 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711208125; cv=fail; b=XqJSpfZ/jtFpp4aiTrrGatBti2ATyFJKnI3IE3REDSpV1Kivh6zK/qDhXSGMIFdqQGm7QGsIOeK2bLwAHK1X5QCuLF+R9fvQzPPT12slKtz4Kq+KnVm68rPNCIcZMGC5ug5qxO8zJ/QaPuJglHM6zqD66D3fXBjUhVh27RskiNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711208125; c=relaxed/simple;
	bh=Cba1I8lPfT7XGGJBLhHLImkgVygTholVVk8WsvGvZuQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RwfGUFQmlIlntmaBmWEE1+F60xuWOjjNwtmGvEfEwrYbOOhzIc8Dszd4zE4ICWqh/67R+RcCaE5H1h/hQYk7jB5DjQ65L3EbmQkwJ1iurIWZZs6vj0ICj5j/HmWxWUH7vrnzTGzAFROV4ScWZjIs4CT9eXlXdkeXEj4erF+jGXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HR8Kp1Q/; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3UwqEbaPI6ZYu2/y0/T/AE7mrx1sveSrsYmOBAltPHEZ5iEayB1eK70p4Gpb+p/l2Fv+Me+o9Yz3+LbE1wZs5Epck53i5CVtz8VHQL6E98N6FxHAqyVbnqfPxJbFLZw07uvLy9lUQTq73A+Cx+IdjPKaQs5c5CUEds13drb78yexp4QNPOlo3rNCnxlgt1vX62BWSSFcysiw2z3Q1jz3Qs3WtjqxzZQ7RtYUq3aOr0P9zoI1+29NApv9xs5/m56Pp79RuWiGPodovhHk4mSB7KbIVE2kp4UpbYkz87Ae2rQ+N1h3u9MOhQa4kVKvZEOPHyM0U6RVxssrt53MyIAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLs/58IIUeveyfmtV9PhDz6tUG0OWzPy+/o3nZ1cyIY=;
 b=oS2GXd2v0vb6998u56ZzSaEic6IhRNLQ2z/3YgI/uSK6otvxenES6lbkvmfqpS3ShqdY0n8G56vk99kQNdeTINOOLXCw4ckMzukJJzlEB+K8/rcRPRtwXVe7rbYoO+rQeSHqO26X2Wfx2RxQyrk7B1DvuYjb07AyA5/VZIowWaZsA/JtY+Xj4/cfzoICLReTKMupcUILa7/bGwxosxs/OnUcGtkMCxIquWCraVHALh8qhmXG0c0cFouyHYxuCW5ZZF7NfUF08c79tQv2cmoqBFXcFOexFUbUzKoY3X3ODKSYsChWjdvcsestWgH3GCT5DmU+l9Sk6PvtLR9vFqplGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLs/58IIUeveyfmtV9PhDz6tUG0OWzPy+/o3nZ1cyIY=;
 b=HR8Kp1Q/QaUzvnRhm5H7OZ4YGXMFvkly3MVNb17wge3pGjLl++Vzw2Kkh2/gUnr611P/Ll/QC1b1vr2ot840itQHcnoCYXzEDyh3fw1z2FMuH+qr2F4ZlNuO5BnA0nNM/uU6J/IkO2JCrgBxtQL4MlvFEzyRsfkxmn3R4J6ArIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 15:35:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 15:35:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 23 Mar 2024 11:34:51 -0400
Subject: [PATCH v3 2/5] dmaengine: fsl-edma: add safety check for 'srcid'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-8ulp_edma-v3-2-c0e981027c05@nxp.com>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
In-Reply-To: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711208112; l=901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cba1I8lPfT7XGGJBLhHLImkgVygTholVVk8WsvGvZuQ=;
 b=DZR65aYc+8PUeN+rRyshHGL+hLWvsYzcfbpCoDw9GnVzkPODkLqhXdhlwgZHslbg8KzqbB4LI
 clHe2ZovAy0CEqCYpLJSAg6As8csclDdXRDYObXZZ2NcdGuoW/aRzHA
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
X-MS-Office365-Filtering-Correlation-Id: 7fb7e83f-8cbd-4363-7c28-08dc4b4ed945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o51RxKs9PppwzfDFDUif2HV8PqnGHZ9w0Tt9hBAbpxufgePk7lsbpDQT+KIZ1ksRd485mX4JF+kH9V9//HDYgQrINEc5VL3/V1q/pTRmZ3yyBPMlJ1G2Pe1TyEJG32jL399AMBSBQeiAhr/GRwOXvlK6cWQGIyMy7QCXMaOPxmg4wK1jmeuupNw0zoJdM4XYl5WIaIFdfrV4DUNVOU1TwiEdWRlp/OE3Id5BJ277UhOJBaDmdHeZ3KKcWjKWUyY25dGg9TMouCSqSf5Zs05t3zB79DCFjq41CBzNB78Xro5MMjJ1AVfAhR4T3TNdC0/Mjkm2Bff+G3m+zDCC1uuQJczR/Wr2CudvNs5vsOeJwQM5MAqFUi1bzmxcQpLxqRDOQdzy2z3nIHPhcKfqA8wSFbW9urrKD82YZsFOax+SP3oJtp1ZytHidsqNK0Flb7PeOLewDpW5mRtBA9vt/ZEhBJtY/nT9tE9FhegovqnEhL/YGDGqlYhfCQWr3oNG1/zXm2SAH0GXeWevnEe6QIriePPN9TAYWC3ZxWtCCklUmSdC+hxM1Uut+ejes15da8NUVbRep8FKc29XNFxPKiDWDsgphFz+SicmUhLZsNOPrX79OUdEUOXDkj5+jWwMtUPBJNHTLZRkrE9Nbc2XwmowSBmurzsSwS9ZmamfDSAJG3moPd7oYWgENvcPnYV5mGYmpIog8/AggvOWqBk773ubpXh9mOgmSIhk0oNGHC1qed4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDlwY3k5T05BQVpzU0FKOVY0N2N0dWJNeDZlTXJoSHhRQy9CK01lMGgxM3FS?=
 =?utf-8?B?WlNNWmRUL3hXZ3IxU1RlVjJ2VmRjL1FQWExJdkJMa0hDTTMxSys0SzNrVE8x?=
 =?utf-8?B?TDg1K1hYcE5rbzRyMC9ta29ZZTNYcnQ3NzJrcFlqSGtuOUEvVmRJSTVGcFdv?=
 =?utf-8?B?cnpUcTFlVGU3WVVPei8vY3FGcTBxUGNxNStNY2wyWkhSZnREVHpmQi9rR0ha?=
 =?utf-8?B?eVBaYWswWDc4bXVycCtkbWtyUUVVOE1QbXR5eitMQnZqZVNINVEzQWVGQnZU?=
 =?utf-8?B?UStNWnZVWU9XR1lVeDM0c0hwNnRJM2ZEN1o2MTJXM3VQNmpmVXBLZFcxOGRj?=
 =?utf-8?B?ZTRXK2laRDVRbXc0bmtJelJtZERmZFVVc1IrV2hocmFiS0NwMkVSSkRYMnIx?=
 =?utf-8?B?NlhjSnRxa2RTd3gwcTZPbHZpRW5vRWtvc0locjI5eUtXcm5HdG9mdlVkeHVZ?=
 =?utf-8?B?YWN3QkFGb3BFaG5YaDZyV3Zybkp3YmlxN0hjVWR6WTlwUXh4ajZLZVc5N29o?=
 =?utf-8?B?UGUzYTJCdkgzc3lEQmhHRW9aaW9UWUJTT0g1amRtdUZPMUFuYThaTU1tQkx6?=
 =?utf-8?B?TFZBQzkzU2Z2bllMK1hVUjhMb0puWG5OOVh0c0dDcVNKMHhiTVR4THY2K0pk?=
 =?utf-8?B?SnZRSVVUM3NySWk4eFdEK2x3VUtPNnlySmNtdGNjeGxKQTZtNTBFbTFJeFhL?=
 =?utf-8?B?OXBvRHNLK2wwekVsSHN3Y3ZpT0VhMVBjRGlEQ1NFK2hFVDJVZ0I4dFBXd1Nw?=
 =?utf-8?B?NFRCc0pUeFJGVkg0NW9JZVhjYWRuUUNMNHNMZlhFM0kvL0x1dW1pbks3RUky?=
 =?utf-8?B?K005YmYxOXdHbENzclJNaGxyTkFRM3hHNVVoYk5RYmNDanJ2MmhZZ0VLS0ND?=
 =?utf-8?B?ZGNvTXdMaWRucTRNUkxEbWtwNHhPWTd1WFZ6NHlybm9XODI4QkJWM3hzWkpN?=
 =?utf-8?B?LzI4RjZidG12clNHLzY1RnNLTUllWHl5QjhlNk5YYWRGZ214UFUrQit6RW8w?=
 =?utf-8?B?LzROajJaOEFHdmluV21XNVJ3ZUNzc1BVLzVJMWdkZU1xbWpoaC9LRkx3RUQy?=
 =?utf-8?B?cUdqRWVjL3J2YUc0K2JxNjA1czlrb0hIVHlBUUtncGxtQnB4Vk9yUTMvVGVF?=
 =?utf-8?B?b3JVVmYyR0pOWGhQcmpzU3pIcktxUVl4eDl6WFZRdElTbDhQYUVabE9sVmNG?=
 =?utf-8?B?WDZqRmV1WG9OUmZuRVVHRm15RjdadXdjS3NwRDFvUkdEYWVWWTlydGNGb1Fs?=
 =?utf-8?B?NEZnT3FPOUs5YW5aUWtoUDlLeWJxWWZaYXA0TFVuOTMza2xsNlFuOWFPdnd5?=
 =?utf-8?B?WHhTMGVkdVkrRDlreUNDbDFpbnpoSVdQQm8zVWpkUHQ3bks5dm9jYzNxMEpE?=
 =?utf-8?B?a1U2enNQYzJWL01WcXcrODFXdXVocmV0NmFEV1huVmFlR3VFd3Yybks1MUpJ?=
 =?utf-8?B?YmpwK3V1V1g1cHhUTjZWaC9WT0djR0dWTHNoN1FxN0M1OHBWU3Z6aGk3SlRG?=
 =?utf-8?B?aFpXYiswVHV6LythK2RvVjA5ZEdnbGFJMlRBazBpNWJEU0packtiV0s5YVdz?=
 =?utf-8?B?T3c2QS8yd1NDTy9GbXc5SGcyc0wxemxQN2RYa0EwcUo3Wm83UlNSZkUrYVJG?=
 =?utf-8?B?K2pCK05OcURSSkRWTlR2NUNmMlliZ0xveCt0WTArRGlqb2t2RzZ4Qys1TWFr?=
 =?utf-8?B?TXkvSkhIcXV3V1hjVkRqQU9aZEhXVy9TTVUwQzBVZHdqaUFEL2p4Zm05V2xW?=
 =?utf-8?B?V1N6d2cwK2ZZREgyMHRIMVo1RlNjaTRUVFpsSzlaTDdQOXJFbDByWnFBNzVF?=
 =?utf-8?B?aXRKOWUzRERINThpT1ArdDQzbVNkNHh5TUV0RDJ3R25ubDZ1dS9pYkdKQnpm?=
 =?utf-8?B?UUxLdkFCNlFIN040WGUwVVF1QlFTTFFYUHF5bXcvbGpGdUx5VGYvWEpIdmVO?=
 =?utf-8?B?VHkzeko4aXk4bFNqOWdiVkJFTndiaFF3dWFVdk5JWmxYVmJlNnFaenJ4Mml5?=
 =?utf-8?B?UDc0UWZ4TFVNdDFEWlQ0ZDVVMEZ3R0pEUDZTU3g5aFJFbEJTVm51MG03SXZN?=
 =?utf-8?B?VHB3dGxrS1lFdHF6eXI5NkFtVm9HRFRNa1l2Snp1eHFETHRyWUpOWUl1WDI2?=
 =?utf-8?Q?u0blqYIynPT9MwajJHkNwEWQS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb7e83f-8cbd-4363-7c28-08dc4b4ed945
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 15:35:20.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWyf9jPAKBFI3CoMW+af96DdHvE2fKLsF8a2mBnSEcaFUkQHvTgZaqwSNANUy79UVTm+KpXgxLSQlpLvy6B1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981

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


