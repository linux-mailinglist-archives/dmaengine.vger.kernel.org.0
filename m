Return-Path: <dmaengine+bounces-2373-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1BD9095F3
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 06:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D431C214C8
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 04:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD29D53B;
	Sat, 15 Jun 2024 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MjJ9h1N+"
X-Original-To: dmaengine@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F0C2C6;
	Sat, 15 Jun 2024 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718424160; cv=none; b=sSCIg6PPGbf+UNHSL2H7zWfmf7nwmnn1hFHS7biZBNe8o91EU7MUevvqYJrwd0LXzbclHcPhkvwERLcCuhavz6kPyK3xjl/nwsm8bxlzEoFiy9WHscDkCSOjux8VTJ0c/ZipLKrBwToLqI1fgMhu1Bb7m4kxD7vysA48ly/zerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718424160; c=relaxed/simple;
	bh=LZNx7mxqLg870nPh8j1QNCUMFJMicd84KfTSuzUrz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECd6D2zgycRVghh7B3pK9Ifv5QsJ65LS5qfC/vgb5bR/gCJ8V4vG8r8y/cdQPvqF9zuwXUN8mJL32EXutLyqiOHFJvMFZfQiCjKt9r3Y/PE750CBAkOXnoYj29zifE/LUR4xZa7IKcRAMvEmz7EOZuUwieFsAhkPkmF1bvnp1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MjJ9h1N+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NXexhGWDYtYr0oJSzk1NG3eD/CO5/DdYrVVL4DBvufA=; b=MjJ9h1N+6YRmBqezbqDVal17LT
	nhmk778fNc40LaKkMmKjaKlk33Q084Abzd4oND4RErPAowJYTzK8jXTxntZJuy9ysC3KaV4SyYx/4
	vNwx9NeEHDv79hI2/RXqytpEcTZvQhq3hK/4XtIkW8aYuyXt+erd5mRmWqmZQHqOl/5zrKr/p/4TZ
	mbSP0KSi4XfOkFfgP7jgyxNaa5drT/4oVOG15DLFDfrrH2CWqh2LUkyB8aobk/Swd2wPxXI4hzAT0
	51k9Vtx/un4S37Clhznni0YL/8Dc5KilIQF7AJ3fQt3f0EZp+ul+nn9YbM9bys0lu/XVtxLTu7tzQ
	o1v+kinw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIKcb-0000000HZXR-3dUg;
	Sat, 15 Jun 2024 04:02:33 +0000
Date: Sat, 15 Jun 2024 05:02:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bharata@amd.com,
	raghavendra.kodsarathimmappa@amd.com, Michael.Day@amd.com,
	dmaengine@vger.kernel.org, vkoul@kernel.org
Subject: Re: [RFC PATCH 0/5] Enhancements to Page Migration with Batch
 Offloading via DMA
Message-ID: <Zm0SWZKcRrngCUUW@casper.infradead.org>
References: <20240614221525.19170-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614221525.19170-1-shivankg@amd.com>

On Sat, Jun 15, 2024 at 03:45:20AM +0530, Shivank Garg wrote:
> We conducted experiments to measure folio copy overheads for page
> migration from a remote node to a local NUMA node, modeling page
> promotions for different workload sizes (4KB, 2MB, 256MB and 1GB).
> 
> Setup Information: AMD Zen 3 EPYC server (2-sockets, 32 cores, SMT
> Enabled), 1 NUMA node connected to each socket.
> Linux Kernel 6.8.0, DVFS set to Performance, and cpuinfo_cur_freq: 2 GHz.
> THP, compaction, numa_balancing are disabled to reduce interfernce.
> 
> migrate_pages() { <- t1
> 	..
> 	<- t2
> 	folio_copy()
> 	<- t3 
> 	..
> } <- t4
> 
> overheads Fraction, F= (t3-t2)/(t4-t1)
> Measurement: Mean ± SD is measured in cpu_cycles/page
> Generic Kernel
> 4KB::   migrate_pages:17799.00±4278.25  folio_copy:794±232.87  F:0.0478±0.0199
> 2MB::   migrate_pages:3478.42±94.93  folio_copy:493.84±28.21  F:0.1418±0.0050
> 256MB:: migrate_pages:3668.56±158.47  folio_copy:815.40±171.76  F:0.2206±0.0371
> 1GB::   migrate_pages:3769.98±55.79  folio_copy:804.68±60.07  F:0.2132±0.0134
> 
> Results with patched kernel:
> 1. Offload disabled - folios batch-move using CPU
> 4KB::   migrate_pages:14941.60±2556.53  folio_copy:799.60±211.66  F:0.0554±0.0190
> 2MB::   migrate_pages:3448.44±83.74  folio_copy:533.34±37.81  F:0.1545±0.0085
> 256MB:: migrate_pages:3723.56±132.93  folio_copy:907.64±132.63  F:0.2427±0.0270
> 1GB::   migrate_pages:3788.20±46.65  folio_copy:888.46±49.50  F:0.2344±0.0107
> 
> 2. Offload enabled - folios batch-move using DMAengine
> 4KB::   migrate_pages:46739.80±4827.15  folio_copy:32222.40±3543.42  F:0.6904±0.0423
> 2MB::   migrate_pages:13798.10±205.33  folio_copy:10971.60±202.50  F:0.7951±0.0033
> 256MB:: migrate_pages:13217.20±163.99  folio_copy:10431.20±167.25  F:0.7891±0.0029
> 1GB::   migrate_pages:13309.70±113.93  folio_copy:10410.00±117.77  F:0.7821±0.0023

You haven't measured the important thing though -- what's the cost _to
userspace_?  When the CPU does the copy, the data is now cache-hot in
that CPU's cache.  When the DMA engine does the copy, it's not cache-hot
in any CPU.

Now, this may not be a big problem.  I don't think we do anything to
ensure that the CPU that is going to access the folio in userspace is
the one which does the copy.

But your methodology is wrong.

