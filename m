Return-Path: <dmaengine+bounces-895-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB178428A4
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED37E1F2734B
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82A85C5C;
	Tue, 30 Jan 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTKDi2c9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FB86AC9;
	Tue, 30 Jan 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630524; cv=fail; b=G4Ka3NXxf1UjetFmwrp+zZJKVG6ScEIFbQpBW/f26CrB7Nfl164ChdZ4LajiSYKOyEF5ePRiJNf5IlRYvGXXdh4J0DwsnwjVg+/XhhiqhbUbQSUMgQ1xdyaiXm3RLWynpZW1Qlvwg7dq8JUMkMVHgWthAcyCjWJ0PDLDBguizDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630524; c=relaxed/simple;
	bh=+iNUhEPzt3+4VB+RKpfzU3X8sjRKv58BHWiFOGBE10U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdcMS8oBKzgy8/1pWi2zykXJJSkREjXiJyE+FbBXVp6n9VNGTgnXE5fnHdRuBH6zrZfjLd/HuD4Y1pORvtQ8kzri77s/jn6zfLIXchnLaJzW92JvwTVLGUXijFTuCVXyLoDzv8fbZZT4xjjYTszq53ct/uh9natdwFMZWiEqnfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTKDi2c9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706630522; x=1738166522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+iNUhEPzt3+4VB+RKpfzU3X8sjRKv58BHWiFOGBE10U=;
  b=aTKDi2c93LdmHQLuxe2nlTJ4bTirn8NhOTVncJsmrMPzlQ2eHhC/NRem
   /+OZJrHDA6TZW8aqHb2Ix7e3mTnIk+70dnnnym/YmP4mK8llB/gfUPdXu
   r4g7oP7dTcLZVr8k7g34oAZbkXigBuJhJX9T9LjAuusB0Z8vaXCWs/QrZ
   4mG4jvAESP+6mJNaPzwPrSYV1lL3Vm4RBdxkhn0NDZFtcZg0mTyIfhkOK
   VhVD6vI1Pwa5ftKZlPQE2zQRXqTKze380AudBijcWJDnjBBOltlMvBKIr
   lxoH7Nkz2VFMJ4OawJ4ileUX05srPoo56BSd8nu1TBVxS9Z92LL7XTvA+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24796198"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="24796198"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:01:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3834938"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 08:01:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 08:01:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 08:01:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 08:01:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 08:01:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm/D9KqN+NLXXHUmDGnEqhcLY/wN56onBNgVTYruPTA01PeFxEm3UVrYeJA3f6RUbbXCxq/X1yom75Z95rXDQ2N+4iGlYRtvAzfoVR8BkWH5UMuv9HtBuUf/XUteA54wMbo6Elzm0XxQUCzdVMmNgV2+ZSCc+ikIRfHHHeZuQ5b5VoDK4sz4JS/gHamJO30dchq6bzGZUuc/mNpToa6L13KDZ7jEhKw7go1tWv5cLggyYl880yPjzml0JyN9GFaljIiCxTSF24PMBdyE//uN3nQWj7MoVbJcAp3B0o8OBcxExABtbjnXDjbCn7QP/488TguUCpAUDfJJweqosj/3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOJbr4xyYWGZJZm/VhdRBp0Lj1jf7W+eRJmSVEzRTRg=;
 b=Md34JtRcRnDGZsyyyNn4UToox81nIQZmw0iWTyS6IpawSYlkmeUz5OoRq8qksD+SkpEsxxS2ztrYgOZXCCo6YOPmiEz/na4O/sA1IVHk6EBHGohJ7q7/A1VdHLclLFMqXonG9kiBodnAXAUQU73U3dXzjvBDJz5sWQ4pgIfiBAUOoMbDXJ8DZOj5v8Be/tmod/LDfoiB3rjiJQD7wMOs9d989DU1w+Kk6xCUl0YUfO78yZ2GD+gIbNvBU2vWIOskqIk0W1Dd5pACJ4ldXZ4Yads5pt4N1+NOpa9dMlsokwosxcd32iUSHw4zHV4kWHTZ92agcKGFJ7JnHxRjdKzT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 16:01:07 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::be6e:94e9:76f7:5c3a]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::be6e:94e9:76f7:5c3a%4]) with mapi id 15.20.7228.022; Tue, 30 Jan 2024
 16:01:07 +0000
Message-ID: <49259a2e-4840-4009-aaa6-0c51239c5c81@intel.com>
Date: Tue, 30 Jan 2024 10:01:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Nikhil Rao <nikhil.rao@intel.com>, Tony Zhu <tony.zhu@intel.com>
References: <20240130025806.2027284-1-fenghua.yu@intel.com>
Content-Language: en-US
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20240130025806.2027284-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: da91fac3-d8a4-4687-8ecb-08dc21acab35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/KZNqngahigGLp7btUZSuVyBtwv5zlxUPYFCvJje72WNBZig1T4GhJDK8nf6n08P0qZX1ZGXn9Qr5IZ03Gvgw+TUdrUtD/h+AseIR16idqySRZ+KwHqOlU7b1O5EhW8HeTRpwaAamWuGYQV7Va7sHfZXMtkrp5r+9JE0Uca4A9cc/u38UiumG/QUHleGCdV6pmGsGIgt5Ni93YNe5cbuQOYAgWP7J7jjWBGt5Ns1Cjf9Zz9/lDWHeDOivqwttNk2nClezeCZoo2K88Gic3sGRvh+tzb3cvj/FRrfF+ShJZi4YiQaIKDkn7TM+MAsow6bkx+9TJQSxWGLYb+8cTbge+Gxh7LDsYt/OpC2IxhgwaD0oQXF/ir/91pvpmmBGJKHE0txOj7WL7buJ5mpbhafL7jIXLneAFm6TVB380lanqOLngck3UODfJO3rscNzK3oQEnt2bB08StNXquwlB54V7sq9ZslkH9xpt6XupdFdFLe4uTxypH9F9T+sBKK9aIpjBmIvG8xWveLy1dDS5GZSBAFGw9qUt6+zeSp1tnpAD1ZrTjQaX2IzYKuG7DvIoOT/BMyQy/McOEBG6O7Q19qtJUqVy7rWL12kdCtcYlJ33Z4jOAvQYTVgMqGERWlVXONQlvVDzSsFL6HBmvnyVThg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(31686004)(6512007)(6666004)(6506007)(53546011)(2616005)(107886003)(82960400001)(38100700002)(86362001)(31696002)(36756003)(44832011)(6486002)(4326008)(478600001)(2906002)(83380400001)(5660300002)(110136005)(54906003)(41300700001)(66476007)(66556008)(6636002)(316002)(8936002)(66946007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFySWdRUnY2VU1kZmhXS3o4QkFKS0xDUEtpT0QwLzViY1NXWElEQ3lHWlkv?=
 =?utf-8?B?U3VvU0lYam9uTllZYlNZNEpVMGdjaDBQOFRoM3ZtVjREblMxRXlzdC81STgv?=
 =?utf-8?B?ZU9lZU4xU3A3S0dOZWNIc0FhTWVuQVNDd243M2ZQK08xOGRldFFLbXVielF2?=
 =?utf-8?B?WG1UYlo3Nmp1Smc0Uk1ERVBIMUhYSGpnZS8weVQxZm5wVG9vY0htUndHSG0z?=
 =?utf-8?B?VlB2dHFlQW5qbHZuOXRCYVRLVUkxckN2d3Y2dmw0U2EyMEhEQ3dORVZYNU42?=
 =?utf-8?B?MHY1RmtnWXEwaG4rNkhBNjVyUElyQ05sUEo5N3dmMDhVVWczQXU1bEYrYk9U?=
 =?utf-8?B?WGZBNGVQZ2FJSXpOOXpVNGlsK2tuTTJ6U3VyUlNDVUt0OCtTdDI1N01IdHZ0?=
 =?utf-8?B?YlVKK0FIaGs3L0pPN1hMSjN5bnUxd2R2Q2haTCtjajYyS0RLMzBZdEJVWEhj?=
 =?utf-8?B?VmFlNk0yTUVGSno1U3hYZEpiOVd1Y201bVkyalF3cHNQeUducGZYYjJNZkpU?=
 =?utf-8?B?eUZFVStaakU5YWplOElnWFp4M016anJ2cG9rSUw5ZDdSd1VpN2QrSmpMQVJZ?=
 =?utf-8?B?R3UvenZCbXpQd0lJZlV5TS93T3BPYmdwekVOdlF5bkxBMHV0Y21kOFB2eVZP?=
 =?utf-8?B?RDNYTlUxTW5YUWhhWWE3Z3FsaHVJVG9Sb3g4WVlsbmZZQy9KNVRKRm9CSGNV?=
 =?utf-8?B?Rzhzc0JpZGNsNjVxSGpxd1NiL0R0cCt5VkxIUDFvNENCeGVCejZrOWx3VUp4?=
 =?utf-8?B?eHp6OGkrRjVGcm1iQ2NQRndQYmNSSmJTN21nYi9DUGpBSFRwTVNqV05tQ0po?=
 =?utf-8?B?WGRtTktYMmNNYUFjVGdWVW5yL1hMeDdpcWlxSHlFSTZjMlVjU0laVU9FV2t3?=
 =?utf-8?B?Z1BLOTdrMjd6ajA4MDZsUmFuempJNC82QnErTXR0dDZuWEJzVzhUZTB1blRt?=
 =?utf-8?B?YTFHa09PUURhMDFTUTBOZkVLSUoreU94VFRPb1o3VGtQZWpTYzNWdmZoTXJr?=
 =?utf-8?B?YzR6QnRxYTVGZE4vdlIyckZGL05FUG5YUXN3S2llQXVJaDl0VmVOTmZaeUk2?=
 =?utf-8?B?aWFKaStwMmNsNGZsZ2wrS1UvK2IrcDZOMHRQdGoxZ2xybUJuTW1CcExvWVN3?=
 =?utf-8?B?UmEvdThPZVJwbG9hdWxQNnpUVmU4bmtIWXN3ZlFOQXlJUDJMeURrMklBSHJI?=
 =?utf-8?B?MS8xYzNDaDIvVzJpZWtodG5uL1lrN2tZRWpQSVFOZ1U4azMySm1kREtnNXRV?=
 =?utf-8?B?UlNmdmpkcVNwTzBMbjI1ZnpOODVPUXM0UDBiczV4RzZZL0NiSlRuYWg1VzlE?=
 =?utf-8?B?OVJCclJpUDRaL2hNZk5nVVo1djYyZmg1NkV1amRUOU1vNHRvZG5jaXNGSWcz?=
 =?utf-8?B?ZWQwRWlmNlF2ZkYrRFpBQkpSOWlDKzM0dktEbTBNN3JzN1FQS2RjYWxwWjVY?=
 =?utf-8?B?U0NIUVY1WVVhck9BeEU5MWZGYU5US3ZaNmlZeHZYWWIvb0tVaWRwUmNXVk9P?=
 =?utf-8?B?QlUwQnoxVDBsTVp1a2dwa0lvZ1MrZkZ3Um9VQmNLUUVGTjM5WUxkeHh0L0x1?=
 =?utf-8?B?NS84K2tDNi9IVXlPMTR3bFNZdHBCSzErVno2eGtJbmt1T3MvODA2UFBsSmV5?=
 =?utf-8?B?TnV0MFR5Sm1QZEYxU2RXVEwrbTVmWW9rZERGVSt2dHNqWnczVXRKU3NtTTJa?=
 =?utf-8?B?bHlpN1FEWjk1OXhSNTl3a2FtZ1RvNm44dS9jL0l3RnZXRGRYODJaMlh6d2w5?=
 =?utf-8?B?ZnI3WlRjbER2ME9LYURXV3V0WlJHc0tBSnFqOFFTNElGNC8xMnZJR2V4QU85?=
 =?utf-8?B?NDJtdFFENzBPeWZtc0grcjZNUTVMOTBXd3JaQXhGSmZyYUp3S1dHVVV4VlRJ?=
 =?utf-8?B?K2NqZHU1M1c1MElrV09OQkpheFVyMmdDZkthcUFwUnREN1N2V3ZzbEU3allU?=
 =?utf-8?B?ODlLMGhmak11N1Vyd3JjLytPcjBuRVVSQVB1RjFFUWlDNlM2bHpROXhiUGFM?=
 =?utf-8?B?aXVGeWZHN0YxVHpHdmgxaGtKNUM3Q2R3VUtObnhJQU5lRUZCYWJ0UEVIdU55?=
 =?utf-8?B?SFBCN3lJUmNwTE04OXNaUUxIYU9NQ2hra0JXeUY0bDhubW4xb1p2UW8rZ2pO?=
 =?utf-8?Q?W6IzUYnsipMJlWOmi8KCv6tfu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da91fac3-d8a4-4687-8ecb-08dc21acab35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 16:01:07.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH0DezhrCuKigQeXatC5vOR8pKQ4AGSx3wvN3kxjCBnoDvV4vfresdpar5cbrHDjEl22MSHtvQnfWH7/BYaF/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com



On 1/29/2024 8:58 PM, Fenghua Yu wrote:
> wmb() is used to ensure status in the completion record is written
> after the rest of the completion record, making it visible to the user.
> However, on SMP systems, this may not guarantee visibility across
> different CPUs.
> 
> Considering this scenario that event log handler is running on CPU1 while
> user app is polling completion record (cr) status on CPU2:
> 
> 	CPU1				CPU2
> event log handler			user app
> 
> 					1. cr = 0 (status = 0)
> 2. copy X to user cr except "status"
> 3. wmb()
> 4. copy Y to user cr "status"
> 					5. poll status value Y
> 				 	6. read rest cr which is still 0.
> 					   cr handling fails
> 					7. cr value X visible now
> 
> Although wmb() ensure value Y is written and visible after X is written
> on CPU1, the order is not guaranteed on CPU2. So user app may see status
> value Y while cr value X is still not visible yet on CPU2. This will
> cause reading 0 from the rest of cr and cr handling fails.
> 
> Changing wmb() to smp_wmb() ensures Y is written after X on both CPU1
> and CPU2. This guarantees that user app can consume cr in right order.
> 
> Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
> Suggested-by: Nikhil Rao <nikhil.rao@intel.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Acked-by: Lijun Pan <lijun.pan@intel.com>

some minor comments below.

> ---
>   drivers/dma/idxd/cdev.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 77f8885cf407..9b7388a23cbe 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -681,9 +681,10 @@ int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
>   		 * Ensure that the completion record's status field is written
>   		 * after the rest of the completion record has been written.
>   		 * This ensures that the user receives the correct completion
> -		 * record information once polling for a non-zero status.
> +		 * record information on any CPU once polling for a non-zero

Maybe add "smp system" to the sentence to be more explicit since people 
usually only read above comments instead of the commit message later on.
say,
"record information on any CPUs of a SMP system once polling for a 
non-zero"

> +		 * status.
>   		 */
> -		wmb();
> +		smp_wmb();
>   		status = *(u8 *)cr;
>   		if (put_user(status, (u8 __user *)addr))
>   			left += status_size;

