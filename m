Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3959B1BB08C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgD0Vcq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 17:32:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35906 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0Vcq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Apr 2020 17:32:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id b13so29003767oti.3;
        Mon, 27 Apr 2020 14:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VhX0m7XiVUavIDrF8Px+dNHE5Y+gy8GzoSAbvu2Xn34=;
        b=uNQRjdFd5CyAzZGAl3hjsUslykT0GpQz5v8uR+cecisXcRVHs+dMVQrSI4XJk21+xP
         fsPUv1xV8m6ZZYki5Zsyx9VQqbgU4QQGWqzHdpUdspdAND5WDuGQIY8XvF/NVLwjLlDL
         FBPV1c6++voSc0jq0YuYeYjjSfcZjts1KRAe/Gfg6agfjaWtNaEIVGtj248xzPnR/FVn
         CZ5qH0h9yE/TJXLMVaZ+c0hUHyKK/n+y3mWRd2cK9b4A5VgOmWeumdIP9hejba9hAweC
         CfPIFaCt8ZN7N63bpRvmH6+vI4SYxjDTYBhhP8OHKS6XRh79DKE7ziC2SOeOksybgiuF
         rEhg==
X-Gm-Message-State: AGi0PubOzzG0KYjiBbpJnd7uui/yQ4LThhCVV85xkOePLJyvVvE5IY+u
        y21Labco4DW0kwl1xvcRcQ==
X-Google-Smtp-Source: APiQypKaNxXTFDM9s/8lHp/0DfHRTlPNydLnDnh9/hUQgcEGUw3vp0iDQdHVuaMxyOuo5fm7o/BuuA==
X-Received: by 2002:aca:4f09:: with SMTP id d9mr631326oib.172.1588023164944;
        Mon, 27 Apr 2020 14:32:44 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j70sm90813oib.53.2020.04.27.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:32:44 -0700 (PDT)
Received: (nullmailer pid 32460 invoked by uid 1000);
        Mon, 27 Apr 2020 21:32:42 -0000
Date:   Mon, 27 Apr 2020 16:32:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     EastL <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, vkoul@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, EastL <EastL.Lee@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20200427213242.GA32009@bogus>
References: <1587955977-17207-1-git-send-email-EastL.Lee@mediatek.com>
 <1587955977-17207-2-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587955977-17207-2-git-send-email-EastL.Lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 27 Apr 2020 10:52:56 +0800, EastL wrote:
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6779 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: EastL <EastL.Lee@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.yaml         | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/mtk-cqdma.example.dt.yaml: dma-controller@10212000: interrupts: [[0, 139, 8], [0, 140, 8], [0, 141, 8]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/mtk-cqdma.example.dt.yaml: dma-controller@10212000: reg: [[0, 270606336, 0, 128], [0, 270606464, 0, 128], [0, 270606592, 0, 128]] is too short

See https://patchwork.ozlabs.org/patch/1277292

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
