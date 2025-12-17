Return-Path: <dmaengine+bounces-7761-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4489CC86A4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D70530FF6E4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F1342148;
	Wed, 17 Dec 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="L6Gyjd0r"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31E31A570;
	Wed, 17 Dec 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984590; cv=fail; b=antGxER+B31420Uj/GlcOKv5FeflmD0bM9giSE2mw4KT0thNUR9nM1T1P8yb3E5LfUlztALERUOyp+5bNCwzV8E/OQk7hQ9y7vRnN40eYOFfhBeh3WEzMML0haTaWDjqc1PGXPNNscj0U/Q7Rh22+Gon0bBEf4j0dGymhrzj9b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984590; c=relaxed/simple;
	bh=62fZs6md0GVg9qSTUtu4zM67YagAdoPN0Co4kyzuMH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRg0xYBerojpfdDPGnrGymF9v0bSC9rWDmWuJNOtMcTxrZpzlQn0ver/ssgObdjO5boSofV3eqPmATszR7FsrN7egjNCt+StHOwPUa94q7Y6ApBe1Ba9rvfUBHBGqpfiWlww7Ftq48C3CQnDzuHykdhpM2L4fse8tESaoUFAU/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=L6Gyjd0r; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5fnsjL409InZ9b+w9xMNHqkyFwAfFzwUI/eMDlf9FHoZBYeRHxgwJ289YvP1bF4EN4mVor9Pf4oWZGcCbIzuPkB+dQzZ/TQGPduwPz9GCcsmE/JsGNwHpWWGb79o+TV5GTQnUsDAdS8IUxP+Q02typIlEGkeWq8T05xFEOFL9qnKihgOHIsoncXi3jAWRmpWYVrfdvhiEYQIIZN19DcceqmJEjDKmot9qkm64rYgSxn3nKHuyV79Pi1X3O8foczC9O8DsNfrLhpqJyz2rFnWAHiVGQlVt4PQEW8Di1o8bbUOTLHr0h7fTbrHJcPa0GxK4ygBQKgBscQeokH/k197g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOhVH5WbbE7TOgwhUWG5IWDXoW2MiIJ5KWF0mB2sGN8=;
 b=oVCLMe5slr9og5DtXCDgfVQkGqOSsH0i+39J4wtK2obQxMLHaYmO2V6/VQaCgzdmTOVQY1LeY7Q08P5Pk4wM2CiaQMrQgF04a/khers3abfgw07VnjKIEcdX640rANXFgWgQZbX8/Npa3YynAFKcPfXSfFnxF3ifHBVc98nMQuvpmrkd0vrS9Z8HP4e+oug6/qjh4ndPYNcuhjmHglMu7WjQGS5sMNcU7oWtKbdCCspzl6dXymAaF5QBn1WcL7JANTPogkRSs82twI70lrjkr9+GkwW2dFRNbDGnsFE/Bgg5ijsq4FzJjlVYe2LjKnXcIPapW65NrS2/+JOTgT6MjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOhVH5WbbE7TOgwhUWG5IWDXoW2MiIJ5KWF0mB2sGN8=;
 b=L6Gyjd0rnIt6L25/zve9O8/ujQPkIFhOcuq4AMo0ZMpX7WTbws8yILAXIP4jvoVyiNQ0RS1AdEF3AS7+4rA4yKwIR35Ek9Ei7BTp7/ONDaNZQKLzmyIAaVG/ojQ6uN7m1QiFQ4zaHp3t6IwUzPOHvOp8e5+vRvSAYuLpnDQZkwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:18 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:18 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 06/35] NTB: ntb_transport: Support partial memory windows with offsets
Date: Thu, 18 Dec 2025 00:15:40 +0900
Message-ID: <20251217151609.3162665-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: fb65cffe-70ab-44cf-694f-08de3d7f3a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8QAUiJzRhtTlEaEf+apec86lvh07hE74dYZ7sn2fVzvpBRMuXqGWKbANeZ6R?=
 =?us-ascii?Q?ylf3hwMt/GmcaYl2At3gZTo+9kW23lCSjnL9gj8W6SR8IYbgVNNp/NBSemqU?=
 =?us-ascii?Q?h+YXk40kXdBIGlBKmLxcITUwWBxCw9ZT7JXX82dRtZZOWLbfNnhMVn+tbzwi?=
 =?us-ascii?Q?0ySwIlo44p+DqI2cvayDU7Ees889ZYCJ5FhWRtgyaQclvp1odGVY+4jYaRZL?=
 =?us-ascii?Q?TaG0la/+xh/RlpK436D/UqQ2CJ+ilgCxBDlcclFA/4Ux9uWysfzBLDKiK/Ck?=
 =?us-ascii?Q?ssz2YBcs8b6PCWXaxX0kUaGy3KMZn4nUxT2ry1rNe6uXmfUMkpLuuPO6CW8R?=
 =?us-ascii?Q?DcimhUpTAsOYhaoJTnGBohVaGeKeNfT+h0tt11gfV8v+ALjBnTAfQ/rO61El?=
 =?us-ascii?Q?6atZLlC8vG+sMxVyOp4W2Zw4D6isxpRaAijLxG86RxfV0FUHFqk8eFeimVT4?=
 =?us-ascii?Q?v8RKMiqLRfvtIQMQ+ESmImLUdvs9CGbOZZRtw/Tp3N/EgCq6l3tUe3LyBXP8?=
 =?us-ascii?Q?6NeHqYEvRqbB5TjdH0zGvqikfhIlmFlorhhq6QamxgPGsk/Tz/YsVEL5ekiS?=
 =?us-ascii?Q?UpYvxBhB+kFm8jiCMuoi/QhpFlXmSJTU8aAFk5eYFPN6eMg1NzRh0KjRabaE?=
 =?us-ascii?Q?4ELUFLzOaQsa1NZerjVwnFJDHpdIREGT/Z25GVOf6qWOnBRQFChB2TZOrT4T?=
 =?us-ascii?Q?2HZRTuPOEKhzat717Z1jDJ4qF0cXME/3kxXTQv8kOmFxUYTL3NtO8Dk0LeRe?=
 =?us-ascii?Q?n8JaBr4bnXgunNrSY2+jVZlOnqlwDe/Wdt7S5gqc/xGhsSyHCAGY/FFDXtP0?=
 =?us-ascii?Q?aiihP909+4wmi9swILFXrpD2ETowpUYU47ZNTLGdX166qxbNxpI94Wkh1YwT?=
 =?us-ascii?Q?Cx0hVjExZMzMNrael6cRiNzaTZcIkZZ6S4qd6YblMUind8Zapvid6bcuivEc?=
 =?us-ascii?Q?Gxaib69pbsBJK0dBg9sJv4MBPiqwcoPQThgvWYEC0QFN//0sdEBm+SySQAMa?=
 =?us-ascii?Q?uow1xXnD8YXM+K5lQKqTioB0KIBorEClS2hS/1JdxHEOQh4RtbdBohExwyYc?=
 =?us-ascii?Q?e/vFhp3S0Gugu9wU/ugesOXWdgI4tWNmc1HzQKwwFEIKcG/mcVTZOngDGDrF?=
 =?us-ascii?Q?TxwvUNbVH5A2qtr7Cj55k/jjAj3Nd6XfuocO51Sl2D2OOReaMzrsDtqGqvML?=
 =?us-ascii?Q?CW6IrZ/kJX5XVYy9jqe9wluUxvSL5Yt7XtnwouofkNmoSvepo6j9t2weFbDr?=
 =?us-ascii?Q?2G1fd/2fFnUM4Uby6w1GAaF+3rT3o1nI8Ak5iLuOuw0In25uywLYe/xBv9/2?=
 =?us-ascii?Q?QwjYfT0b1Nlcko7YVCM/0QHuAx1qcv17JqcQ0i834NqKzh8w+gw35lDAuCQN?=
 =?us-ascii?Q?Y9JAgEVQlFscWNNwnWWCZXK4cwpIMw0ZXFRyLQ9BYnoh3P0wSjJM+s+ZctDm?=
 =?us-ascii?Q?bTGEG9/IO9Xo8k1Udyv2vHi1ZV36yewe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTOL7YAIRajiYIz/ouXcwPPA94jLYVxPNC0Xd36JJUdB9taYPhfMgj8jU/4p?=
 =?us-ascii?Q?Ns1hjI5+0EU4hOp98sFGOXqbxc8z8WJgYOx/bCMsfsMyArH4QGt1RNCAR7L7?=
 =?us-ascii?Q?lDrR4NIym87YSbvfL++8Pyx+MNkfTZTopcTeBVCpPebNW0uuIv2Qqr932218?=
 =?us-ascii?Q?pzVgRWVMkNMXgbsiOn07YO1JYOKrRTYgALQJviBMpXo3sExJlhqTx6TFooY5?=
 =?us-ascii?Q?BUm6c+3lzKSgbfpl6tLtNNbGXtGtCgNXIYxP6+Y5KwT9//PjuUgBHwgA+dVw?=
 =?us-ascii?Q?j2lSP4LcRNkBoWEv4U/IA4cCrwdplohgnGbtyEI+agRQBFWmD/qs53m1Ug7Q?=
 =?us-ascii?Q?MqAB7AvCylIDFu4LOdYSbOIXtvh7R2SLYZxIx5YaND7BPrOV/q2xMQKvTXkT?=
 =?us-ascii?Q?2QxRRmaTqJASDvf63mf6XRQo7ZwbHye8NvYb6cwzsJ0PQHguPHoiY2IMXBO/?=
 =?us-ascii?Q?sNqlrnpCUihOpRxjSAdk5UtE78JJdv4tO0r8LizkCnk6R61FX692VhlnMKyb?=
 =?us-ascii?Q?5UZGfyBmiwZzPVWtvQ1MuoVh8GEa8jpWKMHgYas0tayfNXz71BzLHNxO9CgL?=
 =?us-ascii?Q?U/hkqkXlgpruXlvdqpCqEfkUp+/MhX0MAz1DopHvLHFbmcjAWXkm3O7FjBrq?=
 =?us-ascii?Q?Qve0jhida32RJY7PxqTEkXLcksxL03XVbyH/NXWw4ErWWh98YA5CrMR9Nm3a?=
 =?us-ascii?Q?kWQv4Vh1bUJvmKozdnJNFfW09UrnezuZMFjA1pZY112xVjP0Zc3gj2fI7leg?=
 =?us-ascii?Q?kAdPHjVuEmtJxpjZXJQmb4v2K+gq0TZLf2f619383XW5sPLkjq5sZhxr8Cmu?=
 =?us-ascii?Q?nsOD2e0BurfWrVfU3NN2MN0A3qYo+MXmxXLP/4bv02/aUsHlClbrrJ/CE+00?=
 =?us-ascii?Q?hveDU52t4WffrfbpNqzoSpmTtsaDWHvc7teqFTb+3+UJdDuE+ZwUOUzftBYj?=
 =?us-ascii?Q?MWfI2/aTbeZLuKLbvUahi3XTRAak2ViXzW3PQ2pBJKMSFSo2XmX98ydvNeKq?=
 =?us-ascii?Q?kLvfVBCFReo9BIvW8UkH/1My8IMVzeqMt2cUluJqAOBFl59kZNCSqfv37HQ9?=
 =?us-ascii?Q?zv2LvJ0bR3c2lc/3WMvsTseCJxfgSinioNqECFsv/SnW7B8Hy7nCgH0V7tQO?=
 =?us-ascii?Q?yMfS4v0HU2dGjRv4mthWH7AGMIt+MqMB9L5ERqfheC5lsAGAALmXI7lLLsgC?=
 =?us-ascii?Q?jvXnp7KohgwBd8h4UNHMM+jg4Zx0S/8pGaAq3FGEUykykn7CfLnR766zP5il?=
 =?us-ascii?Q?ckoZc9ZhwQ/ywSHpOAr3jJQhhGfZFoPpNBTjfl/+oOl31JkuSF8d3YMEOtXJ?=
 =?us-ascii?Q?K3l+i9LA4gyQYMN8ONp2sEcuAhlYLcGa0nesTfIVhtA8e8P3WPvOEsXWKsrT?=
 =?us-ascii?Q?aNblice1qGbis640yAxvwgfGtAnmc4AYv4VkwpFCbvgxr7gXi73ZO6OvX5qd?=
 =?us-ascii?Q?7hTJAPZsFI9RxDhn+Oq/8hTSzAzwYAClCvoN4TXOTNAGsvPCTZL1OAsSbOx+?=
 =?us-ascii?Q?rn4swr/ORvWzrgkdi55hL9y2dP5nUcAUsdbj53cNQ9P4i2ZTgylS9PwWT1Gx?=
 =?us-ascii?Q?aKYZ5p8qu3mOW+pfyxrqfkOZB/UBP2djh5dhzqoCb6hEFebH5EMjAuA/gqJY?=
 =?us-ascii?Q?wKjVXTia//vd2qg0RZECT9g=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fb65cffe-70ab-44cf-694f-08de3d7f3a9b
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:18.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqzCmVm0eMA58iFalQqTz8rrrqFkirZLEchQ7IY/lx3XgzQxwLBqNQbGs1m+iaILnWiRk3Lid7sJq7mbfDh3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update ntb_transport to make use of this
capability by propagating the offset when setting up MW translations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index e16a8147ddc5..57b4c0511927 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -823,13 +823,14 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
+	resource_size_t offset;
 	int rc;
 
 	if (!size)
 		return -EINVAL;
 
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
-			      &xlat_align_size, NULL, NULL);
+			      &xlat_align_size, NULL, &offset);
 	if (rc)
 		return rc;
 
@@ -864,7 +865,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 
 	/* Notify HW the memory location of the receive buffer */
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
-			      mw->xlat_size, 0);
+			      mw->xlat_size, offset);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
-- 
2.51.0


