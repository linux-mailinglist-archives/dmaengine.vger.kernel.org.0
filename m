Return-Path: <dmaengine+bounces-11998-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+HaOefXRmr/eQsAu9opvQ
	(envelope-from <dmaengine+bounces-11998-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:28:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 414EB6FCF42
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=hYnAJD1I;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11998-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11998-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB813107CB3
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E139F19F;
	Thu,  2 Jul 2026 21:22:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1D3A718C;
	Thu,  2 Jul 2026 21:22:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027343; cv=fail; b=SMrrxI0Etnwv4lAr6aG+IuL1S3rlDIq/RhjudTbg3GLqcRfxtmSOdufeydy3S+g2oNP+pjXazxgqnxe+ZCu42MKYp6KLoXKk/9LPBD7Q9t/9m3u/ooXeKDqF6VX71luFNy772ViWMBOSLTxYxqeA7VrJQPCKjj5IpslWcxyLbKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027343; c=relaxed/simple;
	bh=xCflwwGk4I/5tf3LkcNqvzhn+YwfAbFjMqeLRJBBovQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YrNqKaHpcLoK2hWSu9cSm3dSub+6t0lX/bbQx3Y7ehjG9HapfWqlUy1/l8e9F3ItJKf18UuumW40YiVh/l+2mXZzhTUrvyXI0tFYKjtu0s26kXVE4LxOxmmz2fEXZv74oEvI4KQa1ped+9cu2adR7eEvHmue4A5f/1qfE5w6Tlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hYnAJD1I; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw2rqyUzlzItkBLwI2qhkUaPYPT9Y1Iqtw/DVZhkOsLQ6CrUXJirx//zuXM9IlzU37SPT6g27DUEFFwSGJjYiVif/56opcG9PkKxuw9e/5+pUDdGBvAezM2m1CroYSiawokZw8lK8YNUTqM6j2T5Lr9YDglb3RMWZ4WxLjL8WVUMVoiE74E+XEo/umkC0s6ODz07ro7tmFpgtqdUCEDEQywb8pIOe+4A0u/kvMsmZ5PdU9i8Q+Ghjrkrazyidpqdouee/ek44EwPIZ0ykcw26qodxasRogzQNyyHYzqLUQp+y7yvSrzEzNbXOD3Dgl/Z8br+ZgdBbE4Kdu3PllIz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZumXrwKusVjgtjWReFdkjPWkBJLp6AodkNFaQKw9FUs=;
 b=rRpDv18g5UxkJaJJ2yHawND3SjN8YQcTR1GgwAhp7g8K7n/7lKXzq3E+SIZSjhO73OphWyEkoYMZXNKtwPpuxn0bQP4IJ7IretMi8SfzHOUYmykBB331lknzwdkH9swRqGAp9kGV6fZL3LoSyrtIDha5wWRjzmTFRb7FBzSKf8Ngi86F94xmU8uGKpFwGNXC8Dq/lAm0hxmFQJIXmaz7BgbqcRfflSCz4Ak3jxfyOkBq8/7VrvhxTqIa2n2NYaYh2uAc98R6XRqBufNwY28shV5NftP9A7mytNZPtbVC18KF8oZ0etXRflZG6FsEZRCxXDlXeQfYoTcSw3hT90K6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZumXrwKusVjgtjWReFdkjPWkBJLp6AodkNFaQKw9FUs=;
 b=hYnAJD1I5yyz4U0ngKXq8erh5I1tCBzJm0Z/lkzGjXA0xNfVRN1APu4GUCOpfiSdJ/wX1qY1UerBnel0rG7AkwgpWq8+nKaatgtBkALa+gC98gszO4UQQjB8hMnhgKwOhHIpu3BOP+mw8/0cTABsoZoBIPEWrlK2IlYwSsFZECgoAo+iFFn4HjlYY29svc+IxbiJMItKsoi2r3F+QErlXcIwkxcDv/vuVqB80AVNzxKxDEpjtnL0alwA6OvLpyvQZ3wN9CKqRONyGwuq2LKb91yHY6m4cI5DX3QXzB3qznQKxQI/GgIs8v0uXDGkGraeeDnif8beBCVbJd1sWV3hMw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:22:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:22:09 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:28 -0400
Subject: [PATCH v3 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-8-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=7698;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mnUpJ89ZTekfbB6mktUveF7osZFBJURzD6IIxi7XtZA=;
 b=ljy6mUG4y8jwDepN7v9uAU217qMFalcEqfvhOHNCS0UfeaLcYZiL41+cwWiVRlhFMZUm95ggz
 0tu8rp9dxNzB4x9KcAmjYevBp0z3TlNmJVRJmYWByu9IR+7kgIliNX4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: cb838e13-a739-44a9-b456-08ded87ff99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	qQpqkpVyd8zyPgpJQDVFEJrgZuPjj6MhoeSdlZUZ/kCVOQgGF7d/mtBS0nMiOGGHwoarNNp+R1cF2Lannt0ZS6NQVBKieiDRn6QT+0/lD4f0G9Rzf1iu5/GpUadsLeFYm8xGvz+9aqNbuwbGzswLfdC8nLsOuCi9iWI+MUr2Tucliyx1zhMv+sWIgL94KlmzyA3zBnBweajXJ5f1aWfebmv/morec0motLOeAQlPOyQAvjl4Z3uQ8IJj1sGcLNuEtdVgea7IDu3YxVC/t/gqCmffWhCHlHmvDi/P47H80Vmz7t6GcKXiIu7cILf4WBkQHXoG6iXUjCCu7gpqBT6SXlUByEMJ8GYnHMW17b9cb0vmBHzetMcEP24in4ZEWlIiKECfXYM537U9aDlT4OVXU+cB0bYSQwIEMeoP4yRR8mK+6fU1jhyEKyrdIfZ6szQjg8QpfGogxxreA6X3WiQXtYyEfIF3zunJfdwJWpVJXInG1KfzrFhQRphlCoOGJe5jzaxogyySjsAMar5cS5wy1l1p6DlBuvS9/WQaGL3zHEIInbjzLgj2PXsZImFUe3UESEqecMbF0OoufjjoHGeRZeg2Nkg9LYu+OYvm3YtusD+QuPfVsSVXVdieQiC/aLixTTfC8fj5CyuKhc9wlLdtv60/3VeJaQnbkMsQ87vREBn0AO0v0xF1dNS+dKsasMPcY1KBfRaO/nF7fHGR0XVATw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldoNTdtWHpUWUxnek5CM2tMRitMQ21GamdQWG5JOUNRU1VmZVkwaGd0S1Uz?=
 =?utf-8?B?ekpOaUgvelRYNU15V2UzVEF5ZjBGc1BvUTJHRG8xN0s0VE5iVktweTFmRFBZ?=
 =?utf-8?B?N3VOYXpWSVFsY3QrUGpRVnVnbTZKdVBORWl0Z0dDazlGNWI5V3JvQXRXQ2I5?=
 =?utf-8?B?N0N2SmNLNEtDeHAzYjBsVGVzOVYrMllPNm5wU0J0VWRIalBoUDRMeXg2MFZ0?=
 =?utf-8?B?ZnRSTWVxTGtxODZLanZiUlFaNWxicVorRUUxRWZYVThqa2hnY1hFTlExVDgz?=
 =?utf-8?B?ZUswb042d0RydCt3REtmN1dIOXNGN3QvTmN5V0o0RFM2aXNUM3B5KzJ2bzZE?=
 =?utf-8?B?SUp6VSthOUR3UFJoclJGaE1YaVU3T2R4SHNQaVZGZ3FGcURGN1FjYXVLaG1O?=
 =?utf-8?B?VEhhUGNRSDRhSndrNEl2RFg3VU1HRkNFckdBYjNDWGhoOUcxWVNWRHFrL0lB?=
 =?utf-8?B?TkZta2lLbE5oWEZPZURxSEZlRGhpV0dydURad3IwQXRRT1lrcVVicTdSK0p3?=
 =?utf-8?B?akNLWWM4UkRzQ2JsckR2UW50Q243RUdHVnZLUzVwOGIvaEw0NDU4ZC84ZVNV?=
 =?utf-8?B?RkkzK3YxalJ0c0ZXVjdxajQ0cEU3Wk5RWGJyK2tDS2RrOUhUQ1czR0QrQ0F4?=
 =?utf-8?B?Y2IvVUJyVlRZUFFtbEVnWDBzbDN3QWNvZFZwYmZvWmFhWFRRT3FtMVZwUlNm?=
 =?utf-8?B?TXNFTTVmc2V6dUlzNGdyR2tmaDk1SnpRUktZeGg5WDRITFhTeEZxbzhNVWZ6?=
 =?utf-8?B?dS9XM0ZiZ3B2TDBlaUgrYnc5c3FDZWYvdkNtZ3dnVUs0YjluRUM1amo4MXNY?=
 =?utf-8?B?WmhtQ3JXSjhGRnU5MmZCbXFQQXFKdHQrbUNnbGZHaGdhZEVLblc0bW1URWFh?=
 =?utf-8?B?eU5OZXM3YUZjR2lCeXJHUi85UHN0K2ZYbDBjUmdwaSs2elE3RWtPYkw2am5Y?=
 =?utf-8?B?WUsvTFhrZHo3UVF2SDhZZVpqelJ4Tk9WTGJPMFJ5aE1vZjF2eGNkaGZ6eTJL?=
 =?utf-8?B?RUxxVEliTlVXRHFMS1QrZTJFYk1uU2xlNDhsN3gzZm5CMjdtRmlYRDRzMTV4?=
 =?utf-8?B?V0V5QXVPenkzcEpVcUZPemlPbVpYRUdjOEp6d0N6YjNMZXBRaVQ4RWJUeXRS?=
 =?utf-8?B?azFFaGtLalRkVDFOM1BPQlRkUElYSHhyMzhGQzJwb1cwYU13SElFN1VLVVRz?=
 =?utf-8?B?RVE2OTZlVVRXMENHQTg2OUYvbHR0WkR2bUk0N2dtYVR1RW01eExwbk0rcGtL?=
 =?utf-8?B?T1JsVHBVTlNic1RnUHBNTEdXMFJFUkkwbU5uT3REZTBGNmJPMmtpZ2hCdU9L?=
 =?utf-8?B?RWZoU3NBTWYvTWVmVFhCNVFoNW05djFwNjEzUzFnMnVBanVnQWQyQUVHVDVV?=
 =?utf-8?B?UjJ3R0pxVjQzb3lJTjB2ODNFdmc3OHN6bWhuZ1ZoTi9aS0R5ZU1aYUFsc05s?=
 =?utf-8?B?Nno3ZCtFS2lXaitsZnpCcGxoekFHd0c0MTZub3VmUlo3a2R4Rkw4cjdwRldn?=
 =?utf-8?B?NmJYRVBzb0t5alZ2QXBPMndlWWgyTSs0eXQ4c2dpS2ZnYmpDNzZYSHR4Q09F?=
 =?utf-8?B?M0orRFY1NEtBajBtaGFKL1Q2VFhVNkVtME9JbHFiUnBLbmJiR1dJL2dtRE1R?=
 =?utf-8?B?UFVta25iYnZTRm95TVM4SFc2QW1ESURaNDBkY3FoRlJhcDZrMmtDTVd5Um9k?=
 =?utf-8?B?U1djL1p3TFRSSmE0K0E1Q25wb0VxSGVaWUJ1UnN3NHU0b0hLT0lvaDFQQU1N?=
 =?utf-8?B?RXdqRGNtRW42ZnBPbWl1bCtSUS9Hd1lJakppVmdWRVNBdXJ3YlJPUHh4YTgx?=
 =?utf-8?B?VEc1alRPKzZGNmo2QVZYMllZcnFsQ24rODAzdVpTaERqbUhrUHNUbEhTSEQ0?=
 =?utf-8?B?bklSSU1kRXpib2N3bzZDT3hPcGw0UkQ4K0FZZXk5UWkzR3ZtWGdDY0Zvc0Rl?=
 =?utf-8?B?elB6M1ArUUdXaGJFZHdDWjBCSzdQcmc2SktKWU41Q2w2KzZESWgvNzZ0dnhE?=
 =?utf-8?B?Z3JlaTROL3Vpc2hSU2V4a3h2VXNETGEvbE1rNER4TTY4dFFYR25mV1RRYXc3?=
 =?utf-8?B?UTc2ZHV2NytHZWtPYmljY1hWdmRtOTdrRHlkcU5ZNDNmbVd1cTdjK2FtTitS?=
 =?utf-8?B?RTVpK2pQM0dTNjZxK1FYT1JKVVVYMm05ditVSkdsQWJCRjFHT2tHYTdHb051?=
 =?utf-8?B?SnEyKzhUT0RqZzhlUzJXR0VUY0lIVE05eUJYWGl2R293RS8rUWFGZ2tmS2xa?=
 =?utf-8?B?SUp5M3A3ZDdrbWtLN0t3Uml5a1hVT29Fb282UEN3bVpxQk1wOUt4dU5wNzNG?=
 =?utf-8?B?UUY0QjBLQmNnN2EvY0ZkSHR1dkl3SHFqL3JGUzVSSmJjUVc3S2pvMVY3QTY2?=
 =?utf-8?Q?1qx5cOl1h7dXG9KgLTdSlbwjyNkxw2jnxbkFP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb838e13-a739-44a9-b456-08ded87ff99d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:22:09.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8hETmSyFwjtw0vEy06dREP+ZUPaESwZDfybfEOGD8YHaFh7S1I1+z/RXrr/NGMhZ7g2WuxT9LM6hMIyBEhOHfeL57uVtwRa6i2/iS7WK9jf/zqyggJ+geDlhGvNUcyR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11998-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:mid,nxp.com:email,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 414EB6FCF42

From: Frank Li <Frank.Li@nxp.com>

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
index 10ad63d7e6016..8ee2db0b3739f 100644
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
index 4cff839022213..ad0ed28c928f8 100644
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


