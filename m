Return-Path: <dmaengine+bounces-1614-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334F88FD4E
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2454B20FC7
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000507CF17;
	Thu, 28 Mar 2024 10:45:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEF65191;
	Thu, 28 Mar 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622746; cv=none; b=oGL6hJODJPwwf21+vjZKXvOJham+bi+63PKRftN99PuBvFc0zkeu245XayuPss2gdrauEcW8UillXHoTj/ZO1u556UUF07gDdxV4HuEHWhlGr95il88W4HJOuBHEYB+5jk5U0BPxy2AUhVbPZcPAkkXQhfFKE37gGwqWaG9lCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622746; c=relaxed/simple;
	bh=MoAnRl3IeEv27R1vGNGWDYEqdwTApYI/tUA3MxViRqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+tsaXVlugwSJseZ6CwZcfAFxvvjD1dQhSEpvexy3PJb1aGW0p/01jJg4EBO0T5OQ7MMsZuitD8v7QOUxLE8z2feqiKLH9bw0KpchwNwJJD0Hgyp6fqSSP1bkZOVp0iyiBqyeYMI6bK8ODJdrnWY8vm0qrRsV/ub6pOyaisIp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnG5-00C8CW-2d; Thu, 28 Mar 2024 18:45:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:45:37 +0800
Date: Thu, 28 Mar 2024 18:45:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 0/7] crypto: starfive: Add support for JH8100
Message-ID: <ZgVKUbHQA5sznpDV@gondor.apana.org.au>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>

On Tue, Mar 05, 2024 at 03:09:59PM +0800, Jia Jie Ho wrote:
> This patch series add driver support for StarFive JH8100 SoC crypto
> engine. Patch 1 adds compatible string and update irq descriptions for
> JH8100 device. Subsequent patches update current driver implementations
> to support both 7110 and 8100 variants.
> 
> v3->v4:
> - Updated interrupts descriptions for jh8100-crypto compatible. (Rob)
> - Added patch 3 to skip unneeded key freeing for RSA module.
> 
> v2->v3:
> - Use of device data instead of #ifdef CONFIG_ for different device
>   variants.
> - Updated dt bindings compatible and interrupts descriptions.
> - Added patch 4 to support hardware quirks for dw-axi-dmac driver.
> 
> v1->v2:
> - Resolved build warnings reported by kernel test robot
>   https://lore.kernel.org/oe-kbuild-all/202312170614.24rtwf9x-lkp@intel.com/
> 
> Jia Jie Ho (7):
>   dt-bindings: crypto: starfive: Add jh8100 support
>   crypto: starfive: Update hash dma usage
>   crypto: starfive: Skip unneeded key free
>   crypto: starfive: Use dma for aes requests
>   dmaengine: dw-axi-dmac: Support hardware quirks
>   crypto: starfive: Add sm3 support for JH8100
>   crypto: starfive: Add sm4 support for JH8100
> 
>  .../crypto/starfive,jh7110-crypto.yaml        |   30 +-
>  drivers/crypto/starfive/Kconfig               |   30 +-
>  drivers/crypto/starfive/Makefile              |    5 +-
>  drivers/crypto/starfive/jh7110-aes.c          |  592 ++++++---
>  drivers/crypto/starfive/jh7110-cryp.c         |   77 +-
>  drivers/crypto/starfive/jh7110-cryp.h         |  114 +-
>  drivers/crypto/starfive/jh7110-hash.c         |  316 +++--
>  drivers/crypto/starfive/jh7110-rsa.c          |    3 +
>  drivers/crypto/starfive/jh8100-sm3.c          |  544 ++++++++
>  drivers/crypto/starfive/jh8100-sm4.c          | 1119 +++++++++++++++++
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   32 +-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |    2 +
>  include/linux/dma/dw_axi.h                    |   11 +
>  13 files changed, 2437 insertions(+), 438 deletions(-)
>  create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
>  create mode 100644 drivers/crypto/starfive/jh8100-sm4.c
>  create mode 100644 include/linux/dma/dw_axi.h
> 
> -- 
> 2.34.1

Patches 1-4 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

