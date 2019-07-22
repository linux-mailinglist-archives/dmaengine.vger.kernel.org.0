Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DAD701B5
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfGVNuy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 09:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfGVNuy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jul 2019 09:50:54 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FCC21BF6;
        Mon, 22 Jul 2019 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563803453;
        bh=hDcfTcAyKk/cAZbs70RcptCtShegPKeJ1uI1eY8FuPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xMKjxarVo4A+BUbOI3rs05QqlUUfVfZZp9djm0P0PirgBrwD2cRKtqA2jbIgBCzSz
         i8joprx8AW5LlTSAFSnQHlr6uZ056LPEL8R1t6AJdCbYw+Y74+3nzPBn1+pGPloaST
         aHfg48KjDgWi/mhFckIEPe8wL7XzF9mKxJZPRgPU=
Received: by mail-qt1-f170.google.com with SMTP id y26so38565742qto.4;
        Mon, 22 Jul 2019 06:50:53 -0700 (PDT)
X-Gm-Message-State: APjAAAXtAAqEeZAtuGhYNdk5sBRVHNq9SwQAYTjrjiw0RFC9mba6tdrd
        vPcO1sGxCgjsvW9eA04nBrba58gpZXisVNMzEA==
X-Google-Smtp-Source: APXvYqwflr7eEPfqc65hiWx8dqu/FZ0+6ATGFTjcgLb/3+BvCbBiSuD7MOb4l57MYbVJ9vrYKKqkbj/a1UxlqwUjTPM=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr4648619qtb.224.1563803452314;
 Mon, 22 Jul 2019 06:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190720092607.31095-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190720092607.31095-1-maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Jul 2019 07:50:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL2dxZMpwP08xMjwdkv5kdeZGrTYwdHuvqAcY-nBuZ+fA@mail.gmail.com>
Message-ID: <CAL_JsqL2dxZMpwP08xMjwdkv5kdeZGrTYwdHuvqAcY-nBuZ+fA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: Add YAML schemas for the generic
 DMA bindings
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jul 20, 2019 at 3:26 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The DMA controllers and consumers have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v2:
>   - Added a select statement.
>
> Changes from v1:
>   - Dropped the dma consumer schemas
>   - Fixed the node name of the examples
>   - Enhanced a bit the description for dma-requests in case of a router
>   - Split the bindings in two to handle the router and controller case
>     separately
>   - Made #dma-cells required
> ---
>  .../devicetree/bindings/dma/dma-common.yaml   |  45 +++++++
>  .../bindings/dma/dma-controller.yaml          |  35 ++++++
>  .../devicetree/bindings/dma/dma-router.yaml   |  50 ++++++++
>  Documentation/devicetree/bindings/dma/dma.txt | 114 +-----------------
>  4 files changed, 131 insertions(+), 113 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-controller.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-router.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
