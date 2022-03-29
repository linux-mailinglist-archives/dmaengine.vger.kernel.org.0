Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9F4EA4A1
	for <lists+dmaengine@lfdr.de>; Tue, 29 Mar 2022 03:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiC2Bhe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 21:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2Bhd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 21:37:33 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252F1AA4B0;
        Mon, 28 Mar 2022 18:35:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o5so29137869ybe.2;
        Mon, 28 Mar 2022 18:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUMDHkRP/8Kobp4SqOhIfI5YC+CFPdiLYdQuQeo5ONc=;
        b=ds3x1f5M4qmFLSp9i1Lf8czpJ2ro20lGW+k29/7Je9+ABb8oScKI06t0yhPbG8Kq0S
         bZ2C20GpcKLmlxeZ77SBo3m/MqXCjWS7JFdxV0Wci2OhW3/6zO7CJ+nvVx2R0k+tT3st
         0gtMwhXqWxJ3ULbDnuVyJjUJZl8hAKfQ4+TfMHPKff0ehsR8kziHfIJm/2vtl1SZxwEg
         bujOSANdLiz2pTHsXsWc/czK4ZHFCme4KtKuacXoO9ckL4brvR6p/6b56dTgWNuFYjhU
         ZcRJ3hqaw9b0IGS7tva0ZoQP8G+S7OTVCeTDp9BeBleuaSEu6XCKu+puegfofCW2t5r2
         ZSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUMDHkRP/8Kobp4SqOhIfI5YC+CFPdiLYdQuQeo5ONc=;
        b=DQXdOFQjNmO09ai6abbqCNe+rSdeC+3chUWp5h6G2a7WSrJbivrhc6TnluqhvyhUN9
         YG4K3Gw+QhXJif4HGzZVYXQOUVe+d7vXol+1jjdwNKL/4m1ajCrOxdw5mPFGceHLKnk9
         sRtxySAHcfCnaPIG+8UsbuJAsM7OO4tQB0jl4/4mKHFR0bJYllGgdN1gKpAcbN0Z+lPd
         1y5iRYTdV6F7PwI5Og+vOHWGHSzVhcLncQrKLSLlv+LNoLr7D85iZDe+jCPUxaLbH/fb
         jJnyxisoqRcyWw+LyvOiK0EB8GEn8Y7WDV229kqopuNRPfl2ce2+sLvefn8XVMvYGyFQ
         iXJg==
X-Gm-Message-State: AOAM532TfdnVMctriHoSs7FtUspqoWM9p45CXipSjlxig2ZrZalbuDAd
        ghrJ8cmEHdmYca03i2cdSWBATFgDUMG7Ni3ohww=
X-Google-Smtp-Source: ABdhPJwMicyHr4xbXXojEjRJ03bg1BdpiBkV88I0GL3Zt5Cq/INEqoCBMdWWNfR7Tvl3MMcPhTbTsWgRwj+E1Je693A=
X-Received: by 2002:a25:d456:0:b0:633:6b35:bcf5 with SMTP id
 m83-20020a25d456000000b006336b35bcf5mr25408116ybf.239.1648517751767; Mon, 28
 Mar 2022 18:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <7cc9a7b5f7e6c28fc9eb172c441b5aed2159b8a0.1648461096.git.zong.li@sifive.com>
In-Reply-To: <7cc9a7b5f7e6c28fc9eb172c441b5aed2159b8a0.1648461096.git.zong.li@sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 29 Mar 2022 09:35:40 +0800
Message-ID: <CAEUhbmUYZ=htiQUwiLZuBufj7=p6ATR752N+qUn-=Gy7Uz04Uw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: dma-engine: sifive,fu540: Add
 dma-channels property and modify compatible
To:     Zong Li <zong.li@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        krzysztof.kozlowski@canonical.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 28, 2022 at 7:56 PM Zong Li <zong.li@sifive.com> wrote:
>
> Add dma-channels property, then we can determine how many channels there
> by device tree, rather than statically defining it in PDMA driver.
> In addition, we also modify the compatible for PDMA versioning scheme.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
