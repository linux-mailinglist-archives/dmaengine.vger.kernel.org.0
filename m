Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580976CC9ED
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjC1SQl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC1SQR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 14:16:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB71727;
        Tue, 28 Mar 2023 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680027376; x=1711563376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zt3jDA3GlOkn1lydKXhlunzSXfF0rVI292+I8qwWZq8=;
  b=MhR0/mwri5dBu1jShFSV3+OqwRFwYh4jHlJC93WCpkMTcgU60la1Xnxx
   xphjITlKUP8/qGmh5UrEb1ZdTBpkqLi8Nf55u+if7sEr40Bg+IV/iFpVj
   osKl0tiJlNrTX+73ih0DeWERilFq6vZataOmUdBq/O4u0S4Seklf4787b
   Ldjd8296EabKgCD0hKnMTDXOPljVkbyG3+DCgdfrr4YkE+/QxmlU+9uwi
   dNnMimVFjCoJAT9SOvL+/2Y1gz6xk4PxHKz/rvA+HKnvvpGM0nG1fj85Q
   2B0N2bPWZCOmo1vKnylv/t7S8UxJkmMS0uAduYKZWU7muvU8MrRbeuYyp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324551845"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324551845"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 11:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="858204670"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="858204670"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2023 11:16:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 11:16:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 11:16:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 11:16:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 11:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7lg96v/7iWh+JG5N/d46OXZQCZZserFHRL/HjpVO9zuTJ7COZhN7HGF6U4UJTpPDZhdJhjOKnrROZN4thhHNzFzUl8c2d3rOaKsUnB+P4pJpEC4xA7gFKL/8SKVVjqPjrghayBSWDimtHHgFo+Siaz8I0Uq1snwWXHBy9629F4DhchD032Poo9Hh9n17fZAt0gupMFM/OvFFpEae6TdMfKajN2Cd49iWV//JE5WcCRdtJl6iJI7ssb8UcVTEHKEqkbyt9xScM/v6W3ZsOKD2PFjUiqiTfGYwXe2hysNGJF1v5Ez1eWYTg30o+3wG2h71pbpgRHqIx10cPWDVOpA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAhlVEZzGxJBqiasBrGmYXK1VnmwW+HUBys9iezKn4I=;
 b=Qp8PyMTi7Xpj8KLZbKmxGTPypKIB8FbDhNVyldVZyKFnLUq6z0jRs219qu3Ig1Rj4XdmScsvEGPksOw1EbsxIXEFfgpP8RRee4jyVZpyzTYOwGio2NmeX0BF6r9bYNpmor3R8pggcXE2sf7fZUjAxYFBxMYY/kaheBKlv70dA8osa4xO8vjE7T2r7SdoIQY5QSVOgCHcZ9W+G1o6V1q9eT/D2N5Jg2aHby5PjoEqYJWkxS+H4QXR91b6O5rXhpfC62yXR3ogGTBYPAOE4f++JRYkVtqwPFU8aLh/BlBQqmjXsHA/nch9/3VdhhZYWTAHY8IEJoh8N43g4+XOo53oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) by
 CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Tue, 28 Mar 2023 18:16:11 +0000
Received: from DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::1f7a:38c7:8309:d17d]) by DS7PR11MB6103.namprd11.prod.outlook.com
 ([fe80::1f7a:38c7:8309:d17d%5]) with mapi id 15.20.6222.029; Tue, 28 Mar 2023
 18:16:11 +0000
Message-ID: <a2a107ce-3ebd-0876-e720-cae07e75fb09@intel.com>
Date:   Tue, 28 Mar 2023 11:16:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 8/8] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, <dmaengine@vger.kernel.org>,
        <vkoul@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-9-jacob.jun.pan@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230327232138.1490712-9-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To DS7PR11MB6103.namprd11.prod.outlook.com
 (2603:10b6:8:84::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6103:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: d18efc69-4c20-4d50-86d8-08db2fb8820c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjyOu/Pi7wZSBlak+Q+Wc3JpK4h52lZswXKnegOuhkJMNqtMu/3wXzUqUlPFNutDq5oHjyMCt/7tiYrxpV2dyU2924PSYLgXoX6EmY6U/KlunurLYEhoUZ6Mghm9pssgnRP1hrzOOJtELwXalVu1Kw9jVGMqk3SeOH38Y5Un4iA9B08GcIycfWCVow/DWEaFujcnuPP+kCVe0CO2RxEJ7pNWedtsyVo8AkmdMAOfAQtZo2LhH3O1JSbM4yYRq2dX4++9mNdIvm59T8q069rnCLB6YNBkR+D98XIG87XKkwNb+1poGCBYQbM389X37F8YNx34EkuBAPRyryXLlZ3ka/NTBEGJX8eR0WSehTt7EF+RwsksoTu0SEtd3lxzhoum68OpH72Gh7gKEAnNCU6/TfM8nv4Tbiet0lAhD4vdnxWpRpDMCd3mgyPjQ1wfBuiyN4HqxKCg5iSAKwMGLYOnUfjfCtRSJ+aAZ7IXMNUo9aDvI9ueI8D0Essjc5TFcCgNPxo/pgxcRTlv2/io7UNfeLRRKk3KsRH7DyBkrzEqg7PYNEJY3pClC/ayUqEP2vmf9wLfVSsZoVw9wYOSjYVvn9G1orFkoj3eqJN1t4rTkgmSoGKQu04BztGNzItU3PcMbjRUaALOWC+E2sNImsnqbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6103.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(53546011)(26005)(6512007)(6506007)(41300700001)(6666004)(186003)(6486002)(83380400001)(2616005)(31686004)(478600001)(54906003)(316002)(110136005)(38100700002)(4326008)(44832011)(66476007)(7416002)(66946007)(66556008)(8676002)(2906002)(31696002)(36756003)(86362001)(82960400001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZ4Qlp0QXFVcnMwWW0rSVVqdTVQZ3JHN0c2R055Y1h5ck9GMzl0bjhnZERm?=
 =?utf-8?B?YXRKcDFEYWRaejFoN2huNlNzNU8zbGNaV3dsR2hrRTBSRzM4NlNOU0MySXJq?=
 =?utf-8?B?Y0dMeHo4NkRkamdkTXRIcHErcDlwanBrQXlDUEszMmFiR2owVXdFMjVDYW5G?=
 =?utf-8?B?SVpvT1JjR0dydTQ2amxNMW9zQ2tMM2pKUGxuVEdiNFEzeGdkWXNEa1h1cU9i?=
 =?utf-8?B?eitRUUhjdk5RYUpGK09OditjbFlzSDN3YXdDdE5ZcFFBM1RZSWVUMG9DOXJw?=
 =?utf-8?B?WU12c25kMUJzMi90dWpsbCtSYTMzUnZBVXJ1VEYwc3R1Tm83bkNaR3VjdmFy?=
 =?utf-8?B?V2ltSzlmb0MyKzI5Rm1OVG01Z2xPQlBWTXVUYkZVN1dxMUlEVU16alI1bDkw?=
 =?utf-8?B?c2lBNFdSUm9kWEdUcCtHSnRvNW9Ra3RMSWxkRzRyUXRZeW1nNnVLSkU2OGQw?=
 =?utf-8?B?NnJiTzRtTUd5MG9USUFSd0FmSXpETUxMTnpQdUpMUktNdnBxZ0wxajdSMUxU?=
 =?utf-8?B?YjhhUU85b3F1OG0rZ0F4SngvZkRtaFgwcVA0d0JLaFphbmtHRVk4dmRYMWxj?=
 =?utf-8?B?RzNUaTFpZ3I5a1RyYko1azNDdUE5SEdBaWpqcFcwRkZGLy9ndTNnNWVnUTNU?=
 =?utf-8?B?K1NsTlVtQi8vZ3NadHhVdjlTRjZsYlJIU0NlR2JQbnA5cmdZNGxybXFBWlBj?=
 =?utf-8?B?VkV6bUxsa1RmMUkyTWxEMjM1VGFOMmVJN09pSUZMRUFVMGgyRkNpWXRCdllq?=
 =?utf-8?B?Vk9TWDAwUTB0bnZIMU50b09Pb0RFYWt0TGVEWkFpN3ZzQVE1MnpPT0FiV0lz?=
 =?utf-8?B?T1c0Mnc5TjJlOU9yQmU2NlBNUEJqK3RwcjJVbGwweG00U0hCajk3YmVGbEpw?=
 =?utf-8?B?Q3NjOHYwUXlNSi8xYVBEMmV1NXhud1dFSUtuVTg5aW5CRXNnYng0R2VZcFY5?=
 =?utf-8?B?RDJuelFRUlJQNUxHT3h1NWxKdmNiTHhMdTB5cmkwYys3L3h1UUtEeW1SU0VD?=
 =?utf-8?B?NjRZTHJINnVCUUFZWjk5V0pmNUNzbitMS0I5YStjbWVPQk1SU3pZMFJVUC9a?=
 =?utf-8?B?L1pPZ0JEL0tsb2p3a0Z6UnFlM29tTDFncUZieTZpUEhoOUtVNXdEYnNSSnF0?=
 =?utf-8?B?c2ZXNG9FeXNjeG05elhtcmo1QmtSQzNpemZhL2FnencvZnpTMUp1cy9NU0cw?=
 =?utf-8?B?REFNK0JKOFowczJYZzZPZU05TXNzcTBqaU0vbG0wMUZFM1BUT3pEZkdMbGQ5?=
 =?utf-8?B?cXp5SW1UTU1EdWtQS0F6dncyODN2a0VFWGxjRFY5YW40UDRRM21tb01qeXZn?=
 =?utf-8?B?RHc4VkNUd2ZoV3JsSUdRclMxT1hxNjhRd0YzZzIxQzNPTnJYakpLYmI1UFZM?=
 =?utf-8?B?SzBiYTRvNmUwbmdVRFp6RERkVnFmMkpudFhZcHpIQlJnSDRjc05KZUpBNnht?=
 =?utf-8?B?YnluaWRoSTZJL3UwUlB5M2JkVnNQdW1tNGloVjlhWTBTU0JVdjU5QTlRdE94?=
 =?utf-8?B?QXprc3VJK3ZCSmZxckVlTFVsZ0FaOFVQTk1aSktxai8rdXJScW54Sy9JZ0dW?=
 =?utf-8?B?bGpBQTFPeW92L1ZobldkQWpYYlNRTGZKbVV1bUNYdFhJS0Ewa3kyVUNxSGIz?=
 =?utf-8?B?YzMzanNocnpzRFJMeWhKSGpMZmsza3ZXSm5peFVsejlYVFI1alpqWmVONTZI?=
 =?utf-8?B?RlNMUHdkMzJlSStaa2VHQis4T1Y0TEFiVWFYVWJhalhuaGsvNndSdkhwb2sr?=
 =?utf-8?B?MmRJMzgvZW0vYklFcSsvN0oydXN0Y2lyN3d3UHNvSDJONUl0NUpWN1R1SXZC?=
 =?utf-8?B?QjV3dUhuS29VMVFKVW5aZkFGZGh0NUxPNXpzcVp0bUcyUjBvQk1yc0ExRHYz?=
 =?utf-8?B?RGhPbktkcVpXd0x4bS90NllEVmZrcGtwb2MvNUdjcXNvNDdMSGoyTHcrVEtF?=
 =?utf-8?B?VWk0THpQTUx5b3ByTWtLM1FiZ2lvcmJydzZUdnpFV2E0QXpGa2VlWndjb3dt?=
 =?utf-8?B?aG5Ld1YrV2JqemZIdVU3VWI4VGlKdDkrQmgwc3ZQNXJjYXkwdE9neWsvV3Jx?=
 =?utf-8?B?VFdrZHpyd2lERHhld2J4bDR4dUhYcTliYnZFODZTTXFPUFcxV3M5eDFXUEMx?=
 =?utf-8?Q?Hgl+HrbCGoI6AqKK4LmmvqGQE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d18efc69-4c20-4d50-86d8-08db2fb8820c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 18:16:10.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI3HDaq2E/6puwpxmrgmi6rYITH3JFTlk8qkzOsNB54IVqCPSUMAF8RNiA3B2VnyHSdromHfomDOTgHV4IlCRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jacob,

On 3/27/23 16:21, Jacob Pan wrote:
> Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> API. Now That we have the support for attaching PASID to the device's

s/That/that/

> default domain and the ability to reserve global PASIDs from SVA APIs,
> we can re-enable the kernel work queues and use them under DMA API.
> 
> We also use non-privileged access for in-kernel DMA to be consistent
> with the IOMMU settings. Consequently, interrupt for user privilege is
> enabled for work completion IRQs.
> 
> Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/dma/idxd/device.c | 30 ++++-------------------
>   drivers/dma/idxd/init.c   | 51 ++++++++++++++++++++++++++++++++++++---
>   drivers/dma/idxd/sysfs.c  |  7 ------
>   3 files changed, 52 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 6fca8fa8d3a8..f6b133d61a04 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -299,21 +299,6 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd)
>   	}
>   }
>   
> -static void __idxd_wq_set_priv_locked(struct idxd_wq *wq, int priv)
> -{
> -	struct idxd_device *idxd = wq->idxd;
> -	union wqcfg wqcfg;
> -	unsigned int offset;
> -
> -	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PRIVL_IDX);
> -	spin_lock(&idxd->dev_lock);
> -	wqcfg.bits[WQCFG_PRIVL_IDX] = ioread32(idxd->reg_base + offset);
> -	wqcfg.priv = priv;
> -	wq->wqcfg->bits[WQCFG_PRIVL_IDX] = wqcfg.bits[WQCFG_PRIVL_IDX];
> -	iowrite32(wqcfg.bits[WQCFG_PRIVL_IDX], idxd->reg_base + offset);
> -	spin_unlock(&idxd->dev_lock);
> -}
> -
>   static void __idxd_wq_set_pasid_locked(struct idxd_wq *wq, int pasid)
>   {
>   	struct idxd_device *idxd = wq->idxd;
> @@ -1324,15 +1309,14 @@ int drv_enable_wq(struct idxd_wq *wq)
>   	}
>   
>   	/*
> -	 * In the event that the WQ is configurable for pasid and priv bits.
> -	 * For kernel wq, the driver should setup the pasid, pasid_en, and priv bit.
> -	 * However, for non-kernel wq, the driver should only set the pasid_en bit for
> -	 * shared wq. A dedicated wq that is not 'kernel' type will configure pasid and
> +	 * In the event that the WQ is configurable for pasid, the driver
> +	 * should setup the pasid, pasid_en bit. This is true for both kernel
> +	 * and user shared workqueues. There is no need to setup priv bit in
> +	 * that in-kernel DMA will also do user privileged requests.
> +	 * A dedicated wq that is not 'kernel' type will configure pasid and
>   	 * pasid_en later on so there is no need to setup.
>   	 */
>   	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
> -		int priv = 0;
> -
>   		if (wq_pasid_enabled(wq)) {
>   			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
>   				u32 pasid = wq_dedicated(wq) ? idxd->pasid : 0;
> @@ -1340,10 +1324,6 @@ int drv_enable_wq(struct idxd_wq *wq)
>   				__idxd_wq_set_pasid_locked(wq, pasid);
>   			}
>   		}
> -
> -		if (is_idxd_wq_kernel(wq))
> -			priv = 1;
> -		__idxd_wq_set_priv_locked(wq, priv);
>   	}
>   
>   	rc = 0;
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index e6ee267da0ff..a3396e1b38f1 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -506,14 +506,56 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>   
>   static int idxd_enable_system_pasid(struct idxd_device *idxd)
>   {
> -	return -EOPNOTSUPP;
> +	struct pci_dev *pdev = idxd->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct iommu_domain *domain;
> +	union gencfg_reg gencfg;
> +	ioasid_t pasid;
> +	int ret;
> +
> +	/*
> +	 * Attach a global PASID to the DMA domain so that we can use ENQCMDS
> +	 * to submit work on buffers mapped by DMA API.
> +	 */
> +	domain = iommu_get_dma_domain(dev);
> +	if (!domain)
> +		return -EPERM;
> +
> +	pasid = iommu_sva_reserve_pasid(1, dev->iommu->max_pasids);
> +	if (pasid == IOMMU_PASID_INVALID)
> +		return -ENOSPC;
> +
> +	ret = iommu_attach_device_pasid(domain, dev, pasid);
> +	if (ret) {
> +		dev_err(dev, "failed to attach device pasid %d, domain type %d",
> +			pasid, domain->type);
> +		iommu_sva_release_pasid(pasid);
> +		return ret;
> +	}
> +
> +	/* Since we set user privilege for kernel DMA, enable completion IRQ */
> +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	gencfg.user_int_en = 1;
> +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> +	idxd->pasid = pasid;
> +
> +	return ret;
>   }
>   
>   static void idxd_disable_system_pasid(struct idxd_device *idxd)
>   {
> +	struct pci_dev *pdev = idxd->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct iommu_domain *domain;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> +		return;
>   
> -	iommu_sva_unbind_device(idxd->sva);
> +	iommu_detach_device_pasid(domain, dev, idxd->pasid);
> +	iommu_sva_release_pasid(idxd->pasid);

May need gencfg.user_int_en = 0 here.

>   	idxd->sva = NULL;
> +	idxd->pasid = IOMMU_PASID_INVALID;
>   }
>   
>   static int idxd_probe(struct idxd_device *idxd)
> @@ -535,8 +577,9 @@ static int idxd_probe(struct idxd_device *idxd)
>   		} else {
>   			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
>   
> -			if (idxd_enable_system_pasid(idxd))
> -				dev_warn(dev, "No in-kernel DMA with PASID.\n");
> +			rc = idxd_enable_system_pasid(idxd);
> +			if (rc)
> +				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
>   			else
>   				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>   		}
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 18cd8151dee0..c5561c00a503 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -944,13 +944,6 @@ static ssize_t wq_name_store(struct device *dev,
>   	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
>   		return -EINVAL;
>   
> -	/*
> -	 * This is temporarily placed here until we have SVM support for
> -	 * dmaengine.
> -	 */
> -	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
> -		return -EOPNOTSUPP;
> -
>   	input = kstrndup(buf, count, GFP_KERNEL);
>   	if (!input)
>   		return -ENOMEM;

Thanks.

-Fenghua
