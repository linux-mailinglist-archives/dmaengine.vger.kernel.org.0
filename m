Return-Path: <dmaengine+bounces-10212-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLrIKrDD+GlQ0gIAu9opvQ
	(envelope-from <dmaengine+bounces-10212-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 18:05:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FC4C1216
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B6F330090B9
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F23E1CF5;
	Mon,  4 May 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRcXom2M"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90737883D;
	Mon,  4 May 2026 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910701; cv=fail; b=JxrrEGfBl76U7fDctpXtlflV+hX26EAidGWn/8aa9+BQPVEniXfdDeLrXkrBe9CLU1k8WQHD8wTHmnpQQrtRVQhV+2wEYg3A0GzxBXEKvhVjRJmo/qGcogbxpYDOn8FDq3+eH/KXO6IurkRg/4SAXOnR8zcfHbZufWmPPNqZi6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910701; c=relaxed/simple;
	bh=jXGjG32ubL+dKImrLJiZelGbKIjCtmqi3LowhFyjhW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uw5wY+10rJZ6vli0Liwjq1N59Sj6CcRN2yvTbSGulJci9i2i5lPpYm3uLKhoz9+clyQrDSLhcVrk4xdybi8YZhVIQvz1LIeJqAmCIlrbdfoWm7FE2yK8PRgZlDlhGetBMDcSxt0j02GhXiZ4++Sz2yyrw4T6P5wP1jO229MvGHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jRcXom2M reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuzAAk/zWMfz/HgIxJVYgJBEuMvZEB/3Ian5v+82bsICqSzXzoOjn8lLs5wWon/yH48q+qDmTlC0TW7p2antJnS3tpOQtxheSd6SpzcIinRq4Tm0dseGXU/WhjkfsxzA0pF5M5KFgC9i/F/XzcCZOZAveP70PrR9m2D7ebMmGoDnStfcNtcThRN5rrqvIAfus/5GFqu6zIlEo7ZcdamVN2ZJ+RmtZ3wOlyk+dKF2pjFAiC1dGkrilBk4ASdrDGT/BZc9eF2wV/zrpj+9aJl9/gPHxzmlF90DN/QC/pPK8lg5stbpHt+LMRCPh5fEkQY7HSBBJSnRZ1GrjCfdbD1mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRmih/Wgq9kpsoO6N2ixAT16jOdU/u4boORR0V+JIM0=;
 b=HS5nGTwwY/Q/ZnNkgWolLRNkedgoDhToHaCoG8Nh+CmNR7JQN6cnulXQ6h1osdTpTthVTl7iTJztlN/C56B8K1SEfJC3BL6YMEHXpqOl1xCmtSg3byvHdUdG4rLrJmCKi1Y0qhlDFUyJXn7jXWMNcNzSzastAmkkcgYQ9zpC3yMnmgzo7DAAbLcXSF3Z6IYduatYDhIv4CNDaeeAHZ/D5GCWNkLQVbHxzIVoWt4M70IIa3AWhGGtVAvjtClUyGpXBqmTr6d2pYdevjLLnY633CIYG8GwJ4Fkg1fXuOX1vxPmFihtigkxLmaTZOmu/T5/st1na2q/0Cmm0/SYlBAnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRmih/Wgq9kpsoO6N2ixAT16jOdU/u4boORR0V+JIM0=;
 b=jRcXom2MaLI/QKenXQtyO+VkO0/kf3PBGpfkPSooqRJHwyLJzaGlNk1NRxGma3f7NQHw0OegSQPr00ujofncoYCSflJ7obPiMHZSJpliguVRypIHsxVjkB4Mrt09dwsO50QNjDLPd2vqCbn82Jt0r254w1qDz4iZJTDP6NBk+RVR9UVCDLomGZzAXtDoj0HO/64gfp9mdIVw1ghTGO72vyyA037q5Z4MVOXhD/WtNWu6bAD9jGYu+Bhg3mjOBse58MQWvNP97R+NZ+8sDsjn5xZp664l/tppEFIhS3TKUhT+v0t5nL231GAgV0z8LbvXqhqconfV3NmBE5Wo8hzKxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB7127.eurprd04.prod.outlook.com (2603:10a6:20b:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:04:57 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:04:57 +0000
Date: Mon, 4 May 2026 12:04:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <afjDoZbRlKnsNxwe@lizhi-Precision-Tower-5810>
References: <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <20260430-fsl-edma-dyn-sg-v1-2-4e0ecbe2df66@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-fsl-edma-dyn-sg-v1-2-4e0ecbe2df66@bootlin.com>
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bffadb-09aa-446b-f78c-08dea9f6e317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	XMt+oJuLQCzgz/mNH85VwPcNKQ5smdCaviDMPLEym8AUlvDHQBS3qeJriFfUC++NNuQSV8vkol8B+52YK3PbokLNIMgkdziUPdZYb9HscvOnQTo+to3a2K440qJBoQQcTLkYIW3+lTNUsPMx6jCDRQpxexLGc195X4cXJROaA2tiwEbeZD3AItJ/TUivadLebTwbMd3eLuIKKGcMek0DnXiiajxZdyx1Fqyss2iaBxp5pUBBLT4NQNYGm5ydgQRhJ6AOPg0DwjD9Duq/MGXBo4a+HJJXBmrW1qgXiKbuea5CxPPlq8qhxA6uEks2Oha6RecIIVySVSinrMpK8HKaWlSVx+bx5rHLbho7mBgthv11KtglLYqcNJ3+Wyy9jUw/o/4Qs5TVZlE1BEzlTtMsWohQeASA3kvsxMyLFYTwPb88FgtoTm4+K46ugVy1GiAzQRiWPfNOPX9X0XqpDblEVYYhTVKMBg0BBKbDKwyZOGuOAAxNJFNpXtwYFrrIWARLymuJXjPRkanD0/rWLMc1MCw28g0yNiYkb5jZAsa4QvTRx7BmmQEYZRwKDb2NRjzIamQLrv2lrm+/dQ8ozVIorRYejnOxeqcYLKMXmh9uc6qNvpBpfvzH7ofCyvQbZuPQ5vB5Cbtlt1HRj1OpzzGTxHHoMavHlaG6GIrfYVm1n6Z3VY6L8Ubkyd+2v8Oqx587UhXdTsj8xwfzs6LwoQrJOia1E+FTNYT+Zf/cm13VQHc9Yk9yNPeO+5xhrJ79oTa2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+V3wZiM9BbTOm+cfCdi5kjVHRUEHKfncNjMBuDdW7uN5jdJequpMbyah/f?=
 =?iso-8859-1?Q?deYNytIfeqRu45wWJbwJ65jbk0GoMzp8z7RYMM5DsHWqwxndt3ZulW8T5h?=
 =?iso-8859-1?Q?f5PlW8APGypLr/5d/gehUxbMv4it3jxpFMIy1LdfBRyC2bZcjSmPnHd6R9?=
 =?iso-8859-1?Q?VNBJ7rHRuujnCp6+IeQzB2//rCbLTHd5PbQhotmxi9YuZiGb+INAwGcXWU?=
 =?iso-8859-1?Q?s2RiS9Jakf9qEm/co7THTV27ARRGuSn3EFCffX26hAR3A8F0KDWM5jutIO?=
 =?iso-8859-1?Q?EUPlCRpC9SzF5Rv7iNMdw5HYV61Hv+oGCLMcpTp2nNVYIDLv/8sfyv6/EP?=
 =?iso-8859-1?Q?hmFd/U2ka+w/FUfp5aiWsDl1H9C25ixxCh00sw8Uyf8Hgck5cIyfDqKSwV?=
 =?iso-8859-1?Q?zWU3xTU5kgYpD4qqsfyufDAi/wcWTv2gRymaQ3vcJTHGAzpkOrCf/x5qLy?=
 =?iso-8859-1?Q?g+HAZebh8qqNkOeA2VlcW0hiw4mqjLRH/p95v++Qjc1arOt9PgEmK4HZEP?=
 =?iso-8859-1?Q?b7XOJRSXZhlJa/mlnDKVxqFPiNQwYnJErEawM2kRr+8PxfXWZ6ESfAv7EE?=
 =?iso-8859-1?Q?m3sqY9xOaTEwg49760TGav9Krk07n57qLbu5kCpJwpV+uJ3+vc4zaVI+H4?=
 =?iso-8859-1?Q?bD+/nMNpoODOkJn4uEkb40ik/8iRKrF84H31Y3gh856IHmqvl4J3Uc1h8E?=
 =?iso-8859-1?Q?wi7iiuasTcJ0ZR4+wmuHuE5qpSxryP3393ZmRekXnbMqKEd/Jb3uqLeaVK?=
 =?iso-8859-1?Q?A/M+iA5lzDL2y5TcJr28kqscIlCkMDT6N6jleLwXqWlt2ABmrKbc1m6Ro+?=
 =?iso-8859-1?Q?QmeqKE2omO60jeUtMIlF4RLnB+ffBnskNmCoV6SXCxHwFSr+SyVqUpeoIT?=
 =?iso-8859-1?Q?Q8LKZC/a/h/KjrTThxnAuryaIDpBmmCmwWXQOdK4n2ma3jqJXBApiak5Z7?=
 =?iso-8859-1?Q?FXC8G5xVzNnxrmMOBeEh4Nw/vjdygkGmfNGlzHKPo0wHd7iuc3gebP+feD?=
 =?iso-8859-1?Q?5lySqtHCwfCNmxDkTEhb/hWHjrAsBRXjelu+C4jBsmJpLqqarENqauGSId?=
 =?iso-8859-1?Q?JqdiW7DvYlRZ+bZwSXiT36gnnjpuA4Qa4pOuXuqrMn429VpMMroqYZoDOu?=
 =?iso-8859-1?Q?nDxObZ8+spUz+jLAHC9phymdwXRqj1+OnYqdOAzliJIkhN5dSUKgS7yn+R?=
 =?iso-8859-1?Q?C3jhQY7oDZBsD0x1M2xguXfSRN9nPjtMGglmOvN90jcSouofj0GZ+tp0VZ?=
 =?iso-8859-1?Q?+Rl+JVx7y3VsvjW8DVg0mktg1yjvhpb2fUiHIR9WKu7R7N79UFRjlNSi1A?=
 =?iso-8859-1?Q?BjItcBu0H4dlqfu1gr6bpgmUNDJ1luFnL8yBDWpvCHRISjCfGuVx+ZDfWK?=
 =?iso-8859-1?Q?2zmY5VEET1jfpoA0EeoCfvuR85yOiYadNAjQp3j5nKf88s3UU7U0bJeSgg?=
 =?iso-8859-1?Q?NE7hr8UipzBxNoP7Ie3kyi4jxm6fFx39Z6qrlAGMvlYAYkLIk2SbTv2yjP?=
 =?iso-8859-1?Q?v6Gbqm4CAsocaBqpLUP6j9XPA4+4xYJ6suYIrBOil67EPRWY4s6WMeIxHf?=
 =?iso-8859-1?Q?FjA5uGaURF59z1H2pjcnlNB3p7obLCpRc2SFb22OT63xTh+i8DNT7fZY4d?=
 =?iso-8859-1?Q?Ur4vWkA46ut/3XH9oUHrppRnhuqW+r8GxYw+jaJD13DdeI2T9fn4o1xehW?=
 =?iso-8859-1?Q?D8d1dNxDOf2De1A04B/smccfRGujvldsDL9+d51ULv3xDv3UrLMeJtHI+F?=
 =?iso-8859-1?Q?SigSYotd4vsrPcvuJ1Tmkv2GZMqNPDqEFeecAyyH0L+f3XiewFvS5PaOHH?=
 =?iso-8859-1?Q?y/Ql7kVD5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bffadb-09aa-446b-f78c-08dea9f6e317
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:04:57.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SmWj6jv+caM2UlLCoWwu5VHZiR570KcZl7YOqRq3166swTOmRpTFMdxhyVSjJiqSJNTr7E6w/YIlyeD1tEsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7127
X-Rspamd-Queue-Id: 591FC4C1216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10212-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email]

On Thu, Apr 30, 2026 at 11:49:33AM +0200, Benoît Monin wrote:
> Implement dynamic linking of scatter/gather transfers to enable
> chaining multiple DMA descriptors without stopping the channel.
> This avoids waiting for the channel to go idle if there is another
> transaction already issued.
>
> Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> submitted descriptor to the first TCD of a new descriptor by setting
> the scatter/gather address and the E_SG flag, and keeping the channel
> active by clearing the DREQ bit.

Thank for your trying this, which I want to do long time ago.

The key problem is

	how to guarratee safe when link to last TCD and DMA is working it?
	if update last TCD's next pointer before DMA load it, it is good.
	but, if update last TCD's next pointer after DMA load it. DMA engine
	may stop.

	how do you test it? and how much preformance improved?

Frank

>
> Linking is only done if the last TCD was set to disable the DMA channel,
> to prevent corrupting cyclic transaction.
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
>  drivers/dma/fsl-edma-common.c | 64 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/dma/fsl-edma-trace.h  |  5 ++++
>  2 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 26a5ecf493b9..7094c747defa 100644
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
> @@ -673,6 +676,51 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
> +{
> +	u32 flags = fsl_edma_drvflags(fsl_chan);
> +	struct virt_dma_desc *vdesc;
> +	struct fsl_edma_desc *prev_desc;
> +	struct fsl_edma_hw_tcd *last_tcd;
> +	u16 csr;
> +
> +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> +		return;
> +
> +	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
> +
> +	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> +					struct virt_dma_desc, node);
> +	if (!vdesc)
> +		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
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
>  struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
>  		struct dma_chan *chan, const struct dma_vec *vecs,
>  		size_t nb, enum dma_transfer_direction direction,
> @@ -780,6 +828,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
>  		}
>  	}
>
> +	if (!fsl_desc->iscyclic)
> +		fsl_edma_link_sg(fsl_chan, fsl_desc);
> +
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> @@ -883,6 +934,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		}
>  	}
>
> +	fsl_edma_link_sg(fsl_chan, fsl_desc);
> +
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> @@ -925,9 +978,12 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
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

