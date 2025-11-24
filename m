Return-Path: <dmaengine+bounces-7330-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B63C8173C
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 054B9346354
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F5314A8E;
	Mon, 24 Nov 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HQrNTVlY"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61188314A91;
	Mon, 24 Nov 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999882; cv=fail; b=V6P4vKZ/oobxaADWcW/pmx9oEEgoqStKCH80kPefzEkSQPRh3R3wdhjjMdjIm8bXfgGm5O+ZrsQ/7LMOQ5kMpEbiY9Np4tfg8gUvv3yN+0u1PPYGMoeFejyVoA9jrAtd/o51tU3XaBMtSlAkiVU8BI1D0D71ffk1xxuhmJ8BW2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999882; c=relaxed/simple;
	bh=tGV2SNVTwQbZoHYcWrrBJata9bkeFDPNVqJqi4QeCBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WjdGJOq6tZY61YhN7CsYV+SXXuCgfW/hIRSDYKX0oEs7Ok+eHFIjPpbqwp7CkoGc7BhkHj+CiDuH/Hm/kwnAmsRD6Z3sQv1ROGw4cPH4OHizdSmHEGVlgSyfy2bjGRPZyCFi+dt+A0+dp65nRMjrrMxoOlvOZIdxbWwUf+ZNkPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HQrNTVlY; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAOfR0iLZb70E54Hm7QssZjiHyAcXxvpjtBcA5CCafk8LbVh06uSC2IhzguLh43eaqfjFHXwt4eVAzm7IORCilPPaPlyBvpFD9b/v5pm4+PFKCpAQIzHBV4UI8Nb4UFebI4mQK2Q3U/M4aeSYS+56MGVL8K3NzHgdFlHp694UzxXHrD4eV7HmwLttvvoHJ6dM0+XqmSGUo+t3PnxjXOxu9Tphu2RCP+9nUBgOazL6QwDP0Z+lu2FpoNsHJJheSZQp4tAL1XDAjiEJ5OS1RMyyz41gH16mC5VvcU6v1uPLGCQfMbr8Mc/7wa1Us6MVdcDu+a6sIlwbilb3vtFII4lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrMHcIjedmf7LN9qBmxfD1WQ29f1Glch7Y6rxvOcQYw=;
 b=b7a2X/YZ+MEYcKvOMYj97Q50IUWZva6ezQTTbatsU9UDWZocrxnBFl8V8yn32d3NCeXAhwBTvbAHbf/U07V0B1zmn/q+E13REhTc6K+0fQ6f8e1npS6h2eD/if0fha0WFqS42rumXL6TNLFJejHAOwkG5bx5eJEl+fOVMOu4uulwXxdbDe691q2iMzh4XJd+Qo4BfeViyKDSqNH2uy4/pxzPqqqXL1s1EN+bTs6X78aAnkaGutzIyCg68xNukUMZV/ePkPqgaldMUhX3PxXcNcojmmiW3bPgBJwKPWvEadDS4ap1GpB3bECu7DzhRU9GMssheJOI5vheuAevl9xPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrMHcIjedmf7LN9qBmxfD1WQ29f1Glch7Y6rxvOcQYw=;
 b=HQrNTVlY2nbUrhUjlLZbGmAtShKjctMIt2/TBeQkGoOCQiKMnQvslaFlzjZn5JquggR3gXpxQlpaLoIdUULtJRF1hfs2VnqqjbYw3ZuOyNhraGmhbFkOkCbZGhVKesoW87xcANKdYVnDrADGQ0YGQbxP33l38OMb/6aDOE6OJc2AhKpNBGjI4CR4+VIZrR5QdTm8OSgXQB92wkGDNxAF8t4OxAaZ/gfZ24Yb2u/hWY91rgjkZ4emeH+/0/Tok0UrpLyy+1+UBVT8ND4fMk/3MDAT+AHmhJf5X6wSRZfuit7rKR70RJ1/b/JrHBHihvEKpNe2eFgtztQsvF5ze3nW2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:57:56 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 15:57:56 +0000
Date: Mon, 24 Nov 2025 10:57:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dma: fsl-edma: Add write barrier after TCD
 descriptor fill
Message-ID: <aSSAfW9xLTRN5Fwk@lizhi-Precision-Tower-5810>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
 <20251124-dma-coldfire-v1-1-dc8f93185464@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-1-dc8f93185464@yoseli.org>
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 852ebb43-d545-4662-22e6-08de2b723bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nYzPIkuEvKsKJo7qVQS45ZlEsum2RahOiOvHiOiyjIyRwDBza6FTzS6ec89M?=
 =?us-ascii?Q?3CKJngAQu+1bGMCniXkAxRgP0JzFLbwinOFkRPFCEtnSg34iLn+kqN3/Yb2S?=
 =?us-ascii?Q?8Y3WEK2PHKbHR3W8LqFGIFQAXYdXIax0Dwt65wRjUP/5adJG/38tcEl9+JZI?=
 =?us-ascii?Q?bogPuu8hq/+10y3j2bLC0RofM29hRewJauNNfXIEm1dx+Q+l1IBfqZzTDOXW?=
 =?us-ascii?Q?wuMUI13mDdJJ1MRDZ6R63iuKV6JB2uACj0FlUvibrQAbgZnPGWekD3ZCx5bQ?=
 =?us-ascii?Q?Kj0R/5kSNswhkMB3/9WDxwGfWHt2kvnWms7jiakz/Jid73OfTFXE+TRVOZv+?=
 =?us-ascii?Q?EMh+AmGGLp7Xp5nhZ4IrI1kunUeM2fBf4JUuzJYm1H96nuG2F3G48go4bTza?=
 =?us-ascii?Q?pUWg4LOMiuU2Gzrc2WW6lXImupmOFCKQ+NEIKFyqdXf42iJwEoBn57glk8WD?=
 =?us-ascii?Q?+nq99wTHJNvBdl8qnpBCXwMQc3sM9wkNjQTWS1j6rqd9DZdMcraZaHCYrTPF?=
 =?us-ascii?Q?wSGLtLURrzmciAxOGAfaT0UabPC5qEK70jO6gwxvkrHWl1PB46DHP+ygHbmG?=
 =?us-ascii?Q?IkmdDf5u7MfJpeyCuSUD5SvelG8RfE2Vg0lhNWWnIc/SnUzfKyqEJYqb/+xo?=
 =?us-ascii?Q?j/sFox6dNqLUtspEMCM9Vl3/j2Fv1QpNenlqHPduo2agCrCx6NGLZErAAcdq?=
 =?us-ascii?Q?INdE7EH+VOmkGCjUwB4eth/cb92C0G+eR3RfHlH1vjH1BnQRan37WL3Uf455?=
 =?us-ascii?Q?+XSKeX9qXYkOCakcB0qdq2wKmW4CnxtLYCDX1U71G9hnnRiWTVjxO+A5Dahr?=
 =?us-ascii?Q?pbbjMwScMzbhuyXczLVRxeMhcTaY8dmt7GYYXDRz59lLbAmbsY5c7nxsEAe8?=
 =?us-ascii?Q?72NGfTARLRR87DRmUUMFTXsci2KNCO4zAuMLWfB6ScajhpCO5+3G2mfarWt/?=
 =?us-ascii?Q?3R+KND2WODSCv5+fkJE3KoK8XpnVwDx5nRU0isMJ94hC8NCRt213sfOyJibl?=
 =?us-ascii?Q?qU5K6EHh+uhXSpmjS4eP6JUudcejnJLpV1Gtgf15MYE/6M86YoMNxc7DY6c/?=
 =?us-ascii?Q?P7UXXCMCx/E36kh0MK6cJf9GyfT0DH4649EeHWlJAdHRDWpxMbMKI2B7SkDG?=
 =?us-ascii?Q?b1XCkhqJbDVo3NmOrguJI2DNIyhfOtg4mbE0G9DQTm3I4JOSWmncQ64Jjx1j?=
 =?us-ascii?Q?HqZIOyIBBqVW2Ab482YZuUvYKFjfmjjCDcp+swsj9v3nr9VxsYd29c3JQ5PS?=
 =?us-ascii?Q?94/iepbqMYtJ+q9dTd6zkE/eIk1Dqe2TsLmQDzI3R9D4TpoLVeqbM0pHVcIo?=
 =?us-ascii?Q?2i8KAcY1t5dRQcV58dkwpy7jqPauvmz5z1CnvOKUbeM75pv2dFKzVId2atVN?=
 =?us-ascii?Q?6EmG909h0oSeu8iynT7IAmETHA2wq96SHEXfSR1FQfDK5DixEWcV7/9jhCnp?=
 =?us-ascii?Q?UaYzP2FRZv3KVO9wp+N+10eiLqREKWlSEbBv9AepEA3m5j1GI2/4s1by7H5W?=
 =?us-ascii?Q?eDJ/4BenRmi0BwpKmwNyVSumqBgHXbIgvmcV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDjnmJ5W6vagkUUHzRlgXGIJrGYH7ApMQzkuFpkjFNkd2D8U5d3jfuZhTLnU?=
 =?us-ascii?Q?3GAKDBRFBYG3r/gMEz7mt2pbtgOjkSNC/9KB7Ndnd+oe1Iwaj6pIhrKs3RNs?=
 =?us-ascii?Q?pkP2DQol4eXgmQi6SSlqHs0c73Ct08/cQe9pnPC0weu4ZGJciTzJMmW1qPx2?=
 =?us-ascii?Q?YqjBRzKtMcCKoPJXiz7XF2Ehr3O0t/qmRojSn0AC2/aov+9CIIIuEQOBMAq/?=
 =?us-ascii?Q?esh+XMqTRnRtLCZOPSYebr6+dtwH1NAoEDwpaNoRcGhrk6p+fbCPQyf+oBor?=
 =?us-ascii?Q?x2xWGZOsIkc/OhEg47zn+0HTtMWEfzOMv4ECr0Ihn8ub+/e8rKweJzu5TYw9?=
 =?us-ascii?Q?XFaDkks9wvgRi1p47QUhgpWrmeE10oC1EbUlVt3wmJ74Dq+FW0ipqE6wOyIa?=
 =?us-ascii?Q?tNBSEAhMdw2tRowXpmI3dFM+dzLTQYnTI2CiQVTf1QVx3aIUWdV/gn+0utJH?=
 =?us-ascii?Q?F85+BOPAa1i3cPSO9umNxBnKpOiyB5WLzgYqQzz8ho6SUjHQXPzYZRAWh0dy?=
 =?us-ascii?Q?Fw4vXsqWXZfoLi8TWArXQLgWKjCbHvz3tYr/CHJ4w3a187G8hpsAKvaslWLD?=
 =?us-ascii?Q?ujUOANjx+MQWdxi8N9r7nz0Ss9CwpoaG7bw8Ifzfxkv3EwgZLWJmsFcGPvSn?=
 =?us-ascii?Q?AGbvboO9tDapKmFgyEHLUyLBmLQM9Z4mbR8X/l+qG8Vl9aQ83F+6NY5YCa+C?=
 =?us-ascii?Q?bQsE6G6SlgJomBLbLgA/XL4ZAfg010AcjJ5xEDHX89LzaqY2eCH1z6pQbsK9?=
 =?us-ascii?Q?/V2ve/Ddp/AKEhnOY7OYPluegOWcE3fIQZAL4jzd6aGgwJWrPOShinSivmMo?=
 =?us-ascii?Q?0NmN6t3+xC/MVpGcm55mWT8W4Uw+5trnSAqSxfbKCJXoO2ZH68oK2sPzMJAc?=
 =?us-ascii?Q?4tz7uvsRBEJnDabfaabJEuJ9hvDWfub4j337nxLuP/s40MPkpjV56OG/9pq7?=
 =?us-ascii?Q?1xzzYYoa59ueE3DvdYVp6xH7u87ofjC2HY88f7qZgcUrqg7ZbCfqazkkUffh?=
 =?us-ascii?Q?8hNxDKaMRiYvBNbQA7JLQOCHiRljr+4aRuhj5c+0D+K3krSqfDduOEwdZNp2?=
 =?us-ascii?Q?w3fsWLRi8egGaQPy5A3hKnG88/oBT3vS4qezHMohX6Qyj8elj1nDp35WtMFz?=
 =?us-ascii?Q?Hk4cWOt0KM38lMay8IAznzw0PTi8zxKdPBEFQrDNryq7+81jfTRQj8goJjyg?=
 =?us-ascii?Q?jli/Z0S2siAT9soy9MTjLMUEATgFhGFyJRQJVjrv4G3KogNqaYBao7vlr38m?=
 =?us-ascii?Q?RTBUI1scZ+fJtZxVVCBTdBS9uPqIqjylWUze1Vw4gtBvJLR3r7rFVWN+6X5c?=
 =?us-ascii?Q?5/D2GBtOt/wQ+g7PZf2Mc+AEusi06G9QsphtMvnFMmzox1Tt6lprKUx1n824?=
 =?us-ascii?Q?/RE2kv6V869UDPjmXuo10pRDl85W7k41CTQRhtfMvEf2znoc2zfIszm481rQ?=
 =?us-ascii?Q?FPX/k4ez/1YA9DNNVsMWqIW2nkwdy5Z+zMOG8YQmy7Bs36jY19rXZ3BI8/+3?=
 =?us-ascii?Q?4mWBN9RgpwO6hLIGeMTNY/uGhqdmTAJDAoxHjfQTZCXyWQ/88dnU9qo/gVaO?=
 =?us-ascii?Q?t6Of6aTtFO5yM7dA3+Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ebb43-d545-4662-22e6-08de2b723bd8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:57:56.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCvQNFlU6e83vEWq+AM4T/UuHZCh4Vhp1HUzvMcVEn25McOYYcOSh2cJ4OnEzPuQxxU4OepVK9h9tuqri0/aVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761

On Mon, Nov 24, 2025 at 01:50:22PM +0100, Jean-Michel Hautbois wrote:
> Add dma_wmb() barrier after filling TCD descriptors to ensure all
> descriptor writes are visible to the DMA engine before starting
> transfers. This prevents potential race conditions where the DMA
> hardware might read partially written descriptors.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/dma/fsl-edma-common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 4976d7dde08090d16277af4b9f784b9745485320..db36a6aafc910364d75ce6c5d334fd19d2120b6b 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -553,6 +553,9 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
>  	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
>
>  	trace_edma_fill_tcd(fsl_chan, tcd);
> +
> +	/* Ensure descriptor writes are visible to DMA engine */
> +	dma_wmb();

This is not necessary because there are writel() in
fsl_edma_issue_pending(), which will do memory barrier in writel().

currently, edma use vchan, descriptior have not dymantically to appending
to running queue. so writel() in fsl_edma_issue_pending() is enough.

Even though edma will support append to running queue in future, dma_wmd()
should be just before update csr.

 	dma_wmb();  // just before indicate TCD is ready to use.
	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);

Frank
>  }
>
>  static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
>
> --
> 2.39.5
>

