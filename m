Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C47164610
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgBSNxr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 08:53:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35377 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgBSNxr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Feb 2020 08:53:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so23869384oie.2;
        Wed, 19 Feb 2020 05:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E2rxf7SPwcgMTCE3K5oM6SSprAcPTnFFVvcz8mMphIc=;
        b=pH2IMWZFMhEQ69Y3roSihvK6WyU0CmTYbFYZ6ixqw0rwkXYbnlGCcVyHbT6xQKCbr0
         pBIApOVw1GQi0TTPZFtpL6/cxW6s0k6I1F+o5N/a2W7riTl+3QUQ4pCrJv62punRP1mz
         tKqLwDhIcUWuepVwb8IK71DxATaAE3PX/+C25EC43IoC7h51aFP4QN2UUOADDmiX4YKO
         CUAtwBO7MLVtMSvPurM6QSRxOCeUzApAwITCSRyWu6nlj/iba9GvkofkbJMQHRmqBJ1y
         YvL7SGLYBumR/5aVdB0peXjrRIh5fxHXltS0vnQTQwcStYNqflu3x34abtOswRArMAo7
         0rEw==
X-Gm-Message-State: APjAAAXnXejKkf2CGG89u0ZsBHbSUdXIAi3Alp6IPWUXfM7mkD91dqmb
        bDGMd1dNkooXQ8i6ZdW9aHLdbh0s1Q==
X-Google-Smtp-Source: APXvYqwMJGVebJ0gKcE0QNmF2FJsBNguLXG/bpvWNsk6/5ZNGmKQ4j0O9Fd7bFZgKeFdrJCKWzJYdw==
X-Received: by 2002:aca:ea43:: with SMTP id i64mr4733986oih.30.1582120426367;
        Wed, 19 Feb 2020 05:53:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k17sm700771oic.45.2020.02.19.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:53:45 -0800 (PST)
Received: (nullmailer pid 17381 invoked by uid 1000);
        Wed, 19 Feb 2020 13:53:44 -0000
Date:   Wed, 19 Feb 2020 07:53:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: dmaengine: Add UniPhier external DMA
 controller bindings
Message-ID: <20200219135344.GA15319@bogus>
References: <1582077141-16793-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1582077141-16793-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582077141-16793-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 19 Feb 2020 10:52:20 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding documentation for external DMA controller
> implemented on Socionext UniPhier SOCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/dma/socionext,uniphier-xdmac.yaml     | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml: Additional properties are not allowed ('additinalProperties' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml: Additional properties are not allowed ('additinalProperties' was unexpected)
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1240464
Please check and re-submit.
