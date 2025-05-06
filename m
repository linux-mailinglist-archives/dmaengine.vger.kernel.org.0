Return-Path: <dmaengine+bounces-5088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D64AAC592
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60357170451
	for <lists+dmaengine@lfdr.de>; Tue,  6 May 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDAA280317;
	Tue,  6 May 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="goyhPkSx"
X-Original-To: dmaengine@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0A44C77;
	Tue,  6 May 2025 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537409; cv=none; b=JKTNiP0ayF7Ot9YTCODEI6CklSf7Ajq1msPO5hwVYRx+t3bBxkI25j07GXFcoakpUooyWhiZl0Mbc5o1hmJA7KFTjnAxLjgXPvuMyTQKoZT9XlFsT8GZkbzgQD4nZ/vmRsC0Oz+x6+gCisbcLOFB2VSHiP4hQkPI80XWaJ6VmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537409; c=relaxed/simple;
	bh=UqymppTEr1VZkqJxNIzJh3hxeEyChL2MGB2hmF7Mwqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIZBsrnzFq5sqPnMFwhrc3zkk3px9Opww0Owicdbzh3SUHGriUeXkrkobca/qNUDKfNxaqUT1SjU47qlVqSmeYA7E/grX6KJv1+ZcoDbjDeR5FHNFmclhkTUoc65PRAnEcpLIEUrmhr4BV0++1vVWF+pPXH7n+IGWR6b7iQw7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=goyhPkSx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A48F41080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1746537407; bh=Hk6lHS1hQLdz0zYjilqw4/ewKuu5RRAXRVBkjPfOJFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=goyhPkSx3xzUiquER369Ft9RBz+uLKPDWPoipe7v2COQyz74UX9kDzE1UT8PQ/VK6
	 lSp7fSpIifGg+iwHwGcJZAint8XZyobq4Fl9qqpjBm8Gt1tphRV2K0NTvAzMWsdFrx
	 vKIF5vnkGY2HzJSZRi3hAczdiF1rNghlC5M4k865zkh8CVWiwzjzmiqLUXds2S1oQf
	 zfa4H1EMN84x/xjRAWesXyEOi/XKreBe+1rZ2ysQO6VAwLF9U5dh95p0zjJu0o/NEE
	 Upl61EPRFYWz/tUNmxKUMW/oMI/+4In70p7xo0zFWuDh/Z+4OsQPb5JDjlzAHIY9Fq
	 VVdAqPQ9lyHVw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5A48F41080;
	Tue,  6 May 2025 13:16:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: kendrajmoore <kendra.j.moore3443@gmail.com>, dmaengine@vger.kernel.org
Cc: vkoul@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: Re: [PATCH] docs: dmaengine: add explanation for DMA_ASYNC_TX
 capability
In-Reply-To: <20250421010205.84719-1-kendra.j.moore3443@gmail.com>
References: <20250421010205.84719-1-kendra.j.moore3443@gmail.com>
Date: Tue, 06 May 2025 07:16:42 -0600
Message-ID: <871pt1x4jp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kendrajmoore <kendra.j.moore3443@gmail.com> writes:

> From: Kendra Moore <kendra.j.moore3443@gmail.com>
>
> This patch replaces the TODO for DMA_ASYNC_TX in the DMA engine
> provider documentation. The flag is automatically set by the DMA
> framework when a device supports key asynchronous memory-to-memory
> operations such as memcpy, memset, xor, pq, xor_val, and pq_val.
>
> It must not be set by drivers directly.
>
> Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
> ---
>  Documentation/driver-api/dmaengine/provider.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

