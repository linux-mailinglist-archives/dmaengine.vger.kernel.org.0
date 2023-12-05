Return-Path: <dmaengine+bounces-374-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2524180591D
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480891C2104B
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656368EAA;
	Tue,  5 Dec 2023 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6C1onvc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66641D3;
	Tue,  5 Dec 2023 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701791541; x=1733327541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FyQHcSf5fKXlK7ON7l+O2UQPMxMYRxdJd9SGFHqndCg=;
  b=b6C1onvc07ITOtr+lbtQ46swdxeTBuHmhKz+oMMNAL+bg9YN9O1bnITX
   6gAsR9Vndo94OCLl+LMO0P+u4QpqnqNTJONQIFhmDk84AWmPF8L+m8MrN
   kLMH+nI/5wdhYDwW+U5MsyNlxk3RV5utVWB3orjDZcYjiKFs6tihT1E1h
   S9bvsTTPt1AmWN/m7A6YVr9Ktvq+b1695+G/GV4aAIjq6alXgu5gk9APx
   QaR31NgTQ48Tvjaauqta+kBzXWRA359joTyvYCnaLmTphZcbc7nF6ORv5
   p7viEzU/3m4OJ1zWPebijDf/UkwWThW1tosgy3yr19a+xmaEjlheVCSYj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="756697"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="756697"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="914843624"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="914843624"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 07:52:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 07:52:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 07:52:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 07:52:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 07:52:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ew4ICcCCgK2Gllt2Bj8SF1Ep3IvHORKBF03l3hWBsdkbUf9RypHaPAdtj6Dw4kdYhQX2F3pPCNqJmepegW8q/qD/Cr4OtGUNTuxZS9R1yIO9eelab2eBGOyFjdFm9oAhgQnOCOQ/ZqNA86YltwHjpFkI5L8zChQAO2XhotSwix9PhvQO18d2Ci1bxKEKAoRAWSA6x+DcXi579I2h0L2dm0fZ7kXUPhqiGER6l2E4TYS2Zcaj1qr4iks7qCH6T8AJjZkM+TLwSPr4UIvknvZ+xp911HWqYuBnR1W6+aC1zkWk1jSBByP5CIAl5tQChrxpaoZQq01AWr652nblT+YXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmDqDv2qdMypR3tHFnYwDQtDhziOR9/XzqQ+qByjvoo=;
 b=KgmCeEOqPpbM5fsBWOYyJSn6WRFh2FAAMa5MlzeHtBGZadFoxWS6oXHoSfkMIkIxBbeq3eAhfZuXqmf2i22qNS1mr+qDTxH3/ZbWfThxiYPH8c/Lbs+Q3JPgr5Iv3GY2OhHJDiTxkdQyJEsIn6R7WVEOC3kUtsDo1piqA+pjZjtLqnxddhkcQGmxLt7sfSUJtrdnyUQvV1XVxFlzbNdI8PeGiQ98OHohSJKQFAV60/HLG3EJWNaVQX1nurMESDhXb66kKMo4Gd/r1vqggvDE4liu41rDh4cyCN3IOl1STRc8eazlS1HyRjIFN5/IL4llNYkrvjvYjCQCeZWGzLrLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 15:52:18 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 15:52:18 +0000
Message-ID: <2a193373-ccb2-458a-890f-d48c4b724e08@intel.com>
Date: Tue, 5 Dec 2023 08:52:14 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v11 14/14] dmaengine: idxd: Add support for device/wq
 defaults
To: Rex Zhang <rex.zhang@intel.com>, <tom.zanussi@linux.intel.com>
CC: <davem@davemloft.net>, <dmaengine@vger.kernel.org>,
	<fenghua.yu@intel.com>, <giovanni.cabiddu@intel.com>,
	<herbert@gondor.apana.org.au>, <james.guilford@intel.com>,
	<kanchana.p.sridhar@intel.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <pavel@ucw.cz>, <tony.luck@intel.com>,
	<vinodh.gopal@intel.com>, <vkoul@kernel.org>, <wajdi.k.feghali@intel.com>
References: <20231201201035.172465-15-tom.zanussi@linux.intel.com>
 <20231205092139.3682047-1-rex.zhang@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231205092139.3682047-1-rex.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cd1ff2-c811-4acd-dea3-08dbf5aa28c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOK0UhXG8B/xDbo3wZ3vAaFus/mh9i7LAHjXwdXfeSlk5ni5XHjyTkY9M10IPCGCtGma/eIL2c56dagBJ2WVXfn7uEXiqdFmaHJ4x6LtrAMV7nbCg/22HvMktXzLpxpCcQPRqP2CE5AluFUqclS6HTayonYX0L8Jr2s8HVJETSWngTQLs79MbJm8WDkeKw75HWrpLWUxR6l7iAYnacZuvLF+tZCuTJVtWSPMg8ioMlMRReRDf+EbVHKox05vYjP8ATB7O3G/4oW67yNeDncM5q5T9Mv//226wNdm6sH2mGrdYF4YVrTIQHV16McYbc6gw/Ov7tyC+17sk+CZW+oYWR3WZitzAIUfgCIfOGYCLjAg8rKxP0efYEumi0Ym+MRCUaFs+ti4Nk7qNA0ccF3GMzhhZrwNC0kduEPvNZDO/O+WMOnCFFOyipJ74KT5zX73/vzfyqfSu8k3Blo4CCgOINDoLEFSIzM7JP4IEI3005y2UcFqmhFOH47NbnManRlcbXGNkJiEMFOLWFiKgzs9rujJBZ0R2nki3B/9llPqPkKa4ng7P4/N3Yjm+3y02w0spMr4uF+sPdHETiyM3ZP1WaXqWqjVlq6aXnMY5Ow8pP8xMJAIcVevtBMq0FYawiAf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(82960400001)(31686004)(6506007)(478600001)(5660300002)(2906002)(44832011)(83380400001)(86362001)(31696002)(26005)(53546011)(2616005)(41300700001)(36756003)(6512007)(66946007)(66556008)(66476007)(316002)(8936002)(6666004)(8676002)(4326008)(6486002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBoWXZPbFZxeVh3aTI2RHVUS0c5elhZMVoweXJpWXYwZE02MjBJQmVRcjRJ?=
 =?utf-8?B?SzhQQThzbGFhL3JRZ0lDOUZEMzdvOHc2U1AvbFNQYlQwdjV3RSt5MHIrV1BB?=
 =?utf-8?B?QkVWZDFHQlllUHR1bC9zV3pjZ29WOW5rL1pKTUZKREFDUFplY3dBSlV6OGxC?=
 =?utf-8?B?NDVBLy9BWjFtQ1d1YThlalJPaW5YTkZPUUpBY3l1dmZ2NGFZUzgxc0ZKQWJF?=
 =?utf-8?B?UUdFa3cxeEFOWFRzZ3JUZ3B5cU1uVkx3ZmFhZ3FRcTQ5R0pESXFxempya09n?=
 =?utf-8?B?K2xISSt6dkREV3p4NUdxa3k5UE9BL1JxRUxUY2xsbHlOZ05sKzBiY0lBZzhL?=
 =?utf-8?B?SEsxSkM1SjQ2cm9hVGpld0ozSHArV2tIT1dJTytNYUE1UDBYQ1RZTXB4WURm?=
 =?utf-8?B?KzFxNkN2dS9NNCtQRW52NTRDay83NDdjZytoOGZQOEJFTDBIeFU2TXhGUFpt?=
 =?utf-8?B?Qk8xZno3V0hDaC8vWG94bjdvZytoc2dOMDVYR2duNTNxWjV6eXB5dzhEYnpD?=
 =?utf-8?B?SlJrQXd3Z2pxczRrWnpuTDZ0NDFheXAyaXo3NTZNNktybkI0MjhId1VtcHdC?=
 =?utf-8?B?MzlZZEJPeE1memwyZzRjRXhPdmdKU3Z4Unl6K2dkelRSUTdaZ1h0Vk9SeWtw?=
 =?utf-8?B?T0dKbTl3WTNHclZoT0gvSXpOY1ZOQUd0djBzMVpMSmZGVlVQa0doSWkxRzRS?=
 =?utf-8?B?RlZKZ0tyeHBBTnJNbkx4blRhcUY1WXhmemtwNmwzZldreEt5MXdQdWVjL1dM?=
 =?utf-8?B?OEFBU2dNaXl4SWRZeFVWS1UzcktxdFRvNDdiNlN1dWhyMFBPc1p0cHAyQ1Fl?=
 =?utf-8?B?MHpUMjN4NHlHcHJRWTlBNTZ4cVpta1VsL2tkZFBxcGJNQ3U1NnFaWVczOVRC?=
 =?utf-8?B?cnlzN3lxdmVjeTJHaVVDZWdiM24rMWdwakpuRkFMQ3JyWWNWUVBmV1JDbFA0?=
 =?utf-8?B?Q1BUQVFWZ0dVQ05EQjdHYUhFRW50UEFSM3JCZGZoVktrbnFlZTVnbjg4azJW?=
 =?utf-8?B?TWRxTUl0dkcyTGFhMm9pYmt3Z2ErZjJ3d0VVMFdZeEdkWVJJQlZDc1BjTVZ4?=
 =?utf-8?B?Q21wVFpsejRzRzRRcTVidy8yN3h0US9ENlBoVWNmQUdFS0hwS05RSUJvajlC?=
 =?utf-8?B?TkcyMG1uSDAra2dMUWJvUnZiK25UNno5aENLMC9OTGk0VnV2ZnE5V1l1QTFr?=
 =?utf-8?B?SUZ5VS9XZzE5cW5VZGZiTkRvYWJDZnBCUTZpS0s2ajM4VjZVdS8xNnpjOXpU?=
 =?utf-8?B?b3VJREhMM0YxbUZUbURSNCtqRFVGN01tUFRxVUZhT3l6djRqZjNSeVBOOHdo?=
 =?utf-8?B?cDVnamRTWHhua1Vtd1JSN2RUR3lYV3BpVkZ2TmZnNkFWZnZDRGo3cjRDdnky?=
 =?utf-8?B?aTRMNXduRGVackJZckpTbkIweEVNeWxNRVQxaitHbWtRZmVVQXlsSnZqZFp3?=
 =?utf-8?B?R2VrRm9VdWozZEtlSFU4YlZXMDNEQ2RaM1JUM0ZzNFgyb0F6MkllZEplM0ZD?=
 =?utf-8?B?RFJBcnJHeFl2WDV3R2xvRnFIYTdPd21lcHZqQ0wxNVNlRUQ4eGF6YVdxOW5J?=
 =?utf-8?B?eFFiVkRCdXRPaGMvRkdOK1VoTUZUQTFYK0VBZFFFbll5ZmxoS1o4SzZZcEQ0?=
 =?utf-8?B?UWY4R2JPdEZPc2JDblNNQXhzNUdKcmk1QjVhVVA1dEdoS1VtaDFJUjh3aWJZ?=
 =?utf-8?B?KzlCUStvWDBWOXhzdEo0Z3NkbG56LzF4OERIVGE3SXc3U3NHK01ENGxBb0ty?=
 =?utf-8?B?a3Z4eUFuZHNhMWd4azFqZ2h5Mnh6bkI1a3UvUjBSTEhPcXZKMjk1aC9zc0F2?=
 =?utf-8?B?Q082cWxQMWNONlFYVFU1aFJ2YVNyMVRZbHkrOWJQVjhUdTBBbU9UVllpMEFx?=
 =?utf-8?B?enJXV2JFdzlmQ2dBelhjUjNWZ3pWMWZkbTc2Y29rdWtSZWs5UkRPY2JoNlkx?=
 =?utf-8?B?UFpPSThJdXQ2QVFMQUQyOGZVRy9kVGFWcHZOekV0djV3YjlCYTdIVnR1bHRa?=
 =?utf-8?B?bWp4ZEJkN0tYYm4wenoyN3pzS3hFWlJXVG5SZis1WW5HNmRBY1dEai9WVjc2?=
 =?utf-8?B?b3c4WUJDZlFuQ1dGcWt5YXh2OThUek5xd0ZxcURRYjNRaEU5d1NvQ3V1U0sx?=
 =?utf-8?Q?jHGSFIfn1nWAZb1iO6ENf/uHE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cd1ff2-c811-4acd-dea3-08dbf5aa28c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 15:52:18.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7F3Pz6KSW5rdz3Ehb05cMW/x5oKiSjQhmEQK5/B9LddGqZ0M1Wfr1qeIzK21M8tBsRG7J5QKYjR00NqB9c8TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com



On 12/5/23 02:21, Rex Zhang wrote:
> Hi Tom,
> 
> On 2023-12-01 at 14:10:35 -0600, Tom Zanussi wrote:
> 
> [snip]
> 
>> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
>> +{
>> +	struct idxd_engine *engine;
>> +	struct idxd_group *group;
>> +	struct idxd_wq *wq;
>> +
>> +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
>> +		return 0;
> In the virtualization case, it is not configurable in guest OS,
> then the default work queue will not be enabled. Is it expected?

I think what you can do is just set the attributes that are settable and the wq should auto enable. That may be the right approach to make it consistent with host.

>> +
>> +	wq = idxd->wqs[0];
>> +
>> +	if (wq->state != IDXD_WQ_DISABLED)
>> +		return -EPERM;
>> +
>> +	/* set mode to "dedicated" */
>> +	set_bit(WQ_FLAG_DEDICATED, &wq->flags);
>> +	wq->threshold = 0;
>> +
>> +	/* only setting up 1 wq, so give it all the wq space */
>> +	wq->size = idxd->max_wq_size;
>> +
>> +	/* set priority to 10 */
>> +	wq->priority = 10;
>> +
>> +	/* set type to "kernel" */
>> +	wq->type = IDXD_WQT_KERNEL;
>> +
>> +	/* set wq group to 0 */
>> +	group = idxd->groups[0];
>> +	wq->group = group;
>> +	group->num_wqs++;
>> +
>> +	/* set name to "iaa_crypto" */
>> +	memset(wq->name, 0, WQ_NAME_SIZE + 1);
>> +	strscpy(wq->name, "iaa_crypto", WQ_NAME_SIZE + 1);
>> +
>> +	/* set driver_name to "crypto" */
>> +	memset(wq->driver_name, 0, DRIVER_NAME_SIZE + 1);
>> +	strscpy(wq->driver_name, "crypto", DRIVER_NAME_SIZE + 1);
>> +
>> +	engine = idxd->engines[0];
>> +
>> +	/* set engine group to 0 */
>> +	engine->group = idxd->groups[0];
>> +	engine->group->num_engines++;
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index 62ea21b25906..47de3f93ff1e 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -277,6 +277,8 @@ struct idxd_dma_dev {
>>  	struct dma_device dma;
>>  };
>>  
>> +typedef int (*load_device_defaults_fn_t) (struct idxd_device *idxd);
>> +
>>  struct idxd_driver_data {
>>  	const char *name_prefix;
>>  	enum idxd_type type;
>> @@ -286,6 +288,7 @@ struct idxd_driver_data {
>>  	int evl_cr_off;
>>  	int cr_status_off;
>>  	int cr_result_off;
>> +	load_device_defaults_fn_t load_device_defaults;
>>  };
>>  
>>  struct idxd_evl {
>> @@ -730,6 +733,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
>>  void idxd_wqs_quiesce(struct idxd_device *idxd);
>>  bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>>  void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
>> +int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
>>  
>>  /* device interrupt control */
>>  irqreturn_t idxd_misc_thread(int vec, void *data);
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 0eb1c827a215..14df1f1347a8 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -59,6 +59,7 @@ static struct idxd_driver_data idxd_driver_data[] = {
>>  		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
>>  		.cr_status_off = offsetof(struct iax_completion_record, status),
>>  		.cr_result_off = offsetof(struct iax_completion_record, error_code),
>> +		.load_device_defaults = idxd_load_iaa_device_defaults,
>>  	},
>>  };
>>  
>> @@ -745,6 +746,12 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  		goto err;
>>  	}
>>  
>> +	if (data->load_device_defaults) {
>> +		rc = data->load_device_defaults(idxd);
>> +		if (rc)
>> +			dev_warn(dev, "IDXD loading device defaults failed\n");
>> +	}
>> +
>>  	rc = idxd_register_devices(idxd);
>>  	if (rc) {
>>  		dev_err(dev, "IDXD sysfs setup failed\n");
> 
> Thanks,
> Rex Zhang
>> -- 
>> 2.34.1
>>

