Return-Path: <dmaengine+bounces-11176-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EnsxBbf1IWr0QwEAu9opvQ
	(envelope-from <dmaengine+bounces-11176-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 00:01:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99977643B9D
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 00:01:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=nxp.com header.s=selector1 header.b=BnaP9hJ1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11176-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11176-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06BD63003363
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8A72617;
	Thu,  4 Jun 2026 22:01:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A230D3E5;
	Thu,  4 Jun 2026 22:01:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610484; cv=fail; b=UJcmduh6Ub0nIbnLWZGP9XC4WE405dRz60Yb6IDiZkPrZnj/fRP7dsxdbzcMwXEi2D0Af94prHKveIj3yEwJbByjmb2qGfycXvaednJUEbJBQiicPFElnAd5qqFCi/Cozm5dNvf9bQZazM1cVCYhC606aMZQ8hCCM/A+9l61VPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610484; c=relaxed/simple;
	bh=01vqkYvVdTGy8h4UPdojWR7qCJ7hSpgfD29kTzC988Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKo566WZnSw8mny+6sQVPLR/yRMDXBE5VCMk/Fbqd8snkyJ1XudRKDoOqE64McDBsIEhTajgkBLD2d6V2A7RMMAnVXqO/PvKyaje7w6UDvrGIOI3JHE9vZm7rWl+rvEZYF67ea7fIYhPVQtGzoDLJAVRMOG0mXF8jUcJCF3dKQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BnaP9hJ1 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frpQZuX4xBXPRyZJ7yJw3fD8kcnbiGN0nue7CgE7Ws9GjAksfIXugzpFfTiYMoXTslLaBSgxR8PHJdMblA/AyKsBuIxAkLd4AISybhpUDbT+8YpT4e7Tte6scflV3WHZ3/W+PugvFr8cfi1yhfOqis4Fmi5sPYnIMc7EWEkfSPfM+J+GcWiYWK6w/iDgU3/toQRk8PrRZ7gNB734y10I++3K8Bo73JmI/bP5moVUqele4USFTwl5MKwv71snKBVI22LhVYLL2NvBbvQ3vJcBWZugdhwlCsRSH2L8P9DhCcAMDYOlg2a3VBC4cAnucjTDfhzEkHYg7wCkZZnwKpaYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g7IJTGYBZ9HnnMESvAK7RzkcaHyDgHJB7W/GWWbpbs=;
 b=hODdcvlFkqWM8OjvUTE78xgxce6YUo7ckTvlmFFZUthGVxKs6GTGmU7PxJD7y2aADPE888WNN8xRdj3r+iM+4iXEOqYWKiEVf2adsVPRV216+RaL25qGEOgFQMkUo1uoo46Q0+CHqZslFJWVC5hqoPubl242sfCrfMu0fomVAyYCgX5h9RAhRXlGskP0MQWgHxTtQyxrRWZxhSJdLMg8Nmws5ewBwiUo6rjBSywP7tb3pW1iBtYiwbFghVS15QD8UWDaOapCocnHatnmE1U/vB/S0SufnyZim/MqFB0F2IEntd8voSQFtcUfksPL9kKO1x1arMRebJoabxc04J1XFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g7IJTGYBZ9HnnMESvAK7RzkcaHyDgHJB7W/GWWbpbs=;
 b=BnaP9hJ1bnEsbUr8WPiy06OWkSibeFD5L7AIg4HYiF0Wkr7DQvPcOT2e+J5QS2DR+6ybQzB8uUCcHgtq6iINlHSjkQaS3r3xbNQqXvo7AD947Bi3AfcwH6/1gFatC4I5V8l36ftxTwrfKSN7MH5j3jYbbMxzBOGEUxDPqILW3JQzCYOgHu2z/tx69uWBzBHlSqNLWYb410CgJcA8pmZOL5UPgGJh+Ec/LaXLZ1ypcmXkphde8HFcmKlKUKyGT6NKD0AqoYqyyM4/BDk9E05RaZOA4pvIsOMTBKnXGSqFBvhY5Yj1R8YDuhnK6A98kzBO65o+pGEQ1xqpx1lW2pYcdQ==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 22:01:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 22:01:18 +0000
Date: Thu, 4 Jun 2026 18:01:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <aiH1qDT5yoanBE_2@lizhi-Precision-Tower-5810>
References: <20260518-fsl-edma-dyn-sg-v4-0-8ce7d95b1ce9@bootlin.com>
 <20260518-fsl-edma-dyn-sg-v4-2-8ce7d95b1ce9@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518-fsl-edma-dyn-sg-v4-2-8ce7d95b1ce9@bootlin.com>
X-ClientProxiedBy: SA0PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:806:d0::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 011ed8bf-f12a-4a84-d713-08dec284ce57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|1800799024|366016|376014|38350700014|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZYMXjHsNtoQIrzK2UWUzy4TKxaLG9NU5NjkzancyD8IRj30OHVtpwo+KNw/cbW1NqEjrocc7UMWvUfL6iX3GJd/Ksr4BVIUPOfgE+mxdKikB9VRnxk48Ilbls+2Eztf3qQo+p40cGQg9o+eDQACrpu/YK5DRLyYJgkJYKpIZp6lj+ey73PSjD9IEkBHqqA0mG4Zxq232elwVHo82mBw7sD/VGE+uTfSrj4ZVS08nhnfVvf2EhDPHFFlZRdcnOO6d6onUZCgFlIgt8H5te74TdcugOBbUB8mKxdV65yQFWDCYjXtK5Wr7Wk98jTUhcR2BwNhsScHrsHNSHYS1cmNk5+mCZcHUFSHj4WqqQidbWfVrO9Dz2UV0SJb553Hkim/XwMN5b2XeVYtAkkTqO2oV/i5OubbGsW24253w7CfT0BkPG0Gyv78g31NkfHZeDe2UompE3VK70QQSFNBDLkT2FyA5Wq3NaO6dxAre/9skcm64FyFnB+5YTnBhQDTZu9xAQVuI0blYwgXU5EtX861CD1N77vlVqwUblXwnfwfE4OSYt5H2GWbrLcV1KlwFl1PWpMYOFuXQCZfjn0kdcAQELDkdwBzZ4B2KPrwTzHc7PIpwoVoDkqoe6ss7snxQZ9YqWUfAIbVizDnz0oCkqAMBNXB3JyT93K2W0MX/lct5emJn+FmyeLmA4NlJbqxd1RhBJgIzqZHRZuJMXeZS0peo0YLUbh7B0i9jtWhOnd1ugo5NiZA3idZayi7Ln+g3EnAw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(1800799024)(366016)(376014)(38350700014)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AaYGILtE6qwcZOV1kXhnVsG5xt6pfJuoloxdwuh/Qj+ealEVbq3p7P55lV?=
 =?iso-8859-1?Q?VwrI1FQr087A+brcvs9D4m6Vd9I6VaxdULhK4Q2CfMaEefJavkQ/Tl88uC?=
 =?iso-8859-1?Q?3QVDE9edQI7Henr6TbqnCszcKmHGMI+ggf5tQah+FhZc39KP35wXbRywjp?=
 =?iso-8859-1?Q?LhM6txjSfelu65JHq9W2u6WgnfrixYqkmB1I6N6O52Imt6dy5PND6ftIkM?=
 =?iso-8859-1?Q?QU/iBYrZfxfeSnU1aLekWRdgGkCBhGF/VaOW32A5dNSc7iHgo3qmxS/tWB?=
 =?iso-8859-1?Q?Hyq+eWftpaauqhXdgCHde9cg2eWClxJxY4WAS11elGJaQV7hI4Ci91cAGq?=
 =?iso-8859-1?Q?Hijd6hJfpatmgExoFdjhS2/0YsU245pdne6yHdAjtqEMcmyIqa66EftLom?=
 =?iso-8859-1?Q?mxzvdBh7Gee+ESpi4FQry3dCp7/XJzyJhrgNYht3i4A8anTY91zWMfB9xd?=
 =?iso-8859-1?Q?6YyQkZUle9OZfBxkfpiXKZ0GLREXDsyHk1HHf2cKBUXtahDrxkOLg0GYuR?=
 =?iso-8859-1?Q?yVh0WIx+u1sCFdAsaF678XtuXgsLWbJpWE7Ll3YCgTfLdt+VE+ZW7E5jgh?=
 =?iso-8859-1?Q?z9q79jaSJCbIR0kvQr3dHiu939QFiiLqU7YMi0z9YOpHV/+riJKCr3ehzR?=
 =?iso-8859-1?Q?CC3764gO/zR7YGt4f6tsL+Y8KsHkUr0HIoC0xIku2CmrBcj3mSGo3fxSg2?=
 =?iso-8859-1?Q?1h4RZTne3u+a+RwNjNtg+gQbPGuK1hlCcczv7s3eJrhocRS/kheS1kobFk?=
 =?iso-8859-1?Q?yfDxO2HGJ7x/m5QYGW8b8peLAFB3mmlxlAKOlqR5+99W3/TElzLuxJHw4D?=
 =?iso-8859-1?Q?PtwwojSqDXlVG1W6apAMTsxZNYdvXXpYLLaQaILGVzvXG6YCr05BJkD8T1?=
 =?iso-8859-1?Q?F4/tt6Vo9TUcveM41xmI8xngOFXwhVOgfGFb6a3KewHl4HtHEHl6ziaylz?=
 =?iso-8859-1?Q?DXYvcx9VXw3hKPSDurFRoZNdHBetqpNoEQeML/Is3pI0y8+9FRlqG9oM4j?=
 =?iso-8859-1?Q?HZXGZ1t2tXYAPXqUf17Kah8+Za/ATV7OeghSTZTvAZrEkKLQLQpzCrG9NB?=
 =?iso-8859-1?Q?VXDOqtILdoUBPHa3vyd7IY+i1MvwWE9MQLch1iyrnv8JVjvQROhTQIeOm6?=
 =?iso-8859-1?Q?2Z4PVqxpJXzYpnZK/80SP0P/D87eE0nvvROcxAfS4/oeqoANR8VHeBRb51?=
 =?iso-8859-1?Q?px2BiTr5pzjg+P052tSlTyGlgRPuUhQDYXp3/8SIvaiM1fbakkzyg5H/FX?=
 =?iso-8859-1?Q?1Yq88dwBYEcPhBe7IjPfq/sCDSPbEBRxwDiaFqjq/4Gzvtqkjx5Jah9rhW?=
 =?iso-8859-1?Q?93vXc2+kgw5K1BRbVMBfY8px3m+oDR4r29+4vPKpn5XTQFzzZoYtXcyhjm?=
 =?iso-8859-1?Q?Dj3iPfjwx0Ok+ZrVquk1j0uDBfr+as+vEonQAica/4CrgLODczf4M8KlH7?=
 =?iso-8859-1?Q?olTY7qAm4aqCEKhPD1raN0l4b4pic0Dof0mtiXR/icRk/QqRXlYKTRHVQX?=
 =?iso-8859-1?Q?T/4cHjG7joBM7cgmCF9CgSc0G2oe3F4PkqCVYRXd8clezJKXr/3a9otXqQ?=
 =?iso-8859-1?Q?6WsmmaS4oFZZ/aLxnUGIYWYwlRsGFpwG0IyLTQ562Fer7B7J/z+pl4S8Oz?=
 =?iso-8859-1?Q?OYzFXD8DrR5DDTZVI6IZCmgpirnq2BAjtDbtCX7xP+fT3RCjqn+eH+dbPK?=
 =?iso-8859-1?Q?g/rnzKbpPDZjHZVXnPDKXeirxXFAy2nfJHTbtsE8xI93d4b1HS/Qw5NuIv?=
 =?iso-8859-1?Q?IkpNIq97ldy1JLPRYZomUlNaj2z8ZrS86tLzPTPZRX1zQAiT8VE6BEr1/S?=
 =?iso-8859-1?Q?uR5LVeztZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011ed8bf-f12a-4a84-d713-08dec284ce57
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 22:01:18.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwQpQKK+NAwRQUcZs8jXfugXzIAl867whtS3E5AKvyiIX0BS2MBjCWnn25SrNFISBAsI9Nh90cQTsZYmc5S5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11176-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:benoit.monin@bootlin.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99977643B9D

On Mon, May 18, 2026 at 02:36:45PM +0200, Benoît Monin wrote:
> Implement dynamic linking of scatter/gather transfers to enable
> chaining multiple DMA descriptors without stopping the channel.
> This avoids waiting for the channel to go idle if there is another
> transaction already issued.
>
> Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> submitted descriptor to the first TCD of a new descriptor by setting
> the scatter/gather address and the E_SG flag, and keeping the channel
> active by clearing the DREQ bit.
>
> Linking is done when the transaction is submitted by fsl_edma_tx_submit().
> To do so, the .tx_submit() callback is overridden for non-cyclic
> transactions prepared by fsl_edma_prep_peripheral_dma_vec() and
> fsl_edma_prep_slave_sg(). This ensures that transactions are linked
> in the order they are submitted.
>
> Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
> transfer is already in progress, allowing seamless chaining of descriptors.
>
> Modify the transfer completion handler to check the DONE flag in the
> channel CSR before marking the transfer complete. Since this flag is
> only available on SoC with the split registers layout, we only link
> transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.
>
> Add trace event for scatter/gather linking operations.
>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---
>  drivers/dma/fsl-edma-common.c | 90 +++++++++++++++++++++++++++++++++++++++----
>  drivers/dma/fsl-edma-trace.h  |  5 +++
>  2 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index c10190164926..6e5820051f29 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  		list_del(&fsl_chan->edesc->vdesc.node);
>  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
>  		fsl_chan->edesc = NULL;
> -		fsl_chan->status = DMA_COMPLETE;
> +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> +			fsl_chan->status = DMA_COMPLETE;
> +		}
>  	} else {
>  		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
>  	}
> @@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
> +{
> +	u32 flags = fsl_edma_drvflags(fsl_chan);
> +	struct fsl_edma_hw_tcd *last_tcd;
> +	struct fsl_edma_desc *prev_desc;
> +	struct virt_dma_desc *vdesc;
> +	u16 csr;
> +
> +	lockdep_assert_held(&fsl_chan->vchan.lock);
> +
> +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> +		return;
> +
> +	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> +					struct virt_dma_desc, node);
> +	if (!vdesc)
> +		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> +						struct virt_dma_desc, node);
> +	if (!vdesc)
> +		return;
> +
> +	prev_desc = to_fsl_edma_desc(vdesc);
> +	last_tcd = prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
> +
> +	csr = fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
> +	if (!(csr & EDMA_TCD_CSR_D_REQ))
> +		return;
> +
> +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dlast_sga);
> +
> +	csr &= ~EDMA_TCD_CSR_D_REQ;
> +	csr |= EDMA_TCD_CSR_E_SG;

suppose here need dma_wmb() to make sure dlast_sga happen before csr.

I remember ask dma risk condition problem, but I forget detail.

 TCD1
 TCD2
 TCD3 (last one),

If DMAengine already load TCD3 to register and moving data,

You update TCD3's dlast_sga? Does DMA engine fetch again TCD3 to get
updated dlast_sga?

Frank



> +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, csr, csr);
> +
> +	if (prev_desc == fsl_chan->edesc && prev_desc->n_tcds == 1) {
> +		if (flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)
> +			edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
> +
> +		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
> +		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
> +	}
> +
> +	trace_edma_link_sg(fsl_chan, last_tcd);
> +}
> +
> +static dma_cookie_t fsl_edma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct virt_dma_desc *vd = container_of(tx, struct virt_dma_desc, tx);
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(tx->chan);
> +	struct fsl_edma_desc *fsl_desc = to_fsl_edma_desc(vd);
> +	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
> +	dma_cookie_t cookie;
> +
> +	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
> +
> +	fsl_edma_link_sg(fsl_chan, fsl_desc);
> +	cookie = dma_cookie_assign(tx);
> +	list_move_tail(&vd->node, &vc->desc_submitted);
> +
> +	return cookie;
> +}
> +
>  struct dma_async_tx_descriptor *
>  fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *vecs,
>  				 size_t nb, enum dma_transfer_direction direction,
> @@ -680,6 +745,7 @@ fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *ve
>  {
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  	dma_addr_t src_addr, dst_addr, last_sg;
> +	struct dma_async_tx_descriptor *tx;
>  	struct fsl_edma_desc *fsl_desc;
>  	u16 soff, doff, iter;
>  	u32 nbytes;
> @@ -779,7 +845,10 @@ fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *ve
>  		}
>  	}
>
> -	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +	tx = vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +	if (!fsl_desc->iscyclic)
> +		tx->tx_submit = fsl_edma_tx_submit;
> +	return tx;
>  }
>
>  struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
> @@ -788,9 +857,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		unsigned long flags, void *context)
>  {
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	dma_addr_t src_addr, dst_addr, last_sg;
> +	struct dma_async_tx_descriptor *tx;
>  	struct fsl_edma_desc *fsl_desc;
>  	struct scatterlist *sg;
> -	dma_addr_t src_addr, dst_addr, last_sg;
>  	u16 soff, doff, iter;
>  	u32 nbytes;
>  	int i;
> @@ -882,7 +952,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		}
>  	}
>
> -	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +	tx = vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> +	tx->tx_submit = fsl_edma_tx_submit;
> +
> +	return tx;
>  }
>
>  struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
> @@ -924,9 +997,12 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
>  	if (!vdesc)
>  		return;
>  	fsl_chan->edesc = to_fsl_edma_desc(vdesc);
> -	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
> -	fsl_edma_enable_request(fsl_chan);
> -	fsl_chan->status = DMA_IN_PROGRESS;
> +
> +	if (fsl_chan->status != DMA_IN_PROGRESS) {
> +		fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
> +		fsl_edma_enable_request(fsl_chan);
> +		fsl_chan->status = DMA_IN_PROGRESS;
> +	}
>  }
>
>  void fsl_edma_issue_pending(struct dma_chan *chan)
> diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
> index d3541301a247..ac319d2dbb90 100644
> --- a/drivers/dma/fsl-edma-trace.h
> +++ b/drivers/dma/fsl-edma-trace.h
> @@ -119,6 +119,11 @@ DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
>  	TP_ARGS(chan, tcd)
>  );
>
> +DEFINE_EVENT(edma_log_tcd, edma_link_sg,
> +	     TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
> +	     TP_ARGS(chan, tcd)
> +);
> +
>  #endif
>
>  /* this part must be outside header guard */
>
> --
> 2.54.0
>

