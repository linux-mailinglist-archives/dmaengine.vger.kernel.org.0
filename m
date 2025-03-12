Return-Path: <dmaengine+bounces-4709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C374A5D8AD
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 09:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E513B60F9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6B236A8B;
	Wed, 12 Mar 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="cA6WoRrI"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6144236434;
	Wed, 12 Mar 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769592; cv=none; b=I5vx9IjFaIT9nZ1Gk9Fn6XkSVWZfXIrPP+5xNRRnXrHqo1DJFHI0vBZu9bdMqk8uR/oucC8m6ncOBIxAkmk7Uq2hd3jiqhPzUwoJvCfUw+aKdd1JAOSvYsKZcL0WbdGjSZGN0Ih0djr5d070zT2AbFbupX59nYPa0gbFuguqM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769592; c=relaxed/simple;
	bh=F5V0MKowf2JDzxxZKfhQHTUo1BEp1LSgfrCTL90txrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FpSH9EcHhxsYBF3h4THdU1SD43sQzJ8G1Uh00Xtp9OqXXdr/ZQU74BmgUC3GU4WUN+QnXn97z3lUGqrB3a5vroWDRMdskRI7wwpEu3Gei3tutfdm9/J0yftvcoCjQfki9vPRtV72pBq/IjhU+BRHHMNsTkeOGsYVfyyFE9QtrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=cA6WoRrI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 15D44A0899;
	Wed, 12 Mar 2025 09:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=JiVJU8vpI1AzUUyUc/XP
	lRSfdp4+hku0cXCtyGPLMbc=; b=cA6WoRrI5U/yz2OLyFMpnhEGEovu6aQOMXxI
	lC941G06oI+Ls70GNgzE+ffCn8elNqqxlZR3+iUQS4tpVKCvhMfQ1ENdyVEOifEt
	bMn5myL3EPV8r84zIqOmf9sSz7GjzTOMIF11UOP7kGdktJNpljs/bAdAqU8VIvi+
	roFFmXrxTu9HgVqEm2GMNxOVbNwzcULdVaVwq6jbaxxZuKUJkufQhABm5R91cTxA
	wv/fz7qla5xz0uVEpKrRgjmCXDCT6CLQIUwOYsrxuT8H8IHDxzAFcibcYbuCkqY3
	BmXZcS+hXgMMDxM2cLzobcIkPbbttuaO5/vCeX8JW4O6iNGWa3WHOTKBr5KpxHvU
	1IeFLBNlKJ7Nm7/B0XVaahEV+WaeLDzlLPQV+0BRgye1wiZ5LgZCR5P6jXX7Cqrj
	GFAHOhW0QijeuVcGZd/bW0nGxL3rV6/LAQzqM2rCrTxeGSbfX+SNVYAbLoEL+Fam
	PMDhhqFl8/JAfmKnungDQEW4CL0RH6JPUCwokGcMUBc4bWpQ3goGfNAyoD+fmlTc
	VnkQ4stbUT5i65GtQZyAr6GEmZSYAPaALHAWlSeK0vKy0qemFv/kLS575KZM1/s7
	vt/x0nkNsnkQdOn4SC9+WRpvg2vq77GKIvKk+pSbPBUhsPlaC/Dy/MUgopvD3Anu
	wzbdQ2U=
Message-ID: <81f87d39-d3f8-4b6a-91cb-b0177d34171b@prolan.hu>
Date: Wed, 12 Mar 2025 09:53:04 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma-engine: sun4i: Use devm functions in probe()
To: Markus Elfring <Markus.Elfring@web.de>, <dmaengine@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
 <885ceb3e-d6c6-4e7b-a3b6-585d2d110ccf@web.de>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <885ceb3e-d6c6-4e7b-a3b6-585d2d110ccf@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852627362

Dear Markus,

On 2025. 03. 11. 20:33, Markus Elfring wrote:
 >> Clean up error handling by using devm functions
 >> and dev_err_probe(). This should make it easier
 > …
 >
 > You may occasionally put more than 47 characters into text lines
 > of such a change description.

It was an old patch I hadn't yet reformatted to 75 cols. I used 50-60 
cols before, because my mail client's preview panel is very narrow, so 
anything more than ~65 characters will wrap. If there will be a v5, I'll 
reformat it to 75 cols as well, as per the style guidelines.

> How good does such a change combination fit to the patch requirement
> according to separation of concerns?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc6#n81

It is a general refactor patch, it shouldn't change any functionality. I 
could split it to one part introducing `devm_clk_get_enabled()` and the 
other `dmaenginem_async_device_register()`, but I don't feel that to be 
necessary, nor does it bring any advantages I believe.

> Regards,
> Markus

Bence


