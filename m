Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9647BDC7
	for <lists+dmaengine@lfdr.de>; Tue, 21 Dec 2021 10:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhLUJ44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Dec 2021 04:56:56 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:17105 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhLUJ4w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Dec 2021 04:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1640080611;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ShAKSNLhJ6uA68V/ThSloqM31SbGCIo7ifa1XicEJTQ=;
    b=e/5WOBfKMI54kKGEvTTwpSYjHs6AXUZ39eZmqj0xyS0Rrw8kV7NKL4PZFlChPWHUZ6
    NHFm1gXK2bpmvMQKkbgiGytRNgK3PbqF6QCLMnOUHXdJ6OJA8a6u8kiMAn6K+7B2uODO
    E/EuteOK9T0cqMxOoz2cYpqPholjt200eer/70JHfq7PC22SxVoJ+36vhe8rOXshK5hP
    D6KnvCW3qB/8BouYKZiTf2S54QNHTE002gSdg/CGbqudlE2xyFSpuaahywV55/LmwAoV
    oYIX50+aBnKxCW2/ErCdy3SxE1yAZ0zt6cPm6LqpfbQrfmvYtZQQCk9mtZX0HrjMThGb
    DuNg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7B6PNk="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.35.3 AUTH)
    with ESMTPSA id N01f39xBL9upyK5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 21 Dec 2021 10:56:51 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:56:51 +0100 (CET)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Message-ID: <1368361703.546201.1640080611185@webmail.strato.com>
In-Reply-To: <20211221052722.597407-4-yoshihiro.shimoda.uh@renesas.com>
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
 <20211221052722.597407-4-yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r8a779f0: Add sys-dmac nodes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev33
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 12/21/2021 6:27 AM Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> wrote:
> 
>  
> Add SYS-DMAC nodes for r8a779f0.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 70 +++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
> index eda597766eaf..5426532d10e2 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
> @@ -94,6 +94,76 @@ scif3: serial@e6c50000 {
>  			status = "disabled";
>  		};
>  
> +		dmac0: dma-controller@e7350000 {
> +			compatible = "renesas,dmac-r8a779f0",
> +				     "renesas,rcar-gen4-dmac";
> +			reg = <0 0xe7350000 0 0x1000>,
> +			      <0 0xe7300000 0 0x10000>;
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error",
> +					  "ch0", "ch1", "ch2", "ch3", "ch4",
> +					  "ch5", "ch6", "ch7", "ch8", "ch9",
> +					  "ch10", "ch11", "ch12", "ch13",
> +					  "ch14", "ch15";
> +			clocks = <&cpg CPG_MOD 709>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +			resets = <&cpg 709>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +		};
> +
> +		dmac1: dma-controller@e7351000 {
> +			compatible = "renesas,dmac-r8a779f0",
> +				     "renesas,rcar-gen4-dmac";
> +			reg = <0 0xe7351000 0 0x1000>,
> +			      <0 0xe7310000 0 0x10000>;
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error",
> +					  "ch0", "ch1", "ch2", "ch3", "ch4",
> +					  "ch5", "ch6", "ch7", "ch8", "ch9",
> +					  "ch10", "ch11", "ch12", "ch13",
> +					  "ch14", "ch15";
> +			clocks = <&cpg CPG_MOD 710>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +			resets = <&cpg 710>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +		};
> +
>  		gic: interrupt-controller@f1000000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> -- 
> 2.25.1

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
