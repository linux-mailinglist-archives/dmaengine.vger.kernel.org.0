Return-Path: <dmaengine+bounces-7547-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF88CB0704
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D8AE301B766
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864D1DD889;
	Tue,  9 Dec 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kDxcdiAk"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E581D63E4;
	Tue,  9 Dec 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295113; cv=fail; b=F1eGoAswIZH+4aJu8tCEWAnGVmout6uJFu9OsEf5TMoZTHEmvN9lVaBphJKSpD2NKS25lbRWgl2RnOP2vFOEkGP26JzpPAmViYNZZy0YOHznP9AkuV45FIx6q5XrfAxzbvw5ddV8A9FdcBuhOB7NE0OnhUdzareNHiNTroMprPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295113; c=relaxed/simple;
	bh=oj/DVpCXsDDQUXGcrUns3ncecHL0fRQEo49iUQ5w3zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jd6D9XUlOkA825iAGMcuzVLqwZ4+cEk/Lj15pwUy5AS7kUeBUJiijM+aaytelC00Mkabra7bxEfcW1LvNKB2KTGWefepn9xOSkFWKIlITCtQestafdzyEENC24oNfYRhJXE4HrE1xXo1FBHSL0Yvc2COkoPK/g/3F/BRGRAHM0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kDxcdiAk; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqyjVghvnFW/Joc2NZn/b6fqE+jm87BiB4KAXKRBBmcdHAsPAeuMNpeqgMWBcjrOLbzI+KKVNaSG9fqX5fkoFrrcTHUhwn/61Dc0aSgSglns1sji+fkDfK+BVkJkaoVPnhEcgMaZKduMJnfgqBFd0CMBbMVo9wAyHgTDNfmV2JC5mVNAUcpMRXsWoYwi/gRF1aglSMrym0rbJsOcWpQhrmz5nkUugGiFjtH+GHmhx5cfYIi7S6WXKvkil2NPLnw0QsDtWrGrxEwabOiKisjtDdyu3xSyebG2n13852EWlE0U/PhRNLXAJR6mxi8b+6iK+zUg4u25XuAELNgJycc3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTWbp5lDhtY/WgZEegvKxuVSit34jSF5hjKlvg/Chpw=;
 b=UnPHxqquG7hEugBnk2kjVH419t2bJlQ5KnnEDJSr750egXULq7/z2uQ58HJ5goJ9PmAcJsaI31YLOxJT1rGbS1LMQtWvMYuCAItMx4v2VZAptqNO3ITjdCrXeUOdsQteKhyclXLTdqXZPwGqGgZ6f3WWzUJ9oFckdRr8M7rzRMF3z4g5ehkXI/waYwPciazHRCh2/z0In82AISgAdsXv7p1MABTlEujNO0dK4Brqi1fJdYNEbu254p/r/i7wGviyZiyrbXzLq5M6+Ix2PuccMzVT6Qxfb96f2FZk+HFo27WbXGygbBRvL3SE2b+fJQ0ZQPdobxp+EheqzYy0j4PR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTWbp5lDhtY/WgZEegvKxuVSit34jSF5hjKlvg/Chpw=;
 b=kDxcdiAkehnVQUvTdHCtP03AAswObeCYU5RGKgQ0RD/gSx5pg2isTcX+obs2OLj/54QRgyQVYEykuuknUdNOgBjEM2jfwRDp0D//IiDc24t1HuXK/aPzkAjZKQBqkGNYsS8E5HmS1LNomS81fKFC2wNXF+806UMUuitHlWUKfwEA/222zLiqQdq5PqzMwJQnqgDfIQGXHbup2Tqufw6036ufxsYYHFfkPlDLpv9VfOSGWrHVRSeL4eqiADh0uVrpeZwuloLYrdxJ8+X9Z184rCpXY5JlANoXuI03jdN6+NS6rWlCdSjjLSeFlBCsxnCX9tV82DEOyFxF2L60uwGqAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB11015.eurprd04.prod.outlook.com (2603:10a6:150:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:45:08 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:45:08 +0000
Date: Tue, 9 Dec 2025 10:44:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 5/8] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Message-ID: <aThD92lA2aiOKZCr@lizhi-Precision-Tower-5810>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <20251208-dma_prep_config-v1-5-53490c5e1e2a@nxp.com>
 <f9107db3-491e-4224-a337-821a89f99132@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9107db3-491e-4224-a337-821a89f99132@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB11015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0388b6-d2f9-4ec2-a40b-08de3739ee31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zu+YGp/9N39/ZsODms2afY+OIRidFQUHytTa1uS7CiJjba4jtJx5VUKhrDVK?=
 =?us-ascii?Q?VUna4EdaVQE66QeSWgA5kcal3ajKvEgr8XDeJrx8BOkxxoA2OB2QZgcA1CLN?=
 =?us-ascii?Q?fAR5Hab50h5bpsGg+j4EZkUDJpNsduB7CLC5NndvQuh3YCCjmyyiwjfMXxrc?=
 =?us-ascii?Q?YXu1QMPgqVAUlf3d3Yhh1reKQFDF8+iyjPN2M1MxWFCDLjCKMUasuMg4pHXV?=
 =?us-ascii?Q?dTa2T4Pig7pxYC/pJiBibD7oKYL24i7H4BuuIUkCUWwJHadwFgAoA4Jp9dyW?=
 =?us-ascii?Q?mwQ0+TGichNr101N0Y2sQ9C4nkr1yCxKb/lhMlP9j4l8odwIvWOmWJb7Cple?=
 =?us-ascii?Q?Vgv1KQLqC3I7s34PLALjjz2XOKtTRkXNUOdy/kEiE+z9pNgAlqIRI3PJximq?=
 =?us-ascii?Q?j0SCr0/Tf5WYXdMhXL+Ant+BTKk4SLfx7GIGdnMjwrH4Yfp2b3lW91Ro0qqR?=
 =?us-ascii?Q?melihFjog1q/7HXYD1pNyrDS7m7sUN4yN6i6WqttQlMPWp9zT3ufZQNPKqtf?=
 =?us-ascii?Q?tZC/Ctv//W3dWGBJtI64PuoRIfFOu/ew5qRauoDkon9D/p9xozAc4zsgCtB6?=
 =?us-ascii?Q?C4ATBA2GYs4HWHE86wP0h8kaOlGx32OlGxxPnOHeFcbM9OBFiV46DjvtyqtF?=
 =?us-ascii?Q?wWc1g06LhnLv0EzXfQQ9mj5Tg5gbQOinjNZjI7y8aIcEShxWD4lc3DzlH3lM?=
 =?us-ascii?Q?aQj+wlzjJibnP8ymhi+KvFtKeCo/yUQYQLK9L4kAGdN4640kFEd4yhf4Qao/?=
 =?us-ascii?Q?uXxo8J6o/mRyaKfPoAtaMWbFpo3RtYXUuxlnEE8/0C0eY771P0vkmeNpJeny?=
 =?us-ascii?Q?Tq/TJtHAyOH0TyXLD4yCpuIPUiCfQHjXxAs5qfPxtNlBtE9YirbQHL0NwgXB?=
 =?us-ascii?Q?G0ck9fVKwZM8nCHba71T+Ui2t6rZKA71McHMKTMVpZSWaBLwGFwkoR3t4ase?=
 =?us-ascii?Q?VPH9dxTdqVakmbeL/Uba2J3G2LY2pQ7ptwVBzEzbaCGF+rN9mz4/qk8ckdEc?=
 =?us-ascii?Q?ragzTQFSZAjAqI9CtrOyH+yvrzeTpulZ0YfktLBC5LlOVrozpo8ENBWSqtta?=
 =?us-ascii?Q?CX5l27kSINN8FlgNyXIeupxW+L2Ymw5Zk321iUv+WjWPWoyXMZlpnznDpMX5?=
 =?us-ascii?Q?JZCALmtZ8Lgs/NJ99WqQFhrlQxMuPEexZxKxUHJrSbUsS/hetsK4Gj0d5e4R?=
 =?us-ascii?Q?vQHHVFrAl+TFEso5eHj3irMSzNcn/MZiB9iWrfuz55GBXcvpKtqg2+zs3Cxy?=
 =?us-ascii?Q?/gOfCPRjWD/WLw+7CUXQQGD6UegHvwIJKlyRuXOfP6xUso2tVVLFrXF5YGu4?=
 =?us-ascii?Q?rCFXGRn0mwzoLixAMt3qS5Mc2+yyBvfQx4DQ0KqD9BDzOw12z8NCJErv306U?=
 =?us-ascii?Q?40uvixZNYH7YwcrcTljvk/JBzaNZZJcJDiffMH1Fh3WTrsAN9wkfLaYmwcn+?=
 =?us-ascii?Q?w7y/ZrYhnFLRsSXNKzcfNOGvn+EirI2gqDm0c6IKgSZ/twvKerUPurT9HfFh?=
 =?us-ascii?Q?UwNtOsq/ZCD4X1KG0pB7qovlKCbzijuVOUvU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9FkdCl7c68IISD7o9B0nEUpWH7tmofF/w4hitKTN3d7GoJx30dC+1LvDJBV?=
 =?us-ascii?Q?MMZHtLynOo+rYtsBoJs/syH2+S4PLqZ/5nSxOBn8ShtSuLUxJx0iqgmBMjZu?=
 =?us-ascii?Q?wDtpEvFCp8D+ENEvSChknXZy1wVEGKX/lw6+ZfhyaXrp5JgiL4JR8c0A2maJ?=
 =?us-ascii?Q?EFhDkG0Bnk6f0SNpaohGdjeTGy5TRXLOHVi7vg7emZ2ZiE8GKW+8IS6EqY1l?=
 =?us-ascii?Q?V7EF6u7T5jMMY5Is0r3O2gpszi3MHWpEw/i/3l5ESctp/DI/4FfmMMwn+bcc?=
 =?us-ascii?Q?Oxq3N0Gw6UQ6gez4mk2KMwYTVKveozaRkxB3AQyINkGxYqkBzpD6jkgpAoE3?=
 =?us-ascii?Q?W2kYtAps5bWbDLA1q2l389xXRBzXS+Uw3qPPs4RlR+uBn9t4k1W68OD+qmOJ?=
 =?us-ascii?Q?tMG5QrDkYqVeBa8vUIgdttPcCaGekGshB4SjaSMwQainxC61HP7j9aER4Rqb?=
 =?us-ascii?Q?ASnkfAtrQ2Vxl8hNuK4RxuxkfRL5VcbKpiX6F/oE9AxuzD8q8yYTg+hTLLpF?=
 =?us-ascii?Q?FnFilv6q7RVisy8glcWLTqH9/qILpGUqMj9X2TyzjwKnPxgNgGZlKzPt85JF?=
 =?us-ascii?Q?UBvqvigrgcFkQSjpi7BTwNUjMquB8SanTz17rY24yfPZVj5J0uuczTW7SgJ7?=
 =?us-ascii?Q?Isz3tSKyz6aeu8JNf3AnPrqr96lpcgIt8MYOB7vGgJHbZrnGoXwOs/mXKBzS?=
 =?us-ascii?Q?R2Z5dN3/9oa48at+I2rP9DVz4Su8Tdi2W1Lwj3+aPhJibqrfDmlUUyIzQ+ya?=
 =?us-ascii?Q?kMBLP7ibLr1w84IQ0IImSyYvLy7K/Qqi548LV0nn47OwYi1jDbfZc7JMGWl0?=
 =?us-ascii?Q?wrD2yGS2kpR4bKVm/ujhuuqXpbt7/cklnDAXUMJxp830N59X872tXBq07z3v?=
 =?us-ascii?Q?Dk/JR01zvFofMeyeiYi0/vjSnDuZD0KUS+NsB8hi2SUNYOJxILYCSdr+LDtI?=
 =?us-ascii?Q?/QVhDn+/rRfTkL8WvqdnK+fAdPJoOjvi5jK+mGNVGXUaKQaj/ZW5m1ToW4tc?=
 =?us-ascii?Q?uFlQg9irxX2h1QTpGKE9MqCsWEjcBt+rkKPF0KMgIo/HpLIgsr00pW7g20ji?=
 =?us-ascii?Q?6rQfdCUoSHndGqeMCskT9h6rp7PGnCwa2txcI31/VBTAzWH8pJvWTa+NZbK3?=
 =?us-ascii?Q?BjHpF/9xPjMLTWnlvf8qdFSAm6ieLGMrVY01Hx1tP0zUKtUgvUs+UBUjHWxs?=
 =?us-ascii?Q?+rROrp138HALbUbBGCBQ0vmEtlOL0ENT7+8+17a0Pk/jlW1oh2rUjFH2O0qe?=
 =?us-ascii?Q?eGuX0hMF6iUdAjmnS6c/AFlKWDDVTNjR6JZ+RA5I5XvLRoz4heW1TbuweJN5?=
 =?us-ascii?Q?4mQxf+G/ztXGjSXWN6OumAVpZSBlaFK4z1Yg+jvrdGfxzVUxB01ZkKB5ea60?=
 =?us-ascii?Q?ob9nzuYTl3Wb4Z540CZbNjwyU8A/VZwm4dlbVZyNeEo5Rt1q6+r2oDY1XIg1?=
 =?us-ascii?Q?bmnPoHXUpRdj8ubdpJf87WYcc5Trmfss6u3mfeF92OW9Ee2T1x/caMsIxKCa?=
 =?us-ascii?Q?XAVczSQugUK3eSKMyuw0e1x/mWX1ItwY2TRp/QWpfY0vKm8BPkBeNHsjEnbh?=
 =?us-ascii?Q?0LERq2MDbqr5s57csH3OsqBkfV39jzRayb7G2Mpc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0388b6-d2f9-4ec2-a40b-08de3739ee31
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:45:08.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/uGsoxGfDpqByRenV7I88oT1EMhBLZvk8Ad7DedjZalLTspzXc+Ctu0ncMyEPVjp9ykFhGQyGo71vAjFxGkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11015

On Tue, Dec 09, 2025 at 03:52:15PM +0900, Damien Le Moal wrote:
> On 12/9/25 2:09 AM, Frank Li wrote:
> > dmaengine_terminate_sync() cancels all pending requests. Calling it for
> > every DMA transfer is unnecessary and counterproductive. This function is
> > generally intended for cleanup paths such as module removal, device close,
> > or unbind operations.
> >
> > Remove the redundant calls.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > This one also fix stress test failure after remove mutex and use new API
> > dmaengine_prep_slave_sg_config().
> > ---
> >  drivers/nvme/target/pci-epf.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> > index 2e78397a7373a7d8ba67150f301f392123db88d1..85225a4f75b5bd7abb6897d064123766af021542 100644
> > --- a/drivers/nvme/target/pci-epf.c
> > +++ b/drivers/nvme/target/pci-epf.c
> > @@ -420,8 +420,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
> >  		ret = -EIO;
> >  	}
> >
> > -	dmaengine_terminate_sync(chan);
>
> If the above dma_sync_wait failed, we better call this here as we have no idea
> why we got the failure, no ?

Yes, it should be call at only failure case.

Frank
> For success case, we indeed may want to remove it.
>
> > -
> >  unmap:
> >  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> >
> >
>
>
> --
> Damien Le Moal
> Western Digital Research

