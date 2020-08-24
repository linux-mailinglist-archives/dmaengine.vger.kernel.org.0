Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2F2506B1
	for <lists+dmaengine@lfdr.de>; Mon, 24 Aug 2020 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgHXRkR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Aug 2020 13:40:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42202 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHXRkP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Aug 2020 13:40:15 -0400
Received: by mail-io1-f66.google.com with SMTP id g13so9550772ioo.9;
        Mon, 24 Aug 2020 10:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVtrljt/EWWhhPr0mdtIWZRHw/y3jFOkqpDqOIKXMy8=;
        b=rootcDx+L8DT1N+2GVRb6rnnhi4pdvbLDRDMPLE7b64UAMIljpre62+DMmnryf0nnc
         JRiI4NBGH6KG6Sn9BBBL7ei2x6PyrTkcwL6e4k0EtSQvNWx0RzYFc1JBS3OoXS9Og0Wo
         EjRGYZYg849Sli3qeGd+gqGnH7SalnemNVcVjqmLNYnYcs3XU7gEoL1QYdRHkjDoye7z
         LPPEJjjVy8IrlralaUufDy+8VctXQDAOHo/WEaHqoT9u2uIOGSI5fJELjSyVc+CSNC7C
         cQdi9K2ghD6gjGl6+puj3nZyvcDSFsiqWIdiRKKotA4zctQWpcvdEMZatOK83Y6dYn97
         vGDA==
X-Gm-Message-State: AOAM532Ql5EeQeEl2RK6ONQHey/u5QW6FoGAK6Xq9FXqG2Mc6lcpr4ji
        7YwAd6ArXl8uglVWN7ARLQ==
X-Google-Smtp-Source: ABdhPJyjYzUkBxJsb/wKRoH4c89oJ3tsNy0bXy++WXqLOyjfTb7kelHoON54dkX40b2Pf0HM6/psTg==
X-Received: by 2002:a5d:995a:: with SMTP id v26mr5699626ios.176.1598290814026;
        Mon, 24 Aug 2020 10:40:14 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h13sm6714876iob.33.2020.08.24.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:40:13 -0700 (PDT)
Received: (nullmailer pid 2950296 invoked by uid 1000);
        Mon, 24 Aug 2020 17:40:09 -0000
Date:   Mon, 24 Aug 2020 11:40:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
Message-ID: <20200824174009.GA2948650@bogus>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824084712.2526079-2-vkoul@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 24 Aug 2020 14:17:10 +0530, Vinod Koul wrote:
> Add devicetree binding documentation for GPI DMA controller
> implemented on Qualcomm SoCs
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: {'description': 'Event ring transfer size compare to channel transfer ring. Event ring length = ev-factor * transfer ring size', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: 'not' is a required property

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,gpii-mask: {'description': 'Bitmap of supported GPII instances for OS', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,gpii-mask: 'not' is a required property

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,max-num-gpii: {'description': 'Maximum number of GPII instances available', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,max-num-gpii: 'not' is a required property

./Documentation/devicetree/bindings/dma/qcom-gpi.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/dma/qcom-gpi.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: ignoring, error in schema: properties: qcom,max-num-gpii
warning: no schema found in file: ./Documentation/devicetree/bindings/dma/qcom-gpi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.example.dt.yaml: example-0: dma@800000:reg:0: [0, 8388608, 0, 393216] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1350170

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

