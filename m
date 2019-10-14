Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0686D5D69
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfJNI3O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNI3O (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:29:14 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975F220673;
        Mon, 14 Oct 2019 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571041752;
        bh=4xRYNc1AsGeEeRyhMqeyE0eI5lZWBeRZlGnQlsC3iT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poW3FdOhnfzxFqeIBCD96TFK9ogf+8ey1lA8yG5SXAHL0D+X3YPBSgIrE4MospI+Z
         hb7zs1kMA8wdggiEu844GDKWPb4Rcib/9/G/2T7FwutmRJD3ym78J+PHMeoJEufODN
         RPspDY69Cl+C4TjFoM9KzAMs5IyG7dvkprUUGz3U=
Date:   Mon, 14 Oct 2019 16:28:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, mbrugger@suse.com,
        robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 07/11] dts: arm64: layerscape: add dma-ranges property to
 qoric-mc node
Message-ID: <20191014082847.GH12262@dragon>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
 <20190924181244.7159-8-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924181244.7159-8-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 24, 2019 at 08:12:38PM +0200, Nicolas Saenz Julienne wrote:
> qoriq-mc's dpmacs DMA configuration is inherited from their parent node,
> which acts a bus in this regard. So far it maked all devices as
> dma-coherent but no dma-ranges recommendation is made.
> 
> The truth is that the underlying interconnect has DMA constraints, so
> add an empty dma-ranges in qoriq-mc's node in order for DT's DMA
> configuration code to get the DMA constraints from it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Updated subject prefix as 'arm64: dts: ...', and applied the patch.

Shawn

> ---
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index c676d0771762..f0d0b6145b72 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -698,6 +698,7 @@
>  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>  			msi-parent = <&its>;
>  			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
> +			dma-ranges;
>  			dma-coherent;
>  			#address-cells = <3>;
>  			#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 7a0be8eaa84a..fd6036b7865c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -340,6 +340,7 @@
>  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>  			msi-parent = <&its>;
>  			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
> +			dma-ranges;
>  			dma-coherent;
>  			#address-cells = <3>;
>  			#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 408e0ecdce6a..3735bb139cb2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -868,6 +868,7 @@
>  			msi-parent = <&its>;
>  			/* iommu-map property is fixed up by u-boot */
>  			iommu-map = <0 &smmu 0 0>;
> +			dma-ranges;
>  			dma-coherent;
>  			#address-cells = <3>;
>  			#size-cells = <1>;
> -- 
> 2.23.0
> 
