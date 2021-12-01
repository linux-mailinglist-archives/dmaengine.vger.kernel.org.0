Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5340465966
	for <lists+dmaengine@lfdr.de>; Wed,  1 Dec 2021 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbhLAWlI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Dec 2021 17:41:08 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35441 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343789AbhLAWlI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Dec 2021 17:41:08 -0500
Received: by mail-oi1-f181.google.com with SMTP id m6so51729939oim.2;
        Wed, 01 Dec 2021 14:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fp57IFJwXNDg+FM0mXX6GajPlTd9hyatpK6xMrXr2z8=;
        b=G2bhA5iHn43a85040NnM0EC8hOGS4VHOVOkcV6wtz0/U1c6bqVOpqyCSAaqmFInj0/
         SP/p44KPsnhBRVrvyukWbwaE+m7K6unp4WLgk8LC3Whg71DVfaX8jl64Wo5DMjbcib76
         BBjQcLgTzpePmV9vfQlouPAf6W+QgYPXO1veuq24aFRAQfGiwbPtapL7qY1KzYWFb1nn
         vhpBa9d3pdmCHbpnY98KBYOZBrlHTmhEXo0JxO6i/NPhnRCqg+czR4VptJTxz19mwwSg
         z9RUm8NqtA8O15RQJovuTg6de6E5oSL8pkvpxBIKAtpw7rXvWiRBvaejCm1xmeYHeeHo
         Yo1g==
X-Gm-Message-State: AOAM530RKo1k9OojV33GwOfT9nUp/3LFoKnjMFKCEIp1qVhpgyVRkmSd
        i0213IZSZYi+s6TChc9MVsNNO5Na5Q==
X-Google-Smtp-Source: ABdhPJyPx7vZ0anj/VrjmXACLAoeK/6LkIEw2WUY+k5nu3ugAvifdlnw0FuoaP1mH3/Byg4W/eKy9Q==
X-Received: by 2002:a05:6808:23d6:: with SMTP id bq22mr1142503oib.71.1638398266340;
        Wed, 01 Dec 2021 14:37:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j187sm526919oih.5.2021.12.01.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:37:45 -0800 (PST)
Received: (nullmailer pid 2930663 invoked by uid 1000);
        Wed, 01 Dec 2021 22:37:44 -0000
Date:   Wed, 1 Dec 2021 16:37:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Green Wan <green.wan@sifive.com>,
        Palmer Debbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vinod Koul <vkoul@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: sifive,fu540-c000-pdma: Group
 interrupt tuples
Message-ID: <Yaf5OJl9970GxyMF@robh.at.kernel.org>
References: <20211125150233.161576-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125150233.161576-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 25 Nov 2021 16:02:33 +0100, Geert Uytterhoeven wrote:
> To improve human readability and enable automatic validation, the tuples
> in "interrupts" properties should be grouped using angle brackets.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
