Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7E1CD4F0
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEKJcY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:32:24 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:44648
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgEKJcX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:32:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwpGE+3mzGjO/j2y+TJRvrBc4IPWgAjMYx2/+QeMpY8qIiIduCInSpjKS05QezHjT93RiTVnen9B0BRbAsSS9WO43C56uELjFSXa+403w/s1f82SNA2xY5+r6vDFI59YzvHVz2I76fEGrbZihpr+DsfgIdbO0W9xiV5agFqOVajIVMKQpKtAuVg3cjz8slX9bDSEK6Bc/ELpZecrjAWG7/RzEiI3OYvh7D2R2XSUKdRVf+QV4YU03WyoiY5d4WwS8+kSm9yKeegovBKb+OF96wzZuHNlZkyBv60dyQBEPGwXEKAWY+kshOa3n02BPpgiBua+haRZ4sn0n2Qpf2RhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw4icEYch86s6OwQMtMQ7hmk2R5+lBdfcIpDrfc/eIY=;
 b=bzU7US18toWbmLTE7IJ1XJspETgT8n8As4m/hUBpdCjyMU9UCbiMVMW9qMy+J2prccIxwWj4Qg88VuNAni4LeFkzZtQqv6NPHSsxyZqUxzqSolkRssGoT6WoIDQbXg6SmptjnlU8ynN692uo9bqrmNjy9VnClTh5FvKsqAn5o2ok/U+ASD1G8UtzIF+U7ePNQdou9RcoaD3eUchjbVJKydm3V/GwRPPZpkwlhLIfBOoeIe3fV4QXCp3JD7wKZvcu2FB8khfhvYSd92cySrmE3/FW3k9ZIb8sCFaNcqlSZ4s9cLIpExLubIr0WLodJXeWG2dWx/xAotv9EyhiYe/xCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw4icEYch86s6OwQMtMQ7hmk2R5+lBdfcIpDrfc/eIY=;
 b=UZ9K6YB74kgzRUgh6m3e37bRocDikciZN3yZ4BZSCmQGJEl64/tBUfRRg9d8odDCFepeHsxZq146GuZir2twVq3DuDSrjCHU8hg0pJJ9AM/NVsbbWt4jWftSkw6vfYQxkP70J4BxHkCcOFJBMYaj+0rJbLrB35zlVoeJGLLijEQ=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Mon, 11 May
 2020 09:32:18 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:32:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Tue, 12 May 2020 01:32:23 +0800
Message-Id: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:32:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16dc4423-3d38-4f56-4338-08d7f58e32ec
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:|VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6637899A80D3D3E9BF184D9F89A10@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hy1lxUDEydm1xunoLGiRFWq4zeVB2beXp7zJ1BJj4MWa5C5TlwlMp/2ziJLe2rcXcTc03Tj462zqGYVHdEMLftjvXvga5CamXXAhZT0rI+urmYLBakVs5nb4Jhu7k906fjz9NSl8gUwn4SRMniVAuDTe8pVe5eQYsh62lzwjEDOGBZEBhDLUxkHCRN6D/c4faRQIPD1lCG6AyLz8GaoLvGX5qml5I+Zk00At5SSiRLyu3boT/1hB8RVOXP6jl7/72BrrwrketOiRPdV/mXDDiVWTPW3mh6LFjVibdITgUYQf1CLo9tfUoWTCBXmxg7+YE7QLktZDaeXK1ggWnvfJm3lBIeATy4LoUYUjj4CSOe6XZeemOuS/qd2+7NOdY+dAi6Q6uv7aN9YubPwNjBj/oyV4tC7UpHLMt5CptDByJ+TvSv4mJOYwRcwyydzb4JehLXLoeEC2bKcry6dj7QrGprHr37Q091Crq4dezkNxXcvLr/CAM2YgAQS2BNLfZkWWh6sHA2p8sEUd6g1s0xQccho9sAvPU9nAYRr5I4qKvhux0FbqjiIgeg3DGa/9dgNMUOrpk7WOd1b0DDmQkqzF9bTn0VSt1OPZ0VdiTIE00rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33430700001)(8936002)(26005)(52116002)(6506007)(16526019)(2616005)(186003)(956004)(6666004)(6512007)(7416002)(5660300002)(2906002)(4326008)(6486002)(33440700001)(66476007)(8676002)(66946007)(66556008)(478600001)(86362001)(316002)(966005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IhjtHNL7PFKNqV3w4YPE5yZd5cNUfUUrlQSMFR4iaXwcHiXd3tU75yrX3cvzT/EC8QlwtKHxAp/nwWKR0Iz+pZ9OrnRFyhX2Makfuf+jlYwr3Hzn6E1vi2to3XGejRgIlQlzRId39nkOS/P9VsRXA6CgIs/moXD+cYQVZWvepMPi92eR+P+cvgIh5UVd4Jj0e01ymMJLGkMpFGLTSuuh2yMSNyMP/sU3BgEG0uIif6sZ1Z6JG/2E4oSDOL8Vxs7Y+sNxoHqHWHlUo+KkU9R6MvTWSDcKUaE25lgByaWmymCcBogYyADZXlPoHkpSpQDqLnZDj1gMCZ9WQtX3cipF6FCYyqM0SxlLhBwDVStcbjmUd5jrbdU6a+IoffBB1bC2MF7gBBkyF9rZJGnq4R1q2y3SJr3gMd7DBLn8/9pRYNyzVwvPMvG/EEm+DdTwewR/mljk26fB2sMzYKrKICerU5pEewBbMrSvTBsruptBiQU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dc4423-3d38-4f56-4338-08d7f58e32ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:32:18.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB9JlBzK6kSXffHkscCDrEcDhEPiSc88IFuCA/hMoQXPEvfCOlWGZU3toEOGGE32HXTn/y6qUpAHud5Rr92Esw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
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

Robin Gong (13):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: fix context cache"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove dupilicated sdma_load_context
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
 drivers/dma/imx-sdma.c                             | 67 ++++++++++++++--------
 drivers/spi/spi-imx.c                              | 61 +++++++++++++++++---
 include/linux/platform_data/dma-imx-sdma.h         |  8 ++-
 7 files changed, 108 insertions(+), 40 deletions(-)

-- 
2.7.4

