Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A245A7F0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Nov 2021 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhKWQhn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Nov 2021 11:37:43 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:46626 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbhKWQhm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Nov 2021 11:37:42 -0500
Received: by mail-io1-f53.google.com with SMTP id x6so6945823iol.13;
        Tue, 23 Nov 2021 08:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xHCYnhDhZCTxewpY+KOZ7LWuKPncTJz1crmpYlrkqfo=;
        b=PAqxeekM2RcvZS+nZUr787NKDxK6yV4I54L5EdE8BljedVUnj55TkUnfvJ8stWvns9
         qoMBYAnaMmCdZ1wAJNYXiEggRiA0i+nOnCThNPaYGKTuu1l9tSyyA93/1CXILsHS+det
         RhyODwipXCMa38CgbZ/dTbmq5tZHpJRKhUQJH9Api/I76v558N1sZdTssTvEYix02akJ
         t9CJna22pX6Dkm8KSJ9BHaXOoIc6P7Wqxt/24Dl3a895/qB1slrA8ZCiAomrkE2Dmjog
         HgZ1tuX2iVJgn0PqQzC8jM2V8gUg9d7FulimqoYh8XXaYREQmbuCcb4axORycA/13qH1
         VefQ==
X-Gm-Message-State: AOAM533aufxMr+kW4txcBVw82kpV9TBG3S86swKPLqX0zqjD9YWQGURt
        a7bm0sqG136Pu3ysh78nn/C0J1DzOw==
X-Google-Smtp-Source: ABdhPJxwurIBVfozv0WaI04vNkMxK4z+wmlyG1U73zTi5k9/UxcwuBZEH75s2hOm1c8qOB6d3OBS6w==
X-Received: by 2002:a05:6638:2585:: with SMTP id s5mr8115068jat.68.1637685272706;
        Tue, 23 Nov 2021 08:34:32 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o22sm8929199iow.52.2021.11.23.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:34:32 -0800 (PST)
Received: (nullmailer pid 3442903 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, vkoul@kernel.org,
        rgumasta@nvidia.com, dan.j.williams@intel.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, kyarlagadda@nvidia.com
In-Reply-To: <1637573292-13214-2-git-send-email-akhilrajeev@nvidia.com>
References: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com> <1637573292-13214-2-git-send-email-akhilrajeev@nvidia.com>
Subject: Re: [PATCH v13 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.617639.3442902.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 22 Nov 2021 14:58:09 +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 111 +++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml:26:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1557933

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

