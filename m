Return-Path: <dmaengine+bounces-2795-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F9947E58
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81AC280988
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE489155743;
	Mon,  5 Aug 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dElN2tmZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0292E3E5;
	Mon,  5 Aug 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872427; cv=none; b=BxruzZ8gHE8+h1tDZ2aPKqA10XBooDMe4K9UafDHvH7o0VqIUy8J/WnumJdGtH2wvxuFzvv4Go8/yi9b6pfHQOdE7khHpzHxrfewgLnecjhwQW7SD0Hl9KkDRgExpWmnEddukPsMBMjm4X+fvM/StLu/+TR1UyBebYKMrk4reIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872427; c=relaxed/simple;
	bh=ke4iNq0W8AS/IfPvCncb9N64BUn7bmtEWe8JskxEy58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmVFton/cmUpxdVbI7evzUDRMv9AFzju6FgijCgh6GOAoW9NI17KMGcHn5F4O9Co8vfwRhZ7ugVH/kVYb5mH//hXNe713dMRPDP0oVxhYo6w6arZzxqnIU9inBz5mLOyRJHOj7PuD6u8mgwCjmdPgOzyjodOeP7XCGH16VeA/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dElN2tmZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722872425; x=1754408425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ke4iNq0W8AS/IfPvCncb9N64BUn7bmtEWe8JskxEy58=;
  b=dElN2tmZfMbbb7CScTH7zwrC2iap4nt1Y8vifOSJIOzWBzuHC1XtJyTM
   rE8i0ErewDxGmNhbB2HgIhlTHNX+vy0VX0IGDlYlb5usaThZMRd05wqKu
   AY0JEoSKC9cW2Sv8NVpB2Kw6synsfPwL66NZtgjH5ZWlJeCulLayEbvHz
   mKhFhgXPrcxG28wxkY3HSnbFmOE8cbCvAlz2mZmQAmEgHc90/EAWT2FgI
   2HR0ekNLXDIEcWtgNV5bOuAfUvHOYha00P0NSm0BhMk1O90aruJwYbh7y
   1jKxl/CEFf3sR/9tpAfnarpwQo/XNmmdMXVfk6I4xzthNe/gphUGChkuC
   w==;
X-CSE-ConnectionGUID: fYyWKpPPR2O3A/hNJ8FIqA==
X-CSE-MsgGUID: kmCjGVFjRlefA4xOByV0gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20698573"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20698573"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 08:40:25 -0700
X-CSE-ConnectionGUID: JJc4dSmZRMiFXQOP3SoJCQ==
X-CSE-MsgGUID: uQ774wfgTE+ZqtFGE5UTGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="86781647"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.223]) ([10.125.110.223])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 08:40:24 -0700
Message-ID: <d6ff1070-4f60-4699-bdc4-11bd72249d96@intel.com>
Date: Mon, 5 Aug 2024 08:40:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dmaengine: idxd: Clean up cpumask and hotplug for
 perfmon
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, "Zanussi, Tom" <tom.zanussi@intel.com>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-6-kan.liang@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240802151643.1691631-6-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/2/24 8:16 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The idxd PMU is system-wide scope, which is supported by the generic
> perf_event subsystem now.
> 
> Set the scope for the idxd PMU and remove all the cpumask and hotplug
> codes.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Cc: Tom Zanussi <tom.zanussi@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/idxd.h    |  7 ---
>  drivers/dma/idxd/init.c    |  3 --
>  drivers/dma/idxd/perfmon.c | 98 +-------------------------------------
>  3 files changed, 1 insertion(+), 107 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 868b724a3b75..d84e21daa991 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -124,7 +124,6 @@ struct idxd_pmu {
>  
>  	struct pmu pmu;
>  	char name[IDXD_NAME_SIZE];
> -	int cpu;
>  
>  	int n_counters;
>  	int counter_width;
> @@ -135,8 +134,6 @@ struct idxd_pmu {
>  
>  	unsigned long supported_filters;
>  	int n_filters;
> -
> -	struct hlist_node cpuhp_node;
>  };
>  
>  #define IDXD_MAX_PRIORITY	0xf
> @@ -803,14 +800,10 @@ void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
>  int perfmon_pmu_init(struct idxd_device *idxd);
>  void perfmon_pmu_remove(struct idxd_device *idxd);
>  void perfmon_counter_overflow(struct idxd_device *idxd);
> -void perfmon_init(void);
> -void perfmon_exit(void);
>  #else
>  static inline int perfmon_pmu_init(struct idxd_device *idxd) { return 0; }
>  static inline void perfmon_pmu_remove(struct idxd_device *idxd) {}
>  static inline void perfmon_counter_overflow(struct idxd_device *idxd) {}
> -static inline void perfmon_init(void) {}
> -static inline void perfmon_exit(void) {}
>  #endif
>  
>  /* debugfs */
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 21f6905b554d..5725ea82c409 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -878,8 +878,6 @@ static int __init idxd_init_module(void)
>  	else
>  		support_enqcmd = true;
>  
> -	perfmon_init();
> -
>  	err = idxd_driver_register(&idxd_drv);
>  	if (err < 0)
>  		goto err_idxd_driver_register;
> @@ -928,7 +926,6 @@ static void __exit idxd_exit_module(void)
>  	idxd_driver_unregister(&idxd_drv);
>  	pci_unregister_driver(&idxd_pci_driver);
>  	idxd_cdev_remove();
> -	perfmon_exit();
>  	idxd_remove_debugfs();
>  }
>  module_exit(idxd_exit_module);
> diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
> index 5e94247e1ea7..f511cf15845b 100644
> --- a/drivers/dma/idxd/perfmon.c
> +++ b/drivers/dma/idxd/perfmon.c
> @@ -6,29 +6,6 @@
>  #include "idxd.h"
>  #include "perfmon.h"
>  
> -static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> -			    char *buf);
> -
> -static cpumask_t		perfmon_dsa_cpu_mask;
> -static bool			cpuhp_set_up;
> -static enum cpuhp_state		cpuhp_slot;
> -
> -/*
> - * perf userspace reads this attribute to determine which cpus to open
> - * counters on.  It's connected to perfmon_dsa_cpu_mask, which is
> - * maintained by the cpu hotplug handlers.
> - */
> -static DEVICE_ATTR_RO(cpumask);
> -
> -static struct attribute *perfmon_cpumask_attrs[] = {
> -	&dev_attr_cpumask.attr,
> -	NULL,
> -};
> -
> -static struct attribute_group cpumask_attr_group = {
> -	.attrs = perfmon_cpumask_attrs,
> -};
> -
>  /*
>   * These attributes specify the bits in the config word that the perf
>   * syscall uses to pass the event ids and categories to perfmon.
> @@ -67,16 +44,9 @@ static struct attribute_group perfmon_format_attr_group = {
>  
>  static const struct attribute_group *perfmon_attr_groups[] = {
>  	&perfmon_format_attr_group,
> -	&cpumask_attr_group,
>  	NULL,
>  };
>  
> -static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> -			    char *buf)
> -{
> -	return cpumap_print_to_pagebuf(true, buf, &perfmon_dsa_cpu_mask);
> -}
> -
>  static bool is_idxd_event(struct idxd_pmu *idxd_pmu, struct perf_event *event)
>  {
>  	return &idxd_pmu->pmu == event->pmu;
> @@ -217,7 +187,6 @@ static int perfmon_pmu_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	event->hw.event_base = ioread64(PERFMON_TABLE_OFFSET(idxd));
> -	event->cpu = idxd->idxd_pmu->cpu;
>  	event->hw.config = event->attr.config;
>  
>  	if (event->group_leader != event)
> @@ -488,6 +457,7 @@ static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
>  	idxd_pmu->pmu.stop		= perfmon_pmu_event_stop;
>  	idxd_pmu->pmu.read		= perfmon_pmu_event_update;
>  	idxd_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
> +	idxd_pmu->pmu.scope		= PERF_PMU_SCOPE_SYS_WIDE;
>  	idxd_pmu->pmu.module		= THIS_MODULE;
>  }
>  
> @@ -496,59 +466,17 @@ void perfmon_pmu_remove(struct idxd_device *idxd)
>  	if (!idxd->idxd_pmu)
>  		return;
>  
> -	cpuhp_state_remove_instance(cpuhp_slot, &idxd->idxd_pmu->cpuhp_node);
>  	perf_pmu_unregister(&idxd->idxd_pmu->pmu);
>  	kfree(idxd->idxd_pmu);
>  	idxd->idxd_pmu = NULL;
>  }
>  
> -static int perf_event_cpu_online(unsigned int cpu, struct hlist_node *node)
> -{
> -	struct idxd_pmu *idxd_pmu;
> -
> -	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
> -
> -	/* select the first online CPU as the designated reader */
> -	if (cpumask_empty(&perfmon_dsa_cpu_mask)) {
> -		cpumask_set_cpu(cpu, &perfmon_dsa_cpu_mask);
> -		idxd_pmu->cpu = cpu;
> -	}
> -
> -	return 0;
> -}
> -
> -static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
> -{
> -	struct idxd_pmu *idxd_pmu;
> -	unsigned int target;
> -
> -	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
> -
> -	if (!cpumask_test_and_clear_cpu(cpu, &perfmon_dsa_cpu_mask))
> -		return 0;
> -
> -	target = cpumask_any_but(cpu_online_mask, cpu);
> -	/* migrate events if there is a valid target */
> -	if (target < nr_cpu_ids) {
> -		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
> -		perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
> -	}
> -
> -	return 0;
> -}
> -
>  int perfmon_pmu_init(struct idxd_device *idxd)
>  {
>  	union idxd_perfcap perfcap;
>  	struct idxd_pmu *idxd_pmu;
>  	int rc = -ENODEV;
>  
> -	/*
> -	 * perfmon module initialization failed, nothing to do
> -	 */
> -	if (!cpuhp_set_up)
> -		return -ENODEV;
> -
>  	/*
>  	 * If perfmon_offset or num_counters is 0, it means perfmon is
>  	 * not supported on this hardware.
> @@ -624,11 +552,6 @@ int perfmon_pmu_init(struct idxd_device *idxd)
>  	if (rc)
>  		goto free;
>  
> -	rc = cpuhp_state_add_instance(cpuhp_slot, &idxd_pmu->cpuhp_node);
> -	if (rc) {
> -		perf_pmu_unregister(&idxd->idxd_pmu->pmu);
> -		goto free;
> -	}
>  out:
>  	return rc;
>  free:
> @@ -637,22 +560,3 @@ int perfmon_pmu_init(struct idxd_device *idxd)
>  
>  	goto out;
>  }
> -
> -void __init perfmon_init(void)
> -{
> -	int rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> -					 "driver/dma/idxd/perf:online",
> -					 perf_event_cpu_online,
> -					 perf_event_cpu_offline);
> -	if (WARN_ON(rc < 0))
> -		return;
> -
> -	cpuhp_slot = rc;
> -	cpuhp_set_up = true;
> -}
> -
> -void __exit perfmon_exit(void)
> -{
> -	if (cpuhp_set_up)
> -		cpuhp_remove_multi_state(cpuhp_slot);
> -}

