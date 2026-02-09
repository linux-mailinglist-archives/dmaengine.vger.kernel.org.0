Return-Path: <dmaengine+bounces-8828-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCK5Mw1/iWl2+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8828-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3110C112
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C040C3014C3F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBD319855;
	Mon,  9 Feb 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Mn28/C/M"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E131814A;
	Mon,  9 Feb 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618604; cv=fail; b=XlrWc2tKioCiNmTr8fRnMvfzE5H/wF8i12IodTn/sAuXvNkugOWKA/yeLpl/wlc/0V9VQz/8nK77Lx9GSAwDcJBGwp319fIEfWfNEgRrqxcfURJlFap1q423XfYkuMigUwso/u5WCvywZ3upSJDX2h3Wh+a0ZimGlsZBMN/uLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618604; c=relaxed/simple;
	bh=RuEu5ELvxMj5sc6sxKixNVeRDRkAahwzkDV43tCtMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGjccOKBbqHCQcnBfDSnHFajmrHf/7Ul1D5LHaUfRmYnUhKtubTcC0E3hIwQP9ctfR6rnlq+Sh79YzeRcsxm0ahKgZLfrgXoiAkRPbo6J1qU0Sk3oejxePVsKzizhnmo9hm8O+rpE5b1y1091jq+5MQ+pRe35jMk0yNB/FM89gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Mn28/C/M; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0XpceXpFwGyim0mEAIOpQicyQ7Z14MHiJZ5d9UVK5oP0nVLRa29gnHZZWl2K+lptTL/NZ30O5iGlREHYVdM72WbVw1M8/wvqwVLl8/JWIGTp/itFrWBbCo2C2hHaIjcHA22KmytdHHhZPnxNlYvoUN//5DEUchhPdLB6HYG0/ZQ59PPpcgW7SmivYbJWv1ls20uYJFryf3s6X37RdXOXL9uoGA7F6l9+muqN9lDIU6DCA2dODaymuf1e0/0jCUbXczG4v69jCpOYaRIol9aaQUBxdOEds366r+pL33SPgVKxLjqYT6ac8VE5t5hoUqn0BwESQjl6gR3henM3L8DMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMsq/VHFkA0P4T3E98nvet/M9krabS6F1m1j/RtHSWY=;
 b=V6Bc0hmsirlIYdYogReyoX/xjttKoKX/4US6Tt4epo0BBLZnldVkgpZ0425jKAwVGR7Cd535Am/rqbp/cZkxcVeHVBpkbtQjNIFZNYxiFFONwQfAtIqNh0JyOv1nSxwO8JZgU5BpqVr9BFY5SCmy6FUle+UDI4gfQw+ZYv3U3OlX0gqFNAjxgJQ8eR0K0The0DwLerqUqyU9dTTjIT4Y8cYA+wL1T/BTDjcsdBSEKXtToATkVj9ZVkFD1U0Usaym9CbTTaYb9RhHUMS5AD+84WMhma8DpV21cagQTzbh81RjnslcJiS0X1801MFrD0LvLRRmj5CQ+Xq5goqXj8NWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMsq/VHFkA0P4T3E98nvet/M9krabS6F1m1j/RtHSWY=;
 b=Mn28/C/MP5BOxMY6S5BpqWoPmRSoYjGt4ndzogJX1duOGsPzIGolFlrxVm3LqStoFvL5wGXhpJZxDwAk2cLebLR2fH0xCadBmxZixplZJuqTfWjBfdHUqgD67f+F6u0NCTLhJm8lESWUWAVDX/fwQDkJ3FMEianaofXemWNToUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:01 +0000
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
Subject: [PATCH v5 3/8] PCI: endpoint: Add auxiliary resource query API
Date: Mon,  9 Feb 2026 15:29:46 +0900
Message-ID: <20260209062952.2049053-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a4d6d0-f5b5-4d4f-d09c-08de67a4a785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOfXkUbmj4ct9muAEJU0aLwrwdbkK+ZpBh3XpqRq5E/SPw6adyK08s4NA0+q?=
 =?us-ascii?Q?TB9gOqiefZPGk9vtd+yMhNCPNgV350Qhe43tFmNzo9p8SW7PPgnJgtjibPhy?=
 =?us-ascii?Q?KG4kMzRfX3A4i0K3tNRYq8KXKw8L7pV02fwypmX3Q8TAhnyyiLatSzKq8rup?=
 =?us-ascii?Q?/rRGjmotboOUX+sTXd2+1O/GFPXEpSQfiKFG0bl1697FR71/gmFbGI9v9Toc?=
 =?us-ascii?Q?pEVc/aHH4gd2bSrKSVZPddq3OuKEeWHVs0Y2xHBUIB1ViqIjUh6V76YxWPNs?=
 =?us-ascii?Q?ZCPlgKZigtCGCpzr9SgbkttKSF1lvaST5Ur3mZ0RBh361ujNeOnutpMgHqx1?=
 =?us-ascii?Q?mncSzbXcYxrw/fKynvLq350TfHaelzFZOC2eQdevbtDRteZcRAIbNhancjsn?=
 =?us-ascii?Q?EfCB9tBo9bewtxAsR3zE4cJZZvEVVEma7bTxDMKcdB/WNpfZtxlOimN6Myhc?=
 =?us-ascii?Q?ug6S7nKWlzuJYcuOk9TDP5IiURRnhWoLx27BYHjsfoYzDl/Huccp3KRtHeh6?=
 =?us-ascii?Q?wlfGQ3a27wVFNttvDKOtglKVdzPY3vqhi7EmqxQ6avsz2K7UEgD1hSdofN0e?=
 =?us-ascii?Q?RdTnGqGWxDOwSnPffXdFoVpof5IQUZKaMEatyNv+LuyUh8tskdbPx+PQVBUx?=
 =?us-ascii?Q?XsBYFeB5RNNACVDTYLwn9QpXgvaew0lCOA865Po+HrrRbwxTQEuUYq++S+H0?=
 =?us-ascii?Q?hnIzbpiIeKlcVgHWJ/uQjp/dYdDbZbUV76vmlvkKLxPen14fBGiKcG+TlVWv?=
 =?us-ascii?Q?qtL2okpljbatU1TcUeaD+vWQL4eJueFBzIge6RA0hq4S5ku9/8LUoe3UVEkQ?=
 =?us-ascii?Q?r25GPra2+UKeKCKyme5sxS6x1EFHNCwUxE3Ua3HAdZq4beHAwC08c1pxnd1l?=
 =?us-ascii?Q?/WDc1xtRUxy12Cm352qgImwNgTnOej9Z9qRgpQgo3hxEikt2FUIpU2K9e8jB?=
 =?us-ascii?Q?bji4TaVNuhyIxhriep2pstaEapTWDqFn/KbeZzs1WhLJDczMpEbEfj2YlheE?=
 =?us-ascii?Q?u9uUkgyKbppVjJEKHkTaiV6DzoCoYyym+d9OnyJLPz3lC7agwNSz/+RRJDZv?=
 =?us-ascii?Q?lOfwI8QXdNFofCeO//8KIkljF2ocJ9aHjbOvitZqVzHD5NO0eioNpVV8zsw+?=
 =?us-ascii?Q?xRm3K42lfozokmd+k/ec311u51l4XrhfAPDZZ3N3s1hTERW7doKmfmEu+iuN?=
 =?us-ascii?Q?NeYgQnjIp+lx+Me41JIeuljl6Q+JOq9YSQOm/r7ovBem06hXjxSpB9BLcyFM?=
 =?us-ascii?Q?u2wAvqNhRoS/G+5mCybB97ghIGKNMAChlifWOca5Yu60AbQQIP43O3as8apY?=
 =?us-ascii?Q?SJgJWF2G+jtyOiqweHgaPtsawNeqPYWk1YLzNrP5KlxJ6k4w3+80Ogty0Q6B?=
 =?us-ascii?Q?tXN8OUuRzAimbU/kaU7FPot/Y2DyqHQM9tvYZpPv2h51RMMsLtWohb23LuoW?=
 =?us-ascii?Q?nSo96Alc3wFwxiWxktIIwVVR140rCqUSFvunDJkBshW2V6skjR79W8QPF+3b?=
 =?us-ascii?Q?V9FxHe0U0XBee7CwOf5VDPeD99oA8OMfmNqg4n0hZl6QRJ+kajLOz+c9M2vg?=
 =?us-ascii?Q?AYjPX63TLOQjGQN1hbKQ18Q28A92Vq69toCqBPJF7Ik/eEXahP0GsidgzK4+?=
 =?us-ascii?Q?Ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPuE3yj3ZBFra6ZqpqiwwWDBf3MUWbmtYSfvsgTfbjpYFwaDlJafVuFxNI25?=
 =?us-ascii?Q?4eCsYVvGPQFBOoSq7Ed6Y4MWkDhGMTVTynR8vfI/0l1Calik/EcWWqrKDvOd?=
 =?us-ascii?Q?eE1XC56vC+lHyB6wI83GAxxWI5KA7qbBIIhqGEz/Fb4mq0BE6x/MWGtlze1m?=
 =?us-ascii?Q?0DSc9FYEIzOPhVJWqVFwtHbbHcEamIIPnBMh2u1JdGs2vg35QLDRK4NVwYzh?=
 =?us-ascii?Q?jq07yytDbSAXT1R2HSZtg/AcTDhzZDXOvhdhFfpTZL7dyDWslhPz2Cd0FntX?=
 =?us-ascii?Q?ZUFwfLnxpKsJZQmD9UAdxx/xseSOY8zG3DPtIsB430HmZIqeuoauqNoClnnj?=
 =?us-ascii?Q?jW8EHHnC4992iZydOvdX8BnaslkpZ/fbuw9p3zM92fX8KAqRdjdObV7DRe65?=
 =?us-ascii?Q?Kk/KkSps+cMOZQJch2UDge6hcexYnHdHgBQdPPyY2JFxQv/qfS1Z3M1KJECH?=
 =?us-ascii?Q?Wk1RnJqRbntyyyCnTlhw4qcdoh/cFG7aLPYxPczHEKahObvlXoQljLWeLFT6?=
 =?us-ascii?Q?y0H93jtNdrlSB2HK8MHy+c6APFo1LhGQ93k8iBfn4W0UwGb85GnxnAPj9FAf?=
 =?us-ascii?Q?CqmNHcgEO9SMcqIsNrRD22twJUr8+aRTQ+yLo4na/a1vTt7MEInTgmptnPJg?=
 =?us-ascii?Q?siyvOuYJX49Uiq3gUOBQFfEYs8byYah8oGL9ioTNRqlguba81VLt0izt8CEl?=
 =?us-ascii?Q?2UN/sUxm5YHWIJAu0VAdO/rntVDu2aGEtz7qAGzDC66M4gUn8RA3zVdnHjfO?=
 =?us-ascii?Q?l4VwJz2EEAWe4QtmYoxSr4RPrsuKoGvyWyBEGKyYGMZJjI3d3ZUhc7yES9YX?=
 =?us-ascii?Q?j3kRgMQ7krB/UVQyxDP1e3b33JFvofQMEoiI/IxZjT6A+cM1/5gAyzEA3/Wv?=
 =?us-ascii?Q?d5KOPKPmAEm4pxTyt7vheFkJOOcGOkU0r6e39tg0yj8U0yyg+g62BDrDxwcc?=
 =?us-ascii?Q?d8sJg5ibfgddGlkP7P5XANzCkDLoAr0Mu1ISjHVM5Ya/jEgHP8gt/iNlHYal?=
 =?us-ascii?Q?ImcNYCWbWkiMsilCGJlNWgAnjwoBuZ+mCGjgN7y7bU6+Z78CgNxhpPDv0g+j?=
 =?us-ascii?Q?ueeTmqK231uXG2Wi3thEsiM5kz8+VgX9WpaNBBZXGyhFvG3dIaE24UgjTpfs?=
 =?us-ascii?Q?Hxk+kTwudzvBhR4vXq4AfWk7Ze3yRm5aIwe1x+Lu4L+dIWaV8JK5gAfldKyO?=
 =?us-ascii?Q?moYMKzwqSzAgAkI07NXN7kZsQXLmYoZKx6GklyGdFYfoJedcsZPShma2KC+f?=
 =?us-ascii?Q?eQgys4VgzJpH4QNz5kv3a/Qp0bw+cAwSdy9F7OUzrEFoAEB6W3uaAEmEDs9f?=
 =?us-ascii?Q?qvol4MlFpZaz/IRSJevwsjmyFxMyS63N9mIMcpzk927KO+QkYP/pyLjmQUGA?=
 =?us-ascii?Q?4xE+w1qtjVFtqE0Jngjwki6KA/zkAw4/nIoCjvqAw6IynnntU+uWHAGER1xU?=
 =?us-ascii?Q?hRcIppGdvsmHJRGT2f5gcVKB/orp3PEFMZJHk+xfDNpjL91TdugVIkZpy19z?=
 =?us-ascii?Q?K/7eH/q/qRxUt2yqLKdLd/0pk7yWVLxJYHwLku5pqWMWf+rQCH2F/HPt9/k0?=
 =?us-ascii?Q?WkmQy2769V8kFMP8bRRZWz2I5bJsvxxbTNs8eZTq8WpXQtFc7b3QV1rtyypE?=
 =?us-ascii?Q?vEVrjnmweXPS3qCXgBmHN2tB/t7fROmCFnzm0kKGLasnT1vJCtY9kKqEBoOD?=
 =?us-ascii?Q?5Uyihr+zW0KSoIlCkopBPtXpnjXus2m4VsaPGcvBxjAiJsO0pqNSXykD9Rpu?=
 =?us-ascii?Q?CINKaAij8TiLuB01u9o2R6R7z/GNldRSQjxpnzMn6cABZGhcIHdA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a4d6d0-f5b5-4d4f-d09c-08de67a4a785
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:01.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHjxY5UMPOZJiPJVITeIfL2GL1L0+U9c/S0qhQ+88hZmuu65fz11aQBUb3AfqKZyn0uJRAChEn0KrOVxk78W2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8828-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78C3110C112
X-Rspamd-Action: no action

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
 include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..01de4bd5047a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..5d3e1986b49f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,45 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN_DESC,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:      resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr: physical base address of the resource
+ * @size:      size of the resource in bytes
+ * @u:         type-specific metadata
+ *
+ * For @PCI_EPC_AUX_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
+ * information.
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+
+	union {
+		/* PCI_EPC_AUX_DMA_CHAN_DESC */
+		struct {
+			int irq;
+			resource_size_t db_offset;
+		} dma_chan_desc;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +123,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +155,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


