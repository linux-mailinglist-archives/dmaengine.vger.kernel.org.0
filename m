Return-Path: <dmaengine+bounces-7226-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F72C65154
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1212C297E5
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868052D238F;
	Mon, 17 Nov 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVpOEkTI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4402BFC70;
	Mon, 17 Nov 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396102; cv=none; b=X/DICe0oJmurNTA6o7EM8D2pQWlF6Gfzdn/FQ70SNnILGcx+c3Oh62NTLY9sNHJSvl+WagprVNaTQe/w7nt98ZmnfEb4L1xr1O5syVrspj4RaGkbkpx5MD8N3omlIVaOMjxOmlSH2mO9MEQxQfkd6+vcr7KhWTVVBLN2JPNGK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396102; c=relaxed/simple;
	bh=MJdezGDxpl96TM4cI8OPupzkCopBtXiZbH9fk7Dx5lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPiYqqlwJhxtMUmxQtdQRl3kgjvc23nFCEZTte0ytdrQicjBbBKCnGD27LdaLDCmzmRkQkDYR3QGl1USGcruqy7TRJpMSUfGf/msQffk3K3E1wlvIpfq87dg9ETve8RJWD2kN89Ko7H4muBrUlLmtFsrjSKm+mGtkNEm63FNG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVpOEkTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA4AC4CEF1;
	Mon, 17 Nov 2025 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396102;
	bh=MJdezGDxpl96TM4cI8OPupzkCopBtXiZbH9fk7Dx5lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVpOEkTIizkvnhNoM5qkVSfJh6UzdE9I+CLfCuyeZQmgHV/iDa2Hf9wN+U3nhREEm
	 vePcxkWanBG4QBHG1OSDLrnaNTvBvzHPqLq5LI39lVZ2MnZPGVSge4xrSZr07PQgBs
	 87Eh147YNa6tYUaf0S4RTzWmZBYgqBrRng7aLCzE/UbEpGU/z5U0BgUKqbL0bvjmVH
	 +KUgodMjZuLGcCkpD3EFdwG3wcvavIm8AqXLppHkxjwN1jWv8QuNCiwe4jMOBUJ9qg
	 sRKcsEitnjKlmOEpo95MjVmLHWvHTO2QHOTM7jgi9v2zNPZy6ObfUHlAF9WPUkyJSE
	 UrHMVxwJILqEA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vL1sa-000000002qN-00gE;
	Mon, 17 Nov 2025 17:15:00 +0100
Date: Mon, 17 Nov 2025 17:14:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: enable compile testing
Message-ID: <aRtKA_EY0KkjmXrK@hovoldconsulting.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117161258.10679-3-johan@kernel.org>

On Mon, Nov 17, 2025 at 05:12:44PM +0100, Johan Hovold wrote:
> There does not seem to be anything preventing the K3 UDMA drivers from
> being compile tested (on arm64 as one dependency depends on ARM64) so
> enable compile testing for wider build coverage.
> 
> Note that the ring accelerator dependency can only be selected when
> "TI SOC drivers support" (SOC_TI) is enabled so select that option too.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Please disregard this one which was supposed to be sent separately.

Johan

