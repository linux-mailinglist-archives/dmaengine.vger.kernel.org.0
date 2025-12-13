Return-Path: <dmaengine+bounces-7605-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1DCBA224
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 01:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EAD1307F8D1
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671AF22DF99;
	Sat, 13 Dec 2025 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X9O206jW"
X-Original-To: dmaengine@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF028373;
	Sat, 13 Dec 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765587231; cv=fail; b=FiiZHb6D/YNoYUBVJkkvUf1DDPbWemD0py5zNcoRyDBulcaNQYXvs5r5sc08KKIBaOtcSI9d4xbKHusRhR50DGonOOOGXgbgKcFOw4CbZ96+RjjymqR2o6clehj0cz2FXGTZpWt4kHRrd3f/9cwoAnLYLMObjcmDG+uN75wk+6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765587231; c=relaxed/simple;
	bh=r97qVXXXUoY4Zy8JnNTu4MS8kg3oHKRxm1dswb9KU94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QR3L6hItw+Q1uY7d1x8wObUSRD13CQN3zcCw11aGxwJrYXs/jxf4ip5HAFeVa0giecCzBvBiHDFRY3EX1lXi47wab0bpyMkj+g8Pcokm53sg1YqWrlJFMKT0uzOxRny+HUf3XvZ5boOwE0IjfNkJSbmFHN328cBoLd29CO2zpe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X9O206jW; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWzuPXlE8vpG+khBQdPdjv5DhYDo+dxkVu1HeMb6ESXM/tC7dmPli6x+5pgwnbqn96piXwokq/p7Hb6TZbJeYSKt4qAQVbxOQ/ToE2y75AVv59L55WIFKoSHKAU09YSh64A19pu3Pdzra+Z7I5qj9sSOhzPdK0aeAva316m+wfbHpZnOpDI6tv4E+mixcZkKofvrj5phX5mKLWxbX+rZe6Qu4kibs5PCkGrKg/RlEl18LqAhEDG3n+c9HJsvXIGpKTQo1tcebks3PDTNYrOOE6YEG/XKY/zB6oVEJoE8XE3aa7dA9r6JTXyJ3CWX0J0JdwbZrr0uZARs6z0nMhwXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paaA78dQke/SqLgawF9V57i9JX8LLcbcpToYKwZ5CJ0=;
 b=Ev6PX3WQZcJ+jZQwJRzeNJFGwyZXViyXNRBFC3h3Dyuz11Dz4JWhmNzzXvqfzHMMiZCMbw9Gi44dEPdoYlhDONreCF5tjmxFkelE7Ktl7+T9AynuwHxYTEpMQ7FncHY6PEJEhQw30GGxreYS7oTErnB300w5H6E2cGbkRMZLevOjwvMnv3GTa2oUajbX87gybpiTeJtVo+rpfidSZNZWKohqbTs2HigDYn20t1BvYnZ+NLm7wwFXvafsWe8FNsPQ4LCBel06Co0d7UQZyvMDSRfQjTCXldf5oEVcbqcg6Ad4saqRs/W2S6nwjY2hNM33svDCfoiRFcz4DsgmlhQ4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paaA78dQke/SqLgawF9V57i9JX8LLcbcpToYKwZ5CJ0=;
 b=X9O206jW6pTMqMrP3mbbH9q8wa0D4cU2gxa6wYAdnmG1LqFeB2ywBdJOhZRobCoVrL2LBDUWEMfk0ZZ/rtRHUFCJ5oU08roFSfgDThxcXLtS86785OJY7P178SeApVg8to3k+CcuUnWDamIJfE0/QAeRgL4YgwxzCvytUSPUnRT69JL3oKdFRJmRV7eYqgwagMqfCu/TOBlsPb7KA39XxaF2Td9rzOi2a9WDYPjCQqtGJher9ltSpAb54dnvF42YxeUXmD8TpXkDBPJJ/gIs0AZTTsnOX6jiKJSq2FovgJbbFQdI48hnGQ8islclj40HsJ99OmQtyDYeuPmAfFBmjw==
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f1::8)
 by PN0PR01MB9496.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 00:53:41 +0000
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::bae0:5b38:5068:9ec0]) by PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::bae0:5b38:5068:9ec0%5]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 00:53:41 +0000
Message-ID:
 <PN6PR01MB11717B13B2AE78DDD36D2F0BBFEAFA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 13 Dec 2025 08:53:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
To: Anton Stavinsky <stavinsky@gmail.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Ze Huang <huangze@whut.edu.cn>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
References: <20251212020504.915616-1-inochiama@gmail.com>
 <20251212020504.915616-2-inochiama@gmail.com>
 <A0AF03A6-1F0B-462D-A088-3B4DF6BA6292@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <A0AF03A6-1F0B-462D-A088-3B4DF6BA6292@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2f1::8)
X-Microsoft-Original-Message-ID:
 <aece5334-4ab2-4c14-b23f-8893af2aa427@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN6PR01MB11717:EE_|PN0PR01MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d4a435-8647-4c13-1285-08de39e20f25
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|23021999003|8060799015|15080799012|19110799012|3412199025|440099028|53005399003|40105399003|41105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG5xNFFaY2hGSzA1dUFtV1JDVVZMaXdNcllUMXFJZ1VBTTZWa2hGTzJKNkd1?=
 =?utf-8?B?ODhKODlkQ0E4eEl5SG1pa3NVUUdCZ2xycGVJZit4aVZzQXlWUkE0TzZsT3ZH?=
 =?utf-8?B?ZHQxK2ovTkJaNWJoaGtRM3pIdC92em9JNXUrRXdpcGR4U2w2MkhBNDZTK3p4?=
 =?utf-8?B?ZkNrVEtXSUxEN0xLNkxYTnVETk1QYW1LWHhZaXREZ01rS25uRWR2ZFMydHNF?=
 =?utf-8?B?cUxhMHR5dFdvVHF3YWJHcXlqSnZXQkhmVmwxVmpqd3RHemVYdXhUNlBqdFQv?=
 =?utf-8?B?ZGdSUERETVJNUURhWEppOXU1bDUvU0FpWmdvZzh6aDExb1pkVHFOWm5CZE9h?=
 =?utf-8?B?anMvYXc2WmZqWDg2bE1nVk05VUV1YU9NYmRLbWRsVjRIK3JEL2xwN3lxRFMz?=
 =?utf-8?B?bWVYd1NtbWxhclZWSXRMTTBKOWsyTEh0TW9rb2xlYi9VcFdNd051VHY3MlNX?=
 =?utf-8?B?UElna2pWZkZnVXF5bm5Sa1pPMTFpN3ArSkZjRFUwa3hhWExTWWROdXJRa0Er?=
 =?utf-8?B?cU1Ec1g1a01KT25pQVI5dURoWGtweERMNTFmak5nMVZFZUcrQnZUcW1QMXky?=
 =?utf-8?B?UjdkVVJBSFRTd3JrbktEbWpwWExqNXFUOVFpTXBQc0tOdDBGUEhvSmJhQlls?=
 =?utf-8?B?ZWJjQ2RRMkFvMUYvOEtyNElWSFFzZGpudmtVNEtvbEovRTd4M3Jwamhham9X?=
 =?utf-8?B?Uzd3cGZVeWlWRnMzR1hEc2t2YXVtSm8zV1dPb3FacFdORHkrMnQ5M3NiNGRi?=
 =?utf-8?B?WFgyK2FCeFZ4eTdZbmwveXFpN1U0enp2T2Z3Zm5ZMkpJbVdIR1k3R0RZZEFl?=
 =?utf-8?B?aW8wWnpGSkdFMGNaQ0R6MjhkZENmaU9obE5HMmhMNVRiLzF6NFpwUExOR2Vl?=
 =?utf-8?B?NGUrMEQ3cmhMREhIamt4bUc4TVhXalVyZUhxMzNGbjZMWG9reUtLM3dJbzBt?=
 =?utf-8?B?YWlFZWE4TUV1VENUc0VtbWU4cDIxbUw5c2tnWHI0VGQ0cWpySXdFa2FScmNT?=
 =?utf-8?B?aFVvT2VVQlVDck1JRjZIeTZpWENHRkJXNmIzbWpXQmloamlSK0dkckRKNm1x?=
 =?utf-8?B?eTBncGJBMTBOYUljazNpQVVFeWFhODJiSGxsVlVhS3RhdzhUaE90akVZeThS?=
 =?utf-8?B?THVOWjZWS3dTNnZucWFqaDg0bjR3RXBKUHIybGpMeXI2TmFHZGxPMHAwWkdj?=
 =?utf-8?B?NVZlRG1LZWNnNVBNOEQ5NjB1M2JDUm9VNytRU0ZjVjNldUtQQ2RIdEl3TkdI?=
 =?utf-8?B?SElKczZ5OXhwN0ViY2lSdjNjWkhNdklhQUZMUW43Vy9oZEM0anY4UDlFWUZs?=
 =?utf-8?B?c2c2QmpUYmk4VmhhV2FkNHpZZ2J0VS9CeStvSnAxS0cvT05lRGFURGlnYUNw?=
 =?utf-8?B?dGhKSTdmdXZsMzRlQjY4QjEzek9HZlNSL2Vlc3lKSVlkK2FqOHFCUCtVazVk?=
 =?utf-8?B?NUJ5cmZOenY0TnI0YnRjVXg3TUVkM2pTYmpkaUZxTmZEeU5QSUwxb1hRVlRF?=
 =?utf-8?B?U1JjSmNibmVXUG94bVZEVTBPcjBjdEt3QXhLOWkxc1BiOWtiSm16L1gzNFVL?=
 =?utf-8?B?RW5aZjhDZEd0N2FWUnF5T0dPY1JFZk9Wbm40OG5ITnU2c0doL0VkQXJoMUxL?=
 =?utf-8?Q?jLVQi9vFLTIw/iwyTQ1sTcCbi75/br0l1eV5PcubEVpU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk5EY0JUMFpQc3JMekI3MWxuSHF5c1ZzZ3FWbGZMZzlLemRCcElId211TXNQ?=
 =?utf-8?B?VnhHQ2M5VmdBVWp3RlBybFJheDFUK1hMRE1TTmd3cGF6YVdHRzNmYXNxR05k?=
 =?utf-8?B?ajdRd2pDcDBCQUtHMW1jbytIZVVpdHVKbDZVZVQ4TG1IVTYvS2hWOHNKSUZE?=
 =?utf-8?B?aCtEanVRcnB0b08vVVB4TDIydjRDWmxpZFZVaXNadkxJTmgwN1BlSTFDSlhB?=
 =?utf-8?B?OXNweU10L2JqYmxQbnpxaEpIcWNzb1JTUHAxVUx4WHRaSVV2ZlhSMDU2c3VV?=
 =?utf-8?B?L3o4WXBZa1JRSmU5ZVIzaFFEMW5aeU4raHdDNnRoVlhLUzFQYVFnZlYyNHQ5?=
 =?utf-8?B?aWpWQ2w1d0MxM2poRmwzSXZGMC81RjlOcHBXMUhYcnBETkJUU2EvdFd0eTVI?=
 =?utf-8?B?algyRUVMUXp5aTV1WDNTb05KNlVYNUNZdTFWU3crVkJaQ1Zwd2RqR1BSbERV?=
 =?utf-8?B?T2FiK2J4Z1NJUWE0Zm51NG5mdC9DMU5FbzVaQjR0UjZ5WWtCSDluY1o2L0hh?=
 =?utf-8?B?Sy9MUnh2TmNOSC9QQkN0V3F6Um9FYWFTRDIxYllGV2JZcHFBU3Y3bVprM1V3?=
 =?utf-8?B?RGNCanVTZGdUVlZ5dFhvejV6Njh2N3N4WTlqazJ3WmFzNTZtbWNCK2VXM1VC?=
 =?utf-8?B?OWMvV0NwSGFzc2J1d3JpamFKWDdtcUhnK0pLUkxzbDdQUnptYnluZmxJdGRP?=
 =?utf-8?B?UG1YaTkzNVFSMDI3VGFBZHRYNFBvYUZSck95NU5yWk9KZ2lRVGtXelQwcHpo?=
 =?utf-8?B?U2RHYytuZ2FWd2F2c0oyTitUSVZGOGU2UzMyQnJhaEx6RUk5KzdVVkROcjJS?=
 =?utf-8?B?NE8xWDlRUWlad0d2blViM1U0TkY3MnhrRW9xd28wdzFNYVQ5QUVZbFpFbjNn?=
 =?utf-8?B?MmoycFRlR0syS1lGWWx2SytFc3RYWCtBbGJQS2lRb0pCdWd1U0lZbHp3SzlM?=
 =?utf-8?B?Mng1MU1EYkdMTHN6blVBaVJ6b25zMEI5WHRjMnh4QjgxcjBEbldXaU1vMUc4?=
 =?utf-8?B?SVVXL1hweG9nbGNUYmJiT01Pbi9WVkpnNXVEQkZVRFhGR3RrK1RnNGRudTd1?=
 =?utf-8?B?RkdDclFDV0taNjltTTlwSUpKNldLeG52V2M2dG0ydittekRHWnhlazZ3dnlM?=
 =?utf-8?B?Tlp1VFJ1eDFjbEZleVNiR3FrUXRrNkhneTJJbVcvZll4c0p6SDE1ZXpFMnZD?=
 =?utf-8?B?R3ozVktWY01WOHZIaldjMlJGQU42amZFSkw3cXJRQzE4b0U1bGZhOWxMNkNI?=
 =?utf-8?B?MVhiWFFvc29HSGsvNmY5dDlYN2VJMUFrOEsyNFNYWXVPZUdRZ0JPUm9jR1c0?=
 =?utf-8?B?UFQrSGNuSUFsOVVJUWpzcGMyd1hSanNyWkVZbHd5MzhCdVdWbEYxSFJLU0Vq?=
 =?utf-8?B?RGVGUittbjJPVklTVUlhajBGaVZMRGJocFdHY3M4WEhGbEttcDNBQ0grQlQ0?=
 =?utf-8?B?b2NqTEN5Z2duenVRV3crditocXJISnVjSVlHajRCWVdvRlJVUDZGQ1NDdnd0?=
 =?utf-8?B?VXZsZmRKdWZyeTc4LzNMNmJ4YXE1Y0h5b0E1QnNCUHp4MVhPb1NheW5wR2ov?=
 =?utf-8?B?YWtQWHBKS0x4WnlGZDZEZG9nMys3RnYxbUcyZFpzeFlIbmZ4MkNYalUwcE9W?=
 =?utf-8?B?VUFDZmw4ZVExenBXM0FMSWJWQkZPYXRPcmdXZ3pLa29ISGlNbHRFTXhUNXJ3?=
 =?utf-8?B?M1o4a2R4SVZ4U0xtVVN3bXJGMU9mS3pqeUZhdTlXZE83b0kraDVEc1lKcFZk?=
 =?utf-8?Q?LC1UuiGL8u5JwziH8O7LikYTtm0G47vFSm1Abgp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d4a435-8647-4c13-1285-08de39e20f25
X-MS-Exchange-CrossTenant-AuthSource: PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 00:53:41.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9496


On 12/13/2025 2:48 AM, Anton Stavinsky wrote:
>> The DMA controller on CV1800B needs to use the DMA phandle args
>> as the channel number instead of hardware handshake number, so
>> add a new compatible for the DMA controller on CV1800B.
> Thanks a lot,  Inochi. I've tested on my Milk Duo 256M board.
> Seems to be working with the I2S driver, which I'm working on right now.
> No issues with DMA interrupts anymore, DMA router used right channel.

Thank you, Anton. Could you also add a "Tested-by" signature?

Chen.



