Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392F736EC8
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjFTOiI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjFTOiG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 10:38:06 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A5170A;
        Tue, 20 Jun 2023 07:38:05 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-340bba768acso23832585ab.2;
        Tue, 20 Jun 2023 07:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687271884; x=1689863884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF/VHqh9Z63hL9sa4QxWnH8XWdPzqcxDEJoIRF6jEW4=;
        b=ilwFOcuEzGVLEAg1iNZx+kSmWXVx+D3HXwZ53v8mtN0xt2VkA+C730LckChfkJEAqJ
         +qLk8L5fQdoDxatkMRx7LBlztfNnR8oWGuuIyLL+brRfCsqTqZhfw68cDxjTD22DODTV
         aN4BbPHHP/6FvjusGOnETP+gbahusH+zTEgbvRaAVX8Y1oLI2576eTMjzkziz3FtoYLp
         hbi0ulHDCtZgMt8s/Xz6Wk4ZrLPhQrnXoX7PbPkn4/4d9QoAAMguD70FztROm1AtLSeQ
         w04XjYWPSzseYSVOfRPWsAar5LrHKTrL31wjA4VglYmpSGSc/Sn3lHkyGlyedbAC/Byz
         Zdjg==
X-Gm-Message-State: AC+VfDzTwphaQ/nZqfH6k7DOF59i6J73fqg5kgWdZ/qpUws8KUzzGHJz
        Z7Hl39QRO9fYm5/BpOKEGA==
X-Google-Smtp-Source: ACHHUZ6G1RQDYcnuhSQF4g+EA/8pLz4mpvkXiCrsobO7vcVJIqYb/GzSo7RdqK18AFihbL90RR2gFA==
X-Received: by 2002:a6b:650c:0:b0:77e:2f33:c33 with SMTP id z12-20020a6b650c000000b0077e2f330c33mr7332406iob.3.1687271884475;
        Tue, 20 Jun 2023 07:38:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ep24-20020a0566384e1800b0042311795f77sm683155jab.83.2023.06.20.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:38:03 -0700 (PDT)
Received: (nullmailer pid 3557803 invoked by uid 1000);
        Tue, 20 Jun 2023 14:38:01 -0000
Date:   Tue, 20 Jun 2023 08:38:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-mmc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2 2/7] dt-bindings: dma: convert bcm2835-dma bindings to
 YAML
Message-ID: <168727187263.3557572.9123036067040626699.robh@kernel.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>

