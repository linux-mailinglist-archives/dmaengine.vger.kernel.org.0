Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF179550DA1
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jun 2022 01:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiFSXjB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Jun 2022 19:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiFSXjA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Jun 2022 19:39:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B19FE1
        for <dmaengine@vger.kernel.org>; Sun, 19 Jun 2022 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655681941; x=1687217941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+r2le/0cYQHWtPMNeCxIXB43Y8pcNDHfGVPeVoKPk1w=;
  b=ODvQIvsj4/inldhW2r1OICP7j5m22R0DDYoHUC0D4cr3lHjciYU6Zbkl
   vDGymfV380l91uJmDkp/jwY4ykNtAoYC8vt5nyv10KJmQhDaWkx8j7l0j
   Lup1N8BU/pifgZbDy1t9rNBF50Pj99+s00pyHEcBf2Ul4Bd/kTeJTS076
   X43SyyQIsQtid5/fl0SSZ3MJ5nqcjNMfitL1cE9fka3QS0mpYJdgTbg0J
   5n2Zt0nXfe2C/BscIILk9ivuwcV1EiQmvLkaW4Fe1C5mttdlZ5SyEuNq0
   JKzidrVF8wxSjVXGk30GWMPjvqtYYgsGUDCFR0dOq/7ausjdEGeazQkE6
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204332794"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:39:00 +0800
IronPort-SDR: NXYfBIqbaAKWx2vdCilvY9eT5TXaB3+bmhMMa8+/bDx+1ka0QUzC/C5q1jJn6kQI8M53xkD6z/
 JMnzRiBi+JYcGM71fD0fkY7pq8xkFEfDVFxtGRfgxh+f5abEVGWT+BW+CLYeACpq8vVpLLM5oO
 RklPiO6tox5+GDDIddppYPn1NIJEI9kpUSU7fHoJ8LqBrzN3Xdx0gWqanRJ54W8USirxbS2WuV
 efO9HyJg0yPtLKYPSaJD/th6HM5WGzlKGExQ/EoK3t1mGAGbAj+EcvUunllAwnekZVBkUmsjlJ
 GHFXgBhm38Ov+VZOQiBkhLdb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:01:31 -0700
IronPort-SDR: ZT4Jc46gO/cS7m5GNHqk+m4Cggr6qWrwdxGETSE+doy9WrdulMNZDAgXZ01P1bkVds9z3/xOsJ
 zVfR1k1jxIB6qMK6chuFGGCmiej/jbd1ms80GMuITkLhwZgy6jCDh0dwBSGhlfD2UblRf7je67
 HZsSZRdIBAtjfD2JQVh0kAMnj0ETuYgEaiRUM2YoBy2WC9Fu2YU023h6IhoDkKXKZ24yrWGCCu
 W0kRaCQQCli5rAdZwIdcYwlEfZGrCow1drYJ14yTE/nc1ghT1BfpHTkom5d6LuZ0xGPqlUsL4P
 KoY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:38:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR8PG1Nb1z1SVp3
        for <dmaengine@vger.kernel.org>; Sun, 19 Jun 2022 16:38:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655681937; x=1658273938; bh=+r2le/0cYQHWtPMNeCxIXB43Y8pcNDHfGVP
        eVoKPk1w=; b=fPh0jM8V9qqPW70mFILfn0oH/t6YdTP5j5nYoQaZ3qzqvNZhES8
        wM/NZ1NWJD/pJVvr1BUFf56nUIKAwsRI79NnrEmtxFiYpNl1e2IS0zFLirGVF58/
        /lWr6pXDvMN/aYVUroAahjbEZ3SknQqMnzGVcpJcirHyRBVnLNNACBcjw5W+w6Oi
        xx3LXiZvDtQes/ej6dBQtE/0UxPugLIFRuNlvSSDxKfHYhgDS+DzquTgm9yhteAd
        zxF/VPlxKkDnt0awf+PKnINUx01IznqbpZtT9I8xQTuWk9QlIfY0Ibek5uE3g8+F
        SWNFWnA6DEKhg0NU7wr0hzVc03FtrycJvSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m0JWKYJyh2SJ for <dmaengine@vger.kernel.org>;
        Sun, 19 Jun 2022 16:38:57 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR8P82TBvz1Rvlc;
        Sun, 19 Jun 2022 16:38:52 -0700 (PDT)
Message-ID: <9cd60b3b-44fe-62ac-9874-80ae2223d078@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 07/14] riscv: dts: canaan: fix the k210's memory node
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-8-mail@conchuod.ie>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220618123035.563070-8-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/18/22 21:30, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The k210 memory node has a compatible string that does not match with
> any driver or dt-binding & has several non standard properties.
> Replace the reg names with a comment and delete the rest.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> ---
>  arch/riscv/boot/dts/canaan/k210.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
> index 44d338514761..287ea6eebe47 100644
> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
> @@ -69,15 +69,9 @@ cpu1_intc: interrupt-controller {
>  
>  	sram: memory@80000000 {
>  		device_type = "memory";
> -		compatible = "canaan,k210-sram";
>  		reg = <0x80000000 0x400000>,
>  		      <0x80400000 0x200000>,
>  		      <0x80600000 0x200000>;
> -		reg-names = "sram0", "sram1", "aisram";
> -		clocks = <&sysclk K210_CLK_SRAM0>,
> -			 <&sysclk K210_CLK_SRAM1>,
> -			 <&sysclk K210_CLK_AI>;
> -		clock-names = "sram0", "sram1", "aisram";
>  	};

These are used by u-boot to setup the memory clocks and initialize the
aisram. Sure the kernel actually does not use this, but to be in sync with
u-boot DT, I would prefer keeping this as is. Right now, u-boot *and* the
kernel work fine with both u-boot internal DT and the kernel DT.

-- 
Damien Le Moal
Western Digital Research
