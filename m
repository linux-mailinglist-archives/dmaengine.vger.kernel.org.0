Return-Path: <dmaengine+bounces-11698-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Rh8JeZiOGo3bwcAu9opvQ
	(envelope-from <dmaengine+bounces-11698-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:17:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD866ABB99
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Z18VFrQh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11698-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11698-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1E030214E3
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637F376BF7;
	Sun, 21 Jun 2026 22:17:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB241DC1AB;
	Sun, 21 Jun 2026 22:17:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080227; cv=fail; b=ULRhg/WFmHwCtznbvUVQ6Repb4hV2iG3sFNjtq4qkINKUCp240J/3HyRXIl1pSPPHEmlfYuKjj83nM49wcdikffb8z7ANjLwFsmju3ph0tVNksYxczmuAFWvYqjKzuup+ZWZNTIhW24f1pwKWoOxgB5FkBamACVuhK4amuT4kB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080227; c=relaxed/simple;
	bh=RUpxgt94QNCerzFN2r27m+BMSUvjGNzgCyBtZjNGRo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KF8WSaoidJehf5hkg3eRsWFJGP1OP0sWWrsmi0AjiPcK8Q/kY8Wko1IWzPaiIdbojBOfbYnaPCjxJeZzSthhoZsyHr27Uy+ghuuLzqiEGmwPXE7FgiDDX+qRIo7ZQGan7mhLQea6HN9sQW4lOBGbRQAYw16sb0SPuiYwO+KKhXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z18VFrQh; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzGRL9SFLnZ7M6ns2PYke/8Xk5aLw7nRodTjV6fbH0lzzrIJvh5/JltqfcnOov0EtYDVctZnvG7pzmbZU/sMTPMHt43qqU1TVFInDxIbpC+yNtLO9qI9N7pGh2ekQb61wl8IDyyxPRfF2o0yulcA7I1/iazTYklAIU2G1xDuKExuufd9rmhQ01Emwi9N8KGfBF9PjfdZRl6lTXMiKCv/iLIrMsaDmzbBRLS5vmeWKJzPbbpGFd/djrVDNmCGOaPhwrYndbywUMtndLLtM6T2KyEHJjiSS9dgwbevCa4sdwyO+93BIFTvdmZxZDNXxB3XxEvgC3OW6p1ltL0hkMa2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geHU4OXHhWLw5BjbHq7WY8VBukeymo39+lDqgxUwXNo=;
 b=qhilGEGRTS2zduUYkF/zKeqi35MGIvdUG9mNVrkXMsRcqgNUFlKGgvGktdjgdiAJa5Txcr+OtCJZhxb9pMGDXtTHRqfj3PYJPi/2VTirgNj1H8mNYOYFxlDcj2kmZ/AwZZGTNa8fiWQ8YnxjFK3qToqVyu7thX6KXhPC/lLweQSr4Vw4kImmkijkYXXgG2+wKYp/67xh0/yzkaLLogp5mfEpa2KrQ7yVX/0G+6ZuspzfWnVa8rP8RAr4u1rdsDTPN9HDNZpU0UVDdX2h505rox6AiQfNTO5c+5E/iFLLDfcIlAWGKSfcBUvkfe6OPNIb3GonyLjZRI2O+EUK7/G/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geHU4OXHhWLw5BjbHq7WY8VBukeymo39+lDqgxUwXNo=;
 b=Z18VFrQhWokAtiFb4TT0VYRtbD6hUI8lM3EeslyDeXgDyFFe8MtCSRBFkqkyFTtzgvYvIo82l9JbekORRqjhFnWxPsgeWjs0kSxP3PFxe5FBFvAu6TQCo73VVvoWAOKJGntd85AUIKN4fR82bDpBFYZ0NzbxNpk3NUQaPK7JlBu2CW32g69Ggg6g8np8au9Trtw4fFDRkGgoRrERCboHyv7UdsraU5BUM14JcGKbg2XV9bIIo/De47gkhI00i0TFJSgPu48+GwamefRHAohr/TEQy+6Od3bkN7JEKiQerM+aOiMJn4MYzYGXGjxKnumhMUWmVN6OTIByM6bqG4GHSQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by FRWPR04MB11246.eurprd04.prod.outlook.com (2603:10a6:d10:171::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 22:17:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 22:17:03 +0000
Date: Sun, 21 Jun 2026 17:16:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dmaengine: sun6i-dma: Add set_addr function
 pointer for variable address widths
Message-ID: <ajhi1Klv9g4ggjTi@SMW015318>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-2-340f205891cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621-sun60i-a733-dma-v2-2-340f205891cc@gmail.com>
X-ClientProxiedBy: PH7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:510:339::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|FRWPR04MB11246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de4c652-8f77-4316-01da-08decfe2d25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	2S5NzlG6JB3LSdIjE1uy1bcFcfe25HWmxlozOIsvYLVq0/TOC/QVd7+oN6mNAZR7qTR4UhL3EzwNwb7J56fIfwMu3CC1fE41oUh6bLztWnpmXVdbr8Gj2Jwaf5TUyY8K4pypJ9fRYmie4uF12kryUnNw+4qOJ2x7mR23rObjNmh6HpjlMYmq8xVeCfD942ASXdWPTAzZr8r1PdiVm712EZm5TqfpG/m0ZHMHl1gQnJZ1mFkOBO3f6qJ+ZQtHa/R+2/jb/0r4XLrcBCAGXBoy9IGWGlq4c/KG3YSKEKgqyp5ku0+pwhvaUTE9OoeQFJmATYo3RrmAKkeb2FGK7AOec0ZDFiRpi8SW1hwurH58KDEyEknSKc/Vtre3jeDRUytCFe06LlrxwMG8mkCHr0WfIL1Ie9Pvztphn44fofKgr0HkBZFLJe4BqC5BVI6/yDBtBrU/7u+pGFtKUYe4OusX+C3d0g8IuXZiRIFhmWHuhyUWd+saOfSFiPUvOpnciybHZQRSZRt9Io0Ly5JFAP7APW0R4f+79jxz7eYSMTp6nCd06iKaVFR0HKrC3PPtKooxReF11JQQAvSRkYbOInDqvlyMRs20cdyAvsAx3iQZrJiIEGUCOpRlnNOaRjC86ekHdWeuuG4gHlNTjjlSb1v1vjE2MevL/MLVhl7Ml9clP10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YeuZjYq0/n7jluDati9oZ58L5QUWJg48f7EgLi+CE/rYQM/FbQUutOzj0CPO?=
 =?us-ascii?Q?DENNV0UHHhRV7X26YCN3rfYbOc4D4CifWO+XFfakys6ky2tyeUySx+RmT5Ej?=
 =?us-ascii?Q?eidV9CcMgKwLVNJ9ulaFzTJru5cMAcNKp93sgs8xflmJW7GcmNYF+5mAEiI7?=
 =?us-ascii?Q?fjSZadLlaTmi7vxIATf/CJWXplY45lSF6HfbFMePqFhgAcyDM1IMTEf35Y7Y?=
 =?us-ascii?Q?KnZeGPjmFjItDhcvmeFQ8aIb26orVH4+lRUDxy/4dTCRpBQ1S9e0WWbUlPQd?=
 =?us-ascii?Q?gOwlnNs4TyhF/omA+DYf1RPg8CI7Kcrb4Ycmoo2P/n4OkdpXJQmIdRffoFY6?=
 =?us-ascii?Q?IIcqSaLIx0AJKS/9g3+tDtPuM0/M6XiAcvc2dVUJmsJhtQTGsOdl954cNQOc?=
 =?us-ascii?Q?ksxkDPWxb5g3fbrdW8oKveF6ifnksIYSiFLkqK0/YGpnlBP2fxz3cr1mA81p?=
 =?us-ascii?Q?cKnaj7Sd/2f5FnNlvqdK2UDYLzFKK9RmV540Up9Ja094mc4YzrS0jAeXuOmZ?=
 =?us-ascii?Q?uKq2IHutaonikfMwcBQCxseFALOoSTDm/7neX6kw+8lhU+kWUPHvZj3slkqq?=
 =?us-ascii?Q?sHX2fhHDtCcwmisDE2aveoylEiT/X1qFQklzdUzD2YA1E03cwRDHxXUbvogT?=
 =?us-ascii?Q?6x6HpX+3OBB6d6PwElrxpawrn+19V8aCO1F/T55FfUklzdpiC0Mmb8m3qFWS?=
 =?us-ascii?Q?zMay982mpUt+aBky3yn5UmRBUlKgDCb7x4QquRfW3CWDzYvvDQoWzIwmTInt?=
 =?us-ascii?Q?gTp4pD6temQA5/EMaIO8Vvz6DL1Uj10rBdVkPFfFb3/d+9M750PBi/0ol0/I?=
 =?us-ascii?Q?tM3IfFLL/aSQ0373O/XWMV3SKX6i9cof01twnzy83/q+V32ZpYpbP8vrCPT7?=
 =?us-ascii?Q?1clRAIV3exFch7NFlQhwwH7loG11rtMD3Wzqkd9eszGDzOOzN+7X3q734S2j?=
 =?us-ascii?Q?3vUHV6gxKRgJsRPCFGXV9zs0gBqxVgAniK1vjHl5VydD2wf3rb/sw/s1ZpvO?=
 =?us-ascii?Q?tKfOEQ644PG5ziQgPB6WM2w3nyELbQCQoVx6ajgz64oD9cQknEWgeyo+hRJF?=
 =?us-ascii?Q?vimehzC8XQSsHEY1MdzxO8630HysIuf986QHYw6sggDofJ9kjkGCyVI+FqSG?=
 =?us-ascii?Q?X9ZT9ZiUz7eP8KXKGtuReVaqNPyXvsNxlAXzMMwT46xfS/1h60mCQvzz9JIi?=
 =?us-ascii?Q?MCZVCP70HLplr+9X8MeC7APmis/SxC/CzBBvRvxUt7vv6kRdb7iTsGSO+s4w?=
 =?us-ascii?Q?F2bxdXcNhYOgHAH7Y3+yDZrlevxWvxQyuozONYRq5Bvre9sNcoEUrG2zzyJv?=
 =?us-ascii?Q?vwpKFYKd1jLfEPpRzUh0HVQTIDmPrbYK4YWMhlLkqK9rIY5ent5QZQhH+/FM?=
 =?us-ascii?Q?Ne4hmx+p5c0yYyCMZaVgis2/GtAfd76dA++KN8TFVC2nLsjUHEI6Ok5qQLF6?=
 =?us-ascii?Q?303/CLkzfU5n2j/NYHch41J0qqREFOxweaoBiHaSLeY17ZMqUBut0xyK6ih0?=
 =?us-ascii?Q?7/0u5tSgdTmJhQg5Esh7dJCVkOs7laSzPPq34Hj97pt9O6/MNC2T9WaoO5V7?=
 =?us-ascii?Q?3fsA9ZqhVGXIM/C0VeT6ZqkM2Y0rK0+8jbj0t0ExFylQUVE5AUGiHYxPik9H?=
 =?us-ascii?Q?6gsevjmGWa4A6E1QAWRcYnKzZ2h5mKqPIEfxgoigv9Wke6WlF5lT7oXaICsD?=
 =?us-ascii?Q?NBGrchGVads6FgDYS5w/d/3ab343RCghT49hoPY2qmfDVvdr4cwn+qbBSkRX?=
 =?us-ascii?Q?ZjvqP1zFaYbGfHE3U0cB7pH/vnlekf0WLFRtMXcB23yzyWjvnvWG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de4c652-8f77-4316-01da-08decfe2d25d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 22:17:03.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0jhQoGytcieEcNvA0F5IQVtRrNitQHeqernLS2dSL7MvUkUB1VSupKdKKOxx/sx/oMerdp9Og+LLCbXtyf4SJSVxaBn8n/drnXZKk7XfnXmnwP7ZOC85/r4nsYsTnQN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11698-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCD866ABB99

On Sun, Jun 21, 2026 at 09:40:55PM +0000, Yuanshen Cao wrote:
> The A733 DMA controller supports higher address (up to 32G) compared to
> previous generations. The existing `sun6i_dma_set_addr` function uses a
> hardcoded logic for setting the high-address bits in the LLI parameters.
>
> By moving `set_addr` into the `sun6i_dma_config` structure, we can
> provide specialized implementations for different hardware. This allows
> the A733 to use a version of `set_addr` that correctly handles its
> specific `SRC_HIGH_ADDR_32G` and `DST_HIGH_ADDR_32G` in the `set_addr`
> register later in the series.
>
> Changes:
> - Added `set_addr` function pointer to `struct sun6i_dma_config`.
> - Refactored `sun6i_dma_set_addr` and introduced
>   `sun6i_dma_set_addr_a31/a100` (keeping the logic for previous
>   generations).
> - Updated all existing configuration structs to include the new
>   `set_addr` pointer.
> - Removed `has_high_addr` since the logic is replaced by
>   `sun6i_dma_set_addr_a100`.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index ef3052c4ab36..9984b9033cbb 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -112,6 +112,7 @@
>
>  /* forward declaration */
>  struct sun6i_dma_dev;
> +struct sun6i_dma_lli;
>
>  /*
>   * Hardware channels / ports representation
> @@ -138,6 +139,8 @@ struct sun6i_dma_config {
>  	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>  	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>  	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +	void (*set_addr)(struct sun6i_dma_dev *sdev, struct sun6i_dma_lli *v_lli,
> +		dma_addr_t src, dma_addr_t dst);
>  	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
>  	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg);
>  	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val);
> @@ -147,7 +150,6 @@ struct sun6i_dma_config {
>  	u32 dst_burst_lengths;
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
> -	bool has_high_addr;
>  	bool has_mbus_clk;
>  };
>
> @@ -673,16 +675,30 @@ static int set_config(struct sun6i_dma_dev *sdev,
>  	return 0;
>  }
>
> -static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
> +static void sun6i_dma_set_addr_a31(struct sun6i_dma_dev *sdev,
> +				      struct sun6i_dma_lli *v_lli,
> +				      dma_addr_t src, dma_addr_t dst)
> +{
> +	v_lli->src = lower_32_bits(src);
> +	v_lli->dst = lower_32_bits(dst);
> +}
> +
> +static void sun6i_dma_set_addr_a100(struct sun6i_dma_dev *sdev,
>  				      struct sun6i_dma_lli *v_lli,
>  				      dma_addr_t src, dma_addr_t dst)
>  {
>  	v_lli->src = lower_32_bits(src);
>  	v_lli->dst = lower_32_bits(dst);
>
> -	if (sdev->cfg->has_high_addr)
> -		v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
> -			       DST_HIGH_ADDR(upper_32_bits(dst));
> +	v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
> +				DST_HIGH_ADDR(upper_32_bits(dst));
> +}
> +
> +static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
> +				      struct sun6i_dma_lli *v_lli,
> +				      dma_addr_t src, dma_addr_t dst)
> +{
> +	sdev->cfg->set_addr(sdev, v_lli, src, dst);
>  }
>
>  static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
> @@ -1156,6 +1172,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_a31,
>  	.set_drq          = sun6i_set_drq_a31,
>  	.set_mode         = sun6i_set_mode_a31,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(8),
>  	.dst_burst_lengths = BIT(1) | BIT(8),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1180,6 +1197,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_a31,
>  	.set_drq          = sun6i_set_drq_a31,
>  	.set_mode         = sun6i_set_mode_a31,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(8),
>  	.dst_burst_lengths = BIT(1) | BIT(8),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1199,6 +1217,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_a31,
>  	.set_drq          = sun6i_set_drq_a31,
>  	.set_mode         = sun6i_set_mode_a31,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(8),
>  	.dst_burst_lengths = BIT(1) | BIT(8),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1225,6 +1244,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_h3,
>  	.set_drq          = sun6i_set_drq_a31,
>  	.set_mode         = sun6i_set_mode_a31,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1247,6 +1267,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_h3,
>  	.set_drq          = sun6i_set_drq_a31,
>  	.set_mode         = sun6i_set_mode_a31,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1269,6 +1290,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_h3,
>  	.set_drq          = sun6i_set_drq_h6,
>  	.set_mode         = sun6i_set_mode_h6,
> +	.set_addr         = sun6i_dma_set_addr_a100,
>  	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1279,7 +1301,6 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> -	.has_high_addr = true,
>  	.has_mbus_clk = true,
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
> @@ -1293,6 +1314,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_h3,
>  	.set_drq          = sun6i_set_drq_h6,
>  	.set_mode         = sun6i_set_mode_h6,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> @@ -1320,6 +1342,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
>  	.set_burst_length = sun6i_set_burst_length_a31,
>  	.set_drq          = sun6i_set_drq_a31,
>  	.set_mode         = sun6i_set_mode_a31,
> +	.set_addr         = sun6i_dma_set_addr_a31,
>  	.src_burst_lengths = BIT(1) | BIT(8),
>  	.dst_burst_lengths = BIT(1) | BIT(8),
>  	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>
> --
> 2.54.0
>

