Return-Path: <dmaengine+bounces-11585-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id obSiAh0NM2qe8wUAu9opvQ
	(envelope-from <dmaengine+bounces-11585-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 23:09:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F264069C7BD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 23:09:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=K3cHcdSV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11585-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11585-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 082B7301F335
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA673F5BFA;
	Wed, 17 Jun 2026 21:09:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76293F8EB3;
	Wed, 17 Jun 2026 21:09:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730579; cv=fail; b=ayYSPHTJtdzWAOOqAHwGJSseHwfid6IQ2r8bGlxviWUF6FpqMHO+FuGpSIoNB8vHxrW36tVT1g/XNuBuQYGOS6fxYVyUcYHxbIeATSGZgwKr2XcPlIHWpwI76dglLrsF10Kw2bIpynlJa+79qseAgyRYMzdN5N+mAo+rxxSug3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730579; c=relaxed/simple;
	bh=RoNXEyWoRLR8h5RxByN8zEw4TmvPkfb0RvN4F2RqzIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V3DMjqlfRJEYNrRByAql8droZccCkPD5Ex3u19LBgdHC5AQ1Nd5GeVWWCoih3FefTLDnXw/f7HACGsCnODPJD76DNMTIKS/cogvIFDnAH80jUKCRHt/HxFVM0ryqwKzLvfGhbrUimqOWkQxngQWkAzfA+SW0Vq0gHWOoB2YQjug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K3cHcdSV; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD5P631hlFI77wsqel+RbOkzX25YbuKWEkM3BL0l60CTu8bG4eX3Ydezcbo7XOsBVtgHU43swVjgDc8FeeyYcdEaIet2rJxVSO6IjOEbszlrL0V3fiAv0eXskDBJMqpHyvuERPdqpL99YeKjljzR0sjRsErcJ4mNW9+JNltDDew+NidRap9Ja3JrC+VjFq7qLO71+KjSMDapBv3Nda783/x+7s6VXVJs/Hl55ocLQOU3fa1ZbxxG/uXpg3lmCT7+WsUkT5744lwgg8wRA+tsJDoStHk6YdmI5kVu0iJVM6ze89bbJwjsaFSHcs633ND8BddeuuoYFa/9LzeybU/j4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxEsGnPivQ+M1Ti3bQOTE3SJgZlfBHz8H4bpWiPYy5A=;
 b=kF7cbaFkZ40Bp4Ls+dvWn+fdMs3nlrC2YmLWvuDjVXy5xbEz0Tdrb8ufwF64xiLS23okFM7Smd+/sUAb/BpfPGASsOWA5MQ/jo6RRNnsDxsAsBQmI6uf1CVP2qaMT/Bso+AgY7clpQs27z3o+O2Io20d/Pqc0ZvJj6ldR2/Oif3ULyUSLJ+Jo6TxKAk3ChgEiFxO9sMg6QfZBve25QgTTaK6rGsoAHj+Jd9sySpR+0Lh4JG3kO5AEhYtxFPOJpNIvE8OjrIc2r/O2VuVXnpbeG0RZVfeu4LpqcQZ6GEP6t3Z6RszOTxwJdJZNyHTC9uBuQPIXCGiCJf+gV7AJc6ZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxEsGnPivQ+M1Ti3bQOTE3SJgZlfBHz8H4bpWiPYy5A=;
 b=K3cHcdSVuWS4qy3+PzeKgNbLdO5CBhAAfhtb6pjRzVDesPxZOfbWD7pvx1g8VrQ+gEosa1i0fxvEeh0mBTfpHZBsx0z0XGLIuFHQ4Cf7jXGhpLapoRKaszcBtqMJMAiM3TYE0U33iSUT8qOKIri5qXs5ipIdVY6Pk+TfCqFFrmONMEzf6YXlFCKSn+pdKnSIMwKq071Ad8Bovt8UBfFYCOBSXQ6l9Om6B64lrGnnh2Jrk2CPx5jCLIQz4R5oj9sPMXqKB0PQ7ymCDrLHn+UpX7GcrQJKlxVZMtkZ09fMFWX8/s34S3wf65MoLCS4ctJVJAzBKns9I45Jwi3PSJRlzA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8641.eurprd04.prod.outlook.com (2603:10a6:20b:428::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 21:09:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 21:09:34 +0000
Date: Wed, 17 Jun 2026 17:09:26 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Bogdan Codres (Wind River)" <bogdan.codres@windriver.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, dave.jiang@intel.com, vinicius.gomes@intel.com,
	xueshuai@linux.alibaba.com, yi.sun@intel.com, fenghuay@nvidia.com,
	dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix use-after-free in idxd_free() and
 idxd_alloc() error paths
Message-ID: <ajMNBgdsvdLPCt7X@lizhi-Precision-Tower-5810>
References: <20260615103932.61828-1-bogdan.codres@windriver.com>
 <20260615103932.61828-2-bogdan.codres@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615103932.61828-2-bogdan.codres@windriver.com>
X-ClientProxiedBy: PH7PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:510:325::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: b84bb7a1-e015-457a-a846-08deccb4bb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|7416014|376014|366016|4143699003|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9uYhUx3cm59/NX4ZRleYiW/1az+5ERK5fm5bYXoMXU6m13wp5CAiSJyq8S1yOHlHu2y8NPRTZEp8NuED7AZIeN/ujw+uZ7igmqP07wnQttrkOrxaOHdLYwBtmw6ItBNe4wnW11J6lK9HzwKHlu0cUKVQ8XXZ2EyEMvzndnZb1s/7Ybb7zfkIs7xrzMIlwfPbfkjo/V98QNCeVd/CfTruIjZmgtqVknfRoPt+0jKLgL+joN0uDpTfJ8OweENyPFFgSIEKRptLLX7KDg1m90ZJPuk8OKBFoUSgEapUUUfUE64zuIs1DyNzeneMgQ0ORPl3NJqzbsK1cw+Dgtz7bCDfAulKJgjqNmcAmCHtwiDnrT/0e0wbR2KseVa1Xcys3fQHm0OJqX7ex5vO07HrQhn4AmRBaZEhXVjGRSJrOUtsGG+OmroMtYGxM61RpxQWX4obi2L7di8+hyyyhRwwp2j6+NUUEzISEiT6e8fwyr9p1hEThOjk9TgWfYPH82yeLjwVCpGtR8v+U78EkkqWC4UJaRfmD8dqLdK4dnduuwLfEpO3VRpqlrMl5zZOmp0h7kSKRJhXQmaQGxR6IgcrD4vFhfnLriWbbbOO9EMxbTpVvvpOD4k4VHk1gyykvB0XBnH2ykuIxZkJ/jI5vVlS0lsx+lz6ILzbOxUVU0pY3LlFQcSQMqwZlaANJ9cNP3yGpCZn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(7416014)(376014)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrEX037ulbqMA94NkU2NE3bh3BEMNmplBtNlavbZOQboPM21UqXjmAY77yDf?=
 =?us-ascii?Q?rsy3b6lUQtJqlIW2/kajuiGLHheBgEklZ18DPh+CBLdle2u44gphhRpQLrsp?=
 =?us-ascii?Q?x4Lrq59VpW9T8voSSzX8dUvBr8GU4l7q2YYgClp8li7iGGEE+yhEoLtEh7q3?=
 =?us-ascii?Q?J6bFWhudj9egY5cBJ7a0lA/vpwrDgxdIqaXxC58mXSF2jAhVyOO8+66jPAvC?=
 =?us-ascii?Q?jrUfhwrZvt+d8LjimSHUmX3Oh0KPv2HAOcB9wMXDp58iOrjQWuGEUblzzAxk?=
 =?us-ascii?Q?C9ocvk7IojvZjeCAOX7WZkJ7toJyc+WDFGMNM4D3BPpUpieoD50+QOCy0Bjc?=
 =?us-ascii?Q?mBs+e6PqKwF2vNY5/VH6VcZOUmBzgWdiYbfPikHMvn87rHHBAG4nUa0oJU/T?=
 =?us-ascii?Q?TviLlj3HpxrbExLLZ/EgoNsmGH3orHdLDOif/3D8f63kGuNPdbfB5Dk5poei?=
 =?us-ascii?Q?KUMcP11f+tIefJsHf4u8Wi+dlyWcB25Yhwsy4i7Fo5KlmJVp81Wquj6aZ4Ak?=
 =?us-ascii?Q?1hyCeENpOZD+U4v6FbraYGNLgirAATfZHmhH4o87lr5pfZajaZlJwHMAIRa2?=
 =?us-ascii?Q?JhAoC+WksujFsfr1xh3qu33E7eTONcmQmBXuwjv15bhgF03ocTSJCshWm4WX?=
 =?us-ascii?Q?Fqlt7aSWPs0I5h7uN1YIOnkHOviONBd2w85xln0ebMb4y4NyCZ4CRtBaVpbS?=
 =?us-ascii?Q?egA+S7UxfNXyuVyLvej//FuT1gEBQAIo470jAGUVI8fpRoA3U22kNuezsVOk?=
 =?us-ascii?Q?F9li2Rvwh/+sSlbrPS/C48G5aFxI+W+tFsJExO4V+jAsriHJC8HsYl849TC3?=
 =?us-ascii?Q?tVb3xSdQmY9WfXrOty9MFy/rq54IMqVQn1XFmSkxN3qspYl8f3VIM8k+xDdg?=
 =?us-ascii?Q?cEMsTyvK8RCsmZFKJzYDeJdeoIAfqUhxz40mgi4+DSVk5/k4CuFU3Ujtq5aK?=
 =?us-ascii?Q?XcbUWnmrEtrL0HPAs7Y0LpUwSQ+l0VgSBGYxWof5EnRPIbJZ2DH+xSd638uk?=
 =?us-ascii?Q?wAoDCGCm6rm5M0wRj91LJzJYZbURDMSDFKUkmeNdPgbInh1mNZQ7DzCE5TAe?=
 =?us-ascii?Q?3jEAjLlFZscKn7NufUytXvi1ncA91gzBP5jRQwRoxTLcTXO8pzIDeEQEq0q5?=
 =?us-ascii?Q?itQA+44ZsO/TEUSmuoEuMIu63RKzcZDIGSk5K/J4FUQ0ZPAKThauAM130+VY?=
 =?us-ascii?Q?fn0QBQID8lAwNyIGm2Inb29C+s9ehT9dB0s8ICD2c6dItitG8UqCtNunCM/m?=
 =?us-ascii?Q?KDPCqY7npekk+RXb+SBQOSQT33raRh1fTSWsKGkjiyzOi3y0cvEwnuDyEGp3?=
 =?us-ascii?Q?E8ljyQbZpZIU3ReMI+EiXSqS7fmSw1m80ojIZocfnHSTcjUmij+5Bp8zwZQZ?=
 =?us-ascii?Q?aHWOJvsY1HiEjpEflvlLqRUHl5tXCixLcfIDKfyvx66e2OnojeRXM+HD9uKa?=
 =?us-ascii?Q?4AMBxJHiEHuSPZt/quFgEE6q2o6cmgS+wdo0JEWektAiSI5ZXCJTAFVQLiWz?=
 =?us-ascii?Q?Z1qTdWBvBhJvHAK1TGQsuMmi4yWUtg9sZxXYXnmkq6p4trqQKlJs+gEuZSU8?=
 =?us-ascii?Q?EEylFuj1XTo9QPQIlCIzZgUZBe/XLcSYkBCrqej5AJgw47g2OZUn65N39csu?=
 =?us-ascii?Q?0RR+43Wwj3WbaZIyrgHiD822IZztpWsJrT26CZjjLnBNoYZnylGzmK2dLUeb?=
 =?us-ascii?Q?FhJHXTSbTjNUzVp0AKoE2fV7Dg57BswTTDxh86/sCX92N516fAHEBOS/uVsM?=
 =?us-ascii?Q?GtQMknOorWmIwdR4qGIMN+B2FnsOEqFsavNc6SV/0IIaK5rxwH3x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84bb7a1-e015-457a-a846-08deccb4bb26
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 21:09:34.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc6ZLXS4Fi1NRPY0AklrbTFc3MJ+AKxMLEy3R4iG1Ils4//DerQkKCpP1gj6qspF9e1iOmB6Mu47MJS5F5MmQafSeSKH7fLG5qqgbaDG3rphbQRQ0uC3AA0ppvQZm4+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8641
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11585-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bogdan.codres@windriver.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vkoul@kernel.org,m:dave.jiang@intel.com,m:vinicius.gomes@intel.com,m:xueshuai@linux.alibaba.com,m:yi.sun@intel.com,m:fenghuay@nvidia.com,m:dan.carpenter@linaro.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,alibaba.com:email,intel.com:email,nvidia.com:email,linaro.org:email,lizhi-Precision-Tower-5810:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F264069C7BD

On Mon, Jun 15, 2026 at 01:39:32PM +0300, Bogdan Codres (Wind River) wrote:
> From: Bogdan Codres <bogdan.codres@windriver.com>
>
> We have the following backtrace:
> [   18.628791] idxd 0000:00:01.0: Device is HALTED!
> [   18.631447] idxd 0000:00:01.0: Intel(R) IDXD DMA Engine init failed
> [   18.631450] ------------[ cut here ]------------
> [   18.631451] ida_free called for id=0 which is not allocated.
> [   18.631462] WARNING: CPU: 0 PID: 11 at lib/idr.c:525 ida_free+0xd3/0x130
> [   18.631467] Modules linked in: idxd(+) idxd_bus wmi zl3073x_spi regmap_spi zl3073x_i2c zl3073x i2c_mux_pca954x i2c_mux ipmi_si acpi_power_meter i2c_designware_platform i2c_designware_core acpi_ipmi ipmi_devintf ipmi_msghandler
> [   18.631474] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.12.0-1-rt-amd64 #1  Debian 6.12.40-1.stx.140
> [   18.631477] Hardware name: Dell Inc. PowerEdge XR8720t/0J91KV, BIOS 1.1.3 02/03/2026
> [   18.631478] Workqueue: events work_for_cpu_fn
> [   18.631480] RIP: 0010:ida_free+0xd3/0x130
> [   18.631482] Code: 62 ff 31 f6 48 89 e7 e8 bb 1b 02 00 eb 5a 83 fb 3e 76 36 48 8b 3c 24 e8 ab 74 03 00 89 ee 48 c7 c7 70 d6 bd b4 e8 7d 1e 36 ff <0f> 0b 48 8b 44 24 38 65 48 2b 04 25 28 00 00 00 75 37 48 83 c4 40
> [   18.631484] RSP: 0018:ff59485680267d58 EFLAGS: 00010282
> [   18.631485] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb53064c8
> [   18.631486] RDX: 0000000000020940 RSI: 0000000000000000 RDI: ffffffffb53365d0
> [   18.631487] RBP: 0000000000000000 R08: 0000000000000000 R09: ff59485680267b40
> [   18.631487] R10: ff59485680267b38 R11: ffffffffb5336508 R12: 0000000000000000
> [   18.631488] R13: ff2c9dd3800730c8 R14: 0000000000000000 R15: ff2c9dd38385d800
> [   18.631489] FS:  0000000000000000(0000) GS:ff2c9dd3fdc00000(0000) knlGS:0000000000000000
> [   18.631490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.631491] CR2: 000055e2e7678098 CR3: 0000002003450005 CR4: 0000000000771ef0
> [   18.631492] PKRU: 55555554
> [   18.631492] Call Trace:
> [   18.631494]  <TASK>
> [   18.631495]  idxd_pci_probe+0x1b0/0x1860 [idxd]
> [   18.631502]  ? set_next_entity+0xcb/0x1b0
> [   18.631506]  local_pci_probe+0x43/0xa0
> [   18.631508]  work_for_cpu_fn+0x13/0x20
> [   18.631510]  process_one_work+0x179/0x390
> [   18.631512]  worker_thread+0x237/0x340
> [   18.631515]  ? __pfx_worker_thread+0x10/0x10
> [   18.631517]  kthread+0xc6/0x100
> [   18.631519]  ? __pfx_kthread+0x10/0x10
> [   18.631520]  ret_from_fork+0x2d/0x50
> [   18.631523]  ? __pfx_kthread+0x10/0x10
> [   18.631524]  ret_from_fork_asm+0x1a/0x30
> [   18.631526]  </TASK>
> [   18.631527] ---[ end trace 0000000000000000 ]---
>
> When an IDXD device probe fails (e.g., device is HALTED), the error
> path in idxd_pci_probe() calls idxd_free() which performs:
>
>   1. put_device(idxd_confdev(idxd))
>   2. bitmap_free(idxd->opcap_bmap)
>   3. ida_free(&idxd_ida, idxd->id)
>   4. kfree(idxd)
>
> However, since device_initialize() was already called in idxd_alloc(),
> the conf_dev has a refcount of 1. The put_device() in step 1 drops
> this to 0 and synchronously invokes idxd_conf_device_release() via:
>
>   put_device() -> kobject_put() -> kobject_release() -> kobject_cleanup()
>     -> device_release() -> dev->type->release -> idxd_conf_device_release()
>
> idxd_conf_device_release() already performs:
>
>   ida_free(&idxd_ida, idxd->id);
>   bitmap_free(idxd->opcap_bmap);
>   kfree(idxd);
>
> Therefore steps 2-4 in idxd_free() operate on already-freed memory:
>   - step 2: bitmap_free on dangling pointer (use-after-free)
>   - step 3: ida_free on already-released ID, triggering:
>     "ida_free called for id=0 which is not allocated"
>   - step 4: double kfree() corrupts slab freelist metadata
>
> This is consistent with the pattern established in commit
> c311f5e9248471a950 ("dmaengine: idxd: Fix freeing the allocated ida
> too late") where ida_free() was removed from the cdev .release()
> callback because resources must not be freed in both the .release()
> callback and the caller of put_device().

The basically it is simple double free problem, can you summary it in
commit message to keep short and leave key message.

>
> The path is extremely rare in normal operation because:
>   1. IDXD probe only fails when the device is in HALTED state
>   2. The device enters HALTED state exclusively after reset_devices
>      (kdump boot parameter) or unrecoverable hardware error
>   3. On a normally running system, IDXD probe always succeeds

This is not related this patch, regardless how rare, it is code logic
problem. You can inject error anyways.

>
> Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
> Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
> Cc: stable@vger.kernel.org
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Yi Sun <yi.sun@intel.com>
> Cc: Fenghua Yu <fenghuay@nvidia.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>

except CC: stable, other should be put after ---

> Signed-off-by: Bogdan Codres <bogdan.codres@windriver.com>
> ---
>  drivers/dma/idxd/init.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index e55136bb5..b76f0d12b 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -586,15 +586,18 @@ static void idxd_read_caps(struct idxd_device *idxd)
>  		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>  }
>
> +/*
> + * Release an idxd device that was allocated (device_initialize() was called)
> + * but never successfully registered. put_device() drops the last reference and
> + * triggers idxd_conf_device_release() which frees all resources including the
> + * ida, opcap_bmap, and the idxd structure itself.
> + */
>  static void idxd_free(struct idxd_device *idxd)
>  {
>  	if (!idxd)
>  		return;
>
>  	put_device(idxd_confdev(idxd));
> -	bitmap_free(idxd->opcap_bmap);
> -	ida_free(&idxd_ida, idxd->id);
> -	kfree(idxd);
>  }
>
>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
> @@ -634,13 +637,16 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	return idxd;
>
>  err_name:
> +	/* device_initialize() was called, so put_device() will trigger
> +	 * idxd_conf_device_release() which frees ida, opcap_bmap, and idxd.
> +	 * Do not fall through to err_opcap/err_ida.
> +	 */
>  	put_device(conf_dev);
> -	bitmap_free(idxd->opcap_bmap);
> +	return NULL;
>  err_opcap:
>  	ida_free(&idxd_ida, idxd->id);
>  err_ida:
>  	kfree(idxd);
> -

unnecessary change

Frank

>  	return NULL;
>  }
>
> --
> 2.43.0
>

