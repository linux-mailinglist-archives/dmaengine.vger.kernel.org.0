Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6838B3CD60F
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jul 2021 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhGSNHN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jul 2021 09:07:13 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38862 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbhGSNHL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jul 2021 09:07:11 -0400
Received: by mail-io1-f45.google.com with SMTP id k11so20008755ioa.5;
        Mon, 19 Jul 2021 06:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2fiuab3AUpirMe+xcclBf/WRW6F2pGS4dTs8jwQGUok=;
        b=rRKzrFG5kP1ZnDRHejsXEeT2mvpcay1R8SgXex8sQTeMdMfibVvDKe9OriNc+L8PTU
         8lOxpqlvhugX41u69deGWf8fRFJsHSZXape2AV/hHlU/aTPQo6SH1CSyjhRy1IMUmtiU
         LgI3un7qrkRDz5DBRW4MZaE9/otEKKmxiAw2WrTEOgG9nKdR0TFBbGevqVeI53hl40le
         2xxuZk9Loy7P8m2Ytfu0a4qA6syfHobjlaeryee6fLmslESPLTczhXkrKpyRgVcqDeK2
         jSQ3aZ4j/fsGcNy+MY4vv/jVw4K9Y+Zyuuk0zSuGhwVaIgquYwgx3z5Jkdd3u3Z/oMIK
         XaGQ==
X-Gm-Message-State: AOAM531C/qAxfm2zkFOlHJPuFEa40H+NfSMRhZhxOtrLWiRrqyYbu2xP
        BScEZLRBDpgz9ZDeZUZBfA==
X-Google-Smtp-Source: ABdhPJwtlqHg9Kb15lUpckwCOQNa37haWnmd3xy+aNRnUC51mh9WF0lrFw3p6rfXDDQsCQrzJo6s+w==
X-Received: by 2002:a5d:8888:: with SMTP id d8mr18994729ioo.170.1626702469074;
        Mon, 19 Jul 2021 06:47:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12sm10612764iom.6.2021.07.19.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:47:48 -0700 (PDT)
Received: (nullmailer pid 1811208 invoked by uid 1000);
        Mon, 19 Jul 2021 13:47:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <20210719092842.4686-1-biju.das.jz@bp.renesas.com>
References: <20210719092842.4686-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: dma: Document RZ/G2L bindings
Date:   Mon, 19 Jul 2021 07:47:28 -0600
Message-Id: <1626702448.459307.1811207.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 19 Jul 2021 10:28:42 +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v4->v5:
>   * Added Rob's Rb tag
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dts:49.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/dma/renesas,rz-dmac.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1418: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1506873

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

