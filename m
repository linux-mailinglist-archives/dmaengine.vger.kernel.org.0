Return-Path: <dmaengine+bounces-1002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6675B851A4D
	for <lists+dmaengine@lfdr.de>; Mon, 12 Feb 2024 17:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BAC2848D2
	for <lists+dmaengine@lfdr.de>; Mon, 12 Feb 2024 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FD3D3A5;
	Mon, 12 Feb 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3gzOx/a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C89B3D3BD;
	Mon, 12 Feb 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757051; cv=fail; b=dsHHSh73gBDhEsz5kwe3XTavlyt3vvK49CyKUHUwpM3oGd5Xur/euyc+so6FlmkhZr+P+rLP4egD3AE5DIrRTBkWX6tOhyLcx2fl0aP6fBoh5KKHNAHJ4CkEVkVdor7B2DcMXKOedVX6tH6tuIK6h0m6QQjvLOBNMESm9AABiFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757051; c=relaxed/simple;
	bh=QpDstx1OtFcYa5dRLnPVruak7tZOIaGRgjTv+KTdQ+I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LrS5Uyof3mXkz5Z11F5HWvYQhzzy5Qrw6fEqRtXgGuo3Vzcmz93y5Fe5cIpwMUzZI4UxM2/5E1TPCccb/hPli9Dc5jXROA/NE5IoRkwolf5+i342LvAcCoRwGv0ulKOZn0yQJPVDxHAkFLXeI+Gut6zT0pwPNdhT3qFJ2w+5sZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3gzOx/a; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757049; x=1739293049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QpDstx1OtFcYa5dRLnPVruak7tZOIaGRgjTv+KTdQ+I=;
  b=A3gzOx/aT4IAeIZ7IvqnV+AQs8EM6PzAEubWq45nzfP4hs00CtDhfOIs
   Un6MAcwK1Sj4uc5Pnum7fN0B0e9tFdswcVHmdaj9Xqxx7eTU6JwI9bkIV
   vMfULChrDe5LH733wyatA11Dl891fkZwpwaCl9sJAFa8ga2eRdwVl/GjR
   alnkw0pNYxMkNPhAtFjwlfSZStgXK/ux1dpupFnMmGB5CQafgV5tSQyDo
   u3TqVtea+c+h+dzogiPvsTtXPIerMCdKHOOOUyY7rxGTGMpiyD/obxT9N
   syrXcoib1ZpFZV1CaKrnDepxtGjW6P3+OD094K5cmBKwViS5isH0Twvr2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12470260"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="12470260"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="2676418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 08:57:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 08:57:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 08:57:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 08:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfZpBk1svIyqVbHbH6XUSAL3jtJFH95cz7Ukv0ykjuaUSOJQB/CS3/q1tbHaSw7L4XCyvlTuXuzKocKtyvIEYfYG925hiYlYklDiNkhAIq0esyTGDYkwiLfTSFUIYqVdw5cujdIuh+/ULK8LiP5wNwrr6Bwi3GcWB41PstWhk02f7k7qgI1sVLBVOd6GlUe6TsuyQQh112XvdBTa8S0MywvJo4NvF1IfEGWgpBaig2nX3FxjlxkLr5WKhH82y2uun0jSN0RN/gAUrJj5G6a6IiCeID6krClzhFmyHnHS89t6+jE0dDwI5BeCeQWpjijKAqmoEbfosoXTf49DVxqlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnuldxldNpBMNC0BliwxPA/aEIon4tgFVbU6sNWZTUg=;
 b=oOBtp9Sy45WI2ww2oqsULkcBzs2QOvXceRJsncaSZ9Wkc9qA9kFQQX98SzeWSwdMccbZkzY98O6Ebf+supsLDRrvVvdWRh1o+ukDs3MP9dmWnE1HeF3nWhNC9gVFFbQejBCszRM4E/loM2r5O95hCH+qBMCk8u1shhN1xjoE7XQjBMdrI7+Zg0aUEZwhOwCE//gFCVD47U/8aTrVcu0W/EpORDXJQjq6zozQJwHXubmb2Ln0gjEuz0y9ODcAJbf4dsWQI8/CQeZtDyJLL4tVvSGYWLi01i/e/0zxO/DkDWRtPW3dYxERBND7t/o+tUsVjaW7KQX0aR4b2adrf6A9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 16:57:18 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 16:57:18 +0000
Message-ID: <f1b96616-296d-85ec-3e59-54b6035fa954@intel.com>
Date: Mon, 12 Feb 2024 08:56:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Clear Event Log head in idxd upon
 completion of the Enable Device command
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Lingyan Guo <lingyan.guo@intel.com>
References: <20240209191851.1050501-1-fenghua.yu@intel.com>
 <36895817-8f71-461a-93e0-5db1a39cd3c4@intel.com>
 <18761e12-822a-16b4-fdc5-0ac889b1693c@intel.com>
 <c643b6a3-0f41-416f-9268-3072f76939e3@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <c643b6a3-0f41-416f-9268-3072f76939e3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 50178d03-e1c3-4a01-7088-08dc2bebac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsJ5gmk4kLwqof2VKwc3aGFOnJdFtGrqE1AnaQPIzUCN6vSvd5Ps6iblnaRmoAvJXmtOb9iGcZ1RpXhSzFOhcNwP3LnPGmJKzK68cU1PZivDwPUgDYJ58d8JH5I6bSspxi31RqNazL3qWSsaYnSp3G1f/dAyqQ3KzFYiyNbsRuaGxLJ5jhzT5QGLPfbfmnCAfYNhdrovtIsCtoyyVszqNHukplwmKQUI9wrNUrLg0fG6lJfEeyeco/Yl0w0VsIzL2F17Yjd4XfbhzjnX/HVJbL7ezD6rGvLKP67gJOJeVGKj5gdb5Cwal8cXLUodFfFRmRcLboeVhQMUrY7JFs099BlJlCpkQgsSwHCiyXwBslg9gr8AxNc5lwTR0Y20pcOgQT1Qwe8bkghR9KyK2yYrEO0d10tC0oPf1KXf1PAk6JrfqoDyUDxekrf3zuAuxEgPuht8hQScgU5FaP+GfT34hMhNZkXIevOl0ny5zsDnOQGJCwLECTv3nefqaAi6Zur4SJMyPSEHX91HPdcXYrqBoDAcx6tr/q4A0po937feZ6Ycjg2UwkQOGivdgHzqJqTl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4326008)(8936002)(8676002)(110136005)(316002)(54906003)(66946007)(66476007)(66556008)(36756003)(5660300002)(2906002)(44832011)(6666004)(38100700002)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(31696002)(86362001)(82960400001)(6486002)(478600001)(107886003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmUwRy9RdC9XWm9uVWdSYkdVL1JEbkpJd2NWVENRM0JIUHJqUGxqMnpSR0I2?=
 =?utf-8?B?TG93WlhERllWOWFrQmlXWmR0bzBCbE5qKzcvenFPMTlNTmVxYjc5Qlh4NWNX?=
 =?utf-8?B?ZldVdEVqakNRbGYyZTIzOUtOeTlsUHBjUFBOTnBaelBVVk00Q0tzZXk5QjJR?=
 =?utf-8?B?cExTZXFURHhKVWRRSkN4Rjd6UGpKQk9YdXdpRFcxcFdQYUw4WktiUXdjVm5h?=
 =?utf-8?B?TWdwVUdObkJxM2lJYUJFYWxzWldxRmR3YWt5aTZYbFFSTHl0R09kK0RhdHBm?=
 =?utf-8?B?OEVSYU9KdTRPcnIwUGpVRXVIYkJnRWNiVFE5MVI3Q1VQZG16N0VjZEJMQnNo?=
 =?utf-8?B?UVQ0eHlzdzZOUTVxa09VTEU2bksyN2svQURIVHBxeUNoOG1HejNmRU9uYm55?=
 =?utf-8?B?NTlmblZvQTJxeDFCQXhpd0NPdktpdUp6WWtnWjF1V0xtZms0V3VoZVlkd3o3?=
 =?utf-8?B?ZzV4dUF3SlpxbVErWk5iaTQ1OXdiM21KeXJWUTBuZTROaTVLZWhMNXBzekFW?=
 =?utf-8?B?WjlDdFdDVHpUSUJDT21hMnJmQy8zKzNtanhUV0xFRDhWbmdRLzZ2UEpzcWhG?=
 =?utf-8?B?VTBTWVZIdThQcG9wQ1g2SUR0Q0FKbEhyYk4rVi95MFBzLy9lR3ltSDRGRVI2?=
 =?utf-8?B?MitpdzQrTGFDQlpEVXNSWUFvWUlIQ0NMV05UNDRXUE8wTGlDV1VOYlIvZ0tB?=
 =?utf-8?B?OGFXcStzOWxJbVlsMmUvQnh2TmhCTWpVTHBEUWdMNWcwbm10YU5aM0hDRENs?=
 =?utf-8?B?WFZySkxXdDdDbTF4N2tkelVVSm9SSnZib3pXanpiWFJ2bFlrVkZ0SnoyMzMy?=
 =?utf-8?B?b1d1ZTBBUjNCeHFiTmRCcEZ2bS9wdGhETHJUbzAzOXh4dUJJM2liNDUwNmhS?=
 =?utf-8?B?UDdjSER1blVrSjkvVVRyOEtOcVczYkRTQVpHK2JGQjNJdStPR2haUTlLRjh6?=
 =?utf-8?B?Ym5la1J4K0dqd0RYNWp5cnJMQ0oyc2Jtdzkvam9BbGtGbEQyNFFEYitXdUJP?=
 =?utf-8?B?S1JYc3phbjg3M21tUWY4Tis1Q1d4TG4vUmJSN2owTWpVb1JCNU9NbGh2TjI1?=
 =?utf-8?B?ZHY0eVRVUWhuVmFsaXFGYXlpZkxRQXgyVXkwdTJLL2Nub3B4bUt0akdHd05S?=
 =?utf-8?B?ajQ3ZVZ2Y0tiVSt1eFBqTExiUjVndFh5RS9RRWlYUzJkZXRSK09xVERDcU9h?=
 =?utf-8?B?U3YwSm5yNEtFY3lidmRiL05RdE5FdWg3R2l4OHZPYnBRYXV1NTdhQ0wvcVBk?=
 =?utf-8?B?Y2VoU1ZFTnpMbjl2OUFIVXdvd1ZrajcxZkVYdmptbTdUNnBiVVNWU0VJK1Fi?=
 =?utf-8?B?WlpaTWNUMDBMalJVMzg0a28va1N1bnMwWUZFMHVsM0F1UmtlV09vNFIwLy9Q?=
 =?utf-8?B?OWIrVVNPZHc1cXF6NW1xUnN6MXJzS05rOHBCOVh2TXpRdnFISmFNZFZaSWVR?=
 =?utf-8?B?MVA3K2xpREhmbjhocVpiSGV5dTBlUjBTcjBCSEp5eUdsWDhmanc1S1VHTWpJ?=
 =?utf-8?B?Q2E1a202T3N0NGxaMkEwM0VqSUlkVkZmQ2Q2aHZEcEVCQXRCYkxKMkNyY3Mx?=
 =?utf-8?B?NWk3UkFKMyt4VTRnd3ZDbnk5aDBuRG9tc0doaUVqM2VGUW1uSUpWU083ZUZv?=
 =?utf-8?B?a2UydlNVRjIzMXU4MzE3RGZ2N1RGQXUxQTZUbjVJTktuNWJSOFNlVlFiWTZO?=
 =?utf-8?B?bXVTTnUyZWJpcEs2eUlXT1hwdTZ5VDZ3YmlEcWhXZXQ0cWpUK0dJaUxuYzVZ?=
 =?utf-8?B?NElUaFUwTDF5MjRpeXZYVGRTanFwZlNiSFREeFp1a0ZkUHBZOTZsQnBMZFQz?=
 =?utf-8?B?ZkVITWFEczBkWnVDZVc0bG85YUk5VXNpRVl1Ni9nS2pKcmpmS3dJZHppcWJu?=
 =?utf-8?B?MWxNcEJrNEpmNE9JRFFWYmlMK1h2NXAxL1h1RVRXSWdKNHo5d1A4dS9UZS96?=
 =?utf-8?B?eGlZWTJHVUh4MWpXRDVIWFlvcVpyVjkrRkNMeXYyOGZHUDE4VEhqeU5zZW1t?=
 =?utf-8?B?eWNjUmNBZWZuVHQyOUdiMnJDRGNkMTFCZnpIazY0OGQxZ1MrbXhYaHlkaTB3?=
 =?utf-8?B?RWlIYWxWQjdUNzNONE1XQ3AxMUo5U2I5ZWkweTJLejgvSWhVbkR2YTBjZWFE?=
 =?utf-8?Q?QU2NLFyhGUEgstqpWrgqrm9gi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50178d03-e1c3-4a01-7088-08dc2bebac19
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:57:18.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3pPB5oZNEJaq8jLYoDebvRiH+j0ztKJUkyacDUzbc092HM6AJSPk6z/yTqyjft5wczbw3vEtNXWbMCHIcdq8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

Hi, Dave,

On 2/12/24 08:39, Dave Jiang wrote:
> 
> 
> On 2/10/24 6:49 PM, Fenghua Yu wrote:
>> Hi, Dave,
>>
>> On 2/9/24 12:17, Dave Jiang wrote:
>>>
>>>
>>> On 2/9/24 12:18 PM, Fenghua Yu wrote:
>>>> If Event Log is supported, upon completion of the Enable Device command,
>>>> the Event Log head in the variable idxd->evl->head should be cleared to
>>>> match the state of the EVLSTATUS register. But the variable is not reset
>>>> currently, leading mismatch of the variable and the register state.
>>>> The mismatch causes incorrect processing of Event Log entries.
>>>>
>>>> Fix the issue by clearing the variable after completion of the command.
>>>
>>> Should this be done in idxd_device_clear_state() instead?
>>
>> If clear evl->head in idxd_device_clear_state(), evl->head still mismatches head in EVLSTATUS in some cases.
>>
>> For exmample, when a few event log entries are logged and then device is disabled, head in EVLSTATUS is still a valid non-zero value. Clearing evl->head in idxd_device_clear_state() when disabling device makes evl->head and head in EVLSTATUS mismatched.
>>
>> I haven't thought a failure test case when they mismatch in these cases though.
>>
>> But while thinking evl->head more, I wonder why is it even needed?
>>
>> head of event log can always be read from EVLSTATUS instead of from its shadow evl->head. And reading head from EVLSTATUS won't degrade performance because tail is always read from EVLSTATUS whenever head is read (no matter from evl->head or from EVLSATUS).
>>
>> To avoid any mismatch issue/trouble, I think the right fix is to remove head definition in struct idxd_evl and always read head from EVLSTATUS.
>>
>> Do you think this is the right fix?
> 
> I was to avoid register reads during event processing. But if you think there's no performance impact then feel free to read directly from the register.
This code reads head and tail in event processing:
         h = evl->head;
         evl_status.bits = ioread64(idxd->reg_base + IDXD_EVLSTATUS_OFFSET);
         t = evl_status.tail;

As you can see EVLSTATUS is always read to get tail. Reading the 
register to get tail cannot be avoid because that's required by hw. 
Reading head from the register won't add additional cost.

That's why I would say no impact on performance without the shadow head 
in idxd.

I will cook the v2 patch by removing the shadow head.

Thanks.

-Fenghua

