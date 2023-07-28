Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A160766E08
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jul 2023 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjG1NW6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jul 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjG1NW5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jul 2023 09:22:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F813590
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 06:22:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso14814355e9.0
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690550573; x=1691155373;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t86fEk1B48Jhf5PGXA8uJZQumipRoCPOJsUE1d8YRCM=;
        b=I5pAB+18R2+dx1wq/ZGauDPjeDbH0NfpPC5bHPSwYGWvSKcCsgREL+dEaLCCscjJfX
         faKocywBv3vgb/20PmviQnUnE8DF4z3yPJmwjGLszgYFmNSSAxqx4DYhC112fmIYJZSJ
         50bigVm9HhJcF9S1kJJaI4DQqkjLhamBTF0ndwqDaTie7cYu+eLJ4lQCm5t7wVN52jeH
         fTMla8zNu0rKI1FL4cD88rY/VUEspZp9wIL0U4L6CwzU3cw7+MNy4OA/MgNFK/5AKiD/
         9FGB0CxuLDbUYogCp5O9jmTd2+rW1yzlE06cvKtjGe76zsFSi9Cx2+I5wFaQEHsRMihe
         a3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550573; x=1691155373;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t86fEk1B48Jhf5PGXA8uJZQumipRoCPOJsUE1d8YRCM=;
        b=LYbi5OckuqHefQpVPpNNAPb2OqdqHI6cCqXeu/O61BfrWc24CsJmtnmw4EsrZVr7J6
         ZkFcNdCiOD1K+V1WIp/TPcVhGC2yM4hN8YIkNB7Wly2xAsEQqTbeAgDnmvjAbOiR/rAx
         sZXNzBM5SAu0HEiByDg04e74fRlaCvZvdYU5TVqYCFQjhiBnyO3VUUGSzdp6U4iX//nf
         +RU/QWBuSsUijr83wL/ih1TXq8tkiHwY8zY2IgEp8BdtMylX0px9Sqr94OJoDqucxnyx
         zuqpMkTsB5mzLRtDTKmMX4KUxgO0cEBtAXD8dq1Ld/yOwfSpIhHS80YyyBfjf1uV9nAy
         e4EQ==
X-Gm-Message-State: ABy/qLawvhR2vGhpSZob5OdAJI1u1S3KXP3+ctiSWjT2Jnp7toktfhVM
        IVIiB1mJfrkr1m3KC6k480MDmQ==
X-Google-Smtp-Source: APBJJlHImMAVgco6lnO2EZ30XvL84WDSKwCfHrqNfAxxnVJY79gWRp11k/XtM/0DucWy4yuI+ySlKg==
X-Received: by 2002:a05:600c:82c7:b0:3fa:821e:1fb5 with SMTP id eo7-20020a05600c82c700b003fa821e1fb5mr5010086wmb.5.1690550572892;
        Fri, 28 Jul 2023 06:22:52 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003fa98908014sm7009317wmp.8.2023.07.28.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:22:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
Subject: Re: (subset) [PATCH 0/6] QCM2290 compatibles
Message-Id: <169055057157.6557.3890207774670962574.b4-ty@linaro.org>
Date:   Fri, 28 Jul 2023 14:22:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 14 Mar 2023 13:52:55 +0100, Konrad Dybcio wrote:
> Document a couple of compatibles for IPs found on the QCM2290 that don't
> require any specific driver changes
> 
> 

Applied, thanks!

[3/6] dt-bindings: nvmem: Add compatible for QCM2290
      commit: 4b71b2a44d7d692ae681961a9b2865724652d1f6

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

