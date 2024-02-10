Return-Path: <dmaengine+bounces-998-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723E85010F
	for <lists+dmaengine@lfdr.de>; Sat, 10 Feb 2024 01:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4EC1C22102
	for <lists+dmaengine@lfdr.de>; Sat, 10 Feb 2024 00:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DC4185E;
	Sat, 10 Feb 2024 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMe3rw3v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7FA28;
	Sat, 10 Feb 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524450; cv=fail; b=tla/bv3LrGLhtkbTQ3uSECr8Fg5WbP5yoSsVbfzg5x+SUwhVlRS8CiVTZLUxmCEfLvtDcRSW+AqW3DhvfcAhSxkae/C88DHywLLRnLeOFfrjygqOx3lO7qu0MMyyaLIzsPScvMvlXGKNyH+5xRUk7mxk5MAqzWBWPUuBK1GVPDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524450; c=relaxed/simple;
	bh=KAgh8l+8tap8lKKerOGYg+p1J+WbsyAG3x4Ft5x7BLw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pocgUXDI6FkTYyT6HFnX95KisRXKMNoD5rYee9klZ/4MOh9Oh3ZER0joB+sLq+XOah6NoG7rBikBEkgLTWBLYsxn+Scc/K6WRXPcCNdLtLDJslFHO1jmwoRggFAIbI/fooLVJj7AJMPgmlOiUTjdgaSASF3o/I6bamgj5JoESqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMe3rw3v; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707524448; x=1739060448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KAgh8l+8tap8lKKerOGYg+p1J+WbsyAG3x4Ft5x7BLw=;
  b=HMe3rw3vMiaUnBjKSe92H2+PERXrnF2fahT7VuTSojWNcuiv2VcD/YoY
   LXFp/LO7q7rwBivRA8JFc+FhQN+Czn5qcGgrN75jKfvm0Z94hvQkm59/t
   uQqcwABmSwFOXj8K6hEX5ogLYtMR427SCtpBw1Cttnxeu83Q/cPsIT4vQ
   JHvmRmOm2TD4ACXmG5iMhSJOpEY6JnSnS/+iz5BObd/lwY1cehVoHARpM
   xT/2v1OKrQ4wgQvfSgIuZTvygL56yCjgI+3qOaOyQJEbDtX4RdI4Q6oMz
   v8ejuL3ZxE83RZhfbsSEyyjvuEkbvNuluxt3WQ6AyyNm0xaJzrWnD1em4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1421551"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1421551"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 16:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="6714896"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 16:20:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:20:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 16:20:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 16:20:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 16:20:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8dMXkWaORngHuIUaopjNisfrNpRm0vR+4ugYVLKhelM0dnw6mmfQYVbQ15qDb+nXx534O00ahgw9/pDZUtLSV1DQHXYzdao4vgwilGj+j5q1dtjDSpedMImOVdPgBrNU2GV3hFX8/sA7+bIVqEbDL6mTk76KsC2JUFJ871wvaeuGOLQNCUDhM14z+KWQ+4quusYDiFgUVf3jbdwRnhNFX4w0MhFR1QpnJIEfslUf43+DT45m2Ah21mbExfxc4eq0lVK1vIIFYB9gPh7JGt3BguNo0nYPh5VUc/ix8kYVtovPb33LfCbPHq+LMZQ/qm67liM7sT/p+oNMCjpnkelmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD61xvIWItEUfYiZ+f55ewT+Cp19vOMd3bdrIVSWAMk=;
 b=X0GmyqRDXNSRVI393e6hU2S357bqnH/6d/LOSVXhutzPzHzuLeSPDDglnb7KH4Q0bq1Heal1k1oETPjacgkzwxh+KxAAWjtFxFjPuH8FQz/iO3yQeHTMmnWFCZAcc6DtgGM5VTkuc369BifmR+6rm309ubNG1Y5nFu6pbkXiGvPdLV7I8uj7F+pzpF/DQbgl3qEwIQc/6vuGi/vQBO62Nf8tVNYUeOk2Q7JNxzHXMT43MMRJnwnXduxws7Z17bHhePkd3Gilh238w4/cH5lwvxGTm96ezphP8y65eX3gk6xQhfD/NRUfY63AdVooMS7k4CmBgEhJWJYeNzAY/L25uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Sat, 10 Feb
 2024 00:20:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7249.037; Sat, 10 Feb 2024
 00:20:44 +0000
Message-ID: <5012d165-e726-e3c7-2a5a-02745dd44f3e@intel.com>
Date: Fri, 9 Feb 2024 16:20:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Ensure safe user copy of completion
 record
Content-Language: en-US
To: Lijun Pan <lijun.pan@intel.com>, Vinod Koul <vkoul@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Tony Zhu <tony.zhu@intel.com>
References: <20240209191412.1050270-1-fenghua.yu@intel.com>
 <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <4237a933-0f61-417f-bbb6-ce5954b304d4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS0PR11MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e5814c-1656-4665-c175-08dc29ce1f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JGiWxvK1/gzNEsKTWQqG5sFK2OjaWoXjDR/fLsNA/s2iDu2c1zqmIQyQ84tyyhVvxaljGfpLUbrQSxJX5BeZ8Vbd4cJBWRSdgd4HgCF0FqinSEDlHDxoVFgJ1XVI1V6CfM3/9MuYO3Y5tdxFx2Z0XX1/T7Mwddc5Xa90sPRb+Ke8+Pvh3L3EvSSzO9T9Rl8RitX7I7e/NSi5CJB3by9eJzDX1MkibEe4H3hmIwEioJKnX0kpYKq6WhRGbQaVARmjdQpYvYKKMT6Jc+VssPbAQa1yAfEkigdTJMoGrBdhmNqhTReboQyrIl6HfC3pJrXSh97u826G0wc0znToFa43oweoThHPmu1hTltvnm4KM0/lKg6Ifo92T8QXFFOEJs60LLsa3ILx96JxApneKWW247gzFT3cHaRn+Ol0ujOID5Z8sVp0UtI50NvTQxPjRMW9B57+Kq/jI8v0ZjJdxIeYJ9Y0ljUKbeofOSx6ei0OXxma058oeutIp9mNkpRLoritRA/ms9oWPDwUGEN0GFgZyPBFXb2RxrqB3uVXDtZCcZ1P5Q9ca0tPzbsCdB/zjKX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(36756003)(31686004)(110136005)(6636002)(6666004)(66946007)(6512007)(44832011)(2906002)(66556008)(4326008)(66476007)(478600001)(6486002)(5660300002)(53546011)(38100700002)(82960400001)(86362001)(31696002)(6506007)(54906003)(107886003)(26005)(2616005)(8676002)(8936002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNJaCtUSjVVT2ZzRmlDZ1J1TEJPeW1LUFhDL1YwUDhXOEdWNzJwdWFJUmtx?=
 =?utf-8?B?Ykxsay9Tbld6UUpPK0o4TDNWaEZ3WUJycWtKRTdOZGRZMzRLVU9VREFiMUZ4?=
 =?utf-8?B?S1ZFRzJLaDlCOGl3cmRnb0U1YmRCRENkU0VYZUhMRkJaQ3NSZ0FyWnpJYUsw?=
 =?utf-8?B?Tm5Tbk1QVHBEbFl5enBCMmwzU3lIWlVJVWVONTVFbFN2Y2FQMmQwbHdLTWRB?=
 =?utf-8?B?NHVPdGUrZXFsVjRRWHNnQ3MxbTFTV0ZTMFpHZkh1VVpLRklxUDI2bkJMdmFa?=
 =?utf-8?B?TnFOS1pmeXpYRzhaZlJ0bUF2YjhqTzU2eVpzNm9COFhsK3dINWthbDBZa05X?=
 =?utf-8?B?WERBUnVDaHJpUGlYekJYc1FOazdjZG10NFArREJTZk1Sd3oxb0VIaXdKNEtG?=
 =?utf-8?B?VlFPMEg2NnRQTDIvSzJUbnVSVlQrZDVJeVhsT1FramJtSndRcDMwRnJmVksx?=
 =?utf-8?B?NkZJZFpaZmVvZStSdDFLOVlJWmYwWG9BcU5kdzN2QmhER1V5bU51ZWFuQ1p0?=
 =?utf-8?B?OTUxV0dPMnJNaTJSREFiUWNSVXdqMDRPNkRmdyt5Q1A0enZMNDgwYk01UHYz?=
 =?utf-8?B?b05MYVE4c01QOGZBNlFUYTdCZGtGYlIwZVZaTzMxQlowTTliVTVBeGpzWThO?=
 =?utf-8?B?cTVJY2YwaEQ3d21menhSUGtTdERuQVhRVmRRYWVIZnY3NEFTZzlXaU9YRkFy?=
 =?utf-8?B?ZEZvbmtzQjFkVEV5VlBLMzhVbzU1R1l6SWRFMHNPMTZQQ1NzSDYvcnBROFZH?=
 =?utf-8?B?SWE4Y1JMZHZqdHFIaC9CK2M0bTRLaXVzbkZMSFExVElCMEkyUWFqL0JQS1hv?=
 =?utf-8?B?czhEK01uTGtJaUdsa3V1M0o1UGh0Z2hoS2E0UFZSVnNDa25KcGdMcUpOYTBx?=
 =?utf-8?B?WHBOM0tYTWRRWCttaVpBdEtHRWhjcjNndm4yL2dmY0hWOXFHbXZ6eTlKNnd2?=
 =?utf-8?B?ZnNQS0FLOWRUelVhRXJ5Q2wwcXdnU1FUQ3pVdmtiUWZIaGdRRmI0UUphTVoz?=
 =?utf-8?B?N0hndVZCK25DQ3ZrcUpXNDNOOE1IZ0UyR0JYckcvaSt4TTFydHpBZnQ2VXU4?=
 =?utf-8?B?QkZaZGFvYlRNa1JiT0k4WGlqU3JXYko0VXhyOXVDTGxFOFJIdDBTSkdTQzJC?=
 =?utf-8?B?eUhObnVQMXNzbXFIaWFuMkc3Q29wb0daKzVIR2xhYi8zanVhZmZtYTMvTVMw?=
 =?utf-8?B?NC80amxuSi9sZlZ4MEt5RlQyWmlJb1lxS0h6bU5mUGpoeHF4aDUwU1F2M3A1?=
 =?utf-8?B?aWxVcHBKQ0RveFcxOHAzUDBCQ1d1aDVNNXZJQ0V3YkVvUmxleHVybkM0UE4r?=
 =?utf-8?B?eXlOSlVuaVBOemU4RFIxMXdPcng1eTFhN1E2bkwyd25DT0RjK0pwSm9kZE9k?=
 =?utf-8?B?a1RFb0p6RHAzNlR5amtyQ1dLUm4zdVpwMVNQSktwN2xzNmdDODJia1JOYzQx?=
 =?utf-8?B?RExYMHFla1cxMkhkQjNBdUl1NmFMNTBGeFA3QjJKUmlwYXRJQnZna3lzYkgy?=
 =?utf-8?B?bHpKUUg3OUJ6Z2RXQ0tjaUt6djJSM1B3NU4rdjNaQTNpL2NqNjNFOTlGK0Ny?=
 =?utf-8?B?dlNiNlB3Qm5aM1c3ZlIySkRsNUZtb1dPampZT2lYdmxmdjhRVXc3L0hoMTJk?=
 =?utf-8?B?Y1lZZDZsWmdENnc4RHh6K295K3l4dHlDWlhneG5vN0E3eFhOazR5WUMrWWJw?=
 =?utf-8?B?OGZCZDYrK29nYldMejdjU0ZQOWZ3d2FnRjVFaEZBbHFjdzF0WnBFR2tnZmpy?=
 =?utf-8?B?MzNWOS9EZXArSFVvUVNCWHhBSEtHYnNZK25GWFlJeXV4QVlxN1g4WDFxYzlV?=
 =?utf-8?B?MFBWeFIvWktmVmVUSFI3dXpnTXBUOUw0ODdKcEZBMHZzNlNmU2JvaXdEZmgy?=
 =?utf-8?B?bVE4RU4xNUFFZWZzRnlPUlFNaURWWUU4Q2NidkRVbk40N0Y0aldCeS9haTdH?=
 =?utf-8?B?VzRKcEhvZm9PdndBOXhIR1VHZVhodGhDbzd4ZWZ4a3dQdTB2SHlxUHppcUZH?=
 =?utf-8?B?ZkFxUFhwL0lzazl0NUp0VG94bHdMOXE1RWxZejd0cnVhdklta05UbDlrUzRo?=
 =?utf-8?B?NzJLQytXbER5aWJlcndLSitLV3ZNbmNVUVAyYlRKdVAwVjE2OWVEbmJhSkc0?=
 =?utf-8?Q?Atn3185bTsqc6NmIFOh7nfuG4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e5814c-1656-4665-c175-08dc29ce1f3e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:20:44.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slJ4BMyADeM0NmXGFuvBh2e5LL2/SKJMyM7YJC0WrBD0y1vEh27D2tycxDBIx3tBxfvijjbkUKkYhDG9Cg96BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
X-OriginatorOrg: intel.com

Hi, Lijun,

On 2/9/24 13:53, Lijun Pan wrote:
> 
> 
> On 2/10/2024 3:14 AM, Fenghua Yu wrote:
>> If CONFIG_HARDENED_USERCOPY is enabled, copying completion record from
>> event log cache to user triggers a kernel bug.

...

>> Fixes: c2f156bf168f ("dmaengine: idxd: create kmem cache for event log 
>> fault items")
>> Reported-by: Tony Zhu <tony.zhu@intel.com>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Reviewed-by: Lijun Pan <lijun.pan@intel.com>
> 
>> ---
>>   drivers/dma/idxd/init.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 14df1f1347a8..4954adc6bb60 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -343,7 +343,9 @@ static void idxd_cleanup_internals(struct 
>> idxd_device *idxd)
>>   static int idxd_init_evl(struct idxd_device *idxd)
>>   {
>>       struct device *dev = &idxd->pdev->dev;
>> +    unsigned int evl_cache_size;
>>       struct idxd_evl *evl;
>> +    const char *idxd_name;
>>       if (idxd->hw.gen_cap.evl_support == 0)
>>           return 0;
>> @@ -355,9 +357,16 @@ static int idxd_init_evl(struct idxd_device *idxd)
>>       spin_lock_init(&evl->lock);
>>       evl->size = IDXD_EVL_SIZE_MIN;
>> -    idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
>> -                        sizeof(struct idxd_evl_fault) + 
>> evl_ent_size(idxd),
>> -                        0, 0, NULL);
>> +    idxd_name = dev_name(idxd_confdev(idxd));
>> +    evl_cache_size = sizeof(struct idxd_evl_fault) + evl_ent_size(idxd);
>> +    /*
>> +     * Since completion record in evl_cache will be copied to user
>> +     * when handling completion record page fault, need to create
>> +     * the cache suitable for user copy.
>> +     */
> 
> Maybe briefly compare kmem_cache_create() with 
> kmem_cache_create_usercopy() and add up to the above comments. If you 
> think it too verbose, then forget about it.

It's improper to add comment to compare the two functions here because:
1. When people look into this code in init.c, they have no idea why 
compare the functions here when only kmem_cache_create_usercopy() is 
used. The comparison is only meaningful in this patch's context and has 
been explained in the patch commit message.

2. Comparison or any details of the function can be found easily in the 
function implementation. No need to add more details on top of the 
current comment which covers enough info (i.e. why call this function) 
already.

Given the above reasons, I will keep the current comment and patch 
without change.

Thanks.

-Fenghua

