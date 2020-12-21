Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343192E00A0
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgLUTDK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 14:03:10 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:44948 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLUTDK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Dec 2020 14:03:10 -0500
Received: by mail-oo1-f49.google.com with SMTP id j21so2434610oou.11;
        Mon, 21 Dec 2020 11:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2A5Jx5ebri9fUM0pBXdjugZO9tY3imQBK8tvpAAgvQU=;
        b=gTjHLzUNP3QBvVoZ6vbwQY1lQNMNow3kymXD0w6kgquSY9zytCFrIdDKJzqtfqNZ4w
         RdPFixe3Z7gdPE/IZoMAr8pH3lss4oke8TpEBWyyOUoT315e8hY2ILkOlYvGv8z3/qoC
         GjfF7h3XgRVGFepKP90BDnl93oW6/jDFA2OFx66pNTN6jQWsnrsnT8032DWsiAO0U43m
         DSZ66RFzPPFfo/gUdP93MJ94jaB0VKVyk7gnNLW04GCcsNcUFJSdZRXSOd0yPt1uopNN
         qkTi1duso0vSHKi0SjQjcqFWw9T06dEcs7CGlvVCYvv14cSe7xVSEAtxf36U+rJVMVGp
         l+Fg==
X-Gm-Message-State: AOAM532+U8fxOFpJbKEA72lcY2xc479dYUWI0YwdN78CkGjlpnki7Dtc
        KSkR/58Iq7H/9GVmFNil4w==
X-Google-Smtp-Source: ABdhPJxIOUHXL9Zhm7n1ZCZQbPwtYZh4JNeMqAA/H+90t3FAdhgZwpZgAbd9wAX2YvqDelqvYU7/kg==
X-Received: by 2002:a4a:98e7:: with SMTP id b36mr12461400ooj.3.1608577348973;
        Mon, 21 Dec 2020 11:02:28 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h93sm3978329otb.29.2020.12.21.11.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:02:27 -0800 (PST)
Received: (nullmailer pid 368745 invoked by uid 1000);
        Mon, 21 Dec 2020 19:02:26 -0000
Date:   Mon, 21 Dec 2020 12:02:26 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     devicetree@vger.kernel.org, Eugeniy.Paltsev@synopsys.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 01/16] dt-bindings: dma: Add YAML schemas for
 dw-axi-dmac
Message-ID: <20201221190226.GA368699@robh.at.kernel.org>
References: <20201216021003.26911-1-jee.heng.sia@intel.com>
 <20201216021003.26911-2-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216021003.26911-2-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 16 Dec 2020 10:09:48 +0800, Sia Jee Heng wrote:
> YAML schemas Device Tree (DT) binding is the new format for DT to replace
> the old format. Introduce YAML schemas DT binding for dw-axi-dmac and
> remove the old version.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
