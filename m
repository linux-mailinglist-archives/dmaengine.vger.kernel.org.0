Return-Path: <dmaengine+bounces-6480-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C5B540B8
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 04:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31BE1B25CA4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 02:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7422068F;
	Fri, 12 Sep 2025 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o8HrhTFv"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BA21FF4C;
	Fri, 12 Sep 2025 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645792; cv=fail; b=p/RcQtE9+rK3rD/YeykPxFy3g3yiJrBJT0mTaEF1l7axchd2kPSsnBSemMKxvOiN+w9r2Pk6pgF9Iw+/yYl5dxYBcn7Us/A7MExWi/Jy7J77IH+ZE21jjt4+BKCAdtMRnT/jI6zrW/fuuUJCKnCL4IStG+ENCeTW6EqyHr5tCuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645792; c=relaxed/simple;
	bh=19VhKeBcuQvHeM8jU40QmhheMig/wUl5cDy1ZDHSr7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqqO9xuKYDTx66n358cm1JKnWu4yKeVzdXVD5Tho0dSiveC8fPB1m6NVoo/YvW3H2HHEbIESAvBozivgkjYap7o2SSQpvP1JbJbCM17gt2NC4+ZHGijQAmpHGkTsvLikfvXOOBHqoCab/4xfJzc7nBN0rFlf4kmoGcKlDwgNGnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o8HrhTFv; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHApfWyUIy1JNBMHUi1SMgBIkUCcRrbgRMKay6xtl9ClfTIwV6ebUTaPo/JBvy8s1UxaQk5LnpTbaqn1ftkKhEtsNWVzPwIam+p4NyyZ1hYOa51AB0Xn13vKSMfkLQ/tREhWMnH7S1VETO37/KPeSs/gHnSUBvJZOc7E9I8zsa3RekhydatOy8/JMQ0QmqCHXCHBUwXNyBv+6uZbthLS64XEpxMgs563d+RZBBhbVFrq78B7veiHs3JXWvxED7AOLuQJxM8v90Z3hVKCSeMfhILdtmtFFpnjKjlsQejMd0bGsyjLc7E8KrtsGlW2Q1K0alvl7lHyLgDTT9SUxcEoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19VhKeBcuQvHeM8jU40QmhheMig/wUl5cDy1ZDHSr7o=;
 b=jdw6UtfrmYrwKQaxIy+9X+y7YwScs7pmR3kX5MLsle7XPoht9D33X20K1Kxbk0L98KN8z6C0A1LBNNUhbz9EdYnmpoYFGQKAESBG+/u41DG4/63tRxT8IKutsWi2m7SyPemjHu5yXBj0PJUnfShcvG3fdjlRTg5rdyz//m8GzHJ2D2yyKml3W0qSOYyNm1tIhgX08FDuRNm2PzGS6VURWOjpvLyRvGYrJRVBoJvbNOnh4XtZkwacnRzI3oAQjzIlSY7z6DsNZ181hcLoiTiOVufLY279kk4LUuleLpPs2FIB7FE1AlDkclwJtmMdFh3FV0uyffudUlOsK7TdyPLbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19VhKeBcuQvHeM8jU40QmhheMig/wUl5cDy1ZDHSr7o=;
 b=o8HrhTFvjcTc6svWKcd8cHf+lXoCSjnW2UIcaKVh5Kl4u3x9ElnycNSM68vkFXgyKj0E5q+yH7n7QNOf7n1yqV31S5IgghVCxqhPQqvQV6tSpTFDLrpmzgpwGLi3fkIW0UolGOkYQWSiJRsA+TR8lfZPvpwNLpROpGbqcY7GxH5KqCVvfZMr4sl6PIaG9UQuhhry+4TNNvlfOlbRAHMLb8KUM04eTcTXjyzA/b9hUJCPmozYgLFbbwWbwDSVwnjNjmNsh4HiayDAl+6t9exN4E/nG2O42RHG3EbGGctNgYtFUPphGs3y/Ne6EmY2AbKBAUqbOrbLGUCdb7Fk/A3bdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 02:56:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 02:56:17 +0000
Date: Fri, 12 Sep 2025 12:07:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 10/10] dmaengine: imx-sdma: make use of dev_err_probe()
Message-ID: <20250912040746.GJ5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-10-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-10-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 84981958-6be1-4cd6-faee-08ddf1a7f1b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XGlxgJoazzBpaTm7JbIgfrTWyc+2CeY9d5pP6M0+lnsqWjYLad8k/XgrRID8?=
 =?us-ascii?Q?3gV2czp0LAnSMfv+aGvy3zvO+w96ISQcSUvvxdjcMfmJyd3tXieolZEWJrmH?=
 =?us-ascii?Q?jreqf8hfsw1v7GXYOHo4SvvM41vOLlbQlksPXYbVhX9DvjvRztcqf/LvkRKG?=
 =?us-ascii?Q?gqpGzm4+beXeJyWMft8hTcWVxKyOGUucgMtnsAJ7ELm3Sm4jNqcAhk/seJ7g?=
 =?us-ascii?Q?IgzhTy7iVhs0G3SpF5fdApDUE/otMHGzzU3hieccZ6WYlKwS3sr7qCndsJd+?=
 =?us-ascii?Q?BqtIGP77DkJ3A2qygNfEWYD8seixT4umYClbuQ/uCBmFimraB/ODwgMV6MNM?=
 =?us-ascii?Q?/KZIPtwafWXzQgbTZSKS+QhAIjBXDWNbWs0Uuiskgn8jWVo3DLi6OGqS1hGy?=
 =?us-ascii?Q?FnoQI9Pmuly4x554LCTsvE0Yutvh40fLcyI1aMLk4ZUGX2UsimWJZdKMTX43?=
 =?us-ascii?Q?S9ZYHm1adikMyXJxKnz/0dz8a4kX7f045QGD8pbBE/u4izZmBOODwpYTovwg?=
 =?us-ascii?Q?nvXK9rH1dZFXD5rixZyiFWvvUM18tppGxlmNB8rAsWO94nuZAVMCthkpitGk?=
 =?us-ascii?Q?NAXtzTROSfm3qK1svfjrGunLAUsvlfmZKwVaAH5OagAw5srtsI9bIlVHB9dZ?=
 =?us-ascii?Q?eswvTm22UqDQ/Inh/NPJ+OoPOh9iq622SZoiRcJlTd79tiuoCJ54CxleBtQE?=
 =?us-ascii?Q?3Nrs84WO9BpuhRoq7lYG0aq6tvZTfTEFgNO+ou8cdZAyN+uT8bN/lYVJ81Jf?=
 =?us-ascii?Q?VGpm39IvbN5yHYLmDtbXY6kp61X3YL1wb+D04Hfkd4SBG3Iwf8akcYjteUQ+?=
 =?us-ascii?Q?PCGiiMMyb/byAQTKR6Sxs/cKR0iB9LK/taei9m89cvhTHolOaqemvhtEZoBr?=
 =?us-ascii?Q?cpeA5F+gFUMb9dQsJ2Jvr4N2zAgsS9daE1q2wru6daeUNjbSMZ1S8Rla/RG8?=
 =?us-ascii?Q?UEv2GIjrtB1rrO/y8zSDvo+DFwxKNyz1m0nx6hOIn1vOfayeW69vIU4g/guZ?=
 =?us-ascii?Q?tikb/tpW+K8n//HOxEZmxd51WCf7uP5xy5GfY78LcJRQkG7Mu2bd/uJYER43?=
 =?us-ascii?Q?0J1oedTGRCUCzWt8WNF22g1MmZi+/cS3xhNm57fJF1eGOjU7/3fRCaT9RG+1?=
 =?us-ascii?Q?D6r66JKKwG4OmJCMfdpe2xu5vd6HUiEWdB7DLujlXrea1ysLc4Rz5dqC7FM5?=
 =?us-ascii?Q?tztmoYcbw0ZFADI5MIelZpsbsGYK5RsSSBgsYny5T7dqYP1Hz8iKYhb6wOkx?=
 =?us-ascii?Q?3Lw5NVhtQSV/KKtFmBCd3Uj/smpECmjnkB0e53LY9JsAR+ri7JWkke5LErj2?=
 =?us-ascii?Q?X31D2dX9XLvrNZK5O5s4LVdcEhTpPIIW4NnesS0v3IBFJyyeF4b6VmH94J75?=
 =?us-ascii?Q?I99XWi3bK5XhSy9f67VCvtTH4QrV3CTk/1yszxuuIuStZMMEfiklh+NnaA6B?=
 =?us-ascii?Q?C+mFi/Sxr8R1N2iwxmUsegtuj0PLeh2DMZX/iao7uATF8XmrIwXwLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZa47UwC5LV1bUxKD3Ubmj4KXE7bCy8wwpWJ9EjpD4ewmmS35/8C0hfKS07T?=
 =?us-ascii?Q?qfDP5ERwnMCjJWPphz0GXMmRdQlKl1XUvXSOeqU09xyjOxKyzgzBWGDGoJ2g?=
 =?us-ascii?Q?BHH86CazUD0fjYvDPQcfoetyT0E9sviivgXVdc2dNOJZcakRJvYzqzDa2BYc?=
 =?us-ascii?Q?nZ/OP3Tx9yNAN2uvI5g+wu6+CPnlObHGJ1GN7hfLEICheUi0v3wrFVmRJlnz?=
 =?us-ascii?Q?cIveDMz+1/s5S7URIu85C5YcnpAXWgIgGMYvz5gbZX1WmAe9KNxu2E0KPrgM?=
 =?us-ascii?Q?0cg3JEft/a7AcEoG1oPOuC8S3kCOVBu0X0YyZus/uEdKVUmHsWElBXj848AO?=
 =?us-ascii?Q?/BfM5ig/6GDMroP7/3EVw3/9smKTXj0qarKVTME2lUfZakCRKxItEMzYfFf4?=
 =?us-ascii?Q?O1kAMG0rFSxW0ZBgsFbaAEQonEhs2JJHei2EKIHJHnHDkGp4irt7L/miW1ih?=
 =?us-ascii?Q?8DtkRwWSiFHfGAfU+NJaajkVgwNduY+p2tiU9KHBZW9aVzl9m8OMYvhp5ZM3?=
 =?us-ascii?Q?8ytaIg7GGFoVdzJ/VxrL2XXC7S4cze6XDTi7fWhDP6464SLqF+9L38cPXPdb?=
 =?us-ascii?Q?0Lpqu2BzjMKA8ME+izAtvDxIwNdpMAVVSPRM49OoNY7xs6hR/Lu/BwfN2YWS?=
 =?us-ascii?Q?gTtb5lG8PVGl2KFFFRkfaPOO5bkPe+Urpjg6yBBKEumGmqCk0AI1LvNCMedQ?=
 =?us-ascii?Q?yG74NHnBe4EA9IQ/gp/gW8TxbMDUd93RBwfKQsFTG4ijd3JtC8hZrS0+nth9?=
 =?us-ascii?Q?bOvV853qlJnDqwNW4WeC+RI1hcOUk/oCQ4I1u6N8yq/vYDxay0y7+Z1mRZ2l?=
 =?us-ascii?Q?iLil+hTingNJMcCmkxdK2mznf/N8DCUwI92z2VH63HTXeLlJSw3N8TLKHSXI?=
 =?us-ascii?Q?ZYHkRxeIJZUaQpGQpxLy6E4u8qJyodn21JT8pEamWpcFTAqcFF233AlUaZuA?=
 =?us-ascii?Q?E38A6uycR8DKEBG6FmMQemLkwHvRyqvejROhXhTjhmZOpi6e3FLA6+Nwgo4C?=
 =?us-ascii?Q?jd65XUm2cjBOGwJICWgS3P0f3NLOjTdmvbL4YWo+dTFIDz11cEyjjh7AhbRc?=
 =?us-ascii?Q?RrznvsfiV//wLLRfiHnOwCNLJKLCsNzJ+itSaXfgHn8UPJlZLTQjsOhRWjAY?=
 =?us-ascii?Q?4PWjpIMO4uxGHkUVPvUHubMrM3+YmG+Ez4qSv/6IAELBtvNd9JOA7BKJKOiT?=
 =?us-ascii?Q?KmBKVnLGkDzbDBHXLf3+wMessMIEkmV8iltfLDKXuY4SQKuCc8KOdhji4T+N?=
 =?us-ascii?Q?FeruQjYFBOBJ7cldbzJsF9qYDfyZIL77vynBbqzBhMdHxOMUymbUmztlnMe1?=
 =?us-ascii?Q?NWSw5Xg9V6Qkl3co8DeW6QUuANhsskIDeyxxAEKLMMn9a4vEy9z0bbqSvWAi?=
 =?us-ascii?Q?mGQOA+xUGhyVXtid6AeJsyseOb3a8CRO0Ohftqu0eQuD5BgLzRMI2T44EUtf?=
 =?us-ascii?Q?VeVwHMhT5xG5beCoFpEVzamHMH00tHM1QOxmj9VyQljdoD+eSgmqYBJXtov1?=
 =?us-ascii?Q?eQCmNFf5LB8BQRBOVciDw1JOF3VyDs3wVa1Mio/X8v6aCSu1no9KnMnnKvfk?=
 =?us-ascii?Q?mdM9LelM8DPqBdPmuOajPQrsQMbPYMYQkmlOj0Oi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84981958-6be1-4cd6-faee-08ddf1a7f1b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:56:17.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMxPOf+TvNTZ9k+POs07sd1hobSZ0jVeCY5+ubHk6Me7Yd8Ig3LnVu3umqlkDpERA70PSKP/NY6Wwkxqg7TR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

On Thu, Sep 11, 2025 at 11:56:51PM +0200, Marco Felsch wrote:
>Add dev_err_probe() at return path of probe() to support users to
>identify issues easier.
>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

