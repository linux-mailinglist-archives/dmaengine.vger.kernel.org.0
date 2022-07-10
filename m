Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617756D202
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJXVX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Jul 2022 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiGJXVV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Jul 2022 19:21:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3A13DEA
        for <dmaengine@vger.kernel.org>; Sun, 10 Jul 2022 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657495280; x=1689031280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2bOuAF8hy4hQXexxGrNRideeT3L1vDk2fxucN4Onkrw=;
  b=IkPgbY+bFu8TN7C1SgTEdc8wEgy1tVic6r6D+wPCPw4ILUNvVvG0jGuj
   4EiudP2RLqwKABVeSgG4enjTLoU5zrQ2YQjwTl9AoVmf5b6leigVZpCfJ
   yVa4343dGloXkudGmJVeoH4qJdWdETrqp6cvz65bWQamyUE/AN/wPFnRv
   y7+igniMFYeENBZYS8d7PYq0FEd9FP1V9UtCvMeOekFEAQ5antWVmhlPx
   Tf1cbcM5vvtyAOoIJU9v2Rf+WWbHOxoTJ54gLiNSXEOELbGUMPXuZb5Z9
   jgiIjuQ/+QqHNbSJoqdUzLZdf298JpRweiH0UP4Un/UlFj1n0tjuMmK76
   w==;
X-IronPort-AV: E=Sophos;i="5.92,261,1650902400"; 
   d="scan'208";a="203957769"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 07:21:18 +0800
IronPort-SDR: BKpEhx39u1K++F78OUEN6jXtRKqJMDj8Iz43/PF14LQjU9y+pTyNyDAW6e1D1UTPKfVqGMhtkZ
 93TfO1v8ZKCq4OZlZYrng6gkG81kA0BcFDifohcAmDzlMZRiiAzFfnr3fz6q5RPlIKjKSJIXob
 RYv4uK/z3t5pu0OCYA0nETZpt+882GmKgpNB8ZGeb23Y+4sItW+9nuJJrQP8xsclG7qljl2PVc
 xbAEAx17FcsG1TukKGz2Azb3pbdMg8gsfUDkeCxJjqbxep18m7hOAvOz7geon5V5TnY0WxNflX
 5+BCRzONAHdzks4gmdj+3uSz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 15:42:56 -0700
IronPort-SDR: Re7CVDjQUyfyq+Ki4JiR7d5Tdu/ucc1G2s5y9TPRCkdHns+mp+qRVI5kl7FV+LNwjHDBM5EU/a
 Vm0YszY26ExCiL0e45rbnb3JwbxpdXfYd/wG85yxCkbKCEKzfF8ByDywJwwSD32ob8wTaxVj7H
 2w5n9FmxsEhGNVUR3ebtcfex35gvJ+8NE0PkbgsyrVqBUA+ml+kArYQChWLQx2s/C0kBJc3iDY
 ABMw31TXBtELKhIZ2384kIRZiFQoyNEkJ3a9e0XjjC4IPHpIJNCUo3oN0roiZG6zdJrFniIPvm
 13Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 16:21:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Lh31B33L8z1Rws4
        for <dmaengine@vger.kernel.org>; Sun, 10 Jul 2022 16:21:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657495276; x=1660087277; bh=2bOuAF8hy4hQXexxGrNRideeT3L1vDk2fxu
        cN4Onkrw=; b=iY63mouJ51j7XgRwIzOQn2aNTZVGHkHmYlbv3oLuDn/RDNSJ7js
        fnWlCx5bkYECfSDwfPKXZH28vOy4xBFbYfUEkxA1Bk0W2tEB7xhgqTeJ+Ap/DWQg
        hnU2JJ6onNNBChD6gz9Kl/vSpx1TSHHOgot2/Uqfdxc4DnIvZSx6VX+6PdzkD70r
        YVqYdcosyHDk94OS6MzUxZOSvEXaAvw/o45nGZ12hsI/wy+QaFd1V1Sg5eJIOY1P
        zhOxlrFrGxL9GVwUBo0k2YY10LMCSiITH68OuumTq2EHMgRnenXg9PofTScTe5mF
        NsDo8QkwxLeJkbWK48XERzZy97CMD3y6pOA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NtryrEnTt8lC for <dmaengine@vger.kernel.org>;
        Sun, 10 Jul 2022 16:21:16 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Lh31457fMz1RtVk;
        Sun, 10 Jul 2022 16:21:12 -0700 (PDT)
Message-ID: <b8b015f0-d16f-8528-719a-1a3f74d9f176@opensource.wdc.com>
Date:   Mon, 11 Jul 2022 08:21:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 04/13] dt-bindings: memory-controllers: add canaan k210
 sram controller
Content-Language: en-US
To:     Conor.Dooley@microchip.com, krzysztof.kozlowski+dt@linaro.org
Cc:     daniel.lezcano@linaro.org, Eugeniy.Paltsev@synopsys.com,
        sam@ravnborg.org, daniel@ffwll.ch, paul.walmsley@sifive.com,
        vkoul@kernel.org, palmer@rivosinc.com, airlied@linux.ie,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org,
        masahiroy@kernel.org, geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org,
        fancer.lancer@gmail.com, thierry.reding@gmail.com, mail@conchuod.ie
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <20220705215213.1802496-5-mail@conchuod.ie>
 <a516943f-3dac-70a0-3ebd-9f53fd307f25@microchip.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a516943f-3dac-70a0-3ebd-9f53fd307f25@microchip.com>
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

On 7/11/22 04:39, Conor.Dooley@microchip.com wrote:
> Damien, Krzysztof,
> 
> I know this particular version has not been posted for all that
> long, but this binding is (functionally) unchanged for a few
> versions now. Are you happy with this approach Damien?
> U-Boot only cares about the compatible & the clocks property,
> not the regs etc.
> 
> I (lazily) tested it in U-Boot with the following diff:

If both the kernel and u-boot still work as expected with this change, I
am OK with it.

> 
> diff --git a/arch/riscv/dts/k210.dtsi b/arch/riscv/dts/k210.dtsi
> index 3cc8379133..314db88340 100644
> --- a/arch/riscv/dts/k210.dtsi
> +++ b/arch/riscv/dts/k210.dtsi
> @@ -82,11 +82,14 @@
>  
>         sram: memory@80000000 {
>                 device_type = "memory";
> +               reg = <0x80000000 0x400000>, /* sram0 4 MiB */
> +                     <0x80400000 0x200000>, /* sram1 2 MiB */
> +                     <0x80600000 0x200000>; /* aisram 2 MiB */
> +               u-boot,dm-pre-reloc;
> +       };
> +
> +       sram_controller: memory-controller {
>                 compatible = "canaan,k210-sram";
> -               reg = <0x80000000 0x400000>,
> -                     <0x80400000 0x200000>,
> -                     <0x80600000 0x200000>;
> -               reg-names = "sram0", "sram1", "aisram";
>                 clocks = <&sysclk K210_CLK_SRAM0>,
>                          <&sysclk K210_CLK_SRAM1>,
>                          <&sysclk K210_CLK_AI>;
> 
> If so, could you queue this for 5.20 please Krzysztof, unless
> you've got concerns about it?
> 
> Thanks,
> Conor.
> 
> On 05/07/2022 22:52, Conor Dooley wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> The k210 U-Boot port has been using the clocks defined in the
>> devicetree to bring up the board's SRAM, but this violates the
>> dt-schema. As such, move the clocks to a dedicated node with
>> the same compatible string & document it.
>>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>  .../memory-controllers/canaan,k210-sram.yaml  | 52 +++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
>> new file mode 100644
>> index 000000000000..f81fb866e319
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/canaan,k210-sram.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Canaan K210 SRAM memory controller
>> +
>> +description:
>> +  The Canaan K210 SRAM memory controller is responsible for the system's 8 MiB
>> +  of SRAM. The controller is initialised by the bootloader, which configures
>> +  its clocks, before OS bringup.
>> +
>> +maintainers:
>> +  - Conor Dooley <conor@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - canaan,k210-sram
>> +
>> +  clocks:
>> +    minItems: 1
>> +    items:
>> +      - description: sram0 clock
>> +      - description: sram1 clock
>> +      - description: aisram clock
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    items:
>> +      - const: sram0
>> +      - const: sram1
>> +      - const: aisram
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/k210-clk.h>
>> +    memory-controller {
>> +        compatible = "canaan,k210-sram";
>> +        clocks = <&sysclk K210_CLK_SRAM0>,
>> +                 <&sysclk K210_CLK_SRAM1>,
>> +                 <&sysclk K210_CLK_AI>;
>> +        clock-names = "sram0", "sram1", "aisram";
>> +    };
>> --
>> 2.37.0
>>
> 


-- 
Damien Le Moal
Western Digital Research
