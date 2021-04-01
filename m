Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEE351859
	for <lists+dmaengine@lfdr.de>; Thu,  1 Apr 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhDARpo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Apr 2021 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhDARiD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Apr 2021 13:38:03 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE3C02D569;
        Thu,  1 Apr 2021 08:53:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so2020039otr.9;
        Thu, 01 Apr 2021 08:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkQJQ0O5X0ESy+J810FdCD0SpVEINsP0ZlnS7rJtykA=;
        b=t7Dfd7aJiKBH3JXEyyEPFaogHg3o0Z0Arf+OEq24zx6z9Hb0+Fm0M403EmPBOXpd6D
         /LWgM6PFhazklnzoCjeGaw+8qWFrfNc5c5ZW+80q2ZaLaQOfu6+uTSYHcEel7mfzjCD4
         6xpywc8Degy7g+h5htBTBFhj98zy0cWqhXvGRiOhiPdUv3Pjz/1R/KBUn0NyC8giL2KT
         x20UI0tx2XNS4qiMPM2FUBf2sa4/kdWagpfwO9sFvBe71Ntbhpcf/Xf7AwgN04eODwV5
         5HZtEdny/D6EiKYLJjWwr4Pg4dSe3h/eiNJOp/PKTIbziIkdSRGPl6E7dOCsTOL076Og
         dg9A==
X-Gm-Message-State: AOAM530hq7XzTAxMZx5PS2a1GT+5o8sUigH/VT1f2n6FgkXYEsQmtdxr
        oxljLbGw0/u/YwAskEmFIw==
X-Google-Smtp-Source: ABdhPJxTYMWgRjWTTEUoN54xBzLN6y375nT/Dx7htqlExcUIh3M3GXE6xcxxoCnomOvmTM8L0T/+ZQ==
X-Received: by 2002:a9d:7e8d:: with SMTP id m13mr7362910otp.54.1617292383853;
        Thu, 01 Apr 2021 08:53:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d2sm1271592otl.48.2021.04.01.08.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:53:02 -0700 (PDT)
Received: (nullmailer pid 498399 invoked by uid 1000);
        Thu, 01 Apr 2021 15:52:59 -0000
Date:   Thu, 1 Apr 2021 10:52:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 12/16] dt-bindings: media: Add DT bindings for TI CSI2RX
 driver
Message-ID: <20210401155259.GB488101@robh.at.kernel.org>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-13-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-13-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 30, 2021 at 11:03:44PM +0530, Pratyush Yadav wrote:
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> parts together.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../devicetree/bindings/media/ti,csi2rx.yaml  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/ti,csi2rx.yaml b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> new file mode 100644
> index 000000000000..ebd894364391
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/ti,csi2rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI CSI2RX Wrapper Device Tree Bindings
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,csi2rx

Also, needs an SoC specific compatible.

Rob
