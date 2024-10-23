Return-Path: <dmaengine+bounces-3441-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1309ACA2F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BB1F223AE
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CFB1AB539;
	Wed, 23 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IintdoWc"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277E1ABEA7
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687179; cv=fail; b=MqntMUEpvJmEBcCiJqTtedp7CzAd3B04eFL+Tpl19cZOYK/rX1ul49Md+7QzQBlRAVmrnd43uEg5q4vMakCwaO0vwt7lOx63B0GEWwxTaWC7y/LiatQVG2kirPG3sLswjyJinb/VMMd26lHsFdC3+LQsm/bwfH1WWAl+zguV2IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687179; c=relaxed/simple;
	bh=c0vHknNCw+8lLwmBq6kilbD0aMf4XWfirgN0RUzheRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HDCUQUNECGFlikFJUWwQ97wNt4ZXRqHhiuGztLxxU5eCNwLGl72p6+0FfOVUQZTlN25cHNXco7ONSuPJ4xFOxcttYmb5iFjwf36jQXhlN0cVwidIzXNf6P8Kydq8D7W557vUGM6TJK/11mi1vLVGpKkTYWnrGJ/mCSP30UUhpCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IintdoWc; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF2rqAyGcDSvGSR2LyUyD7hVHx3WJXz9Liuvud453FgRI6heq2UDyyoacGH7WOsi9th4XoIJMh7xYQy14I+yAEssYfeRmJRHdDVezB5/om+qu8I8E8BreptpOJNsZx4XI7zVvcsRCQ4MZ7S+jsUyf/48S8QxjKNAdi2TUUMmAqBPu1qmv2yzXsfatpIzptqaCOMub6bSWRyGHJnzgBMfFhaRNyHfdoGqq6V9l2IpXLv+b/c0wlE+7HOh3jqHBQQJcbQI3voh29Jjj8IC8r0wAyixi6aYUTFa8Eu0GzKN/03/pvB0HQC0wUdMIIv853anEVapY3/GFcGOWAEi4ku24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfc4R0I8bivBZgDgXrUzCg369AgdsZYQVGPIjJBFWYY=;
 b=YwnEQ9y9Fb+IRYvL3Ik/fZEYydfjTSWXLC+jG8tIngijcn59m1DP9sPIQnzlhiosGa+522JQvlxO8sBce7BpB6BPWjFzcx1ii7oeL0vpU7r7PCc9bfSyXFASWng7M0lFNL61LKpIOOD2J2sCP2XwTybgeHe1tn4ErkKEpOECbcJdNarr9CoOpjwo1Hgu2jCpBAE+HDlX3ocCLB9KFkSM8NtsZqnGwE5GWk4Vhq5EUKT2YtE3QzeDM3hNHZloYQvUQO8LKN0bpaUV5xfqZiGfflQSoKTT8h/RslQ0lNnJUEVBVwWxKHgMnN+z+su9zMxmeC6vHr+dWoRJhAjWwVD+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfc4R0I8bivBZgDgXrUzCg369AgdsZYQVGPIjJBFWYY=;
 b=IintdoWcZlXcRd07mTJEgAxV1bMmff0AXLzLlv2GyMSf1Tdd4igmEZb1c0lztWn56s2dccRIvhFccCUM6aGtVX0AHCd1ZGnRt0lXMVCgGBOac9EoZhOeKdEl93BbC6hLn7w8iOCUIJhEO/964vLSXXY6MqBTnWL7qMuM/uIZNmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 12:39:33 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 12:39:33 +0000
Message-ID: <72f7d28a-bed6-7922-8c9c-5226e4039557@amd.com>
Date: Wed, 23 Oct 2024 18:09:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/6] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
To: Vinod Koul <vkoul@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, dmaengine@vger.kernel.org,
 Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org,
 pstanner@redhat.com
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
 <20240909123941.794563-5-Basavaraj.Natikar@amd.com> <ZxaQMP8b0Dfk96aa@vaman>
 <549a5919-117a-d96f-a00b-391ed142dc91@amd.com> <ZxiTGXxqHtYiTW0O@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <ZxiTGXxqHtYiTW0O@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f79b4a7-cf71-42e7-c3ae-08dcf35fbeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amZadSt5b3NaQ2FlK1Y1d3dwT25wV3Y0djJkSE5RcDZBSytDdVgxc2I1TTRV?=
 =?utf-8?B?aFhJbDBWeUVxNjI5UDZJZHR1TTBBOVpKZUxmdUJUQml2dDhRdWlOQ1hYR0VW?=
 =?utf-8?B?NWJ4QWY5bXlJZzc1NGkxU2lOQ1BtVzB5T1g0WC93V0tDRDhGV1RBQmg5RlNB?=
 =?utf-8?B?Zy9Od2tUeml3ZGJmYXpndm9XcjFPV1d0bTd5NFV0c1dGd2pTaDRKQmlmRVh1?=
 =?utf-8?B?U0hDZXlZd2pvdmV5dC9JbjhtaTNZSHdkem1pa2wyT1NDMzJWckpzdVo3QW1G?=
 =?utf-8?B?STdPQ2cwUWRqd2ZLTzZQb0JlOUQxNVQ1YXFId25vTzVyNGxiSVFTVlZ2eVlm?=
 =?utf-8?B?OVRJdDZtdTkxcTlabytORUdjWHQrZk5SSndrN0RjK0k0bENKWk9jK2JPbUdZ?=
 =?utf-8?B?czdVYThoWnpCRS9rTWo1ZnU1MjBoaStxblFua1BUSm1tcjRJSmJQT1YzZEU3?=
 =?utf-8?B?ZkVsSGMvbHY1WDVwOEc5U0w2RlRJSDA4eDhBdFBKc2VNZFVrdWJ3MW8wbjhE?=
 =?utf-8?B?WXFKeE9PVlFWdEFiT1RBSGhvM0R0clYzN2FDaGY3NE91UHFvRXloOEZlUWR4?=
 =?utf-8?B?RkpWdXdiWXJ0UEsrVmdIUVdkWUE3dDY1cjRrb1dha1Z3aHhhVHFEWDI0V3V1?=
 =?utf-8?B?c09YYmVabnNZUk1EQi9OYWRYUDEzSkRLaUdzS1F0Q0pINzVVaDRrSWJ5SS9o?=
 =?utf-8?B?ZkFpREFJVU9HVk9yRk9BU2xwZFdEb3NqRGRQUzRmaTN0cWFMR0szSHJVY2ky?=
 =?utf-8?B?bmRHa3AvSWw4YklOQnRxRElXbmQ5WGlId0ppcWdONGlTQUo5TDlTSUVDR1NQ?=
 =?utf-8?B?c3dHZGoxalhzZlNzRUlReEJHY2JGWlM0cGlUd0dWcmNFKzQzNHVUMWJoMzdS?=
 =?utf-8?B?bit1R3NGemVpUnB5MTBSSFhrakcvUUQxZkZXNkxOTzFKQXhpVEh6Z3dmU1ZI?=
 =?utf-8?B?TlEyWjlHdis4WXJsNnJaNUZjWDd4Y2pHVHlDWnhyT2xPS21JNVdnYzBCZkd3?=
 =?utf-8?B?ZlRHelpybk9TMmtlUEZYVWZqbW5rZVJSUjlxaG1FdC9YV0NtdEJGaTV5U2Fz?=
 =?utf-8?B?TzJmcm5CbWxvRkI0cENBWkNmUUlIcWszQi9HVjc4WklaYVI3ZkhoT29kazJx?=
 =?utf-8?B?Nmk0aW11Rm1rZ3NTSWN2ejlQREw3MW5DWkpCZTZJQTI1Y294NkFvTmZZd09D?=
 =?utf-8?B?QS9udGtRalFiU0preGZuUVNOdGlaT0hEaFN2U0E5UThVZE5aMEIwRTN6STRQ?=
 =?utf-8?B?bDNBVXdtZC94Q2h4WnVvMVdxd2o4T0tpUE5wNlVqSVlSTkwvejMrUTlUekVj?=
 =?utf-8?B?ZDcrNWdDN21GVElObTBVMnF5SmJJc1g2ZDBrYmM4ZVlhQS9ESkFvaGVUQ3Jk?=
 =?utf-8?B?eEZGcTg1RlArRGhNZm5BZmgrK1hUYXVGTjV3QzB5WDN3d3VIS3NPVmppK2p5?=
 =?utf-8?B?U1BxVk9wdmtIVS90REpkdG9OaVdGb2diRU5iZlFoelJFY2ROYmZnOFE3VHgz?=
 =?utf-8?B?Z0lwVnhwcFVmTUtZVHdxa0R1eDZKdlhNOFh6Tnp4OHdVN2pROWVaMkl6UHI3?=
 =?utf-8?B?KzN3UlVseHRqYWpjRWdvbFZpaWJMVzhpYmR3REdqWHM0azZmbGRJdzJOWVhW?=
 =?utf-8?B?eGM4RjRCRmcvN3JQZlFZTVg0UzQyaTZ5SURzZkFkOU85MWV0eE93UWtVaVNu?=
 =?utf-8?B?RkVLeHROT1E3SzI3c1JUMXRDZUthZjJvbDNQZ0lUWDhMSXFXN3IyOFczdjkr?=
 =?utf-8?Q?IxXE3WHyTrH2rC91Mw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9vU0ora2JiSW1rMmZRSHZyTGhFZW1mdzRPTW1kQTRzR2VwR25TK1czbXRT?=
 =?utf-8?B?UXlYcWF3RWRqTkVkd2FuSjJUbWFLZGRCSmtMcDVHdUh1dldqVDNRZGVXcFhV?=
 =?utf-8?B?czZWY0ZKWFAxQ0ZjWm1lMlJzcTB3ZjBBSTZoc0xlOTlCdWNFT1JZMUJ3Y05l?=
 =?utf-8?B?OTc3T2Z4NFRVeWg5VisrKzgzT1poMDQ4OUlYdDZSbUdwS0hpQ1VXcmxzOGdp?=
 =?utf-8?B?REpSUXBaVHF2c3o2RTQyMVMxRHFyWWtnVmZhbmxURE5SQmo1SS9INnhzYkNS?=
 =?utf-8?B?U2VFSjQrL1A0bmRUbDhIWVBaL2o0MGFWV2VkMWorSDNkYUUzTmQ5WHZsSmJ4?=
 =?utf-8?B?VDBUWlhYazdsZlNKelVYamh6NnlBam1BTWtOMitFQUxDT3p3MlkvQnFPZ3Zq?=
 =?utf-8?B?MnRXeFVZTEZFN2F6eSszSTI2Q0l2YmdNVWFsbkxZSUo3ejFJaldYNnJZWGxW?=
 =?utf-8?B?UXVjSHg0VUZOaFhTM2ZWTXFzS1ZWTm5LKzIxZ0wwbUxaeUR1L1lsVkdrUFdy?=
 =?utf-8?B?NTlFUDdKS1lGeWtJdDllaW00UHhvYkF5Y2NKQVNvQUR1OVpLL3dqQUltcS9D?=
 =?utf-8?B?dkgzVUluU3gyN2tLYTBRcm5UdHNLN2Jjc1hhYUxaMXFDMkIzMVNJNUpEYVBC?=
 =?utf-8?B?cWpjR1NiUG5acFVCRk5vb0o1ZG4rU0wxWlFZY0JkSzVGNjZrSDJZSndhKzNv?=
 =?utf-8?B?WW1ISXhnNzNpeGVPTisvZW9JRExmVlFMMFFUUUo3WTV1TnJVTUlBeEJxRWsx?=
 =?utf-8?B?UXJHVytOelp0VjZVZER4czJyUzNoWlcxbSthQkR6Rit4NHBTbDRJZER3NnNY?=
 =?utf-8?B?VmhibFRzd2pzbHJ2Z3NlemllSVlLaWVYTlp3NTFXU2V1TFV4SEttaEVaMkxL?=
 =?utf-8?B?WEp1YmFKN2dXRmNxVmtjV1E3RExqMHBlMS9EekZWZCtHL0ZCTjlCei9LTFl5?=
 =?utf-8?B?ZGJmMVpUblg3SURNMS90WTgzQnBhWWM0KzRabHpoSGxhRm84N3N3QW9LaDBD?=
 =?utf-8?B?dG02WU5hWkk5dE9teFNOT1BmZU9pMVJ0K0d5bjlteEZRK3V6Z1hDQzI2SmJk?=
 =?utf-8?B?NkZweE1XVHBSL0RPZHVUdmVyM1J5TExLWDBndlRrVGdRb0ZEL0hWa1h3ajBN?=
 =?utf-8?B?bys5K1RVdG9WMmhPTzBubWk2YlFUdE14eWNtNnJ0YXlRUGhCazkzR0I5aksz?=
 =?utf-8?B?dWNLcWVGK1pDcEYzUXdpdGVBTFNYYW5OQk5xaU1wMFVHT2VOcUtHTXVIamRW?=
 =?utf-8?B?STQvWnNrMTNJSmhYUGFzOW9EUzIvYUlmVlhCVUNSL0NCUmU0N1ZiQnBUWFBi?=
 =?utf-8?B?VWFpWVptaXBkdnN2TURUM3FZSHNIZEgyNjFzU0V0My9GRFlyK1ZVMzBSR0Vm?=
 =?utf-8?B?Ymk5U1hBd2Zma1lQZXd3dnEvRHJYUEpnTWt3WVdHazJLeHZRRHVudXU4WWtz?=
 =?utf-8?B?THZBSHgyc0pvL05hZGkxUS9Xamo0T3NFZXdsZXpKT1VXMjR4UVFPdnl6Vy9n?=
 =?utf-8?B?VDA4b2w4L1J1MWlNelZhdTBUY3VHZDB6QlpHY2Q3UmxPYkQ2NkdDaWhPZDVo?=
 =?utf-8?B?TjNtTGQ1VXJ2WmZlRmY5Zk1FVWtVN0VDajVSUTFzWWVCNGkzZ2pHaW5iVGxX?=
 =?utf-8?B?L2ZRWWZLOHhnYlZrVXRCc3VnR2VxSHRXOWRWUUkxNHZGenM5SEtNcTdRS043?=
 =?utf-8?B?RmdjOGZFS0tGTW85TVo3SUgvTzNpdlNib1dWekhKajRZR3FvL0J4VEFUaTZM?=
 =?utf-8?B?NEhob1JEWHlGTkIxc0VSSXZndUZNT3ZCU2czNjdoSlFvNElLR1VTQzhrZDZT?=
 =?utf-8?B?V091U1ZPOU5zVGtwN1ZHVEFGcWFWMisxMUpZU2FhVEk3bHh1Skc3Zndnamto?=
 =?utf-8?B?QVJaQS85M1BQdTkvaFhmZndPTC9RWXplQmxvMFdnVTRtcHp4eWxBQ00xdWM3?=
 =?utf-8?B?b2FNd2h5akNWQS9TWC8xUDUvUk1VSXlzdXIvdnNscnZwdHdYVXRNcW9RdVJN?=
 =?utf-8?B?U3ErYk5Gem9KL1Y4ZUp2cHhzUWRneDQwUW4vOVBKZjh4M1pUdXdmRjFCNjYz?=
 =?utf-8?B?bnBEeG95VGx1UVQrdEs1aERqcm5peGpuQXIzdTB0anNzaW5VczVzUEszOGZs?=
 =?utf-8?Q?FoeAkn5X4QTPTAdpC6DLI8aCr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f79b4a7-cf71-42e7-c3ae-08dcf35fbeb3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:39:33.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EstrFMr3eV0Svle2n324IXVp2B9r5zOh4P75/5hNbujmdPNUqpa9H8TVnxtrgAAVE+ps9U2HHsrw7ngNRSqEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685


On 10/23/2024 11:39 AM, Vinod Koul wrote:
> On 22-10-24, 10:53, Basavaraj Natikar wrote:
>> On 10/21/2024 11:02 PM, Vinod Koul wrote:
>>> On 09-09-24, 18:09, Basavaraj Natikar wrote:
>>>> Use the pt_dmaengine_register function to register a AE4DMA DMA engine.
>>>>
>>>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>>> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
>>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> ---
>>>>    drivers/dma/amd/ae4dma/ae4dma-dev.c     |  51 +----------
>>>>    drivers/dma/amd/ae4dma/ae4dma-pci.c     |   1 +
>>>>    drivers/dma/amd/ae4dma/ae4dma.h         |   3 +
>>>>    drivers/dma/amd/ptdma/ptdma-dmaengine.c | 114 +++++++++++++++++++++++-
>>>>    drivers/dma/amd/ptdma/ptdma.h           |   3 +
>>>>    5 files changed, 123 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>> index f0b3a3763adc..cd84b502265e 100644
>>>> --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>>>> @@ -14,53 +14,6 @@ static unsigned int max_hw_q = 1;
>>>>    module_param(max_hw_q, uint, 0444);
>>>>    MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
>>>> -static char *ae4_error_codes[] = {
>>>> -	"",
>>>> -	"ERR 01: INVALID HEADER DW0",
>>>> -	"ERR 02: INVALID STATUS",
>>>> -	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>>>> -	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>>>> -	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>>>> -	"ERR 06: INVALID ALIGNMENT",
>>>> -	"ERR 07: INVALID DESCRIPTOR",
>>>> -};
>>>> -
>>>> -static void ae4_log_error(struct pt_device *d, int e)
>>>> -{
>>>> -	/* ERR 01 - 07 represents Invalid AE4 errors */
>>>> -	if (e <= 7)
>>>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>>>> -	/* ERR 08 - 15 represents Invalid Descriptor errors */
>>>> -	else if (e > 7 && e <= 15)
>>>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>>>> -	/* ERR 16 - 31 represents Firmware errors */
>>>> -	else if (e > 15 && e <= 31)
>>>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
>>>> -	/* ERR 32 - 63 represents Fatal errors */
>>>> -	else if (e > 31 && e <= 63)
>>>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
>>>> -	/* ERR 64 - 255 represents PTE errors */
>>>> -	else if (e > 63 && e <= 255)
>>>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>>>> -	else
>>>> -		dev_info(d->dev, "Unknown AE4DMA error");
>>>> -}
>>>> -
>>>> -static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
>>>> -{
>>>> -	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>>>> -	struct ae4dma_desc desc;
>>>> -	u8 status;
>>>> -
>>>> -	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
>>>> -	status = desc.dw1.status;
>>>> -	if (status && status != AE4_DESC_COMPLETED) {
>>>> -		cmd_q->cmd_error = desc.dw1.err_code;
>>>> -		if (cmd_q->cmd_error)
>>>> -			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>>>> -	}
>>>> -}
>>> why is this getting moved?
>> To avoid circular dependency between PTDMA and AE4DMA, we are reusing PTDMA code to prevent
>> duplication, as AE4DMA depends on PTDMA.
> Okay please move the code first and then do changes, that makes it easier to
> review and follow

Sure Vinod, I sent changes in V7.

Thanks,
--
Basavaraj

>


