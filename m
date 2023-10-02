Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD67B5A24
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjJBS22 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjJBS20 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:28:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B2AC;
        Mon,  2 Oct 2023 11:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/3tYpOhPWjsUKt6G3ZQNR6dPWLJsEIIvD5Zv2cG1JgmW8LVuSPsIw38izI9asnGh3D2rxVv7GUisE/Bzb0sTQ43OhiasCLn4VFJQcWSKpjORKXYNzgXJMbHKG0MHX+FiAOTg/S/I7QywBDBhocjX1n5LH8qDUZuoC6NQ/9PRTneM6urwbtF7VJECAt5m4xN/BubwgVeQG3K0QeCmKOOGIBPRWA8gbhNCE+kgB1sg+U3YmWegbHOS8MlHNqwXjIppukAYTffizqf7XS6J9pcQc+aWf/qK11OGXLjPSz+Tn4GpnixTMaS/KDTG7/wdI/mCtaJIThVz2855UdueNHHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWnu0CNzaIhMWaZSAlNa3rxZqvGDFW1UKtXyriCsiOo=;
 b=eza5wgDCyPJdBf5SyyTMszhDkAUsdFkaPXXRf5dIveivPqnUSJybmAzrJIzf0sI0wVJrXIGYnfFQOQNPwQHMY02pMCr1VW8+SOix64a3VOXY19L7kifwphbwlBuCOCsmrAjzCTvOnWGNhmgERkBwRkys/7oVpHUbgrGofd6ws4aWKNiTpIMTmsv1nBdkJ/KTKkyWsqTZACVgmReuYcHMfRmnuTMfTYfpBuIEDPWTRE1ULkssK3PrprvEF64MOV8K1CGz4/894CMdUFrKM5nYIwRxcYFT+yxJFQCGVJfcLot3FbNWt87JIQE4gWZswVXUuXVBks8yY2COGqE2Yp11Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWnu0CNzaIhMWaZSAlNa3rxZqvGDFW1UKtXyriCsiOo=;
 b=ccroqAyLON0tJ83wjviRuK83OcJXbfHMCK6Kx5Yu/pZKozhAqtqVbfimqiJKJOHSxRPHGmUcZ3RmR3s8KPvOH0cT+itZTea+CiM3V75a6cqbbGdAiIYp1hWtuznMXKFmkXw0o23143GGAfH6WQriY2Cx0JVVrUPVWn54gJStTUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9844.eurprd04.prod.outlook.com (2603:10a6:10:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 18:28:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:28:21 +0000
Date:   Mon, 2 Oct 2023 14:28:11 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Baoquan He <bhe@redhat.com>, dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/1] fs: debugfs: fix build error at powerpc platform
Message-ID: <ZRsLu2IDJd2ueC6d@lizhi-Precision-Tower-5810>
References: <20231002145737.538934-1-Frank.Li@nxp.com>
 <32cd13af-21fa-45bf-9250-b5f3ca132b9b@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32cd13af-21fa-45bf-9250-b5f3ca132b9b@app.fastmail.com>
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9844:EE_
X-MS-Office365-Filtering-Correlation-Id: 691b5c9e-d057-454d-cceb-08dbc3755b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gPpVhE53YKHUv76kL+36lDfDXssjTBAVUPf5KeCBC8C3z7eyFEcZpxZYvVbydC2lk2RuMhjwyozMZRrHDZN60IjVGYHMxE/G9V1TwqVXJlvksvcWtTWERX++P94TPzpPA80OfmDFKx8z7j85BonMuUabgmNyGVSAPBHgB113twnYiXCdyFR6ZuWK263GyOK93DAkKKGxkJNkNvoHEYhrF33k7ai0NUsEnCkFa7/0Aj7SPBzGm/FJV2sab27VPQsooDCFEBuwiWrYhDhChTFmaSU+Dl9exbX6JRMHoyXXMWLXwD34iWem4iatfxZfU5QlQM+5zBO5aZcDeqpj/winQNDOgluAQn0mtMssXC6ycTB55QsO7EDZjkH130hNizphDz/scie4YmJwhX4wFmGgYs7DshjvoV8lOruKOtbN60OssmPoOx3JQo6c1Qvg6aobgEKKCzFfM7is9RWnL55hvnqj+vNM9IdcpQPzcwnk5TmYBHaIIzvu0JfHuCDTOu5ELv+CSd6nc9qAaz6GQ3Zv3IEe4T1nNJ0mDM4atfnAdagVg8qALetbMhW0J4KSqJZ0f6ff+01wAyICDL3VDIJgNKxLGMCEJ55dry9ZSW8T3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(86362001)(38100700002)(478600001)(6506007)(38350700002)(9686003)(83380400001)(52116002)(6486002)(6512007)(6666004)(33716001)(966005)(41300700001)(8936002)(8676002)(4326008)(5660300002)(26005)(7416002)(66946007)(66476007)(54906003)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywJGkyKEljDbTD2bcuWvAsghe8osyrw832j34TdEXChhHGnkvb8kyjH8ZBfQ?=
 =?us-ascii?Q?KDE0LfVK4H+RuEtUeSWmydz3mPdg6tniPqHkmbZEmDbS4seLyHYZ5EO9oOgD?=
 =?us-ascii?Q?aHaAgP1MImNJAB1SwqwaRYS/IkTL0kehV0ZmAPmO/REd9oAbMxCBo5E12vE1?=
 =?us-ascii?Q?H6AWm018awYaZWJHoirYoytiBtJOava/U+ldNqH/7lyYdvsFiN773ir64yHj?=
 =?us-ascii?Q?9SMWPO2ml7yP/WlEa2DQbQ0LhNIU3QJ8O2fMdsC+UCzIEi9wB5Gst+N53X+M?=
 =?us-ascii?Q?k4jMtfaSnm3DykuyQUIHA0SW1IcSgJ40GQrQ5aZd71E/smjZEkTweLi+Em1Q?=
 =?us-ascii?Q?AxDKvq6SQfE3FeBk9kidXMb0QLKEn+dDaw5ojp4axy+sM0OaaHdLpvKRfp39?=
 =?us-ascii?Q?OtyD59vGMFdq/xTkXh5f3GUV4J6aDTUKPTFNWs7/VG3Dgqnj03nxLLucLGwY?=
 =?us-ascii?Q?Hw8JWhZc84CxDvd1BuVJc5bpOcYbDk7bjaQs3gs5DqWlvRLztJpOJZ4cTr4H?=
 =?us-ascii?Q?p79ca7gXojbUkUFrqGzddaP7dREWAqqkQ2DqO33tGu9j8nV/6uSMPClVv7AC?=
 =?us-ascii?Q?I7oWit3b3F54mNhQvAIFM8ADPXR4tmirQHoTBk7I03RC8dATPB1dOddj/nC7?=
 =?us-ascii?Q?89vGtiHymbtB9XZ82yUmRVRJEAPD6VFVZEkQNuJkVKmO3XrXKN4JIgnbRA+m?=
 =?us-ascii?Q?IyQQmWKfnXdzfKbWRkQJ57J3uvf4e4OX2vC04dv5A5dtKZtYiB/6nhc/MyoA?=
 =?us-ascii?Q?b6NtpY+nzn/DgH8cdvm/7JBwvFPJOD9WvR4Mzw5jGtNl3e2Gk88pC2pDSU4l?=
 =?us-ascii?Q?LP4CEOym76iURfmdfujCXTUfN7iTt2k4dAdYemWtq57sHFYNpNbRbOEJm6rN?=
 =?us-ascii?Q?M6DbogD68Ig0ueYCHlfJsXr++b/OJ2OxYgi6ugDiraz9OsqC70N6MOfJtMu0?=
 =?us-ascii?Q?CcvgmaYm7mUSERC0Ez45pADB9pl1TgOdZj9sDykm2VZwM/2ffi/6FdZVwxxq?=
 =?us-ascii?Q?11bj4irDt+yIrY1f17zwJ/SvXzf5NZSRjnmUCFNRql+Lb9Y5o6YHbhZdzbg/?=
 =?us-ascii?Q?+GFnagM74bQwzwTaUSdn7/u0f0dDKOYKy+WZxA/qnoS6Whv1aRl/2xOwJRdR?=
 =?us-ascii?Q?zvOcd8cnHp5gcSC8BfmXFGupsqAmHGoJrdrxttE5MO5QotqxVw40se0/ngwA?=
 =?us-ascii?Q?9pXfrk8y1hI/5VwDTJr5qZweGJ5U82OjKEZm5c6M2jRujsbdr++DZycYvnBk?=
 =?us-ascii?Q?puLFQphGKdQQLU+CsFv3LLjuQ3KVUCiD/Au8U5k1TS24zCC3YynjoY1NiO5R?=
 =?us-ascii?Q?8qpjjaN/j9ewIuwFcqB4ZepySFxh6bdm5kupJsXM0uvEPsGb846KB8UtcyDw?=
 =?us-ascii?Q?/O5ZJ7LesNxGHgurBMa2LQ47jnyFXnJoeuYnmw8XU9I8ra5jjEiE2d9udTRR?=
 =?us-ascii?Q?dOPJP4kIr9kH7AhhWO+YegqQpOjfP4a/NsrRewskI+2Q7y3sxYXcZGtxsQCC?=
 =?us-ascii?Q?S+dIB4o99cVBnR+G8BoBx1oSUYeSG+8RCoK5F4FwBtF27N093caHZGDk+8R1?=
 =?us-ascii?Q?LnmKYxYxo0XbyxODGv0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691b5c9e-d057-454d-cceb-08dbc3755b3b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:28:21.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IowP9czTJgdoC+oRxHgya3FgmMC+codLOu7cU8v7WJhk8nzLGSgbCpVdPdzqSE2jr08bb3+sBoGxeBSlDltQdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9844
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 08:14:47PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 2, 2023, at 16:57, Frank Li wrote:
> > ld: fs/debugfs/file.o: in function `debugfs_print_regs':
> >    file.c:(.text+0x95a): undefined reference to `ioread64be'
> >>> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: 
> > https://lore.kernel.org/oe-kbuild-all/202309291322.3pZiyosI-lkp@intel.com/
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> I still think this is wrong, for the reasons I explained in
> https://lore.kernel.org/all/b795ed61-0174-487f-a263-8431e7c76af5@app.fastmail.com/
> 
> The part that I had missed earlier is how this is
> related to GENERIC_IOMAP, since on those architectures,
> the ioread helpers are not just fixed-endian MMIO accessors
> like readl and readq but also multiplex to the PIO functions
> (inb/inw/inl) that do not have a 64-bit version because x86
> and PCI both only define those up to 32 bit width.
> 
> The best workaround is probably to use readq() instead of
> ioread64(), or swab64(readl()) instead of ioread64_be().
> 
> This should work on all 64-bit architectures, plus any 32-bit
> one that defines readq(), so you can just use an 'ifdef readq'
> around the call.

My previous patchs were dropped by vinod.
I think it'd better remove 64bit register at previous patch serise.

Let me create a seperate patch to enable 64bit register support for debug
fs.

Frank

> 
>      Arnd
