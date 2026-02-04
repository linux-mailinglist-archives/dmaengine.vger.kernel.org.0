Return-Path: <dmaengine+bounces-8723-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPEzMrlfg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8723-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:03:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206EE7CFF
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6503125378
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43D41C31B;
	Wed,  4 Feb 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wFWp97lg"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66B41C310;
	Wed,  4 Feb 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216893; cv=fail; b=ZSRQRG1YxkUhcemyVX7enKIXjnkwLo/3KiK1fsNHnnxOQ13SoRL2IYk+H4KFWHHik21Bqcg0cMFI0LoMGREZ+1iBkCEog4Ekp6qzaqIOBfaLxhrIKEdvKnlE1IuUg6TC1uolRxbqD1Jc0RQkIwG+4V9+ts4e2VafMNQ2ghlZzAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216893; c=relaxed/simple;
	bh=2KYDiBG/+LovTF0NV4VyW8gbdRNvTMXEUU2suACySsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9mMgmKOid1GOcAkHAdGGPOZDFzUIXS2xC/VHaWFahwDD2irELDM7cvpsvvDxzqN5WHCEc0qELfcawVY4DVTMGq0ixrb1rbW2qeitvLZQjmsySIJzpv8IoPYOVm5J597YYZLUviQiqsmTgggHmmAmjHNcuGO5n5xZh+3LMmN1Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wFWp97lg; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J79++Q3ZZnFgEW51qUjJxMq/pjiCUVuyzz4Jmx5q5CQf+efpzWtF5A0wzB+NLH85nph6/3aKDnsjjex2y8gIZsqyFnGvN25QYYRBCyNkW+S+8dbMbm2sbSXzQd/Zt3AjBC+x4KmCgkHlT/kdjdUmwZQYUA3QgQSe9NUAix2bL6IjQqOxCPtiZqLQsW7FNJ63nk1f8zPuM6e++iDEfSUqfNhzoI4g70q+94atKandnJ8rBEI9j8vYHNANiRh2T5H2ljxYgskro+z5VkD9+KNKfbRRFbvp98OU86OoLF2tT3cchgUpEGD0RIGFFSsYPXElO4SAl9efQ71fSf6r6Oy9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4IDx9+lRgpg8PBhuDiR2mN8Hod3uNzw5CP301hji4Y=;
 b=LqjxpB4AQ6eLpCbw/VsZ2qWa+Cd1/VD/+mcLE7C3ClJsMj6o8GvzhwDPlHaPAj43Z0upyTYQ2Pv3girycbKYXnw1pEzE17Tlb2eqG32LBb61AONERMD+z/8Tu99MR3BRGLpFp/i5nehkZL272TG4VdiI475T5QoClax+K1AbqNMvtU3cDQ8Qxvab64CgY83JY57jI6dctkFXQt6lnfvlgTViSDzARwwYsoYxZ0Zypu1vD4pORZmKMpO+7xNFajJT6Gev6HJHJDIRxw6hI9wyAkX212ivm1bqFqgJmvrJNtYbkv9Kp69YV3841Vls4GbKVEnXVR8LT0s8lcnyPT/tSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4IDx9+lRgpg8PBhuDiR2mN8Hod3uNzw5CP301hji4Y=;
 b=wFWp97lg5lw3JXThWZA3JfqQBOyX8JDrw2SFJslBo7M4W2iBmFTIet0EmDeuMeEWuoei/jz5FYfBVlpYXr2HXA0y8+V+5fPlZ1LGK4Qu2HnxnoePUKlld7HW3aer4xZ1qCeoFg9Hs0fcZOVCKASiryBjAfDpNsneTLVg4KclCzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:51 +0000
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
Subject: [PATCH v3 05/11] dmaengine: dw-edma: Implement dmaengine selfirq callbacks using interrupt emulation
Date: Wed,  4 Feb 2026 23:54:33 +0900
Message-ID: <20260204145440.950609-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0077.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b29b56-f56f-4e70-7eac-08de63fd5984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BNQ9m6u9xmV1moPCfwozpAHaWjZ2pr7cYz6ppzEC0uYp7KdrTGvVQPoMH703?=
 =?us-ascii?Q?Z/c752/S90dT92er8dVvJj5FrqCLkq4ZSdl8qksHwK0PKl5K+k3LBeQc6JBl?=
 =?us-ascii?Q?dHelu29qWoLeBYEcpNE36MJFBRuSOwbh9WAbhsnGsnUvHCd8kVAkp5Lw5G5m?=
 =?us-ascii?Q?6h2dqWtYgYlFFY9Zd9NHD9meNzGD4vmINblhk/WOY6GbXZkcMF1qY/1pmXxW?=
 =?us-ascii?Q?y9W237zGgrgENRbhJkIuKa9psEGZk7Z2ylU8pjQlf4kcGv/dkwilNqLx9kN9?=
 =?us-ascii?Q?EDzGrNnZ++lEW1MkvloMyPWtLkM+kemT6MkDqnXFG7ZNpy0coK5eA7GOHRCO?=
 =?us-ascii?Q?kQLlKQa61AWSyaepxQkRI5lTpOh/6J0IRamta7iqzSbWulNKdTTqL8kDwGAT?=
 =?us-ascii?Q?9zu7pKFfUWQ8DW80AgUjTYe6YhxgDF+xithv1Z66t4I/o5o8ShhpYULnsCDB?=
 =?us-ascii?Q?P+EOZT9w7rtJyu8tNgIaZsPrV0FWtWwLaX5Ib03m9CBEv+t963aSCagUBjby?=
 =?us-ascii?Q?uKO/tqdaj0jIK/CsGWsZAvgO0Qw533mjvUDM+3lyi90EU/gXi93+qAhuShbI?=
 =?us-ascii?Q?iaNIjraoCeoW9ikQrgnRWM1r5GKIyBcPri46Y8rMnymDUSgwVphn67el7zYn?=
 =?us-ascii?Q?CbfwicDnwTcHeuTuC6ZSpDK/iP4YC4snY7EZqwQeW/6Kzc1StACWc6NfxtwY?=
 =?us-ascii?Q?Q+ydJU7a+2KjnZ9Oc+Pna0k6xUAlz8lTMfVaUMeYIzaVRHtlgHjbXSndcGtB?=
 =?us-ascii?Q?QW3c4s6A5kl7afbKZQeEFjv2pZzc1emqr7RyNm13V3GD55zNtdPFewo0h55P?=
 =?us-ascii?Q?yoRhGp8ikL4ozC0/oeVFP9zflrDerasYfitvng3U0Eb5Jq3wxmYZ6yQAeR/L?=
 =?us-ascii?Q?PnDl/4gUH5t4JD8tmjvNQFU5eb3FCGofnF72ddP1uBehDy69OYtVoBtJdCU0?=
 =?us-ascii?Q?ktR4byz3U5aOvgDwUEf4azTISK2qzvesXYDMB9kqvfopflnlcb0fMI/cYEgy?=
 =?us-ascii?Q?HF30LbvFHJmMM4Ncwo8XyCjwxKrC1QdnN0GYpoaGbUPX0JGe6x4K6/BYIQoX?=
 =?us-ascii?Q?ydJu8Jmdu2TDF46TIARaX7gUwaL+qzERUi7LcYBW4c8/ZbLnyDat62CJKcy+?=
 =?us-ascii?Q?AYOUk2oVFk7uxWCGzsr2u0/63tZjVCziH1raQd54vUa9q/dWtm/RnngMN3wg?=
 =?us-ascii?Q?2rZS1voaog6/AnS51YzrUposc4iKcHl8qMzd+yomkBhLnusCe7KqSYdzk398?=
 =?us-ascii?Q?eqfluZ1P1p8uInK7aJnb1qQcw9bJ9B++SZn4t4vIYhqBDYz+p/rQiZRog0Z8?=
 =?us-ascii?Q?6PgKOW5/FCaMFbIAL2TVhjugQgKfBwoQ5vNzd1Wy7RxfMZJs38o2xlupC13u?=
 =?us-ascii?Q?FYbCpy+r+imidXtNUTgSeRj+grAo8Q5Jq9RUWd65IRvVF4sm0Oa3Hvae8jV3?=
 =?us-ascii?Q?i3eG1YmYzQzLXQ7uA5q8TMtJZsZFd7T1nCsZNdM7I4W8f/N+qaZ/7BT5qKl5?=
 =?us-ascii?Q?KlBacoqlCTnb4onHKjkJpxjyt0WIVK11xJXLJGIQFP71t2Dxat/k0YvcndFU?=
 =?us-ascii?Q?K+lNlnX+6mgJqxeRwLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUMfirXfDssP/AH7OlcYiigZwlbHfTsio2N0p+I3tz6Fg+Yj7bO5qGghVM9h?=
 =?us-ascii?Q?N1Ucr8Q1I3A2hfh7yQUTtyjvbwTpVVGFRNsINBn4lFuqHMnMC+M9Sd8m3EYw?=
 =?us-ascii?Q?Gy0KU1+OhhF9Y8Mx3B0saimmk3jkyPoCPbLl+H3guGc5vLSg3Y/lecTo2VOB?=
 =?us-ascii?Q?UCQdbGOQ2/n9ZsYLOKbFcBOnCRIAuSI0uQOepgV89efBGfnpSenBt0TMgw4c?=
 =?us-ascii?Q?70D9jPpB/MW6hy1AJB7mRtwPwKNS4KSzC+JLs5IRjibuevs/c5pK6M+iafAQ?=
 =?us-ascii?Q?J9Y38VG/ROINRzus7+kYfKWRQEOnvFnKFYNtRqwgPEiurHcTvNQm34Qbvmi7?=
 =?us-ascii?Q?vC6I0VqXabcN3y33D+ZXRttAIoGpPKHm3SqT2LpN3filXBSAJLs9yLl95D/j?=
 =?us-ascii?Q?pVydNlIZPJtnyNyNkIYk9oh5Y3iyLWOd3yspLbqpKZs6CPEKVL0wQIYceu4n?=
 =?us-ascii?Q?lwliAUWF2YRXsw/T+chFoaGtX4lwtpuEIhzd/Og8/iCWWOrC4Bey3lkOZPk3?=
 =?us-ascii?Q?LgWWHmkO23hISjCP6QfgbjmRdou0n7ryeFRlSEhIyQ/S6iiFSrODYNctWaOZ?=
 =?us-ascii?Q?K9ee67LnWupjX1LXlvzr0szDgnR9H/LXMUKNLA2ctYZ6a40llmayic14MQRJ?=
 =?us-ascii?Q?MtWqTFgUSS79cIhz0t03IBLYIZ8w2dAPzPdRYgC9AAjZ7xqQvWcG5Yn2YYPZ?=
 =?us-ascii?Q?AEaNK7D8qmPPhJPFXIcAbtvQViq0y/bTFUKBy4m7sx7Acakblr7wmorH621v?=
 =?us-ascii?Q?1Mnk8P81uloUYSWDlBiAzKwWkU2FGpVRZaByXvjTAb+vLDj3ovqlPwzpLvyy?=
 =?us-ascii?Q?Y56+qEUcpRXy/LZhsJu5XSMHt0K47yxDgZRfRAHetpdAQ9n4WMOJ26ToH6mB?=
 =?us-ascii?Q?YP7HvNq9Uwtfxzr/H4OEIdz0mGve8XY6CMqVbtosIZwePunSHo9Xe7NalNbY?=
 =?us-ascii?Q?cYT7B3/TsDAONMocuvoJIH/GKgTqDAIUuTKgkBFiIitQp+Wmcar+8pUlB9MP?=
 =?us-ascii?Q?c8qtNCP+VtxNis4RL2H/UbSuZWwnv63s4WtcD6Nt+4YenJsxp0GARLieXLhS?=
 =?us-ascii?Q?Bl1Myjisid0Ob/O5be4R8h9UH+TYvFmbCTu/lKdw8QaQiu6fFlPTIWXy5f2F?=
 =?us-ascii?Q?U2jRLJq9abX1TczBfQXZcLFmajiC7Bq9wv8xzdaxojZCDIqemAQqGuwuaTyh?=
 =?us-ascii?Q?J+S2MhUJEboHExMT6e6iF6I4FRy7iotQJnAjjev8i+exfNa7iXD3fCHIgolV?=
 =?us-ascii?Q?L1OXypZZqKgiHDEehRmOEGK9N1ZRdQpLLkuOO0o4/J32/rPK4OA9OEIW43CN?=
 =?us-ascii?Q?oOOjxHnVo377G51VDSBYpzKb/6rTna9qkwnFDz91JKrkujHnH5vRqXZjIC95?=
 =?us-ascii?Q?fe1qxl5fiakXg1tHfeyxO3+VaJNxsVBvFjpQlmRVJ+XprPe02oTb8O71/6Py?=
 =?us-ascii?Q?KJo3JtZkPzX+1Uf1/hfzeE1u/8L+YfErZ7VVl/DyZ/+s8gJiwyMaBZRqdayC?=
 =?us-ascii?Q?7umgZGq3F87jXSf4pAQepTu+BcMN0rUsP3v8qkDy0Ea7iLVdN9/btX68Zjh8?=
 =?us-ascii?Q?itY1+GH2mgwnOzzb03vGXUkLN2r99G7tw3pZ1Zl5zMauKusLaMvuAXk0orht?=
 =?us-ascii?Q?/5A424tuklBq8Z4Qkox+nao/5m66kPxU+iOwjYPV1HCkKKR35jhCDYyYtTxI?=
 =?us-ascii?Q?PfMXd794nzsj24iS9TmmjTcP5cp+nmB3ImLVceqL3CkUxJCSuFctD96pWZPp?=
 =?us-ascii?Q?zER4OAoXGzgyHq/uJC7ZEHM0IuCOo66wpd2V5UBrXG5kxMK8Q6H9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b29b56-f56f-4e70-7eac-08de63fd5984
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:51.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDLarUFCOGlWOu+fsXMY8Qog4dy0UxO3mEEPwfxlXZiarNaPYV5wNBDkZm0gNAm5UtSZ4EQ5fg7EhUMy6n6cBw==
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
	TAGGED_FROM(0.00)[bounces-8723-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 6206EE7CFF
X-Rspamd-Action: no action

DesignWare eDMA can generate an interrupt when software writes to the
WR_DONE_INT_STATUS / RD_DONE_INT_STATUS registers without setting the
normal DONE/ABORT status bits. This behavior can be used as a
lightweight doorbell for remote DMA use cases.

Implement the dmaengine selfirq registration callbacks for dw-edma, and
ACK emulated interrupts in the eDMA v0 core by writing 0 to INT_CLEAR.

Because interrupt emulation does not set any DONE/ABORT status bits,
dw-edma cannot reliably tell whether an IRQ was raised solely due to
normal DMA completion or whether an emulated selfirq was also raised
around the same time. As a result, selfirq callbacks are invoked on
every IRQ.

Note that dw-hdma-v0 does not implement the ACK path yet due to lack of
hardware access.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 118 ++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  17 ++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  11 +++
 3 files changed, 141 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b4cb02d545bd..398328b0a753 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/dma/edma.h>
 #include <linux/dma-mapping.h>
+#include <linux/rculist.h>
 #include <linux/string_choices.h>
 
 #include "dw-edma-core.h"
@@ -687,7 +688,30 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	chan->status = EDMA_ST_IDLE;
 }
 
-static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
+{
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
+	struct dw_edma_selfirq *h;
+
+	/*
+	 * eDMA interrupt emulation does not set DONE/ABORT status bits, so
+	 * a shared IRQ handler cannot reliably tell whether or not the
+	 * emulated interrupt has been raised when the status bits are
+	 * non-zero. Invoke selfirq callbacks on every IRQ and always claim
+	 * the interrupt.
+	 */
+	dw_edma_core_ack_selfirq(dw);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(h, &dw->selfirq_handlers, node)
+		h->fn(&dw->dma, h->data);
+	rcu_read_unlock();
+
+	return IRQ_HANDLED;
+}
+
+static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -696,7 +720,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -705,12 +729,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
 
-	ret |= dw_edma_interrupt_write(irq, data);
-	ret |= dw_edma_interrupt_read(irq, data);
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
 
 	return ret;
 }
@@ -742,6 +787,63 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 	}
 }
 
+static inline struct dw_edma *to_dw_edma(struct dma_device *ddev)
+{
+	return container_of(ddev, struct dw_edma, dma);
+}
+
+static int dw_edma_register_selfirq(struct dma_device *ddev, dma_selfirq_fn fn,
+				    void *data)
+{
+	struct dw_edma *dw = to_dw_edma(ddev);
+	struct dw_edma_selfirq *h, *iter;
+	unsigned long flags;
+
+	if (!dw || !fn)
+		return -EINVAL;
+
+	h = kzalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+	h->fn = fn;
+	h->data = data;
+
+	spin_lock_irqsave(&dw->selfirq_lock, flags);
+	list_for_each_entry(iter, &dw->selfirq_handlers, node) {
+		if (iter->fn == fn && iter->data == data) {
+			spin_unlock_irqrestore(&dw->selfirq_lock, flags);
+			kfree(h);
+			return -EEXIST;
+		}
+	}
+	list_add_tail_rcu(&h->node, &dw->selfirq_handlers);
+	spin_unlock_irqrestore(&dw->selfirq_lock, flags);
+	return 0;
+}
+
+static void dw_edma_unregister_selfirq(struct dma_device *ddev, dma_selfirq_fn fn,
+				       void *data)
+{
+	struct dw_edma *dw = to_dw_edma(ddev);
+	struct dw_edma_selfirq *h;
+	unsigned long flags;
+
+	if (!dw || !fn)
+		return;
+
+	spin_lock_irqsave(&dw->selfirq_lock, flags);
+	list_for_each_entry(h, &dw->selfirq_handlers, node) {
+		if (h->fn == fn && h->data == data) {
+			list_del_rcu(&h->node);
+			spin_unlock_irqrestore(&dw->selfirq_lock, flags);
+			synchronize_rcu();
+			kfree(h);
+			return;
+		}
+	}
+	spin_unlock_irqrestore(&dw->selfirq_lock, flags);
+}
+
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
@@ -846,6 +948,10 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 
 	dma_set_max_seg_size(dma->dev, U32_MAX);
 
+	/* Set DMA device callbacks */
+	dma->device_register_selfirq = dw_edma_register_selfirq;
+	dma->device_unregister_selfirq = dw_edma_unregister_selfirq;
+
 	/* Register DMA device */
 	return dma_async_device_register(dma);
 }
@@ -959,6 +1065,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		return -ENOMEM;
 
 	dw->chip = chip;
+	INIT_LIST_HEAD(&dw->selfirq_handlers);
+	spin_lock_init(&dw->selfirq_lock);
 
 	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
 		dw_hdma_v0_core_register(dw);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 0608b9044a08..4b9c4b28b49b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -97,6 +97,12 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
+struct dw_edma_selfirq {
+	struct list_head		node;
+	dma_selfirq_fn			fn;
+	void				*data;
+};
+
 struct dw_edma {
 	char				name[32];
 
@@ -115,6 +121,9 @@ struct dw_edma {
 	struct dw_edma_chip             *chip;
 
 	const struct dw_edma_core_ops	*core;
+
+	struct list_head		selfirq_handlers;
+	spinlock_t			selfirq_lock;
 };
 
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
@@ -128,6 +137,7 @@ struct dw_edma_core_ops {
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
+	void (*ack_selfirq)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -208,6 +218,13 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline
+void dw_edma_core_ack_selfirq(struct dw_edma *dw)
+{
+	if (dw->core->ack_selfirq)
+		dw->core->ack_selfirq(dw);
+}
+
 static inline
 bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a0441e8aa3b3..68e0d088570d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -519,6 +519,16 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_edma_v0_debugfs_on(dw);
 }
 
+static void dw_edma_v0_core_ack_selfirq(struct dw_edma *dw)
+{
+	/*
+	 * Interrupt emulation may assert the IRQ without setting
+	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
+	 * emulated IRQ, while being a no-op for real interrupts.
+	 */
+	SET_BOTH_32(dw, int_clear, 0);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -527,6 +537,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.start = dw_edma_v0_core_start,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.ack_selfirq = dw_edma_v0_core_ack_selfirq,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
-- 
2.51.0


