Return-Path: <dmaengine+bounces-3340-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73699C726
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE4F1C22762
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212E715CD64;
	Mon, 14 Oct 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikZEIJ/q"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBA156C69;
	Mon, 14 Oct 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901745; cv=none; b=BlllqkqbXk0EUHG/GBaLOPUlvqEef/9euzpzwAIqwIcyLVHDMElhBdxPGsAKkY+96lCZdQdJ/eKVy5MljuLuvDJ5hQxniF8NsGGVKclR9ik8r5Lu3KhY0gwMAXtb6IPCHkkSVbqtcc8IyXOHm2gDaMJGr/AXeCP8LCYMJmm/3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901745; c=relaxed/simple;
	bh=sV4Rp0TPVdzNhXz3lQhbAY5z63glc6lEzRRa41dAlHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+UffQVTqSpXYtYP+TZvHKeKr4VHO0c00KdVY7Bz0ZkmKX+HXbZz1N/pJVngID3hlO1skqNnn5ZBekWaTWVK5P5EtV5tplZqdK+6Wp4STveRM2FmRDIeQ7xzUgbpj7O6+83rIOHaF/PFmlNE7wov7CB/hEdwy0ROcfa1rI3Umnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikZEIJ/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30349C4CEC6;
	Mon, 14 Oct 2024 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728901744;
	bh=sV4Rp0TPVdzNhXz3lQhbAY5z63glc6lEzRRa41dAlHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikZEIJ/q02U0sgjPnYZhDgFSO09fOvHPApoO/qznd/NsKTgq3fuYKg+kXdQTGNoEZ
	 ZdFP15gv+6ZSyxLOY2vpWe0MBh7ZPpkBcKv3Tb8GreZmO9kMzaoI9uwelL2IjjNl1K
	 jD+ZzMqTMRAlNrfljDijm7JGdgsjeAji5YeZ9YYpK5UaHToAZIvGR693yNbzd9d0Xr
	 QPawXFjCLH4+C1hfbNJuxRoa1chGFiuBxqD4qAa77jUYwF+rR5fGD54Qx8MvXtm6j5
	 uHpxIbm+YJW4fX2DBOBHsPjR/Q7mpg942cp4wID2LsxrsUMfgq1PY70kbK8DN5Fjbn
	 Hdfns0E4XIb0A==
Date: Mon, 14 Oct 2024 11:29:00 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.12-rc3
Message-ID: <20241014102900.GS77519@kernel.org>
References: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
 <20241014072731.3807160-1-geert@linux-m68k.org>
 <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>
 <20241014085819.GO77519@kernel.org>
 <CAMuHMdWedOgc4S12FwQR8_80aqgRJ2pwrKWsNb5Svt6776ti3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWedOgc4S12FwQR8_80aqgRJ2pwrKWsNb5Svt6776ti3Q@mail.gmail.com>

On Mon, Oct 14, 2024 at 11:18:14AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Oct 14, 2024 at 10:58 AM Simon Horman <horms@kernel.org> wrote:
> > On Mon, Oct 14, 2024 at 10:38:20AM +0200, Geert Uytterhoeven wrote:
> > >   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]:  => 126:37
> > >   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]:  => 126:46
> >
> > I wonder what the correct string format is in these cases?
> > I didn't have a good idea the last time I looked.
> 
> "%pa" + taking the address of the resource_size_t object.
> 
> https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229

Thanks,

These format problems seem to have been introduced quite some time ago
by commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string").
I'll send some patches to address the ones introduced by that patch
that I was able to still find in-tree.

