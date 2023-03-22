Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0CC6C46F4
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 10:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCVJtc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCVJtF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 05:49:05 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64017159;
        Wed, 22 Mar 2023 02:48:35 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4651724E3CC;
        Wed, 22 Mar 2023 17:48:32 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Mar
 2023 17:48:32 +0800
Received: from localhost.localdomain (183.27.97.64) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Mar
 2023 17:48:31 +0800
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
Subject: [PATCH v6 0/4] Add DMA driver for StarFive JH7110 SoC
Date:   Wed, 22 Mar 2023 17:48:16 +0800
Message-ID: <20230322094820.24738-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This patch series adds dma support for the StarFive JH7110 RISC-V
SoC. The first patch adds device tree binding. The second patch includes
dma driver. The last patch adds device node of dma to JH7110 dts.

The series has been tested on the VisionFive 2 board which equip with
JH7110 SoC and works normally.

The last patch should be applied after the following patchset:
https://lore.kernel.org/all/20230314124404.117592-1-xingyu.wu@starfivetech.com/

Changes since v5:
- Modified polling time to DMA transmission completion status. Submit a
  separate patch for this change.

Changes since v4:
- Rebased on Linux 6.3-rc1.
- Added description for reset items in the dt-binding.
- Simplified the usage of match data.

Changes since v3:
- Constrain the minItems of resets to 2 for jh7110 dma in the
  dt-binding.
- Replaced all uses of of_device_is_compatible with of_device_get_match_data.
- Moved the definition of struct axi_dma_chip_config to dw-axi-dmac-platform.c

Changes since v2:
- Added minItems with value 1 and changed the maxItems' value to 2 about
  resets properties in the dt-binding.
- Added match data for jh7110-axi-dma and executed reset call to match
  data.
- Dropped reset-names from dma node of device tree.

Changes since v1:
- Rebased on Linux 6.2.
- Changed the compatible string to SoC specific and dropped '-rst' from
  reset-names in the dt-binding.
- Dropped 'snps,num-hs-if' in the dt-binding.
- Use different configuration on CH_CFG registers according to the compatible string.

---
v5: https://lore.kernel.org/all/20230314083537.22571-1-walker.chen@starfivetech.com/
v4: https://lore.kernel.org/all/20230306140430.28951-1-walker.chen@starfivetech.com/
v3: https://lore.kernel.org/all/20230227131042.16125-1-walker.chen@starfivetech.com/
v2: https://lore.kernel.org/all/20230221140424.719-1-walker.chen@starfivetech.com/
v1: https://lore.kernel.org/all/20230206113811.23133-1-walker.chen@starfivetech.com/

Walker Chen (4):
  dt-bindings: dma: snps,dw-axi-dmac: constrain the items of resets for
    JH7110 dma
  dmaengine: dw-axi-dmac: Add support for StarFive JH7110 DMA
  dmaengine: dw-axi-dmac: Increase polling time to DMA transmission
    completion status
  riscv: dts: starfive: add dma controller node

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 23 ++++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 40 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 75 insertions(+), 7 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
prerequisite-patch-id: c3a6b87df79b338fc97766406d010fedb79ab428
prerequisite-patch-id: b49509523cf7c098f684647bdc4fdaece48b61bc
prerequisite-patch-id: 46cc850aa0e9e03ccf5ed23d8458babfca3d71af
prerequisite-patch-id: a6975e61ee5803fbd74b1c21ab925fd81c3c0eab
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: 044263ef2fb9f1e5a586edbf85d5f67814a28430
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: 9f3dbc9073eee89134e68977e941e457593c2757
prerequisite-patch-id: 8600b156a235be2b3db53be3f834e7a370e2cfb9
prerequisite-patch-id: 1b2d0982b18da060c82134f05bf3ce16425bac8d
prerequisite-patch-id: 090ba4b78d47bc19204916e76fdbc70021785388
prerequisite-patch-id: a5d9e0f7d4f8163f566678894cf693015119f2d9
prerequisite-patch-id: 4c12d958e3a3d629d86dddb1e4f099d8909393e0
prerequisite-patch-id: bb939c0c7c26b08addfccd890f9d3974b6eaec53
prerequisite-patch-id: 8f5c66dfb14403424044192f6fa05b347ad356a7
prerequisite-patch-id: fd93763b95469912bde9bdfa4cd827c8d5dba9c6
prerequisite-patch-id: 6987950c2eb4b3773b2df8f7934eff434244aeab
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 9f911969d0a550648493952c99096d26e05d4d83
prerequisite-patch-id: 2ddada18ab6ea5cd1da14212aaf59632f5203d40
prerequisite-patch-id: 398744c61913c76a35754de867c4f820ca7a8d99
prerequisite-patch-id: be3d7a6a13098884ec26cd5e543cc95c39045e35
prerequisite-patch-id: b3ce7955a80d90d992b7d1bca3409f465810b2bb
prerequisite-patch-id: db2f66860cc5b2fd2f71747c4428287b6e3153fb
prerequisite-patch-id: 9da71dcd3af4c68da9d855b43aab6927103e7525
prerequisite-patch-id: 2d9e4f185631549094b6136cf8717a507b68c5bb
prerequisite-patch-id: bb8e071ed43998874b9d98292c0dcdeedc0760ca
prerequisite-patch-id: cd0b464336aabfbfad96c1a3595c0f9ce9401638
prerequisite-patch-id: 24eab3d30274700c2be4727bece743c76d2618bd
prerequisite-patch-id: 584c256c9acb52ee2773d0c81c3f4977fc18155a
prerequisite-patch-id: 2bc43b375b470f7e8bbe937b78678ba3856e3b8f
-- 
2.17.1

