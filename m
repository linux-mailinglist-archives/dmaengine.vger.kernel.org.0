Return-Path: <dmaengine+bounces-8794-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KMzCAUlhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8794-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:29:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB2610102A
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C44F305B95A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49D425CD9;
	Fri,  6 Feb 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qHjpDfJi"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44007425CC6;
	Fri,  6 Feb 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398822; cv=fail; b=uLNg9NvsH/e98tCCntkL8aQsdDgrlegraG7KgjxLB1ZJuZDjIWIWh4fyKheCcqfva0A7JzGRCr1YRO3d7+nEAotAJJmbMcOYvKLBAEXtL5IedTAqfv8/m6xciB3VnTFcV0k0JC0/raFRdlBlYQiu+wBWNL5bjpZSH0xGyzsOm2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398822; c=relaxed/simple;
	bh=jlcOul59TABczguEy9MbWXpIHEQvwzwvAQb1L1Ti63I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PccUtcUAu7p8AdwIxkrXh50j/drl9t02ICK6SMzJwc6UGTt79lW9sVcwN50DqRFBKyQ+kMpZFVzZfs4jEWcSw8HRTYAL1VBY7QKCMAplYn2RSpyluAMxOkxB2R2lJDFXSg23UYO3uXNP48IWGfZCn11lHAVCtuvvAMEx7t6Sg6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qHjpDfJi; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb9U7DZvhr/GQAKkPLHKgzQUNZFF9kW67VIGAYwVw7jv0d2yY2JzIyy7TyBm2SSz4r9K90AQrJOnAnT4+CyUSfO409a3S5HW+Ryam+tX00heKESDAy8wMAq+B/o230L3T2TTs0FYDSotVihluo/9egh5Y309oml2ZEil7AjjOoJo/TQw5FHHMg+OuRuaWEW5K4qBtcK5w6KvdvmXjNJjPb0oQLcOk/qn5uY+u8V3r2YPwI552SNH2cYLp0Er0q8Yxulmw5H6uvqmxq8lGeUs9sMaOobucESzpDzc5JWvuLcm71K2Dz5rkMBcS4P9QKLjA51Nbr74lHgTUwmNX7EEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG+v994oHVGibi6C0FkUg5lH4X3o1zh73SZsNC8nWF8=;
 b=U+LQe/2zDly8/0vwLhaVPFtR/rjeOutxusSh2rJsGZo1METL2xP0TUSVI2uD6+ahEk3AHyUU1/POXCK/0NP13Fkn7/4LaPmFqVAcfzhZoCd5ySEsZq+RTENkTUaw8AoezS80b15gI6EzzD2ZldrTCWfVs4jckLJnc5WE41b+/sa0SXVp5hATYOwgehTxogEHrppt9AcOUPdTgQvaRJc202d74ZvxNf43VcRgBvvZSGfFJTOMSjMQVqlb3o9XYDsI3oyY6JZI98tGx3jXff4wLlYNyTpsaIprqPqDpSufyPtIS5KC35SDZ4HcAK3u5tESMfzIwkhsIFv+Sf9e9fX3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG+v994oHVGibi6C0FkUg5lH4X3o1zh73SZsNC8nWF8=;
 b=qHjpDfJiNJv3VvC5D7wPo1sb5i3zohp0C0UE1lLdPQPSnIIT0jE6Q6EBgeISZH0NyPl8JhsMhId4bOcdwOB31jqWptNwKuHrBIrSCNnFpJ6RHM1m6x4+lvbietNaJJU0iXsFkmZb2auLHbjSRGHGmmw/9sKXI+KwAscZJI4q1+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:59 +0000
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
Subject: [PATCH v4 8/9] misc: pci_endpoint_test: Allow selecting embedded doorbell
Date: Sat,  7 Feb 2026 02:26:45 +0900
Message-ID: <20260206172646.1556847-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: b386112d-10ec-48be-e744-08de65a4ef50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxGFeaQcP+QOnvMeqQARP26pf9QfmI+96odLqEaDS4SzWIqZ9Rn639uh8APv?=
 =?us-ascii?Q?eD17y0ehlFWjOmrYMlqUApEj1wv9Z79bgS22eMltsmM2B9MRkqcP2Edh+3eM?=
 =?us-ascii?Q?sMOY54TEceFCBZiNnIygvKON//nGG8Eclqzuf7zTo9vLjQ7qvRtRaBtzEL2v?=
 =?us-ascii?Q?R3K8bVAwPCPD+7+CqVAcGkn0nZfJ7RpVSwtJ2h1bjaeAUOAPp6HWfiw8rkPr?=
 =?us-ascii?Q?j6ud4Zbxrju37R6H2kmD/vE1XuUjT9STW6WvHU/bl86lDc1TRSRUwT6OeZb+?=
 =?us-ascii?Q?y+SraqE3fYSb23ZGnzVzdz/ZeJe6fjnnIuh55ixa+4zNX9/P2W5NPgot0PHs?=
 =?us-ascii?Q?KhwJ7l0UHMM8msQ7rwQOJb9yrOOIsO6UIrivnDhRlKWlDuJHToWjS7QL308g?=
 =?us-ascii?Q?r0Akh708zoz0nNVHb6vT66D05cXMeG7wNIfKuic/Lzn+x8r8qNeAVZXJ4wtE?=
 =?us-ascii?Q?gjt3jj48BqjxH/B9FTORdkOVv3JiUegIu+AzuDNjmuHbGOP0CZAajXEn6oBG?=
 =?us-ascii?Q?y+YseKYgSTl4b8VAhd9MF3aljWxKAif+LTzWS+GPtI8CVU7FdpC6dyWeyUrW?=
 =?us-ascii?Q?c54QNp2mIVMRcSZ0gx533+ZIfreyLFOcnwnfOtDzhjcpFW7kskOedyiWikpy?=
 =?us-ascii?Q?k8NS65nSa+WCaO5sMLKShJ4BE+LMsmbH7m/qlxoHAdNz1HordV5pLRjMA3uO?=
 =?us-ascii?Q?F2evSmTS329XCc/B4enQckK/1s3rdL58y9Mnw9DSbt5Y8z9C7keFYeAXfjik?=
 =?us-ascii?Q?q/57jxrvSY1Mje7MBEhqHSIDLxCor+PVanXsUw8s1pH0xTnGgKQ63GTM73Us?=
 =?us-ascii?Q?4pXNGprk/FjktFa8BSqnF7cbAb3957bg3emt8mEMHrFAtytt16zAetjOiQBJ?=
 =?us-ascii?Q?1yNU8AdOc1+L1tVFU9ZNXgxHtAb/9SMe2x1GV+Ij7RFYbZOU62Xu4yQ+Q4mB?=
 =?us-ascii?Q?g8ORsMoz8t9F/LxuRfz1hy4k+QAC4M00Rxb2NfIBakrzRWO0qeJE6m8TbFV5?=
 =?us-ascii?Q?OLb1Eqcxa+C0TPD66eqJnVU9Np+MUX5XRjOl2u0xiEWjnctWQ0pVCiKo2CDC?=
 =?us-ascii?Q?BI8th0I6rDvi3jPbjqVKeREiXOTqpFwNel4MPVBlssonTL+sFqsFZkV4JdGx?=
 =?us-ascii?Q?ri+nFAZXojYnU+rQBRbKmJkk8E69rt1s04AW6MtvXTPUspNQDg/PfMPCbCFW?=
 =?us-ascii?Q?bxkuQv8ArU9KvcgxF94Yt+wYA7aeKS/NWDVsGhDuTX/Ls0Z1l3sUhYt89khx?=
 =?us-ascii?Q?IF7Fn8nJDCsrqW+FrfFyt2cLVB1gJbEgUNBILvkGprDwglY2mqlO7V81V+N6?=
 =?us-ascii?Q?2NwAJeFLqJLYBqfpPc1t+OKa01BdPtlMcbUcQQsF82+wHhfNoc3kbtImo2l/?=
 =?us-ascii?Q?w2iW8Tzi44pD293atB6fAvTD7/MeJHnj7e5/Fkm59rxCNxJwnIzw8JyfxU7D?=
 =?us-ascii?Q?QscDFjCpJJPfAD6Af2gFUlYEnf4rcPpvVdF59mRXLvax46SDr1aVLJNYfyxb?=
 =?us-ascii?Q?8zRMdqG/hbtUUIHeNkFJucoRFBiTm6zytszuMJpIGwNeBL9pRcl1tuuq3iQE?=
 =?us-ascii?Q?QaPwTRd9V2XQ9QC1jyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Geg+FS5yzbeDpTyGZ8ZS7cN1qnUU0aNVBBnufRswaGDzyX0cvGeNEc2NtlqO?=
 =?us-ascii?Q?LgvXZxG0UGl4Q9KEwMK7tIekCznlLD6wvakSfZIuawdNZ8Ua3G56DzmLPMRv?=
 =?us-ascii?Q?pWMh90i8ZdhE0ufzOiDnBBqrxWedBcAgi88610wZ2FUydbfytW5IsaWO+bdx?=
 =?us-ascii?Q?3mBez7O7pVdS812Pu+zOOrbib82S23kriUzYZW/29qTWiILXR4UqhBfKQhXW?=
 =?us-ascii?Q?4EOW+5qKL4bpwGEMALYew36Ca4eydapkcclILTusVGiuyhaz3yzGkzUzJO/N?=
 =?us-ascii?Q?KAjO8buvOuJuB87djHNklOEsEjtVvYa+rbfhtnPcrPlirJQfsyd3efwsPjZM?=
 =?us-ascii?Q?4YXNjgv4B5gHJQyToPEoxCNC2gqE3tE8K1tmn5vJWi/QE+VKoHwUSYugeGIq?=
 =?us-ascii?Q?e2imMyekpiYW6hIU4yQ/O/Z4+VTYyssxHle0oYwPk4fJ55wKqUWv3kNKo1V3?=
 =?us-ascii?Q?a0YKdOMm6VGAQu7BgFc3d6E/m988D3lHUEL7R/vv2Z3tVTJ2IZQtj3MSpZAP?=
 =?us-ascii?Q?sUwlmVPffERifThRQhmvE3vkpGdln2U8ESD5dMKQ9DXsn70UzNbe+aQJNGMZ?=
 =?us-ascii?Q?9h+0xSaoA/TMO383mSO5iqfHDLQ57muNFDaF2sYvb78jCcL+2sT3rhNhalFI?=
 =?us-ascii?Q?nGK5LyJBQnVdvjnJ8fEzXX2oK2emtEh3BV/kWDb3X6Z51BSKW+Ap09A/9lth?=
 =?us-ascii?Q?IzDwlIUw34Zx1zPUnrXaNh5xukPnhzrY/pz4V251X8++HM1E0RbqZp6sv7FQ?=
 =?us-ascii?Q?NTOn2qUtKVO0RR0nwDnoV1HWqVmaCZv3MxMFmB7nYQ6uM7kxWF3SRCNLsU0A?=
 =?us-ascii?Q?paEdJ4xbeip0wxGvpKlF6SibmOGL66Y1FGOo6qvPKYS3zCi/RaQfRFETvzSb?=
 =?us-ascii?Q?tfZ7tSXM2VbQnktdT5ttSbXd/GPkoeNgAfJ0WdWkuFHlPOAJbPei+0TZ9JN5?=
 =?us-ascii?Q?EPz4HVrytjQJK4Cme4vnKbWUnHfVF/c97kqAxkA7i50ZDvz7BmxVN7zrcwkP?=
 =?us-ascii?Q?xyYus54jERPbJa/iKxbIyo+Pra5R2oYliuXUUOMPHOxjU1vvRpNzC2gkv0Yt?=
 =?us-ascii?Q?37UVz8wIaNmOEZ0xmaX0PfFemvIr7PfK3UTJ0I8rHYAvDL/5uApPNvDr50+v?=
 =?us-ascii?Q?J+93cno+GcRSabXSZLGBEPu/MHL9azrHa56kjRrMs9PGEnut22yayYDKqchc?=
 =?us-ascii?Q?HqOmGMT4O+Muh4pdDps+bVIGovhi4RTaqc7hFy3VHJJEHXruI4P8Z0aabtKx?=
 =?us-ascii?Q?ivHxsvJYb1/YAIhknFlYQoUytB8ZXHBE2OhKSMJRwq3buiscqhMc3iryRPwV?=
 =?us-ascii?Q?QertXHcGlNXiuTFSOD9N7xE6uCYfDMrJevHQ9nG/RipJVdY7i64kN5xX+qhc?=
 =?us-ascii?Q?dtuhxecLIfKeDSh2Lf7AJpJD3Hty3NyK1N+wXX270iblORkH4gFr/Crbf9l2?=
 =?us-ascii?Q?BG9QTKELrhC8rbTof8duKzMsdjP6ya+kai/criibINIdapVDrI1FiXRpYiIk?=
 =?us-ascii?Q?xfaDYDtaDXgf0JE0D+D6j56rW+kRR/yLDSnelw+G/fWW2vddnJGVZunpA8t3?=
 =?us-ascii?Q?LUypyIjNatJ4vKCHLuMzD8afObbhyqWgGQFa1KGzv3mjUCtTymoMRmvJ95Vl?=
 =?us-ascii?Q?/4BY3qPUNGBaLY4prgj8/QCfYFGabDepUYMTFTejXqSVCmXr3dXpetAgF8H5?=
 =?us-ascii?Q?VfPgcnsIFgscSm2L7Zooj+eI4VmRNa4gRbZEaPCEU1BCIRBuUS+f5111Bi2s?=
 =?us-ascii?Q?OrbZb3R8cHBoAm+hppyuiEp2k7Yheqlggn+XGWFtLxN/IXy+MsHR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b386112d-10ec-48be-e744-08de65a4ef50
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:59.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn8Sq8ATplQe4Cogij7Ekud67bm04aYbtqA274/1eg8v83GyuK5AuLnFky7pV7WgLyxr1zXZNN9bxt0tYhRbAA==
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
	TAGGED_FROM(0.00)[bounces-8794-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 6FB2610102A
X-Rspamd-Action: no action

Allow users to request the embedded doorbell variant via the
PCITEST_DOORBELL ioctl argument.

If the argument requests embedded doorbell, program the endpoint-test
FLAGS register accordingly before enabling doorbell. Otherwise keep the
existing MSI doorbell behaviour.

This is used by selftests to exercise both doorbell implementations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..e484bd47c7fe 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -77,6 +77,7 @@
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
 
 #define FLAG_USE_DMA				BIT(0)
+#define FLAG_DB_EMBEDDED			BIT(1)
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
 #define CAP_UNALIGNED_ACCESS			BIT(0)
@@ -1050,13 +1051,15 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return 0;
 }
 
-static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test,
+				      unsigned long arg)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
 	int irq_type = test->irq_type;
 	enum pci_barno bar;
 	u32 data, status;
+	u32 flags = 0;
 	u32 addr;
 	int left;
 
@@ -1066,8 +1069,12 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 		return -EINVAL;
 	}
 
+	if (arg)
+		flags |= FLAG_DB_EMBEDDED;
+
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_ENABLE_DOORBELL);
 
@@ -1173,7 +1180,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
 	case PCITEST_DOORBELL:
-		ret = pci_endpoint_test_doorbell(test);
+		ret = pci_endpoint_test_doorbell(test, arg);
 		break;
 	}
 
-- 
2.51.0


