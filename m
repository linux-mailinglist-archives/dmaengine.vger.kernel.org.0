Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7F2B50E8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgKPTTZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 14:19:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35184 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPTTY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Nov 2020 14:19:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id c80so19990375oib.2;
        Mon, 16 Nov 2020 11:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hk0zicNyvdGlejHlcvT1pkraHtVqp71eil3CE0c3jBs=;
        b=dayPsDEuPVI/yN161qBjN8OZOAC4Fn7xGHzcz7kwzoh4SML0clgBdTy7+rs1BiMEUb
         YvnJDgLNjSQrBg/EFWE3qddWao8BaBghgyqtj6JeP6jE1rcYg1BYT0HGu4PSPazL3oMV
         tBFQ2IFEo2yG2x7fErvvzhJRhwL9/i49cg2Fqzd9X7IwDFPFXVn6pts1/3VmjQsb5m5s
         Y8yL2ySzYeMMG8/keGOyrM4F058gY4PAGq9zKVI9a3MDbk2i7TFiBrzAm1ZewvARLSxO
         5CRoyBOsnEgAeY6EVumGfbDAUpfXfqfeTv1E3VaJZIZ5Vc4ycKzhSkllepOIv5yMQRWc
         dO1g==
X-Gm-Message-State: AOAM530uUBih/OBrLu/6GhgxXbWl+zhDsYwr/RTVNxg6LSAc+5Q7tUi1
        IpF4ef4LK7DxYPsjSxE5Sg==
X-Google-Smtp-Source: ABdhPJz/+A/D5xNcXl2Y3DjW8C6hn8SSU4lIu+WqboemSEynjf7hT/q2B5BgicViUMLJpx8Hyyng/g==
X-Received: by 2002:aca:c502:: with SMTP id v2mr112809oif.93.1605554363527;
        Mon, 16 Nov 2020 11:19:23 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 14sm4970527otf.10.2020.11.16.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:19:22 -0800 (PST)
Received: (nullmailer pid 1985278 invoked by uid 1000);
        Mon, 16 Nov 2020 19:19:22 -0000
Date:   Mon, 16 Nov 2020 13:19:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     cheol.yong.kim@intel.com, dmaengine@vger.kernel.org,
        chuanhua.lei@linux.intel.com, peter.ujfalusi@ti.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        malliamireddy009@gmail.com, vkoul@kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: dma: Add bindings for Intel LGM SoC
Message-ID: <20201116191922.GA1985224@bogus>
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <bfe586ac62080d14759bda22ebf1de1a1fa9c09d.1605158930.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe586ac62080d14759bda22ebf1de1a1fa9c09d.1605158930.git.mallikarjunax.reddy@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 12 Nov 2020 13:38:45 +0800, Amireddy Mallikarjuna reddy wrote:
> Add DT bindings YAML schema for DMA controller driver
> of Lightning Mountain (LGM) SoC.
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
> 
> v7-resend:
> - rebase to 5.10-rc1
> 
> v8:
> - rebased to 5.10-rc3
> - Fixing the bot issues (wrong indentation)
> 
> v9:
> - rebased to 5.10-rc3
> - Use 'enum' instead of oneOf+const
> - Drop '#dma-cells' in required:, already covered in dma-common.yaml
> - Drop nodename Already covered by dma-controller.yaml
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml        | 130 +++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
