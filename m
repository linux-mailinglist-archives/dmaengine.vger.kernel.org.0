Return-Path: <dmaengine+bounces-6404-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9985DB45CB2
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7957C33CD
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1812F7AC6;
	Fri,  5 Sep 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="cilWvOfm"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011007.outbound.protection.outlook.com [40.107.74.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAB2F7AB5;
	Fri,  5 Sep 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086591; cv=fail; b=MYavOZlxFuPXvHUz/2FY93gDh5CZMpmXNkE6MydtKiHvpTiboSvyFTv4LfJc5757O3CluruAotRv0v41U2HY7klDdSFleaulijodZRhzYm3WNW9NfL7g5Vyz2e8iRJm4zp7RW5fdmll19vBLV/mcLwcPmHiwWa/FInuazsdeX6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086591; c=relaxed/simple;
	bh=vJoE/20VSuRSHI1nrUlcgZFj9JhhvYBhIwsQI10GkYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NOoTRT2mr1Td4WzGnztnZzW3Xaqm/LmFE3Bu56SoEYeN0lvk97w++MiLO2yRXclY6lLW5wAQMKk/xMi7fe19RzzYf5522vN48oBcKiHGUbfSnylbYn6mrncyf5eBIknh/Ri1U5q9hD6Wquc6DLcbUXiRuuu0GWIf/u/S0tyjOdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=cilWvOfm; arc=fail smtp.client-ip=40.107.74.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+RShDRp8VikOydT/J58Bgy6DYDf6Sil9wfFdvmRckYWwu2ZXlj90D8oitzn+FNrvSEq1V/wSRb3T4KRgHfMLOCf8SAUZxLBB1NNSeQWSHmqyXx12yr45vINapK09lRPv3Q5glUVrTbGYadnuVoPgXE6lcaTbzGWz9guCUmszosGgdu6/roz9DNRB5OtJ5K/Y4DMxsZNNy64+dCAg3oKt1hq/z4HeFl4wMFWx6s/t1sJt3Np0NGn1k6G1a+mAhrDWPoY0MKJaC6QTNVMLjrssYPvgh1Ljvr3SNcNf+iZgLD/D7KA7pHxB1ATNGEm1xkBrEM6a9fMjpmMDEK7APO7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbHxTuxt4IA074rmL7W2SjicUnQFyAyLcLKgeFkMEK0=;
 b=uBvOZdswlBhRyOcp5V/JsnVGIiH0r5O7wJelU0bE22FfFCM7kjOLgLjMT1icLV4C5H1hfgUc9t0Yzlo7+gJdHMYCgdcuM2W7wTcKLnXtnxUl8OoeeL7+eGx03l/0sdvbDK/5on4HamGDqb9FHbtCPiAm1Fx7zbZfdYfgX3tVXRzyirjxF65aUq/8XVuNPUeO9rZqmtLI3gAzMGtamPDsT3KGwqoG0WISB9hmLRNbhDz7RtW61WCfMwLSQL3mZJVo0ax8gC75p78IuINPwdkpuLDHjnW2R07XNWdiAjKdJ5TQce7Gh3IXO4epTEZs5nP0CneeGi9PepXCnezazS2vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbHxTuxt4IA074rmL7W2SjicUnQFyAyLcLKgeFkMEK0=;
 b=cilWvOfmo/Nru4hLay4Di2OD2q9cKZJSltv6gE6PVRFXgCALBV0bdrnj77lyBPfRzx57fa5HikmHhUR2NKQkFrsbBea8GjcvXpRJUEU5oIrJTaqHpjdwz7mfwLM/S4baIbDBDKBnk+hEDhZqAAxK+b3qx4koSPIFH4FDlWJdkHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8015.jpnprd01.prod.outlook.com (2603:1096:400:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:36:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:36:23 +0000
Date: Fri, 5 Sep 2025 17:36:09 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
	Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dmaengine: sh: rz-dmac: Add system sleep PM support
Message-ID: <aLsDaeGWo6ON-BOB@tom-desktop>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: MR1P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::6) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: f21d33cf-7788-4b12-b676-08ddec91f80c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAUg9yXnGI+TrIv72bWnJI5HcOvDgJXuH3nMHx6FrfdjanQTLsGc2R/u/DtW?=
 =?us-ascii?Q?eWL7yGCYwBHeIuK+lBHjWmi48cEzeekn6joNpcCV8M1r7SCMtmtPtBuJ8xvs?=
 =?us-ascii?Q?tOu8SeJw36GiVDlc3KNHcrZW+7xxbK8VlpGgWjx3iB3bbFFqX3vpd3LLo2tl?=
 =?us-ascii?Q?WdMnrHyWsvQ+i6JsBKlC2SVa6izTg3ZnXV4TAcAxNghrBOdllr39QkgfND6/?=
 =?us-ascii?Q?f+e7pR4XBG0xWRcrM6B3gaa0Iwqg7hBqvWKzr0mfArs6lhMP939+WRIdCybp?=
 =?us-ascii?Q?oWEW+gi5zK8KpJYAOXRNDFjChdurVTw0+l4wfVgCSntpd60oadIyLitkzSi9?=
 =?us-ascii?Q?CNgIO8xSA3JBG+hx2kGkYfRXY06MvYLtq1GnAjI4hp9+fDKZW/mcaraQcMHk?=
 =?us-ascii?Q?W4MZV05SFPHu9sDN0W+ph8H349q99+Z2M+Mc5bDjm1m1pYOczdzSa7oRiDCo?=
 =?us-ascii?Q?JwYgMef8wTV3TziWpuElFBuEdldo0XJAn/l8WTE1a9YSwFUqH6PIeJn4+K2v?=
 =?us-ascii?Q?xUXQ930K+BUvuC79ohXNVa2HBuUuLKMgTzIDyWTnyMKGsJIufXYv8SV8fji1?=
 =?us-ascii?Q?sb1DxIasZ6HwUimEuxUiB1jZQMsdQTcMX9JodVx99j4melCWf+wM4yJDmpJb?=
 =?us-ascii?Q?Zi7li4Fbd5NhK+fXYaPOpgbOt0BsiHB38Tc1y/B/hJJ7sI9PtqCVWPac7zhe?=
 =?us-ascii?Q?u7+1uDNSXu+CMYe0olb7ZUrrGBqiOYLvUP0AHhpp0gRBx2p7e9Bzcd1aeCEp?=
 =?us-ascii?Q?HEjKy0WsKSmt4O2GTNX43+Ejiw75wzcVbNdupVL7eJsF5QM7bxbCMhuGMSno?=
 =?us-ascii?Q?3EnQO6db4FSgFfmgWuGjHdUg3iQ0rI9EwErhG9yKsLrIV7zl1RpT8IIKt+SU?=
 =?us-ascii?Q?gB8xLazkesdRx7LAQqQ2Z7ZY/MoNJnSp1l5VE6UMsSSp4hqWVe+/tEXDLdLr?=
 =?us-ascii?Q?uh7VhRMagHpnMPN1nS0gE1nuqdssMwQQRqst/FyLLUyN22T+H6rTjet7bRYC?=
 =?us-ascii?Q?lMJKTXRD2ZUuslViSnn3Kj7nTMmUsDfTjHpxhXyhYSgOuLs6SCVYdQlpWoRB?=
 =?us-ascii?Q?md4VkuaHUtFls/6fMya0Uy8Aqa82xFaNTCEstHzrvsPrLMQ9dCFqo7YsFtmb?=
 =?us-ascii?Q?fqo5Qk0X5kde39wxhT4ThmLik/MJuWm8sf60duoA0edcx9zwHg2Hzl7fhmmx?=
 =?us-ascii?Q?SgSg+2oVP3BmNftQorUpo64gPFSGsUGMyIyZ+fr2rcKYppfi75qDpvYrG5Cz?=
 =?us-ascii?Q?JIJJCIqZ7mZDHz1adA9OuY8Q3Wo+xIoxwKFHrb3PF67qpZBFOukE9Uofy/MZ?=
 =?us-ascii?Q?qJvpMdarXEfVovM9WRzTfyLe2j6vaGsnZKzlQjT32cxACBhciOLIchL/T4J1?=
 =?us-ascii?Q?LtQtunnOkm/XVkjRqLL/70X4Np5q1LDP8xP8/6px2CDaQuZhHbIgw8DuRE0T?=
 =?us-ascii?Q?FsHJrDESvEgJI5W6aNIn1pcjEGWWDzvq9P4g6+FvoHThvUncMPBHmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdpSOqu3g0J1BvxD3X89gcIKEf/NioBMO7DRVc3hWc5m1JSPITERYAYyjKjJ?=
 =?us-ascii?Q?KXy6QHuDQCjLV84i3pHtcQP7qduDGR2ocaevYLfwocgS9h7AFUfPvJYR4aBS?=
 =?us-ascii?Q?kcyIYiGNc9v0fqrlFTQEKqQwuvkq3Sw9OrVFhI7qWUzyjpPmpPI/NxjIvZN7?=
 =?us-ascii?Q?DEX4J1QszptTqP9zI/xuSeaefkdG1jml7jyINww3dtUnxqlUt8lc5+2EvHh7?=
 =?us-ascii?Q?JdBesKu6FlygpN2t+vHPgM/9a284XlYApYLJjjuFTRRqc7Pp2j/lyKbefIqb?=
 =?us-ascii?Q?rQGwiE6MO4lIS02JaG4BavExfhg5FPOiDYA9WSRoOu2keK4njd+KckO9VMjh?=
 =?us-ascii?Q?/wcM3Sw1qq3S6k+CL+Qh9H/URUDAOmyiaQf/txx3Gme5MuEH4hazBggAk7q+?=
 =?us-ascii?Q?/4nnq+eN5OccW9l1f7T+4iTGWr/gG1J2pBlqMBHYZ+Mj+2lGJYS97irNtZBy?=
 =?us-ascii?Q?m8ppBrX6Ltw8j5Ag/zzVavv6lRBU8PT9quG4ATrURnj/BQCXFluo0NeBLKTi?=
 =?us-ascii?Q?ther9ectacUL05vf3fQviTVpvZenzw7hDcnjdu9LaS6UjUrWPka135SFhZK/?=
 =?us-ascii?Q?tvNx9eOPSBK0nLLWXnhxhDDhXb+BCuX/dDiSqfa8lbWmOT4+6JTZuGXAYcGJ?=
 =?us-ascii?Q?suHR0Z1bcnsbKBsNFs3MtuoY2sfoaBshueG/+jsLuqS+XsDocyH0LeXfwm3/?=
 =?us-ascii?Q?TCEMmXxmDz+rwOZGaC82pmUpaED6jqI5ZBp5nbNCjfrSRzAyO9h/z1fvjFKP?=
 =?us-ascii?Q?X9tjQyX5govCIEqRE1UHPZFJQvPJ3oQJMwlHVZp3D3w+3nCGxKA7Nc/R/aDO?=
 =?us-ascii?Q?6QXwMgEQh3guL8IruPQobuJ4juyus2zKKTA8U2t1/BnZTBOUANanfZF97sh/?=
 =?us-ascii?Q?BIYPHAJ0xw1Z3PSuK4iOPXNLsjCXukPGDtuws1rUHCwJUjZFjwPEvulxVNd8?=
 =?us-ascii?Q?5SOlcWN0vDNb5bR4FQujCT+01B02YdlJv5aty3jTro0Z0H9wf4+DhrnpV260?=
 =?us-ascii?Q?g/FuIl52JyQV9cW4eyFHAs2bXsQOhV6Lp/72xGcsvb1wkzbzY1L8enfsydTv?=
 =?us-ascii?Q?qzSdIBBjo9d35D8gDqlqpbXIG5oRp0RgOeGFxVzBRi2xFcBIKEE0uCTMHcgj?=
 =?us-ascii?Q?yGcW9SuIVLg9AM4Oa6wuceUaRbE+HE5TORa61zbar+7tEZuwl6ID2s1ZISia?=
 =?us-ascii?Q?XYtyivclWo/o7KekJaWNMiI8pQMjR3ygl39SZIELoQcrp3fBgpAUSIfBhs87?=
 =?us-ascii?Q?teYdBvwBY5kWhpD98DhBZuSTvG2gPyOYagosetFFIedZi7EfwHHeewFKHj51?=
 =?us-ascii?Q?7ugqgVeviBqkJAe7pmw1B1vwor+ROmq34sOYEWnnmzgOoy7+jj9Y8EqBJ+xX?=
 =?us-ascii?Q?bnVUaIjoHMikVUE600vvih4FEoPJYOHvA7cq+eMgSZsZwFQNg8Vja6JOLKFt?=
 =?us-ascii?Q?2t0MgIZ0UtlMuNnXf4PLIhMINv529rmwpB8AHthDFjXfrO38A7XlxRBsyE+x?=
 =?us-ascii?Q?ANDssCU5riMvyhw9byiU9cyGpdv1T8q4tuibcngy8bIjU++79cssMTrmJ7n9?=
 =?us-ascii?Q?EOJBrSEQjL2iXoq5fqVZJfwQhOhuKETPezLkyVTMIvfPkUB8dQT2e9TQdR0m?=
 =?us-ascii?Q?3qsWCLhwkxbHgI9XXCi8PXc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21d33cf-7788-4b12-b676-08ddec91f80c
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:36:23.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob1FjyKuSd4O0GgpgfLIzlCm9GM3FwoHo8RYHjrwWgDEyW0vS/JugjmHaUy0TRT5doKDrfPtMMbrXHHyEvqJ8Km/iQqlUDMDCdKOmPhhQJ80pGT81kQgvwZNffieyT6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8015

On Fri, Sep 05, 2025 at 04:44:16PM +0200, Tommaso Merciai wrote:
> Dear All,
> 
> This patch series improves runtime PM support and adds system sleep PM ops for
> supporting deep sleep in the rz-dmac driver.
> 
> It also refactors the driver to use the newly added devm_pm_runtime_enable()
> and rz_dmac_reset_control_assert() functions for reset cleanup handling.

Series not tested yet on RZ/G2L or any stress test.

Thanks,
Tommaso

> 
> Thanks & Regards,
> Tommaso
> 
> Tommaso Merciai (4):
>   dmaengine: sh: rz-dmac: Use devm_pm_runtime_enable()
>   dmaengine: sh: rz-dmac: Use devm_add_action_or_reset()
>   dmaengine: sh: rz-dmac: Refactor runtime PM handling
>   dmaengine: sh: rz-dmac: Add system sleep power management
> 
>  drivers/dma/sh/rz-dmac.c | 82 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 12 deletions(-)
> 
> -- 
> 2.43.0
> 

