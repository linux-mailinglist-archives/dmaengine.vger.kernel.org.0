Return-Path: <dmaengine+bounces-8375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ABDD3AF7B
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2B63074E75
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D84265606;
	Mon, 19 Jan 2026 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMkt14SW"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9021FF2A;
	Mon, 19 Jan 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837545; cv=fail; b=shm0TdoDa7RMTzJLwkE6pISxm+ev43W4x7Mm0YVFUZaf4eAprmlSdsF+my9EwmBAUgBZbeXnivhJNEjRgtzwP0e7Ui4hVD9z5bmUTVpxCBn4wGQw8VeRphFoIdG+/dyFdo9WQW9D6YImovNM09q/34wT6u5XyLDD3jdle2m8oeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837545; c=relaxed/simple;
	bh=En4AnQeTvHUUr6lIuialZpsWl8F8eKYwod2ZasNtXGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LV1kiKWRpvWGvHgxiEALklayXjmUNhJDywhj2FC1aaxhfmc74DnARY80+EiCwYmNHqWwtzSQkujV0JtDJXvFNG83YylaxcS87vp+DsqhRL2Yytf9AM7mqslFapOkwByx2LmM8kkfvW3DXwtJL0He78ringTf0+//iTcuNSA0cnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TMkt14SW; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp3ooMBzK7OZe8bDXydXqr/Rvynhu0hxcDxtG+ToO4ltSB9JGjZnL2Axb8TCphHvTJ68nSKPEr7vOj7srzmV4d4v789OX5miNyH71txCdPCkEHH5IIMPH3PmEUY8GM0pnKG/zl5lsQdztbPfkw8Az4tUMUNlUjRWsV4/kLCqQLi+I38cWn9K9JtOktCwdS1e4xQNKyZrZ3aZZCcD8wfA7B3z1RmLPGndxgqllcECYQXGJiZulZtTyVbckTPGW/022e81VdMbZJOPmC+ZszNL1W8KIMx2NdhdrpJZm3V9fJnTyNsy+ArcLMfibNAikcsuLVzFL4m9MWa8lKpRgBvFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrvtCSWj7mshCojIVlEBvQphOtRKjg6tFSoFV0aPm18=;
 b=L0t88WdDUEqL75ZDlDkNSVxK1gnWYFMs7atyP2a0CMwb7SbrELrDONXvpoL/vcHaTSkDjb64WC3RPro8IAQ58lftlh/Ns8V12fLNsfEIL5fHsZOPXMixe/zJSntMRB7Pzo/PGi11EsUf2i6XWI7CmSCsP9wUZN/ZsduKSZHhF1K2oewHScfGFWBb+Dw0fD/VzueIqdsBhR40EW6kcnLksWT063BcR+zOILUWbNd71tjs2jOj4sXT233HN2FsPm5TUo+KuwVJI/SrHV36YFzh1wNXMlxD/RVzs3ucFJmXzNFUc/mo4kDWezyDhcqpN6U1ylwiXxmfTHiUAz6lzPQJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrvtCSWj7mshCojIVlEBvQphOtRKjg6tFSoFV0aPm18=;
 b=TMkt14SWe7l7uOYLcM/kxMWh/eDStM9ITotcdGYnccPHmqyYO8s3yDf9tYpzdlkj7xNKHf0tcyDhhXdOgPm5ZjWz2dMvgf0wRqw/cTcx3m7E4oD8jnsId23U+Mds/bbfozm4Pb3IzDw7XXLBNX7gJiPl4xHO2inLbwu1zVOBv2hEe177jP0/B734MgFoSdLEGKpFy5EDQ5hsj+l1bWcOGEzePA2NS5N/rkJnZhlL5+TYAsye1zpI/vtKnFMHmbU9B9KPT42sNzs+ehSvTBPGx4D1cLaZmyqN2/rTClAqMUO0Cj2TooTXmSG3j7KP8KiSNPrFKzcXOhOdSQX25732+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by DU4PR04MB10622.eurprd04.prod.outlook.com (2603:10a6:10:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:45:37 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 15:45:37 +0000
Date: Mon, 19 Jan 2026 10:45:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0175.namprd05.prod.outlook.com
 (2603:10b6:a03:339::30) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|DU4PR04MB10622:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6d35c4-44d1-4ef5-9804-08de5771ca2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6+3NJgeY88CBgEMCOnZYgSIZMyv6f0TezgfXscLSGqyGYIN2GertJtrGwElU?=
 =?us-ascii?Q?z55tPLMeMZYN9L2hXZnBJsnNW5/9fUBbg1AVjp7kL0ggVDRMHMkwNDMeJGmv?=
 =?us-ascii?Q?ngXv577yiA+OtkTZbU6/8mledVS9CkP6MtpRj9LHynj8HwTtw3JyGvNSDr+0?=
 =?us-ascii?Q?panLOiAhDPS4wEEuHT3yNbV6tEaQlJJVuqDT5zFeA8s1TfIG1XPoVCgksVt9?=
 =?us-ascii?Q?mwUfbY6tjcvBglPXfFa3t/1xeWQ56JP1P+kqZzAJBBvkO1bK+6C92D1buqmg?=
 =?us-ascii?Q?xM3uNR33TT6kO3U4nn/gK+OCPcVws5DWobqkPFngaqiQbEPW1/DxMIpHpTsm?=
 =?us-ascii?Q?RFvRqs6DAVfD52noK2ClkaPWmlfw5xtFliPNFmWExU3RL6TGx0dzlCCvelvR?=
 =?us-ascii?Q?QbYLew9Ib81+F7Mdja5qiUbU/6WYe1Z7vMY0y1kiE9ERhlLyM9xcpNQ00yf0?=
 =?us-ascii?Q?nOCFhKnQfcznK8X49BQMx4K/rfdrM37pSZq/tS+pUObHqCI1V1+eKpwmlk6W?=
 =?us-ascii?Q?tdYP4INDBISZQhBoQH/ozy4V6y4I0EtEH9mNKzbbG9MToXh+8nTaQyNoANji?=
 =?us-ascii?Q?8AgllGfRt9WqEZgQrIj86seqkw8PCrIl5iYOi4F2Jp+Te0COP6sH0fBWR0vx?=
 =?us-ascii?Q?LdzmHFl7CNw1kJ1lmo74imH9OtEDXFdysgJVNb5QSJGfSOo8RXvKb/nkOg58?=
 =?us-ascii?Q?e6SbrDQIdUWuPOa3MXEwvVkwjQ1K6rg2go/ISYYC3+x+bpBGXUe430U8iWLi?=
 =?us-ascii?Q?MWX9zMIPv4afuRQbze1skVcrwwnKRkZ7pi17mdzJziE+4PlJneY/oYhL9YTX?=
 =?us-ascii?Q?gTjt9dOmK57q3a9JVUKFnEBbUm0SCfJ8fZiigv4uyASZoKGF4ulAa88kthKq?=
 =?us-ascii?Q?kkT0CZCRVytW08rMlAEhOCGF0QpzfBP29cijc4D9ZawS7GX5XZA+pekbIj1J?=
 =?us-ascii?Q?NhbuaZHhDtbVG3pc/pVU/kDqd+IDbjWaZpPcY0h0kZxBppAmwF5IxVOyiSZ0?=
 =?us-ascii?Q?F4nEgEMOM4GVX2+j4hSGifroQhHwSZzfCrogv5RZO/RNuZb7JIEBKarhCJ9T?=
 =?us-ascii?Q?Sr0qZ6yGYeEnW+VJtAYW4iNi8fPpMA/6khRINXSAUiGqmesyVmSx7+48CKVU?=
 =?us-ascii?Q?s731qyJy9vOS2eCF0TonpYYZIyPT5SlkwDCvdg6kHDwETJtALixzJbQmqGGd?=
 =?us-ascii?Q?PLoyCS33FX+Fd8K0Ms3CIZJTDm+l7TJ6HzCuiP/rWFvUDpzslO4Q6fUoQAd9?=
 =?us-ascii?Q?Fvak+eVtGqRb+y8Grig4EyiHeN73ZzAYC4r/Q+7oOdNWoo295m5QuyxNBx6z?=
 =?us-ascii?Q?67eeOvXWgIMv8IEPn8KZIFzn7hlLAcEpojeQp0SCuy8qKv/6QSQ+V7vfo/zJ?=
 =?us-ascii?Q?E+89zxCPBUS37dEcZQfc6RkmvatDQXcsG4oldY3ZfblGaAkjdrcVgkjaRMQn?=
 =?us-ascii?Q?AHDUSeR4kUFi7v1Ds+uCcqAauU1g6DtdECopJafKpBdDRDZDmt1uVUv9lFph?=
 =?us-ascii?Q?qojAKBX63iKuP2ko/NbBH6JVvrroMWJIjCwokyzQxpF0sjtqx3s8dQ/WSQ5n?=
 =?us-ascii?Q?zrFgxRxpIvLaSW/QNTMwtBiIusECQSLqoOn6sfI+M+mMCPNfkTvErW9IdQN9?=
 =?us-ascii?Q?79Q086JkbKB04DJzvSkdQsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y33XRn6CKQ2RUkHJS7Er1VQ+DiIHxm7uD4R6mUfBb2aCbRzAanawMuuYrhg5?=
 =?us-ascii?Q?ltfM5fKVMYWBlzRr5Ph1Tg6Ctmwc2fdTaqVXYVJQmJjtAaT9/a3fUfOCw6xM?=
 =?us-ascii?Q?zXe9mxCYK5abNd2LJ9x3Fuhrj18Q6OwwakqmwFdZwVWQ28yk2/HNmxj2JTdN?=
 =?us-ascii?Q?wDASPhGnjCaVokbHN5R9+7UAhKVwFr11p+U5LOc/rLMCsDBV1Mj1iCeYq0wk?=
 =?us-ascii?Q?QSC/ZrzHof2VIIxOLg1RcczBhMipYsofZvsUuUnBIF5+nAAcnz+/Yol5Fi5T?=
 =?us-ascii?Q?lsxL+9qocCI0qBDMFlHVEuY5Dno2cWjj8eMUt3v9L8vB/DFUBAGctbwk66In?=
 =?us-ascii?Q?PG61KPsL8yxuGUSrMcihrGWnk7WTEjn7g02MhZyZHbDGMvtd8rlewrHMe8HQ?=
 =?us-ascii?Q?roeUyx+Q0fcxT14+/nvzKQe6xYf30OhCVp0GdPvedvhgHm+WtatyR4xOAFsy?=
 =?us-ascii?Q?zwgk9LmGmv3VQaNeIbr9UxJJCLBDuIZplgKcBer/dAlJwxmtdF1iqUe7QjaH?=
 =?us-ascii?Q?mSQKWvJegBZ88cmblk3YXSGpDTwwO2qt/SpALrGwMRohcDkOSHZ6v9fST6X0?=
 =?us-ascii?Q?hOQnosAAsc9Z8MuZpnXDvEXy3KH79sCFrd1AUYM2RC7hNM6TaTbR2TQ6MjDG?=
 =?us-ascii?Q?gVgXFeEQqH77/z9nUseh2iDmR+BKNpGgz1Qx7We6AZvahRte97HdJU6DfrVT?=
 =?us-ascii?Q?zKX0LhlBEKefCFuIEAbBvTxWzg7N4Za/1tR8zKTajP4qbk+LssQijakyG2zV?=
 =?us-ascii?Q?e1SUzjs/olza6mr7WI79CWQ87tFo2Trtd6cKn36hDH6/uLQwiFD2qlT3iCzR?=
 =?us-ascii?Q?B1MC0sfbBV7dajkfFcYmro/izNgC2iiQVe+2y1fuJf8N3brQERMeCpzMj6iO?=
 =?us-ascii?Q?sfPjuMwkSjXhB4q9j8JWrWxFDDXsZgk/uIrPpcTGL++lUuAlQTF+VE08NfaL?=
 =?us-ascii?Q?qft8NMUW3Zt3yNMvNJZDAiwzw0RV9ql0izfSQuWY+Eg3ekxgGRjXjV6+TMbV?=
 =?us-ascii?Q?zCs73UaXEQHOf9fqMhBVcx66K9y5hzzwhpjGvHVa8PECcqVBG2HZ4nV0/T0V?=
 =?us-ascii?Q?n1/IA24NIaATBa7OjdwdT1igBZSbAmU8yWfvG6HcyHrIIATtOw2Qow1jwCA6?=
 =?us-ascii?Q?ZBBbkM5AWdUO0piwwuWo60FxAIguq/VDkXT2Nw7/WqNdV8pD9U1MfSnV0jhC?=
 =?us-ascii?Q?dpQoUUEChWD2wDp0HjLl9M9hSBi2R2Lf3HWX0Pg13sYudRo0/OmlARaiYOmI?=
 =?us-ascii?Q?QLu+8QJ2sxKITi/hlAeyi8HRh8cjim11U94ou8S3+QpnrOLe/m9TflgBFpA6?=
 =?us-ascii?Q?8bI3SKi9eoYkZMN/zto+jdtBJCTxKPAiCy0rGeedymBy3nBiKTmcO+WZAfv+?=
 =?us-ascii?Q?oWLwJJjC3HAO6mpbvIGMjCOwNnL+kJOQ0SznLfG13ShmSgp/N16v5OKm9dyy?=
 =?us-ascii?Q?c0aNpRGCs4Ie6f+PBJJbwsAUPJWKi3Np09RPv0YY1jGhqepv1X08vLoPYfA5?=
 =?us-ascii?Q?IRFl+Y+/ii8nQXa5namGpShpFmVypm8RtYP//VgBjttYVCij5X79r5mHtiDR?=
 =?us-ascii?Q?ZOK1zxyLSYAPgQ6rYnM+61XTswepYe8TatjBPIUdfSWzBEqWqxBQxoCoPZFo?=
 =?us-ascii?Q?/HtB1aNvQtA+PPkIxhrqgf9TuNvCcWNqqCMEY2c0nC+x1Xh0w2onpZnODTWv?=
 =?us-ascii?Q?tMxOWNSLcWe0+3NvJEsw/bAnub0jDQH8YZcCa+y48efLO4XCx9bfK3hi+35s?=
 =?us-ascii?Q?EpTsfFcfaA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6d35c4-44d1-4ef5-9804-08de5771ca2d
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:45:37.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dyqY+UDamyEywmVlpmcCQvSUk2AnqQ6CYFXrt+KWQg2CjDMhVRu5wJhDyRTzpErx3gzKP5TlmcX/7P9icxIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10622

On Mon, Jan 19, 2026 at 09:09:17AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Frank
>
> Please check my response inline.
>
> Regards,
> Devendra
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Thursday, January 15, 2026 10:07 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > The current code does not have the mechanisms to enable the DMA
> > > transactions using the non-LL mode. The following two cases are added
> > > with this patch:
> > > - For the AMD (Xilinx) only, when a valid physical base address of
> > >   the device side DDR is not configured, then the IP can still be
> > >   used in non-LL mode. For all the channels DMA transactions will
> >
> > If DDR have not configured, where DATA send to in device side by non-LL
> > mode.
> >
>
> The DDR base address in the VSEC capability is used for driving the DMA
> transfers when used in the LL mode. The DDR is configured and present
> all the time but the DMA PCIe driver uses this DDR base address (physical address)
> to configure the LLP address.
>
> In the scenario, where this DDR base address in VSEC capability is not
> configured then the current controller cannot be used as the default mode
> supported is LL mode only. In order to make the controller usable non-LL mode
> is being added which just needs SAR, DAR, XFERLEN and control register to initiate the
> transfer. So, the DDR is always present, but the DMA PCIe driver need to know
> the DDR base physical address to make the transfer. This is useful in scenarios
> where the memory allocated for LL can be used for DMA transactions as well.

Do you means use DMA transfer LL's context?

>
> > >   be using the non-LL mode only. This, the default non-LL mode,
> > >   is not applicable for Synopsys IP with the current code addition.
> > >
> > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > >   and if user wants to use non-LL mode then user can do so via
> > >   configuring the peripheral_config param of dma_slave_config.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v8
> > >   Cosmetic change related to comment and code.
> > >
> > > Changes in v7
> > >   No change
> > >
> > > Changes in v6
> > >   Gave definition to bits used for channel configuration.
> > >   Removed the comment related to doorbell.
> > >
> > > Changes in v5
> > >   Variable name 'nollp' changed to 'non_ll'.
> > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > >   Comments follow the 80-column guideline.
> > >
> > > Changes in v4
> > >   No change
> > >
> > > Changes in v3
> > >   No change
> > >
> > > Changes in v2
> > >   Reverted the function return type to u64 for
> > >   dw_edma_get_phys_addr().
> > >
> > > Changes in v1
> > >   Changed the function return type for dw_edma_get_phys_addr().
> > >   Corrected the typo raised in review.
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 42 +++++++++++++++++++++---
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46 ++++++++++++++++++--------
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > ++++++++++++++++++++++++++++++++++-
> > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> >
> > edma-v0-core.c have not update, if don't support, at least need return failure
> > at dw_edma_device_config() when backend is eDMA.
> >
> > >  include/linux/dma/edma.h              |  1 +
> > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > index b43255f..d37112b 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct
> > dma_chan *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +     int non_ll = 0;
> > > +
> > > +     if (config->peripheral_config &&
> > > +         config->peripheral_size != sizeof(int)) {
> > > +             dev_err(dchan->device->dev,
> > > +                     "config param peripheral size mismatch\n");
> > > +             return -EINVAL;
> > > +     }
> > >
> > >       memcpy(&chan->config, config, sizeof(*config));
> > > +
> > > +     /*
> > > +      * When there is no valid LLP base address available then the default
> > > +      * DMA ops will use the non-LL mode.
> > > +      *
> > > +      * Cases where LL mode is enabled and client wants to use the non-LL
> > > +      * mode then also client can do so via providing the peripheral_config
> > > +      * param.
> > > +      */
> > > +     if (config->peripheral_config)
> > > +             non_ll = *(int *)config->peripheral_config;
> > > +
> > > +     chan->non_ll = false;
> > > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> > > +             chan->non_ll = true;
> > > +
> > >       chan->configured = true;
> > >
> > >       return 0;
> > > @@ -353,7 +377,7 @@ static void dw_edma_device_issue_pending(struct
> > dma_chan *dchan)
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
> > >       enum dma_transfer_direction dir = xfer->direction;
> > >       struct scatterlist *sg = NULL;
> > > -     struct dw_edma_chunk *chunk;
> > > +     struct dw_edma_chunk *chunk = NULL;
> > >       struct dw_edma_burst *burst;
> > >       struct dw_edma_desc *desc;
> > >       u64 src_addr, dst_addr;
> > > @@ -419,9 +443,11 @@ static void dw_edma_device_issue_pending(struct
> > dma_chan *dchan)
> > >       if (unlikely(!desc))
> > >               goto err_alloc;
> > >
> > > -     chunk = dw_edma_alloc_chunk(desc);
> > > -     if (unlikely(!chunk))
> > > -             goto err_alloc;
> > > +     if (!chan->non_ll) {
> > > +             chunk = dw_edma_alloc_chunk(desc);
> > > +             if (unlikely(!chunk))
> > > +                     goto err_alloc;
> > > +     }
> >
> > non_ll is the same as ll_max = 1. (or 2, there are link back entry).
> >
> > If you set ll_max = 1, needn't change this code.
> >
>
> The ll_max is defined for the session till the driver is loaded in the kernel.
> This code also enables the non-LL mode dynamically upon input from the
> DMA client. In this scenario, touching ll_max would not be a good idea
> as the ll_max controls the LL entries for all the DMA channels not just for
> a single DMA transaction.

You can use new variable, such as ll_avail.

>
> > >
> > >       if (xfer->type == EDMA_XFER_INTERLEAVED) {
> > >               src_addr = xfer->xfer.il->src_start; @@ -450,7 +476,13
> > > @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
> > >               if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
> > >                       break;
> > >
> > > -             if (chunk->bursts_alloc == chan->ll_max) {
> > > +             /*
> > > +              * For non-LL mode, only a single burst can be handled
> > > +              * in a single chunk unlike LL mode where multiple bursts
> > > +              * can be configured in a single chunk.
> > > +              */
> > > +             if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
> > > +                 chan->non_ll) {
> > >                       chunk = dw_edma_alloc_chunk(desc);
> > >                       if (unlikely(!chunk))
> > >                               goto err_alloc; diff --git
> > > a/drivers/dma/dw-edma/dw-edma-core.h
> > > b/drivers/dma/dw-edma/dw-edma-core.h
> > > index 71894b9..c8e3d19 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > @@ -86,6 +86,7 @@ struct dw_edma_chan {
> > >       u8                              configured;
> > >
> > >       struct dma_slave_config         config;
> > > +     bool                            non_ll;
> > >  };
> > >
> > >  struct dw_edma_irq {
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 2efd149..277ca50 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -298,6 +298,15 @@ static void
> > dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >       pdata->devmem_phys_off = off;
> > >  }
> > >
> > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > +                              struct dw_edma_pcie_data *pdata,
> > > +                              enum pci_barno bar) {
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> > > +             return pdata->devmem_phys_off;
> > > +     return pci_bus_address(pdev, bar); }
> > > +
> > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >                             const struct pci_device_id *pid)  { @@
> > > -307,6 +316,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >       struct dw_edma_chip *chip;
> > >       int err, nr_irqs;
> > >       int i, mask;
> > > +     bool non_ll = false;
> > >
> > >       vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> > >       if (!vsec_data)
> > > @@ -331,21 +341,24 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >       if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> > >               /*
> > >                * There is no valid address found for the LL memory
> > > -              * space on the device side.
> > > +              * space on the device side. In the absence of LL base
> > > +              * address use the non-LL mode or simple mode supported by
> > > +              * the HDMA IP.
> > >                */
> > > -             if (vsec_data->devmem_phys_off ==
> > DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > -                     return -ENOMEM;
> > > +             if (vsec_data->devmem_phys_off ==
> > DW_PCIE_AMD_MDB_INVALID_ADDR)
> > > +                     non_ll = true;
> > >
> > >               /*
> > >                * Configure the channel LL and data blocks if number of
> > >                * channels enabled in VSEC capability are more than the
> > >                * channels configured in xilinx_mdb_data.
> > >                */
> > > -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > -                                            DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > -                                            DW_PCIE_XILINX_MDB_LL_SIZE,
> > > -                                            DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > -                                            DW_PCIE_XILINX_MDB_DT_SIZE);
> > > +             if (!non_ll)
> > > +                     dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > +                                                    DW_PCIE_XILINX_LL_OFF_GAP,
> > > +                                                    DW_PCIE_XILINX_LL_SIZE,
> > > +                                                    DW_PCIE_XILINX_DT_OFF_GAP,
> > > +
> > > + DW_PCIE_XILINX_DT_SIZE);
> > >       }
> > >
> > >       /* Mapping PCI BAR regions */
> > > @@ -393,6 +406,7 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >       chip->mf = vsec_data->mf;
> > >       chip->nr_irqs = nr_irqs;
> > >       chip->ops = &dw_edma_pcie_plat_ops;
> > > +     chip->non_ll = non_ll;
> > >
> > >       chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> > >       chip->ll_rd_cnt = vsec_data->rd_ch_cnt; @@ -401,7 +415,7 @@
> > > static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >       if (!chip->reg_base)
> > >               return -ENOMEM;
> > >
> > > -     for (i = 0; i < chip->ll_wr_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> > >               struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > >               struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> > >               struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> > > @@ -412,7 +426,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               ll_region->vaddr.io += ll_block->off;
> > > -             ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> > > +             ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      ll_block->bar);
> >
> > This change need do prepare patch, which only change pci_bus_address() to
> > dw_edma_get_phys_addr().
> >
>
> This is not clear.

why not. only trivial add helper patch, which help reviewer

>
> > >               ll_region->paddr += ll_block->off;
> > >               ll_region->sz = ll_block->sz;
> > >
> > > @@ -421,12 +436,13 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               dt_region->vaddr.io += dt_block->off;
> > > -             dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> > > +             dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      dt_block->bar);
> > >               dt_region->paddr += dt_block->off;
> > >               dt_region->sz = dt_block->sz;
> > >       }
> > >
> > > -     for (i = 0; i < chip->ll_rd_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> > >               struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> > >               struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> > >               struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> > > @@ -437,7 +453,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               ll_region->vaddr.io += ll_block->off;
> > > -             ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> > > +             ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      ll_block->bar);
> > >               ll_region->paddr += ll_block->off;
> > >               ll_region->sz = ll_block->sz;
> > >
> > > @@ -446,7 +463,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               dt_region->vaddr.io += dt_block->off;
> > > -             dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> > > +             dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      dt_block->bar);
> > >               dt_region->paddr += dt_block->off;
> > >               dt_region->sz = dt_block->sz;
> > >       }
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index e3f8db4..a5d12bc 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> > dw_edma_chunk *chunk)
> > >               readl(chunk->ll_region.vaddr.io);  }
> > >
> > > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > > first)
> > > +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk,
> > > +bool first)
> > >  {
> > >       struct dw_edma_chan *chan = chunk->chan;
> > >       struct dw_edma *dw = chan->dw;
> > > @@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct
> > dw_edma_chunk *chunk, bool first)
> > >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > HDMA_V0_DOORBELL_START);  }
> > >
> > > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> > *chunk)
> > > +{
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > > +     struct dw_edma *dw = chan->dw;
> > > +     struct dw_edma_burst *child;
> > > +     u32 val;
> > > +
> > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> >
> > why need iterated list, it doesn't support ll. Need wait for irq to start next one.
> >
> > Frank
>
> Yes, this is true. The format is kept similar to LL mode.

Just fill one. list_for_each_entry() cause confuse.

Frank
>
> >
> > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > + HDMA_V0_CH_EN);
> > > +
> > > +             /* Source address */
> > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > +                       lower_32_bits(child->sar));
> > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > +                       upper_32_bits(child->sar));
> > > +
> > > +             /* Destination address */
> > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > +                       lower_32_bits(child->dar));
> > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > +                       upper_32_bits(child->dar));
> > > +
> > > +             /* Transfer size */
> > > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > > + child->sz);
> > > +
> > > +             /* Interrupt setup */
> > > +             val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > +                             HDMA_V0_STOP_INT_MASK |
> > > +                             HDMA_V0_ABORT_INT_MASK |
> > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > +
> > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > +                     val |= HDMA_V0_REMOTE_STOP_INT_EN |
> > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > +             }
> > > +
> > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > > +
> > > +             /* Channel control setup */
> > > +             val = GET_CH_32(dw, chan->dir, chan->id, control1);
> > > +             val &= ~HDMA_V0_LINKLIST_EN;
> > > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > > +
> > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > +                       HDMA_V0_DOORBELL_START);
> > > +     }
> > > +}
> > > +
> > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > > +first) {
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > > +
> > > +     if (chan->non_ll)
> > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > +     else
> > > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > > +
> > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> > >       struct dw_edma *dw = chan->dw;
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > index eab5fd7..7759ba9 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/dmaengine.h>
> > >
> > >  #define HDMA_V0_MAX_NR_CH                    8
> > > +#define HDMA_V0_CH_EN                                BIT(0)
> > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > > 3080747..78ce31b 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > >       enum dw_edma_map_format mf;
> > >
> > >       struct dw_edma          *dw;
> > > +     bool                    non_ll;
> > >  };
> > >
> > >  /* Export to the platform drivers */
> > > --
> > > 1.8.3.1
> > >

