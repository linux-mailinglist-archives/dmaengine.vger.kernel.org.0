Return-Path: <dmaengine+bounces-4021-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9B9F6775
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AAE1880897
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE31B0405;
	Wed, 18 Dec 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F5ZG8o8V"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF7198822;
	Wed, 18 Dec 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529128; cv=fail; b=T6vDvbsfN9XdrEIDfkkY+sJNamY1pwF84oPTLN+TBzIoP1gPmBMYFP5dsI+rgqwuawiwfdau77GvwwHgx4Xopx6hfFCY14qaoGl3HhHvnHkPnhU2PEJv3MGGZ+udGpO2PGEEAmeEh7YP8JcdshiUpojCE+LyJdzlR4RRJxEA3oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529128; c=relaxed/simple;
	bh=AfcvgY0PmWJloeqwVz0dFsgT9n3mAqVmn3zORUcv3dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BSSYAg26v57E1o94A7xXtQP3IW93n16HQx3+5R7aRYqgcJESai16MoDUOlZaDqt+S89BG19gvlBqs++RpSmz5GcwNj67fkTlnAPPagFAxLdNew9MHF5IQsjdoUd3/BZxFSw5PTMQW8U1iuUKhHff9kWa1LSDxfTcILOOPWiLfj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F5ZG8o8V; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQBDV6xHNMUrY7R2QlxZ5MNX6Ko+t7fj/mY6O73Taj7/IaaV7GvxyynjbeQaiiD8rgyiv/6rLuXxOBNAS1hv69CKZ/K3vfi/AAXK9vBKk/ard6/QX+wwXaZBSWbN1j6A6hdLhBdMN8c9pzMERwOOarhxtevHLuWyg9QxNTyOHGvHOsOlSPww800+IZeHqQ/rfW5mAd0LOSnoIeTG0Inq6BzLUnR+HrsMWbgAKlH2g4DKVaU7QJNLyOYfIEgbvivalTcz4IsojC/e9YBkTh3CAu1Soji48Z/4+eer3yYsLIm8iv9zNfxIgvppaP0JbHhi4ESPJA+BUzwZDKr0vbqgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O89zcUU9ppYsAwGShcSOUH4e8lHnp349HjXANmCQo60=;
 b=CHmGHITEw1cniIfiz6u6YS8jxUVkkcU0a03j0Bt6EtZ3RXLBQ7s+FstdOwJMao1KPiFbViUNyOgpEVm/msJfoghAOrkGerVFOHKf5hcNNKUydeBCDrfxOMLqDngGMLJQhHsWa0fb2JvINJ8YtJeAn+miZWf/1FhO+aULwSZO2ih58slfOqY7pc3AVBWoP+vRGmf69l/Dmo3r1yOChSukqGnoxaisl+7AE4YEZk5hsUiO6Jw9Dc7vnEYsPhf+FIiNU9kKoaCRXMn4/VtBwQXrSc5XqQms+ewwoT+VFhxsFafkfswXn9b+cPgi/IH0N/1KKEM4kmVLgNv5feg3kJVCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O89zcUU9ppYsAwGShcSOUH4e8lHnp349HjXANmCQo60=;
 b=F5ZG8o8VxEgJzAyRNLbh8BkvmKl0LfYObp2AWi+o82edW9gjoOuDW1JNYAql6TnTnQUELdkHTP402VODKDv6e8N3ZGNPsTjA/r8aSvJvcRe58Ayua9y5MlCVuic55tnUu/9fZXQw4EmHNOMG6fxkH1arg4ZG59HMfklcnvX4yvWPoPAur7qJnUnP+nklBG0JRP4ks4DirqfrGB17lcaSAds0+VcbBYGxdO3pXYuLzoD+4TvLJAlqTeOlScjgqo2JpM3CnaYDifYTQSg2HmDJU20El5S6K3hoNy4MoRxTtgY6Pkp3fogLMkAhtSZYmvfbfuC2eAVz9A3KQ6RjGAYIGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com (2603:10a6:102:26d::9)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 13:38:44 +0000
Received: from PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515]) by PA4PR04MB9567.eurprd04.prod.outlook.com
 ([fe80::83be:fff8:5a00:a515%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:38:42 +0000
Message-ID: <d96a7dfc-af73-4296-bc26-4f1ccae8f7d7@oss.nxp.com>
Date: Wed, 18 Dec 2024 15:38:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dmaengine: fsl-edma: wait until no hardware request
 is in progress
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-8-larisa.grigore@oss.nxp.com>
 <d4afb25d-5993-4f80-9f80-0a548b6532cd@kernel.org>
 <d5badfcf-58d7-49d4-8a5a-d31de498f015@oss.nxp.com>
 <2e0e1fe3-af5e-4416-8b34-3fecb923b481@kernel.org>
 <458f8940-4451-4dbd-bd50-75a43e4248d3@oss.nxp.com>
 <60b8eef7-e946-4e86-9116-46fadbafb53d@kernel.org>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <60b8eef7-e946-4e86-9116-46fadbafb53d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::12) To PA4PR04MB9567.eurprd04.prod.outlook.com
 (2603:10a6:102:26d::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9567:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4890945d-1ef0-4004-e922-08dd1f69494f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVRCNUZTc25BRFYyc1dabXpDU2RuQXdjVVBrNXdUbzh5OGkyOWE4UStpSnNi?=
 =?utf-8?B?ZU9hYmxGcHZQUHpCWGZtK1ZzOXByZTBmMFFVdElRNEtSa3RNWlQ5SmRuMXVN?=
 =?utf-8?B?R2ljZnIxdDNkRzBjRDNOU3VDY0hkRDYvZWJ6T25kMGhid3JHeFhVdFlZWFc0?=
 =?utf-8?B?VXJxRnRRdXEwdGN6QU11dStGb2p0RWtNK2ptZ0p3bnMrQjZUU09YZnJvZ3F3?=
 =?utf-8?B?MVhaTmxqTE5BQmszSVMzbHhmOXVSNG5Sb1hWc3NldEsxdERiTzNHVWpzbkNU?=
 =?utf-8?B?bGV3eklPZC90cGszSkZEUXhSaHozTnowcFdsT2c4OFJ2YlpZMW5PR0kzK0Yr?=
 =?utf-8?B?LzVnbkhqTnRKODFEbkp5NSs1OUJEd3ROeTlJUmdGMXBDS01iQVRrM0crL3RJ?=
 =?utf-8?B?bVppSk9VdFVMYUJJcmpHY1lZbFc4K2xNektsYytITG0rbXdwNDh3K3VVTGxM?=
 =?utf-8?B?MnRSblh5RktrSXc3d2lRcTEvelZIMWRzZE1hMy9DekxjZTgyRVRFQ0Z5Nmww?=
 =?utf-8?B?UlE4dkdGMFNKSHo3bUpXS2o2RzFIcWRVWjNmYk8xOUNNekZ2MzVReCthN21m?=
 =?utf-8?B?ZW5Sc0JnN3dWb0lrTS9pMkQveFpvakdIMUZ5ampjYWdOZS9PWUNnWXc4eXhY?=
 =?utf-8?B?WDdHeTBHWElsdnZsSzlOODI4Mmx3cXRNVDR0dzdTcjBWRG51aXF1UUpwa0lw?=
 =?utf-8?B?YWNaSnlGQU44V1hzRTBIMmkxQTE4cGEzbVhwMCtoSGlLeVJHaFU2eGZnZmhU?=
 =?utf-8?B?QVpDbEV6T2F6bDJqU2hsR0lMTjZPeFNBWUt6ZkJtcU5aUUczRVpzeGp5K0hB?=
 =?utf-8?B?TFJ1ZG5WNTdqOVczakJTUkxFMHRqQTNyZnFHWkhPUXZjUS9lc2l4NGt6a0lR?=
 =?utf-8?B?VFJsWHF1bmFENG5KUEZNQWpubytMUHZqWGtKSGNMNlBFMHNuUmtIanFBRStB?=
 =?utf-8?B?THA2TmM1dGlSUmcyakdhSFJwZElHWUVGRzl1cERtWXpGa2dqSW5mZklscUxT?=
 =?utf-8?B?TWpKTFJyYzZTYy9LNTZkQU9IWGdOdk9mNk1Cc0lSck10eERMdVpocmJ0Q1BN?=
 =?utf-8?B?Zi81NGliMUF1UDIveDZYcnF2TUJVRWVVVEZTNllmVDczeWd2KzdROEhIR3NU?=
 =?utf-8?B?NzZMd3dsYkN6ZThIQzc4dEVGVTZDVDQwQ3NoUmF2VGRjYi9XL1BvQUdmMXNI?=
 =?utf-8?B?YThVTTArbUZaVFJZa3hEaWtyTDZSR0dZYnhEaDJpK3NZdGhuUGNNQ25DalIz?=
 =?utf-8?B?TXdNdVZIWU13aThyUkNLSkNrNDIwVlRlN2hWQ0ZBWm41bzU4Si9ONERtTFNT?=
 =?utf-8?B?SlMzS3plOElsemN4NDR4M0hHODI1RWhzTHRXdldoSTU4WXUvcXMvSlh5ZjFu?=
 =?utf-8?B?TVBXWDBOZGoxeCtTS0tzbUNKQm9BNC95MndoZmdMNVpLTlBGcDE0V1BNSjFo?=
 =?utf-8?B?S0xQT1ozY2VUQjVURUUzdmdoSzhNVVJ5WHpuRmY1Z0dBNkY2cjRkOGRMZ256?=
 =?utf-8?B?emJpUS9VbkliNWJiVE1GZXZ1bFExdFNRSUpTK09VMDZydHBKTzlidG9nbVJ5?=
 =?utf-8?B?cGJINmFvU1VaWUdmSTBnY0xiU1IzWUNjNWtDcFhoalZBZS9McHFQLzRVS08x?=
 =?utf-8?B?OWw3WGxTc1BIb3Y5UkZVSHVscjRVeWlPVTkrZXZtZ2dHVDBqejlmbElZaUxx?=
 =?utf-8?B?dFdLZ1EydGs5eFZWeFJZVUQ2U00zNW0xdmRwbS9wbSszZS95QTJhaytXL01v?=
 =?utf-8?B?bEVHWGRDYndBaWNTRG9kMXNmLzNvb25GRFhIRlh2ZmtIbEdJcnR3akFRQXFU?=
 =?utf-8?B?U3kvRGo3SjJjaURSOURCRDdaaVY1Mk93bno3WkN2dE8rTm9JMGhvQXU1TTRU?=
 =?utf-8?Q?6BgcRD5ApLu6d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWQ2NzJpN2F2N0h6a05WMjJjelhpSmtXTERlWEhRcUhmNW4wMk9WSnUvZVZK?=
 =?utf-8?B?bzdZcFdIcFF6Q0JhZzhha0ZJVGpSdzExSGNVUWd4RXlla2lsMS9HQS95QkRu?=
 =?utf-8?B?ZWVVM0hyaHpleDkyazZTc3N4NEtSbWJ3ejl3OXBrZ2c0OUNhVjljTkdVSEdo?=
 =?utf-8?B?NXEwbzVhdjM4YnM2cFdHL2FPcmt4aERYdCtuMVhDMVI4OWlNMTFMNDZFUUdI?=
 =?utf-8?B?TFNqRVNVRmNxaXYzSVhMdVNtT3VGM1h6VUMwaEwxTkJzdXpGZkdkMEE0Kzcr?=
 =?utf-8?B?NVBqVkh0cXVvdndtY0p3bWFyUEc5R3RFSUVhOXVEQzg2MkZxSHBMdHdxYUZE?=
 =?utf-8?B?dUdkMGMrdWk1TlJvbVhWQkJ1SFBYMklLY3ZHTEE5T1BDZkIwUFNlWGgyL3lw?=
 =?utf-8?B?RW1sckVOSHd3VUNFdFJNM0F6a3Ywb1MxM0o0cWlFQnI1VG9BbE1GdFZ5aFRH?=
 =?utf-8?B?cEtJaU1GRU5GWnZpakxqQ212UnphTG02OXZSYTJ1b3dpY3lNWG5udVFaRDJs?=
 =?utf-8?B?TTBZTTRoMWdqYXBBeDRSQkRoN1ZydC9OZ244V2tpTmFRQW5PVnVpSktoeHo5?=
 =?utf-8?B?NFByL1lVbVVPcURrd0xDMVVWanUzOHNqUlZ6aUl3VmEyZTZZSzlWeElqZTN0?=
 =?utf-8?B?UjdNRndXQW41a0p5M1RGRzQ2NUNydURuRGszbktqWmRhVjdsSFVXYmVaNTJS?=
 =?utf-8?B?dVJVQ3RnNHI2a0dQMmljakpjKzlVRWJlRmw0SUxIZ1VpQ1Yrc1l2ZDZDaGtV?=
 =?utf-8?B?YXp6QnBORGUvMEdkMFJSWXVQeml2SGU3Y1JOUWs3UFlUcm55VlBCdFVuVEFv?=
 =?utf-8?B?UFpPRTFLbDNrbngyK05zRktFbGZWRU1FWm1OcmxtK1R6MXdwdXZocUFGNXpl?=
 =?utf-8?B?WDNTblJ3bXhwZVZCTEZjRm93bkN5OUNnL2d6YlN2Ym5hTW9rTnRzUGJzM3ZJ?=
 =?utf-8?B?cVkyVlc3VFVkc1RJUitzWVBPOXVNSlhSQXFMcHQ5RVc3Y1BQaEozdHNNSDRj?=
 =?utf-8?B?MVNXMkY0dDhxNGM1Q0l5MWlzd08xVzhKd3ZKVG1rUWhIMUdHMHc2T3ozcG9U?=
 =?utf-8?B?K2dCZXRZWXVFVFFGdEl0dVRJTERKeHJueGQ5dWYzUHdpdi9XZWlpMGZCaVp2?=
 =?utf-8?B?dDZHVXJsQzhoMGlxeWtDRlhraU51dXVRQVlLR1FEQVNiY2tFRFJXSVAzbjBs?=
 =?utf-8?B?SnhOM2JiWXNHWE9lSjREWm80S1lrcjNDaEhqZXNONFh4U0R5Tnk5OEp3azZ3?=
 =?utf-8?B?cXhGYmlYU3lsTFN3Y2VzQ0pjYUwwak9OZVIyM21VYWpLK2Y4S2RBZmU5RGU4?=
 =?utf-8?B?WnhVbWkwNWlZY2xaUzEvcmF1aXNJZ0IrU2tPb3ArKzRjMExKQmFSVTJRYkd0?=
 =?utf-8?B?TExCWFdPSHBaeTVxd0RLN1RlU0dmQmRGTVhHQ0xmZWErakc1SWJEY0tJek5M?=
 =?utf-8?B?Z1lMSGNXMFhSMHZQb3FaSGdUN0VkY2IxNXJENnhzWW9mWWdwRXBsN09UbVBL?=
 =?utf-8?B?MEgwZlBGRWYvdmJsekxWNFlDTjg5bjlSdi83d0lIQW5POXl0SUVTaVdxVDVv?=
 =?utf-8?B?cHRZSU9yd0c4SXFnek5nZlBRbDRhYWhYZHVDeUVMU09LdGNpRUVRLzQ4SFFY?=
 =?utf-8?B?aHF3UVU4dXgrVWs4SVREL1hkd3NpNkJOZ2s3L2x4cWdYOVRFL2I1MmlrVTJ1?=
 =?utf-8?B?L0xDWU5Jd3l2eDFpTHZ1OXRyMzV5aVpxOFd6UWNlUVdQaE9HK0pMQXBrRWxG?=
 =?utf-8?B?NDFjTU8rWjlDay9pKzRXOFpTMDhyRWhpbnZONDJFdXBTdUtwTXVGSmZqT2ZI?=
 =?utf-8?B?Mm1BcjlSbHU1b29TMXEwOVYvdkhOZkdyczRDM3ovZGxlQkJWUGh2ZGMrWDJG?=
 =?utf-8?B?S1NJN0Ntc2pRRWFaUGF4c2VRbmFPNXNLVTNYZXE1K014MW85K2tPNTlwMHgx?=
 =?utf-8?B?aHV6NTZjbEYvcmF3MXM2UnY5Z2dqWnZtSTVWSnJhbDRjTHlMQmNCRDQ4dmNx?=
 =?utf-8?B?TDlwZWZXZWk2L0xrVjFoT1AzOFdGWnlENU9xbER4aHR6alhsVTNNRW9sOTZ2?=
 =?utf-8?B?TStzWHo2TUY4Lzh4ckxoRU5NVXVvdVlneFpTelFmTm15VVJ6bmZSQ2wwTWt2?=
 =?utf-8?B?YVdWLzZuSFhqeUVoRFREZWpZYXZHV1JCYjFDeFVxUWxKN0lXU1llMDM0V3V6?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4890945d-1ef0-4004-e922-08dd1f69494f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:38:42.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zpTYko70EH2Tcsr4lOUcreAw9/tAX+L9QaqBMhIYFb6h9jCWQXBSE3Mpecn1uVDjGOWnHzq64V6L7TMXlDndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423

On 12/18/2024 3:32 PM, Krzysztof Kozlowski wrote:
> On 18/12/2024 14:24, Larisa Ileana Grigore wrote:
>>>>
>>>> Thank you for you review Krzysztof! Indeed, this commit should be moved
>>>> right after "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"
>>>
>>> I don't understand this. Are you saying you introduce bug in one patch
>>> and fix in other? Why this cannot be separate patchset?
>>
>> The bug was introduced by 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate
>> v3 support"), commit which is already upstream.
>>
>> In the proposed fix, a channel is disabled after checking the HRS
>> register which is a eDMAv3 specific register.
>>
>> In the upstream implementation, "struct edma_regs" is created based on
>> the eDMAv2 register layout [1] which is different compared to the eDMAv3
>> register layout.
>> The "hrs" field, which is used to access the HRS register, was
>> introduced in one of the patches from this set [2].
>> So, this fix depends on two other commits:
>> "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"  [2]
>> "dmaengine: fsl-edma: move eDMAv2 related registers to a new structure
>> ’edma2_regs’" [3]
> 
> OK, this explains the problem. Your fix cannot depend on other patches.

Should I remove the "Fixes" tag in this case?

> 
> Best regards,
> Krzysztof

Regards,
Larisa

