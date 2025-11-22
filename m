Return-Path: <dmaengine+bounces-7296-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E290C7CB36
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BF0A4E352B
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7012673B7;
	Sat, 22 Nov 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPUSgztB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198C38D;
	Sat, 22 Nov 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763802874; cv=none; b=Cas11Gb44U0XRyONeeLm7mh8EdugKDeLnIrnTQL1xlPYVvL0i1/7VwVfajkDMTqvhXuM+JZyTatt2AihRA+itty0Jx8WBr66Zgy573bUl1daGPksnhqvr4SWjHemiUk2y8jQzLrZkDNFm4WISdr1SZQVGz2JwH+VzWOsUV7lQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763802874; c=relaxed/simple;
	bh=b4RC2OOZAPgsd4s79lNvAgGlRu3wcln25nSpTwyMcEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ooU0xoVayY3guTe+RqTbaISA00fdW5isRBddsQ3anoxsG7MtzGZxFVcPgpOrSw7KR17Alb4QvKcjqgQVkYVK+D316vXbFhM4ejdfxKDW7QVsQ11bysgFLA3lErK6BcBrgNdZkvuzNcsyqkFAzX0KPYO7TONopPdHdHnpu2RLDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPUSgztB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179C0C4CEF5;
	Sat, 22 Nov 2025 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763802873;
	bh=b4RC2OOZAPgsd4s79lNvAgGlRu3wcln25nSpTwyMcEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mPUSgztBpUe/qFMorT62aNquxDIvkjxBRs6yYD5cBMpNFktTahE3zDgjUyrQTvH0j
	 3z5deHCHizDaIHuzKqquMXXRZU9AnISnDnMpp+gVeEEOSe54Flr4v+ekhKjhpOPsmb
	 HZE7Jr44a+omvkuAJ+9QVa2otZfpbTmSTfr5wiMeVKGCAA39389m3QtJQi6iDmO22W
	 yNN72u71EoTtFnTkkZ8Un5WQm1TnpJr5xpIcgvczMBiZ1zEEu41Uv5HCXLC7WkXf+p
	 WgMcB91H3LFLufRyS/wom91Dla6OuWGaEV9LmV1ZFfqkNGXHlDMyepy/8Hgjod4wBq
	 tZlGSmPjq3Yfg==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251117161258.10679-1-johan@kernel.org>
References: <20251117161258.10679-1-johan@kernel.org>
Subject: Re: [PATCH 00/15] dmaengine: fix device leaks
Message-Id: <176380286971.317731.12818103540617928436.b4-ty@kernel.org>
Date: Sat, 22 Nov 2025 14:44:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 17 Nov 2025 17:12:42 +0100, Johan Hovold wrote:
> The dmaengine drivers pretty consistently failed to release references
> taken when looking up devices using of_find_device_by_node() and similar
> helpers.
> 
> Included are also two OF node leak fixes and a couple of related
> cleanups.
> 
> [...]

Applied, thanks!

[01/15] dmaengine: at_hdmac: fix device leak on of_dma_xlate()
        commit: 9324a4dfc4b82ba6ac71d007763b3a34a72ebd70
[02/15] dmaengine: bcm-sba-raid: fix device leak on probe
        commit: 8d5ac0087d5d325bda6c03fe0aecce348b8054d5
[03/15] dmaengine: cv1800b-dmamux: fix device leak on route allocation
        commit: 1941fa42d218cb26eca6cf8ce7443ed4f3849c5a
[04/15] dmaengine: dw: dmamux: fix OF node leak on route allocation failure
        commit: 43cc76e43f8e0be64358945edd6c14f7a9fc39a8
[05/15] dmaengine: idxd: fix device leaks on compat bind and unbind
        commit: 91b3d5a62deaa9f41d272ae0eea10508553f990d
[06/15] dmaengine: lpc18xx-dmamux: fix device leak on route allocation
        commit: 216b4a61613715b254e52bd3079aa44ad8f21734
[07/15] dmaengine: lpc32xx-dmamux: fix device leak on route allocation
        commit: 8805fc665732f93e7db8fca86fa251a0c793a82b
[08/15] dmaengine: sh: rz-dmac: fix device leak on probe failure
        commit: f7e468e72ba4bd81d0dd8d8462c90dfd00791d6b
[09/15] dmaengine: stm32: dmamux: fix device leak on route allocation
        commit: cd624421eddae7bde7dc17b54968891a47b6fce7
[10/15] dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
        commit: f9091986ac4181ca6457e8b2f88fdd37e18e35c4
[11/15] dmaengine: stm32: dmamux: clean up route allocation error labels
        commit: d2e17bfa4a0d57d2bbd2dfccbeaa39351abb0248
[12/15] dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
        commit: f6ad296520f0827455f579a786ae5fb1c444a702
[13/15] dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
        commit: 430f93d80cad5f96cbfeefbf4a9240212230ba82
[14/15] dmaengine: ti: dma-crossbar: clean up dra7x route allocation error paths
        commit: da0bcd6d207d3756ff44ec2185a814728fe641b0
[15/15] dmaengine: ti: k3-udma: fix device leak on udma lookup
        commit: e5bee109658abc4edc8d57c8545c79f130df1b87

Best regards,
-- 
~Vinod



