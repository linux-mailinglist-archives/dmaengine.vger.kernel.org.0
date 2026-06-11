Return-Path: <dmaengine+bounces-11463-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NQa5BZ3VKmo8xwMAu9opvQ
	(envelope-from <dmaengine+bounces-11463-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:34:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF06731C6
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:34:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=nonkPmY4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11463-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11463-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684C3300B08D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E473E7BC2;
	Thu, 11 Jun 2026 15:34:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4472C326C;
	Thu, 11 Jun 2026 15:34:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192069; cv=fail; b=pe3kPgybWrUWqxOh2wrs5J3MvCPb0yNIEw8FJMKeGtTdOxMKoFD+e9/fRLCccD0F36Z157dlqg+X5tJKPfM5a0XzaQj6ejE4WWPAhQV+AxlHOMuOD61rf4122uoA+POTaieHAmTUv4fUBV9ac/UrmjeQMSznjlpJZl/EyzmPb9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192069; c=relaxed/simple;
	bh=RLlLwDmL+JEu8xCl/EVVMhwDHNXMqSkMCvIKmNMcKeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGhJDEqw7OfCjuRbJwPuBnuWE4u30u4gD90tnE+K0dVMZZsM+wV1ABe43ZTXbYbs8Pd/7omApISBqVvx+WbPD+WAxpKx1yYIp8rbWe/WzczsjS18qtOwDlqqGSIgTcdIhTh/Pu9uk9mEQBtdjbXVuAKhp73kDLI2IVPOP38Pzds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nonkPmY4; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKXcPRUZoryvqSBxKw/eZXYT2hjnA2jqlf6+UbT7a9KYdrIRCvrmB1bNSEUp03FiJXfzOq/rwklq53i6zk/mfW/99Sz12ivZ1mpmfQr8/CrxOpl3KYSIEsVUIL94CbOYaRaOGXEx86DxnznMsLPutlSp5BS7lroYQVqUsXhwsD5fmDp2+cN0KVXejiuRy1YMLyosr9ArW76zSnMnHmPbSf/evTIjOC3IhUd/920H4TuC3e/7HHieySOB513HnTs7EAurhWLKTqJqwzjrWYTptMlVfFxH7O7M9OCoyEgbyTeqxjjy5Qr7IhmBKehXm68+9OllCHOcFdQ2ImeNIOYS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twdt8wkeP2tCO40sOT6FNyGYCVYwTDR0z4+mm8BwGVs=;
 b=JbGJQpVLF+hp2LCNvE3A0Ns5kI7UdCFAliub9aW9JFE/DdWtNtIwNHB1dUFIexQIsxee/ri5jlfvUiX0Ozw8NJk2RDG1tDniKYAYyP2o6J1Ul1lYHP/ekiE5fRcZ7cw4wRheV+piSFx/7m2B0E3HWKcYZE7umVb79S4QUkqya+wXKYXgVQX5IaamUXH73TeLvxoZoOw/v7fhIcfO9T+sLV3xrRnAgCHroFtacT+Yh0oINDZMSc73SfmI+7o3O07MayoMrjcbinmd69isFvsBgjzUMbuO1ilf7K8CAY/n1Xp3HwT5Zw6xczm+yueLf7ssfW+Pyv3rKxHJNC91GgXXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twdt8wkeP2tCO40sOT6FNyGYCVYwTDR0z4+mm8BwGVs=;
 b=nonkPmY4aiCdLbD2sVjz7EfRwrp1q8kDgcNOwb5CnDioh+i3w37OV7jnhun51SLrwYwqhWRdFeYjiGYDQQ5ytGk35TSWV9vwQoaGcMxmwqQdd0tLWOrV5gqtsaKdbWQ6VDUBuaQNPNzpaHK8FlHDC2/cYMJ7fK++0Bk0kQ6phyO8cqbRThhNYYS95tp7LEneZNSt9haGAI7XBvc4uy3qxPLAWpRjNWXlhS+5xu9BKzrpJ/W9K1YNSyLQHVBEFJA2zaPj4ffz5ovtJujpFHSKCcSQzGz8Z3hB0qpPRjTksYYMpUpjiQVUjMd0isHp/evmbygj6y/2u6+QKOh4oyN+5A==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12019.eurprd04.prod.outlook.com (2603:10a6:150:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:34:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:34:24 +0000
Date: Thu, 11 Jun 2026 11:34:16 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv4 09/15] dmaengine: fsldma: use devm_kzalloc() to
 simplify code
Message-ID: <airVeJM2YjZtPE7i@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-10-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-10-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8597be68-28cb-4179-bdff-08dec7ceea66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|7416014|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R3G2F0S0qMCqDLA3pkpDrbjo+HzHN9wV/kft5Ug+pRlHuuQ0pjdV2cMVHqkXkrLhIC6peodOu0PkhFcf7B8MT7gaRwE7XLwwJQsD2tPPpVYPz/qN49jJx007Sp0a2UVXnzrhMrDxbtBhGh48qzuySm5RhfjSbBJSWZmVz01bbwvDAtZU4itaL7jyKUznHfu+NqXys7xSplaAuOVVAT66tnxYNFYYTrIC7BB8oKwvdpwn8dw8lB7B5DrmFoDpOGlJQBrGlpoUvRCFX4VT2vaC0U4aiZ01cqXhB8zkBlpqmLkCqOfylILH6ADxTuZwEi8OHNyWxiDzC/xBzQ8LKGHC/vXLdS0ouIhTUvymr/2JKJFFvfDedmgZkpIgHatecnWTbNplmDPSNdpJkwjBKp55YMIKZxF37G8eVCiKGox/zcO6NDXXOGy6BcwDtH6lco29/fum0LWCeTfD0sExWvmgqEwYcNKG687O/9DidAyqV10G+EBKpVaXkU8icWggpdjP6oc3zuBFsVu+nvmwwnqHcMDxBFmGaniaZMxyrf2PDt4ZEk5DVGOjzYnuwwJBiY5e0UdX9uf3wE/QtDwN/ulFrfs2jKo/5g5HSoPuIxQqTd+ZSHFCXcTjDquAD/nK7rNcSkHkxm3MwQqBTOz5oG1nzeQq3036J/BpoXwJixGsZP1aaBRSGDUr2S8z10fT08YH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rM7DcnA3qFCjAsE2ARLwXaI/psnRcpShieblpTeb7a4oOBi0w3LsWcl78lNN?=
 =?us-ascii?Q?sN4OCtb8tZfn+TYHRDb8I/T7rt5QyymTFExm97kHLi4oyxRTJ+cBWXm8ABMo?=
 =?us-ascii?Q?wHQ2clGmVMwFyjvFsqNQJTclX5bFN5nNEZ4tdSIzWMzqlfJ5pBi1FySftX2M?=
 =?us-ascii?Q?vKXsL3KORnbvQapkS2pqedWj0uSzY8hjEq2tngTs9DI2mZYiHxz4+hRo42VB?=
 =?us-ascii?Q?BApr7crg2MdJNWdhBUBJFiCkpNCYjn/E6ovdxgmuR21E2sZ826nQlTGZeCwb?=
 =?us-ascii?Q?laZXWdhD9bYJscTzbzKloE6J6k+pwMe8+LjIN7+agHY3KNkvlxKpsdBKO6IO?=
 =?us-ascii?Q?LqEXwkYieJI6yDbGVWrwTN0NTxCl4z8/vbbr5pxtWOndcxcqHBX+a79JHSm0?=
 =?us-ascii?Q?T8sg2GymhIwELbR/TDWVpj0RjqykoWjnVeFT/OUot45En5yWFndSlOj1ucE/?=
 =?us-ascii?Q?x3q1a/yo3QWscngRDWGw/7dEXlVYB54Jr0cyS/gYkE+aDgLazju2h1ZaywsA?=
 =?us-ascii?Q?flODcMqDMbOMq0cRDuwzmQ4+GIMR16veSv0kF/7ZOaYu+PI2F7d2V3r9blXL?=
 =?us-ascii?Q?e7pLXAIpIMC38Gzux+/pU2mzbi/NbCCghRNtdfxkbPBSjDNCvjL+oXRDseF4?=
 =?us-ascii?Q?LjoTNfM+bvmgOdSp470iswKMcI9NyldyfK8nBKwOMQ9TWzQWWHkkdXpuoqCu?=
 =?us-ascii?Q?a0QL5bbpADBFYs6tTKZaS9eKX57Ss5B5ICR7k6RniFx/PnNDb9OERituoD5T?=
 =?us-ascii?Q?FkSyQ7xyuDBl+SnLYXruhaIDYH09siR/m1tuRBaLQ7E6opyRD8q24H0cBTgC?=
 =?us-ascii?Q?fEysBi+7kuyevD2KE/Hick3DgKa1UeIr0VYzxAR8HixyI442tSwH4mbnAQ3Y?=
 =?us-ascii?Q?SXyV8o7cDF1PmEaYSPo09d1cf4snRKD4FYRhCkkz3WhYCxw40mAp/WXWy+yr?=
 =?us-ascii?Q?h0YxQDVTN9GjegQLspZ/W1DFEzgJ/+FRTEsh0vdScrKVpgv9uwOuoPaejWLi?=
 =?us-ascii?Q?d38dj3wY7ZBia/w6uKEXmIaOpxSq9D1e164FrzKHVg8M4I6Zbnfpod0RGF57?=
 =?us-ascii?Q?DAnWU7IDe+vTjEr2LiiNBijHE2tm8L9DDNd5Ist44gqgnLl9LUL6wpafTaPT?=
 =?us-ascii?Q?VVQhlkfv/0vbmP3osc24NnwD9gG61p80DAkF8Ubla3R5zqYhc5cBdM1Fl2lZ?=
 =?us-ascii?Q?tSQQxZJE8TCNLwsMAH71Wvlv8m9SqzJq9d8/vI5xDjNk+RcIpPc5rP/QQuRg?=
 =?us-ascii?Q?/BLuvKqN0gwjXznX992DtSFmPw+ZwqQxgxwmmI8JpHWp9KL2CpFZyZmSbdUI?=
 =?us-ascii?Q?XCkGaH6zm1h5ao+dKIS65LRFIchjBN0jMhDCOS2aHCE5sd8HDLt0lqU3zwqv?=
 =?us-ascii?Q?nwujbGWj5cGSPhlD04lly+hqwDnZ29IctDM0qEoYXqitkpZebPr0Ht2j2KSa?=
 =?us-ascii?Q?E00wDOIMt/nHkL3WTlUftbUtO50tHLWULxg4R+pF4K8F6uSvutpWgkW/s9yf?=
 =?us-ascii?Q?pI/2wrWQad51zXU0G8+/K2Gqh+84KYUbLMiQrlhN+oSDydpSAvd+1FVJ6Y4Z?=
 =?us-ascii?Q?7uJAf+bSH6ClUIuzjujS6fzQ9UIOl14QzYj5NbLi3eExZN0ZDMF+yUDjRxrI?=
 =?us-ascii?Q?yqWJc52OpotK7n0TRZ1B+YM69igk31P0veBsnkRB+kQDujy2t6gVECjX/lMz?=
 =?us-ascii?Q?TbweCZiQEUtPfKFNrk3pMX3EvRszk/RADFcMLpiwtlgQV85xYbhNZED4cM7a?=
 =?us-ascii?Q?0UG89E2nhKOeGAqMsqWXliyemOCXvmriZjkmoJ4kqFuDHNrYdNxZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597be68-28cb-4179-bdff-08dec7ceea66
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:34:24.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU4aKcMdDtUukbFk2Vc7OzF8D43ZGu5Kfvh10zEzzDMngTZc8VnsgRvhKKzbP5aeF8VySHAgGkOPiWfFw44FEZ7m/0+sgzMOy2U2ZIcHm08hIeDxd34Njoj2BHWTIDNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11463-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zh-kernel.org,gmail.com,google.com,lists.ozlabs.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lizhi-Precision-Tower-5810:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14CF06731C6

On Wed, Jun 10, 2026 at 08:52:39PM -0700, Rosen Penev wrote:
> Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
> the probe error and remove paths by dropping the explicit kfree.

suggest direct convert to flexiable array

Frank

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index eba194d64105..c3d2b24f8f07 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1222,29 +1222,25 @@ static void fsldma_device_release(struct dma_device *dma_dev);
>
>  static int fsldma_of_probe(struct platform_device *op)
>  {
> +	struct device *dev = &op->dev;
>  	struct fsldma_device *fdev;
>  	struct device_node *child;
>  	unsigned int i;
>  	int err;
>
> -	fdev = kzalloc_obj(*fdev);
> -	if (!fdev) {
> -		err = -ENOMEM;
> -		goto out_return;
> -	}
> +	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
> +	if (!fdev)
> +		return -ENOMEM;
>
> -	fdev->dev = &op->dev;
> +	fdev->dev = dev;
>  	INIT_LIST_HEAD(&fdev->common.channels);
>  	/* The DMA address bits supported for this device. */
>  	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
>
>  	/* ioremap the registers for use */
>  	fdev->regs = of_iomap(op->dev.of_node, 0);
> -	if (!fdev->regs) {
> -		dev_err(&op->dev, "unable to ioremap registers\n");
> -		err = -ENOMEM;
> -		goto out_free;
> -	}
> +	if (!fdev->regs)
> +		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
>  	fdev->irq = platform_get_irq_optional(op, 0);
> @@ -1325,9 +1321,6 @@ static int fsldma_of_probe(struct platform_device *op)
>  	}
>  out_iounmap:
>  	iounmap(fdev->regs);
> -out_free:
> -	kfree(fdev);
> -out_return:
>  	return err;
>  }
>
> @@ -1361,7 +1354,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  	}
>
>  	iounmap(fdev->regs);
> -	kfree(fdev);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.54.0
>

