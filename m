Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2E4EA4A5
	for <lists+dmaengine@lfdr.de>; Tue, 29 Mar 2022 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiC2Bhk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 21:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiC2Bhj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 21:37:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218A1AA8C4;
        Mon, 28 Mar 2022 18:35:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2db2add4516so168676527b3.1;
        Mon, 28 Mar 2022 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehNPWSEgPJrOTf7/Wp6gE2/wrCtVHAQ8IcovXGy9V4U=;
        b=H5WsehtZRcaN9DToOC1NzmwrFFT04PXuDP2xFaJ8eCuDAHHH4EYnTJ6pE1jw0ONRKc
         mU1qfZiLfIRUaQhSw7lbQ0oqBJpxRoFF1tlnlWpTyWSQ1FbNoJyS7Xl7B0ZsWlKIYc12
         ANPGXdBv3fzVx8wzgZ5yO9bsFd56XOQSe8G+G2wJqvYqb5LeUbKTfP4H4/kSew2XBFPT
         fz3aA4rGZlUuZUj4FWlDyE56sUlqsZNLYkUrUpIdLqn/iNUZwYNhrQN7QiMHBbwrdqo3
         yKG107IkbazMCEeqBCduCZadZ0aEBeKeu17nigLd3bS5H1rF3UaCffyPR2DIDmuIYKLK
         PP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehNPWSEgPJrOTf7/Wp6gE2/wrCtVHAQ8IcovXGy9V4U=;
        b=JzPkwJCYP/BRqhBRbF1VjhKFsT+6XYOW91kwcNnFyvmMSMCG7oLL8gqfYNGfZ0PlFx
         S+FiPtWON1L0J27jfP6ZW31dMyTtbm4dixMZAjxDYr1xoH3/IWKUWP6hc/X9ly+LCOUq
         HWXt/erTqLLiwHDFY6J2UoXyoSHi81ju0HmqNHSlTKN9NEXmbbyZ+dIPQAYDfZ3mPZQz
         nxN1M4Zq59BNz4Fp6V/KfEFe9iRD6uLwpoZnobDCIQyg61/ckwKdjP/HK+utOTltUHZi
         meY7jFmL4Z3AAF1pveiuOyv3A1t1FGh5jNiqycdqVFtEq0tL3djmNp1ppqpyWueJ9I8q
         Qs0Q==
X-Gm-Message-State: AOAM532xnQ2H0V5LwwnTLMxikQ7my8dBzhX0gyJC5pnf17Luy5dNi2P2
        oAdkqunI79kk+Ow8xN+8IZvE/pH5VXWJttFRQVk=
X-Google-Smtp-Source: ABdhPJykJRyB+9MTMv00Xj1zdaq2+PZt+stBz9dbr6ukPhkeZu2oA9lSjQ2CLNMKCbl4bgPiJAYvCWQOQ2Jj/+L0EHs=
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr28536934ywb.132.1648517757742; Mon, 28
 Mar 2022 18:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <edd72c0cca1ebceddc032ff6ec2284e3f48c5ad3.1648461096.git.zong.li@sifive.com>
In-Reply-To: <edd72c0cca1ebceddc032ff6ec2284e3f48c5ad3.1648461096.git.zong.li@sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 29 Mar 2022 09:35:46 +0800
Message-ID: <CAEUhbmXoaCXqvOAfLWavG8rvN7-rt=YOZys-ffYti0Wmtvc6XQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] riscv: dts: rename the node name of dma
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
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Tue, Mar 29, 2022 at 6:27 AM Zong Li <zong.li@sifive.com> wrote:
>
> Rename the node name by the generic DMA naming
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> CC: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
