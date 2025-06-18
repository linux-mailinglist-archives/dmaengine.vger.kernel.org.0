Return-Path: <dmaengine+bounces-5534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D147ADF52C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CA31654A2
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22C2F5489;
	Wed, 18 Jun 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNCiOie4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC12F5480;
	Wed, 18 Jun 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269234; cv=none; b=VIEt0pcdGEb59hX9OKcaYz2VsSaye8h6ziYOlnBfQ4cm/78LNG4JP8/SQg0RONQ9rCBY3QlMOCIvGzdb/n1fi6mg2JGAj6erBefMgr4E6Ci3lSfaLQc6ukmZb1LCZbVLuqYBQK2msfBDr+F8yZoY1RN2zBIXPoZVZ7Uk/mN8+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269234; c=relaxed/simple;
	bh=h4mZR4L8DMHgoTdYqIGRaiW/N6mev87wAnioYI8PwI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBypMgc9IbbIKRDasx0gTCf+gZjaIEmqra3CEur6BvL3lRFGTQn0UjaKD5zlyTWI2Y6SpZV/4mQ5ksuENpolpO4UgRMpQ4SkL/xUW/V6EIoA/2YbThLg/eakEOlpatVs4O8HXGMHnGHHmsB3X+vwC7d97S9iO/h+96x/m5xQubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNCiOie4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45765C4CEE7;
	Wed, 18 Jun 2025 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750269233;
	bh=h4mZR4L8DMHgoTdYqIGRaiW/N6mev87wAnioYI8PwI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNCiOie4EqOv+10zJtVBrCF6ZgRLEVNdEkovuci31D5/6f11EqINSMiNU8emmIWjc
	 gdYbBVWnRKUd5Njp1/gHqMRbbKYjUAhzB78U74IIjyQRsO4YJYVH6sglE6I9D6eaNs
	 /WCpWH1PoHwZGhTNPLfyK0enMcNCBTtWwGsbwqEXqDo+PQnOGNk0g6B4ezgR/gRZM6
	 nsV8HED+6ltKre98jxLvxsH+OxEaGHne/eSftt40YgS4G97VLdnPG/IODxlYqfknl4
	 /UR7izQUMBDI+YSUQ+8Nx3lxR3OhaPkjghE7PpksPs+CUrFH2AN4S2GM7YptKRShPy
	 MTt99/+tCO+xg==
Date: Wed, 18 Jun 2025 23:23:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: T Pratham <t-pratham@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Kamlesh Gurudasani <kamlesh@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Manorit Chawdhry <m-chawdhry@ti.com>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 2/2] crypto: ti: Add driver for DTHE V2 AES Engine
 (ECB, CBC)
Message-ID: <aFL9LsQQdG3WTjUD@vaman>
References: <20250603124217.957116-1-t-pratham@ti.com>
 <20250603124217.957116-3-t-pratham@ti.com>
 <aElSKF88vBsIOJMV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aElSKF88vBsIOJMV@gondor.apana.org.au>

On 11-06-25, 17:53, Herbert Xu wrote:
> On Tue, Jun 03, 2025 at 06:07:29PM +0530, T Pratham wrote:
> >
> > +	// Need to do a timeout to ensure finalise gets called if DMA callback fails for any reason
> > +	ret = wait_for_completion_timeout(&rctx->aes_compl, msecs_to_jiffies(DTHE_DMA_TIMEOUT_MS));
> 
> This doesn't look safe.  What if the callback is invoked after a
> timeout? That would be a UAF.
> 
> Does the DMA engine provide any timeout mechanism? If not, then
> you could do it with a delayed work struct.  Just make sure that
> you cancel the work struct in the normal path callback.  Vice versa
> you need to terminate the DMA job in the timeout work struct.

Typically no. Most of the hardware may not have capability, so we have
apis to terminate.

-- 
~Vinod

