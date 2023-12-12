Return-Path: <dmaengine+bounces-502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD080F133
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD1281662
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAF76DBB;
	Tue, 12 Dec 2023 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyzN7c6V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72695
	for <dmaengine@vger.kernel.org>; Tue, 12 Dec 2023 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702395463; x=1733931463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4o73Gyac9+AelJkMDt/dx8dYGKA+gptL7B2bKUpB4DM=;
  b=cyzN7c6VyDQqkOo9dOdlvgmotPHkqs1MykGPsw5YTIWlJn3qPk+k8Ef2
   jIg8vquTkO4jpPD5tMZDy+AoK2MHNSQmvY9CkLAfcmPdL+Dzkt6Ls+aDd
   j+8xq4ehWfZWuGupd63Vlx2MDN3xlkyS+GgvMQG8BBT2KDw7Zml8dCFkK
   FF8NSy+K/lgRIeOm2yDJ3pvWKYlOLzPz3ws7c4m0t1tWgw2JfkZH36DvW
   YNVGKHlqbihFJzxgKCAI6uJqxd73TV4u3EnqmCDG8QGYTH/SzS1f7AT/P
   MjfIlM5bt+Pb6RZCbVQNXLyh2mKgl33QMnH3dzMS+JUH/p861ssxavcQE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459140442"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="459140442"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 07:37:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="766862481"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="766862481"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 07:37:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 07:37:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 07:37:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 07:37:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 07:37:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grRrg13g5EcOzhxDdKCaR09x6NbufzkZBi4JJx8rIomxcFJRP1R3XFbpdZ+3gXTi1hgn28drGMuu7uzf/dovHqLV4+Gxp0oKGLjruIlZF9ToJY2Z5IIwXaDJ5Am7MVEa70tcqCpR0YzDumhE4ekDnkEWk7yInagNvhHV7vrUrr1s3W0qRkx2Xk0GuuDbXCIc5jVjfWmtEjzigSLPn8oozGUyhGwzcYm4HPt+UByhqfsIS+fyrWcBwMIzTWISA470ih7JikDXmC95MMHhAeK4DswgGk78YN1q7RrjC4v/iBFCJ1qLos5ceAXv8Ay8EU4C+I03TovJB9TQP/CHAzvIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDTz2i2bSrqG6GKcB8GjAezI9Gr71SnNiQkmqu+fNFA=;
 b=nQMCdbwSXXXCSmc7JGMt0aFJCv4IAYvXmiwyJcmfABg5x70txM4psFjLOSpkXJhhok7l1g92lb1w2857w5AkpjONY+3lAB3SaaLoKbPfHAuLEWIeSfCQa8aVuPkMe5VTLHCHVDSVEqxZ8gr4QuWcvMTVtTIfZHL+f5Tthx5UTJzJcmieTqN1A2momm8gGkzK86zd5oZy2IGrtAgMETud9gCpp6xhAM8Kf6xq7L+OIu6eNAtrVkqI3Ac5PY9T4j0d/p12ZaT5yqJ7S07zEfsn3jXS1CX3ppf8gvutOwvINZTsbUWhx1IgwN2nujOkrHwjiIdBfXquGgSMYL7dT6+h2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 15:37:37 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::1726:b38f:26f9:26f7]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::1726:b38f:26f9:26f7%2]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 15:37:37 +0000
Message-ID: <2fdec011-695a-43fd-81d0-24aa7fee39da@intel.com>
Date: Tue, 12 Dec 2023 09:37:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Move dma_free_coherent() out of
 spinlocked context
To: Rex Zhang <rex.zhang@intel.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>
CC: <dave.jiang@intel.com>, <fenghua.yu@intel.com>
References: <20231212022158.358619-1-rex.zhang@intel.com>
Content-Language: en-US
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20231212022158.358619-1-rex.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::7) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 022a2806-96c0-4d0f-34b4-08dbfb284491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEexFEjOqfTTkGrXB6B+0hSTFM//dveNOj/3MXCB0q0UJR1gs/1u/o34LgZsJhdYki4jHCB3tHq0Le3F6T22q+YDj8TBbwqBpAS4xph9dfmKg04rWgm4Eau3wyGSpVuEVmFNtE9LllVq+ZFxeMZEMcXi55QMcXUR2/CEs+O/HCkZPgw/T3h/i7t/GtYeUtpe6mAP/vYpKxSzhaj5zISjZIhJWcZmtgmeQVnosazFkvpIRHwz1mVv4W0P+KfyixHLus8Ftgvf2MkcjyjW2H/uV23dkj5WCMynPtc+sXQzUeYmQhUpxykOiRTcx44auvPRtXV7tNej5f1XRvRGZr0MdA35HgPDOlnJfOq97vv48Cnr9Qpq1Yi9ENc1J4F+QZKyaAgYlEEDx0oYek6Kz+Kb/O+amkdgJXBjvHUVXlqHuUcT2tSXpfZP6Kr0kvLXq6E/R5bFhPuyMSvWOTTiiT2PnL0CJ8vjGJVQh+rOSmvQTMs0Z3YYcxoQ4QM/HLazSpmj5XQ8ARjupu9XZHj2/F1AvZLmSitm4C6avWVCHvMRDzTr/p+XVcC5Z7O9CqYCyRgQ7VKSSSdt0Ya1vX2dx2Nk+xvt1F9NwAFU0Z/HtWcBk84YKGFXnNE3oWB9I/f1XOZDxNdanGyo7IUnE2gM/3/mcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(38100700002)(26005)(2616005)(4326008)(8936002)(8676002)(107886003)(316002)(5660300002)(2906002)(44832011)(6486002)(478600001)(53546011)(41300700001)(6666004)(66476007)(66556008)(66946007)(6506007)(82960400001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU82N3JKbHpJMG5HNFd3RHJJb29FMWhVM2dmSGhOWHRnNjZVM1RaRnZnd2N5?=
 =?utf-8?B?U0lHNE0vSnRiTnYwQU1BdGdibFBuZEVWMVZ1SGpyZG5rSmNTVUpVcVZvbHBN?=
 =?utf-8?B?dXVMRldleHlmQ2w3ZTlpN3V4ejVaOGE0TFdnTHROWmZDYUlVcmlQckJtdUdS?=
 =?utf-8?B?L2IrbWgvOUFMYmtDS2FDeHNJb21EYmJYcUg1OEkrSUxiUW11cnlSVldGZXFT?=
 =?utf-8?B?Y0dJMkR5MTVnNW4wVTA3YU5Pc29qdmF0TlFVZUpTRFNYSm42NEtHRFV2MW9W?=
 =?utf-8?B?dUhDZlV3SSswOWNBdXp3bHpXbEg3dTVVSU85aWcrYytBenZvbWs3RWIyVEJQ?=
 =?utf-8?B?YytCaWFFSHRmYlcyOVRKNHE4KzBZMjN1MmRMK2VBMWZkenRKOVY5Q0c5VVdj?=
 =?utf-8?B?QnF5dmRqTmIreFhVSldKYmZnWHM3Sk9WY1dFK09wczAxdS9hM0M4YTJ1WkhZ?=
 =?utf-8?B?RnRiMkV5RmhmZmdUZkFJT2xxVkVOUkxqeC9UVnpXa054OUtrK0lBUVVZcWdN?=
 =?utf-8?B?TE5vSmNGbUZIVEh0ejN5SUhrbHVJc0FES2tiQ1ZPRjQwZ24xR1gxRGcyblRl?=
 =?utf-8?B?QmMwdk04VysxWjVaN1pudjgrV1hERnZPVEc0R2RXWHhpTis5YU9ySnlRYmx2?=
 =?utf-8?B?cW8rR3JSNWY3UC9CMy9YTjFtVENkaWxzQUdwcjJENjRqZnJaSk1SSWQ5MUVp?=
 =?utf-8?B?bi90TnNtNkppL0NKa0p6RnQ2Q05ma2tYaEhXU0lNTzlCNEdmc2tjZGthUnRZ?=
 =?utf-8?B?Qkd5OUdoM3hSc29MZ0VxZXpNMWp3enR3VTBDaW9YWmR5aXdnSTdHNmQ3MmVI?=
 =?utf-8?B?RzJVc1RjVmlLS3BnaGpiMjUxVlpVYW1xcGZqYmF0YmhkTUovSWJFRS9KdzVS?=
 =?utf-8?B?YnkyTjdlNjhsVDRnNmFWV3RvSlNDOWh3WmVJQi9tNFc3c3JGNitzeTZqbEty?=
 =?utf-8?B?R0tGTGF1elpBZVZ2bVhTWFZhLzdQM2p2V1BrVng4Rmwyb2xBaUQra21WVHVG?=
 =?utf-8?B?S041b2hSVnIvVmptSjVBdGh1WE5XakhJSURRWnpyNWwzY2tVajRqRGFBQTVs?=
 =?utf-8?B?UC9oWCtHMUFNdUNQQkowUzBtU2FyV2I1ZHBHRGVzdjY2VUpiSmd0Vzg3Rnh0?=
 =?utf-8?B?a3YxR2pzNzh6Ky9IVEtPalk3NFQ0NVRaaWVzM0MreldWcjBZZThYVGdhRnl4?=
 =?utf-8?B?cVFrYjhWQUJ5ME43V1NFM1lScm5YKzBpbHh5MG9nT2g3UmdBUm1lK0NLVVky?=
 =?utf-8?B?eUhJanpYdFcwWFBUK2RDOVlMZ2lEczJWYTZQbFBSNzZTMW1pVDB1elZXcmxh?=
 =?utf-8?B?R3VlM1BqdVZSZ2dIUC9WUnR2SlBJTmNWVW1CcFlhS3JVcVJ4Q25Sd3ROZlgv?=
 =?utf-8?B?eHY0bnBsODhZWjR5NFpDRElYUFNqSGQxWDJvNTlLUHhFL0pyZ2hjWEIwOGtS?=
 =?utf-8?B?V2I4RUZSUG1icjRIajk2NnJMSnUxYVlMUnY3NTZOWERyaTIvWG92SFpRb1hB?=
 =?utf-8?B?N09HVXp3ZHZlT05UVGh3SXhVMFhxWUhVN0hoYVhBeEtoK0pBbzgwcno3UkVn?=
 =?utf-8?B?REZwbHh3d0tTN1JzR1QxaS84Z3hqek5uOEI0bEpRemdvelY4Zmx2dnRudklj?=
 =?utf-8?B?ZnphV1M1VXF5YzB0R1c3VWxsTkU0VUxOa3lIZWVWTDhLMm9jeFNPSTB2NVY5?=
 =?utf-8?B?KzhkdVNmdGVkK3N5SDQxeHlyR2VUOVVyK1UwaDdVMzVVa29yanA4SzRJblV0?=
 =?utf-8?B?NDF6ZitlZngxcDNCb2Y1aUcvRGZocTNYbTZDSWd1amRHNGJCcS9OcVp1UUtL?=
 =?utf-8?B?NE9VaTVEUVovMFI3ajBqSzBWNGRibDc2OXlmaGx0YjFwS1Yxc2tDNCtjWEtC?=
 =?utf-8?B?VjlyeXB5YVE4amtNcjNmcm5QZTlpclZVOC9aZ3d5enA1ckhrZFpGMlJtK21F?=
 =?utf-8?B?T0NIQUFnWTJUUFhRcjVIQzVpYTZWY0UyTGxZNldldE9FbmdxcFN3amJBN1Ix?=
 =?utf-8?B?L1dTSjJxT3BZSkN5K1VPZkZOWXd5MXU5bnhURDFaN1pqTlJYbklyOWdsZEo0?=
 =?utf-8?B?Vk00KzZmc3Z0UUk0c01RNHloSWRENmpsa2o4TGdFNTJqTW1hREl0QXV5Z3FE?=
 =?utf-8?Q?p4cRt5O9OxIHh+sKdw8mXNo6A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 022a2806-96c0-4d0f-34b4-08dbfb284491
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:37:37.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Qtkvm/uG/ItOG33WtwHlGrZwWSMrBEewNVfYrRjRiDU4YV2Fy2BPKKNdHjJkZp5susYjpfpGAMypEcCBC0P4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com



On 12/11/2023 8:21 PM, Rex Zhang wrote:
> Task may be rescheduled within dma_free_coherent(). So dma_free_coherent()
> can't be called between spin_lock() and spin_unlock() to avoid Call Trace:
>      Call Trace:
>      <TASK>
>      dump_stack_lvl+0x37/0x50
>      __might_resched+0x16a/0x1c0
>      vunmap+0x2c/0x70
>      __iommu_dma_free+0x96/0x100
>      idxd_device_evl_free+0xd5/0x100 [idxd]
>      device_release_driver_internal+0x197/0x200
>      unbind_store+0xa1/0xb0
>      kernfs_fop_write_iter+0x120/0x1c0
>      vfs_write+0x2d3/0x400
>      ksys_write+0x63/0xe0
>      do_syscall_64+0x44/0xa0
>      entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> Move it out of the context.
> 
> Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
> Signed-off-by: Rex Zhang <rex.zhang@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> ---

Reviewed-by: Lijun Pan <lijun.pan@intel.com>

>   drivers/dma/idxd/device.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 8f754f922217..fa0f880beae6 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -802,6 +802,9 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
>   
>   static void idxd_device_evl_free(struct idxd_device *idxd)
>   {
> +	void *evl_log;
> +	unsigned int evl_log_size;
> +	dma_addr_t evl_dma;
>   	union gencfg_reg gencfg;
>   	union genctrl_reg genctrl;
>   	struct device *dev = &idxd->pdev->dev;
> @@ -822,11 +825,15 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
>   	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET);
>   	iowrite64(0, idxd->reg_base + IDXD_EVLCFG_OFFSET + 8);
>   
> -	dma_free_coherent(dev, evl->log_size, evl->log, evl->dma);
>   	bitmap_free(evl->bmap);
> +	evl_log = evl->log;
> +	evl_log_size = evl->log_size;
> +	evl_dma = evl->dma;
>   	evl->log = NULL;
>   	evl->size = IDXD_EVL_SIZE_MIN;
>   	spin_unlock(&evl->lock);
> +
> +	dma_free_coherent(dev, evl_log_size, evl_log, evl_dma);
>   }
>   
>   static void idxd_group_config_write(struct idxd_group *group)

