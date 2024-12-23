Return-Path: <dmaengine+bounces-4054-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF89FB744
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2024 23:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67309164776
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2024 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2427E18A6D7;
	Mon, 23 Dec 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kxu/ovhB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989697462;
	Mon, 23 Dec 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734993983; cv=fail; b=dqrTGzhi7a76Lt9u5CAJTns319VDMTHGmhNXrZtlbo+27VSuVmreUOvhL5fN6ebx4AeJw6woDi8msD19EIVK8oOOiyRxlg158V0tvEH9HtSwbC+1PwtnOlI64Xzw37JSKoKCKLzidb4LdlKQagSIIP1smRKTK4cvBghSjDDHXOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734993983; c=relaxed/simple;
	bh=tyGp4Q+OfqoGHuL++z67kE2k+Wehowkzec2L4Xqu6dw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+HN0GO9/5+GztAtDYe2MSihJtTn6BNB9s/XzJ3dxRTgU9aSAWcbHFeoyQs57Z8gBz1/WmfXsE2U5AHzyRTaXQG6roV5+5BvLXGwarv9gnGq0H+9N8QwepyIkIB9KD8Y84LO8gTgCrcE+JdOYN1MCpyaGPsQGteGDU4wFvmjFj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kxu/ovhB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734993981; x=1766529981;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tyGp4Q+OfqoGHuL++z67kE2k+Wehowkzec2L4Xqu6dw=;
  b=Kxu/ovhBM2zQiGI2c9lfI1QPtG8y9jlISyQQ8QjHpVWkOWwBF5IfWvXm
   kbmXxKmEbu28ZCwxl+ua603mTSCtlZ/bsap0DAqKGiO86qQThNJlfkI+5
   AG5vbXG7WLrWCRLnamIOAx5zmZOXCAMMqtR7Q8z8yEqz4mvB09sHANmRz
   1cDERG690WT0DtQtFT79MMo9BXsRzn9Z0pln8kudMRL9sBU+TjVMxo4gX
   35l3DQEA0orZOiWahnmQRvthHApL932TjXJ8+dRa/96Pi/5RUFiX+o7Ls
   95XInqytTjldsq4N4A4tdzzyVEgUlLFKAID5KroK65fdhvj2ZUUxRvHF+
   Q==;
X-CSE-ConnectionGUID: tBrX1QvdSNSrcl+TNFt3Fw==
X-CSE-MsgGUID: JesrtGbRSPaokY6VtbxwMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="46151021"
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="46151021"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 14:46:20 -0800
X-CSE-ConnectionGUID: GpKY/daFTaOthIUTbHkTtg==
X-CSE-MsgGUID: 0JfT2H/oQFqXwrvVUTEkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,258,1728975600"; 
   d="scan'208";a="99142171"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 14:46:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 14:46:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 14:46:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 14:46:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZwEqX96MqPLdauH78NnTJFgkOzXvygBpyawpN0jN+1N42SEsuuTAVW07xGDhOjk8DPFPLeZlTmsFhqtTDJNueW1AI9Mp5l8HusiAx4Mq0UXa4GgRwe5Pe60Wrv054r2VbCXEsVITuWTkCPUMpfqS0XJfYkkXr/OFtwMnWBX5jY8AjzCm9SA3vu4pWGsD6YPtOPstez6zw0TIa7bscGBt8qtqT+G0f3G1bI4Gte3pf/RaPKYOSs0lS8shG8hXcAy70GpKLtW6fqMu5PBXYafpIAR3euO3yJn/6QdqQTgtQgg7bLwT2p5cxlVhVs+XydW7zI/OujF+UKJk26pcgF3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDjEJfRoq6p9dkTyibOW69ENTPK85gl5XqfAHYmigsM=;
 b=c36IiMrCBAHvYuI3ssNvPB7RtqNtGdyMr9xj1f0rUvAjb4JC5DFrYjeoB98OYKOiDHcuWcJV2l5ZJNbu1CpSuEHeU6v6PX7OymyUlFxTG807bJGSWLAlaDmRWRobvipNtmTSJdb80E13+IbcRrjrFIdvwp9ZTrdzQgrJwKnSfaLxhYEo6ubItc1+vnHLO3YuWrtzG5ATMzMdZdtpG7JgfP3f0+uqsKwTlUI5dDORNdmDZn40azRvtvLu1KUtNHlqLMJwVZBA+tEFm8XnPfORTPlIypFblMRtYAnOTaDlTszzzQoEIHTkJRznQaGf+EcJ+t43nW7cRV7eXZmf0MxCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by LV1PR11MB8791.namprd11.prod.outlook.com (2603:10b6:408:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 22:46:12 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 22:46:11 +0000
Message-ID: <1f22eb80-0b24-6ddd-afbf-95df8d45f3f9@intel.com>
Date: Mon, 23 Dec 2024 14:46:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Remove unused idxd_(un)register_bus_type
Content-Language: en-US
To: <linux@treblig.org>, <dave.jiang@intel.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241221141635.69412-1-linux@treblig.org>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20241221141635.69412-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|LV1PR11MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d06fdb-ae7b-4ecc-d1fc-08dd23a398f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHg1c09VNEh5QjE5aXhXOXJYTWhrbVlvLy9ZTWNTTjdUVjhjN09JUjBBSnNH?=
 =?utf-8?B?c0ZGOFhLSHA5cHlHZWFTL1oydEI5N0YrMWdNV1crWWNtYU1YYXhXenorT2Qr?=
 =?utf-8?B?bUMrbk1MbUFNdDVNeXcvMzhOcENxeVZwR3ZFK0JRbHFzcG5uL3RQaUlKZDVD?=
 =?utf-8?B?S1hUSXJXamxaM3VuUzZyeFNiWWxtaWVyTFhLZjVrODVnUWVuaTVCSlk2Uy9z?=
 =?utf-8?B?cnZaYkxpTWhIdjNSVldScXhQV2EvNzVXQnNGNUlWcGdqY1VjeFZXSDQ4cVhF?=
 =?utf-8?B?Y3R1YlorQTlSOUZ0NG9PTFhtN0crVjVzREI0YVNMTTVXTkNGZkhpclJCZ3F2?=
 =?utf-8?B?cyt3Y3R3UzdnalEzUkhiVGhEVTBpcjdJcEFCY1M2MTRORHJzZjhXUWRwdWds?=
 =?utf-8?B?UlZwQS9NVG1aT3h4NFBCS1U5TkFtc0VZelJha3ZUTDFKTmVTTG8wTnVvdmF1?=
 =?utf-8?B?Q3hLVFJIV0lVY2xWMDVMVTEzQW1GV3RCUEwvcVBJM1hWUm1TL2QyNEJwUEZk?=
 =?utf-8?B?cEdibE90MnQ1TkFxSkhvbWpZVlM2MExRU0p6Vy9kS2lrQ0M2R3d2SEJnUTVT?=
 =?utf-8?B?RDBtY1Q2UUdPenk3blYvR0gvbkI4YVNCVWNJbmtqQ1cxOEhlRkc2eGJxRUFT?=
 =?utf-8?B?V3oweStJcVRqeEQ5elpYd1g1Vm82Qjd3bmpqTmhnZUFackk0S0VrVk5CdXBD?=
 =?utf-8?B?N3NYYkZvRHhkRzNwaVZlRmtKTjlIa0hVZmYzTlgwR0ZCamVJZGd4UUhmTzNh?=
 =?utf-8?B?N3k4OEdTRWVCU2cyZVBRQytCOXRlOUVaZUpHT1hwSDFPQ1dZaGxSU0tZNVZF?=
 =?utf-8?B?Y094c0J0d2pLUDZFTXhmc1Nlbys4ZU0wdm80NVFZYzFuUU43d3d4alBSVW1S?=
 =?utf-8?B?S2Q0ZUZGMXNEMXBVTWNSeDMwSklmSW8reFh0emJzSTJDcnpFYzVuRndjQUxv?=
 =?utf-8?B?WVFXcC96UlBuTzFWVGY0N2NtSDMxY0l3dURMdERIN2hrQWJtQURFeXhHS2xN?=
 =?utf-8?B?blZKeHBsOTJFRHVtL3J6VHppYnRabXlMTjF0MDhVWGVwNDUyZnpPSUs1VFJm?=
 =?utf-8?B?NVcweFFyQnpnRmJ5aWNPTi82RGx2MW1HRzIxWFJuQmVybEZrRis3L2VheThy?=
 =?utf-8?B?Uk5iME9LbjBHTElXM2xTTGQxOFBLL3pzVkw4dHp4MlNPWjYvTURCZ2ZVdWNi?=
 =?utf-8?B?UFBWVlVqMlAwbW5xempUQWNYWlFYVFdlV0pHTWFoVXovUVhHRGtBQjV0d25F?=
 =?utf-8?B?c2pVZ2d1SEtBTitBTVpKV25VcWxxRGZsV1AxdS9yS3JuRjdzc2srRXA3L0ha?=
 =?utf-8?B?NlRHZ2hqWTVqRDd4RGpiYWNyVzRJaEVZb3MxTXNIVjVvOWJUUkpiTTNyaXZF?=
 =?utf-8?B?M0JEU3lqa1BwbC8wUStCeXdtM3ZMcGpLc05LT01yOVJBNEJjYWxBMlIycFpN?=
 =?utf-8?B?cXJhOXFDWFFhUlhDTHpKWWg0OWlmWk8yWllUZTFJT2ZZaXRGY2VQb1Bud2xr?=
 =?utf-8?B?ekdhZEVpM1JMTlVqbXZpcmRGRkFBVnN6V2ppN2FrZnJubE52UVpmYzlZbDJm?=
 =?utf-8?B?bk5oVStTeWJTV21rUjBCdTcyekNBQzNzU0RDWUU5cWlreVd0Rm5oTVJkQ1hR?=
 =?utf-8?B?N2t5YTMvRjkxOFBCWW0xR3VucTVpMVovMTFtQXdOeVlQQVczU3JpK2RTTW1y?=
 =?utf-8?B?SjhwOWZpQUE5aFdXaEEzR1JlTGtxQ0JialIvbExBc2tSYVAyaGdqdTZnN2l1?=
 =?utf-8?B?WFdUZFFyeW9uZkc2Rk1TTHNKTmszOHVSS0lUZjNHckJpaTVaTUMxZytaZFFp?=
 =?utf-8?B?V0hqeHBlNTdmQlNyczI0ZlBybWwrU0FvQTN3N2VLajg3NTI2Z1JmSWIzenJy?=
 =?utf-8?Q?MLU95HAuwoBHk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NPbDY4Vk53L2dsUmRPcTFQdjlMVTdIY29KWnpZdkExK3dDQVduZnRvTXVU?=
 =?utf-8?B?UllEQTRuRFBqWkJGMVpzVEpQeTB4bE41SGZiOW1abFZPUlBLZzMzWHU4b3Q1?=
 =?utf-8?B?bFZNRjZQY2VaUWFOazY2RE0wMElSelhqS1M4NE9kVkZ1MnpFWU0zOHRMYXVi?=
 =?utf-8?B?ckdmVjd3Nmc5UWxsM2hiVzZPODdLcnFtR3c0aUJZeE9YRXZKaGVIZ0Jabi9w?=
 =?utf-8?B?bTQ0UE93RjhHV0JjWkJJZTZxVllubEcyK0pJVTMyeExXUS9WSkRFY01kUjBZ?=
 =?utf-8?B?NXNETFVpN2JDUktaQjNRMURHcWVyOURvYlFXUmg3UTlFOG9aL3pZTGVHeExP?=
 =?utf-8?B?Q2NqRk0yS1J1aStSYjh2VFh3VjlhUXAySmNkN0FqOEl4QW55dWxtSjBDbVAr?=
 =?utf-8?B?alc2NlZpZWd3NnRSSGc0UnFqK3VQc0xVWnRNQm5HcmF4a1pJYjZmdFYxQlh6?=
 =?utf-8?B?c3lCc2REUU5BOThnWjFTblBiRTVKTkpuempmTGQrdlJpa1lNdzFFUlN1emxJ?=
 =?utf-8?B?QmFUU2hSWnFxWEZCbFFaVWl6SUc4d0oxbVJXS1hic3h6T2lXZVNkWkpHcVBK?=
 =?utf-8?B?UTZBb0VuSWFaTm92ODFTZTQ0VzR3Q2lPdlFtOXVjSlFneGhwWDQ5VTBFcnNG?=
 =?utf-8?B?aGN1dnJ5a3gzT09mSFFIdlNVOVBLem1CcGV2dFlDbFA1YmVkMkgrbElIYmdI?=
 =?utf-8?B?UjhmM0grSFVQa2lnZFZzdk9QUTluV3p3N1hFQUhENmx3WS9hdHRHcUpWRzh5?=
 =?utf-8?B?b25uS0RFTHkrd1JaSWpJeWo3b1FwVXlyVnFybEppTGxKTUF6Q2M4cmJpYUNM?=
 =?utf-8?B?ZUxFU0lyeU1pbEx0bHBnT29vWEhsTDd2RklMUGI1WllRYURDeXB0UEQvdEtG?=
 =?utf-8?B?TDhNTmxZWERRL2l4cWtRUzFKcWZBUmIzMWVHdzBQZkluaktMS1UrMWZpdVdZ?=
 =?utf-8?B?V1F0Q21VMWlUV2dvU0YzYWQ1SXl4WUcrMXVSZjgybit5SGptWG5Ra1I1R3pp?=
 =?utf-8?B?c3o4MTJmWm9KdzdZQzl4by9well0QlExd0RXbTRQc1JWKzZLcTMwb3lRYjFC?=
 =?utf-8?B?azBHbHJrRXcwc2s4dFdFU2hQNG1kcElVbzNhU1ZCNHdScnVvRWdxRGo5VjVG?=
 =?utf-8?B?QTF5RUZFaUJPVjF6TFJZNktyMjc2dktzekxVZXFaOVJBUlFDejhYUXo1QXdr?=
 =?utf-8?B?RXc5YU52OUppTXlSaHhUWVhFU3g5VG5MQXdScFc2VVRFOUJEcVJzZVllQm04?=
 =?utf-8?B?L1crL0l6TndvcTFsNXVEUjBlcmhBK3ZEL3JGRm9sRXp6OTBhRzFWS0tUYXVK?=
 =?utf-8?B?czRaQ1FBVVp3ejNLc3lJOStzSWFkR2ZUZ1Y2eG9uSURpNTdDUWxNSXViMG52?=
 =?utf-8?B?cU5RenNkNzdEQjROWXc4d284UGxSa0xOM0FzY0loek5rNzFZaU5BS3lDSERp?=
 =?utf-8?B?K1ptYVZpREZPS3RpNUQ3Y244cWY0bnhGb1Bja2dLN2RkZjJrMGQ1WUpkTFdx?=
 =?utf-8?B?U1VzbXpWMEZXMXZVVWhoNzg4aTBjRjYxUjJyT244bytpSElUU25KTkVqZE1N?=
 =?utf-8?B?UlhZNWhXenZNV3BycVNQWVo0dGF5a3R1SHpEYjV5UnNjYk1nSXhQUW42alVw?=
 =?utf-8?B?Z1BHNE1Wb1FyY0tKdldJY25KNjVDQ1R6YVRnT3Q5Z25WTEpGVGttekxPcExV?=
 =?utf-8?B?a2JNamVBeWpNNDJhYkgvOGtiVVRvLzR3TWsyNEtmbDFTcXRQYm9KVnB2dGdY?=
 =?utf-8?B?dGo2RllvazJCZ1g4VWFVQzNMbUR3MEp5d0FCVTRZNGJPWWlMYWl6di9VYVJL?=
 =?utf-8?B?dFREM0wxeXNUcm5CbUxIZGRhQWhvMUZEMEJCRGd6YWh1cUhXSXRTcG56VS9W?=
 =?utf-8?B?UHBLSFhacmtucENNUSs5ajgrbU45UFJ2TTVOS2JoeUhmMmtiSkYrTlBGSGZz?=
 =?utf-8?B?RUhNeUtvQTNNeU5RamF2WEdnZzBGVjQ4SHlWZmJMT3ZiYjg4MkhsWjZpU3do?=
 =?utf-8?B?OTRSQTRXbng3K0M4d1hMWVIrVUJXSi9QMmI5aHpwQS9lRnpQRGVGcU9IbWNQ?=
 =?utf-8?B?N0RxcXB2ZE84dkxOU201Z2N6a2QwdjFNQkdoMDZEMnpaVnZOT2FkYlg2OGV6?=
 =?utf-8?Q?V398XG50LYtCPnEH1X917rdT6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d06fdb-ae7b-4ecc-d1fc-08dd23a398f8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 22:46:11.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqDJ/VXo135kgf3IW4PjeOOSnbM7oPwETa1H8q+GnY3t4egvXAlDKAkY3IVaZqVX7hq6GA5Y8tSrgCl4RkuniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8791
X-OriginatorOrg: intel.com



On 12/21/24 06:16, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> idxd_register_bus_type() and idxd_unregister_bus_type() have been unused
> since 2021's
> commit d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver
> to standalone")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   drivers/dma/idxd/idxd.h  |  2 --
>   drivers/dma/idxd/sysfs.c | 10 ----------
>   2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index d84e21daa991..ff33ebf08ee7 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -725,8 +725,6 @@ static inline void idxd_desc_complete(struct idxd_desc *desc,
>   				   &desc->txd, &status);
>   }
>   
> -int idxd_register_bus_type(void);
> -void idxd_unregister_bus_type(void);
>   int idxd_register_devices(struct idxd_device *idxd);
>   void idxd_unregister_devices(struct idxd_device *idxd);
>   void idxd_wqs_quiesce(struct idxd_device *idxd);
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index f706eae0e76b..6af493f6ba77 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1979,13 +1979,3 @@ void idxd_unregister_devices(struct idxd_device *idxd)
>   		device_unregister(group_confdev(group));
>   	}
>   }
> -
> -int idxd_register_bus_type(void)
> -{
> -	return bus_register(&dsa_bus_type);
> -}
> -
> -void idxd_unregister_bus_type(void)
> -{
> -	bus_unregister(&dsa_bus_type);
> -}

Thanks.

-Fenghua

