Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9317511F12
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbiD0QUe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243129AbiD0QTI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:19:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C21F0352
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:15:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a21so2544384edb.1
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33Pw1TaQn5DJlFIc1RoNdUwlWVagDgJDIvDiUBnvNZk=;
        b=KBFIVEnWblYCxpnt3WT4Y8eMe9PkeYJB6xCwCQsx3vHrzQwnh0SSr0tGYUWZ0VC4pf
         PEhe1IYK2wbVRadKoZxSpivcBCqUpHNns55tcv+HDGM9e6ipYJXVK+k9JJ3BAHnB99U3
         rZwvIothTa4Sb1uAoxR6sWKowZiZwZ9E5KMtwKaUHDRkDfpEJt1xLjg+dRVJOghDQbqk
         ICovlOyXa66C6imGIJV4ijfxMv02TxNH4zzWFkiV7FS8UlNDyOeVw3PIzQBavOC4sklA
         IQEi9h2fkDIVWEoIXbFCe8Syf71MPkwy83scWZSPnEYkN81/XRm3koh8oqNRWFgQZfYY
         dBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33Pw1TaQn5DJlFIc1RoNdUwlWVagDgJDIvDiUBnvNZk=;
        b=Kfue61U/kBGxlFAJtHcmU5gYUXq2JvlWDOS3L0agWnQlRpiTP0rc7qvdlvNtyZSur9
         VcFcY4KiBxI60NLKprA4s5NVVktbqK31m1Ijlwome/Ba+6hU1duie/cldqhnlrB4IG1C
         y/Vah3Zv5MCHlON8aOO0/mbQBfmBIXcD2/xmzTTcvWqvq3BpHhKvEvFjqDPxTEPehAEs
         o+umLIJbiSf2LUc6qfHvqn/sn9qy3iCPRTiR6tiGYy31xlorbeL4TVl4F57MQwryi3Ay
         L1V4QK4ag1i97BDFfWjXWN2m1h5LisjlW+6Fj0w6mS85h1qKnNuLgoFeNFKK72aMbSxb
         2oEg==
X-Gm-Message-State: AOAM530C7e8fxioNxc4z7IFlm0udb6jCD8sRXI3J567DVarEU45fYP6b
        571fBx6L9w/T2U3dCH++TBwyPA==
X-Google-Smtp-Source: ABdhPJxU1HKHPnvWXqc0EyS9UL31RUccYlh51grYI5WLFL56IHsq8W2ryIxgDCrYNsLhDMqzjq9pxA==
X-Received: by 2002:a05:6402:430c:b0:425:b084:6141 with SMTP id m12-20020a056402430c00b00425b0846141mr31482367edc.67.1651076105678;
        Wed, 27 Apr 2022 09:15:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm7095015ejd.11.2022.04.27.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:15:05 -0700 (PDT)
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
Subject: [PATCH 0/4] dmaengine/ARM: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 18:14:55 +0200
Message-Id: <20220427161459.647676-1-krzysztof.kozlowski@linaro.org>
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
