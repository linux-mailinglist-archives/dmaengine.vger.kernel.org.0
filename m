Return-Path: <dmaengine+bounces-157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD67F1765
	for <lists+dmaengine@lfdr.de>; Mon, 20 Nov 2023 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C04281779
	for <lists+dmaengine@lfdr.de>; Mon, 20 Nov 2023 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D981D55A;
	Mon, 20 Nov 2023 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIVKBu2y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED429F;
	Mon, 20 Nov 2023 07:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700494499; x=1732030499;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=272gBXjwVrmTcneNP5fJ3ycXSmyXti1sh3S6Heci+yA=;
  b=FIVKBu2yhQywbYGi4QvzyPSShiWSGh/VSjr9AQF2jZgsoRP4d+QnpBgV
   oSuqbAE6TBEaOH3fE7oAzyZx7QOPguAQP2rdXhvcqstAuLwPmagU4L9lu
   Xn8p6RliiqPC08pG96pWBz1R/oS4EeVjawcTGc99V84TYoA/y0ISz4wsa
   gheuaZqk72qR3Izb/H6nNresm8dcr3SALR93ILKmWRtGMe3b/Zso7Gc7u
   SAvYvQZDgtPr7SYuPnXnZOkdAgxUYT/xnADr9zFxiYDsnyn7SJGPCfhDi
   v1XgnBsENjJjIPqpxn5jP11wlffXxna1HBqEk4wKjMqcXVBrjLdua2Fu/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4827335"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4827335"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="14194747"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 07:34:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:34:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:34:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 07:34:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 07:34:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY/TMeNBDOeL6otE/LUoeTW6KSXqa2cyI6OjEAVTT00ezU0px0P0MQtVetHSgB2oBZkCxMh8w/kyJoUeDxty8cIKQuOaKlEXyhfBXeRzK/3lsQSAiC7iHXJwON0+oUzjb/0dvvS7PyjNl8OBH6MdBJlOZ3Vj/BGuf1Li4dNmIMNz4YQ4J2NUmIXQ6K5r7+eHsbT47XV4bM7WGXemuGiE30A81EfRD/alssLde4HmX058zjmJDkdL5qA7CjHGp39moODS21o1aTwaatDwIOz6Lrs/OrtoEeQNIPTVXSnObYVYJG3jEw4UW2MCNctDTpoTUsAziVa+0lE7Zrc78dfEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFse2dF6mqMbMZann34Wfnw+fiy31U8xypwNnagqbqk=;
 b=JP3kqrsEb19DU9QA4Yn5Oqunbt/JN5v6YL57N6VlMoUVbm2LsIRa3Onyh15vhEMtsEiVyKwVmuTcQI1bsPuyMr0Z4A+g0VDgQvGLKM/K85GHwh44ftg5Pui4vCZ9aju+9J5DmHNQpexRKyZODfP9YJYpCdhpc+4mArll+P9p5n/tiizFPVKJHxZHKIK4Q/Er2YAChoNr7s2uwXTZ2NmSDXTKaB3WA7+1WYIMGPVemgf5gO4bPRKRQ3K0h96N1DTfUwRomFDDZPtMndl/lxu3IPxJWagQOViPTNwgowf0vB7RXNVmqxwH8yFht/dcoay8oySxTdpi9rl0810lePk9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 15:34:44 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 15:34:44 +0000
Message-ID: <0bfc5c56-467e-40ef-b0ee-0a15d7f64e33@intel.com>
Date: Mon, 20 Nov 2023 08:34:41 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 09/34] dmaengine: idxd: optimize perfmon_assign_event()
To: Yury Norov <yury.norov@gmail.com>, <linux-kernel@vger.kernel.org>, Fenghua
 Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Maxim Kuvyrkov
	<maxim.kuvyrkov@linaro.org>, Alexey Klimov <klimov.linux@gmail.com>, "Fenghua
 Yu" <fenghua.yu@intel.com>, "tom.zanussi@linux.intel.com"
	<tom.zanussi@linux.intel.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-10-yury.norov@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231118155105.25678-10-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW5PR11MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: f79cfcd2-98e0-4f29-70ea-08dbe9de3864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEFHA+5pWbIEnXwB+HLW336N+UK3U6KcAX84meJe6zjUPzLz0BtMJwR5RVWi+uCjh2YmHPB1US14tUAK4QKQEkILFDWkNn4PiJls4ek5a08jV+V5vWJFOJJ0pVRvmK7rIzzpzhto+WuJm9O9UqBNfwsGvQfKjmwkY0TK9MdZvFDe5oUvb7NO76DuznaHCrWexBhgbhJVTdy5gw2A/S4MEWzJZOZr5SemQKO6uBISg5r3SQuhcH6kVSls1gcqM1y6ws8GmW5bK60fcoZN54fog9XIG5AwPE6ob8juDlRzVxIHO1/npG10ymWgm3sElBijUQvZUgLc17Z+koTC8CzKKYs+gfLGcLJ60KqaxUC4fICSx7rS2mObLejZtpjtHdwJhIdRlxI/v2nHKJrspRVNbxIXKDFeP8RLd1o4yMO01l2dQrm+LWCMGGY4b4leV+L6GI5jxOvu3YagVOlvDh2zQgxhtCgYac3GG6MT1Q5mPtr2jmnW+WfxInb0bzhEXibHVkMlj5u0xkDLZZvYVszw8tbU7yqOYAoRk6D/2fRq4kzlCqN6UjqUq+vvkexu3pK8ddr3GeoydBepsbikTeeXGBx/jInCMc62Da4JAN223za7wDn1l8D95plPHQsakbPFZS/DVQ1wV8PdcHqRGMRvWpo7zmt8Zm+CwtjB70UCTLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(53546011)(26005)(4326008)(8676002)(41300700001)(38100700002)(8936002)(7416002)(2906002)(44832011)(5660300002)(478600001)(6486002)(6506007)(6666004)(110136005)(66476007)(66556008)(66946007)(54906003)(316002)(36756003)(86362001)(31696002)(82960400001)(31686004)(2616005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29CNmtRNkZzOW1WL3UxR0VTL2hkbk9DY3pKOUYwMkd2aDBnMkk1S0JDaUxE?=
 =?utf-8?B?VDlGVVJHSTR6S3U0OUxrOUpYY3owZWh1NituSVhBKzJFbldiazdYMzRQR0JE?=
 =?utf-8?B?dnlmY2xCdXh6bTBPU3hqMHZYK3ZiODdnYmgvSTFTR1l0ZVN2U21DSVNoMTA3?=
 =?utf-8?B?WlJGZzdTLy9zMkl6RDQ0QklpUE9rLzhCYTcvTnlReXVjMUp6ZW0ycklSSWhY?=
 =?utf-8?B?TERUSmhSRU5nczZKVzJBUC9kbzZsMnhndk9wd3o4aWwwQUFBQWxqTjd1bXox?=
 =?utf-8?B?ZWt2L0J5NHJVdjdpNXlCeTM3dCtjTHQ3aFNuZG1VOE9qZ3VmdnFFK1UwUDRD?=
 =?utf-8?B?M3BvbVNyNXZOM3k5akFBbVF2Z0crTkNIVDZsWi9wZXBqZ0FhR0RpU241OEZ6?=
 =?utf-8?B?RHF5LzAyUlV6UVovNnJtOEZRN3dlVEVkUFRGT3E5c3RVWFpJanRkbWFZMzZv?=
 =?utf-8?B?VEFtVE1mRzlRc3hhbkxUOWYxY1BMRUFFWWRsTmhycndGbFdJTE9qZHlOdW02?=
 =?utf-8?B?MmNPeVJzMHZSWTdjS0tNZWlkRXJxZDYva0VneFVXSXJmRy9iZUt2MjFWRHN5?=
 =?utf-8?B?UVFPS1FkbzJidk9jdHplSDdob1hyWlJvMVpjNExRVnhNNDlidmhFZ1hNekt4?=
 =?utf-8?B?Vm9uRi9mU24rOEJYMXRoTXBRaE5mUnYyMCt2NzFmSlNLYUdRd1I0SU43eEM1?=
 =?utf-8?B?a0xZOXllOGd2eUUyaTNaMnN0VWNMNU03c3RvaVJiOXl1Z1R1Wk0yRk1GMmxa?=
 =?utf-8?B?d1BJdlhDSTRlTDFNVnZYcXlNc1prUTJlc0FrR1REbTA2bDU1bkttUXF3S25z?=
 =?utf-8?B?Mit6ZU9wWnRTa0lKM1IzblpJeWx1UThBY0wrbFczNHBCcldDYzZTWTJhTjlP?=
 =?utf-8?B?MWp1a0RwbW5NSjkyYVExVXk3Mk1KKzVMQU9tdWx0MnV0RjZZb2pjaG93dFNI?=
 =?utf-8?B?UHNweWoxMm45OUtoWWpmVzdiR3FvME9wWGlBZVRuQm94dWRJNFpuditmRDZE?=
 =?utf-8?B?Tmx0WEVhYjEvME9EUkcvRnExOE41VWtZQUdSbE0wb0NzNzRyY3FnMGV5L0lt?=
 =?utf-8?B?aUhTUm8rVERxQ3UzM2taVGltOWp4aDZHbmRSczB0OC9vR0FSb21nd3NYK0hX?=
 =?utf-8?B?emRuZ2NtSnBHVFNFUXcwclk3bjFBQ3RKaVVaYnBSMWlaeUdhc1pNN1R3cE8r?=
 =?utf-8?B?cWpZbmN3bnB1VmNJekE1SDJNU2FUWmlZaktPK3VPUjloYWtOVmpzWm84RVVs?=
 =?utf-8?B?V2RQNlpWTEZMcGl5bEFUb1VFSlJZZFM0WVdJUGZiRG92d3hvaEFuc1lOUFRs?=
 =?utf-8?B?dmNDb0Z0RHg0QTZZaHdjcnArOGVZNVcvRG5NdWgvVW5NbWx4ZXpNbXc5b3BO?=
 =?utf-8?B?ak02RzBjTEErcTRPaUIrS09OQjBMcDk4QWFzbUROSWhNZ2sxY0RHN21sNkxl?=
 =?utf-8?B?Mkl2QmQ4dkhxcFdYb2tpeHdxRFFnaE5jbmJoYlBXTkk1bVJFK3JzOWRoZis1?=
 =?utf-8?B?N2FtbXJGdThWU2VmUElpSXRadkdReFQ3RlMzS1BnNGJUZmdwU3JpdTBDVzlQ?=
 =?utf-8?B?SzZ5S2F6V1cwSnR4L1YreHdHU3FPa3VDZEU5N1NHeitLSTFuNEVlWFZkczI0?=
 =?utf-8?B?TXAxZUlHeE9zWXIvWlFxaXg3S01ZaDBLdUpOTWlZN3VvcTltK3d2a01STzV3?=
 =?utf-8?B?VlFYK2JBYWptWHdDR01FR1dkTmVCUklSNnJtalk2S0hRbHB0empLeFJraC9M?=
 =?utf-8?B?NVorSzRxbjVnbnVoMHJ6K2k4T0F6ZHJ4enlqWXptbFE2emErZ0dZaXpTR3N2?=
 =?utf-8?B?Z2w3RE5pUHl3TlV4VW5PaDdtMmJXZnA1UXcwTHI5WDI1QldkU1N4amNRQXR6?=
 =?utf-8?B?VERjM05ZY2lpSkhHVFJQWWNTRVZMMFQ4L2I1eG95NnNmck4zd2dzV29mNlNB?=
 =?utf-8?B?WWJtUzNMb0poT2l6K0k1bGJpa0kvZVdmVTc2cFB2bjd3K3ZyOGNLdVdjQkZB?=
 =?utf-8?B?RjV0RE90aFluakQ1UWczVjZTWnJlRUxucytzcEwzUGE0RnBqSmFRanI5R0hY?=
 =?utf-8?B?Y1gvUDF5a3RQdkpOdkIxUGowU254YnE1OGRXeUVwK25WUU1FUkRiV3BYcG11?=
 =?utf-8?Q?/1+3oNf3S7fYHRSvHocAjpPFQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f79cfcd2-98e0-4f29-70ea-08dbe9de3864
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:34:44.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3vodUW6W+Ss6G3PwLWsSS5koE5/rCufTOpH7hAFV377ezWhzBZkhpY+D/v/HemW6SA8b9FOjS+tcugHUY8J1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com



On 11/18/23 08:50, Yury Norov wrote:
> The function searches used_mask for a set bit in a for-loop bit by bit.
> We can do it faster by using atomic find_and_set_bit().
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/perfmon.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index fdda6d604262..4dd9c0d979c3 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -134,13 +134,9 @@ static void perfmon_assign_hw_event(struct idxd_pmu *idxd_pmu,
>  static int perfmon_assign_event(struct idxd_pmu *idxd_pmu,
>  				struct perf_event *event)
>  {
> -	int i;
> -
> -	for (i = 0; i < IDXD_PMU_EVENT_MAX; i++)
> -		if (!test_and_set_bit(i, idxd_pmu->used_mask))
> -			return i;
> +	int i = find_and_set_bit(idxd_pmu->used_mask, IDXD_PMU_EVENT_MAX);
>  
> -	return -EINVAL;
> +	return i < IDXD_PMU_EVENT_MAX ? i : -EINVAL;
>  }
>  
>  /*

