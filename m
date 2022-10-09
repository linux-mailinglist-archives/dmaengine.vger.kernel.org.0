Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6875F8CD1
	for <lists+dmaengine@lfdr.de>; Sun,  9 Oct 2022 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJISOX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Oct 2022 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJISOR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Oct 2022 14:14:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E12408E;
        Sun,  9 Oct 2022 11:14:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so14099567wrh.5;
        Sun, 09 Oct 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvv29k/7rm7wh832tCEYi58dsefWyN9On5tLmaa0KiA=;
        b=qCM+U5l0TVhCfxR6XbES7e15P3vufJhKHPqObEfvyb2LP+DXM2v4edG+cN+EM2c+y1
         LPSoc/Lcxt4WBHyKvzaLfsaId+26ycFgDh/hHsya8ChWHspx7JkPZGLpWo7Cr5zd9fxo
         kQlg0PPFct14g6davRBJzmtv6GG8Sw2wtt5M/7rw/h2UfbYlrGSkInyKMXTgPP/8FNyk
         pBjwJn+nMylvzL9vd010HWEUygo5ZJRz6M4BynZJjuDKR/ecOPPhWXyFZ4ZQjRLU4BMr
         RZLpb3061y3ZYDJck9rdrwGMtGg1iv1ivrALqY3JM10A5mSf6maoflzkuA/KdAS/ntAJ
         7qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvv29k/7rm7wh832tCEYi58dsefWyN9On5tLmaa0KiA=;
        b=zYyV0+mVwBQnaCOHOs/5db79tdmGmhHR+FdpEMnSBvOwiTGZq/IBF/mWTslkvkeNo1
         oPORn8YTn2Ak9K1cuBic5MI8MklSSziBeFQqfL3eMV8vFVdv1U25OvSfgPKQjATUoXcV
         jhhFshucYs+dQm0pt3PpX6ksD9xCQDBscMTVwrN+zYgwrBVSJAiJWA8/8AopMgGKbpFD
         DfhYDUM1FrLp8IkwIgPu6Dr0WGIJGwYsa9NPjU/F/CizcwdQ9/fW/q7LbArpedtz9Fnc
         miApiBD2xZ4jAl75qzoNqQa/Al+ra/Nzx7kaHfvfhGuI9Rd86g1YEF6i4rvR/oIma7qE
         GD6g==
X-Gm-Message-State: ACrzQf1P04YRmU7EywPmncsTblge7lb/84TUPVwwbzqFBTJ8bzAStXaE
        tEK2VIrTqCmFZNF32DgfD8M=
X-Google-Smtp-Source: AMsMyM7UkQGGE+cCIG7lmuwBzQMxflhPdy9JuNWipV9xcgCd0Vl9q3hSgBDg4Tnt5T1ycGSTsbyFTg==
X-Received: by 2002:a05:6000:2c9:b0:22f:e7b5:bc26 with SMTP id o9-20020a05600002c900b0022fe7b5bc26mr2940042wry.149.1665339253502;
        Sun, 09 Oct 2022 11:14:13 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-190-37-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.37.190])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b0022cd0c8c696sm6860581wrn.103.2022.10.09.11.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:14:13 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: ingenic: Add support for the JZ4755 SoC
Date:   Sun,  9 Oct 2022 21:13:30 +0300
Message-Id: <20221009181338.2896660-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221009181338.2896660-1-lis8215@gmail.com>
References: <20221009181338.2896660-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

JZ4755 is a low-power SoC similar to JZ4725B which is already here.

The patch adds compatibles for parts which aren't implemented yet and
they are subject of this patch serie.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml   | 2 ++
 Documentation/devicetree/bindings/dma/ingenic,dma.yaml     | 1 +
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index aa1df03ef..df256ebcd 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -22,6 +22,7 @@ select:
         enum:
           - ingenic,jz4740-cgu
           - ingenic,jz4725b-cgu
+          - ingenic,jz4755-cgu
           - ingenic,jz4760-cgu
           - ingenic,jz4760b-cgu
           - ingenic,jz4770-cgu
@@ -51,6 +52,7 @@ properties:
       - enum:
           - ingenic,jz4740-cgu
           - ingenic,jz4725b-cgu
+          - ingenic,jz4755-cgu
           - ingenic,jz4760-cgu
           - ingenic,jz4760b-cgu
           - ingenic,jz4770-cgu
diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index 3b0b3b919..e42b8ce94 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - ingenic,jz4740-dma
           - ingenic,jz4725b-dma
+          - ingenic,jz4755-dma
           - ingenic,jz4760-dma
           - ingenic,jz4760-bdma
           - ingenic,jz4760-mdma
diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index 9ca7a18ec..315ceb722 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -20,6 +20,7 @@ properties:
     oneOf:
       - enum:
           - ingenic,jz4740-uart
+          - ingenic,jz4750-uart
           - ingenic,jz4760-uart
           - ingenic,jz4780-uart
           - ingenic,x1000-uart
@@ -31,6 +32,9 @@ properties:
       - items:
           - const: ingenic,jz4725b-uart
           - const: ingenic,jz4740-uart
+      - items:
+          - const: ingenic,jz4755-uart
+          - const: ingenic,jz4750-uart
 
   reg:
     maxItems: 1
-- 
2.36.1

