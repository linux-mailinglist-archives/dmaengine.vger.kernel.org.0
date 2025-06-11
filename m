Return-Path: <dmaengine+bounces-5366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE9BAD578C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C097D189E79C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF32882A5;
	Wed, 11 Jun 2025 13:51:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2A283CB8;
	Wed, 11 Jun 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649888; cv=none; b=pj4CpC0B+vPCmR7A9/v74uc/ASu6GQhJCTLmFw+fF3Hg6Ke5dGF23m3JwFWl8wsES6hHMPG+7eQcEXjGOHKT3Uq47zdVKCAA+xYsFpQcxO7kRQ3Wc6I3fuHw/+H48igihbVqNUyOqV/tsJ4gvtrsQKUAIES5PlGaI8Zx4DcIrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649888; c=relaxed/simple;
	bh=yAlRVV0IYpPAr1Khu9WPG25QKxrpg+ulUL9ZM5P9qaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpz1ElXYCD6Nm1N3GXmwPW2NAnAAaffHG9LRYQ36onxUHP5q8PusGNFQK12UjUmhg7AiiqPH3EZbXHPc4W9Ix5XDFGf0JWvm3puL6z2sAqutAaShg/ZC1GnNfCbvphGQg7aUgYGQinLxuWnHpe2xvZUB7BJOuLrecX8nSIfdoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7C8C2340D31;
	Wed, 11 Jun 2025 13:51:24 +0000 (UTC)
Date: Wed, 11 Jun 2025 13:51:16 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, emil.renner.berthing@canonical.com,
	inochiama@gmail.com, geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	elder@riscstar.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 7/8] dma: Kconfig: MMP_PDMA: Add support for ARCH_SPACEMIT
Message-ID: <20250611135116-GYB125008@gentoo>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-8-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611125723.181711-8-guodong@riscstar.com>

Hi Guodong,
  I'd suggest moving this patch after 4/8, as both of them should go
via DMA susbystem tree, or simply squash them?

On 20:57 Wed 11 Jun     , Guodong Xu wrote:
> Extend the MMP_PDMA driver to support the SpacemiT architecture
> by adding ARCH_SPACEMIT as a dependency in Kconfig.
> 
> This allows the driver to be built for SpacemiT-based platforms
> alongside existing ARCH_MMP and ARCH_PXA architectures.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index db87dd2a07f7..fff70f66c773 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -451,7 +451,7 @@ config MILBEAUT_XDMAC
>  
>  config MMP_PDMA
>  	tristate "MMP PDMA support"
> -	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
> +	depends on ARCH_MMP || ARCH_PXA || ARCH_SPACEMIT || COMPILE_TEST
>  	select DMA_ENGINE
>  	help
>  	  Support the MMP PDMA engine for PXA and MMP platform.
> -- 
> 2.43.0
> 
> 

-- 
Yixun Lan (dlan)

