Return-Path: <dmaengine+bounces-9040-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mv2CeMjnmn5TgQAu9opvQ
	(envelope-from <dmaengine+bounces-9040-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 23:19:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C086B18D154
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4707C305BBF7
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49AE33C1B4;
	Tue, 24 Feb 2026 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bENbRWII"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283F1DDA24;
	Tue, 24 Feb 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971540; cv=fail; b=XL++ByHK5mFzg8XZ+ebQ3ZFoKvJAo/ThVmKNGfPMHXIfqtVpVRWL7cni+GRTRcWWAMpbctmsdlfWPBxnW7h0Q5bGTMPqBbjdNM8YwE1HGd2u3og5MqSnZu/LdGbePb7pZMR0GCsc7mpreOibdMtM/DXwRaZsHSV1DbdH1kwrHYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971540; c=relaxed/simple;
	bh=phztWc3gwkB06TMkZnzSCm55+WHyv7ItzjrqiL80FUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i+Ozr950CI5F+H0I9B128jf1HpIcdEUIY86BJ9OQijQnBTFtHchURelWD/S3wMiyloQTYdHCPCgS5+ldKtFucjziOC+Sp+9mhqtF2qzEqlNqEYSwf1FgwQQEd3sFujYq/axRIKSbbitk/2SJLxh1O8mF5Nat/O3k9Q1FkjHQ6T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bENbRWII; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP5NzGguPPoqeMoeqod6Uin/dPPHNk7HopSgsyA3x8qB/maFUb/AQWjpvAt3f9diARqyJ/dKJJumzTe1gt2f9/OueTlqThe0JyIy2ONYACCWX1VtoZhH+DaxjV/CMTtGvPU/iTToOBJXjHiWd7+7ZUX74UfIu4FHIHT9lUFMi+Rsnt5Y3j+ISF5FG8lHaycrjpBZ7gYw+KyGN/UYnKoTVVgmwoPhFLPpzOaHIkY+3Ha25umw2GdynA5t+l1/cpm+WfE/SDlMSozHkwJFVRadMjZNY9nyAsyTT2pXJj+R5evmig1plpCkK1JRuK6NwuuZhTuNgRP8fW2aygz4ag4uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZUdlJ8bTkJYK5zQP2fLSrSNcHGR8tqcxeg/FEhkCGs=;
 b=pE3d2/GR44WSejbJEeP0Xi/Y3baAAuqvevLTuKEdQBylo6I9NechZQww9vAy90iGX4B3kq5LP/luTeYROBrF74hMgbvf7IXQWKFcLP26AGoxOzkeC9hccXFCmduumGkVwzEVwBGH8nuP0sMqM35KnzJ4SMFF7fRtA8YcTgF2YbXQa7LELJCpQGcK5f8kHOCfRZV/K7w6/jo7KbdrSjWJYZMHQMVANwP66rcB9seot5l8V0Gp/ZkpEkcUmK0UUf8VwTsfg77rrZBzsKuXc33ZV+L4QOv5Aq9uEwP20/cfecApUUa8iO3/Tzw3tzdsmLhpiBNSDcMB/dniXEtIV5ydxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZUdlJ8bTkJYK5zQP2fLSrSNcHGR8tqcxeg/FEhkCGs=;
 b=bENbRWIIPZjlmnV92uVEOuPmzuWJ7280oHOsA2YC+v8tJMdfgHDRvt5rk3zQPdZICCA5BAz91xk1LtMsBXG32TGuA7iFAnusN1iOUNu+DbQW2BpjJnme/Yi7dBGgtutQfpiMzJsRr0VLrtmjy3QugiSzPlusAxCquGfOFVADispocHfSNck7XMI2boWprrGL08DdEH0ptv3GbGRdnV3ydi6RCrvfkCznoKmpgpZJbEP+HaZ2vXDMlj8xtdBgY76woTuXPnTKpeD1bIauTTT/mRbV6kAjYePRGeWatVll+O64psFhZDHs0Qi3LmIjSNpOyJaWsKng8WpsNBeIp9GU2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 22:18:51 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:18:50 +0000
Date: Tue, 24 Feb 2026 17:18:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: ldewangan@nvidia.com, jonathanh@nvidia.com, akhilrajeev@nvidia.com,
	vkoul@kernel.org, Frank.Li@kernel.org, thierry.reding@kernel.org,
	digetx@gmail.com, pkunapuli@nvidia.com, dmaengine@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra: Fix burst size calculation
Message-ID: <aZ4jwJ330VUXBNuE@lizhi-Precision-Tower-5810>
References: <20260224083455.333330-1-kkartik@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224083455.333330-1-kkartik@nvidia.com>
X-ClientProxiedBy: BY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::19) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: b0541f1c-7560-4d7b-7829-08de73f2afd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzLkrKPgEWeUhA0zLKEA0stUVWZv21sgYM0EYhlQiq5pvQuTkdg79eBwjnmj?=
 =?us-ascii?Q?rQOA16YUEJEamEjG7W+9amdcIsr+IHRDJdMEfxRSkUJXgX2l8Ekkv5ZCm1ZN?=
 =?us-ascii?Q?J/sJ/R6+1s5uJSLu7imp1hrcI/UKO0KAVUzOIhrZ9c/oJRtdvGXjaIngLa+I?=
 =?us-ascii?Q?Z/V3EWb3kpdKBp3j2prjQ8NybW44szJAf9mFQo34tPCnkMWDoKZ4cRLyQpwR?=
 =?us-ascii?Q?9RON0jXd4yVcGzVVTYic7qmKDQXYQJeyvoutgGRBoe8jSzIRBC8PtSaA5GK8?=
 =?us-ascii?Q?MMb15V7GTl267i913aI3Yd6DeSHLj4qs0inEcDDgNTrtcrYQEaXE/6C3QfOb?=
 =?us-ascii?Q?WGkrSHSZHR+k03iwIdEQM5nHkG5cExz6e+q13th9B4kYd6BPXwcTfaJU7reI?=
 =?us-ascii?Q?DtywvybNYIZNwKjGt+NymI33U/lu+mnn82OCEu4VkFmicQE40wrHcmce3nKn?=
 =?us-ascii?Q?MLGr9IqyXdGYjBPDhaTIiPoJaW41Sn0apCk/dLOrJDi+EriJWj4lc5FTQdWn?=
 =?us-ascii?Q?CV/WoGKxc+Uyec9/p5cLC4+X1SQYq+dFIjIQNm3j0CUtPPOXtVa+bDZhyZar?=
 =?us-ascii?Q?SqZtYZKvMzwHstNUcaNCJWBbEB6ScpDrpygtVeGF4dlGxUc/eQRIvcIFwDZC?=
 =?us-ascii?Q?NT3NnmHDjQ1L3tsdxsjIRF+rjZVUmvyV/d4kHE1WxT15YBbnJ8+SY6XB9DpJ?=
 =?us-ascii?Q?9L6Z92Oax36oOlNB0hr8yt5S33A3T6XghVOg+oclgrQj7SvZ5nH0fWPt3yHc?=
 =?us-ascii?Q?FkJmPYCNyatJI7d0CMKtxhzODuZ4Bg0R3RB2XCUGL/jrvdOYLGbHk+gjIEPX?=
 =?us-ascii?Q?Rjnm9IKMHxjhOFx1M/SRj1ske3fTjXmsv/79gt++YNTb5pPCl8401FAuE4wh?=
 =?us-ascii?Q?1jk2ItXk2SW0fujJhZ8liAUYB1aRa7QyJRqRzz7ibCagOoUzGS1W+uZX1Mq8?=
 =?us-ascii?Q?xV9YTRY/65R7loV7mWumMtqOH6D9vSIQkdIYvp0onQrZiU1XUtK9M+0BwjH8?=
 =?us-ascii?Q?Jp7vsnbnO958pUSif/3S0wdmIjJ5+QZin6eX5i+8coLZVBEUa4TUaO/+VvLv?=
 =?us-ascii?Q?8jtkz2+BjdFRrjSfCX2FRXWb2NP+QiFhFT5fM9ae0VxtPijnQ5NErNHKdjdN?=
 =?us-ascii?Q?Z543S883TvHzFswGh8LAHhEvVUJNrCSrvCV0zLcvngJwDS8ObRE45wYexs6y?=
 =?us-ascii?Q?l0vVcWPJ8uOc/LC06/L/ulZAxovnxVGzddFUb/r6kycS79VcAJ+roJP6F6P0?=
 =?us-ascii?Q?z4oGGpC9MW5i7BBnfiIk9AI5o1QHXNzTljsoUZO58K5W5VqT0xM+vuyqIuAo?=
 =?us-ascii?Q?ex3FukK+ceIsjXH30IXtQTHPTCEDAAdHfyhOgsMyatJfJuOYWKjRDxJkKW0k?=
 =?us-ascii?Q?Yb7kNVm8OSCb4j/M1eK0s+Xyhv7FYMOqSdjtPK8vGVuXtuPS8okhCcfN55xo?=
 =?us-ascii?Q?fo6ga9CO+IL9+cMmZPJtCmlATj0p9K/zY7WrzmvNmXgqWOD0FcZgCh1W3st3?=
 =?us-ascii?Q?M2ciWv0clb5vnkgOX0nFBVlUbIPL0uodA/GmwX1scrw2Hrbn56B7ngQcfI5k?=
 =?us-ascii?Q?6wAMO20Mmm9t31Cgm4klsUaPjrMVE+8KKe8Io86PAZeqbOnzonQ6wXohfHha?=
 =?us-ascii?Q?hLroMoTMz+Nd0YdMPrCMNKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJ7XBXh2g5N7bdWaV7UpuX3gC0egnFcWhUyhiuz0uHbjBN5GwkKHKAtfHzD0?=
 =?us-ascii?Q?TQd9d6mQjqN/Qy/X5eeln0gFwkpP3zvndp6QWPT0rSnmZumixV9T1qgfXvXk?=
 =?us-ascii?Q?/dBP+FgGxT9dxmt+kqXgzgfSGIPz3xY8y2kn736V31rZcL7eR/oLgpKwZCvF?=
 =?us-ascii?Q?WiOGbNX4P/KwHXaSeXzR9r62i3r/F3iqt2dZTwXw2cqIdp0fGqBt1efgN7KF?=
 =?us-ascii?Q?NzXsP20M/CJP7uBBpwLocTF/eS2JX/264hUfsF8bVWIA6eYF3ka4zVrawWlf?=
 =?us-ascii?Q?XixxslV+LPLJNhpEyfFSbvXDbpJwZgAFFrt0OBtYq4JLc6X4GehXAREvLAmb?=
 =?us-ascii?Q?OxZw0SQGIVdLygJ2yt9ll6l6ZAb0zGBxF/5fgSmkjJYFY3CRIg6q4BnEwPkk?=
 =?us-ascii?Q?vwrOy3HnS2qgyCDJFl/NpaOTBIkubd7cniUs1q2u2pRu+5qc+F6yViShTdwu?=
 =?us-ascii?Q?NPCilMhqnUALytUirJu0sXzvPpJQxIYQ2okyY9j7dy1lRPPRsg3H2VyAmJZG?=
 =?us-ascii?Q?V9kGB3IAbUmsCc9LNTfMeHiNmKFf5O7mWmJ45EB8afsA9cgxnTApVt37YHnF?=
 =?us-ascii?Q?1zFZK3xkfAG/h2GOiUWjid08Nmw9VRoknvAPjCcZBuT5yFDKKtpv27zSoSi+?=
 =?us-ascii?Q?8fK6Sytry5AVgJR36aoXZFjxaqcZ6jD2jq8ixNyA9z9J6ZuBKLjzDt3911Oe?=
 =?us-ascii?Q?ert7H7/zPfK8KAQzkP6CIVLJqqdJvarMrctqoeUCIE2uUXN15GouA6Udbudn?=
 =?us-ascii?Q?ypQBSUz8m+KcUPSGaX5EXTmXIqKpIrCjb/gnqNZLT+HSUp34fLsfEv6gItye?=
 =?us-ascii?Q?KFwAM2g/XOnN3ajzScDabdMR5JV++6JGMNM02I2hJgWMHhtRjtnTqB/ilsOH?=
 =?us-ascii?Q?z/nkmIbcsqUcFcH4p04MJIWwxUMwhAmk8Wl8rzmS/uzaruHcYLC8zs9JcvQm?=
 =?us-ascii?Q?83kJ2JT5iPZSUfpPZpnWhwJNBi9XPyFz7HORD3tv2LHHQeFPwjPIWIt14uvJ?=
 =?us-ascii?Q?1SQfQpIyMFaXgDjILJbY2Nto1810bLTKIaAIjClB0bo0CNMTwnXfe34KOaiT?=
 =?us-ascii?Q?HQfHNVdtg2sOs/s1Gf1ETfpKSFNldKpbrt7TQwx4BZ4GOYaBJN0S+BK0sbaW?=
 =?us-ascii?Q?Gm3D8Ref9x7R7n8jOsdNHIfdxNUKhHyiLva5EMC0E8O/+IT34orgfApVG3u5?=
 =?us-ascii?Q?27htP67DUl9h2tAIeeMz3DbKJDm5Kdjohlnc5zGNsZZvHlKXF62k4WTaIsfd?=
 =?us-ascii?Q?LVqO6BgXko8a4X0sHgIZgY0RM5UIZXDyjM2vDR2kxugUVww6V3YzDlw6SqXv?=
 =?us-ascii?Q?Pyl7ejhT1lFrTQju3M96YkrwyHpHs6Rv+w87zd/AKbxmALzSTeMGZAlWK2Uy?=
 =?us-ascii?Q?sMckGkgASegcfGUQ6yPF4hZNrBmpTxFT+fNsgrenL8D4jb93nGs62WiW7grn?=
 =?us-ascii?Q?6w8dmeEz5AfzeFtr7EU7+GyEScT54VFY3LyWlzdQwAMSMdqCOYPFWM+ztrUx?=
 =?us-ascii?Q?wrPPYrkWYNgkcRNxDlxv75/Ci6NwzoN+hIhwf5WVYZ1MTdO6aNacMScs0f/K?=
 =?us-ascii?Q?Q8zXfCsxZO+jR+02dqecOquSyUzjuqCcT4xmc9He34R3cDu6JM3WPN9myvxb?=
 =?us-ascii?Q?iLI1DOeCdky64B59n78hDa927dXiX/bdZ7F8Dy7sHZsCAFVD0bmFBPZaMvca?=
 =?us-ascii?Q?yf23Lb6hQg6Kn1HfIWhvFFZP0s7oKaU7QNQpyU9Z5/9F3EbL4jjqwHHon1G2?=
 =?us-ascii?Q?LmEt+eiqBw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0541f1c-7560-4d7b-7829-08de73f2afd8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:18:50.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bbs4M/fyHQ2EyxR1XOaCrRlpE0HV8hzxN7fDr65TmWXp5WP0om7t1OTXXXEC0ENAwUkuTRGx8LEATJnj7fWnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9040-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: C086B18D154
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:04:54PM +0530, Kartik Rajput wrote:
> Currently, the Tegra GPC DMA hardware requires the transfer length to
> be a multiple of the max burst size configured for the channel. When a
> client requests a transfer where the length is not evenly divisible by
> the configured max burst size, the DMA hangs with partial burst at
> the end.
>
> Fix this by reducing the burst size to the largest power-of-2 value
> that evenly divides the transfer length. For example, a 40-byte
> transfer with a 16-byte max burst will now use an 8-byte burst
> (40 / 8 = 5 complete bursts) instead of causing a hang.
>
> This issue was observed with the PL011 UART driver where TX DMA
> transfers of arbitrary lengths were stuck.

Suppose set burst size by UART driver through dma_config_slave. it depend
on uart's watermark settings.

Optimaized method as your example is set first transfer burst length 32,
the second transfer is 8.

Frank
>
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 4d6fe0efa76e..7df0a745e7b8 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
>  	 * len to calculate the optimum burst size
>  	 */
>  	burst_byte = burst_size ? burst_size * slave_bw : len;
> +
> +	/*
> +	 * Find the largest burst size that evenly divides the transfer length.
> +	 * The hardware requires the transfer length to be a multiple of the
> +	 * burst size - partial bursts are not supported.
> +	 */
> +	burst_byte = min(burst_byte, 1U << __ffs(len));
>  	burst_mmio_width = burst_byte / 4;
>
>  	if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
> --
> 2.43.0
>

