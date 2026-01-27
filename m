Return-Path: <dmaengine+bounces-8521-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA4FNrUyeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8521-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:36:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8518FA14
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025BB305289C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426413090D5;
	Tue, 27 Jan 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lIWPZwPa"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447230C61C;
	Tue, 27 Jan 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484891; cv=fail; b=FSevodg9zLiMaIYEvr2ZcpsMZozq+K+airLnwGULTlhI00kwMG3spuLcYdPFGTcqjPC9ZSyNkXIKMdBYee7QHyOLCmOoAntof23/BxGOD+Oa201CcC7t0q4LQkGMbxx46szVTMpe/nr70CFLUHs8zx1aU1UeFlQWku9tsSTh7FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484891; c=relaxed/simple;
	bh=QXnirUU1oxjLYia5uFQ7wD77sBcEz1/IcB6v+yQXxSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+clFafM9tpxvUr/QuyaydCgzuZE7lZHueOUkZn/txiOWIJnDMVBI6t7Z3sIx7VY4AUnQjLT9NgM9YPyIFpqoTzJtDWMLJwqzjlfQV57DOfyvycAELXN6PplcYGQWZWiORRjgtlTJtsNH2MfZeJuB+28rO03WI9lycmNf52fC0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lIWPZwPa; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNTkf9rKP+cHpZ4Q/jk42lIIEm9YX7IwnvVuAOOAhqioS09aIApiWVu2PJP7PuDcpOL6/3A8SEDLJWPJZDR013azFsnx8/fxNGMO9ip83moS4lg4UeGsUiRvrhtn9AyvanGF42zwVhxQCinYwsPxLwgVRppmSkaki0y/ZlcLrEp86ykQpgcVZADhLSuCzH9HHpGQHM3eoHGc89Z8WZbecl5NTF4YGb3fXec6ahQtSy9UjOXZn8rEN+qEpL5OCidSIlc+A/Ow0lhlC0hli0p3llwmKP2W6uneBydrty384xgpLXVUKVYTDTYfBVrwrGQNEWIwA0MotgbD5pV/VtBUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp9dPzTCEHtcejofSAYCzLEXTJW1O/StwwLR36nHrlQ=;
 b=kSa+rssfRFJwjavjfD8vr8K0d4hPjA/ah+G/9quTpiMnwwH67JgjUdOjqE9K75LRMZVFSlCWbYWXsqhwSkuY6/xXbly520MtAGUz9OCCObnWn/eQP2s64aHYe3UblxoKxEeQsAfQV3py/ivEwHAIdk5COb+fCf6NZZlW1RgwsdSp7zAa4I6qctCcS98JGiLYdku7MieSX2sOGni1hgNVTJCeAEw4kvyBqY1O+XlDCv6jvklCqFrIdov27/mJ2whEpN/j2wlIV/FDuCuQeMQr/pNLVeg8YwJC+RP1YYwG71AiXFFUqjUSIEImPipT6d7v0AXVbKMhJeBnoivuZDk9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp9dPzTCEHtcejofSAYCzLEXTJW1O/StwwLR36nHrlQ=;
 b=lIWPZwPaUJuIBU+ejV01HNPZGWO7Efyqc3hR3xtxhF39XE+szpDSjLamD/hFm4tt5PIFjyGwVpM3SIE5u55lXfDo5GepW4uZDr2Yvop/ZqbTUqJ7/Bt/sZGefKlVIo03nKK2phzpWzdsqpJ9WSmurGjog2st1YCFt7SHVfwWF0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:42 +0000
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
Subject: [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Tue, 27 Jan 2026 12:34:16 +0900
Message-ID: <20260127033420.3460579-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4e1e65-726f-4e64-fa6e-08de5d550277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uLPyIUA/BVLJRw0Bw+p0MkgZxiBRI4yNmaDVxyxYT7CGDF0remAfMZVC+QY+?=
 =?us-ascii?Q?A8VnHpSvHfzgU8s+2+B9rPEJtK3mY4SppenVskrQeTUsZlaCrIGv0EewWjqO?=
 =?us-ascii?Q?7DKflFGZDK1BajAyFlO7/jN7LQIg8H5omNu3FdfVuz5h464eL0eR74ESxikM?=
 =?us-ascii?Q?F164fh357Xmq1PxHJs9KKnUqiOHlvHz6JBuIvn1xjYDSxbsdYfREmpjBeT70?=
 =?us-ascii?Q?Od7X+66RkvnvI4qbE/DBtFLk1VSTXxcAkvWqK5ugMQlc4neVUoYczjYiGpKg?=
 =?us-ascii?Q?aunkr+EHHxacdhHSbaDeS7vf65sU1AtPhX44hI0fwtCSlDWXAInl3neAwV8k?=
 =?us-ascii?Q?IJUGGD6T/kirAMWGbX0FFR4aYPXnTcRd6qZ5YiLWEyd0/neKydSc+V8j97rx?=
 =?us-ascii?Q?uYBFC3ngiRG236chl/MJeSnhxsbTS+iSPs2WeBK3mCp/mQrwKpVnk2b2OofY?=
 =?us-ascii?Q?U6HlkQ0LYme2Rk0Pz5jMItacoZ9fuDg3xldp4nI9EmWi6mFQ6o39Ls8VeFpf?=
 =?us-ascii?Q?8IGvUdNwDKcwmR5JUDQ5ASMtaWnm14Waz1wdUFyMTr6A0LnyITXC3uaXYHUo?=
 =?us-ascii?Q?ugVlu4+w2tlKjnntYFbSBrb/p3g9RPBJLZTYdRKT2BoEu2SzkAt7jYps3JK+?=
 =?us-ascii?Q?UvdE7l87ehzVKuD1/UTaa5U050Ip/CAEnzgUZKapasa6ofJi7T+FdQb4/gLe?=
 =?us-ascii?Q?47x7BpDnwHPLxFzg0HcpaELBdaenyga/THoocykSO0gpjLEHAu2rcoMvYs0y?=
 =?us-ascii?Q?YpwpsS6cfWnISPMpxi/8xImDn2CowCsJNtQ0PozNPPCrQINgoNXdiAmpCilP?=
 =?us-ascii?Q?SdjSe9BmckQC4ZxYUqZ+KYe8ukLwYu/SgWP3MemfGlpucuW6UkvsdRoCktTP?=
 =?us-ascii?Q?znn4XvOj7fi6naidu9kWgFFCHZKKTyGyyvHSuMDxLZQmIE3uT8TIPIqdLoRP?=
 =?us-ascii?Q?/oToRSivZkBYM5hb+Uo4bF0YRRjCYmKfFM0H7Je5nFV5Xs5c+lSW91A6NN+R?=
 =?us-ascii?Q?0Swcp0jtmRnZTHZcIAWySluKV43xKIs+6tfOSCJg82O18LJ9PF4doTy2fjXL?=
 =?us-ascii?Q?5sSrvfrjtarF7hJIS3yhlD7YCicJ7T6pIZmE1S5l4HLWARQsiH6rIwvKgSxI?=
 =?us-ascii?Q?DIMLUM/FemmhAPdhU23j0WrotkgjB2R9cf6GbiMIf0eyiObNvVQ0cOJ0iZ/n?=
 =?us-ascii?Q?KH+0apwVI1V/PI2d7izJfdpoyXPjiEe+QXuAZzFZ64OgNCUDbOLCxIseMP97?=
 =?us-ascii?Q?mdOvlYobvoQUCktDSLdzb3GhY70u95Xveblk1O3Rfb4HRRR6xYXxoz4DCl2X?=
 =?us-ascii?Q?JRkd+FKkq1IsLkZuGLd0nJ0pncNXJuv9Kftequs8/3HGuWOcqe6Xqjq/u8Pl?=
 =?us-ascii?Q?3mA+IQZhMAkMC5jf7UPV8aHDd+vBqz87u/BSS3seDXYMTmi5+qmJdCoLS9GQ?=
 =?us-ascii?Q?9UW6qT8CNhQ2fKDJHDGsB5K5MHSbFP+efK6vrX/NgiJL7dUECeWDqVI1hsVR?=
 =?us-ascii?Q?W+9COAmFf2JClFAsql+BNGg4PiAWGPIiFgzjVM+SvScpUqIJYCR9GeJ7wBJf?=
 =?us-ascii?Q?HqZv7MYsfmzAKr+7P+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0X9pWzvyIEbUo3YfUZ1Ks2z4iSKoU+DLBduDwun6Qn54TNCODONivUeWKaWu?=
 =?us-ascii?Q?TO5u/a+6BE3VtWrp+/DGCqGYz9g21NdCxKCRyNLxI1HxpLt+unqW176LyHWa?=
 =?us-ascii?Q?ZD7iC/lHznawL+K7KnaXy0zVR4WA650ZNTR430BGNPxv/uNWm1t98WZD48f4?=
 =?us-ascii?Q?RwwLl0Pxv6YvhRBj2fut/89S44f6DU7KQyQO0d0hSZIktbpnh0tAwst3P1bG?=
 =?us-ascii?Q?gFKINdxXfLfNrYobA4Tf4NPFdL2CbkPpQ2BPwYQI/Yys7t7v5LfQLqn6u807?=
 =?us-ascii?Q?XEOswrHVMAMkDmAxkk1nXLc+impIcukk7DLTgSFblJrjqIpGCAi9xWrfYgYI?=
 =?us-ascii?Q?pVESMiVgiPi9w4MQXKPJ5e4tAVd+GNLZKXZkVAidQzDtW5K6ORW38ruDBjre?=
 =?us-ascii?Q?84yteXyz+YPkiuKw8etw8mOth19tgsLE9HMP6PksdZ8bCYBp3r/GCKgs6d+t?=
 =?us-ascii?Q?+I6NTv9TzsHZWJSGvFcYD1pQcEhIHe3ykgWW/Pr7iazpXPfY7Se/rCZE8GVD?=
 =?us-ascii?Q?3Oa+1LoiZW+slRQGpi90romOiuX2MF/wnccu9welFv2qUKhoU/2CJMDOTucJ?=
 =?us-ascii?Q?sS8QNLC4Si1NlShGw36e5YDbU57mXQK8BJS9VUvEmGr2yIFiLzQJ+G/oeh5K?=
 =?us-ascii?Q?FbgY3d+mH60asD8kBxOycn8Uhvcpsp3ZzuAvZqi5Otp+vOQcRj0fr2B9W43l?=
 =?us-ascii?Q?mKCqiJfSY808K/S99CNsIrzJrAFEZd/h/JuIm1Sq1xJ9MdAV52x+jpNehXi7?=
 =?us-ascii?Q?bCLzXK1BxJAW6GrA8Pcf/V1CpK7Zb87kAMCQy05z8xlKnI3eEYychbESOrIK?=
 =?us-ascii?Q?2XImyrQH3eHnN1sm1avdepM719qEmEfBOIjb7RJI0I8m+rz7fvURJ6AcRrd/?=
 =?us-ascii?Q?VyVYrWn4xRc7xrcos1O07I7zu1ySZ4ARB7C8O0vyIAOTdtnanZYKqcfVx4j7?=
 =?us-ascii?Q?X8uhJdPmemrOnxVucoOd5P+8u1HX8StpRfQ0Bk5CYKtCO+PYWK0T8rjUdd+x?=
 =?us-ascii?Q?W4Xk8lHW2OIRv9JLmqrz0BmuApWXn42mUyx2sdp+A8kV8JoDYMcbC+wu2D7W?=
 =?us-ascii?Q?XFSN/ppLTh4FSN+gLOhTt/Bvl2h/RfpaRI95tf7dKZfEAzKuARGGBFLfWUIQ?=
 =?us-ascii?Q?vVOqCN/lduObxtj5NVnfr86/SqeIxYy4LNjjXDUjbn17L07kxTPyxuamKrY1?=
 =?us-ascii?Q?DXSkPZ74uvI9nYNtyktyqZ49VQbypKstoMS58mVLPtZpPwkJ3q3P4dtD+vJi?=
 =?us-ascii?Q?tesW/UP7p4HP0IeXvHZJ5nha5kQtjqk3RjdQihbEmdeLYNYwl8vvS0fGE6Vf?=
 =?us-ascii?Q?8b5f1+Ftd9dVJODSiy6XNDTTx0HD3jqVBbGVirm3wtKwydPGZ5j9hXqqXvpw?=
 =?us-ascii?Q?TqM7Wp86VknucrM/2dx83Hj0t2WBbHOyZMMgTdTkk8HuO3djlr5pj/bkpJ2o?=
 =?us-ascii?Q?a+4HRB2ay8+Cykkvo5hIRHEEzrrQX/11iaf0WrYhCk8rZIJZ587VD2mR859P?=
 =?us-ascii?Q?WpxV7Rdta+ci0rFBOn9xVGkp1KAyClFDk+/79SOF7lj5xWLl42E6iCUxsDHB?=
 =?us-ascii?Q?lJfEIOOtbKHW58uzzbkTURKVZ+Z70ZphJOYd43nnn84KdplsvnJZ6un+0lQJ?=
 =?us-ascii?Q?8bdnyF6tzhmw6yOz8D2rhQpNqAe7lPY3fuYRjpmOvh3llPSXI5W1OfspZYgs?=
 =?us-ascii?Q?9bqaoQwxs5PfPWE3wClV6Fpj5mRXJsYwzsAmcFZg40zzeJSBFhNymUQ3fQFB?=
 =?us-ascii?Q?WpXVIw37PfxUHOIwV3y/mrrJTYRWJdavQ24O919KIKbxD1KyuLJc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4e1e65-726f-4e64-fa6e-08de5d550277
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:42.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B18gbq9EZyHwDHdR4lvMabZvK8UYhTY+P4kv9Pnb4MDyE+qCbMBg94MQNj+7DNhsnVChufQDuCYKCnebhNePqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
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
	TAGGED_FROM(0.00)[bounces-8521-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B8518FA14
X-Rspamd-Action: no action

DesignWare EP eDMA can generate interrupts both locally and remotely
(LIE/RIE). Remote eDMA users need to decide, per channel, whether
completions should be handled locally, remotely, or both. Unless
carefully configured, the endpoint and host would race to ack the
interrupt.

Introduce a dw_edma_peripheral_config that holds per-channel interrupt
routing mode. Update v0 programming so that RIE and local done/abort
interrupt masking follow the selected mode. The default mode keeps the
original behavior, so unless the new peripheral_config is explicitly
used and set, no functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 21 ++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++++++--------
 include/linux/dma/edma.h              | 28 +++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 38832d9447fd..e006f1fa2ee5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -224,6 +224,26 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_peripheral_config *pcfg;
+
+	/* peripheral_config is optional, default keeps legacy behaviour. */
+	chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+
+	if (config->peripheral_config) {
+		if (config->peripheral_size < sizeof(*pcfg))
+			return -EINVAL;
+
+		pcfg = config->peripheral_config;
+		switch (pcfg->irq_mode) {
+		case DW_EDMA_CH_IRQ_DEFAULT:
+		case DW_EDMA_CH_IRQ_LOCAL:
+		case DW_EDMA_CH_IRQ_REMOTE:
+			chan->irq_mode = pcfg->irq_mode;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
@@ -750,6 +770,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..0608b9044a08 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -206,4 +208,15 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline
+bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..a0441e8aa3b3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..16e9adc60eb8 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/*
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
+ * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
+ *
+ * Some implementations require using LIE=1/RIE=1 with the local interrupt
+ * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
+ * Write Interrupt Generation".
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_peripheral_config - dw-edma specific slave configuration
+ * @irq_mode: per-channel interrupt routing control.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_peripheral_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
-- 
2.51.0


