Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409FF1EF916
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgFENcb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:32:31 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:7894
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726844AbgFENca (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:32:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btFjvx2yXZ5BB1PcqdBt3n+kHCeICp6N1nG585vJmYLChb/yrVbH96OzJpgEGPIRgbDXLqdKf0ea11RJy/e9S0/yQ3OmyrUNQRmeIbG/pmsGDVoorFbQbTdtg+qk98k+Xlkc519/3m3snTfAm9FiSCWLodEwrkn/+YhIBYIdVQysDgVIueaaB9RRFkTJxs1W2kVl7+oTcpYSxwtJcdvImsOgn/9a55HyUy/LD8GmllySEBl7zhDZ1WEQDmWyV2PnV5XvNj/yX8ArIr4Ndd1kcDVgdikQod/DbHOKpKYik2oLLROibGiYnbGCziUP9VdHLFcfFhGTyaclt5zS5f6PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdIr+yXh54OxuXDi8O3W+Ykd5tFiQiZLLoXyHsE8RJw=;
 b=DhPRI/7eInbzBud4se20JRY8/I0N4B6Qy5AVM5VBIWe9ek3MyC1SKSFuYfToYZZdSrymo3+eiAgQ+Dx7ciy7F//Z5E8rH4lSpuJwLd4VbshNoy9GacRg/+/V+0ZMUuPgDCHyPNZLxseMulCxxsKkdjhU9H0IzxyHKgp6zP3/ig1vh8AHbwqxMafOD5P0DPfmO8WbnbS9SEeppedL8ZRxWyuU9OlE7/e7gvwssX2TFmG0R7Wh3TeYtW7M4jIfxwy1SjdcqYYRmJse9fYvwehysfM/P296su4B3zUoDBS4IMwTeE7lRdSHOG7hO4SgdWVCadqGx7i5ktaDLr00h2OibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdIr+yXh54OxuXDi8O3W+Ykd5tFiQiZLLoXyHsE8RJw=;
 b=SNXabU7jwAbFRSIuCRQtLn61i4PP0uneGaZj+FeQUaVmmfgMPfZ84QNXViD6/DoVyTvT+s/OSZQ8VebmTMpUegdjh7TJ+iCDvMLdLzUdqLqU0Zj9aYzJK2/vbbhYdebgoXnGM8AsfRiTLI5P73acThNTluplDs9pNevHrJdqRF8=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:32:25 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:32:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Sat,  6 Jun 2020 05:32:21 +0800
Message-Id: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:32:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d9264ec-d495-43df-bb20-08d80954e1e9
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB670251626171F5ADB562EC3089860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGupSpJnibd1bjcM4+XCaxvP4vidPvwhgtiee2PlrMJ7DXzqkQr0gj05APofMYr4jHaRlts6glQHYjNAE8hOoj1WXMrU3mtCO8xt9FPvYfPV9HPu5fI3ncDMs7vfnmZ9g2lseuSRz+faBDxXUjTixzNmNY7q+bx96B87KM33LI5ds9jcKhH/+iTE0ER8t52gauxiARxDugnf1Au6l2cnSU/BpHxjW79Glx7T56plqgeyzwCt6Wo2rJOHdVY9cMj7O1H1zcjhnoCCiKwrIU2iYPZWZbtQcSgVae7B3ZgLtNVTDdu5a26/sXXi4rhM1xIXG+CCEjzGovx5z5aAi0XSh78r3B2UTDe9EI4oIDbmeY14fVaHDpBewEkErjRR5+v3sK6Jadcj6xn+BJEXfM/2NBnk+b72LM76Gai2MkVuC3fRhMFH+TUSrqmBCjj8OeMV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(966005)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pGL1e60C0NJWemTbto+1Ga2ISH4gyVOcWHcdpXU1R5uvrB20z4ihnZfhGHJ9U5SF5hYEiiDdmO30RZATkqB2vXyGgJIXQSYGrwvRHOTShvtBTGCC45qzuKQTLSEqm7ZFgG1gdP78Cz62GR1pQfwgf7wlMa2LpEOhAuRWmerp+bPMnifeGg8NJPcqd/jz5hGTijMp5AXxquP2kwqk+AxptqEWh763z3/Q4mt2vI07pSD1DcBCX6fH1VVr0/Wnb8/TTuz1BcJ7C5CzG96nGbg6XzrUm622alY+Dc2npYFQe06qEGD8GcglmnCkexPQyMaR2wnSAM+2vZSdIBkdUinSoJNH7RptW+NJqh8hPV1ziiWpXO+Okq70iy5dKGafstJ47SeHVlIp9ib6Ym7/nRDRTzv1dCftbnVE+mMmz+c6sLd9zF4tKDa+KNPDuWCmeZbezCpzZWu4VfWHBlKRgUQOgp14NZ0rlOG0qZMaPXMlUTM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9264ec-d495-43df-bb20-08d80954e1e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:32:24.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAEwBi4CkJcr1omf4iSh7RHKkLrC6aWD9sRKe4NvVFQOM1hh69eZhf0EjtMfEHXUsDvimUG37t9SkjgMOzb7kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
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

Robin Gong (14):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove duplicated sdma_load_context
  spi: imx: fallback to PIO if dma setup failure
  spi: imx: add dma_sync_sg_for_device after fallback from dma
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  spi: imx: add new i.mx6ul compatible name in binding doc
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul compatible name
  dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
  dmaengine: imx-sdma: add uart rom script

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   1 +
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   1 +
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   8 +-
 drivers/dma/imx-sdma.c                             |  67 ++++++++-----
 drivers/spi/spi-imx.c                              | 104 ++++++++++++++++++---
 include/linux/platform_data/dma-imx-sdma.h         |   8 +-
 7 files changed, 147 insertions(+), 44 deletions(-)

-- 
2.7.4

