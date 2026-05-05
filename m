Return-Path: <dmaengine+bounces-10222-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP+ZI24J+mlsIgMAu9opvQ
	(envelope-from <dmaengine+bounces-10222-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 17:14:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8614D00EF
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A033F30B85E6
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA9480DCB;
	Tue,  5 May 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GPkmE+ob"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB4480964;
	Tue,  5 May 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993678; cv=fail; b=RxQFCgq2/DpHRbHOqGqf4nRT+YLFDfDKx+9bZiHOz8nuGyO/jKudLhyom1nSjtI3a/8aCLUCfhGpVM5aONHPk1Iyzkxgkbtb85Yvqc2LwWOyHMzB9TpUt+YDDrtQYmtTSgWP9oaFBJdPjPyI0kd7H6q8lUFFK7hb7zZjHMpZEA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993678; c=relaxed/simple;
	bh=jSFy/juG/nuspzJhnmoGY1a3ZEOkYZZnf7s/i+wXc1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S2PPwuJQ3pRqTBCpTmYXajzWvQ97/QZ4OfDgVocO11Lf6G+gRGAGRNjo0+IsoucOAy7G6aEBdqNrEmWHc1oSbsRT28Fz67grfEmbt/f0wgzP5yonKJAiIPLeiwS+L2J3VS12k3dhXtth8D4V9p48K+TAwZbUk3YwMrs2DUB2YL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GPkmE+ob reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSOzg7cfr2fMnBY9bJi+htcfWAXL0e2mtTAK8mcTSC7eXwM+XdmN1KY7x/BFkvMWvM30VN9q708jHCinz4h60ROyzLmGQIRUegy5MJFS494xEmUfZiCbwRPuFvbv4NsKeGacNMQBynC1L//y49LHCcuEJIlbraHb9sxxYhV4LeYnDEkIEYCniZnoAPk1xLV8uiKw24Pp5tpk1xMTh5NlD6cBN3NSf3xBO2nwvOhxjQgTPv1HcreDfKhGmGHVsiGfU5BGlth6SPtkryFWaGl1LV5Z1FOP9WZRhQHADy1+LGE2+74T27KZiaAOp0ARYDQ8mJZGpBMK9gp8IzwnmHIxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2chQ9v24YZkbscnO+hL1jrqk0wt6nuzRFTM68qlhCY=;
 b=MVCZ3UsAzvD3h1SR7iw7nts2rI9FxEmRMngle3OrkST/coiyXILADmIHeaTybGSvk8EpiLM6QCu3AmMAikHy73u0HWrH8SaOJH9grKhEpwdLTypSI8CWFOZgYiRRBNS0h2T2LK8W6X32fqJe2skdjfLh0bafObNPMIEW4GPUcLlpF+pmn0N0orR9oFcCYjARaiiB1LxH8G/4lVX496y49gq0m3Dj9UenTO8EW37GfosgDr0Muni2kOWcUL+FYIOW4q8duK/A9VUGZa9YUC2/pt3QJ1Ib50esurtqXh8S4JS3aSl/CkfGNoUNXz59qjDp7IFyNrFjC0FGoEvOyZ2zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2chQ9v24YZkbscnO+hL1jrqk0wt6nuzRFTM68qlhCY=;
 b=GPkmE+obyT3t2vhT5de8FK/xc2cNiGDUcg+wBQzRHhY2rjwnPyGABHrhuav+072f1+Jf7a96FnW4/AXe+SsqZLgfoBgsYukFCL4/nxUB0++b+1B2PQPoiIokOfoYPJ19lzcPtzyQF2tHDlmM1mACXV790kgYz5a6Lhj2Hdw/xS8piq67uXv/Zch1XteYN2EmWKONP624Fed04tCPRFZhw41Dbmw8HcVQoCi7A19uvfVi1aaLUrkeXxbBYG9kjiin28wYc7iXH9UEzeE8Vgye1s2F1pJjWwADRSELu3pHPfgM9bpbmDJs2kBLOx98pzGmRPXkMTgvOmBZggjuGax2MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 15:07:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:07:53 +0000
Date: Tue, 5 May 2026 11:07:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <afoHxJM-s846s6EG@lizhi-Precision-Tower-5810>
References: <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <20260430-fsl-edma-dyn-sg-v1-2-4e0ecbe2df66@bootlin.com>
 <afjDoZbRlKnsNxwe@lizhi-Precision-Tower-5810>
 <y-kZDXvATLGuBxQOHfCRwA@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <y-kZDXvATLGuBxQOHfCRwA@bootlin.com>
X-ClientProxiedBy: SA1PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 13166f0b-b412-4011-3dfd-08deaab814d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	KlbngBGNVrJJKTtafq1sNwnbzAqdpIIfUP3wUVENJetHTiOs5SyD+s61+Jz+7pqjG4aG3ZMS+VgB0BtRZFRC9y9La52vSr1YpQRVwxYH9gZ4cvmsxbCDiatUk/35N3icxz1brnBNPfr0/VKi05Lk17EXQefFBdb5+thL41joZZLdnbOkVhOeH95Q9bdaSUcDxGNQ8msfEd4sZW/bWtUEiNeVvul5v6OMsaJCV/W0dc9RgEWINcUU0pzKs4ovb4NXzuTwtgFDvZRfI8dPCacbhtDsGAcXDD8yk/ZkMqs2q4yiWQ+2l8uIQKzzrxv0FQmIyOECfWCqU4SRAoC4xbNpBZ3nuTC/ORwUPYc3CF52AtbnRgo+4CiMVVJ+mKZmGD4YifT30XYlWlwRlpgo3lQF8/IbDkPHD9wWBrjsQdTJge/coz+n48FyZQOCJAU7vKsH1QDV2E30cWc2f35vGjDonmHuijXEq9U+qo2XsBXBMbsYRG4LeYqOV1uQFhj+rswFmxLN6cmGvyVP0BG1vOUwoiLQJnf9FpjGi5ODcrhulXU+d7srqWQDJPIIx4ua+eYUhwdV3NTgxyzdb14ApVNqbGFPTFo1T1ZBJCw39IfDVZtBhfrguILoFoAjQjbwlHuZUHR2fz9LGi26Korq1kTsdS0/K3qeFWWUs4KNwAbAXY5r5nnvYK2fCA0aY+1gCsPN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?O7aH/TSGoEhy3Fx4629UnlpzvrShqzR0Kf64l+EOTKUFd9g/y+Jon3W75+?=
 =?iso-8859-1?Q?0wcsRXfMlFAyMzybPQQsR0s9jrWZphNxeT7/dAc+hUO/5ZA4BqHw+cZKhg?=
 =?iso-8859-1?Q?Z2IvvePXwXRmy2X23ezk0u5g8BemAOfiSaDUvCvVgY+/rK7hDD/Ko4JD+M?=
 =?iso-8859-1?Q?/iRD5bsKM+GUndyb2wt0umF1nu5MnfPZsfBnorEZZVI6nJjPfVKUqu2S/D?=
 =?iso-8859-1?Q?89B4jBxDtfhu2uGo3gZCHgZn7dtGeGgVkYuh3BW98z8r8lD30CR/tWJYNk?=
 =?iso-8859-1?Q?fXBMABCw71jHdRCvf56NRdNm56yU3cDoN7HKA5Lo8gZs/tvEPcAACMggsu?=
 =?iso-8859-1?Q?IW9HVLGqq/dgNJbdDbkhgES21Ma/pI4NnhMeCcUuaQolzesHpi9aCrCOfY?=
 =?iso-8859-1?Q?h/dFhwL2tNnpxauuzjwSPO9JLJNGMX5IA7craFr9mQ/NjoiFWNQdl7oowC?=
 =?iso-8859-1?Q?JUAX03u05Fxbv2hCanMbmdmgQwaCpz4J7pOZ427u0HhgJQQUoQrnm5JdCE?=
 =?iso-8859-1?Q?GTjk+EYMY7UAbZ1nl+wccAQTcyAJIodpy7AmZ4vaXntsOCuKvc+mc8IyvA?=
 =?iso-8859-1?Q?AfA7gGyybfWsX0okrvOzl5Z+wIx+zlSc718TdEuE+rXACoru3St4nARP5R?=
 =?iso-8859-1?Q?mfLX0c+/PSBCmUAf7Kp+zKgwyjK9cQNTd1w6WgZI0+DX4opCkKJS7efNzw?=
 =?iso-8859-1?Q?kB18vzv8Zulv5gwm9J97FBdjX2TZGUjIb/cUKh8YEP1ioezH8LFV6RklEy?=
 =?iso-8859-1?Q?a/2EwjBDQiRlyReQHx+J0h2ZM32rVVNn6+iBLBHtimDWrZeNiDeeqjzq9K?=
 =?iso-8859-1?Q?w6VY5/BI9Dk4DK7fT2VaztoXcsEAVWQQvsKcE/ddyqb3G6GKLKqQNu/xJ1?=
 =?iso-8859-1?Q?ZM7pG6UfOKKsOOZh6ZHJOtC8AC2hZlZIk7UIw9hGM3/6//+0nhqKzaRFP7?=
 =?iso-8859-1?Q?V76lhNc8jZj+TrQhVQO3deq0xo3sevs8xmxoIGUsmwFGxrgNN6xLNiUp0i?=
 =?iso-8859-1?Q?uEPQ2KjMjI6G4hPN6uyl73iCPYf/lkwGSOzueLaiVmNGrrX/SaobIuQ6xy?=
 =?iso-8859-1?Q?Q4yzgO5v979wQNupXq9AwnpRW4eWa7S70oKWgCupgIJub+PH5psh2/p1a1?=
 =?iso-8859-1?Q?o4wQEL9pGxjUafTk7igRwOo772x0MJSMBIfOlNaOxLa/5cwG7KlOi3m6D+?=
 =?iso-8859-1?Q?2Ozp2LOHHLDEQDP1NZfW1BMunVLEZMz/JF/FbsxSoBMAGeUAVZXbcngthY?=
 =?iso-8859-1?Q?Nruqx5VNKV83rnYpTpzB60EflRH0NMEUt1wSLhpP9hes97rQ60A/KgSYPe?=
 =?iso-8859-1?Q?JNRfiYGv4EiOQcJfbinHApgUGbfjvQVLRyUL/WCLTfoPXxHvNnp6JjBxNb?=
 =?iso-8859-1?Q?+bh+JltBZmpPNuOFRXo2Y5I1hrjODQmiATv0YBkT5klH9h3NpBXCkIRx6t?=
 =?iso-8859-1?Q?9uN8AfiKNsAy1896M3s+2sVMVGsd2qXP06jI1n/h8wtPYi86wITephvUFH?=
 =?iso-8859-1?Q?KtztFyaLZUgpBR9pN4nDoCRvIDLICPRj9zkdwEQRfGuA0Sd9JOVAOZL4AS?=
 =?iso-8859-1?Q?pfD3GSTgpv7Aiv9gUmyLO0kSq5/NbOo1yy+E9U9HpYBEJWyVn37CX0Mmez?=
 =?iso-8859-1?Q?qisvlKyndrMgdu4a+kXLksqC06/hqXbMGciWDQIiUTQEZfJAjjHDxyyHkC?=
 =?iso-8859-1?Q?LMUfSJRM9NxnZTU5XMwIG4uNIM5Ja+0XBAbVisCtAnBKnvRqCxyoy7mwLG?=
 =?iso-8859-1?Q?FIYg2g4pmABZ5JVD3D+Zc8LEhKaJYbZx3gRG91qb77z5kJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13166f0b-b412-4011-3dfd-08deaab814d5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:07:53.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCHvU/ZtYodGSNMGrPJ4PB89ZVvGmyKUfGYt3ODk4XiqgpIgTdbxtJlb1GCYlGByma56SnhHY1xQX0/UY1K+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8585
X-Rspamd-Queue-Id: 2B8614D00EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10222-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.913];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]

On Tue, May 05, 2026 at 03:51:51PM +0200, Benoît Monin wrote:
> On Monday, 4 May 2026 at 18:04:49 CEST, Frank Li wrote:
> > On Thu, Apr 30, 2026 at 11:49:33AM +0200, Benoît Monin wrote:
> > > Implement dynamic linking of scatter/gather transfers to enable
> > > chaining multiple DMA descriptors without stopping the channel.
> > > This avoids waiting for the channel to go idle if there is another
> > > transaction already issued.
> > >
> > > Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> > > submitted descriptor to the first TCD of a new descriptor by setting
> > > the scatter/gather address and the E_SG flag, and keeping the channel
> > > active by clearing the DREQ bit.
> >
> > Thank for your trying this, which I want to do long time ago.
> >
> > The key problem is
> >
> >         how to guarratee safe when link to last TCD and DMA is working it?
> >         if update last TCD's next pointer before DMA load it, it is good.
> >         but, if update last TCD's next pointer after DMA load it. DMA engine
> >         may stop.
> >
> I followed what is described in the dynamic scatter/gather chapter of the
> i.MX93 reference manual. We update two registers of the last TCD when
> chaining SG transfers, first TCD_DLAST_SGA then TCD_CSR. This gives us
> three possibilities of concurrence between CPU writes and eDMA reads.
>
> * First case, both registers are updated before the eDMA reads the TCD, we
>   get the expected chaining.
> * Second case, both registers are updated too late and the eDMA have already
>   read the TCD, we are back to the current implementation. After processing
>   the last TCD, the eDMA will disable the channel and the call to
>   fsl_edma_xfer_desc() from fsl_edma_tx_chan_handler() will move to the next
>   issued descriptor and re-enable the channel.
> * Final case, only TCD_DLAST_SGA gets picked up by the eDMA. The eDMA will
>   also disable the channel after processing the last TCD, the only difference
>   is that it will update TCD_DADDR by adding the value TCD_DLAST_SGA. Since
>   we are not reusing TCD_DADDR, this has no impact.

Okay, possible work, let me think more detail after you remove RFC.

>
> >         how do you test it? and how much preformance improved?
> I did my tests by doing SPI transfers with the LPSPI controllers, doing DMA
> transactions with different number of buffers and different buffer sizes.
> Without chaining, interruptions on the SPI bus occur between each DMA
> transaction. With chaining, the activity on the SPI bus is continuous as
> long as DMA transactions are issued before the end of the current
> transaction.

Does SPI support issue new transfers without wait for previous transfer
complete, or SPI transfer already support async queue?

Frank

>
> Best regards,
> --
> Benoît Monin, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
>

