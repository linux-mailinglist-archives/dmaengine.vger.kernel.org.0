Return-Path: <dmaengine+bounces-12327-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2VyzKxAlUWrZ/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12327-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:00:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094D73CD61
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=FWCvR4eC;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12327-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12327-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AD4130C9A02
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3E472792;
	Fri, 10 Jul 2026 16:48:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D01472789;
	Fri, 10 Jul 2026 16:48:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702106; cv=fail; b=iGFnt3Z/KN3t4JdsR6G7Hj/+6D5R0OCk/m+BdFqgyxsf/YznOxTnoDrD7n1NuEGRcYiyMbTl113g0/KiLvCStElzsHRuUWd3x8OnIW9tyE0/D08hsis95TFXBa9uxeb0G5CYG1cfkMhjplryUZ5Ymi5e3zGkX62THV0fQ4U2nTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702106; c=relaxed/simple;
	bh=ka9kK4KrQsiFuQ8VaCuD7Ocm0ukLLA6FePwvwbbbQ5Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TPASfBxbBQajUr3BgZbxtXPjRcAKm/2CSe5D5W20wRCnbDUb/jlvoDiU5cul3V0dO9j0p1yiPKdlWl87UkSyWjKReMZCmxBPp9viPnhmH0/OVn5nz1AazFP8JKsoD5HwY3YQinQXK9g11yKQ568Af3e2LPVJbOQUpSgyXcUv+6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FWCvR4eC; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2KL+cPaFAoTZ6AEPp5mz8BtHh0P93nm5rSQcASOeZ43gsFPAwwBLGX1sDCz4fWtVv7sYmhOVo3ePTIm09FTjuodKMqOQkuj6ZZeBDfKD+AZ2CoVMvl+D4ZlwvtzMdnxc2V4Um1x3R66LEOqSfUTR2sYJsCYVfkd2Qh1/rsp9cGzg0xnKBLXUln8BmwjXeIXvRhnXzANHnBy7POBbVw1NqzmgfFBHO+bA1Onqkytvxg3u82qbzcvh4lTY4OPUSsMKJ4fNbgJPVrJ2X9MjvEHVDBRz0N0DLR7TPbWzxAKO/qnXVPdTHK/tArwCfqGRQ+Y1VygPiXjLn8n/iKIGdRf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdEl86LdkV9nKp9o1EJZUr5v0ExfYEdIWLsA5ZtNGBg=;
 b=w//oF474HVjj9nmnXw95lwG9BuKF+9IXdh/6iMbYMr/VAYgngXKP3r9zaTLPGuPzRAm08B/4N92Lh/gvXW0ws45VEApnzSVsUsZfuIKeYLbqD4u75GhAAfslGmg8lAUvJqCmfz+42OQfZVvpfOwwfc6TeejYpWvng2S3PJno+PtI10VsOPikpezXMb9hGbhr+m4aRJ0exz6cC9AzKBKaq72sAGYh/Lt92UY4ZD3/8t5y+3G3ODOmuVbF3q6lu3IgrigQ7/sr5/G1fAkgKarQooJLgdMZM8l/KJP1NBDz0ri5ldZunSh1pFisGzHtywgLb56AglgxOn+vOMCIw5VwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdEl86LdkV9nKp9o1EJZUr5v0ExfYEdIWLsA5ZtNGBg=;
 b=FWCvR4eC3vyIFylEK66RaatkglAbno1ja5RXz9nZTJ9tQzPPcrKlorvA9r7AkFARl2lMtrwMDozIcIt/sJqPqHaR11U+u7ysa7h+9mvz9qcfjRUkLWi0jQz4BRDUiUFpXbqbUAStttTlsvuqbJksHmC5+rBi5cSHnZTW5q3WMFazNKP9I6F7b2Am89RW+8XNWHEN+NrYIwn3Pgc9oNQ6AIXZBHl2lppilJTMgN21Cbci4mBPKcHHJLNp18LfU1jw4X8pXgb4959SsuMgl0xnVu5uwjEs98ytezlbeQ1EBn2mVUBF3kfRVNZNIYjCtkm55iEDP+BhiAoF+AIhzPpVwQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:19 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:47 -0400
Subject: [PATCH v6 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-5-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702067; l=8061;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4EK0D3D/aLmHCCY94Jg6tvOeSLTRe5eZn5kbz2AZWXQ=;
 b=URG7LDAC5shsbmFKoAfwFWC4muKiWX9pqVSL+RF4mGToaeA9Pc1zkyvlFKBoArDzeVe6J4TUC
 FsKxJpiWLj2CJNqbhAHOsRGycDk0fOOCnen2LfKnvfH9ZqWLGMpjcI+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 572f3fdf-8530-40fb-f92d-08dedea30bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T4A4wGW8TXcoa1ZniWah8eBq1v0bGaCa2zmB3I+WpyWY0bTYNjEcG9Y55m2sOXgUlrotpW4hD83/9xanFOBLAAGtWyQBcZyewmLTLpl4H/migzdvUpy/FnsD0dSFgEc/OpfVa7qBDpDXazycVeMQWp9i5bEhXmjoM3P8FWcdqRKJ2D4ZwDslpCBZy1XWsmVrtX623eI18YWRjlSbPXQBcGrQ+RQrO9aaZa/R0Ir8V1Yigc36rCEGG5FlbuD39QCUFvflSa2tD43l3RhsyB9uMSmjkJfcsB2VpQaO4tvFZfYAhSQo/ve+GLET7+zWO+5zFI1mxqV2WoMYtp0HEY1Z99kUTzX8TSZwkI5t4dls6YvYittFimvHSoeffkEINuGbzIcwDsDXpWzsfkp+kZKRfchF3Ybg9zBt7a7RKuD2Zc5qohO/LqGKHqUSCv6mWfkpd9NFxoPrNmlgir/FCmlpXLwha4H3fhsThyCpA8YkkbINHs5gUpvoLS/72Ria+yn0a2RApHshSP11+eDO5YebpCL7XDgjfz0sJ1mjO08gcn2tXW79z7ww5LA9QDfnDj+k7c1MTTWOmxakqbx8pBcnkS9NeGBJ4WxMoa0lgPZL+uxjbRL72T4pqgOhoXmhCLINZ1cF4e0P5LlNCjQKZVXIq3d5sNySjcFFFLabQZcWChUSt7r88nPrtHKI2KrLzoEHZumwCWRx/K9E55nbahvtZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elBnYnVmOTdJTjQ4blNuNFNyU2tMaGRGQXJYbkpqWGVSY1owQUVsTVlhZFNB?=
 =?utf-8?B?dHRrTDdLWlc2YzhhN053ZFBIL3FjVnpOTE1xZS9pQ08xazA4RlN3NjRZSlNJ?=
 =?utf-8?B?Ym82QWxQN3hrYkVJZ0t6YSt1RStOcjQ4NDhxS3lBYlJKZ0FIUVlrV0lzSEs4?=
 =?utf-8?B?QzlIVlE5VzYyZDlQK2UwanozenBIUGhTays2bVA5WURSQmNZMWhaN05aN0ZJ?=
 =?utf-8?B?UHZZWUVVQ2FqeFRsVmJwUmM4Z0JuYitlY3RGUGFOTnZxb3B1cE1sL21SNU1K?=
 =?utf-8?B?TTlhZnhIcmtkZ3g0RWRxcGVFNDBEMExEVTRGeitPcEE0WFBDaGxsTEtTd0RK?=
 =?utf-8?B?SzZ2aUlBcExIYVBBZXV4VFYrNnBqRFU3TFJwOFFESzFUSjVMRFU1cTB0dDI5?=
 =?utf-8?B?eDduTGZUT2FGcUNHR3BHSUJXeGVPMlNBcXFablZkZmt3WXo0T1dncDU2MDQy?=
 =?utf-8?B?VWpSSG9qcDZtdElKc3luQ2RtOS9pY3VNUW03cVJHTUF4QjJGWi8zYmN6bXNO?=
 =?utf-8?B?VXZTMmw2OTdmUEYvWVhHUmM3L0ZJSnllcGlXM2dZMUpVYlZhUlE2YXc4QVFF?=
 =?utf-8?B?RkpYNUl5bFZWWFNyWGVYUklnUHlwQVdTVC9GeldheXNqSG1iOTFVemhLWklx?=
 =?utf-8?B?Q05ZcktHZnJUNlc1d05FQWU4NHM5cjZqeGE4NksvSGJCRU9kNmdEM0h2b01N?=
 =?utf-8?B?aXVkVWxaY1YrWEZqY2RrY2ZtOTBPTzlwZS83ZnpLNCszd1VybzJRaDZ2WG03?=
 =?utf-8?B?VFFGOURxUHNmMUNnTEc3TVRYTFJPUGRwSjFTaFBxQVVUWE0vdHJUZllmdFR1?=
 =?utf-8?B?NFJEZmk4Kzl5V0tCbmpxb1owQSs3d1R3V3pYOWpPa3ZYMU1nOWpCanJDVnY1?=
 =?utf-8?B?YzJtSFdFZGthZlp4WEJKVlZOUEhQNnl2UDVXLzlKNXVZelFXclNQZFdWeEhn?=
 =?utf-8?B?Q2k3M2Fqa2w4L1V1NmgwVHIrMEZqSnllcWo2a2VSTFZRQVk5aXlNZzhsZVBM?=
 =?utf-8?B?czQ1UjJjdFRiOEIvVnVWM2h2ZUVES3JVSnBFbExQNG1UMDlRYUVmSHRRb1JO?=
 =?utf-8?B?aU1zb0o5SGJVeTVpRGFraTdrS2REeTdCRSttZnlNRnRyN0ZOSzdQVTV4T250?=
 =?utf-8?B?ZVFQMWNreGxVYnNidWlxNHVtdHhFSUtWZllBazM3aGQ3MFUvdU1tZTQwU3JX?=
 =?utf-8?B?aFJxVlNGWFQwamxnb0FUODd0NSsvSFV4bUUxb1dpTXJySDl4NHh5Qlc5Slg3?=
 =?utf-8?B?eXdXcWI1aERlOXZsM2NockFDQnJybzFuWG1RN0ZxaHlLd1dneXJWc1FUWE1B?=
 =?utf-8?B?cXJHN083RGZGUnBDQ1dsaklqaHBSQWl0RWNSRjZZb3VUNXFLZGErOG5PVTlU?=
 =?utf-8?B?OXg5S2VZZ292eEhEeUdCTDZoQUlOVmZWYllQOVJ3YXQ1S3l0aGlCU3UxUzZx?=
 =?utf-8?B?c2Ewc1RuNnVtWVN4QmIwSy9TeUFUd09kcDdHbyswNTVrbjkrT05FVGFVNmRK?=
 =?utf-8?B?cjJHQ2RYTEg0eEc5OWtMaXZaZFQyY0k0QVlIbTkwa1lTUnk3Y1hHOWdTaFZ3?=
 =?utf-8?B?Rlg2S0NETkxJVmdXVWxmYUNGbXN3YjBwOEwxc2dyQklmd2lFVTlkamduUmRE?=
 =?utf-8?B?S0Fmdm85U09BOGVheXZ4WjZoNnd1WnNxakkxUlVwaU83T2lQa1JTblpuL1hH?=
 =?utf-8?B?eVBNb0xNdjlVN2dTRHFERGYwSGF5SlhDcEMyQXhUQW0yaTRCQTJyL2ZtZEwz?=
 =?utf-8?B?bFN0VVY5M1h3S1ZDNEpmbGZ3S3hLUW1acnhWRW5hLzhsN1RLQnF4VldPZGxo?=
 =?utf-8?B?amlpMnFXWmpjTXNqTE91R2tnWFIxZTVmclFFN09lUmphcEhxblZkallPQ2pn?=
 =?utf-8?B?Y0lvbjJ2UVZVaUNMa3hBY2VSd1VmM3g0c0NmRW8rbUU0VHNYNHBsWGtPakho?=
 =?utf-8?B?NVRvaEkramVPUlU3a0QwcUhXWkVCbSt0TUJzNlNXdzBwdDNQQ01jL2gxaHdU?=
 =?utf-8?B?bGwvV0VMTjlJWVkyaGYxM2V4Q3dCWEQwRWxkc0Y0dndEeS96MjMvRVNhOG44?=
 =?utf-8?B?SEQvQmpZREVlMmhPWlk2QTlSQVdEQzhTcEZPTXF3U09nVWc2ZXN2cUdhc29V?=
 =?utf-8?B?cVV5QTcxSGE4WHl1MEoyZWpySlo5WjU4Yi9wVzczQWJ5d3MvQU9lYVdjWW9k?=
 =?utf-8?B?YkVVbnM3NlByTWhnd1JCdjZQaCs5WVBhVXBLZ1grYzZ4VVlSeUQrVytVTEEr?=
 =?utf-8?B?U0pUS3lhS3pJOGRyZWZBVHhtOU5qckpUUjNWSlgzTjlFSFVsbHFwNUFsTkNX?=
 =?utf-8?B?d3JyV3FFeGEyZWo2c0J1N2YvY0tHZk12NG9ZRHVSRC9NVWVWSERrOUUrcG9k?=
 =?utf-8?Q?uJ7k8aCKmc7IfPCZVP6Eodk+TU03IxPoZPRc2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f3fdf-8530-40fb-f92d-08dedea30bb5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:19.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm4UvMXGv9IBqZO0CupVvaGbjsWb4Ix1J9uevsU5X9vte/XSZwWKqAy7Fd5I/D2xY9gn1ld3Om702yYtCuxC7yzJB1mwNvDNSXZWMaOOfeUGVIMPtc3nssPGhFj7QEFj
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
	TAGGED_FROM(0.00)[bounces-12327-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 4094D73CD61

From: Frank Li <Frank.Li@nxp.com>

Move the channel-enable logic into a new helper function,
dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
link entry additions.

No functional changes.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4:
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 128 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  54 +++++++-------
 2 files changed, 93 insertions(+), 89 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c341aa5343417..8d38867cd9983 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,67 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
+	u32 tmp;
+
+	 /* Enable engine */
+	SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
+		switch (chan->id) {
+		case 0:
+		SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en, BIT(0));
+			break;
+		case 1:
+			SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en, BIT(0));
+			break;
+		case 2:
+			SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en, BIT(0));
+			break;
+		case 3:
+			SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en, BIT(0));
+			break;
+		case 4:
+			SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en, BIT(0));
+			break;
+		case 5:
+			SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en, BIT(0));
+			break;
+		case 6:
+			SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en, BIT(0));
+			break;
+		case 7:
+			SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en, BIT(0));
+			break;
+		}
+	}
+	/* Interrupt unmask - done, abort */
+	raw_spin_lock_irqsave(&dw->lock, flags);
+
+	tmp = GET_RW_32(dw, chan->dir, int_mask);
+	tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+	tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, int_mask, tmp);
+	/* Linked list error */
+	tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+	tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+	SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
@@ -366,74 +427,11 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	unsigned long flags;
-	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
-			switch (chan->id) {
-			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
-					      BIT(0));
-				break;
-			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
-					      BIT(0));
-				break;
-			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
-					      BIT(0));
-				break;
-			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
-					      BIT(0));
-				break;
-			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
-					      BIT(0));
-				break;
-			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
-					      BIT(0));
-				break;
-			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
-					      BIT(0));
-				break;
-			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
-					      BIT(0));
-				break;
-			}
-		}
-		/* Interrupt unmask - done, abort */
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
-		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
-		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
-			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-	}
+	if (first)
+		dw_edma_v0_core_ch_enable(chan);
 
 	dw_edma_v0_sync_ll_data(chan);
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 156b1cc225091..31bbdc6a40642 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -194,6 +194,34 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 	}
 }
 
+static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	/* Enable engine */
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+	/* Interrupt unmask - stop, abort */
+	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort */
+	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+	/* Channel control */
+	SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+	/* Linked list */
+	/* llp is not aligned on 64bit -> keep 32bit accesses */
+	SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+		  lower_32_bits(chan->ll_region.paddr));
+	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+		  upper_32_bits(chan->ll_region.paddr));
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+}
+
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -232,33 +260,11 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
 
 	dw_hdma_v0_core_write_chunk(chunk);
 
-	if (first) {
-		/* Enable engine */
-		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-		/* Interrupt unmask - stop, abort */
-		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-		/* Interrupt enable - stop, abort */
-		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
-		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
-		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
-		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
-		/* Linked list */
-		/* llp is not aligned on 64bit -> keep 32bit accesses */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chan->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chan->ll_region.paddr));
-		/* Set consumer cycle */
-		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-	}
+	if (first)
+		dw_hdma_v0_core_ch_enable(chan);
 
 	dw_hdma_v0_sync_ll_data(chan);
 

-- 
2.43.0


