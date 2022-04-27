Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4C512121
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiD0QUl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbiD0QTU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:19:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7051E76
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:16:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a1so2537247edt.3
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33Pw1TaQn5DJlFIc1RoNdUwlWVagDgJDIvDiUBnvNZk=;
        b=M5wZsoVmuMrbDmKmC++nJ7daqVxdtD6VRJyTfHXnb4KhMQRLFAkqT9TNx300qMM1OE
         24O7eNJCzbyPJCyDr2CrhlMnFFOWD2z3VPhJlER1XVr5Bcj8JGCzf3QWIr1LzEX+yuTq
         Uh0RrLxtTaQCg5y/W/5zS165UdNwsDoIeJfLpf+VBophS6N81i9C+aLb7EUX93xR1x+d
         Yu4cVfLiVHN2OxCFd5U3dlsKWYxjKZa1pmcCbhARUiflq86EJiPR1yWaMfG4DPpQoq6Y
         UykiFMJKA0Zot57+0c0IEGwU6gbKCVGUaNdbvhRzmX8hS6RGZHA1slYmQPlBV2dffbgy
         EFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33Pw1TaQn5DJlFIc1RoNdUwlWVagDgJDIvDiUBnvNZk=;
        b=oijFj2I4Z0Q7xkKKmd5mhWEsCuaTeVWe+8IKENH2AVcb1DqZ1LhF7vmUepYEE1OHPD
         YgssEZgafGL/vXSYaNuAk2uR7NcCKRNajjircBRUGANXRrMymePU0Pcj1CLobZQ3O0GM
         r0S1NYVP9msYXpAdqCTpbYuWgYNHgolmR0nJBX0NyZHKpKg8UAyw569xa0f4MJQkb836
         pAckbLt0x1hOk1STa5u9DkcTB3uA/1shpt3OW3nU2vH2tpXU5yOYt61UN0XsAsIkIESm
         zu5qFKdDeCIwVRZ0XSSkfKaqCGAKmPFxfhfm0acLrEKdSYjLEW9XPyk01Y7aT0H6qowK
         SsdA==
X-Gm-Message-State: AOAM532WLV0q53Muei+9EeMliP3Qf4P+9qtZF/ludQYvLLGTcBNPtEg5
        6tUrCheC9Py6ybVPssHYIQDapZ09RsG/pQ==
X-Google-Smtp-Source: ABdhPJwtXtQwHMNqbnYGky888kJnbA0Gsd9ufcKCpT9OI5JJpU0hsvaPMD5dKZGuDOi70nXTqUQKfQ==
X-Received: by 2002:a05:6402:84c:b0:423:e5a2:3655 with SMTP id b12-20020a056402084c00b00423e5a23655mr31479642edz.28.1651076139601;
        Wed, 27 Apr 2022 09:15:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709064cd100b006e78206fe2bsm7131192ejt.111.2022.04.27.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:15:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] dmaengine/ARM: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 18:15:31 +0200
Message-Id: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

The core DT schema defines generic 'dma-channels' and 'dma-requests'
properties, so in preparation to moving bindings to DT schema, convert
existing users of '#dma-channels' and '#dma-requests' to the generic
variant.

Not tested on hardware.

IMPORTANT
=========
The patchset is not bisectable! The DTS patches should be applied a
release *after* driver change is accepted.

See also:
[1] https://lore.kernel.org/linux-devicetree/fedb56be-f275-aabb-cdf5-dbd394b8a7bd@linaro.org/T/#m6235f451045c337d70a62dc65eab9a716618550b

Best regards,
Krzysztof
