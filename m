Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEBB5F8017
	for <lists+dmaengine@lfdr.de>; Fri,  7 Oct 2022 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJGVgs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJGVgr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 17:36:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85F10325D;
        Fri,  7 Oct 2022 14:36:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y4so23756iof.3;
        Fri, 07 Oct 2022 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJYDNQrhpVfjyR1ECOTmtg0Nixsc0Ua3wj1lk5aWA4c=;
        b=oxzNv250TYErVPM7OalkjcJBJrLLMTpJUqh+WUNw5ElpT+j8ukOb5mZOjneA87HXtm
         y11mznrbpe+UHNpSpiOvFVqEtTpyyziVb4hqFwt3u9IZttoEOrY7xgis5g9va/D0dBO/
         x/MVTx1knPKm0gGZb8rAZZAheYz7Isg0ijpthXmdUju8m4cWgfGkPNZSOryW0ZZBWJcx
         O2RrEGO2jA5I6Hjzu02V6V4Bq9g7BBH71F4yITkcZAhdntplmtJDvSMpbQ1MhOLfg8/l
         4cNmk7thvivz5z+r3RppHPN9FnXCzYBeXVv7pmoqbi9noFb+ohezbh9dkN5UIv39WczK
         Xjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJYDNQrhpVfjyR1ECOTmtg0Nixsc0Ua3wj1lk5aWA4c=;
        b=x5zrTjSOWe2jH5G97B1xOpwAY85R8zd52atCyjpK5Wg59oRi7QPhRIyGUfTpWXnRcl
         shNW2re+7qGq9edtHIh5IB3Sy7scEygXU0+Y208L3zMypX/g0E9nSs6d1f7QUkjRONAF
         VxNui/qWz3Y5OIIH0A+K6OKXAHD4/kJNUWp4aqFp2zoqSukT8qumCBsDCnNXT0CO/vml
         RhbCOb1Hba9AGxXif1s7ZSbNqReWMSEsk00VOXSRRPYBcMvpl6I6e0XmdZCUmqJze7Ec
         aIor6n/3S5BMw3tIf+TCt+IXbgoRV+POZCrmJaWHri/wn3+IQbQ+A/aA9cN9jd3E1Ybp
         LDqA==
X-Gm-Message-State: ACrzQf1OE+/gLAHWUG0GpiDYh+1pgQyjCOC+nN8CcwtokkorUjjPaf5t
        5FBi2IisQ72yI50NlGwyFjZfwhOF/CQsfA==
X-Google-Smtp-Source: AMsMyM7zGSSAHuZai4k+hhS9XIpKJVvZHcr2qAvHVg0pYuZoFdV7XX2ewS+JWEQ9VWKoyky+SfAwvA==
X-Received: by 2002:a05:6602:3ca:b0:6a4:16a0:9862 with SMTP id g10-20020a05660203ca00b006a416a09862mr3268783iov.217.1665178605527;
        Fri, 07 Oct 2022 14:36:45 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id q21-20020a02a995000000b0035a40af60fcsm1302336jam.86.2022.10.07.14.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:36:45 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v5 0/3] SDM670 GPI DMA support
Date:   Fri,  7 Oct 2022 17:36:37 -0400
Message-Id: <20221007213640.85469-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Changes since v4:
 - drop dts patch (to be sent separately)
 - accumulate review tags

Changes since v3:
 - keep other compatible strings in driver and add comment
 - accumulate review tags

Changes since v2:
 - change fallback to sdm845 compat string (and keep compat string in
   driver)
 - fallback now only affects two SoCs + SDM670

Changes since v1:
 - add fallback compatible

This patch series adds the compatible string for GPI DMA, needed for the
GENI interface, on Snapdragon 670.

Richard Acayan (3):
  dt-bindings: dma: qcom: gpi: add fallback compatible
  dt-bindings: dma: qcom: gpi: add compatible for sdm670
  dmaengine: qcom: deprecate redundant of_device_id entries

 .../devicetree/bindings/dma/qcom,gpi.yaml     | 22 ++++++++++++-------
 drivers/dma/qcom/gpi.c                        |  4 ++++
 2 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.38.0

