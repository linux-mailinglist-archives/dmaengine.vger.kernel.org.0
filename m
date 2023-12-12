Return-Path: <dmaengine+bounces-474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76380E1ED
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 03:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6391C210B1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF8625;
	Tue, 12 Dec 2023 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yps1jtBl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC71FC8;
	Mon, 11 Dec 2023 18:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702348341; x=1733884341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZOIG19UmSc6gfXd82Z1U5XFq8uTkjC99QBhZ5DKwrnc=;
  b=Yps1jtBlDua0Bf7/+ekLIJydnjrBoFdsLMgY/jq3Uo882b7rMWlz7D/W
   IOshdCYuCZ/8C4dRMWObhD/IGt7GO45zWSFLj9d+SFky1pwE5shpl3ksx
   Nn5MdQCDYZc96Hu3J5mDrM5w87dXMnJ4GEsY4/QchcxHTrQSbRQFU0sRf
   KRcV52BMO0dg2lGRMnBtuL1n2naY9i4V8arDstwkzk+c8Clz2+UIqGYfH
   ZJnflv3GQB5JtUVSZOLt3qSHuyQCEBvLmh/AaXqZSbXsxF9AyEJdLFHZ/
   /83icq92cFlXz/U6OGQ8o9htG9GWVuwKmyEVPWBYBUkp9UxP+QzShPanv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461218658"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461218658"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104722063"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1104722063"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 18:30:31 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 18:30:31 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 18:30:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 18:30:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNixnAkriOwsYHy8/zW+JhVN7i+QP/hIxCp5T4XbCfelRyK9Kmyod0hugjesouMO4/N73pEeaNFQXln7l2yErHiAshJuxFVCEl22kTkLTA6l3HnBG5o26wcK0A9FGDehMTMe1Ew7GhCY3jVBNDmPyLzfQZnX5m5wBWsLomsBSaKi3MPF+VD3rv8H6AkxMKK5bMB13D7XH/EjmMi3eVwMMqyFDWssDjZPFg91voLTR9pw3iG7m2MYLAfigr52LQHbyxKo3IXkSjdhIID3yuIZeqJR7rGaXML8l3QDEdjm7FjV827DguOBlp32Be4A4NjYvwk2f83Iukzrvbx7xxHaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W5YVxSaTSTMuwQGyxbabwyqttq0o6Wynyj019fA8L8=;
 b=GD+xOWylYx/IW/W/K0DhgUJ5H1OChrBn4RI+3I9buCkW+y+wv8lnyqq45OzvQ2lHplbd7LDW3rOSWSwgskU4uXbAfIWzb6AE0DahgcK2U5Kxa+90rJrl0pE1LsOAR4032S91WYnNK76KEtjM2dHXyUDtFagJwx1VZszoK2mqrx5NOvV9HWaM9Sdo3LKdJI2A5bNRSUEtf9y1zOL+OY17dfLAc0Clf+sbgeV80EKSZMigaDV0EiuoUAy/B/HophiRFeXbqK/Y30dqlN4P/LfYuTFGmCd4J2XEBsRqGZ0syRN1DlSJRPTbshQyE5Kpz3cBH3wETEUpTmTOgEc3I2e8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA3PR11MB8021.namprd11.prod.outlook.com (2603:10b6:806:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 02:30:29 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::92ef:1d38:2ad6:5e29%6]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 02:30:28 +0000
Message-ID: <aef69154-d46c-5947-1ad9-58418dc3947c@intel.com>
Date: Mon, 11 Dec 2023 18:30:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 10/35] dmaengine: idxd: optimize perfmon_assign_event()
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, <linux-kernel@vger.kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>
CC: Jan Kara <jack@suse.cz>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Maxim Kuvyrkov
	<maxim.kuvyrkov@linaro.org>, Alexey Klimov <klimov.linux@gmail.com>, "Bart
 Van Assche" <bvanassche@acm.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20231212022749.625238-1-yury.norov@gmail.com>
 <20231212022749.625238-11-yury.norov@gmail.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231212022749.625238-11-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA3PR11MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d90a64-5f83-454e-776b-08dbfaba4dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gs3lYcHW6qKJ/HwndQDjcsW19YIHLU9tdM8FPwtzlI5tee1ve2i6thUA5g9ZfIC7H5zGnAyv6soPZrmgVOxTbMo1f6MzZySQkiryOr7msxJU7jR2vIBmWOI+AKSdxuzsDV0H4wIfHMJelihGA7YSg8TEvXIdLmbTW7sPcEeHafVekrvcdycETex5W5PPAcFbSWn2VOusvKSPCxquxcFZiAT33QkY+TN4DJlm1kAGF6vhjt46JiYsCwUHcrxSuZRZ+Rq987Rup2BkkqHXxtcBKGWRw1IJ3nbIjXW2ERlZdaS8rkGLp7cdBQQlPlBZebtIOtWp4flgI7VVJf0JVhVE45UlM6ioHxwr+HTxuGgt6+gAxF2LNVrFNdTlWeJwCEm7RZ1VyRZVTM7zqIS+B0KVbtDeD8G8kfHBquSKBBsRrGZ+rPrRa/TzQtwb+hB2lHcxRj90+y2Zr1U14aCx5ExP3gLB0fIz+CASAkXeqYbpeIzljFWEiyiyC/GyHG57lH6tJeIU3ZTIthkoSwe+Jv5S13OXGEkBbHgKWABzbhs9BArVTQ2x8sg1gwfKV7e816kNvMr8FBD9Jyn0VQiC1c8tX+Cfmu9jduBmm1CJOwLh6kFXmFxF6CctBpfihFRj20KrWpcaWpx6IydgrbKEF14arQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(53546011)(6512007)(26005)(2616005)(6666004)(6486002)(6506007)(478600001)(41300700001)(7416002)(4744005)(44832011)(5660300002)(54906003)(2906002)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(4326008)(110136005)(86362001)(38100700002)(31696002)(36756003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZQc1U4Ym03TG1HTGYrT2hXVXJ3MHN2S1lycXczdCtyT1VSb2FQdkxHbkZl?=
 =?utf-8?B?b0ZyVGNpL3ROQ3hqc2l3OE8vM09iK2pQRTVuVmNWV3ptWmxuZ3FtUXRoZG5B?=
 =?utf-8?B?ZEkxVllGVkVCYnd6cjlDQ3ZzSThvZDU3R2liYitIQVZ6ZWIzaTFpdVFBd29H?=
 =?utf-8?B?Z1dlVXR0bWdkMHM0WFFIRlExVU9QYitWVG5URTAxbkplTFFCUUNtOXRXTEx4?=
 =?utf-8?B?V0IwUVF1c0IzZWNDN0cvbVYrTWt4VXY1K3dsdzJKSTNHUVVKeTJpRUNNS3JT?=
 =?utf-8?B?U2JwTFdjR0F3VmhQVmNWNWRjKzA1eFMyaXgwNVBkaS91M3FHS1hyOHBOYmlL?=
 =?utf-8?B?OEdtUWZ5N0VtNUFuOERQT0M0SmdsS2pTbVlHU0RCTzNITXU3clZIOHdVcEUv?=
 =?utf-8?B?UGp6cCtnVmt2SlVXbmduV3YrblBOQmNtV082OFk0d1NlWlA2OFljNndLU1ZI?=
 =?utf-8?B?UHlzYm8ya2J4eS9vamVPSG83Y2dwRnN5dkxKdWx0V3MxUVcrb1orbEpqNUJO?=
 =?utf-8?B?ZzVaUDFkcjFQc1BDemY0aS8vWHN3b3RrNmE0SXF5alcwTVB0OCtoeDFjdnpu?=
 =?utf-8?B?dHJXQk9NSitIa1EwQ0ErZlMrTFdiUk5qVFprNFgwbW5tL1Vad2Y1UXR1cmFW?=
 =?utf-8?B?RmNQNTVyUnYzU0lQVTJ0bHZEeE1PMUpmdm5taklYWEp6eHc4S0Rjbm50dGJt?=
 =?utf-8?B?eHNoVVA1S1NieC8vUmRrcmN6aXhhK2NnQ25EUUJXZlFYZHcwUnljUEhZWVl1?=
 =?utf-8?B?SHVKMkg3b3g2Ukp3dk1yUnFkMGR1SHdoTGxKZ2JpZGVzYWZvSnZ3a0tSVXZS?=
 =?utf-8?B?YmJ2YmxCRmcxTitYb0xLZUdTQTh0Z0p1Y25PNFJuek1GNnd1MlBZWVlXUnBT?=
 =?utf-8?B?aXBkaFBVcEdyMkVFNXo3YTdxK1RhdVBUbG5uaXIvSUdWOU1kVmpCY21oR0dk?=
 =?utf-8?B?a0dHMG02SkhZdmpDWUxGNThmSEtrK2xRUlFhUDQyeUZBTXYvdnhNZWQ0a3lr?=
 =?utf-8?B?K3dNRWVZV2RaNFU0QzEvM3d6eEhaL09qckpYUXFEcFNoYkZKR2F5bDF5Ukti?=
 =?utf-8?B?Q0QwbWlyT1dyMHo0YWZVUVhUVE02UXNJSlZpeEVKZTdxVGJSUisvRFp4bjhU?=
 =?utf-8?B?azB6UHdOdEh5emFZbENhM1ZucGpxZ3RVcTZyd3drbFp4UjNKM1hvb1ppRUdp?=
 =?utf-8?B?Skl3QmlUaGRMUzZCSEJvNXQrU1hXRlpMZWp6N0p3bHdrbW9PYXNaZlpKeTha?=
 =?utf-8?B?LzdkVERmWjFxZ2FWdnpmVmY4emYzUDBxRkNtOHB5cGoxbDloWlBEc3loRThw?=
 =?utf-8?B?a2ZJQ0FGc2poMkZMUDBYdTVtSm1jTmhCbXR0WjU2UzJhL0NrbUFFRTAyWGpL?=
 =?utf-8?B?ZmRubW5IMWZIam1MeHA0QmhDcnBUK01lYy9ic1RNaXIreVV0UmU4eVZzSDhY?=
 =?utf-8?B?czhWZzRwU0laeDAwMGpub01aSGRHREx3d2dvWjkwVFJ3Y3gvYUp5UUZsbldK?=
 =?utf-8?B?RlJwTUp4MU5rQ0g0WTlzQk5uVXo3L3dvdnM2bXoxVkxKZHZtTTl5SEFJakhY?=
 =?utf-8?B?bkV4N0hqZWc2cWxzWjJPM3MrRUo2UWxrZmNNQ1FscGMvcDZOVldNNFQ4b0Ru?=
 =?utf-8?B?MHBWUCthZS85a2VSWFkweHMzaHlpWE5oUlp6aWVWeWgrcFdXbVhSN0FXd0VI?=
 =?utf-8?B?OGdINUtFc1psTDZaZFNKclRUTFlJQWpXaUVsM1Z5ZU5jM0RxdzVmU0NFVW8z?=
 =?utf-8?B?Z2ZNZlI3Um1UMGdMTWk0ZERsTkFIUkNQUGFLZlBxRWN0NE4wNkN1Sms4Z2Fy?=
 =?utf-8?B?LzZ1Q0RySU5meFVnSFU1WjBrOGtNYVhDR0hIL1lrNkpNU2ppeWlOZXdlSVZE?=
 =?utf-8?B?N1NpYVd6cFc0NlUxYWljd1VpRlVabUYvdkViWE5hRzVyRzBOTDRvUjQxWFda?=
 =?utf-8?B?Yngwb3dyalJIZkdIbzA3TEhmbFFkRzFjRG1mQThXUDhXN3N4YVNZRUJLaUwy?=
 =?utf-8?B?UnlISmp0ZFNjVm04ekdXRjBUSFZ5eGJ2endOVUJ2b1hqMC9WemxMUDJUeXRB?=
 =?utf-8?B?QjZsS202MEVsNldKY1NzSHdLMWwxZkoxUEUvVVpsR1ZSajViL1RMdzN3WDZl?=
 =?utf-8?Q?A6ItztxrtkB0eg2oJtO4XdEdg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d90a64-5f83-454e-776b-08dbfaba4dd8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 02:30:28.1939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFFChlP9NHWJ+gN0IhHXpAE+6NqcGweh+UkMzJonphzDzprbxRU9EzD2oZjnNq4Ge3326OUS07smyi7tqCJ1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8021
X-OriginatorOrg: intel.com



On 12/11/23 18:27, Yury Norov wrote:
> The function searches used_mask for a set bit in a for-loop bit by bit.
> Simplify it by using atomic find_and_set_bit(), and make a nice
> one-liner.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

