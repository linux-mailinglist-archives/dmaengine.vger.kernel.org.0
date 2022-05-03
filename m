Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E23517DE5
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiECG6S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiECG6K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:58:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F31FCE2
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:54:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i19so31595123eja.11
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2j9bZn0XiheTEG0dPBdjtpvIR4x4Nm6lvf6UwUpIms=;
        b=XmV3Un9CG36Y1XOWmm7jcgdJ9iZMEtsMcrS2TR1mLYk1OA12Fw1lwXw1IKGgUitkPu
         gQQNx0fk7VW6el1XA/2yURNtmjX0VhdgdlogEnFOHBDqDOYA+3WQg//v2PeBL+lVlRHg
         THDEU6advN89pxFV2vKLuQd3iiHvjw+yJRjE+cTWtv6+810XDEYUqfdSxkF67fYj0IsS
         NxUSWZSHUM3YMQe97bZBQd9FtGycr9/7I5ygmLB4kBiPdGp086S3K5+SsTz8eMAK2CP+
         oHo9r+XnQU27hg/BeEJAvlDne4xm2h32w+14vGOOKWUsJOtOD6q0QK98qSsC+tj5j/E3
         6f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2j9bZn0XiheTEG0dPBdjtpvIR4x4Nm6lvf6UwUpIms=;
        b=IhLbW3UT6fniG36yFvRnGorgRoHKv3NChIl2etypUjQ37kL6AZm6QnZBvghtHyl+cW
         pTAGSrDdwIygPJKDqz8Bf8nVfDo456GGI23IZLlf2sbeO+arLv+4AMSrjaiVye6/1mpW
         pp6/YPZCE5xqOY74sdOaJY7Ckj7hjrb2iyzvcv4uRzsMMukh44RIOg7/3P6vMG9KBJjl
         dZoufB+UYlEGTZVw7o6rrC1L7YDhrTJMpsHaxwsDDdiVSROSyaeCihpPxAcEOhfFhLlR
         Kc6/SLLLrkNOVkf+I9cgI/OWUN2ErNkjGCgiDsZHwYxbRrtQclFJ7NFI39SmgzQUOPvu
         UShg==
X-Gm-Message-State: AOAM531/aZuuPl/1uFRbi4p92DFNsAmbBMQcFSAFaU1zXNbbxP+dn/Hy
        kxq0zJJhu3cRZ7D2cLdYqFztxw==
X-Google-Smtp-Source: ABdhPJzplNOTrSF1JeGrkh5bkMlcKzuVJhqRt4/tSoTRoa6Glquh090ttyEadJCj+wfH6MVMR9icug==
X-Received: by 2002:a17:906:dc8b:b0:6ef:86e8:777 with SMTP id cs11-20020a170906dc8b00b006ef86e80777mr14743860ejc.326.1651560850833;
        Mon, 02 May 2022 23:54:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0042617ba6396sm7565326edr.32.2022.05.02.23.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:54:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/4] dmaengine/ARM: pxa/mmp: use proper 'dma-channels/requests' properties
Date:   Tue,  3 May 2022 08:54:03 +0200
Message-Id: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

The patchset is bisectable - please pick up through independent trees.

Changes since v1
================
1. Keep old properties, so the patchset is bisectable.
2. Add review tags.

See also:
[1] https://lore.kernel.org/linux-devicetree/fedb56be-f275-aabb-cdf5-dbd394b8a7bd@linaro.org/T/#m6235f451045c337d70a62dc65eab9a716618550b

Krzysztof Kozlowski (4):
  dt-bindings: dmaengine: mmp: deprecate '#dma-channels' and
    '#dma-requests'
  dmaengine: pxa: deprecate '#dma-channels' and '#dma-requests'
  dmaengine: mmp: deprecate '#dma-channels'
  ARM: dts: pxa: use new 'dma-channels/requests' properties

 Documentation/devicetree/bindings/dma/mmp-dma.txt | 10 ++++++----
 arch/arm/boot/dts/mmp2.dtsi                       |  2 ++
 arch/arm/boot/dts/pxa25x.dtsi                     |  5 ++++-
 arch/arm/boot/dts/pxa27x.dtsi                     |  5 ++++-
 arch/arm/boot/dts/pxa3xx.dtsi                     |  5 ++++-
 drivers/dma/mmp_pdma.c                            | 14 +++++++++-----
 drivers/dma/pxa_dma.c                             | 13 ++++++++++---
 7 files changed, 39 insertions(+), 15 deletions(-)

-- 
2.32.0

