Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17B3BA518
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jul 2021 23:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGBVkK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jul 2021 17:40:10 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:43935 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVkI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jul 2021 17:40:08 -0400
Received: by mail-il1-f173.google.com with SMTP id g3so9775687ilq.10;
        Fri, 02 Jul 2021 14:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYyph8nrXzYeAFYlpDbusdemGHzqXKlwZfNTuv7wxWU=;
        b=nqjZaNZKwCC/DPk06oYkUFgUSunHl4Y2EMxf+56VHSkoWhEnFVIxxA3cOLebsnB7x8
         Jo64Tj047QxVOihoXNad8lBAaJmFgbGzh1/EhyJdfTAGSBiJub/e3iYWWqg5nAkkkQ6p
         iZmyRfHDzhY4Ur+6uorlShsttZ1e5lbELXA0AUrGuMxP6n+/UVRU3SkW+U7BzQZEYnXn
         xW1kIzQ+8k76hBQoJ8Z5+2Ch9VwJ70rxs53NfwVQ/POgGwz8CjMua2R9REjeI4lgoSOl
         j0MTUyBcM3TRJT+6dqn4D7O1vVcraFx/VUuUK9lY3ZX/WeyiBBq6vx0E10p8Fw/k8038
         pDww==
X-Gm-Message-State: AOAM5310H8DUXWSIqElMDLceEB+/Q0uKKqULVLYoxMwqVyplgKqBILal
        fAFKhiU9GIgUat4Yzm+P28ccZkiJzQ==
X-Google-Smtp-Source: ABdhPJyGdRJcTdbTC9KEycbjoSYoHLWUZktYrtueoXQbrskJs/Rqc6mtGRBbxvZC7NblRiaChIsKZA==
X-Received: by 2002:a92:c887:: with SMTP id w7mr1370838ilo.28.1625261855659;
        Fri, 02 Jul 2021 14:37:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v19sm2260356iom.32.2021.07.02.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:37:35 -0700 (PDT)
Received: (nullmailer pid 1061679 invoked by uid 1000);
        Fri, 02 Jul 2021 21:37:32 -0000
Date:   Fri, 2 Jul 2021 15:37:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: dma: Document RZ/G2L bindings
Message-ID: <20210702213732.GA1061622@robh.at.kernel.org>
References: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
 <20210702100527.28251-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702100527.28251-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 02 Jul 2021 11:05:24 +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in
> next 5.14-rc1 release.
> 
> v3->v4:
>   * Described clocks and reset properties
> v2->v3:
>   * Added error interrupt first.
>   * Updated clock and reset maxitems.
>   * Added Geert's Rb tag.
> v1->v2:
>   * Made interrupt names in defined order
>   * Removed src address and channel configuration from dma-cells.
>   * Changed the compatibele string to "renesas,r9a07g044-dmac".
> v1:-
>   * https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210611113642.18457-2-biju.das.jz@bp.renesas.com/
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
