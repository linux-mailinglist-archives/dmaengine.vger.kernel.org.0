Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45079D537
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjILPn6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Sep 2023 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjILPn5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Sep 2023 11:43:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EBA10DE;
        Tue, 12 Sep 2023 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694533433; x=1726069433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F4JhUsCLdrOOwxUPn+ohG2vgGfgkOj20gKjPlOBf8OM=;
  b=O/NOFzD4omP6Hc5hshr9AeCO80ICdpnq/BnicmkhVd8ul3Wb3FpTkpnm
   zIUA4C4DCXYy5UeZZ6RNuN7qHC2Xx0b8ghGo395QTO87nlmW6VuhwGmGO
   I4YDksToSmWBgwRODTy9eS5Im69J61D7i57m1KI5iL8m7eBBCDt/rXgIJ
   VtOpJOyI81dvvRv1bgVzMBXLRVvyrr0cOyeEUSOQ16siKWz9VYI/imTRo
   irWjpQlRRucvfxCAfG2GUJHdH906Fi88tjxqpAt/4m+BLsXIQvpVXvdwH
   SwHI0j33yRnGPVOf/fXraY4eoXDuNv+loJTGdMulcybX9+MBjCNsGupda
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409366523"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409366523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="813867000"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="813867000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 08:43:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:43:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:43:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 08:43:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 08:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiFkYrRk5vX8Ut8jSTxNeOhBIQr9pkoA2QlUQJIAQ3qwLoeC3ZXr41ZmziVWzOU9ElK5Pw0OXzoxJZ2O1Y7mfLfsMvxuJjwiCAHOT3rs3IqTLtHLGWhxG/y7gJvJKVF4A70jmz/UyAlny9PwtSC+TDpazTVKwWlrYlYngxDZpWHeZcJUsODzSJTOsDq56U5KiWhIlYEGnjH7LhaVIeenDLuvrIv1r1wO2Yj2aA1FPm+mSo6Pl/QEEFm3YI5jPYSiHX3laa60F4URfKfFOZzG/8opnRUgEic0E2r8/wcR34rDiNLRIUQ3KzfC2Kx410DjF62WdzLrT9h1Yld1rD/QuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jko/T6WDsriVpf+Z5h2UarcL4Pnz0F7LyDZ1IDCQvrA=;
 b=f+/CGkAUZCRtdfEvCcHWXTmBskdzZtfU3FksYYNrT+BdFsGEGeJQ3Kv+Qy4FrrcsLHtiN/J/Bsfw56b8w/X4/x27UyWHrjIVXKhivJro88AOcLf+4mWtVMX2J6I1mX07eVRD2FbJF4wUVtGGaNn05unT6cKqcMxGz0J8Odg7DwKghbcpsIgDFaIvP4iSjTtLR5me+8KyjNRmDQVrP9v2OViZsRAPSrBrBvi2LL3gzvt4OgpYxKYu+p/yQ+N2TQUnAw8/yoU22BVxjPugULn7gxS9V99Kg7Enk68MaSWr/TFeYjZKc6TOCP9PzHkLsfi94ExxTPnBiweGhqNkahXiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 15:43:19 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 15:43:19 +0000
Message-ID: <8cdf035e-de79-8f01-0bd3-68cf1e6e681d@intel.com>
Date:   Tue, 12 Sep 2023 08:43:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] Documentation: driver-api: fix ls -1 spelling
To:     Jingyu Wang <jingyuwang_vip@163.com>, <vkoul@kernel.org>,
        <corbet@lwn.net>
CC:     <dmaengine@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230912104650.3999-1-jingyuwang_vip@163.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230912104650.3999-1-jingyuwang_vip@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: a728252f-efb9-4ec3-a1a5-08dbb3a6fcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAQl3CCflKcy10Q7+WBbC+lNiDqw+K0rna2i/3a1oLZNk1MIND4WJ8WByGFtrTUCt8/ZsP+bQBQuw+3EQAWSSsoxj+Va3WjFYTocGHG/OB3W996j4EgAz7DsjRN1WGs4OQlXljEYFhNlIf5mGeEI3gX3Qr2Y5Ep8ibZW+klTM7mo3kSOZUHjZxOTZPr2ztjtm3Jcr35uhDICCsdCIzR/OxT0XJG5s76ThnO30qk5kX/Fs+G4XZ4OnD3TaNsyf9DCUqVPU3DkIC735K/KpKsPrpnKeDPfSjPe4Wo5EV+fFotQJeinI7rImYvk4TjVh2UJjlCb3/pjzSgRtVYaumO6RegWZQdyqasByqwSdOW7oGTDtzRJuuBpLIjujMRMnf1pmnxS+4ZX6v2OcBr4FwpNvtGvUPfbcZISKEeNZbD2tmdrHnhN1cUyTGcpSdVtZ1HPCWpExeoefZ4kF/17iqKiO0ct5sJaxFxu9UJuuYp3/c84SGkEVp31aFLuKrQTp6Qv5BqF9b9UauSOMFghrpcV4pW6x7Uf+g1MvlCKcieIbNT5dxu7AuKA609ZVx7zi7g7DPbPiGUKKAfbL5wVSca6H7aSO9viS6b/cUaNhuE2R3be5D9368Ku8AKr3NamYZb59czH4yPEFM+Ft3q8rZfXKpe2mls86Oo12be61VP8aghuoT9/zR7biaXwluuLJl4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(186009)(451199024)(1800799009)(31686004)(6486002)(6666004)(6506007)(53546011)(41300700001)(36756003)(86362001)(82960400001)(38100700002)(31696002)(4744005)(6512007)(2906002)(2616005)(83380400001)(478600001)(5660300002)(26005)(4326008)(8936002)(8676002)(316002)(44832011)(66946007)(66476007)(66556008)(45980500001)(159843002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBxUlVwakFtM01MZHY0cnNodHlSSjQveHRWeUYwc3Z5cHdpOW8zSDR5RHkr?=
 =?utf-8?B?blUyL0dpRld2STNnZGQxZEhBM3NCcmp5aEd3NHA3bk1ucHVlQUZ3S2hNd0xj?=
 =?utf-8?B?QW45cUNXeG1ISTdVbzRhclpaVzdDdFVic1Q3T0lZQ1FDajdrUnlTTkFqT2lG?=
 =?utf-8?B?RnFMZjNFZ1hIRnBjOTFRZldERTR5emxFOHhEY0ZETW1CMldIbG52eC9MMjRx?=
 =?utf-8?B?TUxvSFdHYUViU28vNkJCdGIxcmEraHhiUWFFWW9RWS8yZHpFcEN0VG4ybXB4?=
 =?utf-8?B?bmx3SkpQblk2ZGVUVkprNmpKVFNRTXdHczBsem9tb3ZjWTkvSjJjTjN6eFhF?=
 =?utf-8?B?UGgzRm00aUNERHlteFVNbUhwTi9tU3YrSjZ4a0VjTmw2R3lGTGdJM04ybFg4?=
 =?utf-8?B?bXlaZVRQVEFlRjh5ZjRxWW1JSzV2NHc4RUVCeHloSDhXekhUMWR6UmFRRFRa?=
 =?utf-8?B?V0VpcXNUM0JOMEY2bkY4TkdNcFk1TE5vVWt6UmNRN0dwT29YZVUzdGdnUStV?=
 =?utf-8?B?cEZtNmRNeTNNVkRTQUVEbUVCRTZFamppZGJHT3BJQTNaaStqK01IV2VuMlBP?=
 =?utf-8?B?V3ZMOFVqUHk4MDVTV3JmUmtkYWM3SHdUMWlrMTF3SXBxMG9oUEc3dFB3T3cw?=
 =?utf-8?B?dGV1VzAxbHBYOERqTWVSejJTdlYyQU5EdStVMHl0ZDJDY21iN0doT1Y0a3pL?=
 =?utf-8?B?MFI0WXkwc2NXcWU2MGtDeGRMZTcybmpMRXRSRmZKL0Z5Lzh2QmdGdzl4eGM4?=
 =?utf-8?B?N0h4RHl4dmNrZGRZNFdhQUNQNHFDVHIvS2ZWUWc4NFhZWmpVQVVyRGZ1ejR6?=
 =?utf-8?B?L1V0Y0VseTBsYm5DdVI3MGNLSEN3RjBCS2NFWGtvVHhIcTFOSkVxU3YxbkZm?=
 =?utf-8?B?R1ZhOXRzNlJOVUZaSGY2UnRqZkhiandlcUVtK2RUVGR3aHFIT0ZLVzN1YU5l?=
 =?utf-8?B?dEJkTm9vRkN1cnErUXpUTnozMDJjQW44MWhmZ1N1VU80Zm5QQis3Q3BkYk1G?=
 =?utf-8?B?NW1xR3BBWnNOSFArejM2Y0xTaFpFbzVwb1Fkemx2cWw1TUtyWWU4ZDQ0RU1I?=
 =?utf-8?B?Yk9SUVhrQ3Rhc3F4Y2l3ckxpa1NQaSthYmdJN09TMllCWHcvZm9vZE1WWlNt?=
 =?utf-8?B?eGNQVCs4VThnTDQ4ajdtaVB0RjNhb2ZOLzZiVmNkVHJjZ0lES0dJVy9xaFNC?=
 =?utf-8?B?dGRoZzE1eUpSYnoySlR0WHd1c2NPdk8wMURVMHRDdFJZM2NIcTdJdzNRL0h5?=
 =?utf-8?B?WUtOOXBHWllKTUh2OEQ5QWhTZzdoUkUrK1h0NlBlcjE1Y05GYjdEUmZUSUxx?=
 =?utf-8?B?NlFqOVk0RUZOdEJYUzd2VmZGcklvT1AyajVwODhOckdabisyVkU4Qmg4RkRP?=
 =?utf-8?B?RkZhRXh2WTgvTHFJaHplUi9DVzZQM2VNb2Fjd3BEZ012SURrWnBleE0vaXhU?=
 =?utf-8?B?RklkR0htOFVMcGRFZWQwRWxvcHhqYk0zSFBXUCtJS3B3M0VrcGZ3RHlmUFZP?=
 =?utf-8?B?SjlRc2lUNmFqdWN2WnN1QkEvL2F0Z2JWSGdsa3k4WjVyaWIvTlR4TngvbmR2?=
 =?utf-8?B?UzJrUGdHVTI1WlJqWmNocTYvS0hUZEJIR0taaHF5NjZiOVZlbnR5allsUDJr?=
 =?utf-8?B?QXF0bWUvT3Nmb2pRK0l5MmxCRkt0MWl0NGVYekZLT3FXVmVJUjM0Mm03NUli?=
 =?utf-8?B?d3Qyb1BnaWNJNG93RHR6U3oxVXBVekM1WjF3bk0zVm95eERqWDhyS2o2aERH?=
 =?utf-8?B?TnZUa2VReXhnWVBidFNCNmUxa1M0QjZTVGZDTmpiM1ljNjM4alZCem1Vd3Jk?=
 =?utf-8?B?OGhuaUxLRTIzcElBNW50RGJzdDM4RmVoQ3BLL3NJcFhmVDdRUTRtT3VqbnEr?=
 =?utf-8?B?akhCR3hacUM3TTRIOFNCeFM2UmVSWVhYaGlQUmllenYvNkpRVWlPQUhzWFhr?=
 =?utf-8?B?NXFiRlgrb3V1QlFTU05FRXZIV01kaS9LVkp1dVhMeFFjTURHUCtReGtPZjZF?=
 =?utf-8?B?aXNvd2V4RDNFZU5hQzZacno0Ty9ob1ZlQTJvR1VNYkRZZVZsK0RaL0hBU1RU?=
 =?utf-8?B?QjFVeDhac2l5cHdyT2pSNVM0ei9xc0M5M0VZSWhTTEU1dHNKcFBWdmxsV2dF?=
 =?utf-8?Q?bpk7zJaoT20Dqbe1iF9iAE8ii?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a728252f-efb9-4ec3-a1a5-08dbb3a6fcb7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:43:19.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6bx1O2RZCm44egt1mzOGhYpremprOV9tbNp+epkzR+H+L7NYYv2xD6hxRiHjEW/ALaEb8vGg+DBmCey8IeFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/12/23 03:46, Jingyu Wang wrote:
> ls -1 to ls -l in dmatest documentation

Why the change? -1 lists all the files w/o the attributes.

> 
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  Documentation/driver-api/dmaengine/dmatest.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
> index e2a63cefd783..b1a0e3bc71e7 100644
> --- a/Documentation/driver-api/dmaengine/dmatest.rst
> +++ b/Documentation/driver-api/dmaengine/dmatest.rst
> @@ -77,7 +77,7 @@ Example of multi-channel test usage (new in the 5.0 kernel)::
>  .. hint::
>    A list of available channels can be found by running the following command::
>  
> -    % ls -1 /sys/class/dma/
> +    % ls -l /sys/class/dma/
>  
>  Once started a message like " dmatest: Added 1 threads using dma0chan0" is
>  emitted. A thread for that specific channel is created and is now pending, the
