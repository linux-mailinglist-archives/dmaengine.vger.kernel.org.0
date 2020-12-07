Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564622D1CE7
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLGWLv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 17:11:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46852 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLGWLu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 17:11:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id w3so13419663otp.13;
        Mon, 07 Dec 2020 14:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsQvzdPF2thWUjytjWg/Jash3Lio8upePTuvdwV9ns0=;
        b=RrEi/EKv91i0uq1u6cGMbdS+ikPv1DvSO2QPjrdwWlq3kr1Xyf0z3GJZtbGUG90kEo
         c7pX6CrZvGcqzMdA/800sX9oGy/kFGSIZvF0RY5mQ8YrR6jZUmUnbWBznqtwcoRbVKwU
         clvALs1prenR4cG870PmB6xDYvYWkvimf2JkSGb/ZLRqI95uGNkjhjhEfwx+kgsWRfZh
         2okNFMe/CL4N0vVTiI1yKJUxjaHHfF7ltUYLBF5N+1rd88mvl2Pr+pbfWMCZ+4VILtAx
         6n/I7QV5554obj8z6x80/0481ZWs6X6InAqD525vrkX+jF0sgxON53J2yLnLQ0LCN/I9
         Ky9g==
X-Gm-Message-State: AOAM533Ab3Yl7rkDuptvtJBtTCacb240mJs3KsDZFyKZKiZy45hbrDhY
        EzQvdvqwP6bKkz3nYTQFCQ==
X-Google-Smtp-Source: ABdhPJwY029JGJagNUX9pkBsVi3mAwTfkCxM4O6dOCfWFX5aA90hEQI+/c8P1R9rLD6dCCf6Oh1d8w==
X-Received: by 2002:a9d:76d7:: with SMTP id p23mr14498167otl.180.1607379069692;
        Mon, 07 Dec 2020 14:11:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm658388ooa.24.2020.12.07.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:11:08 -0800 (PST)
Received: (nullmailer pid 927326 invoked by uid 1000);
        Mon, 07 Dec 2020 22:11:07 -0000
Date:   Mon, 7 Dec 2020 16:11:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 04/18] dt-bindings: dma: owl: Add compatible string
 for Actions Semi S500 SoC
Message-ID: <20201207221107.GA927276@robh.at.kernel.org>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 20 Nov 2020 01:55:58 +0200, Cristian Ciocaltea wrote:
> Add a new compatible string corresponding to the DMA controller found
> in the S500 variant of the Actions Semi Owl SoCs family.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/owl-dma.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
