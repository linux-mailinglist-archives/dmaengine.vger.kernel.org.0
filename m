Return-Path: <dmaengine+bounces-6205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DFB36137
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C102A3921
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D722517AA;
	Tue, 26 Aug 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5T3h8Qu"
X-Original-To: dmaengine@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B522A4EE;
	Tue, 26 Aug 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213422; cv=none; b=UPNlmMLaJeEZQeg3++4mH1sFExavwuKhCQWINJjrNLCAtMwErxXnyTrOba9dGiI5omeOC/DqLaRt0jKa55qNcue3nMslRS4C+LyRGqMD2qwSEU+Gl9zBnLP8tDsiLNR7PTPdolrLm07GiLRCB17RWrYTgAl4AGrVyVsUIIWy734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213422; c=relaxed/simple;
	bh=pe5SE8cLTPPyLKyF6S5l44TjxJSycuwoPwH53Hc4MBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/IhJQReJM/y5yPxstRXY4glIAPG+irhAYQ1Dl/tu+dTBZVHBslYt6eXuUZCHaswxY0AN5C7u5H7XJ+16uaRbaIi/6A2RrMmnEvveP4c5LLWke2z0v58DmzAPLcHdciYpRjRjIYJUZsT5NybQCho4uWpFzRg1MjJkiILdzlpoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s5T3h8Qu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pe5SE8cLTPPyLKyF6S5l44TjxJSycuwoPwH53Hc4MBc=; b=s5T3h8QunORHMVi1lJq+TueBjc
	cEFljtvjN5QJ03jRIuUbqZT2dzYWLCkq7EIgZ1HjiZepKSvKZUS4jhIftbJpUomzAxLkXpo4MhYIl
	ZCvpLQBdWeqllwk2L5LEakNCj50aVxzY1I5n8BnO+qCbmyfysUZaBrevf4ZwX/NHQuj2PrtwGK3Is
	jhSt6FlQLnGrrRwVWOG3VEhB1mGDJu+1EhbkwSGhAG25rhQM5DyWklhsvsXQh2tW5FYLoYbc8dttl
	tsa9sX+EEmcEbn/jBCdJY0wOlh7GZntWiVjKPlxT8hw9CmspDWHiAZfhSZSTIR8f/mKGoVnI/OKYV
	DfymEZ2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtKk-00000002CWx-1CxP;
	Tue, 26 Aug 2025 13:03:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7FAC3002C5; Tue, 26 Aug 2025 15:03:29 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:03:29 +0200
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
Subject: Re: [PATCH 12/19] perf: Ignore event state for group validation
Message-ID: <20250826130329.GX4067720@noisy.programming.kicks-ass.net>
References: <cover.1755096883.git.robin.murphy@arm.com>
 <d6cda4e2999aba5794c8178f043c91068fa8080c.1755096883.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cda4e2999aba5794c8178f043c91068fa8080c.1755096883.git.robin.murphy@arm.com>

On Wed, Aug 13, 2025 at 06:01:04PM +0100, Robin Murphy wrote:
> It may have been different long ago, but today it seems wrong for these
> drivers to skip counting disabled sibling events in group validation,
> given that perf_event_enable() could make them schedulable again, and
> thus increase the effective size of the group later. Conversely, if a
> sibling event is truly dead then it stands to reason that the whole
> group is dead, so it's not worth going to any special effort to try to
> squeeze in a new event that's never going to run anyway. Thus, we can
> simply remove all these checks.

So currently you can do sort of a manual event rotation inside an
over-sized group and have it work.

I'm not sure if anybody actually does this, but its possible.

Eg. on a PMU that supports only 4 counters, create a group of 5 and
periodically cycle which of the 5 events is off.

So I'm not against changing this, but changing stuff like this always
makes me a little fearful -- it wouldn't be the first time that when it
finally trickles down to some 'enterprise' user in 5 years someone comes
and finally says, oh hey, you broke my shit :-(


