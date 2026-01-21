Return-Path: <dmaengine+bounces-8416-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFuYBRk3cGl9XAAAu9opvQ
	(envelope-from <dmaengine+bounces-8416-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:16:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C09AD4F9F6
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5446CB800A3
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6A33FE15;
	Wed, 21 Jan 2026 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qkqTCs0l"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021107.outbound.protection.outlook.com [52.101.125.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83E33E369;
	Wed, 21 Jan 2026 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961764; cv=fail; b=HRY4xVSZjbn8O/bElG3e2k+iUXq/xCndGw+OclwyGVpWQkPLhfGNQA6Ouhag2A8i14ZCYyIzqqxT8jBRpnVpUS4NlMYbzjrnFZaLg7LYjh88VB/Bw3/ox+7hbyJop3fLisB6Gfjmb/21pTYFGwUq5BEFVPoSFTLLxn5uV5Aso6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961764; c=relaxed/simple;
	bh=eczU+gy08GTrPKky3b2YLrH/hmaFvv7axwO0/D7b1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AmDYSGLXBxtg3JNlAwcN6pSjSPZnCbGRmLS0QovBXLwkLAqSGXeiD6BfjgBdyE6oAEKn8yp7QU3E4XzMV0ZnEaNBdR4ntr4CSe5LBDpWES4AeHpg+o2QqmeIZ2K4R1WMg4VDQ/EasV25cU+XfYTy7VwSKka2HHBZWTqbTsfGiog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qkqTCs0l; arc=fail smtp.client-ip=52.101.125.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqT2JlueT+eeFk0xRwldL80wpaaFOylsvorawa+BDY1YFTpEq6WmZ77KGuQs0/ceJip1w6U5d0yNDFg51w8siSsRVI9bl77mKEeZ7i2u08s2Cl0zkWT2aydrEm++VpQxR3H0PW/ijnK7UxNldJ2i8uXcrCsBDqTHgw09Mmpb8gKGl8MZQz+yCK3rdgeFvjm2P9JQtNhwlNuEAzcKOajxCceqtBQeoVYyOgAxutWNFyEsPtGIy3N6UVp4dedH+55PfTfflhQt4w9VV9BK1+rTDCGilPRQUxF1WbOg3NNAaU0uafJ4KPobpr6KTxwauFxyi8AK1XFY7WTcLkOYrCMGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd3GKAk93OFCncX0q6ipJpWt+509l2pruiTP9w+jnDk=;
 b=EBY4pQkKvV3+CUfW+DHu5fLhHpR1GBW0GM+Xv7bSbgQf1xngINGVTrIbaRTfqGX9n6RKOoCi6p6cGQ7YiUDSnN77yrpqz/2NC5k0CZL1iB6n0OHIDVPmhGl18wo0S2SG0whJ/F2sSf0WcaMZzKm1YPrdgoXAjieyWRnHh7Nh7zfM6aNPAUIsrsFtURktmsjWPFjQk5WcVxKChB/k72qr1MF9on1FIMZq9ASbWTGFpZLcacbgrJliOJjKFBiLEl1BNc0rSeKT2ka293iP9Wk0rSPOo7EYqT9XFRph0HbMZuniijewHfdMq1URQ5ZCFUmYapJL0KFvNktpWiaBK+9rAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd3GKAk93OFCncX0q6ipJpWt+509l2pruiTP9w+jnDk=;
 b=qkqTCs0lYBnd3yNZShFnKrpQY7I/tiG+dxoE9RB1PZF9e/K4wzrKglyoJtRN+yLKa94SlDJK9K/8ukKgL1D433FhPKFEh2IjnCR6ghR4+O0xFKxjck/lWWY2k07jcWoTw1GPBV/eOhHNHUjKdV0OaOyFaty0uVSVfSnfz3HD9iE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6016.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 02:15:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 02:15:56 +0000
Date: Wed, 21 Jan 2026 11:15:55 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 16/38] NTB: ntb_transport: Move TX memory window
 setup into setup_qp_mw()
Message-ID: <fk5eluvpog2kqa2mhzhgpln5itejptngcvfbjnggqppoo5pkru@sp2oljea7t5j>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-17-den@valinux.co.jp>
 <aW6V36kWrXE3X017@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6V36kWrXE3X017@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 995c8431-3c6d-490b-7420-08de589302f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOwo4HApdZw0EfdSB2/pUAoltFO54nxDxQZCp6+X17hiKbfGjklGJ09BI196?=
 =?us-ascii?Q?lqKwak0Q/Xchmeqq03dSkCLahGsdN0J48LSf38FXb5vSN6Hu7ahdJO5P0efq?=
 =?us-ascii?Q?axWmPwh3UF/Bx3ndTry70lbE7DrUDseIT4zzOSi6564zCWgSossHOKOlUV1Q?=
 =?us-ascii?Q?zvlyyimE7rtlH23Kyv6hNftZ71cZ5Yj2jvarmm1SmCzi0ASALSvxDwA9CpdR?=
 =?us-ascii?Q?X8/cSvd2uJVxY+bmkcvdt5DMh1sEJpq84HdgXxYyAMTh1dADaAVCljhW6TPJ?=
 =?us-ascii?Q?1CdsfilD8F1MT3QHaxL4kf5REZuYelICl+GygzrHozG2vB0iMFcTPrtvktK1?=
 =?us-ascii?Q?l1wWYJ72ZHt/sPiu+P34ExTex7khrlw748hsDPyaOXeR0CyMCgJQAsCluLHc?=
 =?us-ascii?Q?wm+UtUUjFeyo3Jw7if1ayNJKLjlfNq9AX7Rmr7ALI3JwG0OX7RP680BxPOfp?=
 =?us-ascii?Q?dRLpkfMqhshkOrjgeZBZVIEaNziifM2OykIGZEBmVqEzOy4UBJSxCJTCIz34?=
 =?us-ascii?Q?PaFEIyBILORC9etxRRwf0QpsDakxv6lPm1glT2ZVECG1wp9s5KS+dwaSEvBc?=
 =?us-ascii?Q?2TRDg0SGB1ZSAFz7QpJs33Umcgj393VRaq9JOcLzOejmsZHTawZTtwcIN41c?=
 =?us-ascii?Q?GtZjJzoAFC6dPbZU8kR7h/2N8sJGfn4Kun5GNolTWGJi6TwmeKm/nO6TwVOw?=
 =?us-ascii?Q?1NAT+AVPaxm2X0O2c4fudFpJSs/u0iMVYd3O6bYOInyWu7umnTh3NBzICHw0?=
 =?us-ascii?Q?JbUdQiq5s8QfdP4GZCwXYrHK8Dma9RTvfokDVqZTlKVtSC2ftkYA+2eIxJJJ?=
 =?us-ascii?Q?/BCL/JkqraUdURm/8msULnWHw82YExPF5hrT0z629+P9/5DK8gDQUTyKi2aF?=
 =?us-ascii?Q?G55vUItsq0CILlDWOfWWH1CEAsZGsoc7bGJ9qsAM0+VL8kqN8K6BE3WyHziY?=
 =?us-ascii?Q?nrlf0cc/bDtHyGNX9oQ7YwVBITI0GhwXgKzezJBVEnot8Bgu9vckvURiAF5s?=
 =?us-ascii?Q?+50k+C8/zIdd3tZVNIgd4xfyHhqtt69B+GJ4NZs8BLgzHzDnrDvn7gIKqSGr?=
 =?us-ascii?Q?4O07GB9uuqD4AzfWR1nTPNGTwHg2S/9OenoqOInunqqAhVzA/xQ00v7/xq+Y?=
 =?us-ascii?Q?A0IM+ckNNhREwgKNXK+jws9QgWssqyewLNJGQsB0FqTitOKEub0CyZWi5tdr?=
 =?us-ascii?Q?Dn5azGBVYeNMtOeDYKjfghacV2Lp8JE1aU2l4ZgatziBKCZD2copNeZAY0Me?=
 =?us-ascii?Q?YxqISN8+uL0Za6Fu3AxB/8RORei7KQB7EjbknaiwWWhXbjDhLBMrHnFYkP7x?=
 =?us-ascii?Q?D/Rtx4+Mngi4rFn6waMIyKDzhARDB4GzU8NOklK1pDLgUxRG61EL7fCl1mqv?=
 =?us-ascii?Q?AG5CasYGS9u9EuEJFniWw3JO1noUKCXPaSj5bGDg5sN+Bqo8WgOfr4rsqqZ7?=
 =?us-ascii?Q?rAIhfzqhRnDp24of90yaMGhUMcOVgjBK5nNgKVlBzBtPIBUcXfVJU4K1tkNM?=
 =?us-ascii?Q?uBtXTf0DQaKAeEOtBTLbeFsUSvLI3WMjJw6yYRKPa0qeM574FcdsT7EC1bbW?=
 =?us-ascii?Q?4CGjMnj0pjxwCIa4nFA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QUdaNeQUQh9W/kCkxOTfwjmcIaoT/R8MVpN8vbqZFmxfzW4K1gvje0Gtgdc?=
 =?us-ascii?Q?WOqX0h1g+z/622/aeVsh3uQYiUtNGvudoYoX/33BvrzNh24/6HBH8FS9eeDh?=
 =?us-ascii?Q?jNiIzgIOcqFaNNvlwYv1NMaz9X+k4WMoue174e/e8PStd5bs8T1yvW8GTKVI?=
 =?us-ascii?Q?smZbHgogDjACc5okzKKbGiv16BBxfmkmsXFEu7E8Ucx12WTRqCvUO56745j/?=
 =?us-ascii?Q?415xYh9OOFd6dSOWQuLymgZZKDyoDL3P3tYGCMBIX9m3HBo97+hCjBJRLrzG?=
 =?us-ascii?Q?aRLMx0DWTyo7trB1n1XqJFskDRLzbHFQSy7C6NVdpnqyA8yvSpyub5GjiXsD?=
 =?us-ascii?Q?Y9R3lEq0nuVR5KsLHXNjLirME//mLTry5XIUjYikN/BsU8RlYEajrWhITDRc?=
 =?us-ascii?Q?1Ze/rV9j26StwlK/gVn6FZtrh9ln4S9l/gpvXEnYA0AIyvvOha/ktz11R9um?=
 =?us-ascii?Q?2TfCg3u84Z++DaUS6kfP/o8gNinSXKlf3W9CzpFARNpINw233fXGI52SMRHS?=
 =?us-ascii?Q?iARlvqkO9YeCNX6tshleEZNKB209UfDFRj4Jt7wltmrjyYoN2nHkTVy6ngU2?=
 =?us-ascii?Q?YADPvRBr3DAbTP0YzXwQRLRtkA+xL4+Z8+aH1mvXZMQ4XdJ8mJF9kdfPDKqA?=
 =?us-ascii?Q?mCAonnRB8kkN1d6aW7L2erqht+ZTF5ROTCErdbnI5ZzWtgHkRWPUyUpFl8Ek?=
 =?us-ascii?Q?/7cdQNHe6YY8X8N6MFgyjQ+xx2R0TSvF15VvKWS89Nw9J7xI2Fj97oU/mbGb?=
 =?us-ascii?Q?qX6ymoXQQ3ioudnRE/7Auo7Kni/uFi2GUaett8uSq/VoYEQ2WBpFrQVY+9v+?=
 =?us-ascii?Q?Y5fIcNBWq7exQoTm7O8JK/hQNwMJRdeRWGvIgOwOjWnx+XMzbiGZtVC+x16+?=
 =?us-ascii?Q?1LNyMEedBdDAoQAS+tVT5wJesBC/D8ELr2CtecEAjPybIfBsDkuNyBNc9Grr?=
 =?us-ascii?Q?mhY66dmyszVu9By3SUtxMPZl/TYLcotlPYoOxF1FCyzmsLjRynJ4qwl1CakC?=
 =?us-ascii?Q?+5AqfSPYMjCL/QKUi5ky/Pk5d8KCA418ykUbQK/XvGb1XbbqzeCQ3mtpc3Yj?=
 =?us-ascii?Q?NReD2Ko/aKZgyuGC6kI3GmU1qZUMTkCpdc84wZdtFOVUR1mmPXH7gndA2Y+q?=
 =?us-ascii?Q?gTePhehbxaJArl+vAE8uJEEg5cmlZV7AO3g59nA1MMPkoULhvPoLmizyezUg?=
 =?us-ascii?Q?G8/ctMx+kR1/H6ncLaCn15Pu9Ro0oN/A3CfsAqR9wOYmoyLfSBvvsqquNq2d?=
 =?us-ascii?Q?MNFkNCYq2LffS6y+WYJwNvcQIPj9igIN320kSKMMoYIkKJGXKY+tsNISr8oU?=
 =?us-ascii?Q?uhaz3kFM4ebbW94DamZPsh6ZrLoawOOWfdyXMKMC0GmQ4Q3UJ76UH2Ph0aDI?=
 =?us-ascii?Q?/LQaln+/lUFTeKBZH1I9e/RuqwD78XOGS3wlkm6ZTxtWqw2DBrsMRSdubfSO?=
 =?us-ascii?Q?FVjCtLWv14BJmXdZHrYG3blVERsNv9syLtXV9CRtA5UVsH+/GPNoFmzwd4ni?=
 =?us-ascii?Q?KXQCMZizljpVlpbc8H/tstIWrCCQNCBtE4bI9sxJq9AN6I0/SGXkAoxu9FLX?=
 =?us-ascii?Q?yYXQL5o5KCEw9AslablA+wpl6kXzFIrWNDZFwiUAWZroTP/tnoyK4njf9Ol5?=
 =?us-ascii?Q?jzAg8iEafDW1uS42iI9l7MIEl4wbgU81JUcsq//yQLsJrcBE6FOAwPZrrp04?=
 =?us-ascii?Q?/Gl+AgPrnMOrpKHQZNzqxnjNdE+bU+NBcta6fcbzzLfS+18urzP+TDaw0ELS?=
 =?us-ascii?Q?NLrFSJc4ONAHOkEY7FK/vgA6Kf1vhu9SRW3QpCer4LTllscgRU+C?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 995c8431-3c6d-490b-7420-08de589302f5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 02:15:56.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74u7jJ5A9bORyij0mPUQEQZ3IumUAN5N1bYvr3Dcn7EJdl2hV04hJAPZLy9ixO7Q2V4Jo8uN45nHL0D+kzqDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6016
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8416-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C09AD4F9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 03:36:47PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:18PM +0900, Koichiro Den wrote:
> > Historically both TX and RX have assumed the same per-QP MW slice
> > (tx_max_entry == remote rx_max_entry), while those are calculated
> > separately in different places (pre and post the link-up negotiation
> > point). This has been safe because nt->link_is_up is never set to true
> > unless the pre-determined qp_count are the same among them, and qp_count
> > is typically limited to nt->mw_count, which should be carefully
> > configured by admin.
> >
> > However, setup_qp_mw can actually split mw and handle multi-qps in one
> > MW properly, so qp_count needs not to be limited by nt->mw_count. Once
> > we relax the limitation, pre-determined qp_count can differ among host
> > side and endpoint, and link-up negotiation can easily fail.
> >
> > Move the TX MW configuration (per-QP offset and size) into
> > ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
> > centralized in a single helper. ntb_transport_init_queue() now deals
> > only with per-QP software state, not with MW layout.
> >
> > This keeps the previous behavior, while preparing for relaxing the
> > qp_count limitation and improving readability.
> >
> > No functional change is intended.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 76 ++++++++++++++++---------------------
> >  1 file changed, 32 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index d5a544bf8fd6..57a21f2daac6 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -569,7 +569,10 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >  	struct ntb_transport_mw *mw;
> >  	struct ntb_dev *ndev = nt->ndev;
> >  	struct ntb_queue_entry *entry;
> > -	unsigned int rx_size, num_qps_mw;
> > +	phys_addr_t mw_base;
> > +	resource_size_t mw_size;
> > +	unsigned int rx_size, tx_size, num_qps_mw;
> > +	u64 qp_offset;
> >  	unsigned int mw_num, mw_count, qp_count;
> >  	unsigned int i;
> >  	int node;
> > @@ -588,13 +591,38 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >  	else
> >  		num_qps_mw = qp_count / mw_count;
> >
> > -	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
> > -	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
> > -	rx_size -= sizeof(struct ntb_rx_info);
> > +	mw_base = nt->mw_vec[mw_num].phys_addr;
> > +	mw_size = nt->mw_vec[mw_num].phys_size;
> > +
> > +	if (mw_size > mw->xlat_size)
> > +		mw_size = mw->xlat_size;
> 
> old code have not check this.

Thanks for pointing it out, I'll drop it from this commit so the existing
behaviour remains unchanged, as stated in the commit message.

Thanks,
Koichiro

> 
> Frank
> > +	if (max_mw_size && mw_size > max_mw_size)
> > +		mw_size = max_mw_size;
> > +
> > +	tx_size = (unsigned int)mw_size / num_qps_mw;
> > +	qp_offset = tx_size * (qp_num / mw_count);
> > +
> > +	qp->rx_buff = mw->virt_addr + qp_offset;
> > +
> > +	qp->tx_mw_size = tx_size;
> > +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> > +	if (!qp->tx_mw)
> > +		return -EINVAL;
> > +
> > +	qp->tx_mw_phys = mw_base + qp_offset;
> > +	if (!qp->tx_mw_phys)
> > +		return -EINVAL;
> >
> > +	rx_size = tx_size;
> > +	rx_size -= sizeof(struct ntb_rx_info);
> >  	qp->remote_rx_info = qp->rx_buff + rx_size;
> >
> > +	tx_size -= sizeof(struct ntb_rx_info);
> > +	qp->rx_info = qp->tx_mw + tx_size;
> > +
> >  	/* Due to housekeeping, there must be atleast 2 buffs */
> > +	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
> > +	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> >  	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
> >  	qp->rx_max_entry = rx_size / qp->rx_max_frame;
> >  	qp->rx_index = 0;
> > @@ -1132,16 +1160,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  				    unsigned int qp_num)
> >  {
> >  	struct ntb_transport_qp *qp;
> > -	phys_addr_t mw_base;
> > -	resource_size_t mw_size;
> > -	unsigned int num_qps_mw, tx_size;
> > -	unsigned int mw_num, mw_count, qp_count;
> > -	u64 qp_offset;
> > -
> > -	mw_count = nt->mw_count;
> > -	qp_count = nt->qp_count;
> > -
> > -	mw_num = QP_TO_MW(nt, qp_num);
> >
> >  	qp = &nt->qp_vec[qp_num];
> >  	qp->qp_num = qp_num;
> > @@ -1151,36 +1169,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	qp->event_handler = NULL;
> >  	ntb_qp_link_context_reset(qp);
> >
> > -	if (mw_num < qp_count % mw_count)
> > -		num_qps_mw = qp_count / mw_count + 1;
> > -	else
> > -		num_qps_mw = qp_count / mw_count;
> > -
> > -	mw_base = nt->mw_vec[mw_num].phys_addr;
> > -	mw_size = nt->mw_vec[mw_num].phys_size;
> > -
> > -	if (max_mw_size && mw_size > max_mw_size)
> > -		mw_size = max_mw_size;
> > -
> > -	tx_size = (unsigned int)mw_size / num_qps_mw;
> > -	qp_offset = tx_size * (qp_num / mw_count);
> > -
> > -	qp->tx_mw_size = tx_size;
> > -	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> > -	if (!qp->tx_mw)
> > -		return -EINVAL;
> > -
> > -	qp->tx_mw_phys = mw_base + qp_offset;
> > -	if (!qp->tx_mw_phys)
> > -		return -EINVAL;
> > -
> > -	tx_size -= sizeof(struct ntb_rx_info);
> > -	qp->rx_info = qp->tx_mw + tx_size;
> > -
> > -	/* Due to housekeeping, there must be atleast 2 buffs */
> > -	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
> > -	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> > -
> >  	if (nt->debugfs_node_dir) {
> >  		char debugfs_name[8];
> >
> > --
> > 2.51.0
> >

