Return-Path: <dmaengine+bounces-10300-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMWmJ5QqAmp0ogEAu9opvQ
	(envelope-from <dmaengine+bounces-10300-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:14:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 064EF514E4C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D19301F4B6
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ECF4C9579;
	Mon, 11 May 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZ7WriL+"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F74C0428;
	Mon, 11 May 2026 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526839; cv=fail; b=LcCPiBzRxro/nFk2nylIWL0JMd8k3A9XR8k33Po90Zm4ZJw2tXkXCJzuUta/OcXX9IhlEcU5vU08jCcPmNLPgkMeCNiuUnrF8r1zNwwRD/N19bYNtJLF0oeMANsvlDCfzJ2KNRBalZmK0Mi2tiJFI0eeTdk1H+lXtF0ZOx+f/yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526839; c=relaxed/simple;
	bh=i6xfDWyaShJAoHlCIg7pmQVTBOs/ZvQNnivuY/jV2ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ounfKeQYghglCzhFUrVKtWQI6v4yXWXVKjYw75KPZHifBBFQ9UO7h0AA7pnhCasQPWRP5FF2PCOCIN0tBrLnM/b/rHI5LVbys5B0iHGiPq59ibRKJjU76RqxPvIw74uWoJ6WnrjIXv3yEuG8Ri2TZZdsWY36iCG0PqPsBcbdbJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZ7WriL+ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8Qv/Eq406fFviPvnkm0Pe5OnAyLgd0x6Y46H5tr0IYcv70e324aaeQwa0GGSR1lWPIW8JDzaR7QSrfgqwNiqaYUVleYzOh2CcF6L1P1TXKHB61lYcPIVKfutIcl/8D3mnh7BAWqXxxnkPCYq9GJF5yNGGdyV2vU9w7UlIOb/m+3DnYqQoSW1/+xaV7n861RFyVHLhneljSp932UZ5GuAgExjxy9E851uAWP4z0FfIoIaWKzmW6T/4c5Ux4WepXTR131atZqwDwsQi404PepYfClF4Ltql6bjCezQLr99Lq+E7sbRsm7QnJuYhL0HwKLz9sRFRB/QRU5h/lG8mvYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJRAreoAgF87+4L3c6T5znXmSF5TAsHPntO8RCbe+RM=;
 b=pSU5GPpqWBl0nSdK2GdY7PiNmzhi8/w8HaW6NX+JLDVFmnXN4+L6dUQKumuDFZ3otAaNHpPr11eQ3kywHAMYtiO2xKLIQBydDDOFj/W8R7WWjeFjmZjKN7ginEoP+5ObSUI6L8DBQQ56AH6c2vG5/I7nKYqrKp5PVJ6f2SQxHTWKCm9eHT/2BnI/zqvw1U5tFqmuAIZXZQZ2GVnGCcsGmKppGib54aYLsYFl76HjBrfHbRzqp1sG7O0j9fwwDeJA5iamfH0fcSwNLx64ocfu2PVXMChpWOqK+rB8Jq4V5CEPtEGutfgcjnN/2xf7Fm12jk/y+kVR0GMBmhMWdeYWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJRAreoAgF87+4L3c6T5znXmSF5TAsHPntO8RCbe+RM=;
 b=VZ7WriL+2myFFTyCmDHgiaVy2rFRyWpap9tzx+aVaOFw3CWGW1Ja7RxN6VBHOr3WwtvCRgtBzDwMJS4HKZJDGPcFghPLV3q+zbfiQiMY6HR+1naMj//fEPsOVJROgoCExOjVZqHyRfqbOpMo2bgZ67bYF0c4N+oo//7qNLDTfZl86MjD9jLYqVEQ3z0uM13u0rmECoZg6CwJrA5tT4yjJ6PBCfX+shxIrkv6pBW/fa52yFT0WxNI7gNufMxnkAwhxfWpRmGklXlZ/JQ5D0TfcTi21KJAf6Aiuuy/R9vpevk/VJn+ayOcpJgf8iSjgmO8juT1S2kQVcQOfSdTrP//8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 19:13:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:13:54 +0000
Date: Mon, 11 May 2026 15:13:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Message-ID: <agIqa4iQAXg_GHhu@lizhi-Precision-Tower-5810>
References: <20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com>
 <20260511-fsl-edma-dyn-sg-v3-1-98a181775dae@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511-fsl-edma-dyn-sg-v3-1-98a181775dae@bootlin.com>
X-ClientProxiedBy: PH7PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:510:23d::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS4PR04MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 561db272-731e-47e3-0d60-08deaf91716f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kFsJFgFLDpP9HVIfqPcrJUDv3U03FujTTDSQZSR2oAXJyfmxpe19/5ZL3viWCv5yE+ZwZTCqsU0llDS3/yzN5/Mc7cs2e89HxgYO0/IOTl9MyI02/gWC2CdguZ1NmvY/ZFbalyRdIe91EkbJZqQYAEMPieoYgxpNsltIqcw6xuqxjhv50/CQdHO76GXVY5GS2qN26TzQR5HGhjypcPZRFeOsPZdCN8c5OmoGUhSD1EIuGCCkAIv4FRetAPzUEBLkxTY7lHAwUGDv6veJwxBCi9nNxOEEHbzMHoZ4HlwX4ydqBsV3GyCotjy3kpiLAFdz/VsBcWYsDmvirz1RW6UMgYtfQ7WVaGrQ0JmREATyiI9I1/CKKAOVaPlom5b/Ta7kri3QjKDEERaKeLeT92RFQHXiMPMJ8lFbr3DdqyQhoFLCbPy5nOmt1K8h48WJrUBcAlmXzoemRaqu7rMtMH0f+Oyw+wMU2Jmw2eufhXLWh2IX48s01Ppubey8kRjxd7XCJzP0MOYaHlvESAN9/FlCpGwPDb/JQs/X8DFrXbiUh3+pSDw4QAA23LPbQgQhKPnSry+9Z8LDPrn/IMCWrN87FjZeK0HDDonFJcuJP62nzVKwrrmyPRLyGX4HA7idEl27kCjdv5Y5lYEEuWY218H69kkmhfSQRIetRVqNOf2NkklM/GfqyCt4pTvDGeB2Kyg4UBhjOpvzjVeyCkCQuNnDxG0IrnBF53UIbwNTTp94tiNFd3xGCA/WG1XEyAMzVA/9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?FwgyhtNajPsGjzW4FzLZxHEFgpbo1shAlrfP9idKHjNOd6g9pXYHWFS67d?=
 =?iso-8859-1?Q?qbNTYgrjm+G0vWMbyQi0o+88PHG+rzmMxrJbrmch35eChTiLuT3w6BNUwC?=
 =?iso-8859-1?Q?4yiQ1LaZvJf6jodSTOMsGT53b6B+IX7jwhkUwLab/paqBOccFXjhYWGBlX?=
 =?iso-8859-1?Q?PhFagUpH77PsOW6lfeDmqsx7jk4+UinLrdY8Q3nR0ZRTFRWn6sPS3FRQSa?=
 =?iso-8859-1?Q?eNR99fdaN5ovCS0hfODa6w07wckIkD2rmb01SMW7gLKsoPPJ3RO0YJaQzC?=
 =?iso-8859-1?Q?09SWun+HZ1I+Yp23to7100fmi/9Gw6K6hZLE99xmbkwDHMq9vk3GI90RCl?=
 =?iso-8859-1?Q?tD1Gm4ANEANt62fSCoh4Anr17aob/g+/7ppq4Q7Gm9zmKJ7OVZcG/SNPAG?=
 =?iso-8859-1?Q?4icikDPf9xqDHg9bct5Oa2RJX0lkJKMj4tqBx0AFL+NnVQrl16Wm3ylqaV?=
 =?iso-8859-1?Q?LfRlZIxxpHJBaOT3NLWA7cGoSqd0Ihb9WqoMTGb9+GPYBLDGbDsW20wuL1?=
 =?iso-8859-1?Q?05YCvL6TkE6aeehtJbnTr+6znhHNz2shFreQSHxH38ctJJ+r8fp0GEyg1y?=
 =?iso-8859-1?Q?o31O6GsFQHljJoGvjTxQmQeJsMEKpMhcOJkqSFNm4QsMpySzCkSUPb9n0d?=
 =?iso-8859-1?Q?2QjY296ixVv6HCUrby18PUAxbeWpVfJA96CdnBSiqipyqkKAHzAHgx82Q/?=
 =?iso-8859-1?Q?1Ufm2HvqMlGXiP4aEEs2w3Lex9NLceJJW3WtaQx4EJHDikw/YrSN6MCBo9?=
 =?iso-8859-1?Q?Dlj/B/reKFXg9NlyykIVUr9Y2TVvVwYQ04U1m4+IZBBSsIW9Dm0LMQgYjx?=
 =?iso-8859-1?Q?aNy0KziATEvyGhhXMRkizIxHwISAb5bDWUNHmR4cmL9bTL2mS7S7Z9Iz8g?=
 =?iso-8859-1?Q?ovar4GzsCz+NbImwB7CtAJg3UG1oOO3D6Qo7Ksuyf91VUfcFYjd9ZIcmme?=
 =?iso-8859-1?Q?k8Ac1e6nMvl0cJoedgqj4XsaJBajLjxPSgMvsKZf5ws4CJmAL13yq39OA4?=
 =?iso-8859-1?Q?zdKFafOn2560F50NZAkGZLEnb28pMKBOhsGAbjaDSPbpJnYgPhJBs5PrSR?=
 =?iso-8859-1?Q?3lpqoGMBWYwCGhKA3sJ2DYdNrUrxNJzEOUKgvFJ7kbUchjlvQV81uir5yR?=
 =?iso-8859-1?Q?bAEuRabEeHHFHZUJcuQ17yd39ddHZ9Qv8rQrwDklwa9FqF5XowRkf0t+9e?=
 =?iso-8859-1?Q?ao0Pi9ez1Wd01gl9Iy+fdGHpaRMxQBpGZTXoJUUZkNuQKqTIPnhkYdOyGL?=
 =?iso-8859-1?Q?ebLoZ6W4r2/BELaSnzNqtij9qX4RnOzss3TTEo2RrnIASkJbOGu6OWg3uN?=
 =?iso-8859-1?Q?cHBu/EEJTKN7bKCjPtuWn1n99vLluNYjA6xCz2Mh5cxIoQtR9sxh7XqKMH?=
 =?iso-8859-1?Q?b+5tytiBfp33S39A9VzeSkIk3U65hFlEIOqwi6kWXHvXo8QAFSf1/Qh+Bk?=
 =?iso-8859-1?Q?hPs9yg52BziauRyl51XSNABLcQ7zx1t9t1vvgaAmArRVcA2pk3iyWTPiCg?=
 =?iso-8859-1?Q?6FATHh6mugdDC7xAduj27KRkiXW8F/3v4H9skGwYbi4BT+kQdRp3Dawv5y?=
 =?iso-8859-1?Q?9ga3TncCiDJnZrCltFeDwBWjxinhaSkLe8Zd6o1ACII90cIOOSqMAkuK72?=
 =?iso-8859-1?Q?B0G9mk3dUklKLDCBrzQ4D9ZSx1kDCIwB/tvAPBTUosS3dHZswxEAUP5pEU?=
 =?iso-8859-1?Q?a3rbXeOp1V8f16s/elNcgv2vs8NNL4ekEfujXqYa6e81gmirTcperRmCdc?=
 =?iso-8859-1?Q?0mNSSKpp+LLwh4Rv4hpGXJwMgZ3sk6A9XJflgcBux4Bg9K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561db272-731e-47e3-0d60-08deaf91716f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:13:54.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+1g43wrZzZhLvXbglM/MzBrBSv51KEuB+gQBSf/ca1Mfueu7zrug5SBVcUkhr0t1fe1pcUWsY721nGL5/KIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552
X-Rspamd-Queue-Id: 064EF514E4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10300-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,bootlin.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:57:19PM +0200, Benoît Monin wrote:
> Add implementation of .device_prep_peripheral_dma_vec() callback to setup
> a scatter/gather DMA transfer from an array of dma_vec structures. Setup
> a cyclic transfer if the DMA_PREP_REPEAT flag is set.
>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 109 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/fsl-edma-common.h |   4 ++
>  drivers/dma/fsl-edma-main.c   |   2 +
>  3 files changed, 115 insertions(+)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb7531c456df..c10190164926 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -673,6 +673,115 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> +struct dma_async_tx_descriptor *
> +fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *vecs,
> +				 size_t nb, enum dma_transfer_direction direction,
> +				 unsigned long flags)
> +{
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	dma_addr_t src_addr, dst_addr, last_sg;
> +	struct fsl_edma_desc *fsl_desc;
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
> +		nbytes = fsl_chan->cfg.dst_addr_width * fsl_chan->cfg.dst_maxburst;
> +	} else {
> +		if (!fsl_chan->cfg.dst_addr_width)
> +			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
> +		fsl_chan->attr =
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
> +		nbytes = fsl_chan->cfg.src_addr_width * fsl_chan->cfg.src_maxburst;
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
> +
> +		iter = vecs[i].len / nbytes;
> +		if (i < nb - 1) {
> +			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
> +			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
> +					  dst_addr, fsl_chan->attr, soff,
> +					  nbytes, 0, iter, iter, doff, last_sg,
> +					  false, false, true);
> +		} else {
> +			if (fsl_desc->iscyclic) {
> +				last_sg = fsl_desc->tcd[0].ptcd;
> +				fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
> +						  dst_addr, fsl_chan->attr, soff,
> +						  nbytes, 0, iter, iter, doff, last_sg,
> +						  true, false, true);
> +			} else {
> +				last_sg = 0;
> +				fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
> +						  dst_addr, fsl_chan->attr, soff,
> +						  nbytes, 0, iter, iter, doff, last_sg,
> +						  true, true, false);
> +			}
> +		}
> +	}
> +
> +	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +}
> +
>  struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 205a96489094..0d028048701d 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -496,6 +496,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
>  		size_t period_len, enum dma_transfer_direction direction,
>  		unsigned long flags);
> +struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
> +		struct dma_chan *chan, const struct dma_vec *vecs,
> +		size_t nb, enum dma_transfer_direction direction,
> +		unsigned long flags);
>  struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 36155ab1602a..6693b4270a1a 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -841,6 +841,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	fsl_edma->dma_dev.device_free_chan_resources
>  		= fsl_edma_free_chan_resources;
>  	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
> +	fsl_edma->dma_dev.device_prep_peripheral_dma_vec
> +		= fsl_edma_prep_peripheral_dma_vec;
>  	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
>  	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
>  	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
>
> --
> 2.54.0
>

