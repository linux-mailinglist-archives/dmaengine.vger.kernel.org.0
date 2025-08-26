Return-Path: <dmaengine+bounces-6215-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF12B36F34
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628F18E84F0
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1231A564;
	Tue, 26 Aug 2025 15:54:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6400631A558;
	Tue, 26 Aug 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223646; cv=none; b=LKSesoTfDbdiOp8nggAuKzaPNMB6j2N4WnMsa+l/MnUGx8ugDqaBQFPUxb06JY5Cex3iol5h/OtMaN7rX714hG3NSNSvxLpjqGdM6hL+3eBXgMa41+qno9+XleG0F84DofijlZN4sADYB9ALQV066Z+nC5q7zIbd0RYAT6XvzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223646; c=relaxed/simple;
	bh=kYW541e1nFWGVYhRgbZq3mXAqdUof67Phlv3fCn/KoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZakEoPouxm5z4Gcp6r979ArXt+bce8WCYHGc8QWcO1i5fgg72LDMgIj1C6IP4AAilLpNwEb6dz1YtcMUZtfWCP7fwQTA/2ihlvi9URw3Gytviq540a5pHyf2ectL1UdYesawaGXUFnzMs+yTZ8QuE9i2TFYLHpN45GWJfMGTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39F0B1A25;
	Tue, 26 Aug 2025 08:53:54 -0700 (PDT)
Received: from [10.57.4.86] (unknown [10.57.4.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8041A3F694;
	Tue, 26 Aug 2025 08:53:54 -0700 (PDT)
Message-ID: <983df32a-ba74-421d-bc20-06e778b4d2c9@arm.com>
Date: Tue, 26 Aug 2025 16:53:51 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] perf: Introduce positive capability for sampling
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 mark.rutland@arm.com, acme@kernel.org, namhyung@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <ae81cb65b38555c628e395cce67ac6c7eaafdd23.1755096883.git.robin.murphy@arm.com>
 <20250826131124.GB745921@e132581.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250826131124.GB745921@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-26 2:11 pm, Leo Yan wrote:
> On Wed, Aug 13, 2025 at 06:01:08PM +0100, Robin Murphy wrote:
>> Sampling is inherently a feature for CPU PMUs, given that the thing
>> to be sampled is a CPU context. These days, we have many more
>> uncore/system PMUs than CPU PMUs, so it no longer makes much sense to
>> assume sampling support by default and force the ever-growing majority
>> of drivers to opt out of it (or erroneously fail to). Instead, let's
>> introduce a positive opt-in capability that's more obvious and easier to
>> maintain.
> 
> [...]
> 
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index 369e77ad5f13..dbd52851f5c6 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -955,7 +955,8 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
>>   	spe_pmu->pmu = (struct pmu) {
>>   		.module = THIS_MODULE,
>>   		.parent		= &spe_pmu->pdev->dev,
>> -		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>> +		.capabilities	= PERF_PMU_CAP_SAMPLING |
>> +				  PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>>   		.attr_groups	= arm_spe_pmu_attr_groups,
>>   		/*
>>   		 * We hitch a ride on the software context here, so that
> 
> The change in Arm SPE driver looks good to me.
> 
> I noticed you did not set the flag for other AUX events, like Arm
> CoreSight, Intel PT and bts. The drivers locate in:
> 
>    drivers/hwtracing/coresight/coresight-etm-perf.c
>    arch/x86/events/intel/bts.c
>    arch/x86/events/intel/pt.c
> 
> Genearlly, AUX events generate interrupts based on AUX ring buffer
> watermark but not the period. Seems to me, it is correct to set the
> PERF_PMU_CAP_SAMPLING flag for them.

This cap is given to drivers which handle event->attr.sample_period and 
call perf_event_overflow() - or in a few rare cases, 
perf_output_sample() directly - to do something meaningful with it, 
since the intent is to convey "I properly handle events for which 
is_sampling_event() is true". My understanding is that aux events are 
something else entirely, but I'm happy to be corrected.

Otherwise, perhaps this suggests it deserves to be named a little more 
specifically for clarity, maybe PERF_CAP_SAMPLING_EVENTS?

Thanks,
Robin.

> A special case is Arm CoreSight legacy sinks (like ETR/ETB, etc)
> don't has interrupt. We might need set or clear the flag on the fly
> based on sink type:
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f1551c08ecb2..404edc94c198 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -433,6 +433,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>          if (!sink)
>                  goto err;
>   
> +       if (coresight_is_percpu_sink(sink))
> +               event->pmu.capabilities = PERF_PMU_CAP_SAMPLING;
> +       else
> +               event->pmu.capabilities &= ~PERF_PMU_CAP_SAMPLING;
> +
> 
> Thanks,
> Leo


