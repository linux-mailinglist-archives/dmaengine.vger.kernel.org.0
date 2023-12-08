Return-Path: <dmaengine+bounces-426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30E80AD98
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8351C209BC
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280744F8AD;
	Fri,  8 Dec 2023 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kedXGtFH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3693;
	Fri,  8 Dec 2023 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702066353; x=1733602353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ltg83Zlt3KJCP9wQQBHTbdPJtHJssIVnDaaAz0s2F6o=;
  b=kedXGtFHj1hV5qV5orC+0l85q4aHUwrXT7xkHF0v/CvQrXHEph9buruV
   8RogYAuS1wqx9Z276HhJfkvNDRNadToN5mEOjYo5XJeIEjhSAB10fFH0y
   WVVaLnKSvJeOMFFdotf6tDtUT+73b0cq451jOD7spUfIxu6YjMRoJvHvb
   RK06czBsArukWf+/rpcgDxJooyhq1JfOpXqLTEytCa1Z4MNn4Bhe4FKC6
   AD8TPZQI4P4DQu28Hvc9iIqrNNnk15XdUAhgmDYwiVOVzX6LLkmyVc9Hv
   24Om2uXdhsABDFxG6aHgqwTL3CgKMuIpDJ35KQYPyTu6gItyZrlsXpG9m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="394198669"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="394198669"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 12:12:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="765592033"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="765592033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 12:12:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 12:12:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 12:12:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 12:12:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArZnxcKbA7pX64QWxq3h2iFfAxUBz49au6T5yBBGhm+LRKvb4zMmdkp74BAl8Nr1kDS38UyTuyLROi0kZ4Lz3Ln+ljnQow8k4v+vCi4bFeBIf4k+2T8QOEYNOitU0461Vx1PHHnryMIXHtsD5MM7G06a4NkhJ5yyfmmt2bi/duaHNvoUiNptuhTwIt0MKwrhy00wD9+x5xUu0SGYeKu7RAs+3ET8JVI+ZgY4V+uyRTekQFx4ifaP8zXFmZstsGNAQAqbqE6WmlEFqzcmU4W0fkqAUNdmdwE7pDTFx1Dm9vfdQEZA/bvbSPdWVePH/HeXOp7yR6JEeG+bkOVdc68g1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbFXO1uxIULsniwM3N5ohb7RJn6OnefIF6AmXVDB59E=;
 b=KGk52gBO7e2IggikHFj9aHFQc0aitBFd2yqDNa7SKI4zebEp/8Ff6huQ27DUdPMSkcUCWLR+LS04npoAe5DhvVykXL/JNCOL6BZrs1XMJXNUhwzMPA6CMtS34+1KF33BZSdt+3Zy5pxYJDT+SRf0GlkhEBxlJ2DDy5/Z6eQA9pjrPkXOWPivygqB0QzxrRze6ZfxDfwgSd66js1I2kvvfVPrG930aXg9K4umxRJMtjstS+oG1aHfSmbfin8V1eJZNRjXyFon3X3bJOAFKVHvLa7DVX+dm4mt1q/J5XTgnj0sNhC75MBT9KRDokCCTzes55s74+MJf2CyVo7T/mvGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 20:12:30 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 20:12:30 +0000
Message-ID: <d4b36905-d6dc-eefb-f07d-a78a83526de4@intel.com>
Date: Fri, 8 Dec 2023 12:12:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v11 14/14] dmaengine: idxd: Add support for device/wq
 defaults
Content-Language: en-US
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <vkoul@kernel.org>
CC: <dave.jiang@intel.com>, <tony.luck@intel.com>,
	<wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
	<kanchana.p.sridhar@intel.com>, <vinodh.gopal@intel.com>,
	<giovanni.cabiddu@intel.com>, <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20231201201035.172465-1-tom.zanussi@linux.intel.com>
 <20231201201035.172465-15-tom.zanussi@linux.intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231201201035.172465-15-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0850bc7e-7fa9-4f76-88c5-08dbf82a0125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVSeEQOKoArRXTdyjaBjAHXaHNb4ODug9r5YXe3hMns72unE3wFB0bdemL2KRZJOO0fJJ+ZRJRuUJKpacikOOMNPQOibXT32CnRM7E3GvArHGMgoL1zT8rYYs6CZfUgJurbUNrByE/VTGolT+QsWihatsuLtV8wWexhrCHsfV1dxJKMNFWvHCi7gzHXBDnnBjxSxJGRBVfZXTxh3feDtqR46qK4/gOG7MI3R8Mj+Ff12gjXku3vY+X1rO0QsrWpK9/sDUJtbvNYQKg/dk3pEGnOepscLJTqRLHbNuLCUr3DLMP/G9T9rVXMO/ccwPuxvFZYaDhBdfYbbn4F0JumOAvdAS4oFhP29Yr8HqVHX+WkgM0jwtXXG1H3KQSWHNQyaNvgmimvDkHyPWxL9LS77ztgMMRIcmdhadeGgnNeIPipUbC3ODyJyqccC1qMM5jF9OS3BIyesirW0yncaRhVnhYweXlvISsFBcGMOECE6OBeWsI0FEzSdUrJkO0HmHIEf1OjnfEZM0MYe1/NEC9JyM0ueHE9u7ez2cHcP1MrUJZTuVJe/q7vv2G0ILptpiLM5sK8SvXYlbh2s7asGwfs/izpcYWs/Qghgp/KwFc8yzh4auNdFSUnlezy9dnMSJnN9hqAZ1O0DTupJUav3bX+rrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(66476007)(66946007)(66556008)(6506007)(41300700001)(6666004)(36756003)(26005)(2616005)(478600001)(53546011)(6512007)(6486002)(31696002)(86362001)(82960400001)(83380400001)(38100700002)(44832011)(2906002)(31686004)(5660300002)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW56V1Z6dTJtTEowN0VkVE5nMUlNYWRsQjdwR29BdS9rTFVkdGJ1bC9lb3l1?=
 =?utf-8?B?V1pwQlZGL2NHOGVYMXkySkFCS2VXWVBhMmt4N1ozVDhNRWlKZjlTVUkrSXdN?=
 =?utf-8?B?Um1kaFA3bmNTaC9oZlZnbzQ2b2orM3ZjOU5VaVFUY2I2aTd2dERDUEtOTnVn?=
 =?utf-8?B?WFBLaENpb05CVCticTVLV0ROWEZkVDdrdStHSDlnR1owTUhHTVk3VDRSSCt0?=
 =?utf-8?B?WGxFNWRTcGFLRzJWbU9GbjZvazVVOUE3QXU5S1JFY2NOb2RJd0pKUXVZQy9M?=
 =?utf-8?B?KytkeS9DUmM5cXpKa0dCOTJFTHNyMEJoYjJWNzJFbWp1bWQ1bHVtRWFIUHpS?=
 =?utf-8?B?aEJ4aHQyTjRNU2F1dENET0lkalFvQ3NiaDlxZWJKZi85SjJsK0VxTE8rYVp3?=
 =?utf-8?B?bkJOSlBlWXVsZHlFODFibkJqWmM3K1BiNGd4ZUlNVnlzekpJN1U1OVlabHp1?=
 =?utf-8?B?ODJlQ2NUYk1lOU9WYjdIQVA2R21zVkxXRFBBV0tOTHBjTGFBV1FaUGl1bWJY?=
 =?utf-8?B?MDM3R29XZlVNSmJPS1VxT2ZZOHJlWnZtS0JvZ1pzNkJxWTZVc2JWZDUyMHRQ?=
 =?utf-8?B?WFJjUmZkamduVm1DUVNnZ1NNNno4bVZnWkNNMGlyaHR4NDJDT3ZxeXN3U3pm?=
 =?utf-8?B?ZFVEb210NDF1aDRpVjhJRWpUUGZENFNWUXVXS2p1RHA2dkpDOEgyelMvVnNx?=
 =?utf-8?B?S1RzVndWQUgwSHE4aG14LzVoV3FqUUlLSXVoU212Mm9nWXhqak90TU1PUDB0?=
 =?utf-8?B?cGRCV1RJdC9aeFVFZGJTUDJOVFdHWTBMY3NpWE54bWdRa0NWWnJtN2xZQUg5?=
 =?utf-8?B?ZXpobXVXNWxhRzBCbkVsUzRhZnlhaUV2KzlRQlp3TUI2bXVKQUJUcHJWcDJ4?=
 =?utf-8?B?QVBITUZUYVJiVHhJWUpXRjY0OSsyNFJERlZ2NU9OWGhBdldkUDR3ejRXUm1X?=
 =?utf-8?B?MGcwcUU0V2pIOUFEbmNSdmMvSDdXSmF2V2JVbTlSbUFmeWt3U2pmZ2dEWTdX?=
 =?utf-8?B?WUF0ZUhSTHpvVldYaG5iTUprVHZFd05TdXNFc29XTjdpSzlKbER6MHI3VFRr?=
 =?utf-8?B?dzZRMGdzL0kwa0xwdGxTV3NHRmJrZnpRUjJMWTlMNDNCQ2VrdXczbmxRcGhO?=
 =?utf-8?B?Njc5L3UrM3RiVVJmcExwaTlCL3UzUzJJVVcrZ2grZUw2K3h5L1VnZytyZ1M3?=
 =?utf-8?B?Ylo4a2cvWEZEQ2M5REI2V3hSdTJ4RXJmVHpjT1NLdEdDUFZxelRKV2diQkht?=
 =?utf-8?B?V3VucXR5NFpMU3pIRVZ4QUtsNmNvVis2K0FLSlgxTVRHclB1WmVyeVk5TXMz?=
 =?utf-8?B?MWZNUmVGcDc3aDcxZ2NtdjZVd2crcHNBeUE2Vkw1cyt2bjM2RGN4NEJqLzdw?=
 =?utf-8?B?bkxqWEFJeGlRUXVoRlpzSUtSbEt6NGtaUEx5dFVsN0tCSkp4bE5WVHEzK3RB?=
 =?utf-8?B?dnp2c0I0RStVaG85SGd3a0UwUUlvZ3lhNjRtT0E5S1JXNlMwN3ljbENZb1kr?=
 =?utf-8?B?aVpUWjYzdXdDaUM4VUZlYkcrMmNpL0RMVWdYeU5JQlRsbWNvU3BlUGpwd2hW?=
 =?utf-8?B?S0hzUFArSk1IaktZYitpKzdCb1dFd3ErUWRhTG83UTJrSm5ZbHBLRTQ2bUZ0?=
 =?utf-8?B?WGZJVGlOZEFzNEgwTnpnZ0RDVWlQSWpQNkVSelVSc1FBMjFaUW80VStDTlh0?=
 =?utf-8?B?YXc2dEoyRG1NMVNBcURlcS9WbXhQZ1VVOG9RTk1rend1UWR0dUFXUDl5VEZI?=
 =?utf-8?B?aXpRRStaSkJzaldJZHRaZXgzZEU2dmh6a2QzTWpmV1hhQUVlbDBTZlB3QUYz?=
 =?utf-8?B?YVlqbE5OZTNSajRLUWxrNHNydVJraCtkcnR1UGxOMkpuSTdkTWV4OEJ4bnJp?=
 =?utf-8?B?V0xUWlBJMjJselFQWkhmc0NKczJqaWUzMnpVSGwrQ3AzTGdvQVpvSFJGeThQ?=
 =?utf-8?B?MHRMbFpJdjByMVQ0a3lMOW94ckFPUlUxdnJYamNZQjc0WnVmU3lkS0ZXWUwv?=
 =?utf-8?B?MEFBT3BkV1QxYXVaRmdDWit4Q2NsODlkSnBxUldOUjdYVXBNZ05ROG1NeXdI?=
 =?utf-8?B?QmpCdGc5RFRUUFhDSW53WjgyTkhhUFpYSFNGelcrMktDWC9qUFVMWkZsdC9x?=
 =?utf-8?Q?zVZT5VPdGHE/F4U7oBSQnxPQ7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850bc7e-7fa9-4f76-88c5-08dbf82a0125
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 20:12:29.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7bMbGvMygP4nE6PrG+iYvRSxH6mx43AfzuenBv6h/iq+ZbXUyiG0byFL0fVT3mpHOeJjVSvHqpSDf2h3vl9cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com



On 12/1/23 12:10, Tom Zanussi wrote:
> Add a load_device_defaults() function pointer to struct
> idxd_driver_data, which if defined, will be called when an idxd device
> is probed and will allow the idxd device to be configured with default
> values.
> 
> The load_device_defaults() function is passed an idxd device to work
> with to set specific device attributes.
> 
> Also add a load_device_defaults() implementation IAA devices; future
> patches would add default functions for other device types such as
> DSA.
> 
> The way idxd device probing works, if the device configuration is
> valid at that point e.g. at least one workqueue and engine is properly
> configured then the device will be enabled and ready to go.
> 
> The IAA implementation, idxd_load_iaa_device_defaults(), configures a
> single workqueue (wq0) for each device with the following default
> values:
> 
>        mode     	        "dedicated"
>        threshold		0
>        size		Total WQ Size from WQCAP
>        priority		10
>        type		IDXD_WQT_KERNEL
>        group		0
>        name              "iaa_crypto"
>        driver_name       "crypto"
> 
> Note that this now adds another configuration step for any users that
> want to configure their own devices/workqueus with something different
> in that they'll first need to disable (in the case of IAA) wq0 and the
> device itself before they can set their own attributes and re-enable,
> since they've been already been auto-enabled.  Note also that in order
> for the new configuration to be applied to the deflate-iaa crypto
> algorithm the iaa_crypto module needs to unregister the old version,
> which is accomplished by removing the iaa_crypto module, and
> re-registering it with the new configuration by reinserting the
> iaa_crypto module.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

