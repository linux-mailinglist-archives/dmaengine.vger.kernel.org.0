Return-Path: <dmaengine+bounces-11792-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mwl5BK9RPWr+1AgAu9opvQ
	(envelope-from <dmaengine+bounces-11792-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 18:05:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5C6C7487
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 18:05:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=aM6m2Oy+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11792-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11792-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46664306361F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11A3DB62D;
	Thu, 25 Jun 2026 16:03:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5F39B498;
	Thu, 25 Jun 2026 16:03:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403417; cv=fail; b=TrUWaN1fPGLGgl7k/WPSrSGtgSHXxx7taBhrPNWBfB9K4CPZHO4Gmm8c/LFJr3u8UfPUVuQxaJBcIu9uDYly4q6IdptU4Cbjx9uMvkqj1f7zMZzQNNXagHeLJ45KLWiI5bKp7InjaUfcN2poow6UJMp7lxmtNPMk35cLxAPRpQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403417; c=relaxed/simple;
	bh=t1RCsCsS3VRbcjDemhJT4gVV6IzXDbBXzTW6wzIU0qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uehPDM46ObBbg+jpPQO7AaEiUjLsOHDtQOLrpsfxcvM/PBx/N89+6SGxCuciS+izRR0mTa3Jqs5XxyvG81NhqVa8cqrSxXleb/zxneob5uN1sfCSqLtIoH2gF3knY8yEIhM4x6yoBZmKzHQSaGqN6/GR6quFZv8Dpn6HwVbXR00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aM6m2Oy+; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+TfrD9p2VEjgq/XHHE2lKQq9ozFcWKYTmLV/Z20H3nzCdqlTk+ikXcPCI9EA9s7qjEA5LZEJ8+4ofSskqhOb7zgp35CalYrEkHLhiluX0M4xBz5BSsRU1QNfiR0udVBSfcZoygKsSp3ZJMCJRQ/dF2vC6hRue0IuU1eB63B+hV2cfcYN+EubM/wyZu4qqKYBpq6d8QOwgnvTY6R4gGiO4y+pSAT+H5DcA2vkJhAdtupG7oeGgP8fhOsQnmoHRXGV6dOupL1t2FjU1ncltl55qFLGfQEr3y6JPpduhlA5AlguaoweFj/KUs3CZw1xbA8QB714hr+bbUBdVmnkyFtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqZ2wO48UYLxlaNbThccYzBuNYAooHb+dh5RphM+d8Y=;
 b=rQMbW7iGxcs18cM/boTRkXoDs3LVcBcfsCY2boeUvrhbzdoDMitpcv0i2Oe2mjhmAG9pjfxN/Bo85y514oVi06EuaQKD7gP8BDdW28P7rAw4cDmlQaEQCirAUA+Cwagsjob7zosKLRaAQyFZrw1aiJLkCeswDBZqL7SnUoMYm2MZ9C5GsjcmNpU9q7oSIwfVd9/64rhb3uNxFaERQlCHJzH6KxXKBvqTo5LqNYAP9fXxhSzWUodk3SRcQH5wJgvpQ+ro7wWDEptdaLZfaApBwDd49/qpOJWwVHKoXxRa/H/bicdMzkRRRhWs9CTZ4wCfVvZuX1gdaG4Y1MHqs8ZN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqZ2wO48UYLxlaNbThccYzBuNYAooHb+dh5RphM+d8Y=;
 b=aM6m2Oy+YfUquqo+pMN9TKH5dv9v601kk3a9Ir3CwR8ql0SCt537jhdI5eycPpbIvnIv0TKH3P3/6Dr3vmWzraFVxG68mP+XE6hwa5/ukj2o9XyF3zRWvfZi1yPgs8Exql7KbyHZp0GiDxjx4swo+Np2pa5WvETKZtMH+iFHA61NSrl/XBoqXwmbmFRU8g/qZfDuuuUH3E/CroXbblUbQKHXYR6Wqdc+KEQanW9juFpJdtxCYgyYXFN1Lif4/6ANv2ng1v+uBgZ3PXXdj22MNA9gt3jdZmH9hp286Nk+hBr5BBg8vaiBTrdYlOicWmdq97MR9uqPi7QMhZ4kmf8C0g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9992.eurprd04.prod.outlook.com (2603:10a6:10:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Thu, 25 Jun
 2026 16:03:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:03:30 +0000
Date: Thu, 25 Jun 2026 12:03:22 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] dmaengine: mediatek: hsdma: fix runtime PM leak on init
 failure
Message-ID: <aj1RSj5ZXvc-9yu7@lizhi-Precision-Tower-5810>
References: <20260624081701.19358-1-mhun512@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624081701.19358-1-mhun512@gmail.com>
X-ClientProxiedBy: PH3PEPF000040B0.namprd05.prod.outlook.com
 (2603:10b6:518:1::5c) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9992:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e24da5-ce7a-44b7-eb96-08ded2d34c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	thkr5k3GyRThMpNt+9y9i2RaE93mW4ErqoTYDAVFh2B+Ye/NXpVAScxjs7yN/Ts3mRGt1M0JDdm+lKmmc8qD5ffGy6qu/MU8jEpKTE5zEeUo00uviZafHcLGu+cO8J3oE8MbZVrRGziKu8cG59CEfhJO4DMJ17nkzRMZk2jkXZtLmr6uEXYE1eTnX8MAfi5s915td9e1gd9Qmeer5ygrkvYzXM91e9AkgX4rtpWJxNC0Dqx7WQ5v9HVARPYDKiY+d5gE6tKsL27mqd1EuBAOSKFMkELYMi6YlhIRHUyfeGRyzkwckrvmYoiZW/aDHWK1bkR2sY2J6YIj+gSylel0QRywHXVGSK01OeI/VoghwyNtL6ZtcCUc1tUiMKdaOrkKNvrJwfZswyOUUKK2Z4H36eGMGntJlWnQNCIuoRH35zBQ9+x5aFQL+bqBK4wzvOZCwCQ2Ps7I5NIDBSMSWzGyCvDYGlI+TSfZOfEAOzUCzpjQT3i84vhEoG5O0juUUQAlXVvnQyokONtmyEHC8nXKNrpx9Axzv549y5yiRjFh5iOvR3CQNpb8j3fk2G9c5FDsUfdje8NUdXd15sMnBI1U7usoNaGr1u17kXQOKgqi8mqwdeq0rE5r5hPY9Djo0Yn4Bk0l4KygNz+1HXTmsa8tPEp/0IVUzyWcOBGoBCIsMYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q2RmVqq4+pgTvL9VXgWrdPo7PGa6IQhREBx66SL2PZxP/fVhmexz9bvNbFQ2?=
 =?us-ascii?Q?DwEz9Zpk56r4DbPbziNHdw//lj4WdNfyA01IsbPKR2LXLGQE5ohlMlIUFZIV?=
 =?us-ascii?Q?Bui2Rn9zxKKQkKAl3pi7yjQdRJcT+M17nlXdwtOmoTpvvY/o9Ezh8cjTM9j4?=
 =?us-ascii?Q?XkRciO+PHr+iT7uvttqv6/a0x4uxZMB7DqZekvmVTZXRU/pALklDRJBzEmuI?=
 =?us-ascii?Q?ijuf6ZsC+qI3MZVY7wRrWRwdx5jt97g9hnIyfR9vqBrCyEWI3Ujya1TdLWAD?=
 =?us-ascii?Q?tzbzz7wuLjWIYPrxUbAYMn7J/wo2LWMSjMX3BSa/rxdPq7fbrgZr//C71kw7?=
 =?us-ascii?Q?YkTn2Pg3fGTmcRNGOxBdIYOu70J6zxqM1Ty9IrSc1XX78HCcmhAc6yqF1ltF?=
 =?us-ascii?Q?GQRqC/Lm0RKGLH2LTt8WrAWYpDZ8KMRj7Wu2KpCcEXCnOmHqaAl9z/P5jms+?=
 =?us-ascii?Q?50Am94JfjkiPj2XThiYdUTRHNm2Kuv5ZdW+z4c7OSy6YbjL+om4bG2DJ6VWV?=
 =?us-ascii?Q?OPDJR6SXkFdfla8km7BS30VUdxSvtstxBs/8b10OFtE8kGKueRzQK119YJiG?=
 =?us-ascii?Q?Ze4P6wBw55mg1ebYO+qmeH9rvzt9fv2th84DOeWsU7ZGOZ91P3iYhhGTaPUy?=
 =?us-ascii?Q?x49IG2Sq4Ic/sqhqskxEE5trikmPummQCTmDUC4AHudIJ7n4MjIlYc6HT7gv?=
 =?us-ascii?Q?pD0AS8EN5YqZTs7+yZJK44f43Ite0TkovacCnHywIzohcL7TnaoUHi0akZSp?=
 =?us-ascii?Q?199crC6VZrBz8XJdIONPG68W9LuSbzkIsmoz5pjdTHrohi16G7zzCxpk3e+S?=
 =?us-ascii?Q?/Jrl2WiFYq/o58O0mn6sagM0mZIKtt2kqB61PV/9eHBuxjJ9vMIIIANVhnbI?=
 =?us-ascii?Q?scvljEbHIq7MZ0DT6+CSoSFKszrCRl3/4HdniqePhtBKN8g9aEHE7CjTXApI?=
 =?us-ascii?Q?mxdo9Hg6+sLC7BjZz312agfqztCU7yezk/JUVoSBfoR6Yan0douTboab51HH?=
 =?us-ascii?Q?/Awt5OG8QLhgmFW7J7Zz6QIAvcNwcpUCAAxJDquZKVQ+FkCdEObijZ+AEX0C?=
 =?us-ascii?Q?Jjhl8MfROEvzb/0wB1jx1QNK9P1sYazocXARfbuOMtjVw0AMM4M4wf9u0Wh7?=
 =?us-ascii?Q?5dJ+nbnFEGkmtSM7o7UeweWoZ6/WLj+oqf4suiPm8MEYpI3XqPwgSft0bBee?=
 =?us-ascii?Q?5QknFiyB50HJ0/rRYlQ0aB83X+xt7onDDWjcfIhoaJ14K1ACxYD0pDn5dsv+?=
 =?us-ascii?Q?5LKmMTHh9vbgb3uUb2LTKmwewrer2TP/VPceYuz/zKScAeys7G08+2nVPQny?=
 =?us-ascii?Q?tpm+k7RI3LiEXA2Olbgx5WC3jrSJC+BNqfY9cBfe/dDvU3zcAgJ91Y6mXctz?=
 =?us-ascii?Q?TXKWYQ5aiIyImRKP5gqYoQ7msQRjdGEPbHX1MMZCay7oioKlx0ewCOlGOVQL?=
 =?us-ascii?Q?3xaPBT0wVu/zU2ds87wKBv9fRSHNUSm/pG9AbCuLqxKXLbpxuOAp6Pg0DdWv?=
 =?us-ascii?Q?8fePbHgSl4eZk/vWwC7XIQlTutegU0WU8RQ0ag0ZTAYy4kY2q0hCmx5nyu+i?=
 =?us-ascii?Q?4/YgIfdMMOwP5yM/D+6gAucdaqEpIDxMwEzTpqXnGvfAokmVblCpCOVse/ha?=
 =?us-ascii?Q?dxZjVpLtGSieI15WcEa0N5miOLb6NiKW4JqcqlWbnUAb/nbGM3ug2F+LAeXw?=
 =?us-ascii?Q?h/ziPhXvg9Z4DEoZHuuBWkhUajNq0Zlcaj8Z2GC4kctnmk1x0VDduqlMmjfY?=
 =?us-ascii?Q?1B8Nn64VpEQmey1ihT2VnRoTJcgGsDuv7EoKd/qpomN2vQ/VvlKP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e24da5-ce7a-44b7-eb96-08ded2d34c9f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:03:30.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7YJLh4OvMkPzLmacvu4eD2FgPzjBcuF2VauVa9IH4gu2N0zrTigenRHZL+GdpKEPOEBWBct7tQUKjkuLRt20hbWubpYZ94IMlayniHp3oox6FgNa9gSPW1KTNRA23VF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9992
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11792-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:sean.wang@mediatek.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51D5C6C7487

On Wed, Jun 24, 2026 at 05:16:38PM +0900, Myeonghun Pak wrote:
> mtk_hsdma_hw_init() enables runtime PM and gets a runtime PM reference
> before enabling the HSDMA clock. It currently ignores failures from
> pm_runtime_get_sync(); if runtime resume fails, the usage count remains
> held. If clk_prepare_enable() then fails, runtime PM is left enabled with
> the usage count held.
>
> Use pm_runtime_resume_and_get() so resume failures do not leak the usage
> count, and unwind runtime PM when clk_prepare_enable() fails.
>
> The probe path also ignores the return value from mtk_hsdma_hw_init(), so a
> failed hardware init can continue as a successful probe. Propagate
> mtk_hsdma_hw_init() failures from probe, while keeping a separate unwind
> label so mtk_hsdma_hw_deinit() is only called after hardware init succeeds.
>
> Fixes: 548c4597e984 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>
> ---
>  drivers/dma/mediatek/mtk-hsdma.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
> index a43412ff5e..987e5274fc 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
> @@ -849,16 +849,25 @@ static int mtk_hsdma_hw_init(struct mtk_hsdma_device *hsdma)
>  	int err;
>
>  	pm_runtime_enable(hsdma2dev(hsdma));

use devm_pm_runtime_enable()

> -	pm_runtime_get_sync(hsdma2dev(hsdma));
> +	err = pm_runtime_resume_and_get(hsdma2dev(hsdma));

It enable runtime pm and resume_get here. and suspend at driver remove,
so whole life cycle, pm is enable, why need enable runtime pm management?

Frank

> +	if (err < 0)
> +		goto err_disable_pm;
>
>  	err = clk_prepare_enable(hsdma->clk);
>  	if (err)
> -		return err;
> +		goto err_put_pm;
>
>  	mtk_dma_write(hsdma, MTK_HSDMA_INT_ENABLE, 0);
>  	mtk_dma_write(hsdma, MTK_HSDMA_GLO, MTK_HSDMA_GLO_DEFAULT);
>
>  	return 0;
> +
> +err_put_pm:
> +	pm_runtime_put_sync(hsdma2dev(hsdma));
> +err_disable_pm:
> +	pm_runtime_disable(hsdma2dev(hsdma));
> +
> +	return err;
>  }
>
>  static int mtk_hsdma_hw_deinit(struct mtk_hsdma_device *hsdma)
> @@ -983,7 +992,9 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  		goto err_unregister;
>  	}
>
> -	mtk_hsdma_hw_init(hsdma);
> +	err = mtk_hsdma_hw_init(hsdma);
> +	if (err)
> +		goto err_free;
>
>  	err = devm_request_irq(&pdev->dev, hsdma->irq,
>  			       mtk_hsdma_irq, 0,
> @@ -991,7 +1002,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"request_irq failed with err %d\n", err);
> -		goto err_free;
> +		goto err_deinit;
>  	}
>
>  	platform_set_drvdata(pdev, hsdma);
> @@ -1000,8 +1011,9 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>
>  	return 0;
>
> -err_free:
> +err_deinit:
>  	mtk_hsdma_hw_deinit(hsdma);
> +err_free:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err_unregister:
>  	dma_async_device_unregister(dd);
> --
> 2.47.1

