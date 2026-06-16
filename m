Return-Path: <dmaengine+bounces-11552-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tr21LEnsMGoUYwUAu9opvQ
	(envelope-from <dmaengine+bounces-11552-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 08:25:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6868C7EE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 08:25:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=F4dG3ECp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11552-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11552-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7880300533D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 06:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1193D0C07;
	Tue, 16 Jun 2026 06:25:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020095.outbound.protection.outlook.com [52.101.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8693CF673;
	Tue, 16 Jun 2026 06:25:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591107; cv=fail; b=aKWofiiGWJTSNQJc2XZZvkZzGA8ujDQfTr9ZX8wCPakLDXfIinfoE4wRvLhN15bFF1Uf5iNNy0u92CZ1on0NKIyGFnoskzZUg3HvVW+U57w3mTH5K+nLGoCyCJj82pRzr/KXtCMyTli1lKw+yE37MnG6zgZjZ/JH9H8Q+0Sizis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591107; c=relaxed/simple;
	bh=YGXt/ttWpcduhqoIf/jcedQmpakGaqG4/j3XuIxCdH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DxPn2XSsYt9aUvirkAxdvXROuu4z/0eiIC04i4MsGVJWetEnrxQ3qBMXG1XbrkOJkG0XnSv7BTecB3mKnPV40OmIhyBuDcbi0vlncupSw568kxTpKJS8YfGoQEe+2ri9ax59wHYsSM3R6k2Pa9d30JyQg4M3ekIUyRr2ojd7OxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F4dG3ECp; arc=fail smtp.client-ip=52.101.228.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuGrp8sc/WpDYHD9xTJLYnYe5yP4CSE7u1GEV+zvSl6bwGA3sRW4zWDx0M8smbFufqohK9/Jy7guXApksazWC+VbiV1RtDs9mnZRI2yCwTQo2jXqbYH5m/Uk5r1+Qf7fX+FuaPqkeCcemIOtXlVTife/2DUjSJjEhVQ4gFvpy+kO/AV21weEFIVJmXtCLJrDDGCmZEDCYyyh1HmInIOvXxVfaoOAU0mMZ/kk6AvTtbRIH2AAm+0CtljkhlMwjdsDeiZq8VoGS5OxxSN71o9S6ee0yZmnqI4NqZAYH3O0XyW8r7F7SgB56XHjs44CmMfrPlDFYusRmB237UBuf2/qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dh8ldfCImowUXe/ZKgBx7mrSA2xZgo1tvl+PbvmEN4=;
 b=Q458nirXNNeSYXgxhMKFR/0O8evlcwrBc29oNmmoKpnpsjSBlsOPY3gbk5HDkSp11GmfMuxVRKRUvau88csUnKK5VVgBsUkJDv564Z3VuqsgjZuSPFEq7LVGcnPJItr6XJ083tf+xMZ8k/Yvxbvl9W0wGCyC0TXtfjbZHJUEiOvGbGneMWNzvb2POWDY6E0l1vGwdIdzcNFANMLntam7OzRAtq7qy19hlfc5QirHBl4KypbktrudtI7lBBOMVMhhr+Mp+LfIuQVou760YNiZ+oFXJMWpu5THJWvPMWXrs3ieTFCBcZZi+wgtiF6kM2RkNelYbQtGjX3+rqTCeuaalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dh8ldfCImowUXe/ZKgBx7mrSA2xZgo1tvl+PbvmEN4=;
 b=F4dG3ECpwdjM8aeGhfeLRIt7H0thWnWYOGin4QZnI4jpRLkeh3Q0SjxAG7JSnPubWUv1CD+iozbNSn/wdlaPLZoPjJ2ThEw7GUFC8COjEhoHoFFWcSzhk2AluxA2TDEQkFD3TCIPsAdqh3KoLhkikGgiM7hwg4fZSNCvnMc3D2A=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6284.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:25:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 06:25:00 +0000
Date: Tue, 16 Jun 2026 15:24:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	Kees Cook <kees@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Serge Semin <fancer.lancer@gmail.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Niklas Cassel <cassel@kernel.org>, 
	Devendra K Verma <devendra.verma@amd.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] dmaengine: dw-edma: Clean up vchan descriptors on
 termination
Message-ID: <iyz6a7hioaezwefkchs4gtffvuzd7pas3e4udtqawbcb5daypv@ixz32ardlt4k>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-5-den@valinux.co.jp>
 <ajBH7rXlNsdM1Tp2@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBH7rXlNsdM1Tp2@SMW015318>
X-ClientProxiedBy: TY4PR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f5ffbb-b269-4142-dfdb-08decb6ffe9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|366016|376014|23010399003|18002099003|22082099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0Knr+PRv9gVwcAx6S79s9ZT7NXNHjOsKaTq2J+5qDthdPVI5Pa1AQvT62BerVPgH4iUsmyxKT0LHnUanzRMG191ccVQyUFgQYZRl5m0Hbq8AtvBH2QmwRGzvJV0wSsrfgCbJKpK8c3udBUQQ8tg1nZAMNyszAhuGfkalNKgLIkKF9xXRoMW58TnhOJZfXEhhux/zWBGtDrC4rApVBMi8aAuzjndkSLPDRFKPmo0sGUHxH3CYjjl3A5rdSOovSlPdkK5t+K+UQL02zzjtrApncbPM2fKxbk7HM8fxX6dH5YlDH1QvFQMlPLfL5ICq3Qvsz/3S1rVJfGCujLFBDekQeDO+UVxOOTrmIriIJ7lWEDZFdJkjJWTnaIseCaTJQqEe3vmNxkXXK0SeNWzR1PDTvejepCEeIeh+4ArSmw8y/Wh74ESi373rdR9zrWbhN3HaR8uH4OkV2NNsyyEvDZEJaW+66ICzRXhLZuOzosC3zGY2aaEN25ZezcgTrt36XJYD8ESE3VBjsWNcu8hbmWeUMdp9FNnAwqahCYYYFMdoNuPbiC0pP1RbFixmmMqMa2bggpSepMCZI99KtXn4+jm544KRErdHgE6yS0bT9FN+tDaLUDtMMJlhjIU0x82nCjIcww2jNVgZMzgag4MdJs+fw3SmnO7jPH/q6I35oje0/9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(366016)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbHqRwPVId0A8QdhU9ZE0DxfkrYCMql2asxrKN71D7TE5HtiZHTdj/0+EtYi?=
 =?us-ascii?Q?yNosxCH8KOD0+k7osS2LmnpkTMgzfkfEpUoJWo9sAJ4/93syE1fPsOHnI6ty?=
 =?us-ascii?Q?ed1DbBTIlLg1oytsN+a6wXB8URTeua8+RpwESO/KfH3IWn+dX9oGHTMJX6/U?=
 =?us-ascii?Q?IGccZrDsegr3Ao57EhMMNyGz91cNtJga04xSPH0dorQzyE5VuUtrV5J+iMWt?=
 =?us-ascii?Q?1NGBNn/bUq5WfbzPkiKdbGamWiJLtTmbGtbCM/saKAhbG+pdi2ZPxhWGtg8X?=
 =?us-ascii?Q?ylcmszknEQQHX54AGahO/Ib9IFmrVjYDUvIlztqp51idUtioRsMSO4O2/5tl?=
 =?us-ascii?Q?s7L7qbGDBIqLSZ6Xi1FFK4LU+/KX/08Pk2aJnid9I+4wwYhfm87Cnj5v6ZTc?=
 =?us-ascii?Q?SjhBT/JNKI5QMNHceOFE4EWUm0ZIPTslPpYvy/dGcDwTroLYbF3raBCZ5CXy?=
 =?us-ascii?Q?ITRs1I6DGMlg+9BaVOhd+AFjHlvzN/xAzd+hdr3bMtPBBbQgW8yuTBg1qvWF?=
 =?us-ascii?Q?Vf/l/8cGn1v3DMvabRhraKF86WskcFkxIY+IEV2NLCQDvkDZcrT5jR838t6a?=
 =?us-ascii?Q?L+fP70JxsdLADOmzEyXimfjux2wue99IRcZbYz1KjWSp8ADw5Y0v7XaAYCrH?=
 =?us-ascii?Q?374MFC0IfkTOfdVfXOG7HyvobIcxWFC7cIWRLVeMXK3UDf2zZpBtyVEo6Cw8?=
 =?us-ascii?Q?22VY87IntjxKhwh1yZ3sscCSUAP5GrCA5asSR5Eji2OMPCd1gXjxIKIi8kHM?=
 =?us-ascii?Q?64z59yk4LUOTNA3f9XLZnQrO5BtpPlvBF3/STk10JvNIrT6JB6Kwzcc6VAjo?=
 =?us-ascii?Q?Hda13WZmSuk/eJxCptRteknmFXBr+duONRFZswmryEkvPGSfalb9iBP7mhtn?=
 =?us-ascii?Q?RxKVd7MwOndhK3lsYF2DJPFwQfCv74aSTKFqp/Az+/gMRBjpMYrHZClFLU6o?=
 =?us-ascii?Q?Do6RjGL5Lk3EbiCPnEBw1pgvmaeywV+gM0UBXKreondMnWgKPh7JtrNK/46K?=
 =?us-ascii?Q?eDzzQaNTSZNsZEc8J0H7n5rhzpJb205VmzjJAkCJcgpwo4Dy1epvsy7AQC2b?=
 =?us-ascii?Q?Q6HCNZCRec5UfZBfmyGVTvVKe2AQDQUPa/VTOc8i5bzCd2Du913Jfy8Ryuz+?=
 =?us-ascii?Q?yrYgd1fjp0P+WBYVxCO2Un8P4gRpFVC8RYZZqWv5aGyTk0I5OVZCzvfOFCm9?=
 =?us-ascii?Q?PAsurkvvWTH5OiQYdm1Pay2hPKoJzIrfM2VJd5a8nG4oamQSs2Q7ZwaAfr0R?=
 =?us-ascii?Q?TztV8BBuDfSuDF1UtTLwoUnAomwQHIiKC64TjPR19x118MbmgD/0hjX8BIe+?=
 =?us-ascii?Q?e9gSalQA41NKJaXr2Fkls3RPlfxL5STg6nx2gZId9d7qYPht0jvEMqWXMssq?=
 =?us-ascii?Q?Tr0EcFwKsf1QvHotms3WCr/LJ4AtTTgBFREWwih9H0TiNpAsb57LbZ0PLNNY?=
 =?us-ascii?Q?w3aKJmPLTan1KyXkqHezgiBALvS5K3ktX9S6+h8EUYQ2SDBalCWfJO1qdn3C?=
 =?us-ascii?Q?xIUkEJ8pTEN4W4sw4yeIItmxDT39NfrvzGYIBSKr/0NmNDMIq0lzKWfRX3Hg?=
 =?us-ascii?Q?oxNYhvhc4LfmUiN06rPnKdlgQSYz+BRzyRZYaex/ME0XfuXa/1gZquPPDRks?=
 =?us-ascii?Q?wPAbin0+A7vaU029XNr3WnNADVbBeatHWQkAJIJSyckYbqqU2io5rcZ2nYN2?=
 =?us-ascii?Q?Zsg9NSRIZ7N7O/ohR+b+50JMwsvygtfDRb5R56OZWCoNgdFn3fDj4zCw6bz/?=
 =?us-ascii?Q?zWGnJapubsLF7+PWP5LFcxDcyZnR1SCsiOEI67kBCn6H1nI9woDG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f5ffbb-b269-4142-dfdb-08decb6ffe9a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:25:00.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uHq7zaIElh1+RNiwu9VulxOlf2X9Dt8Q1KqRaHGuybPrv0ZEEUh8off67QK/2K3RWXJ99LrTXRNmVvYO1SIRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6284
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11552-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ixz32ardlt4k:mid,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3A6868C7EE

On Mon, Jun 15, 2026 at 01:43:58PM -0500, Frank Li wrote:
> On Tue, Jun 16, 2026 at 12:40:58AM +0900, Koichiro Den wrote:
> > dw-edma resets channel state from terminate_all() paths, but pending
> > virt-dma descriptors can remain on the submitted and issued lists. A
> > later issue_pending() may then restart work that the client already
> > terminated, possibly into buffers that were already reused. Descriptors
> > that are never restarted leak instead.
> >
> > Move issued and submitted descriptors to the terminated list whenever a
> > termination request completes. Also release virt-dma resources from
> > free_chan_resources().
> >
> > If termination was deferred because the channel was still running, wait
> > until the STOP path deconfigures the channel before synchronizing or
> > freeing virt-dma resources. Otherwise dmaengine_terminate_sync() can
> > return before the deferred STOP cleanup has moved issued descriptors to
> > the terminated list and before the channel is known to have stopped.
> >
> > The old free_chan_resources() loop usually broke as soon as
> > terminate_all() returned zero, so it did not effectively spin until the
> > timeout. This wait can now last until the existing timeout, so use
> > cond_resched() instead of busy-polling with cpu_relax(), and warn if the
> > timeout expires.
> >
> > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 78 ++++++++++++++++++++++++------
> >  1 file changed, 64 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index bedaee6d30ab..2777dc0b2aed 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/dma/edma.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/sched.h>
> >  #include <linux/string_choices.h>
> >
> >  #include "dw-edma-core.h"
> > @@ -113,6 +114,28 @@ static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
> >  	vchan_terminate_vdesc(vd);
> >  }
> >
> > +static void dw_edma_terminate_vdesc_list(struct list_head *head)
> > +{
> > +	struct virt_dma_desc *vd, *_vd;
> > +
> > +	list_for_each_entry_safe(vd, _vd, head, node)
> > +		dw_edma_terminate_vdesc(vd);
> > +}
> > +
> > +/* Must be called with vc.lock held. */
> > +static void dw_edma_terminate_all_descs(struct dw_edma_chan *chan)
> > +{
> > +	/*
> > +	 * This order must not be reversed. Cookies are assigned when
> > +	 * descriptors are submitted, so desc_issued contains older cookies
> > +	 * than desc_submitted. Completing desc_submitted first could move
> > +	 * chan->vc.chan.completed_cookie backwards when desc_issued is
> > +	 * terminated afterwards.
> > +	 */
> > +	dw_edma_terminate_vdesc_list(&chan->vc.desc_issued);
> > +	dw_edma_terminate_vdesc_list(&chan->vc.desc_submitted);
> > +}
> > +
> 
> Is it possible move every thing to temp termniate queue by hold lock, then
> call dw_edma_terminate_vdesc(vd) outside lock.

dw_edma_terminate_vdesc() itself, or at least the cookie updating and
vchan_terminate_vdesc(), still has to run under vc.lock. But I think your point
is to avoid one potentially long critical section, and yes, I agree with that.

The way to do it would be to move desc_issued/desc_submitted to a separate
per-channel terminating list (say, chan->desc_terminating) under vc.lock, then
make the channel look as if terminated from the hardware/state-machine point of
view. After that we can retire the descriptors from that list one by one with
short vc.lock holds.

Then, extend the dw_edma_wait_termination(), which this patch (04/17)
introduces, with something like this:

    while (time_before(jiffies, timeout)) {
            dw_edma_device_terminate_all(dchan);
  +         dw_edma_drain_terminating_descs(chan);

            spin_lock_irqsave(&chan->vc.lock, flags);
  -         configured = chan->configured;
  +         done = !chan->configured && list_empty(&chan->desc_terminating);
            spin_unlock_irqrestore(&chan->vc.lock, flags);

  -         if (!configured)
  +         if (done)
                    return;

            cond_resched();
    }

I may be missing something, but I think this is the basic direction we can take
to eliminate the potentially long critical section.

Thanks for the review,
Koichiro

> 
> Frank
> >  static void dw_edma_device_caps(struct dma_chan *dchan,
> >  				struct dma_slave_caps *caps)
> >  {
> > @@ -190,20 +213,25 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
> >  static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	unsigned long flags;
> >  	int err = 0;
> >
> > +	spin_lock_irqsave(&chan->vc.lock, flags);
> >  	if (!chan->configured) {
> > -		/* Do nothing */
> > +		dw_edma_terminate_all_descs(chan);
> >  	} else if (chan->status == EDMA_ST_PAUSE) {
> > +		dw_edma_terminate_all_descs(chan);
> >  		chan->status = EDMA_ST_IDLE;
> >  		chan->configured = false;
> >  	} else if (chan->status == EDMA_ST_IDLE) {
> > +		dw_edma_terminate_all_descs(chan);
> >  		chan->configured = false;
> >  	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
> >  		/*
> >  		 * The channel is in a false BUSY state, probably didn't
> >  		 * receive or lost an interrupt
> >  		 */
> > +		dw_edma_terminate_all_descs(chan);
> >  		chan->status = EDMA_ST_IDLE;
> >  		chan->configured = false;
> >  	} else if (chan->request > EDMA_REQ_PAUSE) {
> > @@ -211,6 +239,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
> >  	} else {
> >  		chan->request = EDMA_REQ_STOP;
> >  	}
> > +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >
> >  	return err;
> >  }
> > @@ -544,7 +573,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  			break;
> >
> >  		case EDMA_REQ_STOP:
> > -			dw_edma_terminate_vdesc(vd);
> > +			dw_edma_terminate_all_descs(chan);
> >  			chan->request = EDMA_REQ_NONE;
> >  			chan->status = EDMA_ST_IDLE;
> >  			break;
> > @@ -616,28 +645,49 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >  	return 0;
> >  }
> >
> > +static void dw_edma_wait_termination(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> > +	unsigned long flags;
> > +	bool configured = true;
> > +
> > +	/*
> > +	 * dw_edma_device_terminate_all() may defer cleanup to a later interrupt
> > +	 * while the channel is still running. Retry until the channel is
> > +	 * deconfigured, which marks that termination completed.
> > +	 */
> > +	while (time_before(jiffies, timeout)) {
> > +		dw_edma_device_terminate_all(dchan);
> > +
> > +		spin_lock_irqsave(&chan->vc.lock, flags);
> > +		configured = chan->configured;
> > +		spin_unlock_irqrestore(&chan->vc.lock, flags);
> > +		if (!configured)
> > +			return;
> > +
> > +		cond_resched();
> > +	}
> > +
> > +	dev_warn(chan->dw->chip->dev,
> > +		 "timeout waiting for channel termination\n");
> > +}
> > +
> >  static void dw_edma_device_synchronize(struct dma_chan *dchan)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> >
> > +	dw_edma_wait_termination(dchan);
> >  	vchan_synchronize(&chan->vc);
> >  }
> >
> >  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
> >  {
> > -	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> > -	int ret;
> > -
> > -	while (time_before(jiffies, timeout)) {
> > -		ret = dw_edma_device_terminate_all(dchan);
> > -		if (!ret)
> > -			break;
> > -
> > -		if (time_after_eq(jiffies, timeout))
> > -			return;
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> >
> > -		cpu_relax();
> > -	}
> > +	dw_edma_wait_termination(dchan);
> > +	vchan_synchronize(&chan->vc);
> > +	vchan_free_chan_resources(&chan->vc);
> >  }
> >
> >  static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > --
> > 2.51.0
> >

