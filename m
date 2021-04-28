Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1E36E16B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 00:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhD1WQJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Apr 2021 18:16:09 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45001 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhD1WQD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Apr 2021 18:16:03 -0400
Received: by mail-ot1-f42.google.com with SMTP id z25-20020a9d65d90000b02902a560806ca7so1069909oth.11;
        Wed, 28 Apr 2021 15:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Xi7TAHlcVoeB5Rz0Y7svi8AIt7JTNDAlk3MLO/FLse4=;
        b=KoX3e68IqP8pwLy5woJIYoKM+46AIsIFU36ss6TBIzexWxAGHWwyLF0d2FjzFQx08W
         +7keT4Y2vvY/rdQGx2H+0PbuUcIGs1LYoHka66Gn2BWBfZtE8Z+Pxmn67cvQjftgIOBH
         E4XRkjd4CEoz2K203BH8WFd8tQUgLBZi8KEsLQZUGLxjjMqTFJ8gnl7UZwObxs0UGktI
         V60nrC7IAWxdH6uayv+EZQLeCkMR0bFR4myqCRhIBiEXzj8gUBOL3fHQDn7Vwf4sDzGB
         4o4YY7tCoIq61/I0Bl0a6Qc9p1jtxFGFMEmYfKIhZnHqAbjkNLf2zI33KXCpqovsTE9F
         TllQ==
X-Gm-Message-State: AOAM530Kbi16K3snco9lAKDkJPZM+RfGqvwbABfkIbO96Ff0rWTf/IKB
        wniHxahrQXh5F6h465NO8AV7wFCQ6Q==
X-Google-Smtp-Source: ABdhPJxN8d1OtBBDvnGQdL0lWNDlwQyUcPicQ1sLOA+xdTC1f2+voBJBuP8wAq1LRIufjwKh64CQ9w==
X-Received: by 2002:a05:6830:1416:: with SMTP id v22mr8692970otp.120.1619648117518;
        Wed, 28 Apr 2021 15:15:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i13sm257851otp.41.2021.04.28.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:15:16 -0700 (PDT)
Received: (nullmailer pid 4061031 invoked by uid 1000);
        Wed, 28 Apr 2021 22:15:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Stefan Roese <sr@denx.de>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <YIlYnDBVn0fggMe3@orolia.com>
References: <YIlYnDBVn0fggMe3@orolia.com>
Subject: Re: [PATCH 1/2] dt-bindings: dma: add schema for altr,msgdma
Date:   Wed, 28 Apr 2021 17:15:09 -0500
Message-Id: <1619648109.778776.4061030.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 28 Apr 2021 14:44:12 +0200, Olivier Dautricourt wrote:
> - add schema for Altera mSGDMA bindings in devicetree.
> - add myself as 'Odd fixes' maintainer for this driver
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
>  .../devicetree/bindings/dma/altr,msgdma.yaml  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/altr,msgdma.example.dts:21.54-27.11: Warning (unit_address_format): /example-0/dma-controller@0xff200b00: unit name should not have leading "0x"
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/altr,msgdma.example.dt.yaml: example-0: 'dma-controller@0xff200b00' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/dt-core.yaml

See https://patchwork.ozlabs.org/patch/1471123

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

