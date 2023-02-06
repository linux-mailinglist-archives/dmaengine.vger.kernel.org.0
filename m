Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3829268BBC9
	for <lists+dmaengine@lfdr.de>; Mon,  6 Feb 2023 12:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBFLia (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Feb 2023 06:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFLi3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Feb 2023 06:38:29 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3618160;
        Mon,  6 Feb 2023 03:38:26 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 427E124E16F;
        Mon,  6 Feb 2023 19:38:23 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Feb
 2023 19:38:23 +0800
Received: from localhost.localdomain (183.27.96.33) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Feb
 2023 19:38:22 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] Add DMA driver for StarFive JH7110 SoC
Date:   Mon, 6 Feb 2023 19:38:08 +0800
Message-ID: <20230206113811.23133-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.33]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series adds dma support for the StarFive JH7110 RISC-V SoC.
The first patch adds device tree binding. The second patch includes dma
driver. The last patch adds device node of dma to JH7110 dts.

The series has been tested on the VisionFive 2 board which equip with
JH7110 SoC and works normally.

The last patch should be applied after the following patchset:
https://lore.kernel.org/all/20230120024445.244345-1-xingyu.wu@starfivetech.com/

Walker Chen (3):
  dt-bindings: dma: snps,dw-axi-dmac: Update resets and add
    snps,num-hs-if
  dma: dw-axi-dmac: Add support for StarFive DMA
  riscv: dts: starfive: add dma controller node

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 17 ++++++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 20 +++++++++++++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +++
 4 files changed, 60 insertions(+), 5 deletions(-)


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
prerequisite-patch-id: 54ce870d6ea747466474b5d4105cfbc05e1b01ab
prerequisite-patch-id: e8dd8258a4c4062eee2cf07c4607d52baea71f3a
prerequisite-patch-id: 057fa35870d8d7d22a57c13362588ffb9e9df316
prerequisite-patch-id: 102368a6ff799c4cb639aed513deff09c1839161
prerequisite-patch-id: 7c1a50a37919fedbbd336ca5dec295ac63c2a89d
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 87cb528acd9a7f1ffe7475d7261553f6a4de5753
prerequisite-patch-id: 417736eb958e1158c60a5ed74bc2350394321a80
prerequisite-patch-id: a137312ca162b5712e28719f77d0da78e9fdd778
prerequisite-patch-id: f7c548b4619f491ce27f319242c4e3685c76173b
prerequisite-patch-id: 4d90febab2fb7928f50a73104e7454312b9ce6c8
prerequisite-patch-id: 645a807d50e0e56593ffdc6c3b50ea54a230827a
prerequisite-patch-id: 165f8cd740ae60585d22c95b99a0689084d468e3
prerequisite-patch-id: 480d910deccadc2947b3318c3c13dfa0882c8e0d
prerequisite-patch-id: 1d1cb90ec12dfc9312e448759c7cab89f2bc6394
prerequisite-patch-id: 5f539ac7c96023b36489c6da7c70c31eaf64a25b
prerequisite-patch-id: 6bb9a780c62af3bcc2368dfd20303c7b1bc91e23
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: 2e03eeb766aefd5d38f132d091618e9fa19a37b6
prerequisite-patch-id: e0ba7af0f8d3d41844da9fbcba14b548cbc18f55
prerequisite-patch-id: c1f8603e58c64828d0f36deac9b93c24289d8e05
prerequisite-patch-id: d73b2371a15f99416566904dedd45be30109aa84
prerequisite-patch-id: fbbd7f621c50a0762b188f52585e3418f9896a28
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: dd10a6d021de43aef31a1df70fc1a7f8a710d137
prerequisite-patch-id: 7acbc9c924e802712d3574dd74a6b3576089f78c
prerequisite-patch-id: e0ac2cb2de37dcd8c6a3f27d6cba1164a6967145
prerequisite-patch-id: ce8a6557564ba04bd90bb41d34f520347f399887
prerequisite-patch-id: 9f71c539a241baf1e73c7e7dfde5b0b04c66a502
prerequisite-patch-id: 0813e1684f69e106bc7a84e5f5a1f40a28e8a38d
prerequisite-patch-id: bb8e071ed43998874b9d98292c0dcdeedc0760ca
prerequisite-patch-id: 0c04762f1d20f09cd2a1356334a86e520907d111
prerequisite-patch-id: 23db1e84f5de4e117427509c466ae1c106e367bf
prerequisite-patch-id: 56577b43ff594598eaa3c1dc9f7caa462d7f94cd
prerequisite-patch-id: 2bc43b375b470f7e8bbe937b78678ba3856e3b8f
-- 
2.17.1

