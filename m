Return-Path: <dmaengine+bounces-6064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760DB2C59B
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764F93AAA53
	for <lists+dmaengine@lfdr.de>; Tue, 19 Aug 2025 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3A2EB860;
	Tue, 19 Aug 2025 13:25:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623332EB84F;
	Tue, 19 Aug 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609953; cv=none; b=IqEgOARZDfpqNF4kbf8yjrKtWxPQJV08J1ByvXllAV9H/BWlXJlt4Fe4PnbXsqvY0KpLOicVW974pgA762rekzVN8mMieUbOdaUdYK4j5meP6QuCpZbyGBcOHwm/rrWeHvoGHz+JuIP7lUvOTPKXkzIaKF03vfgWc48jqkBbTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609953; c=relaxed/simple;
	bh=pBeIj/4Npl8WnOICq3KNLkIDe0MOER85JIhoxlatFuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RAuGWBCjLs34psniSdZYhebq3KbR5GKIlZslf4dRw/nqp9IvzI/A8niX+ZA2jWYk+W3hXbst8vqIOO0YNbaSs0cneEhR/uKktnuH5IPEsgBahGZR++waE8oYTWpSt5vgUoQh7fouoF66cwXdLtQcC9jRgjU4D4V3Lbgtw7yVyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CEF116A3;
	Tue, 19 Aug 2025 06:25:42 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 884583F738;
	Tue, 19 Aug 2025 06:25:46 -0700 (PDT)
Message-ID: <271daf71-3c57-49a5-a65f-c58ac670864f@arm.com>
Date: Tue, 19 Aug 2025 14:25:45 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] perf: Garbage-collect event_init checks
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
 <ace3532a8a438a96338bf349a27636d8294c7111.1755096883.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ace3532a8a438a96338bf349a27636d8294c7111.1755096883.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 6:01 pm, Robin Murphy wrote:
[...]
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 297ff5adb667..98ffab403bb4 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -731,24 +731,11 @@ static int uncore_pmu_event_init(struct perf_event *event)
>   	struct hw_perf_event *hwc = &event->hw;
>   	int ret;
>   
> -	if (event->attr.type != event->pmu->type)
> -		return -ENOENT;
> -
>   	pmu = uncore_event_to_pmu(event);
>   	/* no device found for this pmu */
>   	if (!pmu->registered)
>   		return -ENOENT;
>   
> -	/* Sampling not supported yet */
> -	if (hwc->sample_period)
> -		return -EINVAL;
> -
> -	/*
> -	 * Place all uncore events for a particular physical package
> -	 * onto a single cpu
> -	 */
> -	if (event->cpu < 0)
> -		return -EINVAL;

Oopsie, I missed that this isn't just the usual boilerplate as the 
comment kind of implies, but is also necessary to prevent the 
uncore_pmu_to_box() lookup going wrong (since the core code won't reject 
a task-bound event until later). I'll put this back with an updated 
comment for v2 (and double-check everything else again...), thanks LKP!

Robin.


>   	box = uncore_pmu_to_box(pmu, event->cpu);
>   	if (!box || box->cpu < 0)
>   		return -EINVAL;

