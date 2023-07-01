Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1059744B99
	for <lists+dmaengine@lfdr.de>; Sun,  2 Jul 2023 00:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGAWTa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Jul 2023 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAWT1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Jul 2023 18:19:27 -0400
X-Greylist: delayed 1055 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 15:19:26 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F2E77
        for <dmaengine@vger.kernel.org>; Sat,  1 Jul 2023 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=awuPIRBOTCLPchkWj4ebZYVqHfMO7eHE5JTOy/aYNHY=; b=h1iYvb7zvOgUfccHyUvSVw+BsK
        PnsLEzDiZPkSggABGw1ftJsK318vzOrCOGkbRnfUWTy6q5I/L1/fU5h4snd1x6nMUoOtPoednRfHn
        jDf4pcqSQq5ypoiXEDWiVzWKSObeQSm3OOflf71Wxs320FHTYS06VIyVX7Aq5n1Kt/UKKezTKw2NB
        egE/RmV06MsWgAT1uo8MRvgTCQmTNHUj5wK4b82Yd6YC6/rVmQcZWNJvD3RmyScG9D13dHsYzINDd
        0q8Gmvk0rngnaNB0TklOPAlI3NZOkARUJ21pFjsJlZJL2US/ySO8atUJ2Xz1yBaUulaL9Lt+5H3xC
        4DQdTRZw==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qFieo-00F95d-3k; Sun, 02 Jul 2023 00:01:30 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qFien-00FECR-1d;
        Sun, 02 Jul 2023 00:01:29 +0200
Date:   Sun, 2 Jul 2023 00:01:29 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 4/4] riscv: dts: starfive: add dma controller node
Message-ID: <ZKCiOQ0IuptKO8kr@aurel32.net>
Mail-Followup-To: Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
 <20230322094820.24738-5-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322094820.24738-5-walker.chen@starfivetech.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023-03-22 17:48, Walker Chen wrote:
> Add the dma controller node for the Starfive JH7110 SoC.
> 
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 17220576b21c..b503b6137743 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -510,6 +510,24 @@
>  			#gpio-cells = <2>;
>  		};
>  
> +		dma: dma-controller@16050000 {
> +			compatible = "starfive,jh7110-axi-dma";
> +			reg = <0x0 0x16050000 0x0 0x10000>;
> +			clocks = <&stgcrg JH7110_STGCLK_DMA1P_AXI>,
> +				 <&stgcrg JH7110_STGCLK_DMA1P_AHB>;
> +			clock-names = "core-clk", "cfgr-clk";
> +			resets = <&stgcrg JH7110_STGRST_DMA1P_AXI>,
> +				 <&stgcrg JH7110_STGRST_DMA1P_AHB>;
> +			interrupts = <73>;
> +			#dma-cells = <1>;
> +			dma-channels = <4>;
> +			snps,dma-masters = <1>;
> +			snps,data-width = <3>;
> +			snps,block-size = <65536 65536 65536 65536>;
> +			snps,priority = <0 1 2 3>;
> +			snps,axi-max-burst-len = <16>;
> +		};
> +
>  		aoncrg: clock-controller@17000000 {
>  			compatible = "starfive,jh7110-aoncrg";
>  			reg = <0x0 0x17000000 0x0 0x10000>;

It appears that this patch has never been applied, although the rest of
the series has already been merged. Unfortunately it doesn't apply
anymore due to other changes to that file.

Could you please rebase and repost it?

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
