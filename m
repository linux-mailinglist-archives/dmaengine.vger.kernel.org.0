Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2A3564DB
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbhDGHPp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:15:45 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:14848
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346238AbhDGHPo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np3rJQGPhTKWK6QXZDs4Isz72kxdU1D+qaKAZ38gVxoiLAwhqwSGQB+AzHmLdFMs3UzKI0W1xdnzBZt5uRtARcZvtZYNUd0dSdhSZnrS9ERQTw64zNllvQGOfru1jjYaVB5uf0PYB7+jHIDCkjFui/kaHxuWrnV+B+t+zajnG53zpINFoRWoH+b2TfG5Noco9Lz9BEmmCVvs6oAbrZEYIcWuP3iaB66xV8jHZeL+2oqhlxqAIOnsp7j++34am5f639IlBCt7QOlI6scgHlZ8W/KEM46QnVUtC5KSJklRVa9hWTM7FtvQW9yA3tQ+hnIB7rfzmOqLdT2GF4seajIYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lWnA9wGOxcDPpLgRhLIuEwbr4f1dzMuNuurxFOSKIY=;
 b=HKyM/dF0KyIW9672MwjovE6VU21LMJLVfFnsll3fA/gIMfMKWmlIUMTGAZmaqMVLUWGyjQM0pyvH/5/rdQPJPoQmpZy48cIbCLwqTAhwaE1s2nxPZv3K4g8cb0Cok1dzokTG3/VL+7CIen7NyBHzGUWhc/GsvNvCwq01+A7U0X+iXpVg9OqChVsqxFvMODQcfqkFfyxzpSmGY4hjXxE6qTUfUtp6Z3tONm6yYGbI/QfMgM7ZcfQHyQi1WKFYqONvsJ5UyDMIFC+TC4sQjGxVTBDw3Rg0KqSdNtEpAkFa/HkSChdHBEdne9l8o+tNUb5FoybuKfZIv0gEcreTy6nAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lWnA9wGOxcDPpLgRhLIuEwbr4f1dzMuNuurxFOSKIY=;
 b=W3BrsBSJ8Zn+SZImXfDlcL4CBZ5Mqw6cuxXnIVpOHcMdCYeMoLU8AEmAkDq0SAUCQympDrXEjR7Q/kUnYZdFe6+vL7SYrvmLR9uou4Jd6++h1ySWH7unKqtrahahFG2EEFmkcYK8QQ2MhPn3LmarFGE3a7ZQ5dgCL4MtilvKAgs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5501.eurprd04.prod.outlook.com (2603:10a6:803:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 07:15:31 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:15:31 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Wed,  7 Apr 2021 23:30:44 +0800
Message-Id: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:15:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcba6a6f-7067-488f-0a3c-08d8f994ed81
X-MS-TrafficTypeDiagnostic: VI1PR04MB5501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5501CDF2A70012A8C71BECA089759@VI1PR04MB5501.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QiZguTrZI7ede1mCyn8yROvk5RUH+QKWCzZn3devcMxvOGqECiahuftlPKLg4oU5+KNo45TSN+uxSglfwujbMLQOVGyzMy/lgLGsBXW92bUZDznRBRAvPAbDuzGIjm6jwG9ukZ6OSqsEM8ikrQ98BPVefxIzwtcp4u0tnhSIK5Wx/oktJoBLldF5/l35K1WzFCFTuqbg2nJZ65XLzMC7dvYuPat1HvAkoO1wPsnYj+agmstU9CLcgOmoDOu45Nt/1rLZv0xABCF+wut+IVyLViLUxnfs0+x+xdRRn0O7XtR7byibXqIWEk5+bUC8NS2/+vjuptThUQNfMc/A7d9aVF4KQDqPPsfVITR3xPZ1R/B6wkwUrs8xH9BA8Mj8dIR7jmNlpKhTMDZ4KkZo+ZMTHZg3Deetee3PIhRYT4H6LdCh5s5kvL7S6yC7jZEHN1sKP7MsLqIE6gSRLL7NfG2w6DGsHkKhLAWhLpF+OTQbEdFZOp0IR4RGtlbW0j6NUv2qGw2LWP27uY0gl+OjK6EGudRJvwh75LcLEc+ai0pjI/WZx6G4C1y271Lk9C4avUbJyz/zarT7bwTy3mFzFivgKOEc8xQA9GCNpyD1a9qZ5HU+EEculodyNqadmv5kHZMMF7odFEtF31qWcD+aw9TEZ/XFrGOW6DgjXVFV2VF07LpHZ4IwKKBkSByVV+jYFDYl9osqoIabSDpYoHUzdjCxTxfjZmdhI5+ugddITysSxbJ71Qan3Pk1x2vQqIU2hLLvvBlkqMsnueedMTeATg/pRtlMhCPdJKbXeqNapiH8Lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(38100700001)(83380400001)(38350700001)(921005)(478600001)(2616005)(5660300002)(26005)(6512007)(66556008)(966005)(2906002)(8676002)(6506007)(6486002)(8936002)(6666004)(4326008)(86362001)(66476007)(16526019)(316002)(52116002)(36756003)(7416002)(66946007)(956004)(6636002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NGo2njsh9lVmJ3J87xXelRPnJshtXADlYAWTYEp30+jDn6Y/60157rawf+eE?=
 =?us-ascii?Q?htf+XcGgsQHfYnBhMPfY7AEqHREtTIifpbzZaYa1+EMrhJFaB5ixOZpvQhjm?=
 =?us-ascii?Q?VgxBWMK9cV+PH8ZydfgVTSiAWORMNivqtxFQUe6SC7B6Yswsx+1NaxIpzpDM?=
 =?us-ascii?Q?uFZWmioEE0hEc/LjtLlspf7dtPYvrlgZHzA4CPmggvD1xyMyDWB9nN495oQQ?=
 =?us-ascii?Q?FsjePYF1/PmivMo4bVzCjQjsKdFVl3hu0FX1LIYnd6VT4UNrP4Qw1QqzJsyA?=
 =?us-ascii?Q?O9LZuQsq1e28ILDzvIybkg//jyLiPhFWFLEc68idAsuXbfVTH7Msxm34dNGY?=
 =?us-ascii?Q?pi72qvSEfZETVhyj4k1FyS9ikzsGkCsf6w8+h3tZrRcrmtNCHeCTDWkKbaY6?=
 =?us-ascii?Q?h3Ips7Jej+/sFJHBKt6aRJxr6aOfB1SKFBhq5I5SHMryyTvceG1PSzT4ChxF?=
 =?us-ascii?Q?xbVxerDNlhsFOwcLlKgDOP6RFVDAmZnz3HBipzadudWDyOFnIu5njgA44uIC?=
 =?us-ascii?Q?6cHxVVvqGhSN1vdCz4wUlHAKBBE5IeSWJP2dxkEYPaLMgFzZ+G6ii6+7lH7c?=
 =?us-ascii?Q?hXT+ebE4HilVJfNI0hc4EQpUjYU0sz++yidaFzFV2hZh5u0Q+UsrdD6IhRMc?=
 =?us-ascii?Q?K7uy6J39IAedE+LbbP+JmPXH82oErLoidap5ng0xNKPVEFlkg3l8/QwWCrg7?=
 =?us-ascii?Q?5NGBF5+3NBW4GKbptwarGfszItxQGo2fdlYCT4oUGBYbV/E1K1Poa05PFV5K?=
 =?us-ascii?Q?KIr61bqpiaOIUCjE/tvmikAr+segwP1D6/47t+1zAlj0IAQ2lOR9rjg8/A+H?=
 =?us-ascii?Q?83RuGh829KwQ0KTTohZMphRfftP1UbZ/7jGdDUTJeWz3aG166TDC8sGtP1Lb?=
 =?us-ascii?Q?NldV/ZLNw3Q2ER5wvgt/Iy7moi1WfilgkWMmmw513AVfYpSD8adk1Ah2piPV?=
 =?us-ascii?Q?5wxuH9TzWnMpUpQknE2+SgbW0ioUBVK2T/nPLgNn8WupaeJXFnMj+FU0siZz?=
 =?us-ascii?Q?AGVvvDt+o2zgjcojJMRKOLv8QXEUsSmKq+pT17E34SNOPfnhPoWsDzBsBe0z?=
 =?us-ascii?Q?7gLcGwyQTqZ0qAXzVcm7IrFlASn/Utkv0et8d5G+wFzBZXQkvEwMUkprbSVt?=
 =?us-ascii?Q?fvpncEjm9Dxd7IYxkfFLgty8SVsRwLzxbTjPRUoy/gEBjPCdGuNBh5J7BiKK?=
 =?us-ascii?Q?u76dr1P+snNOH/SJYRBlj42t4bvY34dZ6P2QL7q+sVcDasmvyaXS86xbiANs?=
 =?us-ascii?Q?szewLfe44bC296CmfcGu3aOy1K1WBUPgZWvZKhcg09+mukUeNA9/7Lkw6Cs7?=
 =?us-ascii?Q?4HEKSV5zkvpB4Z2XCUwcb/Ml?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba6a6f-7067-488f-0a3c-08d8f994ed81
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:15:31.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ezuwQj5FEEyMDC4PmIkArnhOOwX2t6j72qlZb9MjrCX1B6Q6lfMFTZX3hFBU0+8TLYq4HpPCYF8xSBh6Ik4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5501
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
 drivers/dma/imx-sdma.c                             | 90 ++++++++++++++++------
 drivers/spi/spi-imx.c                              | 49 ++++++++++--
 include/linux/platform_data/dma-imx-sdma.h         |  8 +-
 6 files changed, 122 insertions(+), 36 deletions(-)

-- 
2.7.4

