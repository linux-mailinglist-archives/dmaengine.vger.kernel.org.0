Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E440F35018D
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhCaNlc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Mar 2021 09:41:32 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40479 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhCaNlC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Mar 2021 09:41:02 -0400
Received: by mail-ot1-f49.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so18926314otb.7;
        Wed, 31 Mar 2021 06:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jsgIdaqlH2C9MJUIwIFmOwXHosTK36DMQwbtDc67PdU=;
        b=GlaMOk/EftBiN9LQOojhfQNTipiW4HdZpPp93eVlGY5wxRi5SVqVjg3BE7zWj5O36Y
         CVRBXQHSvGv5hJdyZffayr2hnFGq8WDqji1s3SO6MePwtk8SRfakOwA1RaXr9eF80wUO
         G+7FiK0gUW2ORuodrDKVwWtvTGs3TN1JBYDrd5jpYHFzozp7kpI66cc707eCmlEFH9It
         TV1Pfu6FQRXfElF8oinDf7G2UGL6hylx7O43hwefm31jfRz/jgKxE44pQQOMGFcM80M7
         CAz/b2r56S4XkqZtcAyExPzgfCpIqVrbOwg4LzQ25bvneT8ErQa7wqpQPylzZ+Eafrf3
         QzZA==
X-Gm-Message-State: AOAM530GfY6o8ZlaFbIiiO0rjeYuyxdmJ6JWIFMu9JSWnPxw8No9PIV7
        uhRa5XhM6iDzy5GusT1vkw==
X-Google-Smtp-Source: ABdhPJy9cZd8SNUZfNXUreF3fwUvIluuSS4fiqRj0Ql+EUHendHCquhblhKUmO6JrZ58igOXICq5Tg==
X-Received: by 2002:a9d:4b8d:: with SMTP id k13mr2677027otf.354.1617198061936;
        Wed, 31 Mar 2021 06:41:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o6sm474874otj.81.2021.03.31.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 06:41:01 -0700 (PDT)
Received: (nullmailer pid 2074854 invoked by uid 1000);
        Wed, 31 Mar 2021 13:40:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-phy@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dmaengine@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Helen Koike <helen.koike@collabora.com>,
        Peter Chen <peter.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
In-Reply-To: <20210330173348.30135-13-p.yadav@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com> <20210330173348.30135-13-p.yadav@ti.com>
Subject: Re: [PATCH 12/16] dt-bindings: media: Add DT bindings for TI CSI2RX driver
Date:   Wed, 31 Mar 2021 08:40:59 -0500
Message-Id: <1617198059.574658.2074853.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 30 Mar 2021 23:03:44 +0530, Pratyush Yadav wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/ti,csi2rx.example.dts:21.30-29.11: Warning (unit_address_vs_reg): /example-0/ticsi2rx: node has a reg or ranges property, but no unit name

See https://patchwork.ozlabs.org/patch/1460166

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

