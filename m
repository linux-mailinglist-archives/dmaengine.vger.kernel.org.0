Return-Path: <dmaengine+bounces-9251-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLfhGfpiqGmduAAAu9opvQ
	(envelope-from <dmaengine+bounces-9251-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:51:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EC20499D
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A9693059705
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D363366057;
	Wed,  4 Mar 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z14jPLjn"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F636167E;
	Wed,  4 Mar 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642292; cv=fail; b=U/ARAVosxJuIzb1ktXJSpRaUE0SH5UQYRExvziL6YMpEBuU7wzvCnk4adIRBT2IK9FShkv9aN8Z8vePsaPMadv4oSUKpu4uTRt2bTVoHdO4ISgfFNOqKVpXGjjAVH2bfydaIj65xJiBW7JmQ43iAD6R2I4jn7AJmJAZBLovPFmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642292; c=relaxed/simple;
	bh=SAAQLepX+InRsjC/d94Py8uttEEBuUJtauhpN7h5U7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B853Wr8TtZs2WeyuUYtKcPpQP7gDCzko8aBy94dZK1qtKremWnZKoIXkKsmEkIp6Ybqe5wtdB6BuybFcqyTsV2grD07paA/3ad2Idi3aUygUu4vNXeOEUA+0DMGRJqgytQdej47w3hQxHo49djCXE0ayVFNFOnDt/4DHVqcwuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z14jPLjn; arc=fail smtp.client-ip=52.101.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIiNc4KNRgM7qAtt/6WbZ2UuFMbWO7Tb0MiSruu17tHA66mCjzmhKXIuR/7yHkJ296PcnMgDWtrfaRY1M1Inzb0l2/gdERgXl5UlwD2KpD7U8zvBaPMsIO3ObwLn4jCbazwy2up7S/43wReqN/qtpAijik4ictJEcfFhtaxGtwYYDmocbNIK2eYWy2XD4LMkY58w880JeRSiUKaAAJOYDGynrwXyLEV+M0NRWYBmQ9MKX4x6KE2LvR5V7FiAUA3s+hf0MQIWaDnK06QkxU+opCZsXUuCUCFaADW4ZLUUXG7DbDZ4zzfLvnx3gmFv8MDFYsdZZF3ex9ku3fEo5UqBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEthocdaCpjtU8uN7hqpNF2XOHCIhoOshbGvEh3RNvQ=;
 b=yYqkQc8rXnnUCuqy9FmuSxeH07oNCMmzewksSd7ERgEPEv4e1MdxYnlkQq54nf4V7sJcHi+nLxOGreut1VnSEzxWQQyworbjiXFnR87q94C22kDmiXga8jISjA8bOGKeB7HUek+62xOPm1XQfAE/Hpo6kOEKOAeHbPfagIGIM1E5dMburQlv+9XI7rYAFYul5NThXAFsyw+jw3i2412bAaX5xxYVNCQ68CHtSp3CIR8MbD0Qcd2vZt7osFBmzuc53v6Jmyqd/G1JnLZd4klmc1VhmhG8cmhcntV6Ahs91glnzGAQx/ncv6CHOJmFLkvsjNKAMDi78U4+dKGiVeccNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEthocdaCpjtU8uN7hqpNF2XOHCIhoOshbGvEh3RNvQ=;
 b=Z14jPLjniht1WkkiOgRVk3uM7sLhTuUa4B6tOarqCKfbIUGTZbslMQobNDs5MXyPy43zM4uJ4aWXpNhn7bb2CMmE98PX2RajxOGBZaBLc8DOaWTCDXl2426ccuGzctubMjwKJsfvF/oAkBLiEV4FWwbEOvvfTQ7116LV4ImbRFo71jx+rCtcGEsIObcMJmDkedug4gu+45X0TnZI3/79p3f/RVszblf1IURvxXWFfROEfAgKpma4mBaPSUEtSsw71sJtgXA02w5ERUQm0e+R98dzYf9yz/hiVNbYXvNnEZsWCVS2tFiT98zOfYRC5HNPEHHmikfsLjiBC+mnFkSs8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8794.eurprd04.prod.outlook.com (2603:10a6:20b:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 16:38:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 16:38:07 +0000
Date: Wed, 4 Mar 2026 11:37:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 7/8] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
Message-ID: <aahf51PJ9UJGhOZn@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-8-claudiu.beznea.uj@bp.renesas.com>
 <aZ8mpBwOJ-opyKWi@lizhi-Precision-Tower-5810>
 <f33622bd-ac12-41d0-adea-6946e88815a8@tuxon.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33622bd-ac12-41d0-adea-6946e88815a8@tuxon.dev>
X-ClientProxiedBy: PH7PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:510:324::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5dc4d9-1e7e-4c49-4164-08de7a0c6996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	kBih5QSD5nvto6of+RNxk+JesmaVOGWdAsRfcDsaQv0p7MBgm652kuZC9NsL9FhRsWc/s+zmK9y8j6cEiyUK3qlh6b8eZTjH5h8HUjfa/5E5yO0atnCrmsJQcJjfQr4MFG5Y54u8K8xjg2YFpfPmWua/rBeGE+MnbyEG2NCglsjU9vDMh9rKMrGNQLAVXMhmYugOnQS49zX1Os4pLkYo3c2159y53UuR8fXwGILeFvDlr7U29Hw9ukCcSddFhmud/Ww8bX+HtV8cyxa84HIUfrPE+2KW0I9ZQc9zXCAeZ/8cnUuf0tdtSl47Jnt7vXeUMrDA6GrFHBz4tXK0ciZTEEX1eaShJuu9DlK7uT2nHA9s0IrU6VxjOBTOneuUAl6ELAt1MZV3KPt4oP4z81dMpbyhAnRNoYAbn6+0KkKOatmkYy55/06yLafkmY/9GnfieR3tIpfy3U2rEYz2/fNbNjeQN9qv5VzObIQyR3rhBvV0UomPGzCAj4EJmoaRsjGxIvqpkpjMQsH84oI9Qm5YQJ9qTp1/IVYLCq6jLuWv5jTzzAiB4fo8PPvNZjeIPv0qwtCkkGhPfrAp4vwCZjbKm+r4dEslhgwPCvlZrMxqI6nUkdtHyD5ts/iU7yfECMzmuo3OyDnmxC4AeHmEGt0ad7iepHcQhZdgSwiG52P+MPMAr87qmQfueK64rnfMiC/XqAhZsbKiQ2Odl5ZOBlsodJdjrdtt+tKV5I5MYpn5rHiV+F4aLXG8UR3rqBZ8V1YpCMgwRcFFkCXtdk/pFtG9X4705W4M+RCFDjXgPIev2JE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+UjItoactPBBplsgmyi1e17mk4phDf0alTdWBDJTwlIvPkHWMSWkeNJSsFe?=
 =?us-ascii?Q?AYtv751Wj0zEBu+slBNAEw0Tjub0cvGznHj1HrSQyyULb1cwtYGxqE651var?=
 =?us-ascii?Q?PZvc7ORJtcwg5twiTaDEZe8mWn8YF+F81a/uvRBEkNLA8+LqORSJSOD4e7R2?=
 =?us-ascii?Q?LshN7B1dqmdqQXKac0gncaTr5i1UQdnjbAyRYxzHJY0WlqnSFjLeCupfwMsZ?=
 =?us-ascii?Q?JBt9S+0I2OJnmXtRxAlswTqI/qI20CXl/5ie5YkHcJCJiol+vYFx3/PUqrOU?=
 =?us-ascii?Q?8AnJibCM+qdc+LbjgxP+2z1u4OqS1hN05OJ5qFBP34tv3Q6PUVfiQ4kUYHnz?=
 =?us-ascii?Q?eSAgHBGgebT8En3mR6lTPhkRFBlBWXfI3x7v7vVRemjHRjmZksl6uLY4c6vJ?=
 =?us-ascii?Q?E3177PAc6hzCf1OxHcGT1frOUXcI4UdKtDw3o7jr62kiOm+IbMWeSr8GY2Oe?=
 =?us-ascii?Q?SZtcLct+KfTDeu8BNwYox5rFYNeOGuDfyirlZQb7M6jTvNcME6V9ug/KtIVH?=
 =?us-ascii?Q?X63opNAK/NBcZuwmp/64KyV2y8Rok1iUnooeyZDRY0slRdiwxmVQne9BcsCi?=
 =?us-ascii?Q?ww3/NV+FEqbWmS4ucGPX7oSvRZGd3gT7apNO07r6jx5nhMkV3jW8QVdF40/d?=
 =?us-ascii?Q?JwshMUR9lRdHo+jFfYAlUaiCAJHZSJZ3kcwwM2Vnt5cvxoCqgxdsy9fyxb4W?=
 =?us-ascii?Q?FZrfJD3ajzXI0+BQD2T4K7qZSyJnfsOLd4aeEU4W0li20+d+jTc+McRGS5Dt?=
 =?us-ascii?Q?LS4tv6V59W4PLpMXoH0jaI3xSlkUJbxOgV9rXJMvz5VklJ/fdLnKw8jfKAtd?=
 =?us-ascii?Q?/tzYLtP210sDapUdkx1b6ikpZo5avXjcEdwyfyibZ5zwyGixhh4nhDErLS9l?=
 =?us-ascii?Q?WBmWhF6etkUxD5UAhkwZ7DQBpplXmZcbUoEMRvvcYTVEJhneV+MA7smv2AY9?=
 =?us-ascii?Q?qxq4ovYbyFdg+uevvyEqu5hr2ZmIf24lUPJUnq8goVJjABoqmBAbG5HYpnpN?=
 =?us-ascii?Q?UF0Zq4jWtrOuc35dVyyhhk3THYNzey8NAXf9WW8ChSf2u0GugQ+u6qRIRd7K?=
 =?us-ascii?Q?Qt3IJj3BkOumfSsdof1WZnCDGwW/+6ot1WkG/yCrAP8Dg2mHxE+9vnLgEj8C?=
 =?us-ascii?Q?JQ9BzPoQeEicWjUmkG4TgEwwHvIA4YFMPENnJ3mYtmAbXSWgK6/9oDRty5T9?=
 =?us-ascii?Q?pCIwNW2rdLQROx6neCEJd/EUtJAxXKpgPD2G1btN+uuv5c/Xwcw3uQsjMEz7?=
 =?us-ascii?Q?0V2qhnkwM6FEyWKKJKdJKYaflTjfF1KBTUIwL0WOTantxJC8agpu3EEq50dY?=
 =?us-ascii?Q?jXA4OypAxRWeA013SGyUhEF2dIxT+1ihbsyfJ/TwT93NraNufSVzMuXdp63P?=
 =?us-ascii?Q?HbAtFy5XJgnvSHfTw5hi8/Fz2H6v7q6D52CVpyypzUD9uC/FsQVcE1j15+85?=
 =?us-ascii?Q?Sia1CO6s7e9UzyXVkmRWRCiE12lXRcINdh/e4RljPHtC8qnMNS16zaiOqpEZ?=
 =?us-ascii?Q?17/uOwpiwN/siWs4OCuQHWNYP+SV8MjjFFBoKH4x+1sLo/ngaU3+YW1Knuou?=
 =?us-ascii?Q?aMNZ0kEhhdEczxOrMulsItuncS+YYfhZvYbUCu7lCJQMOSMawHeP4YVrQUNT?=
 =?us-ascii?Q?GS70fbepl6LKU3APoEawPkXgzwnw9tdTH9MwNHFB54nHUOBTE/Ng+dcoJ+zH?=
 =?us-ascii?Q?w5w1kJcY0bysA0RtkmoirpZmMi4RJpFY6/ZtaH5xSbpyiJ/a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5dc4d9-1e7e-4c49-4164-08de7a0c6996
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:38:07.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ordHJp0n0Motq1zCY5qWi1Vur1v4EkKNeUcZptYmWrkkO+Wq6Fb5+wmjjLaBzlykg7/Ro2x/Jr2Gh04RBfOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8794
X-Rspamd-Queue-Id: 743EC20499D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9251-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,renesas.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:49:54PM +0200, Claudiu Beznea wrote:
> Hi, Frank,
>
> On 2/25/26 18:43, Frank Li wrote:
> > On Tue, Jan 20, 2026 at 03:33:29PM +0200, Claudiu wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Add support for device_tx_status() callback as it is needed for
> > > RZ/G2L SCIFA driver.
> > >
> > > Based on a patch in the BSP similar to rcar-dmac by
> > > Long Luu <long.luu.ur@renesas.com>.
> >
> > If you want to give credit to Long Luu, any public link?
>
> No public link as far as I'm aware. Anyway, I'll add his SoB + Co-developed-by.
>
> >
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > [claudiu.beznea:
> > >   - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
> > >     pointer to advance
> > >   - use 'lmdesc->nxla != crla' comparison instead of
> > >     '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
> > >   - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
> > >     to verify if the full lmdesc list was checked
> > >   - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
> > >   - re-arranged comments so they span fewer lines and are wrapped to ~80
> > >     characters
> > >   - use u32 for the residue value and the functions returning it
> > >   - use u32 for the variables storing register values
> > >   - fixed typos]
> >
> > Suppose needn't this section
>
> Just followed the process. I can drop it.
>
> >
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > ---
> > >
> > > Changes in v8:
> > > - populated engine->residue_granularity
> > >
> > > Changes in v7:
> > > - none
> > >
> > > Changes in v6:
> > > - s/byte/bytes in comment from rz_dmac_chan_get_residue()
> > >
> > > Changes in v5:
> > > - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
> > >    pointer to advance
> > > - use 'lmdesc->nxla != crla' comparison instead of
> > >    '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
> > > - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
> > >    to verify if the full lmdesc list was checked
> > > - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
> > > - re-arranged comments so they span fewer lines and are wrapped to ~80
> > >    characters
> > > - use u32 for the residue value and the functions returning it
> > > - use u32 for the variables storing register values
> > > - fixed typos
> > >
> > >   drivers/dma/sh/rz-dmac.c | 145 ++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 144 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> > > index 4602f8b7408a..27c963083e29 100644
> > > --- a/drivers/dma/sh/rz-dmac.c
> > > +++ b/drivers/dma/sh/rz-dmac.c
> > > @@ -125,10 +125,12 @@ struct rz_dmac {
> > >    * Registers
> > >    */
> > >
> > > +#define CRTB				0x0020
> > >   #define CHSTAT				0x0024
> > >   #define CHCTRL				0x0028
> > >   #define CHCFG				0x002c
> > >   #define NXLA				0x0038
> > > +#define CRLA				0x003c
> > >
> > >   #define DCTRL				0x0000
> > >
> > > @@ -684,6 +686,146 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
> > >   	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
> > >   }
> > >
> > > +static struct rz_lmdesc *
> > > +rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
> > > +{
> > > +	struct rz_lmdesc *next = ++lmdesc;
> > > +
> > > +	if (next >= base + DMAC_NR_LMDESC)
> > > +		next = base;
> > > +
> > > +	return next;
> > > +}
> > > +
> > > +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
> > > +{
> > > +	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> > > +	struct dma_chan *chan = &channel->vc.chan;
> > > +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> > > +	u32 residue = 0, crla, i = 0;
> > > +
> > > +	crla = rz_dmac_ch_readl(channel, CRLA, 1);
> > > +	while (lmdesc->nxla != crla) {
> > > +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> > > +		if (++i >= DMAC_NR_LMDESC)
> > > +			return 0;
> > > +	}
> > > +
> > > +	/* Calculate residue from next lmdesc to end of virtual desc */
> > > +	while (lmdesc->chcfg & CHCFG_DEM) {
> > > +		residue += lmdesc->tb;
> > > +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> > > +	}
> >
> > can use one loop
> >
> > for (int i=0; i<DMAC_NR_LMDESC; i++) {
> > 	if (lmdesc->nxla == crla)
> > 		residue = 0; 	//reset to 0;
> >
> > 	if (lmdesc->chcfg & CHCFG_DEM)
> > 		residue += lmdesc->tb;
> >
> > 	lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
>
> I'm not sure this will work as the descriptors list is cyclic and resetting
> the residue to zero when lmdesc->nxla == crla and then start acumulating
> from there will not work if there are descriptors enqueued for the current
> transfers at the end and the beginning of the list, e.g:
>
> descriptors list:
>
> | d3 | d5 | d6 | ... | d0 | d1 | d2 |
>
> ^				    ^
> start			 	   end
> (index 0)			(index DMAC_NR_LMDESC-1)

Okay, you are right.

Frank
>
> > }
> >
> > return residue;
> >
> > > +
> > > +	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
> > > +
> > > +	return residue;
> > > +}
> > > +
> > > +static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
> > > +				    dma_cookie_t cookie)
> > > +{
> > > +	struct rz_dmac_desc *current_desc, *desc;
> > > +	enum dma_status status;
> > > +	u32 crla, crtb, i;
> > > +
> > > +	/* Get current processing virtual descriptor */
> > > +	current_desc = list_first_entry(&channel->ld_active,
> > > +					struct rz_dmac_desc, node);
> > > +	if (!current_desc)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * If the cookie corresponds to a descriptor that has been completed
> > > +	 * there is no residue. The same check has already been performed by the
> > > +	 * caller but without holding the channel lock, so the descriptor could
> > > +	 * now be complete.
> > > +	 */
> > > +	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
> > > +	if (status == DMA_COMPLETE)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * If the cookie doesn't correspond to the currently processing virtual
> > > +	 * descriptor then the descriptor hasn't been processed yet, and the
> > > +	 * residue is equal to the full descriptor size. Also, a client driver
> > > +	 * is possible to call this function before rz_dmac_irq_handler_thread()
> > > +	 * runs. In this case, the running descriptor will be the next
> > > +	 * descriptor, and will appear in the done list. So, if the argument
> > > +	 * cookie matches the done list's cookie, we can assume the residue is
> > > +	 * zero.
> > > +	 */
> > > +	if (cookie != current_desc->vd.tx.cookie) {
> > > +		list_for_each_entry(desc, &channel->ld_free, node) {
> > > +			if (cookie == desc->vd.tx.cookie)
> > > +				return 0;
> > > +		}
> > > +
> > > +		list_for_each_entry(desc, &channel->ld_queue, node) {
> > > +			if (cookie == desc->vd.tx.cookie)
> > > +				return desc->len;
> > > +		}
> > > +
> > > +		list_for_each_entry(desc, &channel->ld_active, node) {
> > > +			if (cookie == desc->vd.tx.cookie)
> > > +				return desc->len;
> > > +		}
> > > +
> > > +		/*
> > > +		 * No descriptor found for the cookie, there's thus no residue.
> > > +		 * This shouldn't happen if the calling driver passes a correct
> > > +		 * cookie value.
> > > +		 */
> > > +		WARN(1, "No descriptor for cookie!");
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * We need to read two registers. Make sure the hardware does not move
> > > +	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
> > > +	 * should be enough: initial read, retry, retry for the paranoid.
> > > +	 */
> > > +	for (i = 0; i < 3; i++) {
> > > +		crla = rz_dmac_ch_readl(channel, CRLA, 1);
> > > +		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
> > > +		/* Still the same? */
> > > +		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
> > > +			break;
> > > +	}
> > > +
> > > +	WARN_ONCE(i >= 3, "residue might not be continuous!");
> > > +
> > > +	/*
> > > +	 * Calculate number of bytes transferred in processing virtual descriptor.
> > > +	 * One virtual descriptor can have many lmdesc.
> > > +	 */
> > > +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel);
> >
> > you don't use varible 'ctra' here, so retry 3 become useless. suppose
> > rz_dmac_calculate_residue_bytes_in_vd(channel, ctra)
> >
> > and avoid rz_dmac_ch_readl(channel, CRLA, 1) in
> > rz_dmac_calculate_residue_bytes_in_vd() to keep ctra and ctrb reflect the
> > correct hardware state.
>
> Good point, I'll update it.
>
> Thank you for your review,
> Claudiu

