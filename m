Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4D29D3E9
	for <lists+dmaengine@lfdr.de>; Wed, 28 Oct 2020 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJ1VrK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 17:47:10 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32967 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgJ1VrG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Oct 2020 17:47:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id x26so155321uau.0;
        Wed, 28 Oct 2020 14:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3s41M7Z72fcMkRDw2yDndUowlojinGmdtRTwp5CyZB8=;
        b=o/ALox162e6y48vAeVYnNHRbbAJcz3CbM499XO2eFK3mWp7Oga60iEv6bduhOoOwh8
         JaIbFMqGPBOSzd5so5TbNLSkClydL/6N9+23wU74f8AblxTnSu4MX6rERPyt5Um75y9G
         dV5j5UZTR1hZDmxeZTs3iAN7yTYwR/2M9LB/oJ4TJ3EUkxycOj/LNAcXvbuTw1PTRku8
         Y2ZvhcN3cWbyTFDJjgEun+ayeFu4X/t3RLAefmA9qYd9vSNJ+Krd0NAioALsu0Obsfvc
         mys30E42DD8mIICxi4VSNIUotnE/wq/UuxOHu5s1pIUe26bJPcdfaqpmd7BckVftcKiI
         sBpA==
X-Gm-Message-State: AOAM533s3ehqTgekIPGlJfXvugj6Sr7FjYUY2N/UX6rKSlCU0Y88Hujf
        XFuVuAJ65Z8CmTZyCt5pOksk2hGzJQ==
X-Google-Smtp-Source: ABdhPJz4x4atsHhf7/cg2rc9KcKS2aCuYGJ1v/d9sMbHOXkRqMIjahEQXle3dQvvZLWlBjDyR0m67A==
X-Received: by 2002:a4a:b503:: with SMTP id r3mr5955627ooo.28.1603896221095;
        Wed, 28 Oct 2020 07:43:41 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b125sm2683484oii.19.2020.10.28.07.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:43:40 -0700 (PDT)
Received: (nullmailer pid 3993648 invoked by uid 1000);
        Wed, 28 Oct 2020 14:43:39 -0000
Date:   Wed, 28 Oct 2020 09:43:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, malliamireddy009@gmail.com,
        vkoul@kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com
Subject: Re: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20201028144339.GA3992990@bogus>
References: <cover.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 27 Oct 2020 16:03:06 +0800, Amireddy Mallikarjuna reddy wrote:
> Add DT bindings YAML schema for DMA controller driver
> of Lightning Mountain(LGM) SoC.
> 
> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> ---
> v1:
> - Initial version.
> 
> v2:
> - Fix bot errors.
> 
> v3:
> - No change.
> 
> v4:
> - Address Thomas langer comments
>   - use node name pattern as dma-controller as in common binding.
>   - Remove "_" (underscore) in instance name.
>   - Remove "port-" and "chan-" in attribute name for both 'dma-ports' & 'dma-channels' child nodes.
> 
> v5:
> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child nodes to dma client/consumer side as cells in 'dmas' properties.
> 
> v6:
> - Add additionalProperties: false
> - completely removed 'dma-ports' and 'dma-channels' child nodes.
> - Moved channel dt properties to client side dmas.
> - Use standard dma-channels and dma-channel-mask properties.
> - Documented reset-names
> - Add description for dma-cells
> 
> v7:
> - modified compatible to oneof
> - Reduced number of dma-cells to 3
> - Fine tune the description of some properties.
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml        | 135 +++++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:17:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:21:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:22:4: [warning] wrong indentation: expected 4 but found 3 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:32:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:35:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:37:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:42:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:46:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:50:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:53:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:56:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:60:3: [warning] wrong indentation: expected 3 but found 2 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:76:5: [warning] wrong indentation: expected 3 but found 4 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:81:5: [warning] wrong indentation: expected 3 but found 4 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:83:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:87:5: [warning] wrong indentation: expected 3 but found 4 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:89:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:93:5: [warning] wrong indentation: expected 3 but found 4 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:95:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:100:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/dma/intel,ldma.yaml:107:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1388332

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

