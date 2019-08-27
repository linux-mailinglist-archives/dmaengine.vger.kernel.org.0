Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F49F02A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2019 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfH0QbP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Aug 2019 12:31:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40441 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0QbP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Aug 2019 12:31:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so19272140otb.7;
        Tue, 27 Aug 2019 09:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onG86bQ4dm+z8xysS1CUGALS/jZjH02NkFVXiWum+6Q=;
        b=onDc+Qx7GJVdEliuEbIf9oZB3L6WJzMtPLwCSDUddkbsgt/QbGKmM/jFfPwHxqJevO
         NuxazZkPS7aOd6rsTIJ3hV3E3aV8+oMuU3M+/jw6WLQZRjL2tt1vfQ19GeVt/wEOlc/8
         QuYlSTX2wO32RVfujeWW6PZDqELZaNUAagbf6vQKBW12coT8wwi01fElMNpNzuvsg19k
         rmfEDrn5hJL4tjHcBt4tB5KlCqCGW6i+v0ZAUfaBcSCgr/4vXzpglK++dxHrSUoQzxXm
         K/lLWEVOSH0kloRQ3vrqZaJHQ0DmSSJVl4+Oq/kTgktN8+N4oZ2jmIE1ZnP9yg//HV/G
         QQEg==
X-Gm-Message-State: APjAAAX+f0rmUrqYYb7UXE4tPOjrs8m/fHlVF4g9INJ4yoIk4S0cnPUN
        jpW6KTE186pA9RPEOXbSFg==
X-Google-Smtp-Source: APXvYqw/Xqoltl7S22xzKNb6hdgLcsjQbPzLB70m40Uuv5ScU8Xqxl9b/S4kdzBQlTAmHuTl7asMnQ==
X-Received: by 2002:a05:6830:4cb:: with SMTP id s11mr20124947otd.366.1566923473947;
        Tue, 27 Aug 2019 09:31:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i201sm3139477oib.41.2019.08.27.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:31:13 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:31:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
Message-ID: <20190827163112.GA28297@bogus>
References: <20190818051647.17475-1-jassisinghbrar@gmail.com>
 <20190818051754.17548-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818051754.17548-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 18 Aug 2019 00:17:54 -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Document the devicetree bindings for Socionext Milbeaut HDMAC
> controller. Controller has upto 8 floating channels, that need
> a predefined slave-id to work from a set of slaves.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/dma/milbeaut-m10v-hdmac.txt      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
