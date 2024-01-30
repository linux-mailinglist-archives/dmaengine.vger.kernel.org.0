Return-Path: <dmaengine+bounces-893-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A784281E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E8CB20B02
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B27F7F8;
	Tue, 30 Jan 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbH+KAmm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA07CF3E;
	Tue, 30 Jan 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628856; cv=fail; b=XXlHcai1fVFS2kgNjRQ5AQi3KONryGkD9OG+n5HH6okqH15obCAYLlz4CUQk4688UHzRsX088thj81BgQMBFBOiOQfcJ9AmNfoscOVZfKkZg2G0BtM13sLJ7uwnRYrEGQudMXmUUf9KuqcilF+hnayC0nXQPkqEZqm4RKKTgSf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628856; c=relaxed/simple;
	bh=bbqwYWpQk93sa6b3JxvroImKTBgxw3y3ItkXeidlLTU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NVIBUi65qw0y+hjBq/6iwyBN11x1ZYoxvStRJdRWvJEN0UMd+5yN+TCJCgyMYy4BL3otbwZ/WYb3z2iUgW25Co1VPdnuCUlv5Fi1QAY/+lZM3aIUKndWcLegCRjn+FL8cbd+ind6eRi0/97wNjO5ckpwX2nifbRUdt27z3W8ZCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbH+KAmm; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706628853; x=1738164853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bbqwYWpQk93sa6b3JxvroImKTBgxw3y3ItkXeidlLTU=;
  b=LbH+KAmmcbnFzbEsMhF8SVm3zQHBjE0/12x+WeSBrabIIzq1d85XzxD+
   Y7cusvZBhuAoVOM12p6ugiSNDLgOgZyg7cAaY1C3HTxpQJ7EPTih8/kmX
   J7YuUhVyBAgFufE9vtc1pse+Bun5jVuDlYdOm0SS+GMmnkfOE1mm9z2CN
   4/igF+AUxC8xWFfn8AuE3yoZAjV+/w0L/JLzFBd524lqpzTNxDgy1XBV9
   vX6RxylxJVaLHNYyk+SFZjaykFiqlUCs1SvP9fUXvGnZPMhNd7pPvsOUO
   /JGRoGSxXWmE3U0JzWrBHv4ZMv7OjQMNPvQVXJCTl8DaqrLg4BSt8yNpA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434487232"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="434487232"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="30189229"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:34:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:34:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:34:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:34:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuKFVT0Nv7IokVyrbUkLSaTASlUWZjBAyYNhx7NysyBfWWl1oLmvHI5NBxA+e7GD3DeVHUcqZe/Yq5UU2QgtYIaSXTsPNfgKWE2GRxedHhX3D5lCxyYnDSXSbsZk0u01BLtBMP63HuM1kiFXUg3KS0pidAlphEuzQjm1Io++KdYIkvIGHpyjX4+thkT7XrjiyaVQTh2P4rdbhIRrzjaudRmu4w82IDQ4earnRof0gRamLqeXB2wbqLQoOHfQ3ElDAKbPpg4JoNpiLrfKnhJD40p/yQBpgKLXiZ/2Y6xqk3i5Y7/buDr2wVGRVakmh0CIQPZjvA2D9h4tMWJpPiyUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVznw+MJb8UY03Mb+3sEAWtlZTkxQYyMehjp6qHaaJY=;
 b=mCd1OkwH3sFLlTMG7BewS1mWHdlXvBt2DQroDk5+fTsIoSf7c9S8oxAsrbmqbmQdXAUh41USD/XmxZBR2gDsiN/sGyTu63neoYfQMpCtJ/PZOmJ2u+uUdYBmXU5gwjwvrDxQGxDFvDCyug7FA4v8eHMLEFMxhgupwDYWmiv8kQs/T8Jzg/lbFCzyQ7l1qdexbYXFBTu24NsDWT3fQ51k7KY8/wDIILYD2lI1CW421oSu2emWco2MCgzKd0dg0LbvQtCkAbK8XqEj2WRAQaRLLYKJZFRv4vimyX1N3V55m+O6zpoDe9yhz4ShNn5ENY8B1kaB+OwIs4YSz3N/3NaZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:34:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:34:09 +0000
Message-ID: <b4d845d8-24e3-43ce-b1d4-e121f799e26c@intel.com>
Date: Tue, 30 Jan 2024 08:34:04 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] dmaengine: idxd: Avoid unnecessary destruction of
 file_ida
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Lijun Pan <lijun.pan@intel.com>
References: <20240130013954.2024231-1-fenghua.yu@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240130013954.2024231-1-fenghua.yu@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MN0PR11MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 59efc91e-f1f5-40c6-16fd-08dc21a8e6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jbd2CYyOkZiXa7XxOKJ6tygNRY4z7IXtFKg/OBh2N6VvGhPVQc0JJwld9N9ouSMaD1FUn0FQjogkqVyUq6xjM5YMOf+XNCStIxZvwncFzCQfTkciR4JYbUrZVz1QZ/Gk9nvo0itHzaRhsTZv0HaZgjqprpRuyNcqeZU/s8X/Yqs2CQOXWoStU5+YAa+7yr6x+tZHsoG+GYQar5FkE7LYUiRuNoZrUyBztX8vpIT+QtrrAcgYSTNkpUQpji+hBCzbTbazHh6JGQ6ySV2ru1YjbaNY82h2AHdbqVeeAObvUGbJaPdUYjSPG9n0rG+Fd/ho3dHysEorJeTsXm4Ra3m2pDsDJ76phkYmBgVDLSMaAILLf9/6H9g+n8VE81tf+kJlZNx8xKmlyC9kA+/CFr3jDt5erEL1Ug7OlZIqJyeW/76OA6jbhE6+wgCn2GEXIKBHyINkm6CbcGonwmtt2xkmvDKIEkzfJX8qZrWwnQSu42+XglYUijqFyJWn3gj0BfPWHAlUDt7JBbuQpMmQ7/ny3BMPeiBSBvngEMormi/4bxXbC2y87BCq2EM8uG5cPzPNUnBaBOnjhe9hZJT2KJeUPG7fV45bNsMcG1MD/LADNUqcFVyuE5ZE9//fZQichWRX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66476007)(316002)(6666004)(83380400001)(6506007)(53546011)(107886003)(2616005)(5660300002)(8676002)(54906003)(8936002)(26005)(66556008)(66946007)(44832011)(110136005)(86362001)(478600001)(82960400001)(31696002)(6486002)(4326008)(38100700002)(31686004)(6512007)(41300700001)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm43b0Q1blZlclk1RDFBcUpoVjAwVEJiNUtzdDB0RkIrL1NGZzU2TElGVFNt?=
 =?utf-8?B?dkJWRW1kZmlQQXFWN1dNbXRjeFQxTFZIZVE1c0tKbTZqcmx2S3pFMStMc3Vz?=
 =?utf-8?B?aHpYUzBFdmtUbXM0Q0JsKzRSSU1EdmJxK3NmN2xrWE04WUlZbFBlOVFpUFgr?=
 =?utf-8?B?Nnp1OHprQVhQVHhJd1l0eWhVbGVIRGd2a2xVNy92RjVwKy9jWm1IYnl0NldE?=
 =?utf-8?B?UXhaRHplQlBwUUx2amtxQUx2bTRNVEwyR1JMSlVTYktlUTVtcE9XS0hUUkoy?=
 =?utf-8?B?YlpkVktUdzBscVRPaHM4dTRxQ0l2SVdBY2J6RUFpWjZMMllFOG9CVHpWQlh0?=
 =?utf-8?B?NmVYV2xMVEQyOGZJRERHSUVRdGRpZDU1UmU2Zi9BMFUyYm8zUG9TNjk2NUpM?=
 =?utf-8?B?UXJseHZwRENyRGRsbkRBRDU1TU94a2xjUWJuUlpvamVZd2VBU3Bid094dHRp?=
 =?utf-8?B?TWNwTXJBa0JmS0tnMDVuY3V3Rm4rcjIwVERsSUtZb2VDYzVSZEdORUd5cUpn?=
 =?utf-8?B?V21vVVovanc5ak0vS2M5bnAyZVBBTysvM1k0RWlXMlVXR25DVi9HRVpoNXo3?=
 =?utf-8?B?MEd5Z1BVeDBqK2VqNm1SM08xWENLR3djQ1hUUkM0YmRIekJGWWIxT2xhVU1a?=
 =?utf-8?B?L1NxZnBaeUc5T0p6NWVoa2lINFpyazEzSW5aejNKd3JvWE1sMjM2UmpBdUdE?=
 =?utf-8?B?VEZSMjNYMnZyWjJNUmpEUlVOWGxDeWJVczE4T05XdkNUN0pkYlpVMk5Bd2ZQ?=
 =?utf-8?B?Yk1xK1lST0JsYXRUR3dxSjdpdm82RnlhUlRmMmVZaEFNTGFQUzFIcUJORUV1?=
 =?utf-8?B?a3RWK2RuMGtMaUpPR3Y5emJ1UC9lcmw2czh6ay93SUxOY1VCSFF5RWlQdk9X?=
 =?utf-8?B?RFZSZk5LTVo2TEVPZzUwL2xtZnhvQlNFMExrWGV1VndNaG5vcjArK3ovZkgw?=
 =?utf-8?B?SlZEb2RYbG5NMG9SUlN0S3ptUmdaZjAycDMrU0pHT0t6cXZqM0prT2NKRHBO?=
 =?utf-8?B?QittUnFVaXN1L3FhNVlFMjc1MDBjT0R6bFdzUlVhRkJaeDI1YWo1ZGRCeVFD?=
 =?utf-8?B?RzlucTdwR0x4K0NiK3EyN053NTh1ZzloUjd6TkNVWjhGaDVJMWlBMkZkd3k4?=
 =?utf-8?B?R1ZvWHUrenZDWjR2ZTc2eGdncURORjZqdjFxdjFqcTNLOWNoNXNsZEx3TlBv?=
 =?utf-8?B?RHpRQkNPdXJnbUdhaWJKamZZdy9Wb3FvUUV0Yk1LaWtSZzRUd1ZGUzlGcmZX?=
 =?utf-8?B?bkhSZWNCS3dlaXlqZDVlSXM1eTBZdkZLeEEvb05la1pPUEFNTmgzYlFQUTlr?=
 =?utf-8?B?Zm1aN3g3dmptcjFCb3JhWEtMVno1cjU5MStEWnRLQjMrb2VkUHFwaUlhZE5O?=
 =?utf-8?B?ZDFUZ2pHaFh5a0ZLYk4zQ1ZqVlVRTzRLMGxRcWZPaVV2M1hzSG1oK0NDYWFL?=
 =?utf-8?B?TUdYREVTQWplSU1Zd2J1SmpQQ2dxUFJOSExleFljdGZkSkRiYzNWZHYwV2o3?=
 =?utf-8?B?Y2NWdWI0MlVJajNKTTltd0J3NHRwdWVvTUR5Z3pPTjdaS3d6dmRaZkducWRV?=
 =?utf-8?B?MjhRUTZwdzQ5SzFNM0VOZVA3YmJCY3RCeWVhT3VPeE9DcGtFTFNPUk1DU2Zt?=
 =?utf-8?B?MzZ3ZnBsY3FtQ0Q0cWxnRUxRWGV5SlhRS0JLWldId0FvVU0zVldYR2dkcDNW?=
 =?utf-8?B?YnVqazY5SDJBcExpd2VVWXA0VndJbitwVW1FcHVvelBVeFFXRDZORTNydFVh?=
 =?utf-8?B?aHNMNElOeHFCeHE3V1RSd0ltTG9OZVRkVjRkanIwQ09KNlZrZVczN0hCODdo?=
 =?utf-8?B?R25DVmRKZlZzSXorUDhzVkV5K3RHUGdlSysyMjQzZHlrUUFzSWNZTWdZUy94?=
 =?utf-8?B?ck1ZUG10V2Jsd0xiRWdNWjQvVWhVbktrbHZ0T0RJTGlKV01yenVid0k1K2tG?=
 =?utf-8?B?MUI4RnZncEZ6VVNLUUQxU0tDbkgrdDA5Ni81cXhra003OUcyUHFuYmswU1Z4?=
 =?utf-8?B?aTFPckFhZGJtSnNvQ2ZFd0RuOGFMZDBwTFB4am1OL1FMS01GR253RXkyR3Nw?=
 =?utf-8?B?eDE0K2kvOXUwL0d4dTB0NHpXb3p6TExSd0JrTFJ1TnBYaGQxWlc0L0lTVS9Q?=
 =?utf-8?Q?gGxX/xOZMoVRM20cqqiodj06A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59efc91e-f1f5-40c6-16fd-08dc21a8e6ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:34:09.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyyNUd8oCcmJidyAdKy52azSbviHK9+UtI36LJZwIm0Q+rqc3rMCS32Oi5PUu/iXZ0UM8+L/BJ9+dl2jSSh6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com



On 1/29/24 18:39, Fenghua Yu wrote:
> file_ida is allocated during cdev open and is freed accordingly
> during cdev release. This sequence is guaranteed by driver file
> operations. Therefore, there is no need to destroy an already empty
> file_ida when the WQ cdev is removed.
> 
> Worse, ida_free() in cdev release may happen after destruction of 
> file_ida per WQ cdev. This can lead to accessing an id in file_ida
> after it has been destroyed, resulting in a kernel panic.
> 
> Remove ida_destroy(&file_ida) to address these issues.
> 
> Fixes: e6fd6d7e5f0f ("dmaengine: idxd: add a device to represent the file opened")
> Signed-off-by: Lijun Pan <lijun.pan@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/cdev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index baa51927675c..3311c920f47a 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -1272,7 +1272,6 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
>  	struct idxd_cdev *idxd_cdev;
>  
>  	idxd_cdev = wq->idxd_cdev;
> -	ida_destroy(&file_ida);
>  	wq->idxd_cdev = NULL;
>  	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
>  	put_device(cdev_dev(idxd_cdev));

