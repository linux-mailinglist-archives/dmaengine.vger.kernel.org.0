Return-Path: <dmaengine+bounces-5274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26176AC6D36
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F14AA230EE
	for <lists+dmaengine@lfdr.de>; Wed, 28 May 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9128B7C1;
	Wed, 28 May 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="InY11afn"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6A1E8323;
	Wed, 28 May 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447455; cv=fail; b=sLwbRLgR71RaSQFQZDLSwro1ds3gXVEDGNjZSSqVfWbHQ1YAd41+ik1se6vh/uVfXejDyRyBC8qAnn/+jNohZtkAU01/RJ9PAYWrIMwfL1jOi4DBPTrNZ6SGVzI3cnlhL4To2sPN97J2u6sXmcVXsmQ/mFn69REfmj4LYnnJkOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447455; c=relaxed/simple;
	bh=7ml1oZdkVgSFyGugHPI5otBEPXxRwkAbRqPa7awbPSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJmpyKh7WnYli94xdYZOiVSmBFg60S/0qxb6lNlPWGOooM5oM/nYLfvtEOSOG0EztFVVr3pjx1VNNvBPFlmMBMVYcvxBkYQVpxUeyl3u70UhUIFpsw2uu3loi/U5xXIUOaJ2tVeBM85ffBsNNw7+QR4sUKd0Po7tkuvWhMYlFLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=InY11afn; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbZwOfaHqsLz3yOyrk+KryIAtyul/YsVkpxX2Q5bNqb11Kbq0wEZOQEdTcVmOOApZxEQcyOFl4Pw3zQgP3YE5Iml5i8TIBHl4yJPfVmTfyt7hQ+xOADB3A+MQITKAnCctSpNSZju+wVWp6wFSEdCsvlGMg9jobepvKkCsRZMiNb1PyC9hbEGn+Ev32rN2eaGEGc3O9wWy+9e+B84C8n9jCtIWXa2TS7l7/YuI1kKNLgnDViSjmjDdAr0Lcw5sunROZTcTtJc17jesW4voYSdtCPfxmn/I6Snty0+xfymQkaza8zxglaVPNCSnShbfPzd2MkyKzFBwBvnQWMvUL8L4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYQtwrCw+MX/gECF32P1RLrNEcJi3TazTt9akbUxPQM=;
 b=VVczaZStVsrUmg3lOL9HvR5wbqDYSAOtA4pCbOX1Hf3BM4KXysxW+zyXQVWH32McGdi5XSciks4wyraEiEvpXCkXtGazzRHg/RfvQ47/qxmri1ZfjoooFA8SJ/zSVEQfdyoc8ukgW0rdh8rbz0+ZsWQ9ACu4oLnbPcI2JyKA+eqI1zp5YnN5+6+TLGL/EdNBBS2ybTgEZcHwP6X8uq8/RwXvNl0tguTi3n0GDxYbBPWvlXGMhFR7uujYHCIcCpQHAzt24+kIHSnDv6+k/xd0jFWYUaKGwjbRKq08KFuMTRJhMT907wY9sQKpvnTKadbV9gC1q7tgT0he30BTkjLcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYQtwrCw+MX/gECF32P1RLrNEcJi3TazTt9akbUxPQM=;
 b=InY11afnM2XTp+AaY6cPHy8cwUI0HPMDIeeWOAxTxnfS1geHuWUxKRs6O69MKecBGMsJpIm2fRroqpx82xb7STo92K+eWOIqc1r66RIRjsuARa80FPXbqDuY+nx2ZsX5ahSGAkPNQHh5stTflIZ+vg8MqLa/7NP0++NNJClfW9Gn7e3uoJGzewzMPKbSo4rr1SlO5VgWfe3NDbta5h7IDMEooGCpEtUVQI2q4x+ljipUBLIyAQWoyPUC/VLNLMZ80J3ZQSNlBer9Yug41gSL5+Oj7gdEEkBus+Fd667AgiPFyqS1/OfgE5slAkpS9GnROaLXk4qKuW+/ygY0llOd4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 28 May
 2025 15:50:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 15:50:51 +0000
Date: Wed, 28 May 2025 11:50:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl-mxs-dma: allow interrupt-names
 for fsl,imx23-dma-apbx
Message-ID: <aDcw0sgN1ZX0kCCZ@lizhi-Precision-Tower-5810>
References: <20250523213252.582366-1-Frank.Li@nxp.com>
 <20250526-plural-nifty-b43938d9f180@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-plural-nifty-b43938d9f180@spud>
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: b1518a72-93dd-44e2-0920-08dd9dff6c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hLqDDbKZMnP1R6GoZSHSgYB0zjvHP67t2UuQHxk9rydfb3os/CtdeBztBNj+?=
 =?us-ascii?Q?AHuaJ/AuSnm1srZC2ANHlaWF1fK9vAtz6s1XFCkWMe4CKi15+x3q31XIxrji?=
 =?us-ascii?Q?MIw1jBMCMCbop9CSNaHPCX3+dlXDDilEhGsUfHquc85ct1pZWg7kkT3il6lL?=
 =?us-ascii?Q?wwk6OmxHtzEe0TfWvCIoZyZLuVWH9/VxZ5oA72GREtHG1KmemwHbOlZ2Dp9y?=
 =?us-ascii?Q?2dpYKC9ym0XviuXDHxrRX1P3rx0s3XAGUaFnwosLoi7GTi+5631pfbiRtbti?=
 =?us-ascii?Q?kiLGbtugoK78v9wXuh83SV0u8/rMJD1DP7VQKZPUQj8xBf7rE0rrr87QX70A?=
 =?us-ascii?Q?JT+CAHbpv7t+E1BumG1M5nVEqBC2NpdYqX9oyNQWtW+1jV/tGJhiTGw+45Ls?=
 =?us-ascii?Q?rvtVswU2iR0dp6feZf0wXsxU9MQDzuOBCXA2+hnE1O18slxvB0F6GUy8O+wI?=
 =?us-ascii?Q?VH+ulOSO7OirsU5OKdikzXjHsHDogZYdxZGnMo5xUamP2GpVUQwQTfE+jYaw?=
 =?us-ascii?Q?7DyyPzurU7H7L52H9m5RrrINhvQk8P/L5NCQYHmZWGNz7WSOcdUzziY9sQfn?=
 =?us-ascii?Q?pTFEIpW9Op6nfWHVALrFwcQc13MLJ1/6ElRinquvWSh5BSQUWkQwk7GdG3+n?=
 =?us-ascii?Q?an17Qr8P7kBYroBnG0AR+JA5fXx0bDbzt9ZnYnnu0LFa8h9ch5Zq5J/BeT1O?=
 =?us-ascii?Q?9xsRbHtaUbYAAyWjKmVXeddRGPkAdevkQesUhdMPk+/72X/tZr5It8ITKA1X?=
 =?us-ascii?Q?bzb9NKrZ4tDpn0DBrh47KrydKtxpSjSB36WCEWRaIrUcMFP+u4RCAegEmILr?=
 =?us-ascii?Q?5zuFQIPQTeWaEOBrLbaalJdr48mUH2I+t0d8A9/AclxZBMZ7wx6JQ80lbtNT?=
 =?us-ascii?Q?Oz0G/MM/R+K6eGAFCahMq+UT6Eiit/OzX4dAeZciFHMB4UugAF+mirAs3tvR?=
 =?us-ascii?Q?acm7pHZAsLogSrtP+tO98PwiYrxPap7U6Pk+y27QyX41LbdWFYswJxdUhox8?=
 =?us-ascii?Q?JxLNrnSTNhfhEW1YqQR6Y0l7IfLblG5SCiabvV/6nZUfbQLx6hwyyUpTNdu7?=
 =?us-ascii?Q?w0ooOJEkaohPsK3nJA4OqGwUa06X76IUfqlajm3aRiIacNRsZrAMmbBApmlv?=
 =?us-ascii?Q?855dpPaSJT+xIjg9e0Oe91W/QV9KPNEHxd9/0G3m6Cij7T1sLdDCFt2oOR65?=
 =?us-ascii?Q?P5f3RpQ0G6ZmALrqbVEQb5IhyKjopVcCvmzUmXCtRrggYjkYhAYLX/PzJbcg?=
 =?us-ascii?Q?na0FqH3LKRY7F9Q7hj7Due1AS16WEvRg9P7S+VYCvqETZiPS6P9392O5ENH1?=
 =?us-ascii?Q?B4WW+57lJaHm9RYlS6bqASf1H82vANFzWZKUakrNmowpBDdqVqWl/s1csKvm?=
 =?us-ascii?Q?Y+srn6A9S5+B9EyGreC6+KmJpYAAi1G9gYLa5HZ8aCwl3OqLgVeFqxUQUucH?=
 =?us-ascii?Q?Q/7O1UhbjdNpW8V2EqI5iPsbcoL4YGQo0yWtVPoxsKcBvViWDohyjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yR4UJvP/YdoXr9nsYn8EYnODIpK1jF+HqA270Zo1apV/mGxZS7wHSMYNonSX?=
 =?us-ascii?Q?4M5ohTOdPONPiq2bQ4kfKrfwTbU07HMJ9vUpOGOBvQAoTkezxsA+mbmvP1ev?=
 =?us-ascii?Q?R6hcNwzJZovsAHWZPFPOxXEcb2hZVIYi+uLATNFSwxAVXtA6rrn2s0Ituznu?=
 =?us-ascii?Q?KjadOE7DmiDPeZmJ1K1777WLucRZOLRcpBStA8rq/klzyXHicdV2lJ5U8eSq?=
 =?us-ascii?Q?ub5RtjEJwzJJGbZjUkjMXuqOxT8phunh8DM4le2BPqof4TAZV6/4GIH8sTEo?=
 =?us-ascii?Q?S3GZOhF1E0wMFZCHXxIHvDHvIBL45AHHuFOV2fdqjtFuLTQ4TWmhrSfocc+q?=
 =?us-ascii?Q?hgnykdVU/rRN9vahiiiik4a+orALdn//3cVdEAAi7l6Ty6v+jWZqfgRoaHuD?=
 =?us-ascii?Q?6TobaU+8xDcXiiNr6l4XQJtpkjD8DF6nT5mKFzt6xKqXPY1OYxuRNYSJCITU?=
 =?us-ascii?Q?oRdYkF3wgPQGKuwP9nZ45Sy/ox+Z5ufnZDRaWFjSKHHfzWxmnSes8yoISS4s?=
 =?us-ascii?Q?ixPfR25AJXcTvwE37doYYaJ/7qB06NCTT3u559ImFKMq1QtELeUA3cVeehJz?=
 =?us-ascii?Q?YaECAMrfxx1RfvIx4/9iNSKSjc8TAMTbsmEScPcXg8FXog0UIUl2rwBlCHDN?=
 =?us-ascii?Q?h1p6CwlA2bWzM60KET0s+9arCyhxJ+eXnl6k2Fij82cc0Rdpj1yHOVwrIwlt?=
 =?us-ascii?Q?fwShoGibYgB4t1nAVk21rIgrU/AXUYySE954veq8ocUKB0yj/FXwDhLVg+oi?=
 =?us-ascii?Q?/dtEcWllG+3pK/jFPIGsfbwgUkBQJ0uj6+zP3Lkeb6U+fJG6Huvj7evHe0Cr?=
 =?us-ascii?Q?KqVcAKW4NjtljcrKOG3soGdCLOnyBqcaaEAnRnZOQz5VPUAqUi2JZDamqojK?=
 =?us-ascii?Q?ycNSevXHuZcIPGaoHbazMyRBeINyCvVgeAagUA8XA+g8BHC+wBzG/Koz2oQx?=
 =?us-ascii?Q?YA83NVjh8dorWNwmsP4AD+Y992AO8wAzceGs69G97BkH2LXIQVtuOq2iiqsm?=
 =?us-ascii?Q?KcbBRLgcH3h4dA2ri2EfBO5/SsRMp4yKqhLplNwwlToy4F8mSbavjxc3VHww?=
 =?us-ascii?Q?fCc5BhBtozIJys9NleVVwO53IUV2kLdjXGYwsbMwc9YrIxlRLlY5YoiM9Uvk?=
 =?us-ascii?Q?fhH4l2xeqqVLWnsxxRrH2cnyLp6YlhPvWHPlFIftDKzlDJyRMsc1Ko28uWee?=
 =?us-ascii?Q?Xn3QXPXykRScvHlmOS3u7hONa9v514iIXxITsuvUb84+pRm9zM2a6fsFsDi8?=
 =?us-ascii?Q?fnpqPDjRLr/aiQerAv/FlkxodxMimm9ZJe7fsR280/h2n0EsRatdpzH4GcM2?=
 =?us-ascii?Q?h8EQSpDX80m5O7CqaHbWbvwhEBMyDLNCBibOEsPA6FA758+SItOHT4gC8UTG?=
 =?us-ascii?Q?337SPGXjxcXVlLnBHu1c2LkCxdhUywnV/FSpKO60n8569OA683NkZjvg3fsM?=
 =?us-ascii?Q?BT1qZW6DN15a+V8sPs6mrN0SmXgapQ4TyLVi8x08Q/bIcPDJXlSpuL6T66UO?=
 =?us-ascii?Q?ipRkamccEOfN4JJXFvLypdFBv2QoN3ViBcGQkRuy9j1OGCMapAZsHXDW/fuw?=
 =?us-ascii?Q?ZEyitFL4SEnCP96oG/U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1518a72-93dd-44e2-0920-08dd9dff6c01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:50:51.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/Co4ZJdfTb6Vkzr9S0V5pGs2jJ9lfT1PUZvM8KP/FEMoupHvbQRwYaZL1m35HKHWOLhFa0SXkLWfrcSdoi/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491

On Mon, May 26, 2025 at 04:28:07PM +0100, Conor Dooley wrote:
> On Fri, May 23, 2025 at 05:32:52PM -0400, Frank Li wrote:
> > Allow interrupt-names for fsl,imx23-dma-apbx and keep the same restriction
> > for others.
>
> The content of the patch seems okay, but why are you doing this? What is
> the value on this particular platform but not the others?

Actually it is not used in dma driver, i.MX23 is quite old chips (over 10year).
Just to match existed dts to reduce warnings.

Frank
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/dma/fsl,mxs-dma.yaml  | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> > index 75a7d9556699c..9102b615dbd61 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> > @@ -23,6 +23,35 @@ allOf:
> >        properties:
> >          power-domains: false
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx23-dma-apbx
> > +    then:
> > +      properties:
> > +        interrupt-names:
> > +          items:
> > +            - const: audio-adc
> > +            - const: audio-dac
> > +            - const: spdif-tx
> > +            - const: i2c
> > +            - const: saif0
> > +            - const: empty0
> > +            - const: auart0-rx
> > +            - const: auart0-tx
> > +            - const: auart1-rx
> > +            - const: auart1-tx
> > +            - const: saif1
> > +            - const: empty1
> > +            - const: empty2
> > +            - const: empty3
> > +            - const: empty4
> > +            - const: empty5
> > +    else:
> > +      properties:
> > +        interrupt-names: false
> > +
> >  properties:
> >    compatible:
> >      oneOf:
> > @@ -54,6 +83,10 @@ properties:
> >      minItems: 4
> >      maxItems: 16
> >
> > +  interrupt-names:
> > +    minItems: 4
> > +    maxItems: 16
> > +
> >    "#dma-cells":
> >      const: 1
> >
> > --
> > 2.34.1
> >



