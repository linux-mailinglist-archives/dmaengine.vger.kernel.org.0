Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB47CABFA
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjJPOsM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjJPOsL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 10:48:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2AAB9;
        Mon, 16 Oct 2023 07:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imYKRZBEuqFeDQfjcu8BWZiv830Pzw7v83x9cFhg1rKGXO0oNLN1gTtIH1OK7FFqQ1inG59dvTz0aHqC80YUN8iW+28FIz9tmKEAcCIfXNy95dRqMPmoRZXaUmJsaIiZCVifA/TFUUM3CdIwNj/D18NkGyhLTHqRzt/GOcm81CASUu8dYPNy43hYG9Mo7BE2O+BsfipmwspGARG4NsPZUpGAVxG7I+vEE8L3aCPxKrBhAwsofiYgyQas126hpLXDCE3Pt6t60f5W3JqWThvjf1R7rmVqpny+MmT6GazLb4XjnnyjXQ0T7ReujIfH7+5H0X9hWaio0J1+dNeKdfcsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F2IDySJK2AzyxaqBahCm6XqENXkY+c7XtoQcOJsf+8=;
 b=HjzL+HHpAnqNvxdIIjnSmdrHu9dhtg51C349bPt4CCO8GQOOdmTKnHzaZzQJX6zFUwC/N+c0CGRB/7VvfPI5LP9uGWBMnfn10EhnqkhE/yxNVMCemK4y0j5VfBhn6635q6rT5hhYrrc8MVHD3swq3ynD7c6sFK3ZlL93Nbs/WGCT21mA94ADVa6F8VAoKM3LuG1qzxwOUiyljuFxu1Ki63FCqBT3C1XzSB+totqPJhi4z2gEFV12wlFrRgZttHbFS9uBIK+c5I0X0OTpO90dKb3YXxTPQchfKPgjlaEG1hauzPO+o8FFt5JgIgpISEWtIrzPwIj6RHI3cFav/0LXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F2IDySJK2AzyxaqBahCm6XqENXkY+c7XtoQcOJsf+8=;
 b=Mfx6EbyjJhtMUuDTZv2q53KwmlmQ2dXxE9mDcJpF+xXLAuebPL2Iw3Dmbxmlg6mNfbbz/WDa0Nf4sMAZ3bnsN5A6sGz711q+MnoBP5NSOyXTO4b6F0g4E4Q1LIgHAdr7Uo25Qs9DBfygWhQR+jN9PBvgqVyZfc3BzFyYBFj20Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 14:48:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 14:48:07 +0000
Date:   Mon, 16 Oct 2023 10:47:59 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: Re: [PATCH v6 0/3] dmaengine: fsl_edma: add trace and debugfs support
Message-ID: <ZS1NHwdTiHrAoEbk@lizhi-Precision-Tower-5810>
References: <20231003145212.662955-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003145212.662955-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GV1PR04MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c0762c-1ef1-4546-9cfd-08dbce56e896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bV/1vzRLtovlluli7zcnc2O91yf0ZCtkP2/OfV12gFIZpoewCqwikrSz755X0umuYNuSRgcdd9S4XV95jnNnP3KWttf6pj5PylvraZLfDaEG3dxaUQw69bdWsrlkz3KF+x0Jv5UzivFOI2XmuBntnFSt2tSoZdjkeP8k+YnDs6b38QnMHJGbrqF6nXRRQ4QsvPJdUGuHX1gUYt07Equ3dSrLWaoatuqYvgFbK3QUErmXojDXJRCljH88037reCIpQua6NBH9Jny+geGjD8PGdyZ67Ye30dMWe9EQRQIZZi24WGz0btIgy4TYu9pO4C9CSGb8XS+jvkLf84PGQyPf5kDMg7Fv00xfpyzqKXcmFfEj2iJVQf4qbHkA5HB843BkmfpOEuSVV2iRB0OI0fPlC2HyTMa9oxKiRId5dqDfH5KeCpXxgLNlQhethr4wkFBcny3mxfKpK7+a55BRNWDYFv8z/ppTBk+8HmlxOsJaSguCzRwfZz0NKbCeJPyv/8wd3Wx7lT33Bibwe+zrFPQG7z6qjwLGd5CQHiGQ7f/7CpUnCAjC0n8BFC5KNTAbb4xqD1XAxOWXJUsozNzXnm7SRWZIzS6ULIzR2BjRyxsZKKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(8676002)(8936002)(4326008)(33716001)(38100700002)(5660300002)(83380400001)(41300700001)(478600001)(86362001)(6486002)(966005)(38350700005)(7416002)(2906002)(316002)(6666004)(6506007)(6512007)(9686003)(52116002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYSlykP7hJ+WDsW/zfL9mVfgPfhR8l+5xx0NJfe3HhI9j64zfMKYxFqYYE/L?=
 =?us-ascii?Q?ZqUsE9B06BIhypyu7KstFMVNDB0celjsGkfBs/zPvkC5D7yg/VGK+g4+NbFK?=
 =?us-ascii?Q?SbRVpszPOiyhffl4J091OLLkmmiitkr9jieQWz7nGe5JVnKWwT3rUi5/rqvS?=
 =?us-ascii?Q?O+8ZdWShPlZDMehZVukarZKOf3soarUrAxPikKewAmbH52spZfAuPiO8gpIO?=
 =?us-ascii?Q?Hvme7KDsRTy9ZuIgS83GLWwBg12emE/scBogV+dXQNyBxTYkqfmZ9l/KXVFp?=
 =?us-ascii?Q?tS6G+TMzjOV4Ox6OM3TW2gqsV7mSIgEXivKLfY8Nmst5cYckoaDSpb0z/4h/?=
 =?us-ascii?Q?hCE0yRZXTaVGaulU0anOt4qfEuZo9P6rj9qqu93UGmpOgLYzKCDpsoVm8UE1?=
 =?us-ascii?Q?g/2/DKjs9Wuc56sN66kobq0QrAsmbXPqcFLaOdbPkko/iFFXDuPRP7mafBOf?=
 =?us-ascii?Q?xcnjACD42KKNI6b499wVb4CS/8+u9c2Hi3epNTy96TOdnirWIM4/Tf42x4dy?=
 =?us-ascii?Q?/2swna7KOsINa3TcfDM5skceF/vxpahYlVWiIkY518kbKRZD7pRw2DrGhKet?=
 =?us-ascii?Q?Ko1HoefKDPlXO/GvN6w3bPFYl6iD0YJnTyTDYhLJAxDgiWaZZHBPIaKspnel?=
 =?us-ascii?Q?FBFfLlSYnOQpLNL9Pa/0+7WTYAjOo0GuL7iqMWkc5SlELNDqi3rlGlrDoods?=
 =?us-ascii?Q?n7PVoH2+GZqowNilYP+WAd7GNnsSgFOKTba0akDTyzZatQQglhrogRBsuI8s?=
 =?us-ascii?Q?iAp6KMHlufxAceJ7joEc3hNVVFdWJK0lqXfCtqF4zQshnqSQBVQOXKTMyn4t?=
 =?us-ascii?Q?NJGAfO30ud3Oo0UAjFP/KstTCxlVWt/5o5nYU7IzoY3TClxA4UQqIiqooK3f?=
 =?us-ascii?Q?BnYL/8Nv4XOobEur2WI8JO1VIRAYpY9BHfH1V2hDOK40EPQpjMIIYtWFw1W7?=
 =?us-ascii?Q?v9NpxTLRjEeYAry7QdXxu84AXmoIvRQ8/1Dajb2+G4nKq/HTFCGaaFuSnTER?=
 =?us-ascii?Q?MXuqFCI5i4CycoXneQAD4gVHHXGRQSu7nDpuXABDKIX3UR/N25DN2LG1N0av?=
 =?us-ascii?Q?UAyELttw1zhPoZQdEUq8FFdna2QVDUFi5rga42Hv3u1dFHeSFLPWNLyFLWJ4?=
 =?us-ascii?Q?mg8gz+gdXLhX3lRB4DWcA+uYnI+URW2lEXjV3e1F43l4LS7h8Hu2gi2/H8Da?=
 =?us-ascii?Q?ydlUp7SFsxhMEmA0hofGNbBPKAlKpJkfxo7znC28e10dmrxX96UZiu9bVqyk?=
 =?us-ascii?Q?IUkGEp1W6qjrv8wmEjdcof6raVzde6XalFSzAwnfJwWCBWwI7FWH+3nQaUhx?=
 =?us-ascii?Q?HVmLzOpo2SngdCAZH7/Cd6oC7e79qfAO+ITiqmER2mieN76X4s3Lb91v61ll?=
 =?us-ascii?Q?rmJ7WQ9G+oN7Ryb385bXPxQ5NuyIsHEjfnXYr6fdBL3T2pGW2iPjYnJFHB+2?=
 =?us-ascii?Q?yJSsSSvSAyweDYa8bwXGSwc8q3R9n+6qOIpqF/yaxjBPjSLVAwJbcH/P13Xj?=
 =?us-ascii?Q?AoM6mdBRP+0EOSm7X/7uaWcgxgizTZ88co5EvdgqWBXi8bdn9w/OCzxpt4Eb?=
 =?us-ascii?Q?xHjd9HR3+W8fZEUsbhLP9Z6NZ1OKrmzX6QwuOrpD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c0762c-1ef1-4546-9cfd-08dbce56e896
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:48:07.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1904xQzqPAyQ7d1o9mpS34mlE3bM5X2wLiA+iP8+1P/hX6ngd1A6pd4iycppJJAauPPpWzJYjHHddEkr4myQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 03, 2023 at 10:52:09AM -0400, Frank Li wrote:
> Change from v5 to v6
> - Use case 0 and case sizeof(u32) instead of default

Ping. I fixed build issue. 

> 
> Change from v4 to v5
> - There are still some discussion about 64bit register access.
>   Drop 64 register support and use sperate patch to enable 64bit register
> support in future.
> 
> Change from v3 to v4
> - Fix build warning
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309210500.owiirl4c-lkp@intel.com/
> 
> Change from v2 to v3
> - Fixed sparse build warning
> - improve debugfs_create_regset32 and use debugfs_create_regset() to dump
>   all registers
> 
> Change from v1 to v2
> - Fixed tcd trace issue, data need be saved firstly.
> 
> === Trace ===
> 
> echo 1 >/sys/kernel/debug/tracing/tracing_on
> echo 1 >/sys/kernel/debug/tracing/events/fsl_edma/enable
> 
> Run any dma test
> ...
> 
> cat /sys/kernel/debug/tracing/trace
> 
>  uart_testapp_11-448     [000] d..1.    69.185019: edma_fill_tcd:
> ==== TCD =====
>   saddr:  0x831ee020
>   soff:       0x8000
>   attr:       0xffff
>   nbytes: 0xfba40000
>   slast:  0x00000000
>   daddr:  0x8aaa4800
>   doff:       0x0001
>   citer:      0x0800
>   dlast:  0xfba40020
>   csr:        0x0052
>   biter:      0x0800
> 
>  uart_testapp_11-448     [000] d..2.    69.185022: edma_writew: offset 0001803c: value 00000000
>  uart_testapp_11-448     [000] d..2.    69.185023: edma_writel: offset 00018020: value 4259001c
>  uart_testapp_11-448     [000] d..2.    69.185024: edma_writel: offset 00018030: value 8aaa4000
> 
> === DebugFS ===
> 
> cat /sys/kernel/debug/dmaengine/42000000.dma-controller/42000000.dma-controller-CH00/ch_sbr
> 0x00208003
> 
> Frank Li (3):
>   debugfs_create_regset32() support 8/16 bit width registers
>   dmaengine: fsl-emda: add debugfs support
>   dmaengine: fsl-edma: add trace event support
> 
>  drivers/dma/Makefile           |   7 +-
>  drivers/dma/fsl-edma-common.c  |   2 +
>  drivers/dma/fsl-edma-common.h  |  37 +++++-
>  drivers/dma/fsl-edma-debugfs.c | 200 +++++++++++++++++++++++++++++++++
>  drivers/dma/fsl-edma-main.c    |   2 +
>  drivers/dma/fsl-edma-trace.c   |   4 +
>  drivers/dma/fsl-edma-trace.h   | 134 ++++++++++++++++++++++
>  fs/debugfs/file.c              |  54 ++++++---
>  include/linux/debugfs.h        |  17 ++-
>  9 files changed, 429 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/dma/fsl-edma-debugfs.c
>  create mode 100644 drivers/dma/fsl-edma-trace.c
>  create mode 100644 drivers/dma/fsl-edma-trace.h
> 
> -- 
> 2.34.1
> 
