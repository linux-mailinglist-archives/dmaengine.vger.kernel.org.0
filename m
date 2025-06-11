Return-Path: <dmaengine+bounces-5365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF4AD5785
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B789517E0D2
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE328688A;
	Wed, 11 Jun 2025 13:49:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D931E487;
	Wed, 11 Jun 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649752; cv=none; b=S8P2CN65Hedby9Ewc+AelMU8mmMxzVkn2auD/AZl8C0yqjLR/VykDflVaxtGBomR+okAgF+u/CZNhGAOIZoeUTz5IV47fsNKusj9RS/sCM3fB75iY10V4wHQtB+Ozt9vfWZI1MMWBchVd09X063/ddHFsbA1MHVHdl3tY3ZE0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649752; c=relaxed/simple;
	bh=sZq9SH69Jg41xhouqx7HpvfFGqgwcTBO4AbOt0Jf8NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnB/jxBlQArm1hMLPXI7kReQvVm39XntQ8xkfeZi/MrQ/5RwQGydqnDylJZPjI1gcMA9wXjoDu2csonIldz62+D3tRWMcrzKLyr/VGt2b32SDI+RIbNsuKlgVP9Cns1VgIPljRH873zPphs5vfx+1PBFC9hmRP2DHnx0T0jLyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D4C21335D3A;
	Wed, 11 Jun 2025 13:49:09 +0000 (UTC)
Date: Wed, 11 Jun 2025 13:48:59 +0000
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
Subject: Re: [PATCH 8/8] riscv: defconfig: Enable MMP_PDMA support for
 SpacemiT K1 SoC
Message-ID: <20250611134859-GYA125008@gentoo>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-9-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611125723.181711-9-guodong@riscstar.com>

Hi Guodong,

On 20:57 Wed 11 Jun     , Guodong Xu wrote:
> Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards
> like the BananaPI-F3 (BPI-F3) and the Sipeed LicheePi 3A.
> 
> According to make savedefconfig, the position of CONFIG_DWMAC_THEAD=m
> should be in another place. It was updated in this patch.
I don't really like those unrelated changes brought into this patch,
either having an independent patch to fix "make savedefconfig" issue,
then enable PDMA in follow-up patch, or just ignore it?

> 
> CONFIG_DWMAC_THEAD was initially introduced into riscv defconfig in
> commit 0207244ea0e7 ("riscv: defconfig: enable pinctrl and dwmac support
> for TH1520")
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  arch/riscv/configs/defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 517cc4c99efc..83d0366194ba 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -134,6 +134,7 @@ CONFIG_MACB=y
>  CONFIG_E1000E=y
>  CONFIG_R8169=y
>  CONFIG_STMMAC_ETH=m
> +CONFIG_DWMAC_THEAD=m
>  CONFIG_MICREL_PHY=y
>  CONFIG_MICROSEMI_PHY=y
>  CONFIG_MOTORCOMM_PHY=y
> @@ -240,7 +241,7 @@ CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_DMADEVICES=y
>  CONFIG_DMA_SUN6I=m
>  CONFIG_DW_AXI_DMAC=y
> -CONFIG_DWMAC_THEAD=m
> +CONFIG_MMP_PDMA=m
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

