Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503CA77BD18
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjHNPcQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjHNPbt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 11:31:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A366130;
        Mon, 14 Aug 2023 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692027108; x=1723563108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/8EN4kP27aCMi3RHVkvabc7rMtMl/+4IPhOjI9vkGXo=;
  b=UNuWa8RD8WhIeC6MIJkYS1peeGoiHE6h0PzggBoWC8pDidbhjE0sur/p
   gKmrCMegM0BzTBNrHsXA+0wZMnn7KQvSfiJ85ydzhMqJMU/YvlPDDUbFi
   bpBPdh5s6+qWLhNZpXZboArlZhWOGQ4RcVMZSgXuOJkRW5Fw5r/GLI7wT
   oGO6ZKH/YLoqqc1TPbSilKDWshl+z19VaI2vm12NKxouBQppoBEjcOQGv
   B7akZ7MMf0nOntGKOqsvgUFT/QubbiLIfzP1/vOqNH1gY8HjGCRuerMht
   TJRHB9UpCSJjIoBG7SxAnnOAjJJJfS2abZNXIBx565mMB87KwPzOUlU6E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375777982"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="375777982"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="762958011"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="762958011"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2023 08:31:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 08:31:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 08:31:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 08:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktsda1vffv0FsYIw48RSNeUqMcQYJpPvvpOO+ZWtX6gmGMxEYk8OnJpXLmB19EOy0VAIFZ5QkVqPGpAB+yVCw17rObkwCuvQIQl4eKhK1VFIh55ann4NOX9kBF1KtEfsMnj/vdSJf/uUTARq7r82GbtN5lPVopes6r+MRJqWFg/VOhBHpZv5E4sDcV3AHAO4UCg0g/RKMeFPEHqiBT09PA51yVUYzeB09HS3iaFmQjzva2fArPMlD9tFYCth1a+h0GoXAqgHCTQj1oN67es2IU4qQ+AbuGQ4pBCEIMQW0CbN3kmEhnGZLL3ELp9Hw4ZDYsprqi95R95u2tZ72CjyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQKOaVMo5XrwcNNlDN8zD3Jm80UJ9X5lVcehER14Ex8=;
 b=CGy5YksGqHGguY0cJ0a+fjPIIv2+NIrmJWTagoewe0yMAeXsWkzVKzZqP2aSib99IW4bA9TDaqDQhmwN948AiUFbRsCDjTI9IYxHlUaF6ab4Xkbb1LixcvA8scPhBM114+Sua1goFgYw3Kgi1+wrE8Njjc8k+oqWLB0oU8EnzYt7SBRcCO79vHlU3dkM49W7y44WpMwfKJdthRSIAog8aBQ1pm+DysMy/+mJ2UNslBed10Xb09EHDky9QR4YanqD6kG96Ub/EC8vuuY0xrJ6MyYP/RdONdT1fntkcoBPfUZsr9i/GLvAcP6Ttz7Pqx8n1ckewBk5npaD0E5jLauw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:31:41 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 15:31:40 +0000
Message-ID: <2af57964-9c63-b67b-5cfb-0191cee1ef14@intel.com>
Date:   Mon, 14 Aug 2023 08:31:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH -next] dmaengine: idxd: Remove unused declarations
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, <dave.jiang@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230814135952.12892-1-yuehaibing@huawei.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230814135952.12892-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:a03:100::28) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 964b902a-1b0e-4d17-6670-08db9cdb8e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDC8uVgrJ2eN0p2Sv2qKHvnK5YzUX622/KcQPCvWky9cPxLV+wNUusw79kkSrRubJrWC9rU8efR7ggY8rdbNBItNOAEGqf+m/SeagkKZaa9Z7R331OLJZRQibTnYljzKkiLL0VWl+iP69mYfnINEjWeuz94CopRLFpYWdFG20zyLLGEFfdJMWRJq7dzpdjy6/VIwfJzSXC9aBlgdTNbHXveNo3WSghFJlH4JkxCYKs45lqXV8DHUyMlHUuNv8vwYByoK64LtQp9Akyt1ANVmOoG2iFDBR8JDQ3Pv1gXy7zIbHv9I4I+MQGq9d2F3p8pnOyJ6Kupmynp+o4sSQpw9Bqi2aJsHenzoMFcT4OpgtuxpTmFABb6Fs5a+lavmxtKplZhzwHYXAPiNQIPmQXtxBuXi6VZi2xX9GbPL0o6tAU7vH7hkTLDvkSEvqIWsKlIxafaufHs9fJwMu/V+D3rN+mIwS/g2O7LvHqmpbOgxjWMBFf5vpIpq5jIS6I46v9ZgrrF+CMwlj7K78XGXjG7HJ4soVY2BVhZ4Rw4nSTw5RxANvytvCqFOVqKvpRY/RgVfhahGxR04sYg6/B08Vw5w+ALiR4lnviB7VXzdDwvRLdC0IxhpBSy3hXK1D9o85CN+bhGmAssVs/PT7jX1HNYy0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(86362001)(31696002)(38100700002)(41300700001)(478600001)(66946007)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(44832011)(82960400001)(8936002)(2616005)(26005)(6506007)(6486002)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnN0ajVtdU5nS3hWMGlvb3UwWW9rR09BcWNiQlNYeWpMMDc3WEZHeUNIS0tG?=
 =?utf-8?B?aTBQK2hGLzJaalg3ZmQvUVBENUJ0YXZpVUw1dzNlRUY4cHBzVUQwTXA0ZS9G?=
 =?utf-8?B?bjBQL2d2VFhub0F6RkU2OXZQdGt3dE04OU1hUWlmcmplempyK3dJZDNRbU5B?=
 =?utf-8?B?MDR4MU1aaXgxaVI0SUtxcnBEb1AvcVNmVFJrcG5vNUYxMC91WWZHZHJQSDkw?=
 =?utf-8?B?eVc2SXJ5NTNwQzZjU3JRd1pZbDBjWGtPSlZhTE9aZEhlSXoxcC9INlFqL0sx?=
 =?utf-8?B?cTZ4YU4vUTdQVHM0SDdLRmZzN0JQQ3k1V3doeFpTaHpyRHFHRnFzTG02eGgw?=
 =?utf-8?B?ZTJEYW5yS044WXZ3b3NxbXJNZ29FajdJekhSeEE2MTZzT2RZc1FBK2haU2xO?=
 =?utf-8?B?Z3dySFNNeXI0dkhsRlJOOEgzNW1ZdHBKTkN1c1ZpZlpkenB2bis2OXNhOXZ0?=
 =?utf-8?B?LzJOREtlblZNMXl1bHBLck9aalRUeEhiQ1MzT1hwWjUvOURCakJjSUlsN2Nv?=
 =?utf-8?B?S0pTRDIwKzIwNTFweDU5MU5QMW0xVTZmTThUMktWMjNZc21VZGRkUzc3RkE4?=
 =?utf-8?B?N0Z3allZZWJsUWxBWEdPMG5TdXR6MW55bElmaFNmN1dUQjk0cENPcDR5Zksz?=
 =?utf-8?B?cThEaWtHYjlTc2dMTVVLZ0VEQVA2a1dnOTg3dnVORHJJamZoYndlT1RqTFZh?=
 =?utf-8?B?NVo1ak93UTFtK0NFWXF2eTM4ZFlKSGlzekZIOTBpdUM4Z2l1RlZHVGhHZGoz?=
 =?utf-8?B?UWgrL04zRnFMZlZzNCtFVDd5R3NTRXNUcUpOeVp5VmVkM1RVRFFZeGxxdktm?=
 =?utf-8?B?L2pFSVNPVkV0MEZsOUNCOWpFWGlxL1BLTHpiRlV3MWk3UUtYbWFUeXhXTlpz?=
 =?utf-8?B?NS91NGxDM0toc0N6TUVHc04xbFYzNkw1c2diaFZsNzdGbFlFLzRVTUhndGlN?=
 =?utf-8?B?eXV0SEZFUkd5MTRVckhmVlkzN1daVEFJcEVrOHhzc2QzWWs0b1NNWnBRZ2o5?=
 =?utf-8?B?RFdpWjdoWXpSYWlNSXB5cjhYNjBhclNIaUdNYnk0akRUMUxUa1hwOG9EZzdO?=
 =?utf-8?B?SVB1dnFrVHM3MFExemZxUm1pZjRZZisxaVFGV2ZLZnVINTQ4SGZDcnpnVjJv?=
 =?utf-8?B?ZmppN1QwVVBJaXZaOW04L05SOExBQmNSMGhuTFJVTDgwRUM3a0t2S2VZd2sy?=
 =?utf-8?B?NTVaN29rajg5TXZzSFl1Z1Y5Q1dacUxKaU1aeUVGcmFjK2J4SDE3TU5PdGxo?=
 =?utf-8?B?Ukh2d1BjYzRFNmVPRExsNVhPbFVteTI1dnAwYWhVRFFNV1BVK0xNTTFWQm5D?=
 =?utf-8?B?TTNIOHdyd3ZQeU5TUXpacjd2bjVJNXdUYXRNbVR5eVB6S0JjQithWmpNdnhE?=
 =?utf-8?B?ODBZZVRmcVlBdno0N1VGWnJNZURZRnpJY3dJK242TlV2ckxXZDBvbjlsRmNw?=
 =?utf-8?B?cFBnWXlXSVAwTDRMS0hFeWp1UUVtbDBBWXVEVXdUbFJSdXpBbXZQUWpYaS9h?=
 =?utf-8?B?VW85dnFNWTB1ek1scUp1YzNraWxYcHpWeVRwdnhMWXc5Nk1Bc3grQ0F0RDAr?=
 =?utf-8?B?ZzA0aWp1Znl6bXVad1UvSXlFNEdjWmxTM0VzUTJlWmFheC8rMTQ3WVZvY0J1?=
 =?utf-8?B?cEVoWDlYenRMSEZFMi9GZTdGUHZpY2puUGJuR2I4c21CbmNDdnRsYUdlMjdl?=
 =?utf-8?B?cFU5bjlzZk9tZEl3dERkcFhabndUYmZsSjd2b0ZRZnljT0F2c25URzdnMkRV?=
 =?utf-8?B?SDVXUWwvcjlNUXdKbGhVKzlZWTcvVS9NYThjbnF3ZjFOak1HK29xQWNNVnE5?=
 =?utf-8?B?bHVyZ0hwTEZteEVsMTYxY1BkeFpCYWRmNkVMYXdpSms2MG9TM3pGUVNoRERs?=
 =?utf-8?B?bmdMWU9QY0Ewd2IwWW9hUE90d3hoWUQ2RTR2MEtHdFNiWUN6MEpiTVlOSHVW?=
 =?utf-8?B?YmYzanl3dk9YV3lVOHVhanQ1ZHdjelAyaFhhVUJ4U2ViMmpOQndDWlNHclBt?=
 =?utf-8?B?MVBIL0l3eUNoandWMi9lbWkyN05qU09yQlA1YS9yVWlMTWhJa3N4VnZEK2cy?=
 =?utf-8?B?YkRJeUNBa3JsajdZSzR6YnQzZkJ6S08ySUIzUUJ2K0Ezb3lmL0R0MURhaHJ6?=
 =?utf-8?Q?OBOWt3E0BETS9qoanc+dVJ3YA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b902a-1b0e-4d17-6670-08db9cdb8e0d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:31:40.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV9COR7lEpHj7AlnRDHp+1Vyp59N3LF0dn99/m4uXkOsMVm6PNfVxQK6qUplhdmU8ODdOnn/IeMgvMCH/k9R+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Haibing,

On 8/14/23 06:59, Yue Haibing wrote:
> Commit c05257b5600b ("dmanegine: idxd: open code the dsa_drv registration")
> removed idxd_{un}register_driver() but not the declarations.

Is "removed idxd_{un}register_driver() definitions" better?

> Commit 034b3290ba25 ("dmaengine: idxd: create idxd_device sub-driver")
> declared idxd_{un}register_idxd_drv() but never implemented.

s/implemented/implemented it/

> Commit 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")
> declared idxd_parse_completion_status() but never implemented.

s/implemented/implemented it/

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/dma/idxd/idxd.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 5428a2e1b1ec..05a83359def9 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -651,8 +651,6 @@ int idxd_register_bus_type(void);
>   void idxd_unregister_bus_type(void);
>   int idxd_register_devices(struct idxd_device *idxd);
>   void idxd_unregister_devices(struct idxd_device *idxd);
> -int idxd_register_driver(void);
> -void idxd_unregister_driver(void);
>   void idxd_wqs_quiesce(struct idxd_device *idxd);
>   bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>   void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
> @@ -664,8 +662,6 @@ void idxd_mask_error_interrupts(struct idxd_device *idxd);
>   void idxd_unmask_error_interrupts(struct idxd_device *idxd);
>   
>   /* device control */
> -int idxd_register_idxd_drv(void);
> -void idxd_unregister_idxd_drv(void);
>   int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
>   void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
>   int drv_enable_wq(struct idxd_wq *wq);
> @@ -710,7 +706,6 @@ int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
>   /* dmaengine */
>   int idxd_register_dma_device(struct idxd_device *idxd);
>   void idxd_unregister_dma_device(struct idxd_device *idxd);
> -void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
>   void idxd_dma_complete_txd(struct idxd_desc *desc,
>   			   enum idxd_complete_type comp_type, bool free_desc);
>   

Other than the minor commit message changes, the code looks good to me.

Thanks.

-Fenghua
