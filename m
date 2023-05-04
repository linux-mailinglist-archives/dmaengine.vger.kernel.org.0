Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68676F6E7E
	for <lists+dmaengine@lfdr.de>; Thu,  4 May 2023 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjEDO7c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjEDO7H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 10:59:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33442D60
        for <dmaengine@vger.kernel.org>; Thu,  4 May 2023 07:58:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso767528276.1
        for <dmaengine@vger.kernel.org>; Thu, 04 May 2023 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212314; x=1685804314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8IvnB7h0HAb5+pIi9GxWOAfPdgUl4BJHVh6FYr/ed4=;
        b=kuPcLL3YoUQz+usR6xPzkJy7Qzr+xCOBwv6dT38Ejb2rkKMHl6Kndt9vgn2RH4iitP
         GJzORCEA21O3g7/+GS33g9uei5QHrpLimIHK6fsQUacmH2Ffj7SjKmI206Xa7q3FfAQi
         y0KxVKkNxuqVL/Y5uOl7Vn77LsMWYTuLC9BGNUjEoBMOCy3RNHDuPInha6yTRnHysOvv
         87lKZJwjKlaTS/8g3dW2kRdfZ59pgJYwl/S5nwAj4svodlkgx0dFw2640Q/nGRWC7fPl
         qDXmBQWzRWA9JPZf/U42JKCVkiRpstLjCijuixLhhfkoz85C07G08kXg+HuqmmsDwhzu
         hgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212314; x=1685804314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8IvnB7h0HAb5+pIi9GxWOAfPdgUl4BJHVh6FYr/ed4=;
        b=NBBbyIgHnynqWZd7rpGj3occYCp1h6gEquCfZdfIu35LmHdqArHVQDa+v0xPl7eltV
         qt2ItCFhiJcMa28e9gQbkYMC2ibz2mckb4R+3gC8dqvPrRhdcQZeHft692qELKiL6U+H
         yT4DUvDg5lE9qBluO+FnyH7aYQkjL+IEcPvUidS8i1IJ07DK5NXVh/T0minX20OBrOAI
         kgskRtPsZYu2OhEG8aQ4NpkDmLNGpBw2ZV3eBKSNlyAZGiDP8nHZ2WnJloCkFF+qanFK
         zd5+vmsMzZojKqMVJBM1xJezPsYSXIk0U24Y217xwr1fpEqVKM42ORAFP3Wdmt/Ib30k
         X6BA==
X-Gm-Message-State: AC+VfDw35UhI3/lp/kvpKBRUl0fTUvvDWJxd0PMRG4i2n8TRH3SxLQDo
        N1sTKQHmmoXFbiiJ1NbaTrSxgQdh1HnFDg==
X-Google-Smtp-Source: ACHHUZ6iw4g9UiLmwSI+Th1Vi+OjDYXsXi9WmxXGjir0X1Fu8w/cioZXKeCSGJecPFY3tcD4sPqcliqCieMm+Q==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:c2:b0:b96:7676:db4a with SMTP id
 i2-20020a05690200c200b00b967676db4amr152609ybs.0.1683212314520; Thu, 04 May
 2023 07:58:34 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:37 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-8-joychakr@google.com>
Subject: [PATCH 7/7] dt-bindings: dmaengine: pl330: Add new quirks
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsize"
and "arm,pl330-periph-single-dregs"

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
index 4a3dd6f5309b..0499a7fba88d 100644
--- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
+++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
@@ -53,6 +53,14 @@ properties:
     type: boolean
     description: quirk for performing burst transfer only
 
+  arm,pl330-optimize-dev2mem-axsize:
+    type: boolean
+    description: quirk for optimizing AxSize used between dev<->mem
+
+  arm,pl330-periph-single-dregs:
+    type: boolean
+    description: quirk for using dma-singles for peripherals in _dregs()
+
   dma-coherent: true
 
   iommus:
-- 
2.40.1.495.gc816e09b53d-goog

