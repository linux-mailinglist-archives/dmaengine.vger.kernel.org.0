Return-Path: <dmaengine+bounces-12245-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vCd0Eg/AT2o+nwIAu9opvQ
	(envelope-from <dmaengine+bounces-12245-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:36:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05B732FD6
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:36:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Ll7jIZEv;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12245-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12245-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44D88306141E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BA41CB43;
	Thu,  9 Jul 2026 15:34:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E5420E75;
	Thu,  9 Jul 2026 15:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611258; cv=fail; b=b7SrNJUe51ynULDQffaYkl2alKdyaB7Acukn8VqPT7j6fOY6OfGvrkjuIfHXIaAiWDlZco4NCNJjXwlwTgJVIFKYmHbfvtJcqA+11C6pbVFYaGmRpRoI/zCxfPVQmU3ccJuwYEHQnczx+PI0rz81qYHL+/zhVSYv9RTR/h6BtMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611258; c=relaxed/simple;
	bh=yvPwnDZmrlh0fwppVe0OLvF3BVWLpT2Y1jXpItnJlZ4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bFp5PifQWUHXWx57aPfV8kMmuFQFPH2Tv6pbtadMq39KQCt6EFM+fSM2OpI3PHV8f7JJStpxY37u7lBHwYbXzXyD7mwz7TUlToVWEuOzKnlbnpWTAAyrEHfYo1Jk/UEi3IuYKURdQJzZTOdCzUZjahmREGtnnZG0r1kVApsbfsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ll7jIZEv; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcooZFuv+shlkrSvBbZdxIVCNzVoy64FMH42ibpDh0eBsaC9dqNYEkmhdYIioNO2mB0GxZgRpSr/lELxifBOHRbyFvU3A5TIwCyFyLGVB5tqTN7n+uIlv5eLedRo+/xn3m1I8oRUWP0zJiscDYo0y9Cc/msb9lVvXMGO+52cENtphqXsrpu5PDdlgm9/RGTAJyP32MsELiw4Q3m+ScSw5NF+IZsKt0fG8dbVW6frQYaLzUdhM6msh62VE+SUPUxTlkL2uZ7EUG6tU3zoqg6Np9J8NAoFaVReWj5xwg0LwUtcIRIcMKVQFo1hy1LmUg2yRLfmjM5/QpWGhjWxmUc1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrBZl9W0kqdsiipmliASH33yIMN/jVDBHqiyK7fUMJA=;
 b=UHrUTErsGAFfsaHKYVou1pmBt8iBxpFY3wHOUjRcwRe7oykP5KJKYrNwbKwBsmVumHNpsMSbmYimQdNmwC+J7aV44EnDCR2rui0iv86Hi5y3K80u8Dd9dHkZstNWDilSNFpgYnPK9m28Oq0Gu3RmKu8lUu16n9gLBatzigWNbCH6O76YMQHhpaAV+UnYQAL2+i+YcmHZiF+3ps8HPF5TG4rNj/pckvkdVSBsHUeo7MWgxxnDB5b3/oenmZh3ZX6c4N0ASPshevvzA8roYu4gH/gc/hd17bsWfX/p2c0oKFvXhb4o8ZH7Y7Eu9/nffZzOVAzBIhrkE5OhMS5gM8FKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrBZl9W0kqdsiipmliASH33yIMN/jVDBHqiyK7fUMJA=;
 b=Ll7jIZEv1thtCtd1KWBSTPhZF7GdDLJAlMcfjsJZxz8UN8RVPhQnpwtsX0xX9vaqec0X5uHX0H/qKSV9e94dHzY830bm/isCFllXbK1vmPaP2lhQk7UMrcTu1YWeTpUiRQUnoidTj7bN4S78Rs1zHkxOdFG+czyWQmBxBNSXi7rLrRwVlndRz2ZQq1Go0zGjkyal/3GxSDlf/eCGjQnLU7MO2URMhKEECGNvzfEFYrGQ1q7GRumjVMrJkV3u2lKZx5Njtxhkuf1SbfCvWCTT/NdbpH5UYy95IqdY4X+5hkYlc3bfcNvl6wOz8UmSsVMJ6yOrlvfA8NwedyeFp6Cxcw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:34:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:34:12 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:36 -0400
Subject: [PATCH v5 07/10] dmaengine: dw-edma: Add non_ll_start() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-7-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=3682;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LO3iSgVjP18J5ombaOKncW8om/QRIKrEzKhmIbVez/8=;
 b=aaW2i1Irk2n2miuAKxCE08ulaTzfuTRlvbk2SgWjXRLGkLatEBVg+nPdwE+86+VIcw+ftMps2
 s41BuaWbDlDBZhCzlOJzCZepTGVoRnhXRs838+RSC3j6PwvcAg67DE9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:806:127::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: fb855023-7464-4955-b678-08deddcf8688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	dQDimQvuWmq+WVuevzqhuR/BlkjnzyfRTCJP+tiJJdopcPgPESi27eBVAj+ULZ/XatSvbj213aLvYmU51wCxxlrMVIPKsEc0kpgVSZAQGERR/F0XHze/e81/bKPpjanpaLdQJ1g7hkh3xClQ5oXKVeMD/se/BNIVeFpvFQgzS9l7CQRu1rSxn4qXZAlRNNw5WSWfUATetX0hoy3C7Q0V0hQcsS2ySCOz8bZlUDTLIeviTvVtNW2Vdw+RKZeAn+fFjvQmH0+37KwI3GzkoEasuHkjBWjbakl4R1/ivs5OOPf/Zu8rsgn5rua9gAYxzS5T0tZCfhCCbPZfNdzHRXHldnG/mGgZg8J/K8iLZCK9ma8/acGuNGwOLWL6G4ESYsI7Di69aLHkWW9usqmwjrAhwp/gFYt+HKDWOxbQCvvgn8/JTupSo5tKm4sL4c0BMVHXV1DOIbxyoWwM053XLXr6AWgVCS482Iux+a6P7JINVra2fUeTeOeVOnRqzDu4RFnCfo3AIahGyMmNCUXcT9jBDxItfH1bb+u4mV79xVTty6xKtmrk29XKfnafexWeTWrTR70bJTFos35F2P78YcuUsgfJ4TNQtJeSSjlC+/vzeOUz0KPWEQt8fdFFjJhcWAOJXZpOWU9pn864LeLokfTuo+MSqcZ1K5FGi3bWHA0sqU+XLFAbOATithrzVRnu1zUef8rmo4Mah1VB0Ad+ebtalA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZEeElVSnFuV3VxL1ZQMDZFNUV2SnhITzBmUHc1c1FvYnFXS1B0dHl2Yk5y?=
 =?utf-8?B?NVVpd3RlbitvZkRaa3JOVXRqSXBDaXJEcHlVanl5UHAvMFdTanlWRjY0NG4v?=
 =?utf-8?B?YXIyT0pZT2NmYjhQYUVITFlUdjNRUlBvTTArVENDZG5FQU1NOVF6SVZ6SWw3?=
 =?utf-8?B?REd2ZEluQ0E5T3ZmSHl5RVN0dmY1NklEZHVLdEkrZURXQ3dlMGd4SFlDejRl?=
 =?utf-8?B?VDQ5MmcxSzl4TEl3cU9wS1k2VU1iVllkUU1YbE1mSkEwNHBxTHBLMkVaUWdz?=
 =?utf-8?B?aUxmc1BVcm96ZW8ya3pOVHlnc1Mzc0xTRzkyTXJqRjlNVG93VzRmZEpBeWxB?=
 =?utf-8?B?MTgwdUxRNDlxdGlCSDVVNVRHVnhlbTZjNVpqUklTRUErUmZGOVVkU1ltOStI?=
 =?utf-8?B?RksrU3NGQVBOYjNnREd2VUVZM001U3AwK1RNM2czOVArWlV4d3JNQUdHcEVW?=
 =?utf-8?B?TUFWOTBhbDJpa0VldG8wS05wa0s5bXJCV1JCVTNTSzBpbTFsc3lqdXhYTTl4?=
 =?utf-8?B?b2dWbk96NnpmdkVBL2tONjRnY09DTHhMU0JBM3hNRlZqMk9SMnVmcTFOUktQ?=
 =?utf-8?B?dkFhOWE4MlR4MERWcXNtcHZtclVSeFpnekk4bkxzY2JiNHFqTi9ZeUliTnhY?=
 =?utf-8?B?N1pnVU9hVStTa25WUDd0QUgrSFlTOU9aRFc4UWpkRW01T3JTOXluWHAxWG9o?=
 =?utf-8?B?MTFVT2F3V1NzTDVmc1JmcjBWMG5Ndnc0dkUvTkswWWp5SU4ydUZDRlRhSFpH?=
 =?utf-8?B?NGRjdTJQelZkUGlYUXoySEUvV2g1ZlBJdHBNZmovU2kxWUdMS1BUdGpkQU1T?=
 =?utf-8?B?NUNNNVJDeUsvbWJ4b3l2azdwZlRSSXo4b3hHWk1YL0pIdjRpTU1MRnc0cXlr?=
 =?utf-8?B?a1oyUW51MTZoOS9tY1h3QWlhVGUwSng2OFlEbEl2anYwaHpyVTZKR0F1RkNt?=
 =?utf-8?B?SWswZVJkS1doOE5rWHp4cmJDb3hFbENLSnh0cTRNclF1b0JlR0l6b3pZaEJ1?=
 =?utf-8?B?bkplUHkyZ2JFR0kxU1BWY3UwMDFYNUdRdDczaEdBWFZWTWNCeWdzMkVKb05J?=
 =?utf-8?B?OFdDM0dkVXZoNmlDdnlocng1MVN0aTR2SzRZeENhYXlNbzN2U3pTRlc3SEN5?=
 =?utf-8?B?UitJZ0krWXNtaGgyaGFyajgrYStwODNoRmpOMnVKK3NES2plVTRiK3J2bndo?=
 =?utf-8?B?bmJaa29uR2ZHRjl4S0tFVUMrclpiZjlQRnFqNkhGRWpVdHBuQURKNXc3alVK?=
 =?utf-8?B?TEx1LzJpeWVYTFlKTGdPanI4TnV5dy8yUjhZWmk5M2tRTktnVzRUa0dIR0NE?=
 =?utf-8?B?UnROTlJvSm1KR2pSZ2tRdkZqL0hBN2d6TVVNMzNCQ2RnUnFhbUZabzROTFVo?=
 =?utf-8?B?Y3VJWHJkMlg2R0pQQVJ4R2w2UzNJdmh5TWNFeDcrRndBbFBqdVlNMlA4VHM3?=
 =?utf-8?B?TjEzTEViaGNPRVNUV2JtUlNKMS9FWXZsUkQ4OWJlbHM4cmhITmpCem1lVVlx?=
 =?utf-8?B?ZWFMcUE5UmxncTZQWk1MQXNTSDNxSVA3Q2Vnd1FkMEJjdkhMZVVBQi85Unlu?=
 =?utf-8?B?ZXRtRk9KTVpJTEU2MTYxMDFQcUtQOHV1cVpkVWVLaFNBZkJNdWpKQlpoZ202?=
 =?utf-8?B?MXZXcnBKc05aZ2h5dDlwOFhVa0k3VlVPM0JRcDhEbmhONjNnYjB2YituOHJk?=
 =?utf-8?B?bnBQUHFqVFJWTkdKTm1KbVlybWlpSlVzOVVZVHJwTXdzZGtVOWJKaHcrc2x0?=
 =?utf-8?B?U0drY055VVgrQ1EvRDNVdnAwbDRERGxSODAydjhuU1VkdFZvYUV2amNFNkVM?=
 =?utf-8?B?b3MzYVBaUTcyNnlLVHFGMzgwWGNONXB1T1RKMVdnalp6c3g2UFlhZ1VhdmR3?=
 =?utf-8?B?VFpmRzliSXRyRlU1M3lxZjF6a2QwalJYYWdUQU83U081b25WTHZzcGdhRFdN?=
 =?utf-8?B?dWRvNGxPTzhTcTdlTG5qejZKNEdBV2JTQ01ieDZCaVh2eW1IZXZlK3hkSWpL?=
 =?utf-8?B?SE4rTVNRMzZYeXBiYmUzamhJcUNsVTVyL1RUS0R1dUszejIrMU9pQzZRMTdk?=
 =?utf-8?B?cjZTalBoSnAvaHpmdG9DcjVNMW9Fb1piOXV3RzhBdFc5ck80d0VDNEtjTTl3?=
 =?utf-8?B?Nzl4UWtEVExibWhsK2ZaanNvSlJaYUlTdURaYkZUcWdvYVdWWnB6WWl3WWtD?=
 =?utf-8?B?SHdKSEVpRFVNclBmbzNRcWx6UDZsYzBodmJ4Y2RIL0ZwaGRMQ1NBdkVlNnpi?=
 =?utf-8?B?M21UUkVZd1pYT0NsUTZJTEdTWEpBLzJ2dWNkaW8rZlAvRTNka0dDT1BMOHM3?=
 =?utf-8?B?eENZalplSXVPVzJBN3NSU1JsNWljODF6cWlQaHFnK2k3dGw1MmFrZFNwVitj?=
 =?utf-8?Q?yRHz3P2eeuCG/33o34BjqqlQHxIMOua28Lecg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb855023-7464-4955-b678-08deddcf8688
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:34:12.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pM9gCaX46gApjUMabh/Dx9kATEgWLlKqO3bFRNrWzZxfWMFrMlHEWwOOQlASiQ/wjDP6c3qODD8shePMrBZ0woHJ+7aJfNNMy6YBnXt3zP+lWtzT5xrN96sBk7Xmr3nJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12245-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,valinux.co.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB05B732FD6

From: Frank Li <Frank.Li@nxp.com>

Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.h    | 12 +++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 ++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index bab4d49c92feb..e18d6e827c2c9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 static inline
 void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
 {
-	dw->core->start(chunk, first);
+	if (chunk->chan->non_ll) {
+		struct dw_edma_burst *child;
+
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			dw->core->non_ll_start(chunk->chan, child);
+	} else {
+		dw->core->start(chunk, first);
+	}
 }
 
 static inline
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 16fe3ef43948d..641a513bc52e7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -272,18 +272,12 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
+					 struct dw_edma_burst *child)
 {
-	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	struct dw_edma_burst *child;
 	u32 val;
 
-	child = list_first_entry_or_null(&chunk->burst->list,
-					 struct dw_edma_burst, list);
-	if (!child)
-		return;
-
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
 
 	/* Source address */
@@ -324,16 +318,6 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 		  HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-
-	if (chan->non_ll)
-		dw_hdma_v0_core_non_ll_start(chunk);
-	else
-		dw_hdma_v0_core_ll_start(chunk, first);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -399,7 +383,8 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
+	.start = dw_hdma_v0_core_ll_start,
+	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.43.0


