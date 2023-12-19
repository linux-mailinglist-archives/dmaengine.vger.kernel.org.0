Return-Path: <dmaengine+bounces-586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4A81905C
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 20:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEB41F255BD
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E238DE6;
	Tue, 19 Dec 2023 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhYzyVPk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D938DEE;
	Tue, 19 Dec 2023 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703012963; x=1734548963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JENGzOD4kFnNWV7tfoD4dictDkFT45c4jg3h7T8+rxs=;
  b=nhYzyVPki0f+RsDn2NI8v3urgwyT/H/bw5qxb+QOTwPMAEvkS8gPWp8b
   OhB5g1xsOiAf9HGSYX+GsYvMeKSIIRUmzJT54TBWNOs54+mD66waM+ti8
   ptF7CssFmflkfxMsERc5Unlh1raNXAUE7rs2aC0NKs5XLdv8TL/e0vF1Y
   S+S4LjYZTlZ40I07zL22bcwgyMRtHu7LF3zgjjui2fUkN40xhOcKUxdBn
   ZjZWj4YHXWTX58L8qz/ut9Gyrz/g0Jaled37W6xgjkA4sKS44DyBiix1E
   rp7DWtAfem09r4NIV2ui6CRtPayENgdW9UK0ycEY4iUfQz0GBcHyveE6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="398495051"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="398495051"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="17973445"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 11:09:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 11:09:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 11:09:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 11:09:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 11:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXG/KsY9wC8sJJNMoxm1rQmsDEY6Bg1eJWJuEWYVPyFKw7qaycpbabbFkFZRlMOH2MDLmXf7Jnj4Cix1fQluv+J5vm7wvWJ5AeQ4Tgmv2b3/+li5srvbS4IrM0SOu2b6kYN3Lin5PJQdCfYut21lytgBg9c14+Xy1qiGcV3+N+moxqOYwD5ok6fiWTNAxizG+DFq4EEYpY1KcQeSqTzj33dEH7HTzVjK9KrDqBEl2vBC0y3fu5G4XSWVWg8t0qqJHm5j0RW4x5ND+VmN/pBLEhOa9hzMhX/uCkKp8hF6a6lr8UuyQKGgYDJMEcmOQ+6cuMBDZ+TC9ScM+s+DC1qfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxQZHQAoq5lpyd0XDH8BTckv3hI0QQBVCKqc70+Oj1Y=;
 b=eYiDw22LM/VOuTM6OmbdjKMSd2ydPNZnSCdtomwY5HV2FVnQFMcTzMggLOuAd/lgyVImzCmtQ/adfDsG//AJXOWtL14adxLuuv4wIEB+sig2Widu9Fltt4Ubi+ebA8R1oIsdr996DoZK3ltaU8TbjpPSKJOaA2zdy3t5v/Y12j1XoxSGDiwRobIKuDYCnxTBVnulZcTQRWSGd4rai7MKXi+dDc0FDYF5BaJKMZSYNAH5ysGKy1M5DHt25Jhllm8f4JZv4Owtp73Gajbj37l4KpurU2PEgUrSqrW+beNx+vwqgdzIfu+/2p48X9iYNkz3AUNSbq2ULYhhqp+gIqXHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 19:09:14 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::54ee:7125:d8a8:b915%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 19:09:14 +0000
Message-ID: <b5d4f9f5-e040-9668-fbbf-dd7b32da9fdb@intel.com>
Date: Tue, 19 Dec 2023 11:09:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: idxd: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dave Jiang
	<dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
References: <a899125f42c12fa782a881d341d147519cbb4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <a899125f42c12fa782a881d341d147519cbb4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: a479fbde-55ff-4fd4-db9d-08dc00c5fd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0fq/ur4eB2HNv79eTYXQwRebO+6XvpdlCXksy8Dk4aYSBY31GstmebqodjQNxsw+xgtYjBu4ievPIutiqF0Ky/aEVVmmhHFYAR0hO9JPDwI1QlMpEMdQnYOOiCiWjBlmAxRw5rGvPaGRU/20TSJw7uwZ5hedu1BT3Cbt7mO8IGPm0/weeaQMBZVUhB1Mr4VseQeQcyDCADAUat0IWiuGj3esLZelnjjzZC9qdtW7XLCgxAGz6GhzpWFwMAOBfMMegnstQ5ZF6CWWnbSlH/gfRl+HbIWkmK4kgN2Dn2cj3aCb97QRU/tVBQaVJZ4SeYKpQ3KTnCS1i4hMK5LBCj3F3cX9v3UnGOhi7/Go7Vz9MrseDIFZcRSnEBdyQkI6xWrygX87GeuxkPxaeOXp0BJDydIhm6xumquv1BQh0SvfnHk1UjyQf4qAZ24v1EQ9K4+eWS4Cn97EJof4WV/fQkvC2McACa6OkFgEfvuc1fFIkEqcVH5pOLQ+61MnCcVK+q7nbvCmIAdxdcXMs6WxgamA0ZjVGxLZqxBTpag1DniypLM9LZEIPrJwjcP55qSC4NVrXQkvCs7nqOUzQehMsZmquUvTvmHOnS3Vqdo6d40Xw4oLpm9X2qAPX7ZCQcZDBH9QjwCOWzzyIOaU6m7tpreyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(110136005)(66556008)(83380400001)(2616005)(316002)(66476007)(53546011)(38100700002)(478600001)(6486002)(26005)(44832011)(4326008)(8676002)(8936002)(6506007)(31686004)(6512007)(6666004)(5660300002)(2906002)(86362001)(82960400001)(31696002)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJKMmxjN1hUc0tHdzZMNGRYeGNncDkza0FGN3BHV1cyM0NHN0UvMUwvd1gv?=
 =?utf-8?B?VExoRmZJU2d4MU9udDM5VHp2YitPeWd6blZnSjVyb3NneXBteWhFR0FKQTI2?=
 =?utf-8?B?YVNtS29nMCtGWW5BWk1VQVZBRyttdmYrUEoxRXJQOUdIaWhlbjdSUnJNT05z?=
 =?utf-8?B?aTJQOVQzSGhkcGl6d3hrY2x5bmlJZDA1NHEzcGdCWGpvNU9raDZvUzA0YXBP?=
 =?utf-8?B?c1BpZVVieFF5UUVwVTdWa0lZeDZmeWgvTlFFYXFpT0ZoNjRXWFYxeVZhT0Nt?=
 =?utf-8?B?aTZSZzJQNjBQV0czdnFBdTgzQUtFSHdPQ1k5YWoxSysrMjc2QWRsZFc4YXhi?=
 =?utf-8?B?anFkWmpSYmpqSDRBbEt3eXEvQXBhVFVkYjduQ1dHQ2tLMEZpQ3ZmWEE1UW0y?=
 =?utf-8?B?eXg0dVg4N0xKR01ubWdVdGNxVVVYNkhVblZVMWFueG82S1pUSUlobmdBRjVi?=
 =?utf-8?B?R3o1T2hiaUY1TmY5elEvS0gvSGd3ZzhSSUgzTkpwcDFDT1JXdnp3b0EwUDJh?=
 =?utf-8?B?c0RNTzR1TnRBcldFMVFZbitCeEZQdkFMQ3hkTDhmREY5blNXa3oxTkJURTJs?=
 =?utf-8?B?Z2RpR2lueWpRM1ZNa1YwTURnbWVoZFVmVVRQeGY3Z3kvNTVmWTV6RzZmdlJZ?=
 =?utf-8?B?VTZjNmh6cHpDditVRXdrQlJOWGVpZENRSkhzR0V5SVRycGJHRVpSK0dOR0ZH?=
 =?utf-8?B?MG1iOWYza2hJSTB1S2lCU3pDOEMvdXhyNDkzNWpSTE9jZ3IwbDlmZm00Rjh5?=
 =?utf-8?B?QzVjQXJkdkp0eWVzMWJPV3UwWjlhYzlrSG5xUW55UXh5b2NzaTRUMyt6Tktj?=
 =?utf-8?B?NzVXS2ljdVZNbktOa3ZXU08vSjNpdjY5TFRuekpYaGxocUtsd0ZSM0xqMHRq?=
 =?utf-8?B?bUt4RFJ3S1pHTTc5U3pSVFRqOEVIS29OMVEyeUFLeVhrR1lORnBnZk1xRnFG?=
 =?utf-8?B?OXZGa3BkMU1XWXNDdGV5ZUxUMEpucjhkRFhiUkJsT3FHem1Ra0lrcE5ZNVRx?=
 =?utf-8?B?RUR6UjdEMHdZUEhrbWd4TG9EVnVmUXhnNnlWb2dhZitZaklXSzJUTmVTYVls?=
 =?utf-8?B?SUpvWnE3RzZ2UWFHaWdUcEFQdHVNdjkxbVpyUFZXakJOY0VXb0tzWTdzclNv?=
 =?utf-8?B?ZzFORlcvbXpiZUtleUNTdHlHV3hNa0tWRFJoY2MwT0ZLMEZpeWQ5RzZuTW1i?=
 =?utf-8?B?QnZJUm9pbXpTcFRCV1lNeVVnalVUWUttWHJWRGwyc1A3SFAzTEhpNkQ3Ujky?=
 =?utf-8?B?YnJIaTc2VitqbWE1OFliL2xRU3lDeW9qV09pQ3FjYVNxOVpkV05hRHhla3Fy?=
 =?utf-8?B?NzdzSUtUczNUcTlqd1I5RVdDR29MQlRkTXFqdDVzK3VxZVhlVTE1end5Znpy?=
 =?utf-8?B?WnBNT01OcmdTM0dwZ3JTSXJaNXBFZ2FBNHIxbkk1VkVKVFFhc0xrWC9HSmFM?=
 =?utf-8?B?dHBydHdFYXQ5RStoZjNobUthSHV3VDhEVmkxaEdkRE9VNmtReVMxZURnS0cx?=
 =?utf-8?B?bXlVaTFLS281OHRrUkFVRmZXV3RvWHBMMUhvWE5vRk1GcGppWm1PbzZrQ0lU?=
 =?utf-8?B?aDhOVlNRZ3I3c2RyU1JDS3VJQ1FuZ29mRTlyTU4wbXh4RXgrZ1FnZDZLSS9H?=
 =?utf-8?B?MG5TUUE2cENtM2tvRWVHeG5KdEY2Tm1MNVJ0N1RreGxiS1pBKytaNW1NOXo1?=
 =?utf-8?B?SW1wZnVMNFNCNE02MmhIYVovQUxiVnFYTEJOendza0N2R1Q1ZEczZjVmaE9H?=
 =?utf-8?B?d2Z5OE5lUjBONk9KSkRSeG5PZG5IRUNYTVNLUDZ6UVZXd0NvVitoKzdWNTNI?=
 =?utf-8?B?R2hWNk9Nbzk4MWNxUlBiSmY5aXJmUjZUdVlnUWZqc0FwT0xKRzk5Qms2TkZa?=
 =?utf-8?B?bC9XZmtWQTk1UGY5RjFCMVZwZW11QnZ3YUlQWjFaTmU2N3hhWXZRbGdKVU5I?=
 =?utf-8?B?TEovVFJTYXpVWmx1enp2eXU0a0poUmhTUlh3amJpK1RrenZZSUN0M2ZyMHZO?=
 =?utf-8?B?Nk04TGk4RzNjRjIzVWkrTXljdTdzQThSZitTSDA1Y05UYTExdWtVV2xLV3I5?=
 =?utf-8?B?cWV1bVZsL09xa3E1R3UzRXBHbHhnL3E4dFBFOWNZWU15RCtOdUJlWnd4RzA4?=
 =?utf-8?Q?YcJ96bCW3P7QcGxdbylT0uG6s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a479fbde-55ff-4fd4-db9d-08dc00c5fd0a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 19:09:13.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vn3vF84gK3YuL3ddwItUcc+GmQja2kzeU7D8fucMc/vDCQn6LNEwLxbz32F5EginpHWHvMPlt7kXKoGVoG49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com



On 12/18/23 22:28, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So change this change allows one more

s/change this change/this change/

> device.
> 
> MINORMASK is	((1U << MINORBITS) - 1), so allowing MINORMASK as a maximum
Please remove the tab in "is	".

> value makes sense. It is also consistent with other "ida_.*MINORMASK" and
> "ida_*MINOR()" usages.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only, review with care for the upper bound change.

Tested on hw.

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
>   	if (minor < 0) {
>   		kfree(idxd_cdev);
>   		return minor;

Thanks.

-Fenghua

