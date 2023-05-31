Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD071805A
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjEaMxR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjEaMxP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 08:53:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8A6137;
        Wed, 31 May 2023 05:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOWS/cwbvEixiQyZ/RByqx3zvJkghXi4ld8OyXRRX1GqkNWy8SmcMYxzAekXnuwCCvsns+6SQ3TJjgPbEEAAaFItNgfU7momyDCoAq2JBP+aaCJ6SGl3/lJgZnQvlcS7V5HwLqCpWU8w8WX/uM26ogCZu/+1pGR388CdUXZmMHDnMBkeBmn/HIKHNwg8EDz3IMPDaFHw0T1oMWPT7+NaNHJ0+wgKbqzIj6we5aDtk15ij21BCbI8CIu5o9EDPPiuhZg/0dABdcFaupInbQJeO9PLu47qwuALH8RgxwX7o86jqIfXXjCzZMI38WzZTHdObD6fC9aa6Q3leD3HNbthuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IstQzwLbEbkvZXXWsy2ex8JCtKFNPlVMhEPiU260No=;
 b=m/0Ns/fokVFSG7osRjS5KqzY70yPQuszdHkx4ED2TV3PsFo7I7oXF7ZoVYXtbw1uwk3Qu35MTZBD3JPFLALWEvxMWjwcHiTWJVJIixrkWeHsu6HR74AuDGSpgdj8saVEsPhqt6niekL9Q+eDK3OsJRYavMth7k7FeDX5HDdb/wdixEBQeT2lH4EVfwI1/2PwHB/T1uEhwB3zClq9gDVYAooDjWWp1UqVml0ZcYBSZEtVc/FudCNpktEstooi3X/B57C1bIJmmFIjGrVV5850X27YisUBSLCPcTi+cUpN2ZRXyv3c2/2CcPmGhFj3az8Q912jZdoZELNXysuAmBxUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IstQzwLbEbkvZXXWsy2ex8JCtKFNPlVMhEPiU260No=;
 b=sCbB19Z/lOTWObqvgzy8imJDG5JiC6pP+AoQOdebC6675HCaSQrkLCaiB1srkxjkvYMg5l67Zro/mei0/Rp6TYzJJQPTAhC3r+yBer0anUmHOfXxPSsFeqBOG6EBfJvWLQiEjG6rLdppmjrZNro++sGpKLUSdxlZJWqgYBgiltY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 12:51:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 12:51:09 +0000
Date:   Wed, 31 May 2023 08:50:55 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, peng.fan@nxp.com,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        shenwei.wang@nxp.com
Subject: Re: [PATCH v2 04/12] dmaengine: fsl-edma: remove v3 from enum
 edma_version
Message-ID: <ZHdCrzKavdjQtfiQ@lizhi-Precision-Tower-5810>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-5-Frank.Li@nxp.com>
 <79803451-3af0-26b5-2407-ec47172dcecc@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79803451-3af0-26b5-2407-ec47172dcecc@oss.nxp.com>
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 071f6d88-a9bf-4e40-1c1f-08db61d5b487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udKYUfy47u531ilmq4R9x6+QG2SUu4X84Huu8/lpyw1d20tgVwBIKHZzqjDYYIoZNPWpRWq3gjXneaOZYrEkhmbeTjI9SMQe1no48w1y/KS2WkWu2bsOrLtIp3QefBSWk6rNNWfAdZZ7tppgNjCXanew07dGuBEn8tdP12VgJEraev8dU1vjqFs3Qy6IJbKwbd3YhBjY1jRjA7yS5jd4/M1/OJRTeUaQ5C75fzlzjupgJm6hcYj3nIilT8na2qqvWITnFBjGVTs1quRuOmUW9kg6TbgMOxMj4vEi1ZN5zOm3kWfdbZ2J045+YRSoHBzBI8A27TW95ihj9gpQWza8yb8IdARTEPakA9atIWbbEpgJmdEhWzG2OzbwUpefw9Xd+MYv4S4LhZlKUtgaQeuUfXmOpnGx7BoQHTNjcKS1cO+sBDcpTfKKURjA70BB9k6ARHGCpQcT5iTfa15xVvciARCckEEExFSdp6EydDzPoTgQxN/0DLx3Li5gAHO/72ayleuSAjyKgp8uaGu46y3483NDFeoOEfOaITCJfc0cm+4y/vJqww+srOlX3b1CQaPun1/Hh08sqdoSyW+8+ggD6Ji88EezgNb4aEJhb+LqJTQm6yb+AhUItTBrEl9nnXLw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(4744005)(2906002)(8936002)(8676002)(6862004)(41300700001)(4326008)(316002)(66556008)(66476007)(66946007)(478600001)(6486002)(6666004)(5660300002)(52116002)(9686003)(53546011)(6512007)(6506007)(26005)(186003)(33716001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhAzED7cKeHeTdKZdSNdn2GXCEuVpBXZMEopB6h9fN8aY6PFnfJhuJIbr0+J?=
 =?us-ascii?Q?l3mDZaHK+vdVlKHA2t9doBD3p7g/ZuUZ0bYypOpk+fzt6JPo3HHV8eNVlfbJ?=
 =?us-ascii?Q?Zaa13ZxeV7ZzsGHRi/msKrhVNkKhAzURx5lapjVDtNnV6ScRTGqJEIrSz/rp?=
 =?us-ascii?Q?Sc2evl5k3JRzdOI/BPvGy/18gma1rh9Zm1nju0OcVVp8AC7vSbBGqb3G5j0T?=
 =?us-ascii?Q?VoZN7r1E+iKnA6hxMrWAnGdn/lHwEX0knciSg31QX0CgB4KKUrkl8rdeghRo?=
 =?us-ascii?Q?6EgXjGRqmY2TsKRKXy4NzXAI8wc3fpuBqsXs+FHKCCQmIhZFmroAlEsPsLLC?=
 =?us-ascii?Q?24qDsKaRkTMiuuPBfoVZawK/nVsso4qaqTZo58FjCZO0FrxetYJOQYo4uwJm?=
 =?us-ascii?Q?p0oGpBLrq9+mrba1FpGas9Oigm8equ+tbDQOw/ZGzgsXnq3ugMpd9O88yYOC?=
 =?us-ascii?Q?CBE/00Cd4dx+Xj9oOByjtEy0dZEZ/sOsfygwSOreYJDN6QZEyCsoQ3318VPV?=
 =?us-ascii?Q?EKT7+A3AED8kjDyApoIyQ0O38fU1s8EUQoK1kKMOAoqI7cOnZNizDrdC6HvN?=
 =?us-ascii?Q?NidMcGoR7FJ5f7Uzp8cHme06Jvco19z3jGsm0xom4JZw3jxgtzQIy2OwEHPa?=
 =?us-ascii?Q?3vhrDrzL312vssTlvEqomx7lL4CFayJjpcdINa0t6Sg30Fi5K26hYgMw44/4?=
 =?us-ascii?Q?VeT5uuKSmzFx54pzYzk1Co09Q/K+61Y6Ur9tJLBE5Exh0pQ3Qjw8ezvvqsVf?=
 =?us-ascii?Q?8FSdl26nP9PFZn1MQwDKjMpRPNlT9/w+8MExyzEceVGoRmGNH6DxD6Ybdc66?=
 =?us-ascii?Q?wo2A9UEW7UmOYTogB81/mQWQSz05nSWsycbMxcDDh5OI1emZ0FS+SoX6Ic4n?=
 =?us-ascii?Q?GQxKQ5XQEJDznkzar9sahNZNb9h9cBd8HcBN5pisez8B9zejatsvUwAkSNSX?=
 =?us-ascii?Q?YEs2slbRLTu9ybWhHzQnJW0pq1g0UdfuTd8Ee9k9KgepQMMn/arO94DhReFm?=
 =?us-ascii?Q?DlUC02d7QXqr+3AlYyJZ0o8UfHU+bxxf6bp2r89PViP5KzVgAqinFg1nu8DI?=
 =?us-ascii?Q?i+OsonKbPWAxxCKflIQEiUIpzL0Xmsc1XvcEeouvpK4lWoN10Qo7ocK8qk1T?=
 =?us-ascii?Q?0ou7Q1acn/LCQJ27Iow+M5Gz1EZ7oMOM8iJKhGuSbVvfqYkgQlo9A/QSW3Qa?=
 =?us-ascii?Q?JzSTn6ZruqfkUql1/W3eI0f0+xOYth+PL4bD28pMOWuaCFYuJpHRSkc6p093?=
 =?us-ascii?Q?JSnW+b7kUYmiaXoJAqkKkntRd9pJEktnsokpLD43hSMdpQUlS8L0KNssazIQ?=
 =?us-ascii?Q?oZEyIV9/0F1RNI9TJAZRo10Nk7UxYZEV8mmP75lcH2Co7xIcwaceQ25kBJxR?=
 =?us-ascii?Q?pVq5FBKSvqMCe2Ooya4hq+CXxAs6KCdmEUeoATHZN6e0adimVfsoefVQ3kP4?=
 =?us-ascii?Q?0IvPAZYL8IEbSR1NyVwrPhpDkTTynm2zsQR4KhjnGbqwI75B94BzfcoY396e?=
 =?us-ascii?Q?vUNufekzIQHUog35t8tE/9YJgfPBrmV9pKSLdsEEm8GUkFq7sQHvTaikj+37?=
 =?us-ascii?Q?Bwa9DRctFJK1R9YLJhhpfN2x/2zZL+FAtwgD7fCD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071f6d88-a9bf-4e40-1c1f-08db61d5b487
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 12:51:08.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEFJKnwIg6P3al4tsSQlTkTQBtjtmAbLBCrXZvPlXh4tLxZeBRYdmDWu+Wb1xuLz4Q4W51ZazNaSQKBwJAcFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 31, 2023 at 02:50:57PM +0800, Peng Fan wrote:
> 
> 
> On 5/30/2023 4:04 AM, Frank Li wrote:
> >   static struct fsl_edma_drvdata imx7ulp_data = {
> > -       .version = v3,
> > +       .version = v1,
> 
> This may confuse people.How about for hardware
> version >= v3, use new flag as yours?

I can use drvflags to distinguish. I checked spec, 7ULP called eDMA2.
Okay, let me change to check drvflags.

Anyways, we should align version with hardware IP version, or not
use it at all.

Frank

> 
> Regards,
> Peng.
