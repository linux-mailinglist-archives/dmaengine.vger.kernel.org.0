Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991B1257485
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHaHuh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:50:37 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:64790
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgHaHue (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:50:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwZ4uJ5Al0hCIqZdzb/22sqnNYGed4Gwwxsv94jBb67tY2ilgDOAaymzzYSWedHP66ISHUnrO5jwafbzLhHQmYNgGnnpAJJ+vvsyUWzpf2LxgVJB5oWrbHCku4IBu/SdeMi3/VE0HgxUOb4Xez6gXnSs5iaSYhanOzIX5+255pcxXeAfaGmcCEo/YxO+zlRHv5kSo87aTZJc9K73RjDOgKS+75jp6lFnSwGUj+vIixr4+++/epSd5qhcWbOOiMruSpcpsVr2Zrz1MV6B3edbk4a1JYYwdFix+WlkcTS0lDAlNImVLbxc071GErixJzmaCY1xkcXq2Q/j3FysQuTZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGgHSyeZLcf/CHQdSX5kgpeCMv6WQGZSNkBfFcFNLE4=;
 b=CpB4VdgKuhpjlH0uOM4PZtmER65ggQyQgjLP9dKERLpsWanBSAXBIsws+388dGeBM0905Y7YIYHP1EaX6ZvCR0cXhefDq1OHehPNQDk2w+mZFQ92yIb/JZH/q0UOARTtIaeJQWuw5aDuGLO0+ib2XksZvEANiwOwxGzq2FJX63DwK8+CO87zcMBRSHJeM+szszCDOknEPO62gxtKAn1ffawWUk0Wj/cGuwOw6ZbGKO+cQYcbct+ueWg1t1jIwVHeczfd2NUXY+yyMtQRsoQyCvQ/m83//HF4kar2bedRT7KbT9LcyOkhxqk9banfLR8XpPsxkLeE6QSdJ8pOSYndzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGgHSyeZLcf/CHQdSX5kgpeCMv6WQGZSNkBfFcFNLE4=;
 b=Q/uDGanETxLqVWtxPeZTYBWRlsSUkdPIZNmzKtDqdvYhOsDSiTGnOzJdwHomR+GKfBTaa+B4fstd/wOq1dnHdLMckPTjA9qWW4qLo0xbCTsT0Vg194Ls3Yqq1eqqMeX3xUa+sgADsz49R/PNxvSbEcFXF8YUohC3s1q8LYiP+e0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:50:28 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:50:28 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Tue,  1 Sep 2020 00:03:13 +0800
Message-Id: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:50:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa039b52-2f3d-476d-aad1-08d84d8286d5
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694EB7C05B7AA06E9DF978E89510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0PXYEycHw9mA4bijOuqZCUjKl2CZDNVLJ4Pe33UNFlyimgH2Qxr4y8CtVXO+6RF5c5UUKGfLmt9t5XXFrrTdL62ri7gh7ArzX2cJMUvcF9xm3k/vigHmX10gKuR4vbls9+diFYRVdiGpY0nqZjkPq+ZP71I91nz1sEREoeRG4lIWbyNEe/tsheqnwcUKRhaeuGQphsjhRPzgXSxlfWRBWssQVI5C6f27+fNRG1F9ru9ZMXjRHllHVkQK4Mwt5RAJQ4wHrINMN/sihCIeYMVXNXv4zyZi5GiElLcS6YGFS2bhhiNTvx1wBU+X2I65+qmDALvdxkoIS6DfqrVXKptu6jfn1udYQiTeReTW6AF4Uiy1A/+yR++zfUpJ4t8z53zvCbKyN4J2WnQwvERb8E2Fwd90Zy0RLSjrW36m5K34EWimkrMs6BzMnVx2GSFygr0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(966005)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ki3zrcyxflim4ybpff89XD3Zzbd8ChdbjnKAqYO9VxyS8tgGD+q6VE3aSmj0jejx95CudmYPXXheypRmyYGF0btqDqA+Wif1Sol4ucdmzQ2f50B8lGoR2AM7WMB2dI8jq2WazQYNBoyD1r3vUf3HrCEZyZBueJZfzk+3Vz9JnL9poEgLgf7cFCWn/ELV3REiXS8luEcZvan2dbNTGwaCPl18TKTTfLTY+3LrClfYuoncNZTtf0eTrYFLn8cKxQNBV0UYMmo6j/KK7XLmSPrsIaqR8SO/5shiNcg5y/ga/SuD17b/wrCQsUL/Kip0U65qSqb2fyg5qKTjTtw/zJy4gs7Q7OP2ODbILRqkdO4jDezgwj2kJejLh3CaX8aXb+NQXFYbwpQKZ9tv94AwAnVoPI7hyaXo5gfz3XYPHUnipWGrE1S5vHfu2+IkBc6EnMXFdonvsD3ykrWDmU1TsLfFmdgdN2Bqm4ovAC/PxC7oe/3637xnlTso3WQiMEa+SKzxqTdRko6jpxSPwWOiaF84vwpZNvYKE0kD6zFi/PXD7dY+0PESvM+Jh6ChoJyKnCTjApkJOYeyWoxhUI3ikN4acprQ0qdoy6+VbYHv/1yxqLoncoyxQkOXVoZkAIJPwnPNpYxxSFd4Nh0RLanbgIxbwA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa039b52-2f3d-476d-aad1-08d84d8286d5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:50:28.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3lpokw89YcHbuOwWgOcGuKHfXxFyFbwBQrGBiGqIYYJkE1ibSb1i0grp/ZjxtbD+0ip4Jqr+zRB876xs4QBww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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
 drivers/dma/imx-sdma.c                             | 93 +++++++++++++++++-----
 drivers/spi/spi-imx.c                              | 52 ++++++++++--
 include/linux/platform_data/dma-imx-sdma.h         |  8 +-
 6 files changed, 128 insertions(+), 36 deletions(-)

-- 
2.7.4

