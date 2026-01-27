Return-Path: <dmaengine+bounces-8524-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO5DCpcyeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8524-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:35:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0478F9F8
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A459C3046AAA
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1330CDA8;
	Tue, 27 Jan 2026 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UwZWXIzq"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021079.outbound.protection.outlook.com [52.101.125.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21F3090D5;
	Tue, 27 Jan 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484898; cv=fail; b=h1QACB2O6+xtRYKjlKGGyIOQFdXKgKLS/lHB7iYafOrJCeDzVhJ7wJKpSF6boFatDqo0WkJsxXHUET8ZbRpyEfKARzcO1CaPp++Empj55hKcrC9t8ssq5cUT+bjxeL9k0FdxNPDDY2fjhpGEf4E9hFFwPVonMI4bNLax+NGDaVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484898; c=relaxed/simple;
	bh=Bf2Ec5QBUM8LeNhHeGkTL8aWtbuHrkT4Rc1fBrLB4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9E0mOMlZ3ik8nGDqHizSt/ONBVM02PXt6VYI5ygixxTa7YjkivHHLovk6MgSpzqlsQYTChz4BrfaDk8GjDyn/OG/OUuyWskcqAPpdU+4R9TbmhEN3CUfz/64ovD8qYOW+K7PWNy5W+fJeUXVTTdHBNqRvUXQunouVf6VnQxcKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UwZWXIzq; arc=fail smtp.client-ip=52.101.125.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNTOBBkuDFL+6103qtvNIBo542cmafrjRDviAo4BKra7IJC1sdkSBxQYz4KzriFxbwi+f5mtRh0UB+OrRfI01rx9kU3LJhwZG93PMA9RI3sw4sRidXLby7WW6vO5sY2M7jYhZ85Jp9pVNHoAVklvKGwtORDdaI0Qb1+EkQQZpyfmw0IP0EuU6ON9yrUTDurxCxNSc7mpxT0VEVGDN99+fBkf8Z3RPSClKjtRf+0tDl82rK0LlYHGbaZu/XFUTUXhFnknOByNGXlvok2nWKXdAv0UpgGhedn5fmE4FLw7Vh+NhWsgGMES0b089KueY1nIGcWuwdZtiCN/SuaJ326vnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF9A79SBr+lIwHNoh88aFS+QAwTiruwaGBVdzONKrCk=;
 b=Wk7bO+dYyZj5z1iOTd2sQ2oCRqz4VlxmnYijfMSIlvRHawDAPxHlhHiC6U4mbJthh0sjptq85/4ufz5siGj0ewdgq47ry8+sqEDisF6yqsrbscItqmN2aLUSVErbsKpNEEJiajcMr0qGhl8Fv+fLds8yhvt/0jXmfE5V2/K2GLUg1d+D2PKNQAa2D9/M3xahwN6aIQVqieIZRVFn3ku25+x0vagWbbueL8RChMN8cSITp4THr4JiuQV5Y8d+1xcC/J+9E6p0IvXKj3CGVU6aGjAniL1CBwQvhJ98+2lZ9OtS3KpzPxOkaZIbKZReF5IwuG8teOeupzkHLcH/OU27Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF9A79SBr+lIwHNoh88aFS+QAwTiruwaGBVdzONKrCk=;
 b=UwZWXIzqpiJhlvmA36exSNa0w0OW7mgT3rRdUrJIAgwsXB+FGac2SSM81NZiu/Lvi4rwxLOomGkAalgnnz6v9arkMZAOqcuNLAi92TiJA48fMFXv1s53S5XkSdz4o+dyXkEDwOq6F2LcDpDsQsQl3blVvSKmZq8FiVNMAE3EZR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] PCI: dwc: Add helper to query integrated dw-edma register window
Date: Tue, 27 Jan 2026 12:34:19 +0900
Message-ID: <20260127033420.3460579-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0074.jpnprd01.prod.outlook.com
 (2603:1096:405:3::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: bb78b95c-4cab-4169-9203-08de5d550444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2+bVN3ui4zxIepFcXD1uXo8X2MArMNzVEFafyojwrhdk7k3nQQfcKxyPfQK?=
 =?us-ascii?Q?DWePUhWsZNZLoXcKEBWJVjp3sENpsnuw6rifvDUw1O0R9w+9ThC1HPhVcTeL?=
 =?us-ascii?Q?9lx2Os7WP834vdOdq1d3e4iTmrbgi7bdJQoBICz78T0Jb8lKj90z8+ukFhwQ?=
 =?us-ascii?Q?bSYzghkBP5494KNvqqSYh5cE5WH5YxF8x0G/p1ZB6UphZcN2xrO7CmZKCrRg?=
 =?us-ascii?Q?UJkvev4AIbPNhtQ2ZSKw3geG0KmLAk6P8mgMMelIWpee+++eeiZUwklTfRv5?=
 =?us-ascii?Q?kLs4n0qoRy4IbP5DgrEltBI428uASYxQ1x1KhucDk1Fy2dZqeGsV4fMo2Em0?=
 =?us-ascii?Q?RUKTqGv5MGIt2q3gWIOG9RgOiyUFb/9MQFtNfamJnm8qez3b4lWRRgx4mpVg?=
 =?us-ascii?Q?9ewl64F6p3wHGw/coAyqg4CW5dBHs5xJNmTcUCDIYpcqnWBnsJJF7bJChq3U?=
 =?us-ascii?Q?4t0C8McPhMp/Z4sTuniunoD2ZVzChd1vMirhefzUxQPOegQilQvVoNKRd8eD?=
 =?us-ascii?Q?F96NtRhKfUhLm6zULgN6kW6a8IgePi7AdrD17yjHcokkPDFo9Ksp9cpYzbTo?=
 =?us-ascii?Q?S6a/mVb51Oft39+uVfAnoj86DtvXiBbEkgN0D+N45ngcUr0Of3JJ8zxUCMCc?=
 =?us-ascii?Q?5U/GltWVcAWn6R8BFTjq4ULatdzptPb0+1V7tHvkvXU1swjk98rDVjJmC1Xs?=
 =?us-ascii?Q?plFmWeDOFi8hOP9WOa4ZlgFRxPe4iAZyh6CvtJyCv/nsyjkgGhEKXV0DohNQ?=
 =?us-ascii?Q?olhvBLUKEqo5TF9zSOo4wTKoIInUVkLldP+trAklw4cR6LJe5mCF5e270Isr?=
 =?us-ascii?Q?jpP9Icv71NsSdpgymZvXt0Y0lgkPxMJLwBNA1+vCxvYhzJo4cEaWfdIRfofl?=
 =?us-ascii?Q?iQryAFAZYLud4yIBBAQK2NE0CDg8CDuUzbQHeunrgpyGVgijAwskil5RU+1H?=
 =?us-ascii?Q?zKcKk78DXU1WRS5jd4FMvAzfJAnxNqphCwGWbRfS3fGCqY0jaoUbRYxi4SiZ?=
 =?us-ascii?Q?KsB9NkVSfVZI7+aPexeFWev5qhNpGvvOdGRfqBfHyv9AuvJbSuNpcrjhQTdS?=
 =?us-ascii?Q?5+8gRD6DzofwiAh06lDDfKHFSgVe17OPor+iWLFH+5hJzd9qpx5xqau5dKTv?=
 =?us-ascii?Q?YQtCtsx0Sxsih/8vWqoPkulq/JZ5dyF/sDsBnAWVRk+fSGM7mCYbgtS75A/w?=
 =?us-ascii?Q?qfSucpSrNmHkQhFjrB+KFcCMZTmYFFk7JgrPydCsedU9+SrOsHnjSt/2T3sD?=
 =?us-ascii?Q?9H7VSdyizbrXtlxIMciTRtHsSD108x/QZCFZkn4Sa9WA5NbTlhSTqZqRncNH?=
 =?us-ascii?Q?MpFtuPV8AWdlxtE2iidXqxmOVwY3Ksv36mdak9ylopk/PBLUHNjUR9nG2ZQH?=
 =?us-ascii?Q?sl+jgteKJH9uK/Z46ZqIcGIptXqDNVputqZsHpXkQz28Smg1ROimNM+tTJhH?=
 =?us-ascii?Q?21P0HFzvGj+fpgEETGfcpnyAYgceC5cY+NRKaCgvrnm7No9Tf59uawV0jdQy?=
 =?us-ascii?Q?bt+YD+3xdGEzdXJiJ05EjC5CYcVbOkMCDqAW0/pn5CSvRV2Uk7Jpr/K0Zb8V?=
 =?us-ascii?Q?zLkNeZ9pM4d7iE5cizA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYYXaq/qdDt3oQrIyeO+IE3DnV52GM9ZNX672kAICvln3VTxLlBnCZUpR4VF?=
 =?us-ascii?Q?W0z8gUt2ag+ehlPRFqjvchQRAr+zWde0eD86Sd84fseQlhDP0fMMe4f/Mga1?=
 =?us-ascii?Q?IsG8sUCgfPaSmoJL91eTv7WaolIAVPTmxKXPqEN6S4Zl6foI91vVKMR+BWNw?=
 =?us-ascii?Q?IMgu3eB86QuaOm8YgeVShdkYf9sTxTbs8Bn0YjAWwmkxaZyIjp42YllYO9Cl?=
 =?us-ascii?Q?9hp2MB9vDSBftI3vANilZiACbn1XlH3RmswdX2FgzuoE37O+BWFQ+SwSBl1I?=
 =?us-ascii?Q?BrcGoTHCUIlJaD6PAK21JpA8Ru8Aw9tfkDPT+R0EstQPgJioyiRgdVsmmzJY?=
 =?us-ascii?Q?GLDYA27OWyulWDSl/01stiTi9QnhswqShIUTed5kEqKRKeq30n9z8w+FiKEt?=
 =?us-ascii?Q?bLD3SA/Ff0KHsPTfIqEWSO6+2Bzlx7xJtVtveWs8HZdBuo36fc3QQXd0HtTV?=
 =?us-ascii?Q?6nCaI8eOxrLQZ6hop/tkb4nNAlpB/zDF6oLOQJvfNDhiPKYddn14AXOsTAOo?=
 =?us-ascii?Q?KTgr4CU8mVn2D2ANRg7T/ThDnO3AVaGezof76BC9OmLIWgvB/Ts3HYPCaKhD?=
 =?us-ascii?Q?r0F2FvAcxR+p6mRJbdlBqlfW1qOqBeGyWcSr7VyHEgSPMSWvkl2JZ0UAnP+f?=
 =?us-ascii?Q?4Cx3ul/D7n7QY7X/pVgU+UAAQI83qJknjY1gr70mmLfsWEn61SxThNmlNl4r?=
 =?us-ascii?Q?MmnUsVEZo5GxLI8zNPNITAM0nZRDiX0CUWR0LqTcgJEgI7sMF3uWUvoMJxio?=
 =?us-ascii?Q?JQqR2zOy/Tkf8X+zivk2Y/wFkoe5Rvdo5ueJost824BcGRMHVTP6rcjrq1G8?=
 =?us-ascii?Q?9pMnc3cFmMOqeEU+wx5AHzDn+0yHaIVDkVuBfAUTriJjUJMxvpVk0Je03uas?=
 =?us-ascii?Q?cr4KZCKKxwqbrn1jHfDPdF1GeuJcXLSuOnBiyarQcotQvdtDqzdRd9eXOGru?=
 =?us-ascii?Q?Zka8SByIPlgenOO7Cd/23JOCujWvAA8xJq3fOGZuwMvZmMhU3talo7ftX7NT?=
 =?us-ascii?Q?laouM83YsDdSGyoCV3Kthw7bLyhrxcTWcrkIenj+tMqSce8IAGUe8J6v1MdV?=
 =?us-ascii?Q?KBKcMxEWSOhQEQw7psZsVI6Yy/PbI01CxAyd7FcMq5N2pvNKHor6eDc7dNt8?=
 =?us-ascii?Q?gJSzvBI1FCAxhsUbsuWG4XhIYyX/IsOf7S0EXw2PPuBpqiQ7mSSIwiGJpE0o?=
 =?us-ascii?Q?EIHRZfcMfX1BFn2e+G8GEM6Fpcv0ihwbGm4R4goXFJbGzC9Ejk5qy1GeV8ax?=
 =?us-ascii?Q?KNTwOdhiKYgoWUpSUtbqQXeQDgQ/r8xJtDVSaCAAyoYp7c+6Pdtmu+qHevhT?=
 =?us-ascii?Q?8mdO1wdXc9iPn3Sj/aydTpNd7PKWdg2xJW39m0z0znIFq/X09tu+BsZG0rKB?=
 =?us-ascii?Q?bD2fQ8Zoo4iMD4AA2Z2Q7MSC3KjQtprhQtHyskUFqIEiz85Rn0Br1YeTDrTM?=
 =?us-ascii?Q?8BX02orqZNTZFOEJoUKFgLogr1OitOxY+63mv9Tp7MHg0KOCV/PPoZGKO95p?=
 =?us-ascii?Q?SwUdBGdiGnPOkp8py3j9RzztJ2L96wTAWH9G16AeLYhWk9vy/ooDZPHDlXqB?=
 =?us-ascii?Q?Hp1rBtECLPg76DPcxG2+L+ZEsxXIE0PtP6+DDPMne+7AU9bW76HBRjj2QAi7?=
 =?us-ascii?Q?uT1DLfmIGQ2VrnJavtPE9OjToL3m+YwHCGq4FiXaOPLRmGs9NfspcU+N43OR?=
 =?us-ascii?Q?lgiO2H8QinQ2aJ/NYCjDF97MAn4YSlWEiLOnvooCEHuDLUeTSb3lqrXw020A?=
 =?us-ascii?Q?2zsH7+L0UVrKj/EzmfY8hqd+S36YK8aCG+kIutAKRdQ+eNEP85xH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bb78b95c-4cab-4169-9203-08de5d550444
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:45.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKLKmoyEQXp025ZoMaOcrTJvW/0ZPjL/QtvYhKH8p3P7R3mtC1FgBUiI/aABiuOzh6n9WDBPaQvzrwLgAi3t5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8524-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: DA0478F9F8
X-Rspamd-Action: no action

Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
instance. Remote-eDMA providers (e.g. vNTB) need to expose the eDMA
register block to the host through a memory window so the host can
ioremap it and run dw_edma_probe() against the remote view.

Record the physical base and size of the eDMA register aperture and
export dwc_pcie_edma_get_reg_window() so higher-level code can query the
register window associated with a given PCI EPC device.

Keep the controller-side helper declarations in a dedicated header to
avoid pulling eDMA/dmaengine-specific interfaces into the generic
DesignWare PCIe header (include/linux/pcie-dwc.h).

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 MAINTAINERS                                  |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c | 29 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 include/linux/pcie-dwc-edma.h                | 39 ++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pcie-dwc-edma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..fa0cb454744c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20066,7 +20066,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
-F:	include/linux/pcie-dwc.h
+F:	include/linux/pcie-dwc*.h
 
 PCI DRIVER FOR TI DRA7XX/J721E
 M:	Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 18331d9e85be..bbaeecce199a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pcie-dwc.h>
+#include <linux/pcie-dwc-edma.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -162,8 +163,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
@@ -1340,3 +1345,27 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	return cpu_phys_addr - reg_addr;
 }
+
+int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+				 resource_size_t *sz)
+{
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci;
+
+	if (!epc || !phys || !sz)
+		return -EINVAL;
+
+	ep = epc_get_drvdata(epc);
+	if (!ep)
+		return -ENODEV;
+
+	pci = to_dw_pcie_from_ep(ep);
+	if (!pci->edma_reg_size)
+		return -ENODEV;
+
+	*phys = pci->edma_reg_phys;
+	*sz = pci->edma_reg_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c3301b3aedb7..cd38147443bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -534,6 +534,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
new file mode 100644
index 000000000000..a5b0595603f4
--- /dev/null
+++ b/include/linux/pcie-dwc-edma.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * DesignWare PCIe controller helpers for integrated DesignWare eDMA.
+ */
+
+#ifndef LINUX_PCIE_DWC_EDMA_H
+#define LINUX_PCIE_DWC_EDMA_H
+
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/pci-epc.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_PCIE_DW
+/**
+ * dwc_pcie_edma_get_reg_window() - get integrated DW eDMA register window
+ * @epc:  EPC device associated with the integrated eDMA instance
+ * @phys: pointer to receive the CPU-physical base address
+ * @sz:   pointer to receive the size in bytes
+ *
+ * Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
+ * instance. Higher-level code (e.g. BAR/window setup for remote use) may
+ * need the CPU-physical base and size of the eDMA register aperture.
+ *
+ * Return: 0 on success, -ENODEV if the EPC has no integrated eDMA register
+ *         window, or -EINVAL if @epc is %NULL.
+ */
+int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+				 resource_size_t *sz);
+#else
+static inline int
+dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+			     resource_size_t *sz)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_PCIE_DW */
+
+#endif /* LINUX_PCIE_DWC_EDMA_H */
-- 
2.51.0


