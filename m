Return-Path: <dmaengine+bounces-5351-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D6AD509C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 11:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE3C188DB46
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DA25E448;
	Wed, 11 Jun 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LcRJh932"
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30E282FA;
	Wed, 11 Jun 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635636; cv=none; b=Fr8HiajHE4oESnoHNUrsGEFUFAR4KGgBUYb+IRJHeK8SIgUW9JOBwHdzwUg9UYdAORz+ijkYdoBdkzSknvDFNsF0nNghuRPtJRTX2nZYCogZf2M7JfsCCdJGqfGVMuwkvnD01ClWh/IYHwhTh8YRag93HbJkQTUOZa23vChQRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635636; c=relaxed/simple;
	bh=BSgRFf23USn06BXKMDauBB7ChXs+skWxuq9OSOgYlTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9qnQdIEtvfEzaCWW3fUevdcgD5owvhcuIE/P+S6EB62wQ0xrW0Wdlly7Tnfhbz/BcFP6zogwRhhIpkQy6sm7cCUE6auRh9B3oBFWeTpEs6vDN+MdnOV6jtLjXlhNG39SsqmrSo84LL6G13GdCJMVZOxjc94E9IoSkbgHyFzEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LcRJh932; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gS16jsY87OFksTz1b7LC9eAtX+oys1lrJgtgSbtLAK4=; b=LcRJh932akY/uFb2gUoR2nfhfw
	PVPq9kTD/eUiFk6pbVreGcTNnkytMHs0qvXnOFnwBIUTmvxrHFll4IFPyHfQl97MUx4B/ALoRVzAo
	U4MYHYgjZdWbfIDnkQWq6v1KhiMZ+IJup4/OcNXoMe9iVbW0RSEsYYcss7ZoyKfxpcbwQhAYAO5tm
	bBEFXT1r+1R7kWtND700oDlxjcRZOkNEASkwXTOV3CTtaIccLYoEVuOoiuVTg5vVNe9iuQk2Jai3t
	1R3qiPstzkX/oARVPZrfn4rMfh/UJmZLueBBGUhkRRPZ+irSqMD+Fqvg+D4Oc1XLWJokAhbNBdtPP
	lKEcjPcg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uPI9Q-00CJoB-0K;
	Wed, 11 Jun 2025 17:53:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Jun 2025 17:53:44 +0800
Date: Wed, 11 Jun 2025 17:53:44 +0800
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
Message-ID: <aElSKF88vBsIOJMV@gondor.apana.org.au>
References: <20250603124217.957116-1-t-pratham@ti.com>
 <20250603124217.957116-3-t-pratham@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603124217.957116-3-t-pratham@ti.com>

On Tue, Jun 03, 2025 at 06:07:29PM +0530, T Pratham wrote:
>
> +	// Need to do a timeout to ensure finalise gets called if DMA callback fails for any reason
> +	ret = wait_for_completion_timeout(&rctx->aes_compl, msecs_to_jiffies(DTHE_DMA_TIMEOUT_MS));

This doesn't look safe.  What if the callback is invoked after a
timeout? That would be a UAF.

Does the DMA engine provide any timeout mechanism? If not, then
you could do it with a delayed work struct.  Just make sure that
you cancel the work struct in the normal path callback.  Vice versa
you need to terminate the DMA job in the timeout work struct.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

