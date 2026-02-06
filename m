Return-Path: <dmaengine+bounces-8798-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JXfOGgrhmm1KAQAu9opvQ
	(envelope-from <dmaengine+bounces-8798-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:56:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F71018B5
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560A73012EA2
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850A7423A84;
	Fri,  6 Feb 2026 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gWPBs9ZD"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16E2DA77F;
	Fri,  6 Feb 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400596; cv=fail; b=pVFdI9C6ag7eTyfZbyQ694tkN12QgLmiE/c6dxHL9DQDXNMsZ/hdNni9kPiw4BNOJAzMU3TsSzNqG/ZhhbcsL7x1OtVtRTIVufAjAWGglOwIMIYFlbBRMqsKz12rrWked9shmxFvWmi5b55DL3ghh9c+fl3h1plnyeUgae7vRKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400596; c=relaxed/simple;
	bh=JnwmDTxMUeriUqSWZs2LscGPtd9EgBcqv75aYr10dqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pfiOds050YZDLLMt16T9kJI+AybGe/LoQu4vjRDpaI9qKNBuz5WurLXpUUU+qZvuW+jHAuvAYfJgJhGhaPYfNP+mWFy4TFBmelP/g03smULrRT5R6KmYikfSfuAdepQhatzMcjDLcNrp3z+1eYjJczj3jkWAB2mvnkymnsiCr4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gWPBs9ZD; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpFk8qh/av7FwTlqBG+NgdxLa4Eorwvs5YX0vQ+BUcDrJUUYbV3sR4BZIBr9Ilk77at/nNC4iS6cS0RsKB85S3dPJZGNS+uCwfqgGyKquZpOreZQl0OCMqje1RiZQyRxc/w2zj7byWNf1p9EyfOpKgeYacaZOoMjRzScUlv3dCjC7UV01r3Ph8YCTUQncbw6Ghu02+oHxgS9hf7yjbqoZvio2L1qJPdcWepEhYbBT7rn8JRFsxCr46RhfcEjj4fzE3nC8oHet+RnfLZKCchl/JZmabSj98tCcpfFxrCtuKwDzPFMYlTQl2hpAWNNUuXqr6fB/yfw7e1ij/G2KGTjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yziqwJ+2sdrP/QvRJ38M+MNVFmjUvl22dwyo5gbz1k=;
 b=oL48ImfGxM4N7DuRwX/B6XUAldn8RlTGX2cqYfYKkEHPR06eszKHywnoKA5gVTsnihOKXq1sZAhMWl5+cCcz+t69MT48jUVx4llZS1jjGJGxfIEQxFdAzs1Wd8UcllwhsFvyaPbBagU0vOy2kgKaInOPYmg2p8n22RqLcKFr3CaC4imnbGoJg7uKyOks1TOHZbq8EfWY8K+NKGtSMBhd4rtDXr46rdneKrni47yQ5XdKxBHEXLsaUv2cZuugdecRLiw1YZTSg6dJnDwL2NlZ97j5/IfR675vSSTuBIlRyU6BJ+qndzikNSK7eqfm8KA1UWnEbipNJ70YUErRx7hKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yziqwJ+2sdrP/QvRJ38M+MNVFmjUvl22dwyo5gbz1k=;
 b=gWPBs9ZDLmkyPFSoOPmraYY2FINFDAumCPGU/M0bkK1wr5C+HGbXEdfc15lU+OEhmTCKuWoYM7gopqTQloc+M5CrB2mUdfsMKWDAeG8wQJxKfUknlnI8d0Bk4kVtvzkYEiU8fYkOMGRwiCLrCQ+uC25E0BPw7ZBYa5LkRjtD86JMawZo9nXM9jkUShIDFJkDu9j24kVwkUbejZwFO56fg2QOQIP8IiyITT0UMggpTwoEhhuBnarbz42kd9HGLII8KskTxDlSW20snOO1oQwJ4wD29tG5j93gryExCDSo1IVi7tkeBgd1d4wpeuC6vETe+kIkiDgp8j1TyxpZuTOu5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8208.eurprd04.prod.outlook.com (2603:10a6:102:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:56:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:56:32 +0000
Date: Fri, 6 Feb 2026 12:56:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] dmaengine: dw-edma: Export per-channel IRQ and
 doorbell register offset
Message-ID: <aYYrSM1oOz3_u6Na@lizhi-Precision-Tower-5810>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-4-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a011577-f6fd-44e7-98d9-08de65a90f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4dOVeXO4mjNOl17vReIvvMRVSNIkBmYKuTWwnXfQ6Y3xssC72M8DSii0oQb?=
 =?us-ascii?Q?30QNhBGbwFRBr251G4gBILeAhFrnZsq7mS2hp89+HO/fW6MqtrZCsVatTdDc?=
 =?us-ascii?Q?a33pOnQpHlU9JiIOAKc92qJnkLbMXo6pWbSfD7pq6Y0xDlmaP5B7sTB8Ato7?=
 =?us-ascii?Q?8uwsMxGtmMRkIyp0x91Z5F8Uiyea4rIcVyvXZDE+hez5IyOGRdNEhyJ43QxC?=
 =?us-ascii?Q?4is5l5J7joy6U4GdT2W2R7228U1aBf/PjQRXOl/4gXVcN2+e6NAKUrljJjfL?=
 =?us-ascii?Q?kCZHg8fnffJP1wnjW4D/UxhMIRSvKgvg6dpSNBdIJYFqCAhVtdO4jO3VDryZ?=
 =?us-ascii?Q?ABjE8Mv/HGRrUbU1NtPf6Vt/ugbPBKQ8W7sWmAa7bbbgRtUTr98FnzE5CuEa?=
 =?us-ascii?Q?e7BeqmgRJu7i6hNH49gmD/hJtDGhHcrW8aYDHN9E2yeKiEDUCFfgv5EhPyaK?=
 =?us-ascii?Q?bHsrneQb2VAINYM2T2dF+2p+j9Jysa5Ux0M7UeKNdyagdZOtzMCjIw9Xez8u?=
 =?us-ascii?Q?X0p8THT8Fxbp9Stmc62IoF1Vnx+g39ozlPtW88V5gzmc4BIBPiJA6FAGU0/W?=
 =?us-ascii?Q?38YHlMWT0H9lRzfq/fgq88e2Xuc2aUCM4A24/AogbEsRZrPyoE6P6S8rxVrp?=
 =?us-ascii?Q?wnKv5QGDCJmXvqqeGVGHfxDerfjtPC9aeCRYeJ+IESJmDnllJsRmJjXGd6t7?=
 =?us-ascii?Q?cjAilE2GZQIELtajcil2h2UMH/ba1H6IRThDgZjEbSWN9WsDNI5/opCKmBjs?=
 =?us-ascii?Q?TEdwMtv8YGZabZO8z8OQXdYh3glZ3aBSo1lyEffxSQFfJcOxk3yOqO9HvHZ+?=
 =?us-ascii?Q?8tMjyqv3NA6HzKkzLqC5GGrHuPZrLyqBJmKq/KxBtYCXjHfzc88DFWQQUUVS?=
 =?us-ascii?Q?TdxXj7TgVamacPwag1xHSVY0PEXuNfplRZUBUl55F5oVcHW/tnGd1gpbxR2C?=
 =?us-ascii?Q?yk1m8nCmwdAxRmBUc/aiWwtAvLsXKaFuEUHokvuGbHlA/gpBXg32edMZd+pf?=
 =?us-ascii?Q?1bzUlAI9axwK9r5F8Ak29BKNodr5H3OEVSFIAo5Inqb5o+USjS9l+Luet/8O?=
 =?us-ascii?Q?BJreNog0K97ONQBonLWRs36M5yVSixWHZYY3rfd3Ii6go8zHKy/Wd4oTj67b?=
 =?us-ascii?Q?c3wqKxNQ27UvhdV3xDtwGqKMXag9GokQQl39RtfsEitHBBEhusXnYgPc0RZG?=
 =?us-ascii?Q?V0tgrzjhvmgLUBWbpeyfzxmd4O9StZrN71MSxaB3kkszw0v6BCuFUCmUYWcc?=
 =?us-ascii?Q?cyhi1/ZWxuPQJiPAlopR78Yr486KPZn300Ldql3wXxXKFeS+QzJjw3fCM29Z?=
 =?us-ascii?Q?hZt6PrcI1ie8Obaa1j/vLGxytx1PZM8KSdeSJlHXE9LQOXWJJuxru6YZRWFw?=
 =?us-ascii?Q?eXH18td3E6doXkxG0Bq8q/NPIbskHBLbYod+b8bDnXXaw1HaTIzb7fUnAuXC?=
 =?us-ascii?Q?DYvgMgIsfROa6vFvARSObrMU1UAETeWB+q7sU0h8+GfLRqB/qnzlDhsd0iWq?=
 =?us-ascii?Q?oaeEtIMXtBsvpCvJnDCGEIWwoHquccCbPBWyXfSObUSYsCFN9T4PqGNeYUre?=
 =?us-ascii?Q?yxCRKqhC/R+j3Makor93Ki2uhywf6KJFqOX8uCZ7hi4lSzVeCsm11O2QkEkN?=
 =?us-ascii?Q?xVjCSDnMDOkAAgrDxikwlu8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vARHCVCuk52dBCb3jnIL2ReIiBP6StyWMx8a8IuKJ4bp3p6CTy8Mz/2ciR2w?=
 =?us-ascii?Q?MqFpBagiX6P4LxebSuxK6wZdd4IrNSQDaxnhjuEwrOVN4+swU4UhcF2Pnlp7?=
 =?us-ascii?Q?Q7goO+twY9iLYI5T1OQfQmLOK1tm6X6L0bXYr6JW/RyArIH6/3F/tN+Zx3Nf?=
 =?us-ascii?Q?ya/Glz2BC7lD+L9pvQXUBiwA5ICy+ZbEBsNoKS0zTmxmhn2GmAYXcdMAZRUE?=
 =?us-ascii?Q?F0W2d3LTlVLIlUnHOjS9k9bAYz734iIYlBWksheGiQc3J/+xbmq7yGHvEe4M?=
 =?us-ascii?Q?E8HkSS9cbfG8Is0eyTvCTPGVnS6zdcQQfDFGYCfp/Wq6OMGHPWbVvzLLnCrt?=
 =?us-ascii?Q?s3ky4NBet2mt0sjSK5WDFzvCX5FCkCvyNm7XYDfu0gEmlp7F8mV2iJDyZcxe?=
 =?us-ascii?Q?C5sJBeqGGP/nUgDKhbisqL3sYTObZ+CpAJxpDPcTjDW5VUudzssNJmgcgvud?=
 =?us-ascii?Q?o2tupvurDaoxl+Fl10Cq6dnqa1SNyUKW6s9ad6EYradnulmlFDICD1qC35UA?=
 =?us-ascii?Q?7iTI3XxGGu4PsrC7u6kkb1BukKtdQumglcDtUdgjKxGfuzwTB1HTOuI4ebPJ?=
 =?us-ascii?Q?rHF7rVpTjK9oOee4ZFdakmYPntlsCuMbxN1A/v8zOfmHckkBU9qJJeC/9vYh?=
 =?us-ascii?Q?C8YqbcZ1ci7iLSCkhLuVw4PFZSTfLTP11E5GNUXGOortl5uPKb21zFchtnA1?=
 =?us-ascii?Q?ykt1khdV1HGFGbvGFvwXRC3ZYEzb9kKVutYpHU3kVyOmHO13wh2diBBphxat?=
 =?us-ascii?Q?S8ncf05c6O2ColVbxhWVFmBfEwJhFd/FPsUshCOOLt42mKHH0ZaMtm7lH/I1?=
 =?us-ascii?Q?WdCE/UzAXsmjNvKugXBqq41y7kmNTNEM7p/bs0B4ptS95IKKaDvMNTP3EvSO?=
 =?us-ascii?Q?dvqlPjf8NyATYyu5qEXvqAtgfg/lJUF6omNrHFf/lN+BCO/qsdhF3vrneRUs?=
 =?us-ascii?Q?1x0l77iPb5ZUXnq15GG0HV79K6Hij/QH4/GMPkUuTIPz9+1JLI43AzNq0xvK?=
 =?us-ascii?Q?rWbz2xC4j6GtoEd7/AYzw3bF6aqsiu1lnbLkPIA9Nqgs/rJSTPLrWDUC/GWo?=
 =?us-ascii?Q?ia3CdyEXbSmFSxzZKz1xOnviRfOwFUKnrfndZ50hM8DJQ10Yh3Hoo547ytCM?=
 =?us-ascii?Q?68zNxnO9+ln6Bv75NaXTel92hC/jfFHyrDS13S/3i+Rgl2vEBsdtwWdh42FS?=
 =?us-ascii?Q?bwZhU0sYMkhlgIt4dolTS6WP6FfTA5ccl+W9h3qPUqeW1ChWqNRgL0zofHjk?=
 =?us-ascii?Q?1FjFhfAQJ8hltsNptCZqPbcIPpCW5yi/XCfjbTwqry46bmFvaMaxLRDCLxDy?=
 =?us-ascii?Q?0H7wWPKZTthsfNO/b5gQ2Ls6caT/B7xY4+BXCZPKciGy7fMy3HfXU8DRGQZw?=
 =?us-ascii?Q?bLfUhoGh5KluF3bSicot9it+dsPsLtt+3fepdGiXfdVW6ia3nwCYvD7f12ZN?=
 =?us-ascii?Q?v+dj4Trkfsifit1hvEDQ1eHaXO4RqmudYeyzwafYdp4/l46z6xkIjJrHyehJ?=
 =?us-ascii?Q?2AHdk43q+ccJfRj0PzBKNJ3/jFdVekdCyef6An555NBVoutEF6YJZM9zVWj2?=
 =?us-ascii?Q?IXVKqkY8Y0HIKmEAlyD33KRFuifC/hdHCY059/BRiXujR9zxdzns/L/mvgz0?=
 =?us-ascii?Q?tQ9wiDPd9Zsj6RC1+exBnErJZSzyKcHo3okbDEGSNcFfTszXolMJXo8dGsO0?=
 =?us-ascii?Q?fI4Z6wzKM1XtDR15gLIzU7v2Ql4ZHlC4YJ3BCGhE5TaWM/5x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a011577-f6fd-44e7-98d9-08de65a90f72
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:56:32.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gz3Qs4vfxCB4ESniwkunLbFIfGqKLQcvU9emofZJOoqgMtUEj7v4J4Ga7PHuBAvrRs8UsU85vl1hD8XPtOM6NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8208
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8798-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 840F71018B5
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 02:26:40AM +0900, Koichiro Den wrote:
> Endpoint controller drivers may need to expose or consume eDMA-related
> resources (e.g. for remote programming or doorbell/self-tests). For
> that, consumers need a stable way to discover the Linux IRQ used by a
> given eDMA channel/vector and a register offset suitable for interrupt
> emulation.
>
> Record each channel's IRQ-vector index and store the requested Linux IRQ
> number. Add a core callback .ch_info() to provide core-specific metadata
> and implement it for v0.
>
> Export dw_edma_chan_info() so that platform drivers can retrieve:
>   - per-channel device name
>   - Linux IRQ number for the channel's interrupt vector
>   - offset of the register used as an emulated-interrupt doorbell within
>     the eDMA register window.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 31 +++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    | 14 ++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  7 ++++++
>  include/linux/dma/edma.h              | 20 +++++++++++++++++
>  4 files changed, 72 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index dd01a9aa8ad8..147a5466e4e7 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -842,6 +842,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		else
>  			pos = wr_alloc + chan->id % rd_alloc;
>
> +		chan->irq_idx = pos;
>  		irq = &dw->irq[pos];
>
>  		if (chan->dir == EDMA_DIR_WRITE)
> @@ -947,6 +948,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  		if (irq_get_msi_desc(irq))
>  			get_cached_msi_msg(irq, &dw->irq[0].msi);
>
> +		dw->irq[0].irq = irq;
>  		dw->nr_irqs = 1;
>  	} else {
>  		/* Distribute IRQs equally among all channels */
> @@ -973,6 +975,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>
>  			if (irq_get_msi_desc(irq))
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +			dw->irq[i].irq = irq;
>  		}
>
>  		dw->nr_irqs = i;
> @@ -1098,6 +1101,34 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
> +		      struct dw_edma_chan_info *info)
> +{
> +	struct dw_edma *dw = chip->dw;
> +	struct dw_edma_chan *chan;
> +	struct dma_chan *dchan;
> +	u32 ch_cnt;
> +	int ret;
> +
> +	if (!chip || !info || !dw)
> +		return -EINVAL;
> +
> +	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> +	if (ch_idx >= ch_cnt)
> +		return -EINVAL;
> +
> +	chan = &dw->chan[ch_idx];
> +	dchan = &chan->vc.chan;
> +
> +	ret = dw_edma_core_ch_info(dw, chan, info);
> +	if (ret)
> +		return ret;
> +
> +	info->irq = dw->irq[chan->irq_idx].irq;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_chan_info);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index abc97e375484..e92891ed5536 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -82,6 +82,7 @@ struct dw_edma_chan {
>  	struct msi_msg			msi;
>
>  	enum dw_edma_ch_irq_mode	irq_mode;
> +	u32				irq_idx;

can we directly save irq_number?

>
>  	enum dw_edma_request		request;
>  	enum dw_edma_status		status;
> @@ -95,6 +96,7 @@ struct dw_edma_irq {
>  	u32				wr_mask;
>  	u32				rd_mask;
>  	struct dw_edma			*dw;
> +	int				irq;
>  };
>
>  struct dw_edma {
> @@ -129,6 +131,7 @@ struct dw_edma_core_ops {
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
>  	void (*ack_selfirq)(struct dw_edma *dw);
> +	void (*ch_info)(struct dw_edma_chan *chan, struct dw_edma_chan_info *info);
>  };
>
>  struct dw_edma_sg {
> @@ -219,6 +222,17 @@ int dw_edma_core_ack_selfirq(struct dw_edma *dw)
>  	return 0;
>  }
>
> +static inline
> +int dw_edma_core_ch_info(struct dw_edma *dw, struct dw_edma_chan *chan,
> +			 struct dw_edma_chan_info *info)

wrap int to previous line, check others.

Frank
> +{
> +	if (!dw->core->ch_info)
> +		return -EOPNOTSUPP;
> +
> +	dw->core->ch_info(chan, info);
> +	return 0;
> +}
> +
>  static inline
>  bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
>  {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 68e0d088570d..9c7908a76fff 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -529,6 +529,12 @@ static void dw_edma_v0_core_ack_selfirq(struct dw_edma *dw)
>  	SET_BOTH_32(dw, int_clear, 0);
>  }
>
> +static void dw_edma_v0_core_ch_info(struct dw_edma_chan *chan,
> +				    struct dw_edma_chan_info *info)
> +{
> +	info->db_offset = offsetof(struct dw_edma_v0_regs, rd_int_status);
> +}
> +
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
>  	.ch_count = dw_edma_v0_core_ch_count,
> @@ -538,6 +544,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.ch_config = dw_edma_v0_core_ch_config,
>  	.debugfs_on = dw_edma_v0_core_debugfs_on,
>  	.ack_selfirq = dw_edma_v0_core_ack_selfirq,
> +	.ch_info = dw_edma_v0_core_ch_info,
>  };
>
>  void dw_edma_v0_core_register(struct dw_edma *dw)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 53b31a974331..9fd78dc313e5 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -129,10 +129,23 @@ struct dw_edma_chip {
>  	struct dw_edma		*dw;
>  };
>
> +/**
> + * struct dw_edma_chan_info - DW eDMA channel metadata
> + * @irq:	Linux IRQ number used by this channel's interrupt vector
> + * @db_offset:	offset within the eDMA register window that can be used as
> + *		an interrupt-emulation doorbell for this channel
> + */
> +struct dw_edma_chan_info {
> +	int			irq;
> +	resource_size_t		db_offset;
> +};
> +
>  /* Export to the platform drivers */
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
> +		      struct dw_edma_chan_info *info);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -143,6 +156,13 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline int dw_edma_chan_info(struct dw_edma_chip *chip,
> +				    unsigned int ch_idx,
> +				    struct dw_edma_chan_info *info)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  #endif /* _DW_EDMA_H */
> --
> 2.51.0
>

