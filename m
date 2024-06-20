Return-Path: <dmaengine+bounces-2447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64AD910BD9
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5892A1C2113E
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00541B151D;
	Thu, 20 Jun 2024 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYBFF2he"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36381B1435;
	Thu, 20 Jun 2024 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900225; cv=none; b=n9ICYJzio3SZ8IJS7yKVjpeU8DXiPtyQsuD+FtXbrTvMvNjj6j2ghq/L7YO4o7bm2+MKfa2l653gjbgHrnB6sEdQmdl/ZSK2LIW8GHr7Dc5OF91s2cyEr2Plu0J2kUTCYVR5EZkmVBzJ3jbntbB2/3wPfGQqTF+lABNb+ZumAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900225; c=relaxed/simple;
	bh=cIn4IAYucHLlyNmqD+MKWztwW70sK5v69/WFTeyPL3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKsYZ9CLTYmG31bbJ3IoMl5CTunvet1BcuK4c4IFHeBgGXC3tzq0saArYV3U+1sHWaJg9bhdcqUv1kSZ8bJdQDLs32PFqm/UQcmwAKz4arN6kjC161ECgEbwub6nut3BwV16NAP9ihlEHqg3i08Uqtlth3KlRzc+JHkK6j/orGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYBFF2he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D79C2BD10;
	Thu, 20 Jun 2024 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900225;
	bh=cIn4IAYucHLlyNmqD+MKWztwW70sK5v69/WFTeyPL3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYBFF2he35hujPNRuM19I3BCEqxslTAsV8egyyB7QyHq7LznsRXWuR0CKO4++Yd4c
	 o4Zm050RcjM1V6yp+o0ADU+ZBdyRCGcVYGxaJLo8tzunUoCF+A4vynyqF+oCXQxfsO
	 MNCbwjnDGDkA2W/oobBjp0vHqL1noMZ6hydlExxslQL1OUVhAf6erSZFBzOo9Ueji1
	 So+mqMiMAD9gzbTt1lbzqfb9EQpg39mpKsjTRzWkMnxIj0gPc89oAIUv15j93ELR01
	 zDCiue0bedpKbHVUiCCJmd+OsM+kEx+p+eMKtcZWulz0xtmHJ6/VNzGdrCr98ngzhr
	 +BBZtALOiW2WA==
Date: Thu, 20 Jun 2024 21:47:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jie Hai <haijie1@huawei.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Li Zetao <lizetao1@huawei.com>, Guanhua Gao <guanhua.gao@nxp.com>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] dmaegine: virt-dma : Fix multi-user with vchan
Message-ID: <ZnRV_fE8QViZG66o@matsya>
References: <20230720114212.51224-1-haijie1@huawei.com>
 <20240620025400.3300641-1-haijie1@huawei.com>
 <ZnQ/AyffdW+u9C8P@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQ/AyffdW+u9C8P@lizhi-Precision-Tower-5810>

On 20-06-24, 10:38, Frank Li wrote:
> On Thu, Jun 20, 2024 at 10:53:53AM +0800, Jie Hai wrote:
> > List desc_allocated was introduced for the case of a transfer
> > submitted multiple times. But elegating descriptors on the list
> > causes other problems.
> > 
> > For example, in the multi-thread scenario, which tasks are
> > continuously created and submitted by each thread. If one of
> > the threads calls dmaengine_terminate_all, for dirvers using
> > vchan_get_all_descriptors, all descriptors will be freed. If
> > there's another thread submitting a transfer A by
> > vchan_tx_submit, the following results may be generated:
> > 1. desc A is freeing -> visit wrong address of node prep/next.
> > 2. desc A is freed -> visit invalid address of A.
> > 
> > In the above case, calltrace is generated and the system is
> > suspended. This can be tested by dmatest.
> 
> What's test steps to reproduce this problem?

I think I have asked in past (dont recall if that was this or some other
one), hopefully will get to hear on this one..

PS: Good hygiene to trim replies

-- 
~Vinod

