Return-Path: <dmaengine+bounces-894-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BF842823
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1181C23CEE
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830E823CF;
	Tue, 30 Jan 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YShIi88y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32F605A6;
	Tue, 30 Jan 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628928; cv=fail; b=H2aKCp+o/oy07QBWHD024WrYFDIqm45HacnK/gvLFQGI0E9NjdtDlJXpjeeNn+QtsjaqwPhBBtdqLZo3xrviXgBrrUQxBXFoOUqt39RxekN23L249KFTQeaOt7v6XR7Q7ECY6KoDWpxTpwI9tdtP+1xxW+7kS9evDW37wlPrVt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628928; c=relaxed/simple;
	bh=oqWTTrcGaci5/Dg2d8jhpmwa0raWvyV/SRBW+QWvxZQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifZz+fSV4A+njQtvCppDydZPyQ/XpiVBSoXy0QuwWOrFwTmnRAKgnYGczfVSTH+xLUxGc5C3dqP+IYZBEEKAn1zxVY6cPtpbunYKOW6vFrvsCl6UAR9EPA2Ovzp4k1FMfZOAVMs8Y+BxTF5JB62SNWz7rjqoNa9gDmQuVIPL2AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YShIi88y; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706628927; x=1738164927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oqWTTrcGaci5/Dg2d8jhpmwa0raWvyV/SRBW+QWvxZQ=;
  b=YShIi88yBR7SzW2GAJqjPZ4rO4FIwPvxgw0ZmE4JRDLRsLbnMecgvWH2
   8vypoXzbQ9ZzEr5jpvu5b0veCysgSBJjM3L+hu1esBH9f43LOTOJhWrLS
   c/LmfATHNATsKhWgYCvtAAkyzSSKnzpwmMZ/Eq4R7/Qd7MfYcF/4CxPK/
   ypIfaaPf79NtBT9qVAJjMBEO5hXjXXe8hKC17rfYlKESk4KFGxrbtWNPp
   cMyFMPHIqcGOtsC4Q1v/dJOAmseZHmwfkBpDEaKqVD0Qo4UTvzcDt6Eao
   nnPGLHC88VAMRw/AIZ2v6dtRFa7vRBa1ejs6eoAjaqovB1G0twZUuWmF+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16695771"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16695771"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3830414"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:35:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:35:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:35:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:35:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqrlinfzV1ewubQETq9i3Il/KgKyJeIreaARZ7w8Elct3VWoqIa4wjHeL8gXZK6PBjiu/HNgk8WF9Eifh2TRqI0Wc0XelQCqjy08JJU7p5x4eu0AiLurO/4V8gSDEw34fjbYvQs9UxCAeS02aVMq80Zg9QxsFDPM2lIbl8NtLeVRwTp9RE3e7p2M73s1nlyDlbdj2dIGGrRoHn7vKZLGmBZ/E1GOVBOCnkTf+cW8R1EgDcgo8aAEsBnjvaXa+Qq3qbuYQS6t+yJxHnn69sNTtlVq6Y4G/9Wr+xcGUwlVDAbBhbf68RPOBHH6uCCJccfOmRyfJGnr1y5GsILcoXLh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrCB65Cnn/38C0zbcnChaCnurJZakAiOEgh0Lk2/5s4=;
 b=BLlLZKbM604HKu8qqkO9CxaqHd0yH2MMzQhsPgFdo5oNhZABReCJNqysMsgS0TN5ubaqQNFsD4KrogZAs24Y6kZHq140Wj2EndcZavIuqIZwHF41LkueJ0Ao7DrvbSouBn7kQ6UH8IKfZhaJh8zB7AM0IqHwlvni51Bz3uLu+KpFk6WFR5KJJ1d64bxyZcwtGGMsfWgezEYG6DY39rgZkktztk/yTUFOXZbPFWG5L+IquT3RdcRpAbhM2nH9LmQ1QJAblMhJS+n1BUxHTcRBC686uiBor0dtO7K2kZJMqZioe1zbVh4Bd4s9js6JQFi1Pv6+aU32nbizXxizqYaAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB7451.namprd11.prod.outlook.com (2603:10b6:510:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Tue, 30 Jan
 2024 15:35:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:35:23 +0000
Message-ID: <0de32f03-5f6e-4bb2-aae1-93fd9d9ae49c@intel.com>
Date: Tue, 30 Jan 2024 08:35:22 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Nikhil Rao <nikhil.rao@intel.com>, Tony Zhu <tony.zhu@intel.com>
References: <20240130025806.2027284-1-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240130025806.2027284-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:a03:117::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 055d1391-1f19-4db1-dec6-08dc21a91323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0+RXBASJqZXxEdGQAFl7RTTUASaM+2pNu3Cp3PUiNGkACWuH8KOhS6usjIu107nsup+e3DluHglGPq7KNoACGGKULP9kcLvrMAYnO7B2EVgGyrZsOJGMo8X58nK8P7U14pnJzWbPvTctC6RFd3Xllfq9ES5mnaaYd02cMnwGF5iRhG+rNDi7eeLxdDx/i8DK2pbBpF860SeUx5Edsic5/HyG4l28IEOYHE00Wn9DUlx3oaa8UrmpQcUeSCZuJ03SLp2acGJrZxtO5Y57A96piKCcxOf2NjqRReb9M5uwRh4tk6cmSEPxh09i7OdXKMIhdEQvjtwg5zV6PC5M/zDgoqNnYXYfSCm3aKZmQloVSDf5YAupxrt1cbs+p51NU7bz6Xu4y0BFLtVSLph/R9x4/oHRpPUcSPdgUpXrOYbtX2AWTzhmtGZ1ddLEp+8ASdHa3ttVLqZIIxXq5Dt1q+Ix2lWqGqp1/15R2Ya5EmuSmFHw46siTtLDJZY7w51c30jclZ9vzGtmst0Ymb7NYAoGAC2+YHAyaaPiHziBQdc7/gcdAWh/r4Mq8yoqkGzQ5f+YwZLN1VY9F/od61f6lQ653NXJGrgCjZEMkg8Zeg4TeTdDIn1rWGHj8oXssA5z/d9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(110136005)(36756003)(82960400001)(31696002)(478600001)(41300700001)(38100700002)(6486002)(86362001)(83380400001)(8676002)(44832011)(316002)(66556008)(8936002)(26005)(66476007)(66946007)(54906003)(2616005)(4326008)(107886003)(2906002)(6512007)(6506007)(5660300002)(53546011)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGptMGtYcDNUdzdIVUJmdEplcUUxRGlDNE1vWFNNWmg3SmpwWWNNNmt4Rk9E?=
 =?utf-8?B?OE10a3ZwWk5XWmV4Y1VnWVR4ZWE2cHYrQ0JYczhkWHhjVXFNazlDaXdCbU90?=
 =?utf-8?B?RXZySDdVSHN3OTE2UElyMmI3RVJrVkJTVlNGUDVGanZMRHNEUERsZ3JLakFS?=
 =?utf-8?B?OFdPQ3hmQWE5S1BJRHNBTEtPQ0s3TGFrQkkvZHc4alk2Y2YvN1lvSnRGZ1hk?=
 =?utf-8?B?QnBsWjkxTjRvTlk4Yk1ocjRRTWt1bVF3WnJyOFZhMzZMQVNxUVNGaHFGdGc5?=
 =?utf-8?B?bU1WSzVHVC9Hc3FNM0JHVHlDbkErSEJEOEZqYUJPYzF5ZExKUlV3V2FaRUs0?=
 =?utf-8?B?d0NISGovdHFQT0RjaGVFUVhCMHVXV0U3M2xkVTlZMTVXUEVLaWREZlpFc2k5?=
 =?utf-8?B?a042Q0RiczVmWTcyUXRhSDlodzJSbHh4czdkSXkyeEdVaVlsVXFnVmhINkh1?=
 =?utf-8?B?YkptenFvalBUSWxoK3p2SEhxUzJ6ZHhjRzJvbmFZcGlaUmhkd2JQWkJXM1hs?=
 =?utf-8?B?Ky9ROUk4T3JYV0Fsd09lV1B0enE4RUIwSXVUZWtaSXdiQktrK2FYWGprVXBT?=
 =?utf-8?B?dEo1M3J3cjM2ZUMxbGNrUTFPRHRURlU1YWY2QndUNlhlei9YVnppMUlZWVMv?=
 =?utf-8?B?d0ZPaERnNU43M3FnWTlVZmQvMGVma2p3RUtXejFoRkJjQUw3WW43aHJPNVNS?=
 =?utf-8?B?c1RKR1EvZGxoMlY0ejZyOW5adSs1dWlrbmdYZlhHejl4VjNwQk5DVW9NUWhQ?=
 =?utf-8?B?aXpMcXQxYXErMENXbjNlaDdvU0RNNnVLeU5MQ3hnS3V6dG45NGd5YVZkQmVS?=
 =?utf-8?B?UitYd0Y5eGk1bUZacnhubzVYRE5WZFZLVEVSVU5zWkRPbUhweG5LenNRMC82?=
 =?utf-8?B?SXkzN1kvZHkwYVByYmJYdS9TS0g5aWk2UUFXRnpsUXBRVkxNTEtCaU42M0VN?=
 =?utf-8?B?bC9XdGRwMUYxRUx6V094azJNKzZ6dy9NTGhXRE0vSndKVEhHQ3dIYnNHZ3dI?=
 =?utf-8?B?TWZuOHVVQWpHSUlVenpkRjdiS09kMlRVV1VWTlNQUEpSUThITkFWV3hxbGM5?=
 =?utf-8?B?RUI2RWdzdC9ZZFVHRnFUNjArejl1RXNmYUtiNWkyVGxSSW5aWEpPOGNaS0F2?=
 =?utf-8?B?ZE5WWTBpOUhIanBkOG8zTmNSZFZjVDVRQ2szelRBREVIM0RQOGZvbVBRS0Zt?=
 =?utf-8?B?SmxvbDQzZ1hmazdEZDl1NEo4NjV5Q2ppQlNBdDZXK2JUYW9iL0xVLzQvNnhk?=
 =?utf-8?B?cTB6L2NlTjFxcU9yemU0OU1tOE5uM3ZoYjJycjRWRXhEdzJtNW55T0x3K2Zo?=
 =?utf-8?B?MndvNTdVMkFWZDNYVEpramVVNHZ3R1RZRU1jZ2owZUxwU2Irb3hHNDFIYUxD?=
 =?utf-8?B?d3BrVEZRSk9nUFNjNm1zN2UxMGl5Yit4c2JCUmZDVjFlb2s3Y3RFT2Rzakl4?=
 =?utf-8?B?RE5tQ0Z4WGNHT20vWTQ5V0pXZzd4M3RtazB5MWZGU0RJT0NyOU5UNVc5RFhB?=
 =?utf-8?B?QnJwemtML3V4WndhOTk4cmMybTBLZjJxZnpXdUkzbEhXRkFPWFdjMmdIMkZ1?=
 =?utf-8?B?OC9SS2t3VnlhYWYxQyt2VXczNjIxUEhDMWVMeGhjZlZncjlSVE9HaEdydDdH?=
 =?utf-8?B?cmsrZHhMWFYyWnlZU0kvOGZqa09KVy8wcDV2L3h4OFB5OUl4OHR5SUxvRkFW?=
 =?utf-8?B?TWRwczc3Um9MYjJ3SUJidTh0RnZKL3gwSnIzU1Fmc0Erb2o1RjEybDJBaE9M?=
 =?utf-8?B?TW5ST2xJSUtYb2FTWGFyTnlsNUl5VytaMEhFeDZESDQra29aQlBlZUIrZFhK?=
 =?utf-8?B?QnZ3QlN1c05wYXovQVFNZ0JjR3cyTzhPWmJrUndHNFNERndxV1VrYmlPWllD?=
 =?utf-8?B?WndwOG0zamhQOU9tVUhoczdJaFltM1AvUmtXU1U5ajJrandVUzRHSUR1ZDRh?=
 =?utf-8?B?VEFyUkU0UGJXc0VDK3AxTXVsTXBkQVJOV2NzWGhCdWhKRWd1V0dNY0xoM2NT?=
 =?utf-8?B?ZWh3MytMdDFzYVZNSGVsV0ozYm5IVGNJc25FUVJSNEY2UVg4SkcxbDFhVHRw?=
 =?utf-8?B?dzQxbFdQbVNMME54UEdKQTgxNmpYSGVFTGtQeXZqOU54TG11VUovWThFSFZS?=
 =?utf-8?Q?qRN1SrFtTE1F3m1TWPCzJlafw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 055d1391-1f19-4db1-dec6-08dc21a91323
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:35:23.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joTFEGNGTavPJBDjl1E0y25SpPTyzJUrfOXO45BVOr7gpFa0bNsljq47TUliyiJJb0TzzBd/Drkt7dT8TvXFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7451
X-OriginatorOrg: intel.com



On 1/29/24 19:58, Fenghua Yu wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/cdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 77f8885cf407..9b7388a23cbe 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -681,9 +681,10 @@ int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
>  		 * Ensure that the completion record's status field is written
>  		 * after the rest of the completion record has been written.
>  		 * This ensures that the user receives the correct completion
> -		 * record information once polling for a non-zero status.
> +		 * record information on any CPU once polling for a non-zero
> +		 * status.
>  		 */
> -		wmb();
> +		smp_wmb();
>  		status = *(u8 *)cr;
>  		if (put_user(status, (u8 __user *)addr))
>  			left += status_size;

