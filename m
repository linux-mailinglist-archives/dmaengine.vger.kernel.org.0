Return-Path: <dmaengine+bounces-4137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE26A13E66
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CCD1883917
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2025 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3F22D4D7;
	Thu, 16 Jan 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhG0Blrl"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32AA22D4C5;
	Thu, 16 Jan 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042905; cv=fail; b=LEDt+1wuR/+gqVcoAodoyXEh0ptzcwU8GYFI5IIhh8bNy6mlSSGQiM74wPp7t+eq+RKiwGjL0+0FGdpsdAFwzTuGykZ6Cjxy72IWYunus/tDKAUZvjI/PShSGdRX2Y+PPlVz0B48Xi/a7KeKLPFW6hMQ9Q8VYCd2gaCJvjdT7bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042905; c=relaxed/simple;
	bh=12+/3xEyeiMYm8K5eRhzDUWFEx5QnkPaw9waepFF2AI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l36cuomeLnmK3nnyl1v9T3quFg2admpSPXHHNBQ32MkEZbilirxCClITjMA/WkdrZ/lFLMiek8HejKpeQPDQw8Hm4SfCSy2VRP9BrhQfbjy7u3n+hWouvHu/hsBcdW7tvBeCTSQciXPhLgUYLn3NFrjROPw6MQTpGgtBoNLksq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhG0Blrl; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0DipeaZ676+5vH8eT9q8rvHJVyOXNN/X5wiBhabE58NcvFAIjfKvXMStgz4RnFLOhF9lv7IWJzk+GKK9ZqDnN6D1wykhna0Uu0shSF4NJ3fLlu7o4gIToLoeJG23sVGZwXE0c+JXbwUV8EetRAQFgvLrnIwZf7Wm8XxCkhD0kd49scRBG3ilTZkVHrs8QSBdeCoE/YzKmSIMHVFJoLy7zw6+YPFeRHi9Ac3sZ+yfv+CJ/4GIkpVv5YtZ84SrJzBAjJiE1e7rn7ezASjpToiC+fY1vSgnxMjxYQUYSsvxXyRayfPE/gXLVn4iH2eA4V4biO3pkem9mmWEZGc+kKKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN2k1fRBGA7Kwb3wkI/cm1r5IjODacj7JOGWn3XzbgM=;
 b=nRB+/kTb/4G7LxwoPohubmOoL1Ga9GqYIWEIb6VnfckbDfvS11YqZ9i/pPNCvyo6CChHmUGSvQoYPYPsOPkFVeHVWu9qldr2++Kx+VhvCjuWFkc8zyZyoKEYRZtunrIySSl9hLe/3RFk/yYGf6LPuCec05YgsG/TdqDK5Xx2xhwF6TBoFT1mUcewfFv26PqJB+M3UHdd024wZ4AUJD0H4twRPx4MUsOWy1wZAmmx7UTplXqI4SEvTOZPxo4vSngv3l4BGakxfx6bL8cJkEq8GJlhntfkjLBkKBj9yTsrQ3gArSjfdl721g6ZEsOuFqZTSDfVieA2Xn3UH3KlS6UJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN2k1fRBGA7Kwb3wkI/cm1r5IjODacj7JOGWn3XzbgM=;
 b=JhG0BlrlB2swvypXpyX/MRnsFu7xsqq6w8bu/sBODbinc/LTQtPoPVyM2x2OX43AW/T40cXC7XYWi0+3Zwg5IrB6oC7Ih3xVdgHndx3SY9Vfg/3rVDj/N746ddToZTXAFh50NLBVa9Dp5L7ZFNNdNAYx7T3ekWi6REg3lIRqO1GkPxQa0R7Gh5awNGFSJn/Vw8nM71bwP0EOpNuW6QVW+Q77P6iizr6gz1CXuWad0cZLphkWvn9vrJlGcp1PdXYU1o8cxnMUjtF0tmU5rCQsVPDXlFdTV0vKlvVWUBaibBBgqUo+yoQSc9ANFOMv3ONeEEH8K38Dt6nklGOKcd756w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 15:55:00 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:55:00 +0000
Message-ID: <c16c58c1-97a0-401d-a8e9-57619b2f99bb@nvidia.com>
Date: Thu, 16 Jan 2025 15:54:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dmaengine: tegra210-adma: check for adma max page
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250116155220.3896947-1-mkumard@nvidia.com>
 <20250116155220.3896947-3-mkumard@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250116155220.3896947-3-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 730b1ebd-d86a-4ac1-3032-08dd364621b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEdGa0hmZFZHZ2YyUHlkOGZ0TFZ5UVBvS2tLRHMwdzM5OTRmZGREZUs0Y1NI?=
 =?utf-8?B?c1NEdXprclZtcUgzMlgrU3JrcjJmdzVQMG5rTnVMQmNucTdBcGVhQitFSGh3?=
 =?utf-8?B?QjNEVkRqM0xFemxJakE4NWdOYnFDeTQrNGZPYjRia1NoWUdZQy9vN0M4UlFJ?=
 =?utf-8?B?cWpTaVI2S0U0Sjc0U0ViT0hNb2NZcjZIb1liRE1pVTJiM04xUDVHaENkZHNn?=
 =?utf-8?B?WjFHYW01TlA5R2Zybzk2TDcrTlJITTYzZStmSVRsN0pnOVlqWVRVemw2RlN1?=
 =?utf-8?B?Y2tTdTVPNkpHdFBkNWsxSnJ3a3hUUzlKU0FYM25aV09IbE5BTVAwcGpnckRQ?=
 =?utf-8?B?L0FUdms2Wmg2amwyc0p0MmswWDVwbEtWbFo5LzUyRDlsNDdaZVNlOURxbU96?=
 =?utf-8?B?UWEwOEVuWmc3SDJ3NFluenJtcW1FcmJCdnUwa3FkbGNCMDZ6ZlVWWVd5K3dP?=
 =?utf-8?B?Y3JXdjUydVk2UTArc3RNL0RHUExzWmNJanJVaDAxY0w4bkF5YjZOR05zQkRO?=
 =?utf-8?B?OXRXV2xiUEZMRElySVE2YzY5Wk9udjhHNUREV2YzbzYxN3BlbS9TWlJMNzlI?=
 =?utf-8?B?L3lVbUJxVDlGK0xvRHNra2ZQQ0FTc0YxZU91emYzTm1ZK29LQkJJUVNQT1hQ?=
 =?utf-8?B?ZzNkOUh2VFMvNGRtcVI0cXpldWFkbUVHeEwrMU52RkhOVFRENWJZV0VoQjl5?=
 =?utf-8?B?QTY1VkdFcDFRQVB3ZTkzdXV2OFFXS09HU2JiQTRlNkhNTDZyU2FuWkV6R21j?=
 =?utf-8?B?RUV3M0VBelVmL2dGVHh4TkNBNTVYcDJmazR0djZrdy9Kb2dmeENhakt4Ly8x?=
 =?utf-8?B?aEdtcTB2c0lhOS8yZkpPcklHTytUbFRTdWh6Y2NsVU5UVVExakdUVERFNnd5?=
 =?utf-8?B?L2MrTS9UREpTbXFmN3BiMHlINnVMSDVCd3pZa2lwWTN2emw2ekdCUnUxaHJC?=
 =?utf-8?B?Q3cyVnc5Q2hzSlhaeWlLWTFjL3gxNWdLbFpwOXBiOTlDY1FFczZBaHFOM2tX?=
 =?utf-8?B?KzU2MVFiQXhxRmNKcDRLNGhDQXd3b0VzT0E4M0wwOGVQc3FlNm5NS2QrSStz?=
 =?utf-8?B?ZXNyQlJmUWxOMXJVN0lVK2hJb2Y2aEdudlNuWkg5dDZjZTlkSklYU2s4MGRn?=
 =?utf-8?B?Q1dLWmNqNUl1UWxMeXEreHp4U3I2L0ZBTlo0c2VEbkdSR3RDMUZ3TDVYRHlv?=
 =?utf-8?B?b0JRZTl1Z2FVUlU3N2dzRHJwOWdiVWpPOExpN2FEUDZULzB4UVlFRk43RmVY?=
 =?utf-8?B?aVJjaHl6V2hZMkdmdnVVN1lCZWsyd1pxZmdZaWQyKytickw0ZVFESEhzdmhi?=
 =?utf-8?B?T0NqVDUwVVNhSDEyVURSVU5Kc0FaUzd6bnVSNiswb3RaM3hNNlA1dFBTRVAz?=
 =?utf-8?B?RVhKRDJjbk1OcGdlWXgwY0pjbE9HNjNZQ0lIQjlNMEdlVThhbWRxUkIyZC81?=
 =?utf-8?B?Zjgyc0RpaGV1N0s3K1B4WS9meVRPTmRJSXlGd0xNSzV1d1pYbnNud2xxU3BE?=
 =?utf-8?B?NDEybCsxZmRRdEswcnFNOGk4NFBxbGRBN3JZbU5uSmM0SlN4amhGRFYwOEJL?=
 =?utf-8?B?S21GdTY2eWllMjJ2T3hEb2ZyNGxaa2ZLR2ZOem45UDJqc0dTczJ5UjVlWkIx?=
 =?utf-8?B?eXJuU1NQVkVuS2tsdlN1ekFGNzNLNm9UL2RUS1NxNXlwNnQ5M1F3M3BCcWlI?=
 =?utf-8?B?a0lXSFVweGxvUXp2Q1UwYnY0V0lNMGlnbERnZy9mTGZSNnRqckhqb1RSRTFR?=
 =?utf-8?B?OEI0cjdVa0hCWWh1SC9vS2hUOVJtNEUwZXZkM05FVkZHYUNYQmVkaVNPWVhC?=
 =?utf-8?B?NkFkNTZXcy81dng1YWY3TSt6a1RuN09FN2pTM3RVc3Z5NnAxMW5XSEl0OEFJ?=
 =?utf-8?Q?Ivn48Q4QZ2Tu3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHk2Z01PallTN3p3SGM0eGhmRVJVNmNqTTZwSG1yaFdzRGU3SENndTBXbys4?=
 =?utf-8?B?QTJ3T1o2M0xJVkJmcnQ3WFlxYk5La3pJWUJhMFpMekNHczY2WmFncVJ5a0w0?=
 =?utf-8?B?VWdDOTV4dnpyOWxtNmNWNC9INkJPWnVNYXBWTlRkNTNPNmhMYVlJMTFOSFd1?=
 =?utf-8?B?eUcrMTNLMEVhRUVWY3JNS0ZkN1d5bGl4TGFCaGZJMkxWNUExUkwycm91Wmlr?=
 =?utf-8?B?YzRjUllUUnVrSWppQVF2RXNHbHY0R3k5NTZlUTNUaU90a2Q2bDEzWkJqdE9Q?=
 =?utf-8?B?dDZhajE2UDVyWlQxcHMrbUJpZEIvVmc2TWZJbjhycWxWMFpVcVBDU1U5TnA0?=
 =?utf-8?B?ZFJVbFlyQnRXdWRBeXVwM2hZZ3hJQ1lEbzFRVTBxNEl2MEhTRHNhWnBlM0Zt?=
 =?utf-8?B?K2FQb200cVM4OTlabFcvT3pmUTZIeVlSaDFnbC9FYTIwQzJ0d295WkJ1Tm1t?=
 =?utf-8?B?WG9KSElxT0hwQURsLzBLVGlaZjVuenh4eUNvbEV6aEVDQkkvQnB3WUs5UGxa?=
 =?utf-8?B?ZjBpMXpOQlFUM2ptRmJyN0tva2ZMYXArclZ0TFlEQmZNQTJVeml0VGJNOUY4?=
 =?utf-8?B?QWlPMGp5MUZ1UFh6T1BtNnpMT2tPY0ZzU0hZR1pCMWFTc1hSa0JkZUQ2MTdS?=
 =?utf-8?B?dWNpNk9oSm5nK2I5UGhGb05wMngyRDhWWXRKVkxoOUFjRVBJeVdyQ3B6bk9U?=
 =?utf-8?B?VkY0dEgwSWZSelIzcE1vem92aktXM1dxZitVNTlxbjdBWTAydTBOenhCRmhU?=
 =?utf-8?B?YkUxM0xtUjg1MDNtVkI2bklxOWhrVExxcExubVhpZUFqVSsyREJOQ3VKVnpv?=
 =?utf-8?B?SlNyZGRUMmtnMlZzdllXVFpRcHl4eVJhWjV5d1ZqQnd0TjJ6UmU1N1gzeGVU?=
 =?utf-8?B?ZzJFR0hwVUVJc0xyRTRSb2lQY2hIdWZMTXNhMzl0QXBIRDhyeXhJNExpL3hr?=
 =?utf-8?B?amJXK1NaYlBsV3dEZzA3VmNaMnA5WWl3UC9pSUtWMzVYMHVWWGVCbERNbzFq?=
 =?utf-8?B?T0RaSERKMHZxU1MzVk5pdGlZMDJjNHN4Y3R6TjQ5eHUvaEgwUHVQeC9sNk92?=
 =?utf-8?B?U0w1ZFVSWDdxWjFEWnhDVzlMZUNNWTFIQ3ZoV1REZVlQM0NqZHdFMlZOTnFK?=
 =?utf-8?B?N1ZwUXZ4YmhpSU42RkJOSERuZjhkYTA2UGQyM0xVZVp4S0JteGhVb2hGS0Fa?=
 =?utf-8?B?TlcxTWVMdUpyOC9RU0pxS1RkUmpVV25DenpIcGdDbjlwTE5SUVU1dXRWSXlO?=
 =?utf-8?B?QnBGWW9iTnFTT20yeE5zZWJHNVN2azZadkFZcGtyNlUxUTBTRlQrRVRtWE4x?=
 =?utf-8?B?N1VMb1FMNHlIWlRlbWtIUDZZSld6dU1ZVjhSdWljZFF0NHR1RDM3enBEaGdD?=
 =?utf-8?B?OW5GbXF5dnpOWWloRFlFdUVVUW5yMm1TNzlpZ3dkYnRCdEJnOTlwQ252Z2Er?=
 =?utf-8?B?YlhtV1BRaGk3T1JuMnNORXdBRE9ua1I4Wi8zSDBabHdvb1NVSUJwQVVid2N6?=
 =?utf-8?B?L20yK0lIVkt3ZjFpMDNuUm1XbVFDYTB0WHp4MVhtNUozcWJPb3oxcHJRV2tQ?=
 =?utf-8?B?dDJtOGk4TE5icGpWanpEZS9YS2xFYU8xTHZwYlRkNU1rKzJ1V1ZSREVLVkow?=
 =?utf-8?B?bWtHRC95dU1wWlgvQTFiWmtVK0NGd2RJMlNQNGpWcENWU1RmdzhCWE9XY1Ew?=
 =?utf-8?B?QjJPdXhMMm0rNkpvRzZrcG55aC9kbm1XTFVRbkhQVUJDMjFyOWZyTHR6UDBH?=
 =?utf-8?B?aVN0MUtYSkE2ck1QWnpIdUlnSS9LUjVYTjRyMzdjUStYdkZSTkhZRHFyRk1x?=
 =?utf-8?B?VG5RN1hKRjhzbnp0eFFXbHZWZUkxQUVDL3JXQjVJYXdBbGlraTkyY3VHUDg0?=
 =?utf-8?B?dzZnV1lhRlpFZ1h5Mkh5OFloRFNpMCt6VFo5VDFiMmVKL1dzWmN2aGRaTklT?=
 =?utf-8?B?cFhST3AydVE4cUdmRjB3STdvU1NXS2RHeHE0NXFMSGdQZTZvM0FiVXFLUlJL?=
 =?utf-8?B?cHZFQlRFdENtbjBWbmhpMUs2Vk5xNzZmMkhTU0trc2Y5Nm1DR0pySWdpNTVn?=
 =?utf-8?B?UTFpZXZzb3dqN0JYZ0tvNVk1UEx1NFhwdEVhWmFoN1RGemxvM3B0aCtiNFR2?=
 =?utf-8?B?WjVLQjE1amY5OUNqci8xK3FIWmlTUmh1b1FNanUxQXFrcklrbjhrWGQrNDJR?=
 =?utf-8?B?U2xhQ0ZjVlhmc2k3QkxoL05zVnE1Y0JOMGl3MWE1dUEzQnJGdzhSSU15b3BP?=
 =?utf-8?B?RTBVNlErczQxak5mUjZsYTRSdklRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730b1ebd-d86a-4ac1-3032-08dd364621b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:55:00.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5P7W7HL+gGkCSbyVU6YlI79AkH9WwCKy0qZnmXzdwqRdAsaZ0edMELDixJaJudQUvgdG1XXpT5JrbtZRiknUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945



On 16/01/2025 15:52, Mohan Kumar D wrote:
> Have additional check for max channel page during the probe
> to cover if any offset overshoot happens due to wrong DT
> configuration.
> 
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c                  | 7 ++++++-
>   drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 2 +-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 258220c9cb50..393e8a8a5bc1 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -83,7 +83,9 @@ struct tegra_adma;
>    * @nr_channels: Number of DMA channels available.
>    * @ch_fifo_size_mask: Mask for FIFO size field.
>    * @sreq_index_offset: Slave channel index offset.
> + * @max_page: Maximum ADMA Channel Page.
>    * @has_outstanding_reqs: If DMA channel can have outstanding requests.
> + * @set_global_pg_config: Global page programming.
>    */
>   struct tegra_adma_chip_data {
>   	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
> @@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
>   	unsigned int nr_channels;
>   	unsigned int ch_fifo_size_mask;
>   	unsigned int sreq_index_offset;
> +	unsigned int max_page;
>   	bool has_outstanding_reqs;
>   	void (*set_global_pg_config)(struct tegra_adma *tdma);
>   };
> @@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>   	.nr_channels		= 22,
>   	.ch_fifo_size_mask	= 0xf,
>   	.sreq_index_offset	= 2,
> +	.max_page		= 0,
>   	.has_outstanding_reqs	= false,
>   	.set_global_pg_config	= NULL,
>   };
> @@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>   	.nr_channels		= 32,
>   	.ch_fifo_size_mask	= 0x1f,
>   	.sreq_index_offset	= 4,
> +	.max_page		= 4,
>   	.has_outstanding_reqs	= true,
>   	.set_global_pg_config	= tegra186_adma_global_page_config,
>   };
> @@ -922,7 +927,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   			page_offset = lower_32_bits(res_page->start) -
>   						lower_32_bits(res_base->start);
>   			page_no = page_offset / cdata->ch_base_offset;
> -			if (page_no == 0)
> +			if (page_no == 0 || page_no > cdata->max_page)
>   				return -EINVAL;
>   
>   			tdma->ch_page_no = page_no - 1;
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 45004f598e4d..2af939bab62b 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -466,7 +466,7 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>   	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
>   	       cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
>   
> -	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
> +	//fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);

Looks like we need a V3!

Jon
-- 
nvpublic


