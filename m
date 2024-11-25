Return-Path: <dmaengine+bounces-3785-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A809D7B84
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 07:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B411B21BE4
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F22AE8B;
	Mon, 25 Nov 2024 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kx1K2Y0C"
X-Original-To: dmaengine@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD42500D4;
	Mon, 25 Nov 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732515629; cv=none; b=fXGUs04q9ecw6eb8Jmiol+eyu+Oe0cCecsnT3y5h0hTQ6wi2cK/74cTyzHuiDNGT5kfcZStkbBdCm6oUZ7Tm5lcMpnF4hQyRYjayu2eHRx4LG7/KsH158Mz9MosyiVrS0OrUB2mhpqUQrbsYBAttrmwrSGjkLAhvF2wSK52EI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732515629; c=relaxed/simple;
	bh=H0hIHo+j7tFERzCwMpOSZLAL0avY/bF56wggpRA1N+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4xFqLBDQ6XZ1R4EuIijlLdK3O2gvgoFQTyiPU+7HunZ21lrnYpUNP7dn8wiY16hpnvqoD84Bf1f3XZYczjOC4BIfg/b3V5SSccse/q7d9u9kUnaxJDmuTisOSFhhOcufSSFrGE8Q00i9WqlCNwo98wgs+Z5Mtac+TdBOg08roQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kx1K2Y0C; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3yY5NzRkkDBzt2qTYPlQ4oirItUStfq2fgaKZBugjpU=; b=kx1K2Y0C0owOQ53aJ4TafJBGgi
	JozvLZW/pcspd/xpc2dJxXZF6VFGn9ylFpoa+GogWartGkYoiHSwTMu3QjphMYXc39TQFi5at9X67
	iXtDI1HVzIf4ystiqRTYHLl2dq2QNKl8bCYfO1XWZpUgmMp8ACZmuSZmcqFeP48d2KDh8eJEmBlwu
	tU7YY24N3rDAgeLiW5vt9QYafKyz6aSB9UQlkQ/JDekEEEdlwiISPcEUXiknAGOM9Jyhur6n+7zD0
	dCy732FZgc+urNu4Z3W1O0/yzsjsSO2jXwcrgcdwdinqsvx96lYvWsdQ1ktTpKB976NRA2HBmcTL5
	HShcXOjA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSSN-000000013RY-44UR;
	Mon, 25 Nov 2024 06:20:24 +0000
Message-ID: <1dcee6d5-761b-4fa2-a336-c23d3aaadcb9@infradead.org>
Date: Sun, 24 Nov 2024 22:20:19 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux/dmaengine.h: fix a few kernel-doc warnings
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Paul Cercueil <paul@crapouillou.net>,
 Nuno Sa <nuno.sa@analog.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
References: <20241125061508.165099-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241125061508.165099-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/24 10:15 PM, Randy Dunlap wrote:
> The comment block for "Interleaved Transfer Request" should not begin
> with "/**" since it is not in kernel-doc format.
> 
> Fix doc name for enum sum_check_flags.
> 
> Fix all (4) missing struct member warnings.
> 
> Use "Warning:" for one "Note:" in enum dma_desc_metadata_mode since
> scripts/kernel-doc does not allow more than one Note:
> per function or identifier description.
> 
> This leaves around 49 kernel-doc warnings like:
>   include/linux/dmaengine.h:43: warning: Enum value 'DMA_OUT_OF_ORDER' not described in enum 'dma_status'
> 
> and another scripts/kernel-doc problem with it not being able to parse
> some typedefs.
> 
> Fixes: b14dab792dee ("DMAEngine: Define interleaved transfer request api"), Jassi Brar

Oops, I left a note in the line above. I'll fix it for v2 after comments.

> Fixes: ad283ea4a3ce ("async_tx: add sum check flags")
> Fixes: 272420214d26 ("dmaengine: Add DMA_CTRL_REUSE")
> Fixes: f067025bc676 ("dmaengine: add support to provide error result from a DMA transation")
> Fixes: d38a8c622a1b ("dmaengine: prepare for generic 'unmap' data")
> Fixes: 5878853fc938 ("dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>  include/linux/dmaengine.h |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)


-- 
~Randy


