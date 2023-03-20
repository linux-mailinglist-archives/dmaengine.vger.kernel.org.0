Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FC6C0BE5
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCTIN2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCTINZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 04:13:25 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008FE16885;
        Mon, 20 Mar 2023 01:13:18 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 32K7v6Wo088827;
        Mon, 20 Mar 2023 15:57:06 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Mar
 2023 16:11:38 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <pmenzel@molgen.mpg.de>,
        <ilpo.jarvinen@linux.intel.com>, <hdanton@sina.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: serial: 8250: Add aspeed,ast2600-uart
Date:   Mon, 20 Mar 2023 16:11:29 +0800
Message-ID: <20230320081133.23655-2-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 32K7v6Wo088827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a compatible string for the NS16550A-compatible UARTs
of Aspeed AST2600 SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd..cc6842371d38 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -59,6 +59,7 @@ properties:
       - const: ns16850
       - const: aspeed,ast2400-vuart
       - const: aspeed,ast2500-vuart
+      - const: aspeed,ast2600-uart
       - const: intel,xscale-uart
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
-- 
2.25.1

