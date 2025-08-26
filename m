Return-Path: <dmaengine+bounces-6213-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A083B36DC5
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77D21731E8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE9231A21;
	Tue, 26 Aug 2025 15:31:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B91D88AC;
	Tue, 26 Aug 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222295; cv=none; b=Y+4zzpggLkNa0xCyJkiskt3WIKIl1zH165KQCz00R33ugU3s49JlbRJJrrxmV5XSOpkH7wp0HBkVcf8h3u2d+ES0MRh+wr38qzvGy0Wq9ZjxZNgLiXAwRzd1rhRtXC1Vj/r6iUNzLUE9i/33wNK+MrhY2bgDjYpxYULH8jT/Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222295; c=relaxed/simple;
	bh=UMXrN8bVU3BYR4N/kEYm/GzpHnK1RsyFRzDlslFD5X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnKnwEHE65JdB0CouyNowrx5u6fJ1ddpnSdy3VuKl6VsMiVSPnHYB1ZUIKeLibo2pVz5rBrvH7wAT9r0TsdfUCV0Fw84TDBMcTisspUdbolV77bubSEMTdyoXmGvOfP8uA7Wb3CUtCi2xNQ3NkGqVWC2gyziJBzmivmnvWO6XqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F3A169E;
	Tue, 26 Aug 2025 08:31:24 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376B93F63F;
	Tue, 26 Aug 2025 08:31:26 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:31:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
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
Subject: Re: [PATCH 02/19] perf/hisilicon: Fix group validation
Message-ID: <aK3TS3s5_Pczx1nu@J2N7QTR9R3>
References: <cover.1755096883.git.robin.murphy@arm.com>
 <c7b877e66ba0d34d8558c5af8bbb620e8c0e47d9.1755096883.git.robin.murphy@arm.com>
 <aK2XS_GhLw1EQ2ml@J2N7QTR9R3>
 <ab80cb84-42b2-4ce8-aa6c-4ce6be7a12b7@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab80cb84-42b2-4ce8-aa6c-4ce6be7a12b7@arm.com>

On Tue, Aug 26, 2025 at 03:35:48PM +0100, Robin Murphy wrote:
> On 2025-08-26 12:15 pm, Mark Rutland wrote:
> > On Wed, Aug 13, 2025 at 06:00:54PM +0100, Robin Murphy wrote:
> > > The group validation logic shared by the HiSilicon HNS3/PCIe drivers is
> > > a bit off, in that given a software group leader, it will consider that
> > > event *in place of* the actual new event being opened. At worst this
> > > could theoretically allow an unschedulable group if the software event
> > > config happens to look like one of the hardware siblings.
> > > 
> > > The uncore framework avoids that particular issue,
> > 
> > What is "the uncore framework"? I'm not sure exactly what you're
> > referring to, nor how that composes with the problem described above.
> 
> Literally that hisi_uncore_pmu.c is actually a framework for half a dozen
> individual sub-drivers rather than a "driver" itself per se, but I suppose
> that detail doesn't strictly matter at this level.

I see. My concern was just that I couldn't figure out what "the uncore
framework" was, since it sounded more generic. If you say something like
"the shared code in hisi_uncore_pmu.c", I think that would be clearer.

> > > but all 3 also share the common issue of not preventing racy access to
> > > the sibling list,
> > 
> > Can you please elaborate on this racy access to the silbing list? I'm
> > not sure exactly what you're referring to.
> 
> Hmm, yes, I guess an actual race is probably impossible since if we're still
> in the middle of opening the group leader event then we haven't yet
> allocated the fd that userspace would need to start adding siblings, even if
> it tried to guess. I leaned on "racy" as a concise way to infer "when it
> isn't locked (even though the reasons for that are more subtle)" repeatedly
> over several patches - after all, the overall theme of this series is that I
> dislike repetitive boilerplate :)
> 
> I'll dedicate some time for polishing commit messages for v2, especially the
> common context for these "part 1" patches per your feedback on patch #1.

Thanks!

> > > and some redundant checks which can be cleaned up.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/perf/hisilicon/hisi_pcie_pmu.c   | 17 ++++++-----------
> > >   drivers/perf/hisilicon/hisi_uncore_pmu.c | 23 +++++++----------------
> > >   drivers/perf/hisilicon/hns3_pmu.c        | 17 ++++++-----------
> > >   3 files changed, 19 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > > index c5394d007b61..3b0b2f7197d0 100644
> > > --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > > +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > > @@ -338,21 +338,16 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
> > >   	int counters = 1;
> > >   	int num;
> > > -	event_group[0] = leader;
> > > -	if (!is_software_event(leader)) {
> > > -		if (leader->pmu != event->pmu)
> > > -			return false;
> > > +	if (leader == event)
> > > +		return true;
> > > -		if (leader != event && !hisi_pcie_pmu_cmp_event(leader, event))
> > > -			event_group[counters++] = event;
> > > -	}
> > > +	event_group[0] = event;
> > > +	if (leader->pmu == event->pmu && !hisi_pcie_pmu_cmp_event(leader, event))
> > > +		event_group[counters++] = leader;
> > 
> > Looking at this, the existing logic to share counters (which
> > hisi_pcie_pmu_cmp_event() is trying to permit) looks to be bogus, given
> > that the start/stop callbacks will reprogram the HW counters (and hence
> > can fight with one another).
> 
> Yeah, this had a dodgy smell when I first came across it, but after doing
> all the digging I think it does actually work out - the trick seems to be
> the group_leader check in hisi_pcie_pmu_get_event_idx(), with the
> implication the PMU is going to be stopped while scheduling in/out the whole
> group, so assuming hisi_pcie_pmu_del() doesn't clear the counter value in
> hardware (even though the first call nukes the rest of the event
> configuration), then the events should stay in sync.

I don't think that's sufficient. If nothing else, overflow is handled
per-event, and for a group of two identical events, upon overflow
hisi_pcie_pmu_irq() will reprogram the shared HW counter when handling
the first event, and the second event will see an arbitrary
discontinuity. Maybe no-one has spotted that due to the 2^63 counter
period that we program, but this is clearly bogus.

In addition, AFAICT the IRQ handler doesn't stop the PMU, so in general
groups aren't handled atomically, and snapshots of the counters won't be
atomic.

> It does seem somewhat nonsensical to have multiple copies of the same event
> in the same group, but I imagine it could happen with some sort of scripted
> combination of metrics, and supporting it at this level saves needing
> explicit deduplication further up. So even though my initial instinct was to
> rip it out too, in the end I concluded that that doesn't seem justified.

As above, I think it's clearly bogus. I don't think we should have
merged it as-is and it's not something I'd like to see others copy.
Other PMUs don't do this sort of event deduplication, and in general it
should be up to the user or userspace software to do that rather than
doing that badly in the kernel.

Given it was implemented with no rationale I think we should rip it out.
If that breaks someone's scripting, then we can consider implementing
something that actually works.

Mark.

