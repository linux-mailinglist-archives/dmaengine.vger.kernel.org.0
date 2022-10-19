Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED479604E3A
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJSRJ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJSRJN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 13:09:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C21D1A8E;
        Wed, 19 Oct 2022 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666199349; x=1697735349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9UjTT1e7W7aTtsumyzVu1gFBU9URn/ypViRbyQeoK6o=;
  b=jQVH6w5AKKpbeyREWSmn30OpJibl1hWy8OLRd5W/NPtlicBxheRVDGLK
   f1yo8Whhye1t3Cr6tU5noPPS/bsp6HaR7gvhYxGCMsq0QMl/uEX9AUY5k
   fkhzV8FsHPAmR0d5TI3PxCUw9TgQTkiC2WjSX8T1Ch+TUC/aSiTCXUkKy
   dPdovnIqi2SZRzQFogscMZHUbv3Min1MGK+e5fy0uBKqyHwd/Q1AeFyub
   +iLG5Ulbt5WT417N1JDMCqL06Xf66a/C/dunfmzQO9ZBvPEKu7tvbOAqU
   sXkJ5yaxrYWyMdJnJrizCps4kCKsWDSzE4wJfaGzKHNUweg7jELY3vaJP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305211135"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305211135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="874532260"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="874532260"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2022 10:08:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:08:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:08:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 10:08:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 10:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxRZqQ6Ojh+F/k/TwmuNbNzxOLQA+jhjrUNKDIiuCg8scA6h1cNlQScWQN2Dakmt5nr0JqA6Rumze5LJQSQGqaB5/6MtXwgGsr/jV7uudsDY1iYvDtfNrCF6Znj+FOwPivUBBGuuPUDi2F5l46YU2WiZf3QqauWMq6cIQrG4dZ9530xjEk+xe9kLg/iPV5eifzh8+5PjI8N6APc7NPEUCTMK01yDNwSKxCk2DYQfkndx22lmDPwDQ0gX9ngr8p96bFYv/tXxJXbJddnzI/TociErDfhF9zd2Ohpm1LCuLz8JLpXpeKl9y+x9cZBMIdAr/z+mpYbOkUpWbAlFZHJsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB1WReb3EPBk7rNB0/e0j7p/htUav6euNyFSCNEFOhg=;
 b=oBR6LgB2RbL5QYqJ/Op+FK/CV2SZoohYSbX5fpw1J01UYN3Rp5Oeo9efsKlyT3RDB1SjGtVRDuEIjihIeIjTEFVs7vj5EuQIPF+pPDbQ2TSPkhnH2Z7DbrrgtPkd4ilpB/LSSKB7hVpi06qin83nLqSOYW5AGUCX+bCdDNtYAfS1tdchlbrc6qZOqvoXH7J0TU1xUAH7R9jRun/ssLc+EFp67yLhMuZ/M/cP5YwBXTe27xq/TvfTXFFLk85gfj9IHPZSbG9DLKAey3vACmfDPtN8nxdDGFw06NwpBLz9LgTChrtey3wHi45uAgMPvXooDgNUAbGRD/S9M+AE1rFLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 17:08:55 +0000
Received: from BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::1154:76ff:3b33:3ee2]) by BYAPR11MB2824.namprd11.prod.outlook.com
 ([fe80::1154:76ff:3b33:3ee2%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 17:08:55 +0000
Message-ID: <01d0009f-743d-4d55-7a2f-dd92bcb0b4e5@intel.com>
Date:   Wed, 19 Oct 2022 10:08:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/7] dmaengine: Add dmaengine_async_is_tx_complete
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-4-benjamin.walker@intel.com> <Y1AmTaT4oFDAWLLm@matsya>
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
In-Reply-To: <Y1AmTaT4oFDAWLLm@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To BYAPR11MB2824.namprd11.prod.outlook.com
 (2603:10b6:a02:c3::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2824:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a624312-b665-44cc-01ae-08dab1f49a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9ZXjnwYRQGqeTwGRbuJMMPG7me6p7IptxcouUvhhR7ffKtGdmoL7HmNKpGAuufgzo4ha/DD426A5+jQMc6poaDra4uNPzbCKT/ebm/FOZB+iOtvp0JS4Ubc1uJYoXsQzEx8bdK+UjaSnRAltcN6Yuoyho3pxV7TTkM/sHtAh4wyjJphFeeHT4uybX/z3Cy/oGLVDtDlYcJZMVJGUds0IwZALkH3TK/iJ02ixOuTWTGHm2S0FeUWoQuIi5Ilmv4kcnr8xeRPZue7oeKNlTzYRQWCTRlCx3jKFxg/GZUc3lcGa3tqKwpiLGsumjmM6ClkBwWrm2AUDyVAZkOwLP/aGHcVD+ODPfyxsXV3yYX6Ev/1+lST4QuXnYkd26jTgU/U/KH3Ihorxymagk4uvgdPntYGVX0IDNuy8h8Ungxgw6Z2MEabj3cYOHOkMiB/fB9RiF9TU1G62DMZGyHQyL/G6QBTKSysScCTP19GFqfG4cBQ3YBIsAuZqpKv3mOiCU4yxXqCF4ay9cfZF60PTjMl0nrKbQjjdKnokUpyuDsT71NwDZTdlF2Ajru9wN+oGkiEsb5Cbtn3oyGa5uQmg38VXWrAYulcpQej/h/nnwMMVZfMIBH1YDbQnPizKlOgpYBqPnSjaU9frt5oC8ZBjLfQvErZzsd2rZHxx4KACq5yxagR6bI4sT6H3tkDJgKZaJGmFY5TK1F7NXu4M+QYtkLHCtXzO57omXyX08sd5fQIRiJo59jpsu1DmI2u9QH5VuieGM2fPVLpSVe5GgTZEZwgl3vudoQam1lFgK1jbhZU9+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(6506007)(2906002)(186003)(41300700001)(6512007)(53546011)(36756003)(8936002)(83380400001)(26005)(5660300002)(2616005)(86362001)(38100700002)(31696002)(82960400001)(31686004)(6916009)(6666004)(316002)(66476007)(66556008)(6486002)(478600001)(66946007)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhrOWlrZFpTbkFxR25DYkhVUFh0YjF4WWR3ZnhBYTBrOEUwNWN4SFZNb2xy?=
 =?utf-8?B?MzVQK2l1Y0N5RHNPcnFLODJUcFhqWEdhSG5ldXZLZCtJWUQvVUhlZDQyVytq?=
 =?utf-8?B?bmNKWCtObm5icU5uRTlLMDE2eXJwcFJvY09DS0JCQnFnbCtTN2lPczRPMGlk?=
 =?utf-8?B?UkJNbDgzQ2k3emU3dzFPOFNjemUweS9hSnZoY21OUHp2ZjA0bUtFUjhNVVBT?=
 =?utf-8?B?V3J3Tk85U2NVd1Z4elZoTUxlM29hZGMreTJJcXR4ZG9vZlFXN1Voa0pmdzJ1?=
 =?utf-8?B?b1l2MEpseUVSM2NLYUhOWHc1Smo4R2E3NFlvU1lOK3BuWjZPNFFFL2NxZTM3?=
 =?utf-8?B?RE1BUDhlUHRIZ29JMU5PRUxaZCtaZ3NUbDYydElqK0w0U1BoVldsWE9YbDlq?=
 =?utf-8?B?dk0wVGFDVWFoVTJicGJUeEZwb2FDTTQrWktFN0wxYmtpSU1VVXdCL2pveVpJ?=
 =?utf-8?B?cm9FbTNxOHZQZWkzOXB5c01pdUthMFVpeTdwREhMTWNzUXB1OXIwV1RhcU5R?=
 =?utf-8?B?N1RlZVpwa0EwbE1uMmxhY2EvaENLS2U4dWdCdTRBcTNWSDN5WnF6SnpoUnhY?=
 =?utf-8?B?ZUNYUHJRL3pLeGp2azh0ZUlIa0pZQVpmK0srMWxGT2xhZURQd1NJcms4N1JQ?=
 =?utf-8?B?NFhxZzlKbk1LREFmTVpOSDVDYlpTcDNEeFN5Mi9nNHp2WWlsV2w0Z0dMWnJl?=
 =?utf-8?B?OE9PbGUvRmppQTRoVm0xTE1OaWt5dTRXL2JXank1bjhNRVZFTUJjcVpzd2VY?=
 =?utf-8?B?RTRIKzNTd01mSmMzTGFpalhqMzBGZks3R0VIRWJIZlg0bm10NWJGRmszZXZV?=
 =?utf-8?B?dE5IdHdOZ2c3aGxhQ1VUeUNoT2Z5c3pqeDZEYlpFc2dKWTVONURqTjgrQUpp?=
 =?utf-8?B?dFNIdTkvNVB5cWcxNWVzRUZ3SktVbXF2eStDRkN1NFduNWRIT3BZU3JleTZl?=
 =?utf-8?B?UnZ0MnlpeEN1TVplZ1VUaDBMQjh1VWtZcy9tUTJSKzB5d2FKQmNGQi9hTStv?=
 =?utf-8?B?ZGpzUnJvR2todHBPbUh2MUVlLzFJRldQMDFIeVBTeU8wZ3RFMWhrWGQ3OUNW?=
 =?utf-8?B?YW9FemFROE50UWdzYk9XWTc1NFVNalYvR0gwTzJ6TXpnanZzS1grbjhDcFpE?=
 =?utf-8?B?TXVqYzJwblp6S2E4RnpjYm9WTk53SjI3eWVnb2lHY01Ob21MeFVSZUhHZ3BM?=
 =?utf-8?B?YkRKS0JKdEJ5ZHVYUVY2RjJqNnZUcEZKakphTmtGc201NVI5bGI1YnhRZWp5?=
 =?utf-8?B?aDNSN3JydnlEbmgwV2xVQnVnaXJmQXVoOVpUUkdHaE82S21QeXNuV0FFb0o3?=
 =?utf-8?B?bkhzbEcrRFB4NjBSK3V4dnVhVGtmYjQ1YThZMmtlQ0Rwbi9ka3Q3UXp3ODlP?=
 =?utf-8?B?aDJ1dThIdXVzWVVLaVJra3ZaN2lIU1ltYlhQc1ZMZm1hOE0vTGlPd0VCMHFq?=
 =?utf-8?B?RzZnbGRLL3Q4ektyOW8vOFJrKzNQajBrbm1vVWU0SzNFaU5pUTNnTEpla2I4?=
 =?utf-8?B?YXpGZmV6YkFnaUxSVWR2Qnp5SVVLMjV4MEEyQ25lT0cwYWFHRk05RlNRN1NO?=
 =?utf-8?B?TkVLSy91SGliTFRuOXVNK3VqdHBlWStiMGZmVWdkM3dWN2NMMzcwQVNOLzR1?=
 =?utf-8?B?S0RoRE1IcWMzS2ZzZjlWMjFNZ0VVRUxWR0YxUUw2MEFCSVBSakZSQ1FnRVo4?=
 =?utf-8?B?R00zbUFsY25kWDh2Tm4ydFFsSCtaaE1rV0FvY0Q3U1FLeWtBeFRUUXhJTTEx?=
 =?utf-8?B?aS9tNEdOVmw4WERHdSswalB6S21iRHlQWDZ6eGs4VkIxQkc5dXhXSVgxeWda?=
 =?utf-8?B?QjRocWQyWmY2ZjVSL1BhdzV3eXJKaUFKbTZhckVpcjN1czM5S2c1ZFh0Syts?=
 =?utf-8?B?cDQ5am9UZlZYRERlREt5QVE2Z2Q1ajBlWVZ0dWgyakdSWFF1Q3FoNER6NkdG?=
 =?utf-8?B?bnNLY3dLSVBzdENqSWdsWGZxOWxMMUFESk90dTl2djdIbzJGajN4S0pKbUxM?=
 =?utf-8?B?Zm9HaHpmaXB3ckJER1l5UFp2QU9YaDcyTHczSGtITHFqYnNzVlZqTHNsWVRQ?=
 =?utf-8?B?MlJya3lub1hMOGxkVWNDay9GeTJUbU9ZakdtK1AvMGNkSzJKb1dmemsrNWJ2?=
 =?utf-8?B?SWYzZTkwalJDRG1PbDgva1JvS2FOMW5NTytOeXRVWlZkOTlBSEpMQjVOS0tJ?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a624312-b665-44cc-01ae-08dab1f49a74
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 17:08:54.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23KxMIjSwR1Jr6D9MWNGZie+FT9KPjfhbGKotkOiaSX+Elgf/co+NU9ckrF7dyJhyhCD5bfg0eDOqEWJ/NXWkF2XKv09eEGp6+MRm76kg+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/19/2022 9:31 AM, Vinod Koul wrote:
> On 29-08-22, 13:35, Ben Walker wrote:
>> This is the replacement for dma_async_is_tx_complete with two changes:
>> 1) The name prefix is 'dmaengine' as per convention
>> 2) It no longer reports the 'last' or 'used' cookie
> 
> Thanks for this cleanup. This is good :)
> 
> But, why should we retain async is API here. I think lets cleanup
> properly and rename it dmaengine_is_tx_complete()
> 
> we _really_ need to drop async and have everything dmaengine_*

Ack. Misunderstood earlier feedback to change dma -> dmaengine. I agree 
the async needs to go. Fixed in next version.

> 
>>
>> Drivers should convert to using dmaengine_async_is_tx_complete.
>>
>> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
>> ---
>>   Documentation/driver-api/dmaengine/client.rst | 19 ++++---------------
>>   .../driver-api/dmaengine/provider.rst         |  6 +++---
>>   drivers/dma/dmaengine.c                       |  2 +-
>>   drivers/dma/dmatest.c                         |  3 +--
>>   include/linux/dmaengine.h                     | 16 ++++++++++++++++
>>   5 files changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
>> index 85ecec2c40005..9ae489a4ca97f 100644
>> --- a/Documentation/driver-api/dmaengine/client.rst
>> +++ b/Documentation/driver-api/dmaengine/client.rst
>> @@ -259,8 +259,8 @@ The details of these operations are:
>>   
>>         dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
>>   
>> -   This returns a cookie can be used to check the progress of DMA engine
>> -   activity via other DMA engine calls not covered in this document.
>> +   This returns a cookie that can be used to check the progress of a transaction
>> +   via dmaengine_async_is_tx_complete().
>>   
>>      dmaengine_submit() will not start the DMA operation, it merely adds
>>      it to the pending queue. For this, see step 5, dma_async_issue_pending.
>> @@ -339,23 +339,12 @@ Further APIs
>>   
>>      .. code-block:: c
>>   
>> -      enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
>> -		dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
>> -
>> -   This can be used to check the status of the channel. Please see
>> -   the documentation in include/linux/dmaengine.h for a more complete
>> -   description of this API.
>> +      enum dma_status dmaengine_async_is_tx_complete(struct dma_chan *chan,
>> +		dma_cookie_t cookie)
>>   
>>      This can be used with the cookie returned from dmaengine_submit()
>>      to check for completion of a specific DMA transaction.
>>   
>> -   .. note::
>> -
>> -      Not all DMA engine drivers can return reliable information for
>> -      a running DMA channel. It is recommended that DMA engine users
>> -      pause or stop (via dmaengine_terminate_all()) the channel before
>> -      using this API.
>> -
>>   5. Synchronize termination API
>>   
>>      .. code-block:: c
>> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
>> index ceac2a300e328..1d0da2777921d 100644
>> --- a/Documentation/driver-api/dmaengine/provider.rst
>> +++ b/Documentation/driver-api/dmaengine/provider.rst
>> @@ -539,10 +539,10 @@ where to put them)
>>   
>>   dma_cookie_t
>>   
>> -- it's a DMA transaction ID that will increment over time.
>> +- it's a DMA transaction ID.
>>   
>> -- Not really relevant any more since the introduction of ``virt-dma``
>> -  that abstracts it away.
>> +- The value can be chosen by the provider, or use the helper APIs
>> +  such as dma_cookie_assign() and dma_cookie_complete().
>>   
>>   DMA_CTRL_ACK
>>   
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index c741b6431958c..2816b8f492dab 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -523,7 +523,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
>>   
>>   	dma_async_issue_pending(chan);
>>   	do {
>> -		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
>> +		status = dmaengine_async_is_tx_complete(chan, cookie);
>>   		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
>>   			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
>>   			return DMA_ERROR;
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index 9fe2ae7943169..dde7b9b626336 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -831,8 +831,7 @@ static int dmatest_func(void *data)
>>   					done->done,
>>   					msecs_to_jiffies(params->timeout));
>>   
>> -			status = dma_async_is_tx_complete(chan, cookie, NULL,
>> -							  NULL);
>> +			status = dmaengine_async_is_tx_complete(chan, cookie);
>>   		}
>>   
>>   		if (!done->done) {
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 5ae881729b620..0ee21887b3924 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -1426,6 +1426,8 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
>>    * @last: returns last completed cookie, can be NULL
>>    * @used: returns last issued cookie, can be NULL
>>    *
>> + * Note: This is deprecated. Use dmaengine_async_is_tx_complete instead.
>> + *
>>    * If @last and @used are passed in, upon return they reflect the most
>>    * recently submitted (used) cookie and the most recently completed
>>    * cookie.
>> @@ -1444,6 +1446,20 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
>>   	return status;
>>   }
>>   
>> +/**
>> + * dmaengine_async_is_tx_complete - poll for transaction completion
>> + * @chan: DMA channel
>> + * @cookie: transaction identifier to check status of
>> + *
>> + */
>> +static inline enum dma_status dmaengine_async_is_tx_complete(struct dma_chan *chan,
>> +	dma_cookie_t cookie)
>> +{
>> +	struct dma_tx_state state;
>> +
>> +	return chan->device->device_tx_status(chan, cookie, &state);
>> +}
>> +
>>   #ifdef CONFIG_DMA_ENGINE
>>   struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
>>   enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
>> -- 
>> 2.37.1
> 

