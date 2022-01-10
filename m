Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9E48949F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 10:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiAJJCD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 04:02:03 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:35669 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiAJJA3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 04:00:29 -0500
Received: by mail-ua1-f50.google.com with SMTP id m90so6871773uam.2;
        Mon, 10 Jan 2022 01:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NhtBWzQ5apsDhjpCyjxZEW0Il7Jt/CqRkEvPo1Xwf8=;
        b=BaEL8y1aUS20a94tbSZHSEhXO70YCxxyBHC7LdxaR1RXs9+qO6hWzW32p5SSG4zhtv
         BeKvvFaAAzY1tLrkqEdmvIeC7umirBmkgRBCi4vRmj2AjW6uxWWgXC00Dqu9n5HaTO6X
         NofbNkKtWwkLzhvs++ReA/trOQSU1LTNwHEPCI9AhvdT7ScUCgeezPPdSvrQnf2c22IQ
         IKFjWuiy+LID4ELIKGW4LAps0gmdEkWClw+QhouIQ5eVojmJMSTX0l24pklDBh5kK2Xu
         kyrrRgM1m9WaxAplETYGxyIA5pvwrai0r4rVWYZdoUxMXRf4hpLPVFKu6itsS2t/gkid
         F67g==
X-Gm-Message-State: AOAM532Vb6Met+qsXgysLORKQA1kbPCTSCMLv6kz21UJUoJU+cRyuxMp
        o7ZgUC75ys45UhuH6G5ltAHEH5MOZ2zQRg==
X-Google-Smtp-Source: ABdhPJzUqwqg7A1u/EPIdXKEQ2fkQIQtqmXnNKFqJB/1VrLAzWGxs4Uy/0Ovf9gaGgF5sf4YV2sqLg==
X-Received: by 2002:ab0:3301:: with SMTP id r1mr24729796uao.96.1641805228239;
        Mon, 10 Jan 2022 01:00:28 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id f132sm3508217vkf.18.2022.01.10.01.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:00:27 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id p37so22113110uae.8;
        Mon, 10 Jan 2022 01:00:26 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr1097590vso.77.1641805226820;
 Mon, 10 Jan 2022 01:00:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641289490.git.zong.li@sifive.com> <0419b2865c87f72adeb4edee9113a959e468b4a5.1641289490.git.zong.li@sifive.com>
In-Reply-To: <0419b2865c87f72adeb4edee9113a959e468b4a5.1641289490.git.zong.li@sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 10:00:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUyYVBXAeJ8XS9OsUePpFLgpCXYT5rH_bJCvCg3eaav_w@mail.gmail.com>
Message-ID: <CAMuHMdUyYVBXAeJ8XS9OsUePpFLgpCXYT5rH_bJCvCg3eaav_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: Add dma-channels for pdma device node
To:     Zong Li <zong.li@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>, green.wan@sifive.com,
        Vinod <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Zong,

On Wed, Jan 5, 2022 at 6:44 AM Zong Li <zong.li@sifive.com> wrote:
> Add dma-channels property, then we can determine how many channels there
> by device tree, rather than statically defines it in PDMA driver
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -34,12 +34,17 @@ properties:
>      minItems: 1
>      maxItems: 8
>
> +  dma-channels:
> +    minimum: 1
> +    maximum: 4

As per my comment on [PATCH 3/3], perhaps you want to use a default
value of 4, and document that here, too?

> +
>    '#dma-cells':
>      const: 1
>
>  required:
>    - compatible
>    - reg
> +  - dma-channels
>    - interrupts
>    - '#dma-cells'
>


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
