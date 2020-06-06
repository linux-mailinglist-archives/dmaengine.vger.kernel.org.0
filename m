Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10171F0741
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFFPVN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:13 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:60166
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbgFFPVM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYb1sutWPYEoVJSv419dQ7tmaKSDU3fS8tWc3MJqKk96l5bL4ri1OJaOhbZJwyT+WtedaQN35MbHGBUnLEPAnrqJ9m5ZlMrjWGkN32zBj7o2HbEBD76B1CcRQUtxjm/bNfCTYtzLa3YxFeOztpFgqvea4gAXQyUEN0AD2dyVJlOt+NQz6600HzoBnwEMqOoLL61BepEEBoviKmbFNgWVeuWbGcIxXzjL5ZkWNiN0Nwvuhps+ejz5zUfOco8rDaZ8NatuhxS229ZVa97vMWi6hzyehMt/n9q6apDf+aurCbAmasyFlslhmxVK8Ei/r94mHdT+hpYiOnyRv/6HutYU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZpmqO2oHdeXDFr7hNrHeCQjrrs0RHrCSx5R7z4Nrwo=;
 b=kn0yvTX5be4n5JwMYpTmqMwxfZIxaklt6w8toU7udOo9QEDtkSlKajc7JtxK/S2SJCRC84+7kf6KYbfdBLOmaVviVXaHXgrMgzpfCkfQ1eYU7lNBLiWzjufrHM1/naL3zF6nzq8CepEfVJNz37M3Q82OypRZZ7kgfKIWJ4DPR64GPvrpyBbnjtnXc10XthKGviLmgKW93ZDjXV8f3LcHTunC3eDF7FrGG89/gHHCfDY3rLyNX+CDG2m5G+y7vLndXzAhXjXqujOPs6ZCg0aLKVvK2OBAVCLItV58wu7aUFSZSO5dS/42ZeF2OcucsewBG9stWDP2sk4KcXOhzOBVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZpmqO2oHdeXDFr7hNrHeCQjrrs0RHrCSx5R7z4Nrwo=;
 b=pt06oYzmjk4C2i0xOylLmNvQ/377974IETKzasD1lOFGsSs84qR73qGkRgYiwMQNgQdPbHUTn4cSrl6w28zSGgpcLJW6IAjTatbRPfrwp5lyIDuzmG+cxXx/lMoDbCc0MLjJ8H7Si4X0h+eeS/t1qY3+BW5R22RMB0J9VqYzPBU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:05 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Sun,  7 Jun 2020 07:21:04 +0800
Message-Id: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88c68ebb-5007-45c3-a21d-08d80a2d3b03
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB651199B5654AD96618EAD46589870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guoJ+c1s16rmY7C9xICeUn2O+EDCcm03UaZX4bPejGt4z511oy0eudWSRnPjM4qkynUVzllL+0zbGDf+B1ueEh8moZFsPjz4cuR3yWA7lAWfrVekNuDzMvCS0a/+MvUTGnSKqiZuxfkL3kj9+jR7hPSw3YZpkRb8IkvINW2jdevK+y6d1nk+7jLAY5yhxVnPrMqMK6QxRSacnzvLTL1KeSeYyfryP/CLsIaODwXgZ4hetacEsMNcdhbey6wJ/+Czjpzu09uox0Ibsh3M8FHoTppl/ruiT98pP/rA5etBf8+ICoPG65zE33TiTP7zTmIVX5JSQvbGH8YwSZ3PkxiOhAWB1JTisUnQyLBBh8mQbtgFX4RDGY3sClPUqK90nYBK+LRReTgqlHXKvL90BxUoRTfl41RIMxPBsHvm7Ssu0+glEmYD0l/WQESkhQ9Pthi5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(66476007)(16526019)(6506007)(66946007)(956004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(966005)(6512007)(8676002)(83380400001)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cGurvKvXiyo8N/P/U+fj/23Iua+7d3VvxNhl/W7EFpDjH+ggkK3c6tf/aQUu71Vf6ayzlxxgOtVsliBo0zcbxKbAafW4Z+xJS/PEt1X9jG4HXgJ8VM7/c2d1adJGEdiAciRkMkICG3e1UHiRVPQTD7Sz1czJ5uFY8S2vm2CMzzjgioaVS1cFUBGme+j/F9S5tdiBM07A/q+gQ9d9kPQHLRJkJQsmPZ2xDVQiXqTtA+8b1eHiyg74KSMY023F9DuF0OztqKS52tuZCF43sD8MeceHdH/QSd5NoyOBrdndo0s7G9R5tRssmxytndQSI3kOBDDMJ9LRUHs8IOWtUzlYLPlpaGEyJePLwiQGkOce5KDi8HrAIIFnLk5k138LeaWG0dsI5IbO8k1zMiv9r0IrpnA1IB/HnBf/KrtEliRBmKCp55bzjSOWCtZVo0N0M0Ra46yIhwHhOcBh8s9ce0N4U66kRNgltA22xDk4B3t8AHY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c68ebb-5007-45c3-a21d-08d80a2d3b03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:05.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFpvAZesSv8XZcs1x0r+SuIVWpvlFDgK6giKNCbFk/2dbQ8K0rLI4LVb0N6DFFu9ob21dNkqAKPZVCfBhPnz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
transfer to be send twice in DMA mode. Please get more information from:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
new sdma ram script which works in XCH  mode as PIO inside sdma instead
of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
exist on all legacy i.mx6/7 soc family before i.mx6ul.
NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
or not.
The first two reverted patches should be the same issue, though, it
seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
have the chance to test this patch set if could fix their issues.
Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
on i.mx8mm because the event id is zero.

PS:
   Please get sdma firmware from below linux-firmware and copy it to your
local rootfs /lib/firmware/imx/sdma.
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

v2:
  1.Add commit log for reverted patches.
  2.Add comment for 'ecspi_fixed' in sdma driver.
  3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
    rather than remove.
v3:
  1.Confirm with design team make sure ERR009165 fixed on i.mx6ul/i.mx6ull
    /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy chips.
    Correct dts related dts patch in v2.
  2.Clean eratta information in binding doc and new 'tx_glitch_fixed' flag
    in spi-imx driver to state ERR009165 fixed or not.
  3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in the
    errata workaroud, thus improve performance as possible.
v4:
  1.Add Ack tag from Mark and Vinod
  2.Remove checking 'event_id1' zero as 'event_id0'.
v5:
  1.Add the last patch for compatible with the current uart driver which
    using rom script, so both uart ram script and rom script supported
    in latest firmware, by default uart rom script used. UART driver
    will be broken without this patch.
v6:
  1.Resend after rebase the latest next branch.
  2.Remove below No.13~No.15 patches of v5 because they were mergered.
  	ARM: dts: imx6ul: add dma support on ecspi
  	ARM: dts: imx6sll: correct sdma compatible
  	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
  3.Revert "dmaengine: imx-sdma: fix context cache" since
    'context_loaded' removed.
v7:
  1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix context
    cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma: refine
    to load context only once" so that no building waring during comes out
    during bisect.
  2.Address Sascha's comments, including eliminating any i.mx6sx in this
    series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and taking
    care SMC bit for PIO.
  3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
   'spi: imx: add new i.mx6ul compatible name in binding doc'
v8:
  1.remove 0003-Revert-dmaengine-imx-sdma-fix-context-cache.patch and merge
    it into 04/13 of v7
  2.add 0005-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch for no any
    ecspi function broken even if sdma firmware not updated.
  3.merge 'tx.dst_maxburst' changes in the two continous patches into one
    patch to avoid confusion.
  4.fix typo 'duplicated'.
v9:
  1. add "spi: imx: add dma_sync_sg_for_device after fallback from dma"
     to fix the potential issue brought by commit bcd8e7761ec9("spi: imx:
     fallback to PIO if dma setup failure") which is the only one patch
     of v8 merged. Thanks Matthias for reporting:
     https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com/
  2. remove 05/13 of v8 "spi: imx:fallback to PIO if dma setup failure"
     since it's been merged.

Robin Gong (13):
  spi: imx: add dma_sync_sg_for_device after fallback from dma
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove duplicated sdma_load_context
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  spi: imx: add new i.mx6ul compatible name in binding doc
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul compatible name
  dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
  dmaengine: imx-sdma: add uart rom script

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +--
 drivers/dma/imx-sdma.c                             | 67 ++++++++++++--------
 drivers/spi/spi-imx.c                              | 73 +++++++++++++++++++---
 include/linux/platform_data/dma-imx-sdma.h         |  8 ++-
 7 files changed, 120 insertions(+), 40 deletions(-)

-- 
2.7.4

