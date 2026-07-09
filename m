Return-Path: <dmaengine+bounces-12247-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id COeYNGrBT2qanwIAu9opvQ
	(envelope-from <dmaengine+bounces-12247-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:42:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211597330B7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:42:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bfG4k6vl;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12247-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12247-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5896430B61C9
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0C42DA30;
	Thu,  9 Jul 2026 15:34:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FA40D573;
	Thu,  9 Jul 2026 15:34:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611267; cv=fail; b=j6NbUaETAhIBXag4m/40XxEIDBn0MkceJXa/Alk1iC2lLpArwUyPydNzqf1bxDEvhENwIXzk2cl8sWwyLSwv2Gv3SQyjgME1qAy73lOLDbM9mxzVIx3JlON3Z5N5Hu7gtH4IiK6gs4S9BgkJvKaCSs1YiOSWoC+8rv7D+QhENxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611267; c=relaxed/simple;
	bh=xVhlwJbRwUhGf8e0Dio4Nvw0DYyz7mMtCcMyh28PDsg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=euBl9VnRJBYPMBfPHN7vssCLLm/BWAQPftaRjIFbF6hxIRsAj4sAEZ9sm7C6eIofLgOgL8RjApc+7Hj2gvqct42zmbvExWiMhdyq76HYcVMRx+USCvSVdUn7LMvK3RjLtbsRJb5JXVqvz+/UiRq+T/MqlkJgD2NBLNckDFuTBcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bfG4k6vl; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk6oWgwPB1V5OGVM0gLx2oYZ1q63xTcmLT9PMBbzXbxZ9A+0/hFGv1i4BPvQ/HHAnY5bWCjfL4XiR3WNAWe5LEoa3M12W/cnIQL0t896KvPw9VkF/H9OVEeRZdx/f5M4yuSBqpRJ9/uwbikif3XME3ei4pAvyWFL6+BigrBquvTv/Io49zOhS7LZdVlctE9UYuo81YRn72pa7u8jXFdzWdMcdYes+MnxIHzBtVDubmZhjcAeSngyVXzvYckGBmmM/NKhPNhPddSXYOLG3/3ELEl2tmVZm+ZtCuwypjopIYx3ekdec5c/nKV0OPFicF4sQtnYKIg1umo6VBAk/WDh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IBzu0YizHu4ieCAx5ptGgFcvIylz1CC5Qo7MwGDL7g=;
 b=NtO2SjEz8eHl2OpTgRnDQFDv44PlQCreWtpt4AqEWcgvjTngfLhk2Puak+FxCS+RL3bG/OAv/j5NtuUjTH7qmOAXTr+MiL4EUoBnIAbU0vmcu2sd0eGHVGNQG0EVxrLIfBaBkjqGl2zqUQ/QOBUQclf8FOhLzYmzlfHP69ikncDPf79PBxo6Jc90KszaIpzt4B+uMJZGoeocTt9uLMTnwRinHGySpJV71zIb2b/hQqmbcOI1fpXA+E8c+AJRF00+NoRCMQTV8lDuX5BCUDIV+ZfHZ+xUaj4h4LJ6HypzfXFjVtia5igWrNY2hm7c8GVf4KziPSmQ1hrFepp1X0tNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IBzu0YizHu4ieCAx5ptGgFcvIylz1CC5Qo7MwGDL7g=;
 b=bfG4k6vlS0XFjQnFZbSW7dhqGueKY6+D+ZVdZ5dPPaCoM9bJnG1Uq+CqZxm1v/tzjYYe1ZbWDwa0KKod4DhhQZXy5Lts1WlgxVyL5bUs7qx3V/w3ovtxee0HMWFxfXi13y4R5r5Jgek4kDDxUQf616hBFwxJP0hY17I0uzhHurpuUsPEhuGgbBq+ga5mh0wA8VbpZDGLidjRqCnfXTwZ8hdEMX/5lod1KKWe+mPy/z1w86tYqUPXpX8rtxXQJamZtRWpriRQazAp20mjZZqa676EaP4mbyseC08n3Y1iPyZbfiQF0cdWGBvwTH5DTaTOYoNEOyBtfPs+x8bMh6r7Tg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB9885.eurprd04.prod.outlook.com (2603:10a6:102:391::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:34:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:34:21 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:38 -0400
Subject: [PATCH v5 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-edma_ll-v5-9-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=8015;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fvdFCwUx61ZpT1ZZozWHeW4fTH43wYc3zVYFhM+WSTE=;
 b=jSFLpLiXWI+I3zZ7ym7cFgyYc2fM4gyxly011QyZ/KUJivJzP2K5TJmzQhWYR59pnEPEwH8Nx
 XH1V5JkUAfuC76BPybINhT9Wrkn7l1PVxcBR0UYuo7x7zDWBDgS2UYw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB9885:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fee8237-3048-481a-47be-08deddcf8c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|7416014|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	DsJtxjXnCVvEOmhTz08wCGpRjJaG+ejunf9Y/IJrA5IpUgzbdvIHfYGG4vk+q98n/UGvqwN9Egdb02IspRADMo5fJXfwDyy3PdGf40jquFbOs9Om9nks5do7Lzw112WeYlGMqONYw8FvNuWh1RT6TroHL0XHNoQtC8OBo2mEivKGf/ZY6aUDqEqwQG/WkDxsJfLaLGtPrMA46U42xzowdrx+Sgg9jLvW7Korqdk2SGim4rtWovLwfpmW9sS0YCjn4wrNfuVi2m7ESEuLRvyjekypmSHOuZ1bVuaUUEN2MxD5mizc5oT7J/rMvWyB4OWjFat+c+gWHi50tA/+7eGj1WKfeJSsZ7uNoqbwgAagJc7nYR4xTWjoCNCB7iCP8wlixnyORX7jv29EVYO8VyHBKyufPetQ+RM96drnlwVeAClNVGaD+L97SfTv1CFsRHWMuMLU/JYjtuXIXu0QDwokpJhIP8gPsa0rqhkjQRrfwnjhTXY0ysFXhB5QUELs/Qa4n6LNga9Ksj/og2TS9nLn+QGDdH9XuGX3HzcB0gjv8AJWKStXBFUm1iaR+OZhU30r5oFH/WZZDNr3wvuatlxodLeo3w4QaVEB9NDqmuZnzVUxY7xgIFeig3C2US3CYOOSjPHdroredatq50L+U7jcWjtaDr4Y5niPB+p+RMynktQ72Zfy8DkzVdGt81homZER2PlCOutYWeoxzNxEDAmHVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGs1T2pENXhKd1lZOHROdnY1TURtcHUwZVZaNCsxdFVUaTFSdzM1WHJqdUQ1?=
 =?utf-8?B?YXBkZ2VsUlB6QzlkV3Vxb2IzM21mOXNGdi9WbzJOSEFCa2ZsQWYxM1JXYzgr?=
 =?utf-8?B?QVVsQ1BYaUN5Q3k2M1lWQmVaRmw2S1d2UkZFVzdlMGMzRURQbk1GZjFFUkFE?=
 =?utf-8?B?TGhQU2s5VW93bWpjbkE5U0dvTytibXpoUzh4VjYyNHRsMExmSS82RnFyamVi?=
 =?utf-8?B?cFBMcjN0QUFaVjhQVi9Fc0lnRWljVWxXVWxxVUpvV3V1OTRNd3lDeUVXYmFS?=
 =?utf-8?B?TmJqWUJOd0hUQnZMZXZCWGt3ZmlLc3hhY0xyNEdTdHgyMWt3ZjZzc3lHVk9I?=
 =?utf-8?B?dWpIOVFKSHFVSEFTdnhaR0NLMGRxaEpabFplSmpNWFBuWmtOa000N0hSZkFy?=
 =?utf-8?B?TDhOaFRvOEsrWlM3OGhTNzlxdnJWVldZSXlITWxwdlBVN0dDQ3g0UVlMU3pI?=
 =?utf-8?B?Wml4blNHY2Rkekk5YTZLOHlrSkQyZStBK0lXMVc0a04xNjNNU1dVSlNNWDls?=
 =?utf-8?B?R1FFU211Y1ZIdENrbHJ5Qlh2cU16QVhDdFR0b2NUVFRvNVNvbXlsL1pPUmds?=
 =?utf-8?B?dXpkbDJEa0lHUDhFQ1N6enladmJ0UHY4MGRvU0xTaTZSNWFaNHdUZHdxTGV4?=
 =?utf-8?B?TC9xcE5ST3pwQ3pNeVNLaWxEeGRlQTJjTlZDS0NWWVFFVmltZkIycjNGQ1Ur?=
 =?utf-8?B?QzJnY0dpOEFUTHg3N2dVYXRnenJpcFAzYVlyTVg3L0tFQ1FUVCtsK0lqcEEy?=
 =?utf-8?B?dkZVSERBdnprWEdabzlMWWJ5eUZKcXhLckFmKzRoenlBMkp3RFFwQjJoRGlH?=
 =?utf-8?B?ZklhY2NRWVJmaWwzSTN1aVhERVNZSUdnOTRPOUZORElIMktIOW83djBKTmFH?=
 =?utf-8?B?TTZiVUFWZmJ6cXhTL3ZINlNTTHJpWnZmV01CMUYzUWwvci9PZ3FsdXNUcnZ0?=
 =?utf-8?B?SlFoT2ZqSEtaNWJjWHhwVXJic0h5VnVMbExoWm1iYlpGZUpCSk1jU0g3aEwx?=
 =?utf-8?B?WStMSzJwUXFXU3RJc3VxYStvR2VGb1diMlpXbC9VSTNSK0ZETVBjSFhjMHVr?=
 =?utf-8?B?NTNnUXBRN3lZcE1YbGUwcWNudDlCdkRaZEdaZDl1WDhtam1MSTZzdDZXSGR2?=
 =?utf-8?B?cUdhd3BmSGJPeHR4VEgrbnh3MCtKMkRzeEgxanVlVlFOcGZNaFNZUHlkZW8z?=
 =?utf-8?B?Qy8wcU5ZZ3N3TjJja3ZmcnZTWHRiRUloVEdwZ1NXUjZPaGs5eGpBaWl1RVNE?=
 =?utf-8?B?ajFvMHNKcURwSE0zVUkzZC8wN3dFOHRYeEs3RTkxNTJjc2c0Nm9UWmN3Tjlo?=
 =?utf-8?B?S3FTczZkZDRWN0poUDE3dFBISmh5YWl4Vmc0dEZxdFdxWVBNUllBc2pMeXh5?=
 =?utf-8?B?dFp5N1JYN2lmclNkYk1ESEF3Z3pVMGtPOE45TjlEdGlFazNGV0VlTGJuWFNx?=
 =?utf-8?B?bkxET2ltb3FMdXU2Kzgxa1JDdkY4eFdidTJIRm5jOXgyWWYzcU1VUGpERC8y?=
 =?utf-8?B?akZnd1BHVGkvcnE3aEY0ZDV1cFlGelNodWtnYk5vSkVyL0tHN0FGZDl5eDJW?=
 =?utf-8?B?cCtlQUNXTUZtVmFwR29ZZ09DY0tkV1haRUYyVWduQXJGQUFvNzV5YlN3NEdy?=
 =?utf-8?B?cnY0azdZNFduRmZwcklobmpnVlo4YlE1SkhVSmpKd1hKOGJOU2NWaWU5S1VR?=
 =?utf-8?B?eExGMitWVTRVRm92WDN4b3BJU0JkdG1QcVdUSUNQWDZ2eS9RaVJaUDVDSllE?=
 =?utf-8?B?UkttZHRtd3pFcDRHZjV4dHB3QkNtZEczTnRZTExvTTB4dnp4ZXRiRmpGNFg2?=
 =?utf-8?B?RGh4QUNmWVUwZWxoQzlwVkVISm8xdG9yUFJUaDVhK0toZVFDZEMvbm5vaXNl?=
 =?utf-8?B?QlY3d2Y5UFlWZWY1UzQ1bERZZDlabVo1Y1l6bjJGSWs1VDdBTUxIbmptSkdt?=
 =?utf-8?B?aElXZFJCTDFzRFhTSUFFM05YMSsyWmtPdnA1aDJSb1ZlTGFhUUtZSEVqR0xu?=
 =?utf-8?B?Rm8wUzNueUlaT0JOZGZKOVhtN25aV1dEMk4zYVZNYlgrbmd0eVFlVFBXZkhT?=
 =?utf-8?B?OG5lTnczNzAxdmMxUFJpbUtBZGd3Qmo0MVpYZjBIQmZSUlEzYmhRZzNMaVRU?=
 =?utf-8?B?RFBPZElqV2w3b0FWQU1HNkZ0N2NyMkFraHZmZGpOeEF5S1pWSUtRZWxnR3Zo?=
 =?utf-8?B?aUQyc1BPRk9MajVIZHdmdmViTjNJajQvSUVtc0VLUjVwM05PaVdkWSs0ZEpC?=
 =?utf-8?B?eHp4M245RXVmWjRHUWkxbmNLTGFZaWRGMDl2azdlQlNuM2VpTy9OSWtVMHBi?=
 =?utf-8?B?WS83aTk4NTIvTVUwVXc3U1haOXRSRnFIMTFwQVZJeFpaV1VMcEMydG1Wc0tZ?=
 =?utf-8?Q?McHjkHsLpBcGVBbBysVNvsPy8oJW7JbfM8HNg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fee8237-3048-481a-47be-08deddcf8c5c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:34:21.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srr36FgPG4QhU/ncoKdbFllJvFxVxaDO36DT44i3BbBOa00Nrw61goWGJwlzUvfP3cJ7r/TbS/iAMmGZkews/QskQtuAYDsTnfhMlCc54MPGxC7rzuiO7+uRH9ZL645L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9885
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12247-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:email,oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 211597330B7

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary.

Allocate a burst array when creating each chunk to simplify the code and
eliminate one kzalloc() call.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 120 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f52d9fd18e573..01bee22fe3b3e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,38 +40,15 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *burst;
-
-	burst = kzalloc_obj(*burst, GFP_NOWAIT);
-	if (unlikely(!burst))
-		return NULL;
-
-	INIT_LIST_HEAD(&burst->list);
-	if (chunk->burst) {
-		/* Create and add new element into the linked list */
-		chunk->bursts_alloc++;
-		list_add_tail(&burst->list, &chunk->burst->list);
-	} else {
-		/* List head */
-		chunk->bursts_alloc = 0;
-		chunk->burst = burst;
-	}
-
-	return burst;
-}
-
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
-	chunk = kzalloc_obj(*chunk, GFP_NOWAIT);
+	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!chunk))
 		return NULL;
 
-	INIT_LIST_HEAD(&chunk->list);
 	chunk->chan = chan;
 	/* Toggling change bit (CB) in each chunk, this is a mechanism to
 	 * inform the eDMA HW block that this is a new linked list ready
@@ -81,20 +58,10 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 
-	if (desc->chunk) {
-		/* Create and add new element into the linked list */
-		if (!dw_edma_alloc_burst(chunk)) {
-			kfree(chunk);
-			return NULL;
-		}
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
-	} else {
-		/* List head */
-		chunk->burst = NULL;
-		desc->chunks_alloc = 0;
-		desc->chunk = chunk;
-	}
+	chunk->nburst = nburst;
+
+	list_add_tail(&chunk->list, &desc->chunk_list);
+	desc->chunks_alloc++;
 
 	return chunk;
 }
@@ -108,53 +75,23 @@ static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
-	if (!dw_edma_alloc_chunk(desc)) {
-		kfree(desc);
-		return NULL;
-	}
 
-	return desc;
-}
+	INIT_LIST_HEAD(&desc->chunk_list);
 
-static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
-		list_del(&child->list);
-		kfree(child);
-		chunk->bursts_alloc--;
-	}
-
-	/* Remove the list head */
-	kfree(child);
-	chunk->burst = NULL;
+	return desc;
 }
 
-static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chunk *child, *_next;
 
-	if (!desc->chunk)
-		return;
-
 	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
-		dw_edma_free_burst(child);
+	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
 		list_del(&child->list);
 		kfree(child);
 		desc->chunks_alloc--;
 	}
 
-	/* Remove the list head */
-	kfree(child);
-	desc->chunk = NULL;
-}
-
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	dw_edma_free_chunk(desc);
 	kfree(desc);
 }
 
@@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
 	u32 i = 0;
-	int j;
 
 	if (chan->non_ll) {
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			chan->dw->core->non_ll_start(chunk->chan, child);
+		if (chunk->nburst == 1)
+			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
 		return;
 	}
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
-	}
+	for (i = 0; i < chunk->nburst; i++)
+		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
+				     i == chunk->nburst - 1);
 
 	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
 
@@ -206,14 +137,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk->list,
+	child = list_first_entry_or_null(&desc->chunk_list,
 					 struct dw_edma_chunk, list);
 	if (!child)
 		return 0;
 
 	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
-	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
@@ -425,14 +355,14 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 bursts_max;
 	u32 cnt = 0;
-	int i;
+	u32 i;
 
 	if (!chan->configured)
 		return NULL;
@@ -499,10 +429,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == bursts_max) {
-			chunk = dw_edma_alloc_chunk(desc);
+		if (!(i % chan->ll_max)) {
+			u32 n = min(cnt - i, chan->ll_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % chan->ll_max);
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 27415f3a2d04b..4950c57fca34f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -43,7 +43,6 @@ struct dw_edma_chan;
 struct dw_edma_chunk;
 
 struct dw_edma_burst {
-	struct list_head		list;
 	u64				sar;
 	u64				dar;
 	u32				sz;
@@ -52,18 +51,16 @@ struct dw_edma_burst {
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_burst		*burst;
-
-	u32				bursts_alloc;
-
 	u8				cb;
 	u32				xfer_sz;
+	u32                             nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_chunk		*chunk;
+	struct list_head		chunk_list;
 
 	u32				chunks_alloc;
 

-- 
2.43.0


