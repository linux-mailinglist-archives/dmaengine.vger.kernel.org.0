Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15374B50F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGGQV1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjGGQV0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 12:21:26 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E051FD9;
        Fri,  7 Jul 2023 09:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5NmpCKsOb358/x3UkCqiQ8Y1srqFamilTJAKTpziGCYNPtmbbUDfGaa0pUaG7ZCy7/WkGDPyluK7Hv79LYXoqzc79MKg6aMNQ8l+yq0/qrKlRT4qtBi3BfHJy/J7wGN8CzZB+ILYpI/+hwlRRkfvSiqcuE5caEl7cRKJQJ7whQospBxVuy/g+Mxox3kpNwWRAwGZXpNcZ+Wig8cDu8K3R4G4zJLghe4/9fZsZlNWwFvcpHSCtCoQea8SB78icyaseUr2MOJZcFyJDM6JG/D1zKUbr1fiIhAw6BE3xlZFL8qxT7gXNPmafINM9ueo4uc2yPctR1DIJpS+CqlyCypww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGhARiyZlOWZ2XlAo/LD1W+ckXW993mkfA0hmGzvr1k=;
 b=UctWy3PLDjXp9mOsIms14EaEH8ZNaQotujqqL0lQpIV4agvXI8TIIwxdarY/FntSkUEY/HFTjk2GrgEFTGIe5LM4Dv8v9AoyhAiRnyuQiiiQCgIVf08ldjrYoraxpGMQHipvsfIHb7PFluxqykMEd7vcLJYSmr/RCQsqoiZxl5s4P+GixILsx7f8+Dxdhj70UOrO7qsqqwvXTGcsTiF+FOJHGE4XGyNqajU5ryVSf2Oc9G7dhck3ms034LZsm20LJehQrwcdsHdO2QprXcgogJKcuiq5XsUxlZrH4TYB4rdJWL5mg+Hyhg04PrsxkUqYiY+4mloamYEZq9I+7tgWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGhARiyZlOWZ2XlAo/LD1W+ckXW993mkfA0hmGzvr1k=;
 b=VlLVNuLhlDhO6S9vnBMcOiP4DNQFGNB3PPLwygnY8mC5f+10Jbngs/x4chDUg42W5zookWpeIb7ZKpw1CT9G7M+mzPjRkm/c26lNkcX5RObIGFmjeU3t+omeMpn66EM9LKSoeN4ML+JUhJxF0wV3tGn3qFJbHXzexEYfy4zuEl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 16:21:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 16:21:20 +0000
Date:   Fri, 7 Jul 2023 12:21:03 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, joy.zou@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev
Subject: Re: [PATCH v9 12/13] dmaengine: fsl-edma: integrate v3 support
Message-ID: <ZKg7b/RJyCrmsQQ7@lizhi-Precision-Tower-5810>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <20230620201221.2580428-13-Frank.Li@nxp.com>
 <ZKemOm9OfQK8NkpL@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKemOm9OfQK8NkpL@matsya>
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ab1b6b-7e3e-423d-9b36-08db7f0632ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYnXbw5kBqWJaAls1h3KsFJcj3GN5QPfXM+qHU/YIY/So38w4gjHxpVJmyW9OuLymkQkKXFq5V7Np1UT0eyku2vEMMCV2Htvp1qKPuFzA0SScw2hMWyA/ACEr71GUg+Me/KijtfLyhWWv+Bl9Gd6AXSWGK1LBWY07lXQop+F/15xfqrsoNgFI/z6souNNo4NpwI5v+mu0l64rNnvr/NldmgBh3F0feLXNLlpM7wqEU1OTWnHVqSwl9LthHhZ+2ikLiVpSgt5Kbw5+gNkBI862XUKAh3EUdWdoDPvwwEIP6WUwM7f3VVjGFofcQ9SgnUnIQ0w3opJOc1tgJX7iw35NG2I0n3WAS+3rTdlc7cF9vZjCGbRnl543OItZlHLK7wEX5x99JnaOf88/BiFzjaxAXjPkm7jVe1u5BTc/H+hydLsVnchV9yJUNh2FIOPOIkUlVLdhmlRffng0h6IBHPvdW7UP2laIXrbgnIeTnMOftPiC4brtizzPcx9Z5aNpKNxakh077pzE4I3zREeQPHft+7JjNL83pn0Ky7GB8uF4B8EBoZMkDItiwoq7fOISuoy7BjWzqQGC05mqD+JpCEHKnTSVjGw5YB8hVhxsZE1ogaMMlshpjqQxt3vjxoO1H9n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(4326008)(6486002)(52116002)(41300700001)(8936002)(6666004)(8676002)(66556008)(38350700002)(38100700002)(6916009)(66476007)(478600001)(83380400001)(186003)(6512007)(316002)(53546011)(6506007)(26005)(9686003)(5660300002)(33716001)(86362001)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y0aStg/7iRj0t/w37ncIfs2dGHKr4cVqmmdJF9J6coSb7HnW0/jHDCllBebs?=
 =?us-ascii?Q?fLbCLpdnGFzzFIkbNzKWEs+LdYjnRIDQrvVXzQHBWLWHsIQ4rAGYW/NeEj8u?=
 =?us-ascii?Q?EvdjgZM2HZ371TTjp/p9AWHVYf6/Qvp7TsP1ipw2wcvQR3EsS/rsZipZWVwj?=
 =?us-ascii?Q?Q5YcO1gBpSjmhOJg/oN7rmLgmrRDfiD1dvyTe+O2RmKyXxFoFmKdPadVnv/u?=
 =?us-ascii?Q?QU9nwB4EScxYJrKUNBxhJ8afSZ+l6rZOyxQOjE6Zn2rTw/X4pe7a+26WByBv?=
 =?us-ascii?Q?F1BCqBOa6dm5z/22AScu9gvek/a+Gqm8zjfRKqHPeMnudwPnecKk7UfRPf7D?=
 =?us-ascii?Q?2tm8QmsRjo+/ieY5shqdCwkwbodDse8n+7BfI9SXNfLLEYLEyWd+NhT7cEmR?=
 =?us-ascii?Q?bAgzFYw1zyMZ1OU5ufT8LHI0T15xrgZa2RrtJLOoMwCEBNx9KM8E3LVS0PVx?=
 =?us-ascii?Q?4+nYtv59ax5PUUyV5C+HT/WosXhAOWei3JLYD+5dRX9YtNP9fKp8PdIW2fVh?=
 =?us-ascii?Q?hij2DMFkK6rhetM9m7xmdAnAGt3ex6uoCOM74djQpfqDWMSQ8hEBAKc9IU6R?=
 =?us-ascii?Q?/EbdGcsQh0K5ZXI5MlOxJFPk+IJhrvfpa4Y25R/OgZPtFkrieRksLekMf9wT?=
 =?us-ascii?Q?BR21WLacPIXfB5JWS1HV391Kg3ipm0tGUu0hhkNRnd25SGqV+0hw29NQURhP?=
 =?us-ascii?Q?UiL+2Yi79+IPxndlMV8hBUPr1DxJtIxCxtkJMLjGAmlLgzlpzwRhoIjzuudv?=
 =?us-ascii?Q?S2CWSs6e9IBABnsihdtSN56wBOGoFkolFhU3/LpdZ428234bzHN2kg2oT9qF?=
 =?us-ascii?Q?uMLaMfvzZ6Oud8FH92zTRVp4J3pJB6Rx4ZULfzY0wSO/08qZa3ZAJ/yCAeNb?=
 =?us-ascii?Q?9XDln5TdiljeqE8V3l54Arlmc8XzQYc07RC4xM4zmZevPcjTEcAzKUMSnT8k?=
 =?us-ascii?Q?+XaRRymraaQ8vvTa4UTI/jlYHqFXM4rYIQklo8rcerUfcsgMh3j5PkuNfVDy?=
 =?us-ascii?Q?QcY6FFKXkH2uAyVBxVcrX5UsQXika/j7Oa8P3Zp0bPbqD5gif3LNu4czbG/e?=
 =?us-ascii?Q?aE3q0S/KVSu0MvBIXNyY9Nn3f11fORyF5QBCvUtdg51P78zPY6X9b1wItzp2?=
 =?us-ascii?Q?srocOSK3pdjLp9gzJnOB9yK53SAXvtTWxA7oFwlOigLIe9gypLJw6SsHdc6q?=
 =?us-ascii?Q?4owmX8C2EuitcFG2YSxvyX5UGOyYsAsfDdIGOxlVpPpPAoCT2SUJrsZsV7Y6?=
 =?us-ascii?Q?kzeRsyIWMVqYem6VOfEpO4q++uJU0uy37sXJYXkYFfwcOuYBskHazQ0genEH?=
 =?us-ascii?Q?jyQrDSI1wkfxUUk2NR1AILfmB90wNQYtZb+xMXmn7G6uWM4ztymhG1BM/jt3?=
 =?us-ascii?Q?lH1oJZzbNVYD1AAbhD8Ign3Gcv5SOkLc5q3RfKjo1Fz1YUolXmZytcI9yT9p?=
 =?us-ascii?Q?P1GLfRZfe4quiM7WvGnj5lGlO7lVjHevEDH4hh7YA0jlj/JF8Dom151gyOeF?=
 =?us-ascii?Q?Vjxsf6BJK/1XCsoSgZ9bfN33sh1AKMVho9JdpdBXquk0xSkfCDKGKIck9RaY?=
 =?us-ascii?Q?0ghSwnhZd2GlYEjy1w0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ab1b6b-7e3e-423d-9b36-08db7f0632ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:21:20.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mb2WNmypC2o6bg4QLlER/aZyVO/UKBtv/ePm0mXeEKwzSyahYpbaVZkeqQ/ClcFVuuaOzuP6pmGko4utt1f2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 07, 2023 at 11:14:26AM +0530, Vinod Koul wrote:
> On 20-06-23, 16:12, Frank Li wrote:
> > +		}
> > +
> > +		fsl_chan->pd_dev = pd_chan;
> > +
> > +		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
> > +		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
> > +		pm_runtime_set_active(fsl_chan->pd_dev);
> > +		//pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
> 
> Ouch!
> 
> Always remember to run checkpatch on your code before sending!
> 

./scripts/checkpatch.pl v9-0012-dmaengine-fsl-edma-integrate-v3-support.patch
total: 0 errors, 0 warnings, 769 lines checked

v9-0012-dmaengine-fsl-edma-integrate-v3-support.patch has no obvious style problems and is ready for submission.

anyway, I will fix this.

Frank

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int fsl_edma_probe(struct platform_device *pdev)
> >  {
> >  	const struct of_device_id *of_id =
> > @@ -234,6 +412,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  	struct fsl_edma_engine *fsl_edma;
> >  	const struct fsl_edma_drvdata *drvdata = NULL;
> >  	struct fsl_edma_chan *fsl_chan;
> > +	u32 chan_mask[2] = {0, 0};
> >  	struct edma_regs *regs;
> >  	int len, chans;
> >  	int ret, i;
> > @@ -264,8 +443,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  	if (IS_ERR(fsl_edma->membase))
> >  		return PTR_ERR(fsl_edma->membase);
> >  
> > -	fsl_edma_setup_regs(fsl_edma);
> > -	regs = &fsl_edma->regs;
> > +	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
> > +		fsl_edma_setup_regs(fsl_edma);
> > +		regs = &fsl_edma->regs;
> > +	}
> >  
> >  	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
> >  		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
> > @@ -275,9 +456,29 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
> > +		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
> > +		if (IS_ERR(fsl_edma->chclk)) {
> > +			dev_err(&pdev->dev, "Missing MP block clock.\n");
> > +			return PTR_ERR(fsl_edma->chclk);
> > +		}
> > +	}
> > +
> > +	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
> > +
> > +	if (ret > 0) {
> > +		fsl_edma->chan_masked = chan_mask[1];
> > +		fsl_edma->chan_masked <<= 32;
> > +		fsl_edma->chan_masked |= chan_mask[0];
> > +	}
> > +
> >  	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
> >  		char clkname[32];
> >  
> > +		/* eDMAv3 mux register move to TCD area if ch_mux exist */
> > +		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
> > +			break;
> > +
> >  		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
> >  								      1 + i);
> >  		if (IS_ERR(fsl_edma->muxbase[i])) {
> > @@ -297,9 +498,18 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  
> >  	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
> >  
> > +	if (drvdata->flags & FSL_EDMA_DRV_HAS_PD) {
> > +		ret = fsl_edma3_attach_pd(pdev, fsl_edma);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
> >  	for (i = 0; i < fsl_edma->n_chans; i++) {
> > -		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
> > +		fsl_chan = &fsl_edma->chans[i];
> > +
> > +		if (fsl_edma->chan_masked & BIT(i))
> > +			continue;
> >  
> >  		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
> >  							   dev_name(&pdev->dev), i);
> > @@ -310,8 +520,13 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  		fsl_chan->idle = true;
> >  		fsl_chan->dma_dir = DMA_NONE;
> >  		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
> > -		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
> > -				+ i * sizeof(struct fsl_edma_hw_tcd);
> > +
> > +		len = (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) ?
> > +				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
> > +		fsl_chan->tcd = fsl_edma->membase
> > +				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
> > +
> > +		fsl_chan->pdev = pdev;
> >  		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
> >  
> >  		edma_write_tcdreg(fsl_chan, 0, csr);
> > @@ -345,12 +560,25 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  
> >  	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
> >  	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
> > +
> > +	if (drvdata->flags & FSL_EDMA_DRV_BUS_8BYTE) {
> > +		fsl_edma->dma_dev.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +		fsl_edma->dma_dev.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +	}
> > +
> >  	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > +	if (drvdata->flags & FSL_EDMA_DRV_DEV_TO_DEV)
> > +		fsl_edma->dma_dev.directions |= BIT(DMA_DEV_TO_DEV);
> > +
> > +	fsl_edma->dma_dev.copy_align = drvdata->flags & FSL_EDMA_DRV_ALIGN_64BYTE ?
> > +					DMAENGINE_ALIGN_64_BYTES :
> > +					DMAENGINE_ALIGN_32_BYTES;
> >  
> > -	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
> >  	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
> >  	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
> >  
> > +	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +
> >  	platform_set_drvdata(pdev, fsl_edma);
> >  
> >  	ret = dma_async_device_register(&fsl_edma->dma_dev);
> > @@ -360,7 +588,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	ret = of_dma_controller_register(np, fsl_edma_xlate, fsl_edma);
> > +	ret = of_dma_controller_register(np,
> > +			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
> > +			fsl_edma);
> >  	if (ret) {
> >  		dev_err(&pdev->dev,
> >  			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
> > @@ -369,7 +599,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	/* enable round robin arbitration */
> > -	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> > +	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
> > +		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod
