Return-Path: <dmaengine+bounces-7460-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66CC9A567
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 489A14E3506
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F42F5A09;
	Tue,  2 Dec 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="G138ElTO"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011028.outbound.protection.outlook.com [40.107.74.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B01F151C;
	Tue,  2 Dec 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657343; cv=fail; b=WT0NgLsMsYplixI3Ed92aIPlW866tmGm8deexNPEdyOl3SdkhPa6Qdw2kJxHYUCYYoftVN0jSN1liSxD3oex61dCbYr9uW1hn3xL+KEnyocZzDEhinFfPyFhA+/PmnFK76sb2kj6ARxyTxuT04+4XETg+RDC6Za+6mJjt3sO9AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657343; c=relaxed/simple;
	bh=erc1Omy7xmw/caozCemCJw1bssGmCTMyHB2oMPTmlBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ayKpOIQVt5iVDOkdr8FUuZndrcoSpMcFoLy7Qk8lQgnEhCzz8Zk0Tf3rEMtx1nfFxgFalk+GaM8hXSZp0XPDy7XlI6sgHmB8Z+qk4vR9VeWroNnAWjmZVZ6tVfbRBxRxQzLDYYl3E2exbWs2DevfSPP3AmUyJoTrw4Gg8jqGQUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=G138ElTO; arc=fail smtp.client-ip=40.107.74.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtYXi4Rl3ilOE0r1ZO+F40j0e9jjqEGgPB2OzHDvAIvayKJTFr/HwEzoviE8OXArgoGu0u3Cl3pucW/8iipewrZIgdpwZPCoTGgSdmVMHwNEJqp99Hd/xl82ns/OlfhTNADWmCRdzhQQ32IkXGaT47AQ05TikD/7a8DiX0uUWlq9rkpJkRduEtrLG3hnzWQGSwS9L2OJAvJm/DrrUodTUR7o+y3wgKNDga5SPJ2mxYVyuC9LZyDfij9SqH9pzhM+2ZYKpbr903oojMj5HPTkbRsXRC8wgbvLWXykXPJSn3v479QzrOnrlfJL5p1OS+Q2ze4njRWCntQVkdW8+HaWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAPUNuaGGFJU0L0Wk9F5R2Etom/uK7KLIs0U5PKAOYU=;
 b=gcH+HkW0Ollh3ibIW57I/YR+XFE2FxIrdK8FbpBT9RnwPAA4AMiNLaLRNm2dKZ+rdJ2ymwvh0JfQSAjo8Y0UOzjK2uNjrg08BQvCsfqqBl04Skx4Bya8A/gnt+FU9j/77yfiPka24eek5NOyttOs4J2idMXlkmXbz854ABEDgdGlk6VCLTzxSjHLummkSsjKnRWunZMpRoMUZPMDIgO7rlblpsnVUl1+OclJlBiwkBEq9DmsSmRrrS4iswSuKYdqB5OWER3/uTNLEORDU2fOcEmmXLgAmhSqa2/4N6/R7zEOrppkTeO9X7f4mM7apy3SNFZ+hevE2ANyriUwP9Ni5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAPUNuaGGFJU0L0Wk9F5R2Etom/uK7KLIs0U5PKAOYU=;
 b=G138ElTO+Mk5kKJSXp0KcQlutv7Is/ntd3HUrdzWGRaKKDUw3MZlNyg7GDEdER2DdWHShXCrjwlPfm9DBcRQfZj59/B6N79OI1DzcxxmckXckmp7f6LLHSw5C5pNMCIyV22EcrA0jqG9QGDTVlwptKvAqVX7tycVLBaniqiZx7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY3P286MB2788.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:35:38 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:35:38 +0000
Date: Tue, 2 Dec 2025 15:35:36 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY3P286MB2788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1605a222-9d53-4e7c-2967-08de316d0172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oR7wAyOlhkPC4MCBHg/41+pbdUVYvPjEaDp3lXZ184eRUUWyISeQe/sKN0ug?=
 =?us-ascii?Q?4Tsch90PAdbHNB8i5FATK/4JYvCbTC5sC28WhPyNf4iMk9nVzZDM4HMoSQg3?=
 =?us-ascii?Q?/qwBBlgOySzyuMJYX58slwhcwG8i26pZLDRs/oukY/LlISU7X4Hicnqp+ij3?=
 =?us-ascii?Q?qhpEt7iNhco8qtCTZdUfD2Gcyznaj86rt9hYNyQruqFVPli4hA4sPfEJ0S/d?=
 =?us-ascii?Q?69AmO7sXdtE1vY4eMr+oealqSGqzaFhCT7gZodwdajYRvCSqD6HDwYN+fVg1?=
 =?us-ascii?Q?RXQ6E2NWHswulF+El+g8iVVve+NAwHySyZXj8hGZ6TQcWlvFTnOlXvx9DG0h?=
 =?us-ascii?Q?lGl0fgTDSJv388xNEaXjV0ZI1bKH6t6Ks3rtf0nadiSPQNx/niWngZiCtALh?=
 =?us-ascii?Q?5EOLZafstawLHm7PnmvcmK5vE5hhjJeb1pf3ubPSOoy9qFM/32JnMLg8kC8D?=
 =?us-ascii?Q?mz5MC3pquUUZI36+vqIxWWZ5Td6Pcscc1YU9UrZnBt7p4P/aBVPtcF5w9jtc?=
 =?us-ascii?Q?9U+3Yg0yAiPVX85Bn/djKZrh/M3mDiYNMGVTfmJIAtISddEmP5knOL0EElrT?=
 =?us-ascii?Q?MA8OnFqh4OhnqYp8ytXBHBHfzvW/lW76KbeAVdgTqBtvCOCSypAhIlYwke5G?=
 =?us-ascii?Q?J5WuocILv/uPK7PjnA7SqtxtR6a9ULnmDHxXhOJhmLKBRpNCKF4cZMxRtuGO?=
 =?us-ascii?Q?SR4pyO+IcMaqY2x8bOnHOu//3C5tt7nFzE/I9uJpeeefelqNpFXj3GXiR6n2?=
 =?us-ascii?Q?U1O777bzzC1l57SIgGk67AvBCvBbua3hb4+9OsSw8jQzA5BDyNdax85WU8yL?=
 =?us-ascii?Q?UIsG+sHLfA3zGnabAY7OVxzWY9RFFhfEV703L5t3X++1DNM9Zru/XduFVWy7?=
 =?us-ascii?Q?KdrOaHMf+MfNbCIkwndLNI58qM4w3TnQIjB0yNAypgh71MtxEk8QrEU3H+qW?=
 =?us-ascii?Q?qrqSaql51o+TA9iJAHq13aqYTTPjIjxoKrm9ExC6myQDIhCW7sgDtYNIZDuc?=
 =?us-ascii?Q?tA3A9QAchqiRgKTuQqcL4ZhIMOLqBbPlSJu8FH9J/Ir6UvgfLk82MtOhBtBJ?=
 =?us-ascii?Q?78anqRZojbUXyR+0iamKlZAWBZzSYYsPM5oK0s9VYw5hCFV/etvrGc8wrbpo?=
 =?us-ascii?Q?WHmjgpaIejiwhtXnofQJno1aUy2vwS1LI1yZMu7qGDAFCQRQ5RYSeKi6wwPS?=
 =?us-ascii?Q?UTqy8Eo8564kk6aUiCtET0L3xKUr3OHl54aTpCiVA7ABFvjDY4IFi921zkGh?=
 =?us-ascii?Q?jwg0xZ/yQW18jpD2Yj/BMcfVoiQAXo0YKwVqO1PCt+UxQ6XMcfPXxf3yDNz/?=
 =?us-ascii?Q?/PBwrZAkt0/v0LwG5t2wCbu8sC0BaSps7Xg5NLDHbdrUrir3DIPgXMTHqKYZ?=
 =?us-ascii?Q?wsrOnTjjTfm0bhqQFoterDdUv4GNJbrkqI3lTIcIY3oUotmSng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qd+fv9ve/2GrWCf1vfNNjjhEsy7+tHxLvYxgZfakvAsnvbpcVv8OFhJjt7n7?=
 =?us-ascii?Q?yshliNE82mohUHIQnHOQEZxmdLostO5nDnZlGta0G32rZnC3FQz4/gTjDCIR?=
 =?us-ascii?Q?5YcTIVsRiYbKh0vYU/J6LkrwX4u5UZz37X7kXwVUC49P2dA22hAK9+KMfUI6?=
 =?us-ascii?Q?h+YHwJ7BzNMlw+Wh84LiyMSQqFgqTC82hMWJpxlj1w4mRJYjse/ZC3uBtV8o?=
 =?us-ascii?Q?9YI7b82youkNQF8X/3rVNmeRPITkXcEafzv7axpgK8LJRB/x6QY103K6JC/H?=
 =?us-ascii?Q?bNOdiOnMhzB2/YOdgLUxwX8A6aEqM0JlwWHXtWxenJALjkIDgNICDIBlKHgy?=
 =?us-ascii?Q?4bp/uivCPh6G4tz7MRPP1JMInnGTNw7RKqGIIlyla1szbHYUUO5uVW6ZglWa?=
 =?us-ascii?Q?Jj6pQjcDggBYYJw6BzgVis8tluMv8eIqbQSeG2zLWqi+a1mIzkBQeKCshxj6?=
 =?us-ascii?Q?Bkck3/Oz24fn3VqOMtapgG0rOki3BfcX4V9unRI/Rz1swDzsQPCDWRF/Np52?=
 =?us-ascii?Q?m0n+OSnHTjPrDkLcQ13t7RCM2mmd0UQ7wCj3f8Y6BMkqjjZeoEciHWyH4IVb?=
 =?us-ascii?Q?L8GbeKrw0pxduM0/16MVkeqt7x/G7oqi3xaakbf15g/wWSROEolhbCdj3EP5?=
 =?us-ascii?Q?mf1JoM9HRg/VB9PVazs8PEGQ4guwJPbzH0T98pN4QFaDYHo9ZugX2i6VYCyE?=
 =?us-ascii?Q?bZCOhstNXc7YO6OAWxI8588ZjGfaqr/Jr0EmOKtt+X++1lWX86dwDWQJZSWK?=
 =?us-ascii?Q?syuxkarcQ9LvDH3VuF40ZYCy9VAk+cwJBs7ctEx19CLNlULVgAskOqY1Zg8R?=
 =?us-ascii?Q?riSyeiopinBpcr4Fd8cIujFxrCEQbkCvvCNbkqhFEzYTbSN/EbqpHHiwzDQF?=
 =?us-ascii?Q?tlZO9atiznd+LnGCrEdKhyfv0rFvIP84OCGURkRpNeKgj/S6doApvdxr6S99?=
 =?us-ascii?Q?l2QygK7NbUCkQyDZbTCT2Uw9uep6nf1kLcUHNuedUFnA+Uf//8EHzM3qjgtm?=
 =?us-ascii?Q?S/w4hAkFMs9Auq01ijpH66VhAw8m/fNFqo6hCLq0ny6+e84Qrlz2GvEEh46k?=
 =?us-ascii?Q?nJG2MY4f0EOPzZgxjlIgMdnGPvRa2YkJqmLsL1yPh1E7CO1JXqFklM9WOGKY?=
 =?us-ascii?Q?7i8tfJfsF4pXmI6puxyhNRRwaS8fS+YgDsPygjUZXE+lHKEIALTAeXeCNhda?=
 =?us-ascii?Q?lsUsP0HSPs9E/KRESg053r33moCXrn1YdKhN+VfYrkK9nJSrLM/7CPLd301C?=
 =?us-ascii?Q?pAznowSDkqnF6RuDZy/Elr4L1bIrNlss26rVLGEuGp0iOW5D6mnaCxhLApMg?=
 =?us-ascii?Q?wxkooOQT0KxKAizlzfM/62ir0cNOkiIGY056RBan4zSPL3EYp634bitz+/m3?=
 =?us-ascii?Q?krhXVJNpTmaF6HnscUmwZg8EFw7PaaNvBKokbcLDN4ekHz1hCN9+GfAU/qBg?=
 =?us-ascii?Q?wN0TklDxzfCeMp9uZIgIl/JtADm71QrEhgdgwp4gx5rKOU8vMcrjYVhrISGe?=
 =?us-ascii?Q?JR6TZyxUGqYMS1z2xuc8uKrpfBpzJ4Y/1Zl0zbR1Ev87Oli339VorpJKbouz?=
 =?us-ascii?Q?pCFC62yNiRFpbEUs07GqaiMwRychX8eb+CHGf5vD3LtD4Wj7LuxWOKg3HprE?=
 =?us-ascii?Q?ZYJjK622agUhzhHTSO3oToA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1605a222-9d53-4e7c-2967-08de316d0172
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:35:38.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Imnym8JK98ErYpiNqIpPrRVBBoWz371Z9lM3khGv/yT+aBBFf/CBP2V3fkCZmAbg0Bz4/5vtaS4BvaffllD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2788

On Mon, Dec 01, 2025 at 03:41:38PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > for the MSI target address on every interrupt and tears it down again
> > via dw_pcie_ep_unmap_addr().
> >
> > On systems that heavily use the AXI bridge interface (for example when
> > the integrated eDMA engine is active), this means the outbound iATU
> > registers are updated while traffic is in flight. The DesignWare
> > endpoint spec warns that updating iATU registers in this situation is
> > not supported, and the behavior is undefined.
> >
> > Under high MSI and eDMA load this pattern results in occasional bogus
> > outbound transactions and IOMMU faults such as:
> >
> >   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> >
> 
> I agree needn't map/unmap MSI every time. But I think there should be
> logic problem behind this. IOMMU report error means page table already
> removed, but you still try to access it after that. You'd better find where
> access MSI memory after dw_pcie_ep_unmap_addr().

I don't see any other callers that access the MSI region after
dw_pcie_ep_unmap_addr(), but I might be missing something. Also, even if I
serialize dw_pcie_ep_raise_msi_irq() invocations, the problem still
appears.

A couple of details I forgot to describe in the commit message:
(1). The IOMMU error is only reported on the RC side.
(2). Sometimes there is no IOMMU error printed and the board just freezes (becomes unresponsive).

The faulting iova is 0xfe000000. The iova 0xfe000000 is the base of
"addr_space" for R-Car S4 in EP mode:
https://github.com/jonmason/ntb/blob/68113d260674/arch/arm64/boot/dts/renesas/r8a779f0.dtsi#L847

So it looks like the EP sometimes issue MWr at "addr_space" base (offset 0),
the RC forwards it to its IOMMU (IPMMUHC) and that faults. My working theory
is that when the iATU registers are updated under heavy DMA load, the DAR of
some in-flight transfer can get corrupted to 0xfe000000. That would match one
possible symptom of the undefined behaviour that the DW EPC spec warns about
when changing iATU configuration under load.

-Koichiro

> 
> dw_pcie_ep_unmap_addr() use writel(), which use dma_dmb() before change
> register, previous write should be completed before write ATU register.
> 
> Frank
> 
> > followed by the system becoming unresponsive. This is the actual output
> > observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
> >
> > There is no need to reprogram the iATU region used for MSI on every
> > interrupt. The host-provided MSI address is stable while MSI is enabled,
> > and the endpoint driver already dedicates a scratch buffer for MSI
> > generation.
> >
> > Cache the aligned MSI address and map size, program the outbound iATU
> > once, and keep the window enabled. Subsequent interrupts only perform a
> > write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> > the hot path and fixing the lockups seen under load.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
> >  drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
> >  2 files changed, 47 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 3780a9bd6f79..ef8ded34d9ab 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -778,6 +778,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >
> > +	/*
> > +	 * Tear down the dedicated outbound window used for MSI
> > +	 * generation. This avoids leaking an iATU window across
> > +	 * endpoint stop/start cycles.
> > +	 */
> > +	if (ep->msi_iatu_mapped) {
> > +		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> > +		ep->msi_iatu_mapped = false;
> > +	}
> > +
> >  	dw_pcie_stop_link(pci);
> >  }
> >
> > @@ -881,14 +891,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> >
> >  	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> > -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  map_size);
> > -	if (ret)
> > -		return ret;
> >
> > -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> > +	/*
> > +	 * Program the outbound iATU once and keep it enabled.
> > +	 *
> > +	 * The spec warns that updating iATU registers while there are
> > +	 * operations in flight on the AXI bridge interface is not
> > +	 * supported, so we avoid reprogramming the region on every MSI,
> > +	 * specifically unmapping immediately after writel().
> > +	 */
> > +	if (!ep->msi_iatu_mapped) {
> > +		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> > +					  ep->msi_mem_phys, msg_addr,
> > +					  map_size);
> > +		if (ret)
> > +			return ret;
> >
> > -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> > +		ep->msi_iatu_mapped = true;
> > +		ep->msi_msg_addr = msg_addr;
> > +		ep->msi_map_size = map_size;
> > +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> > +				ep->msi_map_size != map_size)) {
> > +		/*
> > +		 * The host changed the MSI target address or the required
> > +		 * mapping size. Reprogramming the iATU at runtime is unsafe
> > +		 * on this controller, so bail out instead of trying to update
> > +		 * the existing region.
> > +		 */
> > +		return -EINVAL;
> > +	}
> > +
> > +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> >
> >  	return 0;
> >  }
> > @@ -1268,6 +1301,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	INIT_LIST_HEAD(&ep->func_list);
> >  	INIT_LIST_HEAD(&ep->ib_map_list);
> >  	spin_lock_init(&ep->ib_map_lock);
> > +	ep->msi_iatu_mapped = false;
> > +	ep->msi_msg_addr = 0;
> > +	ep->msi_map_size = 0;
> >
> >  	epc = devm_pci_epc_create(dev, &epc_ops);
> >  	if (IS_ERR(epc)) {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 269a9fe0501f..1770a2318557 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -481,6 +481,11 @@ struct dw_pcie_ep {
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > +
> > +	/* MSI outbound iATU state */
> > +	bool			msi_iatu_mapped;
> > +	u64			msi_msg_addr;
> > +	size_t			msi_map_size;
> >  };
> >
> >  struct dw_pcie_ops {
> > --
> > 2.48.1
> >

