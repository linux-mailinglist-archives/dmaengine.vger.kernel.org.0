Return-Path: <dmaengine+bounces-9351-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIQyOenYrmmKJQIAu9opvQ
	(envelope-from <dmaengine+bounces-9351-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 15:27:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343623A852
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DE503013B46
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2C3D1CC5;
	Mon,  9 Mar 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/ba3vcu"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6503BE16B;
	Mon,  9 Mar 2026 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066471; cv=fail; b=PmqrVB4X6GYzc6iuusT8af2vQ9jCoOB2JyxPYuCn7dP+JYmZzm6+T50FwIOw3j16yqDEyqV7LRT9ZzkWoPN7QoNZtcxjl/NC/bZlC3Y7fpQrTkoaqt+sRxA4Qh38seAI/OiS7qcI+HVEL/oyobPEVZsO3ROV0KgHx+AGwn+wfgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066471; c=relaxed/simple;
	bh=n3teBnQwGUOznb+FgPCS60gbkWqLmTVI0o+1CVHCRtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ymul2X5RwBXwpdsPjL2ykUADp4S0MyoIsAiMZ1j1/lEA3yjdoEfWg7VRUjA7LJUDttaCZ95wcjt2XbzlLF4QA+IdV8092EogOv0Mt3q4TvwMvU50GfyRHoK2RWjKIZzBdjpTA2w/9jhQLDw1KrkKCSUqI34P7jW/BUmT4iPCrLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i/ba3vcu; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEsQ1O9EwR3O1suiY7C4RsJMWj44OeiXnvN4yfH8qGH0XFHcS22UwUIV33EbLWtZRDNBTcrl0EsfdNDJXZncIae8Fmov81TIItrvfdLCNZwTOosjQONZi98Hud+a/mk/iMRXIMzs1aTju8foJbcpskVdKa7Aft71ARaVp0gR1x9dZfwcsNF/+4SwDhngJb9NhqqxPBCVxRdG3cl+4Tek7EAvqBR7DOJh/DfWdye0UU2CP6G9s7x8B9P667T3rD73YhrYHw8+4WU5yp7LP9enn3Nz8M6ry829PlZQZ+DfEY5RVRq9JaZN89obH/Ln+6FeQU0ZOvfXTJhDVxTA8Uwnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3teBnQwGUOznb+FgPCS60gbkWqLmTVI0o+1CVHCRtY=;
 b=ZNpyHIFbltlMb6lul69wywSfBR5i9QdK4LLOFwDdjX36waaNNupR4O9UY9B/QNwP1yodPfn1T+eYfJzPg/AVzkr/x+S8c3fVDvSqB0Xjs3QxM2j35hH20Jnvm6OkBswR2pQC/ob9rgBY8CfH03nfxidGC7BrrQYdFRFHFd4OTHzIjAfaheOGlW2YkizG18AFpZ7yqFWkCCFEv1WsP2v/axuaeJLu1XqqAckbj6JTNh/i9l3RP1kHIg/HDoOOwSr9xGnVsInf545tT81+FNqUPm2IRVEwRZ9/N9REg9Qr6XEiHOHjQhC7ZUTXcJ1aP25G6qnOU/d4zO8ovaKaHUr5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3teBnQwGUOznb+FgPCS60gbkWqLmTVI0o+1CVHCRtY=;
 b=i/ba3vcuC5olu47Z5CVyJeOg3K/2BWIfA4tbmQBjpW86GMf/g1KkyKbb5pAwwOLycZpAb69STZ08lGLhAikozS8Vb4TLznaTdg0N3w0TkkBprkOqwnYO7BSWH3aN4LQdFG4aN4Aqp23UsD6RziKRcva7pxoZwArfSr4jX+BcoNhOXMVjWeS50ZiovLsQub4SDThxF/dx7R+c1lzriaOn3bkZS7wLSnyWjZ7LYpSWDrf0DpQxYSYJ1Q/3y63bZRv7nzNKaaSzhckuwhdEvzfWFYtyQDm0UqgWI7IPvBG6L9KUPodunEB+r+HDRzzN8/eJfc6hY4qtarjzXrFZnwfHgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10795.eurprd04.prod.outlook.com (2603:10a6:102:491::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 9 Mar
 2026 14:27:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 14:27:46 +0000
Date: Mon, 9 Mar 2026 10:27:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] dmaengine: Add common dma_slave_config and split it
 into src and dst parts
Message-ID: <aa7Y20I2_Hlp63gk@lizhi-Precision-Tower-5810>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
 <aa6t8QrrlearBOXI@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6t8QrrlearBOXI@vaman>
X-ClientProxiedBy: SA9PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:806:21::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10795:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f660a2-bc26-4694-cdd0-08de7de808be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	jj5xVF6DN8HgcMwsl2ERC6Te0iDY5UWnI7SLJIgT41TDCQINCjZSQjfvVTjQxPe12a24Wuiyipytpj2tPJMeh9w3wEi5ke3NDi+sjBjOim9/ecU5yGGOOAYN8JyGNWc1+gu9ZuxHQrPPc75s+a/pESUT0puLgAr0yvqDw0k4j8r+diO9U0SuaSDtVNQtd83I2SzanNef/JEM/AQrnj0UZQi9e64hMN6Cewi9/gBi9DMn4qNs0omztz4z6rvaMX8eBdZJlc8HdU5F95ZwAv1/sQ2IBjPE39ruCmBPave68/H0IfB1zeGNkH6vOshco2jhiz5Kk3ITQ+Ta2w7zK599NbFCPuoeOTANRhd6cNTsYQhSSzKiA2KI+oSKaO14oeK6XnUri7v6pVh+xYfSduS+1XzrddzK0kpqyQzrhJSR2g9oWH+bqTC2E/Tcjh4dZ15Y3jUwvq6+HD1wo5tHX5Y5KSNQTfPYxSX4C67KqWAjKCMYKaRwBO4WA/KTJd0FZWBnHDDbZjYhU1FNphN7NTMiXzhgWyaRRFAKOGtrB0IQPz9ECFLWGp6B+68xNOxdcvpzGta9ID7zx9Oo/D/KEgWKqVmxCRzzbbS28Fydw4XhFODJEYnPYs1bZx0mHODnQvwe05SqrqkXtSnADSKhSaGetLkrnPf1QdGZYlYWasDa7K1AUrKPzbdXKiaFqv8ZMI2IeU9ra3AwAOdwfI2lp9wr6YPhoH9UiWZqMSm66UqyF+X/wdYK7cYLVc9ELRVcGYBIVq4n9EoEhGU/R1Rnkoshrhscgj13BcjmovMCNqmuBXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?urr4Qp67w9PiVslpSyHO4P54aP+ClSYjz/vI1gWq2N5AwYavTRpLsDBM1DGh?=
 =?us-ascii?Q?eNMDrZoYZu7M4TGeQKy4QmiANZ90AFymWV2VbKQ1oHl32JKBBPlABBuSDjhz?=
 =?us-ascii?Q?q6aPLCLj74jsCMWT0iqt2GXLu7c8zKS0W+aeB84fAwyURbbiuBpc/n3a/4B0?=
 =?us-ascii?Q?59hcdfTojMjxnZb+392dkRgan0UxXsP3WBU1HHP1Zcfma9IDd/o/9eM2IJKV?=
 =?us-ascii?Q?haTmi4I5gWO4TpGYpzfG+XRq5t4Gvobean26Mfat4IDUu66FA9pJ7B9XIDdh?=
 =?us-ascii?Q?F2TCJleKUaFF4W7S9Qj17DJM3VP21S6y6Wf4rYbFPpOjd9PWzdN0Ve74bq05?=
 =?us-ascii?Q?33VwHXkNDzFZiEx/xD9O+lPEzs6jj3TJXbzl+3U/i5s91VsJDV7j0PcgbCX3?=
 =?us-ascii?Q?u7NhWRPVJwk6ekfrzm6ozLGZS01aE9NX6dubIFQIXL4yfNTn39j2gm5LodI2?=
 =?us-ascii?Q?8pSANbyI5irqrCifJPPHoymcReL67BshGK+wWIh/Rb1KaCFtgzX+2gk3hDZc?=
 =?us-ascii?Q?ywv+2uO4i3AkGDm8J830MBkmr0uPmiNZrwHgY9NZ1ne6nm5YSYWsb0q6x6fj?=
 =?us-ascii?Q?Z/tUbyHALf/YC1i9B73h7Hx0dAcNpRLa4WTmNPeT3TIMX/dCwSuOFo1ebMzK?=
 =?us-ascii?Q?ogf4znMaXDYsNcPYWrTogR3xUflDMs4k8hcowtBsGVpEsPyO8kWU4a8se6F8?=
 =?us-ascii?Q?KKUWxkpRzwJM0Z0+LfDi7GIcskv8F5NwjWAgGiaxuXQvqTpAzGa0i38yYVXw?=
 =?us-ascii?Q?+ArPGrVOV2Z6w1Oq8Vw17rD3ZSiCRQ0Jp/A6+IJCofE8nWg2EgJXDfk9zkbu?=
 =?us-ascii?Q?CbaSW+6I14SmK+KBVBuzhnY0PzJSCUlg5aL29ue9V3dx479MWN6oTOq+8Cad?=
 =?us-ascii?Q?UGknsOUSEBlU8ApKlvlSSCRn+UgQOnGThAypfXbWI1QeGPDXQBx+2myjWFZH?=
 =?us-ascii?Q?DEqfnxLD28v8QTesOtSrE1WAPeOssvotge7+ksID8uLSaoLnuPsjY56lhAR0?=
 =?us-ascii?Q?2PguNMC6Xxyf3g4JPUghCa5fIBWw+kOepq1MQitGRzp0jHwuY7/U3b8zWtJU?=
 =?us-ascii?Q?QAZt3WsoJLnGicllp+XLiqf59cQL0CYhE92ZTekBscPQFreUv+Thf0WygKag?=
 =?us-ascii?Q?uLFrRgNkI6f4b2E4KwnlW2J9ybsONqnxof6HDxNra/I6SCqKEYddAwH6LVjw?=
 =?us-ascii?Q?N1hTyk6y9+2N0qp1GyS/fLwAQ25gzIvQb6IL4Cg9/07bHxPDDNQ1hGjjwT7P?=
 =?us-ascii?Q?eR1lyW8+oEMrUirlmzf1QqDYII75tLvmiT0vU4hskiIjo0BpsRkE266YnNsj?=
 =?us-ascii?Q?67i7jxFow1vsWmpRSdqVtYqgM34RH5XjrT9pjQy4kVLzfPH0Vp8enKCbYm82?=
 =?us-ascii?Q?gsoSdPQbQUGM38pjbXtZp2MoWljYeeEFAK3TYKMSB2OOnCZzVEiYGwL/DDxh?=
 =?us-ascii?Q?phcNgaS4FAjWnCneAcrRRG7sNofmv6+X3VvZRR27XsRDiKdSweFQVFXP7Vw4?=
 =?us-ascii?Q?Y9GAgSXMBM2jJL6dkcIz5SXay7WZjxke6D7CGI5uc/9Wh4N0O+3L3AtRxBcO?=
 =?us-ascii?Q?mCQOK3PYWj+ZyK2XIcOTkkXPG8LHIEM9Ska1RpvmzLgqd0Uqi8OGk4NXswmA?=
 =?us-ascii?Q?Yd6za64vNQV36g2h7r1vuJ74n0v1o55Wh9GyTQZ51hZ4ld2uPvR8t/MNbRAC?=
 =?us-ascii?Q?PfvwQup3Dq8I47no0byK8bIncYNfe1SpxFsDTV36DD+lA9HQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f660a2-bc26-4694-cdd0-08de7de808be
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:27:46.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsUxKVTQEaDQi1PxuV5UxIYDdslZcKTVZLeizfSzwLg2POMwFQosbdzoeqqDBPBa2hsn2OT1dcoF3iMTAkUyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10795
X-Rspamd-Queue-Id: 6343623A852
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9351-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 12:24:33PM +0100, Vinod Koul wrote:
> On 14-01-26, 12:12, Frank Li wrote:
> > Many DMA engine drivers store a dma_slave_config per channel. Propagate
> > this configuration into struct dma_chan to avoid duplicating the same
> > code in each driver.
> >
> > Much of dma_slave_config is identical for source and destination. Split
> > the configuration into src and dst groups and use a union to preserve
> > backward compatibility. This reduces the need for drivers to repeatedly
> > check the DMA transfer direction.
>
> The reason why we had both the src/dstn sides was intended method to
> allow upport ofr device to device dma. Some interest was shown for that
> at that time.
> I dont think we have such a user even now...

My means is the field name is identical, not value identical although most
case is the identical. but it is possible, especial FIFO space windows,

sound/soc/fsl/fsl_asrc_dma.c use DEV_TO_DEV, at least src and addr use
differece address.

Frank

>
>
> --
> ~Vinod

