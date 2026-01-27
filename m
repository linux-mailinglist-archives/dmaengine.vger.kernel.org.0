Return-Path: <dmaengine+bounces-8519-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBYQO3QyeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8519-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:35:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D88F9D1
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E1E302BE9B
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2741321255A;
	Tue, 27 Jan 2026 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QSey+6NO"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021079.outbound.protection.outlook.com [52.101.125.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC230BF64;
	Tue, 27 Jan 2026 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484887; cv=fail; b=mn3oRRM0/fgdZpORFzX8LKfSLzel2Iv1b8NZ4YbsqnqldHEiidG9qFGd7zrGdkAZRufBJb6TsBLtdqMHtF/KmBkn2ryp4I00hub/NDmdiQogneoNWSYDjWceBBI9Y/8pT594giZrf0ZPQfcVwImnlYczNOySCFq/+7BXHzDg5ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484887; c=relaxed/simple;
	bh=mEabbj8MoIPDGoD9NrIEynQb9bU4U1A6wec7bOR+j4g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P/hsnoxaCbbdkBLG+IJrjSSv9hWzslal7DsY+6CJfBHZj4kenniPf/0AvlGk5IW9WOJ7rrDfx6hRIxPcZJ4/RhjeoEAfs1mr+tYqyb8985IBwGgB0JezFH0BNlYM0w/ekCrv3UTDTlJ/8FGugeLbe7p4aLsENxsCtmcoRzh7c30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QSey+6NO; arc=fail smtp.client-ip=52.101.125.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9mCPWWVeDLBmo4mYx3atJVjYFYDB6ZKq+w+0Q9Iei9LSJPoUah3Mop6lTaEOI9Fav0bpVzg974vPQHgcFo9H3ESaddBpBrTOYZ8CxdbAhgmnQM2JC5U4CNI+oY5dLLcBH47iraaaubBkF87RIPuERAH2VkPwOlxmu9Q/yT5Ml/SeGMBu/h/6+Lsn3VlTQCUK85ndgNMNpb4c01FIgnGzYPxmkPyD2hxj1g4P0CwbmUMxHkuteUyWg1tRMjBtWSm+VKEThlEcCYsz6BQ85yt2SWYDEiSmy+HdjXnTtKD2xfzKoXrUuqm47CUBfT93BoZrAOwQPJgc5Maq8jAEEOteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HePlWgLBk/DyFuO+97FG5F+FdgSBoBy/Cg1AgV9ISZk=;
 b=VovsGxuuc6iPho4n3enqTRcfrwIMhU1XpUAysoaVMLW3mtIRKry5vPiPv0V5AFlqUwByNRmCa9yUfOykcIyXJLVUWl+TqJLQP8t4n5vVPiCtJp8PHubHTs3nWt5TH7Rs7UW2YF5whljPTtNUGjySq05/VDxLqUDQztitoN8Vci4ncumEh7K1gwhUln/jn/aTVE+GjXIXXoE+goupITXUuCdC5JPTI6rx2Vjwk0GiOii4kAecJ8w7OqF1teDgLdWARfDAMZDyYnkwEzUtObw4Ywxm3SI1khptFCRAjfyqZQKQjwRgLWL40TPaykLr0LYqZ9PEnDKAYRrSAtbef3Vp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HePlWgLBk/DyFuO+97FG5F+FdgSBoBy/Cg1AgV9ISZk=;
 b=QSey+6NO1LzK9Be90qHyzwwSqouMVsaz1hSea7NDPdNZ7n1eLyBE6e3+3rRfugoAuRRdy8nYWAAzVRjhO7trO+CtUJpFXNlS01tyK1qZwMWMxYHCqCf3bYT/3Hi8ugzS70jQnN66uVlANo9OicbBgbYwH7m5m47MMrtObS2l7Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:39 +0000
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
Subject: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use of integrated DesignWare eDMA
Date: Tue, 27 Jan 2026 12:34:13 +0900
Message-ID: <20260127033420.3460579-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd9a885-79ec-41cf-6e8f-08de5d55009e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TJx+sjim7jWgaf8n62UY2pCefz3LyFdwuFAiyjeLURxTbMzXguICJdKImBgX?=
 =?us-ascii?Q?DxXfRn7gJLRjqtDsXpzhllflH9bFfpW/tgMMjsuJWk1doQ+dCvFRgvXLQmE1?=
 =?us-ascii?Q?TDZjKQtF6e0/FSI+eo6vqFj598Nq8qj5OZOpfqieG4bFpz28VcvQBprjU6NK?=
 =?us-ascii?Q?VpF9SyRcVB0S8HILGk7bT1xPWoOMDYLQer8ZD82esG373gfcSVW5yev2U70W?=
 =?us-ascii?Q?Yik8MxQFI7R9KxVH5Pa/6HcTebgoM4CNKEypu5IXdia3rnzGoPZoSgDQhbaN?=
 =?us-ascii?Q?+gDkKDNOR28DFMGPOrYjMyLMLgXOLADknuBBL8kOnoEuOyMaIrRIxlWIFYnL?=
 =?us-ascii?Q?Tb6MS4l0ST0IXxd8dVMqbPztE6+kKD06gK5XSpOLZJVbx0jXnLwpEIuHLV6A?=
 =?us-ascii?Q?Ucy0egGaKLGxHjP7gsClkK6JmtRyPhe1ro8d1hCiyc2Ov5YZ2GfxeOk1JYS5?=
 =?us-ascii?Q?X/T+i275EiBv3jRVSMQgLpI7QqzXvigMKHa3MDcz5DguOr/zrP3aZ/lenbCn?=
 =?us-ascii?Q?R6If10UwveJsz366s47rWFgynmlbjbXtp+cmyQL888U242O+HKD65BxVW3oN?=
 =?us-ascii?Q?jHaqsDLPBVYTg4gqZUBDM36GO1zu+MuYc/1AXvtRA/QxM6B6A7640DfS3Qzw?=
 =?us-ascii?Q?5o3HLpjL45qldKUL2DBCXf20wuDTYDRigfU4wijFo6GcD2zBfDSpn+HL0K4a?=
 =?us-ascii?Q?NCPiQ45AqvwfwMkT8JM9FlCHYIL9L31U8oWcLp+UUixvVhc2W9T86uvLODA6?=
 =?us-ascii?Q?azsOOPzbRJsEgIfcKGGDfqhO4M+vinNeitOZjX6LC50eBaMLJEDKxEKVJkXB?=
 =?us-ascii?Q?ZMxaGLw8t0DDh7jNSaAjvH021D3Wdop97m5JIfELuGyG0ftGQpB09UOLDkxL?=
 =?us-ascii?Q?mDDiADbqpspQ+3GNwV2dX3DsIOJPT5+BjzTEjMEz3VV7ll6ZgPwc2ChuIO/r?=
 =?us-ascii?Q?7YlckYDXJhe5tGuqq4Kpx9a5xUms6sFcRsNnAOm7SduDNrg4iyoCMQdAF3VO?=
 =?us-ascii?Q?2xUvOJjOnTRNaLqCVvFcNwQr9fGJChJSxuHagHY894AtGi0Z3i5NKkY+Zv/0?=
 =?us-ascii?Q?sffe7tedZ/8fG+hKlOaQeW9ZODSkhCqNCHCsnREf6iEohSy9xYmIok4cPk9y?=
 =?us-ascii?Q?TwB0WkKTRANXzzyMRGBuBENapYJjgDoP3TKFdPCe/RoI9hh+Zg6zYMKvPLRW?=
 =?us-ascii?Q?Ju5kjIUkEHToxw50kxQjUxUrSOq4d1sMWSDpi0kwFuWDpfyblno3A9u+0+tq?=
 =?us-ascii?Q?kdbm+VL3YOzt2gODZ0wUshofQyxf5OgmEYIuACryl7pcZxy//tflO7U8EMIR?=
 =?us-ascii?Q?clgmOmr+DgPshfJEiV3DqWtYjFNB1yGOjxwUEBlLJ0PWfvDYnxYEnbOD7oGZ?=
 =?us-ascii?Q?yRQgPKJObRosWu+kPpVoJJaWTl8TPILc8DIvqEqVnfpAlSmoCxjF2rg8url1?=
 =?us-ascii?Q?t2fwzGItMsJn5lNAX7lnJ1DVe0xnsPxug5jhNixZdq4Ct8Gk+EwE2t+leb6S?=
 =?us-ascii?Q?e5tIlxH/P7BBI+O/XFv/tVOvmaQ3rJAwvTmDi+XZcaNma8oA08qUp7iJNzML?=
 =?us-ascii?Q?9EA00yI9UHVQ2VDNTs8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pPJpc/RC2xwGeMdCZUo+rOdv4US7Ic3Kb9+IgP8sEiK57GBc82g2SW6mez6?=
 =?us-ascii?Q?UkZ/BYr1I/r1DB+A1GUrxu6MlqRG437AWClnJWmuPwPxUL2xm0L1ZgFG/KY2?=
 =?us-ascii?Q?cXdaEkz9fNriDJ+cS9fsc4wdDL3bKLpt1nyt8GtGBPKgND3OsnK1LB7qmucQ?=
 =?us-ascii?Q?QptqJ6EycU4JAMFQZOHApaw7N54ybgl/jxYMqF2KxZSFQvhYM7szYMsjTfvh?=
 =?us-ascii?Q?mAIAaVUtLYJ1l+qIKHBmbZB/qKZ7vuH1SxtFdZu9tDXi2qhtMvkmRqM/5OzS?=
 =?us-ascii?Q?1ZxuhiVfniyoHQ7bzo3A5a/2klZbH4Ck5HGsznO0gX/a5d3yBNssKnimc15D?=
 =?us-ascii?Q?nkKStrPdrjTU6P/p8SswY0HFQA1OoPIhtQRF2EaoEwEy8AV/pQ2Q+lxJ8mz1?=
 =?us-ascii?Q?g84Ib/o9k6HIKJFLdSAk6kJDGDMss4HiSfdakCBuRN2QOT6rBR/l564aAUUr?=
 =?us-ascii?Q?sp/MhBesf+2pnowZyzh1kcr8cgDQX6nRqhma8FZw+gaWWLwXG3+u07sI78/Z?=
 =?us-ascii?Q?NcaaW4JkKlFIRkUGmyslUMEAYpSyJIAdWBUINF2g6sfEuVbNq5tGxS5sCbRQ?=
 =?us-ascii?Q?h0Ky5tUHxCXGGWRULfsUk0t2B0rZsrmAbVn3Yzx6D0VxKSbXIaghikOtwIvs?=
 =?us-ascii?Q?UmFQLW3vCGq9Im6Wn1apNu8P1wCeD/4i62rhJsxQ3W/20EhIab9LQJXByw0n?=
 =?us-ascii?Q?AwZxVZhyfNaKuORH2FFUBEbDEATNVb22ZEG7W3jEtlrinSMmBT15bJR5m8An?=
 =?us-ascii?Q?QBYIPT1p2V768NwyFDGanyLjrEsy3HJf1bdxgRZaGRtIddeeN+pajB9P7ZYI?=
 =?us-ascii?Q?rVqSKKthUzG7Kl1qjqp0kkoSoqQQ2+jWUYg+BDsxUH5P5IGpjG/gsun63P08?=
 =?us-ascii?Q?5mRkx8e9nAkTkwc5pigSZ3kmJOiXmAZSnkaOPDzLlDpsu1Z0NMbl5P8HyZtr?=
 =?us-ascii?Q?n4Ib/mRAhgQpq3yCWDaiURYFp2oiua6fz8/z5qFMyzLtftzA+G9M93YhpWjQ?=
 =?us-ascii?Q?5W61S49JqFa8H1EPS5ByBBw6R4zwGLTl7CyooWC3xt4ThHzG6uG1r9/o3ss/?=
 =?us-ascii?Q?lqD7TGe/kDH8iT7zr/MJxSx1zRKw/79b0++8BCniCRiERzZnMwqL+e1zP+ls?=
 =?us-ascii?Q?WK1uZGMa3rc7CK0IHS8NugGk2O4wNu5O5a5CQ2Tu3zHQckoWrih2QutqbzCl?=
 =?us-ascii?Q?OeXFYyfx0TaUFFLtb3pMP1EPU4JVFVIC55VQjJPZH+CaSx7OWtXwbMc4aQf1?=
 =?us-ascii?Q?LBhUUaIBrF0Gy/zcIqT/RBYRalJNm6g6uMb6XjSF7RCdgfp0KDqidCjDvXeD?=
 =?us-ascii?Q?GJcikSPA7XTsLXehM1uauTpf3cTjzCCVMS1mNg7kyvdU4Grro2uOo1wAF6MD?=
 =?us-ascii?Q?wFtFqiOD1hlMAPIOQKVCLb14Hwzep063eCKP2PRNs7nQUtk8nvz+PqOlWqEZ?=
 =?us-ascii?Q?ndxC0DkihCol7I8IrXdOBvKdfvKbWUF93PlKc6zzZroEB2vu4ord34IbltPT?=
 =?us-ascii?Q?r9q/fXBycSwenqWpk0tTF5dnVi3xqzO8vcxq8Hf1yvc+KKxEujzN9lE3H0yO?=
 =?us-ascii?Q?t+IyvbQ6MVlpQaWC7JliSpvqvCHvPkaG7C9cgXIBmlqfXJM7nl+ktViNQBZT?=
 =?us-ascii?Q?qmhHbbhAMfB1RErmRedJinBSBGjJBr4GjvrF9ENUZy5XRYUmH3Yq6ExxRUt+?=
 =?us-ascii?Q?rQNO5b+3rS0YSHDPSR54o3WrHp9fe4ezqruEoJgekX4yBrlngqVL55+T9xa0?=
 =?us-ascii?Q?1ENjV6CdY9kdve7Diowkpha5TdYeD8x37Vh8+5DQH4tG7GClEd6F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd9a885-79ec-41cf-6e8f-08de5d55009e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:39.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBXr/F8vMikKKMFj414lD5MBfFKbKJREH4FA3ectqv4Rm8igv8tvJnTd6IXjixH7jFBG4O3VTsOs29M7w5K5xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8519-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 761D88F9D1
X-Rspamd-Action: no action

Hi,

Per Frank Li's suggestion [1], this revision combines the previously posted
PCI/dwc helper series and the dmaengine/dw-edma series into a single
7-patch set. This series therefore supersedes the two earlier postings:

  - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
    https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
  - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/

[1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/

Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
instance alongside the PCIe controller. In remote eDMA use cases, the host
needs access to the eDMA register block and the per-channel linked-list
(LL) regions via PCIe BARs, while the endpoint may still boot with a
standard EP configuration (and may also use dw-edma locally).

This series provides the following building blocks:

  * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
    a provider-defined hardware channel identifier to clients, and report it
    from dw-edma. This allows users to correlate a DMA channel with
    hardware-specific resources such as per-channel LL regions.

  * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
      - per-channel interrupt routing control (configured via dmaengine_slave_config(),
        passing a small dw-edma-specific structure through
        dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
      - optional completion polling when local IRQ handling is disabled, and
      - notify-only channels for cases where the local side needs interrupt
	notification without cookie-based accounting (i.e. its peer
	prepares and submits the descriptors), useful when host-to-endpoint
	interrupt delivery is difficult or unavailable without it.

  * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
    DesignWare eDMA instance:
      - the physical base/size of the eDMA register window, and
      - the per-channel LL region base/size, keyed by transfer direction and
        the hardware channel identifier (hw_id).

The first real user will likely be the DesignWare backend in the NTB transport work:

  [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
  https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/

    (Note: the implementation in this series has been updated since that
    RFC v4, so the RFC series will also need some adjustments. I have an
    updated RFC series locally and can post an RFC v5 if that would help
    review/testing.)

Apply/merge notes:
  - Patches 1-5 apply cleanly on dmaengine.git next.
  - Patches 6-7 apply cleanly on pci.git controller/dwc.

Changes in v2:
  - Combine the two previously posted series into a single set (per Frank's
    suggestion). Order dmaengine/dw-edma patches first so hw_id support
    lands before the PCI LL-region helper, which assumes
    dma_slave_caps.hw_id availability.

Thanks for reviewing,


Koichiro Den (7):
  dmaengine: Add hw_id to dma_slave_caps
  dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Poll completion when local IRQ handling is
    disabled
  dmaengine: dw-edma: Add notify-only channels support
  PCI: dwc: Add helper to query integrated dw-edma register window
  PCI: dwc: Add helper to query integrated dw-edma linked-list region

 MAINTAINERS                                  |   2 +-
 drivers/dma/dmaengine.c                      |   1 +
 drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
 drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
 drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
 drivers/pci/controller/dwc/pcie-designware.h |   2 +
 include/linux/dma/edma.h                     |  57 +++++++
 include/linux/dmaengine.h                    |   2 +
 include/linux/pcie-dwc-edma.h                |  72 ++++++++
 10 files changed, 398 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/pcie-dwc-edma.h

-- 
2.51.0


