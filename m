Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625F229305B
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgJSVQg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 17:16:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37095 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgJSVQg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 17:16:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id m22so1186750ots.4;
        Mon, 19 Oct 2020 14:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWzvbmQLQZlZz3G7wVvGYG1+VCIyxQzsV3S2HQwzxnI=;
        b=SUqjvWJzztPzyY+IyrgYyPw8JdY42+Fh2c7eIsk0p8ONcSO6567CZcGqqUUQf8656n
         dRvJvSViJO5TY6HIT7bhy2DB9SiXboYOXwv08+RvB9bLhgfhNyan1FdPuY643sPiQAyA
         SooFt3/JzXY+0jmU1YR97TNWpyyjOkZPHiEsp6zWlZI/tVvGIXhegUfxCejXSFu7QlMu
         s2wWa49+jz7+LKpLUQ8XOwql2Edbo9dMiZNPq0dW0YDgAynfjrWlkcjP1JHfbV2egVsz
         eMVt1Z6BrlnbAxNoNAm/wFJBWbDIuQBuTmufcqis/dW9Zp/58TcJtycV2sv9VxiLCmzI
         MsdQ==
X-Gm-Message-State: AOAM532l23tdf0iHIBB+yusIRKCDznZUIQqeKpDIAcmVKv9f9DfxOuG6
        wpLC5jorZTNrsgZFGNDS+g==
X-Google-Smtp-Source: ABdhPJz1uyiV14WVdrs/T1Q1Jk9VF8uhqAX11UbC1/A/1NkpNrq1GI1Z6fIynsSqQAzfN35X5AsRWg==
X-Received: by 2002:a9d:7c96:: with SMTP id q22mr1293742otn.118.1603142195742;
        Mon, 19 Oct 2020 14:16:35 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t65sm259100oib.50.2020.10.19.14.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:16:35 -0700 (PDT)
Received: (nullmailer pid 3616177 invoked by uid 1000);
        Mon, 19 Oct 2020 21:16:34 -0000
Date:   Mon, 19 Oct 2020 16:16:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        sean.wang@mediatek.com, dmaengine@vger.kernel.org,
        linux-mediatek@lists.infradead.org, vkoul@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516
 SOC
Message-ID: <20201019211634.GA3616126@bogus>
References: <20201015123315.334919-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015123315.334919-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 15 Oct 2020 14:33:14 +0200, Fabien Parent wrote:
> Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
