Return-Path: <dmaengine+bounces-6452-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0CB5377B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5313BA6FC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED690352FCA;
	Thu, 11 Sep 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSNxem0R"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DC320396;
	Thu, 11 Sep 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603923; cv=fail; b=PClsZN1aR6009ZtD1VSnTrjSRlKQ/Qx6Fv7UnLw6XngNaQX3gRlbUmQmVvW+1bbdp5BarlXGP6dLPslnl2756twbyWweAaOmx0zQmaFWUBW97+8Dis2b4AyFEHrI96s3BcgAhElDuN1jEaopcGMrVXJatIxcV6yxPQKMYlzXF2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603923; c=relaxed/simple;
	bh=8sGQXb+IpS196cBo42FercTlkffm+C94C4GEuqG33+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mfoa8ViCTDwJjPpAhu/U43Us7rdjN/LZEsT8ZTaCZmvUW5xTFtfD9PUBVWoDX1a9poIvdqtm4Z9Tfx0OlRG9cs1rCsTOYMSMYIoDJgpVHEEYy3nGLDIbTArUiPKR+7GZUqyiJlCx1mnJqA60qEUHieXLBhbLF2o2KLkBkhPyaAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MSNxem0R; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1eqfCaSSXWF1m8QIP7QDIqW49nz5BYPlaIYeW5JHuWfrMbCJYwq3k8g73oDGy5aMP+iRhqE0TevT1TeUB7meQFJivimTvTvT/otYeSAzxzi+MxvuN9PWkEhCkD46nOJlNTdfBrHc8YeweThCoEI6wxhwgbplYL4jYa09FzNY8Nmp4/NwYjsqD8oZ5I17SQsKmrfpeGjEkUMXP2FeF+xbvQ6sOwyBl1zmspxuYwUmFwbPlzIHkZbXYXuMCYN6jtGloZrfbvKl8YU5I4vYKX3g/XyTcIMHSDLc0U9e88jARGu/7h/I4YyioB9tsJKBX5LqUUGC7eehfPogjFX+Zwx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btq2Nmd5j0A24I4A9mWNr+OYdS8csQku3ZV3dHpm2xQ=;
 b=vWJBuY6JRxEPwmlX9ES79KtIGXwDLSbrFWUuVwcyhaT4coRxY1WaJOJ7vxiUeaGAbw/UNUAWX9VwMSOX+xrOTxwPm96+GPdlZVVt89yiKgrFH1LGuvyTBKG6YgU38xDGrxcscBqF2Z04xt6Vy3xEhBINzf1mqu2PJf6wVgo+DBK4abZXLj13ZoOSh83EH0NWdwcdiqC17C/e5+GNYYnPh6t/R8heQbIVie9yfRLCpHzxFL4tEXHJKJEOy4gBjCJ7KTklkMd3clYxQcCrzFgLm+cTTYmkTr7PdWNzyiRAKrB4yCu88TeD5a954qwdYU0fLDTFQF8j6+3nU0GoJZneYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btq2Nmd5j0A24I4A9mWNr+OYdS8csQku3ZV3dHpm2xQ=;
 b=MSNxem0RxPxENzgCGAIbLuPvw0jMlktLJOBSGjhPBrBj9dE4YUPKCW4I7B8B8+sq2vZtkxpHNR7g526A/wPfRTjB0eJHam9Fvl5tClyBJDGG3NhvX73ZQ/Fb6Om/tRXT8pUK9SfhAnqEkp6ewd+sR7ELcLNrfYjuHBZr0CYJlCtauYuSTbtVNUraAjv7BkobQZdbYjs4/dgCndXRW4ujtlb131y3StBfX3fjodCly2fbn2EI4fIsmQeXX80kElLhZW0PLS5chh5GYfoCaQuz0+lRq1Oqp71oguArqdu0HHbOUuXmfaGuON4xg0KMNfv/GjWqsvYdkCW+AGz4UnFw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VE1PR04MB7392.eurprd04.prod.outlook.com (2603:10a6:800:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 11 Sep
 2025 15:18:33 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 15:18:33 +0000
Date: Thu, 11 Sep 2025 11:18:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] dmaengine: add support for device_link
Message-ID: <aMLoP1/Wmay2v37G@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de>
 <aLhUv+mtr1uZTCth@lizhi-Precision-Tower-5810>
 <20250909120309.5zgez5exbvxn5z3y@pengutronix.de>
 <aMA88W/rDxFesEx+@lizhi-Precision-Tower-5810>
 <20250910193545.gx3qoyjamoxlncqd@pengutronix.de>
 <aMHwbogOA6QTc3Dm@lizhi-Precision-Tower-5810>
 <20250911115056.5iufhnjdhsbiwugw@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911115056.5iufhnjdhsbiwugw@pengutronix.de>
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VE1PR04MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cd219a-0aa4-4428-0983-08ddf14678c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbf2GmXuESKhrUTvLkDaULFA/37+cm3Hqdqs74xtr2utq3vJWH0SLVIO/9LB?=
 =?us-ascii?Q?BkmgV13iJ/H3Jwf4bj1kcxT2Ca/wWknikjmyE8X19ByBuEfUGs59zqZHJ8Bi?=
 =?us-ascii?Q?2J83ag2TCWIEUpox78l9T81OwsxaSQzF8v41ly81LYETtsfPePGyUJRXEOdt?=
 =?us-ascii?Q?3YTt43ji2qhuYwONXcK3ntN5PEAfD93nLrIo7/iFGWn1GC1b4wl40wbddjwB?=
 =?us-ascii?Q?ylu0zvIoKFiXvdcpOMKpfbwPEkf1gjLs1Ohf7Kna8mVWrCv5fQwiSlnERmvO?=
 =?us-ascii?Q?8gQ11z8emRUxhDghdMLBsPAnPNBxVF45rF57Ewu2P2a/J2JxOLImHBZR+0nG?=
 =?us-ascii?Q?+kwKMTHnImNyqdvoSzIqBVW4sG4hB+qG4JOjTyfMFF8B+dTTJWU1SKrdho50?=
 =?us-ascii?Q?YqJ9m5ZgVFU5SnqduA/ZPaWsT8hhBuS5pZ99ADTrx0rkq3r+kMUGHEqjsh90?=
 =?us-ascii?Q?qI26ZLVEl6p5GSesgrrJtPpSD6mGJXl1lBOdFY5dPF1g1zUm+wu5j7J8gwyn?=
 =?us-ascii?Q?/2usot4f0iodhEAcDxlGSmKYWT02UWAHadwcUw1ocVAtzpjAsVNFodH31kzS?=
 =?us-ascii?Q?dforN/iYUHBByqRgpgn3LUcP6JC6JBl5T1/P+Qp6KwD0fN3XyGg3qUjkNHnW?=
 =?us-ascii?Q?Yrffx15kO9hEb0+ie6tRtS+cbrWzsZzDGY3xZnM7l71nuF7i3szcwVhNVb8B?=
 =?us-ascii?Q?4Lu6G50U3WJYL26rJCkHDarJ4e10p9dLqayaRnHnNhqt7N0N1GFkXvqgz2j3?=
 =?us-ascii?Q?6qHHK8ky4O8/8RvKNMVY6c8kiKMzPU0GTgDUd6iZCItK0jUka1NgANFgaBxH?=
 =?us-ascii?Q?c3MzvG4LZwz8YFZ2RBeSu5P3JBJyv9rbrNFWNWY7VO1KL6/iWOo+Aq+rj3Eu?=
 =?us-ascii?Q?MaM3WZfRLpqF5Vgk+EHy57SClMsSJfQbePi9Eddr4iV7Swz2rqYZNiKWumyQ?=
 =?us-ascii?Q?zIV/ZmDeVhHXHsd45ci30q/SfKc4Lp8MUM7+4UXh++TH/84eN/CtI6Ojyl0K?=
 =?us-ascii?Q?nnTPCXiQpdQXSi5OS/QbTHdOlVzdVNQ+opaBJsf5lwgJi7zJFBHQfjNX88aR?=
 =?us-ascii?Q?sC+cZ5U6OL3YHd9IpZhs3l5ZcClN97LaGBtPTz3egX8GUBiu/Ucb+ZD4OWgZ?=
 =?us-ascii?Q?+yFVCnOhO4VdtefrFKNSOIhRT+y0WyqYWVAKrNQFzW5/5F8QFVNJg2nN77uW?=
 =?us-ascii?Q?YTfA/GqfR6oPqqCwh+Yt1HEn310uiRfQn3BrNlSGqYgsh6eZKpaikLPNmTjP?=
 =?us-ascii?Q?iPD9oqvgtruzZ4YB6/RKihfHwqaNtuuyhcwy29HCNXDlYBDI1+OgwBYmcHHy?=
 =?us-ascii?Q?bIKbV8zxVhtZiKf18oeAHkRaCMVcCDt2XPdzLzm4KkHOhmfRFymOmlYWy+5Y?=
 =?us-ascii?Q?STATsnZp0hJNvTdXAAzEwh9yqm96w8KgH6MLjkKgPx5vM3j+AQa6jNGYXA8M?=
 =?us-ascii?Q?O8qSvWVE2s2ljPNIRsgxdr6xtVQyVP1ydh8nSOCa2VDp2MYneC2RUXIp1pOp?=
 =?us-ascii?Q?h6B9qFafGfLwxa8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a/4qi7mtxl3EgfraiV7+Ya2EFDnv1UBFZQv9CcBnds6ObdSCoOMWSHpDhp+8?=
 =?us-ascii?Q?RANsOx9rneDXKdUlE4cPlsRhI59MJf2rWBRFGvD5Tc47kkyyYaYPa/qHqzxY?=
 =?us-ascii?Q?w7Iyks9ggI6+mkEFuavEYN9S5oIvYSjDu7xyZwtSebn0YkUPbR6Bj4Xlivw1?=
 =?us-ascii?Q?km84N88cInJpiKm6SEMmZ8CxXTls8DNsmXM6HDGZtDMCMnHpSJQct08cL3ZX?=
 =?us-ascii?Q?+HG5l+hQ7N87fT86rkyxAXz9TWGZPIvecZlm9WMFRIpYYoCj7kYBgacu14Jq?=
 =?us-ascii?Q?DmRC5HCEK8FNXMqX/zTiU05d8+U/Yp6hDjU7zv2OpT+ThGefT3vdF3YMaK3K?=
 =?us-ascii?Q?uituaDKjPe4Tfna3fG4RSWqgoeAVH6wMRkPSV4mQ0/kqoUq85vGJezauEWRN?=
 =?us-ascii?Q?PZ3fuh+5K0rolqnCDZHgCuVhJZ/635lI14HZ+u9jCAThWi/5gf4Ni4lp+uig?=
 =?us-ascii?Q?8qwIS/7+qS50iUQ1SeZ44oEnE1Qx4lTSOYacng46iOpv7viLFsWE2FLAYmhT?=
 =?us-ascii?Q?dJqTuUH45n0UdarA5R7gcWWPlLpeP/QsMu3CDtX5ANLUTCg1zDt+RRJ2CS44?=
 =?us-ascii?Q?83i9gDeSPqdP7A88zbzarafGC665CLYu2sbuaQMJnK06rkZCKv8C74A02cxW?=
 =?us-ascii?Q?aglm84xqQByGMsIHDK8I3N3gghxYpByjWjza3AM4hxWGQBMDNGQMwasxrT5h?=
 =?us-ascii?Q?epXjL2RhFRYLOP+HExJ0dAeB5EJVKYvVyM50Vpl9zKP/MXpcL6tCAlXlkUaU?=
 =?us-ascii?Q?5+MvdIFkFyQ5IKzqZRxeaIq6qxTpCg76aHsjDI2qmeuWp8rsXdNrjkb6ZOAn?=
 =?us-ascii?Q?IaT5iBdreX7NZnDrudLoTGS6119/l+9ZER/JmDgcd1OwXA9Q1fqrTxc0YC6P?=
 =?us-ascii?Q?/IsyDlUYI3TbVQcyXmSEbpuQo1BfcFkVzCcj0dyyr07F+hreVIt4y20nto2M?=
 =?us-ascii?Q?FaBGmarMQX5nNHt6rpARSEBcjComjRsIiXz3k9aekuU9oVhJh0GimZjY4I9Z?=
 =?us-ascii?Q?wxPfd6PuDYJwOrzhk4PJCYN1mHCPM9SR8jSEYPsUeapYusLoUdfGm4HqliKa?=
 =?us-ascii?Q?dMDKcjw+/CRxLB1KXt/cQYPWQRUxdsVNhCwIIF7Sbmy4HEMFBQSWKA8DBMq/?=
 =?us-ascii?Q?pleAkiLTk8VXsnw+L6ReNGNWNy6JtM9YYzn2dXtbUr+3efBuuaf83t6lfcGP?=
 =?us-ascii?Q?F1SMr79cvLcLDfwaD5yhXXK3VBE6d6f7oHljIslaa7rp6vwitTt84TJwibh5?=
 =?us-ascii?Q?RN30J/nBwBlna/79kAblffSbEwNiN3bNvmEMCEKgmY3m3GTiqIc9HtqNfBXr?=
 =?us-ascii?Q?/6wlS3mZp8yh0ueBYso0XJR3ovt8qMOx8x9ARuWdTGt4WHCNTOnu1grMAPiU?=
 =?us-ascii?Q?3i6M7xMcdyhzOFcSjNyqU0/+W1QHcJYUVC/77rVu/YwF8JnlC+t5tCDO5scf?=
 =?us-ascii?Q?UIqb45PX43NLU1460zg9JzUJ9j4SvlYqJYn6JNJSx6b2jcglqgC5nHWe8kPR?=
 =?us-ascii?Q?KiM5AeeGlmvbiERuVbgJJOnFzYAvWvuGEopZU1t6b5k/szwkmvXM9cHEpf6N?=
 =?us-ascii?Q?RRdTahYFuEUbqzwsu5t2uflXiG/ZKu8Z+VfwWb+p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cd219a-0aa4-4428-0983-08ddf14678c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:18:33.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fszt/F6131Tzq2zpVbF1B8PzjLsH5Bt3GJkgQWBrwNKf5z3lSr9zgLaFHIy551e/W+DphXwUQXsXsaIhACM95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7392

On Thu, Sep 11, 2025 at 01:50:56PM +0200, Marco Felsch wrote:
> On 25-09-10, Frank Li wrote:
> > On Wed, Sep 10, 2025 at 09:35:45PM +0200, Marco Felsch wrote:
> > > On 25-09-09, Frank Li wrote:
> > >
> > > ...
> > >
> > > > > > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > > > > > index 758fcd0546d8bde8e8dddc6039848feeb1e24475..a50652bc70b8ce9d4edabfaa781b3432ee47d31e 100644
> > > > > > > --- a/drivers/dma/dmaengine.c
> > > > > > > +++ b/drivers/dma/dmaengine.c
> > > > > > > @@ -817,6 +817,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > > > > >  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > >  	struct dma_device *d, *_d;
> > > > > > >  	struct dma_chan *chan = NULL;
> > > > > > > +	struct device_link *dl;
> > > > > > >
> > > > > > >  	if (is_of_node(fwnode))
> > > > > > >  		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> > > > > > > @@ -858,6 +859,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> > > > > > >  	/* No functional issue if it fails, users are supposed to test before use */
> > > > > > >  #endif
> > > > > > >
> > > > > > > +	dl = device_link_add(dev, chan->device->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > > > > >
> > > > > > chan->device->dev is dmaengine devices. But some dmaengine's each channel
> > > > > > have device, consumer should link to chan's device, not dmaengine device
> > > > > > because some dmaengine support per channel clock\power management.
> > > > >
> > > > > I get your point. Can you give me some pointers please? To me it seems
> > > > > like the dma_chan_dev is only used for sysfs purpose according the
> > > > > dmaengine.h.
> > > >
> > > > Not really, there are other dma engineer already reuse it for other purpose.
> > > > So It needs update kernel doc for dma_chan_dev.
> > >
> > > Can you please provide me some pointers? I checked the kernel code base
> > > for the struct::dma_chan_dev. I didn't found any references within the
> > > dmaengine drivers. The only usage I found was for the sysfs purpose.
> >
> > static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
> > {
> > 	struct device *chan_dev = &chan->dev->device;
> > 	...
> > }
> >
> > >
> > > > > > chan's device's parent devices is dmaengine devices. it should also work
> > > > > > for sdma case
> > > > >
> > > > > I see, this must be tested of course.
> > > > > > >         if (chan->device->create_devlink) {
> > > > > >                 u32 flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
> > > > >
> > > > > According device_link.rst: using DL_FLAG_STATELESS and
> > > > > DL_FLAG_AUTOREMOVE_CONSUMER is invalid.
> > > > >
> > > > > >                 if (pm_runtime_active(dev))
> > > > > >                         flags |= DL_FLAG_RPM_ACTIVE;
> > > > >
> > > > > This is of course interessting, thanks for the hint.
> > > > >
> > > > > > When create device link (apply channel), consume may active.
> > > > >
> > > > > I have read it as: "resue the supplier and ensure that the supplier
> > > > > follows the consumer runtime state".
> > > > >
> > > > > >                 dl = device_link_add(chan->slave, &chan->dev->device, flags);
> > > > >
> > > > > Huh.. you used the dmaengine device too?
> > > >
> > > > /**
> > > >  * struct dma_chan_dev - relate sysfs device node to backing channel device
> > > >  * @chan: driver channel device
> > > >  * @device: sysfs device
> > > >  * @dev_id: parent dma_device dev_id
> > > >  * @chan_dma_dev: The channel is using custom/different dma-mapping
> > > >  * compared to the parent dma_device
> > > >  */
> > > > struct dma_chan_dev {
> > > > 	struct dma_chan *chan;
> > > > 	struct device device;
> > > > 	int dev_id;
> > > > 	bool chan_dma_dev;
> > > > };
> > > >
> > > > struct dma_chan {
> > > > 	struct dma_device *device; /// this one should be dmaengine
> > > > 	struct dma_chan_dev *dev; /// this one is pre-chan device.
> > > > }
> > >
> > > I've tested your approach but it turns out that teh dma_chan_dev has no
> > > driver. Of course we could use the DL_FLAG_STATELESS flag but this is
> > > described as:
> > >
> > > | When driver presence on the supplier is irrelevant and only correct
> > > | suspend/resume and shutdown ordering is needed, the device link may
> > > | simply be set up with the ``DL_FLAG_STATELESS`` flag.  In other words,
> > > | enforcing driver presence on the supplier is optional.
> > >
> > > I want to enforce the driver presence, therefore I used the manged flags
> > > which excludes the DL_FLAG_STATELESS, if I get it right.
> > >
> > > Please see the below the debug output:
> > >
> > > ** use the dmaengine device as supplier **
> > >
> > > device_link_init_status: supplier.dev:30bd0000.dma-controller supplier.drv:imx-sdma supplier.status:0x2 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> > > device_link_init_status: supplier.dev:30e10000.dma-controller supplier.drv:imx-sdma supplier.status:0x2 consumer:dev:30c20000.sai consumer.drv:fsl-sai consumer.status:0x1
> > >
> > >
> > > ** use the dma channel device as supplier **
> > >
> > > device_link_init_status: supplier.dev:dma0chan0 supplier.drv:no-driver supplier.status:0x0 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> > > device_link_init_status: supplier.dev:dma0chan1 supplier.drv:no-driver supplier.status:0x0 consumer:dev:30840000.spi consumer.drv:spi_imx consumer.status:0x1
> >
> > It should be similar with phy drivers, which phy_create() create individual
> > phy devices (like dma channel devices).
>
> Unfortunately phy drivers do use the DL_FLAG_STATELESS mechanism. My
> main goal was to have managed links to overcome the current situation:
> dmaengine drivers can be removed without removing the consumer drivers
> first.
>
> You have a valid point by making use dma-channel devices ( dma<X>cha<Y>)
> to manage suspend/resume, as well as runtime-PM for each channel.
>
> But I see this rather as an addition to my solution because these links
> must be stateless and stateless/unmanaged links don't guarantee the
> correct remove order (my main goal).

If that, phy should have simiar problems. It should be resolved at higher
layer to avoid fix this kinds of problem one by one.

>
> That beeing said, I'm not sure how you want to handle the clock/power
> enablement per channel-device. This would require additional work on the
> dma_devclass to add a proper .pm hook else the PM and runtime-PM calls
> are only forwarded to the parent dmaengine driver. On this level the
> dmaengine driver has no knowledge which channel is going to be
> enabled/disabled.

I have draft runtime pm patch for eDMA.

>
> In conclusion, I see my approach as valid to ensure the correct remove
> order. Your suggestion is valid and can be added later on too since this
> needs more work to have a proper per-channel runtime-PM.

We need pave a good road. This part is common dma-engine, which is worth to
do good solution.

Frank

>
> Regards,
>   Marco
>
> >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 51 at /drivers/base/core.c:1387 device_links_driver_bound+0x170/0x3a0
> > > ...
> > > ---[ end trace 0000000000000000 ]---
> > > ------------[ cut here ]------------
> > >
> > > As said, I get your point regarding the usage of the dma-channel device
> > > but I didn't found any reference to a driver which used the dma-channel
> > > device. Also since I want to have the supply driver to enforced by the
> > > devlink I don't want to use the DL_FLAG_STATELESS flag.
> >
> > Maybe add DL_FLAG, link to parent's device driver. Need some time to
> > investigate more. PHY driver should good example to refer to.
> >
> > >
> > > Regarding your point, that some DMA controllers may have seperate clocks
> > > for each channel: I think this can be handled by the dmaengine driver,
> > > e.g. via the device_alloc_chan_resources() hook.
> >
> > device_alloc_chan_resources() is not efficient enough, most driver allocate
> > channel at probe, so clk of this channel will be always on. ideally, only
> > when consumer devices is runtime resume state,  turn on dma channel clock.
> >
> > Frank
> > >
> > > @all
> > > I'm pleased about any input :)
> > >
> > > Regards,
> > >   Marco
> >

