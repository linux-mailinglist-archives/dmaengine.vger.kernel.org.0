Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00D42DA3B2
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441258AbgLNWxa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 17:53:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33557 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441219AbgLNWxW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Dec 2020 17:53:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id d203so14439oia.0;
        Mon, 14 Dec 2020 14:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SyyhAllHou+H/Fjg3osbdVQ5pN6LnUp0eGp9T9kAOXM=;
        b=Jwn60iyJgCFL1BpIpXPxf7bWh9bIe5vTl1AfFYPJL0TbJujTJGQHWcr76T47MhNSin
         QiggglAD8XePEFFK4+06ED4bZj26gUJCFtRUGXRBnFIqv5zlmfWtwORrqHGFPa76iiu4
         SKso+B2BqaBe/JeTsjKun99zvSIN90AahesNXpQtoy/qh3aocrIxdK5xsFJE99p3NZ7p
         TMrZf0GzQ3SP3pQ8xPP+uYL2AbJ/u2Q2S+OFQHaIxvDHar4KllBrmswAP+6S1rDJTIoR
         3lR10+FZQtDun3rg42CSTtlosqY4qhUdYd+tVMy1RIhQO2jWyc2cBxDuT0Uig3vW0Mpu
         iMFQ==
X-Gm-Message-State: AOAM530SyBvPY9o6CAJRYDSYpRM1Edtq6OtpsJPlmJ2wP0AdiNm5twJL
        lt8oIoBh8qMGAMSdD9oEPZXhQyIi0A==
X-Google-Smtp-Source: ABdhPJysybPsYe5CRfZkVK6K1vVIoD0WXsRrXEW1j8FYo/Msf0nYVohh3Ui7BOBKcP+kZlKsNOUuQg==
X-Received: by 2002:aca:3987:: with SMTP id g129mr18994911oia.76.1607986361458;
        Mon, 14 Dec 2020 14:52:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23sm4606286oih.52.2020.12.14.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:52:40 -0800 (PST)
Received: (nullmailer pid 2531430 invoked by uid 1000);
        Mon, 14 Dec 2020 22:52:39 -0000
Date:   Mon, 14 Dec 2020 16:52:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Eugeniy.Paltsev@synopsys.com,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 10/16] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Message-ID: <20201214225239.GA2531399@robh.at.kernel.org>
References: <20201211004642.25393-1-jee.heng.sia@intel.com>
 <20201211004642.25393-11-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211004642.25393-11-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 11 Dec 2020 08:46:36 +0800, Sia Jee Heng wrote:
> Add support for Intel KeemBay AxiDMA to the dw-axi-dmac
> Schemas DT binding.
> 
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
