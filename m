Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF33DAB1A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhG2SmB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 14:42:01 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:40449 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2SmB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Jul 2021 14:42:01 -0400
Received: by mail-il1-f172.google.com with SMTP id d10so6899173ils.7;
        Thu, 29 Jul 2021 11:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NtViR9x5Y9jf6CYnl+g3ab+BJ+XJIy7vEdyqlPaGRJ4=;
        b=AttvCpgKjh29OISJGOhKSMG0+/RyiamijrsNKmLGcsgJJEtowYupN316kzpmoMWK3D
         ghDByB87uu4TmW9AWjpT3Q9DbbFRGalQzqZANeNtd8lEMQqD1DKitn28Qv9SFxpXbpcL
         tL5YnReeZCTiZbFaE+g3pohcVCpicHf404j0ehi1yc2UCC3ilroiTyYeYMd8OGifyYd/
         iA8E+T8bLpatGNDbsIiOgaceH8BbvLKvz0sBl+v3cjxRotPJeD5EDqe7hbOS2rh3f04o
         STIMmmHuRhK8QPDpMOei1DCSrDswvdNrAVJRBaUkvEcBhGnUb2UubnrnU4HpxjBLmN9y
         sInA==
X-Gm-Message-State: AOAM531eDHluxp59r6G0fNDePBeCSZAbd2ggt/+fGWfzNSkXUIwkgOvR
        PiuKC+A1l0zYUictqRuDeA==
X-Google-Smtp-Source: ABdhPJw+h6P8CSjbZZFVEEteSHNMK/DPfJGo9hPOtNCOG8Tf2WHkDB/1x6jJcx/UFtv879arbob2ow==
X-Received: by 2002:a92:ced0:: with SMTP id z16mr3431286ilq.0.1627584116404;
        Thu, 29 Jul 2021 11:41:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u15sm2734766ion.34.2021.07.29.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:41:55 -0700 (PDT)
Received: (nullmailer pid 662786 invoked by uid 1000);
        Thu, 29 Jul 2021 18:41:54 -0000
Date:   Thu, 29 Jul 2021 12:41:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     list@opendingux.net, Rob Herring <robh+dt@kernel.org>,
        linux-mips@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dma: ingenic: Add compatible strings
 for MDMA
Message-ID: <YQL2cjo78ADXBIlf@robh.at.kernel.org>
References: <20210718122024.204907-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718122024.204907-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 18 Jul 2021 13:20:22 +0100, Paul Cercueil wrote:
> The JZ4760 and JZ4760B SoCs have an additional DMA controller, dubbed
> MDMA, that only supports memcpy operations.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
