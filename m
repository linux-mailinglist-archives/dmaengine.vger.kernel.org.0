Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC142AC787
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 22:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKIVpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 16:45:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39306 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVpX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 16:45:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id z16so10481268otq.6;
        Mon, 09 Nov 2020 13:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0gQKHQcCiV/+zGgZ7epDgosaT+EeNs17sox2/Cv8ak=;
        b=p/kcJ4P5n5p7e6twsDjEIEfVi0jhedZaWXt/Z9asmZVB3yUINJVsbwEan2OeBbwYDm
         MGBL9/i/x6zDs25n8u4m9Y8wEPdTFVnPgMw/HXsGUIuR5szSQlvRwuDiWT/53IDBhUO9
         QR42r3LM0Pc80GPyr3MALJrGMijV8M9H48fpbLEDh+fPcI1IJLSyLbBWUhoMvgtCCNVy
         2o+jH07rLR4np52SVXeG+4L2CdWifPOSzi8jSYuOJz1gY3RUtCivw6U+d93zVJJyoR2X
         NXmYWvd1QXF9iD5/V/nfuhwXtjI/qwR6AWkOP7K+apDTUKQ16Eff9b7Pbl0afzuMr0Jk
         MAsw==
X-Gm-Message-State: AOAM532OaHrX7buk7jgF9n1/XCvG5aq0ZFmI4i3kWmcnDx6TVcg8u3fK
        wg0i2R7C/NQG8sN9xrDSSw==
X-Google-Smtp-Source: ABdhPJzmCnp3Q8x1dS/tba1jP8C5WYhdSV1jUhJI/ijcdmkSlNXFi0jvNso00Bn08q1/9tuNYlSUtg==
X-Received: by 2002:a05:6830:118:: with SMTP id i24mr12184654otp.285.1604958322575;
        Mon, 09 Nov 2020 13:45:22 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm2653313oia.16.2020.11.09.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:45:21 -0800 (PST)
Received: (nullmailer pid 1810779 invoked by uid 1000);
        Mon, 09 Nov 2020 21:45:21 -0000
Date:   Mon, 9 Nov 2020 15:45:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dmaengine@vger.kernel.org, robh+dt@kernel.org, maz@kernel.org,
        tglx@linutronix.de, devicetree@vger.kernel.org,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: dma: Convert ADMA doc to json-schema
Message-ID: <20201109214521.GA1810728@bogus>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
 <1604677413-20411-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604677413-20411-3-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 06 Nov 2020 21:13:31 +0530, Sameer Pujar wrote:
> Move ADMA documentation to YAML format.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra210-adma.txt          | 56 ------------
>  .../bindings/dma/nvidia,tegra210-adma.yaml         | 99 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
