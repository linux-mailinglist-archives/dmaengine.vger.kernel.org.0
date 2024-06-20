Return-Path: <dmaengine+bounces-2444-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3691089A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E535D1C213F5
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76051AD9EE;
	Thu, 20 Jun 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hQr0iOk3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9B1ACE9C;
	Thu, 20 Jun 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894356; cv=fail; b=br+FK+2mb2Org2Qb3LC6BnS0qXvI8sxSNWVgbHekim3xSVDKKkMFZ3cuJRUKS0wbPBF6KKUvcBAaf994gdwgK0wJ3XhWtXAPgKR29z0AatI/EBM55OPkIwyPmLrLbD2MsvR0wLf+soNAACe87zc9VzLmC5lSW+q8BnnQGLtfe0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894356; c=relaxed/simple;
	bh=DCiN3uqn4cGJDqo4hnXOPq+O/IaNPiJsQoufN18dEAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/Q0c9g7AT4nrqwEeJnmH2P6Ui1b3QopEGL11WtiDEm6H+PEx45/iT9IYocIIPQ0Usbh16VrkJ9w6XhvRwLjVEmb0nsBUuaTxo9IQ3cEYuhZfybLQ9C8Xu3jcjNI4HXJWwb/9eDQu6QHHOZWp2HK+A715NjBKiA/W01NNlZVBxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hQr0iOk3; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzSH+yAIaHAkomubn40hfmPY4DCp7BMlEvIIg1Wo3SbeL/7OS96FEki9UNCzKRMXkPTMfSnBFYHJU3Z2xNGzR4uBvUodg0SYsBEpqzLcnxfEMa+Mc3zkUi+l52LhlbUynK+UftRBap2oezfeQ0vjSGBfp4U4r8kRXBfbhRqFoy/NymWJa4n9lKG9NDnbG0emD8ypn0ndqeiL+/81sEH9NNKckMA1ljIHhH7Yn1Lvdr6jrOiau/AHoIEk0m4GaByxAb1v/JSZYOcEMWenJC76m/6fMuKNpxKYIQckRmUtmmMt4XpRBTOR2T2RnCk6mTbI9V48Ky6ySfXSjRCyunjpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOc3YV/0rtYaf/EVOK11K1NZoj+32wQ73Z6BCgioXow=;
 b=aBIrI9UHnUTOjxFCcbV3D842RueskuWqtXvVB1sFM1XHlsOs1VytEuczlYb0DnIzTcIz5YimNLbfFxkYI54hJXukyHolrWxVjTYSVg930jV+NvvWuwbwMOqAiIH8pCDc3xYt2CJwcIcdDBwqzStH+7fVbQMrkEHtrHonIRAF93nizluBnQuC+wF+/BFmMV65hWqRIkl9ieoG2CrbVjMK+4ANaIMT93a1fl7PdORenhTQTjPRIQUu70duN0PN6B/SBLcw3Ipe8IAM3UEaVgzYXW22eAv11WzWGHCgVLpuEitvvQWmxJUCZC8Y2ihLX0EimNR07BqHPNPBV0EIMXUVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOc3YV/0rtYaf/EVOK11K1NZoj+32wQ73Z6BCgioXow=;
 b=hQr0iOk30JrzgOfBgBoaLpR/P5LYZ8nFH05C0MsKmDB2cXnqKd8umzs/fGeM6+V58YMgiC+cs0lCeGQsklTpjPxgxr+xSNAaTvvEzcp8aNVxNNQ85XzRKwG5IVaTQc0PFcecNAAvGOzg6ItH6qRrazJ3YmfI3eTm8eHiNa8jMbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 14:39:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:39:09 +0000
Date: Thu, 20 Jun 2024 10:38:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jie Hai <haijie1@huawei.com>
Cc: vkoul@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Li Zetao <lizetao1@huawei.com>, Guanhua Gao <guanhua.gao@nxp.com>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE eDMA DRIVER" <imx@lists.linux.dev>,
	"open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] dmaegine: virt-dma : Fix multi-user with vchan
Message-ID: <ZnQ/AyffdW+u9C8P@lizhi-Precision-Tower-5810>
References: <20230720114212.51224-1-haijie1@huawei.com>
 <20240620025400.3300641-1-haijie1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620025400.3300641-1-haijie1@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: d31770bf-0306-443e-78c5-08dc9136be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|1800799021|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gzg7LrNL0370T806QFTIJ4xZtW8HlOwLM4UfJC1Op6XxUMAWPMiGpHxlkOUy?=
 =?us-ascii?Q?4lhDuH41qGey7OZHPDyEo9tZt2Ig67RaJG0cy3mJSvgEftR7GredFPiHFJsw?=
 =?us-ascii?Q?DF9mhig7Sxf2U7fWryJ4MuOCp1lh7f5OLY+U07jJtT4yDLFKK6TQzeWrtnM4?=
 =?us-ascii?Q?36zFFsC6CCVEWht/81g6MVyFBxRvdzr8q9cXmly5FsWGu03IwDiM6ZaWufck?=
 =?us-ascii?Q?4asZeKRkz46Sty8eNs9ICmrifmWjMcCublDIDX0jrX1DVRNid0Z4WYt630fg?=
 =?us-ascii?Q?AKg0i6Es8edorRtasOSaXyqqWdSwiYpLbCxyFNzWHxTKkj7nxNl0Yb01yC/G?=
 =?us-ascii?Q?0bLxSb9JoXxyuxzJqXf1YNc0zhRL9BXX/5/XVu4Ylg1k0NiW0P0aaSJWuiUo?=
 =?us-ascii?Q?7OvA087tD9vlpHN9mfQeKuUPwGHFFkY0v6IM6e/Daw2ewAdqJxuO9LGuTOO7?=
 =?us-ascii?Q?Pf98PwoEPNYB/B8Ph7Tpt4dy58LMDoeJTJHOJf0rhA9owAXojU4KwUQUfaRD?=
 =?us-ascii?Q?hfu8/6d16OAjmgsUwr04v1SefoX0ig/LBJfoLRz47C1jNCl2s6znmxOkd9rW?=
 =?us-ascii?Q?fgHPZVmlhdtPG8x3Ix/c6OlIjfXH1TPqNycrY7KaUpEbmHObK84Ic5TIOg5y?=
 =?us-ascii?Q?1yoMg6c0v/7FNSCiYOZHNk/1RYpgdqOpy3R2g7LbPrUX0KLdnIE5AJQCPeKi?=
 =?us-ascii?Q?TrRIi+EofTaawlIlv9q6w6BHyaVtJBKCXcB3S8pCt1+hcqVzT5SfmLsJY0Wz?=
 =?us-ascii?Q?aJdoYDTtZ3yqgDT/+aYJm9Z5cKIa0E80aB36L3ztLTngdOWa8sVY2WRh7x2b?=
 =?us-ascii?Q?LpwFwarhH8sYUYqXEpffiw2QcHcK0witfN5odgO9VKA3yQ6qsnB7yCw0SvYu?=
 =?us-ascii?Q?ozNiladBmk33ybG6kmqw5EP5KWBUKJF9Mh7ObY1pJQxyyZLy4VvezGe0eajj?=
 =?us-ascii?Q?1piGXWt+Suipqylf3I3lAn4vjRr+iQdiQ8jK7grMnoiThSLcY5QKTJLB3W4g?=
 =?us-ascii?Q?jAf/mQw5EhDxaW3nY/UVyNlR8zAa3TLiu/sF3Xj7KynPjYg2MIi8hI8V05t0?=
 =?us-ascii?Q?XQ1x0TpX4pPaXVofTxF6XalmMCT7pGGE7/JJWfoPWOwq5QUGuR1fwnF6aZ0s?=
 =?us-ascii?Q?5ZGjmAWcB07nyhcXlNU3WI9KAhVVbDJSo60iJaRuxTsUYhYxB1g0w/eQ5cVc?=
 =?us-ascii?Q?lcq7vpHEfSj55xGLLdV4RMzi+bwL1ukbGE07nUjJTpBgUM6xTH99UYxmh7yp?=
 =?us-ascii?Q?kDzkTzz7RBuVAt/zp7m+tS1U8e8wQj2hWcK7zFcB3SrIsl6nmPAw94lx7ira?=
 =?us-ascii?Q?PFoL5PNz33l8pBL1Uqk8gqTT5oWw3HrwWs/3OLVsNPLTzFO0DvWdDb7GydRU?=
 =?us-ascii?Q?MRaNwoQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8p0dgMKGWa8gEkC+Lzbh6x6Lp7bCyRChDeFc2QO594+iLBYLDIyoPUb+Z6em?=
 =?us-ascii?Q?4xNdXDCeJfUMSqcbBTGgla5XMl6xLsNLPJIO+Mpd17tPsuwxZZ3m6AVl7jHe?=
 =?us-ascii?Q?PzZhtD0dQT3dj4kidGW/F9Mj9HqW/+tfCjZl/+Gc5kGJ7OcymC99jkdFxmyl?=
 =?us-ascii?Q?W2lIwSjNhC2PTGu5sc3D1JoYMU//JLX2jyCkEMObDT5Fpw9OLY+kX6GgpN3Z?=
 =?us-ascii?Q?QtdWi9oMr5ZHfkUCiKT/Mk8nAxn/TWut7C09NTNA0cZ9Uguwa8d+Fx2BPIAS?=
 =?us-ascii?Q?QB1h5WTQUYshLcT83LVajQpfTo387o/WMzfP/m7KZXHexEUhFs15OesNQkPW?=
 =?us-ascii?Q?hisOqlBjBQqsp9P0fMp+jHU/MNUws4UZA54wJw52338TN9Q8M9R6GoHdmra1?=
 =?us-ascii?Q?7oPuDc4QCDT8M3+iAMBVNJIaIixy5Oes/4F2t35SOIpWFPuddgvQxGVaFso7?=
 =?us-ascii?Q?ULr+8YY89SGwPE2HuDCwHPxKSdaXvyDKTw0BVumtqd+GqFCmpEnsWW4+DqtY?=
 =?us-ascii?Q?uJtmDX6jZhQyUtjiLvT2rEbB3ZXfBYQCavq1EiwrI55A/lyyi4kokXRvEQCV?=
 =?us-ascii?Q?aP7PegytuAZeRIS/SFLB3JL7iObBxqmK169iwhv1Qaz7WXvQnrNpr5UuhBHZ?=
 =?us-ascii?Q?GXl6QgKCvnfSqb4eYdPooXR1ijEjayjst2HFSs8s7eWqcKMY/g4TuqaYjHnf?=
 =?us-ascii?Q?Bonqohd+IR/ygGC2NOnvFPUoMA6BhGBdV45tUdWian9dg0EMaAo+D+Gq33NQ?=
 =?us-ascii?Q?cuVmffawL0A0Hur+W8S01ZRp5doZP4fQP8oYg2GHynoxUm6VI3ZPVyL6N8+C?=
 =?us-ascii?Q?fU6KHRxYL50lGs71LnVmamkn3znOxBKHKYDccj2YZ2TUvm+VayRptQ8/kuJD?=
 =?us-ascii?Q?bu3NbjxeP61sWz/iSstGM8GQwHtOgVVlmVXF6UoRsOtFRJbtCMsgNB7MRFtz?=
 =?us-ascii?Q?1g8CaxIDQZ0J+jpNF/dyqxMOI6nguIvRKaqNq8XAX9/0aJ84ZRc0ZuS3fs/X?=
 =?us-ascii?Q?yn5lwrz3nvPbx1khxFvA1Rd8Fkenx8+PaXRnw93UrWMHvEyEVqZIcfAaSxrx?=
 =?us-ascii?Q?D1AsGK9fqlutDWpyiGMnVjWAhHqVcvXRLD4H80KbPCLSnTEZ7y2urUfEpeTp?=
 =?us-ascii?Q?Rm7HtLM7gFgJxz4IrlIt3mFTruix8hQCtDBInVAS6QAQDy+O1VlO/l/IxFHm?=
 =?us-ascii?Q?H2s1+Ic6hKnh5RwEOU05EJBXJoBHKKwrHsiMs7eHWhVPBd+7BXh2f8bl2rt3?=
 =?us-ascii?Q?pTOdyEJm6yRkk7rN/94E2883+oJGI2+wXpulZZXtu71AMxixOLlxKF1QGxqW?=
 =?us-ascii?Q?WOgzjlxirKFNPBWG0UARetZP9wqZfa5bVyHOoj7DsI/9P8lRUCE4Hs7R1Qcd?=
 =?us-ascii?Q?zSv41FwxqyPVCJ82oWYz5dwL0Dx41Xf9MLL2jdehKpRD0uTWTG5wOtm9Qauf?=
 =?us-ascii?Q?EC0H7lloCsoEUtSdlJE7qxWb3INmLxSx8wr8co8oHl6tus7SeP8abZgJMQPX?=
 =?us-ascii?Q?kerKA9YVDrkyI9Ts/c30rPAc0oAnn10Gkfz8MRuCQfDyyL4QHlZ/7UYoeUOM?=
 =?us-ascii?Q?M50pShuDk1y+F0+hF/4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31770bf-0306-443e-78c5-08dc9136be65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:39:09.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCG3S8mEbE6xYEqPZYqjjJFyrXP+3PeXwFHqL0EPPoKZM8LVBfUj9iZvCqQrA3fJh18zudjbtrYVOzu59/AYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

On Thu, Jun 20, 2024 at 10:53:53AM +0800, Jie Hai wrote:
> List desc_allocated was introduced for the case of a transfer
> submitted multiple times. But elegating descriptors on the list
> causes other problems.
> 
> For example, in the multi-thread scenario, which tasks are
> continuously created and submitted by each thread. If one of
> the threads calls dmaengine_terminate_all, for dirvers using
> vchan_get_all_descriptors, all descriptors will be freed. If
> there's another thread submitting a transfer A by
> vchan_tx_submit, the following results may be generated:
> 1. desc A is freeing -> visit wrong address of node prep/next.
> 2. desc A is freed -> visit invalid address of A.
> 
> In the above case, calltrace is generated and the system is
> suspended. This can be tested by dmatest.

What's test steps to reproduce this problem?

Frank
> 
> This patch removes desc_allocated from vchan_get_all_descriptors,
> and add new function 'vchan_get_all_allocated_descs' to get all
> descriptors ever allocated.
> 
> And apply vchan_get_all_allocated_descs to free chan resource and
> vchan_get_all_descriptors to terminate all transfers, respectively.
> This avoids freeing up descriptors in use by other threads.
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c |  2 +-
>  drivers/dma/fsl-edma-common.c           |  2 +-
>  drivers/dma/fsl-qdma.c                  |  2 +-
>  drivers/dma/sf-pdma/sf-pdma.c           |  2 +-
>  drivers/dma/virt-dma.h                  | 20 ++++++++++++++++++--
>  5 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> index 36384d019263..efdecf15e1b3 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -71,7 +71,7 @@ static void dpaa2_qdma_free_chan_resources(struct dma_chan *chan)
>  	LIST_HEAD(head);
>  
>  	spin_lock_irqsave(&dpaa2_chan->vchan.lock, flags);
> -	vchan_get_all_descriptors(&dpaa2_chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&dpaa2_chan->vchan, &head);
>  	spin_unlock_irqrestore(&dpaa2_chan->vchan.lock, flags);
>  
>  	vchan_dma_desc_free_list(&dpaa2_chan->vchan, &head);
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 3af430787315..1e0ad87eb7fa 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -828,7 +828,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	if (edma->drvdata->dmamuxs)
>  		fsl_edma_chan_mux(fsl_chan, 0, false);
>  	fsl_chan->edesc = NULL;
> -	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&fsl_chan->vchan, &head);
>  	fsl_edma_unprep_slave_dma(fsl_chan);
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 5005e138fc23..7af428db404e 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -316,7 +316,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
>  	LIST_HEAD(head);
>  
>  	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> -	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&fsl_chan->vchan, &head);
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 428473611115..4dc8a8c8ad80 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -147,7 +147,7 @@ static void sf_pdma_free_chan_resources(struct dma_chan *dchan)
>  	sf_pdma_disable_request(chan);
>  	kfree(chan->desc);
>  	chan->desc = NULL;
> -	vchan_get_all_descriptors(&chan->vchan, &head);
> +	vchan_get_all_allocated_descs(&chan->vchan, &head);
>  	sf_pdma_disclaim_chan(chan);
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  	vchan_dma_desc_free_list(&chan->vchan, &head);
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index 59d9eabc8b67..4492641b79f6 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -187,13 +187,29 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
>  {
>  	lockdep_assert_held(&vc->lock);
>  
> -	list_splice_tail_init(&vc->desc_allocated, head);
>  	list_splice_tail_init(&vc->desc_submitted, head);
>  	list_splice_tail_init(&vc->desc_issued, head);
>  	list_splice_tail_init(&vc->desc_completed, head);
>  	list_splice_tail_init(&vc->desc_terminated, head);
>  }
>  
> +/**
> + * vchan_get_all_allocated_descs - obtain all descriptors
> + * @vc: virtual channel to get descriptors from
> + * @head: list of descriptors found
> + *
> + * vc.lock must be held by caller
> + *
> + * Removes all descriptors from internal lists, and provides a list of all
> + * descriptors found
> + */
> +static inline void vchan_get_all_allocated_descs(struct virt_dma_chan *vc,
> +	struct list_head *head)
> +{
> +	list_splice_tail_init(&vc->desc_allocated, head);
> +	vchan_get_all_descriptors(vc, head);
> +}
> +
>  static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>  {
>  	struct virt_dma_desc *vd;
> @@ -201,7 +217,7 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>  	LIST_HEAD(head);
>  
>  	spin_lock_irqsave(&vc->lock, flags);
> -	vchan_get_all_descriptors(vc, &head);
> +	vchan_get_all_allocated_descs(vc, &head);
>  	list_for_each_entry(vd, &head, node)
>  		dmaengine_desc_clear_reuse(&vd->tx);
>  	spin_unlock_irqrestore(&vc->lock, flags);
> -- 
> 2.33.0
> 

