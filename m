Return-Path: <dmaengine+bounces-8792-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGQ/DHskhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8792-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D930C100F05
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B29AA302BA1B
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A242315D;
	Fri,  6 Feb 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sKjGjd9p"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555693E95BB;
	Fri,  6 Feb 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398821; cv=fail; b=qdN68HyOHRrd06g6cUtJdjG0iLbWTdfr6c2lD7qmSyve7gXLq1e9ep7ZLqJLkFynL9wr+7HVCKJmsvO/9W+EjRB6jeys9+U2BB8kPG2Tf6p56aaFp5kfm4y6wQASNn6Lc5lnODsUOPNNfZr/Mm8WhnwaHT0dFf51gzrQxoSmeGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398821; c=relaxed/simple;
	bh=a5TtUgqMzQrnB37yY7y5CogqqVBqusI9mm8Bfddm8bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FR1GF7r0KNsTm/X+CVk2NxgszTjdsUV76GNzrnEOuDGsGf3k9gZI+cf/W4YGKzgPXn3xGba47fBy62Y061zmwXTBhO1tgCfPQfxInuNRo4PSc4NuCXTKRcp6S5ID1SMmamIaxgS3+WWe5DhiSu7Tyjd/MXXUlIiPd9z0zleb6Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sKjGjd9p; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGUYVFmWaczgZL3zwtH9W/W0dntsxNvYrmf6E5tn0n/+O1gl+Q5qkZcZhN14V8l/MzLLI1RqRC4XhWCYn6ga+YLAkE5M0ErneqnoT1myNNBn9fDq3XIfeaejX3c3ukufNmffJGFa0XA2DGnGo85vhev5drGEXNj4JbBQSWwzeKZW3rSXmokAimUvgfemnd4/QXmJYN87y5D44u54s6ZvrKiXkmX2wJRy/QYLBncZ1ZwacXU4Tn3XV8g7n9bRfEhfB9NG73bV9f4vf0j5KcDBlc9a95aM08gQyid4sGwSX02N0GWh+GySfkiQ+pfQJk2lL67jLpgCwROx3NPMRK1CJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U0LROWm8PCs9Uohq6g2Iv/uSbw+u79KT+pbJetsDdY=;
 b=gHmdu4N05ieT1K7BLKElnvViiFlGKOFsRkWFlFSnGLxXjFxZWiMOjyvJxovUJ7sUempmjtl2UG/n5nrqTZZAgGVrRl/rlE6jUPauPYxXbriZTW0Vge7IMbw3kmhUOaS9RMcAzOVCKRVjdgpwmxddaesVqjdqesFDf82FpyehNEee9b5KDERYN5V4J3YG+YrmBq7Vrd30/eqvfwSPYFG44PF52GAFhweYFI92omKXoC7XxKTslFCN1xvI7IICdqdqHMdGPPosYj5aJvam64fr2V+3sxNiCmQcis5Z3meDnB86/5G3UyaGEuaoxg3Bmmu1HIRFu47SdO39Pfb2d3zVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U0LROWm8PCs9Uohq6g2Iv/uSbw+u79KT+pbJetsDdY=;
 b=sKjGjd9pWzVAuzr1FwRZ9BV1lqYm/5mSSNupeMtsREobmjCl46RvA4SKcR/iX+QnRK/stCwh17XwDvlwVywwVei6CjUTYEguosp7tp1P8WQuEipTyw9aJ4CAIb29ELY4KBfXcMoGCQOn1zHLiJZID9eemS2dCn4DmAVWTvk77vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:58 +0000
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] PCI: dwc: ep: Report integrated eDMA resources via EPC remote-resource API
Date: Sat,  7 Feb 2026 02:26:43 +0900
Message-ID: <20260206172646.1556847-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: d80158e7-3526-4f89-169d-08de65a4ee71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ojnxUb21XuSJ+juiN0LqLVUatGNn8ko7KGof9yZnB5Rk01FwOQqXVgiq6M07?=
 =?us-ascii?Q?lANvBrr8y+Gdbe/A6LgX+94/+hpzMO0HrfUlXJW5bAwq77BccIT/dADprdt3?=
 =?us-ascii?Q?0w7PgyW9W/TcoVXlVj8x4AgolchRuCGgPRpdGQvpYd6xPe0AshU4dsz3WYoW?=
 =?us-ascii?Q?YWJORvWzdXgCBfOZzQ4O+TLPEfFUITrgHrSkHiAKTJI3irjf3stz+pVDsdzO?=
 =?us-ascii?Q?Z7Dnu/XFkeqmSc4419sjpyk/RQevN+8rKE40rFRt2Y8amtZPCGwGgeZqAkc/?=
 =?us-ascii?Q?mwQbBdJ9iIIs26YWOtGAXMdUbO9GY0L5R9zJt5Hcqi3N4OPywuMKgiqwp262?=
 =?us-ascii?Q?OjGh00GHPmp/L/+BH7iCIHSTuS5TjkgTy/JjX92mlIlsZxLEhQVG+FUdcHuf?=
 =?us-ascii?Q?nzShNNc+YnfSYG7/Mi9CWs/0hnoCJQLwE5TkfR2WNhACyhRij9fJ8FgMyzas?=
 =?us-ascii?Q?V5T0sbY17WAKO6s/APbiVnG/7nKx+9CLdAVFgGiqoWRSoEmt+XMIdKHx//hv?=
 =?us-ascii?Q?XtWgnxnBYCwbU2oArVSvW3w9GmITwQLJZ7B/5vfd4MiTOACZe6rqP36gd4PW?=
 =?us-ascii?Q?31dcJUbZpRnxbvITKBdeHwkwOBuZ48wr0tZGOHVL4obNhbPDNAqcFmpeBYj4?=
 =?us-ascii?Q?DvxSNfK/hYmKj0U2VsrhY7lDQl0UkPESPV5Ldair6ZgHaKS3t7s+7GxqeGmJ?=
 =?us-ascii?Q?Kge/d/ZFFOgA1fd/JhoCcdN8XJdPg2IOvGk86V52QiK9pYMSa8Jt/kyMWF4l?=
 =?us-ascii?Q?xkUrjlATGzdef6G8IOX+fceNJZu2LOChQQ88nY5SbQYUjDa+0UNyR3lDoweH?=
 =?us-ascii?Q?hMDttqFZaipVMZTfraiKoWij/NLyY+cmGKF8TVH0AKoayoR9DobDvY6bgDBV?=
 =?us-ascii?Q?6IEIVHaxUcnBLfjRzi+xHAH+6umJJTZ9+0JWGOGwvgGldW91ZGCZM17A1u7J?=
 =?us-ascii?Q?ZKgFgMxroXPeK4eiRJBI1qF0ljdyDC8Nz3E4glVxK4yBt8DPPdwLsR1oD11j?=
 =?us-ascii?Q?B/VuXgVOTfHflMWE7xBgEI/53g/0Om0gjyA27EjNDW6IhXUZOWs1W6diiy0D?=
 =?us-ascii?Q?7FuCzrwgz3NASit05ahivul0DANA4wkpc3IzLJz/JqGillV5YLcx3kNeenQL?=
 =?us-ascii?Q?xuMCsBpcT/zjAxMm3eNIJYq5tP6mCLxoNGl83ICcAkT4lEUF9VlBHIUpXks+?=
 =?us-ascii?Q?podFCVd4g+ypklLO/HgINnQjriGJbBFIPv/+oEQH/H55LTc8ZVtzUBULVo9U?=
 =?us-ascii?Q?Usqh+yBGDQhQoo0C8PPbe+0nGJSHf5RRXbxgsydkceiKDTBWIq/CG1TdtX2w?=
 =?us-ascii?Q?ODvWrZ6L6ogQUoe+4Duw9ReMd+YCXojVOUKLf6Sb1bsQwLmNggFw9KjHKb0w?=
 =?us-ascii?Q?+RXJf2sd2PvO3jgayd0IC4WjzRTaE/xjO1dCtRZeHml/tOoytRnOq42gwSnO?=
 =?us-ascii?Q?x8qN7Nl/3ev+z/a/DbRe4DJ/TfXcrujc0YYVUsR11lO8w2QuGlMWMnp1nG9f?=
 =?us-ascii?Q?eDnMQmaulH6So6SQ76YzBNLRXdId1+gJhkSFQOvYw4m076vjpk08YChWOP1k?=
 =?us-ascii?Q?hBWbyMnzoQVDmQe7mjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+STHXozxORLtn7RxKOAuklE9VCUQ8CzyY6S2t2e5tjvNcjb4CRU1oF2GRFQA?=
 =?us-ascii?Q?QGyJmxCTcA+r0xT4KnQD40X7arK/4ActzaXfq8xuwOsgmAnUqWxbB0LhKYi1?=
 =?us-ascii?Q?nejYclvqB0PCKXCV5MSdWozrFIgEFv6htneKUhiDPfXu2sF49UQ9jomfS9GV?=
 =?us-ascii?Q?LrUZf8zK7aNAJdjO1Ef0iZR8Yc1LD/kKgwdpuSE6jaty15KRI90o2rez4Yye?=
 =?us-ascii?Q?4k7AikQ6tYDvoFEH1EKuiu0zYmI0SSA7qMFdZAT0yEJrhtXN9+EAWElFT2Yd?=
 =?us-ascii?Q?be4BHAjfEO6c2thxsWxKtPnmq5TV+wpHpPskUiGclKlMYs+kkBDi+V9LxGu0?=
 =?us-ascii?Q?7LEbOo7mXFeMhKTT3X6ny/UJe4sGeOorpho2qpG99uRAHMQ34LlHzzgBXhUr?=
 =?us-ascii?Q?Q1j1K8DUhltD/aPkLa6lofwKn46isrmYeZiWSq57dXiu2YBPEJC7WypmtQzq?=
 =?us-ascii?Q?tWip/0NLGsxfrstYOQcUA8iJT6RaiKpeRuuYvbh+0oW3sbcpxb6WVz/Bo+fD?=
 =?us-ascii?Q?ACxsBwoVk2WqKCGs7KSLENSWuVnWcMECMcxtEfDIJtdoh3LSsjpC39ukOMPX?=
 =?us-ascii?Q?Yzv4AT+PtsAmvCHs1pmOexAoELhWb9nKby0P4zJGksdj9aVnT9TRHQyHAtEE?=
 =?us-ascii?Q?vjDXSeqzt1HOBdzdNF/1shOa7SNWDIQnYxKFa8b7Jeu30013/NsjdUdsAmU4?=
 =?us-ascii?Q?ioqjFKS9xs669EFvW096iwWgjUUfLuWAXWDo9YNBhCrV+Arg2MNpPCpENQ/b?=
 =?us-ascii?Q?dvbdAjWRiEXn0f2cRVrtG1sx5BjVvHUkWbNrFKizBaYdGHRo+D1TipErz0yn?=
 =?us-ascii?Q?dOxoyXcPAIa0xE8FH49erRxISQmkuQefV367RRMrvU9TlVRuF4pxX4OSoSJP?=
 =?us-ascii?Q?RbWWw53279VZcK26+vp6z3sM8WCMQNiUKi31W+u99MD4jCcetAq//LIF+yT9?=
 =?us-ascii?Q?KyC9i7NKWz7TE3E1VyAllDRxhgu8uCM4pils//63Fw8PLl1gWmZGLVs7pn86?=
 =?us-ascii?Q?1Tx/sZAzLrYP9tvV8B0hEiZEnY/2E1z02uhU6xNXZqOvRMzAg7PKKTD0CjNR?=
 =?us-ascii?Q?tztwYw32AwFDsH66U1zw4EYWfNH0GMUVc1t+hjruLgRGTbE9MwL0tZ5A4pfe?=
 =?us-ascii?Q?D6m3CNO01xVoCmnu+fSK22GAB96W96E9vW5rKK4w5bnsPq9iTcddJtxqYUhb?=
 =?us-ascii?Q?gk3jR6JbPOM62yru5MOFC54h/9WhhFEFav08SHJSyIRGfhD8WFiqV90ZtkTi?=
 =?us-ascii?Q?pQt7GIg3ibAT4FyayAAxh373T4AyZv706ZDjImEuXveN05PUCvOUVB1jt8LA?=
 =?us-ascii?Q?44dN/1c2eQKOeFb920223bpWhFNo5DH2pr9nXccXumXGvTyGiR+w8xx3nXrn?=
 =?us-ascii?Q?DTxWtU8FXju9OFQnMKGUoeRjbY5vBm3cRz9hkLXmLIJaSRja/Xb8mcZG1fZv?=
 =?us-ascii?Q?p9zHnCwhyWUnf1xr/HG+KyWSHN3rkkkLTg74dHG6Y0O/cxIhmuRMTMn4ETbP?=
 =?us-ascii?Q?WZF7ErXucvZyWeYHj2qOXkzCqBsoYWJK60CTiHgm+Y4U6sqZsv4eVpipWMd/?=
 =?us-ascii?Q?mXy0MkAwGlDt+cCQVbGWyXGnjXd0SFQytCn2yDi1y4GL2KjYyFMP/7BKf/ln?=
 =?us-ascii?Q?Ay7EsHcIPWw7/Wz2wYiXtf9jAANWBg2m13UXmw0PwockzuD7IhlPYbdCt4E2?=
 =?us-ascii?Q?Y9TPpI+0+BW5KQYA8994SEiWWfSeACRKffWNwmIvC+IfDzfhbpItMKLMuO7B?=
 =?us-ascii?Q?l3btF7+8V++luqunPp4ttiLjVu7GcQaNBzd+0qBdOO1G1yA3+iJo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d80158e7-3526-4f89-169d-08de65a4ee71
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:58.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Pv7CoGf7s/rdAu8CVdX7bA9THnai+ffuhHOfYID0r39fQG+GVjY6rbbmbpWXgQOxGqz6w1T0aYMUG5PwnzpvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8792-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D930C100F05
X-Rspamd-Action: no action

Implement pci_epc_ops.get_remote_resources() for DesignWare PCIe
endpoint controllers with integrated eDMA.

Report:
  - the eDMA controller MMIO window (physical base + size),
  - each non-empty per-channel linked-list region, along with
    per-channel metadata such as the Linux IRQ number and the
    interrupt-emulation doorbell register offset.

This allows endpoint function drivers (e.g. pci-epf-test) to discover
the eDMA resources and map a suitable doorbell target into BAR space.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..29dedac86190 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -8,6 +8,7 @@
 
 #include <linux/align.h>
 #include <linux/bitfield.h>
+#include <linux/dma/edma.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
@@ -808,6 +809,89 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static int
+dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				struct pci_epc_remote_resource *resources,
+				int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	struct dw_edma_chan_info info;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t dma_size;
+	phys_addr_t dma_phys;
+	unsigned int i;
+	int ret;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_phys = pci->edma_reg_phys;
+	dma_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt;
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	resources[idx++] = (struct pci_epc_remote_resource) {
+		.type = PCI_EPC_RR_DMA_CTRL_MMIO,
+		.phys_addr = dma_phys,
+		.size = dma_size,
+	};
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		ret = dw_edma_chan_info(edma, i, &info);
+		if (ret)
+			return ret;
+
+		resources[idx++] = (struct pci_epc_remote_resource) {
+			.type = PCI_EPC_RR_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.u.dma_chan_desc.irq = info.irq,
+			.u.dma_chan_desc.db_offset = info.db_offset,
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		ret = dw_edma_chan_info(edma, i + edma->ll_wr_cnt, &info);
+		if (ret)
+			return ret;
+
+		resources[idx++] = (struct pci_epc_remote_resource) {
+			.type = PCI_EPC_RR_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.u.dma_chan_desc.irq = info.irq,
+			.u.dma_chan_desc.db_offset = info.db_offset,
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -823,6 +907,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_remote_resources	= dw_pcie_ep_get_remote_resources,
 };
 
 /**
-- 
2.51.0


