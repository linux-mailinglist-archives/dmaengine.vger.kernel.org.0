Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C93C8BA5
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhGNTaD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 15:30:03 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:33624 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGNTaC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jul 2021 15:30:02 -0400
Received: by mail-il1-f175.google.com with SMTP id z1so2751599ils.0;
        Wed, 14 Jul 2021 12:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzPhtbgpbxnOvk9KnY8WTPdMhffL639krC2aO6F+axU=;
        b=Uq6PsLoR/abnq414Rswh511c+OAbWqH2D+YaJuzTeFSffYUhiqn9rzEn5kA6xn9aB1
         jZkZ3GGvuIZBbpJnHKq3rET2/nKZtIt9WqWYQNWRTCJxDGyMxTPdEnRCbK+MNRhZMbrm
         TspJMcBuY1jE4phNt2seqNNnxYwKX0OMAvsgfFtnKjZYKfmqFke0de9ZznXr12PJlluy
         XIkfcwx/FHap0nzkTLOQXlB/9BrKDvFOEx8dQoKgOrgJJQQyaTitfxINhngiJdz7Ct1u
         z37thi14bPiq2d76Kj667xa+oNCdrvRmO2rAgnde9nQsz62fFt7Kdv31bjVrqFJ3xBCU
         97rg==
X-Gm-Message-State: AOAM533PC0u2JbAP09eYfgCayuikEGQwOeB6rOu7i7TyLTnphR7czZoB
        JQxVPVmoIAxm2MAnK3EEv7WZaD0Bfw==
X-Google-Smtp-Source: ABdhPJym1dGtLhVjJOsI52JP8TEA6Em+rrrz6Bg6Vyph2weEybKYkuer9VVBZkwLRLrDFITR1rJA+g==
X-Received: by 2002:a05:6e02:5ad:: with SMTP id k13mr7656353ils.284.1626290830593;
        Wed, 14 Jul 2021 12:27:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f4sm1722768ile.8.2021.07.14.12.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:27:09 -0700 (PDT)
Received: (nullmailer pid 3078602 invoked by uid 1000);
        Wed, 14 Jul 2021 19:27:05 -0000
Date:   Wed, 14 Jul 2021 13:27:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: add alternative REQ/ACK protocol
 selection in stm32-dma
Message-ID: <20210714192705.GA3078178@robh.at.kernel.org>
References: <20210624093959.142265-1-amelie.delaunay@foss.st.com>
 <20210624093959.142265-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624093959.142265-2-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 24 Jun 2021 11:39:58 +0200, Amelie Delaunay wrote:
> Default REQ/ACK protocol consists in maintaining ACK signal up to the
> removal of REQuest and the transfer completion.
> In case of alternative REQ/ACK protocol, ACK de-assertion does not wait the
> removal of the REQuest, but only the transfer completion.
> Due to a possible DMA stream lock when transferring data to/from STM32
> USART/UART, this new bindings allow to select this alternative protocol in
> device tree, especially for STM32 USART/UART nodes.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  Documentation/devicetree/bindings/dma/st,stm32-dma.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
