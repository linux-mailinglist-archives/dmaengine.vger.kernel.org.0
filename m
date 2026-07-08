Return-Path: <dmaengine+bounces-12134-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6bReF+2YTmr0QAIAu9opvQ
	(envelope-from <dmaengine+bounces-12134-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:37:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896672990A
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=OTErh3Zg;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12134-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12134-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 320F7305CDE0
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1744CA288;
	Wed,  8 Jul 2026 18:35:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C84D8D9A;
	Wed,  8 Jul 2026 18:35:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535756; cv=fail; b=Zll6qMZ0oBbvtO93YO6hykOm7V5/ppAkkGVF6J/43/HnHModB6b0W7ozBRYRHVf4mIqqHGeV1qM/5a474kEJQALcSobPKm9c19ejkTeWve+bjzzKfinEI2TTYUCu0pkeB9BnvauRr5TTWMObeqS/uKDvLnpGK0Fw0sCZtGN5Lcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535756; c=relaxed/simple;
	bh=ZGipr494m0d1oF5X8IqRV2atoMwFfHeL5ZqNIrXGVT4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=puEwLWmZ/C++aIjAT6KaQ+Cnr25eXwh4cW7ZYXrIBbS6xPz+xYC8sjIQvGky9DPQr+0EELNzfEMcT1Nx8/t0iTBOxCUBjsuhwcAgabdUpDmFdwkdR6t+9yhI8LFUwebLGFPCiYaR3wkkxcGBZ95SkVXquwx9o7/2C4cGH8EpgDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OTErh3Zg; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f24CxVB7WZf7e3UXW+/kNrYIF+vBWyav3Imkc2YLE9IK7X7AfyKn4C8Uinz7zio/Xb2HHPUgDYUKs7CRvDQmYBNXWaCzO0EW3Ppb45A+kTHe65DiQFSDZcaTDh9Z+MucUMSEag0UtP55xiKJ+zeWL3qXgjeF4w8GweHiGNN8ALlGn1NmxYtB5JF5gb7OWoa1BuQXPKAC6Y3n6lKZgnFDaSALAHNkLu/gBOEGPruAUZD2yJTpaGjveu9+7jWfIrZMF74f8tYFPg32KEDFe+fekPkqbdF8JjASNIjVpSD6vwDZa/RkkQjknVMohoU8BSg+gkmkYYFxx2QnUj7L0CH6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goI7oOu8P3D/92hQL22NS9PUw7qHJVgLP7B5rCuLxJg=;
 b=HfWAtk/Pn2gv+X+2/5Yr2Vm6nVwdRXbQvUIpWC5EHiMPxIebYD7eZgl0v4ZeJar+iC7zSN7WPIv6NhCsRapG44UPhSaecUITCOlMxSVhA5SfuXtCMrD8miBeW0Lf3UwT55DNpJzDhXxpnRituQO/N03imhcej2ooZ2FjzcOby3WxcLKfDzsGdmrSvOXqio7KP41DTDLuQVcOUVu4gX8vurNPsbCAkpuDwCNcp9gwRyaIxADr4IoenRiQN+jMFApHL6OeCAiEIZPkAZPLfKQu1S/o3ji8j9dbMXVQfqUhXxTgJeJQ0A8qrxtK3Vvbaffd4zybgrhiIMTeBpsJBtGKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goI7oOu8P3D/92hQL22NS9PUw7qHJVgLP7B5rCuLxJg=;
 b=OTErh3ZgX193DptiW89nWxd0MvX378+faoOJ06GbqeCe3aP/MqjPqeocT/dmmPwb/Q2R0qsFMamGYjfZdrPbiDZYtVnOeafIctxVKfYzdTJdm8IhERN/cdgCGBYdKRcUgkwOhlzs0ocs4PCeZUSpvtYy5ngY7Ehb3brgQSgrGiKdeak3gVGxUWn1mBz5w0fh28xAliOF85fklrCLSG2DDhIQE5Gww61LCatUqwRKYHgxpEPzRJsL8+dME5Q7MVm8fhtooaOe9pfeVZQCztAPqEOK4NEbDkALf62BesP1u8Tyga21yI7HWs7J9NH3IQdH0GdeReHdL1tRTP4NHxenYg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:48 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:08 -0400
Subject: [PATCH v4 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-8-cc128f0afb61@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=7783;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5wNiTIt210tjZzECyabmvGNuz/dnWdaiBgHGtRLK7CM=;
 b=WvidAgxMh8tyXHPAgVydMwTlZtWAaIWvPz79uUQ2hcb+kAmeRIlz/RmimR4XPgaLg5LRn9GIv
 mI7MUkCeYe3DVIAsJx6skzCiweBc8qmX6JE9XVTh9U6LveQim5sUr8L
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:806:28::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e55f5b-514a-4b9f-619a-08dedd1fbaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	ViE+zm/4QEV5sW7cc3tPMx9QkUFeJb9Cu3KK+aiAZ49Hs0PwmWqlo8Ylj8x0CSCou16FM813MLTnfrkLB/MU7WfwXZJuqLVwUREMUibRPgiPIKq3dTTn9rP44T5m3AtzvWpdNRxqtdwRm1BbbEA9paFvmjUZb6vRcRATWuhlVf9qCNnPU6e2F3umE0bP2/86+5cPm6eycPbBCiJ7Y5CMQfN5MOj1LvO6GuvGYuOWX4F+GGT3gvIwx/85lNrUgaEJ0HlE/vmyJ8gDz92BV8+JwuckgcLJUpkHLaQPOowneeyLAMhnZ3zSgupcsVEnqXsQA2xcax62N4KM4hzUF4fKyTicAZ5mVyQ34ALvzxsSULH8Yh6N2TULv4Y2Ry5TftUQ+TE+siUfZEssutTgUBTy7CWwMgMi8S1ImCcMZLJCpaBFk/TPHhW4kP5eijYuSgjI8J8N3ygM+hafATim1V7sQSlT9kdeNjVCWNdyESXEHE77I6wPI4suYzj3mQMRJb8W3et+u1joe3kT9FvKxJQm0+DFqaAui2i3f8t+9jYuQmxUUIClWmlshF18+alEWZlzZWhqzRH2fz43Y+DWviWYR4filF2F2acBq34pTVQ2J2Hj6nOPmY6scfxggM2fABX1bHfB347gSB7iXVZRsPrHBQFCvzq2MLH4t8A6/1qAoqufzKaJvZ/ONSmZMrGN4Z0egeS38gDqWw2W9woX4GzZNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZpTnd5dUdicGJURER0dVFudy83dkpNdDFtb29IeFVUblBxWlBPZ3BWR2JT?=
 =?utf-8?B?b1RlaDlvdTFpRVQvWjZyZmJXajJiM2lWcGVwODk0enNvMm5KQndMeVhjemZn?=
 =?utf-8?B?dm1iWm5XVk1TYVViN3RZMXZESGxSbnRsVkNoT0gvbXlKUExwdHY2am5iK1oy?=
 =?utf-8?B?bWUvdm9lRXAzSE5RV1cyRWhJVFJCT0ZxYVZ3WDdiWDNVRVlCSWYxWGc1a2Nw?=
 =?utf-8?B?c1Z5eXhvdm5FK1h4cDV0eFYzRnJPcCt5NitIbGtYdXNVU3RqV2MvNktYK1gr?=
 =?utf-8?B?blJ6RmdPTzB1VDhnSmJKNkt6VWlCaXl1T3JvdnVEcG5RM3lJc0ZnVXU1TWI3?=
 =?utf-8?B?TDdmMXRvVjdtVW16NlRTeWx0YnAwaFl5ZmR0RkpYdzM2alA1b0Zmek1sdENU?=
 =?utf-8?B?TEVMMG9xUzlJU3dLRE5iait6TXFqZU9hcmpZSHFyUjlyVjVYRWVpZDZBdXlG?=
 =?utf-8?B?aTQ0UVRBR21oZldkamFxbmNlemw5Z01TRXVwWklRVHhlM0dPUllnUXZoTms5?=
 =?utf-8?B?NkFTeEZxRDIxOUtFR0lsWGVzbXdGQm5kS2QwWWJPNWM5dGk0cmNwQlNJbVdt?=
 =?utf-8?B?LytRRURYSEtIMC9RazRwRkpLVEgzU1hLVDNmNm5xaHpCeWNIQkZyUzdXTkZW?=
 =?utf-8?B?akdvVWlDdEEvTzdiaUVXU1dJQ3RPd1ZsU1VLb2NYcld5RDBFVTRkejVod1lN?=
 =?utf-8?B?M1d5MTU4cWJNSThFeWt3U2RzUWxTRGVRZEdxaVJpQ0U4QkNUZDNXeTJ5SDRD?=
 =?utf-8?B?STN4OGcxTUUvV0VmbXJNTmJtY2tmbzZTRVZSQ1BHb3ZyUzI5MkJpanFVelJk?=
 =?utf-8?B?ZDZtRVhGOUpiR2Rxa0JZdnVqQWxCZ0JRT0tEaitFR2xFMi90d2d5MjJGVEtD?=
 =?utf-8?B?N2RHdFdJZlRDdmRHNmFXNUVSOVVTWVdEYmQ4YmEzbWtOUTl1Z01EeDQzMTJj?=
 =?utf-8?B?eitGWVVmeGNUZTFNc0ozMSs1TWJQMEwvbUNwZnJ1L2hzbXJQWHczeWs5TUVW?=
 =?utf-8?B?bFBPVTNmakc0UFNCTS93cnorc21vazU5SFBQdWpOckY3SHp0N3ltYTBMYXpZ?=
 =?utf-8?B?Wk11T0VTOTFDZlhHTzE5M1BCeUs2YjlIWlRiRlVNNFZhM2p6ZTlxN1hRRllP?=
 =?utf-8?B?cm11THQ4Ty8wZ0dvckk0ZHNaVmhla21ra1dUU3grb2FCQU9IMlBMVGI4QjFn?=
 =?utf-8?B?bUttMGx0ZDIxUWtYZTgxMEtnUWJjTHVtd0M1bXRGYy9EMGVhM1d1a1QzMzB4?=
 =?utf-8?B?eWJXSE5MbGhOOWNHdXAzMmFVQmhMUzhvdHdUTTFaRlM0MDNiT3pkQURhUHdE?=
 =?utf-8?B?ZzhGV3REU2lZUTA4T3pOQVdPa1BUWmU0WHdpMXIyUnIxYnBIRVppSVNhVU44?=
 =?utf-8?B?YWF4eG9iY0tEcWtDVDBqWGt3WW5IcmxvQkRKMEVMWkJ0d1RZa0djWHhWdlBO?=
 =?utf-8?B?TlNDMW1La2J0a09BL0MzTkdmM1VycExySFhaa2xqcVp0bHA3ZjV0ckVFTWxx?=
 =?utf-8?B?YWtnRVpLWW51Z2JLb0JoNUlOb2ZkUmczOGNEN1VuajJrT2xBQXFuV21aZ1NU?=
 =?utf-8?B?TUNwZ2NjbzFrd1lIZlhnMzVWUmRnWXhXbmxPWEM3bnJVMFhSYkpWRTFKTnJU?=
 =?utf-8?B?S3U1RHorSG5pWHcycnM3L3pqT1pKU0dEbS9ReG1LMHl1WExGaXBFOUk5bE5j?=
 =?utf-8?B?alpFZS91RVp3dC9zRWJ6clNCZXZibnRYVC93dFJHd0d3RHRHcVFuaDM5RkFo?=
 =?utf-8?B?TTV2SVowUmVhM1QyRTRlcE5vY1M1d2dYbGd5RVZsWEx6bkNvRjlLU1J1a3F5?=
 =?utf-8?B?amt5clRGSXBwZVVHTTRKRUh0blduWWtzN2sxNUVCYzltY2o2NCtneXo0dzFJ?=
 =?utf-8?B?aURaU2xOS2liMzNoZ21PdVdTejBBMzk4ZFNnVkI1Q0NNK0VGclFBSlZNd0Zo?=
 =?utf-8?B?V2RFaUs1d3Jjayt1cDFRa0N3cGpXd3gzYWtkSm5adkk4ckZoSnQ4Tml1bVVE?=
 =?utf-8?B?d2l4MElSYzk5ZEsxd291UkhRYklCU1FobTBPV2ROdmZvOVY0UUR6Rmh1U3V5?=
 =?utf-8?B?NVVMdUtVUjkxY0paNGZqR0NzaXVidjFYWVRUMlRyd0ZmZHlzNHNvUk1FeElm?=
 =?utf-8?B?aFgxZ2MxbWxFcG12VjM5bnhmcEw1T1BRQTBvV2NqM0QxNUh6c2ptSEFFaUc3?=
 =?utf-8?B?UFBCUk1ENS94ejZRQjZRakdKL0xZTTUwWjR6VXZzclcwUjMzTnB2aFRBL0Nz?=
 =?utf-8?B?OFhSelRlYnZWVDVEVFF0L3RFdXJSUkRqSjZZNzBuM1lMajRLeDB6Y1MzeEEv?=
 =?utf-8?B?YVhvallxT1FzRUdFeHduU012Q0Q0REIvaXgwRXl5M0ZUQjRXdVJ1em9lV050?=
 =?utf-8?Q?GPPxQnV8bo+vn3ifIB2v4v4AUhCJCoQSqO05u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e55f5b-514a-4b9f-619a-08dedd1fbaff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:48.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpLNhrRuDaYcFc7TNlUfCVRg+A/4Cl5mVrzdogIx6gVuuB469/RPCFqNXcX7AgPMmgMPCe+Y4kv3RDJPxixz9AaVCjyrnX5FPhemScPg6FICXhdCd2hdiZEMzoexryPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12134-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2896672990A

From: Frank Li <Frank.Li@nxp.com>

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect koichiro tag

change in v2
- use eDMA and HDMA
---
 drivers/dma/dw-edma/dw-edma-core.c    | 32 +++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    | 16 ------------
 drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 37 ---------------------------
 4 files changed, 30 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2652ad8e7a8f6..f52d9fd18e573 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -163,9 +163,37 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *child;
+	u32 i = 0;
+	int j;
+
+	if (chan->non_ll) {
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			chan->dw->core->non_ll_start(chunk->chan, child);
+		return;
+	}
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
+	}
+
+	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+
+	if (first)
+		dw_edma_core_ch_enable(chan);
+
+	dw_edma_core_ch_doorbell(chan);
+}
+
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return 0;
 
-	dw_edma_core_start(dw, child, !desc->xfer_sz);
+	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e18d6e827c2c9..27415f3a2d04b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -125,7 +125,6 @@ struct dw_edma_core_ops {
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
-	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
@@ -199,21 +198,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
 }
 
-static inline
-void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
-{
-	if (chunk->chan->non_ll) {
-		struct dw_edma_burst *child;
-
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			dw->core->non_ll_start(chunk->chan, child);
-	} else {
-		dw->core->start(chunk, first);
-	}
-}
-
 static inline
 void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c0746e5351410..7b4933c66f9f2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  upper_32_bits(chan->ll_region.paddr));
 }
 
-static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 control = 0, i = 0;
-	int j;
-
-	if (chunk->cb)
-		control = DW_EDMA_V0_CB;
-
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_EDMA_V0_RIE;
-		}
-
-		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-	}
-
-	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_EDMA_V0_CB;
-
-	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
-}
-
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_edma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_edma_v0_core_ch_enable(chan);
-
-	dw_edma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
-		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-}
-
 static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -581,7 +534,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
-	.start = dw_edma_v0_core_start,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 641a513bc52e7..4bf5a441afbfd 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,26 +222,6 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 }
 
-static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
-	u32 control = 0, i = 0;
-
-	if (chunk->cb)
-		control = DW_HDMA_V0_CB;
-
-	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-
-	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_HDMA_V0_CB;
-
-	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
-}
-
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -256,22 +236,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_hdma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_hdma_v0_core_ch_enable(chan);
-
-	dw_hdma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
-}
-
 static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
 					 struct dw_edma_burst *child)
 {
@@ -383,7 +347,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_ll_start,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,

-- 
2.43.0


