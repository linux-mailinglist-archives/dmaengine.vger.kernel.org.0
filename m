Return-Path: <dmaengine+bounces-7548-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 848F9CB0761
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D6F930D69D9
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08252FFFB7;
	Tue,  9 Dec 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VlfsMhph"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8182F4A0C;
	Tue,  9 Dec 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295268; cv=fail; b=LM/xeUU2DVtDHlYTPGRf6FvaxEQ9qHXLqzxLqLkJoEJdVQj7cNsaIo+BPsfYkQMGdP3l43yosr5mndH1xa040iAdR/nb6HMtFcLvhkkL5qBRIulaTaHzyVtep9OLHMBaueoXQjKKFZ1QGJ9Agi8XmpNTBG6y8gv14J8Fx62cw3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295268; c=relaxed/simple;
	bh=F+XUqGsHdfBH/n+v8Mc0Zdsn5uvxRVxi3bhBrikX0m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rPGRHtLi3vu5H/ng4VVe+8y27JhkeF7C9MrnpuNgYYqg7oagEQABgYd/JyJXCIq8V3Js1FlFRi6IwwLLTtVgbVFlSa3nEa+gb/DJKz6Rbm3uHdxqvD/fWFyCkZm6PS8O2CujuFdw+Zsx7KhHKH9pILDWbLFLnG3mJbOvHsghkMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VlfsMhph; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SplcYTGUpGvCbAAtQ8/1lzODb4/glURw0go4hBnzropkxv4XO4FxT5yeJJsSjyyl6uXsd3xFTePsf9GIC9V3jifW53QWbCHB/dQH4RKxLoajimzJcgMH3wn4thKBPMBcmGGxnKP8LoVfx/4KsDHLCyY7q1WugOabGnsumEWkyu1kRCcb+Ic0TjHvw1s46nneAIVQ7ZtNrrmgP6LVPxT0P/eYvtwHivblOCjalIMphkUAvWUkMl96No10BcEDsdEc8e5IliQL8e+LXG6X7+qJWDGpMsl37+ii7gUlHISfoznqbQC+OLGdGxw3RuOkrGfQ1VMzhq+AUgwUdtHfFkWpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+XUqGsHdfBH/n+v8Mc0Zdsn5uvxRVxi3bhBrikX0m0=;
 b=RRk1cdwbyE0xWvwzdt1ijlwyuDAAkYuGNA6VNqa/VtyVWjctaWsA0VPQwIFBxfCM+G/WX+3OnTpoQFgi/5KswKzaB7BxtL+NeYonltO7ik/T+0tUAqxeBA6mAa1C2Bjl8CKnmykcUFIIuDUk8OwZ3TNGAWzO0+dynwfRi8jEAD48iI7KcyR5uFwnIcl2SJvnIxVoYpLL1nCEzaXb3IrcCezPg4OohwVGUpLo9OskaE1kRgbAANWI/TlQFBafqwLi4r2/xRZPQelNSOO6Ltv53tqFe2Cv54HZVJ4cHHVl1b0bchRrr4gz6NMYGykTRtO6faylHH9E3GY3V9KTBYAs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+XUqGsHdfBH/n+v8Mc0Zdsn5uvxRVxi3bhBrikX0m0=;
 b=VlfsMhphQuy6/29pBUBv3nLeMRbk/VkJSMCs0OPLu4kfEE4QaQRWMILfzligbEy9RCAx/DflM5UkjqtR51bqz2PUCrypwRP8Riu1kfq924CrvQswXu1I0liLt7JWD6TGExXQh9+oljLKjh0EQ5xHtedkblC5GmM1Jz1djVICYNb67bWGzI7cV7LVHEjX8UICn4mZyG7YCctAs+3qNDqEhjj6XoX1O6pOIg2aU6mUjngUm9cpEXtcK1Xx8muq7iZWFJL0P3Q5eQrkX2OgljCoHfyNGKL9E24rr4b/mqtOVq6p7qFybg33yFY7JWoZJSGeqi0MVofZ2KmQ2oM3miYogA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:47:41 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:47:41 +0000
Date: Tue, 9 Dec 2025 10:47:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <aThEkqq79WwPvQ27@lizhi-Precision-Tower-5810>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <20251208-dma_prep_config-v1-1-53490c5e1e2a@nxp.com>
 <20251209063809.GA27728@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209063809.GA27728@lst.de>
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PR3PR04MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4208ce-a286-4d85-bb74-08de373a4936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3FmA/Twqt8rt9g3YK6wdB2X/vMr3WlWefjzQB20kIw75VlsHAEDzN2PJOFQ?=
 =?us-ascii?Q?Yc4OA7UrI/8sj0cq16I0Skox6C3YtHzHnP1SeBX9G3bFrnIXWjlwEjOYpp6R?=
 =?us-ascii?Q?027TRrnTgt9HIOwE32KKyK19Wf0917KFqJelXEmUxKPJYkCrNv1VBj1+bFRq?=
 =?us-ascii?Q?8O5q7z74aNVVoO20cscUWVuCJRo3WMcad0gSnd4HxbGCgBG27zVDPJnZc2VA?=
 =?us-ascii?Q?xKwuD4CtLIxkudp5RCuoZa8SLuz81uP4yqVLQ+n1E7kJ7Oi+j3fgos1XmDL1?=
 =?us-ascii?Q?OxqiwH1Ei7kCsuq6BWBXGVURJZSypAaNkvTcnJVHp7Z1HFLEaVjpmZ7qJXOu?=
 =?us-ascii?Q?e9b2u12pjq2hI8qgLAIMBkxqSLRc1ASGSwmgRip/zuZrgRCC8nB1h3t2I6Jr?=
 =?us-ascii?Q?Ubu8m0+DuO9YMLUszN2FEtkVlK7CIOOi2p178g3xpmv7njwNkWDL2JWGR6Jx?=
 =?us-ascii?Q?G5ORPWKbxB+8RcFoO7T+Ruvro2fsnKw72EpbDtrB3H7/Oj3vRCTunwRnEobO?=
 =?us-ascii?Q?7sc5wvIjprr1dxTNSV9czroKhEbUhCMnnz+oEexQx77RGXUktqgsP3UZLfl6?=
 =?us-ascii?Q?jxUZthkpAa16lOA48n3YX/FaLd2Q56OxoAZnPSQSF0c3NNTgtyjjg0DW1HHx?=
 =?us-ascii?Q?XZ0LyRfk5aSHrF3FB5dEwLB7v+TlOJfbIMWacqtJ58aFcDYVhCqwTHSGkY90?=
 =?us-ascii?Q?GJxUXSb6gMr8IvWaUoFNgfD578OKi8PNEroZJ2WyDctNk9XH0npZefXeIx2j?=
 =?us-ascii?Q?d8Nx0U1NtoIXVFxJsbSOqy5O8KQLAbQ0EugMgQS54R+iL9wX+zS9cle4Ozzq?=
 =?us-ascii?Q?Tfw7NmmKRMj4wUg5s1DkZSZ39OlaSalJHcfmGgz4831NhXzM1X5coEtcG9GI?=
 =?us-ascii?Q?WFSYpIiCNuA5d9pmAQ1fR6doZjk+JM4oe6iB4Gt9Dyii3Fqp+dUqXDDG/LuH?=
 =?us-ascii?Q?wjQb62iCnCplVPWitZAiSivh7Frw92ragCAoEQWmYKvbkz6uI3cAnMdfUZC2?=
 =?us-ascii?Q?qSTQSeLxV63sJUDgBsT1lnEXcmz4nGdG5daBxRdyI5BFc6o90Pc9uQ4hze4/?=
 =?us-ascii?Q?Hax3pmKi/EODzsflwNIPzath7+i/J8qGMa/y9g6+830uLVN1On54ulhrGseV?=
 =?us-ascii?Q?2qOV5SKMMYKUBfNp83XGojxkwvbvl/qb7sHisJQzVO+VIRyqfKNxVRsF86J2?=
 =?us-ascii?Q?d2TkGYGWSALoz38HyjYi3OHd51kryiHJ9GS7wtLolArviFJQGT15p6sKYh2S?=
 =?us-ascii?Q?4IZh1Cc6Ymy/6dT77rWE8wKIu3uAQzQ0hVJRGuQBX63aU+frEw0sKuEq9tBr?=
 =?us-ascii?Q?r3rdhR3hQiRnjVYPkl+SV8QdHBhBKfEh0fbqZ0PU8n8fZi70uZGtieZHzydj?=
 =?us-ascii?Q?QbW/zg6z3yaW9tSyJMTf4KYfztKnxYFqwpuwQeaWeAVgedgjWkae2yNrlM2T?=
 =?us-ascii?Q?XdGVPnwxzqtxMx98OIg+fHwwYzodJJYHKcXI1fq1OtrST2vczcNWznyX6bp1?=
 =?us-ascii?Q?cpLJsMSf9N0ZX6yLqPVwc+ItDhaEaqsvzZsw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBvHRa26AHqgoTwZdQ4Lfw9SjP1E2CjGBRGtS/0mXt+s07YypGyVwh5dOleW?=
 =?us-ascii?Q?r/eWAXdQmXYCPLd/fr2UAdIA6tIbMT5AhpSUGUuVR5FLmGTXwq063uiFBaKV?=
 =?us-ascii?Q?0YkFmKGfchujS+io+1wMuHW19v3XDvk0LEIKy4HyVxBb3iAnIxuneqOcAO60?=
 =?us-ascii?Q?FS4j7Ztk5gKncdveiVkrtXhXeIc4s5xjEdqM0yH8qWFk6Qu/LOv7ajDL2wUd?=
 =?us-ascii?Q?9y5Te4cLj1/eqRSJefsiih2hl/PaqetLPeQEzHMMOS6jLSCnygLvVehFyyOR?=
 =?us-ascii?Q?CVm9RUjo4cF/BKX27KG0Qxs2VKz8O7VdCdF65oK++QSqTbjlLhwtOcMfDeuN?=
 =?us-ascii?Q?HVb+xQ7u0UkasKS30qKESArgD+VIvkydVPAYjs/PlmJzubV2KpYeat8Yq7Lz?=
 =?us-ascii?Q?vWFMFP+eKCJ9JK/SCXL+wZZQBiZ1l4n69MSddnCZoOj1uUlIyOaTyYNAzYWk?=
 =?us-ascii?Q?7vb3eu6wmwCfsVPCYIIppdcec1amoK5cjM7D5ismLD0rxf6MNQBDYlVAS1Pz?=
 =?us-ascii?Q?LGJ239Ujp9eEX+6lkYuXjdRQKTphJfOTO1/uKbyn0k2Hq4AmwKheCzWf+IV+?=
 =?us-ascii?Q?trSi5Kk8tcDRnpD5iohSDiTBq8Ld6t3mzppOs9KQ/7ct+xd3uBZBhg8YjXpF?=
 =?us-ascii?Q?fI/6Ox7c95wHB0/Boo7l+F+h7Rzq3pucf/5UGc7biaCWrSk3zvEcHwnfP80f?=
 =?us-ascii?Q?TuX+zqmkVSGoM0CsYvMBj2iL24o2tvgaenZwEMfBFB4ST6rxDdK6WHgzp44C?=
 =?us-ascii?Q?cqJ2k75B5jO/XmkuYeJbLM7s+Io6uwnMPs9+cRMGXAGwloVnIZwYr7tBRljB?=
 =?us-ascii?Q?jRjMoxvdskM1I63eHRB03/33IjcLbaihnpm5O5AywE9YHaxkz917xq1kaTUy?=
 =?us-ascii?Q?Iwzfhm8yHVLuvCQJ7Fflgmd6/PxjZ12DgQh3Bo1R5WOTYlxVt49VKnvW6ddS?=
 =?us-ascii?Q?zDikAu7H2waQmTWw/l6op5rHonjHMBzVionUqJVKohaH3yaSwibjDjecfrEi?=
 =?us-ascii?Q?yQ8bNVuyN7hjqrCtDHDxr9l1L1TaB+HoHkFKdmtf47hfYauzeqDbGlxTfs0T?=
 =?us-ascii?Q?L8kB13Y0JCEB7adnjRMKlv4bey5QHnlMcL0WOnIk2pL73snHeZhf+B1IhylZ?=
 =?us-ascii?Q?rKdn4DUMBxneyIECMsvZ36DuZXKgAcuOFhTOkfCapnlKyR72ZftpxBnmfyN1?=
 =?us-ascii?Q?5g8WDESf/16uEA6wv3/FiBzy/2//2T9vnVreck8O7QJA/xgSLRdoW3VP/hQj?=
 =?us-ascii?Q?Q+7yTTrXjDp0OcVwrNco9HHq9ZYERDtkcpTMe+a2xxgJ1MPo36dy3GAV7ZCO?=
 =?us-ascii?Q?4PasnRb7vuomFMHSjoKNl8q1hZcMjIE4Az1/K5qMgj0crbtHK4p7kzPz5MnI?=
 =?us-ascii?Q?ob847z/nWXHpJ5qQ92YH5te/Ns/2sdbHN/t81OvuLI6bUSxvoVwRMJDtjd1R?=
 =?us-ascii?Q?cB9i82Izg8VEDiM4aadnz4Wgohusta78c9ooj/tETJd1oy30/sjp1cXFN/D7?=
 =?us-ascii?Q?7D+LSSj3dYlz1qyHnAC9lS0tqbofWyzZjQjGfAUuSUcpLL+lUe9LH36qkGC7?=
 =?us-ascii?Q?wTQy1khhSYvLvacvjtKiU0jrkVfY1bUH4fBB9aef?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4208ce-a286-4d85-bb74-08de373a4936
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:47:41.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igtPwsRjrTvXuW8RmO9YWdsJD6GlN5qpRLcBFst/LW+tPYkxekByt/UgKE2qS2zyc45jnfY+PF9Eay/9X1jwSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404

On Tue, Dec 09, 2025 at 07:38:09AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 08, 2025 at 12:09:40PM -0500, Frank Li wrote:
> > Previously, configuration and preparation required two separate calls. This
> > works well when configuration is done only once during initialization.
> >
> > However, in cases where the burst length or source/destination address must
> > be adjusted for each transfer, calling two functions is verbose and
> > requires additional locking to ensure both steps complete atomically.
> >
> > Add a new API and callback device_prep_slave_sg_config that combines
> > configuration and preparation into a single operation. If the configuration
> > argument is passed as NULL, fall back to the existing implementation.
>
> Maybe this would be a good time to start retiring the "slave" naming
> and come up with shorter names as a win-win situation?

Yes, 'prep_sg_config' or 'prep_sg' should be enough.

Frank
>

