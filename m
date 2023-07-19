Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9513B759CFF
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jul 2023 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGSSCA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jul 2023 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjGSSB6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jul 2023 14:01:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB951FCD;
        Wed, 19 Jul 2023 11:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFRIEV2MVfnulnhS8txuQqu8MsYfk2iyBDGfJJifYnnK7dOsiK4KC6zyqHpFnMz3AixqvWrCTtN88FO5DL/Fi1OkYJpolnU3UgM+D9DjDe2Z61zghgkt4oeSIYF/oNK5K10geLOi6MWlYEsv/g84oszOnlVzLcIhtL2WTnHvkzad8Hqnfmnzfx1+C0HpnYvbvmBrb0I07/WOd/YKNHLf6hTxAl1hJFT9mpHFU3lp7KmJ0YOflUoSU6tn7tKwJd1Tc2SQ3lwZbO9AF7saLalF79Uq7JgNixtq2sRs3gORjKcS2tSN2pfTUXKa0a0enMNtDOKAW4s6yXYvDnSA16XBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAC8o57OeLcuUsYHpiEs6c2FRIbssiJXLXt6vwErNCQ=;
 b=VakLmDre/VicJQUoXuRXOcQJr8sUVVUmtNumS1AMciX7s+PyvWCwinPgOmC0u2/2ocPsVoMA3ugjOC9CEMw72eV2LTIyE52WNZGH29qIDILoLFVJW7YBgVoyT1p+rTsNPpfoy4OLxMWKmEAXtbHnYT3p143eCZqJ5CLFnCt1KMMb1pOAWxY/8IocAZkkp3PmS9ofclz9PAUZHu4c5CB/9+kvvSXM4ZdHPgSPFxoeYofwBJglvXvzxzfIGRSQxsFULx5MJfbR4fN95Fejlb6vRB6jpQOk1InPikv7NtfyWusm3zi7E0j5o57vNaBQsK4hyfYe3PnDX86wb2vin8qLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAC8o57OeLcuUsYHpiEs6c2FRIbssiJXLXt6vwErNCQ=;
 b=FtHgWhDdKGonMBE+U3ZVwVrzftJlhH59o1SO+p7sW1HW4D1o5AR/ix8NNL3PidhN0JQasjGEKnGUst4OnVB/lczAFSJg+L7QMZul31FIoheXd2YeQyC2xuGo4H2qtk9VDgSoaVR1ssG4JclsXPoXoboPMqo+dhUVXVquhEAjYy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 18:01:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 18:01:54 +0000
Date:   Wed, 19 Jul 2023 14:01:42 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: Re: [PATCH v10 00/12] dmaengine: edma: add freescale edma v3 support
Message-ID: <ZLglBiSz0meJm5os@lizhi-Precision-Tower-5810>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1446f1b5-4aa5-47e6-db18-08db88823c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWh3V5ssrULnaaY09wu/LQW7WtK8DWr/RwSPvRTe+1UDvV/Zb4FQeP+6NDajl0HSNo4I7imztUcDQVlR5qOoTYH9a2ehAhrjMBPbWmisiNXHRjSiw3q55seLeui1KpU4q4KPziL9XLFCaz4hXPwtT95apI1rzA3bvX/+npjsA8ucvWnW1RJESniqmrRZufM1xNon/A9H74dqY4kNaSMOPVVOfhrZ6oj1HBFW+ucTLFKxZtrCXp9c15OZJCPzeAYVQV7Igo2vtOrUB7fjFL8mRG3GmiSd5tP/5cUzFmLbt5X5Zu0fvIZ/OF03CgiNz6eZVSYbDcna+L70KWNf1IuszDHQ1Ey6y+ntbNoS3zBAzHy+Wge6JgbTNdUxAi+VgTYj7faHSy+y3+Xee64IDk10hniRRax1xRO2PGr4Xbsf64+OXG9CmVWGaVMporhhBtldVc1eGbJj3QM5yIzFE7uXoj9qrDx3gUYOmiLoPKt3AxihdcifGgOeFen+q8cdqDO9Jrcxi9T8bioQ7ibIoue5R0sNwn/tuCMEcK5qSuQeLGjVRTPz+YhyaM4AsE+D04SfAcMT96fxY6kEV+R3kTDs8b8st+3gtGkMu9xxbvCZnAG37W+Xl6YonoUYbuyoKZsg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(2906002)(8676002)(8936002)(33716001)(66476007)(6916009)(4326008)(66946007)(316002)(41300700001)(5660300002)(66556008)(26005)(6506007)(6512007)(6486002)(52116002)(186003)(478600001)(6666004)(83380400001)(38100700002)(86362001)(38350700002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFwOEgEZuNSiv/0xqnI+ykELa+7cxt181FG3BjY9wFea3VX7gQ1gvUlTRPnt?=
 =?us-ascii?Q?GDFpGwJmFN57B0SHK5wMi6MN9h+dQDO7v1qjGKmQfMb1SPeEIDpRxo52FMbg?=
 =?us-ascii?Q?IMn3xV73xGsvSDbJXIePs1zVrghwlmirc67UiyeIeVUrDbs88wXv2WsiEmmt?=
 =?us-ascii?Q?lZdnzkRV0kF6RAb5sSxk4XQmRgT+qQqDMBLleif/3lYPUo3hLkTzNV3NVysr?=
 =?us-ascii?Q?T5UuvmIT/V94N2d2noFqlr3nub2P1jIs2HfHKVngWDb7YaN1IwzIcOi+uP4E?=
 =?us-ascii?Q?TKuqG8Y1n7RsYJqA+Bd3fKtVKP5KX3xrmAsQnCUxgVkS/xz5S13NSa6Kbv8z?=
 =?us-ascii?Q?ixip9Ef4vqsUHjbnytJoabddr2Ns1dKtmPvPR0X4FirKo/rCXn4mXAlP+0wr?=
 =?us-ascii?Q?9E4D39Un7piV5AIpN9Av/0Aw/JqATes+fC3XK1y7+D50kB9zNTXatRqRYWUm?=
 =?us-ascii?Q?EXkSz2R5J4WaEbuwPqTWuvoR1dopX5NoL1UXevw12OBDYxSAwlBhc7C61ykW?=
 =?us-ascii?Q?qSom3/0aGXi7ixpw4EfRDYLMoJfg3C+eo04lLzCJiJUoEdi9UMxJegWuZcRC?=
 =?us-ascii?Q?x19TqYcEorjAHjBbMvZ4Cx+CIjNuINrDVzKIM3e8EiVDOpXbTgCNgYVEkNnl?=
 =?us-ascii?Q?sk8kZA6dd1d06tITiMuXXT/VX9MsQoU2TjYIgNvztaQI5LbZAA12G4Rxs1j6?=
 =?us-ascii?Q?qweQO0cS2dyJu4wS/dxpSj9eJCUAycRltVWi4yjVtsh5F7LVuBlEJLtbsih6?=
 =?us-ascii?Q?j/C6eip58MyctQZDYgRUXxvHW/zhH4OfaBofozzpw8ez3g2zJmjKdQsatKju?=
 =?us-ascii?Q?jiTLW53IpTDxNQUmaKMnkhuK4jv2DMxmgvkzU61g6iNslFQWz21HmrN1f90+?=
 =?us-ascii?Q?YTIjXevTiARzeu2z/tEHNgrllH/aHkBJSb+bAoFwUJuX3p74hJv9ngMiDmXc?=
 =?us-ascii?Q?LEmeoDtcedjCiqjTwHMWH/CC18mK3s0Nu40g2Y78f16P6Zr9ouNoKKmhwnPq?=
 =?us-ascii?Q?Q9sw5HIO27blkHl2hmZU5uZ9lmajrVQGmPvh1c1AwSomHNq+NzAHVdou00kk?=
 =?us-ascii?Q?KVqHp6ju4SqMVtSdHpUHwMcl2iIeJCRR6Bg5qPFCJmGwKOG8y4hc0ehVLsgr?=
 =?us-ascii?Q?8zSxbsSPbiYXDQHzqz05qWO/9W+CJpEMdibYSm4d01eiBKXeTPe8NJSo92aj?=
 =?us-ascii?Q?p6fsilYTlUpocEjq/f1xw0yLKObUdMx1LX3vk34qOE8tPrNY1TKaHBcl5hxX?=
 =?us-ascii?Q?+vfeCQPZhAf2FNDDzrq3p7aqqVDplIUBRZr6QL9s1qKGBYZ8J0A8UZuuXuBX?=
 =?us-ascii?Q?gdcElrtpoo9o45ZSzMy1gJpioG/1U+wKqWovVjC1x5lwamDRwIiKkAQAYIn2?=
 =?us-ascii?Q?q91LhSM1yEZ2tJM6HeGx7PmQG10/WuXKF7wgEYl3zo1Ht9P6sI/cm1UuaBf/?=
 =?us-ascii?Q?7HW32agzZIwHAhvDe6qfc6KmrKdiGvfiAHdzXhk/M4mPgvGeSktkXp1vY3rX?=
 =?us-ascii?Q?fbEnIac/p47mStjJTiMRQHhdBwXwmWfUyjPMrUJd4iXzr75FROahlrUV4dW4?=
 =?us-ascii?Q?Jxw2K+uWTbOCu4txDefUbiAD5fPw4lSxP+ON9Me7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1446f1b5-4aa5-47e6-db18-08db88823c7b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:01:54.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4u3uNfL6lozCpvnYCgPxytw0LEYGQjT3HrtEIVgjU0DvMZHayJAyyF8s3vndhVhIxsnQJNIzVYSuCZdQbniVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 07, 2023 at 03:00:17PM -0400, Frank Li wrote:
> This patch series introduces support for the eDMA version 3 from
> Freescale. The eDMA v3 brings alterations in the register layout,
> particularly, the separation of channel control registers into
> different channels. The Transfer Control Descriptor (TCD) layout,
> however, remains identical with only the offset being changed.

@vkoul:
  Do you have chance to check these patches again? I fixed all problem
that you said.
  All audio parts of i.MX8x and i.MX9 was dependent on these patches.

Frank

> 
> The first 11 patches aim at tidying up the existing Freescale
> eDMA code and laying the groundwork for the integration of eDMA v3
> support.
> 
> Patch 1-11:
> These patches primarily focus on cleaning up and refactoring the existing
> fsl_edma driver code. This is to accommodate the upcoming changes and new
> features introduced with the eDMA v3.
> 
> Patch 12:
> This patch introduces support for eDMA v3. In addition, this patch has
> been designed with an eye towards future upgradability, specifically for
> transitioning to eDMA v5. The latter involves a significant upgrade
> where the TCD address would need to support 64 bits.
> 
> Patch 13:
> This patch focuses on the device tree bindings and their modifications
> to properly handle and integrate the changes brought about by eDMA v3
> 
> Change from v9 to v10
> - use HAS_IOMEM
> - move dt-bind before enable v3
> - remove a unused code
> - drop patch3 clean up fsl_edma_irq_exit()
> 
> Change from v8 to v9
> - add dmaengine: fsl-edma: fix build error when arch is s390
>   fix kernel test robot build issue
> 
> Change from v7 to v8
> -dt-bind: add missed part
> 
> clock-names:
> > items:
> >   - const: dma
> > 
> > clocks:
> >   maxItems: 1
> 
> Change from v6 to v7
> -dt-bind: remove "else" branch. 
> 
> Change from v5 to v6
> - dt-bind: rework it by fixed top level constraint.
> 
> Change from v4 to v5
> - dt-bind, add example for imx93 to trigger make dt_binding_check to
> generate the yaml error. fixed dt_binding_check error. 
>   keep compatible string ordered alphabetically.
> 
> Change from v3 to v4.
> - use dma-channel-mask instead of fsl,channel-mask
> - don't use dmamux after v3. only use flags to distinguish the IP
> difference
> - fixed 8qm and imx93 have not CH_MUX register. Previous can work
> because dmamux is 0.
> 
> Change from v2 to v3
> - dt-binding: add interrupt-names
> - dt-binding: add minItems
> - dt-binding: add missed property: fsl,channel-mask
> - rework patch 4, removed edma_version to avoid confuse with hardware
> IP version.
> 
> Change from v1 to v2
> - fixed issue found by make DT_CHECKER_FLAGS=-m dt_binding_check
> - fixed warning found by kernel test robot
> 
> 
> Frank Li (13):
> 1   dmaengine: fsl-edma: fix build error when arch is s390
> 2   dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
> 3[dropped]   dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
> 4   dmaengine: fsl-edma: transition from bool fields to bitmask flags in
>     drvdata
> 5   dmaengine: fsl-edma: Remove enum edma_version
> 6   dmaengine: fsl-edma: move common IRQ handler to common.c
> 7   dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
> 8   dmaengine: fsl-edma: refactor using devm_clk_get_enabled
> 9   dmaengine: fsl-edma: move clearing of register interrupt into
>     setup_irq function
> 10  dmaengine: fsl-edma: refactor chan_name setup and safety
> 11  dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
> 12  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
> 13  dmaengine: fsl-edma: integrate v3 support
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 106 +++++-
>  drivers/dma/Kconfig                           |   2 +-
>  drivers/dma/Makefile                          |   6 +-
>  drivers/dma/fsl-edma-common.c                 | 308 +++++++++++------
>  drivers/dma/fsl-edma-common.h                 | 127 +++++--
>  drivers/dma/{fsl-edma.c => fsl-edma-main.c}   | 320 ++++++++++++++----
>  drivers/dma/{mcf-edma.c => mcf-edma-main.c}   |  36 +-
>  7 files changed, 677 insertions(+), 228 deletions(-)
>  rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (62%)
>  rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (90%)
> 
> -- 
> 2.34.1
> 
