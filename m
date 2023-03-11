Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3036B5E97
	for <lists+dmaengine@lfdr.de>; Sat, 11 Mar 2023 18:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCKRSZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Mar 2023 12:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCKRSU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Mar 2023 12:18:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7321F5F5;
        Sat, 11 Mar 2023 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678555099; x=1710091099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Srn0o6RxQSPrKW9GqRFNSjPrSBgqS4d2QaHzN6q4YTw=;
  b=Y/u2FWaUc3Qt/pAKr1reW2wH0LwTCtEk6//nj6gdrFwxrcGAINsx4V6o
   BLympUoFU/YH+AGSsElaXgbRS10C0CMglZrgrYqQ7rhK5z8RWcY4iiuWk
   2f2GLGHll7vlgkIc0If1tVZ2zpeP/V4mXrE8fg7NIN5l5XcHfBS/P/cZJ
   BaxmZMMc+q2wLwhChZAAUhVH7sBm7+uzXNhlHhB2b5Vl09EVbt1n9/d0j
   4f8N5X4bBm3PDwKJ8uh4Znr73hqv7eZsiY595rJLj8nhGPLjp2dCdWt6/
   xb9086CHv58vuQPLv6eQ+iv2BOdtIhqYtA3xs9fYYbS4zMH+CiwvPEl0n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="336944573"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="336944573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 09:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="708371523"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="708371523"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2023 09:18:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 09:18:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 09:18:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 11 Mar 2023 09:18:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 11 Mar 2023 09:18:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgsvpNHtUuC6lmyHp8WkDVXgYVFXZxMtF7eM3HcuntdKMivJytH1hjv4Emmi6r72axSOGAF8/H/GZovBMxPC1E42yUf7jHfIdCnJ8T+YJG7Grml2aLUIU/Z04NC1LOY1Tr9yVPnCfJZ2cK7qqMYPcd6cZt1EurtcS0an+fUAeEudnr9PLkQ7gyvadbqm9l7ls2wzrQK7HrmkAbH2l3EDqhkOTNITCZPEuB01eUtvwseOGJF8vpsdzv6tCSOz0zcrQeFtOwhMPbltkqwQ+DGHn/FnaXOOOseYo6BUcOerArQbpO/tahC/5F8AvC7shO2G91iKmj/WWFiALtNLhNLJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JByeKvl/06lyCguCHeiMGuHNl0zaAO9PyEMGn/Vk58I=;
 b=nGbqvQYWCQrFWqaZxtA3XI4+CP7lqROM6yH1sRb+wk4XNg5Sr+mnijRqBeS6Smrd8tRNJWAkGUv07iqxCrsvTjzwqDIyHCk0Y2+RoHSVwYhBZyUSMvJM2OonRbE03nBcrzq1uc3N68Pdm4nVDGLSII1xZIor3VxlMjmMOFm9r+/Vb5XKBNzGdzmHukbHKLtE2/340cpkmkVrrtXlW3mWlfYHkFm40lgPRi6vRBJSkGtv9JbZBxWS435qTfPU/ZxH/6TvNkc8iNkf0pulf9tjGHoYa4AyO900X0MVpHR6FZ/kT846xnm4OTqtsTnVq1XK6SsvxzQCYVs+f9S2TqUd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Sat, 11 Mar
 2023 17:18:11 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.020; Sat, 11 Mar 2023
 17:18:11 +0000
Message-ID: <3050c4a3-8ced-2469-4546-4af9620d3363@intel.com>
Date:   Sat, 11 Mar 2023 09:18:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <corbet@lwn.net>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
 <20230303093235.GB361458@myrica>
 <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
 <ZAHzAa0mnilf0N9K@nvidia.com> <20230307143209.2873d9e2@jacob-builder>
 <ZAjSsm4/PDRqViwa@nvidia.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <ZAjSsm4/PDRqViwa@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 01632ce4-a88f-42ae-8f4b-08db225496d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hW8xfm6Kma8GSfxJb6RLyCIk5N9eMTcvflgIgvHC1GNBZpuCWqhwR4epTDTKJGxRSPbc0hhMcRKo9U7w7+Fek6EeD1NgA7/h/VxuaGK2Vc2CP5SXt/GKVF5D5O3723sVGeiHoY4dTQg8E6RaX1EX77iYZeyNPK2Ye8DCR777dBO1+6OoeHOA6s5DWCqCbMuNCBC49cyVi8XSChrPUdKoIM6On3EUhHtUOmo8tK4acJNrmcaoj5nn4ubrgghUgGzewhzM+VsuoSxoPUQCwyjVYW1K2xJcWbDC40fnryC/m2475gorUrciyuPsK64IA9BdeQq6JU1os27EGEs3hmIAnavciT9WhrgafFYFTXGxwUcue1vNemmmsPB7vOnQJ+4T4xNAN2zn6ga/tYZwUHhCELvCyTgpCadEh8HkDg5KEKiwPf/FFeQfkAxHJ0xJhM9X+0jRHY0RQ0JVxCZFNS+fLmHFePtZZi7y0LBs2DL3LkkmYCgtQvSpAWa/GacwgGq0/pksTxi40QI/oiIUWKJzHy6FVLwr3EScMYo+RzOQQUZsu3gy9jdnBL4+w0HGw9m7G3aiXZvDAGcAPtR9A1XPusLy79aVyrFniUaVipp1FsBKvic65SuMecqaQHJABfKJx/RzFpKDae4IydBI4Gfbsqz1lyHBJlrRSYypfmKJXL06sUqL09hGiH+7FRWZRZJMq5518i4t+5pS2qdgq4TPX/9oJO2uHee3RYmXB+voMN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(31686004)(86362001)(4326008)(5660300002)(41300700001)(8936002)(66556008)(66476007)(8676002)(66946007)(44832011)(2906002)(7416002)(38100700002)(31696002)(36756003)(82960400001)(6666004)(6512007)(6506007)(26005)(6486002)(966005)(478600001)(54906003)(316002)(110136005)(83380400001)(2616005)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtvd0VTOUdMd3dEK0ZJMlZxWlFEVzdFdlhCb2VOL3VNQUc5RWgxK0Qxd3ZY?=
 =?utf-8?B?Rzh0V0dqbStmYzNMOXFBZFhNRENPcE9GRGRTSndjUW96K1dlUjl2ZjF1TlVk?=
 =?utf-8?B?eU9EaDhvc0JBVkoyNmZycGhwYlBZcEI1MjBqa0xUOG1vODJnVzllb1Nwcy9J?=
 =?utf-8?B?WTNXSWJGVW5id2s1d0Jzd01JVnFZZW9TQk9DaUJvS3lSZUk5cXN3blk5Ulhs?=
 =?utf-8?B?ejNBa3F3dVNFbko1N3pQOFlhclRNd3hkc1AxSTF6TW96UkNlbmZzeFdGQ0Fw?=
 =?utf-8?B?R2IrMkJ2SVFPdHo2V2tkblQ5K3RkQVZDWlVlNUpONFBkd1NFU2c2MG9raHlR?=
 =?utf-8?B?QlZDaVBNU0VXTllOYWQyRnhaVVhXdmdOcjlQdWtxdjdpN0pra2tYenR4QXJi?=
 =?utf-8?B?RTI4UDBhS2NaODRKdHR5czBwY2Y3bjBTbGxRa3J5MGV3OThSb1NoY1Y4NGJi?=
 =?utf-8?B?anppWC9hekRsMzFaY3dlNFV1WGh0Sm9PVTkvd0JSREtsRzZuTkxVNXBtazdm?=
 =?utf-8?B?R2RRcWxqRTRIM0c4eHFRU1lXUm44NXRFakl3dGJOZFpCd0pIZVZnNWJ1a1hs?=
 =?utf-8?B?MU53Y3J5VERaTkJNN2pqTVF6ODhPVks0OEZtei9JNGxjejBoUG5sdXRJUCs0?=
 =?utf-8?B?N0R1WUNJbExzZTFFWkYzNXp0NGVZUS9qNy9wUEtCbW5wWG1ONFVBUVJoRXFZ?=
 =?utf-8?B?S1NVc3ZidWl2b1pCbmxuS0MrVUNvTXd3bDJPckdlR052V2JraEsybUlCUDZu?=
 =?utf-8?B?RWhIRU5ManJnZXlPeWJrYXJweDByOGt0RlRvdWt1dWp2Q3BNaE1rNnE4SUdy?=
 =?utf-8?B?ZGhxMDArVVhnUmRRUmMyenhOOFFKTWlzM1ZrUHZyVE1KZ0lLZkxxWHBZK2Fh?=
 =?utf-8?B?RGFqcmV0ZFloMnUrc3lhOGVRYTdFSm80QkExbU5VU1FxVGxBbjBLRlRnWk5C?=
 =?utf-8?B?VjBYMW9TYmJGZnQ4VWhEa0FTYjlGZW00aloxMncvZjQvU3c2U2tzQWM5Tmdq?=
 =?utf-8?B?NXFvZERnRXhlaDB0VThQWm9rVWFEL0hVNEJxWDI1NUV0YmR5ODArbno2UEQ2?=
 =?utf-8?B?Q0ZtOGlmMDdrK3loZHNFVzFUYnBSaGc0V0JKRHV3Q05Uaks3L2tSNFRkK0JL?=
 =?utf-8?B?d003bXdvYkJKT2VnSlZDUG9ySGw5MzZ1c3dmVmFnRnpXZHFpYkJPYWpqZlhv?=
 =?utf-8?B?eHdKYjdrTG8yeWpFYUt6Zy94dUpZajNDRnF0TkJOYmw5ekwxQU5Rc1VNaklI?=
 =?utf-8?B?TjFFdTVRdGJEcER0Ukk0Rm8vaHQyaWF6SE1iUDBlOXhWWXA3Q2l4TmwwQitn?=
 =?utf-8?B?dng3RSt0QzJncTh5eEJNaW1YcEJRUFNldyt3MTJHWjM4MHBPajE2cTJoUUtJ?=
 =?utf-8?B?UzRMNGZWMkFvazFWRWpxZ3BzeDU0YVFjRFkyUTgvbkE4VGgrZ3hDYTJXSlpj?=
 =?utf-8?B?R09FanNkeGNDUjAvSmZrM3kxSW8zQ014bGxtdExoSURnNDE1NjEra1pFaU1L?=
 =?utf-8?B?UlJWOVRFblZ0Y2h3dUUzamN3M1U1ajluVXNlWVNkNTl6bDROK1ptUDJoMXZY?=
 =?utf-8?B?T25DbFRIb3ZablVPaytMM1NoQUVHdkh5SkVHNzVLZDNodFNVUVNTWUdnRXZl?=
 =?utf-8?B?dXZ1d1ZmdXIvLy9MdzNXa1hPV005VmxNU2dmSTRyZnpXQXlsNHJVMzN0aVhB?=
 =?utf-8?B?cFhaNnZrR0llaVZEWmZQVDQwV2lIaGp6cHZjTk11Mm9sa0E5RDl5WmtMbVRp?=
 =?utf-8?B?MkQ3blV6N1dRcGlScFE3ZEJiTFowbG5zbmlVQ0FGaENVQmE2ckorYUFZL3Yx?=
 =?utf-8?B?ZXZJeVpKWkJXMnczVU9mK1BqZGRYUk1HUmozbkN4TzNYdGZwZkloamdrVkww?=
 =?utf-8?B?Q3Q2bGhBUlVTL0Q5NVNCVXl6L1FUc1poVmdaMTZSZzFjS1JJNXB5VzhvMlo3?=
 =?utf-8?B?ZlI3Qi9KT2RkZHhTUWo3SVlyQXlTWmtrS1FtWmszUFlqdWtlaUlCZ2xadDh6?=
 =?utf-8?B?NitFVkpMb1BmUUlqQmhxL0JtUmpxcklMbGNEbkpMMnA5RXA2cElsRXZ5NjMz?=
 =?utf-8?B?VERtMG5RSkFldXQ3bms4eUdTenRFdUtIY1g2aXd4Rk1lWCtQWVppNEtLeE94?=
 =?utf-8?Q?tlMEtpoUY5aRCVU0UO/f5q/ln?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01632ce4-a88f-42ae-8f4b-08db225496d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 17:18:11.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0blXboZbbutO5AKQzegeD3GdnylK2Pz+l+ujgD3mRnGHO9iUYUKDSjLMQNihaUdANyJSBHrkJPMloslJaIQFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jason and Jacob,

On 3/8/23 10:23, Jason Gunthorpe wrote:
> On Tue, Mar 07, 2023 at 02:32:09PM -0800, Jacob Pan wrote:
>> Hi Jason,
>>
>> On Fri, 3 Mar 2023 09:15:45 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>> On Fri, Mar 03, 2023 at 05:57:41PM +0800, Baolu Lu wrote:
>>>> On 2023/3/3 17:32, Jean-Philippe Brucker wrote:
>>>>>> I suppose the common thing is reserving some kind of special
>>>>>> PASIDs.
>>>>> Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could
>>>>> just communicate min_pasid from the IOMMU driver the same way we do
>>>>> max_pasid.
>>>>>
>>>>> Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
>>>>> driver calls to reserve PASID0/RID_PASID.
>>>>
>>>> Yes. We probably will use a non-zero RID_PASID in the future. An
>>>> interface to reserve (or allocate) a PASID from iommu_global_pasid_ida
>>>> should work then.
>>>
>>> Just allowing the driver to store XA_ZERO_ENTRY would be fine
>>>
>> It looks like there are incoming users of iommu_sva_find()
>> https://lore.kernel.org/lkml/20230306163138.587484-1-fenghua.yu@intel.com/T/#m1fc97725a0e56ea269c8bdabacee447070d51846
>> Should we keep the xa here instead of the global ida?
> 
> I'm not sure this should be in the iommu core, it is really gross.
> 
> I would expect IDXD to keep track of the PASID's and mms it is using
> and do this kind of stuff itself.
> 
> And why is this using access_remote_vm anyhow? If you know you are in
> a kthread then kthread_use_mm() is probably better anyhow.
> 
> In any event we don't need a iommu_sva_find() function to wrapper
> xa_load for another function inside the same .c file.

Ok. I will maintain mm and find mm from PASID inside IDXD driver. And 
will implement accessing the remote mm inside IDXD driver although the 
implementation will have duplicate code as access_remote_vm().

Thanks.

-Fenghua
