Return-Path: <dmaengine+bounces-7518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304BCA8607
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7FC93027004
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A733C1AD;
	Fri,  5 Dec 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIfqVwwU"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1D82866;
	Fri,  5 Dec 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952112; cv=fail; b=uT1OuQnm/MPMemA7yIhf1YcTfNuRBTO8UYW2IiYB2E10vWIXdmDW1oQ0S1xtfAC56gGijwc6BAN1rhf1CgJPgCRoEF40sLcIGstKz/FRDKK2E9q98OC0ms8sAcVIWWmPz2M8OitYVlRK3w1qt24a5c4eBE8lqxmMlzDMoLu4pVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952112; c=relaxed/simple;
	bh=ldm1QZprrOefmAD4bNf63+6DKRQj/E4gIaWjMglX0cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YbFeHHC5xQkmsTzTDbngwI7oFRwzMUqrt9gEJQuwOSJu4E/aqpP33N89Qh7NREKpan9nNLuala+gZs7AaTkzmSRKuP1HbYNMGzqkqDXw5u2vCx/gn6tPkhw/OOWw8OB3uehgiEUC3nII8lm0BHPlmMoqEuJq60CgeW+zUN15e1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mIfqVwwU; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1NaNkRvRU3lV3l4sapBQHSJQFJOtLq0nOxO9OHz9+vxBNGEzbVFOLsspna2Kt2G49oQU+l54njJGxSVgQOJG8GYWBPeQxU1JophHfZ7sAj4ylvTqx/PQ2v1OjMy8KVc/0Ls+7RHJ/JmQVgTfRdZ5lIheWem5YI+bUbJXFO2agtbm2tk6sFXoU1XvaoImj7icqqLeP4O9NHqGjCP09l7S3j6RSSQvORGgQZUYrITr/fClXSncZexE7m4pPZFWEPLRQAOHyQxW55683MUHMEB1YAguNVgbeYPq4zuqhmzkh9uKYtVAEa1RiENHG+g60waABZTa9HeLsUEaJvNi7jnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldm1QZprrOefmAD4bNf63+6DKRQj/E4gIaWjMglX0cs=;
 b=rV9f8yOFd4n3M6Ax/F6Fry6/2SArr1i9ny8eKpGtsvdUk6TnVjn2fnH7mx8mb0GBWFVKAmSbBY5z5Gq2ALGFfJJwtPTrHIwg4HKmZSMH+aOz9fpOn2WbeJPmYi3MXElbC+sWom72LB4x93NPjUtTrvzlTwjKkXqDcASitZkuUnwrEwSB6Vlzg2MEHnSMUIddXMYuXYT2BUT1sdKAVffwCbrZbPsANG8fcj3GS1Xux+hLeyQhsfmLO/zUMBgUsirXYkd57LCh938blOZfFXvAzH/cSx7QoKHOD5UqP35Dp/vSN1XtQHi9jxXWTtPkrVufd0izFUtf+UrgWL4ACIFo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldm1QZprrOefmAD4bNf63+6DKRQj/E4gIaWjMglX0cs=;
 b=mIfqVwwUBcwSd5/bG82Ra7zxeFEjmkWMxL8fWfS4WHoDXGCkuZqLnjmQE10BeynCgtlqsSv3nrZXTZYcluxh3pyUu+EsAg2KDRKC/v0VI4qqNrvcj81uWgNmFpx2clCQigCWbCYV2Os4Osem7Ah0XoFQkTOf1KUeRX98LcGjsaZenTg02hjSYongEDkzwO/sxWA1QRbXAoS4PYAaFVp8otZjFrvECfCcbstAGP4yIIP4tDa+OUOWlDWosqbok9lYGDd/p27M9Rul9mtL729GWdz6mh3pmagAE7ZRKz4ENOF7w42H3YttYsksEMb2F5hvsTbuwqbo2IHLQ/jy5OT7OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 16:28:20 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 16:28:20 +0000
Date: Fri, 5 Dec 2025 11:28:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aTMIHLbQJX0Z873a@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
 <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>
 <aTATWZaiqwNfwymD@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTATWZaiqwNfwymD@ryzen>
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: f2296d3d-29f0-4a9b-28f9-08de341b4d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|19092799006|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SujGIY4Tij91GCDInQew0cx/NXOhIUjTZ/QQrBXO8ZwraOk2jvOr1b4A9cG/?=
 =?us-ascii?Q?ja4q7t8SWYHTvy7iOTrhgwxmLvP6GxpIke+H2qGAyPKirDwDdsrmtHIej4SN?=
 =?us-ascii?Q?T+ZFj76+esYE0f4wzohwRWcVwljnd+BXc56E0YFbsFocxCR2iE2tYXiQoG4F?=
 =?us-ascii?Q?aXB9FMCPG3ArfCMcYJg5DyX9i5d9oEDTvV7YCDya0E7tWD8rwIBbF7E5hMKP?=
 =?us-ascii?Q?DK5NW5+S+QfTCR+9UXw4NN05ysi62Ab3yeDRi45NcD+so0y9bhK05S/FTrGg?=
 =?us-ascii?Q?W8NETrU27Hp4QNgoNbeIH1S8Sek/E1Woz0GpzQxpRyeqQRAfJfrLGFD2vjQe?=
 =?us-ascii?Q?2EdEs264mx5+DzAcd2Co7tjpaQ/kUHHyH0fSbq1eOnST5o2b+a0DoBCpMrpm?=
 =?us-ascii?Q?XYjmY85emqQRIEJUCg7Ww03N7CROlI5Ag0RPWUuThcqGE5dPdRhHy6+u6fg7?=
 =?us-ascii?Q?dzwPSMGh8lOhrt1gdwH8M6lfQwswLEHPHvbvmy1FRP7KmEEInq4hwmQBZ/Nt?=
 =?us-ascii?Q?aarnYr46entl5K5bJMyJqHUFPb1ROUwuOhiBN/scZVIL3GYYTrCehrZ4CZ+z?=
 =?us-ascii?Q?vkDOYKUCKyRL3sDUFM6ADhIFe3VgSX1sk03AnWutG4gowj7Ag7DuYjTDexMt?=
 =?us-ascii?Q?W3oK6+nxo6e/QU43CtuStXqTiqRnvLTfFfjVDgaWOv1Z06nxI+YHSARpjUVs?=
 =?us-ascii?Q?VN0Rje+RyqOviZeTe2iZmWpwOrCLB3Pz4mEGX+MIb6FtDlsYSr145GG9A6M9?=
 =?us-ascii?Q?nG9dSAq++YH94goLL0PQ3RBG44QNas+oKp06T/5yLUW+sEW/uwNTiU8ybWgF?=
 =?us-ascii?Q?hz5JCsCmq0U8mUKqR+sJDlRNc4MKKAhXCvLj8AWWj+P8UZCIgm/POTL/DkXo?=
 =?us-ascii?Q?1Rzg09JYlaDWP5HvuasyfRLL2aLVXRGpa4BvgcgkyMmm/ws/EwV/vmxN2B1B?=
 =?us-ascii?Q?wuZ0XM07Az28SgmL9iHQ7XW57sW4TPtoVG7MF4BOGKrIiY9w4pfUlc6H6D6M?=
 =?us-ascii?Q?gjheDSTmOkjYgTOZBy7vlz6fdc54SLpwp5hY/qrpCnr/x6jpoc1JiLMuJWa/?=
 =?us-ascii?Q?ClmLri49MbkC0RN6SN7cEDmqzEOiBd8IPd6RLBsieV0ErMZwlwBcERZ5MqTa?=
 =?us-ascii?Q?Fr5tnf++/HAbPDPR6XGVJ1EUClAKW3DCouihBJ1BHBA+B0KmZC9guD4RNGiB?=
 =?us-ascii?Q?PHeK99CjDzHhmmXwyBINUuzvSOa5GWty+QeoRnj+I2WZouy6Q+zbkDcyoT03?=
 =?us-ascii?Q?vBXZpCHX39T6+vyjWFS/1BswbqFKOjzp/FBstHw5vsotzh163JsjGxD7V29z?=
 =?us-ascii?Q?CgRehj7K7PMVSj80utFv3ZYfu/Ho4iEvmMgHlAb5svgXKTIXajtuz0aPsJGq?=
 =?us-ascii?Q?hLM813+PBfa5kMy1jVpIPN3EE8TSgUSviLiQ822o70DfLvrNtWBGUELZYJR6?=
 =?us-ascii?Q?xEY8W5KCYoOFQ0nW8pBESMmpuOX+bQkFB9BNt5Ns/eLYauJ9Qicypg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(19092799006)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?em5YXvzUrpJ4N3ym/yxJfLdFZuNbN6K/uQg7Cy1pjzseo1KFaz5kH9YKJakd?=
 =?us-ascii?Q?mVhO02lLym/76yiwEQSK5QQq3YS8FgtV4U6YHV7gHyPNAnvRO7X/Hs82rfPx?=
 =?us-ascii?Q?fxusCDXv2kvxl5WWfjT8l52TKOLCa9mz0wp82x6HPujhoSkeXceNlEkpyG13?=
 =?us-ascii?Q?CZgA8nIcH/M2GUValuuvwvPCG3R6h8CVKSLSyBYxmvIqbPgr1Rsrp91jxLqb?=
 =?us-ascii?Q?QzU/aGNG41837ItftfKMpLxB/Vucah6+bcL6fhpyvv2Z+po9zbozdSfbBLYD?=
 =?us-ascii?Q?nJ+kwOcy4iekmMGRZPc5syeqC6AAKadvU7Mza0qoaz0ogCHQ7vLOT/CalLeV?=
 =?us-ascii?Q?rwlLkbHb8yMGfl9lcxqBA+0Ff3sbhFYc5MGQMWvgfMZzXBoEUCpuufQ9xdqR?=
 =?us-ascii?Q?U1E/ilETKv1CDGW1L059C00n/JQMYpiFWhMPEnb6ifGvCZRgHY0YNi1ZHLO5?=
 =?us-ascii?Q?vMH3HBoXPudG9qO1kFOdpJbE6jsmlcXh5EB4EeCGRiLzIi4lZTx1CySPsBSK?=
 =?us-ascii?Q?QbWQXbphsiWJ0cWL+0J2F79R+gpICw8YN2/su4jbS6tqMNWxQnaot7zDqBJd?=
 =?us-ascii?Q?gRUA0Bn6DONU8tcGLn/i4sugkQN4JxNkMrdRLpVaut5fw+Q/Zd+n7CE6a24j?=
 =?us-ascii?Q?BgQ7GgDnNAx99sihQXBTkuIgu6E274kwY1VfrFQNWrd3gqBOrPq9Egc52iTs?=
 =?us-ascii?Q?Et6WJuCvdQtjleMqwlT02Kf5SdoXjUG3bxiorXvGEoi8wEAgtcziJVOdt0+J?=
 =?us-ascii?Q?PdkFIa3aBECeH8ajvHide6ykQY55x3aogBObteP6KU3X3OTD6gmzcGjP/5iq?=
 =?us-ascii?Q?/H51RJxudDVqskQIQLy1bSlZ3ZOrsxDfSkl7DLol8F2yFguwqfQ5mtFqE+NZ?=
 =?us-ascii?Q?VpFHD3l5aqZqACQAIWq9zYCSN7paVOuPTlTB/Takfx8/l4G1K7A7oofL2EaY?=
 =?us-ascii?Q?UPl2jA9eabAhYkytjNu5kVBE53ht2DUWl0JY0wOHeMPrMcQ8F5qVR+V8O5lg?=
 =?us-ascii?Q?Z3xyLVMIR0Y9fXFoe04VgR0kXoVR6sbgZ+eJL7zKVzXTZZXDfaOOnzKg60up?=
 =?us-ascii?Q?CzOkIMCTNTE+LWtjlI9UvL68AK/kYUhApD3R57Oj3416pWzyxeLBdLgO9E9F?=
 =?us-ascii?Q?zHBLzz/xDM8KViYpLYyB7T2pBMPJ2Ry/LfTabf/9zuQcPEhsoucfRs2YTgfn?=
 =?us-ascii?Q?IutNMJ3SgO8DDN9RuM+vzR31zeQuLe6DDI+q1mdj+SdoXU6XbDOFuGscdJfu?=
 =?us-ascii?Q?APMbnXioODxhwKMwqAZAiPZzFw+4I4TsOYN7MAyION7zk8iaZ3xJ4IPupIWe?=
 =?us-ascii?Q?LZDIqNA+I8jz7k3bLxgCukBbzHhMLqYqx4BEFSooO5hupzN/1nR/N/ijas7F?=
 =?us-ascii?Q?HiARX2Tobuywy2JvPbTGbEcGuZ9MunQOvdzW06hAljl9czVGDD0+52L6iOhw?=
 =?us-ascii?Q?5IoBnuKGLtqkql5GG4rQ6goy+E663Ig9YaDmZxHDPI5RYcf6LXwPsvYqiUPq?=
 =?us-ascii?Q?pwHLb/j5sgF6R0iz1BbR4Fzk7Gh4MaQOHUrB6XQUpEQqgcCOMz8a6CMg2f6r?=
 =?us-ascii?Q?ngO4Sd3HVFvSjefa4K6QveH/3UXNJLEu+3B0KJTk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2296d3d-29f0-4a9b-28f9-08de341b4d86
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:28:20.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooCxMYMGDEayWTugy+S+xbW3P7Wj8P41rSLpZfM2B3VffUduQet3EQjjHSsCxIvTokYr1UfQ4pYIorWsxJHJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231

On Wed, Dec 03, 2025 at 11:39:21AM +0100, Niklas Cassel wrote:
> On Wed, Dec 03, 2025 at 05:40:45PM +0900, Koichiro Den wrote:
> > >
> > > If we want to improve the dw-edma driver, so that an EPF driver can have
> > > multiple outstanding transfers, I think the best way forward would be to create
> > > a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> > > does not require dmaengine_slave_config() to be called before every
> > > _prep_slave_memcpy() call.
> >
> > Would dmaengine_prep_slave_single_config(), which Frank tolds us in this
> > thread, be sufficient?
>
> I think that Frank is suggesting a new dmaengine API,
> dmaengine_prep_slave_single_config(), which is like
> dmaengine_prep_slave_single(), but also takes a struct dma_slave_config *
> as a parameter.
>
>
> I really like the idea.
> I think it would allow us to remove the mutex in nvmet_pci_epf_dma_transfer():
> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429

I check code drivers/dma/dw-edma/dw-edma-core.c

does device_prep_interleaved_dma() work? which have not use config.

Frank

>
> Frank you wrote: "Thanks, we also consider ..."
> Does that mean that you have any plans to work on this?
> I would definitely be interested.
>
>
> Kind regards,
> Niklas

