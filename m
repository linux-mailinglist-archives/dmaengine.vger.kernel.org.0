Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D707C7B5AF1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjJBTHW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTHV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 15:07:21 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71AAC;
        Mon,  2 Oct 2023 12:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkEXRgTm0Uf07CzYtg5zaQKsFyE+O7b8tmtDM5650fFk0DAsmfNDLgj6mEDNzjjebzMBc7t/D5fnS3qZA733z0NMb9OfarJJ/7Z21gPrEZgL86gte54A6lCtZ+J3gASJZVU5k0wb0ub0C4/rKTEGj5FoNgJIW/KXzbZJ8aTjBIalXWVlNwQm+lwYMXGEnaumKLpLWtnOzxaxrAPVYpyXnd1HCi5oNB7jvQLwGMbEhj5Orbac8MHEfO1LRup88b+I92MBnxLV08hNLApPQ5BEtYFAzfAJGdwvNauI952NNCyG0/6hf2K+OWIp/qdjaHOvPku9iIM6zLpgfBCaFaHbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emKPoSmqHfzNXGj6wMZw1INGLEMJu03AzMmKXlZ92E0=;
 b=Eu/KZKQkBb4Ls8PcAXO60DqXrHB4ZRXcSDBlt/11aafC63eJ4UN5HVZ0mzXkbgG0h+cwakM5br7RVSeppxStacHXIJw6toa1iAbrR6Gup3uZGvXRLjDKWiEAtRI8A3cJ0J8obzgSqqisbs8Cqym62wtD3vy+Sl6uLFQAMLLetcQfQzKdj2HBB4ZqUUFZMmELjO/0LfgW8V4VH/Vf02kP7XzZ3U84NHdW7541hVcYTePN7TUim5H4Ybo7wEVCecyumBBZmd0CUe1XjMkC618lYHr7QbeASqWA1zmNtrDbv8mVptFNKjAabi3NMJaJlV3UGbDddhgrl+6IzWdu1PLGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emKPoSmqHfzNXGj6wMZw1INGLEMJu03AzMmKXlZ92E0=;
 b=LOMb1c+3Bn3fNK+55emFSnSwgqOk7+efsnOvSlYL6d9hfGN1z+Y0INpniVoL0lQVKT7Xfw1hYs0HY8qvJtUCfhq+3vgJEoOIJiA6y22i0Zvg+CImQIRDhHlGt81R3wVrDCBciVPoWdotlGp8OG/aH0T1XuJlMGeJvnIzOZB6kmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 19:07:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 19:07:14 +0000
Date:   Mon, 2 Oct 2023 15:07:06 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Baoquan He <bhe@redhat.com>,
        dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 1/3] debugfs_create_regset32() support 8/16 bit width
 registers
Message-ID: <ZRsU2gfjxAAOiHyy@lizhi-Precision-Tower-5810>
References: <20231002183750.552759-1-Frank.Li@nxp.com>
 <20231002183750.552759-2-Frank.Li@nxp.com>
 <7f39410a-72fc-463e-b41c-64674ab4f129@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f39410a-72fc-463e-b41c-64674ab4f129@app.fastmail.com>
X-ClientProxiedBy: BYAPR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:a03:80::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ee5baf-00ed-434d-2599-08dbc37ac9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6IGMCXiDVDVo34muAau6YJ5MSD0dKyBPrNIMBuEiqiODsmsallgOqLX6el/Xk78yFBIbqeNTm6zoWEykIeZbWJs/lMg6TYb5HOidOPoJ+WetWSCet7wCSLbxJjBTExLfL60MEcrB0Ob80VtRwLk5No0qqxnDIOSWOPH+jzCPmbQuTu0UktyjF/EV6j/rKE10oVHV8xHDisKy6ZL9yrT9zObk2Q4rJQegySvvNSbqIDnTy9fmyjV0lM5OqCaHAaagAagifTKCU4NIHTYGz7MjPWVFkk5GSX7B0hqyJGnYbB5sLkMHz56y5Xe8pRbLc7JwJTEAnLT/NiR1I8X3gLMJET+HRtOkssrYhA3KwxOI4pz5SfAPsZ4OH80TXWBdeWYb3pBX6QTKkxWbPGA+pwZEX2FJt5k3c5hrIpA1iFPHmo8KWkByAdfsCzSTAG4G7WmrVAgW+Zn/en0GNph8GV8g6Ede7+JZWdtgGcEhk6k2OHfneUVz8/gj/3GbprgAfAzo00DcBzN5ZGgrTPupCicOeCPm+MMECVERb7TL0J3Ls/AS+nu9nCaX6MBCjWy8APpVCd44oppcB+9VNY+7+i2zzIhZ8bcoqFkqPFOzSRCsxNb1MPrRLEE/2oMEc5aqn/R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66556008)(66476007)(6916009)(54906003)(316002)(66946007)(2906002)(478600001)(5660300002)(6486002)(6506007)(6512007)(4326008)(26005)(8676002)(6666004)(8936002)(9686003)(7416002)(52116002)(83380400001)(41300700001)(38350700002)(38100700002)(86362001)(33716001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CoVmDTEvEboRkwPATZMYFF9A0esqYzNrWV6vgZpoCeDUO1zILAd03Fd2aW62?=
 =?us-ascii?Q?bwzFVQfCRa7SH+lfYBUtia1cGyH3OABG6uLi0TMx4rWO7BHOsda100VQ6VCl?=
 =?us-ascii?Q?v4eaI9bsXq2HKXbGpJ9BGuzSmeo+6sF8iH/UQc5DobyXSC3KtHwzLC/zfpgO?=
 =?us-ascii?Q?FNfXU44d5fBhGtF/x5qqr4E/aRw4qzggPX2Q78xEM2j0dv94OGRUKYK6SidH?=
 =?us-ascii?Q?HQBm7wumuyCllKVBnZyB6J53u7/75ZcmZziEW1gurx00zCO6yMvj4fVf9AVV?=
 =?us-ascii?Q?YXwI8vhcOwI0uW6NW8P32kHm8OqL6OqZdS5lbgAdBje0l+HNTX63aRLulxg2?=
 =?us-ascii?Q?1Xv4/rkxH84N3gU66+NqDaBzDcuRkkfrptNrUIV8k+a5q7aZVjyNbkHvgOKt?=
 =?us-ascii?Q?AVmF13wOhsVC04/ywQypuZ0cE4rAMuOCV5HDNgdiMefb14OraBKqcrCBHr8/?=
 =?us-ascii?Q?2dQ1bBQzLeslQd0+xa30HrYD0QcvDqvBBulzryWJf+AMheLHXSov3/L4/1QX?=
 =?us-ascii?Q?Nt3TPlTofooFtj+D3OA6pngkRz8S557QhrEs5/Dwb6fiY8ETaMJuha+397b0?=
 =?us-ascii?Q?sMds8bhc/mp9umE0mmQYSABEH8i/IbpHJVsgNlmb64dn4DVt8xXs23Nk98UB?=
 =?us-ascii?Q?M6baD1FoYKLBKoDAp8FpbUgKAx/2by18j3+RV9Bvuq8XhcpPYVM1Ea+BunX+?=
 =?us-ascii?Q?vYKZ9N7BFFVSUSMVMy9gT44kVO2zfnl4KUeME0if7TZ4ce7S+RnT4BOtbn+P?=
 =?us-ascii?Q?6n1zCfHzGMwUt5o6xkOry3Lj+kcebjhx7Ay348it3WvX53QAb08JD0vKZINx?=
 =?us-ascii?Q?Nw7sqC3QUEJqHIZwAQD0spHOXX5rYwFgBbeYmdv9S5sdkFivcFhggfZzf5HZ?=
 =?us-ascii?Q?5G3ZcOqjTCd2GxXBcQhBb6gr3r98yZgHTP+JUZwL1bup2sI0zdA3RYSg5JNE?=
 =?us-ascii?Q?OgRJQ2a1abyve67bKFJ2G0edlSnrkDUPu1gO07x9/dT4rqgpqGNEQQ7Tji/G?=
 =?us-ascii?Q?5ewZ5pbhdCH3b1gqPJVpUJS/PNb3LZW/RKqM6SCNsDUrpMnCaQ8Ba3+jEnVn?=
 =?us-ascii?Q?rl80zE2oviW/4/Xkspw0uo+9hX97hX7NArjRnQ1/ZVq7YjsBZdckVMjChtZU?=
 =?us-ascii?Q?YtcODeYVGMQS/jLjS7wukW/RUEakmj5/R1kd+FKlRkyiQ/Lkm/Y5l8PtMHtm?=
 =?us-ascii?Q?NmdF7leYiP6oqqAkbq3iVg6GtxVz+uPSFwrBbAxrByh+4X59vFV+0BpQzz4z?=
 =?us-ascii?Q?mW2OAl12aPzjWCHvY45k++k7U6KfCdy+e4ppZt08Ucqu4mJpXD9foEHKcOEV?=
 =?us-ascii?Q?b3YotWkclbEqDVy9MyIsCVh2drpx6yUsSHPKJQTbhmPebiu5IDiqU3Pj2GHk?=
 =?us-ascii?Q?Wsjo/JAh3pyyoEhOae6NK0k29GFaAYC2k6gDyoQ45JCAdzbhk4J/wJn3zh1e?=
 =?us-ascii?Q?8V+nST5ecxMlEPPjjm/1utqS9UY0G1Dcx4prHgDacf8RYRKlhES86WJBXA6K?=
 =?us-ascii?Q?bEwj2MYBVzzYlZxcgXNHDAaXJLh0EP9Dagbqf3/kdB54HSW9buvEU6lDvsI+?=
 =?us-ascii?Q?pTh91lX/m+r8v5LogGs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee5baf-00ed-434d-2599-08dbc37ac9d5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:07:14.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZaLfVVm5rMkwwVavhnB7zmyGN7gtUsgfR5B/rpR95X+gnCZr+fJheqjQhCUtnA3Cum70E3yI9iv5K/XzYh+og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 08:55:23PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 2, 2023, at 20:37, Frank Li wrote:
> > Enhance the flexibility of `debugfs_create_regset32()` to support registers
> > of various bit widths. The key changes are as follows:
> >
> > 1. Renamed '*reg32' and '*regset32' to '*reg' and '*regset' in relevant
> >    code to reflect that the register width is not limited to 32 bits.
> >
> > 2. Added 'size' and 'bigendian' fields to the `struct debugfs_reg` to allow
> >    for specifying the size and endianness of registers. These additions
> >    enable `debugfs_create_regset()` to support a wider range of register
> >    types.
> >
> > 3. When 'size' is set to 0, it signifies a 32-bit register. This change
> >    maintains compatibility with existing code that assumes 32-bit
> >    registers.
> >
> > Improve the versatility of `debugfs_create_regset()` and enable it to
> > handle registers of different sizes and endianness, offering greater
> > flexibility for debugging and monitoring.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> This version looks correct to me, I see no fundamental problems with it.
> In fact, you could list "support for ioport_map() output" to the features
> above.
> 
> A few other thoughts from my side, all of which could be ignored:
> 
> - if the ioport access is not an important feature, we can instead
>   support 64-bit readl() as I commented in a previous email. We just
>   can't easily have both.

We will get 64bit dma edma soon. So I can test and upstream it when I get
it.

> 
> - instead of treating every value of "regs->size" other than 1 and 2
>   as meaning '32-bit read', I would explicitly check for 0 and 4
>   here

Yes, I will update next version.

> 
> - Another more complicated but also more featureful variant would
>   be to use the 'regmap' infrastructure as the abstraction, this would
>   also provide access to big-endian, variable register width
>   (including 64-bit), and pio, along with additional features and
>   other bus types. Not sure it's worth it, but could be interesting
>   to try out.

Yes, debugfs_create_regset may need big change or create new version for
regmap. It is out of scope this patches.  I will try later.

> 
>      Arnd
