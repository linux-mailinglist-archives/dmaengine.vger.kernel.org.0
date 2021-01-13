Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC47E2F426B
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 04:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbhAMDYK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 22:24:10 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37462 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbhAMDYK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 22:24:10 -0500
Received: by mail-ot1-f45.google.com with SMTP id o11so641901ote.4;
        Tue, 12 Jan 2021 19:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOZ1zcAtpG+j2m3YIJ5O/vEoXcdkINU14/EXzgqPb/s=;
        b=aI+aPUM1+rIIpYw5zhWy8U1DrOGTu+T3okBxIzCXBu7ZJfMkRbWOv+re870o30GmYL
         QlRHNl9hJqd9LmA/CZLj5cXSooifyvFxX0oAdjEJvR0RQAm1qMIheKykW4PJhZwyP+bv
         jdOYVi7a966cp9ddd+y7qbojf9Ri2wpHAtjV24Jq2x0/ZN7dYhgJ55aQncxZXKsB6iK+
         edG4t2sWbOkxrswkslL2hg91Qurd/+OwkutVJOpzGyYHQpEkv6g5y6zE8eGJCpUm8rJ0
         nUXPQpW0kGiFxUtIJcTXb4/+FBBjB+LvQtpL9VphS+D1Kl2N2byamEFbPEECraSjRq7+
         +n6g==
X-Gm-Message-State: AOAM532apd1eqw0K58wYABvn4SFgNTcFHcYJHxkaRdOBP0UtcPCMuBME
        SCSR1rcVz2b0cn5XuI4N8A==
X-Google-Smtp-Source: ABdhPJywvsHp4TphcyeyZc84gPrga7TSNEfIrt+MLVAbbAYg5iPu6n+xMjpsbkkWU1c6iAkLnF1eQg==
X-Received: by 2002:a05:6830:30b8:: with SMTP id g24mr16815ots.16.1610508209205;
        Tue, 12 Jan 2021 19:23:29 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j22sm171059otp.45.2021.01.12.19.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:23:28 -0800 (PST)
Received: (nullmailer pid 1469094 invoked by uid 1000);
        Wed, 13 Jan 2021 03:23:27 -0000
Date:   Tue, 12 Jan 2021 21:23:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] dt-bindings: renesas,rcar-dmac: Add r8a779a0 support
Message-ID: <20210113032327.GA1469053@robh.at.kernel.org>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107181524.1947173-2-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 07 Jan 2021 19:15:21 +0100, Geert Uytterhoeven wrote:
> Document the compatible value for the Direct Memory Access Controller
> blocks in the Renesas R-Car V3U (R8A779A0) SoC.
> 
> The most visible difference with DMAC blocks on other R-Car SoCs is the
> move of the per-channel registers to a separate register block.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/dma/renesas,rcar-dmac.yaml       | 76 ++++++++++++-------
>  1 file changed, 48 insertions(+), 28 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
