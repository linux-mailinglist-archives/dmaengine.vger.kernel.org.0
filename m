Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153F3993F4
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFBTx0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 15:53:26 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46926 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBTxZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Jun 2021 15:53:25 -0400
Received: by mail-ot1-f50.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso3497539otl.13;
        Wed, 02 Jun 2021 12:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Q7Dprv1XHrLOLADgwS+LUK9nX7U22rV5liWcuJi1sQ=;
        b=hnll6LBrPoJFNdZH+4p0aJbLv9a4i5tdd2LbjPwCKcSdAtmz3tjjtYCjlVu6KgE67x
         XGC8+LUS0/xp0T/gVEClYwU7r/8rWH1LuXZVknbZLhjzG1tCpg1T5ADKmS7II4V4OIgt
         9OI0k9t05u6fISYbCjEgzr4jMlAfPtsdgaIwvhNM72NC9R8/fTk0OFHdCDbZ9MbwPS1q
         dZ8//NUXt/GBh62aTAPydiqF3hi6SL0i+LrghzmjFh5G0j1nv+FNTIKpHikoTCesKSMh
         8wOSIIkb57zsUqwxfr/ttO1uvKG/8gfFkAtmjM1LAuJ6w7TxUevWTneS5UiHyhxA8A3v
         9HXA==
X-Gm-Message-State: AOAM530LyRXzrg2B86kMkmoaY12c9CBoeqA2Qfox+MKFFaDrXAabKiYL
        k7G1E/jY1H7V/0Dvc4RAWg==
X-Google-Smtp-Source: ABdhPJwwMBhCZYX2BPqAsh/iJokBF2o4Qnby7q+rYIweMoIYXdgIomW7ueAVqAo+AIB0QXXG+duWFg==
X-Received: by 2002:a9d:3e5:: with SMTP id f92mr4917267otf.181.1622663501828;
        Wed, 02 Jun 2021 12:51:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b81sm194380oia.19.2021.06.02.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:51:41 -0700 (PDT)
Received: (nullmailer pid 3875025 invoked by uid 1000);
        Wed, 02 Jun 2021 19:51:39 -0000
Date:   Wed, 2 Jun 2021 14:51:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH v2 16/18] phy: dt-bindings: Convert Cadence DPHY binding
 to YAML
Message-ID: <20210602195139.GA3874992@robh.at.kernel.org>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-17-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526152308.16525-17-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 26 May 2021 20:53:06 +0530, Pratyush Yadav wrote:
> Convert Cadence DPHY binding to YAML.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> 
> Changes in v2:
> - Drop reg description.
> - Add a description for each DPHY clock.
> - Rename dphy@... to phy@... in example.
> - Add Laurent's R-by.
> - Re-order subject prefixes.
> 
>  .../devicetree/bindings/phy/cdns,dphy.txt     | 20 --------
>  .../devicetree/bindings/phy/cdns,dphy.yaml    | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
