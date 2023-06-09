Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5B72A614
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jun 2023 00:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjFIWAp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFIWAo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 18:00:44 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF32D44;
        Fri,  9 Jun 2023 15:00:43 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33b5dba8c6cso9204675ab.2;
        Fri, 09 Jun 2023 15:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686348043; x=1688940043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIih7yq7zItAjcdW9h/PAWrVlJSne2a8QKAirSRbadc=;
        b=JDZXQrtlxmBvRR5olb6sbbGBizUQ9L6mlCEOTtw/ypVitVLk8xXn9rhRrI/zK06TJg
         FVGQztY+1pLhQxz6QB/oH1d1exIPv8wiIJcMZP1suChyr4MwsYVhvymosR4dSfcCOF2o
         Rk301QWEKTy85jLf6eUS8L4EQimP349FPVC/BvjUeYDfezLcxIvpOJRY4Xibyn2QAw9z
         sUxRubA/EpxVd7CPB/xj54lzJE01ee5V0yDTH/FdF+XwvTE5FsCk9EkvbmoFY890c6Nx
         2tYC+YrIp39tb+kJGcNw6e6p5CltwUH7SuKQP3zveRdQ+PEtIU5lFCQEc1T+Uj0vcPB2
         4VsQ==
X-Gm-Message-State: AC+VfDwgamMdpxUkYJafnVgKGpLQaqfZ7fWjwyBZOOQn0ztrDce4mKuD
        iVLl42+/Co1dczKuTqxYdw==
X-Google-Smtp-Source: ACHHUZ6EIvz7xkXcCIMVLaEMaFls8RRHQT6zRXOjUpuAp+4pwiacrjCaBEGCDgGRimwZHpHRLmeeaQ==
X-Received: by 2002:a92:d901:0:b0:33e:7552:3fd5 with SMTP id s1-20020a92d901000000b0033e75523fd5mr2391225iln.4.1686348042854;
        Fri, 09 Jun 2023 15:00:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w8-20020a92d2c8000000b0033b2f5fe9bdsm1336911ilg.36.2023.06.09.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:00:42 -0700 (PDT)
Received: (nullmailer pid 2535655 invoked by uid 1000);
        Fri, 09 Jun 2023 22:00:39 -0000
Date:   Fri, 9 Jun 2023 16:00:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 10/10] dt-bindings: timer: convert bcm2835-system-timer
 bindings to YAML
Message-ID: <20230609220039.GA2534871-robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-11-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-11-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jun 04, 2023 at 02:12:23PM +0200, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-system-timer from .txt
> to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../timer/brcm,bcm2835-system-timer.txt       | 22 ----------
>  .../timer/brcm,bcm2835-system-timer.yaml      | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> deleted file mode 100644
> index 844bd5fbd04c..000000000000
> --- a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -BCM2835 System Timer
> -
> -The System Timer peripheral provides four 32-bit timer channels and a
> -single 64-bit free running counter. Each channel has an output compare
> -register, which is compared against the 32 least significant bits of the
> -free running counter values, and generates an interrupt.
> -
> -Required properties:
> -
> -- compatible : should be "brcm,bcm2835-system-timer"
> -- reg : Specifies base physical address and size of the registers.
> -- interrupts : A list of 4 interrupt sinks; one per timer channel.
> -- clock-frequency : The frequency of the clock that drives the counter, in Hz.
> -
> -Example:
> -
> -timer {
> -	compatible = "brcm,bcm2835-system-timer";
> -	reg = <0x7e003000 0x1000>;
> -	interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
> -	clock-frequency = <1000000>;
> -};
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
> new file mode 100644
> index 000000000000..555fca4897e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/brcm,bcm2835-system-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BCM2835 System Timer
> +
> +maintainers:
> +  - Stefan Wahren <stefan.wahren@i2se.com>
> +
> +description:
> +  The System Timer peripheral provides four 32-bit timer channels and a
> +  single 64-bit free running counter. Each channel has an output compare
> +  register, which is compared against the 32 least significant bits of the
> +  free running counter values, and generates an interrupt.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-system-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 4

Should list what each entry is.

> +
> +  clock-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@7e003000 {
> +      compatible = "brcm,bcm2835-system-timer";
> +      reg = <0x7e003000 0x1000>;
> +      interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
> +      clock-frequency = <1000000>;
> +    };
> -- 
> 2.34.1
> 
