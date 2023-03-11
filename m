Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A926B5ED2
	for <lists+dmaengine@lfdr.de>; Sat, 11 Mar 2023 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCKRb0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Mar 2023 12:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCKRbZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Mar 2023 12:31:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9211EB8;
        Sat, 11 Mar 2023 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678555884; x=1710091884;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XO2GIIAQcn4eWj8JYjdzwn+OrkyTrST8NOMpS3F1+Vw=;
  b=aHaINMaBBF22mNquedhk+zwgSlXbWis8Ra3YnKqpbncfVIoYpQt71F2X
   AEqWX23LPixXut0p9AswggjdJPrG5kDMdk7oMnL8zn2EInquuItDE3T1s
   CHH7eloFWULGFwI8FJkILOhR+kJ1VsV/OywaT670vMA8ae1r7q1wZhUEd
   q2YMRdabAXiW97kfaYjGjt3UBj0teodvL9XiThfv8t3J/NQSIK1yBWnuI
   2t8UudRQ/qreelD6PNFGwwTXdBRagjrFYKYrkVUmHNpugZ3lddTt9R5kP
   RZ1ZmdcFJaVVxSUHisKWGkmLh6rLkbxEngfg9qJNDV+/ivD9XU5LyvU4A
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="364581006"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="364581006"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 09:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="655519486"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="655519486"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2023 09:31:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 09:31:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 11 Mar 2023 09:31:23 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 11 Mar 2023 09:31:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENbbK3p5QzDHs3CGXII5PPOOE12cXtgBxzIyeNn+jb2tAPcIoehV4bEjfOYoEXUeib2vdTdnpJ3armeVGL2qWI0QoGlYfpDV264Bi6Y0qbL7VzJuAF5gCgq+vwweTxM3iR94PtX1MmKfq9pT7IOR49dBMRUnupbA67W78ROPsgDMPquDKThJAvRyS52nAMHrfJaxRB4IkolVjoK08NmMjIxgWULa7nf4jqm0+66S1m9QhhSBqKBxh2E9oV6TKiY/wdbrAvEsE3peb6v6BxzZDwZ0Dp/6byoDtENeMLe/gPHn0GAPNkVCtiDmMIgF4pHDZDZH4IiXU7TQI7RBIirSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVP60rBY+Uw9+Ba1A4jdXVsq55I0Adthiyu+HkpxP0A=;
 b=MHe9QgDJ3aLWBLTf61uCjEFISK8X7gCC8p0+ndnOFV1edKNCnZYjPiwHU3yv4wh3csojcC6HpVt7j88kRmq5mwRwhnsKZRjPBw2AHkwxxibQ7PkKZpuASCryB52W/5V8cCE43cfsyHO+QplemQa9Yf0NBu1C/KpU1USb0uBkwMCNSkPr329mQonoKVEmk9nwoPn4GhoO9VUTLX4MJSTWItbxPNMl54cdskTZjTD7XTO/LYncocsyWeHcmF1Hxgiuztd1vpdFQ17HsRxe+1kaKNSJu69hEtOH8frGvhrGkOVVpz/T0APOkDCm7kfE6hvCdoKgwxcXctGRbPBb3uJB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 17:31:21 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.020; Sat, 11 Mar 2023
 17:31:20 +0000
Message-ID: <8d2b6b6d-5b1d-1784-8b95-865be650a6ea@intel.com>
Date:   Sat, 11 Mar 2023 09:31:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/16] iommu: define and export
 iommu_access_remote_vm()
Content-Language: en-US
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, <iommu@lists.linux.dev>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
 <20230306163138.587484-9-fenghua.yu@intel.com>
 <20230307084058.GA1330745@myrica>
 <156f9e28-e7d2-b443-1aa5-1f5447cb9bbd@intel.com>
In-Reply-To: <156f9e28-e7d2-b443-1aa5-1f5447cb9bbd@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH8PR11MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: e48d26d2-d753-4318-6a1e-08db22566db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1uCWytEiVZPbzrYis28/HzHohkN0yq+kXgiqTAx2m3KR1jCTIAXKBXY8TAB1AOhH4tox62ug1JKBKKDXJ9LRmIGfmrV30z9BpjfqYa54/IGp4NlCAQuCz+evXhAQ65mTbOvyJnNb5zseqC64TD7Ft6l+H8MTVY5Sk7QBtk/iQFwcgi1Yzp/WPnLIJaZ5cDKv97xVy8pA2NmWJpGnRQt0hGHoCJX/uTkmNvPNqF/xx0zW5iscgqMfh6qU3XNWCSvFqarkDjeiuqpEQU1OwFCrAiULTj5s6CUJ2m3dvi/1R0DO1z+vAFZFjoCNX7ugALNjE2rIO9LlKGN5Zn/QiE8CjZa7aHrLTYnY1Fc4aq4tLsTxyujHObVNRWh1vIrjS8oV79i/3OiA3Og6QVsYUzYPdqC9K/W0579z12vKfwC5UDPFyFEvVTgECoxWgadwQhutyq2lfhgU9h4OFWKEmnKqZU6uSrfUuzsG+hBNDcT7yJ/X98mXrnkp/08adCP0PGHO10P+GEpDd8HCjn0nNPS33CgBOp9cCKh5NTig97rLn0d28nhXu152awdcl68CqwMR1S1kZihJ4Le6Hrnz0WLPG/IUjsgdKyxnpWlzwk7LvcWKwKuSy5EPzexCF3/2kqfT2HBLlHOvbFVzqTyEfal6dV0bktFvGXwgZUmuyRiCU/GaWx//SICfWY3vUWvLxC5PPOPXVZydf/GwKUiQIfMJCnbEXTQAHAIYcOMsn5lf/XHGjOLPPyLA12VjPox+2Zth6QYCcgOvUiY5dec0xDrOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199018)(2906002)(82960400001)(31686004)(83380400001)(44832011)(36756003)(7416002)(5660300002)(8676002)(8936002)(66556008)(66476007)(66946007)(41300700001)(316002)(4326008)(86362001)(38100700002)(31696002)(110136005)(186003)(54906003)(478600001)(6666004)(2616005)(53546011)(26005)(6506007)(6512007)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVUdmVLMTNaNlV1L0dKWm8xVkVjbGtENmVSV3pkVUNHQUxYZ1BtbFI1YVlY?=
 =?utf-8?B?Z09ld3g5bnA4K3NTaUFvLy8vaVNCaVBWOUZTNzlGcFFFYmJuYm40Kyt4dUt3?=
 =?utf-8?B?YVZoQW1lL2xPUGV5Vjh4aGRuTUtsV0c2SmdCTUxCaktIWU5leEd0ckxtbU4z?=
 =?utf-8?B?WFYyQjkzeXNKZW40dWRNWUt3eVlpRWRTSlBwMmVBSUp1MTBCQ1VPT2ZEdHFN?=
 =?utf-8?B?NWFmck9lUG0vaXVpalFFRVRVcTgxRVRvQmFBbHM4SFpSOUFOZ0k0OUR1dWxF?=
 =?utf-8?B?SXdqZFJEZFdUQVR2QjFnQlRYajBrcHIyekdJY0dFV25KNW1lcThVbFlvNXAw?=
 =?utf-8?B?cWhqTGRoR0FVbTJiNTZaMExqYThtWlJYUmhrZ2NieFg4SDZXTnFKdnBZckJv?=
 =?utf-8?B?RkZwWnRUbC8yUVFZL0VzbmxnNzhOSmRjSzluYUdZcXBSR2llYTh2NkpYUk8w?=
 =?utf-8?B?aHRQNzBMUGxhR2xVa25RcFZHMzR4SDRoUWpsbjBLc2JXOVhkZ0ZPNzk0UXdv?=
 =?utf-8?B?ajVBSXFoSnFLQ0V4UThzTzUza3ExajBtUzM4empiVzA1ZXdwU3BXQ2s0cFBV?=
 =?utf-8?B?MFdiUHRUTlZMbm9WTzM2VkZOTG1TQWVRUVVFTkVDM2hXKzZtcmlOYjI2b1lP?=
 =?utf-8?B?MzZQY1ZweUdiSkdqSVRiR05Kd3FyaHFlZ1lsSks4NjdIMWJkbDUrN0gwVy9h?=
 =?utf-8?B?ZVNnc1BDbDhvaEVYNFNyQ2Y5ejFRM2llWFBGUFFXb3drVU5tQzkvNlc1anM3?=
 =?utf-8?B?aGVoeEhpeFJVL2V0WVh4NTh5c24yVkJQVFNydy9OV3k3K0ZsR2o2Y1g0eFVy?=
 =?utf-8?B?OTZ1OUIxM2NiZ051cTZFRXJNcnZqN3pxclp6Uk9WV2pSZ3htczRBaVdQS085?=
 =?utf-8?B?aVovbERJN1U4QlVRcFlDMmhTVGl1MEx3TE9uK2M5OVJFL1FvMVdLTFNDWWxT?=
 =?utf-8?B?bmZZamtoZmpzVDJaTFJuY0l3ZFV2SU16K2tLWDFCY1JJbW1JYnIvejNIYjcy?=
 =?utf-8?B?bzV6TUwxVzc4Ny9laXhIdlBXK3NHR2xXcmR2dkwxc3JGL3ozY0ZlVjlJNTlz?=
 =?utf-8?B?bmJ6N05tQmM0SFAxK2M2bFUrejZ3bUk4RStrN3FoVU43OFdWRk51TndZckNR?=
 =?utf-8?B?NDM5UlFmNHhQZ0VCSXdWQmtpSVRlQ2puSWUvVkx4RXdMcU1BSnFPR0hLOTFF?=
 =?utf-8?B?dnBDL1ZqSklpdkc0cnk1MkUvQjNvU3Y5bHFRdERFUDBMZ3RMSmtiVXRrMGR5?=
 =?utf-8?B?NUpFVzZCd0ltaU1sQVRhRlAra0hVVjA3S1crU1crUWhCUEZTRHVsaDNJUjgr?=
 =?utf-8?B?MjdSdGdJWDQzWWJ4WU1ReHZuRVRxbkdaM2oyMHVaazlzNTNEam9QOXIrWW5U?=
 =?utf-8?B?WTFycytTUktHYk4zV1h6dVpZa24vWXJVVUc1aUM3TGEyMWtabUtSYTVDR0dl?=
 =?utf-8?B?QkFPeFpIWXF1TXcvR2ZWZlpkd2UwMkllM1VPOWZtVWN3bmRnRmZJTVB6MUlw?=
 =?utf-8?B?OFJ3STQzZk5ocmM0T0pKSit2bCt4UFhDRHMwRFptQjkyc2xmdkkrdExxRklw?=
 =?utf-8?B?YkFtQ1dPKzVtN3BhdFVwWDAyRVRCWGpRcEgxU1RlbE5LUzVBS0R2RStsdjVv?=
 =?utf-8?B?bGRiWElKbXViSFRGUUtET0s1dVNqVUdjUjk1YWY5N0JqMmY1Q2ZNbXV6WFpG?=
 =?utf-8?B?a3ZER0dJcHAzQ244cXR1OU9xa0U0K0djckIrU09hbC8zMnI3TUZjWUpkK0cy?=
 =?utf-8?B?Zkxidyt1OGtuY2tKcFRxcDY2US9NSWduZGJUaDRUK05FaU1oazVqUVlpT3Uz?=
 =?utf-8?B?U05xcjcyNTlSWHJqS0piYnhRendEM2xLdEo4dkduNStWeDdIN3pZczltdml2?=
 =?utf-8?B?a0dMRWJaUzl1UWpmMEdiRWs0bVI2eDZzQmRtMEJFUTd0SVZOdVZ3SmFKdUJT?=
 =?utf-8?B?VHJDYXJwS2NaZnRJVk9wYktnWFpxZW5nOVdCdXZ4UG4vRTZFWFZYb0J0RHg5?=
 =?utf-8?B?cmovNHVmcUV2dnFSaU9iQ2cwVDUzNzFGSGE2SnpMMUhIaXRnZ0RWUnladEVR?=
 =?utf-8?B?WEFqYm96UnZObVdjSVViaWlYNEtXRTVRN2NTdXh4WFFacFdETXhVdmF2aitY?=
 =?utf-8?Q?OGyWMkZgH3J/u0XTfIQFq7jIB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e48d26d2-d753-4318-6a1e-08db22566db8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 17:31:20.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYxFuLVLJr73Ryi2bEn5udrJRYuuyLxnCZCnx4ijbMdiYR+UiNAQp5o1c/f9JRupiX0OsFSLJ0nAR9YHQsPqnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jean and Jacob,

On 3/7/23 08:33, Fenghua Yu wrote:
> Hi, Jean,
> 
> On 3/7/23 00:40, Jean-Philippe Brucker wrote:
>> Hi Fenghua,
>>
>> On Mon, Mar 06, 2023 at 08:31:30AM -0800, Fenghua Yu wrote:
>>> Define and export iommu_access_remote_vm() to allow IOMMU related
>>> drivers to access user address space by PASID.
>>>
>>> The IDXD driver would like to use it to write the user's completion
>>> record that the hardware device is not able to write to due to user
>>> page fault.
>>>
>>> Without the API, it's complex for IDXD driver to copy completion record
>>> to a process' fault address for two reasons:
>>> 1. access_remote_vm() is not exported and shouldn't be exported for
>>>     drivers because drivers may easily cause mm reference issue.
>>> 2. user frees fault address pages to trigger fault by IDXD device.
>>>
>>> The driver has to call iommu_sva_find(), kthread_use_mm(), re-implement
>>> majority of access_remote_vm() etc to access remote vm.
>>>
>>> This IOMMU specific API hides these details and provides a clean 
>>> interface
>>> for idxd driver and potentially other IOMMU related drivers.
>>>
>>> Suggested-by: Alistair Popple <apopple@nvidia.com>
>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
>>> Cc: Christoph Hellwig <hch@infradead.org>
>>> Cc: iommu@lists.linux.dev
>>> ---
>>> v2:
>>> - Define and export iommu_access_remote_vm() for IDXD driver to write
>>>    completion record to user address space. This change removes
>>>    patch 8 and 9 in v1 (Alistair Popple)
>>>
>>>   drivers/iommu/iommu-sva.c | 35 +++++++++++++++++++++++++++++++++++
>>>   include/linux/iommu.h     |  9 +++++++++
>>>   2 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>> index 24bf9b2b58aa..1d7a0aee58f7 100644
>>> --- a/drivers/iommu/iommu-sva.c
>>> +++ b/drivers/iommu/iommu-sva.c
>>> @@ -71,6 +71,41 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>>   }
>>>   EXPORT_SYMBOL_GPL(iommu_sva_find);
>>> +/**
>>> + * iommu_access_remote_vm - access another process' address space by 
>>> PASID
>>> + * @pasid:    Process Address Space ID assigned to the mm
>>> + * @addr:    start address to access
>>> + * @buf:    source or destination buffer
>>> + * @len:    number of bytes to transfer
>>> + * @gup_flags:    flags modifying lookup behaviour
>>> + *
>>> + * Another process' address space is found by PASID. A reference on @mm
>>> + * is taken and released inside the function.
>>> + *
>>> + * Return: number of bytes copied from source to destination.
>>> + */
>>> +int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr, void 
>>> *buf,
>>> +               int len, unsigned int gup_flags)
>>> +{
>>> +    struct mm_struct *mm;
>>> +    int copied;
>>> +
>>> +    mm = iommu_sva_find(pasid);
>>
>> The ability to find a mm by PASID is being removed, see
>> https://lore.kernel.org/linux-iommu/20230301235646.2692846-4-jacob.jun.pan@linux.intel.com/ 
>>
>>
> 
> Thank you very much for pointing out this.
> 
> I talked to Jacob just now. He will keep iommu_sva_find() function
> in his next version because this patch is still using the function. He 
> agrees that I can still call iommu_sva_find() in this patch.

Further comment from Jason confirms that iommu_sva_find() will be 
removed (https://lore.kernel.org/lkml/ZAjSsm4%2FPDRqViwa@nvidia.com/).

So cannot call iommu_sva_find() any more. Will maintain mm and find mm 
from PASID inside IDXD driver. And will implement accessing the remote 
mm inside IDXD driver although the implementation will have duplicate 
code as access_remote_vm().

Next version will only change IDXD driver code. There won't be IOMMU 
code change.

Thanks.

-Fenghua
