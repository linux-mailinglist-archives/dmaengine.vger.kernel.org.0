Return-Path: <dmaengine+bounces-8743-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEzBDv6fg2kLqQMAu9opvQ
	(envelope-from <dmaengine+bounces-8743-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 20:37:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B5EC1F5
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 20:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01380301371E
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C38423A6C;
	Wed,  4 Feb 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UV/MIke9"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F20423A6B;
	Wed,  4 Feb 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233840; cv=fail; b=LKfHYVgNfBCZLtw/5/HRDWSJBEnkQDNs06GKs1yiXKAL5jKs1P+vopK+r0kmH1C0qw/Jtn1GzjpoTBdvolGNJlgywtLv0uguDBYhUfDFQdxHcuZVNEJoy/WdXYvUo8JhYxwFcVoYbNEJJPdUa/e1HUL2YCwbb2M52nbW9uMX3/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233840; c=relaxed/simple;
	bh=ZSNGoDVgdXOaMUzGoPcv8DTAF4WWoWRNTUfRGfUBLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=epuPdURQn8scNlMgFkiE/JoWI7bPFuNj7oFJPqa3tcLXUYkP0xi3Hku48IPAQImFdXxQqCGddLThAS7dm7GCEYekTJU7FZHM4brm3nx5hgZggk8vZM9aYH7JPEbww/OqQC3jla2nsSTu49XFBt3BeCU4IbAbgm/2PSJy0XCP22s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UV/MIke9; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeucON1YwQJ75Jdh+jgp3G5gLuQXk3zEHOmtgpjZVVUeSHgYQErBX15ONwyRUYBBEf9nBMwuRzozARylMd/ki8GZhoNg6hlAoCKi7j3ffuSfu7WzGnbg4GsqDYESwrqajvUlWlHXYE9MzB0AC9JhuIXWc9R5kh3xscIWMxK0Nh3B18Gil5ZopHmS2RnHJRavQIDHKQ0r9q0wfWcxuziji7DLPqi5qsifw32MtRk7b/NYGuhR3RdhcFSjoxcr3XQ3t2aHSKDc3hcLNEJ0K/Wq5RpxsACl5QsR0OPRNit7DCVX66RxhnlIbV6StD8KqxX3Zw6bpSqQvKrYj7ad+2tIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiuL1pzmYdNLtGYlz5c14VT3zNSwll3QF+SkYO1wVuA=;
 b=MQvV9gfl6fm9rc1A+zq4oVKKFW/I6PRST7HItkkzxMe4x8LIvd+L+vbqyi85i+WfMoY5YuUbxhKJzum442hPc9em2VePYr2tQZkPqoRygPPkQ9HRyaCPqO1frphB4fn0wclT+DOr8q2fMWkPs9TvUrWPbWLLFbQt1cs2nfs5xdR7v4lNOVLx/fiMaqPIYX66AVvTu6w6tc8HJ/lSR8GKrUSYlkXnpXdN2gwZsJcjz3IsLneQLtWRRLLcEVVzxf6GOggplvmwEDeCXeFEOqChPs/oq+H7u6CGKQyTXWe5ZnTiy77P4ZttU+unwJGl1K2hy4WDfq36sOUCgd/Pmvv32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiuL1pzmYdNLtGYlz5c14VT3zNSwll3QF+SkYO1wVuA=;
 b=UV/MIke9oWUB/8SxdVw741q1GdWXzulPBsk5qywQK+Qoq10i6mYMBMxtaIdoOvho0Qi7xJimFwEPc2DkDH/hrf1e9K57AX7oHXhZY4HkULKhyNnbl44AOTbS+FOf68QwwHr5x1bMlhfruE0/V2XItuWX7LwdurA/BEYzXv5nQAF5T4n5vECG4kuS8SKHM6IjKxIW0mbyZ35tbRqjnbZHDm4sv0U/b+kiRJ7UJ993JjFhzG5dHM2+lBMI3EtaCLKRV1cOt0GUwLo8OGPV25dg5vK9LHpI2LrWBHeV/socKAO07vTrwgY0rNjsw1RR3cthr28LS2iYJ06uWD2rjbeAZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by MRWPR04MB12044.eurprd04.prod.outlook.com (2603:10a6:501:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 19:37:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 19:37:16 +0000
Date: Wed, 4 Feb 2026 14:37:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] PCI: endpoint: pci-epf-test: Add smoke test for
 EPC remote resource API
Message-ID: <aYOf5DXQjVEpcwCE@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-10-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|MRWPR04MB12044:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e898196-ef46-46b8-8a89-08de6424cd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnJz1YP4/Ix8q7h0EewejC6bK8VBqvHBwuxsiwlwLedh9+T/dlhrH30D7nR7?=
 =?us-ascii?Q?nEejcUt+caA2HqxwVPOl+W17pHVrbltFh4mMcJIcwlKu7WSGFbPfBfNVEFMo?=
 =?us-ascii?Q?RWqAUtS/Z0bWljgJTvwBBChkX3WzI9SakALkJPJ4pzdeLKMBwnlvI77TL/p6?=
 =?us-ascii?Q?LhPlp7P4wD76hjjZYHN8lxAvZUXbR6sd1sLwdYWcrTF0iQ09TbnIReySGy1e?=
 =?us-ascii?Q?TtLgntbjgxcIcaIw4pqWAF6TcmMT/d6no9djzgxiQvkIl/+MGymKOOTCPBJs?=
 =?us-ascii?Q?O4DfOX2iyAOQTTVu/c91quQEC5+ElBHkyvwwpc06IUmIk3aoOwWhAWJ/Z8X8?=
 =?us-ascii?Q?Z14tbYsWnx+dSvCfr3baG9dYOAV8JpFf+ijLa1Ow9Anunfmo8ezVfwR8vgB9?=
 =?us-ascii?Q?7oXvRXKRj4oXTl8uTaRTHSJC8SQ7cWqqYRYg9yE7bwSIj3R2Fv1IgqsHpb60?=
 =?us-ascii?Q?w5ua9cqVubhQIL7CAtDidezaqXCOUEyJMlqmEPvJYtjYBrVRDDbSYO8NaW+E?=
 =?us-ascii?Q?ImHlmEpR5YbZOR8Bb/oDJSfyPYyHIkPJYUipB34AMJ58TnST7T0qRmSC1NsD?=
 =?us-ascii?Q?SimkhxpoQ4jM0Xg+4Hj7e63jFSK/lJbbnKwANR2dns/HfX9qHOaAdROAiNpN?=
 =?us-ascii?Q?6lq+ifHuuzjAy+Y1pDV31gwkCSGqalIpZkzVTspuK82uUKvV1OZfYBSgyz/r?=
 =?us-ascii?Q?CLKZh7yV3FSQynCRyeTkoij4ktHOFxLd43tOS4vk04CPNk8hi8y4COqXrBM2?=
 =?us-ascii?Q?zcYRrv5eisb8sB4/l1zb6Dpy5BAcVIEgdQo5SrO97D7/jkec2UHt4rAOoPfr?=
 =?us-ascii?Q?tSayqrMP/2MEnQH49bZ762avLonNVD1u0r5fMnikcav/IfS81tzDUlunhwLY?=
 =?us-ascii?Q?THPgV+4anR1r4V0NpWeEn80brWAwx8RCtB4bqibS0NLOTIknbL9/efSjy9lC?=
 =?us-ascii?Q?dsWmp+U3Zt0xgsFkKAAHWK5SXmb+0rreYIthjxZpZZ+gOB5+WhzN6gffccgC?=
 =?us-ascii?Q?swSzMV0vd1dkGKLRvpUqrg345qPMi6ieJ993ZJXNqj/ZYp0gzHnK+yCvAn74?=
 =?us-ascii?Q?QQSZf0KMhRNs1EhvuqTM6lQS9OFC5fyjGvovgUMW9cnUWYrvDtvZjc6QiTh6?=
 =?us-ascii?Q?ybTHyOdP7mLT2yvqkJHG2tLGPsRgORe9pEAUssQn/8eTYXkGKiwRmHw/ebpx?=
 =?us-ascii?Q?0QKPhwTboccG9IH3ZXmcw+G66DARkSRi7ISh1q2jr7te26XxRZP+tb9I5EpY?=
 =?us-ascii?Q?5JaMu9ElgrTi9K8Mf9nG+BPTXn/EJ6WMrQD3Z60tjXezKA3i1CW2yluFi3WX?=
 =?us-ascii?Q?Ot81VSR9IKjyxOYoNuHFn5C4uUVRnuX7ixQWCc3Vy8DTaFvOTAzYeCNW0zAi?=
 =?us-ascii?Q?XT63Qy0Fj/rM4GeTWM0IMqyFdW/tX908zAIHyogqnfKov6YT+twriREdQP4W?=
 =?us-ascii?Q?2q2bI64jtZcT5ptXB1XnXe2QKPv2fxI/ABr36zIs5vu8dyay0w+rEWhzznw4?=
 =?us-ascii?Q?asckHp3Nk6UfvMSfRvMfpR1AJ2dPa3G8n59cE4n1SM0udrx4i9w3nGwKc7Jr?=
 =?us-ascii?Q?TjnN7VUMh8aMw+qfwg5a3qhFlnbAlBIM9k0dp1jFVYYeu4rlczBvucXi7fhK?=
 =?us-ascii?Q?KgSI5t3FLWh5HYNbeCZhz2c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?352/wqSMx3N6J/Q61mwJHMXdA5bw+iMInQ5kUUhE3mO49MWO2knyaKFRLMsT?=
 =?us-ascii?Q?CWbhKhb5qhx8Y7MIP9S12Urz1t7376l+6OQJth9eCfQbUn/QSB7WYS3k4lEi?=
 =?us-ascii?Q?iNBgjERzrvnC4MZP6A066WQR5uOdZDrLBZ1zZDD2Sp2Xdm/ty7TY408eLT5h?=
 =?us-ascii?Q?xSk8WoJo8V1QKNR/+zRF0f+AtWPSs5QlfXamTDxF0M8O0aRZX2PYLarHsFm1?=
 =?us-ascii?Q?LsyBdpVhTNAV4NJXTxq9AzpAvIZoNcA0AEsyCpmgUn3WZkuExc5ApxPZdTjq?=
 =?us-ascii?Q?NtHie1HND7VVkSzl4Xxazirn0SX62neL8MZ0/HfX7w9o2n14dlq+NZNrdxSl?=
 =?us-ascii?Q?q2uijzKd8zmMfL4YaQmrnjZA4MZ8WqC224bAMlHekVLHHhhvX6WBiyRLtBJR?=
 =?us-ascii?Q?HWAG9AzhwqVEThyS266BVH3UoOuTX1LbuR+hx6o/EcDs/8DvHlDqDex+ixie?=
 =?us-ascii?Q?DIDsY6hb2rDgYGXRZS1XSndvl/JvKhYIbdQTCO0uGiTbWwSp3Tm1EXXUU9oN?=
 =?us-ascii?Q?8RRL7igT4JH+v42PjVjrN0A2JFehJKxCP42emNOwe6xJsUnXi8iX91Rbp9l3?=
 =?us-ascii?Q?42I1cABbfjuAkiTSHiEOCTHI0t3tk9HwCuqGnMEGwiYwpMtjoRJn5O4cCxDI?=
 =?us-ascii?Q?BEX5819YPEH/LywepPBB+u5TCSCnnlDGrSe4bDoos7dJoWoq/jzxHtFwa2Zn?=
 =?us-ascii?Q?ck5P1ew3jCxITUt1lb1EJK4QxNze7pbSIpYlV1BkR2x88g9AyAt2eT6akJKi?=
 =?us-ascii?Q?pzpeTwSBHWnRvsY8aiUws7IPrbzutvWaoEVj/GhmEEJrl8b5z42TODEExyhV?=
 =?us-ascii?Q?4fuscaqwtdB2yA0uYVVB7oeFV+peY8Q2B89HbvOnKPStMPQjirDgCTlJ7iJH?=
 =?us-ascii?Q?OYzeyqQIWdutxfNNeRyWnztalFR7TG9OpKJC/3YtC6ZU50JwPnU6aNIM15zd?=
 =?us-ascii?Q?snkiyJV34uPAoMgq0Hk4gUh/AU/UZY1EdO4rI17INiftB+CSj8QUU7jIeWJn?=
 =?us-ascii?Q?hBrl8uZuQuJOg33Hg7IW2aJoXrWckQYDHsuZxPxuZdW2OKcHJBVqgSkGGC8o?=
 =?us-ascii?Q?6ZSY+sGCActO4g2D6bLJFkfQXQY9PHSeudfFNWwJrlK08v/zlZ+smlFbGe02?=
 =?us-ascii?Q?wqAozoxjZ6Nnc6AoUDmPKs/2JIqIvDhDSm82jMoYunhAEjydyCexrdM0IY/M?=
 =?us-ascii?Q?QZqC1Prv5S/i5Sg744GRACFwAe1GMkmtIuDyb0fVcB/YdCVYNe8pP8PCeD42?=
 =?us-ascii?Q?cFY+3s+vjwETiM2eiCKkoPpVBkoIB9bMLxFVirIgexdpyxmHV4p129V5JsIP?=
 =?us-ascii?Q?1NUrcfK1GnL5MqfKyyUSrDLwstg2d2wigUN1xY6xLhilS78y7yUqZEb0yWV7?=
 =?us-ascii?Q?piHX4Z56EtQ8WWQvuAKmWy+2lVy41t6zXOMpjST5UPYWMkt/x2YSJFnJE+QM?=
 =?us-ascii?Q?ug1tFiCeC5DsGtWh8vwmiZA5HVlOHz5nypYjzIdF4Pg3WjaYme0sSA6Ik2Z0?=
 =?us-ascii?Q?tmD6fXvBb4UcXDfGml8nomMxSi96OHnlpxJXb0Shy8hwr06LWrft5ozKsGN6?=
 =?us-ascii?Q?rWt2hxV1mr9h056WlGetTF2abjIlPi3RWMfFw3MxHz54bxrnR1xqSXLEn48u?=
 =?us-ascii?Q?Y7d31Opv/u24uqPuckmtokulIYTUY5O3gydCbFM/+EWtzuU8MlflahCVIBqB?=
 =?us-ascii?Q?5VFq7n6b3Gx+C4vOpz/4RSKsDSjaVV5KeTghP9syBkYb23+3ef3RHmvEDuXu?=
 =?us-ascii?Q?J9AsQTmKXA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e898196-ef46-46b8-8a89-08de6424cd7c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:37:16.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MMFD+Dp6kc1iWuDUY/tjZCekPeC5gTrifZ4bb/2xg/0kK5K2PQ2WgXH20C7xWdGgw7X/xjIxv2RBD5IynuXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8743-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 9D8B5EC1F5
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:37PM +0900, Koichiro Den wrote:
> Add a new pci-epf-test command that exercises the newly added EPC API
> pci_epc_get_remote_resources().
>
> The test is intentionally a smoke test. It verifies that the API either
> returns -EOPNOTSUPP or a well-formed resource list (non-zero phys/size
> and known resource types). The result is reported to the host via a
> status bit and an interrupt, consistent with existing pci-epf-test
> commands.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 6952ee418622..6446a0a23865 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -35,6 +35,7 @@
>  #define COMMAND_DISABLE_DOORBELL	BIT(7)
>  #define COMMAND_BAR_SUBRANGE_SETUP	BIT(8)
>  #define COMMAND_BAR_SUBRANGE_CLEAR	BIT(9)
> +#define COMMAND_EPC_API			BIT(10)
>
>  #define STATUS_READ_SUCCESS		BIT(0)
>  #define STATUS_READ_FAIL		BIT(1)
> @@ -54,6 +55,8 @@
>  #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>  #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> +#define STATUS_EPC_API_SUCCESS		BIT(18)
> +#define STATUS_EPC_API_FAIL		BIT(19)
>
>  #define FLAG_USE_DMA			BIT(0)
>
> @@ -967,6 +970,87 @@ static void pci_epf_test_bar_subrange_clear(struct pci_epf_test *epf_test,
>  	reg->status = cpu_to_le32(status);
>  }
>
> +static void pci_epf_test_epc_api(struct pci_epf_test *epf_test,
> +				 struct pci_epf_test_reg *reg)
> +{
> +	struct pci_epc_remote_resource *resources = NULL;
> +	u32 status = le32_to_cpu(reg->status);
> +	struct pci_epf *epf = epf_test->epf;
> +	struct device *dev = &epf->dev;
> +	struct pci_epc *epc = epf->epc;
> +	int num_resources;
> +	int ret, i;
> +
> +	num_resources = pci_epc_get_remote_resources(epc, epf->func_no,
> +						     epf->vfunc_no, NULL, 0);
> +	if (num_resources == -EOPNOTSUPP || num_resources == 0)
> +		goto out_success;
> +	if (num_resources < 0)
> +		goto err;
> +
> +	resources = kcalloc(num_resources, sizeof(*resources), GFP_KERNEL);

use auto cleanup
	struct pci_epc_remote_resource *resources __free(kfree) =
		kcalloc(num_resources, sizeof(*resources), GFP_KERNEL);

> +	if (!resources)
> +		goto err;
> +
> +	ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
> +					   resources, num_resources);
> +	if (ret < 0) {
> +		dev_err(dev, "EPC remote resource query failed: %d\n", ret);
> +		goto err_free;
> +	}
> +	if (ret > num_resources) {
> +		dev_err(dev, "EPC API returned %d resources (max %d)\n",
> +			ret, num_resources);
> +		goto err_free;
> +	}
> +
> +	for (i = 0; i < ret; i++) {
> +		struct pci_epc_remote_resource *res = &resources[i];
> +
> +		if (!res->phys_addr || !res->size) {
> +			dev_err(dev,
> +				"Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
> +				i, res->type, &res->phys_addr, res->size);
> +			goto err_free;
> +		}
> +
> +		/* Guard against address overflow */
> +		if (res->phys_addr + res->size < res->phys_addr) {
> +			dev_err(dev,
> +				"Remote resource[%d] overflow (phys=%pa size=%llu)\n",
> +				i, &res->phys_addr, res->size);
> +			goto err_free;
> +		}
> +
> +		switch (res->type) {
> +		case PCI_EPC_RR_DMA_CTRL_MMIO:
> +			/* Generic checks above are sufficient. */
> +			break;
> +		case PCI_EPC_RR_DMA_CHAN_DESC:
> +			/*
> +			 * hw_chan_id and ep2rc are informational. No extra validation
> +			 * beyond the generic checks above is needed.
> +			 */
> +			break;
> +		default:
> +			dev_err(dev, "Unknown remote resource type %d\n", res->type);
> +			goto err_free;

can you call subrange to map to one of bar?

Frank
> +		}
> +	}
> +
> +out_success:
> +	kfree(resources);
> +	status |= STATUS_EPC_API_SUCCESS;
> +	reg->status = cpu_to_le32(status);
> +	return;
> +
> +err_free:
> +	kfree(resources);
> +err:
> +	status |= STATUS_EPC_API_FAIL;
> +	reg->status = cpu_to_le32(status);
> +}
> +
>  static void pci_epf_test_cmd_handler(struct work_struct *work)
>  {
>  	u32 command;
> @@ -1030,6 +1114,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		pci_epf_test_bar_subrange_clear(epf_test, reg);
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
> +	case COMMAND_EPC_API:
> +		pci_epf_test_epc_api(epf_test, reg);
> +		pci_epf_test_raise_irq(epf_test, reg);
> +		break;
>  	default:
>  		dev_err(dev, "Invalid command 0x%x\n", command);
>  		break;
> --
> 2.51.0
>

