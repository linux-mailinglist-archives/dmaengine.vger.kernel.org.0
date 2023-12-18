Return-Path: <dmaengine+bounces-571-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70696817CFF
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 22:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1090E1F21955
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154174087;
	Mon, 18 Dec 2023 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqrW56B5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD61DA3A;
	Mon, 18 Dec 2023 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702936536; x=1734472536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+9QiqlMNshoG2GKajBciH7S0gvPxD8WgEtJksw3cOyk=;
  b=GqrW56B5rg1oOTT2z2OcxtZN0HVNPrA1unBK5+Y2VaTERW3qz0eRDsmS
   N6ZS1XMg1Tvoyai4+6trNK1/Rt6qtlLQprVZgSpSVbVPlDj1d5QIw3YuU
   dYvUi1rgMAnMW3aSzqrYcrvpepZMWelf8CIns3PYXd8TDiuo2L01AOjJR
   GUe2fQvZCpryojDv5nNj46rnU7JyPW6xIWVEeewzjweCJENOkQjcKRt1h
   4vgIeQelDFk9uNO1jM/r9QHkHa3y+HIwEGPZryJns1Bva2KpW10q3Wc7q
   8dgJFFyPgzSRjHOYF+DG9AoxFfkpyDJ3OHXLHQksxN85zITrY/AqMLIUD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="462023792"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="462023792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804667535"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="804667535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:55:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:55:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:55:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:55:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ5UgnX95Jf7+N3LyODlyfEgRPB7k1lCQDOu3hv6DXvpV8Vi/8eZVjw25+eUtOiryqddrodmt9xQ4JcBSsK47ejSuLgDT7IQfLa6w1cBhWkmSN5uBOTooXv4LN5lxa2MfHaaGie2RQVTMzBbw1nkJP1d7paqmcvUGrO8NK7MBvEBg0wIzOv4uTY6ewYUkerr9qK4D3B5J78eavGXbxm3WMO+XokiyeYu79thDmWuQKg9G42OhR9pcTD2Ta78rLFjDYU8rDax8bUqx688QSqU41EpNEEUA0NygvHhs7hN5qkUAge5xZzm7zb6d7hhOKzVh8MQIgJZW+o3XA7amK08lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKjWUR9mDWnr9XSU83AvqPMMi6mBbmQB06QiR+UVNZo=;
 b=DZ/KX9Rh+aIkXRYruHIQhpjzMpHp3Z9hdKjgifyVTPAnnF5aHFeAWRBjQ8MnczvMBe5jC0ypp/kCynl8tqJIp4R+bxM2qF3JZsMbxOFlE43YWdiCgSALCkD+hO2zhNi8WuV/RDYgpiptMt5y/7TlyZdPsajIzhS4Ebl532gaukSmVOrhCLTJfjGfqj5LgEyL90blqYAPZ/GD2eQMETsdLY3cq2VYr47sEn6wYYmMaKG2bZ82Gh7oH+D3BRQmbeUkChCuw99cTeO+0lkotdceoSPhqvzivhmnslUem3odK/NBvAXbv7ruQ1NllkN98pbSk/3F/FznWCBm/bSfyZNUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 21:55:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:55:33 +0000
Message-ID: <a7250eea-5fde-404e-701a-152b6a609419@intel.com>
Date: Mon, 18 Dec 2023 13:55:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] crypto: iaa - Change desc->priv to 0
Content-Language: en-US
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>
CC: <dave.jiang@intel.com>, <tony.luck@intel.com>, <jacob.jun.pan@intel.com>,
	<christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
 <20231218204715.220299-2-tom.zanussi@linux.intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231218204715.220299-2-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: c60940eb-5140-4915-ac6f-08dc00140f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo9oHVGC6IL5ysiN1gEUokvJFo267G9O0cHO7CyMZwKkCTSrkW5idBa7TXNMzhq9KhqzKgVf2MuyGNadgrzCMnzQ3qEOdUhW5gwjHexMx2BCRNRJFp9j9X8Fwdq8a44ecWSioEZAtp6KuycwiHPfj7yj3CUtrxmO5p5yW2mLUWqx8hDLw+BOg40JBcjNMxin1VgkZQY5rw2j5/LylaDoiSXa62gsUZ6ggxBiP5G5fO1zr5HjJ02FSOBud4sMQyxx7W+EOQr+YqdsC9RG78vs0FDcuKD/wO7YQezIOVPifa1utaNPVsDRi2carxglULWvD7cHOh9ULTs/y5tMfeeQo5bgs0WgQwFLyzRYqbxI9gl32ghTLbsm5AdokzYo8F3iVmwrQUaazGUXmyeL528CY4MZFOnkMbCYi+hqtAzeaYG/i8VThDSQWYwf4V8+cyttDrtu+kt89YZOGPXaZV1BW7FPw0/4Jw2jVn5koYp9O02t2jBLLzh1ofNd1B32jmQvePPR1gURhMyPJeRGNidDrwljOKnREOcmnqasyOuzLQ0bqAS0r8JyTD0eR9ipfVPz+nUQUG5oUHlnPuQDk1ELr+Tr6JSG6Uqo30hLvVeV++A1urV2rqsN/wh4DH9vRgY+Vl3mhyzZMk7Kyf6kQ63rdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2616005)(26005)(82960400001)(86362001)(31696002)(36756003)(38100700002)(66946007)(5660300002)(83380400001)(44832011)(6512007)(53546011)(6666004)(6506007)(8936002)(8676002)(4326008)(66556008)(6486002)(66476007)(316002)(2906002)(4744005)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpDRmJ2Tk0ySzF5ZGpOMFkxMlJwQVUySmJPMXNjZjI1MHZiR3MrT2ZoYVRY?=
 =?utf-8?B?amRhVjNadHMxRnRzSExyaHR5b29YMldOaVhZcSs5UUdWcDROMjE5VFRWZmVy?=
 =?utf-8?B?eVpVNnIrSmtSdlpkcWd6NzV1dE9GUDRkOHpPMXZib2szWEU0Vm9rWUVScGhz?=
 =?utf-8?B?ZkRQeVhObXNaZVB6bVduQWJPYzY0di8wQjdnYlRiVEZ0TlY4NkpiVVppaE54?=
 =?utf-8?B?dDZrUlR1UE9GeG50Skk3NVBRRktXMGU2SWZLcjZ6TG9wSXZXWGViNEFFS2FP?=
 =?utf-8?B?d0NmdG9zckxIemlZbXI3dDNocFE5TTBUQ1JabnhGRE51emJrMDloWVJiK0Jj?=
 =?utf-8?B?a0kxdFg2MUg2aEhkUGxXVUtwNHV3L1I2MlV2bWtHU2xtVUdxOFV0Q3JMTXVx?=
 =?utf-8?B?cjM0R1lDTnhtZWxXR2FrY0YwTk5ZZnpsTG1TdWtGRThEa2Qxd2g2U1JSQkFv?=
 =?utf-8?B?LzVwZThhS084NEN0UkRCNGVMNGg1bmZSa2FqTks5V0pIU3puMEwwUEY5Q0VV?=
 =?utf-8?B?cWhteW9rcTMrQkpMSmk4S1dPSUJRamlxSDdMMG85YUNPNEdJWWV0VW9ad1VE?=
 =?utf-8?B?Y1V1U0MwQnhQUlBVUWZHblpTVUo5Ly9Ic1QyVExjclFzRXR4NlpDTnZQWnQw?=
 =?utf-8?B?S3IwL3lIRVpVRjE3Z01TSUxseUl5eGJCaVArdDQ4UFkreTlHYnJmQ012c1JE?=
 =?utf-8?B?dWphUUdFUFNvVGlXNGNTVktFc3loa1p3c0VVekVrZEs5c3BzRU1RVnhueDVN?=
 =?utf-8?B?ckxEa1c0YTlzdWxna1JzaDhqczA3dDFab2lhTDVRWDFmRlNQZjBZTHpHWGZp?=
 =?utf-8?B?V0VlNm1lRHVVMHpPdmdRamRaSVhiRlpRRnd0a2FuNEY2ODFmNEplUW5XTExw?=
 =?utf-8?B?aXlCZWR0MGJ0cHdEUmF2YUFid3NCR0JpVEVxeUNhZ2JxQ0Y5MTE0b1c0YmJK?=
 =?utf-8?B?eGk0QW1Zc0NzdGIzREZIcWxIblJ0ZkJTOHZPU1hOdGdxRzFSSUR1c2lRWlBx?=
 =?utf-8?B?cHNyN0d3aVdyZFlaQVFPNWJFa21iWitMWVFkZlhIODRWNlZRZU5MUkFEMXhH?=
 =?utf-8?B?OW94RzFwanVhSmZiWGpYVU1RYm5NNDhqVXJxdVB5QlpicjUwTXpyby9ydlBM?=
 =?utf-8?B?ZFdiVHlDbGtqa1lhdmkrWW9YR1VDUHVmZVFHaEY1cVN2VkF4dEpFQjIrVnd3?=
 =?utf-8?B?blV3WGl3dnlablpOYnhFd2cwQld3TXdJd29IUm90QjE5d0lZRGZuL2s0Yjhm?=
 =?utf-8?B?YmQxYnlNVk4vSHdZZmIvSzN6WCtXbFY5bnVabUw2QmZDOU12eVR2NHNPdFZE?=
 =?utf-8?B?K042ZTJ1L3oxanZLR2NqWDM0N1JOY1UrUG9xZUNVcTJkVHNBYWI0WnZTOUUy?=
 =?utf-8?B?MjRmTHRRcGlUQWtaSUZ5dnJyajRyUkJ6NDBXcHpHbHZQeitUVFdta3I2UG13?=
 =?utf-8?B?U2dZTDJXdDUxRUxnVTIxRElOcWUvTVRHc1hLQ0xIZVlOcGgzQ2lsUFpXRldk?=
 =?utf-8?B?d2lubG4xWWNTSHpRRDJURUxzcDNmNDRFYjNMSVc4Qm1ya2tpUThhM1JmTVM1?=
 =?utf-8?B?Vmg3SlZWcS9IWS84d0E0YlAzYlBPZEhXcE8xUWtCSDZBR0pKNkc2RXVFbWtZ?=
 =?utf-8?B?TUtyM3NBR2tBQlNBUlJWa1VrRE5BYTlvcnJ2Mk15NE1pTXlxWFFOeis1cDMw?=
 =?utf-8?B?MTdiM3VPU0hTQW1lOWlYRkc4QUJVbVI5T0pkWHpDcHdlb1dURitpRnBRK3Bm?=
 =?utf-8?B?Yk0yTEp4L0w3RUFHalpXWENXYngzOUR2YXZNRWNuV1dhUU4wZnpmWEZYN2xk?=
 =?utf-8?B?Z0FLQnVLQ1I1WWtLcnF2dGpFQTRITzNOZ1k3RFNOQWo3N2xTR0VBWnBvdjVq?=
 =?utf-8?B?U0cyTzhYbVFDei90S2VNV01QdTFpZXRsUHd1VUhaZlNybVdXQ2l4L2ZRWGpz?=
 =?utf-8?B?bk9OT2hYOXJNSHFWTXZnck56ZmxEQ3FOV0g0SkJaMXVLaDRzMWEvUVl1TnUw?=
 =?utf-8?B?d3c5Z3FNUFJTNjlSRVhtMFhsL0dMY0NJeWQ0TEp0c3N2RDcySUkyN3MwM2My?=
 =?utf-8?B?SmMyU0ZMNEZNWmQ1OXZXeXEreWlYU2ZkQ3JoZU5MWDZCVU5JZzRxSWE0ZCtt?=
 =?utf-8?Q?tVPsj4NrS5B1VH2sR1hsB3zFu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c60940eb-5140-4915-ac6f-08dc00140f0d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:55:33.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9xcL8UpjcyfoOnf2gO/osDND8K85dqIhp7shazNjDtJ//1T4rVKcp9lbHr6D3C2o0aa4f3GZcB40nHhiGc/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com



On 12/18/23 12:47, Tom Zanussi wrote:
> In order for shared workqeues to work properly, desc->priv should be
> set to 0 rather than 1.  The need for this is described in commit
> f5ccf55e1028 (dmaengine/idxd: Re-enable kernel workqueue under DMA
> API), so we need to make IAA consistent with IOMMU settings, otherwise
> we get:
> 
>    [  141.948389] IOMMU: dmar15: Page request in Privilege Mode
>    [  141.948394] dmar15: Invalid page request: 2000026a100101 ffffb167
> 
> Dedicated workqueues ignore this field and are unaffected.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

