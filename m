Return-Path: <dmaengine+bounces-8589-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL2cKbUxfGlVLQIAu9opvQ
	(envelope-from <dmaengine+bounces-8589-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 05:21:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E18EB7102
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 05:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7836E300DE1B
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 04:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206452FF661;
	Fri, 30 Jan 2026 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBIBi2H8"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700BD2F7468;
	Fri, 30 Jan 2026 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746861; cv=fail; b=Kp8o9l5BNc/o0n5ON0oatx/88TrHF+q9Tq/oMMZkwt2Y6DoxVnSkJMWJ2Nip8OTv0ifrW54LuKefvqmRRkzmbaTNjzPFDw1Y4D9Lt/i3oY2QhIxz+u/n7SUC512VB0dATB+kWU0Xb0lE+PHLgNPfLjkAkzzBOUJv7obLwg7XQP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746861; c=relaxed/simple;
	bh=o+nDkAWhiC9U0A8TqRLZnlaWwlmgsOiAEboAoPm6LFk=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WEAY1dBGJbKIegf6e7r45zmEtJDKi8XzdDbV7WrQdVoO6ADEriZJkSGDdnOaBzfG2H/cr3m6j+D4kD62aBXuSdMzcctGq4aUeEUjwU+Gy4L7VcXlXMqj0uGVDTPlHchyqQdHNBavGEwznMr77TOfHIkQihgULvZukX0nZVhHk5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBIBi2H8; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g96a3I+5wXZZ1vnMaJjcSNzSUOQtAcCyBAvfidRfbvCEX2TAZGnYRaEc0RDN1asnF6F7+DTuYGY27Kva/BGa5N6pbc+U+NiNz9QLho2EZWto+hlMJcCA7EW7bwvuFpzwIlOLiLQd7GOZDfsnGidgq65IGK1aSy0W8rrk6I44cVCCbkYZJ3yUb9dRYleKySmE6obFkkLjc8y3tneWxuBpplzrmSqwbrllkj1drgDHXdFLWIzmQI+3WYFl9TxgwJvzz4GkJ91AcDOiKu7oWVDDeN5uJ79Z63cTFmKCyG3NsUjgNvOX+S1pICC803aTIyuRz6m2WxbvNvvhhgKXRpvERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40hkG/o8s353oOls16wS5bx4wPv36WHzavYqOGfnVu0=;
 b=NcpVcFxJ+LywOtwKYkSdjFpZk6V3WA1QmEiDzXz7lZzr7KTNl2k4DXVjbyFogFFUw0cBHiCk7n/Nhy8ki2XH/kSuSJTBZSjGfqCVxEX7KUxOe0SHJgL4favHQLoH6bB5a+oPFHRYKhtkLct22S/frmRargJkLbyjk8/1s1Fnrr6H16DnqJrGWigVopsf401hb/yLJE8dPpNeWtRM0sHLF9ty00eeQ1/VESds7NGyfILpjm46KRZKu70iw6+NTeW0rTfYibMszrkkRdwbuBXS9ePiRI63Ay3qI7Mpl1uk/F97Mnx5Z/BvaUUY7cqdoPtTI4fUCBhSFcGlhij7cQhhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40hkG/o8s353oOls16wS5bx4wPv36WHzavYqOGfnVu0=;
 b=gBIBi2H8BRMRgvqAEGJU/DL5XMR96SI5msUBOT5K6CZgnWEHCLqdyMCWJ8zMUybK+X0NonbHu5ET3t2hwJ6Ya+Y838sehSEDnknH5FuOQ4nL8/SXIGDpweSLSXREn2jOdVpTjicNMWIc9X9rjB6Brpc8Dd9VXXWpnLDG3fOboWvM1BE/fCisHvGAaS6H0mM7FMSCi1U4Q+H6yHgEUEJ+UHW520yoxFxwv6ziVuwXComhH0vRj2NnDJ/Kzqt2FcYih6nxlRaWnQ75Ly5DYKEVKnDddvIBcO1Gh+YyGg66bXA20QvNHBKLjdT0rmBfJRfQ9JpoV/tRth3fGfUZ6OMZSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by MRWPR04MB12379.eurprd04.prod.outlook.com (2603:10a6:501:82::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 04:20:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 04:20:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: add Frank Li as reviewer
Date: Thu, 29 Jan 2026 23:20:39 -0500
Message-Id: <20260130042039.1842939-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|MRWPR04MB12379:EE_
X-MS-Office365-Filtering-Correlation-Id: ed634f9d-285b-4f42-7091-08de5fb6f6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQNftGiwL5N1opDQwhDGNgT4XUjyg7+nfvxGRMeU+k/TxEpZozoFPbcI6l3b?=
 =?us-ascii?Q?Ud9ED4ekJME5q5eQMF7rF+pyXVNJby1xZHZ+rsv4fT1GAQrtgYBlaxWH1Cil?=
 =?us-ascii?Q?94UX1GwCrkTrXwzcpkjHsGk6gcukjKPk6LM7+nJOtVRX0PESZx/VI1a/AHm+?=
 =?us-ascii?Q?pRsmZHzGWut1cuo/6M4vTg6/gwv/NwPC3QckjIGlAgzNXTsfQ4ttyp8ABzz6?=
 =?us-ascii?Q?Io8zqoYN3EYoMyTaEpK1LCIYzvJkxdSl+zRb9E81y0AweGS393ZhihCL7GWR?=
 =?us-ascii?Q?oYgQKHx2DcIjvtuBU4liew6QoWl4FFCtgklMv2gLyAL7w6w0ZpJ7KmgO2g6O?=
 =?us-ascii?Q?eoQtH1xWiCYAZu3befaGd5Kme/9kd8hRBxGwpE4PqQvnUI3gUwKDDBlWZjxd?=
 =?us-ascii?Q?1M7wot4Wh/7A/gQwJTn7NXJhvoobeLICZiX3K/Tw0CXD7CplTgFFqEYfhysG?=
 =?us-ascii?Q?46O4nbxhm3p69za6LG90w+OIpZ7r6qI8aHnrs4vMyaHxLoLrdGJKCqfvYg1e?=
 =?us-ascii?Q?LmTI53T9jFTO25KfmpL8wvKX+RA71dZyuneSnGTt5uHV/ZWylYGmrMYiML7D?=
 =?us-ascii?Q?quNy9KBythM40gknrZnsXVTt0f5wsoWEMAfRcvc9BIbAaF6C6H/K/s6qC6FY?=
 =?us-ascii?Q?kSik7jDHLupxT0tndak5TKuP5CJpkwbEd7nMjiMtQREPffh2z4fhnoVoD7QB?=
 =?us-ascii?Q?h/8TeJhizQ6K3wPWwaoOCn7YQNjKOwdOI4Z76H25jhjR+egIQaPTAZKQd5fw?=
 =?us-ascii?Q?iAUulbvMy4aBW7bzgSwL7KE/WqtNW1UI2oDeJy5pMjq0kBJidByMRiUsTvnp?=
 =?us-ascii?Q?hJJpruEr2eFGY6FH69uyZguxBwysjeoucEfG+h/qf3PECytbdLFs9WNXsh3v?=
 =?us-ascii?Q?tzEBvauXEMdsp92CYe2fo9R2kZuaqic5ofvhOCBifsw84DLovCl25nQP3QXN?=
 =?us-ascii?Q?cNG8L0Y+LEdB+l0DA0DxQRUSWpHzeGuAe9MYOWMPNdeyPk3Bgi5sR2LL55e0?=
 =?us-ascii?Q?qtgtR/+MpmDPMhHNh2MScHXrqg62skDU/kCCmxbdzjmchgw4wQUojMJtgDp9?=
 =?us-ascii?Q?1w0rFbLg65oNawUITcLC8f3WFolIDd57rXmYM+wkHCr/BKOd6rMeaLpXE8u2?=
 =?us-ascii?Q?HmFgJO6fWhVJwXuoVQ+wpWe71d+EDi+QMC/mKdVZ9HPki77v/+rpxVkpCg0z?=
 =?us-ascii?Q?DUvvKA8My3bdxMIEi5466KC87fWW9qgSV698D/MC9dZMS2yOxNDL2bpkQV+N?=
 =?us-ascii?Q?9mwuREKKZ1Q/NQIYV4LB92LzaMv8OiC7U3adFBGea0+rpcuQERh48/XdscEw?=
 =?us-ascii?Q?DXgdJnu0Jro4Hm+ovTuJgCrAQowljPEQp/C9oKEKzhZyBRu4XDmf4UkUZozS?=
 =?us-ascii?Q?2nwtKwNcuXLAJPGywDAl4dn/teLahiKNnr8t+hkVwPt4qp30hZu2f/3LFMvB?=
 =?us-ascii?Q?xy8q/flH/jrE7CsX/aYAPjLigiS3llBROEj1HE8T38D0Xc9dN/VfNM4J6Hrx?=
 =?us-ascii?Q?0k8oNFJrldcJUM3RM4W697ZmBna6sUQfSiyApgb9eKPzrwZA1PlaHZgFz1GE?=
 =?us-ascii?Q?sKcZbzHH2XCt7lRDkJ2r8wY/TKL251UyNNR7A/kUu/N3aUK0mKUcv2/JkpUK?=
 =?us-ascii?Q?/rWSqBFJ+9D5vEYIh3Wp6Zc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lm/LeEdfXYMEl8ofg4WrQPflogaGHwyTX0wgJzHndQ0HgRqUmC8cmXlbLc1/?=
 =?us-ascii?Q?wnwWWElGRXQ65Y/vlns7gC9Bwo3LpGUV5UYh4bG1Ipufe357pLJC0w2MXjn2?=
 =?us-ascii?Q?t/Y8YNYmTMPMe4whAuPTYhfgxjdy0himDFEaR+a61ZMtVA9e4ZgKh6F6mEtG?=
 =?us-ascii?Q?NRfU13Eryp8HKB4UwIY+reBj/OTH2gv1KPcSm7HiXj9hP399tiE5/+9RNil/?=
 =?us-ascii?Q?jqIbYpDSIrfaMLC+tQsKY/g1lLMKq2XzJ0tohKDIaVQbGIpHmapdO+b771gy?=
 =?us-ascii?Q?gFwPnm5qTrNCIYYQqKJtoCLW+RrF6NJXmhs9cSNuxH2x2B5j56zhnToTJDeJ?=
 =?us-ascii?Q?EWMvPPPswv0VtuwRc908sha6sO6sfFgOulGqueNMFfnvMFsfKu9kA8wQatVP?=
 =?us-ascii?Q?pD56HbEKDffKsdMzcdOjw5vuw9W2P2smP9nY36XFM2glD5+eQ6wMC7qMDAtr?=
 =?us-ascii?Q?HNUIXbraX+C7CGY/agGMpooSgaWfeFo73Gv3xQaZkllhIuox/xVyAzfBdq6W?=
 =?us-ascii?Q?s8d6oCR2q4/hSpMkx5Vn0ZnR6lYfdNAoiCPv/oq4Nr5FebzE6H5gSz4X5XgR?=
 =?us-ascii?Q?Daq6Gr4Wv9daE3dz5C0uHpUtvkZATqytYznAunhWGzRg/hWbHz3DLdDqVWkh?=
 =?us-ascii?Q?VtAgQJ82OQKuU1BV/vO+RfUYacrkoU/o2nU+vC9EI7CgNIKdppJG4XDqHkqj?=
 =?us-ascii?Q?7bHz3MGRb0PobZB929X2Ph0Z5MZypK6IcaTzRyTkrOHMlGnTxOiD5srjEsSf?=
 =?us-ascii?Q?SzEd6jC0F8xHH8x+bZrx9DtxoCUOvOL2oiPYBtSAbRX4tZQSZDDtkjH8lOgP?=
 =?us-ascii?Q?gof4YZfqH2yFDlg+zXsQaoio1pD5BNRaEUb4ggk7BkFK27W6Fejly4bNIZmg?=
 =?us-ascii?Q?MNw0wEdJcReiXSVs1L5foGiZ7gmBOUeRcB4ePRIjvkqAoFqSLlawyeq7VePe?=
 =?us-ascii?Q?Md4UyFGU+ZmojZgZ3PHXSfDr8bLR9drH8gtpyQweLz7xYP6X4v9UTe8RGt2y?=
 =?us-ascii?Q?doRFh9HtZZVKa0osaFX34U1Yh8bBbuf9uDAMdX0waL81UT3y+OZILflk2Cp7?=
 =?us-ascii?Q?mdu4zzoarjPwY2fIUMHSTFmzYxsBTEPg57f4q3z3YCIbQpHariww+Q/fR1dS?=
 =?us-ascii?Q?8AVm0366rZDdJ91x0yij9lrI9KYNtWR91bgHb11nWOEjUQ07o7jqsCSiFfnM?=
 =?us-ascii?Q?ebXKYr14Pv3/cPrHA6rqizbUbXyFx1tEe0f9R8sozX9cYNnlzVOsVGOZ1Fjb?=
 =?us-ascii?Q?hUkgKZXL0DSE7eHZyKqbeRg/SwMdCaBCHlGhWqkMxqa5QFxay7ZNBvjappcL?=
 =?us-ascii?Q?TSKcwAs/t+2uRZip0v4QHMcR09fkQs6xhQ7ywSuoaKwmLmXXW2LtrwLVXB9C?=
 =?us-ascii?Q?9k9dwao3LyqfetyVsSEmTVJI3HYSdj/KvyldweNly+7ZTTURcBefUg/az9v4?=
 =?us-ascii?Q?ohaooWnROz/TL60nwYMUY+y9UaDLe3J8OzPzMJWdeiuYbOeEiMQqyF+VkAry?=
 =?us-ascii?Q?Qh/V+RXRuWTxiUoEYl9fJxsX5UXIKBycRp8C1iOiRFWHX38K2za/zzC07cX0?=
 =?us-ascii?Q?RdfQd2FCzXCg67cDB6JR+kPxCxsziothLw4ICIoSXIgu+qbSyMe1OK4LbDo2?=
 =?us-ascii?Q?iz045q7YBkm+fmy7iXGVVT+W3ulchjBHTGoIayaGrFqLHv4JfSuvVbUtKJty?=
 =?us-ascii?Q?rKKKcr8a4YmKFUcMTS8N4xr3ZBIaL7RmJ6hEgRxkZNHiktAb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed634f9d-285b-4f42-7091-08de5fb6f6a6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 04:20:56.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIYvs9I4MZWu6xwx8SMYROaJH9p9TU9G8PTgljW3ZhycbSAEGmIxvnFrvJttsOGz2aknJlyZoLulpYfV4RKWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8589-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 0E18EB7102
X-Rspamd-Action: no action

Frank Li maintains the Freescale eDMA driver, has worked on DW eDMA
improvements, and actively helps review DMA-related code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4044b28ca1818..6091c7474b77c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7510,6 +7510,7 @@ K:	\bdma_(?:buf|fence|resv)\b
 
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
+R:	Frank Li <Frank.Li@kernel.org>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
-- 
2.34.1


