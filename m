Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3ED3AA0BC
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhFPQFY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 12:05:24 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45722 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhFPQFX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 12:05:23 -0400
Received: by mail-il1-f169.google.com with SMTP id b5so2760294ilc.12;
        Wed, 16 Jun 2021 09:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=kwPi2g4FGY+Jx7RaNgQmOzIxYEO+PVqEYf4NO4F2AVQ=;
        b=j+yZnDMFpBsyKZF256ekz2Ov32C37JzD5iTD7FwbBXAN1g13LhoEY9TamFTNgfSskk
         3N6lpaim6jKnf0gL+uwWFxS92DsT0rqZ5AIy85gCca2yDjbb4TLOFc0Sr53fazBUzIqQ
         +XICRRRxKh3XCPt0z4B+evY+1AYaLmVXgtpGuLdOpovBONRoQy63yPteobKx30+vNnwl
         Nk9kDIqQ+kLBYRPGroUnJVt0nyqsflBvrjkY2lHKrNDOaHQhzTIaNGvnloWIlSAbCI62
         tAkna6RJyf4bdjV721ik4Ehq75GEgR6CCnxSokaFsDyHlF0bCre/HXdg1pYUCbIXS32o
         QdCw==
X-Gm-Message-State: AOAM530zKxNLNrrCAW5nqr1w+FxGog4x3bY+WWIXpVDh7B5iQwLdjQjw
        II5D39LOiSaE41FPAg/f5A==
X-Google-Smtp-Source: ABdhPJwxhRcWDnn+qJ4Dl96VBWvfHgqrknjgKnrgIf/6uMEZ+Rn+xyKH4qHFEhb/hwoesKQ34Pg3sA==
X-Received: by 2002:a92:dc49:: with SMTP id x9mr294547ilq.144.1623859396412;
        Wed, 16 Jun 2021 09:03:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w25sm1358120iox.18.2021.06.16.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:03:15 -0700 (PDT)
Received: (nullmailer pid 3471590 invoked by uid 1000);
        Wed, 16 Jun 2021 16:03:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Biju Das <biju.das@bp.renesas.com>
In-Reply-To: <20210616105557.9321-1-biju.das.jz@bp.renesas.com>
References: <20210616105557.9321-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: dma: Document RZ/G2L bindings
Date:   Wed, 16 Jun 2021 10:03:05 -0600
Message-Id: <1623859385.197234.3471589.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 16 Jun 2021 11:55:57 +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in
> next 5.14-rc1 release.
> 
> v1->v2:
>   * Made interrupt names in defined order
>   * Removed src address and channel configuration from dma-cells.
>   * Changed the compatibele string to "renesas,r9a07g044-dmac".
>   *
> v1:-
>   * https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210611113642.18457-2-biju.das.jz@bp.renesas.com/
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dts:20:18: fatal error: dt-bindings/clock/r9a07g044-cpg.h: No such file or directory
   20 |         #include <dt-bindings/clock/r9a07g044-cpg.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1492896

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

