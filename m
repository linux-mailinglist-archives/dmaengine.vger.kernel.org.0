Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090B0735FEB
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 00:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFSWtV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 18:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSWtU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 18:49:20 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B2E55;
        Mon, 19 Jun 2023 15:49:19 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77797beb42dso143980439f.2;
        Mon, 19 Jun 2023 15:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687214959; x=1689806959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XC5lpbRInQ/+5gWZrsaA+KqscUlYl6sjL8GyEzFCglg=;
        b=AdZhKelKh/g8u40VH6vVJymf5NCG1IzEnDiO/6+7Mj3/7jtrUaGxjjHChsMsFrciJ2
         754nOfGunzAV+VwT7DPwNofUlztqoPSTheUYHw2vV4RINONZjBlY9z23e7M9+Br/HiBD
         DJN17atoa7YKyO6KRPYiK9XOGJXdeGQR5mIpEuX9m4R7msx13m2fZxqe51Uz2hb+YYpz
         IQnqcjWBiaVwehHSh9w/PhDnJJhn3jCh8fmiuBg8iJrqQ2yF0H63JNYppdhDxmPkIFmH
         FiMkqEdofW/acAsuom520r/W8IEdqAc8lpZiRQ+q0dN1IKRlEdi/Helr7RivhjttZR3z
         2dgg==
X-Gm-Message-State: AC+VfDzFOuWJv/fx6eEwcrlqHHtkf2rLtsXhJOmK3mygt9AP5A5RB5ad
        8iALzJw4URet3sbl1CIx4Q==
X-Google-Smtp-Source: ACHHUZ6aHzKiHI6j0pGyABhICGpFbZYq4LbWxeN/Z7bW9EdQkXxO4vMuOqgS+UoLXk9bYuI+u4Zypw==
X-Received: by 2002:a5e:9802:0:b0:77a:c315:75b6 with SMTP id s2-20020a5e9802000000b0077ac31575b6mr2055139ioj.5.1687214959178;
        Mon, 19 Jun 2023 15:49:19 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y22-20020a5ec816000000b0077ac32a5de8sm213979iol.26.2023.06.19.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:49:18 -0700 (PDT)
Received: (nullmailer pid 1675447 invoked by uid 1000);
        Mon, 19 Jun 2023 22:49:16 -0000
Date:   Mon, 19 Jun 2023 16:49:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH V2 2/7] dt-bindings: dma: convert bcm2835-dma bindings to
 YAML
Message-ID: <168721491312.1673983.7120570846265839418.robh@kernel.org>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-3-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617133620.53129-3-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 17 Jun 2023 15:36:15 +0200, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-dma from .txt to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/dma/brcm,bcm2835-dma.txt         |  83 --------------
>  .../bindings/dma/brcm,bcm2835-dma.yaml        | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring <robh@kernel.org>



