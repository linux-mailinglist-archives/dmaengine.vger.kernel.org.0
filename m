Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C813930CF
	for <lists+dmaengine@lfdr.de>; Thu, 27 May 2021 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhE0OZ2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 May 2021 10:25:28 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38880 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbhE0OZ2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 May 2021 10:25:28 -0400
Received: by mail-oi1-f177.google.com with SMTP id z3so915146oib.5;
        Thu, 27 May 2021 07:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1vMehXJ6oAYHbp4RF5sTG65I60stU8VCEuNRTkFfowk=;
        b=fY52v/HjkLqRunOC8hgYIt+OA7fnYcwNmNjJjdQ4gPQwoOpoQME9/6qLen9zBFzCoI
         +Z0x2C0DjFrL+rEKLtAITgvbYzfr2F15dsG7nDJm+lxdf5K4YZyeu8QNjuSxJEB+zP8r
         CIVM46F/4UV2YA7a/Gcptg4NHZwokXeYKsLysdbBSiLnDdFz3hEMKPdVuuBCvqaPC+Eg
         Z0bHeNCwI77i910/TohkwNUxuzhgRQjg301+IcfiKBrAj9agCPwddYuuZPMeHzOLMLPM
         5reNp6slYhFKS4JeEPcMZ4dCGXOXo82aBAh4+3wZ2DJkw0RnZ4w1/OolNYsXeaf8viSb
         pR3w==
X-Gm-Message-State: AOAM531+r1caPr0UBFhXVn0TjPvlOqDWsfmZ6IzoN94At/NtbPOKWggO
        wVFRWNwbgzDYst2t94qjedgkdtEeAQ==
X-Google-Smtp-Source: ABdhPJwqCnMFuak9KEKSjV2tWB/d3DGPZ0evW9gOyvH6zbV1jKLsdfVChSwboF7IiV17kI71uxP3Pw==
X-Received: by 2002:a05:6808:3d3:: with SMTP id o19mr1434254oie.136.1622125433926;
        Thu, 27 May 2021 07:23:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm501578otm.1.2021.05.27.07.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:23:50 -0700 (PDT)
Received: (nullmailer pid 731786 invoked by uid 1000);
        Thu, 27 May 2021 14:23:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        dmaengine@vger.kernel.org,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210526152308.16525-15-p.yadav@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com> <20210526152308.16525-15-p.yadav@ti.com>
Subject: Re: [PATCH v2 14/18] media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
Date:   Thu, 27 May 2021 09:23:27 -0500
Message-Id: <1622125407.764961.731785.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 26 May 2021 20:53:04 +0530, Pratyush Yadav wrote:
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> parts together.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - Rename to ti,j721e-csi2rx.yaml
> - Add an entry in MAINTAINERS.
> - Add a description for the binding.
> - Change compatible to ti,j721e-csi2rx to make it SoC specific.
> - Remove description from dmas, reg, power-domains.
> - Remove a limit of 2 from #address-cells and #size-cells.
> - Fix add ^ to csi-bridge subnode regex.
> - Make ranges mandatory.
> - Add unit address in example.
> - Add a reference to cdns,csi2rx in csi-bridge subnode.
> - Expand the example to include the csi-bridge subnode as well.
> - Re-order subject prefixes.
> 
>  .../bindings/media/ti,j721e-csi2rx.yaml       | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/media/cdns,csi2rx.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file 'Documentation/devicetree/bindings/media/ti,j721e-csi2rx.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/media/cdns,csi2rx.yaml'
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/media/ti,j721e-csi2rx.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1484096

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

