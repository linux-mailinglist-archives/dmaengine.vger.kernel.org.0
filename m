Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3073BAB9
	for <lists+dmaengine@lfdr.de>; Fri, 23 Jun 2023 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjFWOwY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Jun 2023 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjFWOwK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Jun 2023 10:52:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948312697;
        Fri, 23 Jun 2023 07:52:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8fe9dc27aso8209105e9.3;
        Fri, 23 Jun 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531922; x=1690123922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iOE+y1sXG5nrn3kNA5b5DrRPO/GVLVSpD3jOxlyNFQ=;
        b=DvQSlFLcBm5olgkNY7zJz5aWmId4wuWKeB9dokUbMzLFRiWZ0Qu0MVKlJd0GVKQgFU
         mI0KNMSrL3sZ3QujGo9i5U05tcdjAvvaDIt+f+EPdhPpU7UF9UhiwCrEQTUr4COXxk1A
         xlD0yMGT7+lOIoSS3LPy8CHl1ee38TRTMMuY4CvW3kOuZM3h4Z9XmhUD6BkXXdraNpQ4
         P2TWShDz5xsgmuUZcnMfoMgqCXfFggysp94cNocM96SnM+zQ38ZoUfJb0Qg/2tqXdcKW
         QeUzdWlTUg2xMdcnrINxKeTSvmy4kXN/skVaunGrILvZ703rWBNuo4NWQ2ftuoS3shbu
         E1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531922; x=1690123922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iOE+y1sXG5nrn3kNA5b5DrRPO/GVLVSpD3jOxlyNFQ=;
        b=Y1AKw6muttnVukJuPaBRiTgqEywJhabONNWxr2FhBRC5Y3cenbnLCBZ8vCTGCi8Jkc
         JPkPZvbpQJFVei0Z31P3QewM1hkR05CQm+4Sf9C6wPhfbtl8c8NDrF3bX4TsJC/hsop8
         xmU+bLplsxEBX1LYSeWFTSUymN7wSzer8l2p+b/++DMlRFTeUS5r/cBAjFW/+acmPZW/
         I+q89NtW5pfFKM+5UZkTYLUDF1Lqb3cPbp0IlVoBbgzo9dS0J/3/qWjo85uJjtN1b9Cp
         Pdx1jtWObuj9QiBVP8q8wzJLgqGdxmqYu5eFm/CP8vJWjSbqJHIrooMH+bemlJrNEpfF
         x+Cg==
X-Gm-Message-State: AC+VfDxAcxNyDIwKgFCX38oLI1ldCa/SAoJMTNgntrxtRE79kgOsu5V8
        B8OUYSRtBN2jhsT95w1RFpRGov8Ix5M=
X-Google-Smtp-Source: ACHHUZ78J6ASZEekt0tyLQI8sa1a1/efYh0IK+B/8OLt4xVqG4uMA7h6L91vazAuWsNBC1pb/nY6Ww==
X-Received: by 2002:a05:600c:213:b0:3f6:91c:4e86 with SMTP id 19-20020a05600c021300b003f6091c4e86mr15671730wmi.3.1687531921870;
        Fri, 23 Jun 2023 07:52:01 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c224100b003f9b44e5b7fsm2545390wmm.46.2023.06.23.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:52:01 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: (subset) [PATCH V2 0/7] ARM: dts: bcm283x: Improve device-trees and bindings
Date:   Fri, 23 Jun 2023 16:51:39 +0200
Message-ID: <168753171985.1191890.2010823187252640169.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 17 Jun 2023 15:36:13 +0200, Stefan Wahren wrote:
> This series fix some dtbs_check warning for the Raspberry Pi boards
> and convert 4 txt DT bindings for BCM2835 to YAML.
> 
> Changes in V2:
> - drop already applied patches (bcm2835-sdhost, bcm2835-thermal)
> - drop patch "dmaengine: bcm2835: also support generic dma-channel-mask"
> - keep brcm,bcm2835-dma for ABI compatibility which also resolve
>   dependency between patch 2 and 3
> - drop quotes in patch 2 as noted by Rob Herring
> - add interrupt description as suggested by Rob
> - add Rob's and Uwe's Reviewed-by
> 
> [...]

Applied, thanks!

[4/7] dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML
      commit: 92554cdd428fce212d2a71a06939e7cab90f7c77

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
