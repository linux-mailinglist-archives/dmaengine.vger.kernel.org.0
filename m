Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB141AD78E
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgDQHi3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 03:38:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44689 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgDQHi2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 03:38:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id j4so691959otr.11;
        Fri, 17 Apr 2020 00:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIWwQv26VIVXOmhR5PyVkihL5BOBmBlh7HlW4wXcRxU=;
        b=UO8P3fCrOVDIifPhSJYluqb6r4cJKLwc14MBotZf9Z/75ZjMoApavdqYdx/tV+NjWF
         mk7Yum2xe10xtt7J5ZJF6Il8mkgIFfv+04CAXKSv+bWiahUJLo0JXqn98XjgaMA6i+NC
         //V0Ev+hiBov3k7OQJuyQammT5n7bZC4UnKlI8sOpFZjilapMdhSPp/x167FTq8QUVEp
         Of5XuPNzJkj00195ihGjZ9b69dOcfkApAdfWlHtg3B2BQm9HjaK9qHqWiYFky+OcELFo
         JMgH+gPNZIwCnCDiUfXh3YTEFmiPiSWM0Rz68DZDQnn4Og36W/63LQh3/VrlAOGZGBYF
         pKHg==
X-Gm-Message-State: AGi0PuYu13Gi4r0k/1xYLm822d3R2DONSf+5w6mNuq0yzAl/0kXfFc0q
        IfzFlGo7YikGQrBfMNVy/vrwibKvUiH6rn3e1Y3EOpvv
X-Google-Smtp-Source: APiQypLwfQvN8h4h7bPR17YD3xh4WDlxXcuPgzXNBUI4pqjzbQeC6XnQKNvmq3QNN6iXpby/aOhuM4uJisvl+oedVeI=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr1570852otk.250.1587109107894;
 Fri, 17 Apr 2020 00:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <1587095716-23468-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1587095716-23468-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1587095716-23468-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Apr 2020 09:38:16 +0200
Message-ID: <CAMuHMdWXMcSgjOGwzMD+7R37at1v7db-neM9VgMRh+hMVp-aYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: renesas,usb-dmac: convert
 bindings to json-schema
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,


On Fri, Apr 17, 2020 at 5:55 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Convert Renesas R-Car USB-DMA Controller bindings documentation
> to json-schema.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
> @@ -0,0 +1,101 @@

> +  interrupts:
> +    minItems: 2

Don't you need to keep the "maxItems: 2", too?

> +  interrupt-names:
> +    minItems: 2
> +    items:
> +      - pattern: ch0
> +      - pattern: ch1

According to Documentation/devicetree/bindings/example-schema.yaml

    The description of each element defines the order and implicitly defines
    the number of reg entries.

So I think you can drop the minItems.

> +  iommus:
> +    minItems: 2

+ maxItems: 2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
