Return-Path: <dmaengine+bounces-1955-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E78B1D68
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FED1F257CD
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D382485;
	Thu, 25 Apr 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwI1RkiD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17796EB4D;
	Thu, 25 Apr 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035948; cv=none; b=SAE0gMDzXFBLRSk5H7c1B9qzgcQt4YGLh2BYpmYGATWpJT3NsWdFYl3oWftwlQ6sHpunOdMLQcXyCP/QYBDgV9uVBBlLwD6L+fwfOBAsQ3vKgzlvDot7URjALB1qt8N8fMV503fuYJyiNqnYdlP2gEBbDy4PAO+2bSG0RtADvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035948; c=relaxed/simple;
	bh=CyBxhvSJqvOeVqh/PVEluM40ihBbVCYqOjncj69jKxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/RGF5jtAszWjG/MI/7BgLDDMC0YUk6WyMsa4RmHfWyXP9z+xHQFumUzYywLjTj8SkhvKl3O/kTTFwoVWgiTyCtH1YdXtxIYaGjWvOPGdZCJvFKq0cauLZ15Cnf+u2Gl1KfX8d30O2sCI/aly9YtGzBd8I4taUM03rRsE5f4IeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwI1RkiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA9DC2BD10;
	Thu, 25 Apr 2024 09:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714035948;
	bh=CyBxhvSJqvOeVqh/PVEluM40ihBbVCYqOjncj69jKxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwI1RkiDn7OGmmWnZf7cVb4SHqfIG1KbOnc0Hx8VR8PYobCDWCNuCh2J2RPIw3ljG
	 PSwpaHJ2AX9MKFX0Wk2l7Jh+VEQ73UqtZE01RRzjP47b8luNRzsl4H9Bv2jEd5lUo6
	 iD6/wO2XiRxD9/NN2AT0+IgZqzjhpG7NwGau5LS+/Q26qEDYaIDDgszfgiZugsVvQB
	 TDNhrD5WF8Ev/uvWKSrADPBEFFPNA5yRcD7fG/MITceyWdK1KpcyN/kfMR1JYnA4ng
	 +maSydeNDM3zZpbr8144/T3aTHcHWrWc8A1JMx8ZR0uBwkU8TseUXxaFdMHGP6ra6j
	 GD1f69o+5A7oQ==
Date: Thu, 25 Apr 2024 14:35:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jie Hai <haijie1@huawei.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: fix timeout caused by kthread_stop
Message-ID: <Zioc6Jn9nvPVrd7j@matsya>
References: <20230720114102.51053-1-haijie1@huawei.com>
 <ZiAEbOMxy9pBcOX5@matsya>
 <d0ea4a88-900a-ad38-0580-017ae20c2fd4@huawei.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ea4a88-900a-ad38-0580-017ae20c2fd4@huawei.com>

On 23-04-24, 11:39, Jie Hai wrote:
> Hi, Vinod Koul,
> 
> Stop an ongoing test by
> "echo 0 > /sys/module/dmatest/parameters/run".
> If the current code is executed inside the while loop
> "while (!(kthread_should_stop() ||
>  (params->iterations &&
>  total_tests >= params->iterations)))"
> and before the call of "wait_event_freezable_timeout",
> the "wait_event_freezable_timeout" will be interrupted
> and result in  "time out" for the test even if the test
> is not completed.
> 
> 
> 
> Operations to the problem is as follows,
> and the failures are probabilistic:
> 
> modprobe hisi_dma
> modprobe dmatest
> 
> echo 0 > /sys/module/dmatest/parameters/iterations
> echo "dma0chan0" > /sys/module/dmatest/parameters/channel
> echo "dma0chan1" > /sys/module/dmatest/parameters/channel
> echo "dma0chan2" > /sys/module/dmatest/parameters/channel
> echo 1 > /sys/module/dmatest/parameters/run
> echo 0 > /sys/module/dmatest/parameters/run
> 
> dmesg:
> 
> [52575.636992] dmatest: Added 1 threads using dma0chan0
> [52575.637555] dmatest: Added 1 threads using dma0chan1
> [52575.638044] dmatest: Added 1 threads using dma0chan2
> [52581.020355] dmatest: Started 1 threads using dma0chan0
> [52581.020585] dmatest: Started 1 threads using dma0chan1
> [52581.020814] dmatest: Started 1 threads using dma0chan2
> [52587.705782] dmatest: dma0chan0-copy0: result #57691: 'test timed out'
> with src_off=0xfe6 dst_off=0x89 len=0x1d9a (0)
> [52587.706527] dmatest: dma0chan0-copy0: summary 57691 tests, 1 failures
> 51179.98 iops 411323 KB/s (0)
> [52587.707028] dmatest: dma0chan1-copy0: result #63178: 'test timed out'
> with src_off=0xdf dst_off=0x6ab len=0x389e (0)
> [52587.707767] dmatest: dma0chan1-copy0: summary 63178 tests, 1 failures
> 62851.60 iops 503835 KB/s (0)
> [52587.708376] dmatest: dma0chan2-copy0: result #60527: 'test timed out'
> with src_off=0x10e dst_off=0x58 len=0x3ea4 (0)
> [52587.708951] dmatest: dma0chan2-copy0: summary 60527 tests, 1 failures
> 52403.78 iops 420014 KB/s (0)


This is usefel in the commitlog, please add this and update the patchset

> 
> 
> On 2024/4/18 1:18, Vinod Koul wrote:
> > On 20-07-23, 19:41, Jie Hai wrote:
> > > The change introduced by commit a7c01fa93aeb ("signal: break
> > > out of wait loops on kthread_stop()") causes dmatest aborts
> > > any ongoing tests and possible failure on the tests. This patch
> > 
> > Have you see this failure? Any log of that..
> > 
> > > use wait_event_timeout instead of wait_event_freezable_timeout
> > > to avoid interrupting ongoing tests by signal brought by
> > > kthread_stop().
> > > 
> > > Signed-off-by: Jie Hai <haijie1@huawei.com>
> > > ---
> > >   drivers/dma/dmatest.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> > > index ffe621695e47..c06b8b16645a 100644
> > > --- a/drivers/dma/dmatest.c
> > > +++ b/drivers/dma/dmatest.c
> > > @@ -827,7 +827,7 @@ static int dmatest_func(void *data)
> > >   		} else {
> > >   			dma_async_issue_pending(chan);
> > > -			wait_event_freezable_timeout(thread->done_wait,
> > > +			ret = wait_event_timeout(thread->done_wait,
> > >   					done->done,
> > >   					msecs_to_jiffies(params->timeout));
> > > -- 
> > > 2.33.0
> > 

-- 
~Vinod

