Return-Path: <dmaengine+bounces-8788-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDM5JoIkhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8788-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D95100F13
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02A54302A6E2
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B13EF0B8;
	Fri,  6 Feb 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gqtzoo3K"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58F3ECBC2;
	Fri,  6 Feb 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398819; cv=fail; b=tAdI+aT6r2CiMgyATpeu+GYnrR4MIe2Ixwc5zu08UShZeR2Ts18nCBSWnFgaauF/3aWu2n25GX+adSzT6WOsVIXkIvNIUyF8gp/+YgPLP279PF1TcArXIKe/UF8WWkFj7uOiIaXADz/J6AEKnCNLhoKUDp+6aPOjPwtfXAZLb3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398819; c=relaxed/simple;
	bh=aW+DAprHeYSX1vR+PHi8JjlzN1IZf7ek2XjKs2SQnwk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZvL3Y0LBeJKAajcyR/UNVvvIyRRLmBN4KCPoAGbq5feeYGvX0Cl0C/TV9btk7i1MW6ixo5xO/4c9K7OBbWrmSo4Dsqm22XFjIfGCFFoEimQn+ubt28GrQjwEVTH8MCZ2MhXRoQI4FfZ9pVLc8EAuKxKfu5V9d4dVLkmpoSAKCgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gqtzoo3K; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4tw5N8o5jqZD2e4p8//1nQ9SDVwdX55GrqI3o37nmc22Jqf4qx9JCr+uDidIY2z0RPR1g0MQlqlM47NXaHohL2AXoBrnEZvWB6fNHUVjmMelAj5VYkx1f7ORCgYygweeHwsdML+PKJ/wrDvU9E5Mnq/sFMfeqCyHHC2yGf5B4X7Ljp/E6l1MrdJMn9jwnju5XoWpGALu0wJEsY1luvEZxHotQIPZAUeYL1BFpzZLg+rBURqWvswAqiH5tE8zR296so7iutRF/bvX4BrCfkFldiXwfLxKq5SBlv+cmcQRJf8L3jWGYUVBe5vkhSGflWFJijZLw+s/R00IKgFzW0NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDc1PK4fj8IWzd/1/twE3iB2IEtWofMzIwWR4qw41PM=;
 b=MRGRIbVvXu3zOHqNgpeWPCTp8txm29QDcMDhvgFkrelTgBlze8aQ8+9bUANWzjpSNBEofN+tBEVUtJc0xWd5K3jpH/stAibALac0/fqgp1JNK7gA0rCTW5jeSGzwo4KebnM3A/UoZ3ywzUUooyOX+YVsdXHGLxSttqZlm0JbUqrN71Wglu3X0WMSGjmy8mzHVqyB99uoCQcExFGPWyg/BEijwYyRKqU9Lpu8zLgYeD5F6odJZwrQ7+IdLusOgzwPGTstGZLpi6SEiUE2mV+2hc0JwZO5UMhnVfMNbe3q8WezAV9ZQ4Lo0rlfEx+aKD351Jz8J/gIOmYjRjWwjdvnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDc1PK4fj8IWzd/1/twE3iB2IEtWofMzIwWR4qw41PM=;
 b=gqtzoo3KBAclfaui6Q8bCQopNTGX+WtNJTNdYxtchMTXMliJaofO6RIP9RNBfynu7QyaCmsKrFXAg74Zh1WMz0HbyaCB5g/WbPu3fWzz+f1Rles0EzHwhk2xwezTpsDjQbPs6CZMktRRrZZfcvzjnUD4iNhYppuffDYWzLNGSIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:53 +0000
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
Subject: [PATCH v4 0/9] dmaengine, PCI: endpoint: Enable remote use of integrated DesignWare eDMA
Date: Sat,  7 Feb 2026 02:26:37 +0900
Message-ID: <20260206172646.1556847-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: b03c0299-3d49-4779-e6c5-08de65a4ebca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3DvFSw4Ht9/mrVyZtvKGIe0W6qjk2E09Bh8RXiPmuZbu6RvQOg5MMDNOVGSf?=
 =?us-ascii?Q?+bK4rRPUh2yrWsOc6Wdc845O46/Aw/2wlCx12/TbjDjcGd4i2d6+OPO+4Hfo?=
 =?us-ascii?Q?7FtewfwUG2jG0U0wGSP0m/PHusZt6wDtyqtaLtcgFmuIP4pl2wk/ROJN+u80?=
 =?us-ascii?Q?9YxdKqaekVkov5vV97R0DrypTi7KA8kCXOZNC5LeEpuQq7ZQbkb6UXJehbr0?=
 =?us-ascii?Q?3HMgsE8JS7Pw6C50zCbpbZiaUG5nIfEJO0GLZEImnlm6P7D8+l/OI8BiHcZX?=
 =?us-ascii?Q?cGHs58dRhIjXSmmqhtRvAjUhwUpJCgfHeZcTpGoKXycS9hqtr1YuEDmmidX+?=
 =?us-ascii?Q?BrExxbPt8y9u6I7DHxTzYoF2E3bhm1AYFi1VvCodUBUqdFImYRWaSuO+BoSI?=
 =?us-ascii?Q?vnmvZpxIXXtr3cmP08uE5Jf1xs0T1jLreE52lcgxcgkcBFG/iHdZeiThdQ2m?=
 =?us-ascii?Q?ROzQ31duHAibxq/q1Avm8dJMN001JnJielSZliRXDQnek1hbbHO1+MEKE7Ql?=
 =?us-ascii?Q?pqtFpUt/XnMyy6jUkcdKtw2cpPMkINPreIjvEtMXQ1way8YJRB2pfoj4CxdH?=
 =?us-ascii?Q?n0yhw6v83RhklhUkRdGR8NIYLYTfLgsqHThkJS/B9akuI9o64gJWzuJF+17e?=
 =?us-ascii?Q?5646JYNtQ5b7bqGNhmWc1jDUuNNuWXahTqkFZhxDqtUKyXIKwehPT+HiIA89?=
 =?us-ascii?Q?zlkGf1GYuhwNgkyR/9uBahB3ExCED7VJnPrHZjiFHpmkyODUE7uKVIuCwMA/?=
 =?us-ascii?Q?eEIaKYRLkQIe/otrYLSPcnTHxjns18/pxPNgDyKFlPgIB+5u8wGf+jaK6Oqt?=
 =?us-ascii?Q?EZdDGc7807dPN2fIvTXTxTsQddLUee8NfR1UIQ5RRSytW059hnviuw07pnFw?=
 =?us-ascii?Q?wEaubPo4k+6LX/zmWKSTbwufGIgK2FdQTGo+Nn5UI8TzGlxQSG7ke5JPhKiQ?=
 =?us-ascii?Q?vq6GZKu1PAsKb/hfapYHnpzDs1a5kPsDFtq7YBYYNR7CKlBKU+wEs716S2oC?=
 =?us-ascii?Q?wGft1fbP51GS1otECJbebD0Rm0pwBtiiDIX7UAUnCbLnV6IZbEuwl+OLFQRY?=
 =?us-ascii?Q?wRIJkeEv2R/cgzGJFiaqWUWKzeUGNAsaVJRmTWExqFRtsMJgEV5uQNC2Qlj7?=
 =?us-ascii?Q?mx5BvZueF0No1ivbLvqTIzsIbaKliwSMISSryqMi7FRFKsTH1WSQh7U7fr8N?=
 =?us-ascii?Q?4FcB99S6sfxc0fcQ3ghSxpalPmg+iGWjFyL44e8irsgCKQB//pbxjsMdvkVX?=
 =?us-ascii?Q?f8/p7qkLTf5j3UTJqwRQndQ3rWrV/obU/YXiKhrzfl5plymNR4HsJu9SM8oN?=
 =?us-ascii?Q?6HMOfvjRjV8jCKESwA0je4ZW7yzTygryEjk0wjp+6tp6BlSsEvwOLLYCSM5t?=
 =?us-ascii?Q?szZBKR/nV2ETj5QMz+VSzPD/HPdavM7hPtW97+6EV0sdyPjb0AYBsKqL3yBL?=
 =?us-ascii?Q?4/pU+Bfq3335xL1A2jUEucbuucTYD2UFakdfFoZANybaoeMlqCYMyf6ZTdRR?=
 =?us-ascii?Q?aucOqOsCTPIu8YZ2ZiFCLrLGIUCD9sRFfKM6CpAiW8xBqR/NeU7Epw8+uZq0?=
 =?us-ascii?Q?vBnnmPEZEXSTeGYTY9z1kdEqglvG4C6tr3pVwuB3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahSIY4Ky/cqSAlzTR+4lSuLP6swHlFQrX9nqWr3NM+2SebNz+4DKhwcEJT1n?=
 =?us-ascii?Q?bvTEFF9a8dw8HgzUalwBA0GCrVp6sNYcy48pwXprizFVHy3v07JlLf/nuHU3?=
 =?us-ascii?Q?dIXjlUw8HIWbQJok1x1Ij8tfPWkv/Mi7cAdxt/P4wDYD3Y4IBEV+5CZrBs2f?=
 =?us-ascii?Q?7YQxt60ss+Kq2u7LazS2uKrnQSIovtkjbH8DkxAfsVJvI4f9cDUIbrXnwX9l?=
 =?us-ascii?Q?zwnKy7l64PM6+04I2UEyY6/0M8kRHTZHU+5s1jMU/K/WsAJzSDJOTcW3Po6J?=
 =?us-ascii?Q?dR6T9S8nPeXrE/iPA8xJvtEy/r5yV9oVZV7+O7uZaAmydTiq/wiVu9lCzMo5?=
 =?us-ascii?Q?IrllOed7q3T6uq64DM+wemaithEzb/fWRLffTXfvfoozEzg6Dp9UAdUr2F9G?=
 =?us-ascii?Q?cjfgp0JxJl9CkxhMmUz9eeZAoZRILdJ7U/66OxMnfjdfv7h2GYXLIv+uHaGT?=
 =?us-ascii?Q?0xKVr3kJNWF/+xxkba7vsNfdFhZIKrgwkqjpK9BtVYg+DEEnGQJQkm3g7TAY?=
 =?us-ascii?Q?SDwN7m3lSW+rGlR8emFAPOMOK0eGuRN//f9XnLFlY0/KjBOT3BpjAjf29cXH?=
 =?us-ascii?Q?brXE5o+okyYcPso/11x2o6UogoM/h45X6G6L1m6yVKpNLbHUDeknfBEMCZ9U?=
 =?us-ascii?Q?2Vh7F/utd5MWMObeK9P0nXhk5Re8QwTCsiJMit7xbnPwLOL/CZiErIR4BtkV?=
 =?us-ascii?Q?YiMgfhMvWapPb4UKNQ2vvamXcmk0xuO0NGK11UuxRLZTdlQqtytRuX5aR1jd?=
 =?us-ascii?Q?CegduFcQt+CkVy8WfEI+mYkUzFn6/YyYPJpmv1h9mMVDeBLM44dN/15UZt8G?=
 =?us-ascii?Q?x7YyEtyfI/RKZba+KaiDkKvqrNI8tNQDnSHvUif8TIB7G/3TZEGkOeyCHHcr?=
 =?us-ascii?Q?DFzahY7q2eTq6yyqamA+lByz2A9rQ/emrd7//HE2A9Soda7Ldie/IXtt86++?=
 =?us-ascii?Q?3PjOtaAD/nEC53tRRrKzoHOQD1VvLAB3jYCuL88wXa95waNSDJZ09I7Nz0XZ?=
 =?us-ascii?Q?kus0s9C1dz5ubT7J3gAt1fN5sfXcUQ0iKAQf2ztaYlJfIgJ/Gnw+XUmPPyHC?=
 =?us-ascii?Q?khkVBjNCnEkpCpDLfNuGytCvEIBsL6QZWtex3XF1B/MxSKI03wvUgXKQKV2N?=
 =?us-ascii?Q?/Ivp2v6M0BXhSsGTxTcBjjWK5MTLqRoXU5veHKKXm7lrM0kFK8KkCNs/J8Jc?=
 =?us-ascii?Q?eWJec66dWItzuUYDC8xAI+gKe9k+UbAKP5B1WQ6nP/ktyyq00WP/Jk0y5zt2?=
 =?us-ascii?Q?QgY9sgyARyA+q2C6JdfR07ezojx/CmwvwFhhSe1AfKp8HM1Wl5vrmtf3to+W?=
 =?us-ascii?Q?63jAcokJNhhCiV+uwcW4uO2KcafU0KK2ciJdxf4ZFVhkTIDr1FMwKPgNO5iJ?=
 =?us-ascii?Q?rbt0L8QgYizJzBDLhs6AMMcCWEttBnRid1Str/Vt3jeXdqckZkjLzLMNI2bv?=
 =?us-ascii?Q?QoQFn8zaolxTolNa346BWR2Av+ALl62kP4xpSEpdRpQacA8aabQwPz4eFfEt?=
 =?us-ascii?Q?kDqnzhW9Om26F2+ai2tZtfL6ccGFE9Jy+EH6G9fG22zbEXWReerHBuTgrrZl?=
 =?us-ascii?Q?wuSpUpYdstvpeCjcO2HKbGfNBUBKWgi6kflAaibss2PpGb3JVDgTndWIuYZd?=
 =?us-ascii?Q?+b586sTu1bPOjGMgyE3bJahooZRMZ0HfrLvv11Knf+OQP9tNrTdsJowop2y4?=
 =?us-ascii?Q?Ohn3MHEDsSRu10L48075Zd+bWgTcFEN4xssMpjdBynXhF+d73OVZqbEVsofJ?=
 =?us-ascii?Q?0uhb7veBTk1mRhMDqejfOZq8fxKUls7IvBHdMQ1MaLvMxt0uLcjP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b03c0299-3d49-4779-e6c5-08de65a4ebca
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:53.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw4ZrRCGKO74vSvBr4iSZHhxZHWTodwugFrhU/xtGp36DFM475CfzF60oPz5Badj4W2fLmsD0zd7PSH9uVXLXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8788-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 43D95100F13
X-Rspamd-Action: no action

Hi,

Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
instance alongside the PCIe controller. In remote eDMA use cases, the
host needs access to the eDMA register block and the per-channel
linked-list (LL) regions via PCIe BARs, while the endpoint may still
boot with a standard EP configuration (and may also use dw-edma locally).

This series provides the following building blocks:

  * dmaengine:

    1. Add dw-edma-specific per-channel interrupt routing control via
       dma_slave_config.peripheral_config.
       => Patch 01/09

    2. Add interrupt emulation handling and expose per-channel channel info
       (IRQ number and doorbell register offset) via a new
       dw_edma_chan_info() helper, which will be used by Patch 06.
       => Patch 02/09 - 03/09

  * pci/endpoint:

    1. Add a generic remote resource enumeration API
       (pci_epc_get_remote_resources()) for EPF drivers to discover
       controller-owned resources that can be mapped into BAR space (e.g.
       an integrated DMA MMIO window and per-channel LL regions metadata).
       => Patch 04/09 - 06/09

    2. Add an embedded doorbell test variant and host/kselftest support
       for it.
       => Patch 07/09 - 09/09

This series evolved out of:
https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/


Kernel base
===========

Patches 1-9 cleanly apply to pci.git 'controller/dwc':
Commit 43d324eeb08c ("PCI: dwc: Fix missing iATU setup when ECAM is enabled")

If preferred, I can split the series into two.


Tested on
=========

I tested the new doorbell test variant, 'embedded', on R-Car Spider boards.

  #  RUN           pcie_ep_doorbell.embedded.DOORBELL_TEST ...
  #            OK  pcie_ep_doorbell.embedded.DOORBELL_TEST
  ok 2 pcie_ep_doorbell.embedded.DOORBELL_TEST

(Note: for the test to pass on R-Car Spider, one of the following was required:
  - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
  - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)


Changelog
=========

* v3->v4 changes:
  - Drop dma_slave_caps.hw_id and the dmaengine selfirq callback
    registration API. Instead, add a dw-edma specific dw_edma_chan_info()
    helper and extend the EPC remote resource metadata accordingly.
  - Add explicit acking for eDMA interrupt emulation and adjust the
    dw-edma IRQ path for embedded-doorbell usage.
  - Replace the previous EPC API smoke test with an embedded doorbell
    test variant (pci-epf-test + pci_endpoint_test/selftests).
  - Rebase onto pci.git controller/dwc commit 43d324eeb08c.

* v2->v3 changes:
  - Replace DWC-specific helpers with a generic EPC remote resource query API.
  - Add pci-epf-test smoke test and host/kselftest support for the new API.
  - Drop the dw-edma-specific notify-only channel and polling approach
    ([PATCH v2 4/7] and [PATCH v2 5/7]), and rework notification handling
    around a generic dmaengine_(un)register_selfirq() API implemented
    by dw-edma.

* v1->v2 changes:
  - Combine the two previously posted series into a single set (per Frank's
    suggestion). Order dmaengine/dw-edma patches first so hw_id support
    lands before the PCI LL-region helper, which assumes
    dma_slave_caps.hw_id availability.

v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/

Thanks for reviewing,

Many thanks to Frank for the continued review and constructive feedback
throughout the development of this series.


Koichiro Den (9):
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Deassert emulated interrupts in the IRQ handler
  dmaengine: dw-edma: Export per-channel IRQ and doorbell register
    offset
  PCI: endpoint: Add remote resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Report integrated eDMA resources via EPC remote-resource
    API
  PCI: endpoint: pci-epf-test: Add embedded doorbell variant
  misc: pci_endpoint_test: Allow selecting embedded doorbell
  selftests: pci_endpoint: Exercise MSI and embedded doorbell

 drivers/dma/dw-edma/dw-edma-core.c            | 116 ++++++++++-
 drivers/dma/dw-edma/dw-edma-core.h            |  38 ++++
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  44 +++-
 drivers/misc/pci_endpoint_test.c              |  11 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  85 ++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 193 +++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c           |  41 ++++
 include/linux/dma/edma.h                      |  48 +++++
 include/linux/pci-epc.h                       |  46 +++++
 .../pci_endpoint/pci_endpoint_test.c          |  17 +-
 12 files changed, 621 insertions(+), 24 deletions(-)

-- 
2.51.0


