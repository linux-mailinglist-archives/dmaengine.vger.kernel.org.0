Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3D7511AE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGLULZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 16:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGLULX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 16:11:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4968E8;
        Wed, 12 Jul 2023 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689192682; x=1720728682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eJuR8PtajzucQIo/ak/tDg4cDTtjtOz2Y3W3oGgUbHQ=;
  b=Dg/CqD32xZshXo7Cp3I/xNTyTgL1QnxusFZ6rqWJaGfeRRNiA8ifGP/f
   krSXNgayy02K01ifVARlGMZ1fdZ4UMGHKuahpOD/vny70zwarOKpxy1Ap
   C2GXjI5jtqtSKFiyEUC8vWoWdArBfaCmjtXVCvmCHefEiMpoZ0SC4rcDa
   hPXWYkDWgWMWJn8iYoziA3IGRq266xBMO0Zh6y9EKGT2gbmzvUh7b18kb
   EKZE61AbUz48TRaxZNYaf+YnzIRK5RExTcl0/8RYGRM+E3+OejCbz/Vhx
   tNkWfBT2QHY9CnHivSUG7//OKKti4KepJ0zCYg2alt+y6ZuLZcY3X9mp6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395793649"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="395793649"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 13:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="756902695"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="756902695"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2023 13:11:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:11:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 13:11:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 13:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs1EqGYfjrImCRXn2hXZ6guBA9Cb96w0n3JAzAkAsGmfZh/E45FrrH53a+NWOi2xQVJoTytwIJ3mjVmBPZvOiQPwfr7egU9QJ3MRiLGRU4WdicYs8LPsYFLa1MPOo0hp3U3OFassRbtJAyieATsHjL5HvmnWXHmE73Kw5Ub9qQ6pReMixbbHciLfaPvnnYJSeWGHGY8dBaDpLj7c/4TuazGFxF9hzKvCMULQcCw03Ok9h/pP3DN4tq+uDifjMp01Wh8/UfMkwHKyf0qaBYOji4eX2BFRWkAlQx9BgbteXH4QP/5xSQDnsD0jcK7TaUDCVVqa5bEcGLS8+4YFMha4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K060IXKapjcIt9VuWvvfNpoFVpuy9yPsI6w4Gabi8lE=;
 b=jFSz/VaGCT0ItKporYmJvyYHxZhNlZtSITDiE6FC60jYI6pYfhqEVN0GkvCYnjSybGino2owMmToiXrDgA2pY83efGBu+XfFeARPseGiAiQYrAudTNJzKwKzSJ5syIZHVOLONgVORcEKEJ9H6WxBOLNC6gLLmA8/yzomu862hXJS57n8p8qYtmEEq+aA9BM+DgwvbUCVZUxVCOw88OuG8Xq0lRKqOE8QDP92+FaVgHhkuT6/18f1HYVfKI6QKVQ35lplCRhyTf11XhbmgH/z3gLqkRKexs+9xE423h4dulYs0pdoVugB1GmvMIIVml0aw5rS/CZ3h97dFS74njNHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 12 Jul
 2023 20:11:19 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 20:11:19 +0000
Message-ID: <42f9e042-e404-2ecb-5e92-c3810671ecad@intel.com>
Date:   Wed, 12 Jul 2023 13:11:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v3] dmaengine: idxd: Clear PRS disable flag when disabling
 IDXD device
To:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>
References: <20230712193505.3440752-1-fenghua.yu@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230712193505.3440752-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 629a2077-f30f-4bd9-dfee-08db8314276a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0mKPkVWjULDJQhSXT04IYK0TTwwNXPwnzZHWdeFxudOO8cjebk6EQJP42576RJF7kdkwo7nFgcQ4aeEcPgPvzdcCDHsI1FGEyhZdKbuodx6TSm7phkYQ8oUNsKjS31YKZJe6IE4/ZSKVMiALxf7A2zj5EiAtJQuG7nyyAIhUKm9ikVPQyCXiEya/U3x8FklqkOBgT6msLS47vcdgHQqiw7i31th8W1idLnUygQ/sgYvWSnD0mm9b/AD1QhK9coTEcujpDmCY8yoOgifrkCj2P7DbqnaeNL9Pwye5DQHFbtIPh4fMfsGg258p69M0sqE0+bfhYGGKzkVokxOSJGTgcG6oVzGNcXvHoXh9PvPWNTum1jEsQryWZCheKrntma2G/sjDTStg3+3L98TazX7uBxIgaKa12p3ru4qKC95YEpX6ppsreNJw2OOKz4WO6q4OVhbgmrqTpZcPB064tN3HgVmcKr5XMfLNyuYDuepFqCjnUR6Zj5Sj/AqtK/SE82bwrYbT0+LeOxq3kFNa9Law17XRFlZxa4/gP2uWmg9bVadXZJ+FSwUgi8vuvdgO92vUwm0rbPzA1/d9BGwc8uWK1WABLMOrzzIY5cn1HeQPcqZiHAFFZX6QdIWQ/8Pbca5YbJ4+Yn8WTH8xXf6aqjZNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(83380400001)(82960400001)(66476007)(54906003)(6486002)(478600001)(41300700001)(8676002)(8936002)(38100700002)(66556008)(66946007)(4326008)(316002)(53546011)(107886003)(110136005)(6512007)(6506007)(186003)(2616005)(26005)(86362001)(2906002)(31696002)(44832011)(5660300002)(6666004)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUFqZGR4ODBuaisvZDllVjlFb2UwZlhLSFM2TktCL00wNTFCa2NHUVIzeC9Q?=
 =?utf-8?B?RkZLdStlSnQ0S3V0YW44Z2ZTN1RFclNnZjg4MTQ0TU40SWRmOFNLVEw1MG9l?=
 =?utf-8?B?eWErQ0xSSHRjbFZRNFpRS0EyaFFuVFh2WDBnS3l2NXE0MHBGRjk0cDdsQVFH?=
 =?utf-8?B?YWdVK3B5UDNsWEpFeXFyb2FrREQxMzF4UVF1MUJmQ2EvSDVZVDhieUc3NkJ3?=
 =?utf-8?B?UWoyWE1hVXpFSVZkTmVZR093a08vcGczWXY3dHBsMUEycVd2SFN5RWdUbW5x?=
 =?utf-8?B?bksvKzFBc0YrS2JDaEJQOXVuR3gxL3RoTXJvSHI1cGwrcGhYa1F0c3B2NEZk?=
 =?utf-8?B?eUZwZWhvOFQrejRNT0ZkTFVwaHNFZ2hrUFZJNDh5RTlBcUhuQWsrZWFNMWxX?=
 =?utf-8?B?cnpyYm1RZCsvT2dUTFhZVForTHZEK2RZaDd5cjJwdXIyRDBKY2hubkJDU05h?=
 =?utf-8?B?c2NDZFBnYXFSVVFmbFZVVHV3a0xkVDkwejRySWluQ0E3ZFVEbkpmYU1yMHg3?=
 =?utf-8?B?clpKOHFxMVlXakpPRGk0K1g2NXM1Q0tSZXVxYTVueW8zT3JQbjNvdEVjL0NZ?=
 =?utf-8?B?bi96ZFlqYXJLUmdPY244UUhIQ29PdFNScm54cndFZWhpeUhVMjVrWGE3NU55?=
 =?utf-8?B?N1kwVkdWakY2eGdraHpTSXAxZSt4YnIwS0Z4YnhSaWZBaGZNQUNYTFBaTkhH?=
 =?utf-8?B?U0FMaXdjNnRpb21TRmFPUllyQ09iQjlUUzhNa2dJNXVndUNadEhiN0tELzVZ?=
 =?utf-8?B?SmdHdVF3ZVJoajYwcTdDQmcwaFZyQ2p0N2hvT0dlUS9lY08yTEgxbXFYVUx4?=
 =?utf-8?B?eE5NRUZSaENIUHYzRVdZR2hMNTBPZ1d1RUU3MjhiRUlIdkY2RW9tbEgwOVRT?=
 =?utf-8?B?MVhwbTh3VkpqQ0thV0xrMnhkVFc4OFdUUmVPYmVIektaUWR6SW5MdGIvM21y?=
 =?utf-8?B?ejFhYTZmZGdzMHpMaXdqcTh6ZWROSDFLK09pNXV3Nzhyb05OM3h4TDg4TGx3?=
 =?utf-8?B?WHlpcnBQenBkbXhqSTRDRHYvcGgxQ0hwY0M0MlhSRW5TSm1tMWw4SU9RR2Rk?=
 =?utf-8?B?cFgxMEVmVGJzdGdxbmJEaVJVcGpJenVTLytvdzlPamRBczZuM0x6Y0RiU3JY?=
 =?utf-8?B?TW9VcXlJOGQ4RzZpZjRkM3Fyd1d3TkxPVFRaRHZpaTlmeGNQQ2kzSE4zeFRW?=
 =?utf-8?B?dHBmUERDaGI1WEw2S3FHVjBIT2trUHcxL0FPS3dCSDU3NFE4eU0rZUFuajdi?=
 =?utf-8?B?blVSZUFlWTJaalh0R0tSSG9LbDVPckZSOU52VkFiM2hzNGUrR09UZFZId0di?=
 =?utf-8?B?ektWaUhuL3VxSFhjaFZkWUVENXNOcDY1eFpqakM1Tm9hU01LL2pRQnQwd09n?=
 =?utf-8?B?L3VIWFlPYkkvWklDWFRzK21FM2xVZWlzWXF0ZWV4UW1MKzZhbXlKaDFEOFVC?=
 =?utf-8?B?N3FCWmkyQ0tpUUw5RTlFaU4vajFVbzU1ZEsvTy9XWkpJS3pleWRIVThpZFlr?=
 =?utf-8?B?K1ZDME9OTWQ4T3U1dU1ad0RYVXhWV3BONTdHUjFlR2l6V1RYYzJUMGlvOEt2?=
 =?utf-8?B?ZE9Fb2ZlWCsxb2FKTWh1Tm4zT1lpK2tERXJzZlVMOThyNlNwYzBWNytrVE1F?=
 =?utf-8?B?QnJaaGE4T3UyK2tZNS9OWStmaU5qQzF6OVBhajloT1pkdks4Q3J2RWxVQzEy?=
 =?utf-8?B?Mm5ac05BV0FaRW5BOEFKKzRRcEZHdGExbExMeFRvYk04eENqbzZ3OGltdmoz?=
 =?utf-8?B?b212aXAyazI3ZFlwVDVidmN4ZmJwQTVvNHlrVkFxUm9pVFRibk54eDFxMkF3?=
 =?utf-8?B?bEI1SkozK3IvZGJQUnNtRTdnTVJkNlk0aHFwTmM2NlYxcUtZRCtaUXVtREV1?=
 =?utf-8?B?bHYycmxVTmJPeDNJWkgyUXRaZFlMZEVvZU85ZkVxZ3YvODFKVXhkOEhRZk15?=
 =?utf-8?B?QXhVTzVjUXFPTG03QkhuYjRxMEdqWi9iMkEwa3FCSGczUVB0ejUvQjNKWGZN?=
 =?utf-8?B?QWRBdFJDUzYyT24vRlZjbzM3WlE4aXlod25CQzJSSDBLaEZXWnJCR1M0ZUNN?=
 =?utf-8?B?dkFCaGFmb09NTXFreExtZWpNeXJGVkU0SnQrNHdtay9KVHk3dkJ1a1BmSk15?=
 =?utf-8?Q?VX3sYaGOlYcw7O2MKlZkBcyAF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 629a2077-f30f-4bd9-dfee-08db8314276a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 20:11:18.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojIpklwvJeton5sOkGLL0F9y1+rkufGyMFY5DEPIdjtUuB2Qi00VpT+yJreNCJHH46Mxt5k8glaRiwYZe31K7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/12/23 12:35, Fenghua Yu wrote:
> Disabling IDXD device doesn't reset Page Request Service (PRS)
> disable flag to its initial value 0. This may cause user confusion
> because once PRS is disabled user will see PRS still remains the
> previous setting (i.e. disabled) via sysfs interface even after the
> device is disabled.
> 
> To eliminate user confusion, reset PRS disable flag to ensure that
> the PRS flag bit reflects correct state after the device is disabled.
> 
> Additionally, simplify the code by setting wq->flags to 0, which clears
> all flag bits, including any future additions.
> 
> Fixes: f2dc327131b5 ("dmaengine: idxd: add per wq PRS disable")
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Add "Fixes" tag.
> - Set wq->flags to 0.
> 
> v2:
> - Fix Tony's email typo
> 
>   drivers/dma/idxd/device.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5abbcc61c528..9a15f0d12c79 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -384,9 +384,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>   	wq->threshold = 0;
>   	wq->priority = 0;
>   	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
> -	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
> -	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
> -	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
> +	wq->flags = 0;
>   	memset(wq->name, 0, WQ_NAME_SIZE);
>   	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>   	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
