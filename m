Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DC49DB23
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jan 2022 08:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiA0HD6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jan 2022 02:03:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34280 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HD5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jan 2022 02:03:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72031B82187;
        Thu, 27 Jan 2022 07:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A5C340E4;
        Thu, 27 Jan 2022 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643267035;
        bh=rVD0fNy0bHKOsHsV7IPqLXUyMJvfQuj7ygoyxxP4qC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCmpCcLYDfjiMMy+DuRgqx6vluJdfbhMOZkWMtUHfQ1FPyflbWdzAYwYQWiSxFzep
         ULw4GEZj5JOHfY/XmsnxZsFakYlEW4ByaZhGtYqvFInM8PMgoNQkV6IO5IxIbKUjDm
         MGgBYPmJC+SOO9D3af7LVwSR86dkb9Ebxx+9oyE7kczukhUJNJoY0wuKhVG69wQdaW
         MK9wvVwwxePncyTbhAUz3IdUZ8m0/TpEUgLx4D02EtMjigTeHOxVOdhWjYpolA/CLd
         T44UAR1q/xJ2osHtf61kWFdC+Ge0SbazJl8Ae9ZRJGSS7nbCKE1myB7NhgWgYpSCBd
         Ttg7qF9ql7nSA==
Date:   Thu, 27 Jan 2022 12:33:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] riscv: dts: Add dma-channels property in dma node
Message-ID: <YfJD11wlgkzuE+Sp@matsya>
References: <cover.1642383007.git.zong.li@sifive.com>
 <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1642383007.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1642383007.git.zong.li@sifive.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-22, 09:35, Zong Li wrote:
> Add dma-channels property, then we can determine how many channels there
> by device tree.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 +
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index c9f6d205d2ba..3c48f2d7a4a4 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -188,6 +188,7 @@ dma@3000000 {

Unrelated but the node name should be dma-controller@...

>  			reg = <0x0 0x3000000 0x0 0x8000>;
>  			interrupt-parent = <&plic>;
>  			interrupts = <23 24 25 26 27 28 29 30>;
> +			dma-channels = <4>;
>  			#dma-cells = <1>;
>  		};
>  
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> index 0655b5c4201d..2bdfe7f06e4b 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -171,6 +171,7 @@ dma: dma@3000000 {
>  			reg = <0x0 0x3000000 0x0 0x8000>;
>  			interrupt-parent = <&plic0>;
>  			interrupts = <23 24 25 26 27 28 29 30>;
> +			dma-channels = <4>;
>  			#dma-cells = <1>;
>  		};
>  		uart1: serial@10011000 {
> -- 
> 2.31.1

-- 
~Vinod
