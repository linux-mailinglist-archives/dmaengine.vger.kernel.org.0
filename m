Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1D76EDFF
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjHCPY7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjHCPY6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 11:24:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29830FF;
        Thu,  3 Aug 2023 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691076297; x=1722612297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Arxbr4qd6BisAThpDMLoCAWCnySimLM+hfJR7I708YQ=;
  b=fdhmoqtr9cCUxr5SRz4ELxXmd26m5txj9/ZGlrs6eUQmugp+DG0n18EL
   zVCIS2uOCLEfSwWEiqyttksCGZshQOlhFVltEAHW5AARslhwlo1XytJaz
   /YIEb0l+uWDpx5lty6UdcB4rDLYg9GcF2R6mmgxaNgbK6leMMVosZ1otw
   3+njwXcEodRghKlBCUxzOkZsnKMPkSs8zFMsWjhO2aCh+qpFdzC8XbUaz
   O+NVVGqYkKPfqpWmUOc6q7gXPmiXCADr9EfnIcIfosPUztqkoMlnk7R5E
   pN8wHSiTzj7v6GBOGmUbLdJsZ9nh/eSK7pDa53OASJp+0DU0wjFtnr4oK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456281395"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="456281395"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="843627627"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843627627"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2023 08:24:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:24:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:24:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 08:24:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 08:24:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWFsu1yLR0n2NykxC5um1hk2oGmHOGvj0RSxaPWl42W1z7roNRqpq8L0RJ1G1NuR8pyNCDDkwg159OPwvfyQgptHrebV9evCaIlq1J4oqWP1ZwbRP3O4DaK7Dj148es8aqvrhJYddampLxY8jIh1ZMWMkEQEgYBMlTx4iBFv9RZlWt4C44Dso8J2nqEwcmK1iPtJxVTBdI56CWGoQtdNyvtw2sq/8LC4m4YDE+6ZuQw9wWAafm4ShWm55fD5TYJ/xvRGlP+X/O3vovG6hPlPovuBDrI1h8zLnxW9qslIFyqIkCoQ/T6huQIeS1wP7Z9DrLjgdw9oa6CThcOszPQ/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgX1/Bd27BIx0aIO5qv9nxDMbhOVayFT/9UGhLbhDLE=;
 b=LDMGAjvkpkbKZyOmqovG31zWEym4SFDSAvx5eOYRqCMKOgMV7W/5zP0CerLnCeb9WSt2PvJ/a/ZQMbRZTD0z3CPPCSta4PbDrRaRwPfULFH85fy9cPc3n5SGLRw5BFyq7TrfpGvzSUl6ltkO/eKopFBz4T8GkHi8Em18hKMXLrCruxMy3VGA0gq4dopenA5QVZiWUKQW/bKB6pWqAN1iv0Om0Ab/LFU0GwR6AVRdDEgXWWJ096U9WNwc/H9Lo9m2edu0apIDWnuGU5eEY67PENsNAIMRnCwuOxUzM4Q+oTLj1fC/Ax84Bcfb119X73dYlRgrpBBGNLZk1lfXXsz66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:24:20 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 15:24:19 +0000
Message-ID: <52b44427-4670-15c1-ef96-8344413e76cc@intel.com>
Date:   Thu, 3 Aug 2023 08:24:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v8 03/14] dmaengine: idxd: Export drv_enable/disable and
 related functions
To:     Vinod Koul <vkoul@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <fenghua.yu@intel.com>, <tony.luck@intel.com>,
        <wajdi.k.feghali@intel.com>, <james.guilford@intel.com>,
        <kanchana.p.sridhar@intel.com>, <vinodh.gopal@intel.com>,
        <giovanni.cabiddu@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-4-tom.zanussi@linux.intel.com>
 <ZMuoi8FycD28v084@matsya>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZMuoi8FycD28v084@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: ec253260-ca79-451d-74e1-08db9435b4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDdLpVV6dYLM7hxaI3wLnDWCe6pUgcG7gZaFUIga4GMhEmxKCReOgUlq0CHJ+RRyi1JuYcedH7NfYzwn/jzyBoDE5LmDpK6Jl/YIBulearWwqz20nLylYtOUyiKKUj2gd7CFp1caL8cBIV5azJ+Dzj9GX6MFHE0gXyF78+l88DCDfVR7uX80671HtQTIgw+lP/rR0BbASGEjcGLa+4wD1+zcm6CmXtiYYbksmoxmz9b+AncOKlDHQUy6VCJRXLpspIEJW6IM+RGI8OxNTN9IBr6Ogrdqt0kMnfWn0UcWYVdCByGTTdQTobieTnGwAVwRR2tBEXV/M2CQef0fx7SuP5F7pOFvTh7l8jOMXCdqUReW159cadC52R6DkgN+p+3DwHhZYDIw0jDXS3n/hOttX6T+aczGSRGchWbaeNtV3Q9eODFnF7mqGJgq8ZEqHfe4n948p6c4R4zOBJ5nSW0UtNkM0JOTNnpdDI982aMRtXpP6OnVhvByCe4gC2OfGNyjFycYBrkQYAnpXILlzmHgy9SGGTxBWg2bBOhoobuI15o4PuZYmJzk783APNaRFV6wLcRQLHnEtqepxQX1GvAohEg5J1fnC7vgV3sEmMWOAQXgOFVHbs1pcBCGJp4B1ZUTsm5apjr2VVXIQizFHSagkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2616005)(53546011)(6506007)(186003)(26005)(8676002)(66476007)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(44832011)(8936002)(41300700001)(6486002)(6666004)(6512007)(110136005)(478600001)(82960400001)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R09lNHFYdXp4TUgyVlJTM1Fhbm5FcnNESWhoYXYyYTNudGkwMzlVak5yUTFY?=
 =?utf-8?B?dENiLzRsa3V6bVZEREhzTldJNy8rU24zRWt0T0N3dEhoaUk4U1BnT083OHJl?=
 =?utf-8?B?ZmtqbmwxekxFeXZWbXNmSy9vWmlTZmZaY0Z5S3BnalJRa3pFVTJWVWJjZnlM?=
 =?utf-8?B?RDlJd1RnSmZQY1ROMHlTQzRCMXMrM2s2MmE1VkttRFZhNm5WNDdIR3ZSY0dr?=
 =?utf-8?B?RGpHME5tTXFBb0ZsaGE3Z2NXbENQbzFEVHZGRjcrWExHNm5XV0JJaXFScDBS?=
 =?utf-8?B?UHkrZzRTWnJSMkFOb2Q0YVNxY2tVODB5eWVEMStQSjJ2UDFOaXk1ajZhT3R5?=
 =?utf-8?B?ZDRTaHBrbW1oM2JMenVsSDJNUkkyb1FFM1NjbWgzejBYNUhXTVZtYjg0WnpK?=
 =?utf-8?B?SG1wN3NyMWJDbFJLUFdhZ0Niek9jdk13cEN5QjhjVDRNT0VkUkZ1RThnMnRT?=
 =?utf-8?B?L0psb01ScEs0WnVkL2pjT2lZcy82MUxOUy9Dc3Z1V2h1RW9kUHF2ZU82N2la?=
 =?utf-8?B?M1Y0WVBrcWFZQUNEb056aTVMandaWERFYm1Oc2VwbGFEMUNaVFN5NE55am5X?=
 =?utf-8?B?d2xCZGh0dUtNMFlLL2dva3dISCtZUjRIaFRKWU1yWm1VVkJIZWRvZWN2UTho?=
 =?utf-8?B?UHBTaUsyZEdsWHVYdUdyaGg4dkxRQnVhbm9kSmlKVVNVdXVBZWpyTVFpT3g5?=
 =?utf-8?B?TGtveWxZenducXBpTHJURW9UbmdkN1hHbm9PaFZOcXY0ZUxPZW53OEhKUldl?=
 =?utf-8?B?NVRaeVIyNFNhTDZJMmpIbkZOMTNLOTZZRGpuQXJsUWZpZ0t1ODE0ZStsa0JI?=
 =?utf-8?B?cFczNWo1eFRseWVuNGRjZUdUenFiTTBVU0lJSWJrOG5DdEF0QjBnZE1uUnpo?=
 =?utf-8?B?d1JieUFSMC9Kdjc5cUs5SVJvWVN0RFVtVkxwa1Y3QWV2T3lXT0hqbTE3Rlpa?=
 =?utf-8?B?RTZ6dkpacHkyWVUrMHFtd2cvRFhhV1VIaGZqVXZmUGxRS0tPWHlzWXVJSy9m?=
 =?utf-8?B?czd4ejhpbHNiRC96VW5vWjJtNGhiMGlBT2llTm9OQ0p4VTlNQy8wMmNTaHlP?=
 =?utf-8?B?YmJlOFhXd1hTRGRWbFNKaU1YQjZ1WFoxOXROaWJBMXZMOWNpZUYwbTZoUmNN?=
 =?utf-8?B?bFkwZ0sxMUZsM0NFTFo1Q1liQ2ZMeHVNOCtPOWRua0JneWRqVGxnVHg2UE8r?=
 =?utf-8?B?VjhDUXNkalZ0b3lBZVo1aEo4Q2hyaTF0LzJ4VVNwNkNkQVNnRngyK3lFaDFp?=
 =?utf-8?B?cDFReExpeGRHSkU1aFdFMERhMUZTNVBUMWdzVDJORkY3VWxjN0FwQzhtUndU?=
 =?utf-8?B?L0pJRkl1N1JDUXdoOHhoWjBDQTlQZ3hSN2N4eGM2S1R3SFE3a1RMQVpncitk?=
 =?utf-8?B?OFhYZmx6RDRXKzdRKzZzOGk1YkFwUXl3a0JXL1RvUTVDZ3o2RFQrVnZOUWJR?=
 =?utf-8?B?YWZpRG9xMVRyZnlYSGp1Uy9tTnN1aldrYnE3djVCb1Uwdmx4REJlOTRXRDhY?=
 =?utf-8?B?YnlvNkVuVWJSRVFMWmhNSFBicU9ra1ZlVkJUOE05WFhIQXdseHd6M1dLZEpQ?=
 =?utf-8?B?MUJxczhvZVVjN3Q4VDYwUnFWbGloZmFjWU03eUtRMnFZTGgxcGNmVzVUZ1JU?=
 =?utf-8?B?d3FzTGlrcEJVb2REby9MWW5JTGRaa3JvNHF4VE5qM2p1eFpaVWxjMnlrWWZk?=
 =?utf-8?B?aGhidnlFNEtsZVJxb01xVmtBVDF4V2NET0FLUnlES0xBdkpTbUpjSGQyKzBa?=
 =?utf-8?B?cW40azBUZHhKM0pSOUdSeDRYakNCSlhjMWl1em5kWUlVeXE1UHlqVENtQjd3?=
 =?utf-8?B?eXJvSk1yM1FFSFJvOXIwaGllTFdWWndhc0tRYzQ5Y1hnZlREYStUR1lwV0R2?=
 =?utf-8?B?KzVtbDBwaFVCenMwMjMyWW9keURDdHpWSnpmZ0plQWZMdEE1dGhnNWpTOWNm?=
 =?utf-8?B?VEJDR0tiWHpRQmh0Tmw2TGVVQm5weDNhdldHV0tCNnNGS0dibnU4MDFNam43?=
 =?utf-8?B?ZCtkT2VyVEdtWUlXYlpWbHU4ZHRmQTl4bS9aYVNObjZhOVJhMmdhTzBNY25h?=
 =?utf-8?B?Z1BMQWlsaXM1L1huV2x0Qk1lY2tUVk5GV2pUS0p5LzJDbUVZcFhzRi9YWTk5?=
 =?utf-8?Q?IakHxRaFL66ivCNsvjXeXkHAC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec253260-ca79-451d-74e1-08db9435b4f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:24:19.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: livrpOwKMvT3NdG4i/HwHcIWpFrVaANcpWj7vLWp/iKYLahNaJtPqV5CehkzWK04GoDmE3XNocTHIWLeapFPlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/3/23 06:15, Vinod Koul wrote:
> On 31-07-23, 16:29, Tom Zanussi wrote:
>> To allow idxd sub-drivers to enable and disable wqs, export them.
>>
>> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>   drivers/dma/idxd/device.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 5abbcc61c528..87ad95fa3f98 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -1505,6 +1505,7 @@ int drv_enable_wq(struct idxd_wq *wq)
>>   err:
>>   	return rc;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);
> 
> Sorry this is a very generic symbol, pls dont export it. I would make it
> idxd_drv_enable_wq()

That's true. Although just a note it's only exported in the IDXD 
namespace. So maybe ok?

> 
>>   
>>   void drv_disable_wq(struct idxd_wq *wq)
>>   {
>> @@ -1526,6 +1527,7 @@ void drv_disable_wq(struct idxd_wq *wq)
>>   	wq->type = IDXD_WQT_NONE;
>>   	wq->client_count = 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
>>   
>>   int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
>>   {
>> -- 
>> 2.34.1
> 
