Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D382139942D
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFBUFP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 16:05:15 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34638 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFBUFO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Jun 2021 16:05:14 -0400
Received: by mail-oi1-f175.google.com with SMTP id u11so3896599oiv.1;
        Wed, 02 Jun 2021 13:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjEK/cX+BI3n6vnExnE9Eyw2QgCenmcMJowoMHQs3c0=;
        b=qq87w46DdIYPOmtXg77N+un/LRP0P3srYBoi5pLPPsPv5GmNBsGJL1l+mDALl3AGmX
         vNY4oP0JSOhxZVecN7Yn0fcwUzueo22zpbtGS4BzkFF7PHamKjaDzAMdLMoud5Ib8xEk
         gj6DDp/dP78ScgECGXXtkT5ZiM3YmxbTbWSYAp7F0oP2NIkzC7TA353umvq8vbTc+Sfx
         YV+JUHEOhHkf4ohlwxGfgEOjMkl9mqhLMziRG22OLS2rOgP8A/HIP8uUo097PWZhI6vI
         fw9OdUZyX709cpANUjjwocRrgD0qPGIWrqwriLTLDX2CAG+CLzTdCpaSip5rYrcNH/V1
         u24Q==
X-Gm-Message-State: AOAM532+FLd6X2E/s/4vH19btyBTuu7iTizu6RaWau24kbpMUzpJaM2B
        QQK9feMOW3FVsGsYIp9J/w==
X-Google-Smtp-Source: ABdhPJy/dFj5lq9utpS+hog7W+dkdat5s6XM18gdtDyQiihpKHVccVMI+H73F4x+Vb1d99f05UTxjQ==
X-Received: by 2002:aca:2311:: with SMTP id e17mr23343284oie.160.1622664210887;
        Wed, 02 Jun 2021 13:03:30 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 7sm202636oti.30.2021.06.02.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:03:30 -0700 (PDT)
Received: (nullmailer pid 3895257 invoked by uid 1000);
        Wed, 02 Jun 2021 20:03:28 -0000
Date:   Wed, 2 Jun 2021 15:03:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/18] phy: dt-bindings: cdns,dphy: make clocks
 optional
Message-ID: <20210602200328.GA3895198@robh.at.kernel.org>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-18-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526152308.16525-18-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 26 May 2021 20:53:07 +0530, Pratyush Yadav wrote:
> The clocks are not used by the DPHY when used in Rx mode so make them
> optional.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - Re-order subject prefixes.
> 
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
