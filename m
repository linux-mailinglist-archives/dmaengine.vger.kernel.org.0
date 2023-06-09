Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E972A5B6
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjFIV5B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFIV5A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:57:00 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E12D44;
        Fri,  9 Jun 2023 14:56:56 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-77493b3d18cso104491239f.0;
        Fri, 09 Jun 2023 14:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347815; x=1688939815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzOONi0zgV7LIasSzfLGqe+HzHpNzqns4tNaD49XSTc=;
        b=BQDAzPS7ElShix1XNvzfbF1yVvDXdD5uwG+6CfHvCnqxz7actgc01sE6dHbSDwclcd
         izAAircC5zvUS4LdW/HVmepZ2X7/xB0j1C3joCCgBXGcvV4Ale5QyJqnnkhfkqPiDyy2
         h5GRdX9pfZkMffwOp3i3evd2SojjQHDZMiw/HVFnjP6X86WhwrhZOYnAspzcVSWTFghY
         dQlJuTtXjYKfhkLdZ2XTNMEBLFe7yXtGh0+JgOrcx+bDo7pteV30DRGxRtt4c4mJAy52
         nPv47Bsho6Dtm8XiSjVaBa+x7UrebIZ6dOuZm2sjc+l54LIq8nxz1C1zP7OBvh8dIzSw
         4TjQ==
X-Gm-Message-State: AC+VfDzLg5gpLZbiKDxLcxROadx6te0MtjPrBHz6oUbA6rKcc0G8BaJS
        iDhrbhf1DkcH6IN6P7qplw==
X-Google-Smtp-Source: ACHHUZ6nZ2KaD5hmNp07WmHCrLCDbmQfPZXYVB3WGcLgf/BZWcHdAGYHB1k7vwhyA9CNl5JuR4m7Lg==
X-Received: by 2002:a5e:c90d:0:b0:774:9c64:e0a4 with SMTP id z13-20020a5ec90d000000b007749c64e0a4mr2439964iol.4.1686347815592;
        Fri, 09 Jun 2023 14:56:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v3-20020a5ec103000000b00763699c3d02sm1348089iol.0.2023.06.09.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:56:54 -0700 (PDT)
Received: (nullmailer pid 2531490 invoked by uid 1000);
        Fri, 09 Jun 2023 21:56:52 -0000
Date:   Fri, 9 Jun 2023 15:56:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 08/10] dt-bindings: mmc: convert bcm2835-sdhost bindings
 to YAML
Message-ID: <168634781203.2531432.15882860496306793883.robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-9-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-9-stefan.wahren@i2se.com>
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


On Sun, 04 Jun 2023 14:12:21 +0200, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-sdhost from .txt to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/mmc/brcm,bcm2835-sdhost.txt      | 23 --------
>  .../bindings/mmc/brcm,bcm2835-sdhost.yaml     | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

