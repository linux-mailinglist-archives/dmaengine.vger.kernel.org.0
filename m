Return-Path: <dmaengine+bounces-12403-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0B+TDIQaVWrujwAAu9opvQ
	(envelope-from <dmaengine+bounces-12403-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2136774DD65
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=q+7TerUn;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12403-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12403-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B414300CF33
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EA0331EBD;
	Mon, 13 Jul 2026 17:03:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A39329C48;
	Mon, 13 Jul 2026 17:03:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962221; cv=fail; b=GBTnR5e2m6gvU973guSxdgw3rS3qjUV+Qjdwnjm+sSOF9YSfcQVDnRuJKthdgPnk4dTgn1ibzJ26TgN8xkc165svmypa0hQgjFpj1jv8MtOLVxT4Cc9b+JV7kAjmMkFwT2HgKliB+ngohe7tysYIslrZR5CfYzxAdsm0ZJUQ874=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962221; c=relaxed/simple;
	bh=sf8qXVycnQYyQIc2Un9T97ggXFYss+FKV+ZWx6KLHbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OHbP5krA33ZpCafsSusTJy0IssPlTEYkSanduMhHve2LaE47Q3uVg0D/XxzIxHLU3akDh03kBAUUc1FvSOlJtIi8P6YYfxXUWD3E02bys4dq2HKvb6Jqcpd/dDpDKhvpeX3AQqD4jJEkECxdaSVrCk5mfV3XlUqLfb7+V1dpLB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q+7TerUn; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSMZUjYXOcFg+dT3ofCo5RU+ti4P+E0g1+9TNBCqFe8yO957O1NaG4ZtdYn6XYiU1Vs0noGOuQz1fnp4JfG85NK0xMLVRn3qY98IBRbsNB++nrC5+Fj2TP0iDmML8dJ43wnQen+2nktcRnFvO63uKOyaB6IfF2dEBEo0aREw8mchX+1DDLtMZ8RIvNQGh+gZMbjtKNSDP7RoDUJ/HEOocmIa7DC2hMylkOl1siRWHYHrvpM21ghHnx3yJ6cT6BQCE2BHj+hY9juBRrz8AlTdfq55zxF17wQHyxf0RLOdN8K2j30saHNzU8r274ZsNWgtHgusem5c76XKMHDExQK+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euXAQn19MRdR6uOmD5CK79TK7xWnNDXB7KM87jTH0HE=;
 b=vbdA8TelwXBt6Wi8Et9zw7fnEapePbFnKU3UB12Dv9Wk+l60ENMAW+tZy2eWcclrlfbjF5LcwNYwBH27+FgmZR27EPlHY6cedPvVDJjGjxZAo4l8D4+YcTD/aZ83Ta/OpGZ4dS0bK/wwcn1tqWyydz6r3oZVtAJgbdvHrPq07QfG0uilTr+CDQ9JR38clJgp+WkTr1KJtsOrcN5Cps6g3DydwbuQ2O2X6H5QlLa0OsGRTDapkOAf68jNjvP2VF8n0GNtEMp0ZpUxwnzir/wxwbQsbE75q6lwl3QUe63TubjGrIbLxgw0hcFPgyvwbFjdasFxGtXSMWwyxopm8O019g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euXAQn19MRdR6uOmD5CK79TK7xWnNDXB7KM87jTH0HE=;
 b=q+7TerUnbcAd+nlJn1bW1CfAyc6f6RGn6EwJh6DahGFtmDZlm1w1VPKvSKrVIXcHHm0dbLf9MKhtYe2JSuA1hR/sCAzpl6umnIZGyl+OojYQMcaPW6g4f8Cjsu13nUBvlyAl2Zx2pWw/ZWigoWERNYnQwTUrCFK+3AarBTo+tEMmRyZOjV2/3lYXaIibTHPkagfYymxPIC/0tR3/f+BSwkjKWe/zWPwSoFcIYnSm4LnT3q/J9TvZ6X8CkD2vrKD1CRS3uruDLJEN3wsCwMfpwTrwayY8BI6Sknk47ogquTzUWoOgD80TZMr1D794pqK1R3nzjAngRZGmvpnCP7IzYA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:36 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:20 -0400
Subject: [PATCH v7 02/10] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-2-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=1817;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aTxVcxg+WLW+ex4KKcOS3TIGtND9b5sRMxkYi3Csci0=;
 b=+8FJcyGynqAm4eLIBOtFc1VWEis18BgeIlsohq4/VsgZK60Rr5SqHDnPRzEoVnUsNV1Adj0s6
 uirLd250UwCB3v3RjOhL+OHgwzgmSXlw3MrOo1HBru8Ij7iBruwk3UP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: f000de2a-61b7-4a77-e515-08dee100ada3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YRKu9mNK29JnhEY/ZUuFIShym4mMInRqWQqJK/CtFeeSEaDrjQ0Vbq3+vHB5WkemA79SgjZNEY2aV359pZLtt1YCfnE+OUar+dfQG2bm25xjEV4wWEdl8dg/l/CubTXGDQLNDvYU69M3Os3wQT9PE3FWoSzdWgR8OvzMtT4OJdAl7IqV2qgQ3Le4Gp17Smgpy+O6EQMT0v+ksDNgK580kH0XCxcxLBseRpOUvULkmoAhQy/cr++UjCng7qEhFhI8psBzmBIqd+kVe5sbUQ5ukgZqqSf/b4rdkNXqiwy19PutGbirnACXl6zCm41Ule8q9DudoinuBK9WH/REfpGisQrFKP52c6AD9HPzQcmswwzRNwwik5Ind2RDEiVLvnowQBu7pGgwOiAIVCsWFREt7DPinyCqiAsNyuFnu/o8///4WXqOCfP2vEO4UcpaBEfvoZlxZ+7gEMiWhhifCxsQ3NNL/krPDkjcaVc4+mUGBfe3W4v4smD7bJsyds+OZF3HbxxLs1CmuicH+MElakv1ObnDeoAM19JwJgDUo0xi8anK2ZoE6/G+z8Id4tUuDBto/54qJX2YOyv+bF4FVF5DAS840E3duWaaBsnjvSwJWcl056+cfTgWi7HbRlpehlHp9D26gN+xf2ChfjV2F9WHlPhR96ZtBV+etNrHxEzHHtcD8DFCklMwDbkCL/M0fA3B5VW4s37qJEPDALAbDl0elw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1FYM05rdExHZXYrRVo1UkVJWFNwMVVzb0JkMmhGb0pMUnRjWUFMTGRGTmh3?=
 =?utf-8?B?bU05eEFBbnArSzRJM0hyVUxPWkhWeGlONjdFVkxLNXVZaWx0aGJmRWU5dG9K?=
 =?utf-8?B?QU0xRnlxMmxqOWVRR3gycVR5dHB4Z1AvYThpK2tYTXdoSHN6WmxrVWREUjdI?=
 =?utf-8?B?dHN0dExyYytiVy92bFFlZUQyU1RIcFpvbFFnVkNKVUpISjkzclZjaDErcUEw?=
 =?utf-8?B?U1VHclk2SGZ1K3I4RXd5UVgrcUFXRm9CbDZwenVMRG5Vc0l4ZUFpWmlQR3Q3?=
 =?utf-8?B?NTlZTVI5YW0xcVBmbzRpN2U4elJjak5INjErTmhvTG9oVTNsRmhBVG4wNHg5?=
 =?utf-8?B?bjNtdlRQVkptUTZoZ3FzQy9GM0FQeUlzalo2Y3hGaFVrR2ZDeHgwNm50bWUz?=
 =?utf-8?B?UlgxSnRvQjhmRitGNTlacFB2bjE1S20razJkZ3k1NTRxMDJTMHZzVDE4RE12?=
 =?utf-8?B?MmNjMHFlM2cvSGlMSkJTT255UTRUcWUvdE1ibnBRdEZ2ZDJnWEhON1l0T3Vz?=
 =?utf-8?B?QXk3SVY2bFNkRTJmUDQ1S1g4T1hDM2NNcTVPRFJ2YnBEcDF1dW02aHZkZUxw?=
 =?utf-8?B?b2d5ZW9DUklpRGVteHJNWmVFR2RxdTF3ZWwrSURpcFlUeTIxSHVmMWQyN2R2?=
 =?utf-8?B?TW1sZWVrVkpNNTY0VTBhaVJZVTRjOVF2MU41ZmtrV1VETFhzMnpaUEZrcWti?=
 =?utf-8?B?S1VjZ3M4R1M4UWN3azhjMlpQc1A1NzNGVDFVMENWb3loSW04S21JY2J5ekh3?=
 =?utf-8?B?ZGVjYU9mZ3Z4Mzd6Vnh6aWdPYmFnRkFvYWgybnkyRkVscjgzbUhhdVdxUXF3?=
 =?utf-8?B?QWs4VDVJcFFnRlRLcHhuVDd3U01ZVDd4OWVKdjgrN2w3M3pzR091UzlYbUt1?=
 =?utf-8?B?OWZ1TFQvQTlBbDZaYmN5UGVXYmw3Ky9lcFJQbnFvemxhUVhEZGJTMTRRSGpI?=
 =?utf-8?B?dTdvS3BWdC94UE8rMDRCTlhDVXk1YWRWOXBlQ1BpUFkxeGJvb0RLZnBMbkN0?=
 =?utf-8?B?UVprREE2Uit6aUhuOER0NkVYUmp4OEJkTldIR2tMY3RRYXROUXhsUWxYOUhq?=
 =?utf-8?B?NGFMV0kxYkVYWmNKd0kyY0w1V2p4UlRQZmxEZWtFdWFPdk04bEFMcDJWM3pY?=
 =?utf-8?B?RzlObGhsejdnQlRka1FabFYrQ090amN6U1gwenlUckdEYi9Wd2NyTk51aCs0?=
 =?utf-8?B?OWUxa05mMGZjdU5yWnpXY3E1NER3U0Y5cjJGM20wZWRMY1FsTVA2eWlIdHdL?=
 =?utf-8?B?c0ZTWWwvSWpvU0gyeUk3SVFhZ0xkWGJzWmdScFNZNEFPK2ZrTUpERHlCRXB3?=
 =?utf-8?B?YWFha3EwaHR1amdyODNBSXJKOHNWWVV2Z0M5V3V6b2FyaDBNY2M3UWJzcklH?=
 =?utf-8?B?MFdhaUxhNFdGRFFpNzQ0WXhoVW15TTZmMGI4dW84a3ZXanlTU0NkUTVnZjRT?=
 =?utf-8?B?OGRwUUlYZ1VoVGhrbGNhWTNZd3AvbS95NFEycUg4UFE3N2hDQUJYUnRicXZq?=
 =?utf-8?B?S3gwSXBZbmF2QkNSUFgzUStWc2t5NFkrcjJjMi9kSVJiM3NuVC9Kb3VvRzhv?=
 =?utf-8?B?Y3pOcVVxUUthWEY2WTRoZ05Tak82T2U1aldMTUpuTWVWaFpnYStIeEQvWlFU?=
 =?utf-8?B?cjI2eU1ORTRyVnNwNC9Ta0h0Tnhic1grbzhyQmUwZWlQMmQwYkgxT2gzc1I4?=
 =?utf-8?B?NVNhYmEvdzVOL2tqUGM1RDdjaFF6R0dFMmhzY2k0Y0NFWjgyV1VmSnpNZ1FW?=
 =?utf-8?B?OW1OaVdkNEVURC9wVWtTL1NvSmpvRGFWOGU3dG5KdXpiSWUwUWhxMUh0NGZH?=
 =?utf-8?B?OFlHZE1lVmEwd3lvSmZLblNJdHJ3YlJEK0xaaEZTSlFMUElWbmhtUlltak5X?=
 =?utf-8?B?MTgyVHNGUDJXZEpBVU0xbmdNZXZUQk8vVXFIWlpPTGNIeUoxS0VBdnB5VDVW?=
 =?utf-8?B?VXkxQi9HOHNzemtKby9GU0dlaTAxMEJsdEFmUVpjOXYyMnV2QVU1OVNNY3p0?=
 =?utf-8?B?S2VqTlBpVmpCa2gzeVhWbk9LVEEzRFQ0bERDZWVsKzVzdWZ5MDhuSlJHNlkr?=
 =?utf-8?B?b0VCckZmQTdXZWNVOUtSV0FNQm1BUXRXTG81dDVuTTRVZVVicW54dzJLM3lT?=
 =?utf-8?B?SG5VbUhtMDlCQ1ZGTUlXenM2QlVXT2wxd1IzRzY4a21waUVZbXJHMEdrTkpY?=
 =?utf-8?B?VFZaaG03eWZtdDVobDZBTlhqa1VlQmU3ZVRpMHZpWjJjK2VNRWZjWHhkYmhL?=
 =?utf-8?B?dzVzT09NeWRoamNvR0Q1RDFlNnYvdkRGdnFnTE5hWThTTHAwQkpseXVWeGVv?=
 =?utf-8?B?K2QyRGRRNFhWaGFiZkhRL2RLSzZ4eUI5UkpBdUQ0R2pKUk1KUklEVTdncjVY?=
 =?utf-8?Q?hGetN5TDzMELTOEcMgLR3081W32spBT98obiK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f000de2a-61b7-4a77-e515-08dee100ada3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:36.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jANij/Egmwf2k7uVbHwNzxKisS7nf18SMO6JUP4uH2rD1RKGSmVr+4os8uqIjAK3nuASqZVnztbBP8IVDa14bE8W3Iap1KavIj1BzbgB70tMSEEXgOelERAKUZc2g6g4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12403-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,oss.nxp.com:from_mime,valinux.co.jp:email,nxp.com:email,nxp.com:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2136774DD65

From: Frank Li <Frank.Li@nxp.com>

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1fec1b52e3d47..53469c8c8b82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -527,7 +527,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf71953..db5f45bf048c3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.43.0


