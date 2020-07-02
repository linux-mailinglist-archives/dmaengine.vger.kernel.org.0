Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0173F211C29
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGBGxl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:53:41 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:51975
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgGBGxl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:53:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylk3bjhE74PbhRvbYq7Z9/bJJQzXlY8Bvwm/m7zf4Z+CEIlVdOXZJGqwQFNA8pJW9tYyxplFsDC07HbfRhNNbHyxcLc3xGO/5DtuitSvtqgGxkKt7P/Do10blD+8R1WiHVQKaS6e5yaZaET//NwhTfvFPiNrAu/z3Q675rMForSLn7h4ayo96N5+B5TAt0+BU75rZ/kg+1A7cNd6enHuQ5q4CqJjlhJj2YWt2qsSviLALu/DDAT2Q5NhtRJbeIkDnmMrJVL4j8LK0bExjoAsbzplTKkWgkcObOu2K6Hc3ccwwKDyDBCN8Xg7t7FOOLbUNGk8It6dIRSRyHRoYKd9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEwFDhbvzw+SwNzLA57qxwzxTZmYyID+lEWSpd209Sg=;
 b=DrGOdRGuQCFZojdk2eLS1FcrRG0+DxRlMHnNgAiOjVg7cSr2t83B1/AcYoIk7CJUHFTfvOmtBqUOiWpvPWGzEYrc9V5fTuZ4dCIY3ZP1IQo6bWPg8MFaGWK/0ymFCR0g7VDaodx/XkSIyhiC3j2Slp2Uqm3/RP8qedaH5D6fuMng2Y2j6xm+dKs0IbVkd40LgISD+oYmVdJHXjNUfBCN2i0758KMYvVt6wWd673m/m9bf1E6W0coDFxDILsIjleMM2I6DqCeYOBWEnaKXQvsk4Hqb0DppLlAwS1W2f/fxYTh9Uzd708C4pwYw1YxUwn4KCpUBzU7/xU0ev/zw39mYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEwFDhbvzw+SwNzLA57qxwzxTZmYyID+lEWSpd209Sg=;
 b=aZUSyi07CDzMRupH8jzKogZ7BwUv+OmrGfbI/9/ngfbG+GA6aVBNhYm8/E0NSuUJSnx1pUF2/DhzZvucsRJssKfrszHGPf4phz8tb7ix27DyLHyJNCKkjOHqHbzysewvdsSnDCfiEBWp/U14Omd0P/KMy2hhmvldi5uEt0mZtE0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:53:36 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:53:36 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/9] add fsl-edma3 support
Date:   Thu,  2 Jul 2020 23:08:00 +0800
Message-Id: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:53:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19c00ea1-79ca-4ebc-0c27-08d81e54a4cd
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694352D360FCD7693F58C4D3896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F50p6JGoAYuKhcIQMDNWrEo+iOcpHXAIVcQREboDXRAVYcIqNpf7cLHBBR052uHPY7gIRDjmNNchiuJiTcsqjxtzHLxDTNKG1YZbpJjOl84ssA6J0pI52X2n23YjDmxLB97fqJer4KepJynEiNMBkwufrRPiFyF7c4ozbAEXO7fWBCbGvweH/ZGNf6WmU2CY8day2KmufGOVTvL/JOrUvCdxRGz5tAksDHeXsz01cLJDW7IuBxdGCZH4PZ7q8ACtmiAyIkZ8X7qSMREiZur9FEGY3WKin/M77MG7Yyc2ke+CVYr2Rl7RYqGK2ZaOLOYp6Zg8KcT/pNkhselb5hKcAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LTWeDXTJa+HHHOY3JzNJJaQb82g3te/SmI2L+O2MjpRHqikJeHmsap69Yh3JYfQOB9OuqY/me3D+Ywc44kfOz9qkCxOFjI2SsZ3YuppiQBAxSek0lYekm+4ZkeFqwJmxeNejLO8Pk8MAd6DFcGXBVD/vB/rXgVgqxP1LumoVg5gGMychC3e0DKRjyZMAZ7diP7Wa7vHZVBLMzKp/2Fzo2f6C5Vmt5HCeLVxTRbLAZNtruRgY7z2c2JE8GDozaSrKN39WQzJEF6FLY5Kv8bCwADy/E83Vecaf+gMeTUjojvvtB9W23hwsiMPCqlYtKJbRKbdOmmxEgR3LhXrpv1KlHL07ieMA8nlKP3F9SSTst48te0ULTBPQOl44Hsk/aUw1NLSD6uDsnu+nMhMwetPPg/iz5I/KLTE0KZA+5iGAuJ6NLIKEnFpI27wQucjImNM+pq8P7lxJ6s/SNrw/jRo+KyWZXecXYjvtD9PzHqx66E0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c00ea1-79ca-4ebc-0c27-08d81e54a4cd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:53:36.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpCvgbb8u2oIwb2sOTuhDRqRgCjDCpXGpfpXXt37FRs0K6k5iTVXpMgZUY9W/SGj5CR4XWo3tZ1AXIFqonCbIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset enable fsl-edma3 which is used on i.mx8qxp/i.mx8qm. There
are big changes on fsl-edma so that add indepent fsl-edma3 here:

1. split memory address for per channel, while all channels share the same
   memory address and the same control registers CR/INT..etc.
2. all TCD registers of channels are continuous on legacy edma but split on
   edma3.
3. per interrupt per channel on edma3.
4. totally different register layer and add some register such as SBR
5. power domain support, per domain per channel.


The first 4 patches are used for preparing no any function changes involed.

Robin Gong (9):
  dmaengine: fsl-edma: move edma_request functions into drvdata
  dmaengine: fsl-edma-common: add condition check for fsl_edma_chan_mux
  dmaengine: fsl-edma-common: add fsl_chan into fsl_edma_fill_tcd
  dmaengine: fsl-edma-common: export fsl_edma_set_tcd_regs
  dmaengine: fsl-edma3: add fsl-edma3 driver
  dt-bindings: dma: add fsl-edma3 yaml
  firmware: imx: scu-pd: correct dma resource
  arm64: dts: imx8qxp: add edma2
  arm64: configs: defconfig: add CONFIG_FSL_EDMA3

 .../devicetree/bindings/dma/nxp,fsl-edma3.yaml     | 129 ++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |  38 ++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/dma/Kconfig                                |  12 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/fsl-edma-common.c                      | 151 +++++--
 drivers/dma/fsl-edma-common.h                      |  30 ++
 drivers/dma/fsl-edma.c                             |  10 +-
 drivers/dma/fsl-edma3.c                            | 493 +++++++++++++++++++++
 drivers/dma/mcf-edma.c                             |   2 +
 drivers/firmware/imx/scu-pd.c                      |   7 +-
 11 files changed, 844 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
 create mode 100644 drivers/dma/fsl-edma3.c

-- 
2.7.4

