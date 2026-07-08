Return-Path: <dmaengine+bounces-12149-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pohUKjW8Tmr0TAIAu9opvQ
	(envelope-from <dmaengine+bounces-12149-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 23:08:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7072A6C0
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 23:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=t1JXUIC5;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12149-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12149-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845293010528
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AB3F1676;
	Wed,  8 Jul 2026 21:03:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA43EE1E9;
	Wed,  8 Jul 2026 21:03:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544619; cv=fail; b=RGidNzed6XZAiotRhgJ4uaAfiHzXZpkTrnTHRWPdBrJquDy+ZJCsEobIIu7WQopG/9ViwU25ZQVPRzSo6DoluynGDHv9Px7iJf2A+5YGuV/JbPImD8+gRCG2WRfaMTW28KjAw9ZQpnm+tib37c41F2KUz1zjoIp4cmC3uQ1yG7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544619; c=relaxed/simple;
	bh=YupVii2epDkW5MINLu8dDiWMrR0FFDfuHsnXnc6N7fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YbCV3ItQ6cnBDN8RMczAMHMTYH6+1x6pIhPcOtBTIpOzGEjH7sr9IL35Fe9PF9d+V3+xkemEwruwbF43PlUdEKJzeoRjv+yydEc3q614+1sntUntH1Zfdq+53H/J9Ewr+0vht+jc1Uh4R+RLSSMcyEleoL3+bPHJu/8zveYlFMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t1JXUIC5; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sioAiGUi2hsh9gLt/mM8h7RpD2Zn+ixNpcfz6W9r26EmabkhKMsBJCyWO22GFXQRvaxFoIVZqxt2ecWpFctY9feBCbJfKAksAA3HWPKHAU8STzq6/cBR+zincoHTpen3b61fHX+JBYbogYrcqAbSDUdmyyOy+atTJR5HDhSS7lWA5YuIzuRfzIl0qiwE5wA6WPwssTCOXjHS6WzKxcKqb2UiZbmbGXAKaqu0bKjoZHCzri6C/4hS1ZbFcRNE+wc5fuEgMORg/dlMdejRcKSV4w2W3iMIm1UzRbTkWHdfYatlhncgqx6XiagJ5gzizB/MXX5II0i8/vXjxjzhCidK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1CB5IdWjzvBOUlE+iPQ9fW7uvQXz7VqFlbF5M+sM2w=;
 b=XnSug3VsCmjKFOgIKbiQ2ir3M9SkxRQUHYB/eAPA1vJMTD1ZHlHgbSjVyYlf1FHULqDCJjSxgBIjzneJsM8cjAJHzhXV175hRQKv+rA8vv3XD36QKZz/+PaXtaJMJjgh6ui7jtA18uxrKjEkqrj+Xhdewy5J8U2xRDzl+/Qsmdk0iDadRGL9+4dYMR3yCCk/Abmjvm350YzSn8LoAxHt1frNI/MH8PsQgPpXp7YD0z9SH7BIRSTEZxVpBKZTNhGufufSXjyddMHPqxrY9gj6PLt90O0uEJ8hB4/I66HmvVyexDXyy8Qxf1spzFgfg31UGYnqYVthwN5U8u/w5dAaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1CB5IdWjzvBOUlE+iPQ9fW7uvQXz7VqFlbF5M+sM2w=;
 b=t1JXUIC5gau1l9siwbUqFMn6WPED9qtOXXEXG4Nv2Of1vJB4g4MuwdNekMGzhzUDlyHly14ywX68X5ALurkGl5EHbUv8JwchL5ltLsIpvvoS2r6UENTjMDuJuJovrBjuwgpu2+UeoqDBAR/aIxke+P7V4xhxDuxmtdLN6d3X8cEDS0Kzr6/j2y8LWbk4kjptpscz0SedO4jh0P0di0yJ5aFgbj+NxiHgWtF7uv4rEe8Z/zlJt3HW5w4twnW3Ar4iGGif1nqplWhZEcVcI0oOHwyMw1/JDXM8scEdGeTlaMYiC9EJJd9sp2NZmn4NGeQXeecuepeytMtZdqFA5+iJuw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8815.eurprd04.prod.outlook.com (2603:10a6:102:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 21:03:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 21:03:32 +0000
Date: Wed, 8 Jul 2026 16:03:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org, mripard@kernel.org,
	arnd@arndb.de, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH v4] dmaengine: sun6i-dma: Fix use-after-free in error
 handling paths
Message-ID: <ak67GssLG5yliDe4@SMW015318>
References: <20260708032518.50886-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708032518.50886-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: caf81cef-880f-47d0-5046-08dedd345e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|19092799006|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	I8K3wUbVe5vGY6qpzoAaYJr0xRMghgkUc4skEJSJuvOhb1CjB20dfrJyWVPFsUhr0oaXRX2KbecL2XFSNSdqFmCKYC1o8CVTztikyroLPTOMS4RBOUiVz7qlMmJFiqTxWp3SR58pr7wSJAXtGPrYhDPtv4NAFx+pALIp8cbjLQa+Z5jN7iUAXCkKeeMmiM9X4Xy4wfWOUaIcrC4PR8L6RkTzqCr72Ym/xXw0Gv5jlWTsUn6q2QgIhUZpvkNk8Z9YLo5U7IdrDMIJy31kKTJT8DkGwM9lt0bO0a+A1ZQo29cezIB07YP8xYIxx66x3LNtAAXhMRV2hnk1iQdY7yKNyG+Gv+sUChuLq0oQbReUy8dboHaPvxo+yquu+CDRr5aGNLlqohmOwWtKt230bUf4kUg49bf9XTGHgYpZuJtt6NF3IhV9Kbi4OQoJ6NwlXDlA42EHRwoWDNKuvFyCQDHIm5FnYqh/Ao+ZdyoZ+gjb9eS3H5ZwsnN9Usto7VkCLXg3UURXTQHhlGyLjLepwg53RlaK5BhkOSWWmxHMuFpHxAbkl5lRQ0f1/34TSD5NqyhVNhms6a/HSAIUwiRcV2wkhHtTRj+EC/zBQXbYhkfo5yBdQQiDmIwzSJNdUzGLzcrky5eBBx3yBdBXDhkyBexN/uJNu/2oCocyCth+E2kpJ3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(19092799006)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZV1zN0hLFbcwhqpHMJW3zF1d88gFIY1up0TEAc4myTPz/fW60RhcxFph56aV?=
 =?us-ascii?Q?Kej80P+Nhyx49Qhf0aiIdkBItYswMXsf6L8xek6s/B6yGTOTYdyDFwt9NAH9?=
 =?us-ascii?Q?95r7Rd+t8jTIbND+WbP+Lvpc7NQLr4MPGF4l69g5mV7/nxWt/ePIJ0pdVnOF?=
 =?us-ascii?Q?hSpNKsrm6BQRO0khE/pFYbhTmfATSw7C8lGWqvQsZHFhKmqBsjG511+8TY3O?=
 =?us-ascii?Q?QASEWbYCzr/5QUt4/jLMFeC6kNQRDe6k4M2oElXb1JxrFol81Gw1D2EGoeVn?=
 =?us-ascii?Q?lgMwWj0AcnkBjllLVD9WtNTpmpZ1M13bS7OCzzpD6aAI1Y+4eYDU7RHCza3j?=
 =?us-ascii?Q?7z/av5aRjFytkSPdAg39GBIkOzaMtbxkVs8y4UAGwOspIldhJ+8i0F//mH0c?=
 =?us-ascii?Q?hoNxHCwsxyyv7U8kQbWmeVztuONMtAX/Ka6v9i+uBPYSk/6eSznlan1zeYVA?=
 =?us-ascii?Q?VpGQN6sE5ZfVr72LelDqcCuX6rnNe+s/gjKiY2g4vRhI6P/xSXf2bwEqJZ6U?=
 =?us-ascii?Q?eLiwic9e+1ZSlFZds0HlXgMdLZbzpWR5anagZxmVKGfMRrgiOGugMleVgVZq?=
 =?us-ascii?Q?AxaZGOHXGz14umMfio8GTKUZrqwKI9VuP5JR3dGT554gz6+40gWWVnWOtVmg?=
 =?us-ascii?Q?nyp7pc7ZHhNVvzU5Aswdv8gb8hmjzn12gWTCNGgWFWeISoNXDmkiZBFVIdoZ?=
 =?us-ascii?Q?8U76GxlBf5NZqyOG6Zwnm+7ogrl7JjFyQKrA7w+RtUfvHjVCo6b0lP/IPK9b?=
 =?us-ascii?Q?DZ0oNzxurcz7bPyIRfuuUMkY04tG3WJMCcHRhONqCSmPH49ApS07YwhGATzw?=
 =?us-ascii?Q?DT5IOiMWEcVWsQw8FGF520sj70L2R+9VjiVm4V6uDVKlEC7CzBC2BMj+AEFY?=
 =?us-ascii?Q?PWqu77biwkMJFSxgfEUWUgWPZkglqweeD23UVgPdVegHKO0dtXpW6HHVTyi9?=
 =?us-ascii?Q?M2cjul0+9RhQ/w4aLgSPaxaSy5OyXf2hkO6H7E3thHFGZBQRHe0PCQ6S9cD4?=
 =?us-ascii?Q?THUpB1nkrPZQPa6fIZT+B9xGYBKRYj4V6sjcD8ivRpefmVzYjW79CjsMNECa?=
 =?us-ascii?Q?x1MPT1RBMvovPtF9vu0hsMzu6IghkDIKiBGBXIKTwlaKJGl6pA4W3mBivvIQ?=
 =?us-ascii?Q?87bzbX9ELHtbvR2/YkDLe1rrzp5Ias+sz1zOkxFwCR7hLK71h3+MJhsc+tNX?=
 =?us-ascii?Q?gwT5wuZGocUUiA8CyJP8QsUwDiVYOJereX/5F6tkCgzMyMqkU86b0BxnK119?=
 =?us-ascii?Q?FjdsHvUApmDNdtg/keR518JECZ3bi1zyVz+grK85UbyUqbUaMlPJyCqSHGWW?=
 =?us-ascii?Q?5r81IVKrr9RymNOCHd6ddmahqzoaqJd/0YDuK1E+P88PvpYJz8xB4Fx25mpm?=
 =?us-ascii?Q?CFyLeZkmL7L7MjEmdj1Bu3ZlGMa+2N9S3O+tLOUhR8N0hqdUdB0vsIW3628f?=
 =?us-ascii?Q?M9FJLFbRvXnO8+yv9qL6ZcvOB6JpA4xEyA5O63O7R0fozRjXspi0imYkmBNK?=
 =?us-ascii?Q?7bDnjDD4cTSyTnulKa3Ijr2Fwiy1K2FImyJovS31rW69eVR02rNtTEAWJJ1H?=
 =?us-ascii?Q?XUGk6Ww3KSocnKAuReHlPaQJuOmM+UpyR3OUxre0GYeUcYICP4kXdbtb7+VJ?=
 =?us-ascii?Q?OtOnoWa7AYFFx6I39d1V2N6gFOukdp+M0yQFgYrjhmzXAt254fYKISDcmwmG?=
 =?us-ascii?Q?Xv7RP2iSkkgR8C8GaN65hPvGPUqk4ZOV5u3zJIQHygKoDZv8f3j+1J9uIxiB?=
 =?us-ascii?Q?edgd5B3Uz7AYLGik/RFCv9gTwl2AGyqizHAFpSP19nVCh0PT/1Ai?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf81cef-880f-47d0-5046-08dedd345e71
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:03:32.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji25BfFDCJYq1pkLcyBvrrMkH/h719gUmKBKud0ug4SxbWH1JPlNJUgxLiA3lzc2/T00LrOaAnycL/OE0Baw7NaHn7WUkeyeOi9gc9J/tRxbBMBeKQBSKaanoFm6F9C1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12149-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00B7072A6C0

On Wed, Jul 08, 2026 at 11:25:18AM +0800, Hongling Zeng wrote:
> In error handling paths, the for loop frees v_lli in the loop body,
> then accesses v_lli->v_lli_next and v_lli->p_lli_next in the
> increment expression, which is use-after-free.
>
> Fix by saving both the next virtual and physical pointers before
> freeing the current node.
>

Is this statement out of date? You call sun6i_dma_free_desc_virt()
where saving "both the next virtual and physical pointers..."?

Frank

> Fixes: 555859308723 ("dmaengine: Add driver for Allwinner sun6i DMA")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Suggested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> ---
> Changes in v2:
>  -Refactored the fix to avoid code duplication by creating a helper function
>   sun6i_dma_free_lli_list() that handles LLI list cleanup
>  -Add Suggested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> ---
> Change in v3:
>  -Further refactoring to move txd handling into the helper function
>   as suggested by Jernej
> ---
> Change in v4:
>  -Add reviewed-by
> ---
>  drivers/dma/sun6i-dma.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index fcc88a74d821..e161fc298b86 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -406,16 +406,12 @@ static inline void sun6i_dma_dump_lli(struct sun6i_vchan *vchan,
>  		v_lli->len, v_lli->para, v_lli->p_lli_next);
>  }
>
> -static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
> +static void sun6i_dma_free_desc(struct sun6i_dma_dev *sdev,
> +				struct sun6i_desc *txd)
>  {
> -	struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
> -	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(vd->tx.chan->device);
>  	struct sun6i_dma_lli *v_lli, *v_next;
>  	dma_addr_t p_lli, p_next;
>
> -	if (unlikely(!txd))
> -		return;
> -
>  	p_lli = txd->p_lli;
>  	v_lli = txd->v_lli;
>
> @@ -432,6 +428,17 @@ static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
>  	kfree(txd);
>  }
>
> +static void sun6i_dma_free_desc_virt(struct virt_dma_desc *vd)
> +{
> +	struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
> +	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(vd->tx.chan->device);
> +
> +	if (unlikely(!txd))
> +		return;
> +
> +	sun6i_dma_free_desc(sdev, txd);
> +}
> +
>  static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>  {
>  	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(vchan->vc.chan.device);
> @@ -788,10 +795,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
>
>  err_lli_free:
> -	for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
> -	     p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> -	kfree(txd);
> +	sun6i_dma_free_desc(sdev, txd);
>  	return NULL;
>  }
>
> @@ -869,10 +873,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
>
>  err_lli_free:
> -	for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
> -	     p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> -	kfree(txd);
> +	sun6i_dma_free_desc(sdev, txd);
>  	return NULL;
>  }
>
> @@ -1432,7 +1433,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>  		struct sun6i_vchan *vchan = &sdc->vchans[i];
>
>  		INIT_LIST_HEAD(&vchan->node);
> -		vchan->vc.desc_free = sun6i_dma_free_desc;
> +		vchan->vc.desc_free = sun6i_dma_free_desc_virt;
>  		vchan_init(&vchan->vc, &sdc->slave);
>  	}
>
> --
> 2.25.1
>

