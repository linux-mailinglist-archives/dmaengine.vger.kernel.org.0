Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB323F131
	for <lists+dmaengine@lfdr.de>; Fri,  7 Aug 2020 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHGQ03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Aug 2020 12:26:29 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15425 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgHGQ02 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Aug 2020 12:26:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2d804f0000>; Fri, 07 Aug 2020 09:24:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Aug 2020 09:26:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Aug 2020 09:26:28 -0700
Received: from [10.26.73.183] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug
 2020 16:26:21 +0000
Subject: Re: [Patch v2 4/4] arm64: tegra: Add GPCDMA node in dt
To:     Rajesh Gumasta <rgumasta@nvidia.com>, <ldewangan@nvidia.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <1596699006-9934-5-git-send-email-rgumasta@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b00f05c9-f967-1292-3383-3c02ad20fe5d@nvidia.com>
Date:   Fri, 7 Aug 2020 17:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596699006-9934-5-git-send-email-rgumasta@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596817487; bh=5g/lNqVuaLfOFj0Ctj7+3HTboaH0OPONy4VZqvOuKRY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R9l/r4OWJP998wyd3lRjD8zbdgdoAP6FGyYfs5IXb/pJ7PEe8zC1MAV+rVDMPd84b
         r7xAts/WzOfn6PILB9YACFP1EPFDeaTT8usqDtzyjbiULoI13ygK2t/8+Zfc2hHXhs
         Esjn8qS+YJuw5OExK2+e7oS6O+5eZNvoDAoQygl/a3QS+tf/TvROCHkqrGTkOLp/ZH
         TfcL/H7BRP13RK7bXBeKuBs6lc8e9aEhHIufbcwJomgSFmajoCuyMeBNTcv5em9ZEF
         ezguxq2Pnv/br3RIGqHx4Tk2F6q6y2Z0SZPucs+VTI9cWRtcmQislspcWuYg8qaFUt
         9F1FdO28GTZCg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/08/2020 08:30, Rajesh Gumasta wrote:
> Add device tree node for GPCDMA controller on Tegra186 target
> and Tegra194 target.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 46 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 44 ++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index 2fcaa2e..56ed8d8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -54,6 +54,10 @@
>  		};
>  	};
>  
> +	dma@2600000 {
> +		status = "okay";
> +	};
> +
>  	memory-controller@2c00000 {
>  		status = "okay";
>  	};
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 58100fb..91bb17e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -70,6 +70,52 @@
>  		snps,rxpbl = <8>;
>  	};
>  
> +	gpcdma: dma@2600000 {
> +			compatible = "nvidia,tegra186-gpcdma";
> +			reg = <0x0 0x2600000 0x0 0x210000>;
> +			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
> +			reset-names = "gpcdma";
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
> +			dma-coherent;
> +			nvidia,start-dma-channel-index = <1>;
> +			dma-channels = <31>;

The above two properties are not mentioned in the dt-binding doc. I
really don't think we want these, especially the first as this is not
describing the h/w.

Jon

-- 
nvpublic
