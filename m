Return-Path: <dmaengine+bounces-6218-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0284B37082
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA757B8274
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF03680A2;
	Tue, 26 Aug 2025 16:35:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B5362078;
	Tue, 26 Aug 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226126; cv=none; b=WzpnlZGTV8MbtXNa1m3NS8QdCm/56MDcgWoMYggcCn3KExtxnEgZlrfI7C/hKw/GJkCI62Kfmmaz+3969AMx6CAStR10r5Ang1YXoYg5CzbnClXA26HyHkSDg2WxxQFjXE4dSpV5QxYBH/m+MkAFecXlBAsULiwB3Ym7TUHscns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226126; c=relaxed/simple;
	bh=Qr2qTi+512p+e4SYLAIsyC00OV8S61hM2BP79hz1vL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTnm4y7h5ZZ/UTvzOdkB5oxEB9mFnSoMaZOUaAC+YHOneg6tbAG/4vKqRoYuNWYP1XBSdhL98+tRjMJ62MELogaQz2m9KkQzdPQfi3hfj3UovIXRRcdnzzAtUayna3VLzimij34HlQwmgWMT6WH3FxGh5D/QevhHJho1AQiMA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4571A25;
	Tue, 26 Aug 2025 09:35:15 -0700 (PDT)
Received: from [10.57.4.86] (unknown [10.57.4.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5A1B3F694;
	Tue, 26 Aug 2025 09:35:17 -0700 (PDT)
Message-ID: <8d6ac059-fc8f-4a5d-b49e-d02777c01cfb@arm.com>
Date: Tue, 26 Aug 2025 17:35:15 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] perf: Introduce positive capability for sampling
To: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, acme@kernel.org, namhyung@kernel.org,
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
 <20250826130806.GY4067720@noisy.programming.kicks-ass.net>
 <aK22izKE4r6wI_D9@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aK22izKE4r6wI_D9@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-26 2:28 pm, Mark Rutland wrote:
> On Tue, Aug 26, 2025 at 03:08:06PM +0200, Peter Zijlstra wrote:
>> On Wed, Aug 13, 2025 at 06:01:08PM +0100, Robin Murphy wrote:
>>> Sampling is inherently a feature for CPU PMUs, given that the thing
>>> to be sampled is a CPU context. These days, we have many more
>>> uncore/system PMUs than CPU PMUs, so it no longer makes much sense to
>>> assume sampling support by default and force the ever-growing majority
>>> of drivers to opt out of it (or erroneously fail to). Instead, let's
>>> introduce a positive opt-in capability that's more obvious and easier to
>>> maintain.
>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index 4d439c24c901..bf2cfbeabba2 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -294,7 +294,7 @@ struct perf_event_pmu_context;
>>>   /**
>>>    * pmu::capabilities flags
>>>    */
>>> -#define PERF_PMU_CAP_NO_INTERRUPT	0x0001
>>> +#define PERF_PMU_CAP_SAMPLING		0x0001
>>>   #define PERF_PMU_CAP_NO_NMI		0x0002
>>>   #define PERF_PMU_CAP_AUX_NO_SG		0x0004
>>>   #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
>>> @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
>>>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
>>>   #define PERF_PMU_CAP_AUX_PAUSE		0x0200
>>>   #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
>>> +#define PERF_PMU_CAP_NO_INTERRUPT	0x0800
>>
>> So NO_INTERRUPT was supposed to be the negative of your new SAMPLING
>> (and I agree with your reasoning).
>>
>> What I'm confused/curious about is why we retain NO_INTERRUPT?
> 
> I see from your other reply that you spotted the next patch does that.
> 
> For the sake of other reviewers or anyone digging through the git
> history it's probably worth adding a line to this commit message to say:
> 
> | A subsequent patch will remove PERF_PMU_CAP_NO_INTERRUPT as this
> | requires some additional cleanup.

Yup, the main reason is the set of drivers getting the new cap is 
smaller than the set of drivers currently not rejecting sampling events, 
so I wanted it to be clearly visible in the patch. Indeed I shall 
clarify the relationship to NO_INTERRUPT in the commit message.

Thanks,
Robin.

