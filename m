Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DCA2D5CAD
	for <lists+dmaengine@lfdr.de>; Thu, 10 Dec 2020 15:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbgLJOAy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Dec 2020 09:00:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33959 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbgLJOAt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Dec 2020 09:00:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id a109so4920267otc.1;
        Thu, 10 Dec 2020 06:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDnG3etuTG2O5w/8pwgzq0QlreX8DZcmIWq84PxhfKg=;
        b=imY4rlLNAmw4FDqGKT3djCKUdLxajSB5qF/SaBvEFtMG6INmNIbGkav6zbSNjzra1j
         fytCDLlLvRUqSc5MIwUub38KY/VlkIR/zIICHthaqHVhmRBAuKacaoWe15n0bKtDVskc
         uXqtUVTgEleHI9Yj0JevJ96rJHkAc1J+Vwmir7mqQj2sCgMVFrmtjAvM4I8cgPCl8Wl9
         0+76C8+Zeei2Rs3K6YYe0Jx88G1xfofDs4YJNmcPWo/+fJSFpEyzvPb1OfDAxEN4wOh2
         hCpeC6n++PZGLnEcgp1iNjDupcyKP1LyiFSnf+P+ULaZICTl3cAWTXCenJu4PQkggcG+
         fDWQ==
X-Gm-Message-State: AOAM530dL9+F/gzXzu11c8Fkdfqo4bPbKkiR6JFqtIdvWiRO2qQejV36
        to4z+ghiJhGDSaF5LFw1bw==
X-Google-Smtp-Source: ABdhPJz90X0LBbNbtmVSc9EIZIuCicnTJlnEkxXOecBv4cMXBoj7eZvZ7vpSU+SbMjRkkNr8U3XHbw==
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr5824066otf.188.1607608808087;
        Thu, 10 Dec 2020 06:00:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r12sm1014107ooo.25.2020.12.10.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:00:06 -0800 (PST)
Received: (nullmailer pid 2421016 invoked by uid 1000);
        Thu, 10 Dec 2020 14:00:05 -0000
Date:   Thu, 10 Dec 2020 08:00:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     grygorii.strashko@ti.com, linux-kernel@vger.kernel.org,
        t-kristo@ti.com, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, nm@ti.com, vkoul@kernel.org,
        vigneshr@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, ssantosh@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 12/20] dt-bindings: dma: ti: Add document for K3 PKTDMA
Message-ID: <20201210140005.GA2420984@robh.at.kernel.org>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-13-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208090440.31792-13-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 08 Dec 2020 11:04:32 +0200, Peter Ujfalusi wrote:
> New binding document for
> Texas Instruments K3 Packet DMA (PKTDMA).
> 
> PKTDMA is introduced as part of AM64.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
