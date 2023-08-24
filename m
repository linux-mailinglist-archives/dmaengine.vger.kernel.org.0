Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E629787246
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbjHXOw1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbjHXOwB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 10:52:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D15AA1;
        Thu, 24 Aug 2023 07:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvvkJiUPHY0gp7dhCdNEZA4qPhNH9HITHYcfBHg0slsC6qrDmAefTMy48aSaWw/mzkn4kZigjw1Gc9pLVKKj/FSSGp+JxQnyFg5Nypzao7qepPVsEC2K7KDHbRafdl46I85DCjgCYp5stN7h44B3WtgY5K2WPF75lc0ULnsMyJFSYYCswMozQh5J0fyjFIAN7kCiPQhM4yxAc+5clKrIRlCNNP27b5nPJb8u7nkql+qdcgzIUFAgUgAQb/FTuQCZuEhGyzfzW/5Qz60cQde33fJSdmxzSyx6h6svak+GSudDF1v4oroLxiUy9GAXSDoDmifYnWgD5d8yyZPl5Hp0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzVhKj2YiMxGoP5EhsJIQ7mFqYkZQNz+J5Ltsjnfgh0=;
 b=G9+5ySWbX4EPoVIVErnf48PiZGiDHdWyG1xJJpeg2Df+oClxEPAPHy2pJLtP32xpQHQNCVvtIZ2DHKc3X6umFilN8mHfswYISSLM3oTwRp/ZuknSe97+0SCDMg2bU0yHCJdtWnpL2uDcYcIx9NV+8qyMmc9EeO6bvjvLLcuqA6OhBbrTXgowHwLbr7EgeWBHYIcSFwHPTfWpIxKElmw/mlpGUdZ533T1xLbLISoh9q1rmDRLlCUD0Vnlgg5iGndGLmmnhVuPR4sj3I9PWP31ixr126JCUUcOd9b98Z3iFS889BhNiyjRCwCLiBb9C/kaXqxZX7ImCvB8Ba1znfD1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzVhKj2YiMxGoP5EhsJIQ7mFqYkZQNz+J5Ltsjnfgh0=;
 b=nswEW8iVaDmua19vl+ZkKD7Y0EJOGQjEQfgeSKCf7ihiQXa688ExnBYlmQeRVybOdYpYyaMWS8tRZVBSKlGanuj6A1/JRxmOzSIbAnxQSwGQDQfOsFgtNkUvjAJCEPVgSoNCYARX7icanFo8RZ8Enf0R9VPSdMIVVOdgVyTaz5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9059.eurprd04.prod.outlook.com (2603:10a6:102:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 14:51:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 14:51:55 +0000
Date:   Thu, 24 Aug 2023 10:51:41 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA
 drivers
Message-ID: <ZOdufcBktNwbvP8G@lizhi-Precision-Tower-5810>
References: <20230824030454.2807336-1-Frank.Li@nxp.com>
 <2f664575-b821-2d10-0f0b-9ce443ba47a1@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f664575-b821-2d10-0f0b-9ce443ba47a1@infradead.org>
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: cc956ee2-6c36-4c5d-44da-08dba4b1a8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kJCui5R8pKxGSEzwQVu3ZjzdAwLAXWUMzRS0mgjbMQnmnomO7wIi166BP80XMYLQiikJ6fAhNDWXgEUCD9mU7eEgJELmO1gvN1RjtLVU58TO4DfxNqwxLMH2gwe05ftUgT7u1sVTojmYj3wXgp3AQqt80Ji3rrI+td5IqCfTexJtPRHJFG2PwcAECIeJwZGylh9gMjWKowNzBlvCu+4rvNphYHwvbrwP7xxyiAu3p9+eOLS2+z5s47Sk5aicmlOpciTG5WjZ7Cee+DwyUCwSYMyJUJPAjjVHX+utF87TZHTzP+nn3KvLRcgFSKnRA57izwKdFGswKKiWRwRAIJtCRXwKRtM9MeEvX/yUuqG7CXos8WIiKP3Z0xUizUSMkIxcjzyKybQZqO+NicHgEm/LuizSCgCttNrVmhcpr2BHx71w5c0oflPBRpQNvpIkakeODndKUmIQRlI6JCESWEznphMf9AX2W0gPfsFa70hgwAvihTmV5oOpO8GS3RbTjgLq/UHMdVlCiQ12NHVsqjkrhYVUtiW3rWv34ZLHmft7dqMx4NJ+Ow5Hkkz+OcXPJAzqNF9rxONxVg8Y4QmLg6qKqtq9yQLeKfsDWey77NjBKDZIQWbSMenTC8OOWvVmoEr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(6506007)(33716001)(66946007)(66476007)(66556008)(316002)(6916009)(478600001)(38350700002)(26005)(38100700002)(6666004)(41300700001)(86362001)(9686003)(6486002)(6512007)(2906002)(53546011)(52116002)(8936002)(8676002)(4326008)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJHLHXkCU7WV27vbBldHVqJV0K3/z9JQkKbMvbci7K111bz3SWpTxep94J8n?=
 =?us-ascii?Q?XcThTF42BpjEL/ruvy3LTR587NjiMGdM9d6/l+tJ/k8u4PRzyOEQaElzuuMb?=
 =?us-ascii?Q?9O36h22lqF9nP3wgER+ABrhcEkW+I0KZD7n1bms3/18K/qCVkBR4jEUWnvtx?=
 =?us-ascii?Q?8wmx4YcJe0AfKOyYPKkvPWKLGiDyPAmcKOqpRwngaeqU5lzb7djWX2TEqBMh?=
 =?us-ascii?Q?SW3rpsVoWrdJSkGFJtq+tjJWMNTzr6oNqM/uInnTNQz8o+P/vccM/H0nz3Ad?=
 =?us-ascii?Q?jAle8VlMOEf2KEDD28JWuwtkbjqHGaeaSKBDlsgb9x8MrzecyuDNr8ezTJdK?=
 =?us-ascii?Q?hKqLeH6XN84ttO3tJZEmTsVOyVSZXj3k5Fr61XTeLnEGLIIJImC0rhH8yvm+?=
 =?us-ascii?Q?UrQ5CUO2NDMq8jaIzCNDSytwZE2AynwyIn7/42e0opSyGwqERdujJHepyYlj?=
 =?us-ascii?Q?8CdndaSV1fQ6KUMrVzVKXxEQnhlE1UNVdEut9TcqQj92tZysuPb5U9FrZilV?=
 =?us-ascii?Q?V2Z5mLRN2Y8nFv2QXTlxM+Pps2NuhqXV5QO4ZiP1agq2V2DNZGhqORUBF1+q?=
 =?us-ascii?Q?xmF828APQ+gL+d2E+UUz3Ftg+6i/LttE0/Bdf5O4Gk+LACNTv12MziKCHqsv?=
 =?us-ascii?Q?Ri/EI6NFiJmlNebo4qX1sCxhIsvjXes70TzvZxW98Vja8BwxgRv77nHWqEMp?=
 =?us-ascii?Q?3dcok+l7Pe/+viba1oVII8WtLRkPUjSnQnf4v2G/x63+1eEPGt3EfQh+WnYd?=
 =?us-ascii?Q?eIocZzT0Je1eAzIR4wgIp8E8QZMIAF4J//U8FrAdrMAOnAuU78cTrhr+p2YE?=
 =?us-ascii?Q?Jf1XP7YwRR/7gqG5/PlFPkMvhw+iVp0LjiTa4wFi6WjU/6CSj1mW6sxF/tYI?=
 =?us-ascii?Q?nbUKJ7E/LpFOYgPRq/nipGvDQsjVT++a30eZHEW7dOX3yLPT0c7mCREkmVVP?=
 =?us-ascii?Q?GxDAecdXwPrDzqhbP0eXDvReXzPGGSpAXc7Nt7aVqe144b2oowofQvcoq1wH?=
 =?us-ascii?Q?j7aieOIaC6zUxsQme9TrvN6ZgvSQaI5QUH3ZM/zI+TfiRfH5NKq75pGft6i/?=
 =?us-ascii?Q?uBpo1AVHI8b5ROdakpBuWQ5KNVTNvGs7fVWlwqM4xjeqyJZCZNRzEYJI3TKY?=
 =?us-ascii?Q?Vgr6Q2YcJWfsh5PU6jXiT770dSipNbK5A3idjgv0h9DmIO0gBusJgsmnwtA9?=
 =?us-ascii?Q?9UxCH6gqHWOQCfhut9q62hVKPAVde/A4SoC5Mc4lk73dRUCLq/D4JpabSRG8?=
 =?us-ascii?Q?vZAb/NJEoscXujQx2mKooZj2bFQPDn/zeBsEb3Y/a2W89jqQjOkVQ/I5QuHO?=
 =?us-ascii?Q?CtkGXd2NYjlzXgVBxOUmQ+kTPEl25ZBesBTJZLn0TCunyrPYXhWb5DTKxfIv?=
 =?us-ascii?Q?SdRHzacQEsfFO5GW7hZ+b0wvnKls4DRwHtlkj2V77T/L0D3Z1O9gjyTp1QD0?=
 =?us-ascii?Q?fbMhN74XYScAP5TUM+IRUQjnPRln84OUAhmxUCFv48K26TiUtbTLKiQc7i3o?=
 =?us-ascii?Q?UC/iSlpAemMEWpRv9AYtP1ln5K1E5jpWG7pd84Dq6J6AS1GasxD0ROXj2tdQ?=
 =?us-ascii?Q?HOPuMb6wR5n1v/t52U7rHEYVyKYY1Rj1Joj7aUzD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc956ee2-6c36-4c5d-44da-08dba4b1a8a7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 14:51:55.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzrYOAUZhKKvxjWMvzsgTYqi9kCumRJ47ViPa1gK92BhtZCScSmqERGqAoMXza+m5AIs/ATyCSGuuRMRnCIxiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 23, 2023 at 09:32:28PM -0700, Randy Dunlap wrote:
> Hi Frank,
> 
> This is still not in alphabetical order.
> 

Sorry, my brain dead.

Frank

> For v1, I said:
> 
>   This new entry should be after the following entry to maintain
>   alphabetical order.
> 
>   >  FREESCALE DSPI DRIVER
>   >  M:	Vladimir Oltean <olteanv@gmail.com>
>   >  L:	linux-spi@vger.kernel.org
> 
> 
> and that's still the case: "eDMA" should be after the "DSPI" driver.
> 
> On 8/23/23 20:04, Frank Li wrote:
> > Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v2
> >     - alphabetical order
> > 
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 23eafda02056..fbab3c404eb9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8215,6 +8215,14 @@ S:	Maintained
> >  F:	drivers/mmc/host/sdhci-esdhc-mcf.c
> >  F:	include/linux/platform_data/mmc-esdhc-mcf.h
> >  
> > +FREESCALE eDMA DRIVER
> > +M:	Frank Li <Frank.Li@nxp.com>
> > +L:	imx@lists.linux.dev
> > +L:	dmaengine@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +F:	drivers/dma/fsl-edma*.*
> > +
> >  FREESCALE DIU FRAMEBUFFER DRIVER
> >  M:	Timur Tabi <timur@kernel.org>
> >  L:	linux-fbdev@vger.kernel.org
> 
> -- 
> ~Randy
