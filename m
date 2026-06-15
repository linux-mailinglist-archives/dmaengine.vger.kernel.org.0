Return-Path: <dmaengine+bounces-11523-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gc1bN0seMGokOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11523-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FFE687D8D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=URBlJxK0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11523-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11523-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 196BB30DBA49
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310B4071D0;
	Mon, 15 Jun 2026 15:41:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FA403129;
	Mon, 15 Jun 2026 15:41:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538090; cv=fail; b=eAQiwId7Tv5ytDstCPiZUzQzQ1fdwR5Cs0EPrRI5MNalw26P6zqFqTcYbaPkfsA7O/ExFyiL4IigZDu82uh1GEqNZ0hLYXKBEil+GofZLFvVyBHpxFQFDtmD49iqawt2uEZ7s4/+Q8PFjM2dl8S89bGQS5vsL8D+McyJ95rwOzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538090; c=relaxed/simple;
	bh=0ao6nskdGoZ0j329mM8vLigR0TJ/4bNzeIk7E+4o3M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ma0EtJzA3UoakXdh/2HEXHH7infsoqq1F3s+Q0UjovqpySUBIDaLBinmHbwAdzpMnuERJm74UimDToxKr676GjKgjc//kqd3c666sOTUQrKyvS9g7B4fHGgv09ToQOgwzDoC2XsA6Uj0RH2WjuNSjJPYuDiCtOf4XvifEEebQs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=URBlJxK0; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut0YQ9N/7gIj49W6sbZpgMILcZQ8kC/vXBrAHqeMwLZIhTolqOqvPvr3H6TjSlrJ+4ebRdek6U9fTc7Y45eFSPLNauIp4zAK7NZsRu3gRcky6exNPokxH/PWH4c8+2FQCfwjt9rlGqFXyCpvQ3B/AGbg7QAN5MElukKI7JImgTJUNy8tuedPdoLi1OUEe5dyrU2ftNgRmsNAECgAObH2DaKwDJ7eZ3RNf0OnWOQrElvFhbVD/TtliZA6yxNuBcsrYpt4H+SsmGrEWenzrrCP1LbtTSZatGRlg9jbVzizFAQu+adySugBwUr662KEKBJAU9wFzax3azXiW2eG1yvMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALq5lzzq/5mTtk1PnYz9h9mBUSw/EhMWjpLxVUNEDlM=;
 b=hJKSv74xh5/qpPDmzD5S5xl2XMZbghgOBzuiY+YqgpXcsbejyIBepC9u5/Lwvs47Mkpr+KQmZvCQSjrNxGsejCUqXW7n/04pUnQaU2bPG0D4pwNzIoKZlbdrbnjmfybdpYlVr8+0BlVeYmm4dAFaMrUPVWEvvX57jVNn9ORk8YKgINgVO2fyBAPKeANf2m7I3c2QQ1fMBIUKRy8mC7PEK7RUBNzxHr7zuDhxh0lIsQk7sBmsth14moQcFW6aD2pe73McBJNl/ELU+ojdrdPfdMpXq1JttTt5wER5QZqNYQyolc8ExDlhBTaXofrrXd+VAYoFnVUkLHbx+aCthIvWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALq5lzzq/5mTtk1PnYz9h9mBUSw/EhMWjpLxVUNEDlM=;
 b=URBlJxK0kl3CrGy6K9OCIWup0Bn0BaKHdmFx+Ks552qsxtSgzaYBAU3WSRNYRpGRRo8f9yPKX2Ja4zO31txNpEUPLyWGW5Jso20UeRfbUmrydqvqR5TNikVS+DWYREUvlI0uV8v/Tl5ErC8iFZjBmP2q6Gj/MWAEPKK/SWhC6ZI=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] dmaengine: dw-edma: Fix residue burst index in tx_status()
Date: Tue, 16 Jun 2026 00:40:55 +0900
Message-ID: <20260615154111.2174161-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c69f8df-8774-45ac-3bca-08decaf48d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	nqlR1K60iEZvasVDzBmZ8Q9q5OWG+E+XXXeTLt7k5gC7zS3hSgpVjQap104pxyIX82MVbpm3UWfVIukhw8DEKDbkf6Rc9jyvnAZwlJthpWj82W+LqF36DM/cQJNWWihzEVv3/0MoXrtfyk5H+kzz32A0dmVvu4I9rU5cDjYIs6A/6bF3rOqEQ8I7XUUwG6A0HcSEavBHegjXBvHBsTLY/hvvUxv7RoSi+7dpg6UV1ZZ6ki6YkCGqvd4ZoXya4dq6LGw5Vvpa+lnJYODET84Q/OgEU9tZJjqAZtpSmTnD7DZl7GEx73sKluoF8Zgwa2y9Jw/a9T1GMad6jPU431kXOXBvMTK2uQ5BZWjyZUSBbXl0CiSqd17GFYGPj5HHjeH7AeboPYmSUPrIwhs688ao6/0cWf9z0FNvy2qNdwFbwB+KsCcfjicT7Mbt3dz/BQJMuVOiac0lrKYESNsWHZj6u17XuIUwZ+UrhHRxqk/5/CvU+01i4r4s8RBER8AEjRQaad8NlPs8uS94vwO1UpRHgdC85gmA26+2VQTlFqoKO4PMVYD4TflInh8xb+9IZlMOwX4JJN/zDbcg/RurpmfjGylZwwNDN35mSbvxMpjsXcVXk6J5dkRbT5ME7XxImrsqNIhXxqaijGao6FVH3Qu3jHwyWZpRyEHOA1aYvidkktX2Kb4XxxmekZBv/jv+o7vu8T02tfXRGen0wGAY/9gzs3rxEuM3rTePQ3BdDhh63vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ho50ifTeqJ/+zp5feb0zSr36JfbKIly3UF7BKMi/rGgevmRjVBSUSguTR8v7?=
 =?us-ascii?Q?ee9LtJlhI0WQbkRYpVpjECO8JCkuspL9Lil2HPRDBAkNGBnFLbeshvIJxihX?=
 =?us-ascii?Q?0UVqxbZfDiSe356/dLCmHxIUFFCfPGqk7uIeKa7jh/1sr/xYQsTpse/IdQch?=
 =?us-ascii?Q?wlj/2czQoefOGukUy8jqjmJzZl1PMFeZZRWiTMhPUVMrLEpFM0EW4HLsvTzE?=
 =?us-ascii?Q?PfGR/OZxc024mua4jFb7DeFORoBzjfCabDn60N48ZcnhJ1eZelJo1x3nbGyh?=
 =?us-ascii?Q?8PesuPHBZrAPgXye9R46gYkZnbnfjQ93SLz6FyAm4D/GECJF7HJId/lu0heQ?=
 =?us-ascii?Q?j73f28qBZNsrjVRRV6mS/h1MddZrjAZwGGnV8OqpLMSz8yFpvgVvX6dhIMLw?=
 =?us-ascii?Q?U0UZsNIQ+k0Nw1pgtXPpwSFwIqVdtc7PqI6rJj0dr3Jc52ii4iNATRM6EeGn?=
 =?us-ascii?Q?+M6zTU43Acxetv3aJEXgwKqMlZ7yEeD/OsZSPAY+C7cG+SMy13KIG+GUJNjj?=
 =?us-ascii?Q?pJC3eLoklq063IVOkvlDTSZz1h4Zdif8DYdSseAlUBGOC607yGUknHmDdzSg?=
 =?us-ascii?Q?HrCJEDu4Dg4VW64MQoAaOa3ghW0k1FzLiiiN+QgCfDlje6+xpX1RQVORyD5d?=
 =?us-ascii?Q?8QP3KS8RTGbN15CKSnLngDKLm74zX5N37t2hGuh8sVdj2o4m66TWaubpv/Wg?=
 =?us-ascii?Q?LmqvY6BTJ4IgL7H41xTawe5PGy+Jbt41YmeTczeMxQmxw3UL9rbgIk1i31+j?=
 =?us-ascii?Q?gakYkSvsFTxu6cGBJSuF0QyLdqLcCy7bQnOxPyddG3E6DUiI/TQzhyIDizhc?=
 =?us-ascii?Q?2CUc7Wr8Lj/NFzNSIhh3od87x5TSevUDMTR3DN6YyyXf0hOFuDjS1DkBDlhZ?=
 =?us-ascii?Q?dr1bc7Dig4jxin/ULioRrmJft6z39D2tumeRnXHeuD2y/ofiAU4jIQ298gc7?=
 =?us-ascii?Q?+If241m3YEWj/pZIJbzs/FoEcvHqJnO3o7XGtzQ1qXcIC9Ek5PRmL+GWwdVh?=
 =?us-ascii?Q?JwnWJOh9tXHDVZNCMIkjmjd/mpiVgbv/AodU7dKGTDJLNVjVTATbHyD3hxGz?=
 =?us-ascii?Q?5FMzLlr8ArgrFLCv2eKC26CULeTajLCgTaDDIK4GIkkoVxe6jlcqzYCNhMJJ?=
 =?us-ascii?Q?0cAi1E0W5zTA5TaKIksRlEmSrpyD3DaFabc8GQWcbbQRwg4plxJRelO334IP?=
 =?us-ascii?Q?NxQTistvIKdNz5V0elJEYGLz31i74ChOwrdJ3r53mEyMmzXPM+UYC3arcqzl?=
 =?us-ascii?Q?x1R5z12r/uiJPMoQpX8UIwKYSP/vHh+RkGEXglJ22DXob+zBFfK7TYVijnLk?=
 =?us-ascii?Q?8t+TJohMKr/ZCZUceKwGGxnMKcOLDq325oxVgBLsgMooYf+sxvloAdUls/jK?=
 =?us-ascii?Q?KgcQUhWAQGYbToUYIcFxeeiWLdkN1ZcfJDcuKk+envLTblrmYzO2/TYlr3si?=
 =?us-ascii?Q?DKXHv8DlQteVzyMRJpAmlgCMHazOe5bWEuIoyrxGdPX6+OiGd2jz93f8aSM3?=
 =?us-ascii?Q?MEpjEepOz6AvWbST8d2rldGzhKVX7eLQ2llnVkQP7c3oOlQmjxU+tHsQqeKS?=
 =?us-ascii?Q?1zCjp9GlFxXMV2hnkUbrB7mnY4kccV0PM/S+Qjs247eJ5ecrwxqOW9S1Heu0?=
 =?us-ascii?Q?Kw/P7QJYXF97toJ7t+l3II4Oh6EHNYWppd2kvLzqLXkC0KCW0eXveyJWESnk?=
 =?us-ascii?Q?G4oWw7m5l1C3MjeEjwJ/xxNOOrFCdcCQ8m3zpZAR3Es1NcbJ7mbwSIlpiUAK?=
 =?us-ascii?Q?OZZG8UEsf6uvBZ6FzLdEVmZaOv6K1yatqYoedPBwXYQyOfwEWmW5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c69f8df-8774-45ac-3bca-08decaf48d79
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:22.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar4ljr5ZLlBEmgso1tyKCXtxX0nNB2MKOW0Agm0rvYKwUsDpdnE6s/Aji3Xzg6X2bMiCJTVTi/TteD8HytHX1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11523-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56FFE687D8D

dw_edma_device_tx_status() uses desc->done_burst to subtract the
completed byte count from the descriptor size. done_burst is a count of
completed bursts, not the zero-based index of the last completed burst.

Index desc->burst[] with done_burst - 1. Otherwise tx_status() reads the
next burst's cumulative transfer size, which under-reports the residue
and can become a one-past-the-end access when all bursts have completed.

While at it, return early when txstate is NULL and drop the redundant
desc check after vd2dw_edma_desc(). These are minor clean-ups since
dma_set_residue() already tolerates a NULL state, and vd2dw_edma_desc()
is only reached for a valid vdesc.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
@Frank, if you plan to respin 20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
and agree with this patch, consider folding this fix into your patch
when submitting your v3.

 drivers/dma/dw-edma/dw-edma-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1c8aef5e03b0..d99b6256660a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -244,7 +244,7 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 		ret = DMA_PAUSED;
 
 	if (!txstate)
-		goto ret_residue;
+		return ret;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_find_desc(&chan->vc, cookie);
@@ -252,12 +252,11 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 		desc = vd2dw_edma_desc(vd);
 
 		residue = desc->alloc_sz;
-		if (desc && desc->done_burst)
-			residue -= desc->burst[desc->done_burst].xfer_sz;
+		if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-ret_residue:
 	dma_set_residue(txstate, residue);
 
 	return ret;
-- 
2.51.0


