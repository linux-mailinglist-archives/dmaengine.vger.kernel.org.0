Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C089E399430
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFBUFn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 16:05:43 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:39522 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBUFm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Jun 2021 16:05:42 -0400
Received: by mail-oo1-f44.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so848354oor.6;
        Wed, 02 Jun 2021 13:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yW3ZDfBnMJBUJsuopQmswVdlQKbkuOB9JOmMNmyuRXw=;
        b=eMYjdwjIhhoWe7Uq7CFUdE++U9+KjSzrKCGvjIp6tfDBj8CCbZH0mImU+bQIfSsE6A
         B5swh+YnvcI53BCMZFB+jRX7+hRJQHV+dtHZFavyftp/mPDsG9LO7952QLXeQeucnSVs
         JO4hqNW8ZV/sZRWzNx06YZWKajXhC/QTKKEuFjn8oWrYNTH8SjB/oF4GQo125tDilNDU
         2eaZNPnMl6fmeHYriy8ktPm2138W5/KtTk7oKpvkO0LDMu4RF4Woj3dQHrxESJ7Y26hT
         1CouDd+O84hS/oZ1lBuFrmIOQ9anf5rfru6nkAG2il1RxbX0jkztyXQgSv6HngQm17BF
         0XKQ==
X-Gm-Message-State: AOAM5316P5gqpm7AtG75DdGNTHHohUx1ju9KJXR30po3Xaxeh+lKJnjs
        irX6qKIh4tAk4DSJmjq4UA==
X-Google-Smtp-Source: ABdhPJwrDyos+fxWLzP98HAh+IdIrCv3fpALGzWTZZnndNjfcH2+Po08xUnsX9UZkVt6wzpaxQFD4Q==
X-Received: by 2002:a4a:9b0b:: with SMTP id a11mr26347406ook.73.1622664229254;
        Wed, 02 Jun 2021 13:03:49 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x24sm194681otq.34.2021.06.02.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:03:48 -0700 (PDT)
Received: (nullmailer pid 3895929 invoked by uid 1000);
        Wed, 02 Jun 2021 20:03:47 -0000
Date:   Wed, 2 Jun 2021 15:03:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: Re: [PATCH v2 18/18] phy: dt-bindings: cdns,dphy: add power-domains
 property
Message-ID: <20210602200347.GA3895900@robh.at.kernel.org>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-19-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526152308.16525-19-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 26 May 2021 20:53:08 +0530, Pratyush Yadav wrote:
> This property is needed on TI platforms to enable the PD of the DPHY
> before it can be used.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> 
> Changes in v2:
> - Add power-domain to the example.
> - Add Laurent's R-by.
> - Re-order subject prefixes.
> 
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
