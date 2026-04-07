Return-Path: <dmaengine+bounces-9896-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hSz+NJ1+1GlLugcAu9opvQ
	(envelope-from <dmaengine+bounces-9896-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:48:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC73A97CB
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B73300D150
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 03:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28235B642;
	Tue,  7 Apr 2026 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nPc9mK7A"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557771CBEB9;
	Tue,  7 Apr 2026 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533721; cv=fail; b=Ae+LKoGC4IKNaj1X1yBWQS0upCmdH8PF6iFgGud6eZoSvPDKlP39Po7KBOoshdG/Z8RLquS62zeCaDPi2rB0Jsqp2dCeQSL/231EmiN1QMMUWzKQbttMueRIBIiZO70mirHdLCIwpOsHSLI2PJbtxzpUtXsVttuYgXX5F+yTI/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533721; c=relaxed/simple;
	bh=5+hmUl9dxWxiG4ObwHrwM27BfvegsoQByUVBgaVmFl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ftYEFhw4JAJfWE41oa+1w9lXaT2qGjsSw0DNJ2GYjfrKkNDvWOsnMKm50iExn/yucy6xAuuo4ZnAR6CSIoHdF4A9ToBa6Dnrsti/15U06U4FfyWMSD4ifTGFJq8gY0/K5kL6U2aPgQ8kh6s1iM+el2sH6D4uL/vigFDFML0s4mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nPc9mK7A; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2cZvsBP8Lfjm5FdAaWJXLkTT7CK4gbYEVba7EDVGIEX7OK4B9Cv3RLbCxKtPzKDy7iRqYtZsVKYozcAdNC+G3INhkMwjCdNlH69a8OPAzRL4z4Vjs+WMFHzSM/WVpllVslRZntZX5mvQj0fTtqqEmDNkvOt41Pg/fWR9Ipqxo6vP/OdGkPmaRLu1MErm/f/P8A7yzWWyeVnCdfV9OBydOEMfINHXbU8teZxcs2kJL+FnuKvJRljCDOSrcPP/s+dzhAZHU2AivJ6W1gtve4c1Xs4t/B+3lYm9n+4++0DWMX3crDtda98nA3IvVSz0XM7MhE4L0F8OZDsWPkCFWb1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+hmUl9dxWxiG4ObwHrwM27BfvegsoQByUVBgaVmFl4=;
 b=zCV1HEsu99wCHQ8/KM+q4DAa2Wmw0BhYaqf4n6ch+YTCMCc8YEBDz0gdzrGGl/TwO0+aMKQLdoC0VU40WQRzla4drGtaMlD+CGODTC0vzPwiVCY8097QK/JmcmM9S+HCMLdTqmtlqPpQCkuBXULsSViuFCbQQruhNQGfArwlWqfZy3hd8Io5BP55SypzA+QJHT278SLpZjkSpn45lRpB48TFMDzLEt/MuQl4zf9/n8sQzy9Tt8/YkHPgzDiP7cO5FNbL0PhujoKN+LYN6bVcBjSvLrK+WiQUjFMdPieiigIv7JdiCLz7NRLYPUdv0rxD30vJ14UtjecPODX1XYcSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+hmUl9dxWxiG4ObwHrwM27BfvegsoQByUVBgaVmFl4=;
 b=nPc9mK7ArswhmJpzSPvEaVyUpcBJcnKoGvat9gMEYEoA69mq6s5ugB0TsURNUVODhCrA6tg+D23OYyAebNEBL+PqGz1leHEL+sylw464/LcL2i0WKAFCmiU8DitWLRKdFGLsFHr4eMkvkJFnjsf/OxfcXTuCQtAMoP/kXUhy5j6A/ivDmY4J+8DTVp88xwOTxYpFX3l1kCS/JE0hSCP3I6MI71HO0CKekDC6R0T/AXVSXiWWRiQY+hMXJd1xH6rV+x5/VaZljUrMfpGOzRq95RiLxqGedGIuaQNTt5dmM60rwpOT7RtpphZorAvb7agrZJZF0cQa+iIYK6sFAm5LcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10342.eurprd04.prod.outlook.com (2603:10a6:800:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 03:48:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 03:48:36 +0000
Date: Mon, 6 Apr 2026 23:48:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: imx-sdma: Refine spba bus searching in
 probe
Message-ID: <adR-jGAH5cDlWtwa@lizhi-Precision-Tower-5810>
References: <20260407032755.2758049-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407032755.2758049-1-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10342:EE_
X-MS-Office365-Filtering-Correlation-Id: c8072e8d-7815-4604-b349-08de94588c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IvW4BjjNWiaymWuZFcYtumQcQX54ijlR1HNPPnvxPYQp+l1R+vg4GspuzZJ3U9VPTEWyQQeFS2B9q6jWZCCOK00iuagfs8fsZTX06CdvcIJNqpQ7++U2j+AaqMyy6fzW0DJV7/I5hXi+5DUQnw0sL3RLs1YqVpoil0rmXz8ikVgol32UekD8xSmDhD/SRSTB43HWxM41i95wPavK9uabGKaBd8b+rBKtbSlGSZs5/jgOeaiH4ycUbaDpHZbiI8Kxv8p58Flvjl4eJv4ZLAnNYcG5hsxdtZFvfzOqvkQJDHareFzJYlNjOnaKADa1CvisfGgrfahlXbasoR/XfzyTbMNW6N+9DpJ9hYyETWDDRNJ9enhpFhnS8qlBearW3Yzsmt5qPFzdKJ/G3q/gDHfMuf4i4+5n/+g3HyCkRUYi9FUs9jSX0CeSpZv1ydUXcDpgsENppfeJ2UJAggZwJIXLZd2iN7v85ciHE7CvHpGZ3MJM+kramMmk6DjnWuHkTSsJ9vaEN9yxIm1rvsiIWoF3e1V12XzNwVU4F2n/3fmaV4E3oLt+jw7dJS7ByMB+YT1xDOfUNAbhuVbFlXyqaFE99FMZC12JI3xVT2TAIUIl1h+ZyWdEqSJttBmIob97tdH+jc8Ade7TJ/SWNt+Az/Flwo1HEKiCcO4xd4ZPyXirHjeqDiY2ctkt6XLPYg0+AnTzYSryiv2BclihOf6wPHn6EPOkbnOhATpP+sj/FlCtmGatnKaO7Jl6ieVKrsuG21HsL4CIF+4p6rlesQQ2AjTDw9iw03iUR38usguZ8aR4yMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6VpzV6hbmVM56L54KCwNcdfzuJs5L24nG/nfAu/+h7TgKoGwXzGLGhxrhUd?=
 =?us-ascii?Q?bIYBn6ixkuKRjpDb/NoYEPpJnSKBColRSMwLhaE50UPyYkFET8SS86oA/n1S?=
 =?us-ascii?Q?ARjj/ecEIgx97fBBTf8/YNdWEh6vGjxLFeAmpF5xNqyxaC/6+5RCafb5oula?=
 =?us-ascii?Q?cuEi3jQkC3hBhy/j15Dnb7WXBv6sedDyGUWqTfJ7BOMewm4+hXFFnX7mc9hH?=
 =?us-ascii?Q?UGA5YTrfIuGoZC2mul60AQ1JbStVeJhLwadEXmguorr29qkU9eZFU4EsI6Jr?=
 =?us-ascii?Q?I55caFuLM67ykAVvPHrAAr/w+7ogbOq+UUDpv5tuh4wah7omXxbcIKRu8p3F?=
 =?us-ascii?Q?8tfluEXKjEr3wlvbkpGwN55r96pNs2HdS7aDM/pk6j/0UDy9pKXIO2eaN9Zs?=
 =?us-ascii?Q?Bg1v/ajdbAKkx1mgp+rXOczv8nHkMmi4ACpjRjIgV4gn8NYe4TUbFNGYP+DA?=
 =?us-ascii?Q?pbdCl19Mtm4PsZ0kapmNwPTySPPo+ZkX5vS1LyQTICcSzbiGFgZ6NbQAWrbu?=
 =?us-ascii?Q?uzJz5P+4fnlCgYT6ZHQFSQxInAynePkPVSHKmXdXYxhukFR3zTW8ZicNMQCe?=
 =?us-ascii?Q?Vp0j9k02UTAYBt8ASjc9ytxg+QTAkMOxCSISbyl3uJgr9zKOifZbAZUEbMTJ?=
 =?us-ascii?Q?F1OvwKgX9pTNRODyH3gJVRsUeJfsXzp3AsaQDPlXa97H4Nf5DH8GYuNrDtYX?=
 =?us-ascii?Q?94uqX/e/DBdIpWrXBvY2tbiHyvfWfpQllihPn2Rd/jGQtOMCAciROJKmIh5f?=
 =?us-ascii?Q?XkCpI9duJWI86RjlgXfTnn28fjKTq+GFX3aXnH+9kuhtUUwM2kAgFvY35Pjd?=
 =?us-ascii?Q?GkT1z2ttIbiBuEyDVGrECfm6YPuP0Z6ZOwfPxzO11/xpH7/Y/j7kwolpZQGw?=
 =?us-ascii?Q?A3zOyn7WFkKyVEND2XizG566UL8YkXi4eDhWw3ls0m0LZbZSWkL+niRoVwHm?=
 =?us-ascii?Q?UK5nMXSTvx8sU055VxgxvN9VUTT4Un/5Fs6E3YDKoREvKmUTc7BzM8+xZB0v?=
 =?us-ascii?Q?2cNKqDokogLpx9TanDPfWNY7aSldumnM5XoLz62P2GpLMxbtbSzZIRi6KbTv?=
 =?us-ascii?Q?rUVETo1dF6+JdUqeDJxbGwoOS+GDD86o9+e01mos7IG0DV4TqS8mHHUjHfSa?=
 =?us-ascii?Q?G3Eh6jjDH9Zyx9bwEQqbQoJHiZ51YV9zON1T5tV5KSBJmvML3864UAM/lfD7?=
 =?us-ascii?Q?t2CdkHSz7d9yMzBnZY/97CURFT05pbRwL+N+W6vparmv7osiEaBtkH+ttQXn?=
 =?us-ascii?Q?wyL9FzfWq3LY6F8xsXxvLhU+8PusxJ73ZbBSQ/UhWIp8WB/EBXMhfnHK/EVj?=
 =?us-ascii?Q?GmWRSCHapAVP2aI1rOd4Xh3LTvE3Q9dkRstflw7BJ0cRnDeghYjRkkfRFJza?=
 =?us-ascii?Q?7HZOrbTMxpBWjMAiTDYivJ6R998e66CIMrpkDDrXUd/ONpinrj0qzkCZbI7A?=
 =?us-ascii?Q?zpU45xvCIMKOsMeoaMcOtNNqY+B6jm94NIPSwImMD9Pj4TviTvj2gssDxWy6?=
 =?us-ascii?Q?dK85NWrT6683Iz5ttpTu4uoIgPoj9NE9d1DsZ3tMpJZmeuozyBiasJgT5Mbu?=
 =?us-ascii?Q?Nl0H937+smpPloD/UW90zu3sLh7SsWOMpvwUjL32SCMND61/3SbAJ1D5Nk9Z?=
 =?us-ascii?Q?TMRWHtd5XuaKFPkdiGfNzQhu3UxX937dcgSBn9xcPCbmBbac7PhrMC4nVXNR?=
 =?us-ascii?Q?diGE0iMvRAKLNm/XBxtMA4dAVFoJ+luqqtw0UZXtImBixK4R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8072e8d-7815-4604-b349-08de94588c19
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 03:48:36.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwp5mhOqzfs+E1GLX0UGt5oyDv2CtBy/k4fzGF9CXzSWzbLlZkC7oTeJEYrq9pDd4L9khUlyUc355/C3xRNRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10342
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9896-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 2BBC73A97CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update subject: Handle multiple SPBA buses during probe

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>

