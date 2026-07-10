Return-Path: <dmaengine+bounces-12346-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9XK8IaVkUWqBDwMAu9opvQ
	(envelope-from <dmaengine+bounces-12346-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 23:31:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E195573EF1B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 23:31:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=lcRienbx;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12346-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12346-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672EC301C15A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 21:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABE83B9D83;
	Fri, 10 Jul 2026 21:26:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BB3B71A9;
	Fri, 10 Jul 2026 21:26:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718785; cv=fail; b=hZQ9PZMP09thyHDrJ5kb0/Q4vRqrD5YNlFV//hV1oqz+qY+psOW1+sWcTwQttw4yRPCrIVXFI3hrzTCBd0yha3H9HcnJ2+l1vcw06PHYnC7tFB+GvjzMn/bLdASrWuSHMlaqKT/iU45s4qFmzOd/D2SpP5xWtqMFlJUhW8AT9dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718785; c=relaxed/simple;
	bh=LEbsiaYQjErxIF+2UMKdH1qV6QCfpht7vTazaYn99+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dhUTcu5rky4XwaoHpzHrGlBRX9TSBGaqB8BsK/pYerOkC3nCq9Zn0nLJfm1jbWB8TJ5jfFle0JI2GY9xvpaPxgtQkg35s1rxTjFaY2b63LYoCiI+zQd7VW+SZ9lGvCh/Th2/3vb7jZIbh8ohq/Y3x2H8oaGqnBqHqv2MpjH0auM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lcRienbx; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkdccFwVQDFSEGFA2Nie+vxF9rq4DMs6Pe4P5A6Sr1saIbSB7K7fjjkppk/8t/cHiJfm8NMBibkvGbwpvDDOsR5jqrBO7O3RVps9N84XBRl8MfqxvKb5P+XW8MdXJICFBiHo82f0991P7KqT9e7zsFRN0xbDYkbC18SlA7bYzyeVqsi9dNLPkjGr4xDxPDq+Uk/ZjrKerNghROwHSf8SQ09Qm+QQLhliJzAFOsnzICDTsEudmPDva3xu2rki82XXSl7sUi7WwijabvxhH8VDYHhCbwawe0JPLfUUZY/wrmX4dzIRY42W6SBc0OPDRZzB+8Kb/9b+lpLK0kzH1oNuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx6Be1KhS6PfqnDDZ7QL7/tE4StPWfU2BWjpiywBIfA=;
 b=fKv4NvhAfTVdBFisN4EhHj3SEuB7ozxAtTbbz81LeF5oNCvRKfv4FCZK3TbCRVFDm3whIn95uJgCSgGZxFUZx8gXytHVYQgnXpi75uGqe4esb8nA66ZEL+zMhUAmeaxrrI4oNlWiVdFxWsjz0f3LqVjjFAxAelbAYKJAsnNND54NHhFtXSfkNH1I2DBglJYq3gYPSEHk6xdikMOi3+ThiCtd1rMbdq59qhHR289EEHFrekNfRHM56c9+9ISUoZ3IzaQy8AUf8i1XjWjjgdXzlugLHeXvGzrZ/7ZHZeVfnSctbbqaPqxMipf5i8yTe0mjj/4uXRoK+KULeDYFvuzFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx6Be1KhS6PfqnDDZ7QL7/tE4StPWfU2BWjpiywBIfA=;
 b=lcRienbxH2UhvgJJuWQej9yr3SXYFA2VlmDB8nzoFPgiTx7JFELq9j5IDK4IdzKkh9SGdEpBHqB8vjnikdRmeG928R1OulgH+75+aiHPp9yu5Z71ZQA2Aca755IpvRpe6uieAiLkEh0fD7fGjREao6AjpDoFWlEXDZz8XIZXDJOyCCnFPzNRLGkvWW3GVqVv9BKsJLD1DQN58vVNt5cuVH1WeEs+XopsTdbX90FOPS1T6Pz43rZWJDLNrVRXFlZIAYQTDcg1Rl4JB37Fp087alPYIzItZ4xok6C7YtRWMIu8C6vuSOdUQ/zWzo6PsBH7E1A7P7kHt/ISV7ZkAd5P8Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 21:26:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 21:26:16 +0000
Date: Fri, 10 Jul 2026 16:26:08 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dmaengine: dw-edma: Fix HDMA channel status register
 access
Message-ID: <alFjcLq5q_47uomJ@SMW015318>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080903.2392888-2-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 915c9968-eff6-4c1c-9dd1-08dedec9e00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|23010399003|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jSQOcvrOW0ERumZTqbB5oYRBo9BG/hdxCl94/swvbc+CK7GCzi+8GbWjBpqeuKGSvJ4OAnM4awVbLpkMfc2y7++K3VLCDwLoxZ1M3j9CIxyhEqBt6pjQ9V+6zPX2G/jMnB7PuE2ICJOyWJu26HrQlQQWVOpUX2y7jHdJfqqro3IhNKJW50JRnGnTcNFzRlWcrQ3P6sqt2uXlDzM5da0qdFgzbnumBXnvn0PRDBD/7TpZnzGlmB2uKZbEdzPHR8FL2B59wsqNF9zZ7k1/peV0roZX81JcCdphTzFip+cF6OyFf8G/Eui3hYe/tTyYhpIMcm5XoObtOo3HAz/QO8atlqsm28d3mw1IJfV3010EGZZLCuCmOWnSXYR7/U4WTJVkngISTwbwnOBBxnMweJrp2okmBF2tZerTmSAsOoZGMdI3A1GgByPhDMBLEzOn9HKFzxfVDWc349aPKG0L9KYc+8gFz5LgCl1uH2CCA0SkC3w5xKrVw6cdEHb2o4l941x8htc3AirQqNxuq/Sh4td1dclKS8nlIXaWrmMRGzZ++GqBE6eUGfwG/+KVXuQoITScw/wK9HBGkn4kOJIdJyjQd5zd5rejXhJqtxBYKRgC9fk2Aoz57HQwT2P7C3slR1OUh1zEfPfeMlVK8FCvFT56Xh65rgo/9HDOo+NvuPDDUvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lOrL7zPB+Z6V70QSoV/iTUgw/YmM2ZeF+fWhZlOva+pr4FMuZktYM8gqLa0P?=
 =?us-ascii?Q?S7Z8AKiFIaXQKiLvokfgvnO+KNDN8K1106n5dDdv9W2V/kwgYqu3n39jWTdS?=
 =?us-ascii?Q?3X8yS64WgaAN4+1FdnhuxkpjyS0y1vQiRk+5JFjFBuc06EeAcRg7dv5tZ4wZ?=
 =?us-ascii?Q?yM9lK0mIsNNyC1WYHQs9XU/o4hmAxV/ex/lWGYrWGGUeVUWTdHzr+MJj4mtQ?=
 =?us-ascii?Q?h0ZGN4lYt9UP8fEtZBuqo3I/PHATpPeTArubGDq/OEg7w00+nfVLz6cGvagc?=
 =?us-ascii?Q?MjCOMDAUDTaeXO60o/L0i3L/hZvl+K8Xg1Ne1KLFB6q/f2bHlPrNL4bNzcAt?=
 =?us-ascii?Q?vm6jcnPMgTfpFgIr23MW0b3TdNkkS30Vp2VfF61A5LrAg0EgEbz6jMP9ZMVx?=
 =?us-ascii?Q?UDA3FhTeu972b8BE7lzdyzUqJkLnL0L1W/Qo/yifP/ChoaRmkBgLf+fdcnWx?=
 =?us-ascii?Q?2zOgTAKK7R7vQUpeTbJahJtHsxjpT7lzWcviVCPvnB6PxUZ2LUtBuhGLFQdF?=
 =?us-ascii?Q?bAJhI+RBsOWXkweGRUcP7tbm+JHuNIXgUACAuzdk0P9BSsTkjXJBKFPsjou1?=
 =?us-ascii?Q?lVGJsz8WQJSFoQhF7kc57Fs9Y4iX4FjaG9AYO1CNBnbPKlEPzvdRrQzYyr5d?=
 =?us-ascii?Q?0qIZLDeJV8l6doOzkN03TvlQJw8EZ5yv96h83hrl47mSMs8nSiPgUJHB/ryf?=
 =?us-ascii?Q?AKdYmIE+pCkPBe0Nm/FBEFl/bSbsL19mMuUsrTWZFH4kfJd+YN3Byak2+UvG?=
 =?us-ascii?Q?PeNm+RoKjTDH/ucx8+kYayezj1X9fPRPwdHzUJtl6T/12QPS2IKd9UilygmC?=
 =?us-ascii?Q?t0VdU6nPrEnm95ZOEecVL9J1YNs08NDo3QoLIXQKdObxMWOx2SfVJJwy6ls6?=
 =?us-ascii?Q?fDDVSltVpBFjxM1eKLhsy+VfMSMKQ0yxoS34AobKFfTEGBDDdwLNtpSxRj2a?=
 =?us-ascii?Q?cfRzz1kL7QcQwxU3m0LuH5pknhTHdOGCUYLQTI64aE6TxKlGX+2HG3o6C/ur?=
 =?us-ascii?Q?hARDYD1JgrKXfl24Bkx0cXge9JlLRHrZvE6/1um82zvQCSVkzyJja8luBinL?=
 =?us-ascii?Q?ibuWlGu49SR9kTJuO7yYtBIdzPCPtj3D6Mu5Ej1N1RyvUHtASOcDflEx0Won?=
 =?us-ascii?Q?G+4sKZzdCQ/SljCSFFCvhAvuzo1ZT8D7uftD7GqtBZ1SdFJwnYOIyiZPp82A?=
 =?us-ascii?Q?drsQQS/fe6hezN9iLVEDACb+sTdsSt3aCvWisMQplpa/NfBrhWF7N+soPrba?=
 =?us-ascii?Q?sj8ATuO1Iu6YigTwsEUH9I/zsG8ZMmFj+smcLJrkuUeNNMz/0kzkAs6LQwhd?=
 =?us-ascii?Q?cIAFbKJTHt29OBoH3zgKylkJ8U7jVgh+szZBgvXX7pnb9iZTx5WJYGB1uLU5?=
 =?us-ascii?Q?YKkLW1pMHyxO60Mk0Vqk4/eg0/MFoVzVHgDgVZQIcQk9XQNEmQX3Q8goag0K?=
 =?us-ascii?Q?Odrnu//UJto7FwjhlyoLQv7ud+F8Zul+T9nEW2NHfhnRpvdgNaILYADNL5OF?=
 =?us-ascii?Q?snOPIaWLUjW/mtaa1d4Qn/DzdmVRelN1JHey75CReKblI2j1JLYSzsYfTepn?=
 =?us-ascii?Q?Iopqqu4/8FlyhAKUEP5uEMtvhvFz+B9MHPOZcXhC5SnsXJCXMGQmSDzrX+Yk?=
 =?us-ascii?Q?FESblLyfVYZaGS3VmcM68g0NYhqEwFTGB4TazwUP4cBtxrJ1TpMaY+mVoW7H?=
 =?us-ascii?Q?Od9jMyek2Xu3haNxH8kdZ3R86rP5ZlNR546m+KLok76mrbUKXUDdaV/Quasi?=
 =?us-ascii?Q?O26V034+O5x3eSgBj+QXs0wpvjbnlCFkLqroHPehzKiT/0Iz6boM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915c9968-eff6-4c1c-9dd1-08dedec9e00d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 21:26:16.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYLwz06e4pxb+Aq5MKu6andJJFTGK+F1OYJ/qiBYor7hK+i2lByHMrkkaf+R1K/JHDPfrr9IjEVLcWo/HHaKSE8BVgEtpHSgN6hLvW23gQAjPz9X9Ng8FyHikYC5UGN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12346-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,nxp.com:email,SMW015318:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:from_mime,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E195573EF1B

On Fri, Jul 10, 2026 at 05:08:57PM +0900, Koichiro Den wrote:
> GET_CH_32() takes the direction before the channel ID, but
> dw_hdma_v0_core_ch_status() passed them in the opposite order. This can
> make the status callback read another HDMA channel status register.
>
> Use the same argument order as the other HDMA register accesses.
>
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Do you miss version number at subject?

Frank

> Changes in v2:
>   - Split out into this preparation series (was patch 02/17 of the
>     dynamic LL appends v1); no changes to the patch itself.
>   - Collect Frank's Reviewed-by.
>
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 632abb8b481c..2beec876b184 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -79,7 +79,7 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
>  	u32 tmp;
>
>  	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> -			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> +			GET_CH_32(dw, chan->dir, chan->id, ch_stat));
>
>  	if (tmp == 1)
>  		return DMA_IN_PROGRESS;
> --
> 2.51.0
>

