Return-Path: <dmaengine+bounces-4279-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1953A282D0
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 04:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B693B1886961
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 03:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7C1E505;
	Wed,  5 Feb 2025 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FRm8IRIs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D425A654;
	Wed,  5 Feb 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726278; cv=fail; b=FR/uag0u6TderaudiHfhZpB5Y/JIcbS/NI8F6CQCicBahY3tpDE0fquiTgpfrlwfV+f7M1nJ24P3ceHi8ewLGAbr+W4nSfEfO9o+C23pzZKKq/YTiA/wTRulzduyODZEQn4eq5PpBB5+2cfsbxFammvBSqOk+zzSIaaogtITs1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726278; c=relaxed/simple;
	bh=WqAzt5DOCcDcAxT55KIF7Q93soGRe91TrRHt6CkJD6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kOlSTq1oY2ZQmj4CSTXxitQ/g75geiHZzzqfGKHDLNwssHh3itS/E3+zUOB4FnWtPqBReiIRonfe/5RN/+JQZe/2J859iq0cveByO3VNnEDtEtq37e0/+9Y7OlwTybEMFPNBRzGP1KiqJB/joeqSc8mmqbZn+gRuvkSeQteIQtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FRm8IRIs; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnWQ/PFFQFnHC/ffJ+4ktgYF0yhwBxcmFJOSGZaJ/4o9DsHx5LiBLpd86yOcVRirVOQ/IPdqRpEnUamSzJri2OB8i5FGeM5ARDcZOWnti0GAp9MldnPMK7wDXxkIZw+97lBK8cp5pvKJEd9kkV2XDq0keHff39FRasjOMCscl8Loy2A0BQpSG/Z33c6n7+ndP+CnOVq4mwVKiyvg6FNft3L6pgg2zjBabJIGCJ+2W/03gj7nkQQKkV6i1+jPcVhk+SAAB4SjRHaAS58z8M/9JRu5iUv3xoLJcr0YPns+xr/s8sIZWJqLTWwlcmMq79p11ent3vx0E2EuVXDZ0o56Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtuBW6PYhOqF/6MNrDIS5p0M3CZdMwR7T5i29d0vNW8=;
 b=itOhSHjn+waLKRkSyeAl/w/iVGRlCJzkoZfR1C0b+QRZA6YUrsTlikw0UjoYrfehcEllJgQJUu49ELmm1n+rmDNH/7911tFf/Ir622hK09nkecyN6XmWf09LFl5Q2hGT4KXxochhWQNdGlq0PhxVhfVIasJkP13Vm0gDio3l99KqFBXV8IMjmH0nsSDofGf1FD3G+hALt6yN9lO0RT1J2QR3JvcSc5BDJRMiu2K1Ilq/geYw7FYu9mdusuBSwVm5GYeyzUas+1G2Q439Gv5zSUA9q6akOAlCPIxkRg1DNt1CH5qaboypqthjakaYdNBjf+BdoUOV/y1rRLwr/KZqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtuBW6PYhOqF/6MNrDIS5p0M3CZdMwR7T5i29d0vNW8=;
 b=FRm8IRIsWG+cjrmNSMst44YTV0V56QS12vNdFUmRf0WYL9SB7odpL+Rl5PKVw10E0SO2SMobDGeNK7GF8G7eNAcdl24/jmfGSbJ7qnNDP6Pi8CPNC0BDyZkG0GW2s87MTdxGDa5CqyzuXdDe9qM2dvCS5iNNLcY5PJ+oyn0NPW3GJy9t1xgXTDM0u1b8dqa2G9oOw4hkKRaPZeEJbRl2XtSmTIMmKA1pOAuml8uF0OQKcUalbnVbDIrax5B4MK9bvOTXInPWQxEHT1Gvnzdb1JJx4g+tGdDbvFtb9zg6K0NCLarEo5TVRh/2iAakdY4RdpPOb8SV2mYn/u93njfYXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 03:31:11 +0000
Received: from DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b]) by DM4PR12MB5101.namprd12.prod.outlook.com
 ([fe80::8a69:5694:f724:868b%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 03:31:11 +0000
Message-ID: <2f438f0e-e627-4e50-8f3a-9c3a11df707d@nvidia.com>
Date: Wed, 5 Feb 2025 09:01:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
To: Thierry Reding <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
 <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
 <84382200-e793-4e9a-b25a-8dc43e7a8bd0@nvidia.com>
 <52n364alceto6tgitbnjbfgtrk2lpe5ipztxi4abnuikjwgnvk@i6irrkj6fqbb>
 <c5e7e8a3-2e8e-4d68-8e06-a7a3f7fc451e@nvidia.com>
 <uboixhzbccbt3ugdv6z4wsyyn4cpviw6okjwmfeqaslecotgpj@47afypfx5xo7>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <uboixhzbccbt3ugdv6z4wsyyn4cpviw6okjwmfeqaslecotgpj@47afypfx5xo7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To DM4PR12MB5101.namprd12.prod.outlook.com
 (2603:10b6:5:390::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: a335ecd5-1e57-4aae-7d0e-08dd4595894c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S291OGtLZnorUXFvMTFEcUx6bVhTY0wzNGFnM2RZbFpXcjZRWHczeXFiYXV6?=
 =?utf-8?B?enZ5UlRrMVJyaXhoQlVRbkoyUURyWU5ZT3hLSzFwQXZkeEZFVkpadFlLMlRW?=
 =?utf-8?B?OGtxV3lrTDB6am8wOVBBNnc0TlJRbVpHWWQvYWNkcGhTODZwUjk5aHoyZVVD?=
 =?utf-8?B?cTEybEVLU0FIbFZPd0hVRkYwdXErRHErem9xZ2pBYWJ3QXpnbTVTcGZkNWdu?=
 =?utf-8?B?K3VnK05taTQvR0ZzdzZ5bXd4NGhaOHNXWW5EMElNUjVZOW1IRGRUQXk0R29M?=
 =?utf-8?B?ZkRUMTFrZXpEOHY3YXEyVU85SUJPU0lNUytPcldOMUFMWU5COGMyelpSY00w?=
 =?utf-8?B?dnQ2Z0NTS0RLZEYwU1kyVzl4bDhQRDNQaHFjZGFTeUNET0JuaENEelQ4RFd4?=
 =?utf-8?B?c2huQ1hUbnQ5aitsYWJFOTYyWHFrR1BjRkpuUG1mSVJXaXR5ekFGUVFsdURD?=
 =?utf-8?B?L0FPb2ZFbjVKZTdWNTJWZzJITGJrUHpVMjNEelF6RnNldWE2MUNlOHI4Zm96?=
 =?utf-8?B?d2JIMDVyZVdMS2gwYUZJdEIvYW5raXNMRmYzbUZVbVdFd3NJNy9JVS93V0hj?=
 =?utf-8?B?WXpzUUdNMWdRL3ZOZW5zdTdJTkZJOFd5M3pjQllZMHpUNWVQWFNnTFdhbFdp?=
 =?utf-8?B?UnYvdDhyYXh3Y2o5V1RUdm5aVEo0cW0yaVlGcWwxQkxBSjlPajVIbm5uaUVq?=
 =?utf-8?B?WXdwWEhMNnlweEFxdXdLMytEWUJaZGM2MHhCK3BybmVFcG9QcXoySE5CMWxT?=
 =?utf-8?B?eVQraTlRbW9DcVY5ZWk1N0FrZjlGZmZCUzY4TDdvdU9ZT1pYamwweTdpWW1h?=
 =?utf-8?B?MXlWNENUK0FsNXRMNng2UkhFVWlvVFhrNjVyMVdsOHFrTy9GazJuS3RWMUxX?=
 =?utf-8?B?emNpZ1NqQVdUcnMzTytmT1FKTnVxMnVwNGVkRVRNN3JFNUxLWkRFL2tkNkxY?=
 =?utf-8?B?UFQ3eHJFNzQrRjBEa0NvV3F0MlZjWkJiTEMxYUYvd2lodk96US8vazhLdHY5?=
 =?utf-8?B?WDBkQkNvajNBQXc3RmUyRlFEZ0Y2M0xYLzF5MWNFMkI1dERMNWRqUGZxS0gw?=
 =?utf-8?B?M3l1OTUzaEtJS1V5NHBsMnJmR2Nqc0lnWUZhanJkY1l1aEhzVEF5M2cyTzE2?=
 =?utf-8?B?S0l3L0dPOTVGMWpiV2NZUGdhYUNFaVBiVTg5ejIxdXk0bTF4Y29LeklTNkcr?=
 =?utf-8?B?V1FGOC9xaHlVaXlMbWlBak9KREV4R3p3ZFNjWU9MUDZsU0VqWjl5cFoyUGhS?=
 =?utf-8?B?UzRseW5FMmJ4TXJZVjdDQWp3WEV6bGs3cklJY2J6K2V2TUhuK2w5MnFOVWZt?=
 =?utf-8?B?R3Ivb1UyRTNvWExRSHl4SHZWT2oyekx4b3RMUllza3pvclN4ZGI2K3ppZ3k2?=
 =?utf-8?B?MkdNVVpSNmkzYWU2WHVaSnJNMTd0Sk5LU3R5WUVVN2ZqQmRGQkRMMGpxUFhi?=
 =?utf-8?B?M3lFQ2VVTzF0aTNhUzE3NjRaUkpTblVlVEZOT28xK3FEU1E4VUl3U09OY2J3?=
 =?utf-8?B?NlhqRHh0c01WRUlrbVNXMmpwU2hWWHRoa1UrWDA2L0QrQm9kelRTV0loVWpB?=
 =?utf-8?B?a3ZUK3kwRzFEQTVJSnpCK2dSbWNmNmZMeUlOTFNrOTlZTjk0Y2VVZ09mQTFQ?=
 =?utf-8?B?MUFHRXFGQ3FBRHg0SUwySGFNbTFheXZhWjdNOUxvc2RjaG1HK1RYSW8wL3JV?=
 =?utf-8?B?cTJMU0VOeHlDMW9YSC8vd3F3L2RYVk9mZ1djU3NPb2hLUzBqK3V2d0owMEVO?=
 =?utf-8?B?NVE2U0k0bDdUUllsL2Y0SVZIZHB3S1lkZHRHRUtObXVySmd0Mi9YSzJJelEz?=
 =?utf-8?B?Q29IeUxwVWFibUR5c3EwWjYxLzhVZndYWnJKU0YxU1dLR0R1S0NkalIyZjUz?=
 =?utf-8?Q?3wux2utRNU1yg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkNaMlVmdjlGVXNaWS93T3JpMytKWTlJUUQ1U3prSDI5aEdvS2pVRTkvWWZ6?=
 =?utf-8?B?ZDhLUUFOVTNEZUNwRms1TEVqcU1meTFuVHlTN0ZrOThOa25hQUhueWd4NjQv?=
 =?utf-8?B?ODFseVBwdk9MUTFxNXJhTTRvQVo0Zk5kd2FIc09HRG1UcmlvMnE0UWhYbWtk?=
 =?utf-8?B?WWtsbVVmc25naG8xVzNLWUNva3VhamVic2UzRlNMTERxNC96bTZRcGNJci9x?=
 =?utf-8?B?MDBHZ0RMcnZTUGE0QlpqSUJXSjdlT3lXYTBILzhrTktwRmNmRmVRQmNZWGJN?=
 =?utf-8?B?T2ZZN01nRGZta1RIR1BWekVObVEvUE92R2ltUnJtL0lLVWx0L0FHZmRTQnJJ?=
 =?utf-8?B?WEZ3RDJzQ1p0V20zWThyUE1xVkxYS3dHekw5c1EyQ1dqU2dSdkhRTkJOdGRj?=
 =?utf-8?B?QTdjS1VscXp1YTNsQVYxZDZWUnhPYVRFNGloQkpxNExLbmlHdllseWhuaVpk?=
 =?utf-8?B?cVBEQ0dkZEV0cG9OeWlBaVlwdjJVN0xUTjRpRllmbzRuYTVFNS9EbGZuNGY4?=
 =?utf-8?B?N0lkbndRNnlzaktHaVBNMGxVaTdqOFVxV2FRdXJycjl5Y29RcWpURktnNmRS?=
 =?utf-8?B?U1pJS2pxMUlOdU81cHNLK2JvWGwyU1FoZXdjUG1HTnBsMlhjL0ZhY3IrM1FO?=
 =?utf-8?B?eWNFL0h2RTVZYStRU0NiTk9vVmZuNnhadThPMFBaSWJpaDY2d0o4dWx6UGVV?=
 =?utf-8?B?MEFYTEswVEp5OWxHaUFkeElEYlRkdTdNY29PZ2VsMG1jMTUzUnFxcTdLaGwv?=
 =?utf-8?B?Y3FFcUFLNGxKYjRPaDZMelFYbzZxWlN4WmI0OHJhRDk5Uzc1amlWMldUcE5O?=
 =?utf-8?B?ZDAyNFFyNTZyR2JoUkU2bUh3cENTZE0rU3Q0YW9iMHl4bDI0RkRHZHF0a1Fr?=
 =?utf-8?B?RHJKRUx1NVU0OFhpRmluQkVrWVQ2cWtBbFVZUStkQVhEbld2T050UmtDWVkr?=
 =?utf-8?B?TERFKzRKMkhEY2lMeDJCZHQrNEtDNEp4a0V0QkJvMUl1dmM0Y2g4ZXdFay94?=
 =?utf-8?B?ODdTSks1b05GcDU3Z3YwRlYzb29DVG9yeG9mNXZRLzkyeEZXakRGQyt6aWN1?=
 =?utf-8?B?QmhzNHBwb2FpZlZFOXY2VXV3WWJZeDBEUE5oTGhEeW0vVjhIMFUvVENpTkRB?=
 =?utf-8?B?WHhxWGkvOWdTbkcyUXAvQzUxZlA2OFpoaTAzYnVoN3RnWHN1bTV5alIrcDNP?=
 =?utf-8?B?dVNTNllrY3prNUpMSHlieHJsQ1Q5YTNDSzhHSXJ5M25OQ3JNQ3lqek1MUzAr?=
 =?utf-8?B?c2JobDVwK3I4WE9YRVRHSmJoOURJUnBrZVRSZEd4emxIdjRIMnFxV1hkbVJj?=
 =?utf-8?B?UzllNytBYUtQRkJpR09VSk9HcnRGdTZ3RnhqbEVaSURnbkQzKzZnRFFzYVVv?=
 =?utf-8?B?WjJGTVZlVjRUampkdEUrOXlnRXFQN3V4L2pINVFsSVUzMmtZcnB5K054RkZl?=
 =?utf-8?B?NzhKVm5Gblk1NlNpVTQ3WlA4c3hIUktHNnF1ZTJEb2NaZUNZQUg0ZnBtQi9T?=
 =?utf-8?B?SVVVRDQ1WkZ4YkVBS2pWTG1CNTNSYVE1ampRWkZrZDRCMkJzanB6aWx0ZFpK?=
 =?utf-8?B?T1hnaHhZTXhpdWxHa2pQVHd3dXhLTkNYWS80T2xPWC9jajdZWUNTZnozbGdM?=
 =?utf-8?B?RXBYYmMzckVoSDc4K0lSdnJrVUNjNkF5U3phc0hZZEFLTnB1WWhvL0RvWlpm?=
 =?utf-8?B?TWU3YTRIejZQdFh0SkFXNTFhU2V3UUh5T2FqVTRhMFlXenMrUytjUVZTMkF0?=
 =?utf-8?B?MjZWNjdiSHVURTZra3JGV1BxbEZvSTFxY3FjWWQ2S2ZITmJwS3JjbDNENVBC?=
 =?utf-8?B?RFBxTVgzeTFvRUM1TzZycWxUSkovYVZVTDZGODJ3VlptcytyU3ZydnIvOWRB?=
 =?utf-8?B?WDB3d1dSREVhVThSbnRETHo1dkFXTXgzV0huc1dXWkNlL0JZcE1Sa1J2djQ5?=
 =?utf-8?B?T0NyaVZSbisxVmJjZVQxM0prYkNOTnlnVnJIRjlNN2FJQSsxeHg2UU5aSWtG?=
 =?utf-8?B?emRGNWZHYU1obk9JdElYRW13bkJEcTk3c0JvYlNPSnlhc2lwVUIwNlhwS0k1?=
 =?utf-8?B?OFBXNzJBVHYvMTFsSUNTaHhmSXZ5aWg0QThDN2hUaVV2cW9VTVNIaFNTdGJE?=
 =?utf-8?Q?ZpWnMpkPiq0JrWcidTycizNbt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a335ecd5-1e57-4aae-7d0e-08dd4595894c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:31:11.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tImSuDJWuJ1UPLwoDqDvE11VtadhLfC2Wu8nYp1K94lQgw6NdBKsp8L86tWD2GTVgOjJOo0+Kxf54sn7R8ehGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318


On 04-02-2025 23:28, Thierry Reding wrote:
> On Tue, Feb 04, 2025 at 05:18:46PM +0000, Jon Hunter wrote:
>> On 04/02/2025 17:03, Thierry Reding wrote:
>>> On Tue, Feb 04, 2025 at 10:13:09PM +0530, Mohan Kumar D wrote:
>>>> On 04-02-2025 21:06, Thierry Reding wrote:
>>>>> On Thu, Jan 16, 2025 at 09:50:32PM +0530, Mohan Kumar D wrote:
>>>>>> Kernel test robot reported the build errors on 32-bit platforms due to
>>>>>> plain 64-by-32 division. Following build erros were reported.
>>>>>>
>>>>>>       "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>>>>>>        ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>>>>>>        tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>>>>>>
>>>>>> This can be fixed by using lower_32_bits() for the adma address space as
>>>>>> the offset is constrained to the lower 32 bits
>>>>>>
>>>>>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
>>>>>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>>>>>> ---
>>>>>>     drivers/dma/tegra210-adma.c | 14 +++++++++++---
>>>>>>     1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>>>>>> index 6896da8ac7ef..258220c9cb50 100644
>>>>>> --- a/drivers/dma/tegra210-adma.c
>>>>>> +++ b/drivers/dma/tegra210-adma.c
>>>>>> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>>>>>     	const struct tegra_adma_chip_data *cdata;
>>>>>>     	struct tegra_adma *tdma;
>>>>>>     	struct resource *res_page, *res_base;
>>>>>> -	int ret, i, page_no;
>>>>>> +	unsigned int page_no, page_offset;
>>>>>> +	int ret, i;
>>>>>>     	cdata = of_device_get_match_data(&pdev->dev);
>>>>>>     	if (!cdata) {
>>>>>> @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>>>>>     		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>>>>>>     		if (res_base) {
>>>>>> -			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
>>>>>> -			if (page_no <= 0)
>>>>>> +			if (WARN_ON(lower_32_bits(res_page->start) <=
>>>>>> +						lower_32_bits(res_base->start)))
>>>>> Don't we technically also want to check that
>>>>>
>>>>> 	res_page->start <= res_base->start
>>>>>
>>>>> because otherwise people might put in something that's completely out of
>>>>> range? I guess maybe you could argue that the DT is then just broken,
>>>>> but since we're checking anyway, might as well check for all corner
>>>>> cases.
>>>>>
>>>>> Thierry
>>>> ADMA Address range for all Tegra chip falls within 32bit range. Do you think
>>>> still we need to have this extra check which seems like redundant for now.
>>> No, you're right. If this is all within the lower 32 bit range, this
>>> should be plenty enough. It might be worth to make it a bit more
>>> explicit and store these values in variables and add a comment as to
>>> why we only need the 32 bits. That would also make the code a bit
>>> easier to read by making the lines shorter.
>>>
>>> 	// memory regions are guaranteed to be within the lower 4 GiB
>>> 	u32 base = lower_32_bits(res_base->start);
>>> 	u32 page = lower_32_bits(res_page->start);
>>>
>>> 	if (WARN_ON(page <= base))
>>> 		...
>>>
>>> etc.
>>>
>>> Hm... on the other hand. Do we know that it's always going to stay that
>>> way? What if we ever get a chip that has a very different address map?
>> You mean a DMA register space that crosses a 4GB address boundary? I would
>> hope not but maybe I should not assume that!
> Not cross the boundary, but simply be beyond that boundary. The current
> check will falsely succeed if you've got something like this:
>
> 	base: 0x00_44000000
> 	page: 0x01_45000000
>
> or:
>
> 	base: 0x01_44000000
> 	page: 0x00_45000000
>
> For both of them the page > base condition is true, but they are clearly
> not related. Of course this would only happen in the hypothetical case
> where there are multiple instances, which is not the case for ADMA, but
> for other devices this could happen.
>
> So I think it's always good to be prepared for those cases and do the
> right thing regardless.
>
>>> Maybe we can do a combination of Arnd's patch and this. In conjunction
>>> with your second patch here, this could become something along these
>>> lines:
>>>
>>> 	u64 offset, page;
>>>
>>> 	if (WARN_ON(res_page->start <= res_base->start))
>>> 		return -EINVAL;
>>>
>>> 	offset = res_page->start - res_base->start;
>>> 	page = div_u64(offset, cdata->ch_base_offset);
>>
>> We were trying to avoid the div_u64 because at some point we want to convert
>> the result to 32-bits to avoid any further 64-bit math and we really don't
>> need 64-bits for the page number.
> Well, we can always safely cast page to u32 after this, or after
> checking (in the second patch) that it's within an expected range. But
> then again, do we really need to do 64-bit divisions using these numbers
> again? As far as I can tell this is only used in
> tegra186_adma_global_page_config(), where it's multiplied by 4, and that
> should work just fine with a 64-bit variable. But it's also fine to just
> cast to whatever ch_page_no is (unsigned int). That's ultimately what
> lower_32_bits() ends up doing anyway.
Thanks!, will resend the series with the update.
>
> Thierry

