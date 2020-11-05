Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857BA2A866C
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgKESuV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 13:50:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35309 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgKESuV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 13:50:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id n11so2409442ota.2;
        Thu, 05 Nov 2020 10:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79BiO/+iVQS5f4JE7+Ah5lxHJdkoQWGAWwcqZ3jscHY=;
        b=TxyGoGBFhVomn80aU+ndXWvvcuVsNq5+RZULh7qRi6I7iYENrlnkYAWTysIhBwqDh4
         0txfCqqG5uFEuinMKCjNpHRQ7KOVAM45FjeKyYEdlAlfI3BnbKn+UrOs0vGzf2zv6Fko
         uAKrSYcUTuSs7uhqpwxugChGxpvRbz1Mahk4Q7mSqQuTk4uBtjySKP42THR6Bjw3E6iR
         Rt+fVJbDh5k1/dhFjdUsZsPa4z4x5PFmxUObY0Xagm1uuiQISvNfgL7u3tgasTxR7AIj
         37Ky6sAVGhwqdYxkb6svDx2pCQCDGvSlL02HcsX3aeCfWiIFcQYDkN6WNYQp0C6yns5a
         y0Aw==
X-Gm-Message-State: AOAM531IEiZiEzvYavUpymFoDfvVDGKnR5fu/4uAPLVp0bAy/EuI/gUg
        OvCQwj7MaepAxf+H0CzDKQ==
X-Google-Smtp-Source: ABdhPJz/r3pC7uBbHrTvEghjoX8aLJu/enMy0f17YIwn0JhZKzcM8bcgybDTg2FSAW72nR++OLr4zg==
X-Received: by 2002:a9d:ae7:: with SMTP id 94mr2509229otq.159.1604602220001;
        Thu, 05 Nov 2020 10:50:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d64sm553166oia.11.2020.11.05.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:50:19 -0800 (PST)
Received: (nullmailer pid 1623074 invoked by uid 1000);
        Thu, 05 Nov 2020 18:50:18 -0000
Date:   Thu, 5 Nov 2020 12:50:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     vkoul@kernel.org, jonathanh@nvidia.com, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, jason@lakedaemon.net,
        linux-tegra@vger.kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, maz@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: dma: Convert ADMA doc to json-schema
Message-ID: <20201105185018.GA1622537@bogus>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
 <1604571846-14037-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604571846-14037-3-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 05 Nov 2020 15:54:04 +0530, Sameer Pujar wrote:
> Move ADMA documentation to YAML format.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra210-adma.txt          | 56 -------------
>  .../bindings/dma/nvidia,tegra210-adma.yaml         | 95 ++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml


See https://patchwork.ozlabs.org/patch/1394859

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

