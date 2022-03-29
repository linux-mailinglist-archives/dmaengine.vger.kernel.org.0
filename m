Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55854EA4A4
	for <lists+dmaengine@lfdr.de>; Tue, 29 Mar 2022 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiC2Bhj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 21:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2Bhh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 21:37:37 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654351AAA6E;
        Mon, 28 Mar 2022 18:35:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2e5827a76f4so168135377b3.6;
        Mon, 28 Mar 2022 18:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7I0uwf8IPEu8YwRUskYNPlj8l3hoiQdHtSwce4QS7o=;
        b=Vx6jozgmhNiZW7zvqD3KrH3lrJNzYe8cexbc0wIdzb17NWZRbkHgVC7ZNDnPDFbRDG
         tJNCmG99+V7qm6qWdu+6Rxr0Qf7j3w5Crxl8PWA1QKmeIAVrBbdRg+nfnTJdmsQg0Coe
         1DUMmQz6N91Sw+sOb79eGNrH6AYblLpqhLCkxPVdcNZvDydXIhQm+tEeBe3Suv62A4WG
         bLZ7KAxehj3xBlzHRiU2bpVzvdRZSrHQDspPZV6L4OmVdssGm4cH9LGQec6iwhr/qpPb
         u3J/rWnM1JoadRNB0ypcBU5z2TsQno/WKbSgkF8Wug7HwCO/ype3mFJR9wxADsdd2KLw
         UU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7I0uwf8IPEu8YwRUskYNPlj8l3hoiQdHtSwce4QS7o=;
        b=4F8uRtS8VT7SkC9gc9hX0VhK7ZOc6+w11CWBaVwopu3OEWExiS3lSo3OoCe+C54mkI
         zc3n8UrHMC3+CkmvyRwE7VHaJ0AWPsSPUFanVCWHK+7bMeQEQymZcNPBqE2yY4/1fjIj
         2Y4PUnXAyLY9CNAyflsrJ1aBFTwA/xkIWCuHfbZt4AkcdUTFtFvVT3xJvds5o6oD1QcP
         xW7N9SHqXzZISejipqHIjcGSu9Jq+/BjZNbD9WhpPwPphJb5GAAYrxkL2FuB3dXGk4W/
         JTlPVyxsW+oU3ayDZITf2FsQJsN7wQlvZ8MI87epUfYkiomHXYj87Q8pcDZHm6RNa7Sr
         7gyQ==
X-Gm-Message-State: AOAM532mbwyc6Kotr6soBxGxZyqRlN4TYr5CT4u2bR4cizIH88//MHDA
        QaIE5/8xs2mQytFhJoVNOKqtTBNT1pDigzgpXsI=
X-Google-Smtp-Source: ABdhPJynywOppsd9u0oECrk1vvbMGNhMwoQbM2BOGEyu65aUGesK63Ug72+zCl1851ZeRt6xxCLsCVxmIABYLlwyQAI=
X-Received: by 2002:a81:1bc3:0:b0:2e3:aa1:f553 with SMTP id
 b186-20020a811bc3000000b002e30aa1f553mr28349485ywb.491.1648517754634; Mon, 28
 Mar 2022 18:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <d19daa503fb242eef00d79082931199cb3e48021.1648461096.git.zong.li@sifive.com>
In-Reply-To: <d19daa503fb242eef00d79082931199cb3e48021.1648461096.git.zong.li@sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 29 Mar 2022 09:35:43 +0800
Message-ID: <CAEUhbmV67ms9za3BX9TvDah0_71gP0cRqGNLGJ+PCPG2Jxb-EA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] riscv: dts: Add dma-channels property and modify compatible
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

On Mon, Mar 28, 2022 at 7:25 PM Zong Li <zong.li@sifive.com> wrote:
>
> Add dma-channels property, then we can determine how many channels there
> by device tree, in addition, we add the pdma versioning scheme for
> compatible.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
