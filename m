Return-Path: <dmaengine+bounces-572-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D91817D06
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 22:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F05B23BCF
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062674E01;
	Mon, 18 Dec 2023 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxgSaF0g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9F740B0;
	Mon, 18 Dec 2023 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702936558; x=1734472558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iuKOUJCWno+zUWetxdx1AtNreQB47Ef9EoC937Mf5Ws=;
  b=VxgSaF0gjv1/6c2pXe80NJzPAovil7+0vlH0RPAS2j2apaNocZvWqXuz
   XIH/YALoIm6GRK0deYlqd5o/rFlqXPDGDPibdTK+SL2q0sKTYjbRWlNyS
   O/2bB91dPb+aJioQAIEB852K/Y0FnNKBZIfGhgcoccQXyZOb1hwt7OSYh
   LKFfHOYVio/fWZaV9FhBoFt1DBffzzIEK1PyfxMnqFrVfaAyFp1r2w+wO
   kY7e6XG+ok9lVgtaR0Kowbb5ZlLpJgeluQcxmzyez1s2VUJhnB1vj6HTo
   6rpiy6V0zcWKKQX8XQZRkic+EhY2kNSFjyGaVpjK4zdmCkU6npPaHRl5Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459909961"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="459909961"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="23940494"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:55:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:55:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:55:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:55:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:55:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9ynndhToC3Skn4D06pxyjT6fgBpT6xk+9NcYc4RFYgLI5U3X4pH8SfPCftWE82I+CvMUZcQapHBONt1B5yYMkTGcBtQX7HA9VyqeMV4GpJzyIssFFZMTLOyWP4D3YuYX4/bgE9xSVU76ct/zHvCAz8Cf26LyKArcmbSRbsBfCNfJFJylaKT57VanW/7SxyTP8SFs7bl2DmIPkIiwGMwxD4IembnJFLEqob+b9v3O/sjsoQT1v9emZ9geHo1p+TIu25FqI7LbY/QhRZCMQZB5enWVi3mqpm7OVycXakKtmGEHNxGSHvk7+nUS8nx5qrX047jBTAjt5k1hS7OcelHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH8nXlhNSlh/9jOyTREIwVI0IJfHzI8XAeZkuzHxj40=;
 b=TzJIq/kSe3f8yjLxeGAJ/sWd63BEVxB1Dxim2StfYHX13VaNsN2zfVebNXFsx1NrYJEPyx80XLe3ezCj43elQ1bImEvgv9OT/UPbv9SNyqEKHzuKSZDwJks9BnQ6EzVGxQLf6ZKUGXm/0byn3HQ3r935O75RkMpCeyqLfXgLyvzKS9/7zlzAtz2w+tr6OWIyUOUJjPHhXn6w6GCZYaXBnLbMIynRA7cDK/6wfnb4FjT6Lh4gg5RAC/rfMC9crdKD8D0y9e1RPr0bFK1hDcidYvSQP42OkFgnASCfBNSuebWw2mKSSbmiFFRj17vNTBKV6+T6PNTz+kWXaKqnlsrVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 21:55:49 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:55:48 +0000
Message-ID: <c13fcee5-383e-1c9d-c9da-ea22cc266467@intel.com>
Date: Mon, 18 Dec 2023 13:55:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] crypto: iaa - Remove unneeded newline in
 update_max_adecomp_delay_ns()
Content-Language: en-US
To: Tom Zanussi <tom.zanussi@linux.intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>
CC: <dave.jiang@intel.com>, <tony.luck@intel.com>, <jacob.jun.pan@intel.com>,
	<christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
 <20231218204715.220299-3-tom.zanussi@linux.intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231218204715.220299-3-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: afa8d967-b030-405a-373e-08dc0014184d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bx6V+t08RmjN0Fj/PoOMd9QpDITqwH8qQBYNRo7nyoUBzTFAxlMFXU1X89SIPQh9w4wxKYyrkc1fbMbIMie1GfG9KWKN1phqqMHYSJ7Ju3IPGdyHlbQEMxfWGtyghlIvs1Sg7XuvH+I0EpwB+lrLCMvuuO8APKL5MLajuQU9h+hvaq+Mcz/cAdjdEw1wz7xrv9vT0bSKw8fUiuFAfFtg+pDdLjDuP2VN3Hve+Qb9r311e9Q6rqjiJYlWB+vRd6D4+bzZ2wN1qiw/MGIOJRMv7OA8HaGcjMqj5+SyHRUbFtRE9KtfioxPJu8X4kXtE9YpT0fv4ceuIzywVx8LurvtRtH8Dk1S3X6FREz8jCBWCh4o5LduH7wv2gbXgq6KA3p7FBHt3eBSHWhzbdZMWIC8xqfjE5JBErlMN6o5WrZwttU+t7Djj11Vzidtbjdg9LdpCaZf0LsDHmRFY5upsqhDoH3NilS0/mqmeyxb+jFORhILWKOnRUH7XP2l1GE8UtAGrtTtQ3njX5Fhm0txw0ExA3R39FE8USczsKcNTKNdzuRDfNLuyBCQ/DDAG9cew1iJI5n3StpNK7ERUH23eT90hkJ5zKWowH6/Ba4gzGU8xgQkw9Pj4dw3cc2oa7Fji/wKhG+Fv52kuUqCJMeYbbJ+Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2616005)(26005)(82960400001)(86362001)(31696002)(36756003)(38100700002)(558084003)(66946007)(5660300002)(83380400001)(15650500001)(44832011)(6512007)(53546011)(6666004)(6506007)(8936002)(8676002)(4326008)(66556008)(6486002)(66476007)(316002)(2906002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVON0VjRXlNMkR0a2llQ3BoUldhRm5VeVlpcXltSUh6QzgyNXJ1bE5jWHZ2?=
 =?utf-8?B?eGhoc2tHci9pMEs4aDFLUC9oZ1dJeURmU0lCd1V6ZEUvM1hsRk42dHdONGdv?=
 =?utf-8?B?RkZEdkNEdS9Ud2ZvODJPUGVQRm1CS0oxTGxJdS9NQ3JyTjFhUndvR3BlaXlH?=
 =?utf-8?B?NDB2YmVTbkJTVEIrb1hkZnVobW9Ma3B1MU9JUm9ScENyUEx3TmFON3hzRzBq?=
 =?utf-8?B?UzhGTzNyZTg4Z3JQbHBDNUkwWWYzUlJ1dVZwdUFaRDQxMVYzS3FuWm5xTHA3?=
 =?utf-8?B?Rkxra01QaHNaNklrZDExaFhyTlc0bEErNWNkV2lXUk5OQVoyNDdzSmVmSlg3?=
 =?utf-8?B?YlBUQk5zZXhKbmdBbHEwaHNjdGRCaWFKRUkzZHlHeDg4Rkxva0R5YnZJa0Fp?=
 =?utf-8?B?YW1uUUp1VkhQSVhOcXBYcWlHbnhhV2xXNUxncUt6dm9wdFRiY1VodDhSVVcz?=
 =?utf-8?B?RjdIRThQaFphcld2SmlaT1lGcnU1VjZtdXp1TVNwczhibTlmcmdhaHF4OEl5?=
 =?utf-8?B?a1RmNkhwOWpOR1h3eHc3VWM1WmJBRDhaYlFidEVsTUdyVkxJSWJXQkxhU01j?=
 =?utf-8?B?SlQvbFJLK09hMW5TMHRCQnRPblR3aytSZE9rOE1YbWpuZXo1N3JtS3NTQkFJ?=
 =?utf-8?B?dmUrc3F2YUpnTUNHSW9lL3BoYmdBM2RlYnQ3QjFrVGVBMWdmU3kxQ21wU2Ex?=
 =?utf-8?B?RUNiUjAwZlR0bFhHWW1yR2JUV2puQXA1a01EcVNuRzYzVXd3RTFGWVoyVjZy?=
 =?utf-8?B?QXZlZDFSSnZ5a0c2cWRDRkxMYzcwbGYwZUdwRGFLY3BVTXJzanpZRWV6M0xE?=
 =?utf-8?B?VlZmZnNTL2pkSzlmUy9HQXNzb0oralRjQTNhQ041NHZqQkZjUjFFWlBYSmtB?=
 =?utf-8?B?anNiNmZqNkx1ZTF2WXJlTXZGZk0wTnRyMEVZV0dXckRwYXl2djA0ZWpwMWpl?=
 =?utf-8?B?MHdlMit5dEhEcmp0bVpDQlc4NXlGNFBtZEVXMEs0NGxQNTdGYmFMcU9STTFk?=
 =?utf-8?B?VWFHZk5DMTNHdlh2SHlxZWhXRDJ6QmVnaUdua1lvZi9vRURhbFQ2ZWJQdmR4?=
 =?utf-8?B?UEErdXBiYnovbW1GNVg4bmwrTGRVcThzUVpNeC9VM3QyWURFejFkTVZ3TWxW?=
 =?utf-8?B?VmtncUFkUC8xQ05wa0l1MmRJMGhIcG4yRFpaM0RzdnlITzhPektRTjh2Z3hK?=
 =?utf-8?B?aVlTUnYzOVdPaXA4WDVxQ3lUaFFPNWlXOUM3ek1QME94MTdncURXd3V5djRp?=
 =?utf-8?B?VW1pOFgycVZPVDJhS0lrV0R6QW9WK2ZjU2w2L3EyamRXZFY5N0s5YkZmWU4v?=
 =?utf-8?B?NjZFVXo4N2dxUXlrcTRNaWRhVXYrQjRscU9WbFNFM1BjSDZpUmRmUTd0dSta?=
 =?utf-8?B?cERac1Q5UXI2N0FmekZsbWQrYmVjY0twQStFRHZMME5id3pTYUZkSVp5REFM?=
 =?utf-8?B?b2JxUDVyNmFFRlc5MDNLaFhOYUlpaHl0OTRQNDg0WXZjSlZkYnhLREdaZWc3?=
 =?utf-8?B?OWczUUZYSk9GdEFTdGY2amFhODRZay9IZksxTVZ4bFZQMTd4MlVzdUhnMUU5?=
 =?utf-8?B?NkJzYzdzUTJXdHlkQnN3eXA5NHJGQTlTc1dmbnJBMExIaEFKZjhhcHpzQXo0?=
 =?utf-8?B?aWFvNjVheGs0RC9weE12QzFabWF6YXRrR0dyMWZGT0lOY0xuS2FvZi9oZnV3?=
 =?utf-8?B?S0JTckp1bVFiMUtVTDRPc1o4Y25lNXRoMGt4aEwvTGhBNEVCOUlpYzNvNnRJ?=
 =?utf-8?B?cThDc1MyOUk3Y25uRHdQb05jV3JKVmJRQVRoMExuUGw5eXdvUGNhVTVLNkdm?=
 =?utf-8?B?NjJISDZyem5lRXZyVzNBZE1pNlAvQUNTMkYwcDZYWmRmU08vRVFsYUJkeVBR?=
 =?utf-8?B?MjFOd0RHSnFVZzA4cmlONjZwZ0YraEpRL2NQekxzT0c5ejNXRWNlbm5xUnNY?=
 =?utf-8?B?M0Q0QldlRVpJY3pZYVh0cUJuVFBpVDlkYU9SZWVNME9iNGpFR2RpUG1MU0dB?=
 =?utf-8?B?NW5EeTFHNkxGakhkY05ad1VuUjg5MGRabEZZRjJMNFBZTEw0WG5xdFN1NFdT?=
 =?utf-8?B?QW16akZTdVc1aGVGNFdxNENJbFhjM1JZUDBzN2Iyc2RDc3hjRmwxbXlqaFlz?=
 =?utf-8?Q?igcWRgGEBz2TzApy9pOb36Kib?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afa8d967-b030-405a-373e-08dc0014184d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:55:48.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJXSj5V9KIZyEdjKMjB7B81pfikihAaddWh1eIbytrNNvdA7yhrImXT/g1hXg/GKMcFSGj56qNUB0Bgh0i5cHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-OriginatorOrg: intel.com



On 12/18/23 12:47, Tom Zanussi wrote:
> Remove a stray newline in update_max_adecomp_delay_ns().
> 
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

