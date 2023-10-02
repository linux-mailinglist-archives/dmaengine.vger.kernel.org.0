Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA807B559C
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbjJBOya (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbjJBOya (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 10:54:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C39D;
        Mon,  2 Oct 2023 07:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVjo7phFA1dEHxZ+xmfNxwTTVOHa3w3CHlNyNLpSLyyAPdVFBm16oX/Hxff8Jk52PnLdSQ3EijEoqmWOaTYTTkTBL6bdbX7nps6DsEy2t0oki9+XxRFdUXUUto9DYXHEKZZV6vhwHKo/NpPIoEDIhd092uOwVWniqB69Rl4xo/D2K4B8CLbwi+IeyeBudvoNWUy9KaNVNUEOCoilqAT/md/4XKHxDJRnOhz21srUGfbgGtWadzSRWCZzwBP+H95e4G70vNxRoZOsV0dh/3lEbqnU/uZKpWY2vIfPN2v3YP9BgCkZcyof457skt85MSm1aJEbYaPTjKfG9xK/716Iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDbItpV/GNBhq+0GpSZXdtgMQQZshm7lp0N3V1e3Eso=;
 b=FYhukA6XsAWbY4gPJ73uJjyGxPdHv8jWhCAaop+nMbFxFNquozh/vm0HPRRbaBPpvP35dZ5cUh70WxYte+4txl/prg7TvPNm3j5S8lBJDoCZiM8AC+e7ZzdW2/KEftScXngczwevyR/maNVN5ag0zxWnr6zcCAmT3TFHr3MuNY/hfQsOH1QIrMPGg/HMwk62JesJqASYphKOp9v+UJwViGdHR3sLFzoBFdoCOEyvAuRCpiB9DNsxqp5UZisceleZH41GgYF/sOjoWbLe8Urxj97NaIvuiqoW6bAeYWnymDBt31+43pVveY8xRv0N1oEpHYiIFlKIqM/nCEapkhGIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDbItpV/GNBhq+0GpSZXdtgMQQZshm7lp0N3V1e3Eso=;
 b=DmxA+24xXwcvTrt0rVzrSd+4LaYugLKPCPo8B2IaquOaEQBQNh3MP5QzdTy5A+GxucUm4egK9TJVoRfstYUKcSEvP7d9anvxtyQqNU76rLKXfNOOCArb3J+XeDn/LRmeL1uVfnaU3JcrZrapo9lNWgM5ZdGEzjOK7t3Xb7e7yx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 14:54:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 14:54:24 +0000
Date:   Mon, 2 Oct 2023 10:54:12 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: Re: [PATCH 1/1] fs: debugfs: fix build error at powerpc platform
Message-ID: <ZRrZlPdS2vD21Zwh@lizhi-Precision-Tower-5810>
References: <20230929164920.314849-1-Frank.Li@nxp.com>
 <ZRlWeeq/AOjyTtnV@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRlWeeq/AOjyTtnV@MiWiFi-R3L-srv>
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 385b452f-58f1-4d62-3c69-08dbc3577783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YRt1RdTNr+FtAF5uGE/K8dliH572e7FvXBXtlnxarFbfUXtUIf9X5TZAvniquuBRVcHmUig3KQQ6I1oTxDOKzQaDbczlCX+emWPEMpm5N0O61ILkJX4iuWPzwerlbLChPIGmkD3Axe+x323jOD6beioAfx+0mtS3wtCzuWXvmXT4LeSlqypB1FPtvxQZwDfe++Oh3m0h9tjBa/WXbvo6fHodOrc6D0mAcnvN6N0ZLHFE+uuINGg7w3yk5CN23gZpODdTg/WtNnKwY7BjNGaOXqEqPW/qCAzim/E1V7aBKdnrb+izol9O7AEgXjpGkKswU0pflv65XpZfoVoVeWw8avW1F3rh4X267zEMBOUiE64nGXknBXzMP2GueRCopSBqvwmyRdNHhiBUEAKpanGw1QOcsWn7LJPyWHzYM0LEb40OWace0iy3zO8qrH6fH/6SJlaYG5ylkh8y3ST8kTa61gWb++JQN3bUaWqQWLLuMV3G3eMxfBMVRUqh3VFwcc//UjxAgUqKpDAu8p5ftyNhXfgRS4rHOjlKiB0/7+JkUa+pPZ1pdWOPblGpqoMUdm9Wp3Z3dXr29HCYVI+eqgyWD6YOo003vL7iOSMlnXyqnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(9686003)(6506007)(52116002)(6486002)(6666004)(38350700002)(86362001)(38100700002)(33716001)(26005)(2906002)(7416002)(316002)(41300700001)(66946007)(4326008)(66476007)(8676002)(8936002)(478600001)(6916009)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jIeYicuSjWvlbJyAFMcCSWlY2ns6QxjS0ZTL13cwBYQL7+dtd1sqYgZ6KN90?=
 =?us-ascii?Q?k5+c3eAp1hatMotdrxzchYwLKN7iYc6P9bOcpWhjNmB6GLBDPEq8uDgne1s7?=
 =?us-ascii?Q?7HfSMW3CtQ17AtvXgzQp8ljqPp2bYZa1vBZGslvFSxzs3EtAZya0GXWNvWsb?=
 =?us-ascii?Q?dz/mYpc4sBL3FJNvhd/7APjDuXbm2epVxyHxIGBnF9gc2Clji+XLKj1gS9mD?=
 =?us-ascii?Q?8BFdnj1tQVO7TO4F7HQ8C/E7vDrEsvPYF97/7pkeobBn8ISU/dV9Dogv+Vix?=
 =?us-ascii?Q?M3EKjrE1I/H4E9Vq7kHrtlqtYYmpU3PzrwJsMvZZe9yqSr8IFyxNDoYy5Y91?=
 =?us-ascii?Q?W9DiafX5GOcM1rLdez6y6rrLO5pMH3FqZ4hy2pcGeOwyoD4eNEt71I/zAndb?=
 =?us-ascii?Q?UIEGoigjhXEEJrwZes3Qm8rDAmyq4ck9UCUrKuBfrcnfIetl8tgjyxCFZbZA?=
 =?us-ascii?Q?vV5KRAUnJ++8uvBeVshUDOwCMd1wuBGwe+MO3tb5w48MmLJll5Get3kMTblP?=
 =?us-ascii?Q?lWDwPGi7I1oT98sPYgifS3y3KX6NT6a+BcbGAj6/bYeaI6lWOGmlNTKyBcYC?=
 =?us-ascii?Q?5CkPGqECkrKuIj8y7YiTQAsnNowUi/3jGLaLirJ//5ii6CEKGpEHnZJW3YAk?=
 =?us-ascii?Q?jm12FsrU64iPg4CI/ywATPwj+d0Z0K1EreDJOUk+vL1S++Cp4dNY9vXYG7nj?=
 =?us-ascii?Q?Ee6DDD+y07eyZdrswU7ZQ7wty+G5NJ9VfsOUrhxzIrivyKdPe9XJTAWs/pq8?=
 =?us-ascii?Q?tunwPxFU0Mv6Tqs+9Ci9rUqVcrUcQQL8DZEy8ZPKiav5CKPJU66ivOwvptN1?=
 =?us-ascii?Q?0wCy+WGc0DYPofdPmJ616mok5GseCsC1V+6QKKF7Y5nImQVYqPdcq7m2QmjU?=
 =?us-ascii?Q?9IMzLrkhiSKPsdWuRjkweX4JvpPwEypjkGKx+gSLK3FCPXmlQEWmtjT+lCyr?=
 =?us-ascii?Q?cXCYXe9z2u/2Xlp0oH8J+E+MUyGqRb+xTkfm8ewy8fmrZFm+bQ2eP3NY6Pv1?=
 =?us-ascii?Q?FqtPPS8FXVplU/s252dWpsQb+97MU84XZ4eMjYwXLUcF/VeannXr8RtNcnEz?=
 =?us-ascii?Q?hlMh56Ph+FCdsJkjwUCt7fqdWB6gosJ7J3PMKWaIqglCL0CVGYlNOVz0lD0Q?=
 =?us-ascii?Q?pOUGefT2OVT6Gc+RNz/RCVAxRmEM94JjjyN8BpoghTzsEMz85ZvyXs/WT7Y8?=
 =?us-ascii?Q?jZRub3ZNIMK2mgGzuZPmyVh7OgBHNiD917VxXIW26kMDTYkL9gAm5ziwXEPs?=
 =?us-ascii?Q?S1yyLvfNlEONiHWLPlGb6wR+Jz6K7ZHpRK3rBitPKBdeENupZ9tSO6ErkZYf?=
 =?us-ascii?Q?0L57rt1ILXz31viTWETAL3bfaGxQHncQzRd3sD2/7R71Wo8gY1F6+9r7zVQR?=
 =?us-ascii?Q?AJuV4whSHPbTGuQHKbDv+xngrKqcJDSuQ0mn5W4DfsXjONbvKFa6CFi+w8/s?=
 =?us-ascii?Q?1V7qvbRLn3o1shrsKeDPUKFeBRIAbVOvTw86gyipzHv6FyZKiXC1ow5MPIDB?=
 =?us-ascii?Q?FBsEt84Vc0fx/QP5NlCsaNr5d4QvUWWF1h99ocKhDiBjjvDtrcvpacNwTSVF?=
 =?us-ascii?Q?s5uU+qPNFeud3I6iQnU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385b452f-58f1-4d62-3c69-08dbc3577783
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:54:24.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuTxIzZ2bWJTUmxeGdB+3evtDdtAzix8D4RAl8tZPGYjFk48PnTt0H0pttPiZ+v3DQoJcnc8vnZS5bjpCO7+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Oct 01, 2023 at 07:22:33PM +0800, Baoquan He wrote:
> On 09/29/23 at 12:49pm, Frank Li wrote:
> >    ld: fs/debugfs/file.o: in function `debugfs_print_regs':
> >    file.c:(.text+0x95a): undefined reference to `ioread64be'
> > >> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'
> 
> >From your reproducer, on x86_64, GENERIC_IOMAP is selected. So the
> default version of ioread64 and ioread64be in asm-generic/io.h are
> bypassed. Except of those arch where ioread64 and ioread64be are
> implemented specifically like alpha, arm64, parisc, power, we may need
> include include/linux/io-64-nonatomic-hi-lo.h or
> include/linux/io-64-nonatomic-lo-hi.h to fix above linking issue?

Yes, it can fix this problem. I think hi-lo is more make sense.
It is just show register value to help debug issue. It is not big issue
even it is wrong.

Let's fix it later if someone really need lo-hi in future.

Frank

> 
> >From my side, below change can fix the issue. However, I am not quite
> sure which one is chosen between io-64-nonatomic-hi-lo.h and 
> io-64-nonatomic-hi-lo.h.
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 87b3753aa4b1..b433be134c67 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -15,6 +15,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/debugfs.h>
>  #include <linux/io.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/slab.h>
>  #include <linux/atomic.h>
>  #include <linux/device.h>
> -- 
> 2.41.0
> 
