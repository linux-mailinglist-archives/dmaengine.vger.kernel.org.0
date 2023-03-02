Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AF6A83D9
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 14:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCBNxD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 08:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBNxC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 08:53:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF3B46E;
        Thu,  2 Mar 2023 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677765181; x=1709301181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M3gchpX0fTIcVWkz3o8uclKZhhJdMo25rmEY1JBfSMY=;
  b=bJdgifsLwmYuOfplld1PJq14Hc93F3SaCR6mv/ldlLojQrPUb1JUQ7dd
   QCTfjDjorclReGjZgvsDEZ22FUXBGsBWDyxyh3w8VCLy2afa/I0kcDB02
   Vxi0gID3nSHc+tCQ0W0dsLXiukpWulKn0WugNuVpWXogewqQmqNp9zAj1
   Veoe+W/iTk1OryL0FzV75zhM9HrS1DVi5wWOH81rvy7W6B0s/PLtTBYYH
   IeZt916KW7MM45APSS4x7gIOhFNrCp4zCOMFXbyACfhjOQlEpuBXKXywU
   12qOC57iRkrJrss5TrEDP7sE6LcrM968E/y8hDDLstwp+vzkATcMRIr8p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332205092"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332205092"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674967390"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="674967390"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2023 05:53:00 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 05:52:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 05:52:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 05:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/j5fTz0T12p3Bn+I3x+UEGUq9W5gY+YqS4hQuzvAmb+pHonC8so75GT9BexVAJpW/4Yum/Nf6oIkDOafr2lILFGpZMcG00iAVSYK6ftYnHTMh0soLvq1yUJAJYY84/uaYTb/iKBitn5TThVA+lbie2ELM/nmgSxw1XF/0ib+bUpoHBb5240Rizdgb6ldVRyvV1cA8NV2vzWBTG5BAfJCGTqXCcq/tpnc2VphNvP+0uB6Z3oOdKMtAsgV4tn1b5aJtvW64xM1FCEsjv62Reba5MWM2t8MR1csutWgpEVaK1PL0Xgxh5I83i+k5fCrR1gYqUjj17jBgAxya8YxWH84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNL/SxPAY2qhMrvCHQLhzO/sgPKzLLUJXKMOlP1rR4c=;
 b=EJRyf2ExsXpV5dNCFRsfSDQAFLhORTtoQ8orCHWOBSK2MQhPgmGEm8jKu7IuTzJOrSoaE4dR1kHro5Fafr2qu+kucXrZFoxXeNt9lspeFnHtY1ND8UUciEM9ULS8sNuE5kfGhbnQmvtxnJsc08JlhlcGsraJjfItjGRaQHA0q4bKfLdEeCyVKKUL0axYNxrQIztXLLRB5TW6NGa95rZAetW0k3HIEz6UA7eAKdKkYaSn6LmyGonbkmzAZgsnCBrh0Xwh1rskrkeLo1w3/xrbUuxHl4RLuZJ/PdIc34QosF/o5NIAru4/PBoP+moDbvZUn92Qk9IpM12uptSxWdmgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 13:52:57 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d1f4:4d52:6667:5479]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d1f4:4d52:6667:5479%4]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 13:52:57 +0000
Message-ID: <43e9711f-042e-eaf9-e091-07db78cad943@intel.com>
Date:   Thu, 2 Mar 2023 21:52:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "X86 Kernel" <x86@kernel.org>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <corbet@lwn.net>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c5681a-7dc4-49b9-6351-08db1b256d5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTD0gaihNxtOG30XKKAaVmxErngDrcqThgEvdXyomq/ALSNecZPWdMq9u/X4q1hspsVkXjS1U7IT82YiPpdLKJsiFFGA3IwvEq1sB78EOV4keYhegX0XnjaXoDfsoC5mGSK40encCbUC9/LnQBGcghaIebzyCLvR7aaVtXiGejsH8WkAjkgslQxq+Ty9gc/NIl/pvci2CkKRj5vNE9NzThV1cED1OPIy4HPhIRr9OwPhOnCH/2ai3seU0MMxQqq2PNCObVjDGmOD7NfRKGH5gBIf8bDjwlnMiV75aZjDUgIewEA2xZD4hr89xnge0BseJbyv6U0cV6HleP3s80Hccyc+B0+T4+a4UyW44HHaAbqs8QDwQvkFKzjG+hmzrkzVnKn4YDTzh0PqfjZi8Vnq4yqSLyEQV7x2Gy9bqFRT1XX9UEUsFb9SPug0uFeEpYb/CFwtknkxfoYFx31ZSFNo16z7bfesPsgA31JsDRGeecfBQGFDxo3rsHaza60vm5N3TJv3SfSasD2FoBGlt8uEbtDK57Q3VnqTScZo4YoJEr7hI3LXSqjmPw1s3IqAWurQskK3xpmbe1F+lN3K6EpNreQPiz9mhmmWZUszaq33Lr4QWZQjFg9UCnZQzeZTHCpwKi20eructW+VyMfyWHBsdHPGn0neWgd/BzZWymAfDoAK5I0QAPpFqbD9CmFWMJfVuNyv2s2+TznNgbphxeBiBmMRG1B3xxtTJ0f1O9jYSilklo9hnWdnoHp2xNsakW+i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199018)(31686004)(36756003)(2616005)(41300700001)(8936002)(54906003)(6512007)(8676002)(66556008)(4326008)(66476007)(66946007)(31696002)(86362001)(2906002)(7416002)(44832011)(83380400001)(186003)(6506007)(26005)(53546011)(316002)(5660300002)(6666004)(6486002)(110136005)(478600001)(921005)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHh0ZmxjV0wxaHJqNGFFMFVWNjZUdEVQMEV0NHo1QWVYR0lEODM5bmR0T1Jz?=
 =?utf-8?B?T1RlNFZUSmFIVVFyUU1iTjdUMjdoWCtjK3BHa05rdDNYSzBWdlBQQVF3MUM4?=
 =?utf-8?B?bmVySXM0eWp6dEFSRERwYkUyMENJdUhOUDFkTXJMSEtINWhTK3RJSVJpRm9v?=
 =?utf-8?B?Y2o0a3N0eW16MTF2aVg3VUh5UGlOSXhzVVR1MWNzZzVUc0Z2Qzc5OVFWTnBB?=
 =?utf-8?B?bEhXMFBTeFphZG9BbGtSZmNTM0E1bE4vQVFQZGVCckpBZFBVR1NFSkkzRlJ4?=
 =?utf-8?B?UHU0MWtTdm9iUEJIWjg2b3YzZThBMXJ6cVdENXRjeldPS0tBeFN6ampETEZk?=
 =?utf-8?B?dm9pcFBqOVUzRFZMVGltbGN1VWNBUElhakJQRWZwRWtjNUFOaHRMMTlwMzdT?=
 =?utf-8?B?U1RLbG1pN24zTFp3WlpyUE5Fb3M4UER4OTUxSjdIWFZXRGYxRVd2S3F6K0Vw?=
 =?utf-8?B?U3pVS1ZGTTBVd2RnT0dFU3Zpb2NrTTJ2MzVNdk9xTmdCNmw4K3Fxc2c1VTYx?=
 =?utf-8?B?R01EeUpOL045VVdyODFuTUg4NEx3NHdqZjQwdjRnaFB3WEticFZQUXhiY0dj?=
 =?utf-8?B?S0gwaGZWMGhTR0dwdFhFUm1vQWdxdjVnZ0E0Z0ZaaU52c3Q3WmVZUllibEgz?=
 =?utf-8?B?VU5Xbm8zWEJ1ak9zL1JRTGtLb2RyanlmYStMRWxReHhMYk5tZ2dJK1dnUkUx?=
 =?utf-8?B?aDhDZXcrY1JndE5hQk9EVkZBM3N0VklEdXAyMnlSSmE3b2VJRThQekNoWTdV?=
 =?utf-8?B?Q3NKeHY2UDJtd01naVEzSkIzdXlJdDNNVTcrc00yRHlEejVaL3huMzdJWlNt?=
 =?utf-8?B?a2ZrUC9hSmNDTHpwSUdBOHkzRkxCd1ZuWXNjVWx3SzJ0aGx0cVVRUDYyUzRp?=
 =?utf-8?B?SE01WlZPNWFwRXRSQlQrenlOc0U2VFg5S3pvd2lhS1Bvb2lYZU81REJESVlH?=
 =?utf-8?B?RWhldXQ3YVBUdjRQdHFiREY2MEdXeFlEM1lUQnJnWWdhY2dGVVpCazZVaHJz?=
 =?utf-8?B?eFZ0ZGkyWDMwcmJXRnBxcVdwZVRRVmlvRjhDTURGWVVnRitBQmxLbVQrZld3?=
 =?utf-8?B?UmI5YVRPM3FrR1hpay9lMUZQaGVxMHljUmMwb2VrWFRLUVJGQTVmQklBeFk5?=
 =?utf-8?B?TElDbWdFYjFFbGhzZmFjZ2RJSkpmZDdmUmp1RTVPS1RDYklWazhiVTErN1Fz?=
 =?utf-8?B?OGJnaFFMS1IrTUZzWmI3b01FYzZKQ2w1ZERuT2s5bEN6ZnFhYjlVS2tndHVl?=
 =?utf-8?B?SDkydWl0ekxFaXUyN1QxVWo5VDEvYUszQm16OUNsSktkb0YzbUVNUEdaWHVm?=
 =?utf-8?B?bkVHUWNGeHMrU05sem1Kb2x5UjZqOE9iUlNlNDM2bEFYclVaWlA3STlpbEpn?=
 =?utf-8?B?SGdNenhWd1Rhci9pL2dGNk10WUlKa2ZVR0dyUDRmVUpPQ3FNQUxqWStoN3Nx?=
 =?utf-8?B?ZUFHVUdHSG4rYWRNUVhnN29XOCtwMGdERW5UbEFENGNGeFNkeXQrbGxQQWp1?=
 =?utf-8?B?bTBweTJlbmFNZ0VZbVg5ZlRKSVZjM2dLKzQzeWxpcHlBanhMUjZOWkMzV3ZV?=
 =?utf-8?B?RUY2d2JteFRHdTlzQU1VdG1sMVh0TWxMeVhrM2g4djMrcURPNmNXcC9NN1Ra?=
 =?utf-8?B?dXY3OXhQdGNOVEJZM0JYWnlRSmFaZGlrRWNqMmNCNlhyRldqczh2S1RaNksw?=
 =?utf-8?B?TWlkSHoyNHRaN0l5YVdRQnR0NFFCSUkzanJ3NG5hVSs1c2xtV1ptRXVtQXg3?=
 =?utf-8?B?aDFMbi9iVjFvNTduU2M5YlhRWnRNc2xzcVZ3bUNuOVlTamRVK0NNQklVd0cv?=
 =?utf-8?B?TVZBQ01kb0tVa1Bod1BxTWlzaXE3M2dscjJtZVhEaDJqNklZcTd1bjFOSXU3?=
 =?utf-8?B?UllXcnZ3N090b2JTeHdXT0dEbzA3b0NkRXdjZzhRMk40YVdTU1ZBOVNXVGl1?=
 =?utf-8?B?VUw0WHlJdkJVRmdhZXFUTnA2cXRORDB6aVQvSENlZkdzblBNZG9USmJQMEJS?=
 =?utf-8?B?bXBjcjZNdmovV3A4NWZydXhxdXMwWmp1NVBoam1Tc3hQZU5BSm05ckd5SzRX?=
 =?utf-8?B?NUc2SzJqUTZGQW1yUlh2c2hyT2U0SWVzN0YvOGlDTi9CNFNEUDFJQnMzNVoz?=
 =?utf-8?B?N0xpYWxOcllrVEN2b3R5MHVBek5nNC93enI2U3puRjJQQy8vUSt6b2gxVDlW?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c5681a-7dc4-49b9-6351-08db1b256d5e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 13:52:56.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH/5AQY9dFBUE+Z/k42exoDq7gmVMVX9WrfPf4CBFF2CJFUCkel1TGXr3e7J3fAU4yDTD8bzxwpcarl8lInK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 3/2/23 07:56, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
> 
> Future work would be to allow drivers using the SVA APIs to reserve global
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v4:
> 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> 	GFP_KERNEL in a separate patch.
> ---
>   drivers/iommu/iommu-sva.c | 62 ++++++++++-----------------------------
>   drivers/iommu/iommu-sva.h |  3 --
>   2 files changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 376b2a9e2543..297852ae5e7c 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -9,26 +9,13 @@
>   #include "iommu-sva.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> -static DECLARE_IOASID_SET(iommu_sva_pasid);
> +static DEFINE_IDA(iommu_global_pasid_ida);
>   
> -/**
> - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
> - * @min: minimum PASID value (inclusive)
> - * @max: maximum PASID value (inclusive)
> - *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid and will be available for the lifetime of the mm.
> - *
> - * Returns 0 on success and < 0 on error.
> - */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   {
> -	int ret = 0;
> -	ioasid_t pasid;
> +	int ret;
>   
> -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> +	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
>   	    min == 0 || max < min)
>   		return -EINVAL;
>   
> @@ -37,39 +24,20 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   	if (pasid_valid(mm->pasid)) {
>   		if (mm->pasid < min || mm->pasid >= max)
Here seems not right, since the valid range is defined [min, max]. 
Shouldn't the invalid range be:
		if (mm->pasid < min || mm->pasid > max)

Regards,
-Tina

>   			ret = -EOVERFLOW;
> +		else
> +			ret = 0;
>   		goto out;
>   	}
>   
> -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -	if (!pasid_valid(pasid))
> -		ret = -ENOMEM;
> -	else
> -		mm->pasid = ret;
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
> +	if (ret < min)
> +		goto out;
> +	mm->pasid = ret;
> +	ret = 0;
>   out:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
>   }
> -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> -
> -/* ioasid_find getter() requires a void * argument */
> -static bool __mmget_not_zero(void *mm)
> -{
> -	return mmget_not_zero(mm);
> -}
> -
> -/**
> - * iommu_sva_find() - Find mm associated to the given PASID
> - * @pasid: Process Address Space ID assigned to the mm
> - *
> - * On success a reference to the mm is taken, and must be released with mmput().
> - *
> - * Returns the mm corresponding to this PASID, or an error if not found.
> - */
> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> -{
> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_find);
>   
>   /**
>    * iommu_sva_bind_device() - Bind a process address space to a device
> @@ -241,8 +209,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>   
>   void mm_pasid_drop(struct mm_struct *mm)
>   {
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid = INVALID_IOASID;
> -	}
> +	if (likely(!pasid_valid(mm->pasid)))
> +		return;
> +
> +	ida_free(&iommu_global_pasid_ida, mm->pasid);
>   }
> diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
> index 7215a761b962..c22d0174ad61 100644
> --- a/drivers/iommu/iommu-sva.h
> +++ b/drivers/iommu/iommu-sva.h
> @@ -8,9 +8,6 @@
>   #include <linux/ioasid.h>
>   #include <linux/mm_types.h>
>   
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> -struct mm_struct *iommu_sva_find(ioasid_t pasid);
> -
>   /* I/O Page fault */
>   struct device;
>   struct iommu_fault;
