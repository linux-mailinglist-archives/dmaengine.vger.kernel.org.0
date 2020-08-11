Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE416241746
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHKHjv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:39:51 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:21889
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgHKHjv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:39:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwX8qKT3wglDwqBCkpQVMXKMdSV6EmU87f36e9eVzLsaziyRBjKVWREQOYCfNjyekOhWuX87QCo/8yUhO+qenr8TdN6lojN6/67/HoTIUOBSNtdkxAQZ29UvQS8PXea6ydge48JNi7YBsNjpsxg4fE/KJD8Mz45xBvKqGyZfOwYZfN0mgZJT4vtypwZx1UC21ZU0AlLGA6aIXXSF5NZOh0Exdrxi07Wf/DAG5CcsT0EWBYDFDAc8VyK4V5ac6NokOAf7mhCTqsdOpbWbQEO2/PJF/EuuzEwRU4mZIj3smAjXdwbdQv9ToNbMrwWX+xGUmsghCNUfnT4b9wH00PakCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMKxs/ZEjDEgld8kt/MVxOQ0Otgzqax1Huz6azM9aIo=;
 b=cYZqcKT40oXwp1fDQ3k17U/vDt3Pp70vGewGO+/ICNTqf7Aengbg2eHSD5i8OwpEaveJeceJ+ZhsrUMFyeCSnxFcy9LtAFjICde5T+KEEFsPPCJTPG+o4ITW6HmlA/uhWh3n+QEkZMB6jV+OSAw3VM4fL+Lmj9A9+8I7DQkXTZRtX5OMtyne+Egm55IoP3bm9KODr9GBSPCQt3hhPBmW1KIdKUmfON+EtB7qbQJJwTR8cmUm3BKcJZ1iQZ/8tK+3QYMhWA6RN5rlYXpgZYA3k9aINLRjMjf7WfB1Z9HPXd/u3EEwCK9bOz/28eBev3KE6RWe9IQLBEMlJTG7Of4PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMKxs/ZEjDEgld8kt/MVxOQ0Otgzqax1Huz6azM9aIo=;
 b=EXEYlndCfIxP3jalkExqPYAbFML7qyqpjR/AZZntpg7EnLdN7YCb5q6dlWG5xBcgoaHZaKAEh0iIDtWDUzCyHxJrAezcJc60JPy3mb34Z9Q+YlaAirEPfDUl70Muj3z6WofWJ5w3pgnAfQvICx+dOFRA/xpd5RWD8Mqg5hBoqlY=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4006.eurprd04.prod.outlook.com (2603:10a6:209:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 11 Aug
 2020 07:39:45 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:39:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Tue, 11 Aug 2020 23:53:39 +0800
Message-Id: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:39:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 226765bf-889c-4756-3a27-08d83dc9b75c
X-MS-TrafficTypeDiagnostic: AM6PR04MB4006:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4006FBB024BB424CC9A5E45289450@AM6PR04MB4006.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXdzyXHfnZk/ylcAWLhpn6S7VjdHsRzVP38KRHqDkUuhucODHCLpI60ssJ7F25mElV4zr1HoSwRuCDrY9yYwhybnUs/uXpMfj7+Qe0jPyXJ5KlNwP6WT7a7kCl+DHDSO51SJLCHv9fGfIYwrdlBVEawFztuZ98bz3EywcqnoVVB9vx6EU49E/19vZdDuJUYoTtHVHSSOc6LSp+s256NJTUR6MT8+s+7cW/N+02PpiutIzXfkYaqk/UWQu+FYrnXGMjDeDAi5o61ylIeKmDmmckgK++RMp5WCDZJ7nzIVlwHQLdfIdegF6XwsCZTIXb9qiMvtlMfXrutns82MQr6+Pj5SBY/ONWW/Gok5OXbV/skjkHzttCaB3upwJd31Y9Gy/ZW8ZLUNFCL18WezLQTrWwCBFwUQxPsZO194inMe8qVE8tZc0ho/5/XcrEwkGnEc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(316002)(8936002)(6486002)(4326008)(86362001)(478600001)(966005)(8676002)(7416002)(2616005)(5660300002)(956004)(6506007)(66946007)(186003)(52116002)(26005)(16526019)(66476007)(66556008)(2906002)(6512007)(83380400001)(36756003)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jI00qO/DhRJizzSpL4Tf4e9owUxiWY9WA5vRFBISGqRsEtV0kInyoPFWVAAc7aq04vd65B8Pvv7o+XSQbs2VTR53Qo0YCxSSQA0q1i2+7LhXADBw7W6PoJCv6J6nQwa8L5h6uQScC8abF9N69TD2+KlJcUywWhTbBwJnU+DHbBMVtQThv2GVZhGSqsp+5AKX+gurzHIKjN8ppF4hZvh9DtE6EMnpawt9CNtcSIxzi9jxSSCMZbZ2CXxWTWpnkg4CiQdxCRZkRU2Q8z7QmuVIJhQTnED3bColJ/MHUytHFN3rRgCLGLM1PXkENGl+cjJfUU/B5Hw4qNN2eRD/6aEs8fnpcZ+rD4zgAOy4dug5hX+5OZxpf1vQ0qX4gb+VCbbXI0iXaSU0qYAwbmJhJ/jwo0TRP5EoJ659NKcskYOuvnku+aOcmxN2zfvilsxLVtIDSV6AH5Rm7641u5tcuPC1MNv/Lh6y84PEhOlOscA8X2spKv3tJcUTl1xyGFQg8iImqplmxJuhyLBFUga9taEIEh41aX9nAbmsT1x+DuD4REttC99hscLNdvFlGEnmQgruX2eO3QaG3khWxQc8eD4Tuz1bFvmitBKlrYgSeJcPL1oOHtM8CF1KMwaSeuBto7gUSVI9dlNw8P0J3q9190jOUQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226765bf-889c-4756-3a27-08d83dc9b75c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:39:44.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C29B17eyJLxKKpdkV7vbRWXM19P0OiuQFZUi3K2PdeFhMUp9SShFESQ+sLhniCEHiJiVXmmwe2/l2lcO0ZagFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4006
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
v12:
  1. take care uart_2_mcu_addr/uartsh_2_mcu_addr since such rom scripts are
     now located in the bottom part of sdma_script_start_addrs which are beyond
     the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1. Reported by Frieder as below:
     https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2263544.html

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
 drivers/dma/imx-sdma.c                             | 76 +++++++++++++++++-----
 drivers/spi/spi-imx.c                              | 52 +++++++++++++--
 include/linux/platform_data/dma-imx-sdma.h         |  8 ++-
 7 files changed, 119 insertions(+), 29 deletions(-)

-- 
2.7.4

