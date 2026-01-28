Return-Path: <dmaengine+bounces-8570-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKO9JA9Temnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8570-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:18:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED0A7AC3
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A07C3065D08
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCD371045;
	Wed, 28 Jan 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LbhSGd78"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011028.outbound.protection.outlook.com [40.107.130.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CF36F436;
	Wed, 28 Jan 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623657; cv=fail; b=m3VkBK01gb+HyF9SnIygTvEh9dTJ1Ft1Hr0I+dWXyXkDLCnJOK0bz4Uj21giskkKwl2JlHvPKgT7JJ2H6FIkSzYZsiSOPFyG46/TizjyanSdvoHg/twk7P+/YQz09V/eFSAEVWdGHushzrz8dP2UsGmv7FJhixQQVeq52Ai/Tx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623657; c=relaxed/simple;
	bh=5dz/GsJKLWT/69htyTciCjHJxyT9O2E3vY3iNx+McQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dCrtEo5WHNxhI5HWtr4CVCHFRvQJh9bBygo4DKaCTHLo7HPUd+HbGUOoi45W148FSL1qkqTYMBWl3JJbWUaRxoTIxcxxeiQJQKf/nZzsee4irhJOYJGhMq3P0VRwEP8J5z1EfD+I9brrD5VjzEoWmxkFvRel08KfZ0u6KdBzYQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LbhSGd78; arc=fail smtp.client-ip=40.107.130.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw18ptQr3e2DFMv1hKZScti7HTInb3VjnW+7RCYVWdACImw4i2j6JH5og32mF+rV69Oe/YYmeyPXxBNzRWTVI3EhZ4o54FodZsgu+UYJBPtgWjl1vcPN3cPYRdzHVZkE+Z9cc/jP/FWsUIdztVCzRk3K5+Wkb1B2rhNC7bO3rtOYp9NT6YIRQfQy5CFYFF5/uIc1IPXpvNbGqWkrRAZNaYna2d/odWhncbQNNm3uFgTRuhU+aMBuX1PlhRe81Bcx0qdRwP4NmIlpwxeX00LkokMvONZaRAiSSoqjtYuuIf4+HuISiLhQQSNzx/UR7JseGSkpUKCuJPjuIGWnvrwf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=widPNM0fUhsKwoUU1wm33EguxQHT8AddWS2KfNVEyVk=;
 b=tjJjTDok/13jxrmuVb8cO9UZPm0bC7xQymzSsAxuxFrJfC2kAUHXPwSFZ7nmoNRadeZuiiu2hBWHFGy15WnDZs9/hrYHKTqtDpq4UGD90mlNTZAaJMz3oXkfoD+SvXdEKB7P7Yi8L8iDQV0/b14Gz8Avch9P0xeB3hjoNEk8h8yyP4UhYcSbXbFr8klz/E6tfdg/XA4s0y5zJGvjnq7YmCEHwJGmx6vzIKUgIRjYD3TaZAq5Vbj1f34QbMGih4Z90LzfIem6VuIWQ7nUl6oclnUctQGByviuf7sxMlZLVO8sBRJlDNs4yPmtRksYe0WvKT9jJi2NEDmRDs2dyt4psQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=widPNM0fUhsKwoUU1wm33EguxQHT8AddWS2KfNVEyVk=;
 b=LbhSGd782z0JX3wF3HmerPjDgl+0rgY6YNHezDzECyTtuuPQmcWH7lgLQcao/iGxT1PI97mA62P33feYqTtLJcEt2IW/9gQCeH0OPnHN396rXRyek7kVAE4zgDreMUmo+8NJ6SVjjYzaZs3tDyYc/GhR/RcB5rXLPaS3855CxKZUyXO9N8tD494C7rahZtkWltnKqKAIxvvZuO8Va9sHB0GOGTJoylyRapUn34Zqs6b4MFa8RvqtIXnBCjBgH3nanelKkOT5IhAJS110+1ycW9h0aKP5lZnotIunkBMNuLIqv4ljN+o3sv6+aNj7gbr1yMdXVs1DUHbl2LYQxpBSyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 18:07:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:07:33 +0000
Date: Wed, 28 Jan 2026 13:07:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shenghui Shi <ssh.mediatek@gmail.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
	gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shenghui Shi <brody.shi@m2semi.com>
Subject: Re: [PATCH] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-ID: <aXpQX7LGED6RciaK@lizhi-Precision-Tower-5810>
References: <20260128174552.3710-1-brody.shi@m2semi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128174552.3710-1-brody.shi@m2semi.com>
X-ClientProxiedBy: PH2PEPF00003848.namprd17.prod.outlook.com
 (2603:10b6:518:1::65) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: f754ce0e-077d-4e41-44cf-08de5e981c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vi624/G5X9TooOX/8i9W9aMB68jnAs2fkj+gtZNK4o472pa6xQUB98+2eaZQ?=
 =?us-ascii?Q?1ZVK9CCLdOSspIp1vFbSrsxcOKumAJQGfjzv9Tr5aGd8sjuHFE3ycdaAYFxy?=
 =?us-ascii?Q?NFVrHsEfzspAM+UZFZyF+ftOsDWMEPHyjS3keEaUF8hB7117QMenAbjeqkU8?=
 =?us-ascii?Q?uXZytBYrcN55RCVliHKPqtuj18s746oj8AIAt4uHO3qEvzpUoq/MFtBUfJPU?=
 =?us-ascii?Q?ASXOuq423uRUgc0OSd3eS5S+R5eQFb628OiPrVWrC5xx2yFFEFLKgFu8r5hK?=
 =?us-ascii?Q?ktnDsjMWd0y+znii5ImG+FaNnoyfzWx4e7xlUSx9wNgBujOFi6ZWCjTAqZQd?=
 =?us-ascii?Q?uL2Dvb3QM5JbCEI1VPNA+PYulbOUcDhbnltTBdpXJ8yonZfuSPVnQN03tY6v?=
 =?us-ascii?Q?2QqrcMMqPvndw99ebRvM3hWCnU+7lefCLibl3BCVRVI+mVm1PwFlmuuN/jfS?=
 =?us-ascii?Q?4yE+qdRjZYaj8oSBa6mitbocMNeBEMM9kco15Fv4Pj6oZwGW2t+s8tXtf4TY?=
 =?us-ascii?Q?HhR0DXDTVUuydFl23lqTzcvnRRmKLVYVR0RpdzTPNeLBP94Dj8r/7F0skw4U?=
 =?us-ascii?Q?Pa2AM1veFFFQZ8KCsOtPlRVu+g87mhFJb3jgvhWhjSEKHSSltNXFrXCfglOt?=
 =?us-ascii?Q?+rurvnMsjvknuWb2jsRlG50WeIpRRAqDxvQmorRZIwl3x08bReCBJKDR5jYE?=
 =?us-ascii?Q?I6Hnx0SGhZ/7xZqO+jdom1035d1n3D5sahB22t+AXmDdFGEHlwjAG3ZQlG0t?=
 =?us-ascii?Q?VRHOD7gT1nQKRtnoTXQ0BbCJOAbs36rKr1NM9Qu0kn6GVxBjprWE6Ohzoho7?=
 =?us-ascii?Q?cGEzv9zj22xavvNOe96d5sRE7RbeqmTVhUWhZsS1fAT2pUS4DQSW4n3rDpLQ?=
 =?us-ascii?Q?gmUMMAcqRNgxx4W6BB3L1xV1BJ41PvWwBct9AfF3SGU00DgJqwcx+/l/KT6c?=
 =?us-ascii?Q?Bk6lBsgrGGjD7YtM8ZN3QpI2ufjkGYwRrKdbW7RmscrjLX5BPAuiMN0sBQ0k?=
 =?us-ascii?Q?mTTNAzB3675xfzOG3JG630BpBmYFnqkFMinlXklEP5dF19jXzYYzGhsIeFNu?=
 =?us-ascii?Q?psqVkX2gx7jKTEYAPqX+1AYEP9em2WAW43DWh2qVNihBwfCK6sJ31a6iQblT?=
 =?us-ascii?Q?9zMkV8a9A7XXjEuMMzpsZwCJkXBgYcg5GCFSF+nnJz2SWNmtD4xaakrdkLvH?=
 =?us-ascii?Q?ygSsJxh5k6JzKoqi/eYMesdzx6IW3i8RrK6VnRCkg2hHXbOofud+AWsPUNjX?=
 =?us-ascii?Q?o+6NWRW/xB36VKXxrT9ErHvKINnxHrl1KXEJRv+EVw1InUzm+u9TkokQTR1B?=
 =?us-ascii?Q?tENy7kDhxynd+sx6QdZn25UkeCWMzqBWOyJ97Md8vhRtM/Oe92nOUUeUcsK7?=
 =?us-ascii?Q?zcVhLUegnNfKXCZlXdYkun+uG/hL72KhUqDR1Gq593A7uAvdAN4pMmOu2vCm?=
 =?us-ascii?Q?RlQf+FAqhxepF9pbnVszhktXkLIdFr1Bj21ZfgGQ6hnUTo28F+3TKHGwR2mZ?=
 =?us-ascii?Q?yf3JyeUD8cRLq8cUFrbcMqh/6VZrN4qHwwgy+hsUD8t3C4RS8ravxHOUVIQ0?=
 =?us-ascii?Q?hVSvnjj1y9tUzG74tU8h2vDlCnSptktjxSGgKCS7TW0rdH8vG0Hr7gMZ+MHo?=
 =?us-ascii?Q?mzi0Yt7oBjDmlIOnbAB09Wc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U43Fz8ubfZSZYn7mIymarm5wRKgoTFTfrDH2uOk7Bb0Ls+PcFaXtE68iSS2j?=
 =?us-ascii?Q?rgfLVY+jrfKAW5lc8xqNVX0mGeCE6a/D/ksAGQkZ4GHivHjGlPOSbQ6Ep02q?=
 =?us-ascii?Q?CPyU8SCQ2p81CjJvlVbd/k41WGxeupGN1Vj4SgwxJbi2P0zprdT2r8c1568o?=
 =?us-ascii?Q?IE42X/dkkxhRjH/Gc/aXl68N7O6OaPkLyRiY+eCrqmf62g1ZO2IZHEHkpdZD?=
 =?us-ascii?Q?idiATG+rzRJAFqpd9YlHK1KnDm+kJ3V0Aqpr9F+rO+co9AhxgJka8xsgWOuW?=
 =?us-ascii?Q?HcBUzmeMSLNIqJD9w5Gac3Pdi0LSuVv7wSjuPjh5ZzGYBCEBC2XbTzAyczX9?=
 =?us-ascii?Q?M9AQyvl5IjZaWPTMeDM8iZ4lXB0CRoJ480j0wYs1y2rzUCsOBcRYCpZEtPCc?=
 =?us-ascii?Q?2QuH/UoSMoyXRrABRUypCQWEcBOYZjWDQlMVvdJEH2mxCVWuqfSaPUJN/A3n?=
 =?us-ascii?Q?4KKNsKc5pa7CklEHXYO/eVBFoZS2DVyBcWokvryymppodbrVU6SdyukFN2VI?=
 =?us-ascii?Q?8+oKWW6P4VzItD5f+CdmVd5Rs6E3rTqSqUqhfWDysepVAk2m4VSiVeIgosmS?=
 =?us-ascii?Q?5BUSjjFSRLiWGQ9/hv/JhhV4pgIDY7As384NyuvQeQ01XT0DPteZENzZTraO?=
 =?us-ascii?Q?Y5C69trQW9NomHs3MN4dEfpZ0Qfc2NmM7a7qvEBrljqiFGbqKw7kjdQ1/hWJ?=
 =?us-ascii?Q?+U77VSZkTJ4DppGQWt3gaNA1zwmfjLNR6pOgymojB/pjVuBDJiEIcd61wGix?=
 =?us-ascii?Q?N0k4LUdL5Mz9dY+9JEoWDiMsHTnqDq7JswNKYv8Djp+uVpPvibAWIi5vxGcD?=
 =?us-ascii?Q?DIOPTHfwBiNTwyntpoBVzZJAQVkQaHu0iLRS3590U6n0vpd0kS9oSgGfcqj1?=
 =?us-ascii?Q?he+E1/2JyO0VRD7xQB3zjW3wtb5eqdJazU6LpbY2onu4YCuLzLjaYwPPbykD?=
 =?us-ascii?Q?jjUCR3FwXpD5CHbxFeCqhnUGTdIJSIH0QUswol3v+4qcsEKQ54/2BBkwwgCm?=
 =?us-ascii?Q?HqebzwgmISdXvBTgnEutL8B1cnzqjaJFr4+WEJvJvTMlhgUD/6mJiT7cm6Z5?=
 =?us-ascii?Q?BeqpGuSx21yBTsUArGCbs6f2/ENJic6k+GKqdqihYZZb14lfhWfgXFE5SDsY?=
 =?us-ascii?Q?LGyKnsy4KUNK7epgmPxqmUL4iT/aTceaxK1E084AS8OvgeXWjq8giZ92if3i?=
 =?us-ascii?Q?YJaBeC40obAVUAE4D7hfwSDqY/RNoJpleD9XXACribIPUeabIpuFzvtt5lWg?=
 =?us-ascii?Q?4PEfRHnXyrY1BeC1wz4Sv+p6d3cbeix8ciJl5SRLZY0yfc/W7ouAD7KKkhEI?=
 =?us-ascii?Q?EQFRHMncQSQkgkfTHhOnDR7TooGznDWHiWsMPFz6DG7XQU+KorBc4vkxN3Rr?=
 =?us-ascii?Q?9pA2yx0qLZwoaAtJn+IrcBQWX2qII7LBUlLD7s9KaPZapKZZT0iTToSkMACE?=
 =?us-ascii?Q?3tvStg4UDCYbQaM3yab1UmhLb6AmZzLG4LEPf0zIIToFVKK4T8tet4pYT8hF?=
 =?us-ascii?Q?ok7n6mYCHBQ5Xn+8g4w0QBAJYBU5oPeOyKy2/DQjDziICYShy9pS2l5FLYa3?=
 =?us-ascii?Q?HLEjq1nzkpxGqqsrQjulgH+aQ8RjTQsmogh2vVSqlRTojDC0/SZCc3uWBmQ5?=
 =?us-ascii?Q?IAJKbt0nZYnpv0gJcQzhvq4NNqIwm+VauqV10kq4B1SeyhYRVCm0/0WPLMVG?=
 =?us-ascii?Q?ZUy4XGTyhsxoT+UsDB7QyDyzP5pCpznOLTLsTIeBceUHx6Vm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f754ce0e-077d-4e41-44cf-08de5e981c3f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:07:33.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuGIJ8cwsBAfizZH4wBgHOwb2QxFsnFjds21aL6McyYRYbihg74g4O96VJWW44sfQiioYYTT0ZqZqcM8EUUpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8570-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[m2semi.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: D6ED0A7AC3
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 01:45:52AM +0800, Shenghui Shi wrote:
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
>
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
>
> This issue was reproduced and tested on:
> - Device: [20e0:2502] (rev 01)
> - Kernel: 6.8.0-90-generic

Please use fixes tag

Frank
>
> Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa..516770388 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -844,11 +844,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
> +	struct msi_desc *msi_desc;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
>  	u32 ch_cnt;
>  	int irq;
> +	u16 msi_base_data = 0;
> +	bool msi_base_valid = false;
> +	bool is_msix = false;
>
>  	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>
> @@ -869,8 +873,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			return err;
>  		}
>
> -		if (irq_get_msi_desc(irq))
> +		if (irq_get_msi_desc(irq)) {
>  			get_cached_msi_msg(irq, &dw->irq[0].msi);
> +			msi_desc = irq_get_msi_desc(irq);
> +			is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
> +			if (!is_msix) {
> +				msi_base_data = dw->irq[0].msi.data;
> +				msi_base_valid = true;
> +			}
> +		}
>
>  		dw->nr_irqs = 1;
>  	} else {
> @@ -896,8 +907,18 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			if (err)
>  				goto err_irq_free;
>
> -			if (irq_get_msi_desc(irq))
> +			if (irq_get_msi_desc(irq)) {
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +				msi_desc = irq_get_msi_desc(irq);
> +				is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
> +				if (!is_msix) {
> +					if (!msi_base_valid) {
> +						msi_base_data = dw->irq[i].msi.data;
> +						msi_base_valid = true;
> +					}
> +					dw->irq[i].msi.data = (u16)(msi_base_data + i);
> +				}
> +			}
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.49.0.windows.1
>

