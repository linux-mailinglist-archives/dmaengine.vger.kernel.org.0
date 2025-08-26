Return-Path: <dmaengine+bounces-6206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F43B361A2
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F98E1BA51DA
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B1246333;
	Tue, 26 Aug 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTA/3PiA"
X-Original-To: dmaengine@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B30184540;
	Tue, 26 Aug 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213694; cv=none; b=ZE88xS9qerwBHKbPHE+L1FDoOpsCOnius5W6cPTf78/IeU+sW1qXnmskCswemo9LbXoZPxqkZDg7loW6sFYwrXFkHXF5dYLEqkYqZxvzq1Y08ELfPyBc2Yuz9uaam51FExdUgtGkaZYGF6oLWGB4x6KDrH5+Joif0u9qcRtePv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213694; c=relaxed/simple;
	bh=K5Hq8A3EfCbmeiLfsfr4d1nDO6kRorI56BAyDsThWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klvpv9HYhNGZn6PC3oLwfENyrx7P2IjzEuW9tdbFQaIIopxN3BkJHO2hboRwEgp6Xscz/Y+fqXvN+cgwsa+sFAACpu+4jhfuHOZyQatdRqYGzQoBF5gPzqz+5vZIFLkmfMPXVJrGs5TFQSx7ftgxWhY2dmhKYY7XLlZtBuBrYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tTA/3PiA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1anwaqC6FtBZhv/AdRsioHe6z7ff2/NtObpshRSmtXo=; b=tTA/3PiAJQSpvqwn9JBse0zv8x
	XpRRlvytBaU8d04FPgmaRAhvvZSqAROIZ/4ezjLoE6WsNdrr9/VlG41rEHCWsnk6JH8UsrGv5T5LT
	zWsAXDZBYt6RN2vrodVyAq1DmmcYAol3ljF/QPWtrzgIrZdA+eDohdH+O3MOT2cIfR3SAL6oZFxxT
	a0buqH4Cjn32e+/T6hw9u+ioPisD3zaMrQKEyQ6W0w6+Ct9SXam4tKJBvFWH9AMfHquCJRKF+Zp4I
	PdyzFVdx3HFHpHhkOPtwcc+TPPHK59R640Wqk+YmnwDvNpXZJgmWLR1JQJ9jnUMah3B3H6sSqGhBU
	hjKnAxuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtPC-00000002GIP-3rVi;
	Tue, 26 Aug 2025 13:08:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DB2A63002C5; Tue, 26 Aug 2025 15:08:06 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:08:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
	acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
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
Subject: Re: [PATCH 16/19] perf: Introduce positive capability for sampling
Message-ID: <20250826130806.GY4067720@noisy.programming.kicks-ass.net>
References: <cover.1755096883.git.robin.murphy@arm.com>
 <ae81cb65b38555c628e395cce67ac6c7eaafdd23.1755096883.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae81cb65b38555c628e395cce67ac6c7eaafdd23.1755096883.git.robin.murphy@arm.com>

On Wed, Aug 13, 2025 at 06:01:08PM +0100, Robin Murphy wrote:
> Sampling is inherently a feature for CPU PMUs, given that the thing
> to be sampled is a CPU context. These days, we have many more
> uncore/system PMUs than CPU PMUs, so it no longer makes much sense to
> assume sampling support by default and force the ever-growing majority
> of drivers to opt out of it (or erroneously fail to). Instead, let's
> introduce a positive opt-in capability that's more obvious and easier to
> maintain.
> 

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 4d439c24c901..bf2cfbeabba2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -294,7 +294,7 @@ struct perf_event_pmu_context;
>  /**
>   * pmu::capabilities flags
>   */
> -#define PERF_PMU_CAP_NO_INTERRUPT	0x0001
> +#define PERF_PMU_CAP_SAMPLING		0x0001
>  #define PERF_PMU_CAP_NO_NMI		0x0002
>  #define PERF_PMU_CAP_AUX_NO_SG		0x0004
>  #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
> @@ -305,6 +305,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
>  #define PERF_PMU_CAP_AUX_PAUSE		0x0200
>  #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
> +#define PERF_PMU_CAP_NO_INTERRUPT	0x0800

So NO_INTERRUPT was supposed to be the negative of your new SAMPLING
(and I agree with your reasoning).

What I'm confused/curious about is why we retain NO_INTERRUPT?

