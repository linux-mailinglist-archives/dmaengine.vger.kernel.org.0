Return-Path: <dmaengine+bounces-8744-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CORkDk2hg2kLqQMAu9opvQ
	(envelope-from <dmaengine+bounces-8744-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 20:43:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD84EC2BF
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 20:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998B6301BC1A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C94218A4;
	Wed,  4 Feb 2026 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nsWjM12z"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B434FF41;
	Wed,  4 Feb 2026 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233955; cv=fail; b=B8HrA1CcO2qqe6l3++jmhxtweMqqAuzl2MRxz1HDuSMKE24CbzJmoRAt9oKqKe3ChJVionIK0qovxtW7LlDJCp6BGd2Dc7DnT8azg5HcchhtJco2P4TcIRhK4OQieTQiS4H6ea96XrhRGfDJHUXrlsJ+mIHe8k/PXxI1PvF3w38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233955; c=relaxed/simple;
	bh=zNz+Bpw+q3biKlc84sIYAbpxiLXdiYK0a1QARXpwU6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n2inlSqX1c4P20eZu/+w58RKNpQFxssl/4JUSdrYSbCcgqaFBOqaF73jXQKGZPK+Rj5J8KgR1VSxuxJeits7KY3iH2z0/Z+06aKmuOOWARG6FAAWPEn+TDcxXqtnqXwhCZep4DSv/DWvvduMwjslAAajVshcroewMyYNbRyztco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nsWjM12z; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+q5b1ZklRHoaRVEp09JaXIBXYSb6ZmHpCd75D1+kW1U4QHo3jsXucxEFwyoU89Cjhz+AQ6PhnQol9PX7rDcBQwubp+lJqkNFH1865umZZy7NK5HLVUQ7X45kCb2DgJ/4f+NbZmxvqASg7AKfTQvnS50dBEljF/cblQDpzGyUakF2Uq5YJtis0NwPqaE67A0H7f8n9EGj+Z/y1f2+vFGZRca+hdfW7orr2BCHc7KgZYjUigPyCtAg1V955pVFfF7AP8a2qmhapuvqTzZusCd8JptoItVRsI4qFQ8noyp3EsE7TJontz36AmjB1Ux12FHqrf6exfQz/wUh6NAYuk/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMvxqBESayxhOil8JsxYTdWdnhTRrzh9uf/gPp5i3M8=;
 b=czrAtJ5RwoQsMf2vxXrocqaYJtcQKB8e+rPivHDLhegwyGbbimg8sdBF6tXYL1UM7x9Zp7iR3H6uuis6Le86Kn/bsPFAM+V1QwDtr4ojSnBxpWgt8I9qHhK8F2SHi3MxpMeBc0djqs6wHdE7Ms4hZIiUnHYjYXbHNSIvojOx2f3tpiru3GJFB6Vh3eb5DQhQWpRssSj49WIii6L6G9qNvnRW2lsLJtQA7XyM5rtCOHsrHe2SX0RmlnAUlzTfq3ohI90KfPlhr99C/+xY6RpeuZ9/EiMlAGPW5ybY0p5lQ/9FiCH17BB0K3uXhLdh2W0UHX5fLehAOdnIuV9WIZh8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMvxqBESayxhOil8JsxYTdWdnhTRrzh9uf/gPp5i3M8=;
 b=nsWjM12zftDLug5xU+363k/Tp0l68NhMom5UY/rTpoK8v2LnVc+c9hi3v545s6pUOCLRbnmLLdGaEM2Gw/g9DTLKBdCwhV9htw/BCUL/DuQnyd5X4gQ+1EW6TN9triSBhlSsVdVc8QmRJpBsNS+6Dsc9/zoNI4HsKKxB16Dmz7KETzS9y00z1JlwEoESdo5u00bPNnSXQdyCtuMCGRbBJ0Q9OCdcy2pz1ki4sfivCAo1pdvdTOgmvKgYvb1fo2Px8yxaRL2I84L/XlDie3aP4jTejiW10gHwxB9GrLo2KL7YVA9AV7fX3HuBkY5Fr8ahdIWHup19zeUVz2N+bNsb+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10306.eurprd04.prod.outlook.com (2603:10a6:150:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 19:39:10 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 19:39:10 +0000
Date: Wed, 4 Feb 2026 14:39:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] dmaengine: Add hw_id to dma_slave_caps
Message-ID: <aYOgV-dmeA8XjNyw@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:510:325::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10306:EE_
X-MS-Office365-Filtering-Correlation-Id: f39fe245-d9a7-4fd6-0c38-08de6425116e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m53GhChdwZCzRHHzywyrC/Bc7Ok7e+JbT+GDFBgx2oy12DgscUfoDubD9dkh?=
 =?us-ascii?Q?PUc0tqmOJgpYK005046uV2vwIAWjD2uJbu3+BbKKSAIqSI/fvn/udEOGrCsk?=
 =?us-ascii?Q?yPP/tAXNPir2Xwogjr9nKb7eW7tYwl7stcgbtRcup07Osz/pS/2Z6VGl6KrQ?=
 =?us-ascii?Q?haspj3ImUHtwAY20tB9NT/2Y0ztaqB2NwkmsPFRsM1hUPhfe7Zn1UYndWFLf?=
 =?us-ascii?Q?kCwYzTVdsUPJltwqfBJrkEhYBP6CnzHG8jzLlUVI+WN5XmTNwaRIuh7hGMYQ?=
 =?us-ascii?Q?gMzmPrdR0eeyMZmHjpq7gD1Amw0IkQzQXjD2e4xcJvc8Yv+vHVTVx7U+U6n+?=
 =?us-ascii?Q?PIXiQLySY21RlcfaV+ElDfDi/R6GN3o95y4M7uGBfMdxPeIgT/lbJ4iy1Lbi?=
 =?us-ascii?Q?0uvhmrWb5p07VzhaxpgT9D4qiHzcdk6Xhs//2dxyh1HDRAAZEZyi7pQSIKDJ?=
 =?us-ascii?Q?03nNi+paQHMb5/nMLlSojJa//VZFcRNoB2aHF5ASdloSBzt6pAc/AxyxHQJS?=
 =?us-ascii?Q?c9vF3yHSJjwnT+biEa0jBE1N4ePMSOom0Rr8gfvehdemEHQ94Q3vfEAYIjbJ?=
 =?us-ascii?Q?UJEH6PTd/gJwskvmRlKWcoIxcOck+dSXgqKGivPLHiXnJB2TbvYXJa1n+ptp?=
 =?us-ascii?Q?7LckhyMP1JIviafL9ZO46fVPa+A2/qPdBj6Hd0qPt5/j3FMcXLTSGaxsGYPH?=
 =?us-ascii?Q?HH7p2j4aULqCoh/HUSaKvZhxncOImNpncVu0IOG7Z76AN/QxLQgHZ14Sx0j5?=
 =?us-ascii?Q?gun8iNAIevq/NEf+ZJrfZj1unr9tuKZLtcjePsWhFlWevPIFOBXqkS6QwdgF?=
 =?us-ascii?Q?AhVQuxT3hy3Xkm3/hUn2oOE16/kS/O7K9XAbre2BmFMY7262VuzqTsOW4jmx?=
 =?us-ascii?Q?/lUtLEGoLO1AK7gkS1kmgkkDOexxUWpm+bnY1JqlcDPJdA6sJTkNxc/Cg3yj?=
 =?us-ascii?Q?mRL5tvHKr8UHCCJwVRw+iO3Rr7Mqw5vszcT0NmUHpp53vvnChTG/V+5oFwFf?=
 =?us-ascii?Q?b5l68IDRLDlLARTGf5ZSgb/2Tl0S+X1MoQy3abChGcc7dZe4cj5nohTDxb4C?=
 =?us-ascii?Q?R0pG7JRxZs/qJBkrTKf7NDRlaYZrI1wgNuhXiuV40yj1rPKFmB+iEazp6zir?=
 =?us-ascii?Q?esheBVdNuXJh5WOIk3S2kQ2r7CMlxo4lIMblOmFUuwCEG6h4h2mk46+hyruZ?=
 =?us-ascii?Q?8aVny+iGg+jB1vXBY0Ge1LidBlMMKrHMaIirYbaidRqGFTGp+G+jWYerCTnp?=
 =?us-ascii?Q?NVTIVAHqbcFQhkxEdQeqjFSSW+Cp8HZ31bVWgkGugMVFAbtWXBcFhBxCtELl?=
 =?us-ascii?Q?Ttwt2G1DleciS2LKoP3NwJd4OKmNsnJihpfZH0/bgbCf2eqAwOXhVTYMWWKs?=
 =?us-ascii?Q?Q2rfQiBP7hBYOqmDVc4ng40MPR7MYbKwyeM1++raDbdn1mzxpe3/Ybs9Oe64?=
 =?us-ascii?Q?z2C4c3zX6fJyBe4b+jFTs6joi/s4+Khq2dwUukm98w35m/yHA2+TQp6GRoBN?=
 =?us-ascii?Q?wJ0fooTkLTGpRnt8Q9GT0sDtfo5k5sIEP+Uual62E5lnxsKkSSo2chF2972X?=
 =?us-ascii?Q?Mx4jO/2LbkWqBhidTwUnP+ypXTdvdtlJD7IHyxA9rpHk512Lorswxdgezpyn?=
 =?us-ascii?Q?rHzX9W3R3cj8D5xjmhGSNmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbBLovryhaR41obgk7c62d1K47/7P/HvW1JZ0JKYCopXh4vQIouzhLKGcGBY?=
 =?us-ascii?Q?eeZO/GO7+UhSSbrI59pVhDMdhTH+e9DSplM/XBj+xngyPLDzyqr8+Cbt9zmT?=
 =?us-ascii?Q?T5t96MJ3tRaaORviMSe0hcR7nV8jVxUEs+nU5+z8/T2SJ4d2cmT1CCxl0PXT?=
 =?us-ascii?Q?GIZ1Z7aeWBxoiYxN1998JzXYVQd91UhCm2C1SYezZhqkjBIyJKPxiAhSWcIv?=
 =?us-ascii?Q?IPg13029bHpSng64HeSFwRKE+XdJ0um0/A2D2nkF50ZCR2n9ojLjnnKs19pY?=
 =?us-ascii?Q?/MB4fqWa0S7C13+lFEWX2DPzNrIUdHCOyqaMInk4SfzoZzLaRY0o6PFd1b/Z?=
 =?us-ascii?Q?uyl/J4tn+DFzYaEfALqOP3yT7tGvlTBuR1rzjZ1Q6mzSC3Bukj6bxXnipH7O?=
 =?us-ascii?Q?NhX2p4G8zFXOhnVOUooZOAQ/HlHf/vE84ZTb/aTkuQii9vB8eqoo1Fy5yJUY?=
 =?us-ascii?Q?kQaWTp8iX4zUnHdsr3cHD5eLXUwW60B8o9KjZtyHBxAseI7tB09In/UfSqIv?=
 =?us-ascii?Q?k4bDenzoUOH9qoYD8CNZU1Js49rWhroaL5IUIvNYBewc+ebKDqjT06h+b6Ys?=
 =?us-ascii?Q?tAheW3x0A5/6X0Dvzs69Nh+RgdZeLu4XBhKqscRXB7jiUQKK/qhA/hZf+r1u?=
 =?us-ascii?Q?HxfXRw/HJV5wM2LFa+7fmh1xhYh3lVcOg92ZLhsynkT61xYn0kzQO5PnAK9t?=
 =?us-ascii?Q?Ve/g7XFKVdXxRxSb+4t1MnSLpem8brXgJFWBeTnmvfqXKM1S4cJvYYQ4ZZFf?=
 =?us-ascii?Q?/d1bpPVSWJwhTYfqPG9mV5wyXZI9dtcWpMofn+o/Lxj0/Ndk0IYjNUElxZ/z?=
 =?us-ascii?Q?VlybBXb0vz7I4cX1vY5CN/g937lvDDzvkUVYpelhGortDjL/+f3X5CdtdG/P?=
 =?us-ascii?Q?imD3mIeeRef36Zl4Ev9c+fiBol4BoRELpm+C0BunmQtnQIJotPM4Wn4eZTVM?=
 =?us-ascii?Q?OU5cp4NU6D6vjmGJVk9Kiwr3tZLpVmut2RxSRVxzxNqnjvAZxEKdo5IdiVTZ?=
 =?us-ascii?Q?vx0mzsFmm8QNeWI8RAIuqJdenuTZ6Lz7pRAX0Zi8H5FfXUm3+F5U5S6v3Iqy?=
 =?us-ascii?Q?JL2ApbSOaNpUt2yqpSqpA4yCCg/N+GaoTtjCvUGXFxMdayqp4A7Y7uqGTKle?=
 =?us-ascii?Q?Ky/N/4iHpAxNwzeivV+cpiGSQ+dwfgf41smNpqvKmDOXd1EvyvGFKP13g5ip?=
 =?us-ascii?Q?lVec0Pw4gb8Ur54NU6TIo0Oq8mQiZAt1iun1ST/35HYjjtNTh3WYxJBrQUR7?=
 =?us-ascii?Q?iSP9L3+XaRJMW507W6OyUFeAoP7dGvSVZxlSWCNynHypuWE6y32ehopYuq7a?=
 =?us-ascii?Q?8vd5x/IA+LtR5A7kF6DHqBj1vgxZUvZKGA0HNTPDc4xxBg6y1RuI9jAFm+UG?=
 =?us-ascii?Q?1cHLNB5z2jgWBl+EU/ACupoD+RtwWi6gZHDwfRP1W9TEXL/lzmgo0OJp7Qo/?=
 =?us-ascii?Q?j+du6ULABVTI6eAJnFHRFN5gm2HlmDGewNItvQQlxB2K18FTtMkZtLTt8MTd?=
 =?us-ascii?Q?6Y4JKtb0UiNxcuKhn2jWW3Rg8zmAaaXP9kuuNb/qGLQFrw/vz5fv1i4ybONW?=
 =?us-ascii?Q?/5t4Gx4hIr6EQ2v1Ht/5sG3tojPIOcqnS5EGOrvYOc0sFfxpk1SQMkPCc//C?=
 =?us-ascii?Q?RN4lbSqr91s5wFBkjUoPYcTAtWYvt7uiFqh837EjXrvOT4HoEiLrC7qeTteu?=
 =?us-ascii?Q?l5k1XM9QwyUJHwiOp98wAuERyKfSFBIWUbu6750yrQkQnjXRGwpbdL0qJeqF?=
 =?us-ascii?Q?dKjuxkURWQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39fe245-d9a7-4fd6-0c38-08de6425116e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:39:10.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni2Px5Sz7VZBhrBxpHPicu4tU8rMGltncETC7taUDmetY2PJ/UsKfmSIZCypGMhYrSoZtdoTMda8LTqNSlmcNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10306
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8744-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BD84EC2BF
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:29PM +0900, Koichiro Den wrote:
> Remote DMA users may need to map or otherwise correlate DMA resources on
> a per-hardware-channel basis (e.g. DWC EP eDMA linked-list windows).
> However, struct dma_chan does not expose a provider-defined hardware
> channel identifier.
>
> Add an optional dma_slave_caps.hw_id field to allow DMA engine drivers
> to report a provider-specific hardware channel identifier to clients.
> Initialize the field to -1 in dma_get_slave_caps() so drivers that do
> not populate it continue to behave as before.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dmaengine.c   | 1 +
>  include/linux/dmaengine.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index ca13cd39330b..b544eb99359d 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -603,6 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	caps->cmd_pause = !!device->device_pause;
>  	caps->cmd_resume = !!device->device_resume;
>  	caps->cmd_terminate = !!device->device_terminate_all;
> +	caps->hw_id = -1;
>
>  	/*
>  	 * DMA engine device might be configured with non-uniformly
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea..71bc2674567f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -507,6 +507,7 @@ enum dma_residue_granularity {
>   * @residue_granularity: granularity of the reported transfer residue
>   * @descriptor_reuse: if a descriptor can be reused by client and
>   * resubmitted multiple times
> + * @hw_id: provider-specific hardware channel identifier (-1 if unknown)
>   */
>  struct dma_slave_caps {
>  	u32 src_addr_widths;
> @@ -520,6 +521,7 @@ struct dma_slave_caps {
>  	bool cmd_terminate;
>  	enum dma_residue_granularity residue_granularity;
>  	bool descriptor_reuse;
> +	int hw_id;

I have not see where use it? Does src_id of struct dma_chan work?

Frank

>  };
>
>  static inline const char *dma_chan_name(struct dma_chan *chan)
> --
> 2.51.0
>

