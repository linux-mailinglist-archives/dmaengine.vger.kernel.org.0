Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC1366B28
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhDUMvN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 08:51:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:57114 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbhDUMvM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 08:51:12 -0400
IronPort-SDR: ADrPJY77JTT6OTXLjFtj6DEc/Wm1l4mfgx5hVsrn9OVIeSyXrh4P4vLKeBAPvo2wCtGIOe4nG+
 /Nbe4Ko5p8bw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="216330980"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="216330980"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 05:50:39 -0700
IronPort-SDR: 4PRdwROv/b2zd1YieZy/TR5IupqTRDY8kDcpgupKd5E33kwM+y+qLDBsVIFWYrCHNPDjcnHtr9
 /fJu/Qsvf6uQ==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="602888932"
Received: from pdhumal-mobl.amr.corp.intel.com (HELO [10.212.81.216]) ([10.212.81.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 05:50:38 -0700
Subject: Re: [PATCH v2 1/1] dmaengine: idxd: Add IDXD performance monitor
 support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <cover.1617467772.git.zanussi@kernel.org>
 <d38a8b3a5d087f1df918fa98627938ef0c898208.1617467772.git.zanussi@kernel.org>
 <YH623ULPRbdi1ker@vkoul-mobl.Dlink>
 <34f61cc9-a6d6-e5a3-5f8c-6ffae8858cce@linux.intel.com>
 <YH+/qyUVtlHwWQJ/@vkoul-mobl.Dlink>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <410134d7-5a4d-3537-e9cc-c4c8e7068cde@linux.intel.com>
Date:   Wed, 21 Apr 2021 07:50:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH+/qyUVtlHwWQJ/@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 4/21/2021 1:01 AM, Vinod Koul wrote:
> On 20-04-21, 09:13, Zanussi, Tom wrote:
>> Hi Vinod,
>>
>> On 4/20/2021 6:11 AM, Vinod Koul wrote:
>>> On 03-04-21, 11:45, Tom Zanussi wrote:
>>>
>>>> +config INTEL_IDXD_PERFMON
>>>> +	bool "Intel Data Accelerators performance monitor support"
>>>> +	depends on INTEL_IDXD
>>>> +	default y
>>>
>>> default y..?
>>
>> Will change to n.
> 
> That is the default, you may drop this line
> 

OK, will do.

>>
>>>
>>>>    /* IDXD software descriptor */
>>>> @@ -369,4 +399,19 @@ int idxd_cdev_get_major(struct idxd_device *idxd);
>>>>    int idxd_wq_add_cdev(struct idxd_wq *wq);
>>>>    void idxd_wq_del_cdev(struct idxd_wq *wq);
>>>> +/* perfmon */
>>>> +#ifdef CONFIG_INTEL_IDXD_PERFMON
>>>
>>> maybe use IS_ENABLED()
> 
> ?
> 

Yes, I'll change to this.

>>>
>>>> @@ -556,6 +562,8 @@ static int __init idxd_init_module(void)
>>>>    	for (i = 0; i < IDXD_TYPE_MAX; i++)
>>>>    		idr_init(&idxd_idrs[i]);
>>>> +	perfmon_init();
>>>> +
>>>>    	err = idxd_register_bus_type();
>>>>    	if (err < 0)
>>>>    		return err;
>>>> @@ -589,5 +597,6 @@ static void __exit idxd_exit_module(void)
>>>>    	pci_unregister_driver(&idxd_pci_driver);
>>>>    	idxd_cdev_remove();
>>>>    	idxd_unregister_bus_type();
>>>> +	perfmon_exit();
>>>
>>> Ideally would make sense to add perfmon module first and then add use in
>>> idxd..
>>>
>>
>> OK, I'll separate this out into a separate patch.
>>
>>>> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>>>> +			    char *buf);
>>>> +
>>>> +static cpumask_t		perfmon_dsa_cpu_mask;
>>>> +static bool			cpuhp_set_up;
>>>> +static enum cpuhp_state		cpuhp_slot;
>>>> +
>>>> +static DEVICE_ATTR_RO(cpumask);
>>>
>>> Pls document these new attributes added
> 
> ?
> 

Yes, I'll add comments to all the attributes (also I'm assuming they don't need to be documented elsewhere).

>>>
>>>> +static int perfmon_collect_events(struct idxd_pmu *idxd_pmu,
>>>> +				  struct perf_event *leader,
>>>> +				  bool dogrp)
>>>
>>> dogrp..?
>>>
>>
>> Yeah, bad name, first thought on seeing it is always 'dog'. ;-)
> 
> Yep, that was my first read as well... i guess it would be better as
> do_grp
> 

Yep, will make change it to that.

Thanks,

Tom
