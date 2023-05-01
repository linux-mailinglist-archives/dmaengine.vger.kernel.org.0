Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F786F3958
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEAUsZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAUsY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 16:48:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D31FC4;
        Mon,  1 May 2023 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682974103; x=1714510103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E5e52r/8+slgMZ7JgE6S6jTzoOTXEekIw563S0B6tUM=;
  b=eSe5WKq5Xe82oevyXR6j+7Slj1it7p4qKVvz7O11t897CrZuuAWacZHN
   EvNl8hsRb2gOx3TGCEmU7sG4cwmNKdbZCVAuNW7qC6Yib92CFEUMJkFMb
   JLE07Zodb9HJR+WLR4Vr4vrMiKeLggXEYsNXXFoPp++WMpv2Osdrfo2El
   KXbzeUDszAkj/xH8QYAzEqBm9GEv16ETMXhQlvhVOblFHKzGm7IkWbgVn
   fgx9IXYJLzQWUjKMTiBgbX5kk+gx4Xq/jet3zV0RBoHDUL+weIxAqSKjd
   6/GiyDvxqeEga6vLynmE6jP9pOl4GlczNLvcqbkIkLBZHvrwL3fpOYqLB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="347044983"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="347044983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 13:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="673343767"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="673343767"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 01 May 2023 13:48:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 13:48:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 13:48:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 13:48:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 13:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l058mIF1VsfFJVLV0lH/UOKehVafaAysw74i2DQi9SKtMv0w4n7F6ZNBv6BjzU5h9RFIesBUmHlidsVo5wK+5gicmqI8iVQcpfdhbD4ZcMozV2bNQyesD7RWe7QLiIEacCkfPSX7FlNEsL1B7vFE8z3V3ySEgjz5iSzvplqBQRltNOuTJOKPJZ8pWAxcXbyRBmDPlooaXfplmZQQB0FolQpkHw23N0cGdGTHtnM3X76Cgnyix5mxkS3nFRJ3ZKk84qXf1urtgjpiL4XrjdefsTDfzlbAnw6zgpk1gniMakSSjNO/8ut+8Q2f/O1O13Xn1cpjD146c3TAk06QBpJQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srq/ysSSuZP/yZbwlc3MRmGU+tZHzEPVxt5SrNT+/YM=;
 b=YHJmJwulk30rUWoexCVJTvg8vkY5WrdyUfcG/k627BXf9TEZmBeT/4op6iKOJXCQ5KunvDigAKt3E3wbPoOy2gD/cZxwVTSvVsbUc6X61WAFDV/3+loGGmyIeTZHxqmmaFCat2ckyhBl1PZObln0dnc/rckEpE/1teZxCiu6n2GI2MvObLqFU4VnMPUigcYAper3kIwv7x/CDsqgvy5rQ+mL04w2Z767S+AhiWUL2WIMywhDdUxB8qjh5AJTKITOk+DsB49adWb4/QXhtCWal2m0FftJ5RoseZyqoAY33f+DkMNiU8Z8QelDXQt/158iCv7+FTTJI6GXQpJuiOBxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA0PR11MB7863.namprd11.prod.outlook.com (2603:10b6:208:40c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Mon, 1 May
 2023 20:48:19 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::bbe8:5390:54c6:b0e2%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 20:48:19 +0000
Message-ID: <40de89f7-a87a-283d-9da0-d0681d12a541@intel.com>
Date:   Mon, 1 May 2023 13:48:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 07/15] dmaengine: idxd: add callback support for iaa
 crypto
Content-Language: en-US
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <vkoul@kernel.org>
CC:     <dave.jiang@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <giovanni.cabiddu@intel.com>,
        <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
 <20230428205539.113902-8-tom.zanussi@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230428205539.113902-8-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::21) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA0PR11MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6b79e8-2ce1-4473-1e33-08db4a85651a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4hvGNDhXtBxfkbjdWdjg0hE2Fb3PZoSE8+d6vmTEREmb0hguxkpZKV/4rp0lAGysF2HkwxiUV2f0CtTyAkTnYcyrSfCYhDFDG3nr/NBpd70levOr7OmGgFzXTm6LUWNfTiGvuItvqX/A8LSfsFQrMXuC3of+EBfcL2vVlhv6Vg4kRg/o34cY9Ozb/IldtjtXzAcqbidtnm5J5uMhWf/KaN0EeGvd1l8ZvyVbdjNFC5ncsn+JrNJn/Ncn0g5FxXYxxwX1kJ5AMuHaYXclcaZlklG/Py8U3YrO5k7l09WAaHvFBNKkqDy+mUHb45SKnmvu7d5A+omwGCsvWm4RBeq0G+9icwgA2MMGgjKXMQHOyZK/8p9b1AIM/unVdV/ej2ek4+wBgb3VKJUPaGZ2SjxysWwXAU3BOzLkBfTBDQTLOZwkWWOZQWwm27F0D7sy+wST0XoL+fRCyYx/v6U5uQ3eXv4OCkfCHBrSkAgJiuqosSk7Fpp5UGv48BpZPSmScB+WByQtQTlmXuBVaNf/TPIBkAojcfoyBIJzxz68AOi8n4vx0gc4EEARnCOWt9AeAz+JCbDln+mKLh88Dy66ypoHh3C8UZ4Npl7iQZVZS0mBe8/5VFx895hcn64zG7srcdRHOFhv+VRStVYB+sw1qEgFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(8676002)(82960400001)(8936002)(44832011)(41300700001)(316002)(36756003)(31696002)(86362001)(38100700002)(2906002)(31686004)(186003)(2616005)(478600001)(83380400001)(6666004)(53546011)(26005)(6486002)(6512007)(6506007)(4326008)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzlTWFkwS0FGZ0xzMldRZElkZVdPOUtMNXRlOFZGb0JSREw4S1pTcDB1QjAy?=
 =?utf-8?B?VFNaQytqRUViRnUzOXgwNFZNZysrMFFNYjNRL2pTeUJNamZlK0JQSkd1SFdI?=
 =?utf-8?B?bExtcXBrdlppZEZUV1NSSGg2Q2VhZGdZZXYwZDFWc3hnaFQycTZ0em1SUUVL?=
 =?utf-8?B?SkxGNTBaMUEreHpsL3BpQThOTWZSYmI1b2cxeDdQQVNGWHVzUmI4R1RySzhI?=
 =?utf-8?B?aENmcEJneTJka2xFWjNOK2NaZFA1eHl2b1BlcWpOMFpiWVVISllFMXQvZ09m?=
 =?utf-8?B?M1RlMFYxRi9BT2tVRTVtN3RMZU5iUURJVjZjUUJBOWxDLzRZMzZkS3huUEk2?=
 =?utf-8?B?ajQ4dERxck5jdG9XdTNWUFF3UEtEZmxHMEJyamRxbVRQdHlOcW5qelpmME1a?=
 =?utf-8?B?ek1QelpBeVB4MGVuTkZaYUFhYng3dmZCZ1hKMmc5T0pvVm5xaXpreVowU1RR?=
 =?utf-8?B?OWR5UW8rUkpMZjNiQmdpLy9sVERldDZFeUUwc28xU25zWWo4Rm91QjE3RkxH?=
 =?utf-8?B?cHJ0TFRUNFo5Q054TW5MbGJweGdURmFUY3BhRjFGdDdYa202Tlc3cDlzbGZk?=
 =?utf-8?B?ckg0VzJwd3BqUXZmYXhxb29hZnNHRVlPNG5zWERTdzRVc3BVYmVIdWI3cTNp?=
 =?utf-8?B?MXRwbXhqd2k0UE9VTlVHcDNiSlRxRVVkcXRWYTBXNWRiMEFqVHlpd1ZLVEtx?=
 =?utf-8?B?RjhtbDVXbkloMUhKTnQxMmRYYWpGajMvNUpsMGoxc0hKb1R6RDVjYUxBZ1hh?=
 =?utf-8?B?UWNVTkJmNVk2SUN6eFlGRWlaVzVhZjVxcWg0eXdld2xMM3g0aDZMaG9DektE?=
 =?utf-8?B?MWJvK0JlcjVCWmZXNG9kWjIxTmttbitMdUlFTHZvS1VKQkxMQlJBYUdmaWxL?=
 =?utf-8?B?b09Ec2ZsbUdxVGdlSDd3b0NWeUhZUXppNW5FQTRaZjV3TXZ1VDhKTm9ab3Vn?=
 =?utf-8?B?THpEam9wdmUxRUVORG5obXpkaVlUK0p6M05oSzFoemt0K21mc1MzZjB5cTNY?=
 =?utf-8?B?UmtsUFJ4RVZWT3B4NmR0bzFrcm90OEJFSkh1aDE0WmdReC9qUEQ4alNzRHZz?=
 =?utf-8?B?d2xlcS9MUHdIN1VUSXdCZ0Z1OG8vdVJzR084czlnRUN0RlM0L1F2cFo2NUZT?=
 =?utf-8?B?cE9GcTgyVEVKd1JtcllSdE9pYzVqMFRtSFpoMjJFU3pGNyt4RFhMUkYyOEdJ?=
 =?utf-8?B?UXdVK0w3M1J2ZSs3aVUwejNvdFo4VnM2T1V4NGxlNk1yYzh2V0VYY0k3VE9H?=
 =?utf-8?B?UVlIU2lPYllrM1UybE0yWUpJSzlBVVBBMjdSSkRpT0tlNGRGa3JaY1NRL0JI?=
 =?utf-8?B?NGVWY2cyclpVK0FONmVLMndaNHo0cU12b3luakFreE1HSldESHBwVFc5TlRH?=
 =?utf-8?B?Z1NyanUzeThkYVRtVk1XT080TzFJTTZwRTBUZ0toWnpJZE05OExPeTdhRGRq?=
 =?utf-8?B?OGpzTDFuY2NiV0IzVkQ0dkhyZU94UXRaNjFVSzZPbUJkeDQ3c3hMazIvWVNo?=
 =?utf-8?B?MlJ1NUlPNVU2Qm1MV0I2TURISHNqbTZWREx1RkU5bVA5ZnVxcklFeDN1K2hy?=
 =?utf-8?B?d0ZHU01pblJmbWdoUGowVmkvaFhJclBoR28xRzY0R3VMY1dyaDFhYk44clRK?=
 =?utf-8?B?WnFIQUgvSytTSGdnZW04SzBMOVdWQ3RDRUt2YlNpSFRyU1dYOWp0U1d4My9E?=
 =?utf-8?B?SlZGSHI1Lys2UnU2bTk1cFZ4dWQzZzRNcEVIZFpHd1FtUTlMTklSU0VQa2Zk?=
 =?utf-8?B?UE1zbElXSS9ZU2E5c0EyR2Z4cENZNlpnZiswT1NVY3ZYK21iWGdhTUdBSk1j?=
 =?utf-8?B?QTMyaTlPbEVoTTZaK3BBUEwzaFJSaTNOWjNXOFNYWENIb3hUNy9MY3dsV3JL?=
 =?utf-8?B?dWh6SFdNamorN1dub3cyZHB6bmNWcTJYSkp1MXJ5RzBmdGlIbXhpaEFycXF1?=
 =?utf-8?B?VFc5VzBqa3ozWi9zdERvSklsMjExSVRHc1h3TVNlRGM3YWNWQ25iME92TXVY?=
 =?utf-8?B?aXhQWXo3Y2ptVFBTSyt5OG81SFdjeXMzNlZ0cGY0N3dvV0pELzJmZ1RBc1hj?=
 =?utf-8?B?ZnVaMHlXNG5ZaWFPZzBZTzc3OThQcER6SERWaVNZcUorMkY3Y1V5eEVwdkFY?=
 =?utf-8?Q?dnZfa8dmYSqQTviNB2+OYP9cU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b79e8-2ce1-4473-1e33-08db4a85651a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 20:48:19.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyRSg+RK8oFA4WFCqZCSMegxCSw4vuGL9/rrxkv9wOzbjjMe0M6XDKW8itDhEJ4Qyo03M6uy35hn0HgQHFCXhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/28/23 13:55, Tom Zanussi wrote:
> Create a lightweight callback interface to allow idxd sub-drivers to
> be notified when work sent to idxd wqs has completed.
> 
> For a sub-driver to be notified of work completion, it needs to:
> 
>    - Set the descriptor's 'Request Completion Interrupt'
>      (IDXD_OP_FLAG_RCI)
> 
>    - Set the sub-driver desc_complete() callback when registering the
>      sub-driver e.g.:
> 
>        struct idxd_device_driver my_drv = {
>              .probe = my_probe,
>              .desc_complete = my_complete,
>        }
> 
>    - Set the sub-driver-specific context in the sub-driver's descriptor
>      e.g:
> 
>        idxd_desc->crypto.req = req;
>        idxd_desc->crypto.tfm = tfm;
>        idxd_desc->crypto.src_addr = src_addr;
>        idxd_desc->crypto.dst_addr = dst_addr;
> 
> When the work completes and the completion irq fires, idxd will invoke
> the desc_complete() callback with pointers to the descriptor, context,
> and completion_type.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
