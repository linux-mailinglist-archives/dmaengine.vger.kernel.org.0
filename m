Return-Path: <dmaengine+bounces-5235-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B674ABF804
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 16:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3447188C588
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458015B0EC;
	Wed, 21 May 2025 14:41:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73671D63C2;
	Wed, 21 May 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838505; cv=none; b=WJprNakcLsNEttvVPA5NKbpmrEF/KsX+e2IpSQSPQRvXWPI/b1Dt+pKyQxUH1deeHmIbTfxsetxHNkNG+MBlvPSF5QVAmEnqxw+GxcWpUrhrPC58EVNSLh/4wawFbtUyaqO/Eh8m8u3DiYhP9EM5hoEjB92WlgKLcMOYxMLlbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838505; c=relaxed/simple;
	bh=hKLlpeVgOZq4v7+oqNNq1AtZ+j2CGaps4Oa1MUN2Uu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFO6m6yM6zYAyrj5FyVBvBev0F8Eu9veN3OGd/hB4Procfm/AUlJuFh/2NhdDNCaQra18Pv3A0DaMHG/sz5Q0hGNQwNB8YwygYWbbkIkqOQ6WLTGYNGnKfV68YulXYVh9es6IQWU84XOTzMKvxDfHt2zpNjgoCYXCRXTLNDnwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB2AF1515;
	Wed, 21 May 2025 07:41:27 -0700 (PDT)
Received: from [10.57.64.80] (unknown [10.57.64.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01AFD3F5A1;
	Wed, 21 May 2025 07:41:39 -0700 (PDT)
Message-ID: <ea9543a9-36ec-47e3-9fb9-21ea350cbd93@arm.com>
Date: Wed, 21 May 2025 15:41:38 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dmatest: move printing to its own routine
To: Luis Chamberlain <mcgrof@kernel.org>, vkoul@kernel.org,
 chenxiang66@hisilicon.com, m.szyprowski@samsung.com, leon@kernel.org,
 jgg@nvidia.com, alex.williamson@redhat.com, joel.granados@kernel.org
Cc: iommu@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-4-mcgrof@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250520223913.3407136-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> Move statistics printing to its own routine, and while at it, put
> the test counters into the struct dmatest_thread for the streaming DMA
> API to allow us to later add IOVA DMA API support and be able to
> differentiate.
> 
> While at it, use a mutex to serialize output so we don't get garbled
> messages between different threads.
> 
> This makes no functional changes other than serializing the output
> and prepping us for IOVA DMA API support.

Um, what about subtly changing the test timing and total runtime 
calculation, and significantly changing the output format enough to 
almost certainly break any scripts parsing it? What definition of 
"functional" are we using here, exactly? :/

Yes I know the kernel log is not strictly ABI and parsing it is not 
advised in general, but per 
Documentation/driver-api/dmaengine/dmatest.rst this is still the 
officially documented way to gather dmatest results. Also the mutex 
doesn't prevent *other* kernel messages from being interspersed, so 
multi-line output still isn't really stable.

Thanks,
Robin.

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/dma/dmatest.c | 77 ++++++++++++++++++++++++++++++++-----------
>   1 file changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 921d89b4d2ed..b4c129e688e3 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -92,6 +92,8 @@ static bool polled;
>   module_param(polled, bool, 0644);
>   MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
>   
> +static DEFINE_MUTEX(stats_mutex);
> +
>   /**
>    * struct dmatest_params - test parameters.
>    * @nobounce:		prevent using swiotlb buffer
> @@ -239,6 +241,12 @@ struct dmatest_thread {
>   	bool			done;
>   	bool			pending;
>   	u8			*pq_coefs;
> +
> +	/* Streaming DMA statistics */
> +	unsigned int streaming_tests;
> +	unsigned int streaming_failures;
> +	unsigned long long streaming_total_len;
> +	ktime_t streaming_runtime;
>   };
>   
>   struct dmatest_chan {
> @@ -898,6 +906,30 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
>   	return ret;
>   }
>   
> +static void dmatest_print_detailed_stats(struct dmatest_thread *thread)
> +{
> +	unsigned long long streaming_iops, streaming_kbs;
> +	s64 streaming_runtime_us;
> +
> +	mutex_lock(&stats_mutex);
> +
> +	streaming_runtime_us = ktime_to_us(thread->streaming_runtime);
> +	streaming_iops = dmatest_persec(streaming_runtime_us, thread->streaming_tests);
> +	streaming_kbs = dmatest_KBs(streaming_runtime_us, thread->streaming_total_len);
> +
> +	pr_info("=== %s: DMA Test Results ===\n", current->comm);
> +
> +	/* Streaming DMA statistics */
> +	pr_info("%s: STREAMINMG DMA: %u tests, %u failures\n",
> +		current->comm, thread->streaming_tests, thread->streaming_failures);
> +	pr_info("%s: STREAMING DMA: %llu.%02llu iops, %llu KB/s, %lld us total\n",
> +		current->comm, FIXPT_TO_INT(streaming_iops), FIXPT_GET_FRAC(streaming_iops),
> +		streaming_kbs, streaming_runtime_us);
> +
> +	pr_info("=== %s: End Results ===\n", current->comm);
> +	mutex_unlock(&stats_mutex);
> +}
> +
>   /*
>    * This function repeatedly tests DMA transfers of various lengths and
>    * offsets for a given operation type until it is told to exit by
> @@ -921,20 +953,22 @@ static int dmatest_func(void *data)
>   	unsigned int buf_size;
>   	u8 align;
>   	bool is_memset;
> -	unsigned int failed_tests = 0;
> -	unsigned int total_tests = 0;
> -	ktime_t ktime, start;
> +	unsigned int total_iterations = 0;
> +	ktime_t start_time, streaming_start;
>   	ktime_t filltime = 0;
>   	ktime_t comparetime = 0;
> -	s64 runtime = 0;
> -	unsigned long long total_len = 0;
> -	unsigned long long iops = 0;
>   	int ret;
>   
>   	set_freezable();
>   	smp_rmb();
>   	thread->pending = false;
>   
> +	/* Initialize statistics */
> +	thread->streaming_tests = 0;
> +	thread->streaming_failures = 0;
> +	thread->streaming_total_len = 0;
> +	thread->streaming_runtime = 0;
> +
>   	/* Setup test parameters and allocate buffers */
>   	ret = dmatest_setup_test(thread, &buf_size, &align, &is_memset);
>   	if (ret)
> @@ -942,34 +976,39 @@ static int dmatest_func(void *data)
>   
>   	set_user_nice(current, 10);
>   
> -	ktime = start = ktime_get();
> +	start_time = ktime_get();
>   	while (!(kthread_should_stop() ||
> -		(params->iterations && total_tests >= params->iterations))) {
> +		(params->iterations && total_iterations >= params->iterations))) {
>   
> +		/* Test streaming DMA path */
> +		streaming_start = ktime_get();
>   		ret = dmatest_do_dma_test(thread, buf_size, align, is_memset,
> -					  &total_tests, &failed_tests, &total_len,
> +					  &thread->streaming_tests, &thread->streaming_failures,
> +					  &thread->streaming_total_len,
>   					  &filltime, &comparetime);
> +		thread->streaming_runtime = ktime_add(thread->streaming_runtime,
> +						    ktime_sub(ktime_get(), streaming_start));
>   		if (ret < 0)
>   			break;
> +
> +		total_iterations++;
>   	}
>   
> -	ktime = ktime_sub(ktime_get(), ktime);
> -	ktime = ktime_sub(ktime, comparetime);
> -	ktime = ktime_sub(ktime, filltime);
> -	runtime = ktime_to_us(ktime);
> +	/* Subtract fill and compare time from both paths */
> +	thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
> +					   ktime_divns(filltime, 2));
> +	thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
> +					   ktime_divns(comparetime, 2));
>   
>   	ret = 0;
>   	dmatest_cleanup_test(thread);
>   
>   err_thread_type:
> -	iops = dmatest_persec(runtime, total_tests);
> -	pr_info("%s: summary %u tests, %u failures %llu.%02llu iops %llu KB/s (%d)\n",
> -		current->comm, total_tests, failed_tests,
> -		FIXPT_TO_INT(iops), FIXPT_GET_FRAC(iops),
> -		dmatest_KBs(runtime, total_len), ret);
> +	/* Print detailed statistics */
> +	dmatest_print_detailed_stats(thread);
>   
>   	/* terminate all transfers on specified channels */
> -	if (ret || failed_tests)
> +	if (ret || (thread->streaming_failures))
>   		dmaengine_terminate_sync(chan);
>   
>   	thread->done = true;


