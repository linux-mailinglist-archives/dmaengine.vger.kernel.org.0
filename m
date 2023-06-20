Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE782736EDC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjFTOj5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjFTOjs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 10:39:48 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E71BCF;
        Tue, 20 Jun 2023 07:39:29 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-77e3a44dae3so104203839f.0;
        Tue, 20 Jun 2023 07:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687271947; x=1689863947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I010nMgK8kG45jUUX05j2M4inOliG1MEyiqePq5AePw=;
        b=KeDLaIaeHsI313We9glGLv2yUC/LuOMBhTaOUiLUIGE0sVt8l4fltvpB6Su2QCnCMJ
         wLpKKJWNXcsryNqAnYIM9bAq2KN+ctY0rA+csn8/QG79e3n6Jg5xIZciSrQNeY4aq0Kj
         ggTaOqv27aUFzR+Wvx40PsMXaTSOEbvVI1CdQsSPzPGJ/3KJw9UI3fF9dnQ0F7+jMgvk
         m0xpAY+lzuiBC7ba9DJz3C1OccJWM0dZ/4IlBUnI7ZcYZAVE4ivsUfdDe9fPkeDHGoUn
         PzVm+PLZnnS132nOXluRP++kT/OCxR+sbPqBFB8UbXnVRoNi1lxt9kCoZIPPh46e/wtg
         nlmg==
X-Gm-Message-State: AC+VfDy86S0B1/pl28KFV/xEmE0ocdm2XtfZEUQRC6l7sdkJJMKdwme/
        l5K7l7ntzYRBBpFV87C+wQ==
X-Google-Smtp-Source: ACHHUZ6uRnQAz9zY56zQa7xBNoYaLlKDsBB4HSYnSPp6s4hYW875BiTaMxSTTgH1xzL0OErdZO57AQ==
X-Received: by 2002:a5e:8f09:0:b0:774:84b5:cb77 with SMTP id c9-20020a5e8f09000000b0077484b5cb77mr11934684iok.18.1687271947188;
        Tue, 20 Jun 2023 07:39:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b9-20020a02a589000000b00426750059e1sm687386jam.26.2023.06.20.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:39:06 -0700 (PDT)
Received: (nullmailer pid 3559325 invoked by uid 1000);
        Tue, 20 Jun 2023 14:39:04 -0000
Date:   Tue, 20 Jun 2023 08:39:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-mmc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH V2 6/7] dt-bindings: mailbox: convert bcm2835-mbox
 bindings to YAML
Message-ID: <168727194116.3559200.9557415679850510683.robh@kernel.org>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-7-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617133620.53129-7-stefan.wahren@i2se.com>
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


On Sat, 17 Jun 2023 15:36:19 +0200, Stefan Wahren wrote:
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

