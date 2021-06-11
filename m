Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6A3A482F
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFKR55 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 13:57:57 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:39594 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKR54 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 13:57:56 -0400
Received: by mail-il1-f171.google.com with SMTP id j14so3135918ila.6;
        Fri, 11 Jun 2021 10:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eS7FoRD0YGUsWFSvjA1QCJvmsWkR4OAgwFy2PP5WSik=;
        b=ExK0KnhyDgr1mHze7TtcUu0i8B5Tkk/RYOuOXh9+A6/aB6J+bZq9EL8l0BygNMfCgw
         RFS5aDDu7FOH8hXJ+X5mwwyzlhLn7HxDtp1CYwoGGJs3+CllgYeArocTNNV05ezqozBX
         aWr0/BJB7juUH9HDgoivtCQ2/K+QMsuYeSKB1Ro4B6y6hqMcdZ1o/SNoOccGsyzZRAWK
         4ev2aagrCDMjagxjMFp8LCi3/klZqb2bSn0CoVtkaBQSzVCIr8gKs8D3+XdLGdBWHvZM
         GNRhDgvf+F5h8llWM0F2Mer/CaSQCUWyARJRElCv/UoP+aJWvOLHfWpOOoclpFsYma6D
         SBFA==
X-Gm-Message-State: AOAM531dOUbAAbqjGSj6QcRtE0CI6mUpvQSgGq+lm3yCKVVU/8bE3xw8
        haE6vd0Vj3eq5EW8c7ApQw==
X-Google-Smtp-Source: ABdhPJwh4rmlDzrOw1v2SpR3LQ7g2YDOFobuL3xpaUvLChd9WlR1HaFFk0rRQsoHkYBQQY3NAGj4BQ==
X-Received: by 2002:a92:c546:: with SMTP id a6mr3809792ilj.39.1623434142862;
        Fri, 11 Jun 2021 10:55:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m7sm3988523ilu.75.2021.06.11.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:55:42 -0700 (PDT)
Received: (nullmailer pid 1208943 invoked by uid 1000);
        Fri, 11 Jun 2021 17:55:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org
In-Reply-To: <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com> <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Date:   Fri, 11 Jun 2021 11:55:33 -0600
Message-Id: <1623434133.974776.1208942.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 11 Jun 2021 12:36:38 +0100, Biju Das wrote:
> Document RZ/G2L DMAC bindings.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../bindings/dma/renesas,rz-dmac.yaml         | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
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

See https://patchwork.ozlabs.org/patch/1490917

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

