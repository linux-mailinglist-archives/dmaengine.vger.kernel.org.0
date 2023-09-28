Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283C7B1F45
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 16:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjI1OOJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjI1OOJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 10:14:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDCA136;
        Thu, 28 Sep 2023 07:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgLFKbfFMl2LgVZFQofCIQC7HRnCSjpuOp19KNF4+pHkACcKKXerdPfxsUshjklDzIP6wohpVgR1h9+DwmLNaVJTmvYE8vh53RwPqNgyufG02WMSZXDUgn+jN6dQ5y4ORPD7Ki5S49wpRdtete2dnaZd3P3Mjet5+O85vHB40HJOpZlT4vyISoZ05NxTp7fFlbUxmmolKqwLDat8fxJvLk9U8WH2dOpQEGYYExjvT60/zl/WDhp1hikuVzelSv+xjxyrY80culAOOTwfwvL214iHTuxdnn2jik2MwL8QjVueoLF0XyTnlMz46SyfhLa8ne9kNARHG7ahn3IHlWU5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrIkbRt96Xz+xfdQePvpa6jZl/cpS3na/3K2/qTvajc=;
 b=bmj6kIWBDAOiVGkYlIiNdPq2oypqgDELjWB8H4AqL69EF0Oxaey/DIejC5wiqDNxM7rVpW1iXGJC6Sa9YUYh47OGrGxDcg8YV/ge4FNgeuJwG5Gxo5CVE9EcbsBi9Hksztvi67zQtBTA0keNV1Grrmc53+VaY10URy4yPgH+5+Pk252rtnsEidLS/V/7gV3LyFM2Nwh/8FUECNl9761jEPQ+GFbOHqpWho/ARvbE/ezdhx6MtvTu4XWKhq+S6CAioaM7bM+QhYFPsa2qBpfJPPCPhSz+I7s9UsFPq3fB0sHJVzNK/bFoGGri4MTZwZhdyP8nI0oA9lyru7dBb9QR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrIkbRt96Xz+xfdQePvpa6jZl/cpS3na/3K2/qTvajc=;
 b=W/LZvdscVBkGcSgnue71WjJFB8Gvb+8Jqb/9aVMjt4InmgNVyOUuFyvDoshh6vq8kcbKLvZ31jd19Opz9rAMH29hG+DHgjVZgXJLNXGGkzUgw+XdwmBH78ZMyK0tpCEZBQq5IDpHo/vTuzvA6gYFeKE7vQbYcBYXBZQS3MibKdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Thu, 28 Sep
 2023 14:14:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:14:02 +0000
Date:   Thu, 28 Sep 2023 10:13:51 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v3 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA
 drivers
Message-ID: <ZRWKH1gSwdLMhBCt@lizhi-Precision-Tower-5810>
References: <20230824145834.2825847-1-Frank.Li@nxp.com>
 <b1c5ba0d-748f-ae2e-4a5f-e1e853161d16@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c5ba0d-748f-ae2e-4a5f-e1e853161d16@infradead.org>
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7ab9cb-743a-43f3-cfa3-08dbc02d2a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tN1CJuBF1utcLiEGS/t8Bf1NeV0cTxYXSVja9ZcBz3gEkAznewToGEuMKt74Be5I2j83+e4pbIplPErnbLJrZt9RnAOVe8RXcqxNpoy+17rDtTzQrqS6YI+87SdfwPy9gCKATjawQLn5Y3CufN8eQDyrHGES96k6wOdJG6Q6zMUMqCr6Cdw+puKKI136V3HlAVsbuCYD7Lcbz+FsasjMcvHMatLKWLCAUg8j1bUmohyhlPtD4UfZ9KJyCG5tuDzz/DlJHKh6Wv1P7RLN9zchT4YuTKGvVhGERg+2V5KHcw18dSklpbrcwakJU6XGdbgUmVH920fgQc6iOTi6s5Io5W19p1v0lV3OxOY/wyJmtik9iKI0gfFxr/L9ugRXiTunidpJpdkhjl59riFZeVaSvcKawaSNjtY72ViwWLn215pJMq6y84lGRwh2I93AVGYXMlVoHq7AW+2i6n7YCLvKlYG2KR7yHRTVuvo2/Jh/CgKV8jg7nbAQi75ZWzCsRwAcsg1y5xWA9PgfD7mCPLp/OZvDJ1tZvRsdELWWoQHInIe1JhFUjouPcunnvgxYxaQgxEeAQLjc3uS/wqWuaAPtiMwcPmht5nIfGcVflgOMK9h8xuKTKnIhIrZw1PhjZ3HG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(33716001)(478600001)(6506007)(6512007)(6486002)(4326008)(53546011)(52116002)(9686003)(66946007)(66556008)(66476007)(41300700001)(316002)(5660300002)(6916009)(26005)(6666004)(8676002)(8936002)(2906002)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MuXE3OKZe6c6e0APjvhYcfbs0E7l56R6aaodzScQxrkG1JZLNrMep0FIghH8?=
 =?us-ascii?Q?ECHhtW45DhBdsZ7l0AmNYwNQ7r1fqCvPBu9ZUk15kubmfZoyHZzhfD3pYlYp?=
 =?us-ascii?Q?C9M81ZguzM3pN2h/lQS+oz9vQDEcG2vDyQmf7LD3TBLZyJwCXmWUAKtm1V42?=
 =?us-ascii?Q?O8k4L8Tf6XlIF3sarHJIGqUUSDcY2Sh7502v2RTEmhiVsoHFJgc8s41nP7bu?=
 =?us-ascii?Q?YPOH7UFh5ZLrJF1cF5mRemy6YAiDJRnQ3VuU9O/MSulAnRUHARJgZW/qanbp?=
 =?us-ascii?Q?1x0v3JQSO9Q7/Xs76NVBbGeIpVRw8/aBvP9OD5PPKzDWW6CjCuSPtkK7MWsP?=
 =?us-ascii?Q?CshiKqHaPEEy4S2bEHXc/LBNJ1YvnXbrGgGJgkD/UOAo1xMOU18o8tu053wY?=
 =?us-ascii?Q?z6LEdTjR8WJN/PT63wyfvukl1U6r6UcHlMjzDv0fzRWRueWtKZDu3YLto9/z?=
 =?us-ascii?Q?bYpOba7f93U4+oQh9YPAf0OabciqTBHfg4VMr8mmmE9nDOzDdVQpEdQTuxct?=
 =?us-ascii?Q?c3fp4LV//JyvOcDFgAjhRrHwYGZyokUqXSFB7s9N+LmH5Df4YT+PLLnVRW18?=
 =?us-ascii?Q?Ru7PUh6kNOI0T0iYxJaQ4JAq4KDvLm7wq+Up/pvX9VImed/ro9UL2HgK78HO?=
 =?us-ascii?Q?nBT3D7oOld4IYDpK6uV8Q/LbY+1i/O9zZ8D0sEHzmXEcLLlDMUzBSIRTwwSS?=
 =?us-ascii?Q?ME1GRHsULkXHMyAdHVL9MJFS/MCR1ymnaopmFj7EpxwSuhKxl7imboS3JUFK?=
 =?us-ascii?Q?ukVcAPWNbOLAp8nHRtPW3EySSasvsTRT5CrNqceqREBqEn1UUEiDxLWvTANI?=
 =?us-ascii?Q?quG816pJbP7y83PXFK9vKN2Mpr9O6baZN9mviRDJSol8ltuUO4BkB97MX2PX?=
 =?us-ascii?Q?Nbpu0EXs8W74lrhVfwtwlvTM8K2mnN0m/DOMmCAKM/4g77e4NBco5F+ke2AQ?=
 =?us-ascii?Q?uP502NsfIxvfrDe3c//zjSrn1eJoCuzqfsLwl7k9IOrOMOGGHuF8xa9EhR3g?=
 =?us-ascii?Q?f8qN1dsNN2m3euJsOIsCWo5jQN36kkIvv/voPJzrebhlx3UcvrDZtiRoasB2?=
 =?us-ascii?Q?maNN/1I46qPSatKqOtDKoDvbt8nL9S1P0zpRCFnV4lCIJ/WI0SQPh6/nU/Km?=
 =?us-ascii?Q?vF2RYMWBVVvfebw//aGPdZzzpeK67I1f63fAJ5HYiLOILAFRLHzcT9Y1rpYU?=
 =?us-ascii?Q?nuk16fILf9svpWHKOCTWxAviD0J/DJ1wz0X/26z5i3YIFPvLdTKd5gis0mN6?=
 =?us-ascii?Q?E0AKDlXu1Ju2mMkOgAhHvJ9l6SObMjsZfMQMEfCx4PL+WAhfVRgBSFwsmoC4?=
 =?us-ascii?Q?GRYO3w+0KWmWg4VoTaIhUWlE353OpaLUYwuuy1bmyZ2J3TIP2/FFcwjNWO6y?=
 =?us-ascii?Q?tLXJTdn1mpbrE4rt/UOJ1EgopboFPF+m7fxb40y0d4CRh2QkqJyS721vOcdn?=
 =?us-ascii?Q?ZIrbn5ISJsSld7kUfd4EZE5TgTRPraQz2bn2/85iOe2d/jFa2afVm+JOUB2o?=
 =?us-ascii?Q?J4rsMiuoHicGGpVFjk7CQDNGYuYkbowV5Z5hpn52FySYTTNi4Qr5V34Te93Y?=
 =?us-ascii?Q?0Cf/t/BoXhv0CRpAclk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7ab9cb-743a-43f3-cfa3-08dbc02d2a42
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:14:02.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSDL2ZI/OG2podivqrSuKagxe4L9JlJJ8BisESGecT+gHQ6AV9d023J6e1F+6Y3R/lhtKEA5f675CQE/kGeKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 24, 2023 at 02:01:20PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/24/23 07:58, Frank Li wrote:
> > Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for fixing. :)

@Vinod:
	ping

Frank

> 
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >     - Again, fixed order
> >     
> >     Change from v1 to v2
> >     - alphabetical order
> > 
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 23eafda02056..c1c7a9ae244f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8236,6 +8236,14 @@ F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> >  F:	drivers/spi/spi-fsl-dspi.c
> >  F:	include/linux/spi/spi-fsl-dspi.h
> >  
> > +FREESCALE eDMA DRIVER
> > +M:	Frank Li <Frank.Li@nxp.com>
> > +L:	imx@lists.linux.dev
> > +L:	dmaengine@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +F:	drivers/dma/fsl-edma*.*
> > +
> >  FREESCALE ENETC ETHERNET DRIVERS
> >  M:	Claudiu Manoil <claudiu.manoil@nxp.com>
> >  M:	Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> -- 
> ~Randy
