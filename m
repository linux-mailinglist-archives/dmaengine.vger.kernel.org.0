Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDEE4DDEDF
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 17:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiCRQZl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiCRQZZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 12:25:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0922F24C3
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 09:21:28 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 348DE3F4BC
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647620487;
        bh=2W0HN5RRkNZ3VABX+Cwv7ixmrYLder+VG35wSKi/d+A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YzcYOhhBwmL2p+sV7dl6hai2vx3reehNuryDItOPh9AF7LuS2WgBkjOqmOWcjyH32
         PpIRoDfVkeKH6/vxFk3nCueKzm4UzqJRSFx2CVUazpDG5fK1HutpxdpJ2p1EOQW9kH
         c6P834c3wh1dXcPiz40yc7smS16H/E3Hx36WLf3sMfOzZ4FISi046SmccV5X5iHGlG
         7DSpB1bG03wlRQXxv7RFNPjHyiTnsVJt7F98+fCqjDeHPyFRHGlAiYSvmoFGbln98z
         YjHq/WsCWtxC314A4eWGPc9KA4Ozo1v9QxjtxAf53U4XDEmsdA+4HRZTCCwASwqMmQ
         5Qmqs2WSAXUIQ==
Received: by mail-lf1-f69.google.com with SMTP id w13-20020ac25d4d000000b004488cf80eb1so2726113lfd.23
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 09:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2W0HN5RRkNZ3VABX+Cwv7ixmrYLder+VG35wSKi/d+A=;
        b=WueReiaYMDqbmHJ9SHs/o462MxO94gIzP8aTK/MPVlYwYiqcx6pKFiB65tevWrfYBx
         3F09BXvj14gqkFhW3na+U0THdPtQkLHirk0VmfUMib2s99JLPEmA/PLvoX7UxYZRJdih
         m/lv3b4wzipx7uIc+UYVralVJ84n7F6LeH2vih7LHHKlSJ4IRpgEFR5htiQR7sHQIFpG
         6IshMK5ifRoncFxLIJE9xGse0KlKLPyF9UnpIHFjSwEMmoCb7GPAbbGf6TVS+4P7Ccti
         +VuEG5dUzk8t+tIEG7tiIbTbmXvJuKx29ef5YKP7AnEAFndFFX9H22Md3Bat1bDNEcvi
         SIOg==
X-Gm-Message-State: AOAM5319pi4EGFfERW5iR2adzb8KIZlMRR6Tl52MIznk3IM4PFT6Dgqg
        D39AmM+w7/DJL4TfuXF61P9bglN5LYTfMKG7aWO826HavtUlVtLq4LG6rXBpTlRZX6mAQsP2+g+
        zPj7MB42qVlLfBIP55phyNmsZVoguiV2a/obaew==
X-Received: by 2002:ac2:44a5:0:b0:448:27fb:f11b with SMTP id c5-20020ac244a5000000b0044827fbf11bmr6761048lfm.72.1647620485591;
        Fri, 18 Mar 2022 09:21:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxYnFRtdU22BR20+/ugHHxzULrSzy0BJHNZ4eqdyKUJs4Bzk00wOL775ew90uRhXAX1YOExQ==
X-Received: by 2002:ac2:44a5:0:b0:448:27fb:f11b with SMTP id c5-20020ac244a5000000b0044827fbf11bmr6761036lfm.72.1647620485407;
        Fri, 18 Mar 2022 09:21:25 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h5-20020a197005000000b00448287d1275sm906913lfc.298.2022.03.18.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:21:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Debbelt <palmer@sifive.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] riscv: dts: sifive: fu540-c000: align dma node name with dtschema
Date:   Fri, 18 Mar 2022 17:20:44 +0100
Message-Id: <20220318162044.169350-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes dtbs_check warnings like:

  dma@3000000: $nodename:0: 'dma@3000000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 3eef52b1a59b..fd93fdadd28c 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -167,7 +167,7 @@ uart0: serial@10010000 {
 			clocks = <&prci PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
-		dma: dma@3000000 {
+		dma: dma-controller@3000000 {
 			compatible = "sifive,fu540-c000-pdma";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
-- 
2.32.0

