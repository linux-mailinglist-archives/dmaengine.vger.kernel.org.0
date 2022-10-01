Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66565F1FB9
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiJAVTo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJAVTm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 17:19:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B27DC2;
        Sat,  1 Oct 2022 14:19:39 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u10so1929161ilm.5;
        Sat, 01 Oct 2022 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=om1GcEIyYHdAjslVkRCVb4S8CzbSl6NxZMlPM84vTm8=;
        b=bK86Rk7aVgCQcYOvQMtNkwPKHvIi41WtY77mAg58oFNUqYxKlPdwGTUh0ZsC1ZC4vu
         7W2zKwWdvD6Cc6cA6vF42+eh2bekkQMRQmQBO4FzqQc2YD3RXFX9cVWRkDwH5Jz5YkTy
         t2NZne2HsE/BH5lpNA1mzY7ia87zeobBiYHxxoH2ERO3VzlEB5i4pWLmVSX4lrV08dq0
         HoscbtmSnZIXQuDKWeTa3rkbU6SV02TFioG/HsNoM461xYhfC5lELsemUDU8kkNBDmCb
         Rw1ZeEGUm/LDqO/c0jW5wwe71ZN/rjVXOz8AGjYysbCbKXOIP2ncSODqztTxPpR2KoNJ
         rukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=om1GcEIyYHdAjslVkRCVb4S8CzbSl6NxZMlPM84vTm8=;
        b=btQjRu9MomcskF3GUeA6ElylLFhrciiLOyn8AC+yUOmqkfMBtcK+NqhAGo71oWCJiO
         5xJq3qfZmJTmlCGvUizNXGDFkh9JSPnTqT6YQHmHt5KMbSICvxqapxYyOkhK7W7dcKPn
         DcKrXGsgMg5X7nuASTFCuFJRjLFw7/wWNC7LYjQVbMa/eeQe1G5rUoDN1ytiEyMjgNW7
         iDdfbhKY6+ARpvvJ9K+M1i2Ye29jkUTOksf0d9r9aWjXPg+sP1ccGudLMYXxtx+VFhur
         A5Jja6lZyd8opJwzW5qISXW89O9AuYHiqrj489mMJSY3hGnjd31gjjH1l/yE6mX0+RlY
         2FnA==
X-Gm-Message-State: ACrzQf1cQzbZNF8bojHn6rtg/VTXdWjQC7j9/qvVGSiyQBtsgkWGlMon
        8JIOQeVQgKd7n4jSV7GY0ZoVs+1m4fYXKQ==
X-Google-Smtp-Source: AMsMyM6IeKGMHMGmUd2Kd4xjtP1x2jBqtf47dUBO2QwBC1VBxUNFKSjmik2Je2qwwnixCHASaWRimw==
X-Received: by 2002:a92:6811:0:b0:2f8:f381:1bd5 with SMTP id d17-20020a926811000000b002f8f3811bd5mr7050192ilc.145.1664659178350;
        Sat, 01 Oct 2022 14:19:38 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id c19-20020a023f53000000b0035a274c8030sm2448962jaf.44.2022.10.01.14.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:19:37 -0700 (PDT)
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
Subject: [PATCH v4 0/4] SDM670 GPI DMA support
Date:   Sat,  1 Oct 2022 17:19:30 -0400
Message-Id: <20221001211934.62511-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Richard Acayan (4):
  dt-bindings: dma: qcom: gpi: add fallback compatible
  dt-bindings: dma: qcom: gpi: add compatible for sdm670
  arm64: dts: qcom: add gpi-dma fallback compatible
  dmaengine: qcom: deprecate redundant of_device_id entries

 .../devicetree/bindings/dma/qcom,gpi.yaml     | 22 ++++++++++++-------
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  6 ++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  6 ++---
 drivers/dma/qcom/gpi.c                        |  4 ++++
 4 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.37.3

