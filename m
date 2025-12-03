Return-Path: <dmaengine+bounces-7493-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60516CA1CBA
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 23:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E85D3006595
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C72DEA79;
	Wed,  3 Dec 2025 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T7fFR9KE"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86F2DEA94;
	Wed,  3 Dec 2025 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800087; cv=fail; b=C5+rInqYRItk5+wWyOcYdb01h/1zSplQ+O3s4sb80D+khZD0Tbl2oCBK6bP1Z1ZvGaN9f7vGP/yL8kMih4oPKqCL8Cy4zb7VZD92vJSJDoi4yWQIBXvAmZqm69dtSAd9Xc/6htYUC2nZlGjEUIQWehFswnF9v6pkYuVwAYod3OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800087; c=relaxed/simple;
	bh=eLGvIPESURVf+aEXjc1Wmth72oQnQJdwd9/Rx1K1+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d1DfoNsbiY0y0D78cF54JzobktRdUA0+aFtoBQhHWTH7PPLbW1H0Fw9FQuCDzf2/tPNGeff9E6Vagso4bW2oaPamDNvLtwlc6YX5Mexrq1RP7R+sp/5VqnxtiUI8z4mU2JKWt42Qg+WSBNvPryJHmoqUohdnjPCio7QvE9wTiXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T7fFR9KE; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaq7+NaeGFW0IulxdW8WHgM59Y+49gcZtrby9xKCULBRbVToUDFqtVec9gi1X9gLU+xTJUir4vhp8FeXG7ZES46FdJ5TEoZ+tXytPVTJGu8k9kVp6MhbSRf9y129CJ7zRe8gmFTvQ8pyIjezNE5vGFAkpacSfEiyz3D6fMt8uj0Np/H4Agvx3CqaNbCIAxKBAV4GZuSGuBoMZRmfkJc2gsrYNuAKKrTIsriyK2Drm3eYPWGdWNLIT82/KxcO9yv09sZurveu/p/yuPxFvQVuiEIIb5pEeCRenXa7RZhabDSUQwWL21WBCz+70qEs7DWpFiXMJEGh3fXYHOz1T+GGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICwi9t8n9AQgbT67pyEUrLakr4QOYeTfwmSpAZlLlO4=;
 b=ksEKKjhyLsgCs5aWBinswLW/1vMw/GhaaSzW6m3JWT56ow9TiZSjzvzUzRbHnU6s/gUUK0J6eM4W/vTXOT2YGLZgPvt9gB7hrdd5o3yNBlSSR/gcEr1RrzCduu2fdVIAwwa8wqrGDBJcW5IlKzpjQqehrt4LKNOebJZ8S4INauEy7cssE6XwYmEmbRaBgdxufs11Webd2EhkHViz7dAqOmT+AbYe2Rcgyb23l2NS8hGb/H/aKFGrXdV9Yeh3q+S4oQjzJ5byzODA+odmcI6L2R7Py8h6Y/aHISalAvt79KyWGN9L0o3dR/L7BY6sPNoHyvMRYYJDBCYoQJh3nYn2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICwi9t8n9AQgbT67pyEUrLakr4QOYeTfwmSpAZlLlO4=;
 b=T7fFR9KEcgf0Fheq45t8ZKqLe9zZvOyAIxjiujfibJR8HbFas0b6Mj2qAxbV1LKaEurGkWKOuiMTQha4/Uq37i0I8ImPnJK7+TeorsCG9GRnhmAR7qozmb6WfeiMdrqOEnRSF8fMIUbSNUvg/eCuBqiKf90X/V6GkuD15xEG25o8O9Rbih+4zxLVofMcu9c+f+2gY/QDq5KRAMd65M10Sa2jpcrmkFKERaerIgcV6UJRl9NIS+nkGphMmc3HLDT8nAS+1TO7n0zKEK2v8zyOREumPXHDY96SMwyzBd+S7qyyy6uVlWrTXhqtQSlQB3MvUVph2znIClAYZ5IwGVut0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB8962.eurprd04.prod.outlook.com (2603:10a6:20b:42d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 22:14:41 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 22:14:41 +0000
Date: Wed, 3 Dec 2025 17:14:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: fsl-edma: Fix clk leak on
 alloc_chan_resources failure
Message-ID: <aTC2SrErg/R4UlAI@lizhi-Precision-Tower-5810>
References: <20251014090522.827726-1-zhen.ni@easystack.cn>
 <aO5t/dHjLsfkaFar@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5t/dHjLsfkaFar@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd4f71a-b58b-4620-b953-08de32b95b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+TIyxjX2Q2ItbV6JbUP5ZHQoJgh35+2wKOkBRWVI09CaKxHVNgZesO4Pb0B?=
 =?us-ascii?Q?uym+Bf+Sn3VXpRhhyK63nleD8hWtUH0lhsvIryEDBnHTwrBY0HCAAFzRDoad?=
 =?us-ascii?Q?mWZ6a1gALYkxt1te5ejrawlMawKpiaNoXkZCkQ2tJ4jdELnI0pX4wob9Wlxj?=
 =?us-ascii?Q?5Li2wC9vDr+aAl/W6yOku7YHhj04kseK8ee12sMPsCV1B/5c2NbeinjLwTWK?=
 =?us-ascii?Q?GGWczTsCZzjDXPNEhXrxmJ0jOlk6kEzfvCDBNeBCf87kNVWQjt8/RTkVEi9K?=
 =?us-ascii?Q?eOe4pdKTA55a0f98+faBf4Rbi86kT0HHmuJrSu8I7/+nxzPi/hdUzSBNFCg1?=
 =?us-ascii?Q?8AVztZY40Wj3EIGknPd66e2xhEvrkhx9AtOqUx2A55SK0K2nmKhAP5MIAv11?=
 =?us-ascii?Q?8LPWPoPc0g2u6ie2UJi2KV4aaVdUvA+qBEiaI7sj8KoU3oN8036lciOAKFB4?=
 =?us-ascii?Q?AYZ9Cj6+ASuz98lzQWPnhqg+C/OtGOsiCinJPyds9ajwENexF7XKUolRovT0?=
 =?us-ascii?Q?TPA7DScLUWOON9PCk+Tv7ZaRjNAXFLcAa0JLD0VCC0uTSsqUqO/qf4oAPq1m?=
 =?us-ascii?Q?C0WjyLfRSdgxR8K8aY8peyOhvgAMdwl6bXk5/Mc7IFbey3fVvVYyLDa+Gmt0?=
 =?us-ascii?Q?AQj0c+QwXjeME/ySnKtm1J5vYRYIUUofl+V1VUKPU5+QZt7jOwbbOcvEUkKk?=
 =?us-ascii?Q?GebhCxXZofAL6or9VDDOIIuq2QndqHLjLGu1GFDmFCH+w+msq8rmNglQa/oy?=
 =?us-ascii?Q?jiO/d92VgZRFSxmgESn42Z/q9qCnyjgTzdFrjMfAkl38osPTiHAe9KzDLqy3?=
 =?us-ascii?Q?kjkFLXpyGyRleJhcBFeszMI7rSgDtFtyIk5XBrrM/U+nUpXM4R3u1taCs1BA?=
 =?us-ascii?Q?MHXOypDUaPLo32PGWG5+6ALn5MYyaE2upBErjbq/M8+Ch4DQF7W8T5jrLLGl?=
 =?us-ascii?Q?4iW2ngALdCtPJq557v3ZrgFYziA9eb8ELKBa2yohJFLew4EjjNCaIH57A8lL?=
 =?us-ascii?Q?vn0ze5+KPUqks1OxdfCAnhbbKveX0owsb+2q+Bzv1gCNg8cBj2z8QAmVGBlW?=
 =?us-ascii?Q?S3AYDmuOhBXEVm0+sEHN5QrMfuy0TxvhzR9si/CmeIddzaCmBFtvXYpqqvdR?=
 =?us-ascii?Q?HSnkxre0yZ5h8mXaw6gksn3ntRk4a8Ot/KAgWCD57RV4rTSJq23hpQhR18ca?=
 =?us-ascii?Q?8Zoypv41fSmBKmaxuLyQm/dRRLzD2SvhJAKeFgYywFmXuY+mRmwtKlVEdWO6?=
 =?us-ascii?Q?q0Y2PM+LGcS01Zv9JFak75te6sujobAXhi/tH14Jmhcn62lpg19z/9KBij0L?=
 =?us-ascii?Q?bSJE/L+79+/pq9wld1Eneu0xkSaTiPHfnrDUqR+iYN5xV7glD3NcMR7t/Pbp?=
 =?us-ascii?Q?F3syEbNR5CqHzOOZoNh212Hh3mse4/1WTEMMWiuyQwHwDOQXxrY/+XkVNA5F?=
 =?us-ascii?Q?I3/0JjGNkpgG09KLNyh4ll/824sXxsiFwvJS3w2+q4UJj5gT8KgnON48a/g0?=
 =?us-ascii?Q?ADoIWIv6VtV2Qy/p3tfi9iuq9y1WgrqNpziF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epDidpUjFEW3E8wsM0D+cAnNf+er1TWLCOvqDZ9OD4gR7Bxoh9o1KhCxFME5?=
 =?us-ascii?Q?1OlPp6FEGmvEzlNoDm1qR09e1aFd1aGEAVGsMUl+VYxkE2VyPM8Yq4yfbywy?=
 =?us-ascii?Q?EpqLOdiX9YTg9+Qd9wXf4JtOnbvGqAsdfBhOsWb8iaal4ADd/Nl8Wb1OU961?=
 =?us-ascii?Q?3v7mUQD4oDk/D9qZuWudZyvfnO2R+N3lTpq9+cFJo78LyXEwegi6izC8mhxh?=
 =?us-ascii?Q?/9pOpEu7Dv/PbALJpUa5aIHk6rYhiry4kF82esSwu01/a2rj/1YRGjyJiQq4?=
 =?us-ascii?Q?ueMASanCKx4atFlnFtezUjXMR8alGrx31is8sN3dN0BOAuB1+CRhz0EKXKsd?=
 =?us-ascii?Q?C1QTp/j3W8YxoWRJ5uOZQymOgqGSUb9gCfwQI5b2g6Wptnn7ay2gL0bNvCSJ?=
 =?us-ascii?Q?J5lUSg4Zt3I6jzcvRjQL8wfwUlaIBBYFGb+FP+DSW9uiexdR35vbd7xLfaSt?=
 =?us-ascii?Q?6pXBbFjL/Pm8CAQtfznl6fos8eKLxO/4Lv3yTBnZdehbgbnrcVlhwRg5svsU?=
 =?us-ascii?Q?ejWCrm2WwyXU6CQrBaFjj+JTeEidLnp6xha975C4h03hvQQxxoVnSsG8KPPO?=
 =?us-ascii?Q?wyiopWP7u6XX+6Ll9PsV8ejvCLUxUewOAxbuS46M23DIhDd+xiGmSzCW5eVU?=
 =?us-ascii?Q?mDftnfSnBUHkRKEnBbE/pTPzPkPwkduvfA8i52DJckL9LHQ7KJGEkETFSaR2?=
 =?us-ascii?Q?1yTUT/4sVwIMM7XOyqtdxePkv24PbfhWbMbu90WwIdsswbjCctDujTf24qNb?=
 =?us-ascii?Q?GwYZ8/mKn9fpN0uFbm7zG2jrh+GhC/GRH1aQP/Ard5FY4b5XZDQButDAthoC?=
 =?us-ascii?Q?QXVeI15YQCvhmQzq2nz0/b6ZsQOvsWvMeTx/HgeW2Kkfsvwk/TG7fNKI8Rc2?=
 =?us-ascii?Q?0aRBnl0tHCKtDy6kEP2jISYi/NhfGyfkGcWOCqCBcQQrcmn7pBDEdO0gr5LM?=
 =?us-ascii?Q?cunv3Eb1EEgzWELKBXCBuMOqguPUi4xyQcquzPkYFmVtFYqjoGzd6OOGPzqs?=
 =?us-ascii?Q?2j3qHvLsAnuSx3Zt+a8lqrYgqMbUkcHc33MYNo/JQNBtF2hCyhSYXez1HfhJ?=
 =?us-ascii?Q?Veda8U7WXD6MC4mex0YoLMRWtyFJxpLBf36rqFMeNQVRfGdnX/JLi6AhKq97?=
 =?us-ascii?Q?An4MZCSUGv+T26qxmwcOkE/XSZ2QZaqmbQrfP/ZvaJBVqk3PDDsPCkQVk0tB?=
 =?us-ascii?Q?+SJ67MFU9IGwYgONs/yz83fCbezSkw3Go3xS0KMYkCA0EH+VHScHCb0XtUYB?=
 =?us-ascii?Q?jqUogYpIGkB9Qw0bFdVfDqoIK3VshXcFnc8xD3ztoRziteiNfWHPvrk3IOiW?=
 =?us-ascii?Q?N/KGwJBVgH40TiMq4/O90tlrDK+PIZOsHuJvExI7rwKbtg7brFTIp0vDkMBH?=
 =?us-ascii?Q?NAkGlsusciCPpDsg3KAMpojg/9psM9x+hckjnGW/Ifhrw5IMxew3AYqXI11t?=
 =?us-ascii?Q?95z3sWI+ev8ZlgF135WsHBR7UrweDY4XzEwN+rrTshLElme39kDz+f4dUfP+?=
 =?us-ascii?Q?zVUEtOeHLYkkkRSlqDKGkMf2b6kmriCImPsSYtoqI7IM6RE0Tt8Zk9pJeCfC?=
 =?us-ascii?Q?y5B1LH4c7r66xgzka0dXA+ngJrzjNNviPBGlTJEM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4f71a-b58b-4620-b953-08de32b95b1c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 22:14:41.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDRrE2yTJB/9je6F1IXea+rjML5F78SiZu7uU8i/v6IC30BK8ckCJvFiIOGA4X18PqZ4vjMLu6trOop1v1GmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8962

On Tue, Oct 14, 2025 at 11:36:29AM -0400, Frank Li wrote:
> On Tue, Oct 14, 2025 at 05:05:22PM +0800, Zhen Ni wrote:
> > When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
> > the error paths only free IRQs and destroy the TCD pool, but forget to
> > call clk_disable_unprepare(). This causes the channel clock to remain
> > enabled, leaking power and resources.
> >
> > Fix it by disabling the channel clock in the error unwind path.
> >
> > Fixes: d8d4355861d8 ("dmaengine: fsl-edma: add i.MX8ULP edma support")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Vinod Koul:

	Do you have chance to pickup this small fix patch?

Frank
>
> > ---
> > Changes in v2:
> > - Remove FSL_EDMA_DRV_HAS_CHCLK check
> > Changes in v3:
> > - Remove cleanup
> > Changes in v4:
> > - Re-send as a new thread
> > ---
> >  drivers/dma/fsl-edma-common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> > index 4976d7dde080..11655dcc4d6c 100644
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -852,6 +852,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
> >  		free_irq(fsl_chan->txirq, fsl_chan);
> >  err_txirq:
> >  	dma_pool_destroy(fsl_chan->tcd_pool);
> > +	clk_disable_unprepare(fsl_chan->clk);
> >
> >  	return ret;
> >  }
> > --
> > 2.20.1
> >

