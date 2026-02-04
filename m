Return-Path: <dmaengine+bounces-8722-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDrCDo9ig2nAmAMAu9opvQ
	(envelope-from <dmaengine+bounces-8722-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:15:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE14E8336
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BDC3120442
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449441C30B;
	Wed,  4 Feb 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Xi9BHRDs"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD041B360;
	Wed,  4 Feb 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216893; cv=fail; b=fYpofzV3qg70AylVRdmrdRQaJ75xbPQyQV4fQKKBkbcsB3NpT6pXwsFPrVtYlQAAgRINkgZRZsS0UHxtk8xz3aCTeFVc+QBpoKB9zASMSDoh+m3+ByJhLRSZxUqWoZTFF5cGiAUDHBC3GvMJOkxn0nz+XIPq9WYHRIp5egYf4iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216893; c=relaxed/simple;
	bh=uSc8jnMw65UAwpppC9W3csYQ3j+MQiadZOubMSe18nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BvfrRW/prGnPngrp1Ha3EZ7oBMgUBRg9IdMZqIUiF3E719YlPqnwSElLng0f7+SceVceriMj3Yo11/iyTXDo9up3q9aPGdaDkCEUSTbEHm70pYfK1EHHIr44vOEGC5MtEBPCWecQhfAHggzMHyWHkihq0QEXwg6t330eysSj6i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Xi9BHRDs; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWZz+fqvWNbQwvfOImN6Ltj3LfwF3+Tv2bR2IdQ3t04pu7kX4S1frTMZ4Ca5em4+ycaCm31OtDN33NoMW7UzUj7i7f5Yx3K/Uc2wshaHRK48iumblAbZaRppz32uQL/tkd7U2GAUFyq8tW1pdMOc3IbLjHlWXYuJm3HNeG4Wq5kDcBUjj+93BMN/BVuhU8r2UGGM/bUYHWHxJSp6RL8KNCI3gMQiHqnhFoQzh+cnW6S8g/AcIzmQ37fiaXdiYgQx8AWWzmW3UFfu79O2gJGN6FAve+4ZhHGbmmO/t3fxVO+a2UGcPbFQwOoH41KZUFbHhXLi3mCjt0xmi1WQDiUg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAFRcYEfaAj6KIUNvh0SVEq4ul4PRBJTlxaztB5mKuI=;
 b=jEhRHuVoj73BbYuCb2QFWnAZQoGxGLnLMveCma0p+GShAh6pPZHJhQdqsn4gy+wjVULQd3DwJhdK6dbFAK1X1AuWGq01CwRqNjIpYG0b7LdFRHu5ddxA1ChZo9lpSvdTRqxMRayHzg5iYDPdACfS3nx8SWMevqRz4OLVev8PXI8Di+HgD/yNeFIGUG1Z8l6HpsodurHG8jE9+TQyz5pCdP6x7asxB9T2S5oP48GRayFx4gd+lHgSoxgzr4MkHN2etSQ054ypiZr9S9X8Z1zMo8wBaaqplsg6SNu3n3PBJqBO9KbTLArt0AUq0hYsDBtEkA+8szJ/NEzmj2gMEJmhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAFRcYEfaAj6KIUNvh0SVEq4ul4PRBJTlxaztB5mKuI=;
 b=Xi9BHRDsriumpn3Tpjryf3he9ZsI1N/h+yceNvnZBb8BSZXSdbmZ2VNHuo7vhg2PvvPR6zIhLC0kt/pekoY1oHfwtLZPT4TKkygL3Y2FLrtTxij+BrYEnhj/qIYFM8xAqB7a5tPn1SVK59M+1e82+dM3VB8I7PCQuaq5LKL2Gp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:50 +0000
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
Subject: [PATCH v3 04/11] dmaengine: Add selfirq callback registration API
Date: Wed,  4 Feb 2026 23:54:32 +0900
Message-ID: <20260204145440.950609-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ea5958-f592-4fc6-bb3f-08de63fd5913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTkO47YFNVjZzTXP1NNli8PhNwg6t9TkUSSR+Ps8u+EYnDLjcsIqQ0GcvvMO?=
 =?us-ascii?Q?PshRu5OVapHl3Kvix2s5B/cJ3kKLpWUWB14P8LWU9tO4Iz/L8wVYFOseHmbL?=
 =?us-ascii?Q?WR81QMdHXtSJdUH5n+9ezqYZEFHpvmiW9hbY8vxtc+DsL3bd0o8J/TDZ92H4?=
 =?us-ascii?Q?X5UO6+vEpFNWE+KeFUcO3glDh0MViUkQ4uQL+CvUE8IPOGg6iCVZGk69EMWt?=
 =?us-ascii?Q?jMEyvGFevFyIbcnx/hjG0+Sf7qq0LrSZXLtpIhBDyJkQJgoIh1Ujy83z+dkT?=
 =?us-ascii?Q?WOyUFZqBNUdA8Dj2cIGEQMEaDdSU4tjfz87OcDi0py71lcMrgiS5KQFxbrBD?=
 =?us-ascii?Q?ZZCBBdUR42v8RIFRHe5UwPTLDZqDpjuJYRdBeBV4YWblZ95RSuBZmZ55Hsuc?=
 =?us-ascii?Q?yQZrrYnlCxIz/eyJrQw5b90n4ThXFQdhcc0KtTlZx3TOVOulbz9W06INqyJg?=
 =?us-ascii?Q?SDaLx+zfAi1/9Hh2zMt4lu/92Hpi/HyeJvFts4zKZkOQ5oVrc9kfI0YUOlT/?=
 =?us-ascii?Q?t2j3GmzfVlsmr1K8oAWnMm8A12q5ZNv8LG4kEXvEmYiDx4Bvmn87wSs7pwjn?=
 =?us-ascii?Q?QNybXk5O3QfY9zdu079EoyenVIAFwkZiKmHjBpSHXLD7R1+modDbWz/bJK/c?=
 =?us-ascii?Q?SXJavNf8nQHmCdzDDhjduLgP9MXScx+zvzcZdXZ+GnK0D9pRFcP6AjUCHcpa?=
 =?us-ascii?Q?crB2u4cM18I4rpJCLUES2NBNRStyaDTuP8vHnODdTCMHcoGfpsTHHE4a2qIj?=
 =?us-ascii?Q?bwSR9Dw76LfLbe6HWtN8+EeB4atiRTVRZMQTLi+hkzJtSpvwHuTn26eOvTri?=
 =?us-ascii?Q?rpSSL+YmC2MMd1lsvywbOmfEem2qg8+P3l706ifZlWsn6Wx6LDahd1nKGOxN?=
 =?us-ascii?Q?c25bgLUiz0A0/NScfgqtXfy8DVS/ub7l001FH/Flat0P3F6nf69nL2qtng7o?=
 =?us-ascii?Q?9L7UE2uM62m4OXUjvtdGopLp0sTwcnnnot53vYXWhzRPcpbgBitTylbKV0oK?=
 =?us-ascii?Q?yvbSdF4rHMc013aKXKDNqhgBn7+DdqM3LvXxBCJ6qDC9Jbh43jED+Yd0D6y1?=
 =?us-ascii?Q?OQyOyEzzIXfob4V6ajieWjMr9ar9aik2MVJqGa0nwktzD1TZrbJDS5vRUxIX?=
 =?us-ascii?Q?P1noO1I8FnzjMicqpWeIOTihpwdL7osk1mQGLXzqO/6oHgHXke2ricetLtMa?=
 =?us-ascii?Q?W4t07R5vvMYOaeHW1ZbhN/lJv/5Qx6R2K1KlmfPbiFCRopVfyCOv+1AU9s8g?=
 =?us-ascii?Q?m3AtMmsv5o/7s+P1936s8Q3tK/o4xIrm8JH4Qguv/9R5xyhB3K02Anb9O/fa?=
 =?us-ascii?Q?dwcQ0lD4EBAtflUwKqmczeTieY8qRrbabw9I8GcYxK6FEcyzwORa0gPPkFgy?=
 =?us-ascii?Q?zvXrCnJONHgXv583Y9nND9djJNzMOdpDTKIpAZYjqcs2gebsznx4Al6Z5bs5?=
 =?us-ascii?Q?DWMWjJHJdvapl+/09VdpMdedrpaEW+WiC5keETfFijF8M02mWZjmW2xPpkBL?=
 =?us-ascii?Q?msT4GUsbBlGd0zvdE7e18iC5/VDgnF00ZNzgC0fdGI5dtAYrIrkw/TBJ2H5w?=
 =?us-ascii?Q?pyX9lmFMBFgYb9WvyG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aePWy4BbkxYMuCRaiMUKXqaXGGX6Zxx1HP2d52+l+g8QIkaQCXiXlzFM0XiR?=
 =?us-ascii?Q?yb1UiYC3cytKxfUfn7D/3GZ1Hb/0GhWJ30PYuIDSQi2JpYZRg6g9vBj+TU/Q?=
 =?us-ascii?Q?OGk9Xcf3gUQD260J3NuyZ1VCEAfeE2jh7PHRkwDB2eRJsMRyFv6XKV+jU2XT?=
 =?us-ascii?Q?bLuTE+C36J15tWTc5fUTwEKvst6SmlV4R4tzElkOLew7+n8nwo56Qdkpjxcp?=
 =?us-ascii?Q?E8Hcd4J5UBYjHjK0EWuGN7YqM/urkzoYYZiPlSfcvzFiwL5QVbeEG8ngLmpo?=
 =?us-ascii?Q?rZGHjex7QvfXSGssRO87DjxmRMCky+BYBeiVw0uQa7qX5ZI8z4hrVsoUpi20?=
 =?us-ascii?Q?BgZE7ZlZJdu6WzocchWxn7sUo9I1GL8npLYBE9m1g2vauFn175xu/KZzAweQ?=
 =?us-ascii?Q?8/aGLnUljIXcYWO07t4fqR6GpWcoROb7rWlFnpEuC3Re0/MWFsdfq3VVtuMK?=
 =?us-ascii?Q?mVqZVaok9k+D7hsgvujDdY7X4N/MfT0LuiBhK5C507EO91fOvN9KqPGM9h+e?=
 =?us-ascii?Q?nqxWEY9x0S/1fJZZ0Z1yTtplsBQWF32q2jA2kjcAEp6+QhjlMsFZ/QWwlEXb?=
 =?us-ascii?Q?DO1aWt9i6LzotyG6u2vZEjvgk/qhsELK2X+oKHDX+q52tEDFbWcN8VZMitTO?=
 =?us-ascii?Q?nBkC0kALSaVzbMdapWCLGe9xqC9i81uwdb+zUlW0BszPWcaQ9tGIMQZqEKiR?=
 =?us-ascii?Q?7sOkSd1Y6J872mS1xdqi9Wu32Apr1GRXtGYgjHudos8mWe+GuamdfgdBOjYe?=
 =?us-ascii?Q?t8D4Cx+6JbMXQj5/g62bvnGRgu81mOxwybU8C6CKT0FX4uULEt2XYte1t69j?=
 =?us-ascii?Q?ZrFBVMG+tvFNGUZzY6acpku4i6Pe+2rJobJrPY9YRD4n9IRlv742p0xywOZ+?=
 =?us-ascii?Q?i9uDAWNd9b9tyuZ3J18t1GP4a9K9lhreeTu7ZZecHls2cUdO3/NRC8CKCqPU?=
 =?us-ascii?Q?v1xeL1L1BT7/dB5h4+IBVytRHEugRFaT/cDuCbrkNWzAr9tfWrIZ8M+yzmVk?=
 =?us-ascii?Q?Yfgobhx0Zt6wf6merSku1BsWeKyiPZZ+2Rf8EoxBskUAgP65XHKbh/Tur5NO?=
 =?us-ascii?Q?AEyaaZQlmhij3CayqZ/9NhC0sYdyzig5S9uRWIqun3QZYIwKJ0ZvLnngVgLC?=
 =?us-ascii?Q?dldgU2PqT6D0XTMXER+ZtyR2jK8rFTBrNvJ0/M4FnvAiQx50Xf7Sb/H1Ga7e?=
 =?us-ascii?Q?KdYcZfZPS1ga55fNM4Z1jpW76sfPL9qbP4/D0bTmTecOd9RlAdlsAV4lpf5S?=
 =?us-ascii?Q?O14hskLU35nJT8mH6CkAIWQayeVuUqtbd+xVGhW10Nl3fov50Y1f7L1AZabv?=
 =?us-ascii?Q?Eq4C53zDYOVzhUpXnEs/RkXl5nVBHD9TiP/9QUOQuq+Z3xM+htuMUAYLd+86?=
 =?us-ascii?Q?WNjKfk6HKpGTLmhAXGql4y6g5Hu0+32remlpSjdrjJArPNOqzmjyVIzS5aoI?=
 =?us-ascii?Q?XdcG3jqhxc52mqO8fy6f46vXFesOOn9QfSNUdHTbsan5JXTwr4fypUWRJ2hs?=
 =?us-ascii?Q?vqNdS75oX9xb5rDC0Em/0y+lEgAT67Ihpoj3x1x0IqfDDw8LMZKBPI/paXB/?=
 =?us-ascii?Q?FRRibhJun7DzSA7GhiEw53CzczqkEyTGTF1GdyT06PLGtHivczpZEPxtpSVs?=
 =?us-ascii?Q?a97G7teitK+1Dr5LTMPzl6/hdXpgPdkL+aiBgCyBvsST9pJwz6EUlWnBKS0x?=
 =?us-ascii?Q?QsBgu/9pL0355qKUOFoMzboJWzSis+8IR/aNVReBxSH+w8owvNmlzOIKFOlh?=
 =?us-ascii?Q?cNOlt8TIfBrP6414mI8tdXZmUzn7kVVaRPTubDlxMl5M+OWfJiQv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ea5958-f592-4fc6-bb3f-08de63fd5913
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:50.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+9GndvR62icB/g7YoDUE31yxRJK+gH6zxUyfgL2wzYeiiKvyK9sFqVjDsLTgo8I5GWG5I3zlEpC46TftLBHoA==
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
	TAGGED_FROM(0.00)[bounces-8722-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: CFE14E8336
X-Rspamd-Action: no action

Some DMA controllers can generate an interrupt by software writing to a
register, without updating the normal interrupt status bits. This can be
used as a doorbell mechanism when the DMA engine is remotely programmed,
or for self-tests.

Add an optional per-DMA-device API to register/unregister callbacks for
such "selfirq" events. Providers may invoke these callbacks from their
interrupt handler when they detect an emulated interrupt.

Callbacks are invoked in hardirq context and must not sleep.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/dmaengine.h | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 71bc2674567f..9c6194e8bfe1 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -785,6 +785,17 @@ struct dma_filter {
 	const struct dma_slave_map *map;
 };
 
+/**
+ * dma_selfirq_fn - callback for emulated/self IRQ events
+ * @dev: DMA device invoking the callback
+ * @data: opaque pointer provided at registration time
+ *
+ * Providers may invoke this callback from their interrupt handler when an
+ * emulated interrupt ("selfirq") might have occurred. The callback runs in
+ * hardirq context and must not sleep.
+ */
+typedef void (*dma_selfirq_fn)(struct dma_device *dev, void *data);
+
 /**
  * struct dma_device - info on the entity supplying DMA services
  * @ref: reference is taken and put every time a channel is allocated or freed
@@ -853,6 +864,10 @@ struct dma_filter {
  *	or an error code
  * @device_synchronize: Synchronizes the termination of a transfers to the
  *  current context.
+ * @device_register_selfirq: optional callback registration for
+ *	emulated/self IRQ events
+ * @device_unregister_selfirq: unregister previously registered selfirq
+ *	callback
  * @device_tx_status: poll for transaction completion, the optional
  *	txstate parameter can be supplied with a pointer to get a
  *	struct with auxiliary transfer status information, otherwise the call
@@ -951,6 +966,11 @@ struct dma_device {
 	int (*device_terminate_all)(struct dma_chan *chan);
 	void (*device_synchronize)(struct dma_chan *chan);
 
+	int (*device_register_selfirq)(struct dma_device *dev,
+				       dma_selfirq_fn fn, void *data);
+	void (*device_unregister_selfirq)(struct dma_device *dev,
+					  dma_selfirq_fn fn, void *data);
+
 	enum dma_status (*device_tx_status)(struct dma_chan *chan,
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
@@ -1197,6 +1217,56 @@ static inline void dmaengine_synchronize(struct dma_chan *chan)
 		chan->device->device_synchronize(chan);
 }
 
+/**
+ * dmaengine_register_selfirq() - Register a callback for emulated/self IRQ
+ *                                events
+ * @dev: DMA device
+ * @fn: callback invoked from the provider's IRQ handler
+ * @data: opaque callback data
+ *
+ * Some DMA controllers can raise an interrupt by software writing to a
+ * register without updating normal status bits. Providers may call
+ * registered callbacks from their interrupt handler when such events may
+ * have occurred.
+ * Callbacks are invoked in hardirq context and must not sleep.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if unsupported, -EINVAL on bad args,
+ * or provider-specific -errno.
+ */
+static inline int dmaengine_register_selfirq(struct dma_device *dev,
+					     dma_selfirq_fn fn, void *data)
+{
+	if (!dev || !fn)
+		return -EINVAL;
+	if (!dev->device_register_selfirq)
+		return -EOPNOTSUPP;
+
+	return dev->device_register_selfirq(dev, fn, data);
+}
+
+/**
+ * dmaengine_unregister_selfirq() - Unregister a previously registered
+ *                                  selfirq callback
+ * @dev: DMA device
+ * @fn: callback pointer used at registration time
+ * @data: opaque pointer used at registration time
+ *
+ * Unregister a callback previously registered via
+ * dmaengine_register_selfirq(). Providers may synchronize against
+ * in-flight callbacks, therefore this function may sleep and must not be
+ * called from atomic context.
+ */
+static inline void dmaengine_unregister_selfirq(struct dma_device *dev,
+						dma_selfirq_fn fn, void *data)
+{
+	if (!dev || !fn)
+		return;
+	if (!dev->device_unregister_selfirq)
+		return;
+
+	dev->device_unregister_selfirq(dev, fn, data);
+}
+
 /**
  * dmaengine_terminate_sync() - Terminate all active DMA transfers
  * @chan: The channel for which to terminate the transfers
-- 
2.51.0


