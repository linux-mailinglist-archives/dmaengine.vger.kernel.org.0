Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B930CC3601
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2019 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbfJANkd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Oct 2019 09:40:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43203 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJANkd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Oct 2019 09:40:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so14396153oih.10;
        Tue, 01 Oct 2019 06:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bt5QGuWyOSuGhI4UYMoEx6u+8Fcvjj7ixFszs2PhdU=;
        b=m00FrT3T+iNlC0/6GM6Ik6/dGL3mQs/4yi9WJ0SCIOFU4QtrLoCOpGvzHA4Ee/MqRM
         ve43vCaTBX+9rl4vF/zMgJS4tHkMs2jg8RBFObkweHlhiyarlgokVtyomikvDyNMqahD
         620umUeVtPBVCzgUD5E3Y5cangQpiiUP5FQhxOM5fCkTspGzxVcpg2NPREXoGlF7T+DP
         sOr0HKXNDuF02Jr6yogLH/D7MjKT1olC0BH9hEquCyEWb0rE9gNZtBAsezN96ayehHJP
         /X5VNGZJ7LWWqA01qwua5CJOoAbT4V07Ma+SXdVZh2WMVDqhw2GUnT/nDd9L4mx/KnTK
         0vyQ==
X-Gm-Message-State: APjAAAWKlNomAtSLfmDl2oUUPPag3U9tPVsRwqPX7p6jWA2HktKnU75Y
        nprxv24bayYzj07IqesaQpTAyQ0OWw==
X-Google-Smtp-Source: APXvYqxCQADKbAkiJBb9rdlee6HT9dh0xlDzj/zXQqZQh3Jhuy7T2T86o88dRcTuOcZDfTBQKRg/yg==
X-Received: by 2002:aca:4c46:: with SMTP id z67mr2523218oia.158.1569937232728;
        Tue, 01 Oct 2019 06:40:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l17sm4905668oic.24.2019.10.01.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:40:32 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:40:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: dma: ti-edma: Document
 dma-channel-mask for EDMA
Message-ID: <20191001134031.GA15324@bogus>
References: <20190930114055.29315-1-peter.ujfalusi@ti.com>
 <20190930114055.29315-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930114055.29315-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 30 Sep 2019 14:40:54 +0300, Peter Ujfalusi wrote:
> Similarly to paRAM slots, channels can be used by other cores.
> 
> The common dma-channel-mask property can be used for specifying the
> available channels.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
