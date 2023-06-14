Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16F4730852
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjFNTgJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNTgG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA594D2;
        Wed, 14 Jun 2023 12:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHN7ziEJn9cnN0YrYpFYxU3yXyTQ9POg7J+P7/EzWqNpXczDxCT5Q2Gy1kP7/9um7msdXtsKwVPXbxu6YfM0+pA8jmP8kClJlbHjqUd+b3SQqju0oO37qXN3Auob4tTrVYFk/zAxhaCFezFEC9tIgkb3aSzDX3aQ7zGXBikBdUIPLyBwhUN5ne2A/ax9hJ5WGBPC7EZHvlXxVEgQuIhhBKV8q66ts56J14aTXB4nt2WPfFQiGOVx+EdkG27vxFheCkvhm69FbFDxga4iL/P0uRUr2uyibDPou6y/sUsmxwyuPQAuewRcmXgEsJkizZri4j+7hZ8yw9C91AyJipkilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Mywa6+PKUYc84q7ak8Rep7XhiIUTyqzas6PJPiTKRM=;
 b=k7XV6MTm8BjVzXnRPDok9h0cbYy1MYATbc5jpaLRzbh9sQoSJxOPkyflrIpCFbkpQuCtBazvGO7bpKJFxif7B+TQ/F8s3qI/IT+YWU8b62GbYlIn2h45EqcdI+Vt1Yb5hKWErOi7fnQInlrk0smtmiMJ4LJSn33hyXahqO5PnrhCY0IzwJIWFdmqBi0GxjKLai+vbQOfLInabYpO+zH/jML59LVOSiVfLOwmtvBQH3UVzTJ7CUQ/NEUrhNvsgzFAecYfYebdnSEAyHSYammcAeDdqx2Onbc1o0iiV4joyOSSVbIs7sbJ6KTeVOmYDKDuYs3kd6iGgafjamjzB5ES5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mywa6+PKUYc84q7ak8Rep7XhiIUTyqzas6PJPiTKRM=;
 b=Nl1JRat3nUGYx9YiP3Lko4BQqi6/a/CsMpGRJCdDs4TenDvpXF8sC2UjPT80H43WCw1rZGScfpRNx29jPlsvx4648JOqU8Op8alTzbR5eZ8nrZwSFqu5w3vb4jkBBpx7pDOZzEQouo3MQHSLXDT/M7vaFtzxPaUbeT6hTcDwzHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 00/12] dmaengine: edma: add freescale edma v3 support
Date:   Wed, 14 Jun 2023 15:35:32 -0400
Message-Id: <20230614193544.2114603-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: cb59cbe9-2790-4817-0e36-08db6d0e9506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLQD2j6zfEckTyaele7ClzzC3x69erjSOOTlVJAwYEAR5ecNR7uqR2mUWK+XskC2jgb6DAz/lV+V6Z0VvWmA/IHzCWEP2pIrtOCriYeL6DoW6CNqCZ9GmgemkKkD3tXZ2AHhrTluFrWsoOldSvTG2bxaJMLPsC4d4JpWbKtx1755w21zKvF7dIfx2JII38jqDzZCllC4nLCs+7vsihzVYfxj+2YhT1SoOMTLms0gcG5OQkGhz2SQjQtYCg5jF0qPJ+oC1ohW77cBkb5Na9ynntF4v6X+Z4NbtBC4eGS1vuQEkPKw6aqhVrIauENuX0M4COmv6U+1Uofjo8mt4KsT155qF4GQyG50KryNEjQHR0ppvf0RIZXXkPgvjOTmzJzFzHts9Kkj7wzqP+XNzzBOqamxIAf/h8yaOWOENQwZYX+4/+kAfVdTwgffGye2hscJHQEIAPL0MHsudVzmZW15bf4Oyw7HPPJurUxqAxyyuCPzniBr5v+VmXE9gMWt4xN/5+AwQpVGSUm0qcuHrh9hBl6evIHiCyZrc0xb2YJBHkGG0VgB9Ls7NnAS2GoeICilbmmfisdv72TdndbNPgMwVwGLd+ww1I6Po5+xgYoHZYOtewG55+L1Tmg3T259+SRcZ4UepEEHZKG5izixwBRkuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kB5KJYTCbuUdLHZQ+QN4CndNlgb6peySiPDXsJ4qETOJDJIMZvf8i7n2Z2KT?=
 =?us-ascii?Q?vZGEwN8Omb5CnwnIkoC4H3rwDllXD1UBF1BrnR37opWXgiB4mGEkMMJRbXCs?=
 =?us-ascii?Q?ALFlOag9yAy57ynTOaziFZOy+vGZx5NQparwLpR6zSH4OKthQ/aEurbOGB17?=
 =?us-ascii?Q?YgpnFHkC/ST03o2WZDZzbnisxQMTU7zD/HlEJu1tH5tI1fdzAokvcvrrbjgh?=
 =?us-ascii?Q?gB+r1Y6g8EiX359lFEH7IAhei+hbH9ueC+6RuhaqvWTAI6NHJn6aeNuhrNKi?=
 =?us-ascii?Q?rl3RfEhkTRvxw589vpQd7BsDpRtHFK7+N1Rrv0nKat7miMARmPMskzbD1WYo?=
 =?us-ascii?Q?Fn9Z9ff3qjVMjXBMztSzponsLbU85JJZ1GvN8Mf/K7w3Upn0NiCY0eM3DuOI?=
 =?us-ascii?Q?purDNC6Wclm20LMK87rRM04H6WhTCmB09MNAyZ8pL6jjOKgt1XdTvccRWw98?=
 =?us-ascii?Q?hm6WCfFGpT8j2leNBQs2aLW/4GTvRxW/2mDLD3pnNYbGnFl8ehdKAXAsEgLX?=
 =?us-ascii?Q?p91Sbxbks1uyA/PbijvelejzlOfcZ4QJWav9eSSo2ZkmooFrAQJId1TZ/GT7?=
 =?us-ascii?Q?/wq2ymuF9U4AsBTgfeabDl2d0Xi391U5yfYt/vXKMSm8W4zIsSqZXPL4iaIw?=
 =?us-ascii?Q?8SMahqkxlBv7VC8R7ldD5Y7FdmXnWH4UwT70O8g2mvMNEuqiQ/J6gB3Lhv8J?=
 =?us-ascii?Q?V7hOTcgxz5e+js1giR6VxLpCYJzpo1ycjAd+di6RPR9j7EFQQdqzYjJT6PKZ?=
 =?us-ascii?Q?V1/QNaKa0evv3eG7tnvQNxDjijMba0EA45IA70nXsve1GxtoFtt1aV9ATuBD?=
 =?us-ascii?Q?k8uYlSlIqDuhhNr8J1rZ1uMg9Pniv6BVTUun6dZMYPmvWPzf5h9EZ6QxXCaZ?=
 =?us-ascii?Q?fSdSXMxPIBY2spiD/Y7EQSoAqIxoAbBUr7gMs6Kve5COUJzRb27uCJ0Xhqwj?=
 =?us-ascii?Q?KXGntRfzhEMm+GlgoyF6PXPFvZvGJwv7qguAcdvW6be/PUmm7RWoAOQGbRed?=
 =?us-ascii?Q?lEmww9PPtDgB8zlz7mqE7T3GyyJfe380Wsh5loIvSc7Yc648pZdyxo0bwvJO?=
 =?us-ascii?Q?UryZmHFVCJGLKzKBeL0VTQ53E4XWE44Hmf+KLqBd1RX0KKtiuj/NqJSuOK05?=
 =?us-ascii?Q?vG8teCneiT9VpQakG6ZaKQqkt5KkSEFsRJ9DjOiZozeApmAK8nTr/9pYlg6q?=
 =?us-ascii?Q?/SBFvjPxTcxznZvw3mwyfX3hDybk5ZyUD0uORA9QLvzAR3c6uP0E1xZA8P/8?=
 =?us-ascii?Q?thNUcVCeIvDx2sz/eMrfeEoMAbFW1AB0iq2M2A+CFm4fvRB2fa8D9NwLwFsD?=
 =?us-ascii?Q?qp2p9psNeS3kzF0zkOtheu7HXKF6jVX8unz0DIvaOhifxrAT6KvhGOvw/vzR?=
 =?us-ascii?Q?WgOheT6nSHfxyA5w/SvVC/sYaqx1DtfzevGXlBJeWWXE83hoBCikifpoiB0C?=
 =?us-ascii?Q?WTaPtZ/JACMvs6ueg6by3+k0YzVJO2ExjmsWX72HH734B3rJhXPJeFwZsEQF?=
 =?us-ascii?Q?HcK8gl22XMZppFvQhVKaIK8q0DXGXHfkTGAUOwkiVhx1btIRLazFqhrWq/OW?=
 =?us-ascii?Q?2wgMW3ktUnpmxsKy0I6ys8k0hK5P1R4uiqP/YPt+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb59cbe9-2790-4817-0e36-08db6d0e9506
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:00.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t86k4idJCiP2RgEUGA3Vvq9SqMLvtwF65kh9wV5Yp+KzB1QMoCYRRPywYXCs5FAgHIzW1SDbyoTAEzBqsmOnJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Change from v5 to v6
- dt-bind: rework it by fixed top level constraint.

Change from v4 to v5
- dt-bind, add example for imx93 to trigger make dt_binding_check to
generate the yaml error. fixed dt_binding_check error. 
  keep compatible string ordered alphabetically.

Change from v3 to v4.
- use dma-channel-mask instead of fsl,channel-mask
- don't use dmamux after v3. only use flags to distinguish the IP
difference
- fixed 8qm and imx93 have not CH_MUX register. Previous can work
because dmamux is 0.

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

