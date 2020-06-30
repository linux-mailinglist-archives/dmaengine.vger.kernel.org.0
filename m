Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA720ED53
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgF3FYf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:24:35 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:35649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgF3FYe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxQ/GXslvtDLc0mvw8ibKvyFMAMwf03UfPf61MiOR1p5lV1cxCAWBJlVIIUJ4dMnNTwlS6NhV7QTB/niSUd+HIp52+2U5HBtFVjTia9Swl+AR1ywF/axwhDSDu/T65bOpopTpJIeJ1axW5R2po+96B6SHduOmDs8ypL4qIZ5q1xIT0SUyCBM2sB5MPCUGFrnTuYGVAqV6WnfDG7jFNAOaFhtfUSCkC6lDnFXDOXSuJQsU4hGpDjRadyOPgWKvO1lYMdC9zefvMyzY17eYoNhXOdio/dWuUgMC98phuuh3xZWvhUPkN0h9GryiWWJqoPy34V/mRZ+fOCdV8xelP9lFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwa9tEd1POHbUIM4Xm8BoOQjdEesdscNwIUMqUGqAZ0=;
 b=K83kB0b5opSt4ZlPv1aTFeUqKLSjtTpvcVSkkCnUBkZbyB8kvSHWsgkLzCe56OKELS0bgRQ4uhrKZAkgK22EffIRV5LoRfcAPXQ61OP2Mj+TgJC5p4MhU3HQdP+1aZ5a8BQ3WG8Z++hq9AvVqPwuQgbk1eQpdRbyk6ceq0YuCuxRqdWmtDQ05EwJOHhKglF1ppz3gmOgm24jNUxRLTkIAne+syTX4mT+H/MT6fBKxAJJRLTdzG7IsXdOc2UUT/J1Cir+HNP6+7+ghP441dqcQCl0796tQYZZzvvJZ5QR8Ozt22AgmxZqKHOSk3UxosvAImuDMr6lzQ4vsCwtk1PswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwa9tEd1POHbUIM4Xm8BoOQjdEesdscNwIUMqUGqAZ0=;
 b=oUPVV+iUq9i99QXDBySwhumXi+Q0lT1Kd4UdXWCVK60f537AqBS8vaYChJQKL/M0Ph9FB5/LrYn6BT6Wzc1Hw5OCivnj5s1OY4FJ2CE8kMTd5La9aUnHwAvXlblJK8ifdtlr2zIbJ41VLSL8yr09c8ZY04idVTo80tdS29EwRVU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:24:27 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:24:27 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Tue, 30 Jun 2020 21:31:04 +0800
Message-Id: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aae7f62a-b640-4e14-f3eb-08d81cb5db50
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB664040790976798F1E133DD1896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rv/FQrGpEmSmxvio05fIgnm2I6NpB+E417BfCOFQ9y7MkZLx0Iha1k4l/B/biOs8/ohHA7Zfn+8oF5q83wvZsoAGXn1xhZWadjpjTzlOM+7HKxYz/7tyDZ1UJCmrGBCWDTW7RasOUi2EPthqSDxvpK0LlNWYrdhm5EAxs7RCj0tEsqv7OkbWMOw45FCZhQmuHhawJh+nXI+fEKBSEfAx/ObVPfM4TxTgFaMtcMdoE8kPquk8r/h2NcZVEMxyiim6ppamJT+SGKM6RSKJeRtAwIwzjQ0Uuria/h4MChPBmcXxGeinUOjiVIS0wZkfDi8aGZGsSrXiP8uFqp81pZrl/toTe4j9OTNmwAv5gFTO/wcYC2sgOEZmeIPvZ6P0iwPBzu2pbabGFasafq9Aap85pwN5HTyRnClYkNyePkfTiO2r9Z7iu9gdij2Y8SS4zrEV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(966005)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wf1ueChDBtV3sL6vRGpPFyh/aDOJJwOFNQp/5IzGiEcJHXWdvs/d9h3ovw4uUvJBeWXvvYtatJk3v4Hz6i32BrE0+c013xGAJBrNrorHGVcBTlakfCYz5qEIbEklvK2dstiiAz+PIIHFmNNWtsvIFSTdArY4hX1r+kq0OBq0me8x6nOZIy7U1hGspY8pu0UOveyQZm7nwgEURRUlXHq76oLRvYYabDUO14oxLer1L/cI+OGf7LIp497ZnP1dkkp+Cpno3wEWUOIJ5Wcp9zmOvSLlO5HmXvxAoLamOcVoUV3Pvkvd3+wx1MAbVNt2k2DtEAlxxi63iINtCInnkbHKeSpsTIRMVTiJDHnPRXgFRV6kWP0tuakNTS6dirCaUtLJLVVuZDYGZqi6llWTVzsAKFFUwq9y/F4cPWY0AERH9DjWGPiNpGrVd8suEM7sEjfK4trJzdcvq+mXuIu23+Z4FOJ1oM15k5Cu+WMU39Yz5k4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae7f62a-b640-4e14-f3eb-08d81cb5db50
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:24:27.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te0jn8nKaJVoNM+zKoT09LrLKyf8GgUSd5RGfc3ikAM/XmhG67ZaC725vCPnMl0cYHecBoFYlWLC5DtlvUT6Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
v10:
  1. remove 01/13 "spi: imx: add dma_sync_sg_for_device after fallback from dma"
     since there is another independent patch merged:
     -- commit 809b1b04df898 ("spi: introduce fallback to pio")
  2. add "dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script" which
     is used to fix the potential dma_alloc_coherent() failure while this
     patchset applied but sdma firmware may not be ready for long time.
  3. burst size change back from fifo size to normal wml to align with nxp
     internal tree which has been test for years. Overnight with loopback
     test with spidev failed with fifo size, but pass with wml(half of fifo
     size).Seems the whole fifo size fed may cause rxfifo overflow during
     tx shift out while rx shift in.
     "spi: imx: remove ERR009165 workaround on i.mx6ul"
  4. remove 12/13 'dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm'
     since below two similar patches merged:
     -- commit 25962e1a7f1d ("dmaengine: imx-sdma: Fix the event id check to
     include RX event for UART6")
     -- commit 2f57b8d57673 ("dmaengine: imx-sdma: Fix: Remove 'always true'
     comparison")

Robin Gong (12):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove duplicated sdma_load_context
  dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  spi: imx: add new i.mx6ul compatible name in binding doc
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul compatible name
  dmaengine: imx-sdma: add uart rom script

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +--
 drivers/dma/imx-sdma.c                             | 63 ++++++++++++++++------
 drivers/spi/spi-imx.c                              | 52 +++++++++++++++---
 include/linux/platform_data/dma-imx-sdma.h         |  8 ++-
 7 files changed, 106 insertions(+), 29 deletions(-)

-- 
2.7.4

