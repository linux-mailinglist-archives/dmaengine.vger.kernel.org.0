Return-Path: <dmaengine+bounces-9737-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP23Cfmkymmx+gUAu9opvQ
	(envelope-from <dmaengine+bounces-9737-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:29:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B601E35ECB8
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54CF130022E2
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665626B74A;
	Mon, 30 Mar 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4aPsl82"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27F282F22
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888121; cv=fail; b=ukLmr9ECuGQd4lzOuqfU7YKhwOTpcrc6or/A35/71LpPNXSNq2oL1gWhVF3J74goFi6vutg7k113Hsu+aDxRUX5sPUmYpOV1BeWZr9uiJXB+XM0lPNYewS+dKMoP6rtsVy2p0kBI4ZKKGmbTppJHwsnYrpcvnN8JZwFIt5V/ZFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888121; c=relaxed/simple;
	bh=IBS+saOiAj/VAB2t2bJBHqb3a8bZ4OBRGP6c8XqT1A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MB2q9Dp1j4FoYiZMi+XSE4JmnTNrpZa8wWKL1fC8KN5gNamGK4ErbbXglrKhe6DJYX0eWbzODCrTBVGGxVdxI8WUxDdaa5Cbbqjkz3MAwhYvc8TmdrW2CoVvq/ho/hWGr6iaho8ZdFine9757DAtG2ssxvVFblWRC60/3O7Dxz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4aPsl82; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb/5QRMgoF9qxprPEfUd/gn7Rk9mrWW/Z5FsflETTjUA/VjfoHs6imOXUi1OZMU2yhFZHolE0wi6fsypexGZ5ybdOcv8h2x2txNOdxhVj4miHdfb5QXNRTL0YHIcS2aTdFk6gUa+zFhyRquLlqtT28miD+7+s0ongxOyPV1iUaE+/6oAo1iM4N6wUoiAqotFVVOMbfy5tD/8NwNtqobtfZnsNMdWiKGI9v4it00NG5LKWwGj71Mp8tyyPWWaT4z4aUni6ydmpIzGygxXjbYUZD2eM8ipGBct2ljE8K0ziCVmd/vNLER34EBtETfsXIpgLAAOR3pNucnwtZbA7pdC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ1jm7K8l+rwvqfl4dXBnzRAdPsocs2hmBMUz9Ri4hc=;
 b=p454bMKVBIri09sF9f0jMhWQibtJaFoRFjyeISHsKRHiNRQn6NbDZ6AIZYL1RPVor/xvz/P0MV4PuhRvJGg9WAFIYwM3hZkIMq+f6MqSzhWBt7zMYg9BG/WoBsKp5NeTKK2CaTGFV+LVCYKdQykxFjRfZbqnWQua9BMKpWjzscOfnkAdu+Whl7eEgpm6ziOG6brj4MA9WlsgJwB16PiuCOPryAJVif2K99zBWSLPUaKn8RRQe9acFMrPmmhp1dsERTKB2BqpbwPAKZtYaVaqFQW71RpjqJF+de52DubwHifWNhueFN04nZqfgVDDfxAPFigYCDMlP6gHPyQESCZa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ1jm7K8l+rwvqfl4dXBnzRAdPsocs2hmBMUz9Ri4hc=;
 b=F4aPsl82TIdm0bc/55oZcNbB5O5gAc2XfuUTrvBrKGI9sXpZfk19tlCnXDrke48VACoS9Kst4o+S1M9ciOs/fYKtx6wfEqFTM2WFBOCKHEG+YvNa+4ixJiOgp4U+npiJBMqqJKiYaOns5sssxaGUCIrcBBShG3beyBvG8CLhwLI4KzNERSlbR8nv/s862N8TDc7yrYRv5T0GguiiXby8bXSDX0JM9zGyn53OdagQHuoJa0ivz8W8k09JL26Sc3Ygg6jNKH647pZBsvMu+nc8MKCPvEtqsjvkVJzba4IDCI6mg93JaAQuIHuYzX89rUSr71nhwV2dk2sMzbZk0rdmLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10216.eurprd04.prod.outlook.com (2603:10a6:102:406::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 16:28:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 16:28:36 +0000
Date: Mon, 30 Mar 2026 12:28:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: David Carlier <devnexen@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Yingkun Meng <mengyingkun@loongson.cn>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: loongson: loongson2-apb: fix broken bus width
 validation in ls2x_dmac_detect_burst()
Message-ID: <acqkrL7CYbr0WmHf@lizhi-Precision-Tower-5810>
References: <20260318164803.14351-1-devnexen@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318164803.14351-1-devnexen@gmail.com>
X-ClientProxiedBy: BYAPR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:a03:60::42) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df39958-f79e-4c13-4229-08de8e79644f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+GtHfa5bfu9AngYVXUwm09BmEp6pKOxFIOheDd0sZGzE0VuL3kIAT0/Bv0JgqmbasvdAOlOo3JxQ2D79MPfNeKwosBI6+KpMIp3FUeDJb5+Pof58+s6oqBKcvK8CUI61ieK2uIrDRFxrMYt552/cjxLTMnTcOiqAkMGPgT+SCYvpfq510lI3gmCrlEV5fZNSHQEXtonu/RkXAyEULhwRjfn3n7TgR+7nKVqJtFNbMuxHhuxNCMN7k/m+gG4IWBrKNgvM7bTEg32h23My+uvaO5hji69nWDDNTTOsLMxFfGpPFYyxhwX949F6Kg7whW033hrclXUCF8NB1R245KuJ4OxD+9V/j4i0ZGGT0UDLMCVpqL7srgvctLPyVT8OAwNMt40UN2th78LhqdMzlrP85GsKqYcia7iezNnb5r0dJw4SNaojZnK5I6IcGDZ5Jo26u4VMKQkTyZhHXGFHPF8XnpBfi8uHbqqPBNmuD1CEmlJPsksiZLIOB5Y54QAtNuyXASoehR9hu64H0YzCMZflj31rfh5t+c3Ppny3mkTSeDsJ1kRwGvtlFB39pkyuZu7QVBu99421VGVAeCHgBjoGO8Q9+DHlNInG11VRpFooNh6Roer27IgyCE5QevLv/QZ65tkJSsf5yixKl6lQZ4jecaumr7TsjpL/elhtfmevngug77tEoAmnbJr/v/zJ1TCqdHk6Nbq/BczDg20ruoA6D2ceNWrHY3o6Ej/TSIJPPFsjfAZx5rcOnNXGwaaKHIaN93s8oIvFFHS/8x8l9vr/mdDEurMDDx6mS/IizoaqhlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLTB3FIfSOZ9+JqZzLOgL6kkHOLrTE4c2CeGOh0Tw/cXOy72rMKAGc7yWcAQ?=
 =?us-ascii?Q?sDyusY/U+uIVfVEy+w15AT47yl+t04CfCLwq3UDXRELy/esn3gLGd6kwWkIZ?=
 =?us-ascii?Q?G0hyp4UZUnUTSjD5wCEzJ+aPJnyP9vlbjh1PfIt+bafg5mpqIbV7wKIV1g/0?=
 =?us-ascii?Q?GyKVTGuzZTIZkP5xKIQMQHmjS7whvQ+CpmXUf5cE0xEwX+8V4wi8ERQlyb+v?=
 =?us-ascii?Q?YBXzlN155ypnKregMaFK6MamghX4H7+JYvn4i97uBvjYTdCHtmeRsMNrKy+p?=
 =?us-ascii?Q?1bQohgXFM7406aNsqOYVTlcJOW2nF+pyIhLmb5K9Q+JfvK0+ja1S7/IVZ3hL?=
 =?us-ascii?Q?7swMGYyCFY5avbcOqeBIfVBoUgpc+1yT0BB4hPcweNmbhEEabsSY3YlVU/qe?=
 =?us-ascii?Q?6AkufJ5IGQPcf1ksslT6G+P4gDes54z4Yr6czEG8GD1LN0u5hOy4hqXYWUeU?=
 =?us-ascii?Q?kLWyialwPwJe0hQrUY251PIou/c+trUROl2kAiHAUSLTp9ncZd6VfhyrBOti?=
 =?us-ascii?Q?luBcCSMgOaOQwSHp8bmtBC9aRUOPa5ZcjSRjfQAIC9qrsG2wMec3U6bWOKpk?=
 =?us-ascii?Q?WRxpvCxfLCG1mQJK5B/QBHsXHibp04x/3JlnvIpSeudH6kLh4KcQl0AerscG?=
 =?us-ascii?Q?hO0KpnHRnphk0DuLctcR9qoHcrL3ZAFFbwIGjodt06+t6jFOh/FajKSxE8mk?=
 =?us-ascii?Q?CJ5gx0ECbJGRi3RJ6uxV0zvvqxWyFieAdE5bUvSnkaYbwh5JZknymueUiQGV?=
 =?us-ascii?Q?26t65eKJPSVMdrclYiykKRXHjCotvAvo7L8SYZmvD1arui6rwRViopAAUlDA?=
 =?us-ascii?Q?G47FiojaIv6VICNlx+V2hGRAh8O+vJhe63P88N/gPVUpYyxOvOOTSbt2HjwQ?=
 =?us-ascii?Q?Rre4pcZ12VOOBXC36cZjriQXiXrdJB3/+PSQFDSpUbQ4nfRDzzk462OUXj1B?=
 =?us-ascii?Q?7KEGowtUZZxZ7zp2qp+308YWdOPtmIUc44nmfO6bT5/kTK4DletHjrqpl8g6?=
 =?us-ascii?Q?tSK2ychgTsG/0mmBdMu5jtD3YK3RniIxbvbidJnxnVV7kv8MioE0VIHU1tf4?=
 =?us-ascii?Q?wdVQWsyQXGXXX6DDB6OgamibDm7vR8kDY0olzma/nLfxTc4YsLjVxtFC8ytR?=
 =?us-ascii?Q?QcH8lAfEjvGRoCpfqVOS9orTGKJL76d77FqjHpiGvULk6RV8+M705u06y+To?=
 =?us-ascii?Q?TFU6GjWN8xrJdBqCO2HzI8UQx2aCV6BU8Ru8BLLVV7BSBRcyj3JYYaW/5D0a?=
 =?us-ascii?Q?tve9QsGLo/igjU9nP7i09NW/5hIYaLw2dpU2HPflJaBS2s/Pr3wzm/af3YNJ?=
 =?us-ascii?Q?KKBUYiIYbPmoLM+1e79cwc6eLy+rTVxwHT3jsY7qwSC+8fqQKjELDITAkFKM?=
 =?us-ascii?Q?OyJ82imIzo/gzlO4w24swNSBeYocQX8CT4f0Y4TIB35FhEQwcEv1snMQTQK1?=
 =?us-ascii?Q?GbtxjqIG+0iTTZO4iE74WedOX/vcAyOImsfCNMqxqwoWfTtCgShNrkqK2hI6?=
 =?us-ascii?Q?Htt8hzYCSv7vxdeqSEmUO4KTZvoKrM+oQW5fIUvsM5/sNyLJWe6oifmaDZEi?=
 =?us-ascii?Q?8e35wTC/PwNiT7hK0566zT8zgupaIgfnsmZgnGNy/dQgeygIQuMFkWSTqYbZ?=
 =?us-ascii?Q?1uO8is/ecPHS3t3z49dkq/ulestsaaaFAKaLFxmmEdM+cGLEbDbfVcdn4HPO?=
 =?us-ascii?Q?BqXgDKC0dzlWVIxD/7IQa55INrvEDtFsDmX1/9SOalI+I3DsJQ2e6pMTW7gh?=
 =?us-ascii?Q?8ArkoqgCQQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df39958-f79e-4c13-4229-08de8e79644f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:28:35.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TZsDTlgtt5psvQrdv3q86aUV9JVRsUsxpYLacAo/bK+dCZ42Q1Wms44T8bJmJ9dWj0VvaGdj4nn4+E88xwAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10216
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9737-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B601E35ECB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:48:03PM +0000, David Carlier wrote:
> The bus width validation check in ls2x_dmac_detect_burst() compares raw
> enum dma_slave_buswidth values (e.g. 4, 8) directly against
> LDMA_SLAVE_BUSWIDTHS, which is a BIT()-encoded bitmask
> (BIT(4) | BIT(8) = 0x110). Since 4 & 0x110 == 0 and 8 & 0x110 == 0,
> the condition is always false for valid bus widths, making the
> validation dead code.
>
> Additionally, the logic was inverted: it rejected configurations where
> both widths matched valid values, rather than rejecting when neither
> width is supported.
>
> Fix by wrapping the enum values with BIT() before masking (matching the
> pattern used in sun6i-dma.c) and inverting the logic to reject when
> neither width is supported by the hardware.
>
> Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/dma/loongson/loongson2-apb-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> index aceb069e71fc..102c01f993ef 100644
> --- a/drivers/dma/loongson/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -220,8 +220,8 @@ static size_t ls2x_dmac_detect_burst(struct ls2x_dma_chan *lchan)
>  	u32 maxburst, buswidth;
>
>  	/* Reject definitely invalid configurations */
> -	if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
> -	    (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
> +	if (!(BIT(lchan->sconfig.src_addr_width) & LDMA_SLAVE_BUSWIDTHS) &&
> +	    !(BIT(lchan->sconfig.dst_addr_width) & LDMA_SLAVE_BUSWIDTHS))

src_addr_width is enum dma_slave_buswidth, which allow
DMA_SLAVE_BUSWIDTH_128_BYTES = 128,

BIT(128) will overflow.

Frank

>  		return 0;
>
>  	if (lchan->sconfig.direction == DMA_MEM_TO_DEV) {
> --
> 2.53.0
>

