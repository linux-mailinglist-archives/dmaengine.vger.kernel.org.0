Return-Path: <dmaengine+bounces-8189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE6D0C281
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 21:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F7D308360D
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF931366559;
	Fri,  9 Jan 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BbvKiEx8"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9C366DD6;
	Fri,  9 Jan 2026 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989653; cv=fail; b=lqLHY9uDfNA0IxD29NdwncYPnL/MPzxIS6CQxJ0wod1K2Cn5X8IUId9bfszpFUDRMe04zIQWLwU6BoIcB00HV+4hB/Kra1n3Qc2DUkLqV96+0eVhJ1BeGrmgdzlcpK7wcgkhs1Q7YdQgWAjuzvwCQF4yrIcLqGT1dl7E6A0cavE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989653; c=relaxed/simple;
	bh=4k9Sf4uY073AU4Zy7K/tlX5wyZl55QSb0NqPzIQhxVk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EqJHTeBCJruqpC7sConoSk1OHHnqvBkFr5EItIgcBCpnXFPqxV2GLOrk0aBfogZD1IJZb29dghvyNp39QGDGNMf0ZbepVkrSRFIll/UvBvHVy+BPyjNQNMSXLcAMxB03ydcbU2vfegR8z7J8YNyEm8hWtWHVKXNYYpYP/OEEj4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BbvKiEx8; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar+Fmtiu4IH0NNoBvAC6pC3t/SSSWBFedfglCcrcDfEVohoq9Q2VmenltuP1Vr2f2BvGImqDj6opHCsxKjwF/9e2cSXph3GpKGUU0wIN5J0ob4dzVXyYO6kjgbHWu8hI45HKM89FQLDFVI7YMs7hYMkd+IuEnlxCmBwpb6bZAlxHFQFPjgAyhkuPfnUh6uLeIx2WzsnkI+r8eCezT2yqVZV0nwsRWJIMd5i/leZwyH3KjSmyh6X5gwjJatCwGCxsdygJjPeXgiShFy4r0dSZALmgGooCEPnklinQUt+heMCWCBBiC/NO1clo92LXmlbv4oXaIfNdZ/nvLMNGVJOhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS9nPj06JtVTHboy1Smzm840Fs2X9/tddoa0J6FqUFM=;
 b=HN6OoEhuwCy7d8hp0R8nBvBpU1wwd+OJB7i+SZbCDC1JnF15jqSWckJygUlfPT1QCeqEMaSQkJTTyfI5DiQTk5POWo0fxIcsWzfgiRFthMGGH9NJR1H1P65LT2vR2lmVr0FRKx/iOUd6PBD9shEflmMJ0UBPwvIH4f3tzm9yqqJ9nAnAdZ2RnZHgJR1PXGmB2LoyihBBm92X2lRTKbZLWf4jvPndJRf0SgOgO1UGxo5HgiP3x1oduROHryt2Bd8/RRgBzRXm0AUbSTp14k3Uq56psBCEjWygF1jq85V3VykS9MsDagPPTPKcitBusTbiy0+7fUL+hPzYC1Pny5ukGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS9nPj06JtVTHboy1Smzm840Fs2X9/tddoa0J6FqUFM=;
 b=BbvKiEx8S8hF2P2GNQok/y7H87fmokEXPcY5tuzOxcbzP6Rvcx3QhZCi19PgNyDQgB4i1rmM8pMXrHsrwrrxbBlt9OIt+/2iWPThXlygFt5jtyXJMN8mwqbnx6emFvZU/SX3ErzHoZuDfXon7ned4Q6j/CzDlAob10msYYO/humqQ2Hf/sk5HIxY1xYmhtMux9qREe56lRtXtnRQWc0FewGEqOfruvqKYW8QUai5YT9YTmmQd67RcoT1Ru0EKyfD3Qpt9eN6faHcoqTcQsd2VGmAkylZqu2g55P8uZUoPzrzAyc4vR/oR24LpeGGj4Zr8WRD8kz2zIzLVXxaC+/FTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:14:04 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:14:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 15:13:28 -0500
Subject: [PATCH RFT 4/5] dmaengine: dw-edma: Dynamitc append new request
 during dmaengine running
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
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
 linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767989623; l=8461;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4k9Sf4uY073AU4Zy7K/tlX5wyZl55QSb0NqPzIQhxVk=;
 b=9f3QVVPc9rKK+hdJAxTOgcMvKs8webn5gFNQreIEMeNPMudcavWSTlG7ZVsXtS5z7RYtCH114
 NdHWJsGup7YBl9/HG2JLAvMcjl4BNxhzgOxgi2Br4rj86FGRD/VuXQm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: e014d10d-af84-4e8b-645e-08de4fbba298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnV0aitVS3Q3bnFnM05xaFlWNkVZeVlDUUhya1pPMmQ2cUdPdElZZkZTL2lu?=
 =?utf-8?B?VFdiTjZFT2h4NGZyK293WXAwSVM0czNYbUxSbnBYcEsvek1XNFZCcy9ZaE9j?=
 =?utf-8?B?NDlNS29TQm9KZ25JTG5oZ3dJWVcxMDhIckxDSzVtYTczY3NWNGtGU25LK1BY?=
 =?utf-8?B?VG82TkVoZnN5WUNqRFp0TWpzRndCeS9kL00vZUk2ZXZwb3dxRGZNZmVKZDZS?=
 =?utf-8?B?OVM4Yk8zZkZmcHk1eXoxVmJCZHJLZzZMaW9KbVEwRnEzRStlcytJZElDanpS?=
 =?utf-8?B?NDVHTitOMWtkUVlNL3hmVGNIamE3QSt1alJReVN2TE4rZW43cXpqMDBjMlJI?=
 =?utf-8?B?WEcrdUJlMEZaSDlGenI0NUpaUnZJRTVuZXFJUWRlc0VyRTlNYlkzYWVuTkVB?=
 =?utf-8?B?NHJBM3d4LytpaGJYRHlpdE9JNmtnWUdwaHkvUG1OWkRDaVVKUDNFamdoVVlC?=
 =?utf-8?B?SGRRdGNlRkE0VXJ3bHJsL3FvSzVBWGF3ZDQ3WndGZ2xrckxleDdKbEkyT3NZ?=
 =?utf-8?B?dVVtaHh4R2hDVU5YalFyY0o2ek02RnpuOGM0aVNUYlJSQjd1L0N5RWFJN1Ax?=
 =?utf-8?B?MkZiYjdqKzUzWDlFeHFFU0ZFUzBkQ2JOSnlkMzdGb1JzOG0za0lUY1o3NXBi?=
 =?utf-8?B?WW5OSzZtYjlLcFJZa0ppVStJdWVxdjJ5SGlVUXBVZ3h3YmFjcEZsenhwbXRw?=
 =?utf-8?B?bUZKRlVuWUFQS2RBSEpWRWR4elJPbXJ3ZmJ4ZHNwbzUrR3pqMnlKMk4wNWM0?=
 =?utf-8?B?d211aTFvOVdIS3dEVGYzSVh0Mk5kYzh2S3o4L2JXdkxVMkE1am1Ja2RhdlhZ?=
 =?utf-8?B?M0xiL2U0RGg5ZUs3L0RyTnhnTmNrZk8zWmJoMVBLdHVIRlFxamNKRDd0anZT?=
 =?utf-8?B?TVBoVml1aDk3MndSNlVkQ29nMGlBUjRuMTAySUNXdTRLQ01qWWtHT2FFcVdj?=
 =?utf-8?B?L0svZThVcFUvZFlpMHA3Rkp1dTBybXVLSkc1UUpQaTM5UHFSTXVJUk1oSFJX?=
 =?utf-8?B?NE9RWTVYZVkxYi9GWTZTWlBmWTM2Wld0WXA2T0doeGwra3lnNkxyM3RjYVhx?=
 =?utf-8?B?SjZmY3lVZVNZYnlzWUhBMlh0NnZuVitOZ3NWRi9YT3Y0V3dSL243REpCL1Fl?=
 =?utf-8?B?Wm92dzVjNDU3R0hBczUyYWF2NEIxaWppbWxFMkFKRjhTbWxqajdXZUdiZVpq?=
 =?utf-8?B?Q3h4OW9WT0FYdUt0OGR2RUlMRk5TYUFVR3drNGhHa3BhWU1aUE5CRkljUFpJ?=
 =?utf-8?B?TWM3YzNmMytrWnZwVUx4dGlZalAxL21LcnRReW5CRys4MHZjZUlTN0tVM2c1?=
 =?utf-8?B?dVh1aTRqMzBUaWpuMHd4ck8vLzRlOUtrVkpNOGpyUEpBeExCMnF3ZFd3RnJh?=
 =?utf-8?B?Qk9uUERHZkprWXZER1gxdFdCZmc4eHRhWHZMeDhwZXFrZlVlOWJQTGcxQ1pl?=
 =?utf-8?B?SHhRUjNvWElXZlI3S0M0a3o5cVVlNkZtK3FJbnlUSWUzcUR0Q0RCNmR0STVM?=
 =?utf-8?B?NHpxSmdiOWIzOTJOZlBLTzhXeTA2MDZkdDZFZnNFM2xlRkJpa1M1VGgvWVdm?=
 =?utf-8?B?NmdUQ1E2bU9sbm1lMHZOdXkvS3lkSE1nZnAzSFI1V0w3dWNiQjIwQlg2R3B2?=
 =?utf-8?B?V2VlcXA0VC9keWl5Y1RDbDVmdEZhbElLYVdjdk1RVzZQM2FiVi9FSzZuUjBN?=
 =?utf-8?B?Y3dLOXAwNkZaVldyaS8vRkZwS0o5N3kxUUlHUFFHbFliWUFrUk8zSGsza2k4?=
 =?utf-8?B?V2VxRlE5MURtcHNPTUpSRDQrSWdhVnI2ZHI0QnNNdHNkZ3pzbndWdEhKUWFt?=
 =?utf-8?B?akxJTlNvZzlud2JoQ2lseTFpSzJiQTRTU2lLY2gxTWVSdU5lZVZBNWVobGtr?=
 =?utf-8?B?KzRIZFR0MnNJcG9rQUFZMkZHdy9WdkliR3E3VlpRdnhwWlVEQVlpbTFPcGFH?=
 =?utf-8?B?MUEyb3drYzRKY1l3R1FSVGcyZFRmZ0lid1ZDYTh4T2owbEVITmJEMnhSOHhn?=
 =?utf-8?B?Q09xbnNlb09KbHQyK2EraSt6RWE2RGtxdUxzdGRGS1RYNDVlS2tUdjNMNEdQ?=
 =?utf-8?B?YlBvQi90SU90S3NseWpDeVlOTzNoT2ZKS05qQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVRHd2M1RUswMG91MklkTFVCTUUzbHBpMTc5bEs3WlBKUlcvOUJ1V0tMK3A0?=
 =?utf-8?B?alVNb096bjVGNHh3R1lBYTc4SjczL0JSNVA1d0xXWkJ6L1k1cDdPa1o5WXp3?=
 =?utf-8?B?WnVMUnlUNmIvQUFTZzZBckFYbitsVXlLNVFtSWFuZDVJZHk0RnNsZTFKSnlV?=
 =?utf-8?B?S1Q5ZWRQbFp0R1lLZXZJaXBNSHh5aFd6ZElHcEI3RENvTTk1ZEhBQkVZay8z?=
 =?utf-8?B?NEdVV2ZEV1RoTjN6eHR3TDdDTStWVmF1azAxOEZzSDZsSlFXS0FxSm9TVXdm?=
 =?utf-8?B?dkFYbUpTd2JqRVVXWm9CbmVjbjJJalV5RlFlQ2kzMzk4akdpdjhEeEJub3lC?=
 =?utf-8?B?Y1FFZG9UdDJNNHhuZUF6bEVDVmpLQ2FWQXJGYVBLTTE3K2hmemgrNWpBT1N6?=
 =?utf-8?B?dUIrSUt3Y0tseVNmTXhCVmhLMjQvK3RSNHVBcUJmRWdNcVdFS2t2MWFvem5k?=
 =?utf-8?B?UXJJODZQdjRPWDVEVDVMcDJYU1M0QTNDSVk2VmNERVlZRXBVM0JacHZsVDVs?=
 =?utf-8?B?dUxseVJBZTBhWlF2NnJCMkR5TFdIT3RHS1RkVWN2dDcxYWFWZVozd3IybHZk?=
 =?utf-8?B?MGVsNTExN3dpYTdpMWNnM2RLWHU2YVEvVWoxcmNZS2NpQ1NkNVJtWUg2TUxt?=
 =?utf-8?B?TjZuU2xkL05NdVhqMkdGQTc5NG5uNE9ZaGZRRnZRSUQwMVlJSTlHeG9INDNN?=
 =?utf-8?B?dkQ5aUpBQ3c1TG5aWVpZRnp4dU9BaS9acXl3ZTFrb2pOVDZzRjAwSUVJbW9k?=
 =?utf-8?B?YzQ3UituNW00bHdkRXJMZVB1ZG1iZ3VWMWhwWGVTNXJEZ3NvczVtRW5qUS9F?=
 =?utf-8?B?cmw1d3dkbFFHM1dDaDBsNmc1bnNIUzhpRnJSNXBsaXB1dGVHRGVsa3B4UnBI?=
 =?utf-8?B?QWQ0QWd2L0NDNVNNWXJYWnZLZEFFQjNDVXcvTHJ6amcwVjVjTmtmRlRnQ2k2?=
 =?utf-8?B?Z1NiT1BrcXd6V0gxY2hlUlUrcVpZdFVaYXE4c3BXdG5Qa05ZSUZMUS9VQW9p?=
 =?utf-8?B?YXRDSWZwT1M1bWNnZUh6TDlwbUVUV2hKcnhqY0lxY0lDNGQ2OXlFY1NVaXRP?=
 =?utf-8?B?aGZFNEFnMHFWa1FWRmpLbG83ZTllVzlNaDNMSW5yYUowQnhhV0RmbmFCanBx?=
 =?utf-8?B?RTM1U1lHM2pydytjNGZRTTNFbW9JVjhLNldwOGlxa004azdWaVhncHk1M1ZC?=
 =?utf-8?B?dnNEejRTV2tsL0hXK2VZbDY0d0NGVW9VS2RmeFVNcmpLU3pLcWpXNlAzUDZu?=
 =?utf-8?B?UTVpMi9oYkhmb1Y2QlpUMktIN1JzeTdZak9sRzJmSGVPaFhXV1JzTUxDRG9H?=
 =?utf-8?B?V3U0NVd0eEp0UklVUVdrWTVmQVBNZUZwNG16bWxzVXhrblR1V1dhcWczU2lw?=
 =?utf-8?B?dzFmSjduWk5ibWZNSVdsdGUwaWtjekFTQlAvQWVOaUcyUVRWcjFKQmlnc3g2?=
 =?utf-8?B?b0daSlEzd0xjU21mQnNNNjRIbVZsREQrZEEwZ05VNytqUEJyTXA3VEc0V2Rj?=
 =?utf-8?B?alF3ZnFjTEt2M2pFc3dFODNERzlMMjZpQ1p3RzhSTC9VUklGTGg3T1U3T2U5?=
 =?utf-8?B?cGtXSTdVQTNOWGFUeXVqaFpSem94QlBaMlZzQWxDOGR5TGZ5ODFXWXhMMkwz?=
 =?utf-8?B?RmcrczRZMVg3T3hGL2xsSTFac21DM1lhWUQzMk5BcGlBdGVLcWF4SEc5Z3kx?=
 =?utf-8?B?aC9qT3hPbzVKbEVTMW5VTTdQa1h1UDRXSGRzeXdscW9mUmVNQUxYemZiazVh?=
 =?utf-8?B?VTFYM0g4d1RzaS9ueE5lUTQwWlp5bVRJQUR0cWdSNVBoUlp1c1piM1UzemVr?=
 =?utf-8?B?bDNrRWpTTHRQZmMycmhUaVorQjBoSW9tYkFJbThpTnIvaTRnSWc4Ris1MGlK?=
 =?utf-8?B?bkR5bVJGU2UxQmpGdytIMXhBT3hNQ0ViaHBFWFpxTWJCUGFJMm80NlBybWhT?=
 =?utf-8?B?b2lpWG1qQk9pWnBzU3pmVXJtWklHQTIyaVBzMUJGc1E5YUt1bUhOUTcraU8v?=
 =?utf-8?B?dXFPU1ZabFV2SG1FK3FJemVnaEFDL2drSWVBWlhSZUE2SVFEUUFiQWtYYjNr?=
 =?utf-8?B?Q3RFN1Bhb1hpVmtFellJZER4QU1UNzF5cGtVNDgrSVNxNEViVFo5elp1RjFJ?=
 =?utf-8?B?MUxaUzdrdHRxajBCaXlyKys1WUd3OVpDWW0zTW10d0ZWbG5EUnIyanRpY1pF?=
 =?utf-8?B?U1ZjMVBRbnRJSUozWkhCNGVFWG1SWE1BbW5qVFBvK1pJVTFTOUtXT01BN2hS?=
 =?utf-8?B?YWVVWjZNUmNLY3JaY0drUXJ6ZW9UUnpqRHpuZ0JrTjdYekJ1NG1Oaml5aStk?=
 =?utf-8?Q?yOSfJftP9LXk2HkkvP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e014d10d-af84-4e8b-645e-08de4fbba298
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:14:04.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI9fy2s3BQy741a3EDSAOIrEr+/VC/b1X7I1TZ8sz8R7EVwVZ2N3JvsPQDGwI8QmWQiLYeqGcQdf3z+5dgUtXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

This use PCS-CCS-CB-TCB Producer-Consumer Synchronization module, which
support append new DMA request during dmaengine runnings.

Append new request during dmaengine runnings.

But look like hardware have bug, which missed doorbell when engine is
running. So add workaround to push doorbelll again when found engine stop.

Get more than 10% performance gain.

The before
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)

After
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 104 ++++++++++++++++++++++++++--------
 drivers/dma/dw-edma/dw-edma-core.h    |   2 +
 drivers/dma/dw-edma/dw-edma-v0-core.c |  22 ++++++-
 3 files changed, 102 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 678bbc4e65f0e2fced6efec88a3af6935d833bc6..5aacd04bd2da4a65aabec48f6631f6f8882eecfd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -65,6 +65,7 @@ static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 	chan->ll_head = 0;
 	chan->ll_end = 0;
 	chan->cb = true;
+	chan->cur_idx = -1;
 
 	dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
 			     chan->ll_region.paddr);
@@ -82,6 +83,12 @@ static u32 dw_edma_core_get_free_num(struct dw_edma_chan *chan)
 		(chan->ll_max - 1);
 }
 
+static u32 dw_edma_core_get_done_num(struct dw_edma_chan *chan, u32 index)
+{
+	return (index - chan->ll_end + chan->ll_max - 1) % (chan->ll_max - 1);
+}
+
+/* Need hold vc.lock */
 static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -94,6 +101,11 @@ static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 		if (!free)
 			break;
 
+		/* need update link CB before last update last item */
+		if (chan->ll_head == chan->ll_max - 2)
+			dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
+					     chan->ll_region.paddr);
+
 		/* Enable irq for last free entry or last burst */
 		dw_edma_core_ll_data(chan, &desc->burst[i],
 				     chan->ll_head, chan->cb,
@@ -108,32 +120,36 @@ static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 	}
 
 	desc->done_burst = desc->start_burst;
-	desc->start_burst += i;
+	desc->start_burst = i;
 	desc->ll_end = chan->ll_head;
-
-	dw_edma_core_ch_doorbell(chan);
 }
 
+/* Need hold vc.lock */
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 	int index = dw_edma_core_ll_cur_idx(chan);
+	int ret = 0;
 
 	if (index < 0)
 		dw_edma_core_reset_ll(chan);
 
-	vd = vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	list_for_each_entry(vd, &chan->vc.desc_issued, node) {
+		if (!dw_edma_core_get_free_num(chan))
+			return ret;
 
-	desc = vd2dw_edma_desc(vd);
-	if (!desc)
-		return 0;
+		desc = vd2dw_edma_desc(vd);
 
-	dw_edma_core_start(desc, !desc->start_burst);
+		if (desc->start_burst != desc->nburst) {
+			dw_edma_core_start(desc, !desc->start_burst);
+			ret = 1;
+		} else {
+			break;
+		}
+	}
 
-	return 1;
+	return ret;
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
@@ -161,6 +177,31 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 	res->residue = residue;
 }
 
+/* Need hold vc.lock */
+static void dw_edma_ll_clean_pending(struct dw_edma_chan *chan, int idx)
+{
+	struct virt_dma_desc *vd, *_vd;
+
+	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
+		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
+
+		if (desc->start_burst == desc->nburst) {
+			if (dw_edma_core_get_done_num(chan, idx) >=
+			    dw_edma_core_get_done_num(chan, desc->ll_end)) {
+
+				dw_hdma_set_callback_result(vd,
+							    DMA_TRANS_NOERROR);
+				list_del(&vd->node);
+				vchan_cookie_complete(vd);
+				chan->ll_end = desc->ll_end;
+			}
+		} else {
+			break;
+		}
+	}
+
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -272,12 +313,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 		return;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
+	if (vchan_issue_pending(&chan->vc)) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	dw_edma_core_ch_doorbell(chan);
 }
 
 static enum dma_status
@@ -290,7 +332,23 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	unsigned long flags;
 	enum dma_status ret;
 	u32 residue = 0;
+	int idx;
 
+	ret = dma_cookie_status(dchan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	idx = dw_edma_core_ll_cur_idx(chan);
+	if (idx != chan->cur_idx) {
+		chan->cur_idx = idx;
+
+		dw_edma_ll_clean_pending(chan, idx);
+		dw_edma_start_transfer(chan);
+	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* check gain because dw_edma_ll_clean_pending() may update cookie */
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
@@ -545,26 +603,20 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
-	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 	unsigned long flags;
+	int idx;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
+	idx = dw_edma_core_ll_cur_idx(chan);
+	if (idx != chan->cur_idx) {
+		chan->cur_idx = idx;
+		dw_edma_ll_clean_pending(chan, idx);
+	}
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
-			desc = vd2dw_edma_desc(vd);
-			if (desc->start_burst >= desc->nburst) {
-				dw_hdma_set_callback_result(vd,
-							    DMA_TRANS_NOERROR);
-				list_del(&vd->node);
-				vchan_cookie_complete(vd);
-				chan->ll_end = desc->ll_end;
-			}
-
-			/* Continue transferring if there are remaining chunks or issued requests.
-			 */
 			chan->status = dw_edma_start_transfer(chan) ? EDMA_ST_BUSY : EDMA_ST_IDLE;
 			break;
 
@@ -585,6 +637,8 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		}
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	dw_edma_core_ch_doorbell(chan);
 }
 
 static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index fd4b086a36441cc3209131e4274d6c47de4d616c..94d49f8359b99a9b0f8ca708edf81ca854dff4c2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -108,6 +108,8 @@ struct dw_edma_chan {
 	enum dw_edma_status		status;
 	u8				configured;
 
+	int				cur_idx;
+
 	struct dma_slave_config		config;
 };
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index edc71a4dbc798386508e15f44e85c23e7e50f2ee..bb9a1682f943dafef28bcf52ab83f3485068f8ed 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -499,7 +499,6 @@ static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 
 	dw_edma_v0_sync_ll_data(chan);
 
-	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
@@ -517,6 +516,27 @@ static int dw_edma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
 	if (!val)
 		return -EINVAL;
 
+	/*
+	 * DMA engine looks like have hardware bugs, Doorbell will be missed
+	 * if DMA engine running, so last update descriptor have not fetched by
+	 * DMA engine, so DMA engine stop.
+	 *
+	 *	Most like issue happen at
+	 *
+	 *	  DMA Engine		|	SW
+	 *        ======================================
+	 *  1     send Read req for LL
+	 *  2					update LL
+	 *  3					doorbell
+	 *  4	  *Missed doorbell*
+	 *  5     Get old LL data
+	 *  6     DMA stop
+	 *
+	 * Workaround: Push doorbell again when found DMA stop.
+	 */
+	if (dw_edma_v0_core_ch_status(chan) != DMA_IN_PROGRESS)
+		dw_edma_v0_core_ch_doorbell(chan);
+
 	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
 }
 

-- 
2.34.1


