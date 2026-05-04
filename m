Return-Path: <dmaengine+bounces-10211-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UORUOiXC+Gky0gIAu9opvQ
	(envelope-from <dmaengine+bounces-10211-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 17:58:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33374C109C
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B9423005305
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A363E1211;
	Mon,  4 May 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cn0mFCdY"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917703DA7ED;
	Mon,  4 May 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910303; cv=fail; b=RexQaF67hw/aTHx7eKCkoEqLghWuuHcCVSKvvXOfM8hVfCPwjMgnv7g5bawWkSIyAIKwiqiA8p1nLsPD2U9HyREPx+Kz1rMQ0IqZ3UUKGSAQuLPJ73pW6QBQvDl1/XDXCpHwGWAItI4mpTQKSJ4k+wk4BoM75IUrwzsHacnpIo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910303; c=relaxed/simple;
	bh=C62CLfLd02FYH20z+5opkZM9bQzX5HcPB/SIyIgoFEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=olXUEq/QWWhw+U+AOPdJUI3uDkd92+TXe9dAmVkwHD60ULv89O5luyj8w+jOtvj+QqjFTw8pP6eqCAQPLmMUGnd8mV1W0pPnODrn1dV6E+nndlwFbBl5J+KUTYkC0ABM+FYsH4UDDXz0AAY4KjmPKgqk8iCiVRM10cANJ9MXZ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cn0mFCdY reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXWenFcfPm7MEajFCc9d6vZuGg9hfI5i2ZbCw6SNNfah50Hxk+3mIiElUPuaLsXs6UltFgGDgPsB/Dy0KCXGjRhT57KOYd3td62cUu+HayJFVT/MIhT7AOF7F7DRv65GKE59WzTBi55eaCFyZndalCJelsZc2uXhoWgWdFKhxkRtMnsaN3yuSoXM8UFw0o6dXUL+gq4A2TUh4UISNrQBvLOsI/qjLScvPL20oyWeSoAQoP0T0RznqzDjAo6ptGKCynkfljyMe0h9sHwS6XnPLDpmbapx9Q6kPKKlntTse690hWbETFmpUsZCfFtYFu5T18se5tnSLE4Va7Ez2rSh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCjO05QNVxNDQ9uURtnJ7lesaHYuh0Rh77lsATSfdts=;
 b=r+ti1TPdewhoE+EOX9kSFAur7gnI5CDOkwvtIo0luyvyEs97JBq5SoeaWLeKZoSMpg1BiIUloxI+MlsHehjaLW4tawpxNUqoP9j3E4msCp77DYiWKobjlLhu7vBYpJH8yamcRASI/3tHSQBLngxy4yzdiCGkR35n0LuPnxRtlKwuBxIZAJIyUBWaGYUfJwuPAjHflOHsAcjZSwPKVW1kbBrT3bJH5ORmqCO8p91Ixhkj2D/uBYGzcwCcNv7RjM96GwPv1lpW7/Yc9IU6EnD6OnaBcErKra9pTZl7Eii7AjO15PQnKSgA17xsifng4qqzTGYTsQm1Rqab3lx0JHJFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCjO05QNVxNDQ9uURtnJ7lesaHYuh0Rh77lsATSfdts=;
 b=Cn0mFCdY2kCbt9NuTaZDGdGLcXaan+uqVUE934Vnsay5dbbixhvvU3mQHU3KCjuDklHvgP7kUefUArka82aoEtdhSavKqBq+DNPx4GjBR+40to/LMrkzJoMDuvjNhMNRN3pxOb0xBtBns2r3eXCLvz+y3XNUpWGdy6ZbDv/MNtP1AFrnmeHuMnS0kS5Yzh7Zm7bEUFOxdaBgJu0lsbLjOa9CuxDAvvyYCH4HmtGpFbfNKFNATabuYCuUetfZ6dMU0xYzmD5tmm6bVD4r2ugSW7pkvXKb2V/tYpxIIzTSHBwwjT0RfYQr/5+YfpEf90JM2nblUhyGuH3S6/kpmBDmeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:58:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:58:18 +0000
Date: Mon, 4 May 2026 11:58:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Message-ID: <afjCEG_Do01eVBBO@lizhi-Precision-Tower-5810>
References: <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <20260430-fsl-edma-dyn-sg-v1-1-4e0ecbe2df66@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-fsl-edma-dyn-sg-v1-1-4e0ecbe2df66@bootlin.com>
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c9f764-8761-43bb-40db-08dea9f5f538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	bRmmR85P5mIEhdFZHYFeAyrejsCaZ5GmQh8Jk7RnMSGFxjILmJPpriUt06kDeYPeW4iSgyBLx7rsN08H1KqsGhwjLFDGzP0hl3kKyPQbMn2tRhGCffXdEa34DMBuuF7JbEUDyp00PTMPfYKWV9odjORrrTo+U7bMdRFYhy4vE3J2ThWoeYWO2EG+qw2FzQG//Y/Ss2WGAImPrC5l928KfO5hrtDLomTuC8/qfvOWmWasfl81HvttJC6FwRLi/APNMVznuK2aH9RZaL+WbAUnsoU7amgmc1KZEWvye8fS2l68Ybp+46J4J9Z9oMVuW4U17vum6X+XrtE1EQl+d8gq4UENWn1AazgyzeN2JmAEMv7UOa0RB9nhGIcniEdrogsrrrZL3Jl5rxtFxCoYE0GsekIc1fWv7DGZYYFf6WddjMMYFrdgph7X3UdS4zLjo7O7WpekDR3kPtamqg/tfMYehfNtSzVWm+IPHDhI7ZGaxYBEvXhXg3uarDKy3yhOHJYLN6YiYG1qX8WEbN4QM4nCxKuDkhtmjKkwzdi4cMT1rBe71Pdn4hRiQdgbjaayQV9r4iSTnyZmJq+wQRG6PpxTthgbduIUJ7FnJ4dro1nV1s3PMkwSyIiZsOKiq2o7CTdmZRg5jcIfyVIM7qzZgKsMm4uoJsx0mhROQAeeBKsp/HXGHo5xBl5nsURu1lrzkQOiNeAWMJ1gvb1iV2pdWviK2MB83TOmKqJWM9M4JXMDMz1MIEDMyeqz0aHXPuTwr2bn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RRuucbSFHSuylTIVFK+x5QGVeFcVZuJdevkzdF1bifGBdGW013fjRuVZMR?=
 =?iso-8859-1?Q?OsJBzdvaym+9NIEsGgaowQOpHoZaEZtxm5541VbiGPFEcZkm2C5Crio49H?=
 =?iso-8859-1?Q?xILIQrewNFCDcWWoRlPOGc71IVgGxi2t1RlxbyEZd7zPe2ct6zXcHKAOs8?=
 =?iso-8859-1?Q?SQo/NANZCV5h5BvY1qRbhGbuXWSdHeKZiyLc7339nv67ef/Yc8eb1R7WVq?=
 =?iso-8859-1?Q?eFun5HT3drOZa5hCGYEqdkoqF4P8adFZrxeEtzB1/Sn8BqUbHo6as6IXFg?=
 =?iso-8859-1?Q?dRkoiqDdtT/+pKu8YQmAUrDmWbdcD6gDoTtB5sScbDkx6N89QvAKWg3qrA?=
 =?iso-8859-1?Q?Z5Xv+MHFItB1t3gYBBM5oEDcd242GgwlzEGfPUoTc6mmnNkh2WxvzNcwvc?=
 =?iso-8859-1?Q?KmDvGcaUM4O5cjJF0EbY9kb4HQ8PdkSvftqDf3B9yvPOjyH3Nvr1IUyrfb?=
 =?iso-8859-1?Q?sekdv8UoFICwCmENAjLJlHukprHqsYIeQIfySUFVppmjYP++tWPb0OzNWM?=
 =?iso-8859-1?Q?a/fFwYt3RezR7a0nj88KXHDyfSVMIB/CC7Neh85plMs+8L0Kd1qt14c/Sf?=
 =?iso-8859-1?Q?1toB93OA2Nuxl0UBmCLrIStIEkpgfkQ1wklZZuejHvvEonM45FGrAPtuBG?=
 =?iso-8859-1?Q?HhkqDajfxINvNRZY9KL4CADlsBR3eVJTNWnxku2Irr4i8N61pRgyq6lB/q?=
 =?iso-8859-1?Q?Y6H27SeBeUbTwObgvx7I9P3ngSe5ZCSMvH1wRbXNFTjrZGf59z2mAhFQC8?=
 =?iso-8859-1?Q?ntpB5cNR00EUo/esV+SAymO7Bfd/dK3aznNraOIobxFnHBRwYn+yObi3HA?=
 =?iso-8859-1?Q?6TcQRE2zDIG7VyW3XunQ4cdm7aqjYSyYoaP80Xk3qHDEgursMNppLADKEa?=
 =?iso-8859-1?Q?GZp3BiGHL6K42+Vq2MHwFvYBI9aTm6Y4TgYc01jRsHBACG8LmqpyogSlKE?=
 =?iso-8859-1?Q?fPCAHAPPfJMqVgSZnqPa5Ztmhy4jSpyWuLrzCSBX+v+YGEGJaC+4y3hdC6?=
 =?iso-8859-1?Q?/pzYonuPH4Wpl50OJgOXapIF5kNaTyXkn+AhyayhlWpapgcZZtdr9HZtaP?=
 =?iso-8859-1?Q?acetpIrs03A/wSySeMoIlN2k3W2x+hCORZKC1G1J2lvZmvnqDAymDpgrz0?=
 =?iso-8859-1?Q?u9k6ia1TZJ7Vk2yrqnL/Hp549KzevGrm+bFpCZHZhBtHEEmmTruUXAhPNj?=
 =?iso-8859-1?Q?mQijYwaUy7GkoAxkXvJ7Wffc+VOWBYQgW5lgx10AVUJi8QS05kLXqJmwM9?=
 =?iso-8859-1?Q?h3ps5nOWDPmfkWLxfizBhkAGhaNcWtGruR1xiRiEC2WU305gW+arLBMbPg?=
 =?iso-8859-1?Q?sU0v+eYFhBxkJFSu6k9a8fdJ/7IKD7KrUAvUgoAtXNBg5yPhR4gmJRQ+nf?=
 =?iso-8859-1?Q?kW09bNFnX9ooFl6FoS5pOs8vdUtW4NNFxN6MaVnSoZp9cNwYv4dcEyP5lD?=
 =?iso-8859-1?Q?9SsDQPMtzxVTQSau3ABdo9NuYSlwwNpv/LumjmKNYRG4+5bP52bsFmny20?=
 =?iso-8859-1?Q?pO4qA16q5eVL1IBJ5OlHpoa8aS3agmAMmTqgEQLtuZyImZZiRfdqEqUGVw?=
 =?iso-8859-1?Q?H6il35pR1LqEfEJc+9NeIf93CCjht4zPBzNhX1T+LQ3SiuQ3ZB+W9D9ook?=
 =?iso-8859-1?Q?OZ1NwVGC5Vgwl8aG3dm+T49blE5/1cd9FNxuyCHMvcWhmAcAaQXVAsx1ws?=
 =?iso-8859-1?Q?9mslC+q9lc4BW7M2mCPW0oCe2fnkk2+lxYZXcJ3H6FAV0BsFzakHfljETs?=
 =?iso-8859-1?Q?abIuwPiIgn3j99YHl7SEEgbqOXlFWmxfGuqr+qHFpGOjx6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c9f764-8761-43bb-40db-08dea9f5f538
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 15:58:18.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar/1gQhiVlbx4Ikeh2MpbZryyrfEXLO2xX5y7/s94xY5GdRl4LRyD30dZZF+GIaK5MhedUf59Q6EyRoI2ROUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062
X-Rspamd-Queue-Id: F33374C109C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10211-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email]

On Thu, Apr 30, 2026 at 11:49:32AM +0200, Benoît Monin wrote:
> Add implementation of .device_prep_peripheral_dma_vec() callback to setup
> a scatter/gather DMA transfer from an array of dma_vec structures. Setup
> a cyclic transfer if the DMA_PREP_REPEAT flag is set.
>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---

Please remove RFC for this patch.

Frank

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
> +{
> +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> +	struct fsl_edma_desc *fsl_desc;
> +	dma_addr_t src_addr, dst_addr, last_sg;
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

