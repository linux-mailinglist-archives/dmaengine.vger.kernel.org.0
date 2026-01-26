Return-Path: <dmaengine+bounces-8485-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COcjOOcZd2kCcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8485-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:38:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4D84E64
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EF363002B58
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C02DAFA1;
	Mon, 26 Jan 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="q91vMdQ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630F2D97BE;
	Mon, 26 Jan 2026 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413067; cv=fail; b=hDe6Ki2gDBvQ2yE4xdxA/Bhzd+mIm3GQusuFNyACwpsQpEOOfSZx7/xYizoDkW3KxSgtp1dH/I/GQke3XdL7v6zVoCKpsLDu4JbjaZxkl6SUVxHgpGnhkYpu+cPoEKBzpkoeplgJ3CAWtbxU0QWfb0l8DVotjip4BWOje07STqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413067; c=relaxed/simple;
	bh=33tHUaQKihIkU/CfZDXQFX7yxpfaV/HQtO1r58os7s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+aM0hXkFxm4puEoSUYssyfEpESOVENMGb9WHOF5lWrBhkHpizS4HNwQu+ggijcep1+ZGZBNSVuGngKWqLtzL/4FVgK5mBehP4qQQvW1Ea0yA/34H7NHTR5a35QcLoZ6ETSoWEiUTSPFBphI9J7YT+G6kvvvPMe8qGzVMhk7zfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q91vMdQ2; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV9sjoj09WipXrTnq8kUNDgnST6Md4bFBQZTC/ONvaHpEnBGIOziSHQm9rzjdRxLJ11ay6vyeaMIAczGJGwDH0J7tc5Ce269sTJBE8cDjrhOd7zDinsXE8SE29Pm1l25HqILbDmbya20Ycy3ZW3mBQCdEjXcO7+LFD/cR51VjPc4dTjjXI7RMWzkJ7cRGuXZPBMT7upjfE3HhLdhLUUTgh7p51Hg5mH/tRhmpeAnpwmv/kXAx9j4QCDcApLrKDoFTl2SmqA0airdb2kY8SGMTWLyoR4FjyiGocC1iXGVVPyEtm2w2aeFIcPX0QwjJ4t3rmLzSwPnRtHZtVarVlSkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAYM6b41oCnkMYmoIdTU2/xoOCnf3kxqwdqWJZIbtdU=;
 b=GNNobCjkdFjYMG00pA3YiisUU+9r2j7fTm/Fu9kEs6S8mgLQC8bF/SawCFKg8sgtTItCnx1ULetgL0hNHS84dDz80qG7iqxDwFQUIO8nASzIJylhhORmHvTBjS6LDVjIJYDrEh+Ze47bZs0/eSSLMTxROgNfo/QQM4MpL9VwwYHn77GQyRkCr9rB9j74GdQAVhyO+JuhB3HcR8jgh4arvaMBwiDQFF+f7b1J+Z+MvqkTPQoaqYxainZkdH57EMpRlQTaeKuHFN4v2kwvPs1yVdDKYg1bKcl54u/MIuN1jj6jHpFrpBR8UvPL7v8+IuaP4osvNoBG/PZzv0swfYHsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAYM6b41oCnkMYmoIdTU2/xoOCnf3kxqwdqWJZIbtdU=;
 b=q91vMdQ2+KBOpR/EiGUIWxWTjMBKI5Nyt9FO1dmEUlSH1nlE5yMihmOUDh/3x2VE42DRLlVwiPjdpJQhUMmMidUwK+1/nExgMFzmvza1ERDfHXddZJVzG4ALKn/3fRDvalCtHVEvVXU2UXpan8qd9vqkBWE13PgYQUYUAqmYCbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6300.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:37:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:37:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dmaengine: dw-edma: Add notify-only channels support
Date: Mon, 26 Jan 2026 16:36:52 +0900
Message-ID: <20260126073652.3293564-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126073652.3293564-1-den@valinux.co.jp>
References: <20260126073652.3293564-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c66c672-fba7-4e0d-fe71-08de5cadb6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?712x/AH44YzWqVSEjJXa+rDilrTECf+TsUxUrMpSvMCgnLr9veMAvzD8vUmS?=
 =?us-ascii?Q?DCbBI9NCcb7/cIglcKFgCPKE6k2QxzWycNHUSnqoPFbp9GNB/gf/7X4zrSqV?=
 =?us-ascii?Q?d2hPfJ5DdpGuEUR/bIzsaCCmPjdTkxSVyFSqVQpGX4q9/Hq4Ov1nPojrsdaj?=
 =?us-ascii?Q?A2A26v77Qh3yLxAq4p25JFD38fIBHo/bqKxgU/aS0nJ+74HQ5JPSG17Mll9w?=
 =?us-ascii?Q?zWZWen544AkHUQG+6cNTryqYbkTV3LUJ8ljoNXSMoA+QeKdrzYNsxs8HjCHo?=
 =?us-ascii?Q?WiW1Lpx5mBBER7Jh/eXGWICFV7HdK0MOt+DynLD9O5zkjl6BJa6JVw5rOedw?=
 =?us-ascii?Q?zbTL9lGnS7yaLNDYEtdM3Zssbguuy3CBG1tiRlxlSR4hK65Y2EPVAUcJ+vUI?=
 =?us-ascii?Q?QI9ILrUWzpYkq9dKP+Y6xSB3Yacm0QmAspxR9owbIILCc8FUIs5ldswRlaXz?=
 =?us-ascii?Q?3quJt/IkbmiaynE5PK/sG8bioBPy2aEk6l/OAZeypnoCJWkzCkHRsZ4Gs2fJ?=
 =?us-ascii?Q?GdO+WFDJ86DhZRnn//MG4fCH1sf26ioyYdmjeERTJN/hwz0H1vYEwFIjSHUV?=
 =?us-ascii?Q?UQ15g8veP8s7/kYi/buWN2Ztuo5Ofdn0TgXEyAA0M3+subwRD6HTwtxZBvXf?=
 =?us-ascii?Q?ywi1YtCQe7oo4gmkyJs5vFZE3fFyiEy1GF9zmCrQV4o3qF9hB5mH4nzqBwBF?=
 =?us-ascii?Q?nqNUJvacIZu0TJbcmdV63bFKsfio1YWOXIlIh8e5tGfiDJ39AaX9hZi3Ickr?=
 =?us-ascii?Q?gE5ek8VIDbb+8XOlIId19ryqOHhIYJ6f0XGoUG/45RZQLOVgQN0vm/7eMpuA?=
 =?us-ascii?Q?xIbinf53uwED53rqxO0iFc3RjI5bBhqsd1DjvGRZ1fBbm7dFz1I2PjOOlUPR?=
 =?us-ascii?Q?PXmX5QKC2xb7R4RIEqBsIamUe3yt13PTvqTljrhEETX4BblsLOtfWLt8kKvx?=
 =?us-ascii?Q?LzNHIiCjnmXti407BdZUR11kHyO+VFoAEQrs2+/Hy5uIxUV3UDyQc6n7yoHh?=
 =?us-ascii?Q?IdA58xAQf1ad0nP4yZ71VScaEljiHZ9L+YDdGDx2egLG1bVlyxYJ/0P5Enyx?=
 =?us-ascii?Q?DvI8pyCrn+evOdds3Pcp68zKz7G1xoSY+otKUfi4madQ2CPInSqYd76RSyNx?=
 =?us-ascii?Q?cClskua+GCb2g664w2FLAdbttg9epfn5n1kz20DbH5rHvLmEQgOR1Wg5rbsT?=
 =?us-ascii?Q?yTFAwbvTNYGkArz3eDoHvKrPK05vRgtqX9WlycTrHpRgEbx5bdQN0dSkF3eB?=
 =?us-ascii?Q?SbDGl3CQbgdH7b3TkgEiDU/iioQhyyhIpLGuQJ9OP3l1HsqR5VQY5Xvkx9Fz?=
 =?us-ascii?Q?PfDXpzmGYEM7OLhc9EtxXyduk9GKdVpFiJXo4AuhZ1IuZyZhda1ZNuPnIkuF?=
 =?us-ascii?Q?4jSi3QwcfbpNrnUgVP+7BdezIWwwz2jiQY81jtriDYBo/Hb8uOm9CrNBaklI?=
 =?us-ascii?Q?zLkcjJwIsApJdd9moszTtKz+OiTswMPlJ80NtiaSyayIAShXk3Bt32tlRkLU?=
 =?us-ascii?Q?ggWVpRW6F6tuo8gKTEQqm6kLZG8/bd9/Xp+L5PAFDx6P9DuvZJUAHlG7kaKq?=
 =?us-ascii?Q?e/PIpf/LwUJxcFTosi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PuQSX2oTkA/CLX0s9W0siy48XUU1Iv5BSJy3JeLjSFTu6QA0D19SYAv9y1E6?=
 =?us-ascii?Q?x1riceYnDRfDESk8gcqFwgnCeIDS1G4PyIVpVjrhRTgxI5H6UCBrqce/bFxr?=
 =?us-ascii?Q?G1C6uTtPhIFA7mAuHiwKKH8pwV5FICJFk6Kk/eDVcr3TWaLlq9XdqaICqBUt?=
 =?us-ascii?Q?tHzAxfPpVnAQE6wEDX2p61DfCbY/vGb6GgViVWNuVi9EjfEbVr8PEU6QI5H/?=
 =?us-ascii?Q?6jcUSh4Njqon4xYYNjMlXJcSLcsMSTQEfl03GfOPNcQxnaAqlvxlc3Q/CtKw?=
 =?us-ascii?Q?msYFiDuTJ0tQJ9Lv/Tf372gCoE/sCXbhlkYQq3nCqcJojnxCUOMM1ZWxtf2G?=
 =?us-ascii?Q?4F+gOKTPkse8HDtULrFbmI0gOaZ5renh/QlqT0F70WjaSKAR+H5lYrkgkAz/?=
 =?us-ascii?Q?lk5pPKYsHeAxwJ4saUMBr/GxJhJB9jhxb3OQYrZf/0MP2Ht0zCrndSwfsFHO?=
 =?us-ascii?Q?jtNDODjXWhWZRWkU7NgdrUbj+ODDpuRvDyuJBDX17wsgQFlmvAefcbOxOMFV?=
 =?us-ascii?Q?Iv3Qah2VLZr5Ef/xK8IiXzrsuERsM972WGJF9NIur9SQEQ+cq5rcxvK6RRGQ?=
 =?us-ascii?Q?pvzRMHxJAkWtY/N597nwr/JgYL/LETcepPrnTTKOZwDarrDlHFHCZUOmcski?=
 =?us-ascii?Q?w45vNVBmvVWubFwJcJkb+iSF6bI0MnQmfErUkrt7jmM0PYD/ZpNihWnYsHZO?=
 =?us-ascii?Q?UtpwCsQJu4gZ8NPbAEPgkdSKIDMnSyVxUwWSe8dxaTeyz1jgWe0tekU/Bjav?=
 =?us-ascii?Q?zNGl/BY3sTtrHAzxe1jtg9nlc9KLxO4RJcpFo0Sm0mzuyQ2ubdcKS8xMeabA?=
 =?us-ascii?Q?OwEUI8iwgiARssJtYnzFwAbKiCO+PAeTxmqEm0wHVqIxYxcn95rPUY9d/X4y?=
 =?us-ascii?Q?3htEAwqk5JIfuU0O7x0R91JqIdYbSjuLQMBy+KdrXA9zi/impM+zzF1ook6r?=
 =?us-ascii?Q?HuIh3n9bg3ome6HzN+r/WMHzwAdIMC2jIzxiY0tz14QVAUNu6i8hyXN3inY1?=
 =?us-ascii?Q?2US4dfY97QCK2D+2wZ6EYBeBaa7uDe30bURmrE07rVpCQs3hPk9lhrJ5/sUy?=
 =?us-ascii?Q?+5oRnwKmlwvGmzb3DnFl52qztgsfMg5nHE2dhFVwOTumHET4q7RUD2bhmayl?=
 =?us-ascii?Q?jBJjF0p0UQW5tHJEpAoskyNFGd6A9FLCsUnDem7TP3wJ/WxUIs0oTA52KVWw?=
 =?us-ascii?Q?As6fmKlQ4hDRFPL6vDTZdcJIbOyogxBy3H9ikQwNw15oaChsy7CIxyDdfry/?=
 =?us-ascii?Q?P/8MeEz4YG7/u7PeK4sBroQgYdVjkm+02yFslx0dsWLZ0Rl5PuC+Tpbao78W?=
 =?us-ascii?Q?eRqA3iudAMRsbMxPK2/vKBCvZZPSJGSvo0RkGjeTpIHEebe4iJ3W6yU2/ndi?=
 =?us-ascii?Q?bfgLm8D1YXvtlu7s1NBtMvETAkeO6HY7q2Yn5tPJbsVmJTLVj2D91jR0Znfd?=
 =?us-ascii?Q?uymaoQ26t0mS3Wsgmo7kLcVpwsmCkCQudlWkws3vMCUkAiW0D37r0errTpPb?=
 =?us-ascii?Q?iSlJYQXryiLBJBROy9hVNjEOZYH1EkIHY06yLltfBRW+PFWKuug7XEvWNDpR?=
 =?us-ascii?Q?TlRTa1rvJF9UCYwCvbiIpNBunRu3mUjnwewKPwdPokQADb7LGFW/bwtw3atu?=
 =?us-ascii?Q?kidKvqmqFAi1YutunqgvuYPjzXSdvmze5AAk40PDgvEHjLtj+3dSEWln+lfj?=
 =?us-ascii?Q?/A0y0zvju4W7XrD/uCjCYjfHal1e7cws2H5cRPy/BZ6v6Hgac94lM20VZ+SW?=
 =?us-ascii?Q?TSA4s1OKcDwAEexaHAQTzjGhAGMYjF2d9UnWuwbSvp5RasmRlpEz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c66c672-fba7-4e0d-fe71-08de5cadb6c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:37:09.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ9PjJOaCyUUl2cgxy20SUjYYutZjMMQJZHr4C7UHGWmWevhcO9+h6R3Ab4dh52MMgSyCJaA6rt4NrHzaCAk8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8485-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synopsys.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 53D4D84E64
X-Rspamd-Action: no action

Remote eDMA users may want to prepare descriptors on the remote side while
the local side only needs completion notifications.

Provide a lightweight per-channel notification callback infrastructure.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 41 ++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  4 +++
 include/linux/dma/edma.h           | 29 +++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 910a4d516c3a..3396849d0606 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -616,6 +616,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
+	if (chan->notify_only) {
+		if (chan->notify_cb)
+			chan->notify_cb(&chan->vc.chan, chan->notify_cb_param);
+		/* no cookie on this side, just return */
+		return;
+	}
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
@@ -834,6 +841,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+		chan->notify_cb = NULL;
+		chan->notify_cb_param = NULL;
+		chan->notify_only = false;
 
 		spin_lock_init(&chan->poll_lock);
 		INIT_DELAYED_WORK(&chan->poll_work, dw_edma_poll_work);
@@ -1115,6 +1125,37 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+int dw_edma_chan_register_notify(struct dma_chan *dchan,
+				 void (*cb)(struct dma_chan *chan, void *data),
+				 void *data)
+{
+	struct dw_edma_chan *chan;
+
+	if (!dchan || !dchan->device ||
+	    dchan->device->device_config != dw_edma_device_config)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	/*
+	 * Reject the operation while the channel is active or has queued
+	 * descriptors.
+	 */
+	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
+		if (chan->request != EDMA_REQ_NONE ||
+		    chan->status != EDMA_ST_IDLE ||
+		    !list_empty(&chan->vc.desc_submitted) ||
+		    !list_empty(&chan->vc.desc_issued))
+			return -EBUSY;
+	}
+
+	chan->notify_cb = cb;
+	chan->notify_cb_param = data;
+	chan->notify_only = !!cb;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 560a2d2fea86..d5ee8330a6cb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -84,6 +84,10 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	void (*notify_cb)(struct dma_chan *chan, void *data);
+	void *notify_cb_param;
+	bool notify_only;
+
 	struct delayed_work		poll_work;
 	spinlock_t			poll_lock;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index d2938a88c02d..d616d22286d1 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -131,6 +131,27 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+
+/**
+ * dw_edma_chan_register_notify - register completion notification callback
+ * @chan: DMA channel obtained from dma_request_channel()
+ * @cb:   callback invoked when a completion is detected on @chan (NULL to
+ *        unregister)
+ * @data: opaque pointer passed back to @cb
+ *
+ * This is a lightweight notification mechanism intended for channels whose
+ * descriptors are managed externally (e.g. remote eDMA). When enabled, the
+ * local dw-edma instance does not perform cookie accounting for completions,
+ * because the corresponding descriptor is not tracked locally.
+ *
+ * The callback may be invoked from atomic context and must not sleep.
+ *
+ * Return: 0 on success, -ENODEV if @chan is not a dw-edma channel,
+ *         -EBUSY if the channel is active or has queued descriptors.
+ */
+int dw_edma_chan_register_notify(struct dma_chan *chan,
+				 void (*cb)(struct dma_chan *chan, void *data),
+				 void *data);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -141,6 +162,14 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
+					       void (*cb)(struct dma_chan *chan,
+							  void *data),
+					       void *data)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0


