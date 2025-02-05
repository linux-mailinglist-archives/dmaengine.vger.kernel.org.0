Return-Path: <dmaengine+bounces-4289-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAFA2894B
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44C11622A7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44422B8B9;
	Wed,  5 Feb 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dgZ77y9E"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295D22D4ED;
	Wed,  5 Feb 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754948; cv=fail; b=mZ9t9hVb+LqWFaEvVeHXWrGs72XT19i0fiqkbjbAN8Df1JRSiN+qOFoQZK7L+ZN1Kvoaeb6WuNPU8i/mGxI1fAH75Ry+F8GJ3Lsoeih3o8ixzRlxL8AWrE4+OD6GxYtDxIqpm5EykQTYmF5WN5zvRkebv9oEZZVvdYXNgCj7Fv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754948; c=relaxed/simple;
	bh=GBUab1c1/OuQTvSCJ3eU0YHFGy/IAkB/JcbEjrx+CMM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6fjxzjuQ1xZ0VmoqNYz/uWcRJu8Hbn9g5NgP+ZKIXegjBPJTLzDqEg6aJp/T/Fg6qXjxvZ0+Ulk66vjYRKmpziRiKBVr0mRSGarKuTKj0n2nhKGp8CMYnEFT2cVgtSKWrSp90aZbQgrx2w8vhEfqzeqLqWWYI/sSEG/wdXspMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dgZ77y9E; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtpguxdkUowtC0ocCUPrsburOFPqrHCB0SJCSIeG556a9lwa5walTSBqhNzon8bRr2FrC9AYr8VcoNRuQwTgCTXG4DnyHw9SIyHLU3Vj8yUH9cts4gSIMQ9jkWA+BSVQczUBoxBopaR7SsCOw/YrlmcZpJzh3jHm+Tu5fV/M/XNzea0Tc6iIs/oG1AvuMvwJMNLBALeAYBF1ftssnUp3K2k8EA87Dn5h473zZ9gNa47uW7t8XoHVvLPix/O5lW7spDksq4DuKiHAMTaI+CaTv6AYIqtvACW7NGV79OQO3/nrX3X/jEoEn0EWf2NrR50VqE1mILVHGv6hF3/gRier6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t7MHXmtAKGf3hlfnF5/+3e5Nt6lcovoC0B2ZqWfZKc=;
 b=aWme1MKHV7yis/OdPkQXTEfLNjukdZz504TEppBaIDt2NcS6LNKxRTUp14NikW9dt86+DxIhVlpAAOxGmJcz+lLm6JDTJtb9hdG82FIuCtvEIKTOSCzmEQxrALd+LY+jlFCnViNyt5HEmDllZ/g6G1DAs/0X7nRnbDWqGfly/gE/HWFlRz8hUNJ5SPZp95JgcSM5vSqB1UYQfgsTKNG4Ao2PkoYDuqVrUZsrbCRMHAY0kzZ9lMnXxE6ThuAwcJXMXDQ0+fsGnkfMYinSGb2q+kBikfXxp0O+nYC0Qbnq8d9dLpjCLpCv2mVnOH1jQJucsmXE2nTFB1ak28K5LBnH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t7MHXmtAKGf3hlfnF5/+3e5Nt6lcovoC0B2ZqWfZKc=;
 b=dgZ77y9ESR6SeUPw/yeaONTYwCib9CngPlkQ+M3E1Y3xqKvRXn1yFRRozeSKos+4LiqsWbHG5JD0cTgaSjlfo/A+w3L5sIqymcbg3oIQvuqxs/ImneSkD/JFo4xqknrcJqhxug6dVnGyqUdh37dvkY/+VG1jy9PySpawbd0zRNuuh2J2IfI105dIcbH5altU+wIqxgqn5uBfw+dgh29d7Uo8DSZZny0X9awIg/WZw6G5oy86Yrwy5sG1z41ZgAn8jeGrLZ2pV8vL80omy/Q5ZLZrIQ/w2m3QEmvXWLahIX8TJh/kSIHrloLEFeUt4xh5inVRk6A8eWW5g0aszKq/fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 11:29:03 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:29:03 +0000
Message-ID: <5fddf99c-c0ad-4652-82d4-d5bb47fb63bd@nvidia.com>
Date: Wed, 5 Feb 2025 11:28:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
From: Jon Hunter <jonathanh@nvidia.com>
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-2-mkumard@nvidia.com>
 <dd094508-482d-4ed6-b9b4-77607fd18f4a@nvidia.com>
Content-Language: en-US
In-Reply-To: <dd094508-482d-4ed6-b9b4-77607fd18f4a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c34566-4662-4790-7f54-08dd45d84b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnMzU0J0ZEwxZkd4NWNMZGJ4QS9pVHFvNjVpcytaSzA2UC9BYjdZamlscVBN?=
 =?utf-8?B?OHIrNVd3bjhEd0hJeXMvZDBUOWJsTDhuQm12eFg0QU1QY0crTE9wT2s4TXNq?=
 =?utf-8?B?b1VrazRsU1pDcDdyallRUGlxRGxOL094aldqbkFCQXE2M3pnZUoxU2dsT25x?=
 =?utf-8?B?eVBrMG9rQmdkSEx0Q0ppVGdsM0pUNHBVeGQ1L3NROVJpK1ZNWmRWREdGWmtv?=
 =?utf-8?B?WFRNZll2TmxFRG52N3FmVjJqQWRTUmdsK1U5TU81SE1nZXIrV1hrWDdPU2Fv?=
 =?utf-8?B?YkV6MHRNZllra0NnMzFIbjlNSHVCTVUvcjJteVBnWTFDcGFCcXZnZDliZG05?=
 =?utf-8?B?a3ZIbDBLWVRjRzJWRjJ5YlBiRTBlS09RcWNuMUtLaUo3bFFkZ0p1ZnhIWkNS?=
 =?utf-8?B?MkFTRG5uTkJLbitDT2plV3IvNjh2N1IrdXQ3RW01UGhGWWZUYUtvSTJGdlVn?=
 =?utf-8?B?MEFqQ0M5VTVzT2xzdDlJSGlqZDhmYk82aERDaUNIRGU1QmtZUHhWMUlZUURD?=
 =?utf-8?B?Uk9Za0FTYUsvZUVtNVhIQ3M2NHhqelVDL2xBMDlCMnZUeHc0c1ZLSXZVWmxJ?=
 =?utf-8?B?bjlXbTJQREh5cko5ZmpHVUx0T0Ruby8xV2dJYUJqYkdGbGY3N0VjK2gwQ09a?=
 =?utf-8?B?bjFVdGt5c0tzTmsyaFJ5TVFNSnVQaWQyN0haM1JYUWJhQlM2UUhOTlFLdC9m?=
 =?utf-8?B?dEtsbW5ING4xeFBMRmZrdldORjNKa0g3RG9YcEZLeEpOM2VFL2FDTU4vOHZM?=
 =?utf-8?B?bmM4eDFTeGJNTTFwdGVwUGFqTFBZSWNTZDU0OWZRbTRsWHczZHpFVjR1Q3Nk?=
 =?utf-8?B?YkhYR3lwTWRiVGJnQ3ZwNGFIWTAvY2JqU3FXZzFLU0VHeDBXYmQ5YytQMnF0?=
 =?utf-8?B?ZnBmZmxkOFpmUzhWYkl0VjNsdXVjaTk4ME9GZjJXZUtPRmhzbHovaXQrdTJG?=
 =?utf-8?B?SFVtbDZuaXVJVmkwckJ4dFVzcC9LTXJCZFQ5TDVRMmIrY3Fxbk4ydk5BV0F1?=
 =?utf-8?B?SnhzUVc5ajB3Kzc5M3RNT1NCRWp4RU5vUmF3QTZaNktWTjB3d0RwRVNrRXkx?=
 =?utf-8?B?N3NwbGx3LzRaSlZ5UjVib1AyYmxKZmRzdXpISTlzY3o4RkE2cTh5MFV0MkJH?=
 =?utf-8?B?UCtZWExXUEovdEFoZ0M5bkVFd2NHVUF1eTlKRnNVYVlOQXQwWXFKc0JtMEpR?=
 =?utf-8?B?MWpmMzU1cTJCdUI1d2pDK1ZzQklmZnFvaVFiSTRHSkdPTEVrRStNVjdKOGZI?=
 =?utf-8?B?WFpEeUFRazZQYlUva3IyNHBhRGc0OWhZY2ZDM01NYzl6TXJSYy8vZExCRWlP?=
 =?utf-8?B?Z2RuOWZqMEloV2NFY2FQZmV5ZTZEZ0c1SHcyY3dhN3pVVzczbXIzOFNBWjR4?=
 =?utf-8?B?MlVxd1NpbmgrZk01ZWswUjNIOStpMTdDdEFTK0lFSGRicEtZRlozQUhaZzhG?=
 =?utf-8?B?TWRKRHo1TTl1bkkrcnVpK2orTUdrVzhnOW41T2x1WmFvajdoMXZ0Y2RDN2ls?=
 =?utf-8?B?UC9nVXQ5MGhqeUNCd3Z6NW5mR2Z1OFpTSFJSZGxnUHRiSzVsT1YvMVdqWFlG?=
 =?utf-8?B?Y1pTQlFlM25yQlQ2NHBiRzllNXkrUW9xQm5kQnJHTnIvemFSaDU3eXNuWWlW?=
 =?utf-8?B?NmZBZGlVTHRSUlhZUDhMSFJBUGs2MllFMVR0Q0N0eHlmUzloTjY5Z1l5UGFL?=
 =?utf-8?B?OUIxZDZxU3ZrdWswZXpYSUNra0hlL0k4a3FxcGc4R3NYb283Z2Fiamx2SzZh?=
 =?utf-8?B?Z0hEdFJ4ZFd3UVN4TDZCS1VvNGJPdmVpRzIzT0dWYXFHZUgrTEkzeTBOVUs5?=
 =?utf-8?B?Vmw4SWZ3VWZjWWZ5OHMzV1FSM1dyS29FaFJocURSZTlCa1hKTVlVWUdCUS8r?=
 =?utf-8?Q?2cXpY2e56iRBk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVwdk9hOStBbzJTNXd5eW4yaHV1a0xYUkJaeUk3ZjZaSGtjV0U5OHlnNytS?=
 =?utf-8?B?WUg2eWVKbFc1WU5wMnF6NXNXZFJJejRqVnc1TmhmNkFVWjN4VGgrK1BnMU1U?=
 =?utf-8?B?TFhxVWN5OC8zUGU0Vy8vRFBhb2NMZExsVGdqbytydHdvUlp5OTVneVF3ckMz?=
 =?utf-8?B?SnFpVnJhdDkwazYvM3htc1BYN3NGdXZwa2FZaFdXOE1jNXZZdW1iUjJSbVR3?=
 =?utf-8?B?YktjV3ZXZ2lhcDVWcFNDTno4VG1hU0pQc2dCKzVoN05SV2JHNEx5VDFuT2pB?=
 =?utf-8?B?MFg5Qk14OWpOTUJ3NWhHT2VXaXdwMC8zVDh2RGtjR0dPdVc5R1pvOXhqTnY1?=
 =?utf-8?B?T3p1SnNVZ2QvS1daZ1Fnc21NcXJGVytXL1ZGTzk2M3dsNlFEdnZPcnhrUFQw?=
 =?utf-8?B?QkZmK052U2VjZ0RrMWdiem9JRytlc3d3TVNOV1RENkwzajZSL3dDa0ZpbWFI?=
 =?utf-8?B?cG41K3A5a1k4RkRrc3dMSWIxSHZTcW9VMUorSUlkZFhndEZSNmx4VHl2TW95?=
 =?utf-8?B?R0EwOW5xNEF2RWRidnYxWWFWdkVDcFFMRWRrLzc5QS9SSkFQZ3k1ZjZJZFFL?=
 =?utf-8?B?NUdKVE1GRUpLTEV1RmlVcSsxcGhMZlZUV3Q1UVJROWk3cEtkOHhhaXZyRXRV?=
 =?utf-8?B?OFY2UUZGK1JKc2JWai9wOTNXQWpOUFhCYTZPa09xNW4zTlhMeTFJcnBvRjg0?=
 =?utf-8?B?RWJoZENzVk5VS1J5ZVhZWmhKQW5CaFAzc3I1RW9halFQdDVHRTlsVlJ2WmN1?=
 =?utf-8?B?UlF0aDBtb1NxQUJjeWVPMEVQWUtFaGpkWC9Rb1AzbnA1ZndSY3FBbkFlN0lr?=
 =?utf-8?B?U2NFaGpINGdldzNlRHVBb2h3TjZpMlpBWTczUFZzUjdFallQaVYyakFBVUVx?=
 =?utf-8?B?bUFZSDZlQ29kWFdSWVFPTG05NFh4RGVNcFU3WEl6QmZaVkVOZk9WeHBvUzRJ?=
 =?utf-8?B?T0p2a0FUdjV0c0l1TVFkWmd1TUFhc3E5cndZRmEveXZOanlHZGVxRkl1NndW?=
 =?utf-8?B?NGpiOENDMFJhRUdONE1TOTBjd1ZTZ24vMGdhdWlrUXJ2TmtrUm1xWk95Nkxl?=
 =?utf-8?B?bk5qNVUrTm11RFRIOEpyeHYrRDIzWU5MYjJWbTJTeGhTNXlhZmJzYW5ZQWZK?=
 =?utf-8?B?UllxNjhPOEdvZ2RhUGN6THhjekF6NExZWi9jSXlsK05CWi9wR1JJTE9uVERn?=
 =?utf-8?B?ajhoNmxGcEhIOUJnT216N242ODhzRFZNSENaMTF4OVBWZVloek5NNjBiSTVI?=
 =?utf-8?B?aE1ETC9WcnVsTWpiU1RiczZWRTZuL2kvVzZPR1pjOW9uUXFxbHh0aGpDNVNE?=
 =?utf-8?B?eVluYVdCVEdlREZVay9FakZIbkJCNlJGVXVoaFNzdzYrZStGaUtzREIzbWZC?=
 =?utf-8?B?ZzdQeS9DejRicERWR3NLREtPVW9jUit5NGptN0ZUWGtDcmVNUGJRK0FJZmVv?=
 =?utf-8?B?Zk8rM2RhUUJmb3FtNVRQbkhlR0w4dWQrOFgwakVaRXpFTEwrK2hVeE0rZ2JU?=
 =?utf-8?B?WFpocG5GeFVacE5uT1hsWUtib2JEdDlmRmE5VWxCQVRVMzh4cFdncjI0cm5w?=
 =?utf-8?B?MEUwM0pqbGZGY3RHcHlwOUhxMllDVGw1TDNjY3g1U1hBV1hzRk94ZldNN0hl?=
 =?utf-8?B?VWNOVFhlM3ZVbVdpN2J5MDdoUTFjTWVPVis2OUlreENzQlFlMTlTQmZSdXBu?=
 =?utf-8?B?ZVhZbjZvWUx2M2MzVmd1ck5vOTd1VitzU1lENzhSakdYR2JJaWFwZ1NyVXc3?=
 =?utf-8?B?WmpvejFOYS9TK3ltZlZ3UEMzWkpuTmM3aTlHNmRCdUV4Yk94QjYyY0tYbWFO?=
 =?utf-8?B?cjI2d3Q0U3dkWFpsR0VCVk5FUHhPMEVvN3hZQVFaT2NxQ2V6TlNCVlVibjRl?=
 =?utf-8?B?SnJmanZpMC9pSHRkMkVGSHNqOU4wcnZOQmo3dFFaQWMxREdmVksvaHVHeGkx?=
 =?utf-8?B?M1VOS2xhNVA0ejFGYmZENCtnRHI1d1Bva2NOMS9pZlRtQ0hMb1FyUkdIK0Zp?=
 =?utf-8?B?RTQ4K29QSFJrUldmMEN5SEdMV3MvdXdwRTdrSFROWXpOQ3BqRXE2NHgyc1A5?=
 =?utf-8?B?TlgwYmdZUWs1UWdaSnBBMGFUd3BiVFE1MXVqSnRZRXc4YnpnM2ordjIreVAx?=
 =?utf-8?Q?vrRzCVKJSkrDseglr3bOCUJx4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c34566-4662-4790-7f54-08dd45d84b1f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:29:03.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaWArHm8c/Dc8F6WcTWQhKAcHV4J2G2XPINBZzpWwG4H2dBM/TrxHGdwkiMEJjVNhNfr1ERyJRzGbuEUPPx5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878



On 05/02/2025 11:27, Jon Hunter wrote:
> 
> 
> On 05/02/2025 03:31, Mohan Kumar D wrote:
>> Kernel test robot reported the build errors on 32-bit platforms due to
>> plain 64-by-32 division. Following build erros were reported.
>>
>>     "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] 
>> undefined!
>>      ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>>      tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
>>
>> This can be fixed by using div_u64() for the adma address space
>>
>> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
>> Cc: stable@vger.kernel.org
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3- 
>> lkp@intel.com/
>> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 6896da8ac7ef..a0bd4822ed80 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device 
>> *pdev)
>>       const struct tegra_adma_chip_data *cdata;
>>       struct tegra_adma *tdma;
>>       struct resource *res_page, *res_base;
>> -    int ret, i, page_no;
>> +    u64 page_no, page_offset;
>> +    int ret, i;
>>       cdata = of_device_get_match_data(&pdev->dev);
>>       if (!cdata) {
>> @@ -914,10 +915,16 @@ static int tegra_adma_probe(struct 
>> platform_device *pdev)
>>           res_base = platform_get_resource_byname(pdev, 
>> IORESOURCE_MEM, "global");
>>           if (res_base) {
>> -            page_no = (res_page->start - res_base->start) / cdata- 
>> >ch_base_offset;
>> -            if (page_no <= 0)
>> +            if (WARN_ON(res_page->start <= res_base->start))
>>                   return -EINVAL;
>> -            tdma->ch_page_no = page_no - 1;
>> +
>> +            page_offset = res_page->start - res_base->start;
>> +            page_no = div_u64(page_offset, cdata->ch_base_offset);
>> +
>> +            if (WARN_ON(page_no == 0))
>> +                return -EINVAL;
> 
> Sorry to be pedantic but should this now be ...
> 
> if (WARN_ON((page_no == 0) || (page_no > UINT_MAX)))

Nevermind, patch 2/2 addresses this.

Jon

-- 
nvpublic


