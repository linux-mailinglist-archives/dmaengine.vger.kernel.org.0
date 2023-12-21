Return-Path: <dmaengine+bounces-592-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B0881AC53
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 02:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E841C21DD7
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55217D9;
	Thu, 21 Dec 2023 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URTz49cX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B715AE;
	Thu, 21 Dec 2023 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703123407; x=1734659407;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f1/JxonBXdTW0UG2sQQEBD6FDwk5CX3xEKD3nFz5WHA=;
  b=URTz49cXqM4vnclYUR+HVpPP/D8WjH5fUUmU1MnPNgNhZdYdE00yCSeO
   UQtbyld/yPX9Yan7RB+Sg5tqausQyki0GXQ2e0OG6YN5jZLc2Ljb9Iz6P
   VUxHX4gmtnGBj32LU/kUmQNVDNSgSXMqlj9AK0nX6j1xflnzMHIeC1yPL
   KUWX/IqMoUzLjokWVF042IY08M/xsuBp6w4FRTtbJp7mJzN0+Rwn7lHhm
   w2RMeV9quiM6aF0XnBMprCX5MkhrYbzsgBbakEqb/fO4HKub+pvKrccHx
   KCQSzNhLCTL03sX495yU0vJUPRvwbfShDSb4Ph/RB2nzfA/1F2XMNrHOY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="386331517"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="386331517"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 17:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="18517327"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 17:49:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 17:49:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 17:49:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 17:49:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 17:49:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MD5/j9nsKtL5lbChuDrvL1oUU0w4kAMS35XfD/pJuHYcn8SOhyOEKmRVAilpZd1xZ9W6kH3x+cyD0JtIUbAHkohSMuYzlV/ZCQTSDIZQ3yV6Fuy3NNCV/AcSLoQOirTX0bmV8Bx9pW/Mw28BKzGSeGyVZZb5JTfqBu8f6hDUuvcVp41fztQ0VUk4FfJd37RTXt8MT6ahjz+QFAJI0/pRWCqRsiV1zeoKfiK0e3toE8ruC2wksnBf9bw8aD7yiGjMU25JZ8cjfIQVkcwxmMMv1PRo3uQ9x5HLV4/6ZleE6smpChpfrA8EFVqVjdhp81wvEMY1kyPLp4EJTwIwx762HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrhjUb6lS7rvI0axXVZ3+uziLdC3f0EgrWEjEGc37dQ=;
 b=WasWrSd32vqN5CKr1e7quGw9cUY8Rz+CaGaZFQKrXunr5xru32oEcxsm1vK3T8ezmQVdWoDytoyD+ZjLP4lRSZME7METMTxoErwl+DzBRvjXQWlLtsjpN/4GCBUlSvmDtNCJcXfdeyAhfIW+4U1pTgxV9ckQvY5PjttEcjzNQvY6Si9Fl//vVSCn2o0WJxbURSqX/aNp9JGK7PbV3h/lTr2CGmBMnbIW7MkcD/k4Z1DSjEkzlXCQHzIzr0R8cDhqGnfdWXZNVClX1erG67on99isHyS9yxj6bjlOPBFfsFhdrXGwAUm9hwWQdsWuekKGEx2UKQ7ikuydukknYGh+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 01:49:33 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::1726:b38f:26f9:26f7]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::1726:b38f:26f9:26f7%2]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 01:49:33 +0000
Message-ID: <77344325-a27d-4479-82e1-bae88e0e9e46@intel.com>
Date: Wed, 20 Dec 2023 19:49:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: idxd: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Fenghua Yu
	<fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Vinod Koul
	<vkoul@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
From: Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 24db4f17-fb68-4f4d-e8e0-08dc01c71488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjX0VZ1bIFyZ6JzlKzWfH3lHDjALdw6KT25LGvbbkpoomM9SLKKZRuklUYzagMWnRdKCRseL0+g5Vy0ED4ZtKn8WOGVUzm4/A3CJjEikbg/h5jkZWwGBqaTBt73hUKSHCJy2La7UPmk3V9PsaOIPtUJL6Aae7Y5ug8K0ChLVyeC7ImF09qDpC1n3dAWnuBYmAoQPCg5CgxMj0MSwjT5+UQo6DPPyiQMx+HxDTTejoUGNgwgT2Cc2cpwncItasrYQ8mAeVHlwcQir6fK+GnW4/IzbG2u+Em0n0oWcCxwDW6ckGptO1kCI6++Mva+lVqTLLo1EnoXMT7pWqJ6zOx92/YFljx6H8SpgJ/DIEzm6z8DMWZlAolISmM1cOdtrLzh/SpamCkaiFvItiUJ0n4KcM+jIYoiEHujN4bzBwusCV+TdGKJbGi8YH3Dd3SJ4LJWKsAlgVa1SOBzIZoSrn1/audYju3xPRNy2mAiVcl7Fl0yyce1pXG1QiFDrGxdNT3TBm7TJ9dCXzhHA1eUEjn+9zMP69+7ZVViu54zwodUVfzVkWX6wwumgHzGzwM9JbjKkU0G2Mw1tquAyfkUchLd/Nd71VHaS+9FJ2TAZi3/mtPwQNWstOz+pkhHhcriyMsLmYgtYoQZNjJEqoPbDHEXUDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(2616005)(6506007)(6512007)(6666004)(53546011)(83380400001)(5660300002)(4326008)(44832011)(8676002)(8936002)(41300700001)(66476007)(2906002)(966005)(6486002)(478600001)(316002)(110136005)(66946007)(66556008)(31696002)(82960400001)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajNleVpaME1qdm9ZTWZhQlJqM3NxOFpabnlrZjJxNldzRjZMcU54N2R3NWVT?=
 =?utf-8?B?VWVKUGMxVXM2RnUyaDhTN3E4M3B3Y1pRdHpZWEYwMHd1RG1NK28yZ2VZRVR3?=
 =?utf-8?B?U00wMVNKY1JXZUVSU3JOR1Nwcmg3Z0p1TDd0c3Vmc2lvQXdzL2NreDBFZ0xF?=
 =?utf-8?B?MERhYWlwTGlHQXgzZEtJbkNBeXp6SEREVU1LSkFsWW5HYUVFSEtTV2Q1eDUw?=
 =?utf-8?B?MDNZRjhyNmZDYXdva3FLQWtQTEVZQ0RoUTNzQXpLcHFsaU9hVENMU1dIWGpW?=
 =?utf-8?B?VFRQdGZEcDRRM1ZIVEFlOWVkcUlEdE1HTzR5LzJsTkt0ZXdIU0w5WWdudXpH?=
 =?utf-8?B?MllsNWQybFQ2Y25EUzcrNU1lUWdYb2hyN3BsSy9Fb2VRTDhtWHZsTnpuQUNl?=
 =?utf-8?B?YXliU2VhSlZVYk5ZSURtR3R4UFkydXBja0QxN0I5TjlLOEMvK2ZGbDZpaGpr?=
 =?utf-8?B?NzlWYWJxMzVlZjl2ZnFmWkc4ZzlJaWQ2ampPaWJBWldqK3JnTDBqODlORW1Y?=
 =?utf-8?B?cjNxdUptaTY0WjV4QkM0d21keXFXQnppeXg1ZWd4VjgyalJVNnQ1VGRMQlFz?=
 =?utf-8?B?VVdzME1kWHNIRmMrMTlKMmZHazZvak9qMng2SnJqT2pqYjltTWFLQ29QaEtp?=
 =?utf-8?B?S2ZPWFJQNnhubWs3enVhWFF3N2hKY1FuNnJUeVlURDdWUGdJUkNQVHQ2ZXA0?=
 =?utf-8?B?WmpWVFp2K2pRRHo2dVZLZk5Uemh5ZzNWeUFRRnJVUzdoQ2RpdC9pcFAyUUo1?=
 =?utf-8?B?b1hVWkQwc0NCd2JhM3RVcTVOZUxUV2x1V0JQOFpTVFBBdExQM2syYVB6R1lT?=
 =?utf-8?B?TURma2NlU2lENTZLbXl3Yjd2bVRQS2h0RXJ5bkYwUGJNaytnNGp1ZFpSSVVt?=
 =?utf-8?B?NzBWSkxZc3lVSTRwMmp5VG1XSDFscVpQTlQycGZlOXNLMDFXZmdicmlGdS9S?=
 =?utf-8?B?aHZOcSt6bFFCbE5RRXU3TlFQd0lzM0todCtTOGh3a045K1dGY3ZiMlQ1OTg1?=
 =?utf-8?B?Q0tEenRmakN6YXpCbkdBVisyZ0hlMUxKOFZNcUxrN1B1bFFvV2dnbXBmU2o1?=
 =?utf-8?B?dHUyUXBoUXJLMGpZT0tJVFdwRk92S0E4S1RsMVdvcDl0elMySWVIbEdiNkpi?=
 =?utf-8?B?SmY3K0hZNkR3Q2ROZU1MVzdIdCtmTkVteXNDS3F5RUNBb1JiWEJ3R2w5R0lV?=
 =?utf-8?B?T3FMQ3laa2pwMkFJU3RPbjJqVlYzZi82R3M2UmR5VUNsZS8ySUZhV3ZCclZp?=
 =?utf-8?B?K3grcEVwd28rNjQ2bm55QUxuWm5wenB2SzlYanpnaVIwVUwvZUE2NFpLZmJa?=
 =?utf-8?B?TjM5c1Q4VXJ5YjlnMjBHZjZsdUt3Q2pia1JVbGNLRWpZVm9XQVNWMjBZZkxQ?=
 =?utf-8?B?d2JrMkdRUVA2MnQvbU82K1F1eWVJN25YbkFxVERvd0huTTgyT1NyOFc3TitY?=
 =?utf-8?B?UnczaWVBaFVZL1RSOVVPMFBha2ZERlljUDhyOFMrSWYvaGx3emFWbE1ZMFNi?=
 =?utf-8?B?a3E4MnFjWGVKYUowNFpKL3FpZTUyTEtUV01JVXlFVWc2d2ZGVTdGMjduRHlY?=
 =?utf-8?B?TU1JNTlJRTVaKzBlZmszbnJzL1UrQVdOU2lObHkwR3FMa0NnOGlDQTZGV0l3?=
 =?utf-8?B?UGUrZnVxVzZ1dDA2WnZOTWhXcGNWeWM4RjJGS1M3Mmc3VnNpaWFsZGZmd0hS?=
 =?utf-8?B?ZzJFMHlyVXFKNnNWVUxxWnBpYmlObElzZERiUHBTU1ZFejVhbVF1WVBBdVhh?=
 =?utf-8?B?clNYb09nUlRUZmNQT0EwazY0cDR4WGN1Zk9sTzZiVkZZMHQ3bGVBNDQ1bHlj?=
 =?utf-8?B?RnRlOGgreDNEVFVyN3RTc0dqV0FJSkt2ZGo1dzg4STlpamtsblV1d3MvU3Jm?=
 =?utf-8?B?WGdlWkJ3S1o5ZE5oSHNQS25MT3hwQlNDR2lnSVNWK0prOHFKeUQ2V1poSmp5?=
 =?utf-8?B?L0F1OWljeFJ2cXJrR3EwM3E5SEFBbnR1R3ltOEVHeklLM25ST24zTmRacHFT?=
 =?utf-8?B?OWcxRVBuZ0Vpcm9sRkpUS2tnZWFoSi9IYTFCcHhFWDhOUDhOdFkyVDRGQzlY?=
 =?utf-8?B?WXZCZ0hrL05WQkJYS3J5dElZVnZTN3NnaCtQQThSN2pUWWZOTkhMd081cEpt?=
 =?utf-8?Q?BwABC0AOh7ITZaJvcnffkAMPu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24db4f17-fb68-4f4d-e8e0-08dc01c71488
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 01:49:33.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sBg0v6mTlTot7vCqjzX9XnsckuONQKqH3bhn6I9+9CeMho7OEmxFlYIEJRTO8TrYyLaHAD4Cwhzh79ewXqU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com



On 12/19/2023 1:33 PM, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. Sothis change allows one more device. >
> MINORMASK is ((1U << MINORBITS) - 1), so allowing MINORMASK as a maximum value
> makes sense. It is also consistent with other "ida_.*MINORMASK" and
> "ida_*MINOR()" usages.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Lijun Pan <lijun.pan@intel.com>


> Changes v2:
>    - remove note about compile tested only, now tested on hw by Fenghua Yu
>    - fix some wording in the commit description   [Fenghua Yu]
>    
> v1: https://lore.kernel.org/all/a899125f42c12fa782a881d341d147519cbb4a23.1702967302.git.christophe.jaillet@wanadoo.fr/
> ---
>   drivers/dma/idxd/cdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0423655f5a88..b00926abc69a 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -165,7 +165,7 @@ static void idxd_cdev_dev_release(struct device *dev)
>   	struct idxd_wq *wq = idxd_cdev->wq;
>   
>   	cdev_ctx = &ictx[wq->idxd->data->type];
> -	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
> +	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
>   	kfree(idxd_cdev);
>   }
>   
> @@ -463,7 +463,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
>   	cdev = &idxd_cdev->cdev;
>   	dev = cdev_dev(idxd_cdev);
>   	cdev_ctx = &ictx[wq->idxd->data->type];
> -	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
> +	minor = ida_alloc_max(&cdev_ctx->minor_ida, MINORMASK, GFP_KERNEL);

It shouldn't be an issue though it should be below statement if directly 
converting to ida_alloc_max
+	minor = ida_alloc_max(&cdev_ctx->minor_ida, MINORMASK - 1, GFP_KERNEL);

>   	if (minor < 0) {
>   		kfree(idxd_cdev);
>   		return minor;

