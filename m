Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0A777548
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjHJKCF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 06:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjHJKBa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 06:01:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BF270B
        for <dmaengine@vger.kernel.org>; Thu, 10 Aug 2023 03:00:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe5c0e58c0so6652175e9.3
        for <dmaengine@vger.kernel.org>; Thu, 10 Aug 2023 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661608; x=1692266408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8XAqj3aGEtdE6at3bi6u1wUfJ6SEiB57bY3VUBfMBk=;
        b=AG6E5H6ARz4vDKIOAGnjdR9hy/OpJScVKRNmRp3Wrzato1I1GaRyliztyM/u+kxjBY
         NmapSqKcXSoGm4VRp5Bcx7OJHLVjwwxBuukJVIk0b/vHRCab8t/Bn8ksmpXzDkX5dDUO
         zkXPpery89e86DPj6aaoNVZx4gzyUXgW38Kam9l/bdVqlE9ZgzxZ9II0vsMcW31uI6TM
         OZ9g3tH8ci9G3OqQZZwzh+r9405im+nwFmoPnZwXaOnz+Of/KRnmTTk2bZw392Q2BIdt
         kcW0UgPFOMEx7iM1iBmfMljPLuDIJ7STqtz85oHazTk8vwf2KM7sjOG/tfyST0tvphNy
         nbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661608; x=1692266408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8XAqj3aGEtdE6at3bi6u1wUfJ6SEiB57bY3VUBfMBk=;
        b=StqiYlY4PJj3Q2JqfPZphz/ITh9QM8TnRfeOlmZWda54GHcLVeVXwQtAOn7/apj9ch
         gOdBO+wtYdNH3eCeMbbJ/UeQEKirXEg3l9dlY5MpKtJmlVGMHN5RBhEfioGuf9ZXJhjp
         JgNOm0sta+guMLpVQpcC+5aNxpfFf7LLo2psgJrCqKCE6NcJDXbFIBDmeChW5NwBf6Eo
         mngSBFifj4Cc2awGzwxnSf8Fv3Z0vnE4nisrxL0BR6qSEHG4LNsk2Aeki7AGrrV9K/Kp
         efQVQkiZCi5PTeOUol8cD4Cc+iM+E1sqev2EXKeAZ5toQJufdFV2ydeYzAPG9VPATVCE
         Ft+g==
X-Gm-Message-State: AOJu0YzOSLLiaIJeJBjhTKUp4vz5+ExULQfKM+qQ9I6M4X0PrzAj7/94
        jcn0CsvQ5OR1bKP9w9ypgJ/DtK5Y9dDwGPj4idk5Kg==
X-Google-Smtp-Source: AGHT+IHliYy2HqHHgp/KIkQzMp24rK41dN7k1g4MIPlcQ9M6boir9waqqJgGDx9oq9DBIp3zWCJsbQ==
X-Received: by 2002:a05:600c:c3:b0:3fb:c9f4:1506 with SMTP id u3-20020a05600c00c300b003fbc9f41506mr1548236wmm.1.1691661607672;
        Thu, 10 Aug 2023 03:00:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm4498953wmj.43.2023.08.10.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:00:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dmaengine: mmp: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:00:00 +0200
Message-Id: <20230810100000.123515-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810100000.123515-1-krzysztof.kozlowski@linaro.org>
References: <20230810100000.123515-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  mmp_tdma.c:649:10: error: cast to smaller integer type 'enum mmp_tdma_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/mmp_tdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index d49fa6bc6775..52b726fc5f04 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -646,7 +646,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(mmp_tdma_dt_ids, &pdev->dev);
 	if (of_id)
-		type = (enum mmp_tdma_type) of_id->data;
+		type = (uintptr_t) of_id->data;
 	else
 		type = platform_get_device_id(pdev)->driver_data;
 
-- 
2.34.1

