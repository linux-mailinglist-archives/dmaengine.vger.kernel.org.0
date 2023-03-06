Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9826AC22D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCFOFI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 09:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCFOE4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 09:04:56 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E3C2311E;
        Mon,  6 Mar 2023 06:04:46 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7DDB324E305;
        Mon,  6 Mar 2023 22:04:42 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 22:04:42 +0800
Received: from localhost.localdomain (183.27.97.46) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 22:04:41 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 0/3] Add DMA driver for StarFive JH7110 SoC
Date:   Mon, 6 Mar 2023 22:04:27 +0800
Message-ID: <20230306140430.28951-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series adds dma support for the StarFive JH7110 RISC-V
SoC. The first patch adds device tree binding. The second patch includes
dma driver. The last patch adds device node of dma to JH7110 dts.

The series has been tested on the VisionFive 2 board which equip with
JH7110 SoC and works normally.

The last patch should be applied after the following patchset:
https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/

Changes since v3:
- Constrain the minItems of resets to 2 for jh7110 dma in the
  dt-binding.
- Replaced all uses of of_device_is_compatible with of_device_get_match_data.
- Moved the definition of struct axi_dma_chip_config to dw-axi-dmac-platform.c

v3: https://lore.kernel.org/all/20230227131042.16125-1-walker.chen@starfivetech.com/

Changes since v2:
- Added minItems with value 1 and changed the maxItems' value to 2 about
  resets properties in the dt-binding.
- Added match data for jh7110-axi-dma and executed reset call to match
  data.
- Dropped reset-names from dma node of device tree.

v2: https://lore.kernel.org/all/20230221140424.719-1-walker.chen@starfivetech.com/

Changes since v1:
- Rebased on Linux 6.2.
- Changed the compatible string to SoC specific and dropped '-rst' from
  reset-names in the dt-binding.
- Dropped 'snps,num-hs-if' in the dt-binding.
- Use different configuration on CH_CFG registers according to the compatible string.

v1: https://lore.kernel.org/all/20230206113811.23133-1-walker.chen@starfivetech.com/

Walker Chen (3):
  dt-bindings: dma: snps,dw-axi-dmac: constrain resets items for JH7110
    dma
  dmaengine: dw-axi-dmac: Add support for StarFive JH7110 DMA
  riscv: dts: starfive: add dma controller node

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 24 +++++--
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 67 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 4 files changed, 99 insertions(+), 12 deletions(-)


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
prerequisite-patch-id: 54ce870d6ea747466474b5d4105cfbc05e1b01ab
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: 044263ef2fb9f1e5a586edbf85d5f67814a28430
prerequisite-patch-id: 057fa35870d8d7d22a57c13362588ffb9e9df316
prerequisite-patch-id: 848332ca483b026a755639b9eefb0bf8f3fcf8be
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 87cb528acd9a7f1ffe7475d7261553f6a4de5753
prerequisite-patch-id: 417736eb958e1158c60a5ed74bc2350394321a80
prerequisite-patch-id: ff9fe0b043a5f7f74a1f6af5cebc4793c6f14ce7
prerequisite-patch-id: 290602062703e666191c20ca02f2840471a6bf4f
prerequisite-patch-id: f0b29adbb18edffbfeec7292c5f33e2bbeb30945
prerequisite-patch-id: fccfad539d8455777988b709171ad97729e1a97c
prerequisite-patch-id: 929ebaffab0df158ea801661d0da74e8b5ef138c
prerequisite-patch-id: 0d9ddcaa8a867fcbc790b41d6d0349796e0c44b0
prerequisite-patch-id: 5f539ac7c96023b36489c6da7c70c31eaf64a25b
prerequisite-patch-id: 65f2aed865d88e6fa468d2923527b523d4313857
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: e3b986b9c60b2b93b7812ec174c9e1b4cfb14c97
prerequisite-patch-id: 2e03eeb766aefd5d38f132d091618e9fa19a37b6
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: ea9a6d0313dd3936c8de0239dc2072c3360a2f6b
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 602c3cf8f42c8c88125defa0a8a301da51f8af49
prerequisite-patch-id: 82d2d2bc302045505a51f4ab2bf607a904d4b2d1
prerequisite-patch-id: a6df0f7d8fc2d534c06d85f17578c9134913d01b
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: b9b8fda5e8cd2dd4c9101ec03f4c8fb8e8caa573
prerequisite-patch-id: 7acbc9c924e802712d3574dd74a6b3576089f78c
prerequisite-patch-id: f9ce88e490c2473c3c94ad63fa26bc91829ce2cc
prerequisite-patch-id: ce8a6557564ba04bd90bb41d34f520347f399887
prerequisite-patch-id: 9f71c539a241baf1e73c7e7dfde5b0b04c66a502
prerequisite-patch-id: 378a6ccc643a8bf51918cdd61876af813564c638
prerequisite-patch-id: bb8e071ed43998874b9d98292c0dcdeedc0760ca
prerequisite-patch-id: 0c04762f1d20f09cd2a1356334a86e520907d111
prerequisite-patch-id: 8867ef35e4d555491a97106db7834149309426b7
prerequisite-patch-id: e5a319ba557c8165f7620e574c79ff2ad3be1f65
prerequisite-patch-id: 2bc43b375b470f7e8bbe937b78678ba3856e3b8f
-- 
2.17.1

