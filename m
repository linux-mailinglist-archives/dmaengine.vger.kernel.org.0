Return-Path: <dmaengine+bounces-10276-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAGLKr3e/GlFUwAAu9opvQ
	(envelope-from <dmaengine+bounces-10276-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:49:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279934ED9D8
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8521D3007658
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF843901A;
	Thu,  7 May 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EEkA/OMY"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B740242C;
	Thu,  7 May 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179765; cv=fail; b=oB6AoXa35xRZ6cRkNa48PJM62PrM4vpQwWzOLBwJfDiV1sv+pwtO65IWOi5PubCpMQ93zi7DH/yoI9Alz4TXtpGlUi0dVGEYnWjMVa3FzGs/Wpag4vQ31RRtU57V+t693jBa1nj8yD8XdN6gubPxDsMcPtwiazriyTicsizcbf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179765; c=relaxed/simple;
	bh=kh30jN6uu/PMRFQh5fbxq3kY6nTF5SoBzD0KN6eLSMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DH3Ghmwxo3H9f7s54mr62SRkPSpE+AuAONHNoDo1ypejAJr/ZpaWXjYnIRq4UfR5ymokiyQo29VFkAFBS0RC1iZtVaftGWPIA3UivxWA5C+7A5mM4t8TF1LWssFDyM4hmKVwVeaEKz7OjTcxkswceo5Dipf04lDD+juaK88rBVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EEkA/OMY; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCM3tCKhaHC5AwvmAUub3pMVAuTIq1i2AnBxegy3O1QRKwusbyO0FPldfgzUKH+znnDS5oNACLz6eCgJbG7fuDKXFezwh+JzczNhD43NR4SMbc/M/ENYStGHiDB/R2c4gxsC6To5j1E2G2mIv8eIsa7wr9FOOY6UOU8uCTmnPUa/es8o+M9enYpenwk4IBKZ6GbvpqgUZLw/uLFkgkNuDKYPdm5NXL7n36SscQsk4P1XjZGH5o1m3NMzoWz5Pf5chMah9/BF8aaK20QZl9+oNldbYlNvN2lFWHbhCwMqKACC3NObMVCExiaBmCJX9JTbEH9xtnBqqI2G9JYqTS5Hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACsBbtEfEHKYMGvAr1JIhqhSjrXmljtc2mBiCtuFgaY=;
 b=dRvP1XUkDeokT9oQ3wAz9jRK3723xdwIGRBr4wqhO+V2lhv5c12XAURzShtLYAQvKWMPn7MhrnrXye+MWGS7kEMvqiYqchj7XRzkjMlwURVIk3+ht+g/8hzKbgf6+dbEgmILbk0oOZE7EluZE3s6DDeb39oRze+NPeXY+mTDWb7w1ow0eNLuCds4npZA1ynGmKY4BM8xrCEyUOJ/6XxDuwPmd2Uq1hoFd1UQJIcjFSSYAZdmv0ApxUHbYjYYqiNnhA7u7yV/UNtahm/0x0wcwUypFcd8u63z6D8t/7DsWKl+vO153vji6McxhV8JN8ok+7ZYiyhKhG5XvecOAVLmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACsBbtEfEHKYMGvAr1JIhqhSjrXmljtc2mBiCtuFgaY=;
 b=EEkA/OMYar/S7LpfV/9X6qSzRtozxQVpOg9XrWUGcpYp6qHAshYphTblxQG5i+xRgrMeT4GjtUk7gNHjc8wgRKWmEyPYbgJ4TKjgfH619GEQamDmOeaPwlBfNsblQ5cFE/lafG9nxuJ5oaez3/cPlLmVA6y3ct+16oenMbd/FIxNVe20U+UeL4ouJFChx4dIhp/tjvD2ENKkLCbfFyJ1I21K036mDN9GTTK0cwBGBZojy2DrIPutLuMNkfIRSjoJsEdg/nVv8xkRAcFwhUXc19wjiqwDvpfoX7CnT7Lg9rFeZye53YiASWcXuGubasSGTFd8qCL6Qql9x5Jf6DXYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 18:49:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:49:18 +0000
Date: Thu, 7 May 2026 14:49:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
 support
Message-ID: <afzep7hF8uj-jRhc@lizhi-Precision-Tower-5810>
References: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
 <20260402162212.12016-3-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402162212.12016-3-john.madieu.xa@bp.renesas.com>
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cfc9ae-6362-4476-5452-08deac6957fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|52116014|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fsBzOAzZz5d4/n0d5DUqzagYDBFktJ+fl1QAGNWyPIercYoZbB68mqqQhBdnC7UtZ9kTW1XqI0Xp5JdeDjEBBhDnotO6A1yKBzYkinp3KXuAOxnGAPLTRu2qS+S8BftIYTsQX/KCyYG/NTBKFoDImw2SAhFiLMqsud23Mp42RaXfMOqdCrm1+y7FPZX2GiriY0dvPeELm9F3telxqKMVGHQLa14elOqxjvgj4TVF8JIRAPBzqr5ZLb481QifWSDD11b046OG57/SHIi2uBf5hNmSayud6fognlI0lP5s8Mg7Y6W/d/+eDXphQxAITzLD+8d2IslDMlX/8B2o59Dt70P3OiJzuPZAId0MArid7kVCuO+GRFHCbdwtfEdKdD8Y5kMwao2DQq0T5zkOax79SASA+mkx2Hzo05dd7qdgU3SjbOrHFdn5pK5priPca1H7+lceGkO+9yCnsXuyi3wwISkFjBB3dfMTmyv5hmRNO56xxcOdKOlzbTOGZca8QxvuukUEWLU2i9zW3wdw9WBbrpU6UA5jrd4G3UqC9f4ZrdY+d1MvQxekUoo9VIY5FM/5vhtQgG5MHP1V7dwyMRDJ/P4qZD0vwjvJpRIMxqpZc0OCVUI/C51z7A90o99oHHn0gWrrNebGSq0p/qv0NNWZRIXoi+TniieSLGKvcJdhaRb0G/awPnfrc32EjT0FXf0Bz4ZGHzxySaZfiG3JgtZQdtWJcuj+EqljCUO+QnWFiueqhHueC86WlHLS98IxW/kF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42/SgEYh7tHjP6LigGfpDk4lFxXRswxKyL2MkB/QgbetgeR35TOAi4JebdZD?=
 =?us-ascii?Q?ASVmIabhgr0MSq3pFBkc4CvV94Qu0Ok9MEHs/Sp59fvrjZetYtHI/ekwdNU0?=
 =?us-ascii?Q?8zP/mwckxcjkFrD8shHhAdXLv4NL8zDAv5Am5OlLFWRZruLju3HgJTAJYkPS?=
 =?us-ascii?Q?TqP+ORDMvmyKOrjYEfVScIr9/bRIY/mKVPfHEcvVbq/MiwKiUICkqKjm2aLq?=
 =?us-ascii?Q?KUrTFQbnzCJZfEdPFHWFa1q+rJgs8+lHeR3FUmOvoyeXeg2XDi2yHFu4/cIU?=
 =?us-ascii?Q?piG1v6QXjGRaD01QHvSR0U5vYDs62cwbOSMV2sptuB23kMyLoBjZe1E3lswp?=
 =?us-ascii?Q?S/BTuvcUMLJMSa9esZD+MTXRxQaEyX8QXZEDo1tXY8Ojh5p3luGi1NqO3wEO?=
 =?us-ascii?Q?YeVy9ZpnJTAGJ5HlRR5N7ayUXG8frdDU2/tB3COHGOiO2OGI2Ql5VRVq4Ank?=
 =?us-ascii?Q?uQYaupCkHAypbTVgrdqEIli/0HT3nl0nxfUwUBO8Z6UUC+hAbfiu2ASYJ6fT?=
 =?us-ascii?Q?IfXa1YPnTOGl/+FgPKqf4fYYMaPfg0oW7igPKeomrZbZK4t3g3xKaDUNtD+O?=
 =?us-ascii?Q?0j8Gg6tPaEjvRfseUEWXdC1MLJJm7cas11Z8aqIA1e++R1IW6v8qL7v7ug94?=
 =?us-ascii?Q?USiPfkD207akja0EZabDYTIPc5F+3Njx6IwKQ8qS3uCBbpw4Mv4EjVh3ANQ4?=
 =?us-ascii?Q?kXKghbdCVfsf9qBM17KRbwZ4NO5gtZNxoYXkfc7TUbeHHE1k0ivc2BjzPOTa?=
 =?us-ascii?Q?L9VY9Esc+l+7tgxBmU3veHmSNNMevgvfBpBCNU/ujPgxnpF1S0Z23DxzCxmo?=
 =?us-ascii?Q?GCp9b5S96VPnf4Tw5/Xi0gC75XI/f95TEq+0/OslRN/zdRNuRz/Ybfct50GQ?=
 =?us-ascii?Q?QgQYUay2CRtQ2NDUPBJsB6S4W8vW0YtwA8sfeYDIRPK9HEQJr0e+KlB4qwSx?=
 =?us-ascii?Q?4hrJlEUfzEN5DaO4CcSBkXUz+KGDl5ZQ1Hv/XLraYtwDNuJsPWVoY85H0vY/?=
 =?us-ascii?Q?chnKdAqihOsHGiytQr7Ako5TVJmYOka0r2ktpz6YWeMO27ItpQpl2jtlsi/P?=
 =?us-ascii?Q?4aMx/twe1pS1EQ37bSbwEocrWYjvME0uhtIh6FhvuKbEJqKeskpJN6tTcKxK?=
 =?us-ascii?Q?TZkwZuuTmSDUohrn9+3DN7AJ9JUZhfdO4MIq8muQolHnkCmVedOlsRSlrHtU?=
 =?us-ascii?Q?Rd7i1XFTlR4JO1BqmNUZR2ENtEsWkwnMSKNm5rLnTbmuS2/2/ptkEjIclQXp?=
 =?us-ascii?Q?3iPylx1IzWQdxVn1/59y5p8kztWkCLR9LO9R28fAy3BkmYFbVF1/SjWtCGYn?=
 =?us-ascii?Q?LCDrCYCtWCVJ8fKyLdyVTq2HUy1fQUrwg/KhWp5kXvwpuN2boUIEfYvUaZp1?=
 =?us-ascii?Q?H3wJ8sKQ52JY3wabfwA/WoGaxFQr3EIu3jHAzSsw91ihK/r15Hxt9dTCQG6n?=
 =?us-ascii?Q?mZlc28degjLW+YXx3EsOR17qQ4n7grEVeL/IM9dKYCezpa4su0jofuEKFHjr?=
 =?us-ascii?Q?Hxd6p3YHBh8VRabMqq4O4RDe6i6u/V+YpVrgIrdV+B+HJ8fUGFx3jjNuDlTs?=
 =?us-ascii?Q?fwcZ2+hhqOjHL4BIwaBz0N+c+uAL5EqmALxf8trefCZ8Hx4uI4Xch+xzXi2q?=
 =?us-ascii?Q?vXPTrbxo2u84WhlqU1Gx69+rqvjJcz9QY/Q5LXs0vQf/ECj3YUAG7nkR/gka?=
 =?us-ascii?Q?pBymSFGZUf3wFdjh1UX6erY/PVEIUYiubEcobSQ3Z2fScTkJSUM4Dskl1NVx?=
 =?us-ascii?Q?nh4H7KMR5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cfc9ae-6362-4476-5452-08deac6957fa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:49:18.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcGo+7y/AQY9IcH0xhr6eze9K/soQhKsxF5cd/3pmtFgHQUsdXMToKwk64KnYXlWKmFge2yOwNvhqXxPxJMz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231
X-Rspamd-Queue-Id: 279934ED9D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10276-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,renesas.com,tuxon.dev,bp.renesas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Action: no action

On Thu, Apr 02, 2026 at 06:22:12PM +0200, John Madieu wrote:
> Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC, PFC)
> require explicit ACK signal routing through the ICU for level-based DMA
> handshaking.
>
> Rather than extending the DT binding with an optional second #dma-cells
> (which would require all DMA consumers to supply two cells even when ACK
> routing is not needed), derive the ACK signal number directly from the
> MID/RID request number using the linear mapping defined in RZ/G3E hardware
> manual Table 4.6-28:
>
>   PFC external DMA pins (DREQ0..DREQ4):
>     req_no 0x000-0x004 -> ACK No. 84-88
>
>   SSIU BUSIFs (ssip00..ssip93):
>     req_no 0x161-0x198 -> ACK No. 28-83
>
>   SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
>     req_no 0x199-0x1b4 -> ACK No. 0-27
>
> ACK routing is programmed when a channel is prepared for transfer and
> cleared when the channel is released or the transfer times out, following
> the same pattern as MID/RID request routing.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>
> Changes:
>
> v3: No changes
>
> v2:
>  - Drop DMA ACK second cell from DT specifier
>  - Derive ACK signal number in-driver from MID/RID using arithmetic formulas
>    per ICU Table 4.6-28 (3 linear peripheral groups)
>
>  drivers/dma/sh/rz-dmac.c | 72 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
>  static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
> @@ -431,6 +489,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>  	channel->lmdesc.tail = lmdesc;
>
>  	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> +	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);

I am not familar with your hardware, why ACK folllow req immediately?
suppose ACK happen after transfer done.

If ACK need after req, why not add ack handle in rz_dmac_set_dma_req_no()
directly.

Frank

> --
> 2.25.1
>

