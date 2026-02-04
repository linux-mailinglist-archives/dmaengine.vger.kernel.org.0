Return-Path: <dmaengine+bounces-8728-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCguFyReg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8728-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:56:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03316E79E5
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81F8F300AB29
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD019421A1D;
	Wed,  4 Feb 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Jn6U1G1c"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1A41C2E4;
	Wed,  4 Feb 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216896; cv=fail; b=c1wat4fQpYCEE2MgojszELMByf8wqxSdquFwSzD/4mI3/dZo1mxKqfR7/rUvMnJhnMPXD+kstWWsouIydl6xh8V2cYrq6DQKWtSceZIUSgJG2KtTH/qAGOZe7WOz67UpxCPGqxxPR/oAGMfondy0c6mkBOkAaL48+3PpirhWy3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216896; c=relaxed/simple;
	bh=R5MiSATiOdNADrOvbq5QQxH2pQyA1fxlMFiIgkM7M5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7T2Pa+UOuEQQd6drCy5m0R710bTBA3f5AyX6hYH1PkAvCTl28S1s0akIzMOTbOCamlrF/IzAUCNlTvgr9gSgr6Um/W3/k/yvi8UW77Wo0veKJUPt04T8pDrFvy3F7S3rLuTKHu7wwW26XoXmslbmjujsUSM0RN+d0jb8OiQt74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Jn6U1G1c; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6P3hgDxwJ2PFcwhC5av+CKf4z4uh1YZR/TthqyIUh7YIal9WLujnok9XdoJ7b7c1pOl6Ufjw2CwU8x3XLdLQCbfj5okgQD3w+24eQUBttYpPkLR/Yg+D/1z4c2OzNVZwGkUt+lmTgWrHrgjAIXWNDdEqdhaHqPQHd/QjB7ftMOFcd6Pnw51psIcxuzBme5RTaQxB616LiRunXVY2kvtXSKdsCeTGh8AoFmb3mQlh+q0t0jvJdvhEvILlpoGeToaxV4SFZFf/yeGlXKSEwc1FNf4NyCkaWso5uTmz3u7blf+3nsEq9vGTjJcRtYHGsNnB5cEbtN9Rj8fSds+Abv4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef8NXtk+m44u5rQTPZWKcDE8nwS4f+8NeY8fnMmfqXc=;
 b=FTA2mvZ0uSHVMOv59FQ5hltNVTw8E/Vs99W/tZ2uVuxDvvL8ssq4GAnCZezvLxlBxp6f7LW7dQ063BpO0mZBYjF7UuhYA/PhBzF/ADBlu7cpbKJoecUZQL1p0EvBc2WrU7qHdPglKZJer4cQ/Q/QdF1CQZBz7WbMnmUXWKPnXOhMF5Z0rv50JmXgufWwe8y6lRTthNbuc3Vjzi6vOBBQ8aB7iNkgfX4Sb6mLuvKRrQK5EO0pIKTYNdI0BZnpD15I9Xh2u4s2FyLW6aV/MRgLVq+1CEfNtxKlYYuEOC3A7Y8vRMeJst6Vttnhz8Ps5f0ff2NogKunWIqiTOAfnDgJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef8NXtk+m44u5rQTPZWKcDE8nwS4f+8NeY8fnMmfqXc=;
 b=Jn6U1G1cWquJPDpbj6vYlAjckzTuotGstQ2rY2SWmsfcyWyasfe48HRlgTHJiJshaUqdFwkAWLrORwuLsuQzE/6vtnqyWMo7o7fLJFuXpR0Xa+ZLBdhfXpuwKo/+z4n09uqKjI/MeGh6eaq+DP7UOCeQVEK/E8IWEmWNfXxpZjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:55 +0000
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
Subject: [PATCH v3 10/11] misc: pci_endpoint_test: Add EPC remote resource API test ioctl
Date: Wed,  4 Feb 2026 23:54:38 +0900
Message-ID: <20260204145440.950609-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 76369ee5-e8f7-40d2-6910-08de63fd5bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ln16DMXF4A9RbYIdImG3RTk+bdIXH28cMhkGvH6ch2bLQwIS6TlfOLlszvQI?=
 =?us-ascii?Q?DlwZIrUb3p76HHLWiuqIzlu++kdpfzQah+byi9X2pXd7bI4SlZe6P4vgARs9?=
 =?us-ascii?Q?v9MXdeCUAYWX4/fUhnMPUK0l/VOOeBc1O22KI43qTzCi8te+lCqwyPfxL+A8?=
 =?us-ascii?Q?dsfl1aUdu+BJ3Sx6KSmmCO+vQy83nnby559DDBExNZo5FYuolFfZsnh/+PUI?=
 =?us-ascii?Q?F8ZZnAZxG6Dh5H6UwAN5oV4jKi1UJoROXuOqF2SzdcweogBa3xnt0QmGHE5j?=
 =?us-ascii?Q?n1IFVBCCcIUbrn1VM4Nf3vYxW0pYiUHTKQhy5/VQrVzRihjjP5knK7spLWMp?=
 =?us-ascii?Q?GDzHMytPcwePG7z/MhQmiLhFC9udip7Cm/njDHRoA8q/qjsHm72GSxAmjZqR?=
 =?us-ascii?Q?KjLbDyZg8v6Zy2X5DD6y+Rsf8WvbbHCRPjnwBGvO8lReVa4If4m1+j6kxNjU?=
 =?us-ascii?Q?jpiEZ8EDOQw5AfnkcpUrNeaqQIB384MzFIhnjfLNuxLfvtOSH6kZ1tWOwg5a?=
 =?us-ascii?Q?b+xiwYUKnhbZNpTCOZM8mKb+pe13xcJbRzWiHDXkrgjbTARY5pzyERvPI7pA?=
 =?us-ascii?Q?Cde+eMzewbaayPMHGTyJcefCNZRMLLWVqvAiBasqFqmgLva8TLwrmCFVwlHM?=
 =?us-ascii?Q?8aB7xWn/CfSROrpZo5tBKQ1m6Pe9di5x3izw3AOneT3HUDhEJxT8N4obwsUl?=
 =?us-ascii?Q?iVzQoy4aZ+W6iFnQDnPOct1vbnuJc1qNa50CaqGSBHZiI6YNeH0T4NwKzc0g?=
 =?us-ascii?Q?Zrgewgx4BmmwpUGEqxwpKOW3F+k9vf+J2kANPiuuQM0kgJz9+hjs2djzUORC?=
 =?us-ascii?Q?fMsW4YfhfiY5KQMiPHoF6xmhONMGFMNVEmCmeFCRia8fULpzyrWYUxjmAfDr?=
 =?us-ascii?Q?CaGYr58MKITEBTprKACpBcvHTp2TOwCPBxAxFo657bbtIWEQWWuB6L4hUvEZ?=
 =?us-ascii?Q?/wqtZLWBnXd+Rn7GTuM5zuQlX0vewiCp1WIzKaAUe4ySK07rs/mvKhyKrrdQ?=
 =?us-ascii?Q?TvusyNW1t0MJ3cX/2eY9LXoFQp/DMTCspix5hJL/f275WFPeoedbpVn5CfqC?=
 =?us-ascii?Q?9u/0SJijN+iuTiTo4fSogv/8KH05tHQosY7LRcWAmxd4hsiT8N9s4u9HtDAR?=
 =?us-ascii?Q?eVQP+dYH5ENVLHKJQ2Wc3P7FIGJt8meWON+Ar4z2BIfxBvX5ugS7Sna35c6T?=
 =?us-ascii?Q?0tKnKjYfq+byUX3vZyKE7ps+eqP0dqX/PyrwfUr5jl8uzx9M8uWpdu7D9CAF?=
 =?us-ascii?Q?SvcwEDplW/jYNwGKm0uoPG+K9ExjpOQoDFLQyjhI9Pbqp22RbmZ3BnhPV9s+?=
 =?us-ascii?Q?UEbtcHyBPu6wMBi5USqZblmDlZHElPHiUIyEUv6H/1L9albZ1q47gSjrEPxZ?=
 =?us-ascii?Q?JCf8QVUqDhSufhMQGJ542EFvkUnnHadXke0wnWvBrY9zcl3aR4UNN1GM1Wuq?=
 =?us-ascii?Q?FvVqHoTeOCdhKAJ46p9lz13y7xsTQuqLT7yiS6z9E+wlVmYPl8y1Up3eq/hh?=
 =?us-ascii?Q?gLx6oli+M3ZQxss8U2mavBUBrH6jmoicXMLn3X0kVnXVzoiKQjmUgH3wWpM+?=
 =?us-ascii?Q?1HBCp5b8nOrds+C6O38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAvTZijYc8sOK4Lg0Yx3BU+755cSROIza0dbyox2Ap+GzzyVztH5Gdwz25rz?=
 =?us-ascii?Q?p9XCryGptwLVYtKwauSlWVhXQuuh7SrNHvZxnDgNW42VhD/LwRg9E19uL7LV?=
 =?us-ascii?Q?+YPcQM781WoPPu2FCe2MNrpTlbnqA+ITDpEhwd2xFAn+bifL/fSaVKAXxL4V?=
 =?us-ascii?Q?Fd9lpzxmF00oFMrGUMuSuJFRSlixyRjz2i7NNfyce+nSSdZxDqJRfY03yEoy?=
 =?us-ascii?Q?YRA4KBO8lTOKZN3HXARHCgOBrL4RFlJL1YZPhIlnR6aqdUUZPbKJV9pXKheU?=
 =?us-ascii?Q?VAaFYUKAnF+niZrHUmjNruE9YFiONXFyAoKd2uk8v2beJvUWC7G2DujQLz12?=
 =?us-ascii?Q?eC8IME4cJ5bmi+Q3JVlDdo15e6ZRFZeKZjsP77kEsjgTCYFDQlsMqqObXIwR?=
 =?us-ascii?Q?yoiQ3G/UDHK0Hliwd0osZLetDE0ya/MPBuItpS1xL6MJg7yggrEeFzHiWzis?=
 =?us-ascii?Q?Zkpt3oU0x/78OegYCGzsj1Zu3QEkneGCK1Dhh2oVV3vFCpESIGI9ranEJw3y?=
 =?us-ascii?Q?YHjH6f9oefauTE8Eclrm8Ljx/icMXiQIsznJEncn1+eI6qrk1HWIMRXfxLRZ?=
 =?us-ascii?Q?XWJqBW1iF2wrtCRHx7XkvpM2mAjcBhRIdTCexcImtCXCksZCk+mqp1FapWlE?=
 =?us-ascii?Q?XqzKcbImlxg+n3lkaRj/funIGrERSJQWunkZczRkuTK1GLN7lO6GgEcXmWha?=
 =?us-ascii?Q?DKK4sNoNQ3pEXCHYsDhEpdJKfYuZRDbpySa8NzwGYWvb4NRFznv3yeGInJ0N?=
 =?us-ascii?Q?loHUCPBEHBpcAJoVvydU1v99nkm+vc01KjU+TtzUeSQKYnfxZ8eU/HulWDks?=
 =?us-ascii?Q?nYadAf/P8xL+4UkgirK3lEnolOcM/0oW3zTaQcIgz1OOzkpsgW0UxkNBsDFQ?=
 =?us-ascii?Q?YY6NNZYXUo3I3GWVjlgDiDwbhO1sgx8bM+3UPkg+GwNQOWUK3OPzXBnJJGYJ?=
 =?us-ascii?Q?2xdXzH9fGJPxA7dmN8G1V4mw4nzp9qbBsDDXbM+dO+K7MvXrc0SHVrOi0ENI?=
 =?us-ascii?Q?BHoJJEa3lpIfRbTcHBn6Z/rCbSX+ONViFhNW2HVFklxEhT4cU0720lp4tZsL?=
 =?us-ascii?Q?BFKsUXs/Lj78n8u8LAChFyljT6F8x55Q0ZvJREK6RI5HWOu//xqvhRi0wFgu?=
 =?us-ascii?Q?Nc7bG6ev0BSDdyjiMCFsZwQvYItPWCWUKjrQseRGqjFsGRIV/vRDhw7fb5dT?=
 =?us-ascii?Q?L1XOqh55TTHjm8UU71YUic9t6eBufzYmXnmFwG3o309gsbM7twuF7tc3bmeB?=
 =?us-ascii?Q?EESa+8TPYJt3ehPSiZYQXta/63ABf2vabfnjuKqG9ti9Eoq8TfUBdZxrIf0R?=
 =?us-ascii?Q?26HvW8dl+K3qNyij3vOjAregd4/vzSGiJJ4dqeFSPPZp6A3ZrDEGnSYbMx9J?=
 =?us-ascii?Q?Jh2qlUo24aC6uRhx8DxsqVfPZiZEgW+VLUBZjyHB9jjgAGHanBYxqrSkz1I3?=
 =?us-ascii?Q?XafMtMcisLzU9+CyYENDFlhe0Loqb6Oa2qqb69VZNyt3V6A7do//8Yx4UnY5?=
 =?us-ascii?Q?PdGWqmqCtlzeIb+pEA+AYdRbIzPnsjGBrhJbPTJhGQKQfcxpML+gI6nyteZC?=
 =?us-ascii?Q?OpMRYt+8B/K4Uj2I26OUxWDBOV2eSi4SIJvltqYCF+08bDMnyxzSZMzuiYb9?=
 =?us-ascii?Q?OyFGj+16+y+i27UF+GMOtsatxa6ckwdOK+g0meR2RwR+KRwxmCtgEgFwlcQC?=
 =?us-ascii?Q?CvvdrHT9m0RVWsGqkHzxXuIzdq6VMXM1K5iFR0ZZTA6LyT0soKabGMGuQByi?=
 =?us-ascii?Q?gf/TZ3wdwH5xqQ1tewZBmyM7vptXawkmNbSNMMBdy6vz9etohRpF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 76369ee5-e8f7-40d2-6910-08de63fd5bb7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:55.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XLf7q2ysD3R0W+My6r6E3CUpXM6F4Rqws+uoMBF1QsWFxd67bU7sZv701faHct9kUkJVK3gls+DtsrV4XBr3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8728-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 03316E79E5
X-Rspamd-Action: no action

Add a new PCI endpoint test ioctl, PCITEST_EPC_API, to trigger the
pci-epf-test EPC API smoke test from the host.

The ioctl requests the endpoint to run the test, waits for completion,
and returns success/failure to userspace. This is used by kselftests.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 49 ++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..4be21e37353b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -41,6 +41,7 @@
 #define COMMAND_DISABLE_DOORBELL		BIT(7)
 #define COMMAND_BAR_SUBRANGE_SETUP		BIT(8)
 #define COMMAND_BAR_SUBRANGE_CLEAR		BIT(9)
+#define COMMAND_EPC_API				BIT(10)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -61,6 +62,8 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_EPC_API_SUCCESS			BIT(18)
+#define STATUS_EPC_API_FAIL			BIT(19)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -1117,6 +1120,49 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 	return 0;
 }
 
+static int pci_endpoint_test_epc_api(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	u32 status;
+
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type\n");
+		return -EINVAL;
+	}
+
+	reinit_completion(&test->irq_raised);
+	/* EPC API smoke test is executed on the endpoint side. */
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_EPC_API);
+
+	if (!wait_for_completion_timeout(&test->irq_raised,
+					 msecs_to_jiffies(1000))) {
+		dev_err(dev, "Timed out waiting for EPC API test\n");
+		return -ETIMEDOUT;
+	}
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_EPC_API_FAIL) {
+		dev_err(dev, "EPC API test failed (status=%#x)\n", status);
+		return -EIO;
+	}
+
+	if (!(status & STATUS_EPC_API_SUCCESS)) {
+		dev_err(dev,
+			"EPC API test did not report success (status=%#x)\n",
+			status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -1175,6 +1221,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_DOORBELL:
 		ret = pci_endpoint_test_doorbell(test);
 		break;
+	case PCITEST_EPC_API:
+		ret = pci_endpoint_test_epc_api(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 710f8842223f..29491f85b964 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -23,6 +23,7 @@
 #define PCITEST_BARS		_IO('P', 0xa)
 #define PCITEST_DOORBELL	_IO('P', 0xb)
 #define PCITEST_BAR_SUBRANGE	_IO('P', 0xc)
+#define PCITEST_EPC_API		_IO('P', 0xd)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_IRQ_TYPE_UNDEFINED	-1
-- 
2.51.0


