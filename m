Return-Path: <dmaengine+bounces-2195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B651B8D2043
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 17:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D980D1C21D9B
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457341E507;
	Tue, 28 May 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ooNdpKL3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B986170833
	for <dmaengine@vger.kernel.org>; Tue, 28 May 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909724; cv=fail; b=iMPGsals4tO49M0HDHV6rIwykcs1oNbaTB5VXv6XpyXXvQ6pX1jUw/ulD2RMYSqk4vEu9247mBOXFidZePk3fwO8hbbPj2pe4qr/oH+REvN5VUj/KURjuIkEHVgPJV7dFnWcN8m6P6S21Hm47DPsjY5my1x0P0U5T+I2zPWQjcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909724; c=relaxed/simple;
	bh=M8Xl+RRw+33PenFGQjHSxtus7RUEUrz3ZItko5q55g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLdrnhzSS+wHOKnxnTalXTeQbI+zDgQoW7Gua3lrU5sxtTiUM7mXj1M+7Gv2fxN4fbEarQ1xdtM+ZQAKDvggUV3M6DgrjIY21rM9anUi1Oos3+hNbkrHR9dkR6iXVNOFh4Fn0CLCVOCyPXr63DBPVy/1/NSKIXoK8lBj+7c3OM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ooNdpKL3; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWupp0FyQVFaM6tLxsevA6k3IKhuYSbWtH7QdSEsJO66d3Nyft8p8lDD0mEoEyf/Inw/5FP4wtUzXSf8Z9XV+Dx7PK0QKoxERTmlw/WiDD1u18mXGU4M2Ox5oQqakceW/0c15Was80hMnBWgzLN+1qVgXtnVIZ7V3wiXU04rdNkoXZqllWYIqOvO1ul9Qs/+7T5VB1QLxxHgnkDMYv7DunQsK4QORPJMmHFvaCTA6m8D4r2Q6NYC0B+kyxzu6lLva0ssZqNCHZRDPESC4yHqRUiHHCnEzhxoNTznnjMJezJn1MojFZKcQBBwjhLZiZr9vyjiwTApJDoYKAUPZ+eStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPvltClIp/XzuQ5FfSaS5vLkF0Nr/tJEwKkfNfGhnlg=;
 b=mWtfctbulWANc2f3qkMb5C1AFvKq7HZM0mkcEi5bvCE/RJ9h/YwgO3GopmphD8MULzw6VCfHml1Ia4Fj7psCQ2lWAlIBLQlciE7JNnjxAOCgm9Q+8ptzwhym5KuwK9fGHQYmZ0sMm/ynrQl9ftYvFU18yCkFgqgdoPRl9buC1xmTFoaTHS8vtc0PPlIeB1wMD9b6ab/84JJjdh/71WE0i3PRVyQt3wwnSIi/z9x0ObUDDd0BEXo/VMd5W6S/6hLcaUzEsVfUyixk73w8xQyEmW5R6DF3fgiYrBj300DMStovycmVWsx9popoce6MC7JuCsycPGMT90c0g6dZqm/TXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPvltClIp/XzuQ5FfSaS5vLkF0Nr/tJEwKkfNfGhnlg=;
 b=ooNdpKL3hC/FGW91d/4kXRVOWwC0KFf3H0BCJHxJQnp8buvMAZyK/wtA/SYHxyEWKyGIbUkzMnj9k/673W76jAAsEjCG5arkd3H8r3aZse0SOHLVMKq1cxVLfo5cMiXMuWFksbT7lgyIsA8USr6rIUnI4wjnfra/VTxLwwv57so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10155.eurprd04.prod.outlook.com (2603:10a6:150:1a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:21:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 15:21:58 +0000
Date: Tue, 28 May 2024 11:21:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org, Raju.Rangoju@amd.com
Subject: Re: [PATCH 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
Message-ID: <ZlX2kEaTMFlLNO4S@lizhi-Precision-Tower-5810>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
 <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
 <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
 <22e39316-d446-46a4-9c11-96e97413f842@amd.com>
 <Zk+87eRJBvbO+BhG@lizhi-Precision-Tower-5810>
 <6d8d996b-1732-4e69-95e5-af4673d24908@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d8d996b-1732-4e69-95e5-af4673d24908@amd.com>
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10155:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ae7657-1936-4e2e-8fc6-08dc7f29ea11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnNfDNRa7wnZTWTl6zGOPnRxoyAY5BmqkSq/fNygF6B6G26P2NFSnuOFioyL?=
 =?us-ascii?Q?oijJ/+d+l9Dd3JC5EjtAIKwxkaad7yfznKkx0VJh9QSzifAZNsx+nDGrbw6g?=
 =?us-ascii?Q?/bRemBpBi4yfBrA7nfkuEIbbTn4KAjBbwWuEoKGtUBPiJf3jPsfZaOlBhmkG?=
 =?us-ascii?Q?mrxdhStmNE/pPS8FIlv6xoLNofqSRantNa4Co0jagXXleV7q8Mt+qJFRj1IX?=
 =?us-ascii?Q?CH6II0Rhono3UmlR8bUP+9GUGLk69j4i5cy5FTFOROCdIUJaJ2mCVnyZ2wZ2?=
 =?us-ascii?Q?cw5NEfJJsmZR3IPFKBsHQ2u/l2AoZH2o7xE2Ykivtrhl+i8/h4LiUEMis14M?=
 =?us-ascii?Q?26wOD8/kPhXWQTVSiu1Qiw3d9a5qhB+zf6jDF5D3DOT9qbQHNIU3R7WAkYtL?=
 =?us-ascii?Q?Wg2hIgsvlzVioqwOeLKn6HZl3+/ggXD/5hN0ddjmuoEml5EPrzcKF6wCbswg?=
 =?us-ascii?Q?Bn+PbjQFMBonpK/lTm8LimPyRFcPf1rWB/y1EOYK/jTKqkAV+sB58SaPS/Tt?=
 =?us-ascii?Q?1+2CsWZHlEANT4W8Z4ym63l+9PQTFTuX1btPpujrxrs+26QIlLT/N6C4h6Ki?=
 =?us-ascii?Q?a6rMdCOMBW6RahPgqHYzScQulqO8oZeLxKnTE0hlX+Ceiiyp5Sav/9qAa4HV?=
 =?us-ascii?Q?FPyd5pvgEOJpU2SH6tHhvyaTt9gIGkjt+A/ilTLd2OtJ3HjkMyyqUad8ncgt?=
 =?us-ascii?Q?heUNiItr/AhqpUQ48jGe99U9PNJ+2nVEhvYwLMqOkoAXkCwiI6827OwpLqtW?=
 =?us-ascii?Q?ilMOcLq6vLl/hO9yHvEelX4MMmMLzY4/ZT9zbYo5oryUNfw9qaxNaISz1jaU?=
 =?us-ascii?Q?NRMxcUJ4CKqAChQpYD/ucBizPTSj9AjDK6kvOMlJUEV5umGLJWBpp/2la6w+?=
 =?us-ascii?Q?iBAcCiOLCvHiNLtuukdrJr936FqNriVf3HOsslqDs3r/b8yTxadaToQvkc+L?=
 =?us-ascii?Q?b+5k/1WIXxaHzLVvGLmI4s8MbmOfM5y9s5Pkphp2jVUzu6NGoWXH7HYOyqJW?=
 =?us-ascii?Q?7If38fafQ/UrPOk/HbQh6gt393ggxWxa5yVhWBny39Vr2Bp0LjnthasSfmUK?=
 =?us-ascii?Q?D6eLl4/jAk5geRKnaW/L2mks95SCppFAFNB46RpnKv6yfH+K4PQB1PmyckSm?=
 =?us-ascii?Q?OG4GfxUI0Dlr26GG0Htwv2yAImz7+g0FTywKlWOd3ggLFoLC7kGGniGczNDy?=
 =?us-ascii?Q?t5iPrmu4vmIX9fLEOFxkjYdc5InGKlraJoyusw5HJqNjrNewYetmhV2QxRBX?=
 =?us-ascii?Q?jNL53pk7hHPc+YnYTAs5+X9gIf2LBfEye/QyoeLzVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDt3wkYjWONd15J6VKH4HXlt3dDyMSqXivbZaDFl7qqiH78RrQtBmjVvfv5s?=
 =?us-ascii?Q?IfVoE41gfVrX054O010fENSGyVS+qc/0bS4+PSavMs8aR1JfZRoHlVBWKsmf?=
 =?us-ascii?Q?nRr86trfn7MrVS2VHUqJnmZGUJIMbtexrzHVUr2iJxnslsYUAXCyBnyUcwGy?=
 =?us-ascii?Q?9qZ1i3PzySqWwb7rlhwk07GScRryxTNH5ODBwO38Gd1AeY4CnKy93CBccKnW?=
 =?us-ascii?Q?GNdnC6mTOzJU4Aqd+67H5B//rGlgqAo7vdl3x5omIUTp9GU/g7nLEVLmKeLc?=
 =?us-ascii?Q?sOonhHUUAx8ZQW1g2//1Z2guY/j+fdyaUcAMiShNee/wRFqy4VeGoes/rnkL?=
 =?us-ascii?Q?9qYB0phi6i+dG8bJerW0d1z8fVHh5vQzfLYLBUkQaJPcndHLGEke8k4EZWCv?=
 =?us-ascii?Q?HR5U/JAdT1ZN0dkal2ndkRIgFqAGPl1oucahFMnSzbFMdIr8KyHcGPadAtI7?=
 =?us-ascii?Q?ERAbFi/of/BozPocJgqhD1qJI1olbdmoz6o5PmaHDFW6uZjyXthisZM6T1DR?=
 =?us-ascii?Q?F788Yh8jNiQjN9044X00wGJ+auTBb4ZF5Gp5qFCDAhnh7gn80nKmJPq8xSub?=
 =?us-ascii?Q?b7xQnbgwkToo0Nfq4eRwKj9L6xS5CBIM7wNy2kSrFWN8ex3gdYIXGyefZyKy?=
 =?us-ascii?Q?olhr7kJ1TlF6ETVbkdC+R66x4JIyZNiBlTydYPVLteldOQ3HoPJpRt7SwCXI?=
 =?us-ascii?Q?mLGKEU2Znb9B8o93szfwnGrgoTqYLNrvO4Y178ZuHQvBIQJ7edsaNQd39Thb?=
 =?us-ascii?Q?NL9Yz1oQojKxwMtzgwRJN1iBMDx4Z1xqr74V0tVC9zKCoyboocdT6JaYnA0Y?=
 =?us-ascii?Q?1vzjE/RTrOz0eLOhyAfCB1etvj2cqKgcFEHJKS2cjFZuqgR3aaFo1jGPtsTG?=
 =?us-ascii?Q?O8Rdgul6SZY0/gQyg3bA2o01rA4ADKVZum38WMI7UiAh15Jfc6CPmQpe8/om?=
 =?us-ascii?Q?c4UvzGDDRVbWSR7DN4rUhFutX/3g/JnhSVd2j3MhOMY8h2lTL/w8P3EVm8Yu?=
 =?us-ascii?Q?ROF9UeZBl5MSBg08e21GlSW1wQZv1n9L9rArT8K+lpD4E4RgslMWIYZBVM2U?=
 =?us-ascii?Q?FP4VELwjz9gt2wgyGe+GYUxRNKyABbLMdUw3p3pGiSeQ/ws6yj8oqU15C8rU?=
 =?us-ascii?Q?0dC2xYJojP+Df/FvjkRzdLY41tcWcdvpDDA/mtIgo4MDm1/iSzL/2+ayT5cC?=
 =?us-ascii?Q?PTg9jeIA6Wwc+aQ1w0Kjon3fy/Ez7RICu+cFklrG1/ooAjL8aWTrDzKOFYlE?=
 =?us-ascii?Q?rILzM3XhyyifBp0Wv+OJzEHeKx1mjliuKapQ0LJBP7KISC+pYk5NnosGXYOS?=
 =?us-ascii?Q?xTIvbLlDfpnSK6RLK2Wqc+9a3u26gnSQVF59wUtW2YKOffQddKoiYLWKcX2U?=
 =?us-ascii?Q?KYng6sA4n2JVVlilo0GG3mgzEGC7Xb+y5LMb2xfdEWKhQDDamD1AEXYhuB28?=
 =?us-ascii?Q?6mHgfeeaKrv5UnvD61TfxnTTH+0dimwBs5xHzKY3lasWRGV7AgugiXBF5q0l?=
 =?us-ascii?Q?iODLCEPyQTVhuHnTNR+ZFYY5jsv304mULHwD4CQmqSYiMvVCVn4hrmSlKz9p?=
 =?us-ascii?Q?VHODcu7b5N6KK4IKQKI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ae7657-1936-4e2e-8fc6-08dc7f29ea11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:21:58.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw/1/ABw23ZTNCA1zkf8R59S9DDEqcjBSYCojXVETPCojRaOQGrQGflz5Ll7+CVS88ei260OGjDVSJukGQZmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10155

On Mon, May 27, 2024 at 05:04:02PM +0530, Basavaraj Natikar wrote:
> 
> On 5/24/2024 3:32 AM, Frank Li wrote:
> > On Tue, May 21, 2024 at 03:06:17PM +0530, Basavaraj Natikar wrote:
> >> On 5/10/2024 11:46 PM, Frank Li wrote:
> >>> On Fri, May 10, 2024 at 01:50:48PM +0530, Basavaraj Natikar wrote:
> >>>> Add support for AMD AE4DMA controller. It performs high-bandwidth
> >>>> memory to memory and IO copy operation. Device commands are managed
> >>>> via a circular queue of 'descriptors', each of which specifies source
> >>>> and destination addresses for copying a single buffer of data.
> >>>>
> >>>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> >>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>>> ---
> >>>>  MAINTAINERS                         |   6 +
> >>>>  drivers/dma/amd/Kconfig             |   1 +
> >>>>  drivers/dma/amd/Makefile            |   1 +
> >>>>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
> >>>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
> >>>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
> >>>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 195 ++++++++++++++++++++++++++
> >>>>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
> >>>>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
> >>>>  9 files changed, 535 insertions(+)
> >>>>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
> >>>>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
> >>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
> >>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
> >>>>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
> >>>>  create mode 100644 drivers/dma/amd/common/amd_dma.h
> >>>>
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index b190efda33ba..45f2140093b6 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -909,6 +909,12 @@ L:	linux-edac@vger.kernel.org
> >>>>  S:	Supported
> >>>>  F:	drivers/ras/amd/atl/*
> >>>>  
> >>>> +AMD AE4DMA DRIVER
> >>>> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>>> +L:	dmaengine@vger.kernel.org
> >>>> +S:	Maintained
> >>>> +F:	drivers/dma/amd/ae4dma/
> >>>> +
> >>>>  AMD AXI W1 DRIVER
> >>>>  M:	Kris Chaplin <kris.chaplin@amd.com>
> >>>>  R:	Thomas Delev <thomas.delev@amd.com>
> >>>> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
> >>>> index 8246b463bcf7..8c25a3ed6b94 100644
> >>>> --- a/drivers/dma/amd/Kconfig
> >>>> +++ b/drivers/dma/amd/Kconfig
> >>>> @@ -3,3 +3,4 @@
> >>>>  # AMD DMA Drivers
> >>>>  
> >>>>  source "drivers/dma/amd/ptdma/Kconfig"
> >>>> +source "drivers/dma/amd/ae4dma/Kconfig"
> >>>> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
> >>>> index dd7257ba7e06..8049b06a9ff5 100644
> >>>> --- a/drivers/dma/amd/Makefile
> >>>> +++ b/drivers/dma/amd/Makefile
> >>>> @@ -4,3 +4,4 @@
> >>>>  #
> >>>>  
> >>>>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
> >>>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
> >>>> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
> >>>> new file mode 100644
> >>>> index 000000000000..cf8db4dac98d
> >>>> --- /dev/null
> >>>> +++ b/drivers/dma/amd/ae4dma/Kconfig
> >>>> @@ -0,0 +1,13 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +config AMD_AE4DMA
> >>>> +	tristate  "AMD AE4DMA Engine"
> >>>> +	depends on X86_64 && PCI
> >>>> +	select DMA_ENGINE
> >>>> +	select DMA_VIRTUAL_CHANNELS
> >>>> +	help
> >>>> +	  Enable support for the AMD AE4DMA controller. This controller
> >>>> +	  provides DMA capabilities to perform high bandwidth memory to
> >>>> +	  memory and IO copy operations. It performs DMA transfer through
> >>>> +	  queue-based descriptor management. This DMA controller is intended
> >>>> +	  to be used with AMD Non-Transparent Bridge devices and not for
> >>>> +	  general purpose peripheral DMA.
> >>>> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
> >>>> new file mode 100644
> >>>> index 000000000000..e918f85a80ec
> >>>> --- /dev/null
> >>>> +++ b/drivers/dma/amd/ae4dma/Makefile
> >>>> @@ -0,0 +1,10 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +#
> >>>> +# AMD AE4DMA driver
> >>>> +#
> >>>> +
> >>>> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
> >>>> +
> >>>> +ae4dma-objs := ae4dma-dev.o
> >>>> +
> >>>> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
> >>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> >>>> new file mode 100644
> >>>> index 000000000000..fc33d2056af2
> >>>> --- /dev/null
> >>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> >>>> @@ -0,0 +1,206 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * AMD AE4DMA driver
> >>>> + *
> >>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >>>> + * All Rights Reserved.
> >>>> + *
> >>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>>> + */
> >>>> +
> >>>> +#include "ae4dma.h"
> >>>> +
> >>>> +static unsigned int max_hw_q = 1;
> >>>> +module_param(max_hw_q, uint, 0444);
> >>>> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
> >>> Does it get from hardware register? you put to global variable. How about
> >>> system have two difference DMA controllers, one's max_hw_q is 1, the other
> >>> is 2.
> >> Yes, this global value configures the default hardware register to 1. Since
> >> all DMA controllers are identical, they will all have the same value set for
> >> all DMA controllers. 
> > Even it is same now. I still perfer put 
> >
> > +static const struct pci_device_id ae4_pci_table[] = {
> > +	{ PCI_VDEVICE(AMD, 0x14C8), MAX_HW_Q},
> 
> The default number of configurable queues can be changed up to the maximum
> supported by the hardware to achieve optimal application performance.
> 
> Applications can utilize these per-DMA controller queues by dynamically
> loading and unloading drivers with the desired number of configurable
> hardware queues. If we restrict always to max hardware queue, then
> we can't use dynamic queue configurations for each DAM controller.

You should use sys interface to set max queues for difference instance.
module param will set the same value for all dma device instance.

Frank 

> 
> Thanks,
> --
> Basavaraj
> 
> > 				    ^^^^^^^^
> >
> > +	{ PCI_VDEVICE(AMD, 0x14DC), ...},
> > +	{ PCI_VDEVICE(AMD, 0x149B), ...},
> > +	/* Last entry must be zero */
> > +	{ 0, }
> >
> > So if new design increase queue number in future. 
> > You just need add one line here.
> >
> > Frank
> >
> >>>> +
> >>>> +static char *ae4_error_codes[] = {
> >>>> +	"",
> >>>> +	"ERR 01: INVALID HEADER DW0",
> >>>> +	"ERR 02: INVALID STATUS",
> >>>> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> >>>> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> >>>> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> >>>> +	"ERR 06: INVALID ALIGNMENT",
> >>>> +	"ERR 07: INVALID DESCRIPTOR",
> >>>> +};
> >>>> +
> >>>> +static void ae4_log_error(struct pt_device *d, int e)
> >>>> +{
> >>>> +	if (e <= 7)
> >>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> >>>> +	else if (e > 7 && e <= 15)
> >>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> >>>> +	else if (e > 15 && e <= 31)
> >>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> >>>> +	else if (e > 31 && e <= 63)
> >>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> >>>> +	else if (e > 63 && e <= 127)
> >>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> >>>> +	else if (e > 127 && e <= 255)
> >>>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> >>>> +	else
> >>>> +		dev_info(d->dev, "Unknown AE4DMA error");
> >>>> +}
> >>>> +
> >>>> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> >>>> +{
> >>>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> >>>> +	struct ae4dma_desc desc;
> >>>> +	u8 status;
> >>>> +
> >>>> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> >>>> +	/* Synchronize ordering */
> >>>> +	mb();
> >>> does dma_wmb() enough? 
> >> Sure, I will change to dma_rmb which is enough for this scenario.
> >>
> >>>> +	status = desc.dw1.status;
> >>>> +	if (status && status != AE4_DESC_COMPLETED) {
> >>>> +		cmd_q->cmd_error = desc.dw1.err_code;
> >>>> +		if (cmd_q->cmd_error)
> >>>> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> >>>> +	}
> >>>> +}
> >>>> +
> >>>> +static void ae4_pending_work(struct work_struct *work)
> >>>> +{
> >>>> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
> >>>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> >>>> +	struct pt_cmd *cmd;
> >>>> +	u32 cridx, dridx;
> >>>> +
> >>>> +	while (true) {
> >>>> +		wait_event_interruptible(ae4cmd_q->q_w,
> >>>> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
> >>>> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
> >>> wait_event_interruptible_timeout() ? to avoid patental deadlock.
> >> A thread will be created and started for each queue initially. These threads will wait for any DMA
> >> operation to complete quickly. If there are no DMA operations, the threads will remain idle, but
> >> there won't be a deadlock.
> >>
> >>>> +
> >>>> +		atomic64_inc(&ae4cmd_q->done_cnt);
> >>>> +
> >>>> +		mutex_lock(&ae4cmd_q->cmd_lock);
> >>>> +
> >>>> +		cridx = readl(cmd_q->reg_control + 0x0C);
> >>>> +		dridx = atomic_read(&ae4cmd_q->dridx);
> >>>> +
> >>>> +		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
> >>>> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
> >>>> +			list_del(&cmd->entry);
> >>>> +
> >>>> +			ae4_check_status_error(ae4cmd_q, dridx);
> >>>> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
> >>>> +
> >>>> +			atomic64_dec(&ae4cmd_q->q_cmd_count);
> >>>> +			dridx = (dridx + 1) % CMD_Q_LEN;
> >>>> +			atomic_set(&ae4cmd_q->dridx, dridx);
> >>>> +			/* Synchronize ordering */
> >>>> +			mb();
> >>>> +
> >>>> +			complete_all(&ae4cmd_q->cmp);
> >>>> +		}
> >>>> +
> >>>> +		mutex_unlock(&ae4cmd_q->cmd_lock);
> >>>> +	}
> >>>> +}
> >>>> +
> >>>> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
> >>>> +{
> >>>> +	struct ae4_cmd_queue *ae4cmd_q = data;
> >>>> +	struct pt_cmd_queue *cmd_q;
> >>>> +	struct pt_device *pt;
> >>>> +	u32 status;
> >>>> +
> >>>> +	cmd_q = &ae4cmd_q->cmd_q;
> >>>> +	pt = cmd_q->pt;
> >>>> +
> >>>> +	pt->total_interrupts++;
> >>>> +	atomic64_inc(&ae4cmd_q->intr_cnt);
> >>>> +
> >>>> +	wake_up(&ae4cmd_q->q_w);
> >>>> +
> >>>> +	status = readl(cmd_q->reg_control + 0x14);
> >>>> +	if (status & BIT(0)) {
> >>>> +		status &= GENMASK(31, 1);
> >>>> +		writel(status, cmd_q->reg_control + 0x14);
> >>>> +	}
> >>>> +
> >>>> +	return IRQ_HANDLED;
> >>>> +}
> >>>> +
> >>>> +void ae4_destroy_work(struct ae4_device *ae4)
> >>>> +{
> >>>> +	struct ae4_cmd_queue *ae4cmd_q;
> >>>> +	int i;
> >>>> +
> >>>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> >>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> >>>> +
> >>>> +		if (!ae4cmd_q->pws)
> >>>> +			break;
> >>>> +
> >>>> +		cancel_delayed_work(&ae4cmd_q->p_work);
> >>> do you need cancel_delayed_work_sync()?
> >> Sure, I will change to cancel_delayed_work_sync.
> >>
> >>>> +		destroy_workqueue(ae4cmd_q->pws);
> >>>> +	}
> >>>> +}
> >>>> +
> >>>> +int ae4_core_init(struct ae4_device *ae4)
> >>>> +{
> >>>> +	struct pt_device *pt = &ae4->pt;
> >>>> +	struct ae4_cmd_queue *ae4cmd_q;
> >>>> +	struct device *dev = pt->dev;
> >>>> +	struct pt_cmd_queue *cmd_q;
> >>>> +	int i, ret = 0;
> >>>> +
> >>>> +	writel(max_hw_q, pt->io_regs);
> >>>> +
> >>>> +	for (i = 0; i < max_hw_q; i++) {
> >>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> >>>> +		ae4cmd_q->id = ae4->cmd_q_count;
> >>>> +		ae4->cmd_q_count++;
> >>>> +
> >>>> +		cmd_q = &ae4cmd_q->cmd_q;
> >>>> +		cmd_q->pt = pt;
> >>>> +
> >>>> +		/* Preset some register values (Q size is 32byte (0x20)) */
> >>>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
> >>>> +
> >>>> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
> >>>> +				       dev_name(pt->dev), ae4cmd_q);
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>> +
> >>>> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
> >>>> +
> >>>> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
> >>>> +						   GFP_KERNEL);
> >>>> +		if (!cmd_q->qbase)
> >>>> +			return -ENOMEM;
> >>>> +	}
> >>>> +
> >>>> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> >>>> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> >>>> +
> >>>> +		cmd_q = &ae4cmd_q->cmd_q;
> >>>> +
> >>>> +		/* Preset some register values (Q size is 32byte (0x20)) */
> >>>> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
> >>>> +
> >>>> +		/* Update the device registers with queue information. */
> >>>> +		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
> >>>> +
> >>>> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
> >>>> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
> >>>> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
> >>>> +
> >>>> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
> >>>> +		init_waitqueue_head(&ae4cmd_q->q_w);
> >>>> +
> >>>> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
> >>> Can existed workqueue match your requirement? 
> >> Separate work queues for each queue, compared to a existing workqueue, enhance performance by enabling
> >> load balancing across queues, ensuring DMA command execution even under memory pressure, and
> >> maintaining strict isolation between tasks in different queues.
> >>
> >>> Frank
> >>>
> >>>> +		if (!ae4cmd_q->pws) {
> >>>> +			ae4_destroy_work(ae4);
> >>>> +			return -ENOMEM;
> >>>> +		}
> >>>> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
> >>>> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
> >>>> +
> >>>> +		init_completion(&ae4cmd_q->cmp);
> >>>> +	}
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> >>>> new file mode 100644
> >>>> index 000000000000..4cd537af757d
> >>>> --- /dev/null
> >>>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> >>>> @@ -0,0 +1,195 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * AMD AE4DMA driver
> >>>> + *
> >>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >>>> + * All Rights Reserved.
> >>>> + *
> >>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>>> + */
> >>>> +
> >>>> +#include "ae4dma.h"
> >>>> +
> >>>> +static int ae4_get_msi_irq(struct ae4_device *ae4)
> >>>> +{
> >>>> +	struct pt_device *pt = &ae4->pt;
> >>>> +	struct device *dev = pt->dev;
> >>>> +	struct pci_dev *pdev;
> >>>> +	int ret, i;
> >>>> +
> >>>> +	pdev = to_pci_dev(dev);
> >>>> +	ret = pci_enable_msi(pdev);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> >>>> +		ae4->ae4_irq[i] = pdev->irq;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
> >>>> +{
> >>>> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> >>>> +	struct pt_device *pt = &ae4->pt;
> >>>> +	struct device *dev = pt->dev;
> >>>> +	struct pci_dev *pdev;
> >>>> +	int v, i, ret;
> >>>> +
> >>>> +	pdev = to_pci_dev(dev);
> >>>> +
> >>>> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
> >>>> +		ae4_msix->msix_entry[v].entry = v;
> >>>> +
> >>>> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
> >>>> +	if (ret < 0)
> >>>> +		return ret;
> >>>> +
> >>>> +	ae4_msix->msix_count = ret;
> >>>> +
> >>>> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> >>>> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static int ae4_get_irqs(struct ae4_device *ae4)
> >>>> +{
> >>>> +	struct pt_device *pt = &ae4->pt;
> >>>> +	struct device *dev = pt->dev;
> >>>> +	int ret;
> >>>> +
> >>>> +	ret = ae4_get_msix_irqs(ae4);
> >>>> +	if (!ret)
> >>>> +		return 0;
> >>>> +
> >>>> +	/* Couldn't get MSI-X vectors, try MSI */
> >>>> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> >>>> +	ret = ae4_get_msi_irq(ae4);
> >>>> +	if (!ret)
> >>>> +		return 0;
> >>>> +
> >>>> +	/* Couldn't get MSI interrupt */
> >>>> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>> +static void ae4_free_irqs(struct ae4_device *ae4)
> >>>> +{
> >>>> +	struct ae4_msix *ae4_msix;
> >>>> +	struct pci_dev *pdev;
> >>>> +	struct pt_device *pt;
> >>>> +	struct device *dev;
> >>>> +	int i;
> >>>> +
> >>>> +	if (ae4) {
> >>>> +		pt = &ae4->pt;
> >>>> +		dev = pt->dev;
> >>>> +		pdev = to_pci_dev(dev);
> >>>> +
> >>>> +		ae4_msix = ae4->ae4_msix;
> >>>> +		if (ae4_msix && ae4_msix->msix_count)
> >>>> +			pci_disable_msix(pdev);
> >>>> +		else if (pdev->irq)
> >>>> +			pci_disable_msi(pdev);
> >>>> +
> >>>> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> >>>> +			ae4->ae4_irq[i] = 0;
> >>>> +	}
> >>>> +}
> >>>> +
> >>>> +static void ae4_deinit(struct ae4_device *ae4)
> >>>> +{
> >>>> +	ae4_free_irqs(ae4);
> >>>> +}
> >>>> +
> >>>> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>>> +{
> >>>> +	struct device *dev = &pdev->dev;
> >>>> +	struct ae4_device *ae4;
> >>>> +	struct pt_device *pt;
> >>>> +	int bar_mask;
> >>>> +	int ret = 0;
> >>>> +
> >>>> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> >>>> +	if (!ae4)
> >>>> +		return -ENOMEM;
> >>>> +
> >>>> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
> >>>> +	if (!ae4->ae4_msix)
> >>>> +		return -ENOMEM;
> >>>> +
> >>>> +	ret = pcim_enable_device(pdev);
> >>>> +	if (ret)
> >>>> +		goto ae4_error;
> >>>> +
> >>>> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
> >>>> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> >>>> +	if (ret)
> >>>> +		goto ae4_error;
> >>>> +
> >>>> +	pt = &ae4->pt;
> >>>> +	pt->dev = dev;
> >>>> +
> >>>> +	pt->io_regs = pcim_iomap_table(pdev)[0];
> >>>> +	if (!pt->io_regs) {
> >>>> +		ret = -ENOMEM;
> >>>> +		goto ae4_error;
> >>>> +	}
> >>>> +
> >>>> +	ret = ae4_get_irqs(ae4);
> >>>> +	if (ret)
> >>>> +		goto ae4_error;
> >>>> +
> >>>> +	pci_set_master(pdev);
> >>>> +
> >>>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> >>>> +	if (ret) {
> >>>> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >>>> +		if (ret)
> >>>> +			goto ae4_error;
> >>>> +	}
> >>> needn't failback to 32bit.  never return failure when bit >= 32.
> >>>
> >>> Detail see: 
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81
> >>>
> >>> if (support_48bit)
> >>> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48))
> >>> else
> >>> 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> >>>
> >>> you decide if support_48bit by hardware register or PID/DID
> >> Sure, I will add only this line dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)).
> >>
> >>>
> >>>> +
> >>>> +	dev_set_drvdata(dev, ae4);
> >>>> +
> >>>> +	ret = ae4_core_init(ae4);
> >>>> +	if (ret)
> >>>> +		goto ae4_error;
> >>>> +
> >>>> +	return 0;
> >>>> +
> >>>> +ae4_error:
> >>>> +	ae4_deinit(ae4);
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>> +static void ae4_pci_remove(struct pci_dev *pdev)
> >>>> +{
> >>>> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> >>>> +
> >>>> +	ae4_destroy_work(ae4);
> >>>> +	ae4_deinit(ae4);
> >>>> +}
> >>>> +
> >>>> +static const struct pci_device_id ae4_pci_table[] = {
> >>>> +	{ PCI_VDEVICE(AMD, 0x14C8), },
> >>>> +	{ PCI_VDEVICE(AMD, 0x14DC), },
> >>>> +	{ PCI_VDEVICE(AMD, 0x149B), },
> >>>> +	/* Last entry must be zero */
> >>>> +	{ 0, }
> >>>> +};
> >>>> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
> >>>> +
> >>>> +static struct pci_driver ae4_pci_driver = {
> >>>> +	.name = "ae4dma",
> >>>> +	.id_table = ae4_pci_table,
> >>>> +	.probe = ae4_pci_probe,
> >>>> +	.remove = ae4_pci_remove,
> >>>> +};
> >>>> +
> >>>> +module_pci_driver(ae4_pci_driver);
> >>>> +
> >>>> +MODULE_LICENSE("GPL");
> >>>> +MODULE_DESCRIPTION("AMD AE4DMA driver");
> >>>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> >>>> new file mode 100644
> >>>> index 000000000000..24b1253ad570
> >>>> --- /dev/null
> >>>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> >>>> @@ -0,0 +1,77 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +/*
> >>>> + * AMD AE4DMA driver
> >>>> + *
> >>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >>>> + * All Rights Reserved.
> >>>> + *
> >>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>>> + */
> >>>> +#ifndef __AE4DMA_H__
> >>>> +#define __AE4DMA_H__
> >>>> +
> >>>> +#include "../common/amd_dma.h"
> >>>> +
> >>>> +#define MAX_AE4_HW_QUEUES		16
> >>>> +
> >>>> +#define AE4_DESC_COMPLETED		0x3
> >>>> +
> >>>> +struct ae4_msix {
> >>>> +	int msix_count;
> >>>> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
> >>>> +};
> >>>> +
> >>>> +struct ae4_cmd_queue {
> >>>> +	struct ae4_device *ae4;
> >>>> +	struct pt_cmd_queue cmd_q;
> >>>> +	struct list_head cmd;
> >>>> +	/* protect command operations */
> >>>> +	struct mutex cmd_lock;
> >>>> +	struct delayed_work p_work;
> >>>> +	struct workqueue_struct *pws;
> >>>> +	struct completion cmp;
> >>>> +	wait_queue_head_t q_w;
> >>>> +	atomic64_t intr_cnt;
> >>>> +	atomic64_t done_cnt;
> >>>> +	atomic64_t q_cmd_count;
> >>>> +	atomic_t dridx;
> >>>> +	unsigned int id;
> >>>> +};
> >>>> +
> >>>> +union dwou {
> >>>> +	u32 dw0;
> >>>> +	struct dword0 {
> >>>> +	u8	byte0;
> >>>> +	u8	byte1;
> >>>> +	u16	timestamp;
> >>>> +	} dws;
> >>>> +};
> >>>> +
> >>>> +struct dword1 {
> >>>> +	u8	status;
> >>>> +	u8	err_code;
> >>>> +	u16	desc_id;
> >>>> +};
> >>>> +
> >>>> +struct ae4dma_desc {
> >>>> +	union dwou dwouv;
> >>>> +	struct dword1 dw1;
> >>>> +	u32 length;
> >>>> +	u32 rsvd;
> >>>> +	u32 src_hi;
> >>>> +	u32 src_lo;
> >>>> +	u32 dst_hi;
> >>>> +	u32 dst_lo;
> >>>> +};
> >>>> +
> >>>> +struct ae4_device {
> >>>> +	struct pt_device pt;
> >>>> +	struct ae4_msix *ae4_msix;
> >>>> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
> >>>> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
> >>>> +	unsigned int cmd_q_count;
> >>>> +};
> >>>> +
> >>>> +int ae4_core_init(struct ae4_device *ae4);
> >>>> +void ae4_destroy_work(struct ae4_device *ae4);
> >>>> +#endif
> >>>> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
> >>>> new file mode 100644
> >>>> index 000000000000..31c35b3bc94b
> >>>> --- /dev/null
> >>>> +++ b/drivers/dma/amd/common/amd_dma.h
> >>>> @@ -0,0 +1,26 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +/*
> >>>> + * AMD DMA Driver common
> >>>> + *
> >>>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >>>> + * All Rights Reserved.
> >>>> + *
> >>>> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >>>> + */
> >>>> +
> >>>> +#ifndef AMD_DMA_H
> >>>> +#define AMD_DMA_H
> >>>> +
> >>>> +#include <linux/device.h>
> >>>> +#include <linux/dmaengine.h>
> >>>> +#include <linux/pci.h>
> >>>> +#include <linux/spinlock.h>
> >>>> +#include <linux/mutex.h>
> >>>> +#include <linux/list.h>
> >>>> +#include <linux/wait.h>
> >>>> +#include <linux/dmapool.h>
> >>> order by alphabet
> >> Sure, I will change it accordingly.
> >>
> >> Thanks,
> >> --
> >> Basavaraj
> >>
> >>>> +
> >>>> +#include "../ptdma/ptdma.h"
> >>>> +#include "../../virt-dma.h"
> >>>> +
> >>>> +#endif
> >>>> -- 
> >>>> 2.25.1
> >>>>
> 

