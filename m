Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699A717EF10
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 04:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCJDaj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 23:30:39 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:27969
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbgCJDai (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 23:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFbZri8aRnEHbwTB4JCnKkwtM1gR83S4e0SVIxmq3+s+cV1GvB3zNYcLtONoFfMX+ByqRAHCoOqWbiM3nAKwF2Pe/ro91JznFirV7ru2m6HIkK/eYP4Y6ZhY4NtQDK5MEGUU2l6y0xKBy+rO4oZC+0o9HCbjtddI3z6lVfGT9svPzJwpekAdc63zJySWoN6TUN9J/IFCg0JMH9s4l/TnWdHjJ+/Y4K0nTToAQ8VdAQhaoTnCUAySicZbcmSyXSLQ+ev58FaWTo6W0w+2BPJAeQgpYojQh5WdExZjzNqi5GP2OnAeHyAG+CbLv9Olsa0AHozBKG5zU5by2xeu72I0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY5CDpgnANeH4Fow9sbcdYTX9ukW6L08CMaVUzkZuiQ=;
 b=a3VGb05tuSC+iitTeSD2Kus8Kip0bTIKpAw5PIJrUXcPgyxpe7ZKrv9TwV/F0PSYrO2UMH66Lre43NanyhVSCI/5LhoiZP/rK9Jz0C1f0xHfwD5/zWEYlCUZgCT3YKN/V38dSq6ZsKlx+ljBW1n/O0pZe8vFTh2yk7BECArtBJAkJ2rKvLEjQjRBkshm7FTaYIOI/iC3kjTKETUcVx4oC5zZnoka5bwgTR2VNld0czvvR5LCbPCxa2IDLA2vo3wRznuzVhVv7mRhG4sGbhmVBdrk7vzHquIRYfp3X3evg6fWfT4gXeiwL89ddcWpgIyCAk0TAMab+qGjYSMwALk5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY5CDpgnANeH4Fow9sbcdYTX9ukW6L08CMaVUzkZuiQ=;
 b=jtiSEvHAu1j8sCyVmVBEI68Ud/JvjmKfkSLTlU2tul/pEeQP3IbMrBlZgaRO1m7HQZ/XGDqd5/G06rIEEdKSd6k0outTJtShnPy8D0uxI1a8ICmPm+vSg/oUPsmtJWcYyrb43cVFusd4Fut6yNUeb6/kEEYRhP7/Ccao3nVGALk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6621.eurprd04.prod.outlook.com (20.179.234.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:30:34 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:30:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND v6  00/13] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Tue, 10 Mar 2020 19:31:49 +0800
Message-Id: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:30:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0f7b4fa-c875-4bc4-b2f7-08d7c4a36455
X-MS-TrafficTypeDiagnostic: VE1PR04MB6621:|VE1PR04MB6621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6621B79B9C1A0982FE17A10F89FF0@VE1PR04MB6621.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(4326008)(8936002)(6666004)(8676002)(81156014)(81166006)(2906002)(5660300002)(2616005)(7416002)(36756003)(66556008)(66946007)(6506007)(52116002)(316002)(956004)(966005)(26005)(478600001)(16526019)(186003)(66476007)(86362001)(6486002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6621;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8by1cZBH+GxvAD8VRg/8gXAX39N2EMh+fWAzXgraGaRexV+H8hPI1pw9SPVXWaA36HDy6Ym9DGZ9B55VR2E2MfGzBu9+OxCoCGZnNy384mdtknN3wNUkDktH/bdTk3g/ezoBr9//aG85Yh/KucW42bb3qgptf+TVz3ICA2XIv1g/DFYmMPF9N7Ov3+7DVuqwl5gdIYR3IJ2O+aXyeriGitVS0+QUfNuyOzOqAF99pnq3dfID0ZFy+gnCBQmK53+BPeDY6zQRoCENl8qDukqgmPpWdoqrIxGAi1qtzdFfUhEZsUKA4I58udSUQDSdTqzl0agYPKT7CikpC73Jfp9qLMtr0JIRgyTvImb4OOeS1PKp/ijMqMz66i8w9AAdi9Qh2/whJ83tmtQNQumz8mwNkhLLVc64qEeIwMemUIUYa6k7X/ORTa2Voj2F5tNPtQx8IOEz6xK5B4/adHz0UdRsmwgvpG8XIjapvy98T4UDYv8L+I16WADCXIruwlwdm7jEksoyu4la61tGolYZ0xMgUqXR3zkK0yGXbqNGBGRUEwmyGcDFhcgQJQyECYEQz/U8Ka4DHPJhVHbmKo+6qo+aw==
X-MS-Exchange-AntiSpam-MessageData: 66UEprSh/OYdr7fbPR3LeUWEWI87mAPkG2WlEQt3W3H1slNeBwlsJbArX2egbzLh6KS1e+FZeXP6dU4vMVo5NPc5GXbhGrM6bxNe2VfvBhkvVKLd6LFtlYk/NY/w+bXBUov8kWtxrTfSt49ncYsbrA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f7b4fa-c875-4bc4-b2f7-08d7c4a36455
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:30:34.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDO+d68YDKdtSTDs2EZmKX5kT/O6Cuj3d4xjlAkfUpOPfbTxS2/7FUmx8rYwdBHZaF58Lxuh4qo/diDZxwBlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6621
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

Robin Gong (13):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove dupilicated sdma_load_context
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  spi: imx: add new i.mx6ul compatible name in binding doc
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul/6sx compatible name
  dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
  dmaengine: imx-sdma: add uart rom script
  Revert "dmaengine: imx-sdma: fix context cache"

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  2 +
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
 drivers/dma/imx-sdma.c                             | 89 ++++++++++++++++------
 drivers/spi/spi-imx.c                              | 61 ++++++++++++---
 include/linux/platform_data/dma-imx-sdma.h         |  8 +-
 7 files changed, 130 insertions(+), 41 deletions(-)

-- 
2.7.4

