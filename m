Return-Path: <dmaengine+bounces-4147-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14CA15243
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128783AE6B8
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFDA18593A;
	Fri, 17 Jan 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOnKVnAX"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9225A62E;
	Fri, 17 Jan 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125677; cv=fail; b=DfLWfILHhsegzd4/E5GdDZu5HORtkIVQxJ99czc1YEsXnx5/9RNHBtw7WbCL9mZc9+e0OijYBDoAe2uC70+EASje57oIO9Z8NyHx7pIhMDAmvGLljO0dQbzUcMbBK5fsDQz9jXLUsqoOVyfsk28VZHfnyr5X5KEgzNcaORGFfKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125677; c=relaxed/simple;
	bh=zJ2ILiIWErxyE1xkA7/uVgXIb4JL22cQzM+Q+1yjTrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LpDIlj1tH0JdMiPDyD+afX8QNHhrltJv19QE33P4sbqW9MP89miNVeGeogQrHJ7I5EQ2fRc40Dr9x6zAbCU4PcD+6n1iENjMjqs0u4XwlLnMjeTqFul1qxeiJehQjGm1n3sX4wkYe1zbSa73hJvTk7ATUwTd2u/ttUhS6Eh9vKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOnKVnAX; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHNseJua1KeStrCJlGcmPeowy4OV8xEjNz14R5k1W4tXLzl2JbW2o3VFBFhkgkZB/7/1vygzaf6liUrF0GxqvTYOHjAEtxsm4SeBiaBgzaV1+09/XJqYUFNDanxSBiYIQeAt9ODlUHH5dVjiVcfmE13NDPcg7o6l5wWoJHapSoB3FG4Qp4ThuBQVn30RqDaeUOsbsLUP/jxrmBx8ppPkhY8KIoNdFtPsb45jWtE1EoReg4gcak70xlhRhpfMus6uvrGcWgbz9EjYL9Ns+I31AbCBuyAYIPgd5VFy6tkFidIZHB8T90Vij8W07p6rJgEWvPWfmhY7NX0AnBa7c/ngjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKNN71UaU25PwBrV7slGon/XocwsmDIXDN4WzqZMt9U=;
 b=mD4+CK5DTHi3/RYgKqRwdDKFhXGk8NsbI9a5sMvwPSacknTLSCD86YvgSshCs724EJscJnksOWg9kuaVnoIW75yjzv7lcvprdhnRsT39NoRLCZjpGXpFnYzL8G+5MySlBDnb951XI8ex/voMoYMuztlmHy5cSPIB0g/mnpTHVmuF9QfuaO+gQPLtGP6cuc25NRGv6uaS6+JUVm5/+bbMXISnQlx12TdWHENuQvWCs8Aseaws6XU24219KhIgzYn7suqmnDhuWWeJKz1MN542R/p3xPuiqza0QzzAQrnituHZuMg6fA8xv371DZNbzQ929PspyH7yixKGu8UXhIWpzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKNN71UaU25PwBrV7slGon/XocwsmDIXDN4WzqZMt9U=;
 b=WOnKVnAX/Gfoqwj9R0TzlvNjh2h4tB1ay57lb3U8UYWLCemX+rLHXt6e8wqauK3BkfeBk5fla0eC8dQBcc7nAVy78mOvt2OeS5tOkw8iL+877Xfc93TlVnaaYGo2keM5CCIs4wY1m+aMwB+/9Z9t+VPdblb8eExrleOvJI709brkok44UBMtn2T7Mw7npaKhu6XGp8YbDeNgWWuyS5146Cf4uaRj551nSrCPn1ULMAT1czrFLISTzBVhLNpUhN3UdIGtUJEEbUF0AtKMRHArCuaKkJMIrNQkvjDjlEFSqs+G4Porrj90KqGf1NY5EpazGE4SD/XPWWN4VLqkQFbFXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 14:54:32 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 14:54:32 +0000
Message-ID: <6191971f-cf5f-4303-9bc6-3444ccedccd6@nvidia.com>
Date: Fri, 17 Jan 2025 14:54:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: tegra210-adma: check for adma max page
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-3-mkumard@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250116162033.3922252-3-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b21e73-7714-4d74-5239-08dd3706d9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UldoMG5YUnAxYnVvb1Ryb2FkZnAzcmRVWnhkZ3BGQ1RQZXQ0RkU2dDR1VVZH?=
 =?utf-8?B?WEM1a3YzSTdCZHVUQVFTcGwzRGw3ZjB1eC9IMFZ0ejcxN2xpNjhKWXlEK1dW?=
 =?utf-8?B?K0FWOXhhN3gvdlQzbnFXYloyY0lja1hJRGEyRnNaTVZ5TzA1K3N6UUNpbnl5?=
 =?utf-8?B?TkhPQjJkWWJQQ3R1em5pNnhXdmZzNmlHNzlrckkvODFVUitaYmg2ZmJmRVNi?=
 =?utf-8?B?L1pCc0Y4ZHRBZ1Z5VmR5aTIvRUxtQTVzY1FvZTJkQWc3Z3FUYjFRVTNRTFVm?=
 =?utf-8?B?UGFMWVlpYTNRVVF2aGU3NmhocUJnLy9zbndBTFVKaDZHTnY4MmVLVzdud2I1?=
 =?utf-8?B?YVczZHZWTiszbmd1QkRTVmNLWXpvRGtVeDdNeU9qeUhMV1FOUHUyb24zR0ZC?=
 =?utf-8?B?SkRpbmxmazhOeUhYRXFidTEvK0w4a2NTOUVkRThoRDhDYk5jSTJ5UjRXNy9p?=
 =?utf-8?B?M0FBS0FuUFlpdHhpcWhoK3l0QU81ZkJnakh3WkJLSjA4U3p5cE5oMmFDUmk2?=
 =?utf-8?B?dkkyblgyWi9zWE5QZ3BzM0RyeU02WWZkMHhKOGdTRU9oWHBLYjRLU3NsZnVB?=
 =?utf-8?B?aUordXp1RXJ1c1NvZjlOSXRkSWNxdjIvcUlmajVoRTZaSmh2VE9rRHRIMStG?=
 =?utf-8?B?QlVDOFEweG9GZmR5Uy9jL2kyZWVnOHI1NTdTTjFTZndXTkdqc0RQYlhHQVND?=
 =?utf-8?B?OTN6UEFGQTZzQjBIc21ieHh0Q1ZuUXN3TTVTREJYWDZlbStSRGhpbGVHcFNa?=
 =?utf-8?B?T0lVbG53ZGFXbWZzS3RxTS9CVExrUFR2TVNQVmFROTF1VjZjUVVVL3hQM2dh?=
 =?utf-8?B?UmJaK2cxTlNubWNrOStVU2doZklTMkhuMjNPVHFxT2FLVEZXSzNqVUxhSXM0?=
 =?utf-8?B?Ly8zME4yRFhNeWFSUnNoL2l1TUxYWE13ZFpQVGIzZVBrOWV3aUhoU3lsdmpz?=
 =?utf-8?B?TEdRVFdUdGlkOVkweUFWYUM2N1NFekw5S3FvemZUM0xnK1FDNXpxbHZQWCtG?=
 =?utf-8?B?WHJXc3crejl4cmVvTzJPVTNjZXlOVTQ4Tlg2eXJNcmd2MytuYXMxQ1ovaG5h?=
 =?utf-8?B?cVMwR1ZsdDN6aXVoTjROQnU1MllBWXdqK3NySkpUQmdpcE95NVlKMXNKd1E1?=
 =?utf-8?B?ci9OK1BGU3VOM050ZzJWcWZaNENaL0hObWlTZHJmUFIvY2IrdERtZmNpR1k2?=
 =?utf-8?B?QnpZL1NXR1ZBYnBBVEdPeko2djJSbmc1QjgzV3V4UVBmNlZPMXpyYzZOZkNQ?=
 =?utf-8?B?czFGVCtnQWJ3K0dDdFp4TS81Y2FucDhac0kraGZZL2xUWkh0dnl0OEpyNlNX?=
 =?utf-8?B?Sk5CUndqSGhQWSt6Y1BObmhvRlJnWTRJd1FXbDhDUWV0UnVBT1o4K20rM3VW?=
 =?utf-8?B?NVkwdkxTQlpBRFJCd0NzSkNYUU1UeFFDSXZxaGp4RFdTdnFNanVhc09adnB1?=
 =?utf-8?B?RTJ3dDhMWFg5KzZ4bThRbXVOWUZqWHRVT2hYN2s4RTJvQi9PbmpteGY5bmc1?=
 =?utf-8?B?YXh2QzhoTkV0dVhwZzBzelA2NEJIVldScjhQZCsrdGR2LzhKVXV5eFhiYnFT?=
 =?utf-8?B?YWgvenN0VTRLSGdYTE12ckl6WFFuNEtUUnJ1Q2hKNjVObnllREVWZEd4MGpv?=
 =?utf-8?B?S3A0blQ2ZHdYWFkyWGg4SlJua2lJUGJueXFnTVlDZjRnWmYyaU9QblF1NjVK?=
 =?utf-8?B?cWZZVzliMmZIaU9NTG92cDdWQllXN3IrT0hqa3NTaitoZEw2b2tqS0hWZFl5?=
 =?utf-8?B?U1E4Tk15YTUxUVlZa0V5R1djc3dTQ1FYVE8xbm1ab1pQQTVBdnZzU3VJcUtt?=
 =?utf-8?B?UkdZUzZmeS9CN2V1RFd0bnkwczFvdlNhZkhjZSt0ak0yU0toODMxZEpXYU8w?=
 =?utf-8?Q?97G68KnYpKzcl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVNWV1hBeGtPaE1aWkZGTW9kY3lIQ29kQ0FzTWlvZnNVYUtueGFTd1RyNFlS?=
 =?utf-8?B?NGtqaFR4L2JtbW5neXJkOEdiQUphM2Vyay9kMm45SzlYbkRNUzNPeldkZFgw?=
 =?utf-8?B?N2Y2V3NmTzdJMFNEb3NjVWx0QWlGN3NwOUFyS2VNSHE5RDJTSkhYTVkxcGdD?=
 =?utf-8?B?b1kwZEdqK0lYQXkyTG1senBha3BCcHJpa3FOOUF0cEluYnROL3lPeEFEbGl2?=
 =?utf-8?B?a0V3Z1h0ZzZhVXM3bzFPY1dnd0h1MDIvemg1U044S0MyMlFMYzE3U0RISVB4?=
 =?utf-8?B?ek1ZdWx3RWhjQjh2ZGRIYzRrT0xRVzQ3RlNjWUZsTjVvMDhMLzFSbnR2ditP?=
 =?utf-8?B?SUZ3eFBTcHI1NmV0d09EeVh3c0Zwb3o2UUcyZmVmMDRCcUhZRjVtTDRmSTM4?=
 =?utf-8?B?YXdmVlNFNUVKRnUzeERFa3Ixc1Z0ODdYcHZsRC83aENKajZTOVIvTldWZXEx?=
 =?utf-8?B?MFlyUDNBeEtoTndvRlNNOVhWdTVtSzBQR0Q4ZFk1ODdqWVlWSGxVb1pDZUY4?=
 =?utf-8?B?WXFUUExpdmhVUDlEMkxCb2lZd1pkbGRWS2lYVkZ5QjFjUGJIaGhxMWNLbENk?=
 =?utf-8?B?aGpTZzZ4a1ZtTDZhNUE1ZFNiSnpyU2IvVGJlbGhjcXNwNnRNZitHUnJOelY2?=
 =?utf-8?B?ZHdKSnNNNGxYTTBuUzZUT3R0dlVtdnZLRlU2T3l6Y21ra0tzRTRuTnhod2Zm?=
 =?utf-8?B?Kzd5a3RsdFh4eC9sTW50UFRFakZzZzYwdDdvWG5MSUlZblhZcWxVNFNhYkg3?=
 =?utf-8?B?YTdPVUxqbEhZM2lCL3UyOCttZ01pZ0xIRngyL0M0ZkpkRFNRV1IwRWhUdnNj?=
 =?utf-8?B?VmoyK3hPdndtTlJ3aVY2dExXeUE4NEtNb0cyUVVCUVZqRDhTQWtqbWprRUVo?=
 =?utf-8?B?UTVKRkJlTFpHdDllcVJoNzdBeElDMGxhWC94c0RuT1J4SDh0QXQ2Z3lQSWZ5?=
 =?utf-8?B?bVR2aExodmlJcENOTlR3cHdtVSsyOGcybVI4YTdpZXp4SFZjYm5abGpIbGtq?=
 =?utf-8?B?TnQ5ejhiclIwcjlMOWlseGlWK3oxSUMvUGpYRkxyRmRsRmV0aFpLcXoxUmVv?=
 =?utf-8?B?NjZjeURmT1UwVGY1TzdjNkdvMkpUU3pvalJLTjdidFdKbERkS2Y0WTRmU3lV?=
 =?utf-8?B?dDdzYllqSTUwbTRuQUd5MncvNWV6ZHpNWFZVbGRUNytyc3M5UEIxOU5LS1lR?=
 =?utf-8?B?dkFZUjBScHNPOWQycXFZVmRvc3VIbGg0Yy8vZElGOHFpTFpQbW1wVTc5V1JK?=
 =?utf-8?B?Um1tRXBaWjZxU3IvbE44TE84eVozcWQxdkpQa3lkMC81OUFSUTgvdmNDUm1F?=
 =?utf-8?B?NlFZbjdtSm5xc1I3NllSQUNnekZGUStROFBYVjN2MDRUUm9UTDNabWVhWGJZ?=
 =?utf-8?B?bkNsemdESGlhbFR0K24zOE5yTW1WWWJqVjEydHZxNFZuMWlVUHE4L0U4VkR5?=
 =?utf-8?B?VFI1NDlYOU90MWs0a3dmNis2MkJ5Ky9LbFVteVByQkVIaHYvZEZJS1BxRXdo?=
 =?utf-8?B?K2FMeWk4aXlrUW82WGRTRWJvc3F5WCt2TzF6NUoySnJVUUM0WmVaTHNQd0E1?=
 =?utf-8?B?K0lYblNGb2ZGdG9QdHY1c2ZjZkNSQldLcUlpMHhyMG9FQU42Und6RVRaNVFa?=
 =?utf-8?B?YVRyQlkyZ2VZR05tM3hsNGxXSWdSNmZiWEhUdm9jUmE4YzBDOXp3bkJ0NWFr?=
 =?utf-8?B?QitKNU5VcER0ZmJBb0FxdVh4dUdtejB1NzE4Y0RsNmNGa3dnZzBGYndRWS85?=
 =?utf-8?B?VkVwaDZjZFNTOXRnVXVTVWd5RGJXRXE4RUMydWdOMXZnVUpxb09ZL29Nc3l3?=
 =?utf-8?B?YXdUZGU4ZmlGcVowUTBmaWRZTWo2eWVxNndOYTloV1h4TDNkZVdHUXZTTDdQ?=
 =?utf-8?B?NVkwNkF0TGNqZlFzTGNxME5TSzEvTWhSNC9qLzhydCt5a3h6WlpLR20xUHg3?=
 =?utf-8?B?aVJYdllRWmJNNWE0VFI2YjdVRVNwK0VSblVUNWMyMW5MRFlTZTFsSktFUjJI?=
 =?utf-8?B?dlRUUy9zMFFrS3dtUUhUWlROTWpUN2RCSkZHa1ZFTmFNak1MRUFqcWtLdHUy?=
 =?utf-8?B?S2dvbzljQlpIUFVOZ3JlMjVwMVA3VE9lZDlkcDFNaE5xazhpbWVEekljdzli?=
 =?utf-8?B?bXdKTzNVR1hIcE94Z3RONU1CZW5iYjZxTDR1ZHJwcTEyUGVNbGFQMGxoclUy?=
 =?utf-8?B?WHlSQzkxd1ZyaFdTQk1QQmV0djlzYm0rVlBJblpWMkhSTmdQcXUvdzl1Ty83?=
 =?utf-8?B?L0o2VHNYZ1lJQzhWVkRJVWhMbVNBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b21e73-7714-4d74-5239-08dd3706d9d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:54:32.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mb9MQplj1vthKxqN2b0hX8jyGs36RO4ZmPyPg1lm8yxhGmYCwFmC0JmLSoHJy3hxaX2oye8TPR0f60BBMTrd4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937


On 16/01/2025 16:20, Mohan Kumar D wrote:
> Have additional check for max channel page during the probe
> to cover if any offset overshoot happens due to wrong DT
> configuration.
> 
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
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


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


