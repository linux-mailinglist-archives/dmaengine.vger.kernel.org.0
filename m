Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6578A2B07DE
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKLOyx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 09:54:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45700 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOyw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Nov 2020 09:54:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so6620147oie.12;
        Thu, 12 Nov 2020 06:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PifCDWqhNMNufANMuIhdJC/Zqdbe8ffbOkNB2UHoQ4U=;
        b=LddzSjD7PUqUeeJKT7V2fV73f1YyLCni2o6/ms19BCYJgT7Yb5T/glRN1jtOKw/3Yj
         TaNH/zvt0Eg9jSfn2Yk5FqucOqH5+x2cu2SNzO0J8ndM5Gi4vYYd1z9WMfBHlOQwvxMa
         hh9nHDaFKWPCrdh3RvVoshleZpVkY//4OpxzakluQPyQxsth5FGinWeK/rIBF8QPaeZU
         gTIffWwm7IEbz3X0BjQXtknI6FM40mAyEXM2bPV1gBDqqir2MW5sOzk8cwSarKk7iuYL
         VPT7KZtgi7YpYvLCLadWs3ZqrFvKUp2/X0QE/lf3JhgAOFsuzBkcgjGJPZ/UvA1gzWHq
         0rFQ==
X-Gm-Message-State: AOAM530DcB+hS9FATtw4khoHcaqSyNvKtP73j4u1omI6BXOZ8Lu0EA/X
        y1q3s/3k4yrYWszdmeWR7Q==
X-Google-Smtp-Source: ABdhPJyQHxSGB0EXd/LcUQ6+dNsg36cN26JPUbAbsQVvHRAvvoB0nutCFKFlM+ng4I4xYvEFmJOEFA==
X-Received: by 2002:aca:f0c5:: with SMTP id o188mr5384348oih.95.1605192891798;
        Thu, 12 Nov 2020 06:54:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t65sm1143640oib.50.2020.11.12.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:54:50 -0800 (PST)
Received: (nullmailer pid 3584258 invoked by uid 1000);
        Thu, 12 Nov 2020 14:54:49 -0000
Date:   Thu, 12 Nov 2020 08:54:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        Eugeniy.Paltsev@synopsys.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 10/15] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Message-ID: <20201112145449.GA3583607@bogus>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
 <20201112084953.21629-11-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112084953.21629-11-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 12 Nov 2020 16:49:48 +0800, Sia Jee Heng wrote:
> Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
> Schemas DT binding.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.example.dt.yaml: example-1: dma@28000000:reg:0: [671088640, 4096, 539295744, 36] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1398782

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

