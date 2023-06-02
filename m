Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D742F720B17
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 23:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjFBVkF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbjFBVkC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 17:40:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96AE51;
        Fri,  2 Jun 2023 14:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAdW73DMHAZSA9MkHz5yIBWfemafgVPBPGl7ch14jgCWINTu465WQHBblOnA3W6jQDAMcMtspK0TXRIruesXBNwGvikYyh9dFNU6KjN83PVP9HMIF+GKeBuihw3N73VS1va2A2fKbV+3iZAYDD9/qHMNAkx/ngI3HAT91DoSx5gK6Za6FINXQJC+ccYs/2bwu34Txk9OUe1XRdztVm+7drdR+b9hT3tKjU7PrrV7KyT51U+G5vmDqhJrIm26zlPOXV72gNVtlC4+VH9tmy+2MzhI97QfNxYEBCltJJAGknSFFXdLJ/edYoPy1yAHUlUP8u60THOVoISUkd9QPyWgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxZZQhNMW7iuuOHiA31wqE6HxauQhuMqOWKdw86TfWU=;
 b=ngkFpPkLioO1vcyuD6pq/jlCtCPT74PVxvnsa50ZtNWEQbfvlveju4jrJWr3cQbXeOc/tgoadzPMoydtHngF5nzjgykOXQlY3Sw24D4lmvl9OboIMbx/uUJ0ZRmbO2wpEJfyyZDG0+4jqV57yaOOB8/I7KWz9+7ghhPwaT0POq98rzUzKNBmN77j0BvbPb82n9VF5oYMdfhzHFud8zYPYxL1mNLrvb9TurhlL8lkTCHFJiXiUqvfBMMGU7Tt9Eo9TVl4UBWzuW03XnmDtUtlpkclWX470tWo7wWamlUIQCDNVbbcDLcU6sbSjM2b19xta2K8CqTBMr8Sr5Pa9an89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxZZQhNMW7iuuOHiA31wqE6HxauQhuMqOWKdw86TfWU=;
 b=kqed2ZvnqvFrrChCX6qp78kcXTkyVT1yluiWH1yUnan0IXYZRj7lafWoOU01NFDiGMmuOBrxiZqFCX8VTBaQrXZk5D8G+K8dgNrgUk5giMjcB1HZaWwjxLX8FufxX6GHZ055V5/EgTo2nyQ9dpPwjhLDEZhO6xqQiGCcP9dj/Ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7906.eurprd04.prod.outlook.com (2603:10a6:20b:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 2 Jun
 2023 21:39:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.025; Fri, 2 Jun 2023
 21:39:55 +0000
Date:   Fri, 2 Jun 2023 17:39:40 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH v3 11/12] dmaengine: fsl-edma: integrate v3 support
Message-ID: <ZHphnNw54dkRgk9E@lizhi-Precision-Tower-5810>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
 <20230601144107.1636833-12-Frank.Li@nxp.com>
 <AM6PR04MB59252F1C1BE15C61911C60EEE14EA@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB59252F1C1BE15C61911C60EEE14EA@AM6PR04MB5925.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:40::38) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: fe800486-a306-4871-b4ea-08db63b1e7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6cx3KZS5y0sxynUyd5E/yYIjFMOa7l9PTZflXpgNZ5lqvbGq9nHGkMGKVlo3WJ7kq8c6lAhNDTWgtYZi/6orqeVfdpxcVDJXTbZkCgvZ1txaZ3ekXEXmzvJdMB6S2M9cXQq2vVSbSEBoz/0KVEXkB34D3ymZMsghyESiHmXASXpRdKfXbCaPstV1eTa/AQ5gS31QXwoswI18+jSIurD726sb697GBEyKOtjEbke453icr4KPTifJhVrpvea/ymvjtmwnWqL3ah4+qHXXVfUGGaXYYyOpypnR+LJiUY/rfkXWqCobe1xAMEyrqOu6Njdfz6jUfZ9xjmMmmOvfZ3C8ktTv/zjMU9K8iV/NsIvlCJK4UwIHuC0UbSHXYmhKuZXDB4UJ5y+hn0jySW5ly5YRlR0bBcWJTJ36NbkWH04Fd2EvBhMOZ49hISfw/8EVNM7eugoNkSD8EqQm/Wn8LaRjwnYGnzyl1ZScDZ6x1YbyOp6zobNXlgwzqor/vKPQLzO+pL6KQs4Q6AA5k4tVxpqrjrNVEV8kq7U5xUiD++V//3YXYP2SqjttPEclPff6+kciO4Fa+MRHF/Rqc4zgRwovQt+/6Wf5K+j4+yt2USjvfyHHf/wVHjQr4E/5NIPBEsD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(6666004)(6486002)(478600001)(54906003)(66946007)(6506007)(83380400001)(6512007)(2906002)(66476007)(186003)(33716001)(9686003)(26005)(66556008)(52116002)(38350700002)(38100700002)(86362001)(41300700001)(316002)(6636002)(4326008)(5660300002)(6862004)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfAdJ68wkM3+oEQW2Dh8IrV/KJj2WOmIjwtXFxFRyqOCvNpEqAL+fLbg5Urk?=
 =?us-ascii?Q?9hJSCcvmCsFOpVE0xbyR0CPiJpG3skgCBN+bK7clHfyPmyq4hFx+4kndo8+r?=
 =?us-ascii?Q?vtgecG6KK2GRbT78xoFfONhHJ8rsVC7dzgWD0SY9NAZJU3R+eRgm2UkzOCaK?=
 =?us-ascii?Q?p0wMBa5C1F6Hc3kwZwkaxYlASPXvBOm5Xs1VKyAAP5cRLsb2b/NKPko6YKqJ?=
 =?us-ascii?Q?66vwzpSK6H1h1d2DtyrOAcNWo+PBlBB0HNjM35/DNc1g6fZvsjoM+90p3mnU?=
 =?us-ascii?Q?jCYbnDX6R5zCE/KpNdn0E1pdGuzyzdc+Bv6pmsyomMvyas4wbTwSBvv9IKCC?=
 =?us-ascii?Q?55LnY0I8qFPKts1soRBi2CCB2mlSZSEGyf3146wBZa3jkO7Upc4rokMJbq9W?=
 =?us-ascii?Q?fKr7Fp0x5NKf26NKYkx6kpXVqLMcdB+Cg+TSgk2luGIFbYNjPPx24N65lf/b?=
 =?us-ascii?Q?YdIOotERPwrznRDuqCo9ap+yRXHDk6tHCjLCq8guPNdYFn6gVrlMbMEHfscC?=
 =?us-ascii?Q?/T4Y3DPq5QI8EcFZNEeWUpvQ+aKC6tgLycC9wVmDKwGom7Hfx4Xdtx1Xydh+?=
 =?us-ascii?Q?HO444WuYQ7pbmGZbgZ74eJVOAYUkB97oHq+WpXI54VsDR0m7S/Drb7cDU3dt?=
 =?us-ascii?Q?oz9fwp7k1MA9RBci64CiIIf7HedLPk56zmUIWVSHNGMxhloBIBs6nsc4dZK7?=
 =?us-ascii?Q?vRNjyx+BH3Q+RE63M77SclW41+US+BtXYSZeUqrWruXdZbObY2VEJY0yOKOI?=
 =?us-ascii?Q?KDYpiELGSEOEhPdu1c92h3g1aYaMmZcOyNTaQzgKAB9Qx4tChJcjcTvlpNrv?=
 =?us-ascii?Q?pbjTs8+5wISzKUAukMv2f/lcNvFbq6MeX6ck4N9+o6x+HiCIHJdF8fB1bUFO?=
 =?us-ascii?Q?HQwDq2xR1jOCvxLSniyJG4rntcdGBwE/8dRMkLczB0AKWp/VH0k0djdJt5Cy?=
 =?us-ascii?Q?4rcIGazDAgpQC13kvlfCi6Vx01l9fsnqNKIExuO0e2//qo3f7gw104xlnW68?=
 =?us-ascii?Q?NeR+PsUJc/VfLrOsqa/TkK7945WDqfJxZ1DqgSfkcJXWXmXRRmr3uR3/Bjob?=
 =?us-ascii?Q?gkZ4VtC4zb0Mt1UNdOkPtnbFvFmz/L/tiXPwJyTrcCtWr+0ZGJk19kSLABz3?=
 =?us-ascii?Q?3Sa519XleWVWs9yF8bXJSr2NHwsZ4GYQcOVKvLHucBO9qVRWemnrY1R16aei?=
 =?us-ascii?Q?smcNNX2gLv2yhfOpnVxhUS1Etsx+Zd7JAp5b5FuSw43+uxaGcOseiFK4saoS?=
 =?us-ascii?Q?c6da68Za4W+DxH0GE5G9NxUWc1/5PBPSkZJkDX86802k1GLU3V9KSrviRO1U?=
 =?us-ascii?Q?UeLBEjPpa/R4FCHG2T/QR1qdNgPVrQyypVk5C9q89T/baDJ4jgyiiaTE6YnY?=
 =?us-ascii?Q?kgaFzPOh5PfOGkf6umaxl+OFZW/kXkYQRbo3YkfaE1wW12T+Wv9YZ6swA3yD?=
 =?us-ascii?Q?d6Cw4zhKi8u5fiW67gz1oAeMNFR6WXjQLlOWU7kRB+WTFvlNLzFYmjhUe7h1?=
 =?us-ascii?Q?9BZD1Y+YxQ63tX0WDzlUYZvKhqfWQgUCH6rCLO6BlzWaGnq7AilRruZ/n+7+?=
 =?us-ascii?Q?oDre/ARRl0+objrrwNs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe800486-a306-4871-b4ea-08db63b1e7c2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:39:55.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCj6U34h6KoXQ/yPUADBFgF0nb2UOLmqzn6rzn5zwSdQCHJ2QQV2OhC01Ot6eeWTBlh4p72IYnRj4NACQmgyRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7906
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 02, 2023 at 09:41:19AM +0000, Joy Zou wrote:
> > +	.chreg_off = EDMA_TCD,
> > +	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
> >  	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
> >  	.setup_irq = fsl_edma2_irq_init,
> >  };
> > 
> > +static struct fsl_edma_drvdata imx8qm_data = {
> > +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_PD
> > +		 | FSL_EDMA_DRV_EDMA3,
> > +	.chreg_space_sz = 0x10000,
> > +	.chreg_off = 0x10000,
> > +	.setup_irq = fsl_edma3_irq_init,
> > +};
> Hi frank,
> There are many dma controllers in imx8qm. But not all dma controllers support ch-mux.
> In addition, Imx93 edma v3 also doesn't support ch-mux.
> You can confirm with RM. Can we use the dts node property instead of drvdata flags? 
> BR
> Joy Zou
> > +

I tested all i.mx8qxp have not ch-mux. did you find any one have ch-mux at imx8qm?
I will remove FSL_EDMA_DRV_HAS_CHMUX at imx8qm and imx93 at next version.
It works just because dmamuxs is 0. ch-mux register have not written at all.

we have compatible string, which are enough to distinguish the difference.
not neccesary to add property for that.

Frank Li

> > --
> > 2.34.1
> 
