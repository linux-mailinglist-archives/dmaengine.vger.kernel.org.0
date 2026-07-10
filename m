Return-Path: <dmaengine+bounces-12326-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fHtHAQglUWrP/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12326-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:59:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67F73CD5E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:59:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=sgv3LbgP;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12326-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12326-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04CD7305045D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8F472775;
	Fri, 10 Jul 2026 16:48:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46E472768;
	Fri, 10 Jul 2026 16:48:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702100; cv=fail; b=PKmi+yFBl3rf0Nk0igpWGgkiq/m2AC55HNStoVt1abyCo5WrbK3tZS9mSSsUF2hCzr2X0r+ujGo9Zf7mwhu0n8EKVqGl+9GiX1r6CSvSjXiuWMfkohPefPZq3sMxChoQqteuvBS8P59pvXLtEB6E4HsFTkcvOh/QwrVUi7jwdv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702100; c=relaxed/simple;
	bh=5ADtYYT9nHGg9r75fUUmD7kP+ZyXYecz9fkvhiP75w0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AS3fo0kHDqVKBvLdImtDlpsEN5u+JzrqY87zE5vigqVUa+hsSBJtydo7BZeS8H90zflgKidAxREQu1DpSbVXGdppyzWJp1c3F2oTZdZp6pfwcnn4prZjEt24kNIHGBleS68OlsWIo8CSz7zmH4tj5OEPfaLxeBhVr6sycju4Cec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sgv3LbgP; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/9YoAOu3api5+MMTfPZ7pbAnepdxzS7ZZbQsDVCcDtjPi4kUz1mOD49auWCrMZpnCM8UxftNy9PO4L8lOn9v/dPy06NbrWCLefz+0uh8pUNjdFhskcf0lJRFey84OyCrRrXF11OVuF1u/EZRKqbn215QN9VSgSQs255YsLFBAfsWLXErMHSx9MWgtfnoSmM00kX5bv5cbY1UzDRkSpdb8GSRJGbeolohyUKqQWrc1DKDVaDW76eQaJJabUvq04qJo9LobmYnw0W4vB26adkLyE6IOftPoeGiSYhGCGo82w8MV6fNp08/bNIQuXd7QENWBKHyfOEIaIhqFnnl5DVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=BSk0hFex1h1ob7f9JC/QHVDVc0nwiCgN4kCdOIWU+mnwiLv/X6ppBx3plXvizb2RbzK19FDKxaZS4CQWnen5+NngWcZ5Ibge8CJuHuxwmsXofDV6SjcOmad701xpdjLrOyiHnWtU+a3kN3x7lpqHfsQ9Znsmtk4JG8YV9zFy2t1O9QdnCg6MWRjuM7UbepIYQkVX3nZfU9xWnJGSVmpI6eWw4BguiI8pZIYsVoL/fSIw+jhWYK1cJp99MQPHVi+IC6bOFMSzlblsjgOwkMSc9PvDYnUHusxUVFUO1gPeLHXMQ3fOQJkkTePrvFm9c2lSlag7dtIV5QQF7OwSC8AwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=sgv3LbgP8I03XbF3haVy0vJxLlgLserDHf8jtTSIkiIow4nT1NnPzg1nIZzBt5Kj9/d4jw90yORGeLhhYAgcaPQ+JX8lBWMfugiEY0yFkUiSj1iDtTjc8BSKQ8ul1ltRPmVn9CiHGlKKx26mD0ojaHM50SF0AxitdVQMP5KYC4fW6lyJfLFdfTqqIKcUNnfImx0ysj58eshgODyDCh2HOb0UVW6H0sFslAUHpiuxM27noa19o2D8EwfGsVAtVjzYhSV321EfCEG2IKy0AcLNdWh/Fj3/grKlSbChNx1syRlPCZeFPmiZhkzrEENDb1y7S0SG7VNJWI5AIvVzwNWqSQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:13 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:46 -0400
Subject: [PATCH v6 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-4-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702066; l=6919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ErdapcPMmXhUaz/yq+JBAR/2OB2luFQ/CFcEy+/xZuA=;
 b=Ga/7h9VoMqTqOD5mKeCkJacLfKxnP9oo5LpKTz21qXHhpOIPvOsRTiYGb7unQPyXPXEO5G16v
 QRv26/H1xu6D/cY0G8rdDKElwjHWoz3uqxF4rRy6lpmm1f9vWfIPlkJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad0ebf5-2c6e-4093-e49c-08dedea30857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5OfhnsJsnG8xHFWT/Wf9KBTsctFVb3XADn0HN67Wl+X4eL0R1Q2HqUmE/h9k+a0Jd6SGYKLpENGaLqAcdiM1AIJ6Xhe50VlgK/ISmtw2WW032in+dKZsA5INCYXiYKe2nyO37BuOt2BVJvBMPNyldEu8ie/F/G7bMuZO9+Oz5FrN0PV5/JZrNiJCvs1h1gQ7SE+USl8pJqC7ib2QofwDZOfc+m15Ow8C+RORU3bNEounAoNDc3SCaIGUn7liKXo71EUVjByXw0MuEoW7HfZIblaOP4nrbg36hGt3Lz36EJT7X9HxHgCB3IAGdi7m9mCCJfzIIsK8qeG2jB+tZA+srfCLXn1kny9Mfum2LjRo4PMW9L0wCB5l2e4ckF7xtebJsDAK0RFDXlPutPVHGAWhGvwtzx3+RTQpSlnRELpdpJ+auNPxMhM1cXEk5/HelUimOnG5adWGRU8pD4ugMrMQZt9Xba5SU3P/wGlLvUsQXLAaOP2DkZJNmJB/CDTI9xPT+THcMXRazC5Qk0UVYVtkjXD15KsrluwOZockFte6IrV0Bel9kXYot3i1wzfwtp3bqMds4vrxgkx2FTq4zRhxQYvrXDOIjhnuQ2daAoUjtCNLLiUKs2qKPWkAALazcZcUgypujZ2e3cq1HK4Y+EgQRrSmxkbDQsCLo1C/OOTKyI2ZrdpmlBb8DT9qo/bXk6KvawXn1P+HmpDBsMoankSVtA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU8vejV6Zi9Sanpsb2dQNUdTWHByc2hSb2hzajhQNXBxNWQwMnMzUHYzeUt1?=
 =?utf-8?B?aXdjL0dOT2k1a0E3K0Nnd0JLOFp3VHVFZ2ZQY3c1ZUIwMHVoTm8zc0gvR0g4?=
 =?utf-8?B?QWtzbncyWFd3Tks5K1dLTWFacWpYV1BUMTdQVjF3TXFkeTJxaEhIRGRHM0ww?=
 =?utf-8?B?anV0OHB3ZWFiNTFvckJQVWlKMm5IeWlBSU11SmN4akV1c294THJtdzdSSWt1?=
 =?utf-8?B?TmRpUU5GZWs0QnQvSkV3VUtMZzVqa1BRNzF1VGs5OXpSZ0hWNFhsSmNWc0Y4?=
 =?utf-8?B?SmIvdkVCUzE5Q041MUNwSE03TGRTcEVYT3daYjBMU0R2alh0RGRYVjErb3Bl?=
 =?utf-8?B?MWFOVzhFT29UdzNFeklNU0FFdUdsMUhnQ2NWUjZXWmlSVVAxUWlMNTdCbGk3?=
 =?utf-8?B?MEhhcHF2M1piUVZNNUI1aXQ0V1pTcHptNStxWkJFeDNtcFF3WGpzNHltK3Ew?=
 =?utf-8?B?QzEvWS9XVUF4SXkzS0ZPaitXQ09HQzdwMER0RzVva1B1L1pjMFJPTFkxa3hF?=
 =?utf-8?B?YTNtNEJOcmpUcG94YWtxbUpFSFNpcm1DUkpyRzdQeEFWRExDZ3g4alRpdG5D?=
 =?utf-8?B?eGFOTEFwUDRpb1cyOHcwWWF3ZXR2eW55NXVjUjJoWG1FSlgrSHdUazdWemFO?=
 =?utf-8?B?RksvbGdMZnROWDVjNi9mSk5mZ1IwZ0Z2Rjl4bXlJd2g5YWpad00vcjdmUlhG?=
 =?utf-8?B?K0YrQUFVNFJtZldLZmNNS3diMkh2N1FPbldCMmxnWW9GTGNxQnRmd3RvK3hY?=
 =?utf-8?B?bm5OK3dpQ29SQUt4ZEhlUUN0QXlwVDNjdWZYWkJHMS80YlVZZDdMNzRGL0N5?=
 =?utf-8?B?Y2JCN0plN0NtdU5oMDZhR0h6VWJod3lheDQ3OXI2ZGZUNjNkZ1RoVDJCR2Fs?=
 =?utf-8?B?M0RMeWlMM3dXRm95VkVZMlZ3NzRia0JwbE1jaFJTTFU0NlVpSk10SGFVdEVO?=
 =?utf-8?B?YmE3RUhZcmozSHZVMlJWd1dHcjFqZkNJNnV6bnBnelBNMGcxYUZIcDNuUUh5?=
 =?utf-8?B?akowNkJkcHBWeVZtd1BYOFNDRWtTSHZHa2pFQWttOFluNVJGa3Q0bFlmSjVJ?=
 =?utf-8?B?OGFGRmo0Sy85RUlZZFQ2bWprUHFCZWVDcHEvSFZtNkwyN05xcTFqOHRMSjJF?=
 =?utf-8?B?c1VwZGIxVUE4Y1dYb0JmcGlyTUZxQjBuOXBqbTFkODZRc2N5NEhsMUpWb0Zo?=
 =?utf-8?B?OWRhRXBwVE5WUUMxbzNPSWdLS0JiSTdpNmJyKzlSNUJScVB1VjZvZEFXYlNN?=
 =?utf-8?B?MmIyNVhrcXpKdnZSUlNaWE1JcTBBa0VTb3pLQnBEdkNFZ1VXVll3bURRY2pj?=
 =?utf-8?B?RXU2ZW94dlIwS2NGR1cyV3Z6OGh5SDAxSHhqR0pqY2w4WkRvQ1h5NitNQ2dN?=
 =?utf-8?B?aEFSYlZ1WUJtekc3bmQ2d1Btc2N4L05HbS9mb2tqd1VXaFZFZEcveWZYM1Ay?=
 =?utf-8?B?UmZKdi84OENvVXJEYngwcXlPbzBqOEpFMWUyT2svTUtGajBHOTBOMExmNlRp?=
 =?utf-8?B?c05pRE9PL044NXY0U2RYcnpGTDRnbXhIcXFFZWFDOEZlYXJCclFuUVBFdVYv?=
 =?utf-8?B?NW5jdCt1RWxiSkhsT2V6cmFYK1NuZlQ5TUdUYWdvb2RDQitWY2lwbHhDT1RP?=
 =?utf-8?B?UkhBcjFPWjYxKy9iaEJKc2ZPdFJ0Q3JqYXpLRGxpWnRSbElRbDRJVUFTdHpU?=
 =?utf-8?B?b0RGdEMvQ3k3NjA1T00yamhMSnV2NUlFb2ZhVGNzdnArMTdERGxDUUNLVWl4?=
 =?utf-8?B?Ly9TT3hQTG9tc1VVSFg2bkExZDNtRWxXc28vbFNqWFJJSVVRVlBDSXY0UjN3?=
 =?utf-8?B?VWlIaFB5dGpWeHdaZDBtK1lDM1VmRVF2L2d0a3M1K3NqcURObmNReXduaU9O?=
 =?utf-8?B?cWpzUlpvRUF0MWxkMHJUWi9jQmp0Z081aS8ySjM1MVZRYXZTMzVrbE9wbkU2?=
 =?utf-8?B?NTBwRVdBZDM1YmxsR1VTZXQ1b0V1QWMwMjNTbnNGSmFISDJreFZKMUMwd3F3?=
 =?utf-8?B?ampvYnYraVZRSUFMN1NORXg2djVwYnRuWWwvdlZid0FXVjJTRm1kdnhkazEx?=
 =?utf-8?B?cmlkRmhCKyswQStYa1Q2TkszcE1LZ3FibEpEKzB0UWQ2VThKeDEzWEFLVlhX?=
 =?utf-8?B?SHdzWS9xMVgvMUxLN2lGNEVmSjdnOHFqaFJCZ1lWZUF4VjdKL1VxK2VlN2VR?=
 =?utf-8?B?OFZYSDFzQk5Oa3c0MlZiYWMvVmYzQmRoQlF5MkR5MmpETTZSMFJwTFJuR3NF?=
 =?utf-8?B?U0VUOU0rcnpacEJibDdZemg4YVB6eWVpVnBXR09JRXJPT3dMNkV2cDkwcFpT?=
 =?utf-8?B?OHlpa3drbmhLNmJrek1oQzhmNU1VYlkrUWhtWU95cG5paGxZRUpLZ29zV0gz?=
 =?utf-8?Q?9Dvl+VSsBfQJPVZktZq8o2ZpMQPy3wj9VBb+y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad0ebf5-2c6e-4093-e49c-08dedea30857
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:13.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8LLykGFhB4zVIlBB1R/p2/Yuc6l4sclEHaH06WZHmXJONl9+v/QrX+nXu7CZJPRF/7o5izm+5aVItzn6D/FC4WzuRnJ28Mo4uBk8JyEyXgH+lTts2oL87JfYnDnrgO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12326-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC67F73CD5E

From: Frank Li <Frank.Li@nxp.com>

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51e50f1fdcac4..c341aa5343417 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 20089d57f8ab0..156b1cc225091 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.43.0


