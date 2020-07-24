Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5190122C333
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGXKhQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:16 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:44261
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BslgD9BwNCS0ZWeMDeGhH4pHBGtTXM0E4NpfCjCv8RqyhGP3DuD+RIRSfTzMmU5mQjOjZK2yOrt886e9WtCYfBM6y4grtJ6+AztxaDu9r3ZOrJCrhL+VpFiFkRhL9ju1qJaLv13SC5akH9wr2Zy2SdC1eNZ9/9VnQFAHeF3vF6b8e62t3eEuI1awZVuQsaY+5IFFpP9/ilGxaMuKYI32lPSoZWHGLkPs3T91Yh7f1LeDmsd31dqIYUrs5Zpp9vjyxoF6V5goP9aCAUh+WTuQ4Gf5AHGgt1FeNWVWOg+EV8ujWGWadyNpltrIVkeLMlkiJ/3tFhO04UqB6WqpuQlCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s56aO8/2uNfuD2t3cUNIG8LiSUB8GA/RWvBgx5kri6g=;
 b=XRTYWdsNcNWonkk7MHHchaM+B+qmvo3uB89WCvsB8ZNM0d98i10MYRHM6Y5grGHkqmw/VvbnFumeJ51GxwbJLo7knVg9Ke//nmwftQn2fnprF0vgEi2aAtAGXcts2q4Zd62yWjdNEa/CqAyrkPSc/46ZuI8JcyL1w/vj99JxT4bs380nrZ038XxM8mqT0x0NeFyXFi9vGLP6I2f8aUx8cLiPZLjC+v++yrz/uRxDODjUlTzNUkZ/wOPPOCEfhnHVTeUGVY34KhJcbvitHOlZGpXbpMkiP2NvRwh4tbNprxFkjU/BF3mZcPHVs4h7P00lj/kMIxl8VMJBVsddbpC8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s56aO8/2uNfuD2t3cUNIG8LiSUB8GA/RWvBgx5kri6g=;
 b=m2PoEXH400KEIG6RZgoiQaxBgj7F6uefeSg+ExMnaigr3SUgZIqxkkZheLqp+9MseE5LanXdHlCJbKJkAb8U8DyjXVR5pSaFHCHGiM5el67ZqSrKMf37rifSCq+o76ZFFkPgBQDTHihOKmn4AnaxFeEMoxT2cGkJBeS5Fz9ISM4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:09 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:09 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Sat, 25 Jul 2020 02:51:13 +0800
Message-Id: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 427d8a82-6b6c-4361-1586-08d82fbd845d
X-MS-TrafficTypeDiagnostic: VI1PR04MB5294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5294C59633898B051504D98489770@VI1PR04MB5294.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTjjDxpmI8XlHzuZdI79/8cvmlMK1bH71H0RnH4poBA86TYob9sPKCAPx+kykB8HcwoTwffRWalzjiM+ap6RmNMLuaF8+NgvmyzPbAsVcfGdEgBE33180xAYTmTtr+PzKRkIvhE3zBvuQ/vk09DyJuQluQ6rb2c2NGOo++NXcBxFFe5mZblvhdOkVKBs3FECvwxKYY0cuDxLjXolCmyHwtOUOZK8jaVN4ZcF6/ySVT8s8Fq8Ss+k6yirsdZhmHN4S/8dkMEU7sMaREin88M3/DlfnU1CTa2r6+/IIufP8BsrFaPijy0CrPQEREgyYbBxJLNQtxdw1EDi7/EP8GVMir2qhNR5dHTs/5ulY6u13j+cA7wRKCw7U+glUlVnNkpiMj8Xtm1MM//uombBe2Tde05LTO/8y0BBJ9J1ybffAEGGd0G1PdpcRAHB/bJyM4Dd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(26005)(8676002)(6666004)(316002)(6506007)(2616005)(966005)(36756003)(6486002)(66946007)(956004)(6512007)(86362001)(4326008)(478600001)(8936002)(186003)(16526019)(5660300002)(52116002)(7416002)(83380400001)(2906002)(66556008)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tbRQVrkFf+JWD3La2BwP9mS3YJjJAsfKI2AACbBx8HoceVlA3UI1FN/ItoSDJeiJ0Ioke4WcgSJtowjE8je7M+YCzhtqJCYcem3IKBRPEUCvQXKuDaRixFmrk+oNlntAKtcNSkQiHYaXM9bQT+GOnrAfiZ9UZY0fhHtT9yp2qS21PU+/p20dxtKK1wJQhXFfbPLSjtx0qG/PKUC9PQm2UYFCaiI/dO87A11aPR0W5L/ENsWV3yGDuG15dSxkuB1h7Tbojbx0P3iYKhSjuZoqgu6n3MesLlE/EZinLQyLbedQZPo1gzdOTH0uU4UwRrOxeaBL4qMoPJwFQLmFbocotQirZ1Ee0OhcmDEwnuhYOAbyP6oJ7fzC8qXpTxP9o+NPEyt1541XRx9+iaEwNIIo+Ht4eQqpo34wCYF6pN7TFaV94IwCJs8lu9I6mNFmqaPl+By5Xatu+4P6jJz9i7rt/BHpywCE1tmBS1IsAlUpbFc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427d8a82-6b6c-4361-1586-08d82fbd845d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:09.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qY40OsycW1JRWLOR7r6UU2TO0ZEizLgXYnJZF2qOjtkzabaDK73ADl84GJACwI8FDB5xlKpWes6Xel5TaaBCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5294
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
v11:
  1. change dev_err() to dev_warn_once() in case sdma firmware not loaded to
     eliminate meaningless duplicate log print.

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

