Return-Path: <dmaengine+bounces-8832-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDZlMwV/iWl2+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8832-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9610C0FD
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D07AF3001FBB
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CBD318B81;
	Mon,  9 Feb 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RodQcXef"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021075.outbound.protection.outlook.com [40.107.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9E318EED;
	Mon,  9 Feb 2026 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618607; cv=fail; b=sJ85ELlUUW0y61mvCFYWWxnK9xm2npJ1CoOHiBHivbMh+Gxky7vABCQLxfqtvnU7ykuy7D7TgeU5c/qERp4aQ2+CPjv3d3bkj8pcbrDefsDD6l5o81SN1L6P2OrWXcmMXvh++ZvXu/phjbp4Z5RYf0um08L1jWeuLI5+UUeWh94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618607; c=relaxed/simple;
	bh=07NOOa0/rNNL1PxwvNlV+aogVqz5aF0BbgQCjbNwprY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqlwSMjzqmwqtd7C0MzDpgBb/Uq/7WcHpGpftH8YOOywUaLqL1ZhPattvvj22bm10MwrLqTaV6vPrS5gV2j0Fu/U5//5J3MDl6muqYSlnWvQFSHlNsgb8c2/N7n8/WMcG0eNznVsMAoiRaXelQKy927rWJS758KwsikrHSjkNz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RodQcXef; arc=fail smtp.client-ip=40.107.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orymk2mGD2TrpUIGzgk+kAYCVnaSbQ+xk+Kzj7yK7kHxn0TKHNr/phHrujSMpekoSJV6fZRisdi1kaOggXpzT8lF8m6j8TgaOYcnRwhuKh7Bt5LLq4UWjsm9FWXFOLa1sJGHfPbBbgufAvROr7UNYHB/Uxdv4tCGrbEe+kSR0pP1W4sFX8jgCwJcZ7elfaGouZ4jaIDwUFM7DC8uazJ0EA/w9QCXv6TTjuaQ1QM05ZZsEVpGwXDybpBmMvHFp+l5raQ6fifL07aLk0x4rCHBBkYgv8+35idvjSQpWNC+UlbHMxAyI1P3VsZ19rqWpOiRWa9ctn8C3rFnnAOgJIREFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmZ6hbpugReJK6Dpis4ijSWWldbK6J+3kcRgGdadZm4=;
 b=jqTk53edmzj/zo7o8T808/MphfwYQFysyi2bFIPTxBrHR7d3PO42Gy30cRc5uFmzklaI7T5EGDW+2vC95eTVqh36YGVOJz5nLvLsbp7Bi5QeXigh4wcSG1e/I9wp4catYPkRrEbN4f6f2hIJJV5qdiLj4Qt8Z0U3g+TCutu6s3+LZ58j2UDU8SzVvhgOJAba5MmpvCqM4ZyefUvegMmvUZcY3Ep5h5d/Hvu6S92opxplp7j8j1VcDAkh2hVas58Ia8PMwlVBUrua2f5C5oeN46VX4KOi5Wl5D/c+89CiJLkCG/dWD89nMWbgZzsxUP2oMOR9Thb4cRq3oa91Zd9wNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmZ6hbpugReJK6Dpis4ijSWWldbK6J+3kcRgGdadZm4=;
 b=RodQcXefXTfcHJ4yClA5K3PoYYq4Zpd/UFf8lhUNcpawr/xgC5TfkHpXZK+swGM3Ov4VYaKtJqswIUDUDMu+tbSDal3C6K43igKR9WRkceADgmnxJqSKtXBqwqi/Mno6r0OfxAiuU1N2anvEjZXuKx2nHz4AYP+e2sHxkKUiDgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
Date: Mon,  9 Feb 2026 15:29:50 +0900
Message-ID: <20260209062952.2049053-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0068.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 53426b62-437a-4b54-b5c5-08de67a4a983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/tlDT1ynT6uSj6eLuLnTezRfoxb7BVvZKjn3Y2VYC0vv7OGf1HjllhRXOir?=
 =?us-ascii?Q?3O2rA9A2+sz092K7IxiFz+3ON86/y0ZKehhNBxtIt7Fha7q7J0KvecmeCxO8?=
 =?us-ascii?Q?ZidS6H0hZeMiebkyzp7Sdi2PMJ+hWbn32DLquzdUQ4vstAGdlG4HpsdXdXGb?=
 =?us-ascii?Q?4Q+B7mQyznvEkHxm0n5/OEEPP9kDwqSLJaoCo8ssPA3wKuQsTiuev8TcXKrG?=
 =?us-ascii?Q?rNE89jK6eKYXxv949VNHxtvg3QnYN4iY0zdsgc7VPQ1hXk5AKQxozaMDYb87?=
 =?us-ascii?Q?vi/Hh1kmJlgqdDh0iAC3AUhpBvXSBZ3PlpNyVekNVLfSrzNdXnP0bwrkOOjW?=
 =?us-ascii?Q?wmZR1RkOwxEKvbuYm40YEiyZGyLW/aVIFt1fTe9u4kgn9f3KwSZES1eBqp3P?=
 =?us-ascii?Q?VO8/g+Nz5bfOED2/jX8B64aTGMnc07hIy6MRepI3VgKQoSnou0KpzlQSFiE5?=
 =?us-ascii?Q?v86HAtvltAWp0hrSN8n3pGRJbDx/PCUnuvhTiuiZMqvhVkdDaVVGzmpXg1Ok?=
 =?us-ascii?Q?fb+9fnLx50tEsGpcMEDgJCUQZgDh8BUn8u037uU9ghhaP4GElk8hOadjGiBF?=
 =?us-ascii?Q?Oif7eYX5ZnhNXKpe8sVzheOS+xFNc91CgiH9YCt/XtzMFoVM3vGlYRapYxWa?=
 =?us-ascii?Q?qQF+0v5z86Asy1XXu9HOK9uMex6AM02Hpov4/v2Uk3oq6aEogZyF07fiVEq/?=
 =?us-ascii?Q?FMmN8JDpo7QO+8G4NMZcEWbSG0Rt8DFV9rPqgWKmzIlFWugcSehu7JWyp0Fj?=
 =?us-ascii?Q?ksec196EJcUaRUvdgnFeSoG2+TlXpDpZrSsPBUTp3hfDVjLYgWwCFSiDHzT/?=
 =?us-ascii?Q?tNMwTpdBKCMRplYZ/oJfkpxxHeNI7+e/IrsUHiewStH1K/7VCHWAb6rVBZRf?=
 =?us-ascii?Q?xDtubK9B82W24OuR1jyg3W3h/CEBP9eDEAvix0KlPL+bjthNFq5wMN5iiIc+?=
 =?us-ascii?Q?wUxvHa76VITqr+2Syw4YqWWqER1/t/D5csekL1FzvcjvWOkE4Fzy05L3AtjL?=
 =?us-ascii?Q?+t/UVavgKIDhdaRMz8FUw0vzSfCJTOnDsizuvvN+JhmtN7SKbBlGVB9cGggm?=
 =?us-ascii?Q?eFvbQI7ql4vtP9OAweRUiSr+sOrigh2L72nMY1Dts63kGhIJMAWIbd3ibdLK?=
 =?us-ascii?Q?UA4q74kOpgD/eChlHpnsmfyDevWWUnw2ITlG0v3Fx2yQEB/Y5TDatLXKc753?=
 =?us-ascii?Q?CjN6MqLs/KvZqXtJUiMQ0XjVKDLpmypeuj8TgbljpRX9nXTX4zv1CMqgK6BK?=
 =?us-ascii?Q?mEHBMGqiXGItIlZeac4CCkPsBVBCuOetD7P4fxFQsuAniUatUOdyQBKKIPco?=
 =?us-ascii?Q?LsWYtDrmulcMvYeL6qj1IKvALIWIyJnFq2ndOnuMJj94PyqqPlTHS1y6/56A?=
 =?us-ascii?Q?e6v4oKMGCDZc6mIKqxNMzYQvKjAyoOhsLq6e+d+UX1aNsA4FlcCOOCPWPghF?=
 =?us-ascii?Q?15+0EAyjb+krOVK5W3DrugLsg9vFnt9TXcbDl+dPrJaDEaqhokPNlAYDfkvt?=
 =?us-ascii?Q?12jt8by2l4EKn6aeTJ7yXnXDyZqCzJ4Xegnf5kL49Iub1+Gm0C+TJUr859Pc?=
 =?us-ascii?Q?nSh8+TPqy4SA/ufrcA1GJDNaJ2BgJcziCgsSM1gCtkbdEqeY2ZCnYh26Tmw8?=
 =?us-ascii?Q?zQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ASns9izsoY4o4gY7Lhzp/3aQVvkBDFOiF4oqtByDkVNhHLrdxzubp0WrNUe?=
 =?us-ascii?Q?75YvTGOMQw4BtuDV+CN1xxbQAn6bf0DP8N/THa01Ru7i6vQyPZkrydQH4piP?=
 =?us-ascii?Q?QhTG6I7VfgUVbrf1XFRwO5/uNTNvahpIP+vMLf84OXMVm7wh36W4I6pF+5I2?=
 =?us-ascii?Q?XVbAU9gPU/evv3hOvFQ3/XoTouQgtOGTrBFCnYGM/UyXfL34jRGAM+S9Sr7Z?=
 =?us-ascii?Q?zzWzpxwWYvzpURIAC7ONu9vBwAkCY5y++XURa8Cdn3SFHNezj14QUVCJC3Zr?=
 =?us-ascii?Q?IcqpD2PaRqhZc77nAvhvmbOP9joGdnwwCk2C+h/0qUzY7ZtUmMEGRxg4Z+/9?=
 =?us-ascii?Q?EpGtpiwrO4Dlt6vr2lZ7Ew7vCxUDr87z++Hz6vI5g7MACOd9plcxFS6o9Rok?=
 =?us-ascii?Q?EkJRqikB0zUCYCurUE65AX+XU2/Dt2qnFGloynDHef8yuodKKzlYMxZPDUsn?=
 =?us-ascii?Q?AhmJCRB7kceQzUL48OJmWwrHYqumB7xC6Ha/x1G6oEi9aqbWIwK+75+buRou?=
 =?us-ascii?Q?tfPlCXm8FjA3LdvBAZ14+vuaJNSy/JLP4a53NnKpjVppDlkvB6haTwOrK1Bt?=
 =?us-ascii?Q?WQoZLDrctq2+eEV7Z572x8Iy19RXH3b+rQwFKmlAmJ+dV3DY9dN7H65nuNQu?=
 =?us-ascii?Q?/2/ht/aPHAeDwMX4TcTjVYOIzBDHGyAFeh7c3p9Uo17xsKymhNMfNluKMkSG?=
 =?us-ascii?Q?IrFSi6ou3MAXA9R1QbuD54Fx3/JqQld9WfeM3xG98MLdzObtZAQv+jUXWIzJ?=
 =?us-ascii?Q?hwMJ3hs2Z46LHLGPMq3yI7JQQfLnY6ubG2J+Kp4G5GskeHYocAoJensQQbQf?=
 =?us-ascii?Q?GT2Zuq9fh56I7rO6IQkSD/sC3RQPc98fMbvXnhwed7THbXW83T82G26cMhRk?=
 =?us-ascii?Q?Kjx6ETNrEcmqP8E3A01hMxI86PjascnxDjYif5Hr3Q42MV3rWYNfqciGl5BP?=
 =?us-ascii?Q?Mvy7V7uxGX0V+3seeWhqJrDjcUwYIx5Y2hreOh8kzwwMSTWzVCZ9hso3tqWG?=
 =?us-ascii?Q?WifbXkirm3zNFyI5LgfuSgpIKcdU4DiSR68De/KwcAmIQ4T3YmSr97WqQYOR?=
 =?us-ascii?Q?+AiH9qEBgnEMpGt2AY5ITWMmGeF0lULfBH/sq2w0L310XrznwEUhsAqEY+p3?=
 =?us-ascii?Q?G4uMAXR85KT+4LvP6sqSmP7wDE676kulscslttn1t6dgbm03zUi+f/w0vgza?=
 =?us-ascii?Q?BamoWHwea27M4hSl883D0cW5haSbcyQ/pMaW5bSdv5Ral1SzNsOXx30ZScuv?=
 =?us-ascii?Q?Ph70ZI21+kYP/PfdC79ga7FqoVEAGeVbfd9QPtfAsKROgWn4S57Q2J9TUYcd?=
 =?us-ascii?Q?G87pY86kFWT8LOSAFrnqxqzfmcSAeJSb9nqUujTtglBFfvFULS+HEweCYHWR?=
 =?us-ascii?Q?6p3rr2zPCG9ct1nCE9A4uSB/VgPY6TJOrVR+vHJuS1uCELS+CmrfHgPUrdhM?=
 =?us-ascii?Q?zGK+S6TXgqYuocwjsY7YLvQuKw2Mk5PxKddubtvnGB6cGEDDNFvEPuAxdCF/?=
 =?us-ascii?Q?UtjoEKPdxxXyb9xZWqkSdCT5l9IBkIEQZthVTjzQJpXSCgt7LxM5FcXkDtNu?=
 =?us-ascii?Q?tN/rdu+swWV4n3BaKhPhMFoddyo110yztGw7IIuEdHXLFsjPn9SQtMb7dZD6?=
 =?us-ascii?Q?qlvgUG/ZoegyI5//AjubnZ87SRdXKipzlttDtl1ocXLJGyMDv0blJvERJCoK?=
 =?us-ascii?Q?EQ1mqTeX7W1nTf0CuxPxiKzPyKdYIbzaWwHss9iMqCtyLSJmyNi7/z9ZoNPW?=
 =?us-ascii?Q?zBniR+4GpGIeoDt4f8y9B04r3cdxJPXQI0scILMFDZbXunwqPzBs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 53426b62-437a-4b54-b5c5-08de67a4a983
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:04.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqkYSh8L8F2caKiknm0ce4SkWJaaF1sIdql8yIhLX7y3wD/LLdmY9WRwPuQJH/7xrzpJuvKaySz9erzt2tbf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8832-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 28E9610C0FD
X-Rspamd-Action: no action

pci_epf_alloc_doorbell() stores the allocated doorbell message array in
epf->db_msg/epf->num_db before requesting MSI vectors. If MSI allocation
fails, the array is freed but the EPF state may still point to freed
memory.

Clear epf->db_msg and epf->num_db on the MSI allocation failure path so
that later cleanup cannot double-free the array and callers can retry
allocation.

Also return -EBUSY when doorbells have already been allocated to prevent
leaking or overwriting an existing allocation.

Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 1b58357b905f..ad8a81d6ad77 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -50,6 +50,9 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -EINVAL;
 	}
 
+	if (epf->db_msg)
+		return -EBUSY;
+
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
 	if (!domain) {
@@ -79,6 +82,8 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (ret) {
 		dev_err(dev, "Failed to allocate MSI\n");
 		kfree(msg);
+		epf->db_msg = NULL;
+		epf->num_db = 0;
 		return ret;
 	}
 
-- 
2.51.0


