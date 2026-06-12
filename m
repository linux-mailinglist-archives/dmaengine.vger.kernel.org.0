Return-Path: <dmaengine+bounces-11496-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2i8wECcILGrqJwQAu9opvQ
	(envelope-from <dmaengine+bounces-11496-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 15:22:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98805679BDB
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 15:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=TPegRmE3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11496-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11496-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE313077AD0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9A3EB801;
	Fri, 12 Jun 2026 13:18:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAA3D3486;
	Fri, 12 Jun 2026 13:18:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270320; cv=fail; b=mdliV/QCnFXsaLG/1U3DlHXx10q0y9R6bs6YAUL6AaW9QQzr5Ngskxgu0x8exg39KnyOPk2Q2+WmzCtZ4jV6O0G+ZhmRzoe0xXekLV8wDPgri59u6HFe38obnnhI1+kHUI0Oy4UwP4erDfwx2+mMic88VgWmj8XS9k9119CWHpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270320; c=relaxed/simple;
	bh=ryUhgsCNDGx5gbbrL8npKIlZP4HbA/RF47VqqKRw4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A6r8okxPOtETW46bJGoJs5Vs4Nwry61gb90gretRCJmHCInw+Ad5pG5IQ7rjjFKlr7KiLXrjfV4VSJdTjLAIoGMFF8D9l213rlnz1yBQHHDZ166YC9cf//7geK3ZRFu5YtDgH6Xgd4Bjzjl2moLdXGqiPYgol1fEAOos3OXZBnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TPegRmE3 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxsBGgAwY2OgO4QXRPJgluiJg5ejvTOrjvQqQv3KtIotWX5/m8YYbKMEif6oLb9MhmIMubDykDQGCOxa3wiP39SrckznseKn4FKngVaTrhTWKUr+LhLxXRLfcQijmpto/CA00S1MiXbwZkoEYbq3nh4aJn5V5moD45Wz7AAdjfF+nNDWYGdPbkqOPLyyOgf6S+hDfat2ii7ANzSFQKUSkmx23zUCJ0W83EB87JTTee51N6W9CKbrRAWz6L3Wi/HBZuATqpLxftbFF//0aqPGkcjdG5KBeJcUEvzf2qC2MedQ68PFtK+bHEMgk1M8IyPoKtmsyrUn1oQ3MEZlizpH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxduX5/36sAf/0lkwY7mJfeMmDmDUEM1nk8MM1kmVW0=;
 b=mAPpRDljUE/5G24iqqFiuByRA/qNAojNoqiLmt08sgHHqrfez2eHkVpitbVRjBYttaMsuh+DBEFUMd2flCzkPIycj1eqghF9n2P2i2gOdUxZIT/zviUbd5QROi4HgocYS8ds/MgMD3sqfgAEXVAV+vmy8FzTiZSwZXZZWZ9hOnDjtaVP7uxNijsonB2Ss3PPYwFpj7a4ffq8bzyW8k51//9cyj+OxY/5dolwjDlLNy2C8QS0+dbZreC90goFaDbwQGRDm/oZ+91o/ekBn+7Aw7xE1f71aJKQb67xQjA+YZiX0+SNcVsDRYxVbsU6EKMla+lcSFXcpH6eKcISNQg2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxduX5/36sAf/0lkwY7mJfeMmDmDUEM1nk8MM1kmVW0=;
 b=TPegRmE3CK+cjYAKU0p3nfIJ35+VBKkeL1RItKzrAf0pqtTYsKHM4+xmZ92TCk4kLR6aPZ0Fjlq3lW/3uSBJIO7LdxqvKKnNtlOyjOthpc2+Hb/Y3zio394Ah/ECSR4B1TvbZt6n1B+RUOLX+qzeyHIkXcRdUTrQvFRiUCd7WGQ1YU3JQAczrNIbBRN6/qmMSVyMrfX6umClNOew+jLvNx0KFMwRdP3n0ILeLDOxE0CDs7frLu5fR9dXV/9rMDSpPBZ7cbSjCA95DSUkY1venSOefcFfFj14bGGKdYJZDbxKS7MmB9VitvL5rz/ov8WIXBYoShiH4Wc+whwRtedVtw==
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by GV4PR04MB11796.eurprd04.prod.outlook.com (2603:10a6:150:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 13:18:35 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:18:35 +0000
Date: Fri, 12 Jun 2026 08:18:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: Consistently define pci_device_ids
 using named initializers
Message-ID: <aiwHITm9hbZ68LlQ@SMW015318>
References: <cover.1781161455.git.ukleinek@kernel.org>
 <c355276dd152ef312c29f7b9758a68f94aa77086.1781161455.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c355276dd152ef312c29f7b9758a68f94aa77086.1781161455.git.ukleinek@kernel.org>
X-ClientProxiedBy: PH3PEPF000040AA.namprd05.prod.outlook.com
 (2603:10b6:518:1::4c) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|GV4PR04MB11796:EE_
X-MS-Office365-Filtering-Correlation-Id: ae50b241-1f4e-44fc-ae5f-08dec8851b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LKK3J9JisTFrFbPHG5+l/G2n48o/7IRcWa3Xl6vy0dmd1aeEnPXZ1uCbpPFrwDw0ocR4h7LWH2PO8NfWrbgXraB0jQN0DEdjYLp/WWxMeUgD4Shs45Hl4TZ6dbRTzwn1Xh24x/9qp7RCtANtrwED4dSxRw5WnxbOulBq7pLL6eH3A2+o5Dz/mIokI53Xy7l9LP/0Fjcx022ys+4P1PDBGykwIbQKVA7ogtzaVtLElQi0/jcikDgzpWT17FkjoFgmxJQnuH9TbeP9PRZntBSLXZk9yrYJoh5YPMUg7jFGiWTQKcNtNJHa/E/S5QW7fe6xAqErGt0XVQ4QyjXS/0WvqoNptpAfCpHXJfaTkUQl+l0AoPGS1FdmjDPFwQytsSC+MD6L7koIjL4FO+qNo7CDLrwGTIprr6Hiz/ejE5N8gG0akjz9lvqJRt9u4GZT4jyp7aI2q+NplJ9M/751D2PxPksgmShdDh//5MlMEAaCptP3h3x1OiyOZnkduTp6kaBA7UWxOGZNKSR6wIm6XDzJBPC35iprSrzuUzAm0hFWFZnRbPYAYcOVgxjQuy03vlU06m9jTqhw3VQHS9sdYpr5yrFGwlqsWxMNJ0DTaRUh7Tfp4CMM+mZ+ntBV8ryU+y9/N5kybEezRVs8ktRBZR/XNyvZXGEoOclHbESirYF5cVf+QvSOBWtGq2Prip+D3fq2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?su0JtX25uBaVwGKHC2n2wfLkBFS2sNkQzsYnW8z5ZScN7XjE/gavLHUagP?=
 =?iso-8859-1?Q?gt82hzL2rZWQxBEv/yXiGalZVElVe7tCdT0IV2oQZ8L2+wIvQ8x/KR0uyC?=
 =?iso-8859-1?Q?birhrHYX44RGwKMbuLGB52hvUh38jUxUq5/XKNBq+wfS2ppyfIInv0o00b?=
 =?iso-8859-1?Q?R9S7GgX3OtNJE99K6WKRHfo2Pr/gT6Trln2dt9hshAjYDNtuMm6M9QNWDi?=
 =?iso-8859-1?Q?t4z8Ixa2BJ3e8udmR5gXmh0YhS95vHpo5fKJA81ZxTwJ5GdMlnzVDapdej?=
 =?iso-8859-1?Q?wmxOGsC3D5l5mDGYEcJJa2PDFeteKjtmidY3PYGczLSd9PyJqDmsnEXQf9?=
 =?iso-8859-1?Q?hFKqDJkOw6a0fDaSapX9lRaVOhIv/uWhOO0Sab81jrkhhQI0zTCID0FEhB?=
 =?iso-8859-1?Q?2EsRe7ZoJnw43s+Q0BeLdBG3w5Z8SIQypy6gW4O9R9kgnaWnhxv9iA134B?=
 =?iso-8859-1?Q?Hzj8Zdc/UAAV0Mx9gdXWQBcoMH6S7M1VaaJxmeKWbRs86sVJh4bIKdGRQy?=
 =?iso-8859-1?Q?mrmFdUmhHjsWXbYv3VbtsHc4vbav1Oplvvpd+wXy4zpfCdM3AWWUlAGiu4?=
 =?iso-8859-1?Q?gO4kHNsPTTfnhwlsiYw+GD9z7LBoMROKWXYrxYMo2viLItmF5GwhhyuBTU?=
 =?iso-8859-1?Q?1cdjitoeNDjR5grLQZyk02EQwTyNUI+PXuqPUbqnzkXyDZsTGoD2dqTeWq?=
 =?iso-8859-1?Q?93TUt4T5E3zi9Kx2GK4cv7xPyHl3cs7x6oGla091Q/ea75Xpn4EgOSVM7j?=
 =?iso-8859-1?Q?chblgXDTRlJr5/FMj+rmA+7U+qqHQ5THSPd1ZJ3bysSx8fa0tXwTPmzeod?=
 =?iso-8859-1?Q?8prfWQwkfPC15FeAz1IPpFAQCll0dOzNXgsOYx1bTDWQuRuV00JAmsBGbr?=
 =?iso-8859-1?Q?aIqOSK/Aoa7LT75nbT11IEap5PslHlsBCyuTSUQYZOIoF9eYPomp+sl/h1?=
 =?iso-8859-1?Q?Zhe86yYLq9W7fcvJ9q39rlb9QBRxD1ww327owSoWDkn+UlGY3J0VqURBKe?=
 =?iso-8859-1?Q?x11hcQIdyNXdcwCrOXEcrZUi6Xz4F6JRaPAfPyAuTig4TKDZxs0hnFKF6k?=
 =?iso-8859-1?Q?UgR8AMBgmSM3JADzFGlWrHKich//AuNjEHuJK6+Ljdo/pIkrTkZlhLyypV?=
 =?iso-8859-1?Q?8Rodacn0jScuv5Fg6WHbr6No3yijm6iQr+XKltTaEIpphpXU98r9Apwplh?=
 =?iso-8859-1?Q?97dyUxGZP6JST2RyOmbHQZ0wxssXDcdP5747TLKGHQ4GAplI+1rmhGg0tZ?=
 =?iso-8859-1?Q?eflIgafaJ/zMm6LPBz5rRim6J+clpz4Le78LKlCUEbDsjbMPucX0KknVtx?=
 =?iso-8859-1?Q?AV/bFFxCSLfSEHqxNolN6X/0UNx6ZDQRV4SrTodgcHkGYGYEpGa1vuDY16?=
 =?iso-8859-1?Q?CXy6keghYfbdzAHBVi/d742zEN6TINfe28vt9N9RXX2wmpgq/Ag1GxyRIK?=
 =?iso-8859-1?Q?cUpB/OuIYiNXGwFNSD9Jq1ZFFvyGk7EK47Ye+zptHENBOAdQTkTITFETkj?=
 =?iso-8859-1?Q?3gfPjSAfA6FDYbmczqrr7MADlI7s1I63p3ynozN7V7Rg73M/ZBixjB7Vhl?=
 =?iso-8859-1?Q?uehDGDCZ0fSJ/nbABR3/oTjh4IR+OQ7ILNauKOIpgjR/M57CrxFiVnwbWH?=
 =?iso-8859-1?Q?qCkmUi8AnmXHAZQb8q7QvRj6qVqRoS2jJZlSY3/tQZ/zyiHA17j6aGtXh+?=
 =?iso-8859-1?Q?8IZzAeeWRC5F6zDJJ1UF8dh76XgxzevetyeiC0YbOJaN5H4jyNp56M8DIp?=
 =?iso-8859-1?Q?2Su5PrcUx0V/cjPl5dbND5PuO0pi0l+ppebKSWBMje6jxTdJ1MFkHGlE9X?=
 =?iso-8859-1?Q?AjSY2yf+h3WWT422VmKHOog6o4G02U3mkNa9+oIWuy/VM1ezU0vf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae50b241-1f4e-44fc-ae5f-08dec8851b6a
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:18:35.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezA9Z0cUC8EN5fBtbd7YSUJXzIszoh7NVF9XbzXKdJ9JeWDyU5yfesXTWI9Gv04beP+ZIUrnEJoSOLKkgcRWbJHhFYoU3tpTQGxYajKc53zBvnp4sKbxK99f8PE8zIP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11796
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11496-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:Basavaraj.Natikar@amd.com,m:vkoul@kernel.org,m:mani@kernel.org,m:vireshk@kernel.org,m:Frank.Li@kernel.org,m:andriy.shevchenko@linux.intel.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,baylibre.com:email,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98805679BDB

On Thu, Jun 11, 2026 at 09:45:10AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using named initializers is more explicit and thus easier
> to parse.
>
> While touching these arrays, unify the list terminators to be just an
> empty struct with no trailing comma.
>
> This change doesn't introduce changes to the compiled pci_device_id
> arrays, which was confirmed using x86 and arm64 builds.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/amd/ptdma/ptdma-pci.c  |  4 ++--
>  drivers/dma/dw-edma/dw-edma-pcie.c |  2 +-
>  drivers/dma/dw/pci.c               | 22 +++++++++++-----------
>  drivers/dma/pch_dma.c              | 26 +++++++++++++-------------
>  4 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
> index 22739ff0c3c5..0b226bec950c 100644
> --- a/drivers/dma/amd/ptdma/ptdma-pci.c
> +++ b/drivers/dma/amd/ptdma/ptdma-pci.c
> @@ -223,9 +223,9 @@ static const struct pt_dev_vdata dev_vdata[] = {
>  };
>
>  static const struct pci_device_id pt_pci_table[] = {
> -       { PCI_VDEVICE(AMD, 0x1498), (kernel_ulong_t)&dev_vdata[0] },
> +       { PCI_VDEVICE(AMD, 0x1498), .driver_data = (kernel_ulong_t)&dev_vdata[0] },
>         /* Last entry must be zero */
> -       { 0, }
> +       { }
>  };
>  MODULE_DEVICE_TABLE(pci, pt_pci_table);
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..a27112de5497 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -563,7 +563,7 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>         { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>         { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> -         (kernel_ulong_t)&xilinx_mdb_data },
> +         .driver_data = (kernel_ulong_t)&xilinx_mdb_data },
>         { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
>           .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_data },
>         { }
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index a3aae3d1c093..99565fab3565 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -98,29 +98,29 @@ static const struct dev_pm_ops dw_pci_dev_pm_ops = {
>
>  static const struct pci_device_id dw_pci_id_table[] = {
>         /* Medfield (GPDMA) */
> -       { PCI_VDEVICE(INTEL, 0x0827), (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x0827), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
>
>         /* BayTrail */
> -       { PCI_VDEVICE(INTEL, 0x0f06), (kernel_ulong_t)&dw_dma_chip_pdata },
> -       { PCI_VDEVICE(INTEL, 0x0f40), (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x0f06), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x0f40), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
>
>         /* Merrifield */
> -       { PCI_VDEVICE(INTEL, 0x11a2), (kernel_ulong_t)&idma32_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x11a2), .driver_data = (kernel_ulong_t)&idma32_chip_pdata },
>
>         /* Braswell */
> -       { PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_dma_chip_pdata },
> -       { PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x2286), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x22c0), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
>
>         /* Elkhart Lake iDMA 32-bit (PSE DMA) */
> -       { PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&xbar_chip_pdata },
> -       { PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&xbar_chip_pdata },
> -       { PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&xbar_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x4bb4), .driver_data = (kernel_ulong_t)&xbar_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x4bb5), .driver_data = (kernel_ulong_t)&xbar_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x4bb6), .driver_data = (kernel_ulong_t)&xbar_chip_pdata },
>
>         /* Haswell */
> -       { PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x9c60), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
>
>         /* Broadwell */
> -       { PCI_VDEVICE(INTEL, 0x9ce0), (kernel_ulong_t)&dw_dma_chip_pdata },
> +       { PCI_VDEVICE(INTEL, 0x9ce0), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
>
>         { }
>  };
> diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
> index bf805f1024f6..152939e7c6fd 100644
> --- a/drivers/dma/pch_dma.c
> +++ b/drivers/dma/pch_dma.c
> @@ -956,19 +956,19 @@ static void pch_dma_remove(struct pci_dev *pdev)
>  #define PCI_DEVICE_ID_ML7831_DMA2_4CH  0x8815
>
>  static const struct pci_device_id pch_dma_id_table[] = {
> -       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
> -       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART Video */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF SPI */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video SPI */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Security */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
> -       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
> -       { 0, },
> +       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_data = 8 },
> +       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data = 8 },         /* UART Video */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data = 8 },         /* PCMIF SPI */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data = 4 },         /* FPGA */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data = 12 },       /* I2S */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data = 4 },         /* UART */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data = 4 },         /* Video SPI */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data = 4 },         /* Security */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data = 4 },         /* FPGA */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data = 8 },         /* UART */
> +       { PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data = 4 },         /* SPI */
> +       { }
>  };
>  MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
>
> --
> 2.47.3
>

