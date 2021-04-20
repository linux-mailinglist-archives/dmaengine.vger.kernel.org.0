Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F9365AF9
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhDTOOB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 10:14:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:29082 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhDTON4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 10:13:56 -0400
IronPort-SDR: Pyxp6PNjtCgSNtiqZtcR4wLkCuaJFhfqO6hTcpvtrTOyLWZblFIbKIHGO8Gm4yjgeO/s0AbR+U
 Aiydp4Cog+Ig==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="183004607"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="183004607"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:13:24 -0700
IronPort-SDR: wVhe9D9C3sL+Fo+bq+sz/h1SzlHMLQeggp2w3L00OeEnhRGPQOlN2pwuXVVvxx9Y792+GWJZry
 hQ+x8jZNcNvA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="534511460"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.209.163.59]) ([10.209.163.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 07:13:21 -0700
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
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <34f61cc9-a6d6-e5a3-5f8c-6ffae8858cce@linux.intel.com>
Date:   Tue, 20 Apr 2021 09:13:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH623ULPRbdi1ker@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 4/20/2021 6:11 AM, Vinod Koul wrote:
> On 03-04-21, 11:45, Tom Zanussi wrote:
> 
>> +config INTEL_IDXD_PERFMON
>> +	bool "Intel Data Accelerators performance monitor support"
>> +	depends on INTEL_IDXD
>> +	default y
> 
> default y..?

Will change to n.

> 
>>   /* IDXD software descriptor */
>> @@ -369,4 +399,19 @@ int idxd_cdev_get_major(struct idxd_device *idxd);
>>   int idxd_wq_add_cdev(struct idxd_wq *wq);
>>   void idxd_wq_del_cdev(struct idxd_wq *wq);
>>   
>> +/* perfmon */
>> +#ifdef CONFIG_INTEL_IDXD_PERFMON
> 
> maybe use IS_ENABLED()
> 
>> @@ -556,6 +562,8 @@ static int __init idxd_init_module(void)
>>   	for (i = 0; i < IDXD_TYPE_MAX; i++)
>>   		idr_init(&idxd_idrs[i]);
>>   
>> +	perfmon_init();
>> +
>>   	err = idxd_register_bus_type();
>>   	if (err < 0)
>>   		return err;
>> @@ -589,5 +597,6 @@ static void __exit idxd_exit_module(void)
>>   	pci_unregister_driver(&idxd_pci_driver);
>>   	idxd_cdev_remove();
>>   	idxd_unregister_bus_type();
>> +	perfmon_exit();
> 
> Ideally would make sense to add perfmon module first and then add use in
> idxd..
> 

OK, I'll separate this out into a separate patch.

>> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf);
>> +
>> +static cpumask_t		perfmon_dsa_cpu_mask;
>> +static bool			cpuhp_set_up;
>> +static enum cpuhp_state		cpuhp_slot;
>> +
>> +static DEVICE_ATTR_RO(cpumask);
> 
> Pls document these new attributes added
> 
>> +static int perfmon_collect_events(struct idxd_pmu *idxd_pmu,
>> +				  struct perf_event *leader,
>> +				  bool dogrp)
> 
> dogrp..?
> 

Yeah, bad name, first thought on seeing it is always 'dog'. ;-)

>> +static int perfmon_validate_group(struct idxd_pmu *pmu,
>> +				  struct perf_event *event)
>> +{
>> +	struct perf_event *leader = event->group_leader;
>> +	struct idxd_pmu *fake_pmu;
>> +	int i, ret = 0, n;
>> +
>> +	fake_pmu = kzalloc(sizeof(*fake_pmu), GFP_KERNEL);
>> +	if (!fake_pmu)
>> +		return -ENOMEM;
>> +
>> +	fake_pmu->pmu.name = pmu->pmu.name;
>> +	fake_pmu->n_counters = pmu->n_counters;
>> +
>> +	n = perfmon_collect_events(fake_pmu, leader, true);
>> +	if (n < 0) {
>> +		ret = n;
>> +		goto out;
>> +	}
>> +
>> +	fake_pmu->n_events = n;
>> +	n = perfmon_collect_events(fake_pmu, event, false);
>> +	if (n < 0) {
>> +		ret = n;
>> +		goto out;
>> +	}
>> +
>> +	fake_pmu->n_events = n;
>> +
>> +	for (i = 0; i < n; i++) {
>> +		int idx;
> 
> lets move it to top of the function please
> 
>> +static inline u64 perfmon_pmu_read_counter(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct idxd_device *idxd;
>> +	int cntr = hwc->idx;
>> +	u64 cntrdata;
>> +
>> +	idxd = event_to_idxd(event);
>> +
>> +	cntrdata = ioread64(CNTRDATA_REG(idxd, cntr));
>> +
>> +	return cntrdata;
> 
> return ioread64() ?
> 

Yeah, I removed some intervening code and didn't change this, will do.

Thanks for reviewing this,

Tom
