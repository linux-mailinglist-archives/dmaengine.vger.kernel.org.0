Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85B4FB201
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbiDKCyY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Apr 2022 22:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiDKCyX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Apr 2022 22:54:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A8101D9
        for <dmaengine@vger.kernel.org>; Sun, 10 Apr 2022 19:52:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so18404358ljr.9
        for <dmaengine@vger.kernel.org>; Sun, 10 Apr 2022 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKaNytCrnwRly85Cf4rMP6kv73OcecChjT7UHRYi0pY=;
        b=foU1Pomdt1fSDC1+Vo7+ND9Fu80KDnPA26WJ6965htPY3McsZwzjuN5iS1aJSmS/2e
         c0bzdfE1d1aeur800axp47kax1MwU/ItdIQ48aO+x7f6q14qTO7FouaXMUew5eR39Qjz
         wxT0pL0KlELChxAByT+Cy8RYGO66VavKzSZonGJg5yLbMduZp/sntcIf5zDmhHXzCPLM
         IpcVenUyQ/9RAaYt4B2RIiL5Ssz0dcqz+b92GuO6CmPFyu6Y7BpBEUObsG/K1lEwKhVc
         2cOuKb0CePD1Jnm1oeR0BJQZv5ClNsw58kaSgkK7JuDUfqsfqDXeCcOoudlg7zsmKHql
         c6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKaNytCrnwRly85Cf4rMP6kv73OcecChjT7UHRYi0pY=;
        b=e9NPUG1D4Ofns3c+RdGzOjPB2Jm9Vh2pHBTVC0H0rtplT+TZPBJpevEBWPamjYxd0y
         6lrkqZsmm+tEq6q5aqAbqAXuYj294O2Jw2oBZ4CCOn++/dk8vyjYjQ86LV6WdtuMttcy
         DNbWRHIV3gHRcrZjhqZXp/vpOym94nGNJp5mMp6evfFGQ3cSPcj1BbWBYGYCbcQp+JP+
         i38OuRCBQidZ9LWw0Fcby5fqpYfKVUXiEqOyFJHqsOsCpQKabHCzo3bWFUSlX3PP03w/
         q2pK3jUUPpD0dl/SC9q6A1BlyNoTxeRx+z4gBPbzr5tv9HlC7t5ILhxDFiioqkO5jrnN
         6hiw==
X-Gm-Message-State: AOAM530cPT8VQx0uK2vU434EOmhvNsk5Scz1bHTJrPrOSKJYatBqEczW
        4NFBJS4qZcjNI/Y9zeLwdAlaWUOs1Ry7v6Sn6yDsdg==
X-Google-Smtp-Source: ABdhPJze/vdOb2Ppa73SdqfmkL8HEWn9w36G2tkOYs4HJBUnTuZaOZgaU3/KS+dpOWgdaEdvtAFQmU/3GlJ89pUlBI0=
X-Received: by 2002:a05:651c:544:b0:249:9db6:2472 with SMTP id
 q4-20020a05651c054400b002499db62472mr19462133ljp.516.1649645528693; Sun, 10
 Apr 2022 19:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <YlA1DwdIMoQ1dXZS@matsya>
In-Reply-To: <YlA1DwdIMoQ1dXZS@matsya>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 11 Apr 2022 10:51:56 +0800
Message-ID: <CANXhq0ramPvr=CL2oPsPAnWiF9X0eYVt8HGAVWPE9mZ5PfhG7A@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 8, 2022 at 9:13 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 28-03-22, 17:52, Zong Li wrote:
> > The PDMA driver currently assumes there are four channels by default, it
> > might cause the error if there is actually less than four channels.
> > Change that by getting number of channel dynamically from device tree.
> > For backwards-compatible, it uses the default value (i.e. 4) when there
> > is no 'dma-channels' information in dts.
>
> Applied patch 1 & 4 to dmaengine-next, thanks

Hi Vinod,
Thanks for your help and review. For patch 2 and 3, does it mean that
we should go through the riscv tree?

>
> --
> ~Vinod
