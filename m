Return-Path: <dmaengine+bounces-2136-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7238CBC3E
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 09:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37901F21EC6
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329D7D40D;
	Wed, 22 May 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCvqqUdD"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5D39FD8;
	Wed, 22 May 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363799; cv=fail; b=bd/TLPiRWhqPJNQFe1uKgPXloahqBwUGWnG92p/ZKoU5ezs7JlUHoUusJbb3sfQSbmRZmcS/zFzWmAQnTBJmsrFJgIuhbuAvAWw+9B20c1GPa3RzPmQvfsGLckYQUiCKv6fA0WMjk6ePMLD4bH6/fKtALLAoh345Alz9rcTnLog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363799; c=relaxed/simple;
	bh=aak5fqHJyGsb+SEfVfT3gAJNgoAgXb1NoO+zdxGSJRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BCu1ps3VYH4E6mKrXxfkX9loar5OMWq3bd0tGKsj6L4r37Kb13wAYbltKrnHJMJ+3SzzTa0fYr+W2SAj7G/gSsXFRJc3NqjCnTVq3odrQfVQ9Sh2Gt1nBzQpaVNtnnpRle+QZAIvnT96JuUF+/tEtADh8jkvwJvpYmn9OyvCEZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oCvqqUdD; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3SNtoDdoEwyQGw4n3FmuvIfT7ONoXqxXPfaj+MBq2rZLA+U+3KVYaeRvzbqTfwqiMyT7s8Ly6VAMajJz2blev+1/fqnw2E03WinoNdts1EExogdrPoq2pevXra2iAqmdUx6tX0QLuxTOG2l9kVIjAgF2Kqs1Adto7dsAZ1JmAM5IZCAjJ9OHoJmRz5XCF40/y0Q+kxWQBlRaZ9ZBUoRacP+MePUcn5Tink/+J1zgp4ALlk3wI9xzkebGfRqX2nVUBenSTXklNAC9IVJgZeXW5O7KadPDQ0aVDd8ZeV5kSI7F58LTNUvpFkd5faQ7PzN5MaUpFFqlW80LBCpanzjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufiL5mmA9fTnU+McQGY2XsQ2FFNYvX6oKnCAGWK+Uyk=;
 b=GeT/ksQeEi950hsshvT/fAC9C83sNbwK6SKhHfUTqSjQLgSiApjQ4cyAUuICyodAYPh4i0gdI5K+cUnIsc2vsM6qZAj+HSqpja+ZyogytdgBgdyqx//slFX7PVztqfrHS9nV1bbg1oav8WRSoe81LqaIWqYTBio7ON07nSMzY8vwfNhaFyN9Jhw9boRVh/6H9rltpi1eyUNNPgdhnvlYocQBDnjLs0I1LcuL3Bz03xGnQe/1KZRkdIzpjpSviuQCTY9vv/4DD2MMbNcHBRvjYhyeI5qvaIMSZyApk7v7azvmJNZEdYAfmznHMQTDV9xEVnBxRE9OI+D5XtLBeDqv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufiL5mmA9fTnU+McQGY2XsQ2FFNYvX6oKnCAGWK+Uyk=;
 b=oCvqqUdDGv9jYXwsJ/tNZBIf9wqMLx667Z6ybNvHPoHX8fmcpyqMuK8+1IXiiD6FA57xxQkv8cfg3ZQ0XLlA4zsPrnFkn7poyW0D6A24YVL61brZ2+XuqfxdnLHAzmSEgiGETOl/vaN4/0YfQ7tM5RFYnElctekLqka6JxG60RXygDe4+4gVLFMExXedek6G8U0fU+DjDXaA8QT/MbL7Zdchddb+bG2RZQ4ptofv6jMa46wWOXYukhy3ovUumq6E3h3v6c0DGcrEbP1aWPWjH/MxssyYozLbCHbmSLSYG9SDT1lYB+bflzrFN3c53v6AGNS5EjOIVoc+TK3hHVoT2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:43:14 +0000
Received: from CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::eba:a472:8ec9:b80b]) by CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::eba:a472:8ec9:b80b%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 07:43:14 +0000
Message-ID: <f785f699-be50-4547-9411-d41a4e66a225@nvidia.com>
Date: Wed, 22 May 2024 13:13:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 ldewangan@nvidia.com, mkumard@nvidia.com
References: <20240521110801.1692582-1-spujar@nvidia.com>
 <20240521110801.1692582-2-spujar@nvidia.com>
 <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
 <e6fab314-8d1e-4ed7-bb5a-025fd65e1494@nvidia.com>
 <56bf93ac-6c1e-48aa-89d0-7542ea707848@kernel.org>
Content-Language: en-US
From: Sameer Pujar <spujar@nvidia.com>
Autocrypt: addr=spujar@nvidia.com; keydata=
 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
 tFh1Kv06N2eJoLklRzTKy6I=
In-Reply-To: <56bf93ac-6c1e-48aa-89d0-7542ea707848@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To CY8PR12MB7706.namprd12.prod.outlook.com
 (2603:10b6:930:85::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7706:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 79121023-6e83-4902-6d6d-08dc7a32d619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZXYm9INzFOdFBHOVU4d0ZqSFVpcVJWenJGUGtpN3lWL2U2aGR3L0tFMTZp?=
 =?utf-8?B?M3VBdW1PUllldWR6RXEwSGpGMTJVWVE2S1V5K2tnWXg3YnFXRlNJdjMrd1VE?=
 =?utf-8?B?TmJlcUF6amF2Q0k4RVZ3WXhsenN1WEFmaFBCN0N0TG5reXdjMjRYK0RQZXpM?=
 =?utf-8?B?T1ZXRG53TjN0VnkxbW5aTUpYbTBtUDVabTRRRTEvaEVkMkhHUVl4Q0N2TnVP?=
 =?utf-8?B?MWluKzlweTBBTEptN29talV4aDVlWEJnbzJRdkRBV1RjeHQ0NXYzeW9PanIz?=
 =?utf-8?B?NW9xN3hJSjIvTEFQREJDdVZzREt0YjdPU1hpUDUvWkJRSitsL3grUTlFY0F5?=
 =?utf-8?B?Qlo1Mjc4aEVsYlBYMHhMbzVadlMwRnRRZk42QittL0FrYnNHVzgvOTFReDli?=
 =?utf-8?B?bk5HK1haTEc2VVU5Q0MzeGVENkdMSHUvNmpnNHEyK3E1S2ZkYllKQ0NYbXZE?=
 =?utf-8?B?bFF0NHl1NlJnRm14aWlhVk1SS21mbnJxN0VYNnN1VTZJQ1p0S25pQ1ZvUHo3?=
 =?utf-8?B?RCtvVnpTQklwYUplYytCN2w1OXR2eEdHL1crMklhaGM4anZML1lURDd6ZTBL?=
 =?utf-8?B?OG9tV1FmVG5XSWtCQ3dEdXV3QXh6NEFybmlUdEZiUzN5bXZxRlFRZmRaRnhL?=
 =?utf-8?B?QWxxVDJpaFpZQWZmdU9kZTVWNWFVanF5Zk9uQ1NndXRVSWxMdnVlOFlyK3lh?=
 =?utf-8?B?cmtTUThSM3RYeVdXQU5lZkpvVFROcE5EY0d5dTM2ZFlIcFN4bnI2Nlh4VlFa?=
 =?utf-8?B?Qmp5N2JwdVlMWitJOEhUQWQvNEF6Zzc1NGNpWTdzRUxpaWpUZDBHWkFpbGs0?=
 =?utf-8?B?VHBwcUpCQUJHMzBOUGFiQk04V1N1UVNSMndpaHduZzhJOGo2RVBhejNRR3lP?=
 =?utf-8?B?Wk1WaUJMMURSL21hQ2VJdE1YVHM3VXdqY1lVTi81eU1FdWR6Tjc4L3hEbXNa?=
 =?utf-8?B?K0R4L0VyZEFwZXh5NzhsN3hyN0RsZ1dVRGVQZ2VDZElSM2RHVjlTdUtPakdt?=
 =?utf-8?B?azBNWm51a0UvbUlISFRaeVlrWXo4TWcrdDEzajF1Q291ZThpNmJTZ1crcVJG?=
 =?utf-8?B?ZXhrRzZHM0o2SHNBYnBZUlBERlpHeXJtREdFd2xVUWEyZGVrRUp5UGE0MGtZ?=
 =?utf-8?B?RXNMcExEV3lWbmpJblNIUXh5SHRRTkR3c0hJdnY0ZzFFbDBhYVNSWVVUOFI0?=
 =?utf-8?B?ZDFlcTNDakZpdm1HdXlEL25sUjJzaDYraDVlOU40dTNXQ2Y5dlg3bkRTeWx4?=
 =?utf-8?B?OHVzcWJUU09jM0ZqeFdlVUd5c25la1crcDg4d1M1RWtUM0NwVi9BSE9idUpz?=
 =?utf-8?B?bThHd3NHTEtrTnlIN3EyeXB0Y21JZlVBYTdCUlRlclFvZnVGeUtyaExPa3kz?=
 =?utf-8?B?NWFkbjd2T3VpZ3o2enhoV1d6Ynp3MWNlZjVXWE1pTkVOaWpqK3UzNkszVlF0?=
 =?utf-8?B?enhsZWJESStWR01pV0xRNk1oNDlGUEI5NWJVLzArUnc2byttb1I5cjVqRE9x?=
 =?utf-8?B?L25ndysxWkoxTEJUZURaQXJjMmpzOGV2WEVibk90MjZIWDByMS9zNVJ4TEFw?=
 =?utf-8?B?STI4UHZ4ZkNTdXlhT1A4aG9IL0h1dzF3WDlvcUVPaFovWStmd2JwRHlBR3Rp?=
 =?utf-8?B?b0x6aWQxK2hVeFphUGR4U2Ixa2hkRThQMmVRWlhvdGZRVEVwQ0RjTWxKelJX?=
 =?utf-8?B?OTRjczlTejNiaGhQWVZnUThPS3djUzVVRGJmbFAvZWc4SGhQRWk4S1dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7706.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDQxK24yNU5lS0lJMG1qK2ZJS3FiQ2RwZmpZM0RpcTVkY1FaUmduVWw0am41?=
 =?utf-8?B?NENyUGtxZUtuaDZEbUJFakFmTzlCSUZEUmNqZlZqNGM5dERKNkdzQmFXWmpP?=
 =?utf-8?B?V3JhREQrT3B6c2d0T3NDSjlyc3JuWnFsc2dKcGs0SVltT293QnNLRHdWMkNK?=
 =?utf-8?B?SWloZVpXamxEVE5hcGpPQ0NNZEhKSE93SWRWc1Rna1JNeHVZLzgrbnNRMDVs?=
 =?utf-8?B?LzdmMEF6UHl0VklXQUhzSlVHdjBVUXJaaDNuNVBwRnQrOFdwbW4rNTdXa1ZX?=
 =?utf-8?B?VjRLeVpCdmVXcmVvYk15ZU5lNDVmNDdheHFEM3VyaXkvWFJWc2Z0MTh0OWdC?=
 =?utf-8?B?MjBWUGxoZUlxdjhGbmJMQTNrZU05UHVxZXV2TTdGR0FvQWR5TDZTblcxS0dT?=
 =?utf-8?B?UWVyQ2U2Z3pCZ0F4TURQenM1NXhqaDBYN0NJeUsraDVoZFRlM2plUXpyalE4?=
 =?utf-8?B?Y0tvbW1zd2dRNTZlR0FLN1dza2g1ZGJCTjVweXhUcmFaNUJuZHpra3ZhdHBX?=
 =?utf-8?B?eW9leEcrNXJSd3lPbTU0d3E3OTNhSWdMbXFpYXl4eXIvMGtNVkQ0cVQ3WlRm?=
 =?utf-8?B?VHhUeUQySmd6MEIyV2JIRHJFbnh5cTBubUNZVE1sY0ZNK29ZNFZxLy8wOWZa?=
 =?utf-8?B?VTRMa2VwbzMxd3hlQlZ0Mm4rQWlqdlF1MFVQU1NGUzNxK1R2ZEJmc3BTVnB3?=
 =?utf-8?B?UHB4ZkxGU1JNVFgwc2gwL21mWC9EcExQTm1qVnA2akJKMEdGUCtwd1V5Mnhu?=
 =?utf-8?B?S056OE5wWWRmL2V2aGI5bmdVZnFwY2tmTGtMTjhnZlFDbHFCM0ROV3RQd0NG?=
 =?utf-8?B?S1V2dm41ODMvRTU4ZTUrQXRxNEdmSm53NGpncXUyc0tjRWJVVFM1eU4zY21B?=
 =?utf-8?B?alN1eTBUamtrR25yZGM5akpkTk5qOFprWlFQakRPaXF0b1ZCNldUQ2FEOW54?=
 =?utf-8?B?NWJDcXFsNHJFeHZReHVNYTZqSVhTQncyZDh5V21SNnh1Z1A5Q2VmNlo0V29J?=
 =?utf-8?B?dzVJZGZnbllVNEhHMFdiWnpSQUFKOTJBUVhqbFRSMi9KaUlaSENHSnJCVUV2?=
 =?utf-8?B?SEhpOUJzWVRPVkhGaGJYanprM3lPOFpFMUlsaEltN3pONHZVdm52OWEzU2I5?=
 =?utf-8?B?YkMrVzRvb3hBWDFPRE5haitQcW95WmJpck9KMGg2WWREeWwybGhGWkZCVUJZ?=
 =?utf-8?B?VnhadHFwOTlySkRDYzJsQzRZUUwvcVN5MnA3dFZ1K3daaFNZdEtGOFBMYWJC?=
 =?utf-8?B?WFJmY3E3dUh3VjFOYTFLWFAyMWdiZlM2c0JjeS92Y0pXajdITGJNaVByMW1z?=
 =?utf-8?B?VFlyVU1vSkVhSTRha29mWXY3anFORkZXV0grNVhtRVRNeUZtVUxNaGhLM05O?=
 =?utf-8?B?MVhvNzVYV3lMN3dQM0pLcyt2VU51L1dqUmFGSWdyOFVTRzduWCtsSndwem90?=
 =?utf-8?B?aFpTU2xuTElFVGV4WmFHOWZXbXYrZEFHRXVHTlZ1bmtuajRHUGlXNnFxcElu?=
 =?utf-8?B?OEtNR0Rkd3NOS1NXL0pFMFBTOGExd0dDRE1JZTZVanRUclRrVjJxVGRJYmQy?=
 =?utf-8?B?ZmlQZnd3aWRhend6TUF0S2R6RXBNUUxJVjBaYU1MOU9KQTdzbmk3ckROUEJW?=
 =?utf-8?B?Zm8rdFF1Nkd1TmlneXhnOTlvNzM2MTFYeVNhd2hwZWlKRjNNQ2tWeWUyU2oz?=
 =?utf-8?B?dlZ6U1Z1T3QwT2o2aGcvRXZOQXJYOUUyandKcHdVZXNEWjIrOEdxM2NyNUEy?=
 =?utf-8?B?ejh5V3QxcjlRajhRejJFNVd6d2dWWFcwNWJSZDJjbEo4NlZLc210UGhPVklK?=
 =?utf-8?B?NlRreGlYTWNJRnV2cFdKRmF1SFl1U0c2Ny83YldwUUI4NVRpZGVKRms1Wnll?=
 =?utf-8?B?TWwwVnQweUlESlFPeEVJd1pCZHVPc1U3elpaK2xFam5kbHpXcjlob09YRU1J?=
 =?utf-8?B?MitSUUt4Q09vVEcvK2VITGgwNVF1ajlpMmFSZER1aW4vc2lMNFZ2b0VhT1dj?=
 =?utf-8?B?VEdodjk5aURPTVJ5SzVIcFdVUTh2d1FRa2E3SVVsc1BmdjRJakhwdXlnZlJw?=
 =?utf-8?B?djVBa0xYNHRpbEpUQ0ljOE5mV3N4Q0todEVlTFJFeDh0NlJEN3VoOHp4UVVD?=
 =?utf-8?Q?jQk03UwwiAi2GnECl5uhHNLyh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79121023-6e83-4902-6d6d-08dc7a32d619
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7706.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 07:43:14.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd6RqJHjU4vL42viDyP3cy+EMjyP9VgvvuKhb8qgVMEsajo0DaQnl1x6TvD/Qzqq/bwt5Hk8TDrWSMU34dYUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636



On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
> On 22/05/2024 07:35, Sameer Pujar wrote:
>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
>>> On 21/05/2024 13:08, Sameer Pujar wrote:
>>>> From: Mohan Kumar <mkumard@nvidia.com>
>>>>
>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
>>>> resource range to include both global and channel page in the reg
>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
>>>> channel page and global page range is not allowed for access.
>>>>
>>>> Add reg-names DT binding for Hypervisor mode to help driver to
>>>> differentiate the config between Hypervisor and Non-Hypervisor
>>>> mode of execution.
>>>>
>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> ---
>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>>>> index 877147e95ecc..ede47f4a3eec 100644
>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>>>> @@ -29,8 +29,18 @@ properties:
>>>>              - const: nvidia,tegra186-adma
>>>>
>>>>      reg:
>>>> +    description: |
>>>> +      For hypervisor mode, the address range should include a
>>>> +      ADMA channel page address range, for non-hypervisor mode
>>>> +      it starts with ADMA base address covering Global and Channel
>>>> +      page address range.
>>>>        maxItems: 1
>>>>
>>>> +  reg-names:
>>>> +    description: only required for Hypervisor mode.
>>> This does not work like that. I provide vm entry for non-hypervisor mode
>>> and what? You claim it is virtualized?
>>>
>>> Drop property.
>> With 'vm' entry added for hypervisor mode, the 'reg' address range needs
>> to be updated to use channel specific region only. This is used to
>> inform driver to skip global regions which is taken care by hypervisor.
>> This is expected to be used in the scenario where Linux acts as a
>> virtual machine (VM). May be the hypervisor mode gives a different
>> impression here? Sorry, I did not understand what dropping the property
>> exactly means here.
> It was imperative. Drop it. Remove it. I provided explanation why.

The driver doesn't know if it is operated in a native config or in the 
hypervisor config based on the 'reg' address range alone. So 'vm' entry 
with restricted 'reg' range is used to differentiate here for the 
hypervisor config. Just adding 'vm' entry won't be enough, the 'reg' 
region must be updated as well to have expected behavior. Not sure how 
this dependency can be enforced in the schema.

> Also, drop unneeded |.

will drop.

