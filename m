Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295357B1F58
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjI1OTD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjI1OTC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 10:19:02 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803C136;
        Thu, 28 Sep 2023 07:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciXlie/zo3eNEGV6WJFcFi0L6S9C8/38WLqNLuQQY1EtSbo+mbjZ2x2u4gM71K4msP7yNGt7CxBXtBo9SqzFNrkicdYnCkBInHdrOlEAFbjMCQ60IAyJgcGcKTUePxEBfySemHltCDvbrKr4p+WwoAoDaWGq06EEOJjdQuFrkNvsdBeGTvxQjyUF7t9wPGCKssjuWZLJZrrE7Fv2hS2JsX8O1JS+Z8l4Ffh8/LaRkyjuPeKHWl+9FDTo9TUetOuTEOvMfdkyUsWd5H9B0VDY7cx84tg2qMiTPO2i4xxRoPNj2ad9U69dr4yqmVoQPVEB58vTZbLMSxvspkKm/rSzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj/Qnwg6GWZybZ4mnzZZPwyiJIDLqMZ3HLOmS+Vf+G8=;
 b=Q+iy96H1UBReP3pgqVIkrLBnRkCvB6eeizsA20wYQ0iw1mip8g+SlrofVQ+3ujL3/fHz4dBHMBFrgmOyKoip3rQVFBnFn730x/ENNfbM5/qCGnyVhntNAa8JAzxDsMTkWcMYY8RwnWu3zA7Lxb6QSm+SWWwEHCZTFZFJMQIfWbRoeHZEsTr6MA8FkzP8yG8MhiKr364NGZAspxwC0+jdxNXN8juPSirn1O38fO61axz3UmJ2/1KNAARBPTKZxaHTXmonq4VFQHVdmBqQuY6QLZundZJgbV23bMriO5nYY3yIqZ09QHGxIcvB+MFFIssdBrNoWP4S8ltm2v0pN2a6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj/Qnwg6GWZybZ4mnzZZPwyiJIDLqMZ3HLOmS+Vf+G8=;
 b=clVZNAfczJfmIxLH9MJvC4IOg1Dt4JLDQ0mUUIb1BpGNP08gLVAuMgsrWivLPFzy0/IGYbJHAwdwt8jbix+NJEEHI0d6PaiKSTRwB/qVeLBjUmy5h0wwpFsPaTuVPNOXDnq1lukzSk+K85w7s5+sdGfFJiBCyco3Oe/KiDj1HMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:18:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:18:58 +0000
Date:   Thu, 28 Sep 2023 10:18:50 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
        "open list:FREESCALE eDMA DRIVER" <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: fix all channels requested when
 call fsl_edma3_xlate()
Message-ID: <ZRWLSkl/QzBtls+T@lizhi-Precision-Tower-5810>
References: <20230914222204.2336508-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914222204.2336508-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ef3d7c-f672-4a70-73e3-08dbc02ddae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5fD//czxVe6pFgaMXsQsI2sFKLf63eLCUV17hIYp3Xc2p7ekOSFvGGNHfNv63pZefRTBpnRJI6/MltKKWy+kcjg1ccjGVocPFBH6hvjqJImM+qe5NT99+DE6rdxSLUAG3rCcgwueD6AwSg34jW8SwWNOTmafECRBUGrWV8OqwQtKA/vCJTWNGvVc/v2+0I6I4BSOGbmDoW8ARZlLj0f/hlFXJMbH5EyZ887dEKxUcEEgwVDAQ6eIb4/WWG0lB00acF1anfysoS0K2UOKjMQZlNPLZWeS4Dqs8rDTsWBBCgKKfcmsxzd4X8RbgNaym4MFuoNHcI7+99j7Zu7wbpCbu9FxRf52AqX4URcg1ixdsjuTdhVNLevZSM+2lDNzRkHuMYabRYxTrbFnlrtxjG18nsJEP/4K2EJuKFbH4ef66T1o/h4Q3jRXMvtXGjtLVdB9iXhLLKJ+4//H5dbUx8By9aIwgwFWYV3TdvhMTXt1XNovg8mX4QskR27zUzC2WVzAFlMq9DYNDlxHElFPXOIaizqATx0vWEUZub06I3m4TGi1GRbEWatFKRlO5eZ+odCYha283HhdrAY9ySZ3W47JmC4UKRxLf0qfNctkuTwEK5iy0w2zRzfC1Bjl5zQobPZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(83380400001)(26005)(38350700002)(38100700002)(86362001)(66476007)(66946007)(66556008)(110136005)(316002)(41300700001)(5660300002)(8936002)(8676002)(33716001)(2906002)(9686003)(6512007)(52116002)(6506007)(478600001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGqY/sYZrXZGbRedEIcn8U0B6v3fv+VBPHM1ZprvBGonVDINZZRAkNMZGKfX?=
 =?us-ascii?Q?TcF4rnC2EKB97/LzYERGG4747Bpzsmc6eo83bN+x5Skd44fPfQ07mfCXKu2C?=
 =?us-ascii?Q?3Z4QZsQRDTPBEpXYBtNnK+Dx9hUMwFhFQ52pO74UzcGSOAPcvsJbOqUl3nlV?=
 =?us-ascii?Q?0+uzrZvOhP9fh6zp5lh8l1YGRs6MnpL0yAEgdmtNETsxCq05Ak6D25wti95g?=
 =?us-ascii?Q?NDs2KxKCl55WkmCoCsBB+EuDYvyqf23MTEIaWcH41OEyUzgMCpF864RdMNON?=
 =?us-ascii?Q?E+Nnpmy5Cyxm41ia+5ANy0xpWLkqixlGErER1Ned8g7oN84F3FUlPRu2yDzN?=
 =?us-ascii?Q?LlaWgVUnrSJnisjMslCnj1XeMMRaN2bLqRHOR+cKtEC/Xg4YoNMHkhPU1k8J?=
 =?us-ascii?Q?wFUr5ujsoCsQVBwKBb2cuzIi7rKrhYzSQufg7rn7F0Apy2GY9RlcYfIpDJcR?=
 =?us-ascii?Q?Nxv9l1dGHctmzMD9Q2q7HOe701RkEt5rAfSvswhywZEr66597LVXVzAIuSUG?=
 =?us-ascii?Q?/ZMxPdL8lcraXnUXO5Zcu+XztMOY9TBdVq2aZdZQO+VhrMO3qonyUWL/M0ON?=
 =?us-ascii?Q?RlEvfYFxh7BITDWdtU8lUub3IGOOb23+s+NbLHls5P9eeaZWwkbboSW4pBl3?=
 =?us-ascii?Q?TmTrh/2ke8kaErOVjby4a3hUdnzg91qZG575Doy0T0foE6h3Wr6L11xZS3Fc?=
 =?us-ascii?Q?p+EmV9tOWq7dhdmT/ib8/mA1mXHhd2ipexvHU/kJL2p32dxF13fcKBPul5jF?=
 =?us-ascii?Q?9MxwjWeiRqhqc3rRXx3zlQSN5WhuCa1SBT7k4xQ9qK77ebA4C22H2nE+Nge2?=
 =?us-ascii?Q?lyZ+1C1W/DJdwGx8u7MjQjgVZ6MLqc6Rvs+FR4lwgQtRj1B6rHNULl2eME6Z?=
 =?us-ascii?Q?BzwN2vbjiB/LHeD5Szukc9FBNATJnj0VuXtrZ6DrmRxWZmZK6PUUw4vXnK+t?=
 =?us-ascii?Q?g0LTLqqiTgozCqKU1i/beei5DWuMzdq290tOJarrBl2zjkPcg8BPz7qMtCRz?=
 =?us-ascii?Q?ANCFONjwPyZG0huz+W+BBuG8/c7/HliWwhn7GgjRQp7WwvdX8qgBmVSXrVUx?=
 =?us-ascii?Q?n7JtmqIHLA12uN2RbGiFhXEQyassZm85hIrnz1DfgbZONWzHpccmUc1NWppd?=
 =?us-ascii?Q?HwzpI7JoQsVT3E9BHc4s4VfWfcHBfcroJi9zPB6+/62rh91zDZ1XNYDWD1Wg?=
 =?us-ascii?Q?YUHPX/e/XDEfK1Imsoftc7ePZq9TL9TuLw6t225uPNF4Ze1PD42JpjceXVw3?=
 =?us-ascii?Q?2Ru+LKLkBto34i3uxHvMFDunGsYBC+XNmrb09ycXOP03SCq9AQ6VaEOzi0hE?=
 =?us-ascii?Q?wekOoyxiwxqmmxOYqFQIm8dPmu0ojHlTNaEbmfo0JV1Xv0wR/zjByF6R8tVh?=
 =?us-ascii?Q?nUcTR9FbpK9RgGD4ImK36b+NppEqHh8ON+sY6v1mWK6YN5PaBQMPPczy0TZd?=
 =?us-ascii?Q?0i+GJe9iZaE3+46zNUwAmGP75lRUiBt7uV9zVmPdl/p59PWlrPP7fPJMUcgN?=
 =?us-ascii?Q?Nt+Pcf9s+MiXjjZB60NmMLVCxKVIO2dOWJhFSG+OF6zHdh3Vnwg8qo3H+3xK?=
 =?us-ascii?Q?I7PT/sEauwqW0LX3a7Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ef3d7c-f672-4a70-73e3-08dbc02ddae4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:18:58.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qb31yNQHSyhuB50w497yRZnuYsyWI1LlawVxdNJYIQKd9Mk4y2sJXRiqmMONRDN38nH72L5e/zXRykRBaiy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 14, 2023 at 06:22:04PM -0400, Frank Li wrote:
> dma_get_slave_channel() increases client_count for all channels. It should
> only be called when a matched channel is found in fsl_edma3_xlate().
> 
> Move dma_get_slave_channel() after checking for a matched channel.

@Vinod
	ping

Frank

> 
> Cc: <stable@vger.kernel.org>
> Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/fsl-edma-main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 029a72872821d..2c20460e53aa9 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -154,18 +154,20 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  		fsl_chan = to_fsl_edma_chan(chan);
>  		i = fsl_chan - fsl_edma->chans;
>  
> -		chan = dma_get_slave_channel(chan);
> -		chan->device->privatecnt++;
>  		fsl_chan->priority = dma_spec->args[1];
>  		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
>  		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
>  		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
>  
>  		if (!b_chmux && i == dma_spec->args[0]) {
> +			chan = dma_get_slave_channel(chan);
> +			chan->device->privatecnt++;
>  			mutex_unlock(&fsl_edma->fsl_edma_mutex);
>  			return chan;
>  		} else if (b_chmux && !fsl_chan->srcid) {
>  			/* if controller support channel mux, choose a free channel */
> +			chan = dma_get_slave_channel(chan);
> +			chan->device->privatecnt++;
>  			fsl_chan->srcid = dma_spec->args[0];
>  			mutex_unlock(&fsl_edma->fsl_edma_mutex);
>  			return chan;
> -- 
> 2.34.1
> 
