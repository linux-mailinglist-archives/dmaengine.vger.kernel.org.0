Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF2741405
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jun 2023 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjF1Opb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jun 2023 10:45:31 -0400
Received: from mail-he1eur04on2050.outbound.protection.outlook.com ([40.107.7.50]:35999
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230329AbjF1Op1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jun 2023 10:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPoz5bQc0dzEuQIXotMiPB7TGFd8zN2Is/gP2HfX1VkfF0zbCxJ7WPoscw6S9noHBy1iPrNUJ9zrLbOTr4OssXrJkNHI+b/yHYnjzm2nDhb9TNswaiT+rQsr6cHcC5v39LX/lRYLTxbbOjrTmA8wFss3h2yzxe1NUv7RmRYwnmrxhm6diFnDVTkWWbnm1jSHn/vfrMoFMGDR5j0MNb3aUdXAENVMFicufxVYDt68Pv7aofdsfgJ6mcB8f+IsqGL9NIntDFZG0Lc7AA9xEUrQ0xv977M4D+fy6g01bO4p0X+JXMHnta7ebHTtx3xhD2QCsqUz53Dkdd20kFB8+WPMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP1T3gtr+cB2YUY0ykBWG0GweE8pdzY9lvO9qW73wSQ=;
 b=crwdcGdK98Tvf+cOEoC3bcwVlE66QFDVyFndt0U0BbZG53h9HvPrEm3dK0YqIVk+J7kk1KSWZ5A0uUftJBQnQ9Czqgz6ej+7pgcQL1HEgyjJiT1ZvK8DrDoO+oYS6GmNVlB0BbtHmvYnW0Ys4mcTwnyxyfusJmK3LAooI8d63dqpEB3SvivHjy/YaMWu83lgppCf52lWheAbXq4kTwaGvv0vT7lzj16369d2faRNO2B1qvGeMJG1/hAp+4vkmKogNWJpgKek4pG4246rw9kT22Dvo6RKvhb8wTBkaKoD3E4TA/lnQK2oG6ubUOiPprBHsSpwtGNu69kqRQ+nG+IRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP1T3gtr+cB2YUY0ykBWG0GweE8pdzY9lvO9qW73wSQ=;
 b=eqqQLeYf866sUu+SkMQy9dHs3Xg2hoHXlTSp0sg+SLMqmTeD8Mr4AR+wwEtaWNDmrhOvNl+QV7bLCDMkCu9L08BHFo8O0+goegNSizlJjhEHvlWNizQxxNrVRMjKAtbUX0ujutcUKgRkF7bgRCLU7MfRGa9TS7/5RSBVmpSb0dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB9046.eurprd04.prod.outlook.com (2603:10a6:20b:441::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 14:45:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 14:45:22 +0000
Date:   Wed, 28 Jun 2023 10:45:07 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: Re: [PATCH v9 00/13] dmaengine: edma: add freescale edma v3 support
Message-ID: <ZJxHc62V72eVMYu4@lizhi-Precision-Tower-5810>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: acdb2633-9d11-4ad4-7dc5-08db77e64cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6/YiIU/ABbpIRZH+1AcwjAt6d4PS0MrBTit3XW4JHVSkEbQtHrihMUCbuSxVYhPocRUQH7oMMZ6d+zpn/WZFR7fIBANa6+wK/XcHodFdE2iHsXRr9lyH/aeHIXHs/o1BXUZTzlQcZm9bLeqXY5V+K87PWJrhh/DkOJf2iVYKOTR/w8JxX/n9Kryt69fvfsseMMU+HmwssmqZWQVKs5b6pZ6qfcb3vc2WnA0H6dbwz7KldAMSNM0eqk4qRBPFtpkANsYgLUgCJ9KhFnt+GS9i7BMdLuiqG3VZxmnCbLB4fQSvUzCKj9CacAYYLHLrZL5oWqE6lSkqgw9hBMo7QWrQx3y6PMOECAS4Zzw5HbvNfxnM0/BS5gak+nIlibm6xAWCNQ1Tpsrnlp3B3+Rfl09132LAxd8/4FeJdBKPSXybg5GjIn43lUsc2vyLZdLBLtnCUjEPThH7wPjtZbt4u9lHJxLLe92EG4auytcFKNvdGVOh5lYPSo3UL01jUIKaEQgLkB8NIWjtd6TjLvjLaUMQF89tOhUIfZEbx6ue1kopYH+jOgNWvp7DnYIgao9Rghv+jj0EdH01M6TUnvuV/k3CwQSpbdqw7iG5dipTQREChnYjYx+cS2IQjJuckQlja2dh9uP7tznqxOLYGHHuR4dmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(921005)(38100700002)(5660300002)(33716001)(86362001)(41300700001)(38350700002)(66476007)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(9686003)(6512007)(26005)(52116002)(2906002)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ka0WB7SJ5l1QRgRw86pKXfmLusB1nyMM53aRuunxj0AC9GkDzdaphb3nOwrk?=
 =?us-ascii?Q?p8G8PXdrp9HkbafiUn6sA/d5HR1YxYXjVv6QHaR+XgtY1yzQSr+3XtCB67kw?=
 =?us-ascii?Q?nUubsZK33a/nE8uWwOYjG6WAZepqQRUfIR+gWams2/pU0bnfKClJ0c4qsdqA?=
 =?us-ascii?Q?ibQ2k8g70Sv0g53wVd0F25c8jbBZdHUcUQc7fJVGNBgC3e8m4JSSiLbjjrh2?=
 =?us-ascii?Q?CZTuTwzQ9uxRW1+tCkl+WBOb8T06CN9C6bH/Rvjhw1+Zl78s0/pjEPjVNdJM?=
 =?us-ascii?Q?8kgC0WYSOJPexo5zG0lDjTjQZ1XnCMFZeooA7mm6qpAS0JKdmWXqK3Z+yKj7?=
 =?us-ascii?Q?zQy7GCzQLby3bg3kE6AT22VFs7aF3v+gOPG7Pl1IAKh+h9gGvOXr589T4V1n?=
 =?us-ascii?Q?s7aws2Gr1pFSyD8BpZqtrssWELLhHA/KfmRn9bpoEO91Tipyu8EaWeowLrKt?=
 =?us-ascii?Q?CRszSA48Kn7eRGj8tqEMSFpYZ+JDZ55lg7btzamjDfU3XF531rfgYvoB2jKv?=
 =?us-ascii?Q?auTOoZuCd9m5fmfLd5HL0DaSe7wVmipkRlSO0iKUZMsrZhdu5m1NSYNiUHRc?=
 =?us-ascii?Q?qej4G7BGQAjJAlqpFZ1LBsNHydKB4fs2dcZwRyJ7WY/rFoavHrtn6dcL3wNL?=
 =?us-ascii?Q?6c15hprav/hs2hwJ2abrhQMrwtev/v6M3P/0vEwovMwoDdvl/ZdaiCUkI9He?=
 =?us-ascii?Q?AmAURraFNy0dxtHqhRntu0PLdPL7/UWUjpPRV6r3hVFglPttQtZ4qwv60r0J?=
 =?us-ascii?Q?4I9WXPOouHzNNZBZWSeq0+9h2TCkZNk26fjIZfr29h2mz3ETJrDJo8x5WPLH?=
 =?us-ascii?Q?GCNNsYzqYfZEMzAakDsda4VdFWbBik0mM6BeVF77aBxdaRJQKWvSfcZy82SL?=
 =?us-ascii?Q?Vh7vp/AKi8qmjzvm0sm6JqBhgBB+08jqgVsklvITHJUxES29nVp62IgQLJWR?=
 =?us-ascii?Q?wCHiz0RfdVXN1Q7JLgIAngqCThjQhveOG6E1MBL8gjJasvWJiosyE0+c9acq?=
 =?us-ascii?Q?QEHEA5V01O9GTfvNSMwBe3Qwx32W0FeN97K3liGwC8+GwO7cV1STynylX8fc?=
 =?us-ascii?Q?bPk9Y7UqK5xL/QnQTcNcWMpAhnp4zpGLFcM225TvxS4pFXP2Lzi+wEkRbBNf?=
 =?us-ascii?Q?9+QJRze7aLfCT8vg4E6YY7DUHT12NBdsDUD4iVGlk0IVjWqcmQ00w3ocFmzY?=
 =?us-ascii?Q?6W1lmWRoe08mJ4ZXJCpxDbvouWgpR4We0qA36URpQqOEP4EMtnzfGpY1bMEi?=
 =?us-ascii?Q?VK0QmJ7MzOEiRPzR90A3ZHjeyyQwWgO9+6WAomOkd+FWx32z3Y+VgVdhvWiz?=
 =?us-ascii?Q?oDkeGZBDOTKOhaSQusF4mTnBGlJ+m4qKK3sLBwmH5IS6S6JwsIXhHI0LKo5h?=
 =?us-ascii?Q?316IeHJuRoiV8BUyp7yzzaHAOJq6e/hU79LIb286PAq3ny0GHr/QT4TO6xCA?=
 =?us-ascii?Q?ZEu3mV5y8odlAkxwRWJKfg0oWPckKTOMeOQ34koKppFfkL2gKkNifwcuEgzA?=
 =?us-ascii?Q?FlCuwSz0W+Vh/jUEr++oi3v51mAww1HxFfVUXhHIKYcrYj1pJljLLg9SYyYc?=
 =?us-ascii?Q?qxJrIUUJHHkfljuhiaPX2GLue5zjYrnF47cM4R28?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdb2633-9d11-4ad4-7dc5-08db77e64cf1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 14:45:22.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3lIkUkLw9whVxAE4V5wfM3u/sdxBjDq6M+f4HaDMvttKRmZBzIgF1nhRPx1kObD4HoGNlsgeZPUDJRsLwCprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9046
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 20, 2023 at 04:12:08PM -0400, Frank Li wrote:
> This patch series introduces support for the eDMA version 3 from
> Freescale. The eDMA v3 brings alterations in the register layout,
> particularly, the separation of channel control registers into
> different channels. The Transfer Control Descriptor (TCD) layout,
> however, remains identical with only the offset being changed.
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

@vkoul:
  Do you have chance to check these patches? Any chance to come into 6.5
  All audio parts of i.MX8x and i.MX9 was dependent on these patches.

best regards
Frank Li

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
> 3   dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
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
> 12  dmaengine: fsl-edma: integrate v3 support
> 13  dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
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
