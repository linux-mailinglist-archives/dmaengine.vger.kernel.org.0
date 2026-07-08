Return-Path: <dmaengine+bounces-12129-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YcMTJsCYTmriQAIAu9opvQ
	(envelope-from <dmaengine+bounces-12129-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:36:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E957298E1
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:36:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=d7vRnKQV;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12129-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12129-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7081F305D255
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE654C957E;
	Wed,  8 Jul 2026 18:35:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696A4C9574;
	Wed,  8 Jul 2026 18:35:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535732; cv=fail; b=IoPPL/YWmX3MnhJdzw3NYlkCaj4349JjHIu0rwGairX1PguadFJszXJwsf+C6ZUm5wJSlArcTzzkfRvfHT5flsoMsQb0nUKiIUgZAn4lAgpXhWplCH0ltTar/ygNXsNM527HEZ78PtrkMmzvFpnm5YoxtxKFeSotCV3b8tSzkTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535732; c=relaxed/simple;
	bh=qVuuMMJsQy3hIe5JuUoqdQkCzZ4FIL2qJKmyn/KfNPU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JYXAt1AXij79OE1dv8EAbxhhtmIbJhiwHnzYicJWGvVXnDau92ivYj7A0tG70jt+QUc6xc3gmn+0uoRoqU20MzFElnA9chVbDGq/KG6jMBKy0YhtPiCNDTwLvIJO6Uxlycq93X205EBB3FMEWT8dLdyHaseqlCii/tsPjvoOoXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d7vRnKQV; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDEvpHSITa+kq/GvmJePbN3G4C16uGeQ8rVuMBBUb5EnmpgckjyEXznNjt07me8XNqlEOc1I4ijPdZ1jVaG0Bf5Zc4w+LkQuiEqNw4S+RwQ7GuV8ADHTO0tJdFMop72+vjRO76TtQUO1JtBy3ENJVJQ4ZFeWlP+3AQvvAB9uOV5ufK+svaKxwf5i5rKHvDGdpbopeGhmDyjglKxEZ/2gdYJb+GdN3mLVw6bbzMEUoWlqwOO5R9oZADiOzkOK3z0juSbjRoRNCQxaWcsg2DOLcPnFQQRafjwRurP2wntvETqkUutHqOFv4aeexfrxeBljPUubSMSd6CyPdF7vK2GXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htKCchOFJEB/1kcz9Ei0HvNuGZp7OR/PrXyB6wNOmQo=;
 b=HXKd3KttHG3vlm0pOLQAUoOUvDEExvPFhtDs7i7WbspIc2t0jVJasH8sbFE829MiFgd+2ATtOqmEUvvxpUxKLA/ph6LhQA6I6htkYhMUu2kLdm8uwpFj4Dh96wcQjleLZ9hjcCXtfs4IxIZZDStnhGlOU3CH2noH6LCLQclwLmVH7ay2Vrp66L66x2MOIEGnrrnMpi59cw2ieXXi2XxOMbrX163rVTsSIN9seEEdICIcfDaanAsuFktpXhyRS0Jv/rszlPdufGyqSciwgmHgy/k4LIswcMuVAmmAhS5lOre27RJ44h6+/NuN8KS1xILPqnmCAaUkTz8DIdIccIwxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htKCchOFJEB/1kcz9Ei0HvNuGZp7OR/PrXyB6wNOmQo=;
 b=d7vRnKQVwccldlqXPI+KzrYLvflIew+jX3Jr2X/ZQVi84lfMBLpWWWkUbAx8cZPHVE2nqfZ+RAbQAxxRaadzr7Sv5LX08rcaKm+SOB8kWWiPFsXhww5q0/S94js+4kTERmRoixUzVF50JviHF90HgBeZUH731dZ0bt1LyBPc3MbMYMBDT76uk3MfRSov2g5k5OFZJoIPdmTJRZ0wQLUpoMjh+uz4WHPOIXCkWOu688By669GQdY9LvN6tAiJL3k/uvuoUQZlp/ntJF7NEeGm8mOVNdJq/McE66eswpr2YV/JZ8zhfRcvL+z5gbArNjqplkPuWWkWvmhjpUpf2x0/Jg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:26 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:03 -0400
Subject: [PATCH v4 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-3-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=9141;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cj4nbH41Ro3oOo3R3LkUC+mTEQB5fEKv1fz84+0ptno=;
 b=LqbhDm6vCph74I3wxPtKouq6EDb6rbfBxK9GbHbMQruRojTd9YjFWK8Yflx6gz8ZLIY3u0ZBl
 SVEWf3tOb7nB+PsD3N+DJFD/Asnr93WZ2nYaRL8fmo+TZrXvjTIG6kN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 53924d00-80b8-426a-4049-08dedd1fadb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Ff0SfWkF5vIWl6U0BJbCmvET1zUYFY1LjlOoq4kynQ65A+Wq18Wi7tcNwcp43NcK6bpskLEGcB/D/Y7BH26MLnZ8/T5s8MfolY2lYihQyh1cKek4hUiTISZF/D8KA3S1ihKygb6woiGeVPr1btDH+8h5jpdFW7LhA+vzxRv1FK0CDD2Ka4i508ujHA969OrcMiLi3z6xFtRuLd5okYxRvh7wrxiQXIkyeMf5CjalqUMF4eTS0VHnG86lHnvGj84mNmCVBIu6PFHDmy0dQvKrwvtTkKVM60K6eS4QO1pkvvkm7pgH1MygDTelmAZsEFs4zSm/vFDlYitbguF3alFodxtoaG1cYdiAd/HGGbRxl/wOI0cyHhmpBY9Hn2cLPXJyDBfpme57Zby70dhQ/ml+d9KvEiwuqOmJ3tqukQs82A5STZsnkmnacCVP3Uj6XX6zHktubbYoWKQsvv2bdYbmcFdLdyFJAi4+nhEYEnOSy5yDSL1t9m+jwsZE5VmLkunp0+Cc271bOC8brtQ+wyU/bmMwO4ieVKuIukch3GJmODWdiwvbX5uWphZTOHwWOQjbWJAay+YoC7Q4KauCPNqQ0ApX9jPLB2QuG+voejgsi96e46BE1EN32Jvx62WH/hTemR007IT2ISnZvQ9BO6SQw9MNgRO0E+trFoWJSocmRQD0Y6ZnDjh2wD/SbeNg21Q1V9jfZhdhZE4kF53R+iBWDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cll4K0Q4aWJLVmQ4Smp3bklFL0RxdHMrQ1dnRDJlcnpKZlZYUEZyMmRwYWtK?=
 =?utf-8?B?VCtMaUNpeno0dVozOEVCVTZNRkg2NERpVkorRUlHMmhYVXdmMTJlcDNrV1BE?=
 =?utf-8?B?MU1ucFExSHF5bWJuLzZLeDJreEJGbVBEc09jNkk1cHgrbS9YWnUrcm5RYVpj?=
 =?utf-8?B?MTlVZHQ1Mm1pQjBMdkVIMm9DRFRoa2JkV0VrclpET1c3ckZGM2F3OWRRTUVF?=
 =?utf-8?B?aEE4R2s0N01lOEphRFBCemd4NXcrQlA1MzJFQk9ncm9kdlJpc0I0YUQ5Rzl3?=
 =?utf-8?B?cXFSbkYxWFJDNTdwV1FJNjhxVGVwWGNOeElNMTl6OUhibW85anRzV1pGeGJC?=
 =?utf-8?B?cUlIV3FpZjFKZkJ4aG94YVVxRjA5dUREQkJ3bE5VY1pEUTM2M1E1c1dzVmVP?=
 =?utf-8?B?QUU2cGFzMkhEcnAydUpqS09oWVpXNngxbzc2RzFFNGlCWnRSUXpQbzFZa3U5?=
 =?utf-8?B?empEQi9hdzhBTWV5eDd2YkpmZGxJVEdwQldTRUk4L29uWmVkZHhibzNtZkZq?=
 =?utf-8?B?VFN3VXY5SkVxOE0vNUxON0NsVTB4aWRycTArYUk3U0NLNEFvN0QzRi9SdXhW?=
 =?utf-8?B?SUpnYVNseWxXYUI2ZXBpYzRFNFpyVlhPNGZiazBoNE9YMGNpQ3pwYmR0emZx?=
 =?utf-8?B?YVNWSkdzeFlWQyt3Zmd0UG5ZYUlKaFZVc1dqRDFUNFQ5V0h2SFB1d3VaZkM0?=
 =?utf-8?B?Q1Z5d1pOTlloOEFRRVB2MEI5UDBqSHBBNnpqcER1bjhTVVQ3dGxYK0JtWlFn?=
 =?utf-8?B?T1J0Sm9HcStRS1hRYklqbVhXTmVwUzFKYmt5MDRQTlNNNUUwaVNFS1NVRVM5?=
 =?utf-8?B?RmlWQVM5MXAvWDRVMUVjZmVCbjhLdEJMRlhRcW9RS3RnenJ2MmF1b1lGNE1O?=
 =?utf-8?B?anR5cXZrOHhlRkdUYWdBdHBtaVdsODhCTXVKUWhNUVI3TDJMeEJZZkpRL1k1?=
 =?utf-8?B?OVpXZEgrd3FTdVdJTDNyYlltNU9ZOWFROXZsOS9JUStRVmpFRFdXY0RpRXhy?=
 =?utf-8?B?Y0haRzV6N2NYM05pdTJVVlR0bVQ3TUVPYnRjZ1BMR3BKTGtXUnBGSmtTcHcr?=
 =?utf-8?B?TjB2VHhmTGRDTk9HTEZFcU14QXJJNkx2ZGZBMzZlTE9NT2ZhTFJBQXlYVGdB?=
 =?utf-8?B?ck5tWmlaR2R0Rks4NGp6ajU3NzhVeDR0SHJtWUZwMHJwd3RvN3UvaUI1YVk1?=
 =?utf-8?B?bTBybGN4dW51a1JKSzExU0RvUi9lbWtvVFp6SVN4SmkwUms0T2lYSElQYzVH?=
 =?utf-8?B?dmd1WlZ5cTVpT1Q5WDI2T0l6UW9Tb3ErcDYyWlVPdkZnQWswWXJ2RzY2Nmlu?=
 =?utf-8?B?TnZqdXlzRUFUQ1NUd3hJbHFSUWlIN1pWWFFzN2xDRzhDeCswRHdpU3UwU0NT?=
 =?utf-8?B?bzJnVHByS01MVUliTWRSNmZpVk5PY1JwdUxlVDZNZ25UK01MOXYzNHQ4aFFj?=
 =?utf-8?B?V2doM3JSUDJvZTRkU3NEa3BaeHp4OVBVakR2aWVudGtEMjVzU25VaXAwRk1W?=
 =?utf-8?B?YjVaeTNuVGVoWk8rTElET3pGdkh2ZkVyZ3k3NytOMlNiTjZ5dGQwWU01WDFL?=
 =?utf-8?B?ZEVsOEd3U3o3L0Z3RUFJUFVGOWg4U25FWFVsMXFMVFQxTHZmTDNjMnl1c1pE?=
 =?utf-8?B?WUZCcWltWFRDaTk5YkpReitQMVZLaGI5WFBjRjNpRHJibHlUUlFPc3FkeWxs?=
 =?utf-8?B?cHVaMUlwMmorajVXWGpqcFJleUhMOHR5bzJPdEw2enFiUW1ZRUpDTjVCOFkv?=
 =?utf-8?B?dy9jNlRXT1ZvNmhyNUNwZ2I0bWRXT2UrTzJxaFdHY2RUQTdNbDFNZ3ZiaHJo?=
 =?utf-8?B?N1JrbXVtTTZNWTgvdU9BRzBGU1E3blVrYW1pR0tTYS9zWFE5SkwvL3VtZ2NE?=
 =?utf-8?B?eUgrYUNsekJ2eDFLYXhES3JrV0ZyOWE4aVh6UGcvaWowRHNBTytiWnpncEdi?=
 =?utf-8?B?S0ZTL29mckNwVWVLWHFCcXpZcXlnTVN5SlFyR0JRUGVRUEVGSHpwVXZoeDJi?=
 =?utf-8?B?Sjhxb3ZkWU9Ub0JJUEduVW4zMmN6MWI2eTJON09BcXlia0dRNWpnRTFVU243?=
 =?utf-8?B?d20zNHdnaTdpayt1Rm9HVEU2Z3lIa0NjMFRvVXNzODNTYitBbXA3UnRaOTlh?=
 =?utf-8?B?YzJqblJJalFxMWlQOWtxZFFhbHVTOW02a0ZYVEd1djA4Rlh6UDZFMlZCZzFH?=
 =?utf-8?B?bndHK2FMRUxDMDkvQVp6TTdGS3NmaTdYZEthTkdybWNpY0lUTlMzSjBPRVFw?=
 =?utf-8?B?d2lSckREZHFDWjNjSjkxRnBsN3VXbGNWR1IybS9GbFlkNE1RN3l4UkJaYnVw?=
 =?utf-8?B?RHl2U2tKMGhBQ3E0NEMva2N2MXQwTDBSaDh5MnZvUUt6TnViSVpxRHRmNXps?=
 =?utf-8?Q?/pplG8Qp/LBWQYpQdCmwaPQkT8cJYJeBrHaqZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53924d00-80b8-426a-4049-08dedd1fadb6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:26.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnN8UPzKs1O0FI3x1xO1A1t2fV5M/PiW5+bY3MSBO3wog4hoykK+12BZenclqmpa+fiQzvBaBGJHW+A0O86a6Nf2SNN/tVRFV+qez59vuYw183VaxHlbNAUmI7gDH80J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12129-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48E957298E1

From: Frank Li <Frank.Li@nxp.com>

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c    | 15 ++++-----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53469c8c8b82e..2652ad8e7a8f6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -925,10 +917,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
-		chan->ll_max -= 1;
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ - 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index db5f45bf048c3..b96089baf0f9c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index ee5c3c317557b..51e50f1fdcac4 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1201f1ab5f359..20089d57f8ab0 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 		/* Set consumer cycle */
 		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);

-- 
2.43.0


