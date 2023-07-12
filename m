Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201357510F1
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGLTHd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGLTHc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 15:07:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D5198A;
        Wed, 12 Jul 2023 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689188851; x=1720724851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dwWLpUqur9dwH20bBllxz+xBICUnf90zrRqso1Butq8=;
  b=LUIfRAg5NdbiF+XaqCprlzml17z2yHLsoQd03j88qNFu3XPcWNbS6x6W
   pUT0dJVY1uIu7E0JfW1p9RdCHZEXUvxJmr1gTSNmOmQLfd9bOHcvhDcCq
   PlMrTl1GTClR7YZ9zT2ecK+mK2Rx15XphWHITyiVXLa34o45yd0Vt8quW
   DgtzEYjo6JTk8rmUFmi/6usZUXmbbteA3mlv1mWtSHRXOW7SkB3HIMJvA
   smwwaJAkPBg7a0M8/363vO7d8X32LgRwWS7AFAtUkATvC08zow+L1x5uW
   x3Wgrh1P30SyhMD/vjgN8ZUVXwnat9o0HRr+Wbl1nx3jVN2XSZuxc8awE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362445929"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="362445929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895729548"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="895729548"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2023 12:07:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:07:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:07:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 12:07:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8nuL3Xevfvza3WnZ7UAdYq7enF4KQvc35HYgMcP2KpXqedHPVOXELZzLltuLp8JWGXbRFQaph5omSN0e11A8cDQxtenYviKJorQZB5MwQ36Yl2B946V33d+YJkPdwgWxHmJ9My7hwBW0SFsA7NJLGswu+m6DjvP2HSUT+073clV5mEcLhaythUL67KVkOJbBxYqAAXHifXu1Boom6Afa6WaRJfm4VdgSA3agDLdtIvn4CZ+gnqWRiASdteHWLQ25Stn/Pf6vdELzhzJFDGEK959SpsJEtoEVU6zhOzbjhO5gqbBtix6dc1nsCLHw+WoqrH0x6FziCtE2YAw3uHi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2XGNdX7ZkeghndN6PdhdtfC6uXslcUfR5Md6WrE/dE=;
 b=E7MLjmOghi0QnooNRI4GTFkhiH5JDhDGcwU9UC1ONa4SDETMYJUlgaTgN5fX92YOQVpfEZD6P3Zda3+3qXttUOEPFGcG4pT2e7xdjOssQiZTisU7By+K1+RkmtlvbR4GG2OouDB2EYtLdse6/ayeX5t6IdDSMGFa/3YEVty9SbXqroHkfFGZunJdbuUf9o4JIWFF6PoC16eVmtNqkSuL+VYZ0zzQc7BA/Y/Pl7TE3s4rlU6p/mRFKgZCasJ+hqCZf89pUsgOMJnpi/Zre44HN+eCe2ogiu79prjbF3rXBjCyAUI0ExxDXvLBComE7c28bJLniOBX1GYlWDVoQzXpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 19:07:06 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::724:7e04:8501:228d%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 19:07:06 +0000
Message-ID: <14f4e06e-8584-9dc3-ce85-b2491645b894@intel.com>
Date:   Wed, 12 Jul 2023 12:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dmaengine: idxd: Clear PRS disable flag when disabling
 IDXD device
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>
References: <20230712174220.3434989-1-fenghua.yu@intel.com>
 <56681a68-a2cc-6bd1-3e29-dfc02bc07add@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <56681a68-a2cc-6bd1-3e29-dfc02bc07add@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: b864e327-746e-460b-b886-08db830b2edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plMjFCcYfCRblfqde3/wqmmQWyjfi+d4G11EM+IvaSMNpvEA2DdhUHG6NE4iL+n2jFKl/E1BOvnhIMW9FIAdulj7VHIEOkUut0SBU448eMptltMLwn8jN95OLwVb4z6PXBeI/s3LwP5/q473MYMpH6DVBfJKN4UD9LHXe4c8fdvUgg0/SWr1dRHWdBz6eegadUhchPmddO2lAA3ADSwDujGqcMzRXgZvkBTlgDm+izEejMgrpugGipJ9HQpd1v6huDQ7iZpDbiJHzBjHMM55XbgZvtzf308ABqQEc50RNTL9Lnx5P5j0mHRhOEQX+l7KX13eZsDQYGJ7gVs+sJhn50KzW+tuwZ1QlNdndKtcwiX7zWMsyAxV6OpPyzaNRwjgo7vS3mWeetJmjUQaTTmf8hLofdkIa8LLgWCReEetKQmceulZh4EHMCVDiFVXNRt98IzrVinJJmHcI4jTNSD3Tc5QeKswkHb4rDJt56TNaHbC44mqaaU2uotvDf3sVhfgOnAu5J6BkU/63nmuabcfCn9qKjzXQmqv4d9tx1DNUomTTgRx9kYA4ekO/EcvxJYoB7oWzq0i1DYQOSguopNmIdd6bH8NqYoz2SaUhwPqnwQCmQt9G7xQcyqGYuwDJh2J3q8Qu+CTBSXvT/N8DyjazA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(31686004)(86362001)(186003)(83380400001)(2906002)(44832011)(2616005)(8936002)(8676002)(5660300002)(36756003)(4326008)(66476007)(66946007)(107886003)(478600001)(316002)(31696002)(41300700001)(110136005)(6506007)(66556008)(54906003)(6486002)(53546011)(26005)(6512007)(6666004)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmorYTZxbUYzbUsrYzg4T1F6ZmJCRGNSNUphN1l6ZTJtc2JhNzlzN3FsMm9m?=
 =?utf-8?B?a205SVd5QXZhVmNkQ3k0eHcwYWdxS0xOOEMvTmQxSGVJb2h3KzB0OE9pMURt?=
 =?utf-8?B?SitIR2dmSWlEcWwrc0k0Uk9MNVZIanRVcjh5VkNvbHBMNnpYVkthVGg2Ry9F?=
 =?utf-8?B?RkhHUjJOdFR4d2ZERWF1cjgwblFDaHJSSlpWbFJuUENPdllyQzRSNTNBR3dU?=
 =?utf-8?B?M2NiRVJsSnFDcDhZd2NQYzVKUEpPYWtjNEJnTWVUQTBHcmsxUllrd1IyQjRW?=
 =?utf-8?B?elFiLzFRazRqTkdEckxHeSs4QXVrUjUxRWZtblZFYSt2NEQvZHZrUEl3RWNK?=
 =?utf-8?B?K09hbDBDSGdya2FjVHlqTXhQZm5BYzYvVHdGYVBEZ0p2WDg3OUtrSU9aK1dN?=
 =?utf-8?B?S1AwaEo0ZFplbyt2Nk1neHRUczdPVm9DVnlJOWhyRnRQR0sycmdRVXdHNndF?=
 =?utf-8?B?QzczcjgrdTR5elFjSHNRNDlNRmtrNGd2c0ZxWEdmdUZVMTYxbmZ4ZUZsNHNB?=
 =?utf-8?B?SDYxcXU2am1rSjl2OWVrZ004T0ZLalBJd1RPemdwSWhvWUNNNHdpaFluWnl0?=
 =?utf-8?B?Yi80L2RTYVUzN2prQmRQYkFwbmpiQXVGVnVXdmQrWjR6TUxlR25ldER4eGMv?=
 =?utf-8?B?bmQrSHZubXI0d1lEM2hRdzlIYUw4d1NYNmxSQ3RBOVNsR1BRZHlrOEpLQ2tv?=
 =?utf-8?B?Z09rMjJOcEJjRmRGb2hwM3F6VzRaNTNzZW5OWHJWQUhHWFhudWlWZFhBUHFt?=
 =?utf-8?B?WWlFWEpjZXd3ckgvYi9FOVRYeGlqUmpocisrdHdwUHd6Qkt1YVFxZTVBMWk5?=
 =?utf-8?B?STBwMzhra0UvOFdvR0JSR0dzcWxBMFFqRnN3cjlaSXIvek41VlVwY0kvTFlu?=
 =?utf-8?B?eGlUWHhGRUpzMnVoaVhqNmpvSS9maS9kL00xZTdYUE1aczI4NjZVNllGMGxp?=
 =?utf-8?B?YUlmQ0g1S202WHI3RkhadW8vNC8wQ1FGbVUrZ1hwMnY1NCs4WXQrQnZVbU8v?=
 =?utf-8?B?UEVLVkNnREs2c3lmazdJMTJJUk1qL3VDOEl3SmxzVjU4R1hXVXlVTWR2U21P?=
 =?utf-8?B?dVI1MnhhK3VNTDVUaU44TXFQYUkxZlM2NVR4T3VxYjUwTXdJKzBQV3B3UEhY?=
 =?utf-8?B?RDlpbVdJYlh0cllzWE0xazZJT1EwckR6T0IrTkFnTi9oMFhaSVFJYmdaZ21R?=
 =?utf-8?B?STZnTnd0b0puWEV2NTBzWkNPRlUvRm53L1FEaGp1Z2dQT3Aza2R1Ry9QME91?=
 =?utf-8?B?SmR3ZTl6enNJOEQrMythbk41M2kwN1lEWHA0WjdnY3V1WVMyQWM4YlFEWmpv?=
 =?utf-8?B?aE1GK2Vla2tOMUtYMHBvb21GSzNqajRIa1BaM3NhU0tSdS83c1MrYzE5ODg4?=
 =?utf-8?B?TmVOYWZYc2xzVWdsTSs5YU9Ka1lOLzkzLzI1ek1RR0J6cGxFSHUrdjZoaCt1?=
 =?utf-8?B?cEtSSkxOcjlhQUVKM2V0OFVOVXdMZ3ZVMXVwb0w0cEsvdjBuV0FManduSUY0?=
 =?utf-8?B?Rm1jOVpZa05EVkFkU3lacnk1Y2hYL2VYUlJuOGVMOEtZcXVscVhlQ3l6TGhn?=
 =?utf-8?B?VVNNNHY1a0RYZGFYVW4zV2lXVmhFOGZ2VXpjQTMraDhjQ3VsUktobS9oM0w5?=
 =?utf-8?B?NHk1WjlpZm84dkp0ZlpyRDJjMkNCZDRmRi8rQ0d1aHJmUlRJWElYdEdDcGx4?=
 =?utf-8?B?amQydGZQMGhFVDRXVEgyOVpkOUFQUEZIUEthR1NKS1NKdlN0YjRmcTJZWUxJ?=
 =?utf-8?B?UW9mVFhUNW9kSmdjUTZXcHlJUEhzdHc2TTBJUzlPMVFlT05QalRDODBUbWdV?=
 =?utf-8?B?TWpHSURMdlNEaU1qNDR2M2R6NjRKUzlBZm8rYTQycSt6VGZVcFc2VTh3WkxU?=
 =?utf-8?B?VHdoSCtMOEZYWEp4eGc3RTRCd1FkZ1E2NllCR0lLdkoxaWJVTkZnWitxS2M1?=
 =?utf-8?B?SE5ZbHkrZis1VWlwK1krR2M3dTJoTUdtellVNjROY1UzY0ZWUTI0OGxjTFQw?=
 =?utf-8?B?L3grbkhzejdFTmMycnlPWVBFMGFhVkFsaVB0emdEVGhxNks4SDM4eEZORWYy?=
 =?utf-8?B?Tm4yOGNJT3MxeC9KR3F6QWJEY083aUtYRFEzK0JFTm1NUWJURmJjcXhRbERO?=
 =?utf-8?Q?Zq5XcHonolq7EmtN1iuRihETq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b864e327-746e-460b-b886-08db830b2edd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:07:05.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIdXeek60fPO3zT+J7DoGApoH6Kp1WaKRClLuXN4y8xA7k1aSixs/5Wso7FHe2AreSxmJuCY8Yge/fgqnItePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Dave,

On 7/12/23 10:58, Dave Jiang wrote:
> 
> 
> On 7/12/23 10:42, Fenghua Yu wrote:
>> Disabling IDXD device doesn't reset Page Request Service (PRS)
>> disable flag to its initial value 0. This may cause user confusion
>> because once PRS is disabled user will see PRS still remains the
>> previous setting (i.e. disabled) via sysfs interface even after the
>> device is disabled.
>>
>> To eliminate the confusion, reset PRS disable flag when the device
>> is disabled.
>>
>> Tested-by: Tony Zhu <tony.zhu@intel.com>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Should there be a Fixes tag?

Will add a Fixes tag.

>> ---
>> v2:
>> - Fix Tony's email typo
>>
>>   drivers/dma/idxd/device.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 5abbcc61c528..71dfb2c13066 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -387,6 +387,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq 
>> *wq)
>>       clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>>       clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
>>       clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
>> +    clear_bit(WQ_FLAG_PRS_DISABLE, &wq->flags);
> 
> I wonder if it's better if we just do wq->flags = 0? I don't see any 
> bits we need to preserve. Do you?

wq->flags = 0 is better.

Thanks.

-Fenghua
