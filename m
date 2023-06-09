Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A638472A5C5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjFIV74 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFIV7z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:59:55 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E37D2D44;
        Fri,  9 Jun 2023 14:59:55 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso9640185ab.3;
        Fri, 09 Jun 2023 14:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347994; x=1688939994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0wp/DImGQ4iO7fdtJ/3uU/mcyC9k5HDGj0jAU4Zycw=;
        b=cdstRausbEVS5FZzHP9+5reOu4c/TdyaozlZLbu9bCwrSM+BGa1XPse7y4b/nKE5WP
         Ie2xk4Wo4/RtHxRqCBiuNOFH2eJTbbj00LAI/A3D9RL6yTCLZ4n2y2do5yOepGGy8BfD
         OUeAHw66nqJ6L2YpU7ZUNzQ+JdeHPKk+A48IkqWouu5eeKjJED4TjUH3pPdAPvo+mxeN
         y91yZMKFqPeBfT+zTJ/+byHSxP6xPNgfGup3CDP+0gviFDwfygpaFYbiZ1qt8DGAu4MC
         jWgEKKQMDfFPUAK/oD/vZlXuvvUaMYwfWgALIxIUfeDa9oV33cKIeYTPYpFGa3+5WEZx
         e6hA==
X-Gm-Message-State: AC+VfDxaMcvYhhvoW94jBAa+mZ9kPjalcQ29N59Yap49vBwmeIEhMtHK
        Av4zk/bLpkBVTGbDCEu4cg==
X-Google-Smtp-Source: ACHHUZ6Zrjicv3N+bf0HohnF1TbBzxiOeWFI7qlsEEKWsfvN0Dq5YPf7XD+WbtlxVoIvylpv6pMPPA==
X-Received: by 2002:a92:4b08:0:b0:33e:7244:3c9b with SMTP id m8-20020a924b08000000b0033e72443c9bmr2696259ilg.14.1686347994545;
        Fri, 09 Jun 2023 14:59:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id em2-20020a0566384da200b0041d8bc6e143sm1173558jab.35.2023.06.09.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:59:53 -0700 (PDT)
Received: (nullmailer pid 2534737 invoked by uid 1000);
        Fri, 09 Jun 2023 21:59:51 -0000
Date:   Fri, 9 Jun 2023 15:59:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-pwm@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 09/10] dt-bindings: thermal: convert bcm2835-thermal
 bindings to YAML
Message-ID: <168634799126.2534678.15883588315462675223.robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-10-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-10-stefan.wahren@i2se.com>
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


On Sun, 04 Jun 2023 14:12:22 +0200, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-thermal from .txt to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/thermal/brcm,bcm2835-thermal.txt | 41 ----------------
>  .../thermal/brcm,bcm2835-thermal.yaml         | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

