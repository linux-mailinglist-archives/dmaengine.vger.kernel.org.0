Return-Path: <dmaengine+bounces-11996-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aC8LMIrWRmqreQsAu9opvQ
	(envelope-from <dmaengine+bounces-11996-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:22:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818F6FCEAC
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:22:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=VVDLBfTr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11996-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11996-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BADCA302B867
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28C3A8FEE;
	Thu,  2 Jul 2026 21:22:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78539C00F;
	Thu,  2 Jul 2026 21:22:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027330; cv=fail; b=m68Ud+Qd+KqsyanR3bZlCygagJ0iAzIJDuBBvyannuuMwTOkV9fRvt9ySnnDD4TTnR3G6vvawzee+rOPHdspfGt3hWZz9W53vCuHZ46VI9vHxQNCXtFxqRzwe5SBhlXjr4mHF3HwT+8VPDxPX3uMEm7yPn5vj+YHv5yw8YeUzZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027330; c=relaxed/simple;
	bh=OieseO6hhRNztI3OdzVGQ8Oi/FhBV46zW2n1awU7c5c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gacwc5p0jFEit5UXOk/6UY8Io0aDaMi4paKL2yPnteT0CEwGhklAU3xTeVbWWBQ7Lus5VXsGYPqe/jvVltJUs5ummW/xWGIMhAEJEb6bV7ViNwEnH3W61ZxSAOk/AeL0wx9LwKKmxei+X9j58zrCmEHO7an+jKYPsGR+ekcV0uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VVDLBfTr; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrhkiYIz9uxAw5TP68pua62M3hp7h/JJyT8JbZj558fZk0+O1UtS3dNvBcsvmthDXT/KokzQ364Yw4U13ceSruk6Sude1QLnVCUE2MGi4RKQ5uB37t2lpCB4FUklRYEfvvMVmm9FJ798CIKC1ISGiuaQ6f5GR7M9ZNpYcM7eGun382qCmk9EnjNDqckf2CZfKNVT/T9TJpevsLdkSkGqIO/XbTG9Cap6bg7syI7qUQ2cKdlnrkLEXgnq/xDZ21FrodkiTRZe7c9AdpDURti9GiacX8vHfte5oIk4TIiHsmNLMrDQykyvhompyCvuV6a5G11qYXCRLy4nlR2BpYss4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XfIe6q/6UcLhPD0aRk02Bl2KTprZOZEolVqUZdy/5g=;
 b=hn0/Bl1MyotlTXNfEFOifCt0lWRJv27IpYdu1apKDC9z/5Qe2PZ9roTBsKpewxoPeAwNKW+br1+J6amfQDOcu34kP/T7WOhVttooVrPp9inXW8h9IPEwXXoDFtdLqWjT5C+NLzTmKpKyL3oeGJOxT+S3GFlfDBwHj+SleZ67Fescun+xpOjTUtj7RoaXkRmClZ29qC2vPabey11JD+Tsq4Kvt2FX2VMKujPrwaigUVYjt6tFJfSy83jNvF9R1Ca9xd/QhUNwCQ91KqqsD22E4B5Oye9dXyqyEhLh7Isak2ZXfedV/+9Y/nbGLXWy6dDASjI8pThv4GllGKr/PAerrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XfIe6q/6UcLhPD0aRk02Bl2KTprZOZEolVqUZdy/5g=;
 b=VVDLBfTrJs9Yy+CPH5d44HUJcSJwH3zU4APeKar//A9oR9ib/+8wJTbl91iF/wwOo3xW4nsxIXs9jFuP3KNoJ1zgTmVQDHBSMcHduSlmDmBo4eOv3HxuLKXeY2HMMGflrRAJapBg/8hphKa84tktlqzbdElUZfwk3G2JpUon1M7aHZNOMHuvTW+osT5onfkNDoRJcplMVZnZe9rc26kd5gNfVFbM+FmxowOLxuGsmty3fCMFOX2FkKaEofJZ4MvEJbGhq55a7nTQkQZqH2V5yp3LDZk0mLFaBq+4V8GPGAYticw3t7mus35pgkLnJ3MB8dkYerGUWgiJZrPWArB/lQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:22:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:22:00 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:26 -0400
Subject: [PATCH v3 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-6-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=6257;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wZwjy/zaVL0vDk1eKR8kmnthA8AxChxzLHgaN5fNpMk=;
 b=Vjj1y+p0dTn2u8O/iUMOVayx9KLML1X3yrFwNkRrhjWG10G5FTFCC5vL66NVpgHOzsujn2ZvI
 XTZI7Acf9eFCGm0lkGKl31AiaLsJCfBIm7bmDe3FU23mrvNMxKxgjbf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 484357f9-9b70-499e-0e2b-08ded87ff407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	mH3VOE/Zc/9BIuXlzDx4TzBbSZgkwt87554glpMRPfJ0aEQPve5sKKoHzwUARCjysD9v2+8Y9HtLWFU1NoAB2vmdixvKE1aIJf2VTMfAQLKic3KwhFR+gWSPXaOpuxPE3waG4TI6T7IpZ9vsZvADBoUsClb01xlBCsMWJOo37J9Npi0Cu9TIRUJsoVY4yf8Kbfflv63zrmfDTicdOjwsrjXICT04A9E76k9fJqrDSa6V2M1KyiAD7VJxGwdzeEs2/7UhILFwZ62E7+ZkSNc+uJTf6Ysnp09egQUWVzhrehIzgkvzWLwK4SjdvEV0xwehqFrxuDAu2+/CK0S+Ie8+XohGZ638Jtl4K6qcxrwZ2a+Lq36/wGNr1NxUXYoGqmBIGiwFq6xJvoaNPKCg3lHaB6GbMxfhzEBkccgEa7zB93+dclr1vVXvvArWKbvWQaEkgR4ryI06wodgiRhPt0vQ90Yt2gdtlcMWgEUSGNdrh/SpFYgdmKpUOCsbLew697W8197DtaBuRTYy9wwYYweuQRagSPXpYQoMn4J2KsYH5uQCDS7glVOU9m1QkdhdPSjc/yaypMXLD8fgIMb3HuUqI1EaS80/QzEztPnmODZXOk6Cc/jde9h9IeDcUy+K3Cek7gocd8NdQbcC7I+hIIU14ChGZJPu1HNy+ur9FJjEbMnHXkiSt94Ob17Jw88IfZeYJa5yGzgRl5UX/EliOq43Ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHB6Ym0xMHBVMEhDOHdMV2ZOQ3B2QUYvaDUzSVJFN2o3UWxFQ2NqS0lnaXA5?=
 =?utf-8?B?VUgvRmJvV0QrQVBGZjE1dWEwd28zSmtlcHVCWXJqNWVZTS9kZUpjclVXZGMz?=
 =?utf-8?B?TnNtVzVpaVZ5aW9zendrVUtBSGVWV3NLOEdNT1hzckRMcmJOZ2pPVEVqd0dn?=
 =?utf-8?B?NzJtOGdMek1wVUdWaHo1WDRvZENDQThSSXB6eW1yOWw3cEwzN29iNXM2aFo4?=
 =?utf-8?B?c09ZN0wzMFdhYU5JZFZNZGFZWGh2RUhSMlEvSmVVZmpXN1VJSjcvVUxmWUxX?=
 =?utf-8?B?azNhOXB0K2M2Y2s2WW9ia1pjYkNBdmF5QXRvSlM0Sk5JZVQ3SlJQS2RkWm52?=
 =?utf-8?B?eUJKVlZ6YjBGZW5QRGJ3dTZSelVpQWlWVFlhL21zbzVhckxhZFY3TFBYeEUz?=
 =?utf-8?B?ZStVa0lBdlRiaTdubFdIaE1sQXArTzlXUVhxVGlKN1J5MSsyUmdaZEFDcnlF?=
 =?utf-8?B?VlFtWTRNN1hvUTA4cUhCUjdKR2NSZ21OSzI2T3JBdWkzSXF1b2w4TDdqRmk4?=
 =?utf-8?B?eVVLdEpKQXdodHdHd085eS9nS0dRejZrR0x4NjFKM2dNbWVid0VnMmQ3NDFX?=
 =?utf-8?B?Q0twSlNHZ0lyeS9aalhEM2x5dHdaait6eE9TNEtLZ09qSUY2L1lYbTVJOVo2?=
 =?utf-8?B?RG5wSUJuT2hDc3hyWUF2ZTVWK0h0YUlRZHNtRzBKcjh1bkxZczJ0TjczRzAw?=
 =?utf-8?B?QzBqZXdxcFIwMGdYNThwY3NPYTJ2Y0d3VGZGa3JyaWFaYlFvbEZWRDJ0YldM?=
 =?utf-8?B?WlZKMElvZEQ0d2EzVS90Y3NvZ3hQSENwTU9zVTBxdkp6M1R4eCt4THBuVzFV?=
 =?utf-8?B?TUE1TDFoQ1k5R05MSU9YUEEyREo1UHhCUkVkeFYvdDcwYXI1SGlDRW9QNGVt?=
 =?utf-8?B?TldLSWxJMVRQMHZMOUYyWmV3ZDFOU2RQci9xa0UyQmQ5ZUJYZ1RQNkFOSXFI?=
 =?utf-8?B?TE8wcmdMcHQ4TG5IY1FTUlhEYTg4ZktKZlhNQ0ZXQTR3WVd6WTR0NVY0YVA0?=
 =?utf-8?B?RkNmbGNJbElBc2IzMWV5UVk4bGNFMFd0cXArdC9TanU4MGpIS1QyZG1TT1k4?=
 =?utf-8?B?bFpzTTRPdUNJZ3dkNHdXRWpDdnp1UVlnZW1ray9hLzNLQzZTRm9qRXZnVGVn?=
 =?utf-8?B?ekJWRzd2RVFvMUw5VCswSU1oN1BwODVWeTh3TWxUMHkxa3YvSDBTZWRuYk4r?=
 =?utf-8?B?Sm05b0dJSThNVkRibkNMbUdKbVhUQnErUm9VQjQ0NC9vcmJSTGpGT3BzczJV?=
 =?utf-8?B?NG1HcjdpcEZQYnhHaEFRSGRkNmlQWDVZcFVuNDhDaEdmT2NxVnYrZkJTSHln?=
 =?utf-8?B?aWVRSnB0Nmhxci9HRVMxc1hqci95VnlsRTFhWjJQT012SjFxRmZMbUM3NXll?=
 =?utf-8?B?YmxFYVl1VTROS25Wa0VKT1NlbklubklVUnBIVGtoNUQwbHhjNStCUUZ1LzBJ?=
 =?utf-8?B?QW5JR3phTmNWZnZnSEV0T293OGF1eGpDckxlL3VYd1J5OXd1Y0wzdjg1bjBS?=
 =?utf-8?B?R2xNQWJ5VFM1eU1kSUNoN1ZSVUhhR1drWGVQcE1MN0NDU3BlNmt0OWQ5c2NV?=
 =?utf-8?B?RDEydlh5YTE1ei9zalpkS1JUNmMwVWJOYnd5QlBXOTVmWVdaTi94T3d4RXBR?=
 =?utf-8?B?R3FManZsdmRxYnhFLzJoSFhjaFNBdEhydEJqNXl0cXBtRjYxU0ZMRkR5TjNX?=
 =?utf-8?B?d2kxbHc2Smtxajk0clV4eXI5ODU1SWN3SVZReWU4SjFYYlNxbXUrbkRaazJ1?=
 =?utf-8?B?VEJwY0FCaWNXUGRXM1pHeC9va1VsclBTZHFOa1k4UzVkMFo1UDZTaWNNemVh?=
 =?utf-8?B?anpObGYweW8ybWlyVUtxbnpwNllrZU93a0pmMUs0N3gwd1ljNWhMMjFNdEU0?=
 =?utf-8?B?cEl2NVl6Q1dZMmtVYnA3bzRhV1ZsSlJOTDZYdHYrMDNTR3piMkh6NnNTQUZ3?=
 =?utf-8?B?QXQzemJqSFBQRUY1cmhvUGZVY1ZYSkp5WHNZckprcHhaOUtTUTJNSmdYdXpn?=
 =?utf-8?B?Y0F6Q1pGeTFWZUNac2xWZmZHQmpVU3RIYjVUcnNGQk5lcXFHc3FRSEVSTzd4?=
 =?utf-8?B?NkFoRWFuemtnVGJ2YS82eHpTWVRXenRqUFhkUDk1Z3g2YkVPbEZlRWRjYyto?=
 =?utf-8?B?U2ozRzhmSWt3OE1IWTFVSWhQWitOL1Qybld2UlY0M2krOG5memRmd2tCQzcx?=
 =?utf-8?B?NzJHOEdHL3kzMG96QUNMalBUczZyUjJmb3M0VFpXVVVlRGpzVFFIWjNIa3lK?=
 =?utf-8?B?TkQ4NkJjaVRRY2FHWlpmaWFKcFdZdG81cC9HU3ZTd2MxOHNOTU1LMG1MSnlo?=
 =?utf-8?B?eURUbDRmYTIyOCtiakR5WndQeGhVdktpSjBaMnpzSkNGVU92aFlXUzNpVVhl?=
 =?utf-8?Q?4l/LT+Ya7MV9pYZw0xuUdH7TZ+RHXXRcXZq5C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484357f9-9b70-499e-0e2b-08ded87ff407
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:22:00.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBWiPL5P9uLUbSUWtANs69ZJKl2EtOB9rRTF1lNZHXfRfB8qCw0DEyPtNNgPOJ3RegM1yHYbxD6iX2K85j5pDONqSYb+IXXivPM337rH2n/ieW17eC9veOwKB5G3Fh3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11996-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5818F6FCEAC

From: Frank Li <Frank.Li@nxp.com>

Introduce four new callbacks to fill link list entries in preparation for
replacing dw_(edma|hdma)_v0_core_start().

Filling link list entries is expected to become more complex, and without
this abstraction both eDMA and HDMA paths would need to duplicate the same
logic. Add fill-entry callbacks so the code can be shared cleanly between
eDMA and HDMA implementations.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- update commit message
- use eDMA and HDMI
- keep inline to avoid build warnings. dw-edma-v0-core.c also include
dw-edma-core.h
---
 drivers/dma/dw-edma/dw-edma-core.h    | 29 ++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b96089baf0f9c..bab4d49c92feb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,12 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq);
+	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ch_doorbell)(struct dw_edma_chan *chan);
+	void (*ch_enable)(struct dw_edma_chan *chan);
+
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -204,6 +210,29 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 	chan->dw->core->ch_config(chan);
 }
 
+static inline void
+dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+		     u32 idx, bool cb, bool irq)
+{
+	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
+}
+
+static inline void
+dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	chan->dw->core->ll_link(chan, idx, cb, addr);
+}
+
+static inline void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_doorbell(chan);
+}
+
+static inline void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_enable(chan);
+}
+
 static inline
 void dw_edma_core_debugfs_on(struct dw_edma *dw)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8d38867cd9983..10ad63d7e6016 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 	}
 }
 
+static void
+dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_EDMA_V0_CB;
+
+	if (irq) {
+		control |= DW_EDMA_V0_LIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_EDMA_V0_RIE;
+	}
+
+	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_EDMA_V0_CB;
+
+	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
+}
+
+static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_edma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -540,6 +582,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.start = dw_edma_v0_core_start,
+	.ll_data = dw_edma_v0_core_ll_data,
+	.ll_link = dw_edma_v0_core_ll_link,
+	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
+	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 31bbdc6a40642..52c6ea09fcab5 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -348,6 +348,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
 }
 
+static void
+dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
+}
+
+static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_hdma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -366,6 +400,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.start = dw_hdma_v0_core_start,
+	.ll_data = dw_hdma_v0_core_ll_data,
+	.ll_link = dw_hdma_v0_core_ll_link,
+	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
+	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
 	.db_offset = dw_hdma_v0_core_db_offset,

-- 
2.43.0


