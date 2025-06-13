Return-Path: <dmaengine+bounces-5463-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99B0AD980B
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 00:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F2316A6E9
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA528D83C;
	Fri, 13 Jun 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pWSuyjl3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CD244676;
	Fri, 13 Jun 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852472; cv=fail; b=qWhP0mYkMIxlwBbXomvGhiBzSIq7Zcb/X9ZCQfS36OXHmxFevTTx3yWw2xfxu+60638iS5WR6byPRAnV/+XXocTiIYfSQmJwSZnnzr8OWXtQUd1rr6Th2T4slfg7xD90UJmcIdYQUKemGwLmwlGD1+EtsujUpqEiefaBS/z/tvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852472; c=relaxed/simple;
	bh=IeTaAcZLFs30QnMZ2QV/qKXxS+kYAA0/P32IYuWkCQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d95m7sbpt1xy4meeotS428SP813G3HZxz1JKKJHNgS2xszXORs9T3JoJRmcOMQt7Hl+xNgnUoqAwA4FWHBtIXIDSPvCp9fa4zg0Tr1JB6xStfbxunAuqqmkHESKRWQqAMP0mq1OhGZWv19eCtzw0Rn+KY2xYHvrDCKeAVFrPCuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pWSuyjl3; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgQ+gXqViqjioCWWzTz9fXnDBZRw+dDzVGghoJ/jFWIPK68ia82k1Y05U2uhUcExMs4oC2I/nNalEMHJTVQqvw0vZeKpFIARiDAFUZs/uNVtTceu2aygujsIVLSp2tqv/ItApZ2eJeofb8oEv5ZTyNfx5/DkVJYv0g0jFvKp4H5AjEjRPlV/FbU+OczuS7lZ8P1EmvrCJ3y/0vD1F2bvuX/WUSH3q+aNN50THar7a2oPNhJozFkKQIcElqn6Nbf/dxiJzOtetUKUGhpDxIHm5/Opa+idO+EtV1TouWdsMI3B9/FK7z4v9HF1/zSXpklFVzQea5z9/ObkM7Rlj/ZyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Aru5gyugaUNsX4TV2PB/SApwd4QyynHNNJ4w1o2Lgg=;
 b=NDgHa0EQ0oRKdPAJPihfF6iSoPCVBG16sS0b3I2RcWaQUZc7a+SyorjVaTyTU18qr0baHncjItaCIPR/viUWgsK0UbozAjrl4gjTwj5CiEwYFqhpjIWykk0Y6PBdc8zcLH56p1D93Cqtk0fN/q0iZcFT2uXG9Cqj+0bDb3Q1pom/HLF6rXLwx6xUl2IGNKhwc4vPtic1LI5QT2xF3CL2AU9hWh1uhWuLJrYmQwdsKb3ZwNFIOs9g9gcTsiWUjCz3yHvm18Nai+W4//pUgh1uxJO+34PxT/GzePJI2b2PTS0BXI1H62KSuiQzPEJ2F6wpJWIq69kaEMWZz9RE4d/elA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Aru5gyugaUNsX4TV2PB/SApwd4QyynHNNJ4w1o2Lgg=;
 b=pWSuyjl3x1j++Yrv5Q96BcPYzO71zNLbNBJkjzHUGjks0KrR/1XtEfsE4Zw0YXGLKv4uD84zjJ42UCt07kshVxn6MmvZNAgI+7jl1zy5FgQOY1CiywCIa1V5I65MPUg6EXbTcAVA0VK+bYU2yVnF0i55JcJUPKR7mcGG3sncLiPj3SEzZZ0puRwn1F50LzpXS89ttep4rm9PMZjPlqgJYJc8bm08J8hfm8Oky1GWI8sc5/0ER5rvUWPeNmd7QOi0ceRzPnMVhrfoZTOJgi2K56PcbGfwFGFZGso/N4IuWte2sVftUlYkSQ7RTWkkBCrH/rg5MEgVmx9xK3lwryG6Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.18; Fri, 13 Jun 2025 22:07:47 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 22:07:47 +0000
Message-ID: <c9dae480-b5bf-4028-a398-bafb9d206f50@nvidia.com>
Date: Fri, 13 Jun 2025 15:07:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
To: Yi Sun <yi.sun@intel.com>, dave.jiang@intel.com,
 vinicius.gomes@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gordon.jin@intel.com, anil.s.keshavamurthy@intel.com,
 philip.lantz@intel.com
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-2-yi.sun@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250613161834.2912353-2-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d5f9df-0bd8-47b1-0d18-08ddaac6baec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnA3UVdFUHYrZkJ4NUlnL3U5SzhIWHZORUNvN1ZBSklaOVdvSDZVdDF4Q0NL?=
 =?utf-8?B?dEMyNGVVeG5RS0cvcENWcGZ2d2lYZEJaLzZkY2ZpUVZwbWcvdXZuWS9WV3N5?=
 =?utf-8?B?MWtYWjIzWE1JZGtXZks1TFNKMkkwbmNkR3dxUlZkekt5WkREUGVUK0tOcWph?=
 =?utf-8?B?QUw3TlBWNUtIL1plRThMVUdiV2lCRGFRV1lkYzREbGZWMUhFY2dDa29kOEEx?=
 =?utf-8?B?bFltNEkwazZ6Zi85Y3NhZUtQVlA4bG1SUEN5SEl5UGNUOVd4TTNkSXVEVXl3?=
 =?utf-8?B?MVh6Z2VXeXVVODEvc0txZmwxY0FLM3RKd2pNb1hoZUhmeGdLYXN6cU9rVG5o?=
 =?utf-8?B?NXl4UEwxMVpoaGpBNVRxdkk3K1hrSk55RXdjNXZkVTNkVkExQmh5dm0xb3Np?=
 =?utf-8?B?VFBtenoxYUZNZ3RxSTZ5alFCb1hQOG1iMytGK0QvTlY3U09PcGt1ZUJGaUw1?=
 =?utf-8?B?dkltaSs4UHFFbE9qQTdiMklxUllwZXBtTGhLdmpGUndwSnhCR1kxUW05ZWJW?=
 =?utf-8?B?QjlTZWRxWDJLZDVIY1lyajQ5RU9ISm9lVFpuSXBKb2lRNVNqSDRzVUtjZDEz?=
 =?utf-8?B?NXhpNzBtMzdkMk9wRDNteEMrZDJQVUFIcmJ5Y3hxOTUyRzloelNkN2tLaEJ3?=
 =?utf-8?B?bUZXc2ZIcGtJR2xyNUZEQnBvNHNFUVYrdDdsT0F3anBtQ054amdUR2U0T3B0?=
 =?utf-8?B?SDlmVmhLRUVja0ZCQWZ3dytqZnorN1BJaURoUUxuMjdPVDB4UHA2Tm9OSFNF?=
 =?utf-8?B?M05MMCtOMklqek80QmVaeCtjNXFYTFhFendoUEpudGFwSjlYeDFFK2FEcTRj?=
 =?utf-8?B?R0czQWxhbWVnaVhPZjd0d3NFYUlEMnF6WkxVaklwUG4yU3pIZkw0bHdlMHlB?=
 =?utf-8?B?ZVhxaTl0cFZpRnhzRjIxMkZMU2JMbXFYOWp5bW1OTW91bkdpRGFjdnNwak02?=
 =?utf-8?B?dXowOTl4emVmWXN0QjVJdXk1YmhuNnRhTTU1K0ZuS2xWcXBicWhxK055VzJa?=
 =?utf-8?B?N2JxbHdDUEZMbUJxcHkxNEIvWnBSL1VaOVkwQ2pYSUhPMGszTitySCtCbHRT?=
 =?utf-8?B?N0FKZW5jYUJsM3AwZXBCNFhGd1F5WVVzRjAwSkhOcUdLVHJTMHYzNFVPc1Vs?=
 =?utf-8?B?NWVYQzJTZmo0VjRxaWMrNnNQYmJnbDEzaUMwcjhVdzVBekNYY2R0RldwVDNJ?=
 =?utf-8?B?aVVQL3Z4MnlvaHRvOWE5SEx3aDZVYmRkb2tXVUk5TndHZFlpNXg0SWFpdGFi?=
 =?utf-8?B?bnRPNmh4NDdLcXA3dTlsNWZKNCtYTnl6TUNENFRxcytJYndlckN0MjFlYVpU?=
 =?utf-8?B?Ykt1S09pUFlzWjBjYVRmTUpnT3kvblI0VzdsS2g3VlB4V2VOdHJEMnhDV2dI?=
 =?utf-8?B?U3VlYk8zTFRTNXR6T1B2Zk4xSW1zM1krVWFDMjhZaGg3TjJvMDlVVHlTZVM0?=
 =?utf-8?B?cEI1Z3JWcU5veXJyWFd1L0ZqNUlGUkhoV2FSY0lPVVB6aXZZUTRGb3BzSVkv?=
 =?utf-8?B?TnRtcDJGR29rVDAraVZjNUN1S2lNUll6T3BrRys4dmFsdGI1VGpNUFhDajVp?=
 =?utf-8?B?Rk5pK0puSUgvUVBaTnJxUDRMZ3gvQjNweVN0cjV0bTNvUFl0b1Yzek9tbS9K?=
 =?utf-8?B?WjNDZWhnZzFsVVE3NXV4bTJEVTFvZmd5alVIS1ZGUDNPd3ZWWW45QmNjTFhQ?=
 =?utf-8?B?c0pFSncrSDROV0lyOXg3dXo2SU9UN1luYWloMVRUbysxOWV3VHgraWJwWlFu?=
 =?utf-8?B?ZUwzYTZIQnpIeG5paHJPaS9tbzRwVDBvdm5BZUVZTUtBTjlIdUt4RitJb1hC?=
 =?utf-8?B?YzlxQnJQQjBBcWltMnE5cFpVMWxBYm1DRDFQU2s4RlpJaGV6ZFB1VWo5ZWk5?=
 =?utf-8?B?alM5UXExSkU3VEhUd1Q3S2UzMTVvL253Q2JSSGpvSnlMb041Y3JGdUtmcWYr?=
 =?utf-8?Q?Wu79IQfBHQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVaRE4zNTFLVllidC9HdUhHMmtFWjhMVFFna21UMlR1dWpuSjZZcS95S0Fx?=
 =?utf-8?B?NEtPZmZOMkZBY1EzQitSTGEwT1ZRRWdTVE1qNG5OWnpUcVZ1M242Unl3TVYr?=
 =?utf-8?B?eERHWURSaXQyL21maGtqSUVUMXlKSG9JeWxiZUZFSnFUQ1g0YXV0NERxUlNi?=
 =?utf-8?B?cTlLNlA5R2grbnpDQURLNkh0QVlaMUdSL0JMd0NyeHZJbnZYcFlraFU2U0Q1?=
 =?utf-8?B?VEtLRzRyNHVDVFhBWjJkY2NMNXFWdGlKcGJPMlhTWFBhdDNKNGE5VVBoeGNu?=
 =?utf-8?B?OC92QXpVZWtQeXNJaWRic3doTzVRT1hzSFBPZE05ZEFKL1grbnB4T05WVEU2?=
 =?utf-8?B?dHF4UzJaMFNUYmkrYUxwbmpKc2hLUjVmeFQ0ZzRlZmhJdi83T3NjVU5lZGEr?=
 =?utf-8?B?TkVRKzRRWm5SOXVzTHN4RkQ3QStIdUMxZG44L3o0aG4zZzVzYk5kV2lCQW9r?=
 =?utf-8?B?YmJCd2dEOWhnd0ZwekdiWnd3V1ExT0ZSRm5CUkg3cS9lYU1PWEpxU25Mck44?=
 =?utf-8?B?R3N6d0VDUm9mclk4ellKcjVtRnVYUmlKcFpFN2R0T1BOanVQM0xKSjBCbFVN?=
 =?utf-8?B?blo4Zy9PZm1OQXpYYndkank4NkpWWFk2RHFnL2RGRGZtaWNjeDErME42dHJY?=
 =?utf-8?B?ck5mQnRBZnhOVWtPVWFUMHg0c1FuZ0MyVnBIYnE0U3lzRExSR2JQVHpjNjE3?=
 =?utf-8?B?MFo4NmlIZWdjd1hHTGY0VmIyWjYrZDI3VUJkWDBwajdhZ3g5eTFBdjZoYW5K?=
 =?utf-8?B?R0p6RTZla2hLN21jN1hZSXAvaDBqL2hqNnhyWUlPcEdVRG5FUElINk8rUWww?=
 =?utf-8?B?RThSMkpyZ3lpYlJkUlhzMkxHM291bTdBL0lZcXA5R2ZoTUZiNG03aDFuOTBj?=
 =?utf-8?B?NGRlZDdWTnVOcUw2OXFpaVRHdGFHOUp3MFBOVWxKb2FzRy9TL051ZzU3aHJY?=
 =?utf-8?B?cDkvcnN0OE5VdXFqSmtpMXA3aWFaYUY5MmJnWEpCT2xrZWFhcDBkM2FvQnRO?=
 =?utf-8?B?cEJyWDJGdXU4VlRQZ0lNYjZ0Y29DdktlajJodHBzVG5QZzd0bGVaZnhBMGhT?=
 =?utf-8?B?cy9FVlJtalNyUWhRRDlDOEJ3ZTVwUHZaUU1TRjBzSmxYdUhwMTNMOFp6alRF?=
 =?utf-8?B?L2JEeDZCUzFaclY2dmNvNGNkc0xYeEFoRVJrdHo2UHgzVEFrc2k2MnQ4cnpr?=
 =?utf-8?B?bkpCT2ZrTWx1QUtXTTJENnVTQlBJUXpKem4wS25uendhdUpGMnNJODM0ZkY1?=
 =?utf-8?B?Mk5OMXJrK0ZYQnQwRE9INnpSR0pzZFc5dHhMc0oveXA2b0Rwcm53ZVJRT0ZC?=
 =?utf-8?B?a3FKWHJJcVZxZm9Ca2ZmNTVwMzRCSU1DeFA3OUVMWVRCUXRlekFhMjY3OUJE?=
 =?utf-8?B?djM3cG96SGF3Z3hCdzhDY29RM2ZlMFdNd3NHeGh6VEZiZVZHMStVZzliUWQ5?=
 =?utf-8?B?dzNUQlNRYlhjNng0UkYwWFF1RjBNdjlubG1Eb2RuTkRWK3BuU3hkb3BkYmtu?=
 =?utf-8?B?eHQyanY5SDFXWjFqcEROeFFaa0t4VGRZdWJub3FKZFVYMVBEeEZVby8zeGRH?=
 =?utf-8?B?dGovQXdpZmppbGZ3Z1dTV0R5cThTcTExZng2ckJBNWVOZjJna1lUNHlEb2F2?=
 =?utf-8?B?ajlEdkt4WE9lRHBwTm53VXI1cU40dHpHWDVTZFBGSzU5cUtOV0pFcmoyYkph?=
 =?utf-8?B?WU5YbzZEN1l0OFEvbWUrUWtFOFVtV2J1K0dzQ1Rxd3RNL3NlUHhGL01VYXc1?=
 =?utf-8?B?SDZRVERyNHY2NFRES3NucjhqNy9kc0ovbzFRbGtscU43MXBQaml3V04zTmcy?=
 =?utf-8?B?WFdMMnJMak50R3d5Y3R0TkpLLzZkbzQ4cElGalRVTnhFVWV0N01KbGM0Tk9E?=
 =?utf-8?B?c3NCeHZMaTgrUGdmZXdhVE9pbmwrdks5aE5hQmVxdER0eU5OZ252UUVVYkJu?=
 =?utf-8?B?UHYzTUxQM0xpL3cvSThXaE1BOFhYU1VNMSt4WTlldVhMSzZyVE1GQVIvSzNl?=
 =?utf-8?B?VVdHRnNmNlk3MzZoc0E4STJMSW00Y24xVW1vQjhSOFlINlVCSU4zTWMvZUtZ?=
 =?utf-8?B?UUZLWDhaWEFWek9BNmFiWjFUYW4zQnVRMFcvbXdpWjNrbWN4c3VpMXo0OUxT?=
 =?utf-8?Q?4TWy2RSu+oud6ylLEkTHqV1wy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d5f9df-0bd8-47b1-0d18-08ddaac6baec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 22:07:47.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM9nuSYnQNdyA3aOAA2xhdwYnGBJxRbC7dykAVuG5PGe7GqojcKICtMRb0Zpme30nQDe8GytgfH2pK8F4mRWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

Hi, Yi,

On 6/13/25 09:18, Yi Sun wrote:
> Introduce sysfs interfaces for 3 new Data Streaming Accelerator (DSA)
> capability registers (dsacap0-2) to enable userspace awareness of hardware
> features in DSA version 3 and later devices.
>
> Userspace components (e.g. configure libraries, workload Apps) require this
> information to:
> 1. Select optimal data transfer strategies based on SGL capabilities
> 2. Enable hardware-specific optimizations for floating-point operations
> 3. Configure memory operations with proper numerical handling
> 4. Verify compute operation compatibility before submitting jobs
>
> The output consists of values from the three dsacap registers, concatenated
> in order and separated by commas.
>
> Example:
> cat /sys/bus/dsa/devices/dsa0/dsacap
>   0014000e000007aa,00fa01ff01ff03ff,000000000000f18d
>
> Signed-off-by: Yi Sun <yi.sun@intel.com>
> Co-developed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> index 4a355e6747ae..f9568ea52b2f 100644
> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
> @@ -136,6 +136,21 @@ Description:	The last executed device administrative command's status/error.
>   		Also last configuration error overloaded.
>   		Writing to it will clear the status.
>   
> +What:		/sys/bus/dsa/devices/dsa<m>/dsacap
> +Date:		June 1, 2025
> +KernelVersion:	6.17.0
> +Contact:	dmaengine@vger.kernel.org
> +Description:	The DSA3 specification introduces three new capability
> +		registers: dsacap[0-2]. User components (e.g., configuration
> +		libraries and workload applications) require this information
> +		to properly utilize the DSA3 features.
> +		This includes SGL capability support, Enabling hardware-specific
> +		optimizations, Configuring memory, etc.
> +		The output consists of values from the three dsacap registers,
> +		concatenated in order and separated by commas.
> +		This attribute should only be visible on DSA devices of version
> +		3 or later.
> +
>   What:		/sys/bus/dsa/devices/dsa<m>/iaa_cap
>   Date:		Sept 14, 2022
>   KernelVersion: 6.0.0
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 74e6695881e6..cc0a3fe1c957 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -252,6 +252,9 @@ struct idxd_hw {
>   	struct opcap opcap;
>   	u32 cmd_cap;
>   	union iaa_cap_reg iaa_cap;
> +	union dsacap0_reg dsacap0;
> +	union dsacap1_reg dsacap1;
> +	union dsacap2_reg dsacap2;
>   };
>   
>   enum idxd_device_state {
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 80355d03004d..cc8203320d40 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -582,6 +582,10 @@ static void idxd_read_caps(struct idxd_device *idxd)
>   	}
>   	multi_u64_to_bmap(idxd->opcap_bmap, &idxd->hw.opcap.bits[0], 4);
>   
> +	idxd->hw.dsacap0.bits = ioread64(idxd->reg_base + IDXD_DSACAP0_OFFSET);
> +	idxd->hw.dsacap1.bits = ioread64(idxd->reg_base + IDXD_DSACAP1_OFFSET);
> +	idxd->hw.dsacap2.bits = ioread64(idxd->reg_base + IDXD_DSACAP2_OFFSET);
> +

The dsacaps are invalid for DSA 1 and 2. Not safe to read and assign the 
bits on DSA 1 and 2.

Better to assign the dsacap bits only when idxd.hw.version >= DSA_VERSION_3.

[SNIP]

Thanks.

-Fenghua


