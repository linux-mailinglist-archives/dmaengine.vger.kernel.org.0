Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECF73D60D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jun 2023 04:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjFZCyz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Jun 2023 22:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFZCyy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 25 Jun 2023 22:54:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52EC103
        for <dmaengine@vger.kernel.org>; Sun, 25 Jun 2023 19:54:49 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-345a31bda6cso6934745ab.1
        for <dmaengine@vger.kernel.org>; Sun, 25 Jun 2023 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687748089; x=1690340089;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe898F/ffsJMUw2yiRdqMyZnDfV5Af+l4vque2ZH6fo=;
        b=Y8QLvQKDtphi3w29TRqCxG1CgC5SLHTHPJgZvlNl9fNfUwzKI7qQDD8W0/CmtC3ARN
         yY2w6lOJNtA18kSrIRrefWAI3QurrQntiZuVly1xszJ9c+JrmLuuZTJuYRv6HqWjLYh5
         WcKSlNLMAa1BWsYaJZSdMuRNyjAGLDygcGtLoqH+XFuHbpuRE05zxU2SC+BOMbXX53Up
         4aGyoeCD+aRLTb9chp8puDRt74haeM5fB3V9QxUYzsKpnB0v/OPtloGaP1zKFDWAC/dR
         P5rEry1g1gr5yyV2NN0OaY91N3Bb7P41MrBS+7+DlJD7uE8dgXXeIqBN5i4O8iEcLlAq
         fWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687748089; x=1690340089;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oe898F/ffsJMUw2yiRdqMyZnDfV5Af+l4vque2ZH6fo=;
        b=gaq8phys8+RjuEyhQJj1/gi7X21eajVgQS7iNJi5yD3frod/zcvZSeMIfKKDZX8XMp
         Fy3QTlkUNqF5U0iWMJbKyL+oLmSuou/v00gAYSNqRSXPHi4tU8/VSgslKo4p9YiMUcm0
         BMXTZzIFEswlyvX1XGQNKh5uIzzemQZK1CB5fMkI9I0O9BXloGPjPGvVdLoZF9VoAEa0
         7Z6lm2o+4lFWqbsZl+mwoMYtOcffQDwnuq59aS8bET4DrZo2Qqo/nA0Y3icAsIquiZ2y
         gz8RFYG9ZrLCiQSxPwZ3FfNlTdfoeAPSCi9jowdYy8mAPBDOqtYDF5MePx+fWJ7SCIVB
         skyA==
X-Gm-Message-State: AC+VfDymWbIpOB4mLafbSHAQAFZzgXyJoe1f5goxbK95lOq/m5zefqCV
        R/gox6hJ4wQbz9BtioTTTj59EiHDV1t91aetwbXUDQ==
X-Google-Smtp-Source: ACHHUZ615xhJwtejY7OBv9Vr1PrPfhnmy/+F15DzYviSu9aEuxrRSqaHPcXGNyMW6ZoCWQh0tDuw9Bif6+WOgKQz52c=
X-Received: by 2002:a92:d091:0:b0:345:6e6e:5351 with SMTP id
 h17-20020a92d091000000b003456e6e5351mr6562449ilh.22.1687748089020; Sun, 25
 Jun 2023 19:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230531090141.23546-1-zong.li@sifive.com>
In-Reply-To: <20230531090141.23546-1-zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 26 Jun 2023 10:54:38 +0800
Message-ID: <CANXhq0rVred1YMcV5449yYt+MhOu2NUx9Oa-1xJqbS=o_1Qb6g@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: xilinx: dma: remove arch dependency
To:     vkoul@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        radhey.shyam.pandey@amd.com, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 31, 2023 at 5:01=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> As following patches, xilinx dma is also now architecture agnostic,
> and it can be compiled for several architectures. We have verified the
> CDMA on RISC-V platform, let's remove the ARCH dependency list instead
> of adding new ARCH.
>
> To avoid breaking the s390 build, add a dependency on HAS_IOMEM.
>
> 'e8b6c54f6d57 ("net: xilinx: temac: Relax Kconfig dependencies")'
> 'd7eaf962a90b ("net: axienet: In kconfig remove arch dependency for axi_e=
mac")'
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>
>  Changes in v3:
>  - Add a dependency on HAS_IOMEM to avoid breaking the s390 build
>
>  Changes in v2:
>  - Remove ARCH dependency list instead of adding new ARCH
>
>  drivers/dma/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index f5f422f9b850..fd5a94e67163 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -696,7 +696,7 @@ config XGENE_DMA
>
>  config XILINX_DMA
>         tristate "Xilinx AXI DMAS Engine"
> -       depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> +       depends on HAS_IOMEM
>         select DMA_ENGINE
>         help
>           Enable support for Xilinx AXI VDMA Soft IP.
> --
> 2.17.1
>

Hi Vinod,
Linux 6.5-rc1 is opening, could I know if this patch is good for you?
Would it be considered in this merge window?
Thanks.
