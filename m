Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2A66F98
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfGLNHs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 09:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfGLNHn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 12 Jul 2019 09:07:43 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD18216E3;
        Fri, 12 Jul 2019 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562936862;
        bh=8J76JtIM5UW4BCsga1T8Xf5XDKop09AqspKP/Vk8ggU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUPNPXY4lv03ZbwHL8wnKmXnCnfoDk2qK3bWro79xj67IUSK7OKAGvlhOqU7VYwjk
         mcTbX4Vq4+CDJx24I3iP7YIjLW0p3f24ZpXMTrs8ybfXqiQwUeHkKk3u2Ylm1hDBe9
         H0F94uby5Z1sx44dAWNzYkj6CdShtLLOP7DcciMM=
Received: by mail-qk1-f179.google.com with SMTP id m14so6274348qka.10;
        Fri, 12 Jul 2019 06:07:42 -0700 (PDT)
X-Gm-Message-State: APjAAAWI/LzUL42Jn+/bVLeD+ohRgr4odvj4JSao01yLUvLT1+r/AGB0
        zGiaXwhaqfMkzEmnoGZJz3vmFMcU932Ao7z9Xw==
X-Google-Smtp-Source: APXvYqwPav7WNzk1nC8clhcOKZKa5N2Lh/bDVhexp0tydAW/XvWKuUtshKyZEaqfmvWDRKsvZut5biiZ/R7wYPtJ3pE=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr6365679qkl.254.1562936861782;
 Fri, 12 Jul 2019 06:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190711092158.14678-1-maxime.ripard@bootlin.com> <20190711092158.14678-3-maxime.ripard@bootlin.com>
In-Reply-To: <20190711092158.14678-3-maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Jul 2019 07:07:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrVRsWM5ORM9QwjgJyVuPUauCXcY24Qvevvo7wRWgvmw@mail.gmail.com>
Message-ID: <CAL_JsqLrVRsWM5ORM9QwjgJyVuPUauCXcY24Qvevvo7wRWgvmw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dma: Convert Allwinner A31 and A64 DMA
 to a schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 11, 2019 at 3:36 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The newer Allwinner SoCs have a DMA controller supported in Linux, with a
> matching Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../dma/allwinner,sun50i-a64-dma.yaml         | 88 +++++++++++++++++++
>  .../bindings/dma/allwinner,sun6i-a31-dma.yaml | 62 +++++++++++++
>  .../devicetree/bindings/dma/sun6i-dma.txt     | 81 -----------------
>  3 files changed, 150 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/sun6i-dma.txt

Reviewed-by: Rob Herring <robh@kernel.org>
