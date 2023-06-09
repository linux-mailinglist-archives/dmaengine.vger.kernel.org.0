Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE272A5B3
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjFIV4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjFIV4W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:56:22 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A830E5;
        Fri,  9 Jun 2023 14:56:21 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33bdab7b4caso9598715ab.3;
        Fri, 09 Jun 2023 14:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347780; x=1688939780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB9yccAX1Zl0Lgp0ALKMAe+AZ5E+m549f3RDP/SQQ2I=;
        b=VWu0+qDFpt5mHgRd6WifeaLNXd64gh8KviR2xwNUXVyICoZPcVjDNBUq51eaJerQDj
         h9WWeE3gDMC1Qv1X9cZNfGywst2VzuerM2uu2IlGR8jFr8NyjDNBJ274srIQObl4kgL0
         NWMobOT4xh9v6uEn63JHGXVtMS4jOTQKEvI1jNm7fI+5tz3lek/teNg+tBye4iUUsoQI
         Lhah2X2F5bun0/wMTUhQQNJqfxqcgjOvfKPySemDzB2+7QIio8SUID5RrMfIyI0ukoTg
         9wC97DUTNPJpWhmX2RSS5S3eJumHYX+gGiJVyovZfTIIFCoq5SJRFHJPOqaLo2fxh//9
         q+Aw==
X-Gm-Message-State: AC+VfDwOt1NPr/pMiG0xS8TljcBYIBXEGAz8TJi4bLuqjlEtN2c/hFG8
        YzPWKqf8ZtQVIqwZBVQwdg==
X-Google-Smtp-Source: ACHHUZ4mUBthMCIvyHVtNXvPq5INEdw7zijRfRjpz0tvOBvj0MlyFM5JrENgkzrkFTQPX6AJt9/XDA==
X-Received: by 2002:a92:d901:0:b0:33b:94d:b613 with SMTP id s1-20020a92d901000000b0033b094db613mr2365590iln.11.1686347780245;
        Fri, 09 Jun 2023 14:56:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p11-20020a92d48b000000b0033af42a969asm1314394ilg.57.2023.06.09.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:56:19 -0700 (PDT)
Received: (nullmailer pid 2530734 invoked by uid 1000);
        Fri, 09 Jun 2023 21:56:17 -0000
Date:   Fri, 9 Jun 2023 15:56:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        dmaengine@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: mailbox: convert bcm2835-mbox
 bindings to YAML
Message-ID: <168634777667.2530679.12856393854713881278.robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-8-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-8-stefan.wahren@i2se.com>
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


On Sun, 04 Jun 2023 14:12:20 +0200, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-mbox from .txt to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/mailbox/brcm,bcm2835-mbox.txt    | 26 ------------
>  .../bindings/mailbox/brcm,bcm2835-mbox.yaml   | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

