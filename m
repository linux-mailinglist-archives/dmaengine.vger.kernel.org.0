Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542F4968FD
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jan 2022 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiAVA7Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 19:59:25 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42948 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiAVA7Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jan 2022 19:59:25 -0500
Received: by mail-oi1-f178.google.com with SMTP id y14so15973785oia.9;
        Fri, 21 Jan 2022 16:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuvX87i5/+gN2OGkw1Iv7+QOqkzrqLrSTdBhVZ93OJY=;
        b=SXMl6IOBC4R/MnplCK6tpQfzUkb0N1kxj73U/nKGgRkmuVL+bl6gB6gMpEk9mtyYyW
         wjNt0KQRhzoJd3T7D2cYptxvCqCQ5qrn9BQBSMena7bw0ZLI14nlSHjnjtPF7GncYu2X
         NptQPfNa3c8z4TkWJCGPm7i1WKDnn/zYti0x4jjo10bNXW2fXorYWOgrZnAIH+mXH6G4
         Di8WxM/6rfZfqNI8p1WDVYqYdyk0NbzeKsVsSCWN0aEi0zqGII52Rzz1iFkGwO2t8nEB
         OwMgOJjFnP3n578RB0605WmJTMJLExpY4ynWgyD62VUeJS4ju7jAqBjB72HQoCo8nJe3
         trXQ==
X-Gm-Message-State: AOAM532AL5rimL2HfiuvPnrqpn8qjvI5HqefOEiaQHcYDQzUE9XKReie
        RkSsSKWhvdxZsIM1p/KEJRE+EyvkLw==
X-Google-Smtp-Source: ABdhPJxI/KifybrEimqapp4JMNBVmfXuaHfXWIKjx+u8q95D7qWec7oAzqJyPBUAtp6fWbuchqtPJw==
X-Received: by 2002:aca:ad15:: with SMTP id w21mr2676382oie.132.1642813164976;
        Fri, 21 Jan 2022 16:59:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f2sm2295403oiw.50.2022.01.21.16.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:59:24 -0800 (PST)
Received: (nullmailer pid 1959763 invoked by uid 1000);
        Sat, 22 Jan 2022 00:59:23 -0000
Date:   Fri, 21 Jan 2022 18:59:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: zynqmp_dma: convert to yaml
Message-ID: <YetW6/YIR7SGAfHm@robh.at.kernel.org>
References: <20220112151541.1328732-1-m.tretter@pengutronix.de>
 <20220112151541.1328732-2-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112151541.1328732-2-m.tretter@pengutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 12 Jan 2022 16:15:39 +0100, Michael Tretter wrote:
> Convert the Xilinx ZynqMP DMA engine bindings to Yaml.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 85 +++++++++++++++++++
>  .../bindings/dma/xilinx/zynqmp_dma.txt        | 26 ------
>  2 files changed, 85 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> 

Applied, thanks!
