Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7945871A08A
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjFAOld (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAOla (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B552199;
        Thu,  1 Jun 2023 07:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNqjw5hOaoEExGbBQ+xqQoDsId7d1BRAJtyztzn4xgtJwfKbzx+8g9wLsCKLwPVQX24wOPDmtTE3wa2w6bwJVvNWi9Un85xfVH+lO3/+R9E54aLJ0c7teOEjsT0/8da0H9Pyn3W8rm1TfT+iesdd3D2H+c3ySoE3hxMPEKOASmAkH11TQq/B9PWUveY/PJw+ZrlLzT5ImJwLNFjNiTghMWKdfgcfTDOtObkPG8of8ud91rRwMgd8CeIuROLXkssZs4mgu08eZPqyg3DkgDgsusElvW7eHHt0X7FNJ25p8p4mqcWVT6IYNrFzNai6p3uo1pWf0tEi03/zei/8hsy75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOPXwex0pun+btEM0C5xmRDRr/VI2D1X57lF5PXz45w=;
 b=ECG9+L/y4rsUT4hS4yOxgKOhW1IAkJtc0+FwWhkVcvD89azVHtDrRjUQRNdADIPpq16Ngdl4MvlSfRolryTRqjIwQ1s9BUrNBWnlsfLVeL8ln/K/YXoZOdfxvV86EHYyDPsC7nyXRpgRWPq7gpIFoBS83svfO60jnA2h+wRDx/+FVUtIzoV3aQvvpgzb8zs6dXQrNAbkqJn7ndTdio2jW0fxIxAjWgg7C89xivTWK5uZKQO5YVGaRWu4PdCAhktCfjSu5dgIfVLb/RZc7YiwFc4WFuDH0WFgDIOjOwc5UHIXe2uDwu3k7kVwVBhzenrPy71O5TDsmfCoQk4I3LWPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOPXwex0pun+btEM0C5xmRDRr/VI2D1X57lF5PXz45w=;
 b=roFwHW8fD6XqvWgG3dzoKq3fHY05GaOudVvb64D0R/5vRI3ijgc5/vv/0fA2H2Ur8CofSZGhuwv1wIGvJ2SijZZsit9cMMJS3yclnxMncE9I7C69RgvZMvDLlho2wcEfD2WsYJlbQDb/Ey7irFIG9/ZkFunsFKbEGAF1ilN+V/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:25 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:25 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Thu,  1 Jun 2023 10:40:55 -0400
Message-Id: <20230601144107.1636833-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: afc2cab9-2f0f-4f1d-e72a-08db62ae46b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1Ki+XljBrn93vd1SQMaSK9Jg1layrZUpM7Eq8J1TU2mdkcfOW0KB10p9sQhLHwrTlCqyvGajxUAeJVXrhzlJ9QZ6PzM8mPhBz/imEDfdMWNxhE4AyP1Pbge5sUlScvXez4NkxSjApezSJFOnHHNhJNTj7Jvjy+2hGP+G16ldu3g/NZMGkFGJR7Tb82dHLUMG629DXu0aW2zd7avdIXntptubG4Ba46wSGG8oBuLcpIcHdYjLZhPv9XQNrOqk2xpxthMiQHHLeb2bjOEQyMyNUJI/KB77zLK7xvvot2/z09ZyZw92nwLRSJuUajetMXRUtRCE+3Dc/OzMbh+hXMlogdPurANXGVKWwT2tuQhYVwjLISrwFw0xSUk1pOLMc7EOm2/a8ewno1BlRe/Jk5vtjsdKD0X1rQoSsCLuLq83WiPCRU6le0V+iY/XFKt7PjUeneTQkQ7SpDZjvBibDllpTzdv1+UGDszzX9ZxdMdjjrJvGjTeo5bb5//Yw0G3xF75yl4AZwgBcmmrP7iCbABXmvOENfjP3Gyw+5f4Or3pjv9gmgnNCjQVM35YSGJPFB/TgHzzEMgbfHjqcaRRH6KhLV2odopzg+27Xx0gwriQyvJQjjbKBZaT8lCEjVTFdGHgbsj2IldsoI8zmr93f5PKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S5BgskC70ScuwJxUWq0EpcIJqx05jTFdhPOsg5f8983/Mv+J+fEj5UC7b6p9?=
 =?us-ascii?Q?xKrQ4weLTU7kAOHS0K6g1xQocjrJMmLOiyRi/v73oYC/V1enQnffHM037t7v?=
 =?us-ascii?Q?NByRtpk90xuGzDGM7JfYX1JeJ6myy9MVFn6+tye0ZnhXTcEXktxBCEoJIFWB?=
 =?us-ascii?Q?qxtOs3NV0Ydcmgak4uhwQOgWoyYOb2BCDdSbHza6+dqvtmbWR+rA08p7sa7O?=
 =?us-ascii?Q?z6g9ZVEa8iuxY4q27LHWe3Auj05CYDU8n9m17oVHpFTQATS7T6mfZp2FgmlX?=
 =?us-ascii?Q?QAbnpeQqst1m52MlcNprdYTp5PWSBTdoySeKmtQQzUWEIYgq6Tvimw3K9oEj?=
 =?us-ascii?Q?SCc8we0ey7Fmr+pUa3P34XPP0rzSjvnFxg1k5F+oNQvGHKCCoCxfjLj1u5+m?=
 =?us-ascii?Q?OtNv87WYJFxu6RzflLyzccxwb753hv3iBeIxL4sNH/eKbrNHvrT1u/XHh0hq?=
 =?us-ascii?Q?FiCpfLUMb6Z/1DnPsMUereKxJoGRghoH6z4D/ky2QJCB5c7DlCC5YWOPoFz4?=
 =?us-ascii?Q?Z5fufhYoQK9LA/7l9fodd10Ueq/qAwj+jB39p+7Q3lLUwzNFWp5ettEKt8YQ?=
 =?us-ascii?Q?gwhX9eKRU9cvwUYC/OnyJbT5bIBDA5JWmw8ZrZLgTWMucdWqcC55QTtQ5tWs?=
 =?us-ascii?Q?rqyt7n2VzUZHk38V/lCso22e7c7VawvsI1jHHO13p/nBsDycpATxhGbl+ueF?=
 =?us-ascii?Q?8ug/eHE+tPjz7vUOQNFeCWFjFN/4DWwhXn0xjDYdsT4QSXQsHHGNwaiFlDRe?=
 =?us-ascii?Q?LUfvRrkoqTqBcUeOBK2+zUJasvEPwuSMasbxzMoGPRdftvVJGDuZEoYbAJAo?=
 =?us-ascii?Q?WEXyGA5yKNC7BZPbci1mn41wOMenT1noLqgMfz75SildjhFYnVJvdy3vbkjU?=
 =?us-ascii?Q?1Cv58AFlrqNSVQnt5H+cMzsn/eC3spLcvcGCHQpIfZgPrBq3Ybjsq9sjjMJo?=
 =?us-ascii?Q?R3kG/NpviJWBh55MKAPjD5bkPaMCA+1vNLyJdI+ix8dPvMscOSLwWWY5wRSS?=
 =?us-ascii?Q?wWLwhs2BGFRrPbU1Yyd9nfXqdW6osLfnsJAkJOEhMBbaUpFqewCs51aJACwr?=
 =?us-ascii?Q?UXSdG+Et4o8l5F3MFaOdssTe+vpp8Q+ijxdAQsT9ZsrTnWV51HqK/Ofh0ddg?=
 =?us-ascii?Q?gVV13Sen/dj1djMuYboYVc/WPkL8eOnOUBX4iZD6YxVT7ehfF/8uW61AK0JB?=
 =?us-ascii?Q?TFhSxnn0pRIqQZkAef1TK1zS0X/GC3CDbnQa7wNMbPl+Aueqtu+aECrWMJAH?=
 =?us-ascii?Q?ndEbDg0WQTiDPj/TGEKAMLOabYMPKbR9C1YKWGAzPaMMNKxSLRc8a8DZrPls?=
 =?us-ascii?Q?EEi90LIk4Fs0ITmm9Zqv96iBdcpi+XacIPIwwSkTz139swMqsnl5MRw9NUGf?=
 =?us-ascii?Q?NqQV5eDxASuLQuzqUqygjCxV0g1QZ1e4IImcwgAygMzF64qYueaFkStqVnJ+?=
 =?us-ascii?Q?Luwra8FXIcKTjcRXLD5GUBkYekrk9gK7gXNg+erIur4HLtn/PN8GYRK+lh0q?=
 =?us-ascii?Q?exOjoSZL7uUw7om5PSs4Pvj4OVzG0Dxaz2Rc/sT9nUh9g1c+mjukN8Zynbyz?=
 =?us-ascii?Q?tTafKHUr0XbtPB4Ps8SsuEg/TqUBrlyCMEb0L4r1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc2cab9-2f0f-4f1d-e72a-08db62ae46b6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:25.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSH38LOyMZG/BwGct33DH+ncGji35iS12EZ/RzcDcGBN82sfGgn+XGceEiv4xc32CdMrPpqESGEXpDnoLLkTEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series introduces support for the eDMA version 3 from
Freescale. The eDMA v3 brings alterations in the register layout,
particularly, the separation of channel control registers into
different channels. The Transfer Control Descriptor (TCD) layout,
however, remains identical with only the offset being changed.

The first ten patches aim at tidying up the existing Freescale
eDMA code and laying the groundwork for the integration of eDMA v3
support.

Patch 1-10:
These patches primarily focus on cleaning up and refactoring the existing
fsl_edma driver code. This is to accommodate the upcoming changes and new
features introduced with the eDMA v3.

Patch 11:
This patch introduces support for eDMA v3. In addition, this patch has
been designed with an eye towards future upgradability, specifically for
transitioning to eDMA v5. The latter involves a significant upgrade
where the TCD address would need to support 64 bits.

Patch 12:
This patch focuses on the device tree bindings and their modifications
to properly handle and integrate the changes brought about by eDMA v3

Change from v2 to v3
- dt-binding: add interrupt-names
- dt-binding: add minItems
- dt-binding: add missed property: fsl,channel-mask
- rework patch 4, removed edma_version to avoid confuse with hardware
IP version.

Change from v1 to v2
- fixed issue found by make DT_CHECKER_FLAGS=-m dt_binding_check
- fixed warning found by kernel test robot

Frank Li (12):
1   dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
2   dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
3   dmaengine: fsl-edma: transition from bool fields to bitmask flags in
     drvdata
4   dmaengine: fsl-edma: remove v3 from enum edma_version
5   dmaengine: fsl-edma: move common IRQ handler to common.c
6   dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
7   dmaengine: fsl-edma: refactor using devm_clk_get_enabled
8   dmaengine: fsl-edma: move clearing of register interrupt into
     setup_irq function
9   dmaengine: fsl-edma: refactor chan_name setup and safety
10  dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
11  dmaengine: fsl-edma: integrate v3 support
12  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml     |  19 ++
 drivers/dma/Makefile                          |   6 +-
 drivers/dma/fsl-edma-common.c                 | 267 +++++++++++----
 drivers/dma/fsl-edma-common.h                 | 119 ++++++-
 drivers/dma/{fsl-edma.c => fsl-edma-main.c}   | 323 ++++++++++++++----
 drivers/dma/{mcf-edma.c => mcf-edma-main.c}   |  34 +-
 6 files changed, 578 insertions(+), 190 deletions(-)
 rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (62%)
 rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (91%)

-- 
2.34.1

