Return-Path: <dmaengine+bounces-2688-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5592FCD4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723DB1C22BFF
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C1171650;
	Fri, 12 Jul 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HgkqwxXH"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C379E1;
	Fri, 12 Jul 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795564; cv=fail; b=eHwDsrhv4SX2Brdm5tshhBiqrW+JcjXRc644Dv4tnOvtYmzBS3sg3JBHlt9n+GuPA9I3qC7o8z1QxPn55pQZ1DkRPv8zGFka857MhkJcA0mFkB0WJsZsfv66OkCl4KZi5mf/HfUNT9Qj3ggluyGxRniXCgJqixVtYk+Q3shKJi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795564; c=relaxed/simple;
	bh=CzbFr+oWw5lYXInfhUftKHD7dToIOL4KV7BclJ1Jx3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4XUVrNEdRc/7t3jX/6g8a0TZrCYAzsoRTa5X7ks7rSQLxE4lg9biQT6/P1596HLEnb94Sh9rPcZ6L667wipouXAQgMHDlAKvEiKPR2l6sWT7MacKeMBHkXzq66JuSvQipDWe8JJam6tFwK74kiYL5mBMHoKtXddb1vK6O8W8/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HgkqwxXH reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeDojaWcsP6+JwFvspV8ZwvVkANQUsm58gxnuQRPptuMcWy1jx/5mukeuQVSQVl5KLi/NCsuDD6cAJ50s6nIKVruSVEIoEn2Y9HZudoNjYnzGP6DnzogHpDowWo88Z8Y4fq1ZtwkxTlFLoHvagrI4GxwMdxi3ZdMEAiqpsUpK/DmwQ8PIYOgtztjW6QAwhTAPDDMVr326mHPtIfwhV8ZN0CudcC+vhP4aSlt3QA8nNBW74qXhYMPu90v4E/YhZYKGsDYLiWoB+jDcCn/zpDe+pHvonW9sj8UHfpwiOSaZ/C3uCnSdWIxAsuk8a+nCtcWYL+DhoXef6NC2fxv8JjBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P903uT99vb1AdsPdL0iDgpUzro41rc0Pdyka3oMRrjM=;
 b=mV+Dc9MP3o68gsdBgCcNGFYzs89g5I1yAaQueuF7CP659V2l5/+x7gFkvpkleA1nu93Md1rKfSUIzVCeVqhV1zUsWRfUt0j3U1qyorLYIPReenXRW24dUJXvbTP3A/1JdstufX0SqtWwa33rm94PjQGmZsvbnKdxubCzq/GeywSg9if9JJYPszmBWjfm9wLHN/NKOfd7BL3rWPqfIdx0YY4X0LgTDNvsRkWDOH8yFLmncLpq2LA/7eOD5XZRh4qrHbjZbcHLHO9tvmRLNaom6Z+bIRThe/LVLDKzVSsdfSzZG2D3QOfoRxlqh46EQM/2iTmHwmJZ6zILgXZ+pdAvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P903uT99vb1AdsPdL0iDgpUzro41rc0Pdyka3oMRrjM=;
 b=HgkqwxXHxiksCmP/5dYnw6G1XEoxnX74/BMjEbi8FOr6mmPz6WDhd3/qa1WU3lYWE/r3Dpo6V1iTScy/0IrWzGVOxHp8+ORU+FKJfiFuIHj+hnxDHyjfv2DUpe8EybkZF7adaJeAWbKVR94LTOMpBh2OiAtn0EDyxKsHGRI5gAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10598.eurprd04.prod.outlook.com (2603:10a6:10:580::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 14:45:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:45:59 +0000
Date: Fri, 12 Jul 2024 10:45:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: fsl-mxs-dma: Add compatible
 string "fsl,imx8qxp-dma-apbh"
Message-ID: <ZpFBnnbxD9VUs1zp@lizhi-Precision-Tower-5810>
References: <20240520-gpmi_nand-v2-2-e3017e4c9da5@nxp.com>
 <20240527121836.178457-1-miquel.raynal@bootlin.com>
 <20240712163503.69dad6b1@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712163503.69dad6b1@xps-13>
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10598:EE_
X-MS-Office365-Filtering-Correlation-Id: 10884c1f-06db-4740-bcbb-08dca2815854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?rm92L7XYPWTMenIgY1nH6NgvMh9nzED142qXTOcxvxyt+ZIsZhDMvNeBos?=
 =?iso-8859-1?Q?T0HPtY+pF8BjWm6c9sO/wo1GNKip3emweZjZuMvdTioSa5fHAELrlIQ+K9?=
 =?iso-8859-1?Q?T5KNoOBn5bEARWDyNSJ5Cf9A9JrXmGRP8Sr8OYwlbQ6FQ/iMDN4a6IWGhE?=
 =?iso-8859-1?Q?YtZ4ub4jzgyZ93V+tPkmHrnP+KYx3/j32plu/Gp/iUBfA4qX507nrUlZuR?=
 =?iso-8859-1?Q?Q1EOXhCXhIvQx8/8j+XopxwAAIcy9KwHLnPfRO4hzDhbzPR90vzhkklWeV?=
 =?iso-8859-1?Q?NwQICli6+OYkwYoPR48RgRZZWLZGZPPxMOO+koPBUXfN+JDmdigVxo6M7R?=
 =?iso-8859-1?Q?Q09o9t+uQqOaz0W+nyqi/Jp2rEbQzu/JbGyYEDK22HyEGqLCJZ2BGPIhNh?=
 =?iso-8859-1?Q?LVBiYqt/kkol86F+2JE8bGD5UvTCJRFTDdf9QPBefxESjCldQHpHVsxOS+?=
 =?iso-8859-1?Q?PqfNkCuvm4ITaHyOnP19vNkDBZPDTTpWN007PSS69fEQ5oxsUA1tSli1nz?=
 =?iso-8859-1?Q?0PzYZEDXlZvTEw2QZq9HZoIgAgqrWS/Qcr8SSunOqOER+yOHzMZk3QxsUP?=
 =?iso-8859-1?Q?qMtztpqEV7jFTj89UMKBWe2BQC/K3VSWogWI10kD1W3hU/4IVzi24KNTBU?=
 =?iso-8859-1?Q?YSPyRtQs2/1v+b9P/CFx7os4+SQL6VKAEA8sXA63Mzsxt8M5D25W0JrImv?=
 =?iso-8859-1?Q?lD/hQ0wVGrKFvzUa+6iLpq5zCOGQ/HfK1Gl4Zxw1ToEFsyWPw7znR/RIb9?=
 =?iso-8859-1?Q?OpZvuNN6UZ1jitFoLlobv+opQlAT+Td6UIMjH5qTCMhxRfa9NELr1OFVlQ?=
 =?iso-8859-1?Q?PzigJk0Uk4IggJd9Mds/tcX0LwFqy2DzKJNMhZGzP9M8UijJFmoJV4MbTM?=
 =?iso-8859-1?Q?LHkfCm+Ph4X/ShXgllNfsOGKJSK22Coc2+kkglE2ndbTbsEG6ooZFa8gWK?=
 =?iso-8859-1?Q?je0ejig+jebEuDuAuWMcR35zFLmVbMiXpjFR2kY2lpfAu7X7HrKkiDvGr3?=
 =?iso-8859-1?Q?1zmt0J8az4KKPUxNWYC3w0JIiYdKAo3nQ9N63eY4nQ4vpyrwQxdI3L7DXe?=
 =?iso-8859-1?Q?ov2uqTTB+YDkj2cd29Nlmtd+daC9IuMyITkFaJpm581bDGC660nxt7qPqo?=
 =?iso-8859-1?Q?++Jzv8eMCnH0Su6gSdWtdp9cqUd7pVb5B8WucBpYdUOR/TDuO6P0BTCpNC?=
 =?iso-8859-1?Q?e+Bss9H0ANqjCF1cEfK9/jwt8PXsEz/kjLOO887vyWWHtyv0zJefHgxOrs?=
 =?iso-8859-1?Q?alWtevBYwC191e8b+NpOKd6+i1uyEPQ9d1p1xCjlvdynwIwNgH0CoaRNHL?=
 =?iso-8859-1?Q?4GAxFy5zfPJ9XG3dkmr3d16/xqhWV0qfcprlekiT4NoZlSyYUOGvE2vwLU?=
 =?iso-8859-1?Q?QnmEYcDnMgWL29nu+siQqW31lagnx5VT+Scs+T7PUj+PI8uzEorpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?sNAjG5vVAafOCmmSPBzy+yfV8rJZYX7PM3gCjzXeCU9W22o1iCLulcCRbI?=
 =?iso-8859-1?Q?g85LFkr7WbK4UX13xAyuoIqaOvLl2WBU+G3Q0ipFP9gqo8XmammZm3s7UM?=
 =?iso-8859-1?Q?FvNGXQAL0/16aM1LRtOEsZfDmC6zBQMZfiBhT231psAOgA/lwEEVrMmCa+?=
 =?iso-8859-1?Q?oYJyCm36AFJUh/XPyzXCRFwnN6YTg5UIPNRwLFXwEsbkoYAOQOIeK3dY73?=
 =?iso-8859-1?Q?yNCZ9P8ah3U+C/XBQHZTHfd3/hQC9XslqUwXoJkTcxFrE7xNt2WKpa8P43?=
 =?iso-8859-1?Q?eYNYYlUa1No3P7XyisTLq8wFtAwPSyVUseKLsJYvYCVSjGaKS6eiNfnCCn?=
 =?iso-8859-1?Q?Fbs88WoEMyxg0x8C9upQs0TcFk3TweZ7KmfKhfHBLSAVR9l3zd6FlZQCEP?=
 =?iso-8859-1?Q?jlugj295p2JwRwTA+iIxp0sYLmCSOz+DsCWKuXyxN1A/W6Xn+587OBcvHE?=
 =?iso-8859-1?Q?IWTduWpJr6SbWlVewfY+6vol9NeySHCZhCPByIe9XC6xdz2z60QD/RqAli?=
 =?iso-8859-1?Q?r4rbS+10KI24OEryfNLwcmH+GQhvyyevzPrNi6qIRp0vYtewXqIEb//Q0I?=
 =?iso-8859-1?Q?O+TmKuuG3uOgvVpR+OZXBHXg0bKfkqJQjyOUqcJpeKW6JEl/gnrZDdA616?=
 =?iso-8859-1?Q?uYoUVRdY/AWx1cR4GwWYznJPssdSPrpGVWvv91fuMpF6bsbp+/pzxiyh2O?=
 =?iso-8859-1?Q?Esvwms1qrwtgZL4m5oJ4ky6kvbTssP52bep0cifLjDEa6PHbD/fFxjRi3s?=
 =?iso-8859-1?Q?kvXnHr7ceKlokiYaTx+l4SI6vcBlhYnfLTMo8GvZKPWRigmDkzevfpMTBO?=
 =?iso-8859-1?Q?NZ37Qm4TUiNUpOL9/Ih0KpkIU7O5/kPAACRXnEq7Ve8zLbhOyB1v1J4z5n?=
 =?iso-8859-1?Q?0z73OmvvtEey00B6KoBwWilJbJzdt85dw19qP0umBJdBZWKMhw8f44DgSX?=
 =?iso-8859-1?Q?dj8KmHjLVfpVFkKXaXc9km5yOnMu0IKk10elhYTte+5UTePGxVSB2svhZP?=
 =?iso-8859-1?Q?phGu6JyGjJ0mauDp1d4CFsulkBaY/bkvWEerv3YFKAZLnhf58rp2mWoEFC?=
 =?iso-8859-1?Q?f32QLsWGaE1EniHVwOayLdRJsjjScdlCWV+EjHYrHC29ZNa6i5NsH1plsM?=
 =?iso-8859-1?Q?v3vvmsdNvtk+ur1kJS3ekcEHpGVni1vJl9eWxOFnYQkEFJ5Pd3MGHwO4wW?=
 =?iso-8859-1?Q?Ars/6p5f+yO3Bf/DqWC7399r68TZDppT0hAir6TvHM/LTRAuhVpc1zSnsj?=
 =?iso-8859-1?Q?FSr+OVYMW4wH4r5/Gv0Rg2diU9MMRD3MiqD589AnPKkrlvXzrJC2MdUad1?=
 =?iso-8859-1?Q?zSYoBwC4tYlrp9o4tjm3fRBA+NGKXzhIMtISmwPd16JSR3Rq6YTLlIp9sZ?=
 =?iso-8859-1?Q?KNx6rnpH71GVQ/jXb59xHPXT2wyYc4P0v30AWxiFRC+jVmCCtsP5u9CIKi?=
 =?iso-8859-1?Q?aS/4/snw7gyeZ7QoKvmtL1umq77KtAosUwOAaz4019fWmjUNdrZ5zhXGur?=
 =?iso-8859-1?Q?8LOJ/npx2gmDemVCiWI1QPS8gOyk2sZC6fR9q4d2N6q90AU9OP9JsF66vT?=
 =?iso-8859-1?Q?SuKxdjeYuf8RXJ+JIuq6m+Kgkop4rwE1jNMOJeVf1HT0r0ZIx4DoTEyTgi?=
 =?iso-8859-1?Q?+XlTPXv/+iW3n4OaqOqVme1BCtpnK09IzP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10884c1f-06db-4740-bcbb-08dca2815854
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:45:59.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMeXNah5iGMGIfV380JO496m40rNaCnSH24T7Y77SdWYPOcLSAQVAvEu/2NervidZGXLBI7Fr/QWGaYngGG/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10598

On Fri, Jul 12, 2024 at 04:35:03PM +0200, Miquel Raynal wrote:
> Hi Vinod,
> 
> miquel.raynal@bootlin.com wrote on Mon, 27 May 2024 14:18:36 +0200:
> 
> > On Mon, 2024-05-20 at 16:09:13 UTC, Frank Li wrote:
> > > Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
> > > compared with "fsl,imx28-dma-apbh".
> > > 
> > > Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> > > it.
> > > 
> > > Keep the same restriction about 'power-domains' for other compatible
> > > strings.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>  
> > 
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.
> 
> I just realize now I picked this up whereas it was not intended to be
> merged through mtd. I'm fine keeping this patch for the next merge
> window if I get your explicit agreement otherwise I'll drop it.

I think it is fine. Basically this dma is only used for GPMI NAND now.

Frank

> 
> Thanks,
> Miquèl

