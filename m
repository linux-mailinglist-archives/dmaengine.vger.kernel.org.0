Return-Path: <dmaengine+bounces-5239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE1ABFC24
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C854E6F16
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF0627FB04;
	Wed, 21 May 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEAro79q"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6421E082;
	Wed, 21 May 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847869; cv=none; b=s4Ael97grlgDT78q9g67hDzy0WReX0lKEUQvdhQNlK9lr0fdW3IJClv+KHXQEdAqdvfW8vlzqDSb9EuQziS1VLHD2sZ4SSbu9cHMJYCjluzkGffrz+WvVHLMEfZyZeKyufXxKZyg+6UgBytqspLYGdKTbeE/Y+96yw1L1VIbMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847869; c=relaxed/simple;
	bh=MKq89yheYaWXCaAu9Wm2mo0plEFViL4eGl+jR8/HsEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7YK7QORt7zZ4W6uAZdnMOye3OidGBD/sq7u/SBEkFG7nCgJTfJr4ochQksl9jm+rzowGUzlweDsJv3Lc2aew2CrNH8TL+LG8HxMfMdd5HAI4GqBKWn7xuUWiz18ACkiEIzilmXuT/g3hhlGs+htI4sK91hRrDetLgqdpTr9bdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEAro79q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CBFC4CEE4;
	Wed, 21 May 2025 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847868;
	bh=MKq89yheYaWXCaAu9Wm2mo0plEFViL4eGl+jR8/HsEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEAro79qaCcRHl7KC2CUQe9ayiveUW2rblaDCbZA88nruDn/PWlq3bAzfq5gWacvx
	 GR9tPO4faTWPuQMY2IlVUC/FmYVafeBAuOyeYRt5iaoH+BhaiZhQTujw4/zomEJ4vw
	 Ue2VI3PR6+i0/cYlTFHC5MNF9fP3ShV2FOFuRepFwK8u7eyNiw+sIAx64zQErWrGhd
	 DTUk8wA283ScilKEb90GT5Igl/57cDkn8cWBpBDkS2W7RGv4pWZHooq7282FJvWErQ
	 kUrpmnQvCBLdSUwUPoXqPvDqzizimmrX/qJp8hq5NzcnIBdLxYsLl1GzmIJArLAq1i
	 zHBP4JdJ0bTww==
Date: Wed, 21 May 2025 10:17:46 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: vkoul@kernel.org, chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	leon@kernel.org, jgg@nvidia.com, alex.williamson@redhat.com,
	joel.granados@kernel.org, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 6/6] dma-mapping: benchmark: add IOVA support
Message-ID: <aC4KuiiqMyfPoH0N@bombadil.infradead.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-7-mcgrof@kernel.org>
 <a1e9c606-0255-4e3b-87d3-dadc3b819622@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e9c606-0255-4e3b-87d3-dadc3b819622@arm.com>

On Wed, May 21, 2025 at 05:08:08PM +0100, Robin Murphy wrote:
> On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> > diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
> > index 62674c83bde4..da7c9e3ddf21 100644
> > --- a/include/linux/map_benchmark.h
> > +++ b/include/linux/map_benchmark.h
> > @@ -27,5 +28,15 @@ struct map_benchmark {
> >   	__u32 dma_dir; /* DMA data direction */
> >   	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> >   	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
> > +	__u32 has_iommu_dma;
> 
> Why would userspace care about this? Either they asked for a streaming
> benchmark and it's irrelevant, or they asked for an IOVA benchmark, which
> either succeeded, or failed and this is ignored anyway.

Its so we inform userspace that its not possible to run IOVA tests for a
good reason, instead of just saying it failed.

> Conversely, why should the kernel have to care about this? If userspace
> wants both benchmarks, they can just run both benchmarks, with whatever
> number of threads for each they fancy. No need to have all that complexity
> kernel-side. 

I'm not following about the complexity you are referring to here. The
point to has_iommu_dma is to simply avoid running the IOVA tests so
that userspace doesn't get incorrect results for a feature it can't
possibly support.

> If there's a valid desire for running multiple different
> benchmarks *simultaneously* then we should support that in general (I can
> imagine it being potentially interesting to thrash the IOVA allocator with
> several different sizes at once, for example.)

Sure, both are supported. However, no point in running IOVA tests if
you can't possibly run them.

> That way, I'd also be inclined to give the new ioctl its own separate
> structure for IOVA results, and avoid impacting the existing ABI.

Sure.

> > -static int do_map_benchmark(struct map_benchmark_data *map)
> > +static int do_iova_benchmark(struct map_benchmark_data *map)
> > +{
> > +	struct task_struct **tsk;
> > +	int threads = map->bparam.threads;
> > +	int node = map->bparam.node;
> > +	u64 iova_loops;
> > +	int ret = 0;
> > +	int i;
> > +
> > +	tsk = kmalloc_array(threads, sizeof(*tsk), GFP_KERNEL);
> > +	if (!tsk)
> > +		return -ENOMEM;
> > +
> > +	get_device(map->dev);
> > +
> > +	/* Create IOVA threads only */
> > +	for (i = 0; i < threads; i++) {
> > +		tsk[i] = kthread_create_on_node(benchmark_thread_iova, map,
> > +				node, "dma-iova-benchmark/%d", i);
> > +		if (IS_ERR(tsk[i])) {
> > +			pr_err("create dma_iova thread failed\n");
> > +			ret = PTR_ERR(tsk[i]);
> > +			while (--i >= 0)
> > +				kthread_stop(tsk[i]);
> > +			goto out;
> > +		}
> > +
> > +		if (node != NUMA_NO_NODE)
> > +			kthread_bind_mask(tsk[i], cpumask_of_node(node));
> > +	}
> 
> Duplicating all the thread-wrangling code seems needlessly horrible - surely
> it's easy enough to factor out the stats initialisation and final
> calculation, along with the thread function itself. Perhaps as callbacks in
> the map_benchmark_data?

Could try that.

> Similarly, each "thread function" itself only only actually needs to consist
> of the respective "while (!kthread_should_stop())" loop - the rest of
> map_benchmark_thread() could still be used as a common harness to avoid
> duplicating the buffer management code as well.

If we want to have a separate data structure for IOVA tests there's more
reason to keep the threads separated as each would be touching different
data structures, otherwise we end up with a large branch.

  Luis

