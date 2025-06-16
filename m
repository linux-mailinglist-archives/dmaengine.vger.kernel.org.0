Return-Path: <dmaengine+bounces-5479-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BD0ADA678
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7AA188EEDC
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED8428EA76;
	Mon, 16 Jun 2025 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="en3VX0b8"
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882323AD;
	Mon, 16 Jun 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042200; cv=none; b=YKzBR/+VnbVaY62p7kDapywLg8ZgmY1txP7T+yjfCnRgvrVHneG6jcs6qD7iNwMP+vuLTX9h4vhvofHPU5Kgq6gmaPKLFwmb0nhgaMguVeOnNiXQWT62ULn6ptfyrohbPSpcJqBYfdh88+s4GZmrVzgTDTEget0MKt6TWoxaun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042200; c=relaxed/simple;
	bh=k+tMWxroKZnB/34Kb/1dvyfC++S9pbGnLLqMNDHqywc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbaEJ4TXW2QDHSBH2/0NcADmYaixcWxLoFVmXJ6V1uAiYl5r7sHWHodZqSRHOOF3XxqEj3o9BUf4q9Lt9/gaGrn8yWzx1TVe6b2qA1PFI/5AqkUtmpHAdHMDGYcrHhFzldGcr0yy4g6PgJSu+cl60v9BEse6r8qtfxEbl/r11gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=en3VX0b8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BoQSA7qbTaPtx8dZuvNewsZFID1ieW6E82gPXvAynno=; b=en3VX0b8BrwwRX3qjPed7YrIIB
	WaDDQBLV6aQJRX7zsQcjh1gBIjsYrd5lfdsR0FvhjxSDG+OW04y53vBVjYUq7UGXlezZZVCol+cwe
	tQ9+lei5nf/9bxaydmWxqINnPcJMQN+Oc9KQZ8V86zDMoPVYIqUT5L/Vk0NPkO/eaxyFggwK93Hhc
	oXwXytigyCar2QZ1Fj6OJXj6s2IUz+xApdPffYjlAV4r94argsNuRQN0Jmo5UZSVEcXqcD2BtWtwE
	TccE+Gr986AIhhlPrJbI8Op9A1mBXuMDz3i1D/6E/YUgrBHUxZ8srBaplNCl/7ZL9RWvGIvfcGuG8
	P+Q9r83g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uQzfk-000IXl-1V;
	Mon, 16 Jun 2025 10:49:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Jun 2025 10:49:48 +0800
Date: Mon, 16 Jun 2025 10:49:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: T Pratham <t-pratham@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Kamlesh Gurudasani <kamlesh@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Manorit Chawdhry <m-chawdhry@ti.com>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 2/2] crypto: ti: Add driver for DTHE V2 AES Engine
 (ECB, CBC)
Message-ID: <aE-GTC2kTbL6VH5U@gondor.apana.org.au>
References: <20250603124217.957116-1-t-pratham@ti.com>
 <20250603124217.957116-3-t-pratham@ti.com>
 <aElSKF88vBsIOJMV@gondor.apana.org.au>
 <b27eab62-cfe0-4dfc-8429-ea464eef9e6f@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27eab62-cfe0-4dfc-8429-ea464eef9e6f@ti.com>

On Thu, Jun 12, 2025 at 03:45:54PM +0530, T Pratham wrote:
>
> Calling dma_terminate_sync() here should suffice I presume? I'll update the code accordingly.

This is just me having a skim through the DMA engine API.  Vinod,
could you please confirm whether this is how timeouts should be
dealt with through the DMA engine?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

