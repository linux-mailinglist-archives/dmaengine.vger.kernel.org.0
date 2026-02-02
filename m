Return-Path: <dmaengine+bounces-8672-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHxdFDjWgGmFBwMAu9opvQ
	(envelope-from <dmaengine+bounces-8672-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:52:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6DCF2E3
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DB13002F81
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CD37F8BD;
	Mon,  2 Feb 2026 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PoG4Cxdk"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5A2472AA;
	Mon,  2 Feb 2026 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050804; cv=fail; b=lFR/jRDW3OR45pbH4jrtGoLquba5eTYC4y7Bk8TXlsKMu0TwbHaEhgI4AAgbJkGdHTNQqVRQ1PPj7WrNZz9sdiYwzeRbZ3n9FtdVxaP6i18alAozAFBGYdFfm525G6ad6UrQOTtjU3mQwKvay1YxH4JkzKzeErXM5CPZk2w5ibQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050804; c=relaxed/simple;
	bh=VFkB4mzrqs2yHWos4TLev85EVfYewjBfTIkd1EH1dbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pjx/UhL/Hrk5bDbnk0aIOwo6Tquqct0k17jNHxESkNFd8WAPBHDU91dX9Yft7Y8ZoCPzGFoOWYl8VqnCwouHIjlA1BJyCL9zQjwmXoEfqVlPeWqe+Gxpbhl3rBNHg0zHfmmEvlo0xZIvVQzIDF+xrFVV6o7oZxVoBvARqseV6pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PoG4Cxdk; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXcyNtPZU4dwgcuA7ZSDjEhYkoxX/kRwJ3j84J7xOI6LJ2Y4zNl3eLOzIlYM0Dw9qf0+76CQOCTN7N0M2ACwAN+LGJ1i/o4lm8nV2UL3vLrG26y9Eivx63H+pvVnznzgCJOLt34exKZHZAAWwDs4NMATxRyit5N9ZS297/WuzCcBuXfalzwxe2kiRGiGzp6Z0j/GvU4oz2aDdG3zo76QpFfCXxwVawvQMYI1VVaR4rYfP052SnpziELFOqollWMzxRnnjWIbKmADSrkluATRTh6RyI7P9Q7lCNqDNLPdnpHadtQdhV6HPRtoESLz1NhE2PHIwjJu1/nsq2QTU0P8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l0YbfnVNxNZ9phrg0R0idUuFC1+2HmC8V0Jqbl/AWs=;
 b=YvAeJj41sbPXcZfPf5h0a49des6cERQHUPdPOCAvXVe9wGFkFnEcOhEthBCr48qrjpYVEWGXKdWvTJgT8YJDxmP7i8k1rrkR/0OeByscJdfMd1tY0AQ698hMgeWkEKd+uSZznqPNj9YQ/fzqU6ZUz2e9z8Kdd9UCeZhDb/bl03W4J5sCmkRpHCz8DeDkvaIVmijv98ZO4m0sgdGYYw1xjiZ3WsW31GvD0XnRRIVJb4wJBdD8No9M3Tt98VKj3Ysq04xNRhx0OeRcrcwoTxUU9lbeneJnxMk9uY1u7q3o6rb+vU4u5MNSRM+rJoYStXFzNh1/ZEO8tWJOszVGHrd98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l0YbfnVNxNZ9phrg0R0idUuFC1+2HmC8V0Jqbl/AWs=;
 b=PoG4CxdkcojSLo7N0QEh3+Bb9My7JgixMYHRY3W34wQrQnaxi+4FclAWwZ8RowsHDrQHVRq5BUUoDn58B0p9ShXoK/LtKYZ7S3rFR/CyWz06EEFJ+GfB07DyuKO6dZkdcqN9xbaP4elIO/pN5ysiwR8+gXIughUW5gO0oon3HVsGKXIKAYr3kk7ojpwNEZB1PAMDtnadYpJB2XeFu7KtXw6+Vmauk+9TErFC+F51Wc4jbs1J6guR7iLcHkWrYx+Jb4jWAXBbJpdcPl1a6YY0Xc54pduyLXCYktBeF/+e/79Rsmh6CVpu0ZZAnDCvjpxZB4ycWM4Tdw0l/ODTwwt8/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:46:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:46:37 +0000
Date: Mon, 2 Feb 2026 11:46:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] dmaengine: tegra210-adma: use
 devm_platform_ioremap_resource
Message-ID: <aYDU5na1HxkPRvwR@lizhi-Precision-Tower-5810>
References: <20260202034419.3958-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202034419.3958-1-rosenp@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f3e5d2-f481-456a-4aa0-08de627aa1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hXWBrkAj8XI6a8WhRHTLB8vnyJkAHTc23NDFT+ARSKpkrqORG7uD0pQVKy5u?=
 =?us-ascii?Q?dk2vrwnlD3CfRZr1MGGxdCgJK0sND7XAdjunUZiQSufBcrT2KOvX9ZNf/80g?=
 =?us-ascii?Q?G9BFE8Wz3wW9+qoR5FS1MkbcwDYsP69cxuXch+KKmtws9dK/7QWEKOsNUBI1?=
 =?us-ascii?Q?cDAHqluuB0xeDJsNI4oRcbOFmM1vAp0adlc7va3yAZ7EkB0rmke+msXGN2KP?=
 =?us-ascii?Q?M5nN979gFzhhWOKa3HxMcMWAKANnVecQ902VjJCvPi4TEEZpolqu4Yh72e5V?=
 =?us-ascii?Q?K+6h5/yn67CRt3z8i2eG5YajlqjRR0IM0IcVdzNuj8yjgLG5mvtjLf4KL726?=
 =?us-ascii?Q?nireptpky4qlztPlW/OPEkU9+DWl7zos6LM5ClwHsNgnWjP3ldfFE/0nGkeJ?=
 =?us-ascii?Q?8uJSsAaLwZG/SHeej+nm9Kn6PjzGimALLnGr5qlp0SNnEWPXFrvhLGhCYENZ?=
 =?us-ascii?Q?fGy6S0zNrK9iPH5XlhLd9KFC+XN2XMPNhptjZaef/RZ/RlIXi0gFwLYvqBPj?=
 =?us-ascii?Q?DQor4Dvqifl3hIeh6cQ65rxSrMM43H6tu4fCIHsS6UzjSwviVF+ZE+BP73NA?=
 =?us-ascii?Q?z/hgC2LUNMjt8b7e2IIT440uQPnlrO6Iixa3dG63StfAGfvmIB4KQ+u9T7xn?=
 =?us-ascii?Q?sUDlGVUS0KV1CIMv7EYqr9KSHcQNxlh6Y9fcNb/v5m0s9QRvR9LwY3yNgMmv?=
 =?us-ascii?Q?r02il0YgtijpK5KB+EFMZw1delqD8aTuXAqYVsdXF3rxncL53oLuL1xUyOij?=
 =?us-ascii?Q?JfwoK1AAhlK7mOFIhwtEd7IEQSfZK9a7Jt/aa/XnhOghaoGSc8jy/xVg2oOL?=
 =?us-ascii?Q?qSfhgKEzB47rYso2sT0KebF2V2pyYTYVW7opqO50Y5sApcN5uIHqgWGGrELh?=
 =?us-ascii?Q?1GN+eOep2024QMSOhssrWKjJNVpk4F7DsVnLqe7LYy9rDEq4B5Crbgb/VpQz?=
 =?us-ascii?Q?9SI9kYhQUQ0YeD4G1x+h7b04xdSZRn2//pqkP3HXnEWHmPUlqFdKc10Gb+0a?=
 =?us-ascii?Q?K5GQwhHS3HJDK23yGFelKobPJDYafaiq9DPQp1L1KRz9WqRKhma/WjJBUr8H?=
 =?us-ascii?Q?B7gC3hLA3yKgT+UNNPARWZpj+IDhS/TDNy3LY7sJesWGz3EBYtV76j6htNGA?=
 =?us-ascii?Q?jkPM17i7+HkYs63HXHVy53F+vUj543P+PW6dxXEAu8O0jrI9AmZF1FFdgmOs?=
 =?us-ascii?Q?/qVNviFcEnmDb6dhOHDqwj3sTCmTvMiuYnZYqzILNUBXrXtwb0Sa3K9jcFcZ?=
 =?us-ascii?Q?8D0Yo+kQVxmK8TadSi8hI+XSHSA5jLmb9DQi1qBMCqbhE7LUIwTJ6qEHf/7R?=
 =?us-ascii?Q?ZcRK/DmuNFINdcCpI9WxomN5KCGGabE8HzqUt+qjlrR2G4fE0l/UAve5DTEn?=
 =?us-ascii?Q?fwuGC1HrVTm4axQx5GE3ApqMDEOtvu5yr1tkg0vX071saqnWmXCP1TCU6Et6?=
 =?us-ascii?Q?LiQzs7Ail1Jpeh197kcGv9dL1ehFNo7+Mo8jRelMBf6rgpP78Sj260/FHjOD?=
 =?us-ascii?Q?KaLUjbogpzsNGvjRDyxgnyf9wMZ+GCV+UL1CVwR9YFnG3IAh/+mNwZHTaFJ9?=
 =?us-ascii?Q?Zw5PAEoL0b0eYLBu2awyQxFxw05FKvaypenibBSnkwe+XEyohuPrxBg1BArP?=
 =?us-ascii?Q?nuxL/I6M+hhcDqTyP9wDXbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmb98+d7tl7UXzeHG11LaErRui+JRPQHTSKAd6yaT7uMWqhMAxYJSi6Yl7lu?=
 =?us-ascii?Q?1SGFtdwg6/BMBSeSVQ7D9HYIR07ZZLuEo+nMPiFRVX/0MQlca/7FI+GrnR67?=
 =?us-ascii?Q?fHHFSe4zOkNiEnXWs/BY33uMH6qKnZmPzCD8agT3OQ3WoTQCu/sNxzOJBBNH?=
 =?us-ascii?Q?k2sGcQ842ReqnQQ17zBVc5jvL75YBktiEsq9UWDt3oYoY+EQvbazID9/qpkZ?=
 =?us-ascii?Q?+YCDsmoqqs1OB1OeUWqoAey/dI8WAAvUSg1ZPcV4+RVx40LVOd/x59GfX3h2?=
 =?us-ascii?Q?oHeEdF9olwYQFkfBtpTpdDs+mYYvdGzgdRgQdbWxVXksQcUbEKTaT/7QfmtV?=
 =?us-ascii?Q?DEApi82FtLIbJL8q1XEeUQR19OWE+kOoFjGuYYZTLH2jHR0P5aGJ9ibh+74e?=
 =?us-ascii?Q?7XEkq5OnuiG/UjHI8Xxsl/SeHh3/SYyrfJPTpBcr+8aTGL3PYrTDkEYREuCQ?=
 =?us-ascii?Q?F5GXHZt/FcDaT1hRGLtOzyZlIffoBapVfdqvBqdmdGbgulQ9YlOFp6d3dMWN?=
 =?us-ascii?Q?vOg++PysHr0WJv+iNzWePMbtx1IbfDI3ThdUq3k/M1e8+zDnXBxGI1gBx+s4?=
 =?us-ascii?Q?HAQSyojT6LbuutUCaaEQNt41AGafXWqsqovXl3IInW/Rb6l2BXq17P+1iiuQ?=
 =?us-ascii?Q?BQA21ABI6PZ8xu88V0sF/Elr8ZCU/O+PF1jisAtt5+cXe9h6tMNHXF0/mJ+q?=
 =?us-ascii?Q?NXp397+ktp0zmBHWlSQDpGyjh/i9JRe45vh8BoIXM96jzz/tz5kWtr8p/FgY?=
 =?us-ascii?Q?khdOtn8C5tB1w9MszKZ0+d63WFTb+sI0CXBrNbxIgIY/X1QLzsA1bdFbcdLG?=
 =?us-ascii?Q?o+3obiHSBi18Uj4vm2vpjKGxheB/S/fUooqC805XUzAQQirPHzA39U+ml3eZ?=
 =?us-ascii?Q?sokqprRQH9j6WrxtWZtzYSFaOqm5x2Fo5wi+8/XoQWObxzqPuW/sBb6azYPo?=
 =?us-ascii?Q?+shcwz0+d5RIPj8ssrbZl/ihCV+2R4/6VsO8v6usOhQd45BSQ/VoP3o5r6gg?=
 =?us-ascii?Q?8ktME93FmHJesFoBMKVmupDGF41v8ExpQgzbEpK/yjNETAoZkmpbyL3X+e++?=
 =?us-ascii?Q?G2C7bajDTKUpGY724UV+SZZzLBz9zpJFE8hCQ06rePfM2pr2Cad0YcipjROk?=
 =?us-ascii?Q?mct7syv/nyJar9wt9zPHSdOGZFYAxNU2AGLL6KUGQPwyiZn4sB3Ev6CN1SA4?=
 =?us-ascii?Q?XbOrs639WUGXCH3xAlIHexK/S2QOTy12LFcxI46wqoaJJEL2mS3TNY9gZdlo?=
 =?us-ascii?Q?uQYUNwX1c9epJsIpwXoeyxdwelLOL+bRnbctaSeqeopmIoPgl7YJp4Za77Jo?=
 =?us-ascii?Q?Tzn8SsPVgxAFKne6ijNH/UUVhVXbbzQ2c1f7Nf6sf0dc3QvHxwFjdVMP9vyX?=
 =?us-ascii?Q?g9JYUdf7o7gF+SW5W2NeZ1BZE7JGrVx1F/TWwv0SafDydQApbWqgAHxMwhlk?=
 =?us-ascii?Q?0apYL0x8PY0xwcvtTekUfhnn1iVjZbU/KA9lnV8WRJzTN+cwMH6otIwhJyGK?=
 =?us-ascii?Q?S9jDnLkBrmI9y6dlFsFzu7PY2V/zgHuqh23p3VN/VjCM9MKAhSPSziX0jq2B?=
 =?us-ascii?Q?4/v26G7z6mQ3a7XPJObI6v4eqdc37S3OPI1cUdePMaM/aFoP/lqoTVGvEBgq?=
 =?us-ascii?Q?RB9CzF5hxs+t7Dds8s4iHQHXsWawpUoxKeqVW69IM9MKxA40SHNNDIjM5Byg?=
 =?us-ascii?Q?LkQ33ZKsFNSdwSarFp3aiW4lewL0TlJkgINkxupaAxvxRsiQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f3e5d2-f481-456a-4aa0-08de627aa1c6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:46:37.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzLuFc1WX3BhXvUWJrqJX7TFvrRX920l9SpQ0PxIHr1KubUg1p2o87WQqcSKZRjSn3OCJYBrIZckQYn+mPQAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8672-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 9AD6DCF2E3
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 07:44:19PM -0800, Rosen Penev wrote:
> Simpler to call the proper function.

subject: function name need ()

dmaengine: tegra210-adma: use devm_platform_ioremap_resource() to simplify code

Use devm_platform_ioremap_resource() to simplify code.

No funcational change.

Frank
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  v3: reword title
>  v2: reword commit message
>  drivers/dma/tegra210-adma.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 215bfef37ec6..5353fbb3d995 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1073,14 +1073,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  		}
>  	} else {
>  		/* If no 'page' property found, then reg DT binding would be legacy */
> -		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res_base) {
> -			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> -				return PTR_ERR(tdma->base_addr);
> -		} else {
> -			return -ENODEV;
> -		}
> +		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tdma->base_addr))
> +			return PTR_ERR(tdma->base_addr);
>
>  		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
>  	}
> --
> 2.52.0
>

