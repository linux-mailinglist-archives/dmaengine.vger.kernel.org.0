Return-Path: <dmaengine+bounces-8841-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OTlEcbYiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8841-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCD810F210
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11D113008311
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4E37754A;
	Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KvHOD8+4"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896EA376BD9;
	Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641603; cv=fail; b=qThT0tqVJfu3CLnek8wdYz7PqBaG8PiXtkRL2/9uUdf5QCRjr7xr3Vqo4faeFrnwMGCVHvfNN9K6kRXXDoVtoq/oIZqBy7N0DzVs18CZI3XH+le6obIXk0YGInEvX5QYzQ24P6Vfr0ZUs0voQvHbBsY+1xnDd2MS6Dkf61p0VRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641603; c=relaxed/simple;
	bh=LMPeG76zaN7/1vJRvj/3N35XHgYnWdSP9xVsfUjo45o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkRHmNjO3sICLE9/EEfaf7VWReg/g0m6SaWp6mnY49wAV4gukP/dbQW84C73gisFDvY/G6uJQ4Rb0zF5FKKwaXBvoDG65g0VIUaVKeyVRoNSda4cu6b9p5iZXw7CgVdec/baXDWosrd71ZiDD5n9Qn5743PuywLaiye9MsMKiVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KvHOD8+4; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj/vHhDtndAerm3M8U9Gs+B0prPupNoy5V3V04IvMLbwCGHrYwGkiR8uAx3ik7C3aHRWfiw9Avpd2WmUYapiby9sIcPPhDpAGRqHOyFFTB1Hh3SBk/YqgiAbkQW919QnRBr9+pXwHCxyTstDPFp0BLBEXjGdlYAoxi0G3BEJ3Zt1j+KO+8an+xC7zUsQOrbqO7r9oYsSlZ6sDvqUG6OrcokpUaHMyCk4mq0pJDaa0Q6WK/yr99Ilv6DY1IJFcjxMhlBavuP0BAryDDmLGnZt+ve6YXhQDuJh12YSlXcN4KDfUJmamP6aTsgV1Pu1oin7U4q02qQpDbMqyn+RE4YWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGIqxRGFaq1HG5iwebCn64y/g2AUOrVzlmhB8S1cZGg=;
 b=xO816EJV1b8CdkYirEx7ffilsonX61qcJyfwQZlhRPrNnMHdZLDFiwadBn7n/uSvtteesEZHpL0jO/3urNcnOF/2zWcHIiSkLmyhSnGwtbJpVVtD3MpTCSGon+Abswmf6MoMHlbETMWvG8e2HHRfICRuSnmmvYQWpcaOJYzzt6GPeTedcbj6lypz6D+VKBhScumVxN2A0RV6y0gbuh5aFq5odugEAijL+rglGqpwtXoz/oxbuuJOCUfIexA17C4/QByb38PDP33epCtEUjrqihSyaDXIzhDAvDtyRyrkOfb9y6Tqo54R1KVETacvc/KatJZgKne5OmFRGxhw6uqLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGIqxRGFaq1HG5iwebCn64y/g2AUOrVzlmhB8S1cZGg=;
 b=KvHOD8+4UJoRXP3ZC/lZiLuyf3dKiQeMX6Gt/lEWihX2NROIpfSWEichGSoqoBHZx7/ODo8kDofPBCS8Xnnp5chDREoMEBCgkSCb9Nq9lShS9Lol+TVmd6U14TuRK4Dh5C9B7331+b38orXX5C/FAIKAz244lbgWa3GR3OWwWcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:20 +0000
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
Subject: [PATCH v6 1/8] dmaengine: dw-edma: Deassert emulated interrupts in the IRQ handler
Date: Mon,  9 Feb 2026 21:53:09 +0900
Message-ID: <20260209125316.2132589-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a93f2ec-af4c-4409-b831-08de67da3370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jVPuRA5WTXxAZocIt6pioR9aWuLc3mYh6OWV7P4uv/aKKmXH3PItM8cye+Eo?=
 =?us-ascii?Q?qvmYDl9vPg1tLXtUeDanintyNZJ9umHk5B+zSgnPDOBNtd2XZTmSH+WLRMpz?=
 =?us-ascii?Q?+rP5BZypzrhhb0IL9JaPSwzD40S1WBLJSREn3akKXo1IPr2fxoi9LSpAUFNX?=
 =?us-ascii?Q?b5AIbrlSZwniT5Pco3lDow0MH2IwgtYD4Gg3pUghYib/BKjNpyK2hIJLVUOV?=
 =?us-ascii?Q?vziZuKj/WYb3ew+y37Zv2vtIEDpYPUUIyM6XZnb+FQ1T6C9IoEe+j/yiXYol?=
 =?us-ascii?Q?urv8uYDq/5fvKf82sTj3birJ+RypwGg6FKgmqXRngSTm9sk56IAUIQc+ErrN?=
 =?us-ascii?Q?rSlEnlUVsoLyopzwmHODH0IEoz6j5Oscttc2666ZHMgzmczEGU42c6MoVx0o?=
 =?us-ascii?Q?PBjmotkp8VogqU1qhUuBVhDTt1ljQNCFIWfW20KeSM2bROxE/JL5Y+ghe4lC?=
 =?us-ascii?Q?Ja+NnhVPU+Dg5PPu3hAyJIxq6E/VFJMojg+KzC30R6RnMt6SgqJIB8QF3cXC?=
 =?us-ascii?Q?cTqU7/vt+wBtqdO978jBjXtn7N/FT0ObN8t41PggYSgez/EuchmmEb3ZC0eq?=
 =?us-ascii?Q?yyXsMCgTSj6qSm6oXnIyt1iZDegILipveAG1f8KaS9wyU1+FpC2yOewh7+tZ?=
 =?us-ascii?Q?JXjpUiTT0MfxOUmttHvjDqn/Hg1cnksZvdUQK6e72uglFHKg9OK+k2MjkGvU?=
 =?us-ascii?Q?LhllWSxQ40fwditogPtOn07nDS7QNuCcz7h2gRawocrC0X6Xid9yWnsA57Wr?=
 =?us-ascii?Q?AuCOC+zh6X69kRSyqr7niL2ZK+OLzNPKdahEIEWsUgBovFpQ603QF0zyqWSm?=
 =?us-ascii?Q?cEPjn7Blas5t7HzAlyCxh63ZH9MJwIMlf3mBzVa2hzTSGMmJxllmF+0sEl8/?=
 =?us-ascii?Q?m5CtApBqhFCxjeyvUeQ8s+qEE7sdq30aBsa9xUVSswfJtvdOp6j0PQDYMdjH?=
 =?us-ascii?Q?YVxyxFQXJwrOuOvQd7yileVruSHkcKMF/Z9yafXFm4TA5oumsFOF3Zpt+pTl?=
 =?us-ascii?Q?RELhdGo7Y6VgcFv/z2F0dNU4DLc84Kc4ZhuuOl59piR1PP24zsT2QgPLx7X3?=
 =?us-ascii?Q?Tq5Zwt5qOd9S5BDO6B+ABmtCX4fEHqCvpeI8J39IcuHtKN4gdpHGX+nh+yUK?=
 =?us-ascii?Q?5xGnUEVYPxhJNmNOTd6xKM/NgVikITMpcH0amw+25tygELFbnJ4ACPn754Ss?=
 =?us-ascii?Q?xoSpOjbLQWxFwjBfEeWhyVW+N+74jYU7q0aNS0vRrd+M43+7efcwoHz/p5U/?=
 =?us-ascii?Q?TkXyz9E+WMYmnvRt2CEHWBL8praDqjem+mgsRqnpjOZVZmakF/2LCjCUjvGa?=
 =?us-ascii?Q?njb53uGQOU2Z1gS96dgjFGvSaK0dI3ghiHsrj8VNuC8R4amBEvF6dNUhuRSg?=
 =?us-ascii?Q?wRTh7eyjipKf/cmVpFBqrI5R6QhtgrdrwFd4iUBW0TC1BkPJtS1oRvKKenvH?=
 =?us-ascii?Q?RhlbszaFHcybjt0DVh1F7Zzfe4iE4lMjc+aMwmDUJUYVQPNM1mIi0HZe4bMx?=
 =?us-ascii?Q?F8D/1NkeMnQuaxU7SN83/WEkO/hujhmLu6PVL820/wnY0FRq5Kr0/kv4B8aP?=
 =?us-ascii?Q?23K8CrGVV3uKjJ6pItGF1Ec9zTXgK/XphUdF4TDrwykQByp1lb5lRkJXJqMA?=
 =?us-ascii?Q?Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyCSoTkQGChxdJ/ZDrSTIjKL/+WlYAhR9aALQ4+QOjn5z50w8o+X5feeswIP?=
 =?us-ascii?Q?5wNYrCy/nnJcJDlVgHvuFApLaVXh9yjRJjG6Pao90uWcyE9eWrLT5xKgLbqH?=
 =?us-ascii?Q?40fycIGvAVRyBvEc6tHyMkXreDZLICtRr5XshHTetoMPjvhWG0HpAU+HyzG3?=
 =?us-ascii?Q?PaC8F+QU12s7NCEjOapEOfYulM0gx/dIJj8ISJoTbK2gKfqXRDxZ7YdVaqfF?=
 =?us-ascii?Q?/80YcUUhBU/A3y6xQP49khKf/aXwlqMcxPOe1hvU+AthfK8bzQLHlSMiaxZ5?=
 =?us-ascii?Q?r3KVwWzozb6cAkUpdU74OAvHvJMvDDx8pGcGVD61XmYV5b8SzbkHTGnPgSsw?=
 =?us-ascii?Q?rEMdRT171sgIBHbAKOqmYky0u7DqEy9sn26oIzARddqv25/mBb/rk6QZTTAz?=
 =?us-ascii?Q?mlhQp2YPFljXcfKh1npsLruJJxRKLrmc3Usj1v2aPoOgKKGN0spoCHPsaOgD?=
 =?us-ascii?Q?erEGfYoZNxodcFk3bx9OepB8gnmV+CxGQgpmHO81BOB9XpxQskL0b8dVnz96?=
 =?us-ascii?Q?7ziU6kNH52kfCJc2O5yz1NuB5AW4xdB/8TxvDGxfaXrQstXFLvL9i0ywWzyJ?=
 =?us-ascii?Q?fTbdb0737CGY1mvkn22OrDHbC/6fP7BCmqT1CIx6D79Iu9DRgy4GDfqtNTuJ?=
 =?us-ascii?Q?9pQ5wdzllqEmA+d9JpO5f6ALJpNyLUdqif4w5GAebVblfx/hAybrYqQvSUdW?=
 =?us-ascii?Q?iHrpUyChdepF1QM+VeEVCWvtJK5ulzAlFicAWxWzpAGQBWANCAxcG+2hhk6A?=
 =?us-ascii?Q?z+v7rjP6n7bDUo1wshDm3QyIIVjTsQJb8aqDuprfb8SuCF/ys1OClRcvbldk?=
 =?us-ascii?Q?2ZQaBZUmdTncGgFjV4sKsemKKtkeSuhRBXStb4H/vn8IJvxIfK24NRPtzYSJ?=
 =?us-ascii?Q?+o9P/ipGesW2/AC4+EF20qtyNcXetVjp4Qy0Rr43HMKfI8W4kfUWuV93Gp72?=
 =?us-ascii?Q?PsdNYzFViJq2jc76yEAfJzN+8q3B6mYK9cjhL6syxkPcZu56oI6ZL72fxQN0?=
 =?us-ascii?Q?npx5v0p+w8sLx7FDqu5BEpceS/AzKsycw273VCPzdNKHQWPMSQnA93x6tiWD?=
 =?us-ascii?Q?0YntR9em4D9EzhvnMnPV06IafwZ91CrPoyHyHUOBziucR28L3ck66Auq5kh9?=
 =?us-ascii?Q?2EWL1ryIjpHL8WPrXtiLf18cgBgmsf9vehFI/uLinYjEmceeKJYL+nR6D5Gm?=
 =?us-ascii?Q?PdJjHv1mhnKMUAcsJDADTYZNIJJ7DMnyxEzhY1zwZCglN90teWGSypiSmbHe?=
 =?us-ascii?Q?6KKMwlgb5mkWrUU0QkNe81ZMQVtZGXvEKowiZQFArUNCRM5FvtyHOY0UtnBU?=
 =?us-ascii?Q?N9wlL99XbSINl/XW8+K/aPK3wnSGRWDSAZF+uHjM5yRyKWzcLIIXyk/Xl3o6?=
 =?us-ascii?Q?39WMEegZHyreiUlFe+EOBCO/m2lIAsfyqgEFI+RollnJm6N+leWauwaLycPR?=
 =?us-ascii?Q?9GkoY/hAxD6DGN7ifGxYrUhBrCTIU6zm7qjpURvHyrJNjS67qGLOEasoB0AG?=
 =?us-ascii?Q?ZbF1jivMUCiPkU8gigMt46U4Omdam6B4/7G8a45XpJ46wzY7RebC+rYcJBcq?=
 =?us-ascii?Q?Q6/kTVP4xlSYtPSxH7oubNZPsgP8aggV0ej62ipum5x6sJ6G/IzKAAZdan/V?=
 =?us-ascii?Q?9ci7J9OurhpLGcWWFvmmAQHtVb7dqk1AvPZgVI4gXaPLO/sUumLrNbjZS8+I?=
 =?us-ascii?Q?rHimtZ1rQr9HTBvV1R7s7nOuhCOMn8gGNWYNgP28cv0AcTHopP6XH0Vh3uIF?=
 =?us-ascii?Q?blMcn2+N0JjZBA1/TJp+8m9WGyndjeECZIVKgEQ4MShdwWXG6OpI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a93f2ec-af4c-4409-b831-08de67da3370
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:19.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uf61fPEZjZO+RE416dlhFKJqmu4xgNdQrXGQpLCR87wq2uCSFslCHSCJDGZ3nRkeNlXhLrpu1UGf3alJ1Cv2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8841-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CCD810F210
X-Rspamd-Action: no action

Some DesignWare eDMA instances support "interrupt emulation", where a
software write can assert the IRQ line without setting the normal
DONE/ABORT status bits.

With a shared IRQ handler the driver cannot reliably distinguish an
emulated interrupt from a real one by only looking at DONE/ABORT status
bits. Leaving the emulated IRQ asserted may leave a level-triggered IRQ
line permanently asserted.

Add a core callback, .ack_emulated_irq(), to perform the core-specific
deassert sequence and call it from the read/write/common IRQ handlers.
Note that previously a direct software write could assert the emulated
IRQ without DMA activity, leading to the interrupt never getting
deasserted. This patch resolves it.

For v0, a zero write to INT_CLEAR deasserts the emulated IRQ and is a
no-op for real interrupts. HDMA is not tested or verified and is
therefore unsupported for now.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 48 ++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    | 10 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 11 ++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..fe131abf1ca3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -663,7 +663,24 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	chan->status = EDMA_ST_IDLE;
 }
 
-static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
+{
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
+
+	/*
+	 * Interrupt emulation may assert the IRQ line without updating the
+	 * normal DONE/ABORT status bits. With a shared IRQ handler we
+	 * cannot reliably detect such events by status registers alone, so
+	 * always perform the core-specific deassert sequence.
+	 */
+	if (dw_edma_core_ack_emulated_irq(dw))
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -672,7 +689,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -681,12 +698,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
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
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..50b87b63b581 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
+	void (*ack_emulated_irq)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -206,4 +207,13 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
+{
+	if (!dw->core->ack_emulated_irq)
+		return -EOPNOTSUPP;
+
+	dw->core->ack_emulated_irq(dw);
+	return 0;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..82b9c063c10f 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,16 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_edma_v0_debugfs_on(dw);
 }
 
+static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
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
@@ -517,6 +527,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.start = dw_edma_v0_core_start,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
-- 
2.51.0


