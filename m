Return-Path: <dmaengine+bounces-11495-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mXY/OvgHLGrTJwQAu9opvQ
	(envelope-from <dmaengine+bounces-11495-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 15:22:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF30679BB5
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 15:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xE59fQNl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11495-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11495-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E6A3210C68
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9453ECBF1;
	Fri, 12 Jun 2026 13:17:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7793D3486;
	Fri, 12 Jun 2026 13:17:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270235; cv=fail; b=ICVwxqJ8EnAY0/+foRqRTa6ISQNxdL9wuk61p92T1RxP97aCVxAcjFULvRfw4oubGq/bXtWOCHw2W3JULwcs5ZwkICyOnsETxPRV4eFXrjWe0WPtrqC5n01roWSAJqNnG5PtZAqeaq6BxVWVOfk758ExK/np3s31Bw4a/tyOM5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270235; c=relaxed/simple;
	bh=sVz1MPcQkcGYFY5OeT86p1g+pxKoKYOxeGJQYw9R9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgyCpZW5/M9pRi+HrgsK8uV25NpLkPhB/xWgBX58ClNWViQACrH+tvRUlyTCghVBU5W+XnSFAF4/tbBh9co+taCQXbmsRGur1w99DMO1YmsyVSy1/aIyXT5DMOIpurCiu6WlEGFb99U6vcmBTPiNRcgLUkO1q00DPFJeHfADQ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xE59fQNl reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaQuPg6M7rOkIafXVgL4sYz8f764OpEEq7maComrkQFCS61qQIL6tuylxH2Ad/XCM6FG/J9o7RxFWeZw2HES0aCeEtQlHImZMVaa+HBhT4Mpcn2IUhqLQMq618MQnKPatTGSUuBqDdktjTIB6o4ekCdZWXpLsx63pT37kp8nMgnPLravpnT7pQgKtcGZ6IsO4kR57rrncv5dHTmu3xgJ7U/RYJGOKgi12CpxVHPWAwynEXBKyHVitZVirXhwOtAO0RYmJC6TwJ9xmXAbczlDsbfNCw3ATFBRSRfNvabGYpwPxhq3I7JB3ffKMqvQAI5Wb6pzrImwDmhfnfkr16enGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udhv/F3DeLpY84SWwCscZZtbV7JawmvXGYektRPJxQQ=;
 b=No2CjDIpDSt8RfddLS6h9aiDx+e+sVMYn/GuWMIxIlJrg7ZJgJcv9HLTLp/LQozYshVHvPyPnQ/QQQH2v/iHZFsqkdNPh+1OBaUsZwjwPLfDI8buEttxKxY2zzyb3M+43Qj1+S4WzK25a+Ugf9V0VOcDkavNIixyMmgIKOVFKfkpshwbncbllESgaTE2STxeiG9Tk2yFYGEXvv7Qm/uP5r3CeRnKZyA95+73a5Wh+uBANSMfzULDUpDRFbnbQeCnQ7WLThA2d7dR2dmpvqJp0lHAWRzzMvBlYGpH/PKlc79nDghQ0qO4GKpVk9ZheCmnQwV+lO5x60kPjBYPpTdi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udhv/F3DeLpY84SWwCscZZtbV7JawmvXGYektRPJxQQ=;
 b=xE59fQNlqK6jU7edOpjM78lcO1JLGnpYn/dildD0LJGkBJYc6Jsckda1jlgNCl05NgqRr1pcyNMoagGmaZT2/J2tHVYdOksiX4h7RiFtdvEpTeaLTqsE+kA5iWkKpAGY4cCfqLWDkVwCnQRyE6+h2ewEg6TrSv4KwJsk8j0KGi07APi0pwUp5GGk2ssXiWFtC1IpRWao4E6/1XRU+585BOeP3/jaaJN8A84gn2dtWqkrWXS+UD/6QMVJSpvNZfRqe0LBTdaJ/2tUwcOhRjdBq8sAIcysrj2mraIo2VjqLWoUyM618Wiss8HskkX8Wodf7OyLcLRb6YPRwsGTA0+XXA==
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by GV4PR04MB11796.eurprd04.prod.outlook.com (2603:10a6:150:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 13:17:10 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:17:09 +0000
Date: Fri, 12 Jun 2026 08:17:01 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: hsu: Drop unused platform driver data
Message-ID: <aiwGzcdMzBk0lSU5@SMW015318>
References: <cover.1781161455.git.ukleinek@kernel.org>
 <86a23025da12369034dc7444f43a7763f2e515fb.1781161455.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86a23025da12369034dc7444f43a7763f2e515fb.1781161455.git.ukleinek@kernel.org>
X-ClientProxiedBy: PH8PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::16) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|GV4PR04MB11796:EE_
X-MS-Office365-Filtering-Correlation-Id: ef11ff6f-e7c3-49d6-070f-08dec884e863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LkjK1f4HsTPVefPjA0JzcoNXqOF6Z6tjTwQtTvfnDKG9gUY1uocXVB+Cj0BSF5RVvLWCgS5Wqr8o+w8gz3Qndn0MwfTidgpjEuTwbyNFHtIr9JP+qEYfuOQgvbtr/5e/ZI3n9t2qJkFnRjfIrseAQyAiLMBhjp8KG57u5vdvNQmrDZ65iy7tqb0JUa7k9Sld416Toh+fiEc3rO+/kbZ7N8UUG3AgT8OgIpqR7CnrHJA2krLghsZ7Za+FWIQNtgHqiImisa90uIE7bUcBkVN8KCXm2BKluW9DifXWAdDWYT/rciNTGFULrpwlixN+dRL8S43sGLLbCeROqetZ8wtdx74oj1xGlMUZzmv7QuIdKh8FFvwXl7VnxRdBZ7FV1zuViiH0uqjKfp1+aUcnyM+9JWjIN47KK4QMUiolRX+OXcUV5RdPDHB3cbNpldzx+NSVVthquoXU33bl/vg4Jq4RgrW6w44NgTF652dSSjcy0ooRVZQH9SxwF1WpTsntkW7iP8Xoxj2zOZlT8RKe8mRyfQRtd/8N1iQakXIicO2q57lEyYzkm8fxNHUoHC4GnpOi90naRSVsGQJafyr0Yq9kA2cIUNdYzHD7qmsyaUv14efLazHnzK2XeTXYtNB34sflkePFnLoxa1Plh4ksWBYu8HNhmMnEYvC08D1RYWgRUiwPo3fhA+E8QiODjM9DsISD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AiPGG9K1bXMIydPfI3GMPzkWDNEQ4a4r2XHrpPoBWag9C7jG0tljjFwlG7?=
 =?iso-8859-1?Q?Iye27GeQSKdIEzTQME/UWX6c1Ie1ldMZhcfiRLgwAOt239g5RKJVtGbI88?=
 =?iso-8859-1?Q?TgpGO0owkF9dvbZIxRa9/JKZ6nQSdaYpNjhCSmQRpaSfG5WEqTt50xhblR?=
 =?iso-8859-1?Q?jLqF8b8Z31CuR7sz5T4gBo/KVm84MDdzBypBOPOWH/mZ/lpvfJWCWj9mGK?=
 =?iso-8859-1?Q?lTo31DnnqcOOfdfqgY1KGYp81HU1xWVi1nO4nip4/bNcysw2hAhR8Dxxib?=
 =?iso-8859-1?Q?eiIIMfP3jAoomCN1C5OpCueuHwYGkc7ZMJu9mOLGqRYswZMN1nKWrYZCyC?=
 =?iso-8859-1?Q?4z68zCRcvhP3Jxbcsk0xImVyj4omOtXn966X9Up6+95UtUUKz2qI0aH2Tw?=
 =?iso-8859-1?Q?SSAyU7yPpbZXvUIAoUHKOKtUM++COsij+8VmzPzbKFlMHi46MgaKnsqyAH?=
 =?iso-8859-1?Q?Cq7Bo/FTbrE0I3ye5lfphe6g88ew0lpn/XpqBgqYdLZ1XUuiE6KWff3kZU?=
 =?iso-8859-1?Q?7yaPVCAbAHadMb4tmyUp8jZWDzH0uo+AAOGId5Q+7Z0BYWM6cSa7lE1jrb?=
 =?iso-8859-1?Q?RwCXTd1T1+H4kGzVP+wvGWe7CtrrqdefVmg8HlMUF64YbzIQnmpDP1HyIS?=
 =?iso-8859-1?Q?XQdF1kh/4jIko+1NUiiDjQCbj5m8lnCS5ADkdAu5rgdw3lcJVpCcbd9U9T?=
 =?iso-8859-1?Q?xUbOFt36pJz3dTiFnXIGDa1xSCu270kV8XludugIVW3ympkVBl+rxIJQiI?=
 =?iso-8859-1?Q?X2t48AzU8StVqMzgjukVZtJmpq9KRBlj7qAIHugx8VcmvCd3JaL84qZMFB?=
 =?iso-8859-1?Q?QSUtLbgdFBeFPHCsYdkS1tjRDAAfeUzCIOlEPeivjg97xkAvbxRyRlI8FA?=
 =?iso-8859-1?Q?L+wVB7fs+UUCrWBmgQyXAG4JJhXT5hpJfCfXCzc23OGpwDM6I6kI0fv8zB?=
 =?iso-8859-1?Q?y3WD3rtoG+9VkWknKPKXbikN4cTITdAu5TVuufYeMHR+r/0rMAr42mzTfU?=
 =?iso-8859-1?Q?tRdjXUIwaR4/TL5XmFpFdfctmn/lkHpXSZSWxpmZ2PGauQHtuL6LBYLXTH?=
 =?iso-8859-1?Q?FsnQKVbjbFFhVh8uTDCL7inkE+Zwsa+EpeUT7sCRO39Oj4veo0hgLeQCSQ?=
 =?iso-8859-1?Q?aYZ0bcjYE3za/SI/LUDCZkDzqGGza9amNZSi60wVj39tI8e55TviCoUoMo?=
 =?iso-8859-1?Q?ezkM2fvi2c7nQwkRKUk+vpmnUCkxtaQaGILj2MCPFGXYxJHoVATxqky8Nf?=
 =?iso-8859-1?Q?NcYoSvVrUhHk2GhbILOLdyYnen4ICy4xF/R4CVCBaoZo+a/uTMbnM16e4K?=
 =?iso-8859-1?Q?rSEnY6GdM+K6jnrrf5RHKpxhf/Ivdtw2EtvcKSn36vt7DhHO1f9x9bvtnN?=
 =?iso-8859-1?Q?DhNyWL8pszy08XTSvh/SxLbSMS60SKPn+bkxipRY+/CyoNxl+w4erU/Zuj?=
 =?iso-8859-1?Q?Y4SNkdP/wc2uNk0VMF0fqBq8hfRgdXrr2wU9R7+k+7OtjmYXwhCBYnyIHQ?=
 =?iso-8859-1?Q?zXxOlW8YkTnhtyMfnINR8rGxj1hfBiCA/quoo/9QrlgphcBL4fklchjXuq?=
 =?iso-8859-1?Q?4yYl7niFYehVbYy0UsdJ7S2WvcyZzjAPngvmBEHeyupPh46WD/SdPArxvo?=
 =?iso-8859-1?Q?OihOWx33m2M2waB2xp3CvqrQZnTvUVeSFAIA+Yc5NZBrUrvKE7MxZqYWcA?=
 =?iso-8859-1?Q?7PBV3xAilVph9weH5vuj+O4qMqZIK6f7J4ZtBNzVrxN8b7moX0WpZ7ao2z?=
 =?iso-8859-1?Q?L6xSBHEOTRW4IDSLFNNudc2YjwUm+Mcd+EvysYHdrBnRhR2r7xGnRwM5QR?=
 =?iso-8859-1?Q?SVhelix5q38RfFLy7asUPDEsF3K/sAlQ8fBTuk44vE395QVhCrX+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef11ff6f-e7c3-49d6-070f-08dec884e863
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:17:09.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byo6JE+jW8hY9wCfInys9Pbrp8dy9xV4OssFUyFO/JAovjJ6K9FFIG7wImyFcmghdfM9A6ZnG3CvEt2VCSGkOhXwuywd2R0JhWG9t01l2mLYlkP2sT1PweU3XN+RTvqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11796
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11495-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:andy@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CF30679BB5

On Thu, Jun 11, 2026 at 09:45:09AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>
> The driver explicitly sets the .driver_data member of struct
> pnp_device_id to zero without relying on that value. Drop these unused
> assignments.
>
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with builds on x86 and
> arm64.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/hsu/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
> index 0fcc0c0c22fc..b42c9c0887a8 100644
> --- a/drivers/dma/hsu/pci.c
> +++ b/drivers/dma/hsu/pci.c
> @@ -116,8 +116,8 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  }
>
>  static const struct pci_device_id hsu_pci_id_table[] = {
> -       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MFLD_HSU_DMA), 0 },
> -       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA), 0 },
> +       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MFLD_HSU_DMA) },
> +       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA) },
>         { }
>  };
>  MODULE_DEVICE_TABLE(pci, hsu_pci_id_table);
> --
> 2.47.3
>

