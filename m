Return-Path: <dmaengine+bounces-11724-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1YXOh9WOWojqwcAu9opvQ
	(envelope-from <dmaengine+bounces-11724-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 17:34:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1B6B0C5B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 17:34:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="TU1/FzQ3";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11724-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11724-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F13B3009E3F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FE3C063E;
	Mon, 22 Jun 2026 15:34:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CA3C0602;
	Mon, 22 Jun 2026 15:34:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142490; cv=fail; b=CAj+zRfSRkn8Wb4gKKZ7TJoJVWKbtQZECRVV2K0sPF3jUYI9PU2Z8oquV0wRUQ4o3oNGuhN2LGb3vwBHepycTyPoz010jmINL5iJqxFfsQv+erytz9kWFJohSX7eJG5lcgqMD6T3K2qiZyHX2teOKM8y6oTQ0+OPspV3DF1onvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142490; c=relaxed/simple;
	bh=IugfIN0CFTaEs368m2AwzzSPT8p7xWMQIn9tEo01OAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HCY7MldD94UDFF06gPrgcoFwsEu8Tm1m0ga2FCfMxJf7q0IAc8dk7PXAAzXTIw4Vlz4FKdCb519b3ti+qNIYko1nHL1Xm2KW8vY/9H7DAJSahIsY4QzdHU+FF1kxYjS/BsL1c9fWnFgdOjxXH4bJ5NcKzTlMOXybutN+khSRwjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TU1/FzQ3; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M09INQPMxkcKAP7LRdWDI6RGdsbtOXoowEJbT2IHIHw77YOiqmJFurYDchBXf5l4JWvSL8FZVzyKw8+6l8wOUAiRSh+iTaKVSIi8sb9/MIZfs3tL1hm2bVr7RidfHlWdfcx8GxKiGlHOwjpt+61WZGZL+B1Rye71kdTfIUezexQEk5AI9ot2OXbD44umFgUgEZ3JC23Q/Fh3t5On5DOyDVKPi5Lb+LrWHPy+omq/YkPhiljSBv8MQxAzy1+jnYtyykkD+Mn3RRGbFerxeXZ3xkV3tyKXk3GnniP8Q7/utcf48Xbmp9CXYLmSmnkRMZgCkK6FynVyxSjIZRfwESPAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFN9JkQf/Q3y2vWORdGfog3e4Y788jwTn/5bs6s0Oms=;
 b=kYgd4R7whrXgVoYhNfV5KTjSueg5/HYvfeY0ut+vgKFfcAwKCxQF7X1jZgouHNb17YibnV8rVCsTQghsIPV64cDSgNEwTKcUIEAGiZm2A4OVe0CdFWv6Zz3ZxPeR7zEL82hicAeRQj7nOjaMoOn/gYV2xtvC3Hb203/2NwLQl6hQosqb+38Y/tA4B5oV2sE5n7ThAug/oc2oa8tR3m9RvHrkAdBZbxQ3FiO3SRhP4rS9qxZUaymfz/5MQjtvsgAN4OaLVqH7VnEZpMeCjQzdhTKgbqxuYng33g5EtTyv+LKVKvC0ghZEZm6lx30KpEnJgKKnPVkKa6AlXw8UgxqqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFN9JkQf/Q3y2vWORdGfog3e4Y788jwTn/5bs6s0Oms=;
 b=TU1/FzQ31SXJ+lgIV0efzci0NXDUZXTmG9Yy2H6dl7X0rlKrrvvK1bvtCUgvryw2gHODtMb9QRUYXi6WBX9G4NWvxcfm+pAdgy11d3KYrlQBIYkQXRFrMPr5uul3fnds1dJ+6GM2C88q0+SkWPcNNi5fdtz5qOxMioXWy1rVdNvRnoJJ1PRchanY05Pd0vwOavosGH7GxF+hRMRawjG+gIyQ8fHXfRKw+K8XBahjndRFJYqODRtX6EXHn9piaN2WyhjQWPh56GjfseUuzSRJfwwpKBu5tVjXxT3v/7e+fe9ML389ff7fROXuWXF/TUL8fOSHQ1epNdod94GklovODQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 15:34:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:34:44 +0000
Date: Mon, 22 Jun 2026 10:34:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/13] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <ajlWCeFlcGFbeLwY@SMW015318>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620170040.3756043-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:510:174::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: afc84685-eb62-4602-eec5-08ded073c82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|18002099003|22082099003|4143699003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	5ikfruyels1aSAXdMyRQuSZmYJTBnXIsX1tg2df4CM51O/x2CRDtjAxS+OJn2XGO4W+FkjuhwrcNGe0ZkbgXbyzXbbZvkVrnLqbQHOZObbJb+KovHDH/dPV3jBYQ1FsNg0hc4FYxVg2sC1cjUnuhQQ8/jTRJmJF9gXbPe4HytN/BOHYj/InBdczHQWPgQ7KxwuNB+Rz0s5PFZwSAbY9b9b/y+m5crxbv4mYBGqxYkLkOQIsqNmysyl4mc9UDor3XP61wqTS92MnpzSL1hpBSR8uyUOadcFgliM7zJnXqzpKjL7F+pNhAcs6cSgo+/YSnMo6jupATENx9ZNB2KM9woWm35mwJvui7MeVHmGBU9brAtoCrI6f4K8svhZDu1B/iWYgTKq9/J/ThG7IP5Yx9eh/+x1tmXg5lL0IoLgglXq+AFm6U/9GDL2+GstC0ULz7R4Fw09NSg4GuSa8FpYt63PaO+0on+wIa7NDbT6SOuPFxGLo6gLAeOkIZvcZca5Me+G2aF26zKDOQvQ2oUivGrL+yGHt0IimNYbppcMA0xp+GYnlv3AEExY/G/VFw1qfrLJM5lgZTwb7J6jFzxnHFUE9b79rygzLZXDkqsfyZmtImGciEuecv1sUPNW3759yszC6Ai+ONdciuzNMK2biEsT3xzaQVKmOxz63st2Aewlk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iT18nge5TjF443SV5Gyd3ihkr2rS0wpzT4UOwooiwjoxfTRQqjGFQmRqdP9/?=
 =?us-ascii?Q?Rd8mk7gc4R6gtWIoXEFq8C4Kq0/i5VZOCV1TEvUx2lIgY9+1spHjIGZT5eb+?=
 =?us-ascii?Q?e0LiRxjY/8Nl4Ox2KIrTSYJjJHYqLiiew55O611yEPnSkysHC8hpzf5Ww2Vd?=
 =?us-ascii?Q?UnJ8E2TlhvDQtpjVXfr7jbWCg1n1kF0lVwQ+AM2mdiwjlbv92uRuiab1UgFw?=
 =?us-ascii?Q?7zuntOZQY6aE/NW8dz4oxTUBt6I5mcXailzj/mgcGHFlKtb7ndw6N7kc4G7w?=
 =?us-ascii?Q?MYnfQAsig3mc6g8kEhWbufxTV3KJRr2dd+uFrNGZRVcI30pBhMxKMl4wuDpj?=
 =?us-ascii?Q?Wq/NBu8nLGDMo5Rk29Av9EFU+hNQekizasiu8xosF+5aS8DjruqHxOKQvvum?=
 =?us-ascii?Q?GQ4/HHo6I2IXyxp3codDpLPCBs9XLSX8i5jFJfiTbtLvi1IegaTA6/s2MHRl?=
 =?us-ascii?Q?3VRzIuW4TsmkvKFkrR3y7IhruEKLghghjajbAVW5KFxGu/RcFYglVIQbgF93?=
 =?us-ascii?Q?/h2DlZiKpu/QWLMeMNTdSf0EF5rXdkFc1BevuKeViz5Pjr7aT7Eh1yqCgj7f?=
 =?us-ascii?Q?5M13ecxMUWmK2r4I9tyr2YxcnsFtCCyHGwd2ufy/OuAfdFhAUALx5BwfpYfb?=
 =?us-ascii?Q?WfiFM2ymSKbM+Yvt6QTmxwTtc0vQLliFIiG3c+3TWR6pZyo7a828zHfdxwD2?=
 =?us-ascii?Q?Yt2lSAIuooXEKU9pHwY7Y7NEkagewoRhpdm2PgKjuHB5egF6zB8RuTX5BHNB?=
 =?us-ascii?Q?9N+PbJOMFbl8X04en7BdNrjttZB4Lb9SbZf7QFwnVjiK9V9nZ06dsbUtRV95?=
 =?us-ascii?Q?q+0T0rAEIEGqpHWbOPOOIFU4hHibCnemG0IBQ/rudKAw/T5kXpqQtmPDTUTs?=
 =?us-ascii?Q?iulU/NSyhf6EuH/Y/GD1EMMQiyBZRFvltpExCJzWtTOPSv4ZtqdGjGEGeLAK?=
 =?us-ascii?Q?lHjHEebWvcsKJRjFH1Pss0U2mTbPXUHOccaUpQz/2irbKwy5+PViBEMWG+iv?=
 =?us-ascii?Q?la6e/IBBhRH5AmOGjvg7JugJNPTpdQEs0tWl+pJfiTgw1bOnBE3DD6dejSgc?=
 =?us-ascii?Q?GCPcBG9XFmuuJWGSOZTCRj0pr68s1zBqoyOBGUD9VzCulxPE9YGNOUWWS0lo?=
 =?us-ascii?Q?wHINw47a59EX9pt/MELsWd28+sGeTNtuHsmsjM6UT2ysggrhtixRpk0WjF3J?=
 =?us-ascii?Q?aM8YHrfAvdJd+HiNQze2vAjQ9KJQylxD/Y2XvCfzTXbJDz0tbUTCWhXQ5Wna?=
 =?us-ascii?Q?4oeQ9YYjScndXZejEclVhzk40K6A3vzsF6XXIvXUsgN7tRTpZdUVaz0aXfsB?=
 =?us-ascii?Q?CfdC/mP5D065F7sqpucWv7zrei3GL778SMjEL0gNbU0RB+ZqEnfkAxAWOIhA?=
 =?us-ascii?Q?c/WLNR0JEfIzT9mhij68X7uY2bsg8x3piWsuPwUcXWiZdhyqjzrCqq9b6o+H?=
 =?us-ascii?Q?2Dj1Cn6xplyZ0KXdaMwpReLKay0Yqu7oWn6blgYvMiuV71zxtiJcOknRlFTu?=
 =?us-ascii?Q?cxNbgj1Lz8vtKvvB1WXp9pV/WooPJZETmp1NrxPXENEtZjEvFFQCwBUAQsMP?=
 =?us-ascii?Q?qFN460We1IRuyC3JXpo/PcWPbh9QoCiLdE5VS3lVqPenHwGSqQaLB/s3b7L2?=
 =?us-ascii?Q?r/0Sd10BUQVCwpxZro7Jgg7Op4F2ppVUCg4+HGBpz1OEbwVMsQmSBT7NQLdu?=
 =?us-ascii?Q?tgZ2cvQTbn4tLS1oYFi4Y++nktr4lbCvwxCWlHMk7V2f6gKZ49ezWesUWUvi?=
 =?us-ascii?Q?F6jNvOCwRFuw4rH9jBrqNhTT0JM8LdA4u8kNeQZtN6hhvw6SQLjj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc84685-eb62-4602-eec5-08ded073c82c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:34:43.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Umm0NT2DJ7pvLLbURaXTNrwE8D98xeh9aarNcpcymoFp1AmNmasUvlgxR6AIbPRww52bQEroLbArmV2YBTZ20ovNmy248+uTYJ8BlDMhslMRXm9Tb+der8uvm1R1mjWL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11724-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,SMW015318:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEC1B6B0C5B

On Sun, Jun 21, 2026 at 02:00:28AM +0900, Koichiro Den wrote:
> DesignWare eDMA can signal completion locally through edma_int[] and
> remotely through IMWr/MSI. When channels are delegated to a remote
> frontend, the local endpoint side and the remote host side must not both
> service the same DONE/ABORT status.
>
> Add channel interrupt routing state and initialize it from the
> controller instance configuration. Update the v0 eDMA and HDMA native
> paths so linked-list interrupt generation, HDMA non-linked-list
> interrupt enables, and DONE/ABORT masking follow the selected mode. For
> HDMA native non-linked-list channels, use the dedicated remote
> stop/abort enables without local stop/abort enables.
>
> Keep the existing dw-edma-pcie host-side instances in remote interrupt
> routing mode so their IMWr/MSI completion model remains unchanged after
> local routing becomes the zero value.
>
> Note that the routing mode describes where a channel should report
> completion. It does not, by itself, say whether this dw-edma instance
> owns the interrupt status. A local instance must ignore remote-only
> channels, and a remote instance must ignore local-only channels, even if
> such interrupts are unexpectedly delivered. Otherwise the non-owner side
> could steal the interrupt from the owner by clearing shared DONE/ABORT
> status.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v3:
>   - Remove DW_EDMA_CH_IRQ_DEFAULT; local routing is the zero value
>     (Frank).
>   - Set existing dw-edma-pcie host-side instances to remote interrupt
>     routing in this patch, preserving the legacy IMWr completion model.
>   - Remove an unreachable HDMA native check (Sashiko).
>   - Clarify local/remote instance ownership after Frank's question.
>   - Mark non-owner IRQ handling guard paths unlikely.
>   - Add HDMA native interrupt routing while keeping the existing non-LL
>     int config ABI.
>   - Keep HDMA native linked-list local interrupt generation enabled for
>     remote-routed channels while masking the local edma_int[] output.
>   - Use remote-only stop/abort enables for HDMA native non-LL remote-routed
>     channels.
>   - Drop the peripheral_config IRQ-routing ABI; initial routing comes from
>     chip setup and channel ownership handoff can override it.
>   - Keep dma_slave_config from resetting channel ownership routing.
>
>  drivers/dma/dw-edma/dw-edma-core.c    | 14 +++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++
>  drivers/dma/dw-edma/dw-edma-pcie.c    |  1 +
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++----
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 41 ++++++++++++++++-----------
>  include/linux/dma/edma.h              | 30 ++++++++++++++++++++
>  6 files changed, 99 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 89a4c498a17b..7a24248b84e9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -219,6 +219,17 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
>  	}
>  }
>
> +static enum dw_edma_ch_irq_mode dw_edma_get_irq_mode(struct dw_edma_chan *chan)
> +{

dw_edma_get_default_irq_mode() ?

> +	struct dw_edma_chip *chip = chan->dw->chip;
> +
> +	if (chip->irq_mode == DW_EDMA_CH_IRQ_REMOTE &&
> +	    !(chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return DW_EDMA_CH_IRQ_REMOTE;
> +

return chip->flags & DW_EDMA_CHIP_LOCAL ? DW_EDMA_CH_IRQ_LOCAL : DW_EDMA_CH_IRQ_LOCAL

> +	return DW_EDMA_CH_IRQ_LOCAL;
> +}
> +
>  static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
> @@ -853,6 +864,8 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>
> +	chan->irq_mode = dw_edma_get_irq_mode(chan);
> +
>  	return 0;
>  }
>
> @@ -904,6 +917,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->configured = false;
>  		chan->request = EDMA_REQ_NONE;
>  		chan->status = EDMA_ST_IDLE;
> +		chan->irq_mode = dw_edma_get_irq_mode(chan);

if already set in dw_edma_alloc_chan_resources(), needn't set again?

>
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 6474cacf7195..42f2f25ef377 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -81,6 +81,8 @@ struct dw_edma_chan {
>
>  	struct msi_msg			msi;
>
> +	enum dw_edma_ch_irq_mode	irq_mode;
> +
>  	enum dw_edma_request		request;
>  	enum dw_edma_status		status;
>  	u8				configured;
> @@ -224,4 +226,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
>  	return dw->core->db_offset(dw);
>  }
>
> +static inline bool
> +dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;

is it okay to simple return false here?

> +	else
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..70ea031147d1 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -419,6 +419,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dev = dev;
>
>  	chip->mf = vsec_data->mf;
> +	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll = non_ll;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index cfdd6463252e..1781ba4f022e 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -256,9 +256,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> +		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
> +			continue;
> +
>  		dw_edma_v0_core_clear_done_int(chan);
>  		done(chan);
> -

clean up these unncessary chagnes.

>  		ret = IRQ_HANDLED;
>  	}
>
> @@ -267,9 +269,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> +		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
> +			continue;
> +
>  		dw_edma_v0_core_clear_abort_int(chan);
>  		abort(chan);
> -
>  		ret = IRQ_HANDLED;
>  	}
>
> @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  		j--;
>  		if (!j) {
>  			control |= DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)

you define DW_EMDA_CH_IRQ_REMOTE, sugget don't use reverise logic.

	chan->irq_mode == chan->irq_mode

>  				control |= DW_EDMA_V0_RIE;
>  		}
>
> @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
> +		/* Interrupt mask/unmask - done, abort */
>  		raw_spin_lock_irqsave(&dw->lock, flags);
>
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {

I think need also check chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL

> +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		} else {
> +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		}
>  		SET_RW_32(dw, chan->dir, int_mask, tmp);
>  		/* Linked list error */
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 2beec876b184..7ba6bdbffc17 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -49,6 +49,26 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_READ, ch)->name));	\
>  	} while (0)
>
> +static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
> +{
> +	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
> +		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
> +		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
> +
> +	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE && chan->non_ll)
> +		return val | HDMA_V0_REMOTE_ABORT_INT_EN |
> +		       HDMA_V0_REMOTE_STOP_INT_EN;
> +
> +	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
> +		return val | HDMA_V0_LOCAL_ABORT_INT_EN |
> +		       HDMA_V0_REMOTE_ABORT_INT_EN |
> +		       HDMA_V0_LOCAL_STOP_INT_EN |
> +		       HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_ABORT_INT_MASK |
> +		       HDMA_V0_STOP_INT_MASK;
> +
> +	return val | HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> +}
> +
>  /* HDMA management callbacks */
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
> @@ -132,6 +152,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>
>  	for_each_set_bit(pos, &mask, total) {
>  		chan = &dw->chan[pos + off];
> +		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
> +			continue;
>
>  		val = dw_hdma_v0_core_status_int(chan);
>  		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
> @@ -238,11 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
>  		/* Interrupt unmask - stop, abort */
>  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> -		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		/* Interrupt enable - stop, abort */
> -		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> -		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> -			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
> +		tmp = dw_hdma_v0_core_int_setup(chan, tmp);

Can you use small patch to create helper dw_hdma_v0_core_int_setup() only

>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> @@ -293,17 +311,8 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
>  	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
>
>  	/* Interrupt setup */
> -	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> -			HDMA_V0_STOP_INT_MASK |
> -			HDMA_V0_ABORT_INT_MASK |
> -			HDMA_V0_LOCAL_STOP_INT_EN |
> -			HDMA_V0_LOCAL_ABORT_INT_EN;
> -
> -	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> -		val |= HDMA_V0_REMOTE_STOP_INT_EN |
> -		       HDMA_V0_REMOTE_ABORT_INT_EN;
> -	}
> -
> +	val = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> +	val = dw_hdma_v0_core_int_setup(chan, val);
>  	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
>
>  	/* Channel control setup */
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..c0906221a7c7 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
>  };
>
> +/**
> + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> + * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
> + * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI), without
> + *                            delivering local edma_int[].
> + *
> + * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
> + * bus, and remotely using posted memory writes (IMWr) that may be
> + * interpreted as MSI/MSI-X by the RC.
> + *
> + * For the v0 eDMA linked-list programming path, DMA_*_INT_MASK gates the local
> + * edma_int[] assertion, while there is no dedicated per-channel mask for IMWr
> + * generation. To request a remote-only interrupt, Synopsys recommends setting
> + * both LIE and RIE, and masking the local interrupt in DMA_*_INT_MASK. See the
> + * DesignWare endpoint databook 6.30a, Linked List Mode interrupt handling
> + * ("Software Programming of an Endpoint's LIE and RIE Bits for Linked List
> + * Transfers", Attention).
> + *
> + * HDMA linked-list watermark interrupts have the same LWIE/RWIE guidance. HDMA
> + * non-linked-list mode has dedicated local and remote stop/abort interrupt
> + * enables, and the remote CPU programming examples use remote enables without
> + * local enables.
> + */
> +enum dw_edma_ch_irq_mode {
> +	DW_EDMA_CH_IRQ_LOCAL	= 0,
> +	DW_EDMA_CH_IRQ_REMOTE,
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -76,6 +104,7 @@ enum dw_edma_chip_flags {
>   * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
>   * @db_offset:		 Offset from DMA register base
>   * @mf:			 DMA register map format
> + * @irq_mode:		 default per-channel interrupt routing
>   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
>   */
>  struct dw_edma_chip {
> @@ -101,6 +130,7 @@ struct dw_edma_chip {
>  	resource_size_t		db_offset;
>
>  	enum dw_edma_map_format	mf;
> +	enum dw_edma_ch_irq_mode	irq_mode;

This are already have flags dw_edma_chip_flags, not sure why need irq_mode,
suppose, if set DW_EDMA_CHIP_LOCAL, pre channel should be default as
DW_EDMA_CH_IRQ_LOCAL

Frank
>
>  	struct dw_edma		*dw;
>  	bool			cfg_non_ll;
> --
> 2.51.0
>

