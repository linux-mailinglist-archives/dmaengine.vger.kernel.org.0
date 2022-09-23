Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE945E719A
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 03:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiIWBy5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 21:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIWBy4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 21:54:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C78F3B966;
        Thu, 22 Sep 2022 18:54:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q83so9258303iod.7;
        Thu, 22 Sep 2022 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qsPvYmg7jnOoMPiYWFtL2rAhyiJL8CXDGyIJq8ULqQA=;
        b=E8tyZ6ZvnVdOLsPdvkpBkA4DbpCZYoZloBmC6p4KxUZ9Uvs4zVqZnpvVmBF0X+F3xV
         Ogu/Isi4MEySiMoXRU+P2q53e8zYtjSWk90TVG5fpTq+vOqanxorGFAKjjZZteHDulSs
         thUdOM+OZ1VVy6Ayr1orZKyb0kMro8UYs9Jjxut53bSbV/G1kmPH0c4o0xSKsLaweK1/
         kwFu2eP313ghBHszZc74DZjZ7hXEXdH0EcsTxaGYpX7fnDnIMslUwoO7LV0ffNTG3BHJ
         QwBkXpq8PAnJpmcvZRUo82DSenAkOzdCB9XY+n8WpInsRcPSru3YCsFXtj6a9u3HbaXI
         Yt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qsPvYmg7jnOoMPiYWFtL2rAhyiJL8CXDGyIJq8ULqQA=;
        b=EGu6L7JQfjhwO0Q9rgFMMTldKtuLSG0/gKIqqbioc0QnKOXOHt1N0wuhjmX7hcO6La
         5/EfLg5zEIWlVnijs7RMbjfQ4Md8HaxUTGQ3D9WD7RlNHgw8Nm+hNfPzIZv/5Xt3jhsX
         vSby8sO/wtmzq0UAhCevix/HTVwGTchP6VHOlN7I5lzgqp4RKNkgiZ+6p9CkoQTLqOe5
         5iAqVr7DvE1RszMIGB3JAD+EIhIEPoufQKeDFCdzBI8eAMQEUA9kaGw7bFXN4jrOj6ps
         C2rGVt/WLh9eO9I/HRiNLjsJseUVY5lmBLhbJC793AasCzHlodAJZ7a1PowWt8bfoMuA
         fo9A==
X-Gm-Message-State: ACrzQf29Ea8b+Bn8cY1jOunvn/U96cGqFgSUsotlAj0+BqvA0AcblVLH
        WX6/tCGZTeZBFJsRIvmOd9/Qz4OdqPY=
X-Google-Smtp-Source: AMsMyM6ESV0dXEcAAT0QxgvBMs/LmbX/0UYVefuO7ZmeyfKXtahfIwWdQOYDzr/KNoBB8SQfCskz4w==
X-Received: by 2002:a05:6638:f83:b0:35a:d85:ab65 with SMTP id h3-20020a0566380f8300b0035a0d85ab65mr3636064jal.240.1663898093295;
        Thu, 22 Sep 2022 18:54:53 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1e16])
        by smtp.gmail.com with UTF8SMTPSA id n17-20020a056e02101100b002f5447b47f8sm2626286ilj.33.2022.09.22.18.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 18:54:52 -0700 (PDT)
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
Subject: [PATCH 0/2] SDM670 GPI DMA support
Date:   Thu, 22 Sep 2022 21:54:24 -0400
Message-Id: <20220923015426.38119-1-mailingradian@gmail.com>
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

This patch series adds the compatible string for GPI DMA, needed for the
GENI interface, on Snapdragon 670.

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 drivers/dma/qcom/gpi.c                              | 1 +
 2 files changed, 2 insertions(+)


