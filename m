Return-Path: <dmaengine+bounces-6214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93253B36DD8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 17:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAB45E5201
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECEE27D786;
	Tue, 26 Aug 2025 15:32:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A772264AA;
	Tue, 26 Aug 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222339; cv=none; b=opCGg10fAlAREVqKL0j/Hs2QClDamzjgCCADGy6gWBeHJrZwigmBEuCXgwTmLjuUiB3NxzPtqabOMEO74RIA3Mius8fQxzUyy47JSjVIFWKG1azssBdhRPSn9QChXAnwyUeCqf8IcSU31uwK6WmpH/XhmLW7p4VId8QU2alm7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222339; c=relaxed/simple;
	bh=mhPjoaXqk9FeEGRXj1OT9YJtAB1S/b2g99dnNIlN5XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2bvDoAzlhljWjVrW4SAwF5CRHOHi3/B+/jt6fMnolseV6kTfd7eMXQQEqKXXESRcszhCTe++Rfnz4T93tu8Sx5whmrrT2TCIxBVT1Bbjs6NsV4hOPziVvzxDcgQ61KErwA2q47Jld+2O2yfuQ8WjI3aRD4kpTKQey1OEAAC2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E872169E;
	Tue, 26 Aug 2025 08:32:08 -0700 (PDT)
Received: from [10.57.4.86] (unknown [10.57.4.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 893E73F63F;
	Tue, 26 Aug 2025 08:32:09 -0700 (PDT)
Message-ID: <6080e45d-032e-48c2-8efc-3d7e5734d705@arm.com>
Date: Tue, 26 Aug 2025 16:32:07 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] perf: Ignore event state for group validation
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, mark.rutland@arm.com, acme@kernel.org,
 namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
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
 <d6cda4e2999aba5794c8178f043c91068fa8080c.1755096883.git.robin.murphy@arm.com>
 <20250826130329.GX4067720@noisy.programming.kicks-ass.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250826130329.GX4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-26 2:03 pm, Peter Zijlstra wrote:
> On Wed, Aug 13, 2025 at 06:01:04PM +0100, Robin Murphy wrote:
>> It may have been different long ago, but today it seems wrong for these
>> drivers to skip counting disabled sibling events in group validation,
>> given that perf_event_enable() could make them schedulable again, and
>> thus increase the effective size of the group later. Conversely, if a
>> sibling event is truly dead then it stands to reason that the whole
>> group is dead, so it's not worth going to any special effort to try to
>> squeeze in a new event that's never going to run anyway. Thus, we can
>> simply remove all these checks.
> 
> So currently you can do sort of a manual event rotation inside an
> over-sized group and have it work.
> 
> I'm not sure if anybody actually does this, but its possible.
> 
> Eg. on a PMU that supports only 4 counters, create a group of 5 and
> periodically cycle which of the 5 events is off.
> 
> So I'm not against changing this, but changing stuff like this always
> makes me a little fearful -- it wouldn't be the first time that when it
> finally trickles down to some 'enterprise' user in 5 years someone comes
> and finally says, oh hey, you broke my shit :-(

Eww, I see what you mean... and I guess that's probably lower-overhead 
than actually deleting and recreating the sibling event(s) each time, 
and potentially less bother then wrangling multiple groups for different 
combinations of subsets when one simply must still approximate a complex 
metric that requires more counters than the hardware offers.

I'm also not keen to break anything that wasn't already somewhat broken, 
especially since this patch is only intended as cleanup, so either we 
could just drop it altogether, or perhaps I can wrap the existing 
behaviour in a helper that can at least document this assumption and 
discourage new drivers from copying it. Am I right that only 
PERF_EVENT_STATE_{OFF,ERROR} would matter for this, though, and my 
reasoning for state <= PERF_EVENT_STATE_EXIT should still stand? As for 
the fiddly discrepancy with enable_on_exec between arm_pmu and others 
I'm not really sure what to think...

Thanks,
Robin.

