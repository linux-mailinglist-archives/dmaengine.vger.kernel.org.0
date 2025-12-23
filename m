Return-Path: <dmaengine+bounces-7874-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F0CD908B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62C4D302034B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFE2F39B1;
	Tue, 23 Dec 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiFN/5Pr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8A18EFD1;
	Tue, 23 Dec 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488062; cv=none; b=k+SHuR8fA4VrMjYkBHItptY4KJaafoZZXoJZB+VuFYbiVCAT+BNV5Sq3s6dMBpgy/izfa+uu8gWTu/+rwksoISzfFLmQv8ArXyMRCjEPzmpaZQdi8wvI0aFOYhmGTiCpOVa2xC13LeKoyy0jePA91dbbCX6+99Iy54SlOSfSas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488062; c=relaxed/simple;
	bh=gUjbEFknRhqasS6YRgpYb1eKphkZZ4QNS7vc6zMwKv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/e+AvcLbhCNMe2lThyFjTlaEU5oHzAO2wqL6mI27rgn0wON2Np9yaT4G70rwXiRM6X1jikalGckARj81/a3haj4QTMgx1JO3VkIfu3YKq5NEKoR5jmvygpBLAutktrqyV55ga/v593Dx6WpkM360/9nzUkBQX8kDuZgbIv7OYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiFN/5Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CE9C16AAE;
	Tue, 23 Dec 2025 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766488061;
	bh=gUjbEFknRhqasS6YRgpYb1eKphkZZ4QNS7vc6zMwKv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiFN/5PrQ2w/+2leMeDnqGDYFc2IeiCM50MOSnVQNcoia/DA/kkJ4pNo1BE4nBSqo
	 L9lN60xgo33ajpwGuVbVxp5nyYdvYu12QuM/bGJ+/TzE6o9lhKYsJH4Hs3mvKVaMLE
	 N0XFwwG96DNl+3DzfNaAcdRuUEZ73Nv8fFQnLwm7Z77CIzVZHMh1IEQZ1b+YS/R0AH
	 Zl7DXDSxoSBwcEFSj8+E8iYyF8cMMA4ORpEJzEuiYUrsPxrev5NxBFg7ODJqaIAcok
	 SzFYYICMigWpo06r5aJQdcRVWSanz2vfYXvwNiunrhGswhaL+SQCikPCD04Vy8j3qL
	 fL9C8ilJ7e/cA==
Date: Tue, 23 Dec 2025 16:37:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 dmaengine 0/2] mv_xor: some devm cleanups
Message-ID: <aUp3-WM1DM2HQMFy@vaman>
References: <20251105210317.18215-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105210317.18215-1-rosenp@gmail.com>

On 05-11-25, 13:03, Rosen Penev wrote:
> Some devm cleanups that are now possible.
> 
> It's interesting that this driver lacks a _remove function to free its
> resources...
> 
> v2: resent with dmaengine prefix

Not required to add this in within []..
[PATCHv4 0/2] dmaengine: mv_xor..  would be fin

I cant apply this as it fails for me, please rebase

> v3: add error handling for devm_clk_get_optional_enabled to potentially
> handle EPROBE_DEFER.
> v4: remove request_irq based on feedback.
> 
> Rosen Penev (2):
>   dmaengine: mv_xor: use devm_platform_ioremap_resource
>   dmaengine: mv_xor: use devm_clk_get_optional_enabled
> 
>  drivers/dma/mv_xor.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> --
> 2.51.2

-- 
~Vinod

