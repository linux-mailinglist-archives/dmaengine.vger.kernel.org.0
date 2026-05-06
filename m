Return-Path: <dmaengine+bounces-10236-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLkSMrVU+2n+ZQMAu9opvQ
	(envelope-from <dmaengine+bounces-10236-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:48:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E34DC8D6
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B939301D326
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27056402BB1;
	Wed,  6 May 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MWceqHNP"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267546AF16;
	Wed,  6 May 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078019; cv=fail; b=UKOfPsLLty3H7cWjbafxIRB3L5l5VcZWUwNBdHwKzgdWm8CJf51oQFuyYz/CXSJ43xhawzI05zP31LaT2JSDe4g06YmSL94A8sIKNGjju4j9WF3WdSG5YKcMyiX68WET8iUFpUtgSdHD25DqLzNsTR1RyL2DCngpRg0DWz6lhgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078019; c=relaxed/simple;
	bh=udvu2/LuUJR+4x5GCiZBSLqRy5BbzkHvhOpR8QMJ64A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fq4S+jOJ+FBzIdtDPhSGo/nKaoCIQFOphn4wDHBCqysNpIUnFah752vdjGTD1/aR34OPnljz7tN7ut9H47L4GrgUC53QTO+2zbj391I5Pi6+h2L6lPahnbBlVcgkkCigJVCeY2Y6Rw09Qve9zGdFjf+wmQxUQ89b2MJltZ62pWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MWceqHNP reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+vhFEyUajvTK5QwXT3KORoH1oQXbeS/KceNsA+tS2W03a8a0bUp/r++f0OQ6l7lDIOx8PxqnptWK6DniGCXHE9eClyTrSIgfcU6OWrTQ2Fwe5iffkSg27CjrwOos3nXyRAv+3OzLEuA5ORczj6quqFwCDolyA36VykleYhMJWU0WHSjWbnAqDrJQ0enNN+vQalwkOCXFT07nI1wyI8Cqw7q/ExAcm6bj1aCTnrrashqM2zzdwRhfBgqM3m08MuFYq1T8e13fqNCEcFoij00dZu2e2JGX9Aot+1LlRCqz5K1jqP7qaH5HHwMlkUhzubpSsTJ2tABjKi/giPqqidmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW+hmocYswU1f73cFCW0qtXZsj8+zuUqJYkg0KaVtqU=;
 b=PcU8q1ck3k7PS7NzeSpMik/pmhOqsaxiUgv/2zeMs3F6ESmYkTbAex1On3PPKr+aUgjUvwYNP5bZtiQH+8cIMwJ7x77o555dw6JeppTIhj4YuTJh938JhB+RpO5iKaII12SQN60ODFW+ClmNcQ5JRZYS13nwue7YTMnv3E89COw0YNoGorAVCTTEOQYDDWK1gkdRZoCs8NLUbi7VqM9M9mK+NXFvQnCP8IDzBDAl8G5J68HywavEjOsb1ZxnTjI0Fygz3ZH/KtVaUm4+BvkUcTkdNSjrw4yX4P0dXOMrl8O9VagBIP8id5Rf9X8q7HLmV57RaXpvEreFZdAF8AA6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW+hmocYswU1f73cFCW0qtXZsj8+zuUqJYkg0KaVtqU=;
 b=MWceqHNPiwIuumwx6UkNQAEop9zCeYnD9enE3T+VZ3n7bjtyC/+OyQ9GY0dMqFTQfG3XDPgVeFDuQN4F/OoahfRixXoJV+rYe9sarvsWn4pVswfvhY1vKa58iwNOijl7EtFZbhiBpzDlCtwoV/gVTPN4l5uZqhH/m/X3FY2oOB5QQJir6WtrFjdq8CX6RxH2Mt5lgde9e72RPjnlg2P16y8TN471RcoLiB3ZEXA92Hp+6e0hNCvLPJ7VY/9battsachoDPCkQ/5tQ7HSiePtdbQoNAJns6Zm2H2tfG8eKEGgV1BJhe8LzJr6ddnggRZsoajwERGZvY80a6pqhi7K1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 14:33:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 14:33:34 +0000
Date: Wed, 6 May 2026 10:33:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Message-ID: <aftROFOK7dn56hlU@lizhi-Precision-Tower-5810>
References: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
 <20260506-fsl-edma-dyn-sg-v2-1-66439cdd414e@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-fsl-edma-dyn-sg-v2-1-66439cdd414e@bootlin.com>
X-ClientProxiedBy: SA0PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:806:6f::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 552d34a6-58e5-4d46-d613-08deab7c742f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	mZoqRiz8hUDbIeBCvYKHQ4ZXAlnBAQ7116QsRTtrN+dyUmrtVu1fkKGuyvQa47m20wE9TAemRs4ILdHMrzDZoyMr5P5UU03zqCD7ooRZvhuBa7IVE2o3kFFauhLVzS8UzHj9vdaZLhsFKmpe42ICmDEBavTcVppq6p2KybKEs7JUpxOmzDfaBmpuqyGgedy1dnrxV1nTT+6HSLAxpLYzhC5+oUJnoU/wgzX6Rtw/g+5Rzbw5djL0G0WRP0o7Q3imykYfoADZRLlcqdQMERpu9lTSNrOWcGtNI8BR5GWc5RvadYYFlicaqKcwz3a0zqatmuce7u5pJPQpXLnnjl9ncVwjYFmxikBoWW9lwq8SWXiuHxblj+1tLUEj/6q11PEFv9RA4sNwaxOgUtfCkk0DrjZBYtSkyuWOqAU+f4v71C7/aAxDUamqnWPtm1Fqno7fvzHUghdMS4pn5f3A9u2de+Ay89hFiP9/p6NdoAc7eNdtI2cl4HBPOdjmgyHO9y7lU2hjfJyeU/UJUMI577/CL2ZpN/cqUmZhGHSSc3A2lIiA4c44JIxUviDXtAtaINppqbc4qhHbdRMqMlOf7jEa8rTq3CzlccAJSHt1xj1vzDc21Nk9OhHYtHcxMg7u9YB5/nDSOS9SmibmGqtBLJ0pd/CPSV7LEqE5ggCdoCzxfy0sYNGDDtKqPeVJvRGhcjm5fVdzc0E28wIX5C3J088dnzL4pm5lBhYZz3cFiNAujP0MYYwAceNp9vock8YxYWvp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Snxp5iH0NEMBtcCp8uncrqCdV4ZJyUzPQPIK0wV7iC8SIrEI9qxipf+sPJ?=
 =?iso-8859-1?Q?/y69FOJPWXbrRrb2LDzvG1M/Ud6w3qSAS+3QKp/3od6FCuFsfSeKY+UZCw?=
 =?iso-8859-1?Q?K8+rJlbYkS+tVonjP0J+Snqh4coSbsWoWZRmr57eIJern1c8aYXfBR9kYQ?=
 =?iso-8859-1?Q?aE4EH2jWj1CkmE599T0fj71uvWH3Ch92oRysvKsbAIxhQOk3t7uYLBaYPb?=
 =?iso-8859-1?Q?6LLe1EN2ISbq4XxZbcrNcKQclvvERjtTZRjrxc9qRSjigYRv53n/n6m8k9?=
 =?iso-8859-1?Q?uVeO6WekQShg4rmF7LzqZpcNyNFVUJJi9OU+dGWHConFC557Q1OK3boWm+?=
 =?iso-8859-1?Q?1lNj384zFycci5YANHFdxNrYEjGDo5BhRfxNE3QGJB7b+SycjUab3JHLpU?=
 =?iso-8859-1?Q?oOP0ROugwIVZ0o9Oxip4MIF7KkeZm7JfIFJpjHWxP9WQCZnpL7Yo53mSIE?=
 =?iso-8859-1?Q?GeA/DnsfW20+1IcWWqeburKViEjdG2hiLXA+ajEgepkYpnvb5g/YOIWPcp?=
 =?iso-8859-1?Q?soI8T4t0Xyhedntv7TrVsLfhrj4jEhBCq1VwIFvPr5maGH/M82ZKnaxOoW?=
 =?iso-8859-1?Q?qh4SgcKU+84Lj3tUbMNAFR3etfwDf4LhtabNu+qUJSbOTWjaSU8Dvt07xt?=
 =?iso-8859-1?Q?k5zp1vDsa5bAr/ki9D+yFC9LNUlvF/TAB50kCfHp9Qd3Yar0OD/3ZL99mp?=
 =?iso-8859-1?Q?YF9m0aIWZkaTrx1vYYC1pxn7rfAmbqDeszUOS1B4s1Ym1mZ7DP9iuxBI7k?=
 =?iso-8859-1?Q?9XNNhy6r7NXXDS8wHSEy6IufiQS1iTT9akCiwpAxSP7j3UuAfM3QW5U0Cb?=
 =?iso-8859-1?Q?ec6lFADc+6mNssY7XLGdQ34kFPZVJKYWVX7tSyreKp1fgx/eAzZEhAE2LN?=
 =?iso-8859-1?Q?c3DRYZanSxZ9l0tWkPbVKryZcN8/ufxGLvvI9ar7g4CU8pURX7oUmyYT4M?=
 =?iso-8859-1?Q?w+jxsXfk8HU/+jmClS52x62Bg81geJE/bHmJHrPJeVN3egtxvbNMvY33kw?=
 =?iso-8859-1?Q?JC9y53wtjDd45VtmQVvBfoZFl9cbnGHuOOGA7RdyfC2kgkbZIkdfcthMk2?=
 =?iso-8859-1?Q?0Sv5uwO46CbYnnWBYgEls6cJhpcpMRi9VL0HnNRL0rcOaPRH+Y18ilCfda?=
 =?iso-8859-1?Q?lqmC1y8rLXjaRy+jl4b98QQPS9/20R+VKQPnwDcPwWUxfoutHhQy0AUqP5?=
 =?iso-8859-1?Q?uiBftd4BHkQ3zp/a6jiUzDVDhnNZXaN0stYLI/S9G2G97pJcdT0+4UkjzV?=
 =?iso-8859-1?Q?5gDv/HeDZJjN0PgIFYhKGwrvzMatdTSlAZS9Nuku9dRk99ygjtmo3NYosK?=
 =?iso-8859-1?Q?jUjepmwTznaZ+/M0IhSkgfYdOUUGo2QhjY7UhnUYI5/awlw5ZS3T/Dt2Vp?=
 =?iso-8859-1?Q?T3PTdbg2t3/bkzTGNUmjyQ41Bxzy/Oi+et5DQ897Ab7dTjPEEXoNWRnIsM?=
 =?iso-8859-1?Q?BBetw7sCTVp0+kFnFcNROwJiqGXw5XPP+Y0HlAeDltIpV5GLbhVmxoYK4M?=
 =?iso-8859-1?Q?5MwBlnH06oTf4uCI1ANYTsygwjD2H4Q+OYRZfpUBcxzq33iwK8DkTk3Jvs?=
 =?iso-8859-1?Q?ruVVK2/4gLFipJ3zPopqOjuc9/ZwVGuJkd8RLnUPEzID+Cfh6VQYPzJOFh?=
 =?iso-8859-1?Q?EknTbM0mAzLko7QVxskblnEp10/P4tEygzsd0MyYr3XIG543oFGsU7FGrb?=
 =?iso-8859-1?Q?gcKODV/yUQ9TnrM19KjUhVKNubQT0DzFzvwgWYdPdQ9dtmFT/6QC+zLLBx?=
 =?iso-8859-1?Q?czLKmM7Vi0i7Un8SnaDBZlnrqfffH7gvtJhiAgC/3dbmeuvdW3gCrX98N+?=
 =?iso-8859-1?Q?Y+l1hCO/ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552d34a6-58e5-4d46-d613-08deab7c742f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:33:34.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY9NNZdAkrEA8KkdOBL01MF0EjGx1OvN7IzqrZE7mQ8PSwzpv0gDgDtduSZS4ARikU+r9QqguS4kFofkcsY4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Rspamd-Queue-Id: 285E34DC8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10236-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]

On Wed, May 06, 2026 at 04:10:35PM +0200, Benoît Monin wrote:
> Add implementation of .device_prep_peripheral_dma_vec() callback to setup
> a scatter/gather DMA transfer from an array of dma_vec structures. Setup
> a cyclic transfer if the DMA_PREP_REPEAT flag is set.
>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---
>  drivers/dma/fsl-edma-common.c | 110 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/fsl-edma-common.h |   4 ++
>  drivers/dma/fsl-edma-main.c   |   2 +
>  3 files changed, 116 insertions(+)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb7531c456df..26a5ecf493b9 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -673,6 +673,116 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> +struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
> +		struct dma_chan *chan, const struct dma_vec *vecs,
> +		size_t nb, enum dma_transfer_direction direction,
> +		unsigned long flags)

struct dma_async_tx_descriptor *
fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, ...
				 size_t nb
				 ...

> +{
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	struct fsl_edma_desc *fsl_desc;
> +	dma_addr_t src_addr, dst_addr, last_sg;

Keep revise christmas tree order, switch both lines.

> +	u16 soff, doff, iter;
> +	u32 nbytes;
> +	int i;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
> +		return NULL;
> +
> +	fsl_desc = fsl_edma_alloc_desc(fsl_chan, nb);
> +	if (!fsl_desc)
> +		return NULL;
> +	fsl_desc->iscyclic = flags & DMA_PREP_REPEAT;
> +	fsl_desc->dirn = direction;
> +
> +	if (direction == DMA_MEM_TO_DEV) {
> +		if (!fsl_chan->cfg.src_addr_width)
> +			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
> +		fsl_chan->attr =
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
> +		nbytes = fsl_chan->cfg.dst_addr_width *
> +			fsl_chan->cfg.dst_maxburst;

This file already use 100 column, keep it to one line. check other nbtyes.

> +	} else {
> +		if (!fsl_chan->cfg.dst_addr_width)
> +			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
> +		fsl_chan->attr =
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
> +		nbytes = fsl_chan->cfg.src_addr_width *
> +			fsl_chan->cfg.src_maxburst;
> +	}
> +
> +	for (i = 0; i < nb; i++) {
> +		if (direction == DMA_MEM_TO_DEV) {
> +			src_addr = vecs[i].addr;
> +			dst_addr = fsl_chan->dma_dev_addr;
> +			soff = fsl_chan->cfg.dst_addr_width;
> +			doff = 0;
> +		} else if (direction == DMA_DEV_TO_MEM) {
> +			src_addr = fsl_chan->dma_dev_addr;
> +			dst_addr = vecs[i].addr;
> +			soff = 0;
> +			doff = fsl_chan->cfg.src_addr_width;
> +		} else {
> +			/* DMA_DEV_TO_DEV */
> +			src_addr = fsl_chan->cfg.src_addr;
> +			dst_addr = fsl_chan->cfg.dst_addr;
> +			soff = 0;
> +			doff = 0;
> +		}
> +
> +		/*
> +		 * Choose the suitable burst length if dma_vec length is not
> +		 * multiple of burst length so that the whole transfer length is
> +		 * multiple of minor loop(burst length).
> +		 */
> +		if (vecs[i].len % nbytes) {
> +			u32 width = (direction == DMA_DEV_TO_MEM) ? doff : soff;
> +			u32 burst = (direction == DMA_DEV_TO_MEM) ?
> +						fsl_chan->cfg.src_maxburst :
> +						fsl_chan->cfg.dst_maxburst;
> +			int j;
> +
> +			for (j = burst; j > 1; j--) {
> +				if (!(vecs[i].len % (j * width))) {
> +					nbytes = j * width;
> +					break;
> +				}
> +			}
> +			/* Set burst size as 1 if there's no suitable one */
> +			if (j == 1)
> +				nbytes = width;
> +		}

add empty line here!

Frank
>
> --
> 2.54.0
>

