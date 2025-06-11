Return-Path: <dmaengine+bounces-5367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD14AD57C5
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45481E1784
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2EC28C5BE;
	Wed, 11 Jun 2025 13:58:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2801E487;
	Wed, 11 Jun 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650285; cv=none; b=lN7UAjod3Dn5kEx+beT2hMggBOUpaC0MLsuCzzEi2odyFH5aFWWp1yn/hxQpmWv2Z5OeZ2ZPTKVrG7nZCktBBjQ7GBCQCZiOQC/dhh36KsfE9wvDhFGMxmuHZa3UC0kVfPYJcEPQ+YZvqd+kGuQohZzcXISShtg20y4ORAlmtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650285; c=relaxed/simple;
	bh=HlXAP7Hn6c9MFfZk1HtJLc3Rdp+WGVH6K9qgcP+ukWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtX2m18/jEqUodETZBBxgedurxixZa/MTiteNyYP/GOB9a44CfS2coyt1maUelmxLUtMEaoeAWFEFew7Qw1VKHG6mETtjUvcYICFgcfIKEVWxPorx6MLczvAZYd0vAVTbCj5aX1T/Tt2avnu0jlsQREbDxJ3qYIBoptXWvHX7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 02DD633BEB9;
	Wed, 11 Jun 2025 13:58:01 +0000 (UTC)
Date: Wed, 11 Jun 2025 13:57:57 +0000
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
Subject: Re: [PATCH 6/8] riscv: dts: spacemit: Enable PDMA0 controller on
 Banana Pi F3
Message-ID: <20250611135757-GYC125008@gentoo>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-7-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611125723.181711-7-guodong@riscstar.com>

Hi Guodong,

On 20:57 Wed 11 Jun     , Guodong Xu wrote:
> Enable the Peripheral DMA controller (PDMA0) on the SpacemiT K1-based
> Banana Pi F3 board by setting its status to "okay". This board-specific
> configuration activates the PDMA controller defined in the SoC's base
> device tree.
> 
  Although this series is actively developed under Bananapi-f3 board
but it should work fine with jupiter board, so I'd suggest to enable
it too, thanks

> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 2363f0e65724..115222c065ab 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -45,3 +45,7 @@ &uart0 {
>  	pinctrl-0 = <&uart0_2_cfg>;
>  	status = "okay";
>  };
> +
> +&pdma0 {
> +	status = "okay";
> +};
> -- 
> 2.43.0
> 
> 

-- 
Yixun Lan (dlan)

