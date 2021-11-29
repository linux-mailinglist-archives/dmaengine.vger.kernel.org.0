Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965804627F8
	for <lists+dmaengine@lfdr.de>; Tue, 30 Nov 2021 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhK2XRJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 18:17:09 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35727 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhK2XRC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Nov 2021 18:17:02 -0500
Received: by mail-ot1-f45.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso27735619otr.2;
        Mon, 29 Nov 2021 15:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdZYPJcMdD8wr28rd+KcGV1ImyttgAJtTmto0qzfN9I=;
        b=KpwqtOc8ZsM5K1bNqvETXBNVY2tvsS1ioIal6tHUms6HjHSAYOdOEtA/8JWpCVC26q
         bMF1wPfAYjjjYz2qjqT6kiNlUq0pHx+J6eRFHP1oob7XDqq1tm7ukJ+mwaHrJSbdIlaO
         jg1iZfChcmjZUwsHAPkSDV5jamRK9aXzOdG925jWjoNt96DHBuO6r84QN3rz6Vx0FL+H
         PD/6Vs1SoNJJB12EJQBMyKcoWyeQW7v7GHxhlawvRUUNCGkdrgZDdoQDrBJWQObvkvmp
         nKIPfJlA4rXD800Q8dXT3/s4kOdeb+e7QxZI6YnyAk2CN8tu0SYEg5CaHjCkRdmRXLEc
         yfAQ==
X-Gm-Message-State: AOAM533+oTPovTq9ONA/j2A1GN3GQZD7C0s2kwyl55cn5tKtmppa+dgp
        2UIp4agPYVQT/YH2ALiFww==
X-Google-Smtp-Source: ABdhPJwlOcBLipQCR0h3G80bR+R1jXN6jbmi9p1p3ZtXNEWw+UVg4SLmgYXTJ+malU/zYNbk3+JiPA==
X-Received: by 2002:a9d:750c:: with SMTP id r12mr46401373otk.273.1638227623991;
        Mon, 29 Nov 2021 15:13:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u40sm3496985oiw.56.2021.11.29.15.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:13:43 -0800 (PST)
Received: (nullmailer pid 789766 invoked by uid 1000);
        Mon, 29 Nov 2021 23:13:42 -0000
Date:   Mon, 29 Nov 2021 17:13:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: dma: sun50i-a64: Add compatible for D1
Message-ID: <YaVepmEInHXCPvQA@robh.at.kernel.org>
References: <20211119052702.14392-1-samuel@sholland.org>
 <20211119052702.14392-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119052702.14392-2-samuel@sholland.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 18 Nov 2021 23:26:58 -0600, Samuel Holland wrote:
> D1 has a DMA controller similar to the one in other Allwinner SoCs.
> Add its compatible, and include it in the list of variants with a
> separate MBUS clock gate.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/dma/allwinner,sun50i-a64-dma.yaml           | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
