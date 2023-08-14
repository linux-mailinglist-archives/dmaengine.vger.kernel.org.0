Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B538A77BCD7
	for <lists+dmaengine@lfdr.de>; Mon, 14 Aug 2023 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHNPSg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Aug 2023 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHNPSJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Aug 2023 11:18:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6510F7;
        Mon, 14 Aug 2023 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692026288; x=1723562288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BSmu4t3uPpUsQuQJcw6IneJyt53WPT3Jz7MdcH+BMS0=;
  b=CaJTynwtpPh95Z25sThfm+1TEeqtV0xlspjzBNNCC1peGjtO7Cttm8bR
   3BYlcSij2GUeVe1zrouvafkm9PyFQVrbzazXReHUqS7u8BfHUWU8rWoxN
   pN8zYJ7KcnldH9+1P7zvxJjdOAkg3elBl68PN1cxAgu7iArzBqsSK1WRa
   dlwmjta3VgXZ49UEPPTxwL1lAuX3YjPmh+U9HwQRGNGaRm+x4atGX0aje
   OdYVpN571izl8m+9Ujeb9D1W9IWa4hBp/GZ8oVP4EZ5rbUjwvR3K+U/s0
   GxLFmyUARlma07+7LxNqvk9radqFT35LqSke9k11ZNXRiEUnFrbnaH4i9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="351657635"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="351657635"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876974453"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2023 08:18:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 08:18:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 08:18:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 08:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op49gl/jSYDIm+W2VxrzR8FPkhe3xYlou5fkEUeYS2HKqL7P2yspBQSCD9N9y8IXiSjxho0lgbsqk8V5JSb+AjJZXFeFOtV+XfMX28I7QSgHbbohPl8ef3/AQ1TihUI3uC6zLX+t0BfXqPUa0odjJw9ehI+cUenXS5JgXK3pSXdbkMqK4E+fzwlASXO1negGakmBdGRevXMAe3qlrNEyIvFauQcL5iWhXy+PpKANzGKQd6pvulciHXkaklEcyaz6qjo1oCg3RpX/mR7Lo+mK4Ft4sxOMfmgSMoIugmKnPXZR16b2nIeLP4l2UNROnXWn4DbBY1f1IpH0yVLTqu9ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpefuS/qcPmqpvOjDodSkb6TYEtd9LHmVl1jnUyN1cI=;
 b=JtjBIkWaMvWUi+5pomI+7Wr3oerNiR641ODH8Xym37etu0EhccubQxVZJwiCtTgUmx3qgsRGwp4u7BStlubEV6LKrr0sXs84g59eGNPHp4SuDf69K18bFNo6Y7kib3VGS+3xkWtL2b3/LB31KlTH0xnoMo1DOlF5ZPpWcoEycOmw8rh9F8xgmNX2b7qMulfvZ5oVPoWNHeMgYrjiM3S29w7YMiU56tjI3Ko0NS2ASSjvUnFFGcZB8szwc9WDHY2Z+F3+vvCgIvvZkO1FKum5WJO0BVcShCtl63edm25V4R3qy2eyPB8+jW924hHitOAAunQ3GI2nYec2hczQM0GS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:18:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:18:04 +0000
Message-ID: <22fdba99-8af2-fb3b-a208-a9bc1eab317c@intel.com>
Date:   Mon, 14 Aug 2023 08:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH -next] dmaengine: idxd: Remove unused declarations
To:     Yue Haibing <yuehaibing@huawei.com>, <fenghua.yu@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230814135952.12892-1-yuehaibing@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230814135952.12892-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d46f6e-e710-4214-1a67-08db9cd9a7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtm4iw9kfeau29LGBJD2rCOGswUgiDf1T1R88yhNRMC8NgDPvwa6I43d4Zc4fZqunCXWZ/fpmSs1kCmwDKe20nEDV6VgrLTbHSSQLze+PbvfzCSgYhSfwaSBWi95hSgTSRs+CfwrqHXsmGTYEd3QtqVACefvgQtALZcxbn17DRHEtFXFYVmXo11HgBa20pPKDWgeRaZfs2CegbCO9I+TJML25aqGC+/z7z7/cKLYu7qovmMcRngy3PksLNbBgh/GJW+g9L9zFiVq3NrwaQ1rshMuaTrPalljsq3pGnNSO54/RjqT028sTJq5Q51AAN6+i+vxTJw8m72ZcTlBmRZdfZ9JEhug28cMUlaXrf1tD/d5DMj4DhkJKeEHpTMsnnzer0Y6rD895nVrkMSnPNs4//9a6PcTvm+WJ0h6bLv295rUMhKWsZCHj9UXMUu4NENsS0SlRtfLVksHulpbhTi4u8sxDbt5861U/7+YJ4BaAqywL5E6EqnABY5dRIMTOsCoMI2Rg7n/IzG8WcfEZu+vrd0i0UAINnlF12PeD8jk6WuXzxAIDae4jK4Y49CFKZhchstU9zdZFn9sbZqF2sgF/BoTd6BLvbSUIz8CiX9vIrrFQtzDt5meYfI3pjMPaGbpBUz3uSebq7/5IyvPpDCZ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(186006)(1800799006)(451199021)(2906002)(26005)(6506007)(53546011)(83380400001)(2616005)(478600001)(41300700001)(6666004)(5660300002)(6486002)(8936002)(8676002)(31696002)(31686004)(86362001)(316002)(66946007)(66556008)(66476007)(4326008)(38100700002)(36756003)(82960400001)(6512007)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdEOUR5b1piZ2pyZE5EeWl4L00vbEZYamljQUxtQkVuS003Szd3OUNLYnFC?=
 =?utf-8?B?dWVrRWhCWkRyRU1vcEdFNVVxQWJ4STlOblVCSU9rKzd3WEE3Uk8xZVF0ZmMx?=
 =?utf-8?B?RkFxKy9HL1Z1Z0d3b1Arc3RtbCs1MzdZbnJEMXRtT016WTdWYnZseUVSZWsx?=
 =?utf-8?B?Sng0RDV4VkxaUmVnSnhsUjZYK0xkRkhDMXB2Y2pEUHY5RkdyaDZ3SXRZMjgr?=
 =?utf-8?B?WUpWUmlEaG1LRUtZWmJDZlQ5bzl2c2ZoQjRIU0NGNDJ4QjJPN3pEWUF0Mi9S?=
 =?utf-8?B?TUlvY0NBZW1aSFpmbGEvSE44dlFpRElocm1HeUcxaURyYWRlTVpuMStQenlv?=
 =?utf-8?B?QXFpYmF2WElJOHJNVnRHcGx3UHR6VmZJdlpzQm9VU3RqYkJKQTlSZjJwelFJ?=
 =?utf-8?B?N2h6QTFreEhNV0hIZGF1WHl2RlZIcFBha0g0bE5mZU5FVVNieFZTa3J0ZVFo?=
 =?utf-8?B?SmRIaXUxdWl5d1paUGtqRW8yQlA0cWNsSXRnUXkxdHJ0ZVBLeC9RYnQ0c0Fh?=
 =?utf-8?B?Rmw5SGNZcERHcFBPREVXOWs3cWFKYXdFVlVacjNkcFVlTHZtUjc2ZkE4K3ZI?=
 =?utf-8?B?MzJJYURaS1k0a1BDQktEZnBTU1M5YjNzSDRVaCtTV0NSRFNTNElvR3M2dXhi?=
 =?utf-8?B?b2pzQjVwcWNaU2M0Mk8wTHZLY0VFVXVuZHBhczN4ellCWE96c1ZUWE5JbmE4?=
 =?utf-8?B?YVExN3ZzNGtYNFZ2bEZMYTFTY2RiOXhlN0cxRWRPb0RWZ1FmdDRMOTRKRnFI?=
 =?utf-8?B?WWt4Y0hWVzlNaWh0MHpibzJkL1pCNTNPeUdqWFlFYW12aHJybnVTdk5VQlRC?=
 =?utf-8?B?KzNOZlZ2aTUxbXdCenZtMEpKS1piaTBVYXpwMmNZemtubUloTWNMNGlNcVIw?=
 =?utf-8?B?VDk2OUNFck5OY2Evamh0RTd0cWdNT3BXWGFTelExMVdUWFdyQTk5dEY0V3Fv?=
 =?utf-8?B?bjdsV0txYS9wYWZBQnZQOWhvclJBTU00TUtaOXhFbVBuZW9KOTZnbnpISExa?=
 =?utf-8?B?a0ZSVS95Y0xlUCtnc3dKNUZQUzUyalhmQUtxRHpsRStlNUI0NW5ITmtwWWxU?=
 =?utf-8?B?MDJ4U1lNV2NsSzFRK2dGVWhNYnBwSnNzcWhjczUraHNWSSsyQWtxUXNXeUc4?=
 =?utf-8?B?Q0o3OTRKaU1vYUsxMXdDd2lkVTR1MzcxYnJCWEw3NnVzSzZzVURMbDcwM2li?=
 =?utf-8?B?SmRwOXpHMCtDMzkrNUFNSUV4OTFFMm91ekpCVjVkSExnNU9kNDZ6QlNFalNk?=
 =?utf-8?B?REV3L2tkOW1ZeldpZCtUanBBNDM0Tm4wcDNLaVdjM3JYVThEYnF4dWNPRXkv?=
 =?utf-8?B?NGNuRFp5T1lYclRGVkhUWHFxaENnU01yT0RKcFZldWI1YitsRkdoTUprL2ZW?=
 =?utf-8?B?TmpXSWw3dmhnTWc4ZVN1bndkVVFNdGNDQ2tZaWdnMmRQcklmZVNiME1pRC92?=
 =?utf-8?B?YUpkejBIMm1yYWttRlEzM2hZdG1yaUwva2ZhdUZqdlJ4K0hKaklLQlNCZTNX?=
 =?utf-8?B?bkJZdzhkT3FSQjFOY3BOaXRMaU1acmIyejFDWGNsbERhOVZDdVZJdVNtekhH?=
 =?utf-8?B?WGpBTGFjY29QemVzbnU2QlBBcDhTYVEvclA1b0JLU1BYUXRSK3djMmNBMzZ1?=
 =?utf-8?B?RTBGN2VRWk16R3k4UWZldGhNZzVzbEdadDhncGluYlJVWkloVHZtY2ltSktD?=
 =?utf-8?B?VmMySm1oUWtxUWMwT1pFWmtTYTlKVGIzWVdaZ25tYmt4NTRlYS9BWHVhUlRs?=
 =?utf-8?B?VjN6cmhlUHhwWFpyMElWMTNRU0xpUHhPTFZMaHZiNi9yMkpaenArR3k2Nks5?=
 =?utf-8?B?TVFIZmhySVM2NGptbWxTWkxlYmY5QVczMlB1MmZzSDR5RDBaZ3g3QWh4QjZz?=
 =?utf-8?B?R002ZkExclFxYWFmVUdjUUcyU2VrdG1ib1ovZVJKclVzOVFpVXRMRTdZcFEy?=
 =?utf-8?B?QVVQM09USW1JRm4rYUZwWjV0NlR6Tk1naG9WK2JDV2lEd1lyamtRK1NlbXJY?=
 =?utf-8?B?QmViZmdxU2hSckVFY1BWR3pBdHlsV1ovU1U0dWt2dHhCUko1dVllU2NEek5x?=
 =?utf-8?B?NjV4QjNmRWZwZEJwTFlJYU96WHJCVmozSkovOWZaOFR4VUJVcWdhemJ6M2ZH?=
 =?utf-8?Q?pc5jcriAqmHCUqrmtu/aD3NtQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d46f6e-e710-4214-1a67-08db9cd9a7dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:18:04.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktr5vGTmXhaIGUZcRDwm5w+CKpEv456iku5C2R8pfWo6IV+FBz1GlEpN6y1o46v1C1MmaFVAjwD2Rzj5NpAaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/14/23 06:59, Yue Haibing wrote:
> Commit c05257b5600b ("dmanegine: idxd: open code the dsa_drv registration")
> removed idxd_{un}register_driver() but not the declarations.
> Commit 034b3290ba25 ("dmaengine: idxd: create idxd_device sub-driver")
> declared idxd_{un}register_idxd_drv() but never implemented.
> Commit 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")
> declared idxd_parse_completion_status() but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks for the cleanup.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
