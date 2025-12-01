Return-Path: <dmaengine+bounces-7441-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F30C98F0F
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 21:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E4341B73
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 20:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725F246788;
	Mon,  1 Dec 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oBE1EzYk"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B941F5851;
	Mon,  1 Dec 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619377; cv=fail; b=c+rKVh0LsrZlKdpVppVZPcRhlLUolgE+9S7XudHlmGGR3nWx9+z6awoLcrHrTgOmvIoUETMP+9zBCmLnD5nyhdBcqNs3d2F/hGVv+Go7TA4yK9/poxs07VqfOi6y7hUCRcyCeuOytMhfirNLsxIULeLmBuabtWhXSFJcFGjYC4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619377; c=relaxed/simple;
	bh=Z+H4wl7+72fc0t4PQqSk+Q+JPcx1URi49U9koVkB3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hLEBgwjUQPoiayjLv/9Nmhi9AeoWID9a6yV87hTF8JwLULwYSmSESgNO55EgbU8qcowe0v65PgJDEROYHoGWS/s07lBf7f7R9C52RT7NwGIDsHmSqXfNEGHQeGG0u6YqauWRmITI+e7BsfiEJX1Qp5T554rnbtUd05IletympA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oBE1EzYk; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4QGwYEo+esliTn/2/6W3/QQrnW6toJc+8L/iYm+iLeVNZ2W0TLMrliT2fHwM7lrOYXiZwkSSLO0Vk3pYfDGYr9ade71hAnugfcB/eK1Jx7j8dDJTytrxA2tSskKLbNFf0ld6Zvu378FJvmpelk/fSa1QhLtzRd5yrCi2wU3wVRAOTglX0iDNzUvZZLfmaPhzmUtIVpHBBqAFTAPoF7yVf3or+z1PeJZG14BkPITBR80uvzwC5ALT8wi0A1VyOQB3Zwe7BdspyLxFztukWIaMeSBrjyIP0XxdnjmwQ7Em8EAeVVoeMmPZwnTQcoz/c4z/JOoC+AzVjUaV6QFtOwujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVqfoREWkXVhZCfXGJ8eIe0akLNGZdJfPyPWIXJjPV4=;
 b=kTKG150Pw+EzRKN/a6973ZJ1U0skihuyVGzkNP7LcFhA6+zSnpWjSF9DOJvRP1nSHg9NwDDSL3ONo8ZHFXrtjxosnVWaHjaPknNWteGYrtYEyhyCx3H7pIT/ZX5/wfU2Q3n2qF3L8dt2luMaZcPFTU27L4yw6905CgNLdApKWLZI7uIoHhDURK6Dh+1caeBcaHE5xsURXArGsjN1SKrCHVMJWHaH1BGc1fBRbV9KYzlzdPEG/du5Jq8gayL5FaT9S0bDDPPIYpNsN2zRJhCGnxtYWoE7Ej5b7YH96k30dSg8oXBWH64doOotNQmyXAh9bKHISUbXEz1cHKTMpN/kUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVqfoREWkXVhZCfXGJ8eIe0akLNGZdJfPyPWIXJjPV4=;
 b=oBE1EzYk+Q9e5RFwGVo2wXWNuW1xiQjw7uA1FxZBLJnsvaI8M5eqJM6/EfqBxQH4HtIqPxWE0GeYjs8qfV4xvWCFuVHFpzfBa+1Gru1FYujAu8y61yCO6Sb/4Q126sG9TpqqqJENQs0NDfQNyDMgrsvXdc/pdR+W390TGqGlX03tjotC+Ha3QJyhP4SdqyzdvtOHF5iUaMYabX2umYkNw8lStThtwrJSCV3kowMgS+lMf/NVAgZ/X8ExONCJjzhq/F3wy48xCL+E6la7dJ8pJhyIGQfV8xVhzA3/bFNqAQvAE75WDgQEeFPOnZQnA9TKOac7KXJNjk14SPmwEO/3SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA1PR04MB10651.eurprd04.prod.outlook.com (2603:10a6:102:483::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:02:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:02:51 +0000
Date: Mon, 1 Dec 2025 15:02:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 14/27] NTB: ntb_transport: Move TX memory window
 setup into setup_qp_mw()
Message-ID: <aS30YHfDUH7mRheL@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-15-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-15-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39)
 To DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA1PR04MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: af83de44-2ce3-46c1-5e00-08de31149b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkW+FZ4OSt0+1Rhr5PbkccCQDtjVicotThcsY9DiFsT8zrELosYfJgKZAzFB?=
 =?us-ascii?Q?ZRMzSEEmCdHhG5Ji9GYm2kphiMuZs2Q7YWBKaSF/gd2PYPWai7Rur5LiSkB2?=
 =?us-ascii?Q?Cet8HVbJghdAv98oUjGewzW7RsJtvvt2w0D7NwRa0ZCKrWunUbJDAwQdENMV?=
 =?us-ascii?Q?SaAH+uYXbmlsnXx2DP0vrAXoHZ1/rFL0njwjKLC+p2sJ3K1gXrf4xl7wBxAO?=
 =?us-ascii?Q?wjblLWYeBZyBp1NKF6E9C46t6rO5BouZWzR7i3bly/AyyFniWEWNeOcAVwPw?=
 =?us-ascii?Q?mAwXeXd8bOfvRwCJrN0qHXCBLnYWzrv5DOpgJLL8pv3wx2TvVOEnXbSRPjsc?=
 =?us-ascii?Q?EuFEp5tyzFVUAXn7AfqJM0x1u3LKss3BDAxaJHO5a6jwiFpGDxl4LDFIfGAR?=
 =?us-ascii?Q?heLqHVaV0I1V3GdUOoveXkUG2vNrgnV0zfhqFmYVNlTrjAmlvAfD2bsqSbln?=
 =?us-ascii?Q?zVSdDPC5Y8Uq57D+dloGkDESXE3mBQHJHxFmdp/fQl5n0ZrsKHrdJ6GHxyGL?=
 =?us-ascii?Q?8e00aZhWC8ZbehfkIsbYG8Ax9Opki71UMsF+uEgUp+GKQDj7E9OukKIxNNxb?=
 =?us-ascii?Q?Sf1EHkxBCYE470FfWBR2Cw33a12ZGSUdcRTPg6AV8b9wl4pDHCc5RDjnNz/w?=
 =?us-ascii?Q?3t0z3eHoeq+EdhaSSvu/RHZpGf+Th3IWP3OCVYrNjzXtvOjMDQHZYUlSnNJ3?=
 =?us-ascii?Q?D3ey9SgW0Z7HOOS03VIbdcR06QcbBky5Gb6TLSPnna8EElwKjyomv5BiL1ul?=
 =?us-ascii?Q?vJiubBIDjAsvaV/ioDTC8GJO4bnGhOtmWSlr6pQrURpS7Ag+ouH3ShLreV2T?=
 =?us-ascii?Q?IZv+xDbVXpghTbpG4NEdWzahUBYK3xUOBmGCjYZvInZAcWjm6tP0ygD/3xkY?=
 =?us-ascii?Q?jK1BaoQABfM+LeKCpSpwJSa6QCWhoQTvYZbOYGkIITA6FX5L3aiiPwBZiKgW?=
 =?us-ascii?Q?Aqsepjw0epr/JgKSggWT8cbXlsM8Hcl3vkvI6o+INrb9otL709tsB/9F9wI3?=
 =?us-ascii?Q?isnrYBrI+IKDoVCC+7T/QmxUljEgwfnaBhEC0cwevGkqZwryrdc5z4R8suMK?=
 =?us-ascii?Q?Ijs0AtP6EV14g4k94ykUI8JoTURjrVJg7D6e49gM87CWj8I51N1Vr97gmxow?=
 =?us-ascii?Q?gze/tx8UIhzWhkYZ/E0vAjI0YSVXZ9WDenzsgZglF7RjevU7q7NKPCGzdR97?=
 =?us-ascii?Q?F5Td32OAtfhHH6nycBpzhsCrrkNoaH5K3r7goFLMUXDI/IxhEq9Xg71i5MUN?=
 =?us-ascii?Q?rtoopH94B0yCmKT9k+kFaDOqLI8XH//mEICnW+C2k+xuoevMqQ5OOGi75vkn?=
 =?us-ascii?Q?T78znmpf9v8XdL4OHy1RyPiMszKTogJ2ymm3YXQ298fcU8xZmJ5xZ1JPY1G5?=
 =?us-ascii?Q?mhvaiSXaKlpwRfy982t3/0KZOnkfJyh14oloDmBUoPCSf2VsRzr0yjh1N3oa?=
 =?us-ascii?Q?SEPHS5vV6uogkHCwHUg0Xz53T0xcmZuYoe+gjm5EmMEvOpTXZqGzkoXwV+cw?=
 =?us-ascii?Q?pgZlASmtHs4IWaYLKnAfczx93M7bsi/jgL1b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZfsqtagQyHQBNMV0fkYZCK3KcmedQFIPtNLhXOEKc/k4QbBYusu5RIuEoDZ?=
 =?us-ascii?Q?uEAhGXKzZPlxbiSQO74aCwn5i+G0gSkACQOfQEqyhnosX7UpvZdf1YSBUAis?=
 =?us-ascii?Q?UCXHwTVt65nX7Za3fwPKrRN+w3jDE0YSiXarToy+3IZXLosUn9bIYoJP+5q+?=
 =?us-ascii?Q?6ZUkpVFHLcaTlI81rFEFyodI/6z2azgdQIhfiQ/nVH9rXLxt0N7cK8VnHrHf?=
 =?us-ascii?Q?hbzq1P+J4RS0JaMpxppdpb7BMlSIUyuDZrGfxpgTUnllmul9kR6n4Hz1mBtd?=
 =?us-ascii?Q?dZNNBJDrWMjATcaWcUIo8gsSBW/jPVuC4rEAf9ZgHJPzbe21hQDo922grisx?=
 =?us-ascii?Q?6iWwG1/gnIMd69r8RgSCkb5Q9pJhBoIUUivDXhPeTfLQ7WMSJvpTJZdy4uhV?=
 =?us-ascii?Q?6Kjq6TcGR8VMdaRubVoZ//Oy1UirGER7mBjo0uoe8+zHKP/tjMeiyaudbB8D?=
 =?us-ascii?Q?WG0ij1oOqHtZRcT1n6uU70me141eDheFY9jcynxzUk3rx76zA2XjSI1bKs3m?=
 =?us-ascii?Q?POESgOecceGe8JVzqquLUxKK2jB9PCP5JMkjHrXdBG/42XcIJiHFkRVgR/6J?=
 =?us-ascii?Q?v2hOH3j88LLJig17Ed3Oa+R4nYQTinIp3Qhr4qGMlNGzttweMZbbPsjFhNcE?=
 =?us-ascii?Q?lPn1t79+n4YPntYvG2i0jXNdgFluDcUvC+etAEp+PlK96fkEml4FsxraY5Xg?=
 =?us-ascii?Q?XsnlPlCJATwzUNwWatrnYDWl/b7cOzj+HJmG2p5Ozj3BBWNyFGfjLyEOg+ex?=
 =?us-ascii?Q?W3TbZgWrAOKp5iFqgSkabcihI/aXCXgjBYu91X5Vn4a2ldCOATibVpmP7Siv?=
 =?us-ascii?Q?FlUZ5lUd5KQ5EdVjwospRL0sqGKEATWhJzNEuwTBgWydpsAPU7zDYMbBXNW6?=
 =?us-ascii?Q?/KXW4Y6BGHHLRHIhncC9I2/5KvaGcOWKpXH8MRqjqaT3Z8JfeorWgOtvlPD5?=
 =?us-ascii?Q?RIGvYSeh3TDUkTg9h+7/eV+tG++hvyRaE8217Zr9Y6nBZQM2CyPEtU4WShlr?=
 =?us-ascii?Q?8PthByuZWDoUSWN3699xWRi43cRy4yI8zrUIQGTt4asuB36XQ3FW42TUPT29?=
 =?us-ascii?Q?YnPqZtTCF47KSdo8RfQIzpzPOm2u+fssvE6hd4btcvyd/67ipDrKS+p1Kjcg?=
 =?us-ascii?Q?Myz0VKKfduBqRsQkL5HP6d7RG8ks/XVOj9QLX6X+tRjZ5L9AYLS3QX+NQgqu?=
 =?us-ascii?Q?zti2l1FOaQHrayh6954ySntqkJQ6Wyq3/4y/IL9KopQZ81AbBzfkvzfN+PdM?=
 =?us-ascii?Q?qscbufMbPfkoLBm/JSLwtVpjOdeVraWfwDmx9gtN8N5HeUKVHdh3EtxRq9p7?=
 =?us-ascii?Q?rqIDx9JGtL4bokCRzZpRw6hTjE22GOYQ1lYvZjMIRnOPEUC8NOlvfmaN2H6x?=
 =?us-ascii?Q?DdLZaC3axRYaVgB3TTa9QT2+3MucvCc2KLFZKCvDXMzIAy6qhfp7uKXGeyEF?=
 =?us-ascii?Q?Wh/o7wvaaWuR/QV7K8NSpatWZv1gKp7woH8wbpCoYbidhfjWuCCXKoDb9x/T?=
 =?us-ascii?Q?q34Jec9YZLTUnW2qGkrNK5T8tSUAXq8/EzFCTHwcWMlXd4WfuborxfTz8MFi?=
 =?us-ascii?Q?oo6MgZInSJezKM2uP9I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af83de44-2ce3-46c1-5e00-08de31149b5a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:02:51.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH8ByMV3aEmsLC4v/MtJ1JoRjMxUSN5Wvn1WrTYue1SA8FzOFbpX3p9LOB2H/BNJp0XnBVq+e3Y/eN2lXeoU4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10651

On Sun, Nov 30, 2025 at 01:03:52AM +0900, Koichiro Den wrote:
> Historically both TX and RX have assumed the same per-QP MW slice
> (tx_max_entry == remote rx_max_entry), while those are calculated
> separately in different places (pre and post the link-up negotiation
> point). This has been safe because nt->link_is_up is never set to true
> unless the pre-determined qp_count are the same among them, and qp_count
> is typically limited to nt->mw_count, which should be carefully
> configured by admin.
>
> However, setup_qp_mw can actually split mw and handle multi-qps in one
> MW properly, so qp_count needs not to be limited by nt->mw_count. Once
> we relaxing the limitation, pre-determined qp_count can differ among
> host side and endpoint, and link-up negotiation can easily fail.
>
> Move the TX MW configuration (per-QP offset and size) into
> ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
> centralized in a single helper. ntb_transport_init_queue() now deals
> only with per-QP software state, not with MW layout.
>
> This keeps the previous behaviour, while preparing for relaxing the
> qp_count limitation and improving readibility.
>
> No functional change is intended.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 67 ++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 57b4c0511927..79063e2f911b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -569,7 +569,8 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	struct ntb_transport_mw *mw;
>  	struct ntb_dev *ndev = nt->ndev;
>  	struct ntb_queue_entry *entry;
> -	unsigned int rx_size, num_qps_mw;
> +	unsigned int num_qps_mw;
> +	unsigned int mw_size, mw_size_per_qp, qp_offset, rx_info_offset;
>  	unsigned int mw_num, mw_count, qp_count;
>  	unsigned int i;
>  	int node;
> @@ -588,15 +589,33 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	else
>  		num_qps_mw = qp_count / mw_count;
>
> -	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
> -	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
> -	rx_size -= sizeof(struct ntb_rx_info);
> +	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
> +	if (max_mw_size && mw_size > max_mw_size)
> +		mw_size = max_mw_size;
>
> -	qp->remote_rx_info = qp->rx_buff + rx_size;
> +	/* Split this MW evenly among the queue pairs mapped to it. */
> +	mw_size_per_qp = (unsigned int)mw_size / num_qps_mw;

Can you use the same variable firstly to make review easily?

tx_size = (unsigned int)mw_size / num_qps_mw;

It is hard to make sure code logic is the same as old one.

Frank

> +	qp_offset = mw_size_per_qp * (qp_num / mw_count);
> +
> +	/* Place remote_rx_info at the end of the per-QP region. */
> +	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
> +
> +	qp->tx_mw_size = mw_size_per_qp;
> +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> +	if (!qp->tx_mw)
> +		return -EINVAL;
> +	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
> +	if (!qp->tx_mw_phys)
> +		return -EINVAL;
> +	qp->rx_info = qp->tx_mw + rx_info_offset;
> +	qp->rx_buff = mw->virt_addr + qp_offset;
> +	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
>
>  	/* Due to housekeeping, there must be atleast 2 buffs */
> -	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
> -	qp->rx_max_entry = rx_size / qp->rx_max_frame;
> +	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> +	qp->tx_max_entry = mw_size_per_qp / qp->tx_max_frame;
> +	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> +	qp->rx_max_entry = mw_size_per_qp / qp->rx_max_frame;
>  	qp->rx_index = 0;
>
>  	/*
> @@ -1133,11 +1152,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  				    unsigned int qp_num)
>  {
>  	struct ntb_transport_qp *qp;
> -	phys_addr_t mw_base;
> -	resource_size_t mw_size;
> -	unsigned int num_qps_mw, tx_size;
>  	unsigned int mw_num, mw_count, qp_count;
> -	u64 qp_offset;
>
>  	mw_count = nt->mw_count;
>  	qp_count = nt->qp_count;
> @@ -1152,36 +1167,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->event_handler = NULL;
>  	ntb_qp_link_context_reset(qp);
>
> -	if (mw_num < qp_count % mw_count)
> -		num_qps_mw = qp_count / mw_count + 1;
> -	else
> -		num_qps_mw = qp_count / mw_count;
> -
> -	mw_base = nt->mw_vec[mw_num].phys_addr;
> -	mw_size = nt->mw_vec[mw_num].phys_size;
> -
> -	if (max_mw_size && mw_size > max_mw_size)
> -		mw_size = max_mw_size;
> -
> -	tx_size = (unsigned int)mw_size / num_qps_mw;
> -	qp_offset = tx_size * (qp_num / mw_count);
> -
> -	qp->tx_mw_size = tx_size;
> -	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> -	if (!qp->tx_mw)
> -		return -EINVAL;
> -
> -	qp->tx_mw_phys = mw_base + qp_offset;
> -	if (!qp->tx_mw_phys)
> -		return -EINVAL;
> -
> -	tx_size -= sizeof(struct ntb_rx_info);
> -	qp->rx_info = qp->tx_mw + tx_size;
> -
> -	/* Due to housekeeping, there must be atleast 2 buffs */
> -	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
> -	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> -
>  	if (nt->debugfs_node_dir) {
>  		char debugfs_name[8];
>
> --
> 2.48.1
>

