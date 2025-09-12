Return-Path: <dmaengine+bounces-6474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C2B54003
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 03:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAC1486FFC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE7156661;
	Fri, 12 Sep 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U6lFYy0T"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EE26281;
	Fri, 12 Sep 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642097; cv=fail; b=gb0VIiYLYRqKGJ90YpvoO0BGBq41qkW7iyNz8Qa4YaYjIdtC9Eo4Z4jLwZIJahWG3ug56hP1wQKKxp9qf0brmMhownFh9d6LFWILXzt5W1Mxp9pL3fqPO1sOPZ8cPNORKvedor81A5gQ7IhClWuKZOeLN9ZscZliH+p6/Cj9YH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642097; c=relaxed/simple;
	bh=JmidRVlwUnv8WsPeGY0rJvSuCfBaCnzMVGgFcT4vEww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2nZnWK8yXS1VlLY72oumpKEDWZ+dHNaWxE7urzvTWeSDJ5MyMHX335nHSoGGKQ2vTAjYuxEKnThGf/+JjJzcbT2dHMwYFjmykTFAbuVAy10deMqwtCK3IXcStJyyx66TRpPAlfXjDzD4BJYVW/UbmFQqIScqubuGR7U5xPOS4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U6lFYy0T; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIDKO4VkNn6ruO0Zke4zrGAgejMOToQDgpwHRi4+5MnlQ6gvT+rXgU20pppnJLlzP5OCpTIkU2nbNJbdC2RxPw2YvhsxDRgjotY8oA+vA4U0Kz+k2czCUxH7EVkALjTmnGlyz5dsprX4s2PF+TZT9+rVPu1qP9TIp4jM9Ol0VfA5Ap+v8j5WXplAQUOW9DSMIRLoCLT+R+TtdGKTClS31GbMU7uzEP9Jkt4sehINjVV9reNjun6weVGqKtB1YX2i7AcC6Oa2cKUNEtUtJeBlw4wyBPfRQG2Zc1lfaNN6hvO01luvSADUVnJv8bZeTtC9mpILJp57MH2GvBKaTecpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmidRVlwUnv8WsPeGY0rJvSuCfBaCnzMVGgFcT4vEww=;
 b=XLfZmPANCX7NK/7VRU7Nzw2Wmb+31OUcEzvjXmqpa+nHakp4yoSxhd5VcX5qbbQtp1j30CKxOXgk53LxUBYm16SVQJa+5Jg+w4HIH/Q2GL+PiCosqHzDyxNUUaMM+2UygdUruEM+jBldwvcF2sKGMEHNlU7Z2oX8hqNjfEkg8JU+zjuyetU6ZeKvsFZWwR/V34p51q5IiaNpl7pzgb/e0xtuXAXhSjd6LKCZ4OY2CTU+AGiM0spty1MJQsWyekOrJEzXFqZbOiyTHz5RHpi3PjBwQilwio7UHQLVsMYqPpTAlUnags3vblflIMrAItJKDvp3+pZ4VzKjT1v4GTVkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmidRVlwUnv8WsPeGY0rJvSuCfBaCnzMVGgFcT4vEww=;
 b=U6lFYy0T1bdixBfbt5sdeD4aEPjZKVABo1b8M54Tf0HU0r1IT6XQR1hs7VypSjUYtvQlSoLIl+QmoQiH5wzlCZkgNp+tZ8uLDTmBnrcb3Qw9np8LME0BSUIL0yU22cE2P3H/BIHLlpoa9/QtRWYgguuImdVWqb89rsF3gXteVKBdJsULTvnt4KcwPEUD5tXBOIDtOTbavJFpGuNRISGjXzAJrs4yJbxx7gNdd90GKWCm6bb7ydZAaDfPgxZ5m6huZsWOmVJAGlpqou4rlOe7dfCdk32PE2JCfVgspn/wO27Nr2bK0BPhw3O4asx4yaNytg3X6BL1lpa63M0tcVcKgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 01:54:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 01:54:52 +0000
Date: Fri, 12 Sep 2025 11:06:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 04/10] dmaengine: imx-sdma: sdma_remove minor cleanups
Message-ID: <20250912030621.GD5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-4-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-4-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: df7997e3-fe9a-4bbd-ce47-08ddf19f5cf5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kb7K/jfykY2v7h/qWBmt9EICHcaEz82j7Y7OF9ux0X5FfejhovJBDlg1pQMF?=
 =?us-ascii?Q?5qAdabL0rULtOMChDEm1T080yBax/YRTffIG/ftMMnp1fryGOzBBGdkSeQq/?=
 =?us-ascii?Q?fbQz1uOUjENHpXcwJCDmUu65vP1k1LEbWzde86d7QjYb/jKTQkLni6Lg2Zxq?=
 =?us-ascii?Q?cvcWVXJFHaGBjDZFY6gyW7WsOh1u6o+iVbuns3tvR+3L80DlTWD0iPtQcx+V?=
 =?us-ascii?Q?lQSuU3kVMMLG1SugjvnD2zp81hdPZVaGjm8lMwHuYwZlzqHz+TXyUcuoUQn9?=
 =?us-ascii?Q?Xe+EcZu80GtLMIGFVh/tl1mLDpEOTmk7ezLKyFo/uXZ1Xzk3nrejB7wDJOTW?=
 =?us-ascii?Q?eKsuahGDzDoNGFobu+VbJC0Ri0QjgT0x1zNQ2dZjDPpY1oPn9l1onbg8BbAF?=
 =?us-ascii?Q?MOfZeq7zw/BGPrsauFTym1JZbKuhEB/XgaLtp57uw8HuTyfrD0xbttIJHRWg?=
 =?us-ascii?Q?7gNQFOwTl6n7Feq5bYvWJVijZvqe5UXzRDpZLLTPQsp1MOsenv8twIeKQ1UJ?=
 =?us-ascii?Q?yOoD2mK2ZpDAkzgxutmwhJRS8KI08vwNWtEQB+ZjVULPLQQMyQAXjD268tjH?=
 =?us-ascii?Q?lxQTF6FLacnJctr+CZz5e9omgUOdIui8m2KqWNhZjo36WH3TBjuF+GoqsNBa?=
 =?us-ascii?Q?uUsQwkCxOA+yGRrSO/HvdjfZaGnDu3wCKjo+2/jw6novaf8E6WTFBjsZoXwU?=
 =?us-ascii?Q?flzIzKH4D/H6iufUn3f9TXyNaJIbpaqv4yLO9mbd2oov+c/SjZnUULDVDeFc?=
 =?us-ascii?Q?a93NMbydBgvnK22E3aSSYT4fzpvQvA8sELxRxhHDNth7rygDrvPxILUjx1Ev?=
 =?us-ascii?Q?HbLgbuDVvQ6F+JkEN5tmPp9UBwDcg3H8u5hQ17i01STJOZwnKcAnIkB42jIu?=
 =?us-ascii?Q?Sqwy21MlS774fEF2tBofK5UTd59ybSyUk6G2khQMIHE6HYSc5KlGzcOmplXU?=
 =?us-ascii?Q?q8HkuuJxq7xiJ+20ZZsWJ725HPhitS/DIPI6Qtpc5aq5Nv6zjSlSZRAtiSoI?=
 =?us-ascii?Q?0ZvOBNe4g8eP758nOJvz4RLZgybDhQoHLzvbe8377vUjiz6IzGChnMY/Rs1c?=
 =?us-ascii?Q?3gaXZrM7EtCLwfBuQBphKdna7mpR5uQADvYEoaGrxpsxXX5xci1lzmJ5qbRQ?=
 =?us-ascii?Q?8Lc73DZ/3XE1e4bPC1hbCbge+4zWHHYxQjl/xF06dMNkzioPJm4VEQmGxRHw?=
 =?us-ascii?Q?VxGTnZRNiKk7bymRQBomz8LWHNMSlcw5AOdx2/mTSv9obbzXsIzHPIJfIiGd?=
 =?us-ascii?Q?es4LE4DHlkN7qHNh/npqz3ohCzSBSl5czUrTaA4G5CpVq1CCOWElGYKQB4fT?=
 =?us-ascii?Q?YQcg6K+wr1wCxYEjiNmWS3f2fiMK4DJtylJoIAhMM9aqSl9nzhYGIEbiDX4V?=
 =?us-ascii?Q?KEwrWKw7mjtgqtp83gU19OgWALXfWjqMBt0J0zaZH64yCYZ8GZmfUJbJQ6Yk?=
 =?us-ascii?Q?50Q/9jN8233fvxIKugx4PPuMTk6o42YWGrfGLrIx8sE+vasyhxdi/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PM8oHrYQZeGID0lpXKyHtlR8eoQSIH2D+Tk8X/iuBrMxNOW/JdK7/gdfLbd/?=
 =?us-ascii?Q?bVfkMGyWbXLok5NT9XjCjy2FSTFt2DD5Nn8ym5QIkngy03jGqRP7eHE/b0gW?=
 =?us-ascii?Q?7CALPJbu55fVpP6XTlbe6BVtJxD5Oy9ljo0GATNLIYYEYGVJiPaUsj9pBf1J?=
 =?us-ascii?Q?ayAeb0ne8FYKcrZiNm/TvckUg530v+mIakUhJbPbMNNS02DNC1F2xX/yD2CP?=
 =?us-ascii?Q?PSfAQ2+PWYSwHsRxkXnG5Zcg0DfYCG07fL9kYA7dwvMvIJPviCkNhWRjjMLt?=
 =?us-ascii?Q?RFfnTBQMuoB3zXdiP79JAJxNZk7u3GLOP9ow3vf4ZC5YnpDOKV01ASRkpkn3?=
 =?us-ascii?Q?drMoLxLRFw1fjGy6l3Clfdh9tP4iSJJWHVw4PBcEPRs1FlKtKE5WXw/SCCDd?=
 =?us-ascii?Q?T7ka5OgoeydmcVptqkyjcFawhEDvaOf8bBtLOhPjaXsTXwOZYh6Q8lXN1Qw/?=
 =?us-ascii?Q?XFm60DZb7rpfOszeeTj2UEo+gq2acpgtPKy97vNOS8aYy3T95a5Wi1NZdgha?=
 =?us-ascii?Q?J5v5NjObG9ECNd/Uc8604bvGhytk1a23S2Y945gxTI/werU3TZY6sNZgm+uX?=
 =?us-ascii?Q?zT/2S5GtfRXyNfuVaz8IIBjuXRuq/3Li0MMazS50YoAZOJmvZwkUeL3W97Pr?=
 =?us-ascii?Q?zFugS0oaM0uHXuMohuFCZdphymFdpzf2LGOlbuHlWbWv+U0TRL+/CmPqIVwo?=
 =?us-ascii?Q?usvEz40EyNEqrL1i34RwZQQxqcbF4VuMaEPh+8bcsHbQRSasW5vGTNumHoIc?=
 =?us-ascii?Q?Hc+fiTY/0GEACRqJ3eWe7ozb4tdeyirEQKsgvBymQOwbtGIGhVC+PY18mVrQ?=
 =?us-ascii?Q?jSZMsb1jQl+Th8TQhf5ejA9KCWoE410CBdAUaxsdP6U+1mMRJgYtsVE/H5pT?=
 =?us-ascii?Q?7yIS7MS0P6CuA49qjxJ03tSKG8V4MX1bAGd7b13vTY+CBSnFvyjVFkAHE2y7?=
 =?us-ascii?Q?1lCQZR+0VhcGkdOVzOHdD8Kd1ujyBpzQDfQxUa2kN97cwpv0viG+44M01Ccn?=
 =?us-ascii?Q?xSDLe4djxw2FIDFrbdk9sH9Hzes3xCFmewN+cau9lp6fSYxwfFebVQYLxKez?=
 =?us-ascii?Q?IK1R+afjOpAAkYqHU8vXSoybAlDXaqK6GpCYncJOBq+4t8PYin7JoERGzC8a?=
 =?us-ascii?Q?3yAwYa+dRcScYacfdD2uUkGIfAMpS7rxSvaM1Y0wZ6WWaHMnxMdKYBCgcJ7y?=
 =?us-ascii?Q?Opc6XOafknzNE9NexCFoz0tuOomh2iyZ3HKxgGBXQm8oXIExRyMtTA4G06SQ?=
 =?us-ascii?Q?kr9hK8xpSElTMbuIYtuRWBq1g+Q+fP2aYJLAZdTGpmM/rzLXCDRZumCaKRVJ?=
 =?us-ascii?Q?Wt3HJ5tHVadjdNbAsRFLEZy9gvi6R/qEN+4vY4D1uYA8SQcAfKKFT9D9IeZC?=
 =?us-ascii?Q?qZFyhCbQWK6QwtFW+5lqiTVFK+hPwzAZ9QZ9Ws54YVGTaGcXdzdLHjSwlPnf?=
 =?us-ascii?Q?e7H8R4+eaMz8e1p1SzBjP2NTxV2mPIG+MdJGJl8yYn8SoVL2UK/YvDZLh0v/?=
 =?us-ascii?Q?+UsVwPGtKdzX5wYpOwU6Fs0cHOO7SBsMT+BG8EIxoMa9PZJSokpx8ib1XUR9?=
 =?us-ascii?Q?ptJSIpb6/ypC4vRPcVGEEn6pu1GWMpt+xbS0blzY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7997e3-fe9a-4bbd-ce47-08ddf19f5cf5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:54:51.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpw6j7oYhSqbAb5n8TbXEmIziHC8K8cnXDOMTBdm82zGiP9Km/jGTlHo+I4EG34992G+S89FyduH9eSSTlQQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055

On Thu, Sep 11, 2025 at 11:56:45PM +0200, Marco Felsch wrote:
>We don't need to set the pdev driver data to NULL since the device will
>be freed anyways.
>
>Also drop the tasklet_kill() since this is done by the virt-dma driver
>during the vchan_synchronize().
>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

