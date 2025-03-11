Return-Path: <dmaengine+bounces-4701-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BDAA5C1A2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7F63A9E1A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A222FF22;
	Tue, 11 Mar 2025 12:48:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6921660F;
	Tue, 11 Mar 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697317; cv=none; b=RCgFZ2SyDtfyqO4jzeghSp7fWgUIN4LBYRQUAFalXxHxZXWd3es9FTCuqRz9+YgIOpRIKuFelRnqO7+bf7aqldCdlFgtbVaH9CKfEV3ZP4buLK8ebydjDQe1d3/7Kkc7IIhR0/NXLVcpajeLVGV1ASibjhyhhzWSnBoVl6IVew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697317; c=relaxed/simple;
	bh=fNfmtHdXf9BoyEH/qA20u3R7qett2R6u5Ubso+unVKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdkklfuYFJ4l9fgWgNFLGclCF9rIwkcj+GsnVAzLpOI25V4u3nLdQtv2j9tdbBzRZD09GnN7Zh5pLkVdOJPc28CZ6J+UHvdusPoPdW36jMQy+rYivEoRW3t/Uqdwj+OUs9w1U7aV37FLWoU1um2I7rQ69Xw4JQ1RBO5SvBjNa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98DE1152B;
	Tue, 11 Mar 2025 05:48:45 -0700 (PDT)
Received: from [10.57.37.142] (unknown [10.57.37.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABE503F673;
	Tue, 11 Mar 2025 05:48:33 -0700 (PDT)
Message-ID: <072d1d3a-2aeb-4ab0-9db1-476835a1131e@arm.com>
Date: Tue, 11 Mar 2025 12:48:32 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
To: Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1740762136.git.robin.murphy@arm.com>
 <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>
 <Z89P461+Y6kQDOCX@vaman>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z89P461+Y6kQDOCX@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-10 8:47 pm, Vinod Koul wrote:
> On 28-02-25, 17:26, Robin Murphy wrote:
> 
>> +static u32 d350_get_residue(struct d350_chan *dch)
>> +{
>> +	u32 res, xsize, xsizehi, hi_new;
>> +
>> +	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
>> +	do {
>> +		xsizehi = hi_new;
>> +		xsize = readl_relaxed(dch->base + CH_XSIZE);
>> +		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
>> +	} while (xsizehi != hi_new);
> 
> This can go forever, lets have some limits to this loop please

Sure, in practice I doubt we're ever going to be continually preempted 
faster than the controller can move another 64KB of data, but I concur 
there's no harm in making the code easier to reason about at a glance 
either.

>> +static int d350_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct d350_chan *dch = to_d350_chan(chan);
>> +	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
>> +			      dev_name(&dch->vc.chan.dev->device), dch);
> 
> This is interesting, any reason why the irq is allocated here? Would it
> be not better to do that in probe...

Well, I'd say technically the IRQ is a channel resource, and quite a few 
other drivers do the same... Here it's mostly so I can get the channel 
name - so the IRQs are nice and identifiable in /proc/interrupts - 
easily without making a big mess in probe, since the names don't exist 
until after the device is registered.

Thanks,
Robin.

