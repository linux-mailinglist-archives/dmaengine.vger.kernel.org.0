Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3628D72A5AD
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjFIV4C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 17:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjFIV4C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 17:56:02 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E02685;
        Fri,  9 Jun 2023 14:56:01 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77797beb42dso97113739f.2;
        Fri, 09 Jun 2023 14:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347760; x=1688939760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQKWu/Nmn9JuHRIqTO0O6TLbe/AqUc7TFP8t5cgdkFk=;
        b=B4AqrSWVUm9yweC4pCeqxPI5Y/943uMUu3u1a/bi7vlL1SzLTI+/PC77NQz/D/HeR2
         ljKX9j5mLQwqfIGS1k+FhSKe6lqNPQIqiYYtOQvl9pru0Qp1UlI2L+Ye73sbtrMTuPbO
         rU1FVz1CIYJnmG85lH7HfAHLG5j8SuQ6eFTCEe2D/XBPoEhq3QvWr2rPgEBgTvDtC2vK
         8AmLk7v4g5svw/EhD73eaJLX2n4T/vs8nyI6yKgMoSqi32a6NdVfXo2fXgDKxumUq4xA
         JJWJgRZJ91P7iB0dWcRz2FCwTELFrew7+ThzPitvQZDQGER5M/ukJDp/8BrFz7SPrmiC
         FHvw==
X-Gm-Message-State: AC+VfDzg4nJHx3flCg90m8nneUcJOvDM+wV71pzPUdDvavrrY7B+1Grc
        EVMDoLEVghUKruzMkOelTg==
X-Google-Smtp-Source: ACHHUZ72Z2NSeyntgkWsQ8058OasVu4mqJoKjNA1pG0m5lCpYEU8gqN9EnkF4PcmvXWh6EySCfaTRA==
X-Received: by 2002:a6b:e801:0:b0:777:b1ac:30af with SMTP id f1-20020a6be801000000b00777b1ac30afmr2737102ioh.12.1686347760412;
        Fri, 09 Jun 2023 14:56:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b8-20020a02a588000000b0041ceadd5f4dsm1198423jam.70.2023.06.09.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:55:59 -0700 (PDT)
Received: (nullmailer pid 2530251 invoked by uid 1000);
        Fri, 09 Jun 2023 21:55:56 -0000
Date:   Fri, 9 Jun 2023 15:55:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mmc@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: pwm: convert pwm-bcm2835 bindings to
 YAML
Message-ID: <168634775597.2530196.7706723373983160654.robh@kernel.org>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-6-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604121223.9625-6-stefan.wahren@i2se.com>
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


On Sun, 04 Jun 2023 14:12:18 +0200, Stefan Wahren wrote:
> Convert the DT binding document for pwm-bcm2835 from .txt to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../devicetree/bindings/pwm/pwm-bcm2835.txt   | 30 -------------
>  .../devicetree/bindings/pwm/pwm-bcm2835.yaml  | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

