Return-Path: <dmaengine+bounces-8727-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMIBKPVfg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8727-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:04:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1024E7D71
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2C7313C5DF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9F421A09;
	Wed,  4 Feb 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MVdbd/sc"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B034219FD;
	Wed,  4 Feb 2026 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216896; cv=fail; b=EXdWey/G5C+XkJG3piwYeJllMN9J3utxSh20DpPMQpZZ1V3nWqNPAqpWQ+at2mAR2hy2xmJc+8PIOM3kna4i+IO2GCh232oQgOOkzjbK0w1PYHbUY9OctD7/egNdMGxcmNVJP3f47JHsEnSnVoTb1129q9LJvBK2iWmpeRg5rtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216896; c=relaxed/simple;
	bh=snsgE8XkCmrf42e7E81nCeDkGLy+ZiQ4hwakK8Q5La4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NK25jAV8enutU2um/6tCFeDvtF+x6Tn+U0dVh+3FRMdGGYTu1Dfpiu56aU7eWu/87bTanvSg+rX5w3/ai60J5MJDOg34pd2MJlGLmjW3as/eAmhvY9wqBKIZxIkPWzzCOXdk+bQ7zP5Q20j+WLkCCGqWU/CagRZ6RmovK2Tac3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MVdbd/sc; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toZpIAg9jg1RY/2OnlN4KW77oekKXmmiCawzQt64DjEv54HYdhjjN5uwGUuIlvTpIWXHIDCozvkQUKeIi5jIIffhHS7vGmwqBcs8e0pvfGgEuwHNT7C42BIiYIZ3oPVYoG2LbUoYTuTNw5TCJjvDSooEwQamdJV86HfADLI+CqBlX3z4ALqmzualocKJklpdV7IDuJcPTaECwubFYsoP21L3JbBSIYYYTrr0RiqXzo4R3mHvIPMNPBseeix6SSOzHImTo3PRuoD+9hnX+mFv/nw5efkUZ75RJwPSEAS9YGWFFhjFmOlc/sfDkiv76aEIMnc08GB/WRcOXRUtp1KR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCTb3O/PCYfFgnJ1i96k5LBnchMAUr/9JEUwYZnFsmE=;
 b=EiVOhE0J7m0KlxIYgL+giOjVV++1KNe2sXRWBl4ixjBs6J6mNzj223+s1j3lepkB6sT6SHXO0MoGNhZ4GNAzwEBEf4UtN16rXZNZiTTXlVYJ8x5r09WsbtUpnjuqiA8L9W2XJSL23S6GVxIXJqpU8ATTVySqo2OCgc6lQ7sWdkq+WDdYLrGwI6wOyTJ6jlGAc05jZiWRLB2N0JEmjT1PqM6eDRknRotTj8BVLEYn8+Z7YTupcULemWiiKZFmMa8gs8dbohp57x60YaCIXN222VYVSX0NLgMtb5dUz8SIsFFrpARSWFfN3KDVvM+mbC6VzwuH8XdEtAdoWzRb9+Tm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCTb3O/PCYfFgnJ1i96k5LBnchMAUr/9JEUwYZnFsmE=;
 b=MVdbd/sc2GHIuKYlsn5M2UQkpXxgP30KGYDalqfeISuC1079fQScSrK9+ja1tgEwj8pL6P9zsrFMb5YhK61Nu5VgV5h/666MFndjM9WrM5Xs92CKKIXF/20Cvb1NGx/n9axBFR514sziPM+vhgYVBygQwgrbRfdIqkBp1gj+UaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:54 +0000
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
Subject: [PATCH v3 09/11] PCI: endpoint: pci-epf-test: Add smoke test for EPC remote resource API
Date: Wed,  4 Feb 2026 23:54:37 +0900
Message-ID: <20260204145440.950609-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c90b908-ff5f-42c1-e0c4-08de63fd5b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8WvPCWCb6muEXyYHJI09bNbOv8V+PvZWSBLlVZVVuj0DAJendsPCe8Xcl6v2?=
 =?us-ascii?Q?FReAbrEecdqUUjV06iQaeqzxo4EiVaTbDUUYpzhA86LQEqDiT5kmXxLaflpG?=
 =?us-ascii?Q?L5Ph0MN4pBk30YGqvQsjqti96hT9xHgAdyxGAEVyGveQDkGjA00VjFbcpevY?=
 =?us-ascii?Q?Bhlne7Hhl1FhxcBXUFslwZpi6M1zPRJWX73vR+iNyygCi3FDQPkePwzGREKM?=
 =?us-ascii?Q?zbR71sepAYVmYgJ38/Eb7dGNg9s/lWhQ12Zl3khGPY/pdufkGBubw9dUH0GK?=
 =?us-ascii?Q?fYU+8dnpKDvymqmDtCeYAQc1apELKZLjOMA4SssW+/cjTNPRZHWK71Ypgx+e?=
 =?us-ascii?Q?lbkuKMlnILmFsIqcGb5DxSyt9XqCOszDteGRtkdhLFmnsflJnuouTiRR7cKK?=
 =?us-ascii?Q?B/h3qbWCrC9j/MkTAFAcN5xaJKvel5msle3JcQGokAcp5zEjTzYe85G8YpJr?=
 =?us-ascii?Q?fOQl770EfJi5DuS3FV4ezvVsOqPEYwvGu8OL/sfhp7qJGY13YMVtQ7uUybqk?=
 =?us-ascii?Q?ZfhdEGUhv50cd1yxf+OVP7OT37kG/CjJfUx7g/3gM1ERl6jIBDIfJvewLlWq?=
 =?us-ascii?Q?k9UggpsqklIMLaxJnf4cNB0gLQ04F4Tx0xyWjDy6PBEssYEMgpf2L88JEx9N?=
 =?us-ascii?Q?1fKusdNgbVPw0jkbAIY9jmmjCs6b3Tm0QHWmYexmTgZk2hRPrF/0MY4SA3cl?=
 =?us-ascii?Q?HJvRJH/3CUIHEPQvH6ZW5S7XM9Z0/2yC4ULXtx6tYxYwaMk6a/qGyV32yA1B?=
 =?us-ascii?Q?NxzR+Fw/qKgYX4tsU0ycVepgRWXYVCkFSwN7EArY70xWWvFFOxn5dihXzxPx?=
 =?us-ascii?Q?QhGAok4aKQrBD9LBEV2MPcWX40Tf6T+20fEQYS05XXWHRwq/V6SdglqF73Fw?=
 =?us-ascii?Q?kooyew1P6qifEnZ+hiFua0ikBcTQIQDH94zyIOjhCrhKBD+AWqo34ldHvsAC?=
 =?us-ascii?Q?jKtoHBH25VA829X2pRH6YhjjVGxhjuyVywTpm5LKNuUkrs+xOagh3b7myTPW?=
 =?us-ascii?Q?9xcGGF78QioGd4pX2mIZwptr7tumTbR6lTn7Xk6Vm6T0ZMLLtGGbi7Yr+Rdv?=
 =?us-ascii?Q?lgJ3j5mufS9dH6vpm/t0UbbCZCe0wMqNEPIv6daCkmSacmobR4kTTqZt0FhN?=
 =?us-ascii?Q?sIeAbVFbSt0+s8XFWun/hYrc5Xp4+6U11ssUa2NAEhVB0yUz5qzEDGlcj8J5?=
 =?us-ascii?Q?6ziKIZoGHwXBjc9T6uUAIRvrSJTGgS6kseGycZxNv0D2KuRiyz86yREvrEwn?=
 =?us-ascii?Q?rIwM9XraFZue+sH/H8QF9jYJKr/L9uVzM6q5jkXLQ9wTbp95gxz0f9PacSF9?=
 =?us-ascii?Q?aBsWsJh1gmpxv3nSfqX1yTTb7Fm7/Qr56BkeEs18oWVBCuobUjKjWWIn221D?=
 =?us-ascii?Q?pGEd8Am1a3XEpfkz1NbLqrkBckJnlksvny8UOfc411HQMPhFDG84gjXHcZzf?=
 =?us-ascii?Q?dVLIxNWjV6zMcOZEBipeyC1UmH3h2GettlPsPB9Dt0y5rwLtH2iFfm4wa/br?=
 =?us-ascii?Q?/WvQVu3ycuVSVTy5bUwVXRASoMXJkYFxkGfUnoAHnWbQ5mXUSEZVc2a+KlFh?=
 =?us-ascii?Q?NRNt1NLJ3Sjifo850LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgTnXiDYal3abpbt9RiCajVt15lzDd5oyRMWotJ9P97nwwm+DvC4JPdBOt47?=
 =?us-ascii?Q?728CJNZAxwxc1/t9f9i1EtHs35mZp2CaPEWXCQJFyyG6+zaFZB8gT4hgRCgT?=
 =?us-ascii?Q?7JN0FAyNdDuaV+N513yG7VqNMSd5mnB2zpd0ZFxMnqkeqgtdNGYNix5+YaCa?=
 =?us-ascii?Q?jMKAINwHaG/5S84d4meQrqJND8f9Ya4xB9xbhhQP2u5P0y/FD40iV+zV5JPZ?=
 =?us-ascii?Q?8NtHtBtBXo0/WLxfE3cVDr7ZyEeXjQAcYo9Z6QnjU38gigz6inwc8iSo/mBi?=
 =?us-ascii?Q?Rk6W17u+6UYspv4SLui0lrSsm0puii+EJ+kg6HIj0BHHHCRkenvG5g0rEbue?=
 =?us-ascii?Q?tK2OsNs6bv2Y0ZDpzoTmpPgOGpnVkap1t4egf3xMch/BGQW70ZGPSc+LiMqf?=
 =?us-ascii?Q?D3+WjkWkZKHEi363EWkI+qLswmSgxESS5ShU3VvR1LG4AifMDjR82tDe2rVx?=
 =?us-ascii?Q?lJC91m++gcVfjcQB0ZwWWxBdj9y4aS4EpZvQM4ETSz6xFdBFB7uGugruEhZo?=
 =?us-ascii?Q?hfrkABxvl7gyL2iYKo86M+VQkEeCizeqgyBOcrnDkX+MHLtOxl9VTP4jkTv9?=
 =?us-ascii?Q?WqfVRgXfXRxodVcpfnNU5/H9tu1uIQ4axjNEeaiLslqG6cCikN6tXiUvc33E?=
 =?us-ascii?Q?zms0MCSZvi0m1AaGfnDfVv+gytLlwBEXWU9s3937j20DCnQjD6AMwEBalbBv?=
 =?us-ascii?Q?GfA4ZKw8ob9m2oPSXNJUSjy6Pv4ckTxp4nNFEmxl3gpoNzevMzYiuxqQ4eeo?=
 =?us-ascii?Q?xJX4muBHB/lcG9CR9+uPatkqlvtPdYklknpF1g6ZG/+vi/BQictD70MSrgVT?=
 =?us-ascii?Q?ytLNc05V2mjD3TJMnOXyyVxh/+d8gd5TrHN0Tqbu5NK/9dA+18MpYZYRW8ja?=
 =?us-ascii?Q?L63UJVjv+PUgI3eKfQPVjB2v3BIFFqAhIcjcx7y+4Hf1coB/2UIGrYBIOVl+?=
 =?us-ascii?Q?dkm+BEcjw7ykMFqX4EDq0F8BYApI/N07+HyCT1IWoj4FXprs9ZQNRFoexpZX?=
 =?us-ascii?Q?ty3TJ5OGaiQlwANS7vk91tDY/La3iX9fTK5xtampa+S/woq+t1xYUlwZV0So?=
 =?us-ascii?Q?brdLYgTUQtZOpuezsgVodEEcITzmIdOObqRrIKN4eil/HgllaJkPQbO7/CBr?=
 =?us-ascii?Q?YDu1D+G/+c0qwpxfX0kPEv+p4HBUAMk6Y5mw2OyMrEC9FI74siekfYJWJXoW?=
 =?us-ascii?Q?XOqhnKlbEnSsYFKYTxX+Y1909wRmHGMB5P7uxbxgyPQAxGiiPX8YQf6al/4H?=
 =?us-ascii?Q?KuPOQt5uzOO7K/vIcT1Ml2GxnQIqxN7jf3ILT/+mRGnYwX6pJQrc7PDYn53V?=
 =?us-ascii?Q?cKazIUq6hYiFn/Rcg1pO6BnwlNrEluvJvDuwPZ5O+aVMMUzZOFPZAqOKTKfr?=
 =?us-ascii?Q?k5Pb78xMekj/GZMkaEEair/e3BvGJJMBKGGHenHDSbVb7MO7cyAzPfRRjGjb?=
 =?us-ascii?Q?6A8jWstf3C2DzGHC0WA0yv1Flc+p9sOZjK8Q5FWhn1UVJLJtEsIasAOKZ8s1?=
 =?us-ascii?Q?1LiFnEJpcZWfA4wDVogI0i0bs7V/KpdYh/fWQbFZI4Jk9e4pVUspwrgt6k3P?=
 =?us-ascii?Q?g/rgKsW0ieXBjvZvEkzKBH0ltJS3XDFaL+G3MOHfsuLy+3Sd9P6Iiev1BdCb?=
 =?us-ascii?Q?1CxGrj+OecdxQMOSHlBALQHg3njqvhO9EotoaAWJ8pyuFWmPelPLb+60Vbh6?=
 =?us-ascii?Q?6pVpR8PuOjYA3WbdYldDkhSAI9cUOL4E6+PPBoEMNetTOzss3qzA6X2uUivK?=
 =?us-ascii?Q?B61Sh9raIIQ95aVGQMPiYG88nI/SlhsJ5ui2wMGQ4j2frQE2gRSK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c90b908-ff5f-42c1-e0c4-08de63fd5b47
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:54.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfjLw5coRhVzP/l400Hwm593W447WZdqz0u6jQLDgJvOE4UJvLS3gKaLNrJRQYCAHSZqFEAB/EVTyhrigU1iLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8727-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1024E7D71
X-Rspamd-Action: no action

Add a new pci-epf-test command that exercises the newly added EPC API
pci_epc_get_remote_resources().

The test is intentionally a smoke test. It verifies that the API either
returns -EOPNOTSUPP or a well-formed resource list (non-zero phys/size
and known resource types). The result is reported to the host via a
status bit and an interrupt, consistent with existing pci-epf-test
commands.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6952ee418622..6446a0a23865 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -35,6 +35,7 @@
 #define COMMAND_DISABLE_DOORBELL	BIT(7)
 #define COMMAND_BAR_SUBRANGE_SETUP	BIT(8)
 #define COMMAND_BAR_SUBRANGE_CLEAR	BIT(9)
+#define COMMAND_EPC_API			BIT(10)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -54,6 +55,8 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_EPC_API_SUCCESS		BIT(18)
+#define STATUS_EPC_API_FAIL		BIT(19)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -967,6 +970,87 @@ static void pci_epf_test_bar_subrange_clear(struct pci_epf_test *epf_test,
 	reg->status = cpu_to_le32(status);
 }
 
+static void pci_epf_test_epc_api(struct pci_epf_test *epf_test,
+				 struct pci_epf_test_reg *reg)
+{
+	struct pci_epc_remote_resource *resources = NULL;
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	int num_resources;
+	int ret, i;
+
+	num_resources = pci_epc_get_remote_resources(epc, epf->func_no,
+						     epf->vfunc_no, NULL, 0);
+	if (num_resources == -EOPNOTSUPP || num_resources == 0)
+		goto out_success;
+	if (num_resources < 0)
+		goto err;
+
+	resources = kcalloc(num_resources, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		goto err;
+
+	ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
+					   resources, num_resources);
+	if (ret < 0) {
+		dev_err(dev, "EPC remote resource query failed: %d\n", ret);
+		goto err_free;
+	}
+	if (ret > num_resources) {
+		dev_err(dev, "EPC API returned %d resources (max %d)\n",
+			ret, num_resources);
+		goto err_free;
+	}
+
+	for (i = 0; i < ret; i++) {
+		struct pci_epc_remote_resource *res = &resources[i];
+
+		if (!res->phys_addr || !res->size) {
+			dev_err(dev,
+				"Invalid remote resource[%d] (type=%d phys=%pa size=%llu)\n",
+				i, res->type, &res->phys_addr, res->size);
+			goto err_free;
+		}
+
+		/* Guard against address overflow */
+		if (res->phys_addr + res->size < res->phys_addr) {
+			dev_err(dev,
+				"Remote resource[%d] overflow (phys=%pa size=%llu)\n",
+				i, &res->phys_addr, res->size);
+			goto err_free;
+		}
+
+		switch (res->type) {
+		case PCI_EPC_RR_DMA_CTRL_MMIO:
+			/* Generic checks above are sufficient. */
+			break;
+		case PCI_EPC_RR_DMA_CHAN_DESC:
+			/*
+			 * hw_chan_id and ep2rc are informational. No extra validation
+			 * beyond the generic checks above is needed.
+			 */
+			break;
+		default:
+			dev_err(dev, "Unknown remote resource type %d\n", res->type);
+			goto err_free;
+		}
+	}
+
+out_success:
+	kfree(resources);
+	status |= STATUS_EPC_API_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	return;
+
+err_free:
+	kfree(resources);
+err:
+	status |= STATUS_EPC_API_FAIL;
+	reg->status = cpu_to_le32(status);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -1030,6 +1114,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_bar_subrange_clear(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_EPC_API:
+		pci_epf_test_epc_api(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
-- 
2.51.0


