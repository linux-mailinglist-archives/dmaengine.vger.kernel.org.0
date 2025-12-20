Return-Path: <dmaengine+bounces-7851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9FCD3220
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCB330124E2
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AC26F2B6;
	Sat, 20 Dec 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="muaGmDsU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011053.outbound.protection.outlook.com [52.101.125.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17E21C9E5;
	Sat, 20 Dec 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244578; cv=fail; b=GxOdEvfF6VenSgJUzqXQYMuCXPZb4ooWtO0Ea6BhqoKaMpwGdXwdAZ9WuszDaZ+h2AFES+OA3TFYbhSnRxt4oLZ3Ij6IdmInHIQE/hf/zGNcMKWW5ngkqkuCZYYO7KMMpZQyDCZZ/dTAtxwqd4DetHZ75/jzRRfcU0Bb40psh4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244578; c=relaxed/simple;
	bh=tZP+iCM1gZMjS3h9pegcJ5T4L/ORvSNojTASEI5VGrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qM9v0cp32RbO1DBGtO3/R6c22urZ8qfigOfd4/XEIhqox8oDqDiMpHizuBJf+l40tx7fii6PUZqArHn18Ye5wLYCKbdqZLaZXTHAHllPa6JF2LL5Hf8NeLu9/WVXo3VQZ6XlvPN3qKyq6zNf2+I+h1GKWYyfbl5exBv8RMsA04c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=muaGmDsU; arc=fail smtp.client-ip=52.101.125.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSNi1gN4DJUaA4RU+4en7HLQxjBczeuotQJEPGlgk0Ez2nIgcwtvZKu2skY4GoCmSxGdMz0AM8zmoCUihmFPAFK2eSrsgCDO26YumSkxM2K9IaWLY/BEen/9i8TGixziWrREH2FuJKIaBKz9xgHABFYqv2cmox5Gk+UhjmmmX5tp9mTYDlbqvSkdOUXyMbo0IkdUrdL/x6UZiq7Z64ft9AclF1X/xgaBfYEjKH+8Op1HCvL+8qup0JVU4KcFyB+1gaWlFuv/rxnLhQIAWg3+CMXr/0V+ZMxKjTUef8WKFki1dFD/O18gwt+ZKGPxORxWMDlGizX6CPri34cDF1Q+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9QE+Z+8G3aAokNVwdOyebHDotT920vlNBicaeHmcV4=;
 b=MDql1YLldRiczVyQIgW6bzJZCDeHLX4tizTSYD7A/TBV6D1hO7cTf76fMMAW9SNCeOdgUDcRJIxVhRULLBo6HA1P6v16TUXiLYD4HlC8Akyx9yiOjxjV0VKAQkGCUSxpzig5sb1g/mzF7L+4xmlW++BeuLiAArfSwYCKfx1KgP6JNy3lpeH5aC/JRHmyFgZ+KPFfwUqWg7pOuQDxLMSiRP6qJq4DqreJRNoS3Q/M+rAbFxAYv0DcPO4+mBGh6GlXx4YUPCM+XkIaq1KAKpg3ArbbucFkYJBlu+qZsuw5a79S2nJLD4TwmOFFmN/7jXDZnFUrqmTd9n8/XiiWJ7RGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9QE+Z+8G3aAokNVwdOyebHDotT920vlNBicaeHmcV4=;
 b=muaGmDsUP2hklDOmWrCQ7PWU7Ey0xRavbqLUA27/h/rHTrxVMcYsXbtksBfA9YiJsrntdTKUf61U0LL0+grSSR965N0oYbhb9Ajb/f+PsFPFEfua1p9jFCcKLWYMuesyVGHp7KjjXpSnmMSEZ89NGWX75z9CffW0StTkB9Z7RTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5180.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 15:29:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c%7]) with mapi id 15.20.9434.001; Sat, 20 Dec 2025
 15:29:34 +0000
Date: Sun, 21 Dec 2025 00:29:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com, 
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 13/35] NTB: ntb_transport: Introduce get_dma_dev()
 helper
Message-ID: <hhjc6h3fab3c6a3jc7z6j46wrbreh4pwrwya5gndxlsjpcv76x@2axrgpzkmpin>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-14-den@valinux.co.jp>
 <aUVhr33M86WCAIqZ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVhr33M86WCAIqZ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0c4522-55cb-4ad3-c36d-08de3fdc942c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?doyCOnQbmiTbwSyvgm22HD5mGtNSPPezdjl2Z/t4IePH224QOB0G2RUYXXK9?=
 =?us-ascii?Q?o092NmI02dBTiFagG4y4JZ4p7Z6zCU3XGc5IXxIPtUdOcR7ganpaCE334RjV?=
 =?us-ascii?Q?R5mWQETUOOAcu4vDf4JGaokVjv6peqsYLVBN/WC5QTa/6SoR0KuwUBnV2x6J?=
 =?us-ascii?Q?VO6fjrngJQjDpAe4Kv+WKYxBPn/zF+80IWvEiBKFb8RdjOcdoriDgellIPkw?=
 =?us-ascii?Q?mu1nq1PgptEuh1OGQ8lxua5yvTsFlzVKunYA9I6lrXRe0+MxRvzJuD6Kg/B/?=
 =?us-ascii?Q?GO667+5YS7Db9ePBP5+OVYR21rE1qtfxCiafOinQET9cGfSwVncUIloCWXoq?=
 =?us-ascii?Q?wjLNsVjh/txJ4RLWLPJZbWbnZw9pwJ0oQq3NN8YvcUNgALUpOMViR9aD5FIG?=
 =?us-ascii?Q?F2NkW33+jMg2C916C/ez0oPsp3fo7f6K/dmwuKJOoTRIxlm6/ZreW1FtnS0E?=
 =?us-ascii?Q?HxU7E8UqSiFlP+fyNZo9+87npOM9ss+/gFx0Zi6jpXgqXmnA9CsQXZiWSjgK?=
 =?us-ascii?Q?u+dOJLrIzPE9wEL2kQpebWwrD+OfGJFP8iTgL/tExvxA3t/XoSMc7fco2JMh?=
 =?us-ascii?Q?xm6G5zX4ucON+iqQd7n40OTDt9sBgB+MOWnnEiQHwrJp+s29Yuq2ZWhUXFSA?=
 =?us-ascii?Q?aWVBWcFdmRW9AP8xQHweGnAkQlWgu8qI2Vx3Rh5nYYTlvYipWlTto71IgeL2?=
 =?us-ascii?Q?+Qk2dmlJfeiMXkqIKsUknpxV1EhDnpi2BcwddKF8ilRS5WeDu+QB+584UUMe?=
 =?us-ascii?Q?g3zoijCOVd8LS0xewfbGfPajFfASY4Ayhn5+fcLR44TCCihMmay/D07z6kD/?=
 =?us-ascii?Q?4SqtRQzjnmiHRrVg+yfU3wCjfdka1bgHfoOvTWGA8zevWq93S9k+2NEN7LP8?=
 =?us-ascii?Q?WT0j4RxAXQdy8KsvXrsAeqeRiqyE/WxeLY6qy56AYb1hhC5KZDBQThP/luno?=
 =?us-ascii?Q?79LjmNnkTmIyihbC0QVDJVRIN+nTVKkLP1hbDYpr0ML1/kbUYQTYmw8zqZv3?=
 =?us-ascii?Q?RjxOUEwzCL6pZoJ/yMJUeZN1sH1slwPvLO0u1SuoiSm2OG3Yz4fbzMENqhyN?=
 =?us-ascii?Q?LDniPxfc2vqfwJBOXmlOu++sOb1x0hULrCZIC4WSF/Guy4tfRuW5pMauvIQl?=
 =?us-ascii?Q?Erj2VA2OlTntLOWRDiyHSAjDsaupfJNwgAeV7YYcSohSaB3xr55NONXKHiHb?=
 =?us-ascii?Q?3E27o3DsKa+GiKgrVsc6etorblH/4mQiZuBk3RFD5MyaXzHlwWVLiaMcZUqx?=
 =?us-ascii?Q?tzHyLWuQWheUN7Jlm3fZakptIaJrgxcvfRooQtBMgMhbmK/l0QQeUykCwwo1?=
 =?us-ascii?Q?MDi9VXKV7IhYnOb6WjPCKUzKSaH0UH5JJftqMHmhHJfgLg8gfIBLzcNs06h7?=
 =?us-ascii?Q?FmDlbyNaqRdjKDt8XMxM0pXG1glTJ6j2PJLOuN32BF1nxYpwaVSQnbma5VdJ?=
 =?us-ascii?Q?poWz9rky1PWGXvgXISDFvhGUkhMIWaIN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mp6IzxY+ZcxqrZKIakyK6BCuZBLAQ70lVWjfuFYEdLZ30WSZ9YB55O9eGJ+0?=
 =?us-ascii?Q?9F9VEl8K1J7C7Lu5g+72iTtSkQKRXsRTEsWP/trjWpo+kiHOs7rHzUij8aKs?=
 =?us-ascii?Q?sSIyaaxkyPcAOnEq3tdM2NdQAX+Dj3kgqyMPmgiIat00HqwC/NsMAEuIsZ+4?=
 =?us-ascii?Q?8g+7Zl1+0bcOiRJHgVf008oe/Q+i4nKxT5OYzISnyRoozVMZXDO0j3P3bmgN?=
 =?us-ascii?Q?Qmno3c/P5utZAY9VCc7ft3IsDB2aIaUBsJoJt4bt88q1JIvR8tdZPbHxONeg?=
 =?us-ascii?Q?C0iiCKPAq+C7Ogkqw02LTvm0GdCYBiY8Tv6+hGFRpsEZA2ZOU8fUnyUojI+L?=
 =?us-ascii?Q?OFox7cJzeN8pDPICwacz2itMfWZhxHTwbXHazlT818pH7vS1giGzhmh8B9yb?=
 =?us-ascii?Q?cj5yxwkW/F9V5tAnd3OWD4yHFwpuohh6nHh3+JhUVNqtM58JnDndIOMzyE5v?=
 =?us-ascii?Q?DjxoihXl/keAchCsI5rWY3ynmpKkbQgxpqqjs0iH/O0RAF6TF0qxQlexh1a0?=
 =?us-ascii?Q?Py7CAa/LuVL4pQVmeD+DtfptcecncYLR987/qbE0C0BpogsVZFbxgL6ItAE+?=
 =?us-ascii?Q?og83n/vPHMYPj7z1/9uOTe7gPTlvNHqoe4dxd/X0aMWYBHBDWG7LJa0qKJ0Y?=
 =?us-ascii?Q?T2hEv9jzWyXVnmWqSywFDgFuDWa5ys29FROGCFWs0c0uhI699M8Bu3nwShhM?=
 =?us-ascii?Q?45MQJEukuPOXO8ZuXAsqKv9FAtgzgxf5ZKkAqz+VO5uwqum9O6OoDq72jZZQ?=
 =?us-ascii?Q?0OcVzrkwCA8zr29F3ID62KhhmD4efHLVrAMu08T/t+MW7q1wiXcxt97mpKPJ?=
 =?us-ascii?Q?XRVu2SXIRQBmBlWdXTOaEQ11a5+OUkOTshzHJVcmL6AkRvjAX/AUU/4p9zW/?=
 =?us-ascii?Q?QKOXdmhj/Wdjsiyc/OH0pxlOptG077LhbtfdnOSuDYkb/1Jb5EbJXjFt/fMb?=
 =?us-ascii?Q?Usxs+wud5f1FMBhNf0NwRf/bunTkWs/zPocmKGSQqLd1b6sv/xovXtbl9Gr/?=
 =?us-ascii?Q?+gpMMcGz5tBFeM06DPDY5W3KgDYHIL0kDbIWaKtmfAR5oL0uMB9VrbfHFfd/?=
 =?us-ascii?Q?/wg2ziYRDcPEyRH8oDdjT7dYPHFnsFXJEiSmZh3XYKDIFP4c2jY5Kh2422H2?=
 =?us-ascii?Q?NpQC+lnKA9IkgVBVIZRmyOHshoaaiPgUtMmtOD8y1NARxWs/3LeLTRASUQ2r?=
 =?us-ascii?Q?sQJ6cUKco+oN4BE1JIi6aKxCEMP+fbbltSG3eD9r9kdl6A1MJfTwWTNGSzFV?=
 =?us-ascii?Q?w0uB2m243nQXNNHMdYsK5/8ORuV/r8ohlTHsc6wk1p9bli4IJjwyDGlHyYh/?=
 =?us-ascii?Q?QnVKli6PJ66Df8q8oa16o652Nz7800yghVAgDKyY4ey5oBEbIAS63HFr9+4Z?=
 =?us-ascii?Q?NU8Zk3sugACZZ4bH5SJ2OvmK7fRbW2ApF4JkIjvw6FcsLOsOTBxLhxiowcCq?=
 =?us-ascii?Q?fRTiMeZkfTllFghXsFC2BgKg6i5Bvatai6j/2heYSZuinI/pbjDxkJYxolC4?=
 =?us-ascii?Q?qxS9mm1QNAZwaWeMBzArLVCp1CBVz41dGRDwuk+kJgggvKJ/nkGc9wo5F5Mr?=
 =?us-ascii?Q?pr4lc8sJaSriR/eBGVBKUgedxYPXytpWzv2w+N6Stwp1Uzu0UCqI4i/c+AZB?=
 =?us-ascii?Q?lITpMIGjysewqdNQVDlhI8GEHEUAbrxxDTpO6U4SSN+g9gZ5dQkrLfNwnmCo?=
 =?us-ascii?Q?7+S/r+L1DrHQpkwdIGgBRgyfenkFI28dRMUlgQ/EAWSWquq+JflEr3Ixqitx?=
 =?us-ascii?Q?GwwB3D1c5cDvqXJ99ytK+6aZ5U4g1a8EbvbIl7w3frgrEG3nrCDJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0c4522-55cb-4ad3-c36d-08de3fdc942c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 15:29:34.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yqmb51y3XN2z8tu4Op38oaoL9+JRfGykTxGiJTw8JO7EmZXK5VNieL50WB9sb/9SFF9QEovmMQ+6huLMl3auHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5180

On Fri, Dec 19, 2025 at 09:31:11AM -0500, Frank Li wrote:
> On Thu, Dec 18, 2025 at 12:15:47AM +0900, Koichiro Den wrote:
> > When ntb_transport is used on top of an endpoint function (EPF) NTB
> > implementation, DMA mappings should be associated with the underlying
> > PCIe controller device rather than the virtual NTB PCI function. This
> > matters for IOMMU configuration and DMA mask validation.
> >
> > Add a small helper, get_dma_dev(), that returns the appropriate struct
> > device for DMA mapping, i.e. &pdev->dev for a regular NTB host bridge
> > and the EPC parent device for EPF-based NTB endpoints. Use it in the
> > places where we set up DMA mappings or log DMA-related errors.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 35 ++++++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index bac842177b55..78d0469edbcc 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -63,6 +63,7 @@
> >  #include <linux/mutex.h>
> >  #include "linux/ntb.h"
> >  #include "linux/ntb_transport.h"
> > +#include <linux/pci-epc.h>
> >
> >  #define NTB_TRANSPORT_VERSION	4
> >  #define NTB_TRANSPORT_VER	"4"
> > @@ -259,6 +260,26 @@ struct ntb_payload_header {
> >  	unsigned int flags;
> >  };
> >
> > +/*
> > + * Return the device that should be used for DMA mapping.
> > + *
> > + * On RC, this is simply &pdev->dev.
> > + * On EPF-backed NTB endpoints, use the EPC parent device so that
> > + * DMA capabilities and IOMMU configuration are taken from the
> > + * controller rather than the virtual NTB PCI function.
> > + */
> > +static struct device *get_dma_dev(struct ntb_dev *ndev)
> > +{
> > +	struct device *dev = &ndev->pdev->dev;
> > +	struct pci_epc *epc;
> > +
> > +	epc = (struct pci_epc *)ntb_get_private_data(ndev);
> > +	if (epc)
> > +		dev = epc->dev.parent;
> > +
> > +	return dev;
> > +}
> > +
> 
> I think add callback .get_dma_dev() directly. So vntb epf driver to provide
> a implement. The file is common for all ntb transfer, should not include
> ntb lower driver's specific implmentatin.

That makes sense, thanks for pointing that out.

Koichiro

> 
> Frank
> 
> >  enum {
> >  	VERSION = 0,
> >  	QP_LINKS,
> > @@ -771,13 +792,13 @@ static void ntb_transport_msi_desc_changed(void *data)
> >  static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
> >  {
> >  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> > -	struct pci_dev *pdev = nt->ndev->pdev;
> > +	struct device *dev = get_dma_dev(nt->ndev);
> >
> >  	if (!mw->virt_addr)
> >  		return;
> >
> >  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> > -	dma_free_coherent(&pdev->dev, mw->alloc_size,
> > +	dma_free_coherent(dev, mw->alloc_size,
> >  			  mw->alloc_addr, mw->dma_addr);
> >  	mw->xlat_size = 0;
> >  	mw->buff_size = 0;
> > @@ -847,7 +868,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
> >  		      resource_size_t size)
> >  {
> >  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> > -	struct pci_dev *pdev = nt->ndev->pdev;
> > +	struct device *dev = get_dma_dev(nt->ndev);
> >  	size_t xlat_size, buff_size;
> >  	resource_size_t xlat_align;
> >  	resource_size_t xlat_align_size;
> > @@ -877,12 +898,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
> >  	mw->buff_size = buff_size;
> >  	mw->alloc_size = buff_size;
> >
> > -	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> > +	rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
> >  	if (rc) {
> >  		mw->alloc_size *= 2;
> > -		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
> > +		rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
> >  		if (rc) {
> > -			dev_err(&pdev->dev,
> > +			dev_err(dev,
> >  				"Unable to alloc aligned MW buff\n");
> >  			mw->xlat_size = 0;
> >  			mw->buff_size = 0;
> > @@ -895,7 +916,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
> >  	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
> >  			      mw->xlat_size, offset);
> >  	if (rc) {
> > -		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
> > +		dev_err(dev, "Unable to set mw%d translation", num_mw);
> >  		ntb_free_mw(nt, num_mw);
> >  		return -EIO;
> >  	}
> > --
> > 2.51.0
> >

