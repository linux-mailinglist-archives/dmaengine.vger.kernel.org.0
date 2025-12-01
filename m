Return-Path: <dmaengine+bounces-7435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8AC98DB8
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64DE3A2424
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A61E1A17;
	Mon,  1 Dec 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aJj+n+F8"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8A1F03DE;
	Mon,  1 Dec 2025 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617545; cv=fail; b=WhMrLSZA1ViNsES2jAhW7f0DOf/bxMRoDKjbIBJznzI0ttYBSgRyxJlOASyh6PwMvEWTyQmMBZKjs7kVAaZ2r9u40UcfgNZVn+ZCtKDtglIW0KWEWPCMZmXSLixiTaFE4FY1loXLZGowD3V1iwvTAp8E2omhmkvtxwgAImuMi2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617545; c=relaxed/simple;
	bh=PU1yq2mZIol68876X9ef0HxjIeAj02Sh2ovF3DviMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y17h7yKzoYQQ++IeUvADys+nuBcZjKrhoLA5OLi8LUWyRfr3MUCVkV+t074KZG4O+Fqf02txvgMkfuF2MNrVXdUx4hp6RP6O7bGfFGuDFfkj8YepNwAdyVMLP3XmuFaZrb75FZwWRJpW8MnDMgsSF4ZiQDwu4DmujBmqCZbeIlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aJj+n+F8; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftUzWcqxlMtmc4atDPtu2lBPpLav8rwSQ59f40UbQO1yOfeuBCn/9o9vrQLffRdlabrn3CwQjpWfB4SlBLBPg6k3VXtPujtlKXNVdDHXkLsEGyVjNXHxkYQ8UYl23wnSPLWfS2pTUJpIIN0jXMnYLA7FhjllynykYnjWkIZlTYoQVRFMJ0e+wvbzZk9Z14S0JFEFIyoVFOZepDkJ8cOvE1x6K6hZZFuiiJO51GR6LQ8ukhJwKelUa7cetILvCjGBC4A4CG/dNqjrVy8D9PP2dSAlJiq4NOcul0pyNFEj29RwLiOZsKNA2ZSLlBzR6K2eSqhjhy3/KqTZV/1slJBbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTyAj9nU++p006fC02JRfq2vnjQTIgz5rCbObyKvbVI=;
 b=U+9i7LR+kreBzKRVqPAQIQcUmGh947DiaF3Mxh+iONOFlVz4CPGnGYN2387Iio9Zi8ZH3Bt9gBGLxwHRm3VhrxEKnX+X5d0+uQovem4n4/m5VrSKkJXHeQnjNE/cgoOxJGu1pJCJ24ZefO8M1IqEwU0h6NX/7UGS0UlJ+WsRokPQuk/ovYI3TTShPzTZlUs7wQYrWQkc1rq5/M83wukPWyoHibMJMK5UAH4uLrCTT4sKIj3OonjpqrTd1nNhFTsJd/cMOWCeG6uAMQuWT141IUFntJgUZAVeCmy+lRDgIapolI5Wj5qe/YfdDbd2JgWvMFkSE9GlXDOgXps7gp/8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTyAj9nU++p006fC02JRfq2vnjQTIgz5rCbObyKvbVI=;
 b=aJj+n+F8lYRdOhC4F2kj0Uc9ndeToXTxC6I39DA9ATM8qD6z7aQ/GgK5XVWjUGZIcfbg76Jeyrde9PVpv1PB+RTVZOV4Dqp9+zWf+QMiXrAGoXfLZYsDg09cdfMN7QVqJKLKJVtBM856/ePrhASKl8LEq9LAcyPXDSEJJOlrzBOvEcHPLOUPw2auHFxcsRq6/p9E2mbA0YWNk5MU4yEaphDuO90LiYx2t7xJyU9DYJ8tFJ1kX4cbUhc0Annl4anwYjLGIUiViKxt09WmyppcJUF/2yQaCasxxanH0ZFSY5aehka/sMsUlhcs3P+Hs8XNTvcS0nF6BQZrxYSqahgrFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB10713.eurprd04.prod.outlook.com (2603:10a6:800:275::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:32:18 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:32:18 +0000
Date: Mon, 1 Dec 2025 14:32:10 -0500
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
Subject: Re: [RFC PATCH v2 05/27] PCI: dwc: ep: Implement EPC inbound mapping
 support
Message-ID: <aS3tOi39GEqLMdzR@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-6-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0110.namprd11.prod.outlook.com
 (2603:10b6:806:d1::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB10713:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0f22bc-69f6-4ec3-f9d4-08de31105706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+lb2wAm78BVqeif+ntwXGqcPpggGkLUYhEZ2TOvfvpWX4tYCnyv5ZUe1IpO?=
 =?us-ascii?Q?1wxWA4imSOYs79elD1t4XTrvwUh8fO5lhIRlfr2TLoj2d7EeTAA74KL0NS4V?=
 =?us-ascii?Q?Ll9Vj+fEEi7QbLQO3OjMOThMjvFFwhPsHa+0U1qS/nDb77Qx8Ni9aC1Idria?=
 =?us-ascii?Q?iULTeF6jVXBAOQudurYCE+oG8UGc7iWBAr8PyKitXzNAKGgRyLXEBrGDhDbm?=
 =?us-ascii?Q?nVYvcZllqZ2Rxfe2uvcQrdkK6t+6YJum5EhTCTBMC6C+m0oeECKRNvanUElh?=
 =?us-ascii?Q?CxtatKP9Bm5jNC/T6+srL8WSExLScKhqSq27U/gC6nz0239D1AcY48uqotVU?=
 =?us-ascii?Q?nor+c1D7UaaX7pSY/6Ov/c8IqkTY6d0dt9cBI1QpY1FL0RbOSYESsFo09GBX?=
 =?us-ascii?Q?y9086ygnxd8RFgtHl9HKUlnvFp3IK3WsFQYYGdVKEqBj0uEWGAW/vYtdezGy?=
 =?us-ascii?Q?cf7aWqLfAcOpKigkNG4AAi8XrJcobtcxB7E1ZNT37aYyKJmGHGKLekQ0xHW6?=
 =?us-ascii?Q?9Xa8djuG/Zb3Aootl4tq5IPGlfS1qCzq0GHLx13dOedwG61oAGYJJBcJ+Pa/?=
 =?us-ascii?Q?8+aNV7ZqNvxnysoooW65O0c4ChJMy9QL/uBGbDZG/Gn8muG9N4grHkO5XhLp?=
 =?us-ascii?Q?G2tKBJdT4eoLkcH+of89p6ND933m/B7d9XJF6IM469fiX+SRff3E08q6D352?=
 =?us-ascii?Q?ZgrG+2kSyc99dg67Ujx9G+maymhWfNvOVM4qspv7Eotz1VU54JnjKa0kC+Nv?=
 =?us-ascii?Q?4SxnezNeK2p2p3o059b6koo70X/0WfHsh5PvC9rOuZfPumL1oLq4DgCXmC+m?=
 =?us-ascii?Q?oVGoGk/FTxOpbqsOOMFx0mkNLzZdmJ6bnniRK7MoKjgF/+tghUXIETnZLooI?=
 =?us-ascii?Q?MSqaiJL7kVM4wYW0R7WCWnXcmA1K8Edm9JyQnzeNPN+lZLVJeBEP+YtXgFGI?=
 =?us-ascii?Q?Aq6dF2cDMEK2QqXLSzdhCuglv8rUhgTildIEs1ie3454X81ho2kV1Hkn9UKd?=
 =?us-ascii?Q?bfg6KqKxhRlg4WljNyjNRMaRK2C06gV4QID8swcqrie/O5kZjCECd/B0AkIX?=
 =?us-ascii?Q?82Oof8ZFh++GZNwAVI61hQkM4WLtO/2l8A3eqLuhICN0X446HFVjXF49Xi7O?=
 =?us-ascii?Q?OSeasPfqvIWu0dTLM8CdmDXFQ7GJHyUU5pJPt1OwyLq36auvtnTO16XcUPtt?=
 =?us-ascii?Q?LyZe6lf3AZGTdtAtZ5RXWOjiPD8RSTIcVzELrNwsoNmyV4o6QZqbui5GUkHm?=
 =?us-ascii?Q?X7aBKBAKtZSPYXQFBsvkA4mZI5Vi40urzSjIXobSFWbx4Th8dyLjZyMgnz55?=
 =?us-ascii?Q?tE9hZyBzJmcd4X4KZGkU72HsmCqclvLmlv/ECNaTelEyft3djpSmNBl8sBig?=
 =?us-ascii?Q?SeVmjymROqee+Ev0c5In0HiG+Ff7SknTrBKg5FQj+IaXAqZzrk/EFO5oNRw8?=
 =?us-ascii?Q?iqtSF63hpn2Tp9RdwAubfOsLwaLT3jEBhzL82Ox52kOuiG64f+N7bY3EE+xU?=
 =?us-ascii?Q?si9e0jUJYbM5n2hKTprchIBazGSZnFdQOEg9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqPl1doCtkif4a+T98U1f2RTEkuJHEsWi3s3p4mvm3k1IZHw0eyEJaIeIgi0?=
 =?us-ascii?Q?ehha2a5nSVE4UPelTbHjg7r0FHQ3yZdvhrPSrgRyETMaDXgWl6mCgqL6wZSm?=
 =?us-ascii?Q?xLf4M8B9/H8zBHjzfU+jjOPfA+XOH/Pn42Qbe4i4VizYQBKIQ41v31XgdUH1?=
 =?us-ascii?Q?e8zZG2mlA1KnPkXRbDXnQ1m7ZsX5EUFSIcFqGrnZxmdvaCMAyC0RhD6nzdEq?=
 =?us-ascii?Q?4jQwqLXjVqAU69QeVNS3mwCrdY+p2zEKiLUmm7ueTk7CACFLr+lngCOCmCbX?=
 =?us-ascii?Q?9oZGG2IHcfVG0j0NlfSJy1ys9/ycS4vi1l6pZLjeg8pfSgEL/nIcx6qJ0nqU?=
 =?us-ascii?Q?Pr7eJolUR9hD7B6/U/E32S6ANAXDMSQVG1kc4pR6IMlSaGCZZDQeJHIx2+BV?=
 =?us-ascii?Q?2zHPigbyc8d2KjYrABz66BFf9ift+BW8tmqCDzBALS/95hZXZ/WKQLt4ulyz?=
 =?us-ascii?Q?lTR/asPtzS4EA+vTWicgH+/QLc9isPVq7kLk1H5Bm1JxedYIoQKlJtwMKNpg?=
 =?us-ascii?Q?VAntJg70dNxLIY/TX3eOzBjXwF2gGxnAR7nBf512rdUhnRJ0IronOpK3xAac?=
 =?us-ascii?Q?q5qTe+j95rFzzi5gybPHuKLSqxGeYDfkP70fwr2PWf52qf7A7MyoCqb+GqfS?=
 =?us-ascii?Q?qWu76oiZwYfbz/ZnmoYhi0Ise08eL3Wn+h2n7IIYHNaRAo3i6OAmeqh1NoBF?=
 =?us-ascii?Q?Xbf0p3FgQewbnMuojBEUCfQ2837Cp+Un/cm35guo6Zb8rNlPDWhttMFPiqL3?=
 =?us-ascii?Q?+cY0kAnDSygoVXcQ5SoB7xY2jwxWHEOu3hEYnk47+l1OOy0w/sbyb+QSWbVl?=
 =?us-ascii?Q?bBdz2QCggr83UH4w2Sad3vvq+cNAhqa1pwSKyoexvZXCZOrBjNP/wyOwcKor?=
 =?us-ascii?Q?/OOL/INXZGZoq8WNBEMYG62++y5oPZw4ErrUb9lz/4yTMsP3sleol9TM/luM?=
 =?us-ascii?Q?dgmPavYghEuOBhKvkMfoaw5mhX3s59AI2YDS50UXvWnYQGeBfueDZlUcTmxi?=
 =?us-ascii?Q?3k4OV+gkQ2+KRRhgDnt/e4ki+b6IIKZ91+gC3/QnYA48xaC9T9llKxnBiFdg?=
 =?us-ascii?Q?MAxrbV07L6x3neS1D+3pChvZPBTOY1dcDAYnNT+KQYFuF9cb+r+RYApzGw6y?=
 =?us-ascii?Q?TNkiLbU5mSaLCQMYomA2GbofYPwiy5hfBsIEEcX5nhatMB05FdugvG435pvN?=
 =?us-ascii?Q?AqhmRt+XFcXTfSJnNhNTBCo9IkbX9SGqAN5xrfaVutZaDJEDnHInqCZ8KHiB?=
 =?us-ascii?Q?7Wel3GGjuUo7FwzJ45zBqco8BJ/f9zIS7XEcjYpDBI0kiAk/YLDGiL6eHh46?=
 =?us-ascii?Q?PekvnlU2TwLpts+qlYK2UmiVlhVgOGCmErvzLxOQJCFnfeK/cHdgpM/CalTU?=
 =?us-ascii?Q?jU/Dc04SwOv7RpiksJ9cMQMH2YiHqgxEGaoFkzmXm7UYhvmCb8UwRHqj0IeO?=
 =?us-ascii?Q?8LzxktQctRKk8te/kFFB2KrPCiDXkNcuHUVFePp2VJwIqmjDZlmlI5L3ZFW6?=
 =?us-ascii?Q?w4D2UWkL9S6imSY5RR7VeHzyxdvM8ObCzPBPPpn5jArAaWGSVdW+fnHzoblo?=
 =?us-ascii?Q?EaY9TTV6Vv+g3b36cUY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f22bc-69f6-4ec3-f9d4-08de31105706
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:32:18.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IULriJhaV50m/iTBBHvHiXjpVDWPriX/P6Z5DL307NCr1rglpUeBZHeRTitOKf9zn/KYrlprFcbBK/Qpz1h44w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10713

On Sun, Nov 30, 2025 at 01:03:43AM +0900, Koichiro Den wrote:
> Implement map_inbound() and unmap_inbound() for DesignWare endpoint
> controllers (Address Match mode). Allows subrange mappings within a BAR,
> enabling advanced endpoint functions such as NTB with offset-based
> windows.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 239 +++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  2 files changed, 212 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 19571ac2b961..3780a9bd6f79 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
...
>
> +static int dw_pcie_ep_set_bar_init(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				   struct pci_epf_bar *epf_bar)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	enum pci_epc_bar_type bar_type;
> +	int ret;
> +
> +	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
> +	switch (bar_type) {
> +	case BAR_FIXED:
> +		/*
> +		 * There is no need to write a BAR mask for a fixed BAR (except
> +		 * to write 1 to the LSB of the BAR mask register, to enable the
> +		 * BAR). Write the BAR mask regardless. (The fixed bits in the
> +		 * BAR mask register will be read-only anyway.)
> +		 */
> +		fallthrough;
> +	case BAR_PROGRAMMABLE:
> +		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
> +		break;
> +	case BAR_RESIZABLE:
> +		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		dev_err(pci->dev, "Invalid BAR type\n");
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

Create new patch for above code movement.

>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			      struct pci_epf_bar *epf_bar)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
> -	enum pci_epc_bar_type bar_type;
>  	int flags = epf_bar->flags;
>  	int ret, type;
>
> @@ -374,35 +429,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		 * When dynamically changing a BAR, skip writing the BAR reg, as
>  		 * that would clear the BAR's PCI address assigned by the host.
>  		 */
> -		goto config_atu;
> -	}
> -
> -	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
> -	switch (bar_type) {
> -	case BAR_FIXED:
> -		/*
> -		 * There is no need to write a BAR mask for a fixed BAR (except
> -		 * to write 1 to the LSB of the BAR mask register, to enable the
> -		 * BAR). Write the BAR mask regardless. (The fixed bits in the
> -		 * BAR mask register will be read-only anyway.)
> -		 */
> -		fallthrough;
> -	case BAR_PROGRAMMABLE:
> -		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
> -		break;
> -	case BAR_RESIZABLE:
> -		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		dev_err(pci->dev, "Invalid BAR type\n");
> -		break;
> +	} else {
> +		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
> +		if (ret)
> +			return ret;
>  	}
>
> -	if (ret)
> -		return ret;
> -
> -config_atu:
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		type = PCIE_ATU_TYPE_MEM;
>  	else
> @@ -488,6 +520,151 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>
...
> +
> +static int dw_pcie_ep_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				  struct pci_epf_bar *epf_bar, u64 offset)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	size_t size = epf_bar->size;
> +	int flags = epf_bar->flags;
> +	struct dw_pcie_ib_map *m;
> +	u64 base, pci_addr;
> +	int ret, type, win;
> +
> +	/*
> +	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
> +	 * 1 and 2 to form a 64-bit BAR.
> +	 */
> +	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
> +		return -EINVAL;
> +
> +	/*
> +	 * Certain EPF drivers dynamically change the physical address of a BAR
> +	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
> +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> +	 * host).
> +	 */
> +	if (epf_bar->phys_addr && ep->epf_bar[bar]) {
> +		/*
> +		 * We can only dynamically add a whole or partial mapping if the
> +		 * BAR flags do not differ from the existing configuration.
> +		 */
> +		if (ep->epf_bar[bar]->barno != bar ||
> +		    ep->epf_bar[bar]->flags != flags)
> +			return -EINVAL;
> +
> +		/*
> +		 * When dynamically changing a BAR, skip writing the BAR reg, as
> +		 * that would clear the BAR's PCI address assigned by the host.
> +		 */
> +	}
> +
> +	/*
> +	 * Skip programming the inbound translation if phys_addr is 0.
> +	 * In this case, the caller only intends to initialize the BAR.
> +	 */
> +	if (!epf_bar->phys_addr) {
> +		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
> +		ep->epf_bar[bar] = epf_bar;
> +		return ret;
> +	}
> +
> +	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar,
> +					    flags & PCI_BASE_ADDRESS_SPACE,
> +					    flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> +		type = PCIE_ATU_TYPE_MEM;
> +	else
> +		type = PCIE_ATU_TYPE_IO;
> +	pci_addr = base + offset;
> +
> +	/* Allocate an inbound iATU window */
> +	win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> +	if (win >= pci->num_ib_windows)
> +		return -ENOSPC;
> +
> +	/* Program address-match inbound iATU */
> +	ret = dw_pcie_prog_inbound_atu(pci, win, type,
> +				       epf_bar->phys_addr - pci->parent_bus_offset,
> +				       pci_addr, size);
> +	if (ret)
> +		return ret;
> +
> +	m = kzalloc(sizeof(*m), GFP_KERNEL);
> +	if (!m) {
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, win);
> +		return -ENOMEM;
> +	}

at least this should be above dw_pcie_prog_inbound_atu(). if return error
here, atu already prog.


> +	m->bar = bar;
> +	m->pci_addr = pci_addr;
> +	m->cpu_addr = epf_bar->phys_addr;
> +	m->size = size;
> +	m->index = win;
> +
> +	guard(spinlock_irqsave)(&ep->ib_map_lock);
> +	set_bit(win, ep->ib_window_map);
> +	list_add(&m->node, &ep->ib_map_list);
> +
> +	return 0;
> +}
> +
...
>
>  	INIT_LIST_HEAD(&ep->func_list);
> +	INIT_LIST_HEAD(&ep->ib_map_list);
> +	spin_lock_init(&ep->ib_map_lock);
>
>  	epc = devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 31685951a080..269a9fe0501f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -476,6 +476,8 @@ struct dw_pcie_ep {
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
> +	struct list_head	ib_map_list;
> +	spinlock_t		ib_map_lock;

need comments for lock

Frank
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> --
> 2.48.1
>

