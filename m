Return-Path: <dmaengine+bounces-11406-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KIbdBV17KWqIXgMAu9opvQ
	(envelope-from <dmaengine+bounces-11406-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 16:57:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778B66A7CE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 16:57:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=sGeGokGE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11406-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11406-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76DAF313CD7F
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F232D42B;
	Wed, 10 Jun 2026 14:43:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B83D9674;
	Wed, 10 Jun 2026 14:43:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102588; cv=fail; b=U26GP2kU4oBuPmdmFtR/43ntRv/Eh0D1Mp791HAZLzceS7MW9Nhstm4FpvvSdbEQYw8PjjYD7C1unuyRG5U5WOy8SGHnq3eFF2HET8BzLT0udtoRbomGfvHKpjODpUb5QTC9F2Lt9k6qNDEzVN2CPUtU2kkEP6U0MZ0Hd78w+P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102588; c=relaxed/simple;
	bh=qphwr5A4fJFKvUn8QVkSV31QeGAQy2X5SnL1x7aqsuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uj41hSX6Upvq7ZTaogHosLYrEmHMZ9ZLC/CpYqpDCKluaG8t60Lz1bCBJSUUecz4r2AkIFhTxcZz3nY0wAvNTr2hz8G6gyS8Wnk3Cs3urXKha9N6gnnonl7k17LroeTE/TGL3qq7ktANUgq0c5AN0vvIZvpco1pw6TFGrBaUY9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sGeGokGE; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsKvsalHEOtlrXEq4sDoJ2FK2iUqYr2pATT/Bn1Myc90bmpfZcf93XDLT+HsWlOHlq/Fd6Qoc2U5dRqs3GmHj4k6Xw5mYK2gnTGH7Az4M3Yhx5lOzYIKBGiqLZl6IIpgQn/If6/Dd5GoIMCBdeNR+1/rfMY5mG+tHuu0h5umQ+pagek+G1Y1ulx5txs5oA5oZyJ7uLCVrn5zxtKzJAh828nRA/RjXS+12y1Sg6k7w5kB6V6XUDbwh5TPR5KmzCeHrULY1g3JqTxAZdOiTK16sgfdAYG4WyKmZ1QzlDN4NYuWxqO/jBk2Y/o+EZq1+iRqSMwPO+wFZewEFduuTjvcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxCKV5tNwF28ouXs+/KcxU+0zp9l1MKujmR8sygvre0=;
 b=dyhmmTFArskRMPj7dAfPOEwaBkLP7YI4NC70XB62pAuCQeS052+2WfNy/7oKX0k+m5yLxhXtjDfP67nzFnT55BqkyZByljs7YylmpQQL+RvOvYkDx/AB6CTREf7ZGpHnaZcRANhj9K/GZXlVcgXtMZsi0RozHIXPWttKDz0tMGpNcOpTfKmBkwh8ddVncFV0UxA8BtCBkCBdez2MQAXYjLXg64ibtZ65PnQYERQ8Zr1WquguQMP73p2FjlCSiaii9NPYNEMcbP3TXR0vW2111866cxsvlB6x8ixCSnn5S/4GCKxyIqtA1Qmr5bamNG0YpGWfWsBivNKY8ST/Z2pnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxCKV5tNwF28ouXs+/KcxU+0zp9l1MKujmR8sygvre0=;
 b=sGeGokGEBJTnfRElf29BONXJeWEs3U5ULWWKhbV88mRE4X/1GFqc7mJMcOeEObzZMrMEqreijo1vpwU9Ua0lm96MQqMJPxZDO2eC1a/gy+55ju211me7o2KpOeEjsT2CM0AOX9fU7NsGQv1miU6sUCYhLNUaAyR4TQwMzo5374dbsRh8pWF1gUnfpGZlpEaovS92q+2aFGhCIhdWndBij3T44oM3z5SzmLfkcB0ZfoNhcQZLTNYO30ALJSZX6gLanpBibG9sE9bOFNKJyCtpUdXHj4esq7lYpkTQd5wuODmDyCHIyadXj30KOkWJx2gX418uSzPYY+gUN2iAnu8puQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 14:43:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:43:04 +0000
Date: Wed, 10 Jun 2026 09:42:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dma: mv_xor: use devm for dma pool and irq
Message-ID: <ail38Mx0r6cW_Wej@SMW015318>
References: <20260610065737.118211-1-rosenp@gmail.com>
 <20260610065737.118211-4-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610065737.118211-4-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:6e::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6938da49-423c-45be-f898-08dec6fe93ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|366016|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	q+VRVvC60uNZyyUEJR0aCk/wO4HiLumZ/SstLSzrbUDpqCw01FP0TmW0YOVxQ2ehT+JZLqsrZhdUgv6O2ENXux079+rzXFSg57Man4HwUHxncK0WHIg1ghC9nIsRZPS+JlvezA/vr01hPUU+zdLpnYzuADC3Y2w74El9y0HVzJvh8TPT7wqISBOCZofB4WZDXoeXQo0/Bs0ChHaJ94TtH6+cq0if4gCSOutTIm0LE9G05MqYaB2A/43R957kXtqD3ClMRSKCLWstPNwMNbIgGnWIjbNUnf3UykaETbSqjpxZtnERd3SXcRfc/kUdohzaA6MSP0OBMcLwvOtvo5WwlXciH+b3G1VA2sDFRmZTTFZ2RSs230WKfxXL2VAj2F7ZUEhklYxJXeP/0wvyfXRj0oii9NeKXWPWoosItb/VYM/LDTrH3UVe4a+mOAd3qA4GFzJt2LWzOjzD8/M6jePN7I3DF+KD3CGPDqlLJ3z3i/QMdv0oo1P4Y5PxpTq45nbWXhmX3slUWq96Li+KXjkhMdC87AB2zTmACqBrJep4TRqAn4tEyDieOp0nhF5uNUEKG5cuVEFFizn3erCn3u9OTnOoRKR+YrlY8WlJLyue77i0ephk5ub0oJmY+y8fzuRxKn9XW9xeKeoZ6hcHqFpu0dTktIvKs75H/tUfSaD1v3pwy5hIBP7F2gEtgcqWimaG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HpdvJG+Yz/6VYsc+md5i0NQgYjF5L5hyfq8m8Ecv23lTZeZy24fd8ufZWaZx?=
 =?us-ascii?Q?6/7qEuIlMiNrQA//flLY3trAoiaQW4oFVkujTdv+U6Zy+N/F1mhDtWdhPuBu?=
 =?us-ascii?Q?BVZ3b5jetB/V1IQVnOtiOnhE3PtfpOtCA8jsJ1FUeq1HgbGdKzRpqAKql0vM?=
 =?us-ascii?Q?RjnySrM9i+8rtNJSzT9iElqAOnUMolWs1g5JKaVelwgaVXBYNOPkYzAVCaH/?=
 =?us-ascii?Q?Da0nkpuWYHtkbVxRGkzMIW6nq28za6a51G8PnM4NhXRXg51D18AEpXbqmzlK?=
 =?us-ascii?Q?IEI9ajg3cYyEZsXJd3IU3wZoeXBdgESSTzd6og3esmsVQOR8wX1QlrX6ckPX?=
 =?us-ascii?Q?JHnQks9vwiaPeUSF+3h68VZGdYwrddf3zAyAxZU3WzXQHbaqL3BUYbHsSlWB?=
 =?us-ascii?Q?ujpOdKGMQb0RWw8Qhn1xgBybgQV8QuRKAOn4wKG2/FdqtdxpyKplkfYz/sVZ?=
 =?us-ascii?Q?gxW/tCVZrzLt8eEQwxSEU2cgyoI53noWYcJA2NvD82wyKPVpyu5cD1nf4anF?=
 =?us-ascii?Q?m4Qo8r/BPDPNIJOIA3VLqXNM5f7/05LjZG9OyL/vrgwnoIicIc88KSWRlhRC?=
 =?us-ascii?Q?70AFlVuZuCKlGkkLrFWPwJEcrp8q3utQEpcxzVPWUiJOps7UoTtczHHLVH+H?=
 =?us-ascii?Q?4YoWhDB8NQn3PmcR2EldKaoPn4p2b/R13RcJFuA8akZD3FSMmSbduY39MSjI?=
 =?us-ascii?Q?jQ6yXqWp3Rx+z1ynZrHpC5MNziPhJdpUz3XKEC0ScANpybgbz/y7k85YGWjD?=
 =?us-ascii?Q?Y9VpwSTdK9or0Sntj6R7YOhHEND2Tw/F3EpsMX0viJ77Ntd0tytSVVfmBwPE?=
 =?us-ascii?Q?Q3RacjPLKduqOy081swk8ph7v/BnkAC//QU7upcE7TVjuU7gqpdLIRfhKI+B?=
 =?us-ascii?Q?ufPEuoH9ofEVxvYlirTJfzAlFNBJkYhjwz1ahS+wvclqi9TpAHQ+tW3+ACWo?=
 =?us-ascii?Q?ZCA3ojQ36EmGw0W2VPUbFxHXR6seuWMWKnc4zQSDANSp2XkVjkij3lrh/e3H?=
 =?us-ascii?Q?jxSWOWEAAvRT5is6ULUAh1UhLgJ7/1cy3tDQKRI2y/FmP7ygcl2Frwvw9X00?=
 =?us-ascii?Q?ga34JYd8wt5s9XD2h+n5JpCU6V0ar/1JdKV1P7sl6XSqkmY0Xr7n5zXBvwf/?=
 =?us-ascii?Q?1KGdu/Z3sjF+SnlWGrlNK26OZ/XHcGKlmI/qY2wivPazLXWkkKagCQeaFcho?=
 =?us-ascii?Q?I9lGHX6nwWa11YIUBAY2PxkzJEWLuUjoWtFtm6+X/nq+bAFiUpGBAP8wS7lr?=
 =?us-ascii?Q?rkv9kqOPk8EAV6PmEsnXljj8v4JwgEDc+Zu30AW7qOar4EP9xFjNscGYOhD/?=
 =?us-ascii?Q?6AFpPMuhvbX0Hm1BROfu4gBK5NqXtSLzHTzqFJYRQtt3PLbubaTm8FBJDk/x?=
 =?us-ascii?Q?hpK7CJoDzvlvotE2FcZmmlJhBPuT0vGf8E5/LILYS/Shap5rIkveL4dYW1dd?=
 =?us-ascii?Q?AQ/pw12UDczbjnN9V6gfB296+RMZHqrHb/eFldM5i3WY269M9IITkN61NtJL?=
 =?us-ascii?Q?EmpbKulKKRw+x0qcwCDi4vPJAZesmfraZHyr2TQ1hzDAofezdMgVnmZsOPh1?=
 =?us-ascii?Q?k1H24E0LCz+Qb7RradrOwpQpuHK0PVz9qN44OCCPXLzSV8VRnL/Vem2AJsei?=
 =?us-ascii?Q?yFQfXYpz7UeS1neNtMIfLPhnc5Qg5ajuvrgutxQSgDF5DtHo6zVrRga6uoWm?=
 =?us-ascii?Q?Bl4hmQ/eXkW/+0uJQ2LKRT99qen0tX7DE7YSln4dApNdS1Z1EP00kAPzElF9?=
 =?us-ascii?Q?FdbMbAV/eIB1JYt+hA/SKOwN8bUuGhulZbW5o0RLgANF5DVR2iIW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6938da49-423c-45be-f898-08dec6fe93ed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:43:04.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPAu8WgRtCiAvm99Xsv9hRHsPPMEbvEG13BuBwClkFttVU48XtMhZ5taJGsrX/So6oydM50TEQa2sifWiKiJt4kjT/S4U8lM2pkZvxstn99+z4bHQwZS9nq8JSZo99i8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8979
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11406-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:from_mime,SMW015318:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7778B66A7CE

On Tue, Jun 09, 2026 at 11:57:37PM -0700, Rosen Penev wrote:
> Replace dma_alloc_wc with dmam_alloc_attrs and request_irq
> with devm_request_irq. This eliminates the need for
> manual cleanup of the dma pool and irq in both the channel
> remove function and the channel add error labels, removing
> the err_free_irq and err_free_dma labels entirely.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

I already said many times, tag should dmaengine, not dma, all functional
need (), please respect reviewer's time.

Frank

>  drivers/dma/mv_xor.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 3fc39cca7cbd..2ac7f01155fe 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1013,8 +1013,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
>
>  	dma_async_device_unregister(&mv_chan->dmadev);
>
> -	dma_free_wc(dev, MV_XOR_POOL_SIZE,
> -			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
>  	dma_unmap_single(dev, mv_chan->dummy_src_addr,
>  			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
>  	dma_unmap_single(dev, mv_chan->dummy_dst_addr,
> @@ -1025,8 +1023,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
>  		list_del(&chan->device_node);
>  	}
>
> -	free_irq(mv_chan->irq, mv_chan);
> -
>  	return 0;
>  }
>
> @@ -1077,8 +1073,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  	 * requires that we explicitly flush the writes
>  	 */
>  	mv_chan->dma_desc_pool_virt =
> -	  dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
> -		       GFP_KERNEL);
> +	  dmam_alloc_attrs(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
> +			   GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
>  	if (!mv_chan->dma_desc_pool_virt) {
>  		ret = -ENOMEM;
>  		goto err_unmap_dst;
> @@ -1112,10 +1108,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  	/* clear errors before enabling interrupts */
>  	mv_chan_clear_err_status(mv_chan);
>
> -	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
> +	ret = devm_request_irq(&pdev->dev, mv_chan->irq, mv_xor_interrupt_handler,
>  			  0, dev_name(&pdev->dev), mv_chan);
>  	if (ret)
> -		goto err_free_dma;
> +		goto err_unmap_dst;
>
>  	mv_chan_unmask_interrupts(mv_chan);
>
> @@ -1138,14 +1134,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  		ret = mv_chan_memcpy_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_unmap_dst;
>  	}
>
>  	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
>  		ret = mv_chan_xor_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_unmap_dst;
>  	}
>
>  	dev_info(&pdev->dev, "Marvell XOR (%s): ( %s%s%s)\n",
> @@ -1156,15 +1152,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>
>  	ret = dma_async_device_register(dma_dev);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_unmap_dst;
>
>  	return mv_chan;
>
> -err_free_irq:
> -	free_irq(mv_chan->irq, mv_chan);
> -err_free_dma:
> -	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
> -			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
>  err_unmap_dst:
>  	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
>  			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
> --
> 2.54.0
>

