Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6C745EFE
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jul 2023 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGCOqj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jul 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGCOqh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jul 2023 10:46:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C5110D7;
        Mon,  3 Jul 2023 07:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alqpJrlipXrtFOEJbake33Z5HAPrUkRhd288JpCiZv88kLAecROn3Lel7O8Jee8rIF4zmg/LkJU3XXlK7EVZhVu1BdON2mTx06KCfq0n5caEIwP0+sj6Hj7/tNGgqcTUB5zFbHxPpSlGQ9v9IUj6IZz+edfeL1wWYuPg3720oxOwE6FKNWju8HBDRXxmvkzZlp8o2hC6RZAOGs5zBUbX50c7yb73XyvwnbqkmVSoCk5CcxqxvpldUDGUOHXe6rZk6/9MPWO+QXuciLN5YnP2shTWKVdm4BhJx8JJuSpfq29wIEjDJEwPTTFaoYFMsPSLBxWmQVKzLeQidJOMyrdE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Bf2yORxBOvSQR8KJG/EmprvhdAYYBwNEDV+PTwhuw=;
 b=cR0JKwyq1tQYwtSYGoHluS7UVdN2Uhap8fT2hsr8nGrTz5ROMAaZNLMAev3Dm8S8dQc4FQXPpoRPvLBBniNqkysw8KOhG38lZFtN3VcdhBnu7MVMfSz4Zvr1l90lyLrKzC9W7GgZl/nRF3FfgipeZVWCvhuimY4CKcU5yn1808l3WPtHduVKZ1xCNlPqr2buq1tHnQzcBc3YZ9LcZmC0FroiJoiA7GSTxvtOn3dBIZl2b344R+xInN+OPncQrFozooZXWgdeJYKv44f4AEkLpuOIyB0RiHcB7TjVhqnmG3jr6g9pK1BA5bDRXz2eUQp7ldr7aMPWgKia4gKB76dh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52Bf2yORxBOvSQR8KJG/EmprvhdAYYBwNEDV+PTwhuw=;
 b=lpSzvfmkk2F+wxLv4wQdGrU378liX5eNmCRNXuCEZbrLhsMTF16Fsshjj8BL/kaHQk+JIATM/FPuQ4dzBuDESxoq1xBMVeg5y6LGKYywoIBJmW6W1sqKK0+LDoPUjUEDBGw2+yfDkbVpSijfzFkBbz803Niz5rbvYHRKiHFlhsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:45:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:45:40 +0000
Date:   Mon, 3 Jul 2023 10:45:27 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: Re: [PATCH v9 00/13] dmaengine: edma: add freescale edma v3 support
Message-ID: <ZKLfB7putFfLlAoH@lizhi-Precision-Tower-5810>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <ZJxHc62V72eVMYu4@lizhi-Precision-Tower-5810>
 <3ce07ab8-9ed0-d5c0-e7da-bb24085cc3f8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce07ab8-9ed0-d5c0-e7da-bb24085cc3f8@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: a5165bda-988e-4b8f-c0a3-08db7bd42bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEf0B84+1Ue3Gj7wXdyXYUmtpKmwYd4birjOC1hAricXbei+XalYh+QsK5genzN9Ywr7yHQm3BR+G38ns5D1UliUpJSWZZcmZfAIOSbyjsaq2Kj4kxpr1yeP4jslzgfDdiSGOA6RiKfI0jHQx1UdBpvPzVYYeLbpj6itfREjZa9V/HJ6LYvXEfLGiQ/zXrtOQ1lbb3Q/tE7N80hjY6Ro08TfC3RZ+DEOlkokfxtyo0BivaF0ruXf3J7e4CZqEnut2UtdE1U2nk1cYe2f0R/zqS4sdKp9EzXErcGVzD1BLmi568+z3xrdKjpvA5eMUC88jc+U0PLDTPUEtg2m4BBYbwTtuoAe6T0VD3rDXah9bayJ8XdVcw9e2l4Djjdc1KA6Li5G2WIkLnb7/VqN/emtdCHFna7vAi+iUcunkZa0JUKGTGo2Cj2CZQGSRB1I1QNR6fi5O0CMLP829PwKTWuiWXYGCPgOPqSRzh68DR8Or1A6jNMxsY82G151xPqmFpuUFMXKSOpkNK6/G/XRThioMZXg7xLoZ1MPrY19KkSjm3Zk4ZwDDQk1hfrC8sQX7FFIlo3BwxoBU3eoM4QqTb0OTUrJsoJ8ojNGTQ/uW1esYNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(2906002)(6666004)(966005)(52116002)(6486002)(316002)(478600001)(41300700001)(5660300002)(8676002)(8936002)(6916009)(66946007)(4326008)(66476007)(66556008)(33716001)(83380400001)(86362001)(38350700002)(38100700002)(26005)(53546011)(186003)(6506007)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+f4zGXikrOE7jydNJEVeqvUM34ESBSrHw04CgdX5kcTFJzp3r9DLxBaU9VX5?=
 =?us-ascii?Q?RNZoM93H1EGZq6tZBEptdEIjrddhmalB3q7ZH6q903FzWMpbmaoENFeumO1B?=
 =?us-ascii?Q?uUJN08+MsaOTATU4MRTgN80wobXyo4uIvFRdWPZYydQ0kkxqsehn9h2/y60J?=
 =?us-ascii?Q?EBvnvRIO8ecyZrdzOiEykx1A2jAfOOqC1x3zDBIz8chZkd7eyF9BDsVq8Cuc?=
 =?us-ascii?Q?hxL3bUAfwiw/UDkcHdAJW80oWVvACGvmzhHPalbRMm27aU+70AUv62o2Z2Bu?=
 =?us-ascii?Q?8DctfyBKWbr9Q/yHVmugn2GS1qRDAgyEKUDvSgp1CKbjsmCL6sf0NnaHcN1v?=
 =?us-ascii?Q?Cu8D5My7nxm18Gin5XqPgEilhYMqxe3FVaSi97qimbpncrcQVApD9XjMMzgx?=
 =?us-ascii?Q?uQx3u1+c77dOFdCxLKkEXY49qSp79lxtIsHNjF0v/kPf0KENBqtjCjuMTnBv?=
 =?us-ascii?Q?88W0dr1Iwk2aOf6K67GT4fffBggWlfdL4kx7fxf6+vPGN7TqrqN+k2oFZNtZ?=
 =?us-ascii?Q?LgVG+vLLJk4FnzOA7sJpmq04J1sQDMgXKck0kpfzQR10G4xN+4fJFq2zvoxc?=
 =?us-ascii?Q?ffYwOg44hEHSZ7X/uGNmQuQ1hOiPoxiJwgiA6qiZJRyPDcrT4wYtoB79s1cc?=
 =?us-ascii?Q?MAeE6bV6BNvPo0adfAQSdXajbIPqx6kR3gZ7VnhF47JCz+xNf4tlv/FM8Brg?=
 =?us-ascii?Q?+LzGVf/nrUy+j3xg/Xo0pH9Dr7HkOAMJHeQWdFbkhUhRi65x5V5UEDYuRyMG?=
 =?us-ascii?Q?ZWTY7wp3REhJoGFg6NvM91X3626tRLaS5P0KwdtNrTG0RlfJVtX7YAkSJJyt?=
 =?us-ascii?Q?/3EpafuBLF65KeF81VLJcxUZXmNvnymmxpkfCtskR8JH0TqvSIt+6M/0t1uw?=
 =?us-ascii?Q?nszWmjG7mSdfUYPYSORS1IS3Sm2+KN2Mr0jnI+ITrkvUn3+1xNAFsnNFlMw1?=
 =?us-ascii?Q?xe+7w1VlqihEhxAix5Y/+kPFiszs1d3GIm8tUJNdnlGswiHZtYy9qkZXyyQH?=
 =?us-ascii?Q?LeYyGvdAHI/fykpCuSMcu/sPw8FP6jmBzl4P1pu32NIIT7z8v63CZP0J9b1/?=
 =?us-ascii?Q?q6OiH4CqBnVQgA7ujzE7cgBZLQp6FhwCOcWdV5ReoQzyxxzwnlOfaY3qZbXD?=
 =?us-ascii?Q?lTi4aGC/XVQD63BeOJLfSWzM7M559oqKjIe9YiHjbPTOW/fVgCSncG15kLKU?=
 =?us-ascii?Q?HyWPZU2DBNbpmtStDZAAuV8Yyq3wD2InPPI2ObEzHtCvopMqqerG77cLWUMZ?=
 =?us-ascii?Q?qjIz4rCKVypTLzKZLG1AbAX2LnegQepGrrALL5iCUttdu0UiutGMar8B3v1A?=
 =?us-ascii?Q?wRA1T5OdBjsIIL0uCqyHXJ3hwNUlfvlzhhmTpAZpQPiKagssRH43Xcb+Dz1X?=
 =?us-ascii?Q?aOedsyu90iWIvFiaIMkVuCz0hm1h0agh2ztVcSntDZfiGtdbtarmhP6+ApBm?=
 =?us-ascii?Q?dO2X/1Wsx2PeaHi2AUNbTEByyp4p/tZhWUERWKrnIEbMcw0yoWoF24jbCpkX?=
 =?us-ascii?Q?v5mPHX34/bjSMPl218FDlR3MpnUGpqXVkbiXy1qVH//LLwXg4NkAYGsTUMT5?=
 =?us-ascii?Q?dxjhZ3wcqBuwIABwtCk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5165bda-988e-4b8f-c0a3-08db7bd42bdc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 14:45:40.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5diaYqQEIm+21AzdTIVJIpLsM3wEe5Ya+GsYFhSX9JV+z4Z1Q7aXDALdCtPb8QyVMTZGPmvfUsrNxbTZJKF8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jul 02, 2023 at 10:22:22PM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2023 16:45, Frank Li wrote:
> > On Tue, Jun 20, 2023 at 04:12:08PM -0400, Frank Li wrote:
> >> This patch series introduces support for the eDMA version 3 from
> >> Freescale. The eDMA v3 brings alterations in the register layout,
> >> particularly, the separation of channel control registers into
> >> different channels. The Transfer Control Descriptor (TCD) layout,
> >> however, remains identical with only the offset being changed.
> >>
> >> The first 11 patches aim at tidying up the existing Freescale
> >> eDMA code and laying the groundwork for the integration of eDMA v3
> >> support.
> >>
> >> Patch 1-11:
> >> These patches primarily focus on cleaning up and refactoring the existing
> >> fsl_edma driver code. This is to accommodate the upcoming changes and new
> >> features introduced with the eDMA v3.
> >>
> >> Patch 12:
> >> This patch introduces support for eDMA v3. In addition, this patch has
> >> been designed with an eye towards future upgradability, specifically for
> >> transitioning to eDMA v5. The latter involves a significant upgrade
> >> where the TCD address would need to support 64 bits.
> >>
> >> Patch 13:
> >> This patch focuses on the device tree bindings and their modifications
> >> to properly handle and integrate the changes brought about by eDMA v3
> > 
> > @vkoul:
> >   Do you have chance to check these patches? Any chance to come into 6.5
> >   All audio parts of i.MX8x and i.MX9 was dependent on these patches.
> 
> Why do you ping during the merge window?
> 
> v6.5? And what about having it in next for two weeks? One thing is to
> ping for something forgotten, different thing is to try squeeze patches
> skipping our process.

I saw dmaengine tree have not update over 5 weeks.
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/
And vkoul have not sent out pull request yet. So I just want to check
if possible. 

Frank

> 
> Best regards,
> Krzysztof
> 
