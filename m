Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845F86EF669
	for <lists+dmaengine@lfdr.de>; Wed, 26 Apr 2023 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjDZO2v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Apr 2023 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbjDZO2t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Apr 2023 10:28:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633E6A77
        for <dmaengine@vger.kernel.org>; Wed, 26 Apr 2023 07:28:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a52667955dso75490185ad.1
        for <dmaengine@vger.kernel.org>; Wed, 26 Apr 2023 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682519314; x=1685111314;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zxN+51kTmRRhvTkz8C5RRZ+SlcUGbzZqD2x7sZii6Y=;
        b=ihewYFMvT/hjTDnt4kDa4P/YQEexZP+hDKO3d6JWJ8RwltrnIqxaakuDnhfv8EOP9q
         2XTZQV/mmxqzBNBLtLfwPTAaXFNNYP+kKLchZlJv/tFW9po685xiEAzvFM7xrUEL0xz1
         2rw6MeynYACVQ+pDkeSDP5afmi+vL/HHWSvTDWeR+g44ZK/salcTXzMQ0D5SmIcVJrCf
         d/hx2UmhSpN4htF/4Ec9N8vXosJ272hEasAq/dS9c3mqT2Uh7vAK+P0Aaspx1hyW5kmC
         C8TquSa/wqlmHoQU7iPrym//np/Scogt8klch2qQtOLCn7+pgGY2z4mYR6CdkR5cqAbW
         sO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519314; x=1685111314;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zxN+51kTmRRhvTkz8C5RRZ+SlcUGbzZqD2x7sZii6Y=;
        b=IZVMsW2JI+pjFsUbPAd32/1nwCZ7fMHv5+u6N9AIj2js70TSJ9XVwW7kdAQDoc3lS0
         4UUThg4rT8HrVNU58TTS7Od6BlymIy0MmSwDcSr6gDb2hq5bGgYAHo/C3LtBEihgvk6P
         Em1W79iWqPSesjQlaNsXu8bcNFg8+6bH14ucVoy52/zlEYrj2ONWrLRSR/rznGLF27aS
         rukpYJfvINptZCSJTiDfKSwNI41YzMP7UZAddcxpAYiu3no5x0xBTuFBs1GEnZpqoxYG
         Yt988kBIBqEjt1rfxcE1JWSFCX/qnBOcKkqcZAQLAynQ+91fa1PvZyQy9EBSVkxAX/fm
         7Vvg==
X-Gm-Message-State: AAQBX9f48uuMeA/RYq7lt2N5SZiDtWEvwYpTLzBSOYAhiSGzVlgOFYwO
        8i7hn6BqFdx1R1PNMCKB8+hJhg==
X-Google-Smtp-Source: AKy350YR1Bl5RHXjM9s5lsJGEYu5apz6QLx/fMwtQiLLB/BN/jzx/1QiSynUTfY19XWsRTH/8nuD/w==
X-Received: by 2002:a17:902:d4c6:b0:1a1:cc5a:b04 with SMTP id o6-20020a170902d4c600b001a1cc5a0b04mr27183794plg.3.1682519314628;
        Wed, 26 Apr 2023 07:28:34 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b0019a5aa7eab0sm10043570plb.54.2023.04.26.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:28:34 -0700 (PDT)
Date:   Wed, 26 Apr 2023 07:28:34 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Apr 2023 07:28:31 PDT (-0700)
Subject:     Re: [PATCH] dmaengine: xilinx: enable on RISC-V platform
In-Reply-To: <20230426074248.19336-1-zong.li@sifive.com>
CC:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-cdb02a07-40f9-4424-b3cf-938247588537@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 26 Apr 2023 00:42:48 PDT (-0700), zong.li@sifive.com wrote:
> Enable the xilinx dmaengine driver on RISC-V platform. We have verified
> the CDMA on RISC-V platform, enable this configuration to allow build on
> RISC-V.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index fb7073fc034f..816f619804b9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -695,7 +695,7 @@ config XGENE_DMA
>
>  config XILINX_DMA
>  	tristate "Xilinx AXI DMAS Engine"
> -	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> +	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64 || RISCV)
>  	select DMA_ENGINE
>  	help
>  	  Enable support for Xilinx AXI VDMA Soft IP.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
