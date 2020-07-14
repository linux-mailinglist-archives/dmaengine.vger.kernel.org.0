Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89221ECB2
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGNJ1U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:27:20 -0400
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:42625
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgGNJ1U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/Itw9lwDsPzMhfaHKlYPpw9L2zIam5NTKnMlB/sv6hXaS1zKvHqXKK/egHD3Z/dkFSI+wcropflay2WmRGOu9DMPEj9c50glufhs78Va6U7+RlurZ0z/C05KEnVEHuzlXCJx2pw1KnpWlvuVYMlQxlkBXY+zSsMcYSsm4DLBF4uP0G8UotQao8g8QVxYrf0qD8n1VLo+zkv/CgKQGnc6ulYB2MjMoEdbbBR8aeLqoUhM2vuEQFTLrwgLP/XIVutEQCKZmLJ0XfyjdCNzZc7eujMl+AJOwjAV59q+sQ+K48MGeSabDG81u5hEb16BpLkRb2YPn5mdGVCPa0w0QpJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr8z1PgtHqsrP94smhtYxGqq7vebsC3+BUQnQAmy0A4=;
 b=fM1ALwZ1fF0hqrTuDtbFZBvWqWGwZwIqw7Rs4ccPlV8Nch1mmDfi3hhDiUNPDoVGetc80nBowlRCSkXEZ76z/2JR8lGgLt6W1IO69mMdmqEo/HxSUKX199//L/fIYQzcwvvcLepGUpTXnRKIYnPi/WuSLHN7EDb+Gs2weIHykqovzQnNuy7iDOvL4LIVrnmgwp4pfnNJCm4yQ7lTglwCpM8VkBTO+wnsIYEkTnMymcAdYh2bDW/s6ZylHegYB4dj1vZ6bMQUYyRw7O4eXWCU0WBVX3pICx2Fn/0JsBPKcGcO7jNECbFiuid4nhNb8+zC89FpIbOLD5xMnW6lFuATGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr8z1PgtHqsrP94smhtYxGqq7vebsC3+BUQnQAmy0A4=;
 b=I3QhAvRt0eQxpdQKWyr37YlWuxI2WBvjJ5av2jrLkJuqQMGc39S2k3+8vXgTmHu3qxxd8p7P5cuXmKLyqnkJtoa/KvHq0aVsSbNobBIPQAWc1kbSl6zGd75MQyqunh9OSGi/4OqfNel4txeCo0HZ0SJQIGeJD/Thq5LuZG4HTbQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:16 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/9] add fsl-edma3 support
Date:   Wed, 15 Jul 2020 01:41:39 +0800
Message-Id: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71e9b69b-04fa-4621-d6a1-08d827d81921
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB627060CA620DD796B52F2A2289610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qB4kIznkL1P5aEe7wVgtMJVNHhchDsmRMCEnhh692q+e58+rV29Aj8np333h/j1o5QTajylfooDwhqxJBPditkNM26LlmaPmrohbFh3IV4SNr4OEJtUfF3KS5DG/ZRZ8EnqRobDJ5Y1XpKMitNDRpDMEGmhp4FAgRUTdhk2K6MS4uY9l5ZCa5LXnZ5DjwPFQ6Rd730eW4ue2fZmYKmJYc06FwXYeUaaPBqYHPUnfM5SzmuWGn5LUJxE/8yfXevw2J9xwQto3SUZ4r/MDakAnURkxtpKexQlBzWRvTG5t7ZFFuWsR4JgL4fx1aGgvi+ufXmiZulI1xYXACLaG8WkR/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(478600001)(36756003)(16526019)(956004)(2616005)(186003)(6666004)(26005)(5660300002)(8676002)(52116002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W6s+wRPOVRCSjDKWylN/KBnB/mIfOkYxf1xpRFsvQ6aIO0+NOkcJJS1/kDsXhU5MRl0YVIYTHjznZAeI3Lm0H7T9sQP4sCNBazsgc/Z9nODpvA10WJEL+x2gebMpi91Itov4WOZIXHgKDg9HcgKFsGJihGBlQ+ri3CM8lVFXjp5o3dq6MgQ/tExdGwl2yiIDezl8Uz4SO2Ajw/hYyNaBFOmybRZO3zYbiJz56iKUIZNTGjsO6aCtTJ+3oEPaSKwcTZj2S7IH/lMfMQwv8m16WzmtAmcqEP4VkRynZNMWYGYde0CiXNgqW/m2zdslzTg9cHAMk+E0MPn8HDz8ZMLLuvu2ATMHdwQkFeBbyYOBui7A0dn6seDPGouQiWLMDdV2Cd9Y9cHZ4WFDou3BPZeEfWAIycMoQg901Qx6ReuMxS0sL+P/85dn/EMuwNtsxwMIWo1wOZj3Cmy7VBDcDhCgNCF+MlVoR5UjdPNPvX3LrVs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e9b69b-04fa-4621-d6a1-08d827d81921
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:16.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqzUEa4JNvHJ1sdQo2fayO7oUEcZNf8ztqG1HUrvTPevZt6a/MafKCqSxcucfbDRf2SWNgZ4EAXP8f6VCvQGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
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


v2:
  1. fix yaml binding doc build warning.

Robin Gong (9):
  dmaengine: fsl-edma: move edma_request functions into drvdata
  dmaengine: fsl-edma-common: add condition check for fsl_edma_chan_mux
  dmaengine: fsl-edma-common: add fsl_chan into fsl_edma_fill_tcd
  dmaengine: fsl-edma-common: export fsl_edma_set_tcd_regs
  dmaengine: fsl-edma3: add fsl-edma3 driver
  dt-bindings: dma: add fsl-edma3 yaml
  firmware: imx: scu-pd: correct dma resource
  arm64: dts: imx8qxp: add edma2
  arm64: defconfig: add CONFIG_FSL_EDMA3

 .../devicetree/bindings/dma/nxp,fsl-edma3.yaml     | 134 ++++++
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
 11 files changed, 849 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/nxp,fsl-edma3.yaml
 create mode 100644 drivers/dma/fsl-edma3.c

-- 
2.7.4

