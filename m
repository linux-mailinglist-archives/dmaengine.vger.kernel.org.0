Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B6365736
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDTLMA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 07:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhDTLMA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 07:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A23961354;
        Tue, 20 Apr 2021 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618917089;
        bh=BNW3MtqZ8adN3h4rDrUM0FUx8nm3g6xveqFpE6MpLT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6cwQmEMiqsPtZpZYvgil/xeEI1AHtTvR+BRd5BC+kiOusnWAHv4WejvSFlJ2PkpW
         QW8Yez6c8Hlwvp8WkEeOVSDJwUEwfYw8+ltM9pocZwZ+OLDesqPIlkhfvhu9vni/NE
         MFmJa0kQlFoyBekJK9qCdPp0TPZJukIWhr+Z7BUXPKgjN4mFkOHyTkD3OjaBqe82YQ
         1SufCIMMIu4FmAvZ0C0ETVM9mrFCYdU8HGXhqRA3p3FN2zoXSIOdQSEQIQCUx2yrZn
         wGw2oVv6JOWIZbbBhjigi63PoFp4QHU4uJFVhS+2SK2lbUvC6Ou72UwdKpOJVTlsO6
         u4WspBHPuVTlg==
Date:   Tue, 20 Apr 2021 16:41:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dmaengine: idxd: Add IDXD performance monitor
 support
Message-ID: <YH623ULPRbdi1ker@vkoul-mobl.Dlink>
References: <cover.1617467772.git.zanussi@kernel.org>
 <d38a8b3a5d087f1df918fa98627938ef0c898208.1617467772.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38a8b3a5d087f1df918fa98627938ef0c898208.1617467772.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-04-21, 11:45, Tom Zanussi wrote:

> +config INTEL_IDXD_PERFMON
> +	bool "Intel Data Accelerators performance monitor support"
> +	depends on INTEL_IDXD
> +	default y

default y..?

>  /* IDXD software descriptor */
> @@ -369,4 +399,19 @@ int idxd_cdev_get_major(struct idxd_device *idxd);
>  int idxd_wq_add_cdev(struct idxd_wq *wq);
>  void idxd_wq_del_cdev(struct idxd_wq *wq);
>  
> +/* perfmon */
> +#ifdef CONFIG_INTEL_IDXD_PERFMON

maybe use IS_ENABLED()

> @@ -556,6 +562,8 @@ static int __init idxd_init_module(void)
>  	for (i = 0; i < IDXD_TYPE_MAX; i++)
>  		idr_init(&idxd_idrs[i]);
>  
> +	perfmon_init();
> +
>  	err = idxd_register_bus_type();
>  	if (err < 0)
>  		return err;
> @@ -589,5 +597,6 @@ static void __exit idxd_exit_module(void)
>  	pci_unregister_driver(&idxd_pci_driver);
>  	idxd_cdev_remove();
>  	idxd_unregister_bus_type();
> +	perfmon_exit();

Ideally would make sense to add perfmon module first and then add use in
idxd..

> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf);
> +
> +static cpumask_t		perfmon_dsa_cpu_mask;
> +static bool			cpuhp_set_up;
> +static enum cpuhp_state		cpuhp_slot;
> +
> +static DEVICE_ATTR_RO(cpumask);

Pls document these new attributes added

> +static int perfmon_collect_events(struct idxd_pmu *idxd_pmu,
> +				  struct perf_event *leader,
> +				  bool dogrp)

dogrp..?

> +static int perfmon_validate_group(struct idxd_pmu *pmu,
> +				  struct perf_event *event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct idxd_pmu *fake_pmu;
> +	int i, ret = 0, n;
> +
> +	fake_pmu = kzalloc(sizeof(*fake_pmu), GFP_KERNEL);
> +	if (!fake_pmu)
> +		return -ENOMEM;
> +
> +	fake_pmu->pmu.name = pmu->pmu.name;
> +	fake_pmu->n_counters = pmu->n_counters;
> +
> +	n = perfmon_collect_events(fake_pmu, leader, true);
> +	if (n < 0) {
> +		ret = n;
> +		goto out;
> +	}
> +
> +	fake_pmu->n_events = n;
> +	n = perfmon_collect_events(fake_pmu, event, false);
> +	if (n < 0) {
> +		ret = n;
> +		goto out;
> +	}
> +
> +	fake_pmu->n_events = n;
> +
> +	for (i = 0; i < n; i++) {
> +		int idx;

lets move it to top of the function please

> +static inline u64 perfmon_pmu_read_counter(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct idxd_device *idxd;
> +	int cntr = hwc->idx;
> +	u64 cntrdata;
> +
> +	idxd = event_to_idxd(event);
> +
> +	cntrdata = ioread64(CNTRDATA_REG(idxd, cntr));
> +
> +	return cntrdata;

return ioread64() ?
-- 
~Vinod
