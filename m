Return-Path: <dmaengine+bounces-4288-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E9A28938
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D447E3A0F9A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 11:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31822B5A3;
	Wed,  5 Feb 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvlToKm7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF622ACF1;
	Wed,  5 Feb 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754883; cv=fail; b=GwxCMy0VM8zamvF8XqU8BM7GSR6aR4cGjSjDcTr6CaIX6GNCit1v7s+vB+pXeW+Qfe0rWwcliKk6yiOfMh8oUzz42QCIs4AXnxOFjVd5GqZBPubTbCOqPApPUwmkjAnuApSOak9TinI/ugwz+atj7W20ZJgAqrrLfJoLxTT0GBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754883; c=relaxed/simple;
	bh=iTnl15XT83QhmZggDDYpCtFieFoAgasPSJbtjMvomp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rh5dEcYp9AUNVh2iKF5pCyfps9h5jKcjqMBecKfVaF6mzfzS6sS+h/2Z9TdUYSaMPPJBOY8oQqx8UWMyUyqlfPtTMW061mr3D9/NCAGmWxDa2wkW6NMnhhjqhFE/hXb9YOjd+wtaVru9h5Wi9byuS0YsRVIZFEuVQOFzQw/He+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvlToKm7; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1CEvtpOtBkmG1+lmlccDAyG2/jzif/+fo96mCA17h+2Gt8oDb6Q/LkvatV6Dc9gV7EaUfm5lFf+u6QGa6DuZWRiIIOUkCm2xlaRnRuseTzvihzVZ7Vv6elraDkw57PMbsfHQ2FRa5wopabiCbiA0P4xq3BQLDOju7YjTWl7p9BCUsJYDIWRp62WTBuSSRwlJaLAvSwVuBic8o2DfJPUyuFv+MeWfegBBawKTV5kQycK50EfuOuOdzBc7q3cfQ5QWVDUgFp26B5MG9JpICKgVKGKRzwAkYX//6BEKJzN+7f3iPbLzbCaq6fesjbk3xDujXLEch1kkTMZMi5YPq3s7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPwY4LaCqJH3zq9fOQ8NuSnwWjkFh54UPocuIU4aPKs=;
 b=QwQGgltSsZV2N5igRWdOAZlh1DL+S7M+75MqMFsDtyC1ysNDR9n3JChy2MCfXHtCV1rnrmlQfEbTk5qnLdtRx2FAfQqHoWA296+imQpOkqynS2oJdV2J8IyB+OGxF51X07hf8PxyF+lIKXfEOKje1wdOuNGWD6/MV+GaBRxW7PIIU7NqjRW6bMkTjQx0YamkxlOdMP9qOV8yXqcq54OiW/+7jUKUO9qFq7ZUsOkQwd+K0Ul9CwjQZa/VW0lTTh34STJV3sktpvjD364SZmNM6s9DO0NPJdiOLPvWG4/fGhU7qW6RTiBfgsvtPw4MI0H7jLfkRtlgcXFui6HjNIHgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPwY4LaCqJH3zq9fOQ8NuSnwWjkFh54UPocuIU4aPKs=;
 b=IvlToKm7JwdvyFzntAXli2O2ybjVqSCvSvqn9IKU+7RNjTD1fJPlrRHuirkn8iPTOmm0HOXcSOvitG42CX0+R3ocjNNuGIhpKh1t1qXLok5ZREUkvrhcX1zlbkbKI3Fqq810kuyrhgmqYtRDVAbG/6kh9kf4eBn2/yaec3MtqQdYY5fpfYhoxr0e2W9ZBeCNYjhftBGkqkG91AC6fSQyXj/ma8MICYmyelwX4TXQ71hs9EcFP/qqMXDPKzp39BERN9D0cZZs2Zi7i9FiEm9nBNtcdRw3iz6Pjvq0mUdKzfGAlj+XSnFLOH3o48GlCLgHUs5c0O7t1Nih6Ft2CYwcNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 11:27:55 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:27:55 +0000
Message-ID: <dd094508-482d-4ed6-b9b4-77607fd18f4a@nvidia.com>
Date: Wed, 5 Feb 2025 11:27:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-2-mkumard@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250205033131.3920801-2-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 38dd0705-1328-466a-51e9-08dd45d8229b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnhxRGsxci9Ub0svUGhMRTZnaDdFM0dWTTJlWUlCTGo1d1hGelJLWFFjZ3Zk?=
 =?utf-8?B?NG1haGI2bWpvaWEvVEJNSHd2T28rcXFJTUR6YlBycnVXU0wxOUs5R2xJR1RQ?=
 =?utf-8?B?U1dTT2hWdk9DN1F4Y3JxVTd4UEJSYzBoeDEzZXFMd2MxdE1aY0xjWDZtUnds?=
 =?utf-8?B?ellRczRaTThlT2VlRkJaYWJRNXU2NWk4bExqMy8zOU5xVnJMSUIyS0g5Ylox?=
 =?utf-8?B?R0pJSm0ydGNISjlPZ25RWUFRWFFRcStZaUovNE1yTkFNRTBQV2FBYTAxUXpT?=
 =?utf-8?B?RllKRy9kVFNmbEkyaXFrYlo5SGphUUR1NTZwN0xUWEpXNUM1ZUttWGNxVmd4?=
 =?utf-8?B?ZmhvQWx3RHpneUgybTVkY1N2cHhXVXRlalpudzlicTlIaXJ4aysrRlBMYWsw?=
 =?utf-8?B?T1QwR0NrQW5iZWdBYXZPejMzenRhTU5CN1k5MFZ1SWltZWFEczBMSzhDeUpa?=
 =?utf-8?B?NVZXQlN3SHF3YTV1U210RkttMUdYeHN5SmwrcTNpUVhRUVFUT2RqTjFVaEdU?=
 =?utf-8?B?QWJHK0xLckxITGRtRGp3dGc0bXdGc1hOQzFHZDdnWlMvODlxRWVYTHl6VHJK?=
 =?utf-8?B?WUV5MHJMcEcvUVIyUVdEUnZWbmFSSHpVOCtockpPVXFPa1pZSjJYdnVDK2wx?=
 =?utf-8?B?Mm1iR0ZIMUhOYVczYVBwRXNHNnAxeU9YZFkxaEgza0hUbi9Jbm4zemc2alpJ?=
 =?utf-8?B?eU05NWF5OFBXNVJxK1JzMHMvVSthYm9QSjBKdEM1Y0ZHb2NZQ0pPbHAyQVpF?=
 =?utf-8?B?RXpibEtrOGdUK1Awbk1KcnZyaVU4N3FLbTBacXBjTUNRRWQ4UG1WdVhlU1pU?=
 =?utf-8?B?ekg5MFhTYzdrK2RGVjAyS00wdFNzYVNWYUhCV21NRzRFcHE5QmYrK2FDR2cr?=
 =?utf-8?B?Z3ZXdG01VGt0dzF3YjIvVmlVTU1GcU04Umtvc1RYMVhOcmZZYmxUYnM0d3ZF?=
 =?utf-8?B?RjJML1ZwQXNaMHI2d2RNb2h3QzRDb0FZTWhwN0lVakhxTWdDRlhab2lIb3B2?=
 =?utf-8?B?QVMwMDlJQ1UrUXovSjc5RUhzSGpqOXRxdUdocGxRcUFYNkxuSy9CUGFkRVl3?=
 =?utf-8?B?Rk1DeDg1MDJ1ZEc5ODFCTUQ0MGZNNEczc1ZpeC9SR2x4bmRjVFJTNXRNTWdR?=
 =?utf-8?B?cFUzaU5BekltdGtlUHlVamZNZkMyMjd2NGxmOUtvQk5DQy9hSStsZmc4NU5y?=
 =?utf-8?B?QkhqRFU5T010c21OMGZuOU1USzBldDJ3ZkxhM3ZlN2dZYi92WXVhZkhaQWxB?=
 =?utf-8?B?TmxIMW9BK3d5VlVKTDViRXk5aWdVYjFKMGJPVk9RdkhQMFdMWTRVVlduTVFn?=
 =?utf-8?B?VEwwZktsK2x5WEp5aW5ZckVodlNDREJDWklaVERvUWRwWUs0M0p4bW9QVFBs?=
 =?utf-8?B?ZjF4bHYwSXVVdmVCQkNvKytDbFN2RzdQSHNIZ2toZFJaQXVmTUZQUjB0NTBy?=
 =?utf-8?B?dWdhSFpoSEpkUjZDeFVsSE9janhpaUV2KytyT2dwMEt0Ymg3NVNXOUpJeVZQ?=
 =?utf-8?B?ZjE5UjJrNUJTcEF4ekVjOWRuWHhFVnpPZ0ptN0hZR096bWR3Mms0Sm9uSnZ1?=
 =?utf-8?B?UGJ4TTgyQmNleVhDMW00RmNpMGEwZmZUTTJGcUdzYmJpclA4UmROejJQcFM0?=
 =?utf-8?B?dHBQazZ5THVzR0tuUThJSDIxcUdlK1lnL0laZjJVSzdiQ1lyaWMrL1U1c2ZK?=
 =?utf-8?B?VUpqSHNTYW56aUljeFNaNEprRk9FUnphc1BVdlNCQjBuSnkzckZmWm51UUpZ?=
 =?utf-8?B?MkZwN1NCR2N3YzQzRFFVN21acm5CWmlUYStsMDFLbzhnTUZaTGo5UnZ3b2VD?=
 =?utf-8?B?SlN5TElvTnFTbURIU3RCNWdYblJRWjY1dHB4ckdLYXROYkRXeHZCYnRMVHZF?=
 =?utf-8?Q?XWHDhCLzfsXOk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdxVk1BS2dpMGJkdkVuNC8wOE9VbStPMlRGOFZmR2piNExoc1NWcXoxL0Fm?=
 =?utf-8?B?MFY2Ymlhekp5bU83TEdNN3hwVzBYd0xxQVQ2SnBPQk95ZlN3aWFHZklacTZm?=
 =?utf-8?B?YWcrUXhINEM3eUYyemhrVDRLSlJrY3puam5GaFdlUGd6NWhDMy93M3BLbk1k?=
 =?utf-8?B?N0hZcTR6U3R5RmN0SE5rNXVmdVFHRThmcjN6c0J5T1RoT3pYeC9TalRFRGI3?=
 =?utf-8?B?Q2VudWhZVXZxemNyNCszTlZNVG1VeU0zMVlZVmZXWnRZaUZOZFdVL0w5aXVq?=
 =?utf-8?B?bk9TZUhIS0RMQk5lbUN3L0hobDdVV21oVm40MlYyV2Q5di9MeWJGV1VQNWNY?=
 =?utf-8?B?aHBVaVhhcDEyVkZoRG5GUXREeEdSOUpRaXhuMzdMM2NtNTd6YzIzWWJyOWU3?=
 =?utf-8?B?a0dRMGR0VVh6YUZOVCs3cGc2eEM1aWN3K1EyN2tNejlRWnJMTlFPOGJDOXdz?=
 =?utf-8?B?U3p2ZGhjRTRtVG1WR1hCMjJFKzMrTk5jYjBtbE5tSTN3QmJYdHIvajNhSFJ1?=
 =?utf-8?B?ZXV1U3B4NnhodVVrUitUYmJ6Rm1vckRXRVdDdWZCMEVZeFBIcU9JTytVNFpF?=
 =?utf-8?B?YS80VnRyYVRqOGY2UENJRkhiRHJWdmtLN0x0c29LZnVzS3hnYUNvVlczVytL?=
 =?utf-8?B?WjBuV2pBYitYeHEwNlgyY3F1SFhYV1p4cW40UHpIRHFWZE9zMWhsaElDSi9C?=
 =?utf-8?B?T2l5UEpuRmE2ejNjT3JxM1EyS0cyZlhQNDI2dEdudjdWLy9WUzBaK3FrMjBy?=
 =?utf-8?B?Rk5oOEJwb2p2Nm1jSVhtNG1sUU5nRnZqTUpTMGZheDFPSDRKc1lrTE1PRnda?=
 =?utf-8?B?U0tQQzBhN2VjTWRDRVg4VVVDMFBJdmRpVDhTaTZZVUZleGRXaHVCb1NBd0to?=
 =?utf-8?B?RzAxQTVnMm95SXo2V3VmakMyajVxYzl2dXgxcWJ5V1NaeXBjTm84OXpReW1R?=
 =?utf-8?B?clBZbUUyU3NKVHkyaE5HMkQzalJ3aU9ldW5mUS91K1hlMmNoWmNBWjUzbUo1?=
 =?utf-8?B?WGRxUnB4Mkp3WHJaeEVuamJhVGtpU2psK1dMWTNIOURqdGJMS1ZzWHBTZ3Ez?=
 =?utf-8?B?Um4vNWVYVXQweDVuamR0S09Bb29MRmhsdEdDRjVEUm9pVEVLb0tTMFhBY3h5?=
 =?utf-8?B?Z0RCMm16S3RXVjFoV2hMdER5UTJNeGgxZldOcXRtcDE5YVNIZWF3K2w1QkZ6?=
 =?utf-8?B?RzdWbjJaVTJBZzU2WTQyNkxZZ29IdWdvWTJOK1pWYmhNc2hrNUtaQzlMYzd1?=
 =?utf-8?B?TUUyMjhUcm5KaGZKNE9KSEtaSDZYYTk4Y3IvYmljeVA2UGx0WDRGVFhlU0xr?=
 =?utf-8?B?ZGFucXpLVjVzdDZnVlRURFp6R0lpbVlQbUcyOGYvMjlLdWdqUTlicmF1QW1K?=
 =?utf-8?B?MUxvVk90V1ZnYVk1bnBpUmRBYUs3UGpzblhkOEZKL2NPRENwVkhpYno4emJy?=
 =?utf-8?B?ME1FcS9KRFdmbzlzUjRkUzNiTjlDUkZkU0Yrd0NPbDgrM3N3VExJWHdnbnhL?=
 =?utf-8?B?V09iMGZPRlpIZ2hDNnhiUGEwOTRsS2krclpXU3lWWGRteGUwdmUyUm9iRGZF?=
 =?utf-8?B?WmtBSndkeXlzSm42Lzkyc1J3ZUwrNy8xb0NMQkZtMlV5a1V5V2FqQ1B4azBm?=
 =?utf-8?B?Qk1mQWtjcy8zM1hyNjJ4NDhialFyOFlIWWh4dUtoQlZNZENKU0ZPRjdIYjh6?=
 =?utf-8?B?YUd4V2Y3TGF2Y0ZQaHJhcUwxQlQ5MmNjRE50anRKeWtxT3Qra2wyUzhOYjI5?=
 =?utf-8?B?ckRUOU1JeHZpTHpmUHV0Vmk3Smgxbk9WaDBVbHY4Qy9Mek1DZ3FBOWxBd0ll?=
 =?utf-8?B?dTFwVVpWZWVHbUpLMjVQdDM0dnRFR2dodHg1NHZCVVNEK2Z1ZnpuczNPUnpH?=
 =?utf-8?B?b0tYWU1WMmIzem5PSlF5TmMrQTg0RTlRTEtnUlNhRmcrbDJEbWl0OEovbHNR?=
 =?utf-8?B?MFVTVjd4TTdLUUVhTHB6dFl5U1FNWkVrM0tVRUlnQmxDVUdmeUxsMGhQOHZG?=
 =?utf-8?B?dlZrMHBjbDI4SWlFL0k1L0N6YTRZMXBWVE9laDBHYWlrQTFoY2Y0TGp2WlRP?=
 =?utf-8?B?dzNiOEJOdmEyc2JGQXErVEJSOFlqUXFKMlg2K3o4akZlQ3kzQVQzbmNSNFJ2?=
 =?utf-8?Q?+pRZ0hWCO8lTkY7JwL2p3L+6O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dd0705-1328-466a-51e9-08dd45d8229b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:27:55.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhDSkajAim4LkURsxscaVBAEDpBAtMcLUYNYwByhr2XmIq9i1owzgCVSpIsU0RxJZYG/MDltrxz5r6+Z0sEP6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878



On 05/02/2025 03:31, Mohan Kumar D wrote:
> Kernel test robot reported the build errors on 32-bit platforms due to
> plain 64-by-32 division. Following build erros were reported.
> 
>     "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>      ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>      tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
> 
> This can be fixed by using div_u64() for the adma address space
> 
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 6896da8ac7ef..a0bd4822ed80 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   	const struct tegra_adma_chip_data *cdata;
>   	struct tegra_adma *tdma;
>   	struct resource *res_page, *res_base;
> -	int ret, i, page_no;
> +	u64 page_no, page_offset;
> +	int ret, i;
>   
>   	cdata = of_device_get_match_data(&pdev->dev);
>   	if (!cdata) {
> @@ -914,10 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>   		if (res_base) {
> -			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
> -			if (page_no <= 0)
> +			if (WARN_ON(res_page->start <= res_base->start))
>   				return -EINVAL;
> -			tdma->ch_page_no = page_no - 1;
> +
> +			page_offset = res_page->start - res_base->start;
> +			page_no = div_u64(page_offset, cdata->ch_base_offset);
> +
> +			if (WARN_ON(page_no == 0))
> +				return -EINVAL;

Sorry to be pedantic but should this now be ...

if (WARN_ON((page_no == 0) || (page_no > UINT_MAX)))

Jon

> +
> +			tdma->ch_page_no = lower_32_bits(page_no) - 1;
>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>   			if (IS_ERR(tdma->base_addr))
>   				return PTR_ERR(tdma->base_addr);

-- 
nvpublic


