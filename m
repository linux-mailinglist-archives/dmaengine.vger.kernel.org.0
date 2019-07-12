Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48D66FA8
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfGLNJQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 09:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbfGLNJQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 12 Jul 2019 09:09:16 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF126216B7;
        Fri, 12 Jul 2019 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562936955;
        bh=W6YIjaFSzzjtMDBKWJodMGbfMMX0VBoh4+APVLIt+SA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vUVTFwqC/zGAaW1/n5WXHjBkKD5Ypuvc083w2flxQ9TarX9sAG9ByX+2dIPw1VnBQ
         /YYcR5XF85+qqJPxwWh9K7AmlV/l9CLUb3ty/1nToUwE0YKacb3+faHzp4yrfjm+yu
         HU5arit/ux127/xK/l9dqc7i4fVFk64VHicdMbxY=
Received: by mail-qk1-f181.google.com with SMTP id d79so6278170qke.11;
        Fri, 12 Jul 2019 06:09:14 -0700 (PDT)
X-Gm-Message-State: APjAAAWdF1OuTrpILhsv1LzlregNF6q2n/h4SWk4ZIYmEVq+NwJpsZY2
        ASu1pcKFHEkkSUIgAzddKf+nUc53OhCWWHCZdA==
X-Google-Smtp-Source: APXvYqwjdoQwR8x8UTFOyyGiPA50uzJD5f6PGF0aB6Ty2QtFOm2DGDacJSD7J67xZOfZmZOUg59B3SH4VdFNnGwzYkM=
X-Received: by 2002:a37:a010:: with SMTP id j16mr6412048qke.152.1562936954182;
 Fri, 12 Jul 2019 06:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190711092158.14678-1-maxime.ripard@bootlin.com> <20190711092158.14678-2-maxime.ripard@bootlin.com>
In-Reply-To: <20190711092158.14678-2-maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Jul 2019 07:09:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJkoudu3mw9wVuN1RM-VPGSWj+Vv6L=C=N-DtW_vOAdA@mail.gmail.com>
Message-ID: <CAL_JsqLJkoudu3mw9wVuN1RM-VPGSWj+Vv6L=C=N-DtW_vOAdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dma: Convert Allwinner A10 DMA to a schema
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
> The older Allwinner SoCs have a DMA controller supported in Linux, with a
> matching Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../bindings/dma/allwinner,sun4i-a10-dma.yaml | 55 +++++++++++++++++++
>  .../devicetree/bindings/dma/sun4i-dma.txt     | 45 ---------------
>  2 files changed, 55 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt

Reviewed-by: Rob Herring <robh@kernel.org>
