Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B22AFD2A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 02:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKLBcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Nov 2020 20:32:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33217 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKKWqZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Nov 2020 17:46:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id k26so4117906oiw.0;
        Wed, 11 Nov 2020 14:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pls+V/H/4FrDdC+eWOynRQq2y92PsS473AH0BwXYNwA=;
        b=AFxCnvjiEcLnzUEVUG0xP2r16Iomcfo5JVv0yWPhmSQg0L7vRScexx+M/qvgrHCA4h
         6IVd7b5LiQwV2hRBzmRvEjFgRGV4Op8WjaoA7q9iC5sx+9NmLtjaFVPRrVr+rS+avaLJ
         zUoDaV/jFH/CTldUX+k6rLrzlaF6nMBesYKY6jyy6mypzl1Ez9WVpUE0h+rAaCRNWvpo
         NSR5PUDMAG4zMO+iIBlmm9M3iHcrQwTtMwRr59JR6nIxGY7SIxdJqDOozGY60Zg1O9mk
         riQrF708EzrHg4DL3bvaIKuKz1FZEmSUTpKy09c/XLF7yYFkEWuEsxRdt3mfLC02Wfl3
         442w==
X-Gm-Message-State: AOAM530UQqr79mI2WPKYZXiBjpd5qrxnko1uKJ/Q8eAIDhPzjmLDObA3
        ka6ta1sRxEYoVAsLiTrFcQ==
X-Google-Smtp-Source: ABdhPJxjq4CPZZ7vNrzHEOOOSGFQ4dHbRcKv2GqlppSR/LIrRMC+dJwGYkrtFYwsMmH1RliyLFJRfQ==
X-Received: by 2002:aca:fd86:: with SMTP id b128mr3838345oii.103.1605134783059;
        Wed, 11 Nov 2020 14:46:23 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm851090otp.0.2020.11.11.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 14:46:22 -0800 (PST)
Received: (nullmailer pid 2184256 invoked by uid 1000);
        Wed, 11 Nov 2020 22:46:21 -0000
Date:   Wed, 11 Nov 2020 16:46:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 04/19] dt-bindings: dma: allwinner,sun50i-a64-dma:
 Add A100 compatible
Message-ID: <20201111224621.GA2184225@bogus>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <f15a18e9b8868e8853db1b5a3d1e411b0ac1c63a.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15a18e9b8868e8853db1b5a3d1e411b0ac1c63a.1604988979.git.frank@allwinnertech.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 10 Nov 2020 14:26:38 +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add a binding for A100's dma controller.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
