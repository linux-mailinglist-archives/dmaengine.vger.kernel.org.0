Return-Path: <dmaengine+bounces-6203-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C93B35A65
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310662A4DE9
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7F312803;
	Tue, 26 Aug 2025 10:46:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1C327790;
	Tue, 26 Aug 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205186; cv=none; b=r/NIMxaaXHdfaS6cJe8mD0qcxsnylRiSA/CnCAloga8Y6Tui2xtkTBc3y3sGUu8aXo4eCML1HsZ6/MZkRw/ps0JQpXDOSqwAbYdk/Ds1jqMuBx74lxDvheSSLmpj8F2V8A2zkt93rd6J3GVKsDULDwLYDchNP81Rfq3cttJR1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205186; c=relaxed/simple;
	bh=H3tVdYrDOxdRlNSFXF/jMCHZ3FgH+2UV7laTh6NYYEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFJYUOq5A6E9j+0qXg+Ldef6aZCGnKbnc0SsGAghEhfr2vzghjTVd9eRrciyq0/tY21xWTWZv5zWZQhY5nDMAvhPBHf4DlFMdkMxP4hsf9bNMfq18S3KUnlKfIgGej+7CwrG9+6vbewCThidWYRN4MqkSfKiHcAqqkLUqdPwbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A06821A25;
	Tue, 26 Aug 2025 03:46:15 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8000D3F694;
	Tue, 26 Aug 2025 03:46:14 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:46:10 +0100
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
Subject: Re: [PATCH 01/19] perf/arm-cmn: Fix event validation
Message-ID: <aK2QclH4jlHJ28EJ@J2N7QTR9R3>
References: <cover.1755096883.git.robin.murphy@arm.com>
 <0716da3e77065f005ef6ea0d10ddf67fc53e76cb.1755096883.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0716da3e77065f005ef6ea0d10ddf67fc53e76cb.1755096883.git.robin.murphy@arm.com>

Hi Robin,

On Wed, Aug 13, 2025 at 06:00:53PM +0100, Robin Murphy wrote:
> In the hypothetical case where a CMN event is opened with a software
> group leader that already has some other hardware sibling, currently
> arm_cmn_val_add_event() could try to interpret the other event's data
> as an arm_cmn_hw_event, which is not great since we dereference a
> pointer from there... Thankfully the way to be more robust is to be
> less clever - stop trying to special-case software events and simply
> skip any event that isn't for our PMU.

I think this is missing some important context w.r.t. how the core perf
code behaves (and hence why this change doesn't cause other problems).
I'd suggest that we give the first few patches a common preamble:

| When opening a new perf event, the core perf code calls
| pmu::event_init() before checking whether the new event would cause an
| event group to span multiple hardware PMUs. Considering this:
| 
| (1) Any pmu::event_init() callback needs to be robust to cases where
|     a non-software group_leader or sibling event targets a distinct
|     PMU.
| 
| (2) Any pmu::event_init() callback doesn't need to explicitly reject
|     groups that span multiple hardware PMUs, as the core code will
|     reject this later.

... and then spell out the specific issues in the driver, e.g.

| The logic in arm_cmn_validate_group() doesn't account for cases where
| a non-software sibling event targets a distinct PMU. In such cases,
| arm_cmn_val_add_event() will erroneously interpret the sibling's
| event::hw as as struct arm_cmn_hw_event, including dereferencing
| pointers from potentially user-controlled fields.
|
| Fix this by skipping any events for distinct PMUs, and leaving it to
| the core code to reject event groups that span multiple hardware PMUs.

With that context, the patch itself looks good to me.

This will need a Cc stable. I'm not sure what Fixes tag is necessary;
has this been broken since its introduction?

Mark.

> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 11fb2234b10f..f8c9be9fa6c0 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1652,7 +1652,7 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
>  	enum cmn_node_type type;
>  	int i;
>  
> -	if (is_software_event(event))
> +	if (event->pmu != &cmn->pmu)
>  		return;
>  
>  	type = CMN_EVENT_TYPE(event);
> @@ -1693,9 +1693,6 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
>  	if (leader == event)
>  		return 0;
>  
> -	if (event->pmu != leader->pmu && !is_software_event(leader))
> -		return -EINVAL;
> -
>  	val = kzalloc(sizeof(*val), GFP_KERNEL);
>  	if (!val)
>  		return -ENOMEM;
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

