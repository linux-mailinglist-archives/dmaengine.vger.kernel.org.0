Return-Path: <dmaengine+bounces-12348-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wN3aJahVUmoFOgMAu9opvQ
	(envelope-from <dmaengine+bounces-12348-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:39:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D494A741CDC
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:39:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=GhP3MjGN;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12348-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12348-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5351D3022615
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22472BE033;
	Sat, 11 Jul 2026 14:39:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6B26F476;
	Sat, 11 Jul 2026 14:39:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780767; cv=fail; b=Dxj+XIJ6zttwNenkYRWZHSlVyee2gCrsiaRhITkptBLqI1eR+f2K3qztRZ3vJdt3H3VttOXHPtqvm2ol2oQWxRcESPVhMawDOnr2v951u+rQuib1LcEeuG/bm5shYJ8oIuLngk8Qq5xKTvec3A7vnsdDAlg0G9iqF6XMXaY8l7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780767; c=relaxed/simple;
	bh=lKVL1CGYZxsqD7klmF0HHmoNvvmWZKBTf8fVMipxXO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/n68c3+029ldrOqmr+TT7DVD1oe3fDpRkhLjPQJZI2yq29ymkIIznjIOiUZcQFLAfhn/5APpdv22M4Vc5vn1bM4K1cBKJANgmbHO3Y+leZJwUki463xz510dxKTWAKOtIfuXPbtBz0PU7Ui+SPUjW2jlIVAk5kH53DvknF6V2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GhP3MjGN; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNC7tkdmwh95pFozD5y9IHGOJAku9gtiy5HazVMdrKSxF7RWtpD/LThSTs2/JVgVusaaVcdV1V9DN7eS9WOxQwBjJVb2ztqW13OLE0UAldQ8LWmFX/e1WDRCagdcfy+wf0roBhp4HeUW6aMxAAvnmtzxqcNck/ihr3KdZhruANEWeB/WB48tLWn/oFTWSse0JUmg5rGxgMbXaQ/Kty7LoCY8fBG55+tUh0P8kQyZh67CXVVXN9CGbGKP8v7kGwG8rY/7w2LjuuHsM9ZwFthEGemoGD4HKWlv9aHcMubD8xisYYMXDwrWD3EVwZEuP/NjZJWSGAj8OQXNw0m2uegvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxaAWkbt1lo5HKHQ3RA8dBZb1R1SD8xNreWEHt0Uafg=;
 b=oVrFmr2Sog5QXjpK0T7CHU7vX96e8uiilsvxW2WxsfQ6wKCDC1p48OFx7pNRdph6AZeg22EYUyaS6OkyLNcSIwXPJRFn2NgdFJUdhV5AhN5MmvnnD19Qfwl/UAleDCysN0T9IU3fO5M56CC5nXgzss/IVNvxb+dXiXRnKZL6PkPKy0GnI1vws/sINyr1fh+9O2Y4ydRH63zjep7swOob/6qDTmNQqi/mhUc9dr+eHmMd4s4vomf4UMjJWGFru4GNGp+e21/ixao5il3f88lNC7U5TlKl+1PfiILO6d8yXXLpzvDFtQkHi5R+5mFGT1+JpJfPMaT5tT8C78M+VZyysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxaAWkbt1lo5HKHQ3RA8dBZb1R1SD8xNreWEHt0Uafg=;
 b=GhP3MjGNHqtycXLQSKu0BIajWxSsr23/N/Z10ED6K3BNTmdoWxFmB80lkWbUzrxZL9FWUAWpf7wEmRvGACzDIHMmxp+i9wFi4eXVCTDyCzs5RWMu60XYLTsfEvzyJH30sfZi2Q2L8FNiIkF3dwWSyT2+dvzWEhv7VE+wnGf3LuOS7hZ4/Aovv6x895iOs6EM81JVdBOcNpxKOvYQ7DyKGbmMbRb1kIttSxkctXoNw7YRNVtg7Or0bj4RaAedTcp88BaXZtDf/+oJzvZJQdaQc/3C7L7iWoVwxlMXST9IHcjrdXbiRbOT2YznZjSCOsYyIjO7+Mwmn98s6kIr+ncwQw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10282.eurprd04.prod.outlook.com (2603:10a6:102:464::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 14:39:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 14:39:22 +0000
Date: Sat, 11 Jul 2026 09:39:11 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dmaengine: dw-edma: Clean up vchan descriptors on
 termination
Message-ID: <alJVj8DPMizmPj4G@SMW015318>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080903.2392888-4-den@valinux.co.jp>
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10282:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b18a28f-24f9-43e6-0fc4-08dedf5a324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|19092799006|366016|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vu9f7x1ZV6ZSLL6U2nl6VLmnR+pwJrU6p+bBC4tlJDE/470VNylPWGrMSFPMruX9qCtgj5nkHklpDAvZSQUd5nxr4tbOierRhJLsjiz/GTrBRNJYtw0Rlsf7JBJ+odeUiznhZetPSXpgjM9DttAwj8ws7+eV2hawD1ntkJ/+JWThtOPY933US/EBfs75Ht05ZntNnTTVmMjRWSmMKVYtdiXnd1B+Vu9KyEYfD7smMdWXEvnSDEOiT26ULqseB0sKqORuA1Vjn7TYlOrVUeLG3BZq06d0ad8usBci/d2r+32qJOhxGZJ9FMysQfOas5etOBI4IJ8a9DccUcwm41kqGvxZxmHncWaSwTLPJHwH41+aIwaevj8MMyu4qs5qJISN1V1oMeuWvvoygSpArHvYqbQBFBbZMLwtXq3zwondzf7mWunHExkZskqmxtdL9lc1ZzvkaOgTsy2aXMZJq1TnPD+2DXJ7QZuTOmk5zV6EdSqOdbDbLO/0/axJCz5vbYHAPgZK7EZ25No0pf9Wxdk2zKHMFlR0/1Jx5tWgKoRYl7FW+mf2NV684Tr16+KXel+4fMGkGO7isNPo1aTDTZUrnDtrpGwzo8uxcXTawZXkTe+9wwmLc9hnaWpUZXyYeQP2KIL3729gYWUAAVZI0M5z7hCFQCLYuA0p0RtIgMmv/zQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(19092799006)(366016)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSM90+lt/1t8e/mvWcI6vzW/0l0Etc3k8QmAhz7oU/rCUWW2ekLILuothYJy?=
 =?us-ascii?Q?/tTXCA7hZy3whbgWaMc25MIUzPqAQbMd+GtlWRaWNLsUaana/OvdNNuqI3vt?=
 =?us-ascii?Q?nsqJ5nmL+wv12GRqmTQDeQZSOVDhxMsUN08uKFSyfg7wFazKiASXJEXa+/J3?=
 =?us-ascii?Q?UbzzzcMFVpmGLHoqW76E+CEVcf55yFUlkFE3ulHshJrvecDslxgd2zsK25je?=
 =?us-ascii?Q?F7PmKp3AEJyNq49zQgbZ6ltkQjRL5yVXGHrHf+W1tDz9DE/hCKc8XFEbL4+E?=
 =?us-ascii?Q?oFvpntqhgP48dw+b4m9GqrmEdfz+lBIt8UnJtl/jVsal1WF8/U+lEmfBN9am?=
 =?us-ascii?Q?r67CQt7f0f0QrKS5xZXgciWiYzEzMjyEY3Wf5lQkgxoPjoPtgEp7Fjf4YOxg?=
 =?us-ascii?Q?xJma7lEUJ1oT38b2x7VZH18/s84Y6pQinqfVEjfRLVOUV3kxQ+ms3sIlYhzb?=
 =?us-ascii?Q?UJEnj/SDMVV2XFA5758EImwpVRfdEsMpUlZZFGiPN3Y5s5XCoaOt6VO2qewW?=
 =?us-ascii?Q?cbOBxzjCrghvuugyeNl6eI2v2+LKvlpdHQsel1Tkg6ylAvbxKiGsNBuzESCt?=
 =?us-ascii?Q?t4udWAsY1q9suqLIE9vbO5k2RZLX/hUfymu17ZlmvBewot2pY5n64Y0Ch21S?=
 =?us-ascii?Q?mEoY2WuNfFUkJn3yYz5lzo4q42C/5uVBqhwd0qSHsJzE81Ga3KIQWHduamnW?=
 =?us-ascii?Q?u9ifVydniIjBUlnD2Zpunmt1cVqr8MGmFJuL15SrFiRofXoEtEPY8SbWNH90?=
 =?us-ascii?Q?qPAneMUSiRSlpf/IIiGd6SBKI24W84fMBJu1t7JOTrVtSFWCjLfW+fgSnu+5?=
 =?us-ascii?Q?ie6JL5hgGoZAGs254lfOtnJQD9/NqzNkk5H7LLw2BNtuk5JfU8zTXDsQiWE4?=
 =?us-ascii?Q?cWl4MTOJkD3j3Ogrt+VPXNIFnRpWHtPzIY+A2wNVQN/c6KoqcWIK/MuooMxT?=
 =?us-ascii?Q?joWpfFeOP+AYeri/VahEI9EtGP6JU6dYnDGAD/gqhfs9Lc884TP3Lp2OmWn3?=
 =?us-ascii?Q?b8BxED1X1dB3zTguAn9aKnTveD8uVCdWbUy+TyRwvVyl/3pA1bz57zo2fFA7?=
 =?us-ascii?Q?O/6qWpEJqhR0fo5K+NhyhJHr3G4jVFiY/JIaCy1u504wI+mwGGRrOxx24b5t?=
 =?us-ascii?Q?/tQE6u+j6qVbCXEQzKsA8ZY154dqeQ91bvWWROmcrfxxkJ1WxARDwR9XZJtu?=
 =?us-ascii?Q?krk7VV8hOMl73nd59RuuOwd8lEYn4eLSfgl5aYS0tykX40jUWzAXYHOVFPVX?=
 =?us-ascii?Q?RfhshP2W/BX159aVh9b7+a+Bia3H2GaiXgx1tIfMypW3uzfhFZtPlPtrWl8A?=
 =?us-ascii?Q?QQ8yyvJQEJjLCpzxZDUaStl42dP6J1QLGUWal0JjEvY1alTUCKGqaXzQnIRa?=
 =?us-ascii?Q?NRUhLzXfKC61Yap7ITlRLy0YGSuvHl+PBBNJ7hFSuVnyMonP9MhhOjhBOgXa?=
 =?us-ascii?Q?LtOjqyepjfIS9+PDFnzQlhnJKjxlHbrTViR2o6ueSRpS3THWLUoi7R3TquFp?=
 =?us-ascii?Q?UYteJCnqVA2QJb2PwIZAcNYntPnh6CPe+4Ea1/zOnRYDLG2jaaXP3nfekx8A?=
 =?us-ascii?Q?XBlF+uURSgEBQLd5BEhv3kxfCS1RB6vm04ue7NQHaLhNFBySi2cbuVTgf7Fd?=
 =?us-ascii?Q?NXwNTCsMcJYcDZGfcVVJhou9ZjnV7gRkgUMqt6wo9NUzSWvc37+DmlMHQ/ne?=
 =?us-ascii?Q?9aPv6lEqyGLaegBoh7D8H4tQyGCpsszPrbEQ8mSC1o6bue+pThkhw3ycKuWe?=
 =?us-ascii?Q?59QSLNqQ3q9skQNjUM7N/u2CYRiS5XWyXKFz5liBKn7xRvfvoFBm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b18a28f-24f9-43e6-0fc4-08dedf5a324d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 14:39:21.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rCW7q+A4ZYLCaCsJdad9uVFAo5EyWBJEx4rEWGKxIL35sNYeYgpK8RIA0mhY3AiU7EAVWMG7TeV0qGQBMcmcAZHORGIuibCEHlagVdqAeZJPG7QIktFTnUd9tqu6Pkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10282
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12348-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D494A741CDC

On Fri, Jul 10, 2026 at 05:08:59PM +0900, Koichiro Den wrote:
> dw-edma resets channel state from terminate_all() paths, but pending
> virt-dma descriptors can remain on the submitted and issued lists. A later
> issue_pending() may then restart work that the client already terminated,
> possibly into buffers that were already reused. Descriptors that are never
> restarted leak instead.
>
> Move issued and submitted descriptors to the terminated list whenever a
> termination request completes. Also release virt-dma resources from
> free_chan_resources().
>
> If termination was deferred because the channel was still running, wait
> until the STOP path deconfigures the channel before synchronizing or
> freeing virt-dma resources. Otherwise dmaengine_terminate_sync() can return
> before the deferred STOP cleanup has moved issued descriptors to the
> terminated list and before the channel is known to have stopped.
>
> The old free_chan_resources() loop usually broke as soon as terminate_all()
> returned zero, so it did not effectively spin until the timeout. This wait
> can now last until the existing timeout, so use cond_resched() instead of
> busy-polling with cpu_relax(), and warn if the timeout expires.
>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - Poll with usleep_range() (and include linux/delay.h for it) instead
>     of a cond_resched() busy loop in the termination wait; each
>     iteration does an MMIO read that is a non-posted round trip on
>     remote setups.
>   - Split out into this preparation series (was patch 04/17 of
>     the dynamic LL appends v1).
>   - Let dw_edma_free_chan_resources() reuse dw_edma_device_synchronize()
>     instead of open-coding the same wait-and-synchronize sequence.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 79 ++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 4e0dc52397e2..1b493c104a5b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/dmaengine.h>
> @@ -15,6 +16,7 @@
>  #include <linux/irq.h>
>  #include <linux/dma/edma.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/sched.h>
>  #include <linux/string_choices.h>
>
>  #include "dw-edma-core.h"
> @@ -208,6 +210,28 @@ static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
>  	vchan_terminate_vdesc(vd);
>  }
>
> +static void dw_edma_terminate_vdesc_list(struct list_head *head)
> +{
> +	struct virt_dma_desc *vd, *_vd;
> +
> +	list_for_each_entry_safe(vd, _vd, head, node)
> +		dw_edma_terminate_vdesc(vd);
> +}
> +
> +/* Must be called with vc.lock held. */
> +static void dw_edma_terminate_all_descs(struct dw_edma_chan *chan)
> +{
> +	/*
> +	 * This order must not be reversed. Cookies are assigned when
> +	 * descriptors are submitted, so desc_issued contains older cookies
> +	 * than desc_submitted. Completing desc_submitted first could move
> +	 * chan->vc.chan.completed_cookie backwards when desc_issued is
> +	 * terminated afterwards.
> +	 */
> +	dw_edma_terminate_vdesc_list(&chan->vc.desc_issued);
> +	dw_edma_terminate_vdesc_list(&chan->vc.desc_submitted);
> +}
> +
>  static void dw_edma_device_caps(struct dma_chan *dchan,
>  				struct dma_slave_caps *caps)
>  {
> @@ -313,20 +337,25 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
>  static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long flags;
>  	int err = 0;
>
> +	spin_lock_irqsave(&chan->vc.lock, flags);
>  	if (!chan->configured) {
> -		/* Do nothing */
> +		dw_edma_terminate_all_descs(chan);
>  	} else if (chan->status == EDMA_ST_PAUSE) {
> +		dw_edma_terminate_all_descs(chan);
>  		chan->status = EDMA_ST_IDLE;
>  		chan->configured = false;
>  	} else if (chan->status == EDMA_ST_IDLE) {
> +		dw_edma_terminate_all_descs(chan);
>  		chan->configured = false;
>  	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
>  		/*
>  		 * The channel is in a false BUSY state, probably didn't
>  		 * receive or lost an interrupt
>  		 */
> +		dw_edma_terminate_all_descs(chan);
>  		chan->status = EDMA_ST_IDLE;
>  		chan->configured = false;
>  	} else if (chan->request > EDMA_REQ_PAUSE) {
> @@ -334,6 +363,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  	} else {
>  		chan->request = EDMA_REQ_STOP;
>  	}
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
>  	return err;
>  }
> @@ -680,7 +710,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  			break;
>
>  		case EDMA_REQ_STOP:
> -			dw_edma_terminate_vdesc(vd);
> +			dw_edma_terminate_all_descs(chan);
>  			chan->request = EDMA_REQ_NONE;
>  			chan->status = EDMA_ST_IDLE;
>  			break;
> @@ -862,28 +892,49 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	return 0;
>  }
>
> +static void dw_edma_wait_termination(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> +	unsigned long flags;
> +	bool configured = true;
> +
> +	/*
> +	 * dw_edma_device_terminate_all() may defer cleanup to a later interrupt
> +	 * while the channel is still running. Retry until the channel is
> +	 * deconfigured, which marks that termination completed.
> +	 */
> +	while (time_before(jiffies, timeout)) {
> +		dw_edma_device_terminate_all(dchan);
> +
> +		spin_lock_irqsave(&chan->vc.lock, flags);
> +		configured = chan->configured;
> +		spin_unlock_irqrestore(&chan->vc.lock, flags);
> +		if (!configured)
> +			return;
> +
> +		usleep_range(1000, 2000);
> +		cond_resched();
> +	}
> +
> +	dev_warn(chan->dw->chip->dev,
> +		 "timeout waiting for channel termination\n");
> +}
> +
>  static void dw_edma_device_synchronize(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>
> +	dw_edma_wait_termination(dchan);
>  	vchan_synchronize(&chan->vc);
>  }
>
>  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  {
> -	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> -	int ret;
> -
> -	while (time_before(jiffies, timeout)) {
> -		ret = dw_edma_device_terminate_all(dchan);
> -		if (!ret)
> -			break;
> -
> -		if (time_after_eq(jiffies, timeout))
> -			return;
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>
> -		cpu_relax();
> -	}
> +	dw_edma_device_synchronize(dchan);
> +	vchan_free_chan_resources(&chan->vc);
>  }
>
>  static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> --
> 2.51.0
>

