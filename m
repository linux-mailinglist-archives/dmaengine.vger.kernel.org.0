Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B52429A86
	for <lists+dmaengine@lfdr.de>; Tue, 12 Oct 2021 02:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJLAur (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 20:50:47 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33525 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJLAuq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 20:50:46 -0400
Received: by mail-oi1-f178.google.com with SMTP id q129so6153493oib.0;
        Mon, 11 Oct 2021 17:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvdphmR8B6xS6fwc2adIk0LTkqcXDfOqTUC8n6SjM6I=;
        b=kNHre8Xt5BLT+GHHfPcho4Y3tYxx97CssIieCr9BFt9KLFN+W8cAbkWJW7aTdbPP/n
         SHPK1f1LbQpf2BpBGood0F1U5f/j5qixNhAVxyp/E2L72hLAUJRII94Img7JOYUcRFcJ
         hg86Jh7Dk52ssyTwp2np/x5vPMFps0egoGQZExXlrlka9BOVeJbm9D7j7JamOnYNzJwi
         TvdkZlqjQ8e4T6aIbnykXoxq1D0gpgOITXWOFIL5m0LjwmEiO/DCT5WZzcqYqhKmnbrD
         P/Ql8qOGXjEJf9ZBUKaRLGRFKNq/uhztcaBxp5rKIKR2OkCRUa0t+xfwG6So475AFlAD
         5+tQ==
X-Gm-Message-State: AOAM533dDtyVG1UYjUHzip0Lbd/X6VkEp+scUAfC09TdcCiGlnPMg+B7
        3vvQr5lN0PakqSEkkvRzgA==
X-Google-Smtp-Source: ABdhPJwdHZ9cbLOq8arrw6k3jrMl4h0w+04haOg/y8RLpLQvMzvh0RgQfnSk4n49DxDvXpcbemzbiw==
X-Received: by 2002:aca:bd0b:: with SMTP id n11mr1628631oif.100.1633999725621;
        Mon, 11 Oct 2021 17:48:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 16sm1167126oty.20.2021.10.11.17.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 17:48:45 -0700 (PDT)
Received: (nullmailer pid 1481967 invoked by uid 1000);
        Tue, 12 Oct 2021 00:48:44 -0000
Date:   Mon, 11 Oct 2021 19:48:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: dma: ingenic: Add compatible strings
 for MDMA and BDMA
Message-ID: <YWTbbOWhtrTniXWV@robh.at.kernel.org>
References: <20211011143652.51976-1-paul@crapouillou.net>
 <20211011143652.51976-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011143652.51976-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 11 Oct 2021 16:36:48 +0200, Paul Cercueil wrote:
> The JZ4760 and JZ4760B SoCs have two additional DMA controllers: the
> MDMA, which only supports memcpy operations, and the BDMA which is
> mostly used for transfer between memories and the BCH controller.
> The JZ4770 also features the same BDMA as in the JZ4760B, but does not
> seem to have a MDMA.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/dma/ingenic,dma.yaml  | 26 ++++++++++++-------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 

With the indentation fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
