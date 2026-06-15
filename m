Return-Path: <dmaengine+bounces-11543-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bi0uAwNIMGo9QwUAu9opvQ
	(envelope-from <dmaengine+bounces-11543-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:44:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53177689436
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="TYF/qRL0";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11543-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11543-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0995C3037DF7
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C03876BE;
	Mon, 15 Jun 2026 18:44:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A2384CFE;
	Mon, 15 Jun 2026 18:44:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549056; cv=fail; b=PxrV5p0WjCqRspTDtMEWiTXTMIdgP6kb+aILuMca6ljeuGq1IKaG8Eeo2mRMqxiKOmhiptXyZtnAOlKdtlyUGANeeM9JYrxuFkpgouiuSj5HCWXd4wTSHf2Wa050r8qSlSiM4o8cysOTB9wFIfRQUBhDJ2T2sc0QhCiHd7nzLBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549056; c=relaxed/simple;
	bh=uP0wPBJvxTA2E4IDCHsuQBrPmuoCFjeRtvg29A0iDVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n4/hy/NXY7DahGAiiF2qhOYLQDOD0IkS42VFfuKFI726A9dn3CHqlzBna4nvJaTCJv9Yq6WAoSLI+hCFrBZpaG2Cej3s95k3k2BNwn+hS+QhTRTeH1uNOBf77GzJto1QjWCqNS5tDlILMnoaRfLPKeyOFh9/ott0Y8Zsne7eKJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TYF/qRL0; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs0MUryCeDvMb6OiUtohAHvIq9fJa8cA4YNXeS80UGia4uOVroe7NJ2xlsF57TURiotZGf3BjEdWhqqmkxmRfoRU6ZSY8fDR3IT2GqkEbhve7iBDIQWbt6izjzXJn/LmM0zMO+LxX9VIgwT7O/dsx/p6xinHjYyibetDByv30bd7oPiVFOfDNkHpoE/5ngOf9KJtOX//lh2YifVxvfgPVf1KyinTHg55jQuIB/cQE9a4zOe6rJ+DYgfCd7ubP+bTbVDXf5pA62B4vI8t5awyZ5C72UHx/iLajwY6rxPqm8PsMs+WZTXl4RqXCy6YLflDD6LG7J0e6u1isC+PVGIvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO0TJenFmfbX0TrxJ/Vc9E/mnahJoBAhQJB46PHHTwI=;
 b=RbBLiSE9rqQBgfhscjefFgd6zvsp7cZ3UnRL1sohZxb9+ADgnQVeGM/TjG62t1QIOe3zwVZBj3c5PAsbIjZL1Xe0DsrAtG+bxXtyTve6+JSZf7cNOWDbn1hmF1aYbzVlDhmdmVLfa0licr9FKRAe/qxvA4KEYPd/zPBUeQhkNjXjJLPevYI0RqoSGN4holZmusuYczTt0G0UBqVOVfLwPOdFJJ+mfSdoTsXcd3+MleP9sMrshi2QkcfggoWLbykeVgAY91ZxePtHJO0HmvDyarAUYOIUL5gqC3aMk/2o9G4FFOJ5/Na0Rj3vB6KisjJh+zRfNs9Uke+EdWt1OPe+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO0TJenFmfbX0TrxJ/Vc9E/mnahJoBAhQJB46PHHTwI=;
 b=TYF/qRL0p/ltJNAwNBRlwiaQaFpO0fcSQbXjkwEUsOZK8zIhTx+6qOFCGt46fIKMe+9LA7swys9+4107JqkScwoXSqJFlsyK+RJ23IwG2v9N7JvMarZalqh45E1fOZDf1yWKuVL06+NHK/JhsoUb2fxzAvL4QDp7QC3Zp/Bvy9mgFzEr22dmkx2TpsAISSG7AsbkZWydwEhTzHvmr2U8bChzd1uzEgaiglNO+Sb/tEBMCu+k2nmMTnbbf5h5Nt6qxI8zrSgWGPMCMEzRUd6lZyzH0gjNKRhr+DT9m3rHJrCBozzhrBC7WN1CEpjvldvRaAJ1Dwv87/skrYT2bFmGxQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB9814.eurprd04.prod.outlook.com (2603:10a6:102:37f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:44:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:44:10 +0000
Date: Mon, 15 Jun 2026 13:43:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] dmaengine: dw-edma: Clean up vchan descriptors on
 termination
Message-ID: <ajBH7rXlNsdM1Tp2@SMW015318>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-5-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3571c7e0-5e2f-4a34-dd63-08decb0e16af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|19092799006|366016|56012099006|11063799006|5023799004|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	YzKbUt6ht8fvKE1UzSa1T8zWk+RjhmiXPBwadLIXy+fJEbti6c/+SU17kV2PyT08G9WEzpWw3ofkqhutDNQedkTaaeZ+ocd0335B9eZDMzDypxQy8edso/Jve4tuZZK2iDoY7/Lx2z9Dm4kLmMKtG5u7XtWNoymfQwm1sUBnJXYeVDgyH2rwMPcBWKqf/6Yd+vTauxEMgpuAbTQaG48vJOf/no8DEJStCdOSqXnzalynF7TvmDLUoXjwNaQffCpMJgIMtbNLp0XlMen46T0Fifdn+zWQYaS5umfKo+1snuRyqKzuTn3l615L45NzFITRonoxjaOkB2LapJz9UtG9nCanxDfqiBAWwQY7XZUvMduRa6bmAWdPGEZ8uiWVCMNLPX8ahtZf3wEPgf8KfMqaYvvHz7hcFMS0HK1RHDerZMjhi4NehfixTSMGpfaWXhmxw3MQS/pO/k2HY/0DB3Qold+puAgfz+9+hSmZZEyTzi+JNe8nH94qVKmhnavmNkgEBCmZ9nZHELg15ySd9D/WD10iIkP3NmDqTZFbDrnnkS9igbfbuxi7ovRjauaoTpTkC3Re8uol01HBygHU3BSo4vMvyK3ztbuxmc7QoQH1sYllZNGLXjzjnBvHUz/GdQdvs4VcLzts74VumlI1xeDUO2xE+qCl4gbPORNcHlJjul/VEaAPuoj+2lrGQOexCdXH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(19092799006)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SptFx2GwccaKgl1f0AJvQ86OdmPM2EijJIn6srBYNUzUfZ+hjebpPjvOLvRj?=
 =?us-ascii?Q?H1AVkdl2yQSIcjLIlG/8SucTGnLE7r1NqemIQY7VEooRFRP7AJnvwAWQf6Fy?=
 =?us-ascii?Q?+XiF7Ugty4korKrVNwNXLgmUI+MAT3Uj9eRHVxPieCFUEXzyAOJ5QL1Ah0zX?=
 =?us-ascii?Q?C+aiSd/PVuQJiM76gciqgQX/sbG3CaSZTy3LKhj91flETAxoD+j8VNCR/kS9?=
 =?us-ascii?Q?Wx3olVgOAfjnj06JcWE4zIQ+r9LvyoRVlfsolqVEEGRE4Sumv21jsS08IgXT?=
 =?us-ascii?Q?Iyu4qxsFp+hBOUqAZek8Gp76uHifc5d2cUoCrHknLYXn5GzwyS16FW2aiJTg?=
 =?us-ascii?Q?1NEu3bZIPRcPiMXZGuw1Hy4BABSGmNhwOcuENEVpwaAs5QkAHynRVlvrSjOR?=
 =?us-ascii?Q?gpxht33s1uEm+PNYyczS0NnrESwcZhR9gcsc3Xh89B8osdS3bsZ5tCsOS8Eo?=
 =?us-ascii?Q?5hRupLX9yGi54RALp6nYEbwPj9W1BoJhrs19YUCrgSiQeOxBzhkLpGUmSNKl?=
 =?us-ascii?Q?KiGh4iHyM/qKCa5ElSRik6NiciJP7JiffV0ps3krxrcIUFQMCsSMyITZTT4q?=
 =?us-ascii?Q?otlyGCIA4bHt8gVLp9OWQjmESJCZqIs1lkLNi7xCbaPDaDNnGdq0x83GDP52?=
 =?us-ascii?Q?MIT3dKk94G0g86yUFkVL2bwjRO6Ncs5mutSYmd1FYonF8x9+L9w0DVVMBkpE?=
 =?us-ascii?Q?RsVvY7TqX/Kgcq0KD9Ismh+4TOp4vegFLOpqL7dvHliYqXmr4r48v3zVdYjy?=
 =?us-ascii?Q?QYOGwV9Sz7uJ0sU9uvmFYTxa8uQLzI9cMq3knQRmYWBGH02LmTWbFtWYjzAY?=
 =?us-ascii?Q?n0dk5fr2Hs1t55swSlQIs5FXb4cSyQmAeoOkMtmz2B2EjNiHNwJKPILcZV4r?=
 =?us-ascii?Q?cF5C1M6pq1eUl4I7R8qUeX8VbDhrkjuTC4FAMZGdosNY0HJA21XNisJOTmuN?=
 =?us-ascii?Q?AyyBx53mwdzlnkrfnAWTVrmPV9+khKMWHkvckb3BdtyGwRN0LadISwbemphl?=
 =?us-ascii?Q?V2bMZsorv0u35UsJRnTQiUsRay1GwVWUL8R7rRFEff0qnOHq6kTgSMEnuby5?=
 =?us-ascii?Q?prbNwO2NaMDgd9ZSoEMPZ0NXhP0jrM59oNmTEJgFjtT0lEdOGt4SUM672I4/?=
 =?us-ascii?Q?Puv3XNqMH2ToGud/3dLZFasHLgF+QDuyZ/6yw/8Uo+S05ujBNnYYNycFG30Z?=
 =?us-ascii?Q?+Gr8F/xHUmsYmBQRcWrNNmcJOsFf5FVzsbHtThRlw6QsEi7Ku0MCg2WaP5Oi?=
 =?us-ascii?Q?iDQqhGOWv1RgQI3RUz/+4x3UKyASR9PpqHa6P4zQVaLX/+he+1p2ZWQ2VLx4?=
 =?us-ascii?Q?Fb5UOG6aS44hIo48quUw7UaptiQ7YKAbauD4dyPkF+zofoVKbqwxp76rhfgY?=
 =?us-ascii?Q?3EysO3WLaJ2o3Ci6hB1K5rbGEHAFZi78is6av3kXDG88NRgHbrfqmZ7hoQC1?=
 =?us-ascii?Q?R1tfnEL2BX2f0PxGvmYUDyp7ocy6jEVFFHo9bp0XISWxA40RprRbUwlJRjxO?=
 =?us-ascii?Q?okHv56ZbWEB3mRm1ns1tlMoXWNjCxN2zx4borf96hR74t7ScDTFNzlqzCUJU?=
 =?us-ascii?Q?9dvLcOc1Yx/JTeRHqXDQ62qusrufxrE1SUc3lWOiVROmiWN6aNJ2D8vJrdUi?=
 =?us-ascii?Q?O9CRAMq7hLPtbwZtwhbAxjfgZti09juFGkVhTORnCDcUN/goibrTYcKbzeZQ?=
 =?us-ascii?Q?lk5Twy2fk2KLtziN9Wmu3f4OxbOH+a4/KXaH47ioJv6ZS+X0X28HBy3nYwBo?=
 =?us-ascii?Q?EQB+tevsMm2lqcY+g3eE15nzlypBtdTwTm53b3nhDP2qimRbbv/T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3571c7e0-5e2f-4a34-dd63-08decb0e16af
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:44:10.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL9JKSECeM+4oEIFgU4i7Ln+gXY+7PFaAsscaW+1ghFX/lKd+QDdl4NZqlibqFTdE3wLwfeKPdS8sUoMGD1EjlanlEPQChMn36M7VgNB+CVwabaozX9bilucWKn5DSvb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9814
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11543-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SMW015318:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53177689436

On Tue, Jun 16, 2026 at 12:40:58AM +0900, Koichiro Den wrote:
> dw-edma resets channel state from terminate_all() paths, but pending
> virt-dma descriptors can remain on the submitted and issued lists. A
> later issue_pending() may then restart work that the client already
> terminated, possibly into buffers that were already reused. Descriptors
> that are never restarted leak instead.
>
> Move issued and submitted descriptors to the terminated list whenever a
> termination request completes. Also release virt-dma resources from
> free_chan_resources().
>
> If termination was deferred because the channel was still running, wait
> until the STOP path deconfigures the channel before synchronizing or
> freeing virt-dma resources. Otherwise dmaengine_terminate_sync() can
> return before the deferred STOP cleanup has moved issued descriptors to
> the terminated list and before the channel is known to have stopped.
>
> The old free_chan_resources() loop usually broke as soon as
> terminate_all() returned zero, so it did not effectively spin until the
> timeout. This wait can now last until the existing timeout, so use
> cond_resched() instead of busy-polling with cpu_relax(), and warn if the
> timeout expires.
>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 78 ++++++++++++++++++++++++------
>  1 file changed, 64 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index bedaee6d30ab..2777dc0b2aed 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -15,6 +15,7 @@
>  #include <linux/irq.h>
>  #include <linux/dma/edma.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/sched.h>
>  #include <linux/string_choices.h>
>
>  #include "dw-edma-core.h"
> @@ -113,6 +114,28 @@ static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
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

Is it possible move every thing to temp termniate queue by hold lock, then
call dw_edma_terminate_vdesc(vd) outside lock.

Frank
>  static void dw_edma_device_caps(struct dma_chan *dchan,
>  				struct dma_slave_caps *caps)
>  {
> @@ -190,20 +213,25 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
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
> @@ -211,6 +239,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>  	} else {
>  		chan->request = EDMA_REQ_STOP;
>  	}
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
>  	return err;
>  }
> @@ -544,7 +573,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  			break;
>
>  		case EDMA_REQ_STOP:
> -			dw_edma_terminate_vdesc(vd);
> +			dw_edma_terminate_all_descs(chan);
>  			chan->request = EDMA_REQ_NONE;
>  			chan->status = EDMA_ST_IDLE;
>  			break;
> @@ -616,28 +645,49 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
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
> +	dw_edma_wait_termination(dchan);
> +	vchan_synchronize(&chan->vc);
> +	vchan_free_chan_resources(&chan->vc);
>  }
>
>  static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> --
> 2.51.0
>

