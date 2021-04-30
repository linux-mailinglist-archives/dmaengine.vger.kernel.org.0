Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED69370344
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 23:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhD3Vzs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Apr 2021 17:55:48 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40887 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhD3Vzr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Apr 2021 17:55:47 -0400
Received: by mail-ot1-f46.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso32745237otp.7;
        Fri, 30 Apr 2021 14:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25yjAOkFDhIBZeh0NhmJ8pwzCv2l1d1KN88QltHVSow=;
        b=eylC6to84gPC+tRmRaF1S9qBmaVwQQ8x0826E7vzr2xlcvWZtBMlkEirJOQYVZht27
         m+/2KYzWTOJ5N2B0X+tK/JIqsP/v22htoSOmpIINNPKvmaOgvsaJ0xldJl9tir+fHTbH
         SKGzErGOPYGjSUUsnaJ81apy3tqOPeELwk0ExY4pgyj0KNTJ8wAFI2zP3vC4kvkvTxPT
         YsskRb46028ul7vqobqvGrhh7JKMh/aJdMfONcCF78niKNNPRkHoi/v5IPXfk53grCSU
         dXJ6hmI729/+3ypKo5LQ0ZJen49tDIjh7gTyAIJYsJnG7tmIUR1h3qbw0cI1OuQax9ez
         LfwQ==
X-Gm-Message-State: AOAM5336NhenBK/ib9xWY2VU4CG6dmPeYhvoCgZ76UYLeoHkiHBVr2L1
        CBgI+CwVloBnu+6XHB0K6w==
X-Google-Smtp-Source: ABdhPJxcWSUVX+MsJAKYmzw1w6cT8NnW1E5qK7dqr++IXplJF5dwUlBQ7pk1LQcqpPI1Cp1jEQYfDQ==
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr5290244otr.169.1619819698703;
        Fri, 30 Apr 2021 14:54:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q10sm998327ooo.34.2021.04.30.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:54:58 -0700 (PDT)
Received: (nullmailer pid 3970166 invoked by uid 1000);
        Fri, 30 Apr 2021 21:54:57 -0000
Date:   Fri, 30 Apr 2021 16:54:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     vkoul@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: dma: convert arm-pl08x to yaml
Message-ID: <20210430215457.GA3970064@robh.at.kernel.org>
References: <20210430183651.919317-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430183651.919317-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 30 Apr 2021 18:36:51 +0000, Corentin Labbe wrote:
> Converts dma/arm-pl08x.txt to yaml.
> In the process, I add an example for the faraday variant.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixes yamllint warning about indent
> - added select
> 
> Changes since v2:
> - fixed all Rob's comment on v2
> 
>  .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
>  .../devicetree/bindings/dma/arm-pl08x.yaml    | 136 ++++++++++++++++++
>  2 files changed, 136 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
