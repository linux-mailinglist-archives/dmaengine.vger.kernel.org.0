Return-Path: <dmaengine+bounces-1041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF185AA0F
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF2C1F22EA5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304244C93;
	Mon, 19 Feb 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrXUpD3p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09540BF2;
	Mon, 19 Feb 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363902; cv=fail; b=euVngjdde5w0Q3svyE1pPRs821nmaqvqlZZScR6gQenM/5jqvfKYaIhw/bSoCeHskegldt4I4n8jD7OLwojhwRaC+UlkQD81N88sgxnLS9vq4y7zi+yBMsl6XAN8Wu5QSr0jWSE0j8C1eWfGS8eOV6dA6oM9+x/J36OslfthWbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363902; c=relaxed/simple;
	bh=yNNvkhrqXQ8X1Z6JWmAGVJ9A99aE25YCtIagxOPt9e8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7fXefY7Jkl+Y6OgVSczdD0IaM/Rp+Zj2FhTt1eJ8WD9KuGGZv5YnJiSuTVapv1Vp78a7fGB3ZLLN5WTKYB9cK2qI0yxJ1SNjMvrBciR5FBeBPePbv+jc/LpcLXzqDPX77E3oa3fvQNdrI1J1Lb4Bf2oeEPyxuSepQPiywElfGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrXUpD3p; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708363901; x=1739899901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNNvkhrqXQ8X1Z6JWmAGVJ9A99aE25YCtIagxOPt9e8=;
  b=VrXUpD3pE6xWERm/sNGqFfYG7uwF3E/XQvdBSG+Ym2LE16n7BqGy2/K6
   2FAge3scOnmD3Aw4U40qhr50t8RJNltIyiZ4PSDh0a+h9s0kp9OMUOAdQ
   /i5vlK7PNj2PXTUkzZbp8CLOqkqyI4QsR6V8Uft4YrqffXdYmusU6ieIY
   xZG9a7dIxN9FaIISLCvW7y1vxkinv13QrKLtU24EXg8aJYeRm7RPCkDyN
   BUamJk53zZvNx0nrJ+mLjseAt2xA2oNHzBQSNGk+/8OqkomMqTZYUB+Yc
   8xWuGI7xP8AgPM6VJ3oTcBM8vUcRReI6ru6b4b2GBmYWPrG7bPmLYWqEE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2596416"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2596416"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9208724"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 09:31:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 09:31:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 09:31:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 09:31:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvIQ9SuYYN+Z2UCzY+vVR6K+U86I7ULLroJ9mr2uqpMglkmtq3BYX1zw6+Fae8CuPUjrbQGxVnln+SEsN+bw5KbkokV7KCGlNllT2+fsOUloNvMk8SsF3y9cgc+PcWaVmLKZrWGkz4rSKuWor93e9Qmuhyi78QPBq/NojyVe+dQfQYkw3hBzLZcQceFvoWEiupFRgpficd0+TnxuspyUYTqB9qdsZcRyZZKtjDFw3FANeIPxP4LOe3e3tHOe518F6rOKzJR4FFVDOoN1Xadwbca5NkYyBs7J13+8RYTFhZfwBQ5MFKYbSg50rr81lif4mftg+IC/sxCp+orFguUB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4EdRhzAW0UPlke32OnA0P3RZxVMuLfNm9YQ5zI58ok=;
 b=msR1KUmYo13HoaIsLVLZeQQ3qO1PI+5KNI35oqjXV6n3ZoUb815n/+NfIGr2V5YbvXG7FnbfErS5OPX7EYJ/WxKV8+ZlAiBGQaBPRQBdX1KHMLcC7fBopwXIXMw55XftrB84zyFAPRPFg6ebV7UwDBrRqD1mNQgPyAxZ+5B1hEuV2ycbeqbWL2la81heSqmUipQiJ4389ySa744IEAqx2ix5+pmrgYBjgf6pn+0PcYGcTK3ZbdL6Uz9tA6BLSLlpbZ7hzSblMf9eCAHEO1H2oijbz+Ii4AMzAwTqAlmdcVfEZyetkvEXU5lacHgg/njGGAqjDc6Sc9EWmPV+0rYf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH0PR11MB5690.namprd11.prod.outlook.com (2603:10b6:610:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 17:31:27 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::9c3:d61a:c2c9:109f]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::9c3:d61a:c2c9:109f%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 17:31:27 +0000
Message-ID: <07d32ed5-825c-cee2-7551-e8442177dfc1@intel.com>
Date: Mon, 19 Feb 2024 09:30:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: constify the struct device_type usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20240219-device_cleanup-dmaengine-v1-1-9f72f3cf3587@marliere.net>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240219-device_cleanup-dmaengine-v1-1-9f72f3cf3587@marliere.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH0PR11MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: feb149a5-ebc3-447a-2b51-08dc31709a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDI/nYvTVxZlwZqwiuN0AhptHda0+eFfVK1HN+h5NZFDp3vsq5MuhWajIuJqb/mR6Y+RKTc3NZuMVCYB5CjuBgX1yj7pr9vfjlUpOoYuWDGgqA2w9XgryY1qDZ9AVhLC6pKOWCEwV3L5WGSqju4ZUopw03AiVjhBt9F2Uj1TTMMQJ2yaPFvFSNeJiodPV2rZ8zI0oQXNhMHNkmxuO/6EAL1vH0DjZJHU1hfZEPUl90TY7rxudhDb6sLBO+lb7wvHjDmcBSmjH7qV65aoxLXYrhFXXCzshI4N0kP7dq7UcNBlStUdumP5XQXjjUzC6KvsTz6opGUVYs7rQfh6btMnP2b8s2gxrTQ+2NT7l3/BYcIqG1Y0EW3HOFC4TukhOtXg1w8+MuYBTwMaG4bXy72y+RWAU1F0NyKe4QnA8jJIAnzqhO2OfimPOObUW/PeUtXIsEuX+TYdSw89G6+Ozf3VWmDpzpcV/gJdWTPagAKWthD9yty9gQYRdw46DIrsgRtHKttkak49Ve3q9eFzUrSZzGJL0Ljw2uyWuKFuWjVgs5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkphamo5U2VsQlFSMWNidFIzNUh5Ny9zMnM0T3FqMlJEVG45SHdSVmdqd0RL?=
 =?utf-8?B?NGRnRVhWQjZtalZ3YzdkT0pEb0pvL1M3VW1pNkhsWUM4bXFnUTRPUnZRV3Jy?=
 =?utf-8?B?ckpPeXZjUWdrUDBDaHJ4RFZ5Syt1OVVLTGhUTXR0VC83c0xQZTVJbE5pRnQ3?=
 =?utf-8?B?WFl6NWVZQWZtUEdKaTNwRjI0WVJRVVBrRUE3OCtZSVVvbFhFdmo5dFZMMXls?=
 =?utf-8?B?UUpWVFNoMkxwTVBYY1AyNFAzWlR4aTFuZ1JzbjZ1dEVieHJScEdSWDBkbk45?=
 =?utf-8?B?QjY1bEI5QWRzQU1hcTV4L29hUG1HamRFSHZvRTgrUFFIL0Q1aU9sY1hUcEND?=
 =?utf-8?B?VnU3amp3b3F3MXBweldZaW5yOXU2c2ZTaVlmbDB5eElObzhXN003Sm5DYits?=
 =?utf-8?B?TUxVTnEvWWMyRlFhN0doeTlNUUVUdXN0OWkwS21aSjRRZ0FCaVdwUW5Uc1FI?=
 =?utf-8?B?alpob3VSeDg1M1ZyeHpjbnpCUDBzRXV5Z2RiSnpKQW9mdmd3eW12cTVQS0s2?=
 =?utf-8?B?UUswaVdiak9XSmRqOEc0K2t4WmE5aWQwL2RXMzhVeXJkRUJsSll5MTFBY3Zh?=
 =?utf-8?B?YWJDQ3VhOWZzQTVDYnhNYnREQ3NERG5mcDY5bGpYZ0JpQ3puMWJvZ2p0ZEtY?=
 =?utf-8?B?NHI2RVhWcGswQkcyN1U5bTZSRUNOU2pXdG1GY3lqUjNSUGVweDRIVlFrYU5y?=
 =?utf-8?B?U3BlWm9tNlBYbkJrckdrUHZFdHFVeUVBZlE0K0pRS2FodWJtdTJnWGtxSHJt?=
 =?utf-8?B?NjFqUGtFNk1mZWJRNXRhL1JocHhXbXN4aWhIWUVTTUZFOER4bGxXTWx1VnVk?=
 =?utf-8?B?UEdlbEloTXVoSEpzT0FJdWcycFdJK0EzSDFRbFNSUUxRbjVXWmpCVUVzUndC?=
 =?utf-8?B?eHVzZ1RJMVY4NXJzWWxmUUhDcmRDUmhoRWw0UGRhZVpJZ1VMTEM5d0I4SzZz?=
 =?utf-8?B?UVhkYVgyTzN1Wm44R3lKRzFlQldib0FuSjRtSm5RdFBTOWJ2ak9yM1JrR0Vk?=
 =?utf-8?B?NTFlUEVFT0xDNkF4alExUFB5QTVLMjI1ZWN6NDlOSDZYcXNFR1BwbFZOYzdT?=
 =?utf-8?B?aWVaeXdGMTJwRmNaK2NxT292ZW5hVmd3QlJ6M21CVU5ra0hNdTVvdEQra1lD?=
 =?utf-8?B?Z0diQjZGMVFYcTVSaU9CQTl3UU5Ud2pKc01GbXBXeS9EcG5VYVNkdjBSa213?=
 =?utf-8?B?bVpxR0pTZTh1RE51bFZvR2lrcVFMeDZoMEMrWWhabFcvanZxTXNnSDQyc00w?=
 =?utf-8?B?cVNzMjBCMC9IUy9zaVhSUlpuVUtsSFl5QkxjVDEzYVcrS1RpdnIwZi9ucUgv?=
 =?utf-8?B?Q1ZKazVaRC92T2NVMTlSWVoyTDl4cS9UT3k5K1RDaU1DdGlTY3VJdUp3eVZs?=
 =?utf-8?B?UVVLZkEyaHFkeXd6Yjd3cFRLNWFNVU1uYTVGWW5qTnM3LzRsZmdNVE5vQzdO?=
 =?utf-8?B?T2ZlNi83YS9NTDZ5Z1B0a0hiMklJMlVLR1JRNzRJbWd3NEphMVQ1WkQ5OWNS?=
 =?utf-8?B?Sk1xUUozdU9vYVV4eHU4djJKbFpnTG9CZ28zbEY5OEhCL2ZmaDNoZVlIQ3ZN?=
 =?utf-8?B?UW1lamY1ejlZOWM4QUY5aEc2U0xBUXVEaHBUaDI0MWFxSkg2RG5Wb1BQai83?=
 =?utf-8?B?cDFUVmFiazZ5djRmUW1vUzRPMFZPdERmcUdvMVF5V2JJczJCb3daSlhpbm9m?=
 =?utf-8?B?QmMzOE5FM2NTK2VTNGIwKzZNeDBiUklJNlJ5NDJKRHNKdEt0dHpUOVZVTmRS?=
 =?utf-8?B?UVFBcS9JZEVGNEk1KzlxVTU3enJCUjdiUGp5UkpoTlVIcjhOOHN3MDBFT0cv?=
 =?utf-8?B?b2NDMldYRmpSYUdscllMVEdUYjhhM2NMOTVTQXVZNU5TYjRkbWRIa3Q1VVlR?=
 =?utf-8?B?YUJjV2FsSm14Qll2Ykp6U0NyMDlGU1ovQVM5MXZEMzNXYlRXaXIxWXR3NU9P?=
 =?utf-8?B?MWlXcGVPUUdXcm5zM0VTbUZYZWFTcnl5VEFpazRGMldNSitSWHhVT2kxaGN4?=
 =?utf-8?B?SlhOeEdoczJESDRINHFSNzhxdG5jZU9GTEE3cFY3aFc0RmFTTFVBMlFsL3Uy?=
 =?utf-8?B?R1VScWZObjF5N2VMUTluVmlIOG9razFKdEwzdG83RTBSNXBXaGU5QVFnSFdY?=
 =?utf-8?Q?9amnyzf4wa04qkq/hQ9gqFF/L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: feb149a5-ebc3-447a-2b51-08dc31709a26
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:31:27.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G04BeuqrFHjLRZa81G5HfU/GgsW0Gq5Lq9T6WJ4eMG5gjF2KoYSXyzLvSq7lUv/fGbHnpYAeZDSu3IdcW6pwvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5690
X-OriginatorOrg: intel.com



On 2/19/24 03:46, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> dsa_device_type, iax_device_type, idxd_wq_device_type, idxd_cdev_file_type,
> idxd_cdev_device_type and idxd_group_device_type variables to be constant
> structures as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

