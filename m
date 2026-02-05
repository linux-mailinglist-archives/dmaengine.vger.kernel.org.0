Return-Path: <dmaengine+bounces-8747-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGrpN9g8hGmZ1gMAu9opvQ
	(envelope-from <dmaengine+bounces-8747-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:46:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2EDEF14D
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 07:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30B563011A6B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 06:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF19275844;
	Thu,  5 Feb 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UTd/WMmv"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020139.outbound.protection.outlook.com [52.101.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B042AA9;
	Thu,  5 Feb 2026 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274004; cv=fail; b=IavjaoUhDFLF/iE8y4ilDIbLcTPfwct3KFORDHoq1+9xZv+p3oG4tDs2XhEm+rI6VR5fUs0NTW/yoffYVCKQz2bI9rwCvuFHVr3WBa/ix3ltA3jSwGdgtQO8pWAbuSM0SRdIcRZ7sX0+NzMQNDr0SpCDaJ3cqo6BMKxh3AUBCWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274004; c=relaxed/simple;
	bh=55qEWAQvAnEm1ozS/lN5lOAHPfrsQHjAWGvlWGzRcGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MSHc7ebsu7+2bmjGUKqDbS1R1APaVJCtH8w2swI2eIfKg22jWjhGfjfUTKNnPXy4UV5gSnTLCqa8/+/aaHGii5iSWWfHHYjLghEtfd1Pg1/QMnsjSGc41I0h49gsC1t4dhhgehwV1Cja9JriV8wZdBMlAghVMMNnETts3X0uppw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UTd/WMmv; arc=fail smtp.client-ip=52.101.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhNRj7qoEA30evj1omJc9NpHmtYHqobY7xl9jQUz1BQD2RyKlCzneTD1lm0LTyrrMGH2gM83hkUnBXmwxou280XDv2VXGzFs+O0eVX00+t5EgMCyTXJXxnGlw/zss+Bc33Iuq697CFp4zZjQgQY0fy2hGNR7sgWYj/i/bPgEaZ1NHjXQADDw3dMeGC3NONdtnpEmSz5DoZSFXJLNcbQvhJq1lUFaI8lnkG2o1Js9VsqL+h1DjBrtoJcP8m7c5I3Bf61unKLfbdQdQ5u+ZJ8Cseem7ByyNA6Grmj36WbbVZ+cI+86WDkkfk06WTNeu31nAxQQN3nHeChXByrdp+hKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8iCa2HjHz3AT31wQxUOO+MT+RyhmiZ0eM70NXWctHM=;
 b=CtEhQroOxd21hbsLv6rnCsf/H5FRT4OcihW+4k+V5zXP5Pn+EuVWY5+eJwFj/yRY4e5w0sIMc1iTq9wtFLVuHMBd8eM7HDucYZqIFD6EgHnhivZ7aq8U6bQxbHV8vC43zEgDLNo00L6mHaOpb1qkOa478sDovWJsdqEX+eTnvCJpRbb+FZLcFYJpdi+QRNV+FHkelcakKz92QOymWvDlRwDQAguVJhN0RjCkltp9qsc7SElZ+1bqMGljuUrpKLXSXKPSaXeTNLIPHWh4F3LJqiOVX9wOu7RvbjlzFYsEwg3mb9ZCxqgQZ8WIHwDIOSWrFwk8WhJkTAMpJCaOlv5WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8iCa2HjHz3AT31wQxUOO+MT+RyhmiZ0eM70NXWctHM=;
 b=UTd/WMmvO+SMK6KF5wxaHxXA3M/rRASG2PabarMnq7tT2f56iH+E30vqHVKyqeIF6jMKVlaAODKKl7hvzQZKPYvTW1h8PVJRPgSgvyc1FWvyLQ6teiD5WAiI+zLzyWLVlBxF1PoCJfEiOlM5kdQOIHAA7/kZGhS1RbVPBWiekLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5786.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:46:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 06:46:39 +0000
Date: Thu, 5 Feb 2026 15:46:37 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] dmaengine: Add hw_id to dma_slave_caps
Message-ID: <f3byxj7aup6sixkxixtayamh4m6q3df77rweiawbmmtcsw4boh@vbfbjhufe45r>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-2-den@valinux.co.jp>
 <aYOgV-dmeA8XjNyw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYOgV-dmeA8XjNyw@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0337.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: b6df3a59-aeea-451d-602e-08de6482506a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ezQSpIIZKvX1xigadLvsTy4SWJnXVyRc5XZXtDZW3gY+QGmRUHue51olRa6?=
 =?us-ascii?Q?bDv63GOegNFrQmX93XIlGjwrIbTxTRUuJAaYg7vjzAjZILVwWR2bec0pZHFB?=
 =?us-ascii?Q?mcVvZwifhzEYBJc1O1Bv2L1fkwhqG33/xZF+9K8hjnK1gWi6mrkKhmq0YOwl?=
 =?us-ascii?Q?3zeMKXSxjHVSIkoUB+3qxl8PhXqqVCdKoqmilkbZn2hWBWi6Vve2u/ta/KXw?=
 =?us-ascii?Q?+RTTwGwIkb9nTW1+o/PUA641fWuH+pgXQRxbHhvPkg/9B+t4cEsAlUUVOM7N?=
 =?us-ascii?Q?uD+BIv1OCBSVNphztYF/Xy37ZsiM2F3uKneodssCuqnJ+9MjWAjNzw3hGv81?=
 =?us-ascii?Q?C5MwXxurkP18KCWhVwZCJzXbhZM+7HM0HRg05vb33lvPnNYm5Z4P6fi78pF7?=
 =?us-ascii?Q?YGMY0t+/uaqAaYvXI3C5k6nQw0zm0fkDwiiVBwsQAYMW70u92t6/bsPy6OqK?=
 =?us-ascii?Q?ywn6x+/LBDkBtHsjeMfBr2x+bbQMV4jGn+IHCXsaSgjUxG9S9blHxQWiYcAL?=
 =?us-ascii?Q?6NeA+Kc1F2eQ9L1NGBZAbyFSbmJBA74WccAQB4rbXPBShBl3hs2LCPgSfGkR?=
 =?us-ascii?Q?suwpQNyaYu5JvnQaqOY6g+jtyw4r4+lnt4EZE+9yQ9vcWEqU7691S+vG0DI+?=
 =?us-ascii?Q?dZ5boqVpksIcxuLNNGkjBKcCGfR28UXUexdcXenpmtPWeo9MjYb+fKQSUg5N?=
 =?us-ascii?Q?ZiBg1Awaz409zUYrKV8k9E0cx9tEFiWvlqleWwktvU5PuN2qOak49fkb6QL9?=
 =?us-ascii?Q?2vn5RwEgPgCTmC6gi/wYjWYNcIHct3swy9mFBP0S5JIjd7x54brGwPLwxHSN?=
 =?us-ascii?Q?S3r/1i6zo9nyYILFRB4xeu7nH250pgZ1CgBLlojegjI+I69VbiAqSuAZ8HXl?=
 =?us-ascii?Q?t6T2z0RviwkkQXuslu2yLzcUaD6ol8ksG7e8nsoqZg0A3YrLttE+ooHwkp4u?=
 =?us-ascii?Q?jIpEYUKEDzS28JS4u6isyRhGhbyE3xzbLC2pNPE1GKgXphhWepm1u+VCPKjl?=
 =?us-ascii?Q?lBEkxdNgVwy4tg1hXYy9eNUMTjlZAIQmAwoWSUKmiD3TJGUoDBXkL0qK0l3y?=
 =?us-ascii?Q?8lixNAD5jQar4e68YCG6Fj4eWa+rzOj4RaupWGzNlaE02OlYjkBd4euIx/Bc?=
 =?us-ascii?Q?1ypt7Up6mklCAJNyiR8H1TbFNn2y7hSbOupnJt596qTqYrcBdEqikh3gsI4+?=
 =?us-ascii?Q?aRhXpDiluh3P03G2DFW4XUBgNC3DbQ7b4VStK53RmkP2k2fAhcI+lRcb/ei1?=
 =?us-ascii?Q?TvBPiMbPIXtBp958Ar6l3SgjNkxrbK+BFwpKpjYs5YGFMw003lOif2vew86x?=
 =?us-ascii?Q?tDeUUDvzg5bYDgKeoVYwnXVQ6Pt7h8P078NTc/IQcPOnGbFr962QaoVk2LjO?=
 =?us-ascii?Q?qPKq/iwK1FXNvvQZX9NHLYIl8tt7lbGXdsEX21WkdrwybHRKoLLYfS5i1J/l?=
 =?us-ascii?Q?aDiVxPVawp9W3E/Jv9S04aFynR3U0Ivoo/2zk/KmXQGDstkB454AmiJmyhs1?=
 =?us-ascii?Q?9aMTAlU0nlWQXbzfWmk4wlA2BbH4sxRSBGcObtCUy9VqRSNmm6zVTfqbQMai?=
 =?us-ascii?Q?XJt/vGC+YdSvJvdVEcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ca54TyuEWoRYeUE1ac8L28JX6ODwJho3lKFjNdufz5tJiO/IEArNp/+GxDva?=
 =?us-ascii?Q?NoTfkBm3+WGFaygOW3eWbxc7ky/GvL2CVyFA8cXtLnvXVwR54sVyFnboTSVT?=
 =?us-ascii?Q?ek8TzYOpawiQLjP8S8JAR5yQlK904Js9MJFC6jLtR6JY6ocQLrxmDk0Ler63?=
 =?us-ascii?Q?mJRdEvz41TXldcfP3ZLmDxLp+UvuZNK8o2Rcs/n04J7fP+3YL6JBkqpyEsSu?=
 =?us-ascii?Q?vA9Ll/EeIGcB/jkcPJlU85qsM4ru5awW9e+jyG1H8XXIwBdR8I4tRTOqNcqM?=
 =?us-ascii?Q?7dQvx0ypC0h7Vab9zPPonQDIZQUfZqoZ4f1ervxUgmdrC11a1YKZqI9eisxw?=
 =?us-ascii?Q?Xrb6U9Sv8flIdci9aZQO06PdpswswVPccz38pK4ZbyXtpYIjAsdWyfBM0Kg1?=
 =?us-ascii?Q?5dKMmrVYqtOxtxtucgZcMo7gd+lE/+g/GOKZiNNRCEWoKuVw17MLvMUoKKbz?=
 =?us-ascii?Q?Rao6pAYADhOKwvi6+obcFk+Mi1kQLaoial7WAo6vUVXFaGkk1wijIruMTN0j?=
 =?us-ascii?Q?5o+CDekgvDCOKjXueL4gN/396NLxxLviSZeJYRApsHkibn1V51SKWsDTPZgE?=
 =?us-ascii?Q?JjUUkvktou7Xu5UIlev2v0Zp5Qsn7ZpIOqMm/gye6o/OAh2iiBDbNktd1NrO?=
 =?us-ascii?Q?Eg79iplku2tVoTFxU0qdwinVpz62cFO2VjYDozys6uWFo2BL9y4Rmt7ZPzlA?=
 =?us-ascii?Q?4cdwTnYvwup+g6J3GEcrR/fNK38pscALjbkOSheUB0u8W8WilID43H+G+QUs?=
 =?us-ascii?Q?w/i96ZM4qPaI/nHia3kSRpu8VOWDsby0A5hkkifPaZJwCTB1eG9YpEnGFEze?=
 =?us-ascii?Q?LA1taVodQyCmQxLfTxKoAATJzfTXBikpklJn6HKvZKgHsQIGFMLVMl6oMQ1w?=
 =?us-ascii?Q?ngP5ntai541O53Pf6jhfiju0SACgVp8l/ElWukFwe1Cdh9cf/6CyA6IvA4V/?=
 =?us-ascii?Q?bAcZYOkB7a5gpdrlEo04EG5TcmBPb/IOqObc/jd02XUJag2mgHEjGMkAAbyk?=
 =?us-ascii?Q?PeAn/lwLqbzRV8ZQ0w3UYKBqWjfz7z11/Mjq0M6na1j8HTIhaay6uAHjea5M?=
 =?us-ascii?Q?8Ap/V3UMNKhSngAj74tGYMFuidbEc0XF45g+WUCMUoeEGZu7TFjo2cJFnUSS?=
 =?us-ascii?Q?voMF1r110v3jY2ix1QdmQWAozhl3oyPpE3LIuiZTtdZnbDsJlcSPigB7q4iX?=
 =?us-ascii?Q?7MYLa9bmdh/IwuvD6lF55mcPCODrUqaeuPyPHL2Hez1jM5WQ1uQrNZcpOmw1?=
 =?us-ascii?Q?g+5nZ4oCu9S8Swi2Q8382qMqIOkdItJ4OKxPupiNwsKXPqrLt8NszMnCPQs9?=
 =?us-ascii?Q?h+t6rJUtLC16kfxdZcPQYeOJCaRKYvLDADnvCeAcYhRUHtDTYLEUfpsOhVHa?=
 =?us-ascii?Q?I1VgFMPKJj0Kjtb2M6xQWvRBWCWuCNH0SHQiGecl6tkxXXh8h6hubq6CuqID?=
 =?us-ascii?Q?hYSYMPZQCnr/6hM16DTWoCwr7W2e75KtWnePCF0Mu4Hlb0vkBnO91Q5Chuey?=
 =?us-ascii?Q?jZSjMH7qu9UUGDr/mF1q95MihnQiN88Q6XM2GjqyAaN0LjD8u+Q8tJilL2Db?=
 =?us-ascii?Q?ulLw5PpZdQFRWyCEtM+cklvE649y0Jc/mj/2jMBtr1+5yaFz7BWfXbwQTAOh?=
 =?us-ascii?Q?eMpdb+qYyyNLDUlzuvWUDC4kpLTBe1CSzqlUlHJIDjs86G1GFJC4uL/9VZSO?=
 =?us-ascii?Q?DnglE4JUuW9csxTk2TYZT3pawUZXOPRS/tpCPDxSpNOY2uGvuJa4JAtiWV3R?=
 =?us-ascii?Q?lKJq5qfkjY88lU4c18a6xUzQYoZ9rTLDbcqmZtfN//RqrN8lwo/D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b6df3a59-aeea-451d-602e-08de6482506a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:46:39.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEZ9d04BsZiHx5v7rN5WBIUKUr7e6dragHDZcCaOe1dk9Y9JwlZMV5HTaSC+C38YXunTePHu9iZ8j7pbb7MjPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8747-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 3D2EDEF14D
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 02:39:03PM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 11:54:29PM +0900, Koichiro Den wrote:
> > Remote DMA users may need to map or otherwise correlate DMA resources on
> > a per-hardware-channel basis (e.g. DWC EP eDMA linked-list windows).
> > However, struct dma_chan does not expose a provider-defined hardware
> > channel identifier.
> >
> > Add an optional dma_slave_caps.hw_id field to allow DMA engine drivers
> > to report a provider-specific hardware channel identifier to clients.
> > Initialize the field to -1 in dma_get_slave_caps() so drivers that do
> > not populate it continue to behave as before.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dmaengine.c   | 1 +
> >  include/linux/dmaengine.h | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index ca13cd39330b..b544eb99359d 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -603,6 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  	caps->cmd_pause = !!device->device_pause;
> >  	caps->cmd_resume = !!device->device_resume;
> >  	caps->cmd_terminate = !!device->device_terminate_all;
> > +	caps->hw_id = -1;
> >
> >  	/*
> >  	 * DMA engine device might be configured with non-uniformly
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 99efe2b9b4ea..71bc2674567f 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -507,6 +507,7 @@ enum dma_residue_granularity {
> >   * @residue_granularity: granularity of the reported transfer residue
> >   * @descriptor_reuse: if a descriptor can be reused by client and
> >   * resubmitted multiple times
> > + * @hw_id: provider-specific hardware channel identifier (-1 if unknown)
> >   */
> >  struct dma_slave_caps {
> >  	u32 src_addr_widths;
> > @@ -520,6 +521,7 @@ struct dma_slave_caps {
> >  	bool cmd_terminate;
> >  	enum dma_residue_granularity residue_granularity;
> >  	bool descriptor_reuse;
> > +	int hw_id;
> 
> I have not see where use it? Does src_id of struct dma_chan work?

There is no direct user of hw_id in this series. The intended flow is:
  1. obtain dma channels to expose via the standard dma_request_channel()
  2. get 'hw_id' for each obtained channel (with this patch, Patch v3 1/11)
  3. call the pci_epc_get_remote_resources() API (introduced in Patch v3 6/11)
  4. iterate the resource list obtained in step 3, and find a resource whose
     .type is PCI_EPC_RR_DMA_CHAN_DESC and .u.dma_chan_desc.hw_chan_id
     matches 'hw_id' obtained in step 2.

By the way, I couldn't find any 'src_id' field in struct dma_chan.
Did you mean dma_chan.chan_id? If so, it's explicitly a sysfs ID and is
allocated by the dmaengine core (from dma_device->chan_ida), so it doesn't
correlate with the provider's HW channel numbering.

(Also, correction to my note in the previous v2 thread:
 https://lore.kernel.org/all/zqcu3awadvqbtil3vudcmgjyjpku7divrhqyox72k43nfzcoo7@hflaengfjy27/
 There I wrote that the low-level dma channel id would become unnecessary,
 but that was incorrect because dma_request_channel() does not provide any
 guarantee that channels are allocated in hw channel order: other,
 unrelated components may have requested dma channels earlier or in
 parallel, so the set of channels obtained by a given user cannot be
 assumed to map cleanly to hw-level channel IDs starting from 0. So this v3 still
 includes this patch. That said, since there are no direct users in this
 series, I am open to dropping Patch v3 1/11-2/11 if you think that would
 be preferable.)

Thanks,
Koichiro

> 
> Frank
> 
> >  };
> >
> >  static inline const char *dma_chan_name(struct dma_chan *chan)
> > --
> > 2.51.0
> >

