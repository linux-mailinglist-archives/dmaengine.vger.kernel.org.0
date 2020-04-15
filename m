Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B883B1AA37A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506003AbgDONKV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 09:10:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40984 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504628AbgDONKD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 09:10:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id f52so3283019otf.8;
        Wed, 15 Apr 2020 06:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9qFaonjPRW9YmEnwpksQX2HJ6Eu2laaNELJr4ZepKs=;
        b=UsRMem+4nQ//2nHIUdfqW5L2C/Wo3qHzMPnrfFDOf9VpxNpGGGFiGoP2Hvbwb5BFBS
         1ptvSCRn/kAi00NBjpAjmcpbGVz5BQFAIaqsGvrBxpiGgK4MuCR/UJrzqIuaq2pmuAnS
         XNJk2xi71wSNQhm4W5OjDMwk1xvsuskidrhToY5+IMVvl2ta2m63Oqhe0HkHDUtL7BFB
         a/sU/OayLZHK+rj42xjGUl+0V6g1p3oMY+6p63RxnOlvkUzxTEG8SpeYU4bndpFbVhIU
         LdmIPT8dNVCoww0kgPbEIJ70WbZ/05TJpNkRwQxH3UwRn//gWBjZl2b7mDmkX5NAm+Ib
         gRTg==
X-Gm-Message-State: AGi0PuYiGLo7txRGJrJrpozJJfSNCf1p06mOj3AuAA9ICZ93U8dQldFs
        rDD8Gfu3H8wPWB/X7R6XMedaY3lZoukEDUYngiQ=
X-Google-Smtp-Source: APiQypLShKZQeszRkfUd4JX09QyAsJLhw1FNdbkBHMtLuShW145jHc+V4wPdNtNpXwRXxnGu4ITkOPujBryR9ze8Mnc=
X-Received: by 2002:a4a:e1af:: with SMTP id 15mr1097315ooy.40.1586956201952;
 Wed, 15 Apr 2020 06:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1586512923-21739-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Apr 2020 15:09:49 +0200
Message-ID: <CAMuHMdULExMNnKJWsjAonR1sVeTyQCH0shwO--Wo6dLzrWV_tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dma: renesas,rcar-dmac: convert bindings
 to json-schema
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

On Fri, Apr 10, 2020 at 12:02 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Convert Renesas R-Car and RZ/G DMA Controller bindings
> documentation to json-schema.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One question below...

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml

> +  interrupt-names:
> +    minItems: 9
> +    maxItems: 17
> +    items:
> +      - const: error
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"
> +      - pattern: "^ch([0-9]|1[0-5])$"

Would it make sense to just put the actual names here?

    - const: error
    - const: ch0
    - const: ch1
      [...]
    - const: ch 15

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
