Return-Path: <dmaengine+bounces-11105-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OOMGr+bHWpucgkAu9opvQ
	(envelope-from <dmaengine+bounces-11105-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 16:48:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B2621258
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F546301CF9F
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9BB3BED79;
	Mon,  1 Jun 2026 14:43:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB33B4EA3;
	Mon,  1 Jun 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325017; cv=none; b=gNoP+6AuYZ1qiaCdHf3h3plWjGTrHVxs5fyuHZ9hLLiLYWSbl75fPpUsCT/jme7H+DMS4fo01ok6VaZ+LasqWio1ygiST+ZC++dMw7tUQX2iXdvDuiaTDccNxFFFHmNKes8+jiaBqGorRjC74vjWK6i/PWNBDHydmOdC8bMK25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325017; c=relaxed/simple;
	bh=m5ZUc4gAQRze2UVAcz5pyvxHsM4wU7vTSIol0yQAQwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiMox9BHMJLlwKxA+j6iRpU193t/oMSWmWiTgcBYYehupGFBbcUyriYA5hafNk7HinP31/m+aUOHQXOkJ5Xiw6tkbsxyAJZXyQX554lMd+xS35fs1b4an6DRyMxQ/rHObjKhivCPdF2IZ2xhmqe0pLExxN86KnoIPv0lEwCp4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB2CC68B05; Mon,  1 Jun 2026 16:43:32 +0200 (CEST)
Date: Mon, 1 Jun 2026 16:43:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
Message-ID: <20260601144332.GC4918@lst.de>
References: <20260506142644.3234270-8-gerg@kernel.org> <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org> <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com> <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com> <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com> <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com> <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com> <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com,lst.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11105-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 169B2621258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 11:42:26PM +1000, Greg Ungerer wrote:
> I don't think that is right. The way the underlying data cache is setup for
> MMU ColdFire (via the ACR/CACR registers) means that individual pages cannot
> be marked as non-cached. So coherent memory allocations are not possible -
> at least the way things are today.
>
> It would be possible to set aside a chunk of RAM at kernel startup time
> to use as a pool for coherent allocations (since it could be marked as
> non-cached via the ACR/CACR registers), but there is no code to support doing
> that today.

With CONFIG_DMA_GLOBAL_POOL there is some generic code dealing with
most of this.  But if this driver worked on coldfire in the past,
it must have been fine with non-coherent memory and could use the
non-coherent allocator.


