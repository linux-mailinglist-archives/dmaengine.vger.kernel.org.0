Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0572A5C0
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFIV7j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFIV7i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:59:38 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7442D44;
        Fri,  9 Jun 2023 14:59:37 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33d31ab00bdso9516575ab.3;
        Fri, 09 Jun 2023 14:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347976; x=1688939976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeH0FgQbPzjFMjec9bTg6Vy3JBH6ycxdjGfPGI1drbw=;
        b=fWOd4zjsbIUd7YMsKSr7DghBZs0l7IL9O5DysZt/hO/Wr5yTNp5sR1CV8hesIkOfjz
         kJQzhM110sR74m7162RdsUD1zUmPdaO4Kr25Ch8uH67+Z07lX2JzT7UqIz1p+J4T6bcG
         enKQozB0Os1pP8qi6cRWUyDoj+65z1fnZtmvvlilI5QAZEp7LuBaCg8h7X9nZX9s521F
         4Pcs40SGRhPbjcmEs46K76fb/CIR88dCcAazDHC3Nq19QbK1gNZDYEfidKKLVv8gZFBv
         oWU67LprLdaiFQi81k5rSS6cCfrYNEZCwAgGYKxoiGdQBHnpBN5Cf8DNC4YrvBo+TiZb
         IaOA==
X-Gm-Message-State: AC+VfDxTxi40LjHMvmnar02vQP3/3tqmc7sn77AJT0kRnC6pJzy0hGWs
        iY67aHG8iYiZfXI/GwtCiw==
X-Google-Smtp-Source: ACHHUZ4yP9J3MJ3khMT45lJjiw/B2z0d0ehsYF4KdCeyTkSFdWMYKb5dZuDzQLqGRf0QCa6siO5NOw==
X-Received: by 2002:a92:d941:0:b0:33b:1fe1:9a84 with SMTP id l1-20020a92d941000000b0033b1fe19a84mr2254551ilq.21.1686347976577;
        Fri, 09 Jun 2023 14:59:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l18-20020a056e0205d200b00331833da1dasm1374021ils.35.2023.06.09.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:59:35 -0700 (PDT)
Received: (nullmailer pid 2534313 invoked by uid 1000);
        Fri, 09 Jun 2023 21:59:32 -0000
Date:   Fri, 9 Jun 2023 15:59:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 05/10] dt-bindings: pwm: convert pwm-bcm2835 bindings to
 YAML
Message-ID: <20230609215932.GA2531610-robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-6-stefan.wahren@i2se.com>
 <20230607075602.s2pfs7dl7fwkyevm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607075602.s2pfs7dl7fwkyevm@pengutronix.de>
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

On Wed, Jun 07, 2023 at 09:56:02AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Jun 04, 2023 at 02:12:18PM +0200, Stefan Wahren wrote:
> > Convert the DT binding document for pwm-bcm2835 from .txt to YAML.
> 
> Both dt_binding_check and dtbs_check (for ARCH=arm) are happy, apart
> from errors like:
> 
> arch/arm/boot/dts/bcm2711-rpi-4-b.dtb: pwm@7e20c000: #pwm-cells:0:0: 3 was expected
>         From schema: Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
> 
> which is fixed in patch #6. So:
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Who will pick up this patch? Is it supposed to go in via pwm or
> arm/broadcom? (I suggest the latter.)

The default is the subsystem (pwm). Why not here?

Rob
