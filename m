Return-Path: <dmaengine+bounces-8868-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO0JNdH7imlyPAAAu9opvQ
	(envelope-from <dmaengine+bounces-8868-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 10:35:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AF118F01
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEF663011152
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3EB33F8B8;
	Tue, 10 Feb 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYXa70GN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80529BDAA;
	Tue, 10 Feb 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716111; cv=none; b=uL/Q7YEkm1FdwSc31F4MSkph4+kol7+Hx7PBpry43o2APRLHHKz8ZyIh7I1h6rYyexH0rW8YaNJL9joK2+v+eUShcKDaIDGZUqPOVCqrOZ3upGB9jhZTMRQkmEZWdSMMIfd7FcQ7j0pVveR2APmJf1GmlpdzsCMrneO41Bco3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716111; c=relaxed/simple;
	bh=qLApdMWtpjsrybaOBv+5Y5DwUbzF9WTlqL/fs5gG75M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZagznbebaJHsxTsmUjciwLMe0CpMMeu7HZGQnnz779jDqF6kDF2lMkB3KR4Qt51BUjkYeEJqtvY2PwWGVz4GZ3DbrUWRHDcFzXgoGAuq3MGjN0Iktj36DhPGtDC03q3KzJN2k3atZCRBF1cTlyZo7pzyglTF8w+mNCeW4t2nVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYXa70GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A4EC116C6;
	Tue, 10 Feb 2026 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770716110;
	bh=qLApdMWtpjsrybaOBv+5Y5DwUbzF9WTlqL/fs5gG75M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYXa70GNq4NkvKJAti6EdUW56bcSPceeAl8O3fCAVLhUKmvtliGp0OYcXcHumAks5
	 mGIbu2hUr9P0ysmJUtJ13Ovx+/uR8RC+7hgTS76JOcvfXbFTj51zZ7Xb0Xh7CoHPRk
	 WridwzHnxyiytBNvJpZR8EGqTJaEI1zTbUiAwbGqQVxRVXlq8/o00lCXmAy2nzjFxA
	 wjmr+HphrD/xi11Knu+N2LvGMwl1d169dal+xG+OAUnh39lgOMfO3kjwUlgtmZu2GU
	 QQoRqqZm2c1pDT/JBEqFYDYnbvlAnZQj4sPeShBLriw+PQcumVK87FOBhLk4qO280h
	 O+GHJ5kluNm4g==
Date: Tue, 10 Feb 2026 15:05:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pat Somaru <patso@likewhatevs.io>
Cc: Tejun Heo <tj@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] dma: apple-admac: Convert from tasklet to BH workqueue
Message-ID: <aYr7y6C3aNIC-Sbc@vaman>
References: <20260206221143.1261191-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206221143.1261191-1-patso@likewhatevs.io>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8868-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 797AF118F01
X-Rspamd-Action: no action

On 06-02-26, 17:11, Pat Somaru wrote:
> The only generic interface to execute asynchronously in the BH context
> is tasklet; however, it's marked deprecated and has some design flaws
> such as the execution code accessing the tasklet item after the
> execution is complete which can lead to subtle use-after-free in certain
> usage scenarios and less-developed flush and cancel mechanisms.
> 
> To replace tasklets, BH workqueue support was recently added. A BH
> workqueue behaves similarly to regular workqueues except that the queued
> work items are executed in the BH context.
> 
> Convert apple-admac.c from tasklet to BH workqueue
> 
> Semantically, this is an equivalent conversion and there shouldn't be
> any user-visible behavior changes. The BH workqueue implementation uses
> the same softirq infrastructure, and performance-critical networking
> conversions have shown no measurable performance impact.

I would prefer this move to dmaengine specific work of Allen. That is
more apt imo
[1]: 20260108080332.2341725-1-allen.lkml@gmail.com

-- 
~Vinod

