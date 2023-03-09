Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F346B1A29
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 04:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCIDvw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 22:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCIDvv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 22:51:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35052D49E4;
        Wed,  8 Mar 2023 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678333905; x=1709869905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oNN4p+yMfbqYELE8ZX/ZbsVx1kZzJA6LOBrSzsJpsmY=;
  b=bzt61SPLnz/vZyHpN+q7aDnOkyIDUXWKh7c7sqfXa9YOfm8Q4/zijjlr
   sF4F7ljRrkIx7x/CWf0ACUkicx3s2FmEw2DYGPhhGaHkfaUxvMXBkGxWs
   ho66EfmecrEWCK4SxjsjKK23z2/gV8koNl/6W/1TdhMwO0BCLs+HV2vNR
   gHpjyXS6UlVABuLK5o9WMBS+2OMnRxsOlGtoMr801X4IVcza3Rs5iGmnA
   ODd0LtE+6InS3ssdpAAVs6axEUEsohMEgn6/23nSAnL+WFFfQdHmDaxr9
   Y52dJs9NUmXUnl25nRCYCw2/ZGpzlvmjDcKXaU1W21iEFZ7zfBRWl7OF+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338682818"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="338682818"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 19:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="923068767"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="923068767"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2023 19:51:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 19:51:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 19:51:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 19:51:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 19:51:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S04yE5SzWN395o2GL3I7bkpyv+L80PrmbDzIgeAdFv4cXbuwjw+GGmz+TL2rUhDgqOs55RWVuI8SFofGjoQf6dzYsz+XvLkgGUJ4nmdudl6a/+MUizsr+eBkzsAFlm/llXuGFXCZlMALoFWonJF/kubckicj5cnVD+e2KQlkJJdkotvt0frbT21AmOPE1KNp5A7TaraPVieg9TDwFMJRBqY3CPn6IM1i8raiCOxPjjd9QKK8KE3lakWro3rqmMHoDxcpEwqeu1Jmc+3Q2xWqFm0dg8lh+5LtH7DL41wgEj3UKnUhCT4zhdW+9sPoP5fef9D4rd8Ogf1APyqac+AkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAQ3DpuKHASljDsU41vuuDOJzN+wJwxbItzbAQsQgo8=;
 b=WikFKmnIPahHxc+uhjLjM7yyZMoSuVbbiq7w6BtMmvnAQmM4+4TZwGttTJb1KiTrF6s6M+l+vWKZ5aHN83cszKCAc8321GK1Sm20K1vcn6YeUctnyNHfD+UZf3Fx1ZOQGR5qkR1mFR2BD16yvEvrjJVq0Mo22vpvK9oo6ZtiNW3HyRR8z1gFusQNKTvSg/R7VskHumv5zFGtmzCd3CKy7yAOCa5CR9E1gEWGtIAsmnIaA2+IShX6wOyBbTNaaysTuXDRGFKEQj6X0Pm9AkhjhGVU7Z12x8K+OXXfl5gDjG8SUDruI8K5XWQnHWLKllU79tErjjYYEPcvmajoV0AU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 03:51:40 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%6]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 03:51:40 +0000
Message-ID: <d00b97ed-2d25-c58b-f844-be4f4f159335@intel.com>
Date:   Wed, 8 Mar 2023 19:51:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] dmaengine: idxd: Add enable/disable device IOPF
 feature
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-2-baolu.lu@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230309025639.26109-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 95966f2d-4683-4806-f1b7-08db2051973c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGptgOjkSo31vd84QSE1WmAbQ70Z32+IFkUAht0n3N2+TgB1k6gBzYKzTzg6adrdhNngwSteYb/k/a7M/vDml4Ls5OgDEIiF/ITQlUiaWKS0zQx4mWavFzNSsEbKyTiV2GZHrLbvqryxjc6cA8+4jhg/DHzvyTDCSZf+dVA1srnOpL32xT1QvQD4Vi16tz+Tk7y5HMzdJ6+e99bJBBO+N3DzDoUwyPIOgA3xKx4kdZcWpiXMb3gs3hOkhZ548DhywXCxFMScKNzZ6VdNCkQn3OOzKhosXAeq7fuN7LbSzvhNPR9Kg3HX20/XAJyKycXVF0qLBG+kvRJGjpmIRvaTEd3bpaMs1lMfinKj1Tt5lA0pCu0SyMFJ/i+LBa6gdaEdYbQQEC1pz8eqPDu8bZxZx3roX3G3ZcBc3oYYQrs42vwvG5bsBnon1T6p4v+9iSzpVy8kEJ6u6B3jbAmmMeEzbbj52CS/7H5PPpop/jHuaFO5jMUlpfCYQyPvCNB/wmp+pPrJFy2LI8moR5DVZvvNlSkgwKHFUQgy9/xLZfzxJyjcDFSw6H1vTT9/FWkxNyqsyz/jOJcHyUhYlGetBIDN+Mmz7aj1og0pvwzixhNuc3pobCBVkvGRN+InlJBY8z/nwndvL+hVqW045ItmpSHjMCxdPhPAMNQRkjIKiUXXRKYAIV5nqW2wCkGch4Jwnw1YE4WIt1HW+Kjef2DaIBNOtTM/cw5O+pNpXuZaBYW1axs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(6486002)(82960400001)(26005)(38100700002)(6666004)(36756003)(478600001)(6512007)(31696002)(86362001)(54906003)(316002)(31686004)(6506007)(41300700001)(83380400001)(2616005)(4744005)(53546011)(186003)(8936002)(5660300002)(44832011)(8676002)(66556008)(66946007)(4326008)(2906002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0tvWEJwclluZ0NaOXNiK0RlRG5JK0Nvc2UzT09TRGM3QnBxV0xLYlczVDQz?=
 =?utf-8?B?WDloR3RPK2tNa25ZRWZWbkhQZWRlZXFkMStPZ3lnKytMeFVieTJhUDBHWTM4?=
 =?utf-8?B?V3JIQjhXeS85UFYvOVlLUmdTbU1WK0FTQkFxdHNOcXMya2dCcXAyQ05FZXNF?=
 =?utf-8?B?enVrZmk1elZMOGpONHBvVEFLMEZRWjJ3S2tSREpTemo2c3FvWXJjcmFhZHFt?=
 =?utf-8?B?TjVUdzBJdWh1MWZzWUcvbzNqSzRJaERQNllQSGhnZ0FsamtLSVkvT3ZXNkNn?=
 =?utf-8?B?ak0yUkw1UXBub1pXWGwxMGpXVFc2YUZ3SHgzOTY5TUxMdnBKU21SOXlQWUQr?=
 =?utf-8?B?UXJTTGExekFRUWNUclJHalRkRHFrNWVCb2xiTzNvd2sxUTJGT1J5SitCbE9J?=
 =?utf-8?B?ZVc5cTUzemZ3Z3N2Z1NLbFkyZXFnQ3dyOTBmTGVXNEdtWDJnUUo3NGI2YXdr?=
 =?utf-8?B?K05jMW00MXJ3SWVXbnlIRFZrRUc5M2NVZUVZQng4aG9wclhVZURSUFpMcVg2?=
 =?utf-8?B?UW5YOFBTcDBRTCtITSs3c3AzcDNEMURvMmRNQlJsSFE5SHNJV3RjZ2FaVUdK?=
 =?utf-8?B?eTRJOEtvZS9sTDRmU0xWRWhWNHNiN2RWWFR6ekJZRTRvU21McU9ra0NraWRt?=
 =?utf-8?B?aWVIWmJ0VCtKaXJ5cjAzMkUyUjJvN3ltMWZMaTlxZldrYXJCcEU3WHhZSUhq?=
 =?utf-8?B?ZFRUZC80dGUzMERIU3BUMURsY0VBaFZTQmFDWTVRbEhhZnBOTnRPRXZOWm5N?=
 =?utf-8?B?YTM1MHA0NnJkem10Z2FidFRISGpPSW8rM0w3OVFRZHMxbkhBWmczQTdZY3B6?=
 =?utf-8?B?SzhpSEFFd3JSNFlONWtocVBWY0tlWUR5VVJxdC9WUVRYK0NXeWovUXY5SC9D?=
 =?utf-8?B?dGtxOVdKN05RVlVxZ25xSnhhdUQ4YkZxRk8wbEJ4bStvUndXWDQyL0pOZ1hL?=
 =?utf-8?B?YVpLYStEOTVYaWNrS3luTWVoUzY0V2hzSUpwdVNmT3o3YUtkUng5ZjVJN2pL?=
 =?utf-8?B?VytmMEtmTERRMzhMc3dpRGtYUkJoc3NhNFE4OE1PMkovK05tSEo2Y0NwdGM0?=
 =?utf-8?B?Ui93SGRyMWc0VWh2L1diYlEwMUpFN1hNNW9WaXBQNCs5YVBWT0hsa0k2WW5p?=
 =?utf-8?B?eGpRd0ZDUmwyZUpJcVFwZ0lsV0RkS25wWXh5UVpqTEY0SitsV2JXM2h2c2Jo?=
 =?utf-8?B?SjhYRjgrQUZIdzhUYzlRZXJlNzJYakIrSTEzSHVDUmtBVmltMFljRjh2eFB0?=
 =?utf-8?B?VnlBR0Fvai93aUxUNW5HQmhteGorcllBbFNLdFNQRXdCQWtzQkc0UVJVVnRS?=
 =?utf-8?B?alZBc0VHeHhHMVloR0xQQXNJNC9ueFVmRjR2bzhVZDJwVWhsbU5qZzhMOEVw?=
 =?utf-8?B?am5iYURMQm4vUkVvbzR1ZE0xOTZaRlRUcFlWMTNiWUpkS1o3bjdHVU5abjkx?=
 =?utf-8?B?UHUweWhLMWFlaG9UL0xzL0hHWGVXTHc1MHRLYWJ5bGtSbXJOWkt3a05qZnhX?=
 =?utf-8?B?M3Q2TVc3UzZIMzB6Wm4xclRHVXU2c1pFdzU1OUVEM21pZEl3K0ExUDU2cnVj?=
 =?utf-8?B?WURhUjRPOTV6UDRyTFo3Szlrd3ZjcWllMnBZaXIyLzVqc2FJMWE2K242ajZj?=
 =?utf-8?B?ZmhWdXBwOEl3VVdDNUlmUjI3MXUzUE9GMkkvZ01tTzNBQjkxdW5YZ3pjVXZF?=
 =?utf-8?B?OXRTdk5WLzZQTkV2OTdRU1MycUhSN3VFTGRheWM3SjZxNTdSOGI2UFZDcTQr?=
 =?utf-8?B?anJyMFRXdXZ4V3I4ZGUxN1diL1Z6U0g5VkZIRVo1VHU3c0Z3RUdRTUpVcW04?=
 =?utf-8?B?d05Jc1YwNEkydWRVYm5zYXBJeEFwR2dYR0lnMTFsTEE1THJoRitKalZmRzMy?=
 =?utf-8?B?dXNsYkNSRFRvRkdxZmVGWllwcnZWR1hNTlkvbmNvMTdJb2tCVXQ0M1RpVnVa?=
 =?utf-8?B?eS9tbytCYzRkdklHYWVWS0UyMm9GcjNXb1F5bDRLRXhiR2tLZjdHWnhkQk1O?=
 =?utf-8?B?MlRkUm5rajc3UldFYzJxdWorUlpob3Q5OG9xOTlBY2xQeCs1Slh0U3FDWGNU?=
 =?utf-8?B?cjNTbXlRNm1WeDNRQUptb2wzRE5ILzA1MXk2MmNiQzFNUmdmRGlxYzVpdnl2?=
 =?utf-8?Q?f8bVU1WuR3zZyIISi0bhJa274?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95966f2d-4683-4806-f1b7-08db2051973c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 03:51:40.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0b6OS+pT4kokYUXAymmaLr5R28AanN3zULlWsG/cQGakEf60IIE98N32S0DFp25eeyQIsuteV4JhHFXjAWvcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/8/23 18:56, Lu Baolu wrote:
> The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
> and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
> on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
> driver.
> 
> At present, missing IOPF enabling/disabling doesn't cause any real issue,
> because the IOMMU driver places the IOPF enabling/disabling in the path
> of SVA feature handling. But this may change.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
