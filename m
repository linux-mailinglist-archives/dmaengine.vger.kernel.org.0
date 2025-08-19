Return-Path: <dmaengine+bounces-6063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C38B2C527
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189F8174EF3
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D18338F29;
	Tue, 19 Aug 2025 13:15:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3A2C11EC;
	Tue, 19 Aug 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609359; cv=none; b=mTbA7A4lvZXsFQVGRW5MLZreoRnaJtnQg+nXx//GA6IhyCnevxcYJL3bwj0sZ1DyoAlw7aPGqhD4BoNrijxyIqtgSUuPzBOkORlHWdzaksI1sQBlT3lo33fMT4cJkG5sPv0gLhGi/DjG/z49hkfUQlRr7WKmMu2mwtwY3OutH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609359; c=relaxed/simple;
	bh=TZO/KLYTk3liX98Qqbq7mizNVHvRrDmh1OUM8O5QVDg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vzhilxi40RdHl/if59Z3tD68btiKi8WcLsyIO85rhK8rRKxCPHZ8EpCoVK6e/DZk1Tgx2sEjAB02wfFhCWSfleC3khXdPT/ppeLXkQ3sXQSfCt0BUTJtNqhAurWF5pgRbNPXo3gMc/YgI2zDUm0ozoUC6Y7iHR7ntcoQ5M1vsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0830C16A3;
	Tue, 19 Aug 2025 06:15:48 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 078263F58B;
	Tue, 19 Aug 2025 06:15:51 -0700 (PDT)
Message-ID: <67a0d778-6e2c-4955-a7ce-56a10043ae8d@arm.com>
Date: Tue, 19 Aug 2025 14:15:50 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] perf: Introduce positive capability for raw events
From: Robin Murphy <robin.murphy@arm.com>
To: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 mark.rutland@arm.com, acme@kernel.org, namhyung@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, dmaengine@vger.kernel.org,
 linux-fpga@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, coresight@lists.linaro.org,
 iommu@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1755096883.git.robin.murphy@arm.com>
 <542787fd188ea15ef41c53d557989c962ed44771.1755096883.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <542787fd188ea15ef41c53d557989c962ed44771.1755096883.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 6:01 pm, Robin Murphy wrote:
> Only a handful of CPU PMUs accept PERF_TYPE_{RAW,HARDWARE,HW_CACHE}
> events without registering themselves as PERF_TYPE_RAW in the first
> place. Add an explicit opt-in for these special cases, so that we can
> make life easier for every other driver (and probably also speed up the
> slow-path search) by having perf_try_init_event() do the basic type
> checking to cover the majority of cases.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> A further possibility is to automatically add the cap to PERF_TYPE_RAW
> PMUs in perf_pmu_register() to have a single point-of-use condition; I'm
> undecided...
> ---
>   arch/s390/kernel/perf_cpum_cf.c    |  1 +
>   arch/s390/kernel/perf_pai_crypto.c |  2 +-
>   arch/s390/kernel/perf_pai_ext.c    |  2 +-
>   arch/x86/events/core.c             |  2 +-
>   drivers/perf/arm_pmu.c             |  1 +
>   include/linux/perf_event.h         |  1 +
>   kernel/events/core.c               | 15 +++++++++++++++
>   7 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> index 1a94e0944bc5..782ab755ddd4 100644
> --- a/arch/s390/kernel/perf_cpum_cf.c
> +++ b/arch/s390/kernel/perf_cpum_cf.c
> @@ -1054,6 +1054,7 @@ static void cpumf_pmu_del(struct perf_event *event, int flags)
>   /* Performance monitoring unit for s390x */
>   static struct pmu cpumf_pmu = {
>   	.task_ctx_nr  = perf_sw_context,
> +	.capabilities = PERF_PMU_CAP_RAW_EVENTS,
>   	.pmu_enable   = cpumf_pmu_enable,
>   	.pmu_disable  = cpumf_pmu_disable,
>   	.event_init   = cpumf_pmu_event_init,
> diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
> index a64b6b056a21..b5b6d8b5d943 100644
> --- a/arch/s390/kernel/perf_pai_crypto.c
> +++ b/arch/s390/kernel/perf_pai_crypto.c
> @@ -569,7 +569,7 @@ static const struct attribute_group *paicrypt_attr_groups[] = {
>   /* Performance monitoring unit for mapped counters */
>   static struct pmu paicrypt = {
>   	.task_ctx_nr  = perf_hw_context,
> -	.capabilities = PERF_PMU_CAP_SAMPLING,
> +	.capabilities = PERF_PMU_CAP_SAMPLING | PERF_PMU_CAP_RAW_EVENTS,
>   	.event_init   = paicrypt_event_init,
>   	.add	      = paicrypt_add,
>   	.del	      = paicrypt_del,
> diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
> index 1261f80c6d52..bcd28c38da70 100644
> --- a/arch/s390/kernel/perf_pai_ext.c
> +++ b/arch/s390/kernel/perf_pai_ext.c
> @@ -595,7 +595,7 @@ static const struct attribute_group *paiext_attr_groups[] = {
>   /* Performance monitoring unit for mapped counters */
>   static struct pmu paiext = {
>   	.task_ctx_nr  = perf_hw_context,
> -	.capabilities = PERF_PMU_CAP_SAMPLING,
> +	.capabilities = PERF_PMU_CAP_SAMPLING | PERF_PMU_CAP_RAW_EVENTS,
>   	.event_init   = paiext_event_init,
>   	.add	      = paiext_add,
>   	.del	      = paiext_del,
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 789dfca2fa67..764728bb80ae 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2697,7 +2697,7 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
>   }
>   
>   static struct pmu pmu = {
> -	.capabilities		= PERF_PMU_CAP_SAMPLING,
> +	.capabilities		= PERF_PMU_CAP_SAMPLING | PERF_PMU_CAP_RAW_EVENTS,
>   
>   	.pmu_enable		= x86_pmu_enable,
>   	.pmu_disable		= x86_pmu_disable,
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 72d8f38d0aa5..bc772a3bf411 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -877,6 +877,7 @@ struct arm_pmu *armpmu_alloc(void)
>   		 * specific PMU.
>   		 */
>   		.capabilities	= PERF_PMU_CAP_SAMPLING |
> +				  PERF_PMU_CAP_RAW_EVENTS |
>   				  PERF_PMU_CAP_EXTENDED_REGS |
>   				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
>   	};
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 183b7c48b329..c6ad036c0037 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
>   #define PERF_PMU_CAP_AUX_PAUSE		0x0200
>   #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
> +#define PERF_PMU_CAP_RAW_EVENTS		0x0800
>   
>   /**
>    * pmu::scope
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 71b2a6730705..2ecee76d2ae2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12556,11 +12556,26 @@ static inline bool has_extended_regs(struct perf_event *event)
>   	       (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK);
>   }
>   
> +static bool is_raw_pmu(const struct pmu *pmu)
> +{
> +	return pmu->type == PERF_TYPE_RAW ||
> +	       pmu->capabilities & PERF_PMU_CAP_RAW_EVENTS;
> +}
> +
>   static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>   {
>   	struct perf_event_context *ctx = NULL;
>   	int ret;
>   
> +	/*
> +	 * Before touching anything, we can safely skip:
> +	 * - any event for a specific PMU which is not this one
> +	 * - any common event if this PMU doesn't support them
> +	 */
> +	if (event->attr.type != pmu->type &&
> +	    (event->attr.type >= PERF_TYPE_MAX || is_raw_pmu(pmu)))

Ah, that should be "!is_raw_pmu(pmu)" there (although it's not entirely 
the cause of the LKP report on the final patch.)

Thanks,
Robin.

> +		return -ENOENT;
> +
>   	if (!try_module_get(pmu->module))
>   		return -ENODEV;
>   


