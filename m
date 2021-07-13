Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE43C6E64
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhGMK2S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:28:18 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:46238
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235475AbhGMK2S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:28:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St4DjGjCvQNjgAbByWV+mLJ2DwAJS85LmIffCwlAWLbJdAx9RQod3tvaqSuSvx4HUdeFhkCHnCCetpMFuw1wNozl0HXH9jMuKPoOCxle31mUvPMBSL7G04xrLNJSd+DWdmYF0XxUuUgwSi0ShbK0VeRAf7qUBLXoGootAjjB7PR/ZpW51/mpGGDTfD1TPgeZuJdZyrOBQ6DntNtMBZIjHP91YjbyZ0f0BeVBJ1laDqX/hgaVZ5E75pLdlraqKulJSybAUP9yzKyx35clpIaS3yp3fAosKy7WsrYgNjJyjAQZNHthXN8t6H08F/iROTjpCdiHa06hYHWXCxtwUY0Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7h/jwRvJ1qh+6DahRzsLY1Tmo3ozbTU7aSM97J05HM=;
 b=Hz7KoyBKVMIwrhWCxNIEgpDgC6+B8AtOqbEsdyTC8FhV9yL6rh39COSjDAKgR20qV//MiPtSmMP6wqwi7FAf4O8xrhC0LyRNqRWj44+GDc/qe9ehXKwRvqWSDTPTYlQxZlPwZURjqF5i8IEfg3chX1l9TAYlktVV5strM2xnA67jffLJ4dxPmFSOIGRUetiXkMfCg3wDgtnPLFSfTNU7sDHv14wxX3YFUMdXa7Ver0goAXNdK2OBQ6V0fnysT1jVyp7/bZEQwu30mCCy4AzZCse8OXLHYpdPHqGcbTYK65pElXxBjzREb13dtNdIo6qQkbHCnKgOiMcCC/8UWx4hPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7h/jwRvJ1qh+6DahRzsLY1Tmo3ozbTU7aSM97J05HM=;
 b=fIbD9SYIPwUzjOH8keuSCccfZzgm7XTwM2k2sxSMiasSdYKQLV5tk2PIa00qtASVOpQoqjFHeNA/bsWeAzrXT9WEA1ajYPs9BAaq/ivAmevNz102+LkhwaliS37d71ShkJ2hqhWNB8ph+0tPJfKddzx5ZuNMLkvO9HTe2p4MGxc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:25:24 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:25:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Wed, 14 Jul 2021 02:41:37 +0800
Message-Id: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:25:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed61be1e-f884-4641-9fad-08d945e886b9
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB22882C6EAB07CF5F35216B6A89149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZaK/NU9vMh0dum6FUivOF8rqTgaiokRD0eHpWXanOxg+nLNf9955uUk3gy5cgd74m29DXTFjPQNiRlFvhF8uonscD/LuMIAlOv8DSwJwirjeZ/VkMPK2n/KKDY3YX/7cHj30uEhpbmybQrJUb+BDW7SS0rJm2+Dx3437x+V9+8iQOvYIvHuF/X4w67+qWC79mVDP8wQfkANfGn36SZNUGZpRJfiIj/V97fZ14drsYDXgp/tX3ov6pKGEy4tFsommr9r7aLpdI6p8Wi5o+63ZYmI9GRPCjAmxelKPEUU8ruVqEItd88fAecOVo1dC7o40d3r6BH6HrnAS/2Q8ptuETX3kR0xf4pKyy0Jg7JX1n9xYReTQ3zBBRpflOFMcBWVjblRbPWkKCvihhKWoereEOr8DTIkdDyummHrnCPlZsUk/411J6FSwEG+Knv+92d2RKV7AzIRVBfmBQj5QZ//yDit7F4SPbreWNIOY+o+Nx2zitfL9QOWR9ZyDvOQuFWPIYpqk6SUCixxX8DKaCeC1W7ubiaAT1oZSUWM7SLnA6i7n7e3ydyCoE8bMIg/2hxVN/kCc54YXiVK9op7+YI/9dW2kAH72sc7cecsKDY/bOQMPNGSgFk7RoG8GE+uPmjij0OwFHCDokoVSQkvguz0GRc9Nbs5yB90zmFJV/mn59M2B6CAO9IpSYCr+jIwI6tC/S7Q7z4y8wq01/syw9o9Dc9gwLIVTcpTzUtfyFXhT8RnyNfAjijRJ9B+9BGFsel1cvNwIKlMPPGlGPA7+Kch+f2fT8WqC+b29J8rnIXFPM9KbT612HweMTfSaP4PcRqkfo+bNYZ6evArgESBfYT2zPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(966005)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTprK784Y2LNXqnoIBzXl7aRmoO6lho4Z2xja5ti5ZmFqAFahD9A7QcBeBQT?=
 =?us-ascii?Q?U+SS5kdDgCho5gWUE1oK4tTPcHWlx9BmcF8idWcuw9uMMjllMqgqkD+M/T25?=
 =?us-ascii?Q?gb8AIatMADf9ZW4Gh5Brzgm6+wBR6+4KG3ybVgxjdzSOYcXj4iDqhB+YA5uo?=
 =?us-ascii?Q?dSdMHWayS+aG8DsRRhyrS/+7qgbzI04UDnRnr77z3x6409G38UwmYuYcSazC?=
 =?us-ascii?Q?VnYhZ7XXJZ5Jp9BD8eIuvO3eU/Kg1JlzoKh11QLG+Nynk8UryeXa5D1rzUm6?=
 =?us-ascii?Q?MaVqLlXlbSeqgAmaVTgB+iosdC7L3HhwJRzzjpcexsYdWMnRKRnHkZczUCm9?=
 =?us-ascii?Q?OXKiXg0IRD1uVt9lp25qczeVasRx3gC7Uqw+jeiZ45N797tVTXO9M/SYbdvV?=
 =?us-ascii?Q?p+XuDk8bYRWD1oR6qn4P9opo9zXP5Z3HA7GcZkcttR7w9f5qDwYNyrctzG1k?=
 =?us-ascii?Q?NaZDgcuS4NalcmZqIj+VITdz+6NT1jWq+g+XSe90JxOQuRUQLzmgL61QQ2Vj?=
 =?us-ascii?Q?unhJs11JWg6dzPbXzbimdHS2MDTqhYyUMR8/vcVNJm3TKi+EEUWP6Hg14hqp?=
 =?us-ascii?Q?U6RCLwM23jAxuuDnAzkU2XKeWxJTnYPgubq171iJ8Y+lLUWpYB+jL+iBVGjI?=
 =?us-ascii?Q?61dJ0xnfTgYGRZwAQEzY4aV4aKePQ+6M1ogG45hzmvzp0YfL2v6DpJZhjSLp?=
 =?us-ascii?Q?vkfrF4GeualUh78KrB1jFnIE5CqBVZ0QbflJ56SsT5LtuF+vpHh4uk0j+yIz?=
 =?us-ascii?Q?5Y9CsMzokiYjgSv6V2oOE74ab5GBc1ks2AekOZ5tyxTWAce50G1vPXPqvzK9?=
 =?us-ascii?Q?EnMrubNB39VceNle1fgDe73+6igmPSPtr1NC/o0lJRO5qOe5xKY2Lzpz9DyK?=
 =?us-ascii?Q?VYmiBX3tftNXYZhKMgqeY+VSavPWr3Rvya/35e+jWxHxHXGIaX5pAeBIAUPB?=
 =?us-ascii?Q?pRo7FLY1SHaB6ZC72xWt0JSHJ5KVVhA2oPPkx2NNSsm+YLd7KXvpVl87zJbR?=
 =?us-ascii?Q?M1vE/7GZJDithlegqO0i42j4q8eMtWA5eNNDZaH0jBW5CFVLU0u4X0A6PhoS?=
 =?us-ascii?Q?xPSwqrf7xjUWfo1t7iTOQc6NmvhZGZKySv+AHJDX1NjTtGXPeEpuVDPW6x/w?=
 =?us-ascii?Q?IRUdgYCEUtc2GhB8kZcj93bqMD92XUrdwLp7/QGIhTV7Hw/XPxfZ5rzq7t6f?=
 =?us-ascii?Q?8up3NSsfN998iLVsK6uyNsNkTJMtzMNcPcJHnnBm+27hAWwT8+F6WqlBFhWz?=
 =?us-ascii?Q?ybCt3E0ow+p+8WQxXpiovsOX2hyHCy3vk8pmr+z2YTw7a73IcJUMr1VIPFO+?=
 =?us-ascii?Q?XcrJC6PeBOsyXp9izcO1qCLX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed61be1e-f884-4641-9fad-08d945e886b9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:25:24.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNIA0utLAv5bOe+F3+SlSFQPLIT7YJpP8xWppgu2ReMdt6lYwWPcbHrrPDB17cg3z16mrWMKCSkBy7jbFVcf8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
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
v11:
  1. change dev_err() to dev_warn_once() in case sdma firmware not loaded to
     eliminate meaningless duplicate log print.
v12:
  1. take care uart_2_mcu_addr/uartsh_2_mcu_addr since such rom scripts are
     now located in the bottom part of sdma_script_start_addrs which are beyond
     the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1. Reported by Frieder as below:
     https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2263544.html
v13:
  1. rebase with latest linux-next.
  2. remove 09/12 'spi: imx: add new i.mx6ul compatible name in binding doc'
     since it's been converted to yaml already.
  3. add 'Fixes', 'Cc: stable@vger.kernel.org' and 'Test-by' tags for 03,04
     since they are confirmed fix by Richard Leitner:
     https://lkml.org/lkml/2020/8/17/39
     https://www.spinics.net/lists/dmaengine/msg23489.html
  4. fix potential descriptor free unexpected on the next transfer before
     the last channel terminated:
     https://www.spinics.net/lists/dmaengine/msg23400.html
v14:
  1. rebase with latest linux-next.

v15:
  1. reuse IMX51_ECSPI type instead of new IMX6UL_ECSPI driver.
  2. use mcu_2_app rom script directly instead of ram script on i.mx6ul.

Robin Gong (12):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove duplicated sdma_load_context
  dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul compatible name
  dmaengine: imx-sdma: add uart rom script
  dmaengine: imx-sdma: add terminated list for freed descriptor in
    worker

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
 drivers/dma/imx-sdma.c                             | 95 ++++++++++++++++------
 drivers/spi/spi-imx.c                              | 41 ++++++++--
 5 files changed, 113 insertions(+), 34 deletions(-)

-- 
2.7.4

