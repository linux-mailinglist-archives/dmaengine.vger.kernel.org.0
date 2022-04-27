Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93572511FFE
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbiD0QUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiD0QS1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:18:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144B50453
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:14:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k23so4423632ejd.3
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33Pw1TaQn5DJlFIc1RoNdUwlWVagDgJDIvDiUBnvNZk=;
        b=U51HSzeI8HGrI9NW83Hp4A/HI9mlfDf9gWNfiNKk/K5DikSp6yPBh9cRt0ThUgQLs5
         hViq9bNgsMfsiWdf0Y9GUIl7ZuI+y+wmDZx3ZvVmKNzJmTNsbsyLxrug6utarW/ohtJ9
         zleu8j3RsdrBjyVQ8GAyarmF8WaJF2M/XN9IMxJEgKcXWHQxqTRCcZ9bQOfOiB8Q+qOR
         wIocaBdam+6CnrsiiqIoJh/2BAOiElgLf9XCuxzS90CKQBNTdCII/IhMDzMHgrelfQqf
         WqKx/ZPGMi0D+Yzsrj9otq3yckTZ3NGT+DMrL05QGWtHOjnDKUiWUT2RQCb0R7hPTYqA
         FngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33Pw1TaQn5DJlFIc1RoNdUwlWVagDgJDIvDiUBnvNZk=;
        b=w5oweu2hoDEsCFV7pAQ6oC/7wm21wF4G0B2u0lCvLiH3lslBwCYEStmwnrVwOqRC97
         ng1FwvwaBoEB9rNleMtEFGn9h/i9DLg6EhOxUvMNViBlSPQN5vhQb2maz2I5gZJsHtcP
         u1TwgpDD7/DxbHUmHpjsjVGJqwUnDksdaiMBsuaONL2YoWHagiK1RnYLLB4V6ic4Skzz
         njp1kALs0La0YmJSpKan+bKFdPy0y8rR0XuGV1HnhMKVcPFlzUkdJGXVGOL+GEk35BYY
         g1nnolc+yXjd6P8JAbJwe/ula5perTYUMOac8qqwSWlFOJ+//3L5F/Gt76K2a1ZDJJQp
         ruIQ==
X-Gm-Message-State: AOAM530easAd5ZDJzX1TPJGZeZlLTD6u8pmWwvZQUy4U1tzzh+Tn+e0I
        6VqWa82mYoWVd5lHwgKmAJN6aA==
X-Google-Smtp-Source: ABdhPJzmLCZ9Ahq/jSBN3LvwtNKXNXUizhAxyJ5MT0YIi7KkFXLVO91cs4ohgwxLLTG14pPlZFOsqQ==
X-Received: by 2002:a17:907:8694:b0:6f3:8e7e:fcfa with SMTP id qa20-20020a170907869400b006f38e7efcfamr16691802ejc.82.1651076067103;
        Wed, 27 Apr 2022 09:14:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm8583383edu.44.2022.04.27.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:14:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dmaengine/ARM: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 18:14:20 +0200
Message-Id: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
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
