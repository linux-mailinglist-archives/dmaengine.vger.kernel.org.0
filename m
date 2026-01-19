Return-Path: <dmaengine+bounces-8376-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF3D3AFCE
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F20A3011ED1
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A038BF80;
	Mon, 19 Jan 2026 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PsfJYLma"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49722B5A3;
	Mon, 19 Jan 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838383; cv=fail; b=pSO7m3KxvIsSrZ0hErgpK7ZSb/18SsiiapZwtUfMuOkLxv0YLL/vCw5NMizWDtk/19SFNQaaBWP3rhFnge2fh23QEZZ4oqYNnBzjWMfUvrEks0oBV6oTKodjjyo/rlrCGxk1yOHOsv1RHDEM4gwQXAKHOR5gghBhY0xy+mDxGok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838383; c=relaxed/simple;
	bh=6iK9DaonU8v6lgUCCrKgHeR72Ft3vMUBvSHxAizRv0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q6HaBfWSdJ3rHR+T03fRBIHCYtMLDpUsRic5GilKGubw9pndX6DpLkecfde0Zs/lxrfanjVGhQQ66fF826NtiidFWJaFUYSaWu/HL0nB4urakDZ1CqubPY5QfC/v2MNAjdfLyS3MDLYMQyu5AFKKf0AKwz3/NYT4Ln7DQUXDII8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PsfJYLma; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ3iQhjKJXyPkfDQyYW/0bJP1IY/ynB37kscbhZXL4wgTec/SuFm5fYV362CLMj/J4OhHow3pXwheGu+XeFhWwEPCVdIuWSG2lZhSGKKAzUgonLQMghdn5FFNhl785Z9hmrueRXO1gDUktUqPBTxCZDL1PhRVBAb0DlJN4VirqHodZArkSmziANyIyU2B1WJBYIJsJjVrxDi20hMpmCaMHyG1W3arGXKUTSWuYeqA4TV0UcKAtl14MpfmS0Ojm01HaHYi5RRBoR5xLm2jRxbxkFnWd7RDrxpSQbfi1GiV49jUogh4WxSHB4XocCxReJnvsZtisSGlW7GoOGdEwXluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAI5tRKqmi0Gjj0eVZvWwgerUKl4qypPghSUgb+xIkk=;
 b=nKoedfYGa3ygSiueFwDZkD6kGNSnZ6OHhKtQFbbF+zd8OyIhekSOJxZLii4LTd0DRO5j7RDFaNvx7WAlf/SiZZAVAyYMm+mv/yckwM/PCwwmqgWwuo8dpA6Zr3Jkc3hXYkm/5hcnvY5bBj2BeUIkIRixfVTEj24RkifQMGSHdYoKq1OVPYfzbzE1yTkmdBlBf/bkhO8EzxFErtrLJiVoKnrzig7oEHQ1zZBkBu5atcgopb6CkjVvzi+Q4XKtWK1aPKR8HQ/p5LD8r8JwqpaVhN6xWuyorYKlTZtAP9WLG8l95C/xtqWY1IJ8YBP85MnEJVnyX6Fq8wYNfX5QPRH7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAI5tRKqmi0Gjj0eVZvWwgerUKl4qypPghSUgb+xIkk=;
 b=PsfJYLma1FabWhX1hEsy4hW8FDxPehfHpVsMiojwWMe+cXDUoIcalF52HUmitdG3eWp7+7XlF+DuibK38nwuANQYos4K9O18jZ1A1hQEJsvImym+HojBFWZG3z5BUTjmihlsLKV5ULiwvkXiIb9FKPTgQ1n47+iw1mYKYwFd/gjiEhQIPLtIQRTSGjbDCYmW0C3ZMy38hqjiBR+sCynCXzspoOOLL74Upvunr2iTsXqQhCm4xeKPGFU1NcmHZFfCzz/vQBVvbRYcsOR+hLxSlOU4CUdcuXZNvfTaEaCjodUkqfL7NyYnwLfnX6rDvfvBMfpa5E6Fz4gMM8ggcKTs3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by AS1PR04MB9286.eurprd04.prod.outlook.com (2603:10a6:20b:4de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 15:59:38 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 15:59:38 +0000
Date: Mon, 19 Jan 2026 10:59:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <aW5U5AoUkE2uCzaL@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-2-devendra.verma@amd.com>
 <aWkT/TDoLNnGUNlG@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E8E85ABE669FD626E75D9588A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120E8E85ABE669FD626E75D9588A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:6e::30) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|AS1PR04MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ee1e6a-faed-42e7-0aba-08de5773bfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2lMippCNfwBUyXu1ZzqAepXYWolOo32qryS0+1svMbns0/NanhScq1RJPbSM?=
 =?us-ascii?Q?k8QTUJ3APSKLFHqAs/vPLQ3PthPN+vG/fAUnCQt2zk+8x19bcGg/8Zt2nxvs?=
 =?us-ascii?Q?5Srk7kt+YBwiq72CP1vOPfFqpZvn9X7B1NDdRw+8uDtARcCVCwxhvT5EiT7c?=
 =?us-ascii?Q?Lukgm5+i8hXcmXnRGcgKKF8XbJDdxJZ9IUSHoYp6ybRNORiETLxbNVOzo9NM?=
 =?us-ascii?Q?kyKydBsyInwhRLhlAGjzWneoKV8R/nZK3QF67u3ut2RAORRC+orLFdqDnSf/?=
 =?us-ascii?Q?yyrFQ4H12YpFhzf1LwVBylfVzIcTdPDsOMfqjYAvBz29Q1CTqXzrsY7r/gM2?=
 =?us-ascii?Q?5AW8v9rshYTtG4fMQTvJoYRis71YzyP8ukeopZQKYWv4GeIEmqBFb8nwQfc3?=
 =?us-ascii?Q?y7JdlhyFiezMR3hfRjuF+nSplFiRYXjnU6DHYkNJXdfuZARqi4VgKqiYu18C?=
 =?us-ascii?Q?yG4TZNCuRnPkg/FNAW4QTbJVgbHhpoDZmwWKlMATayA2H5XbbGKfqZirWiwA?=
 =?us-ascii?Q?sIVpZo3mTeyf151e+AVo2vlkrbVRzOzPz7uGd29weYAkSl00yLSMhTXrWloq?=
 =?us-ascii?Q?kWx8pgnl3l5FkcPPp0YpQjSNHjp2UONG08iQ51xbCdYJ0sy+tlQI7nnjQOPd?=
 =?us-ascii?Q?DFPDKP7o+oqo5ey2HKBZaGI8QDp+4owz0TmnRSpOWAKZEK1TxSWXRcyWOVxs?=
 =?us-ascii?Q?euxc7XPYNQewiC5pxpQ+z7HHNyDr9/y0Q/4IoXFdXq2tEbiDZfKrqLeeYYEy?=
 =?us-ascii?Q?Y18iY9YedbyxouIS14eDModNc3yalqGvym8n7LlXrptFtB+GchBs4IWjcPT9?=
 =?us-ascii?Q?+qoubAOExFBSNF+3hBr1DvFXEifkI1wI7ByPyzvGDK4kl9A7ioBm9Pa9IY/K?=
 =?us-ascii?Q?qe4OBpsRA9qQNEpA9YBsIjoKxTThN3P/hpUrxBwt+4sKnkzrPlo80Ct7aXZO?=
 =?us-ascii?Q?TjguA6y+gDBKJk9P9BcvDu17KHT0NaNrs5Jt/QLrtIxIaSnfmFg0fF6+xH+S?=
 =?us-ascii?Q?F85Nf34GPk4CNJzSjTNL2e+8WEEqtgFb039U+Hn2mOadJzDAWG478/l+PAzA?=
 =?us-ascii?Q?GFhSAplGBGXi1fBSu3MOz689FizOJCHLM3safZjYHQni/LT7Xl+tZifKPIUD?=
 =?us-ascii?Q?mAfXOjx0xL7QY5PnvNRpu7vBV+lAIBJLLwr+Bnncfz/Lwrz1C91OusJBpU+w?=
 =?us-ascii?Q?wYytwvIXMz6RJAJgN/AVeHvNCsVH8JWwRP4aXFAFthBPCanApiUh+1B7HXzO?=
 =?us-ascii?Q?alJz/XHGLhpcEsVG5jTD1NZxQwcOm4DRxf6kXSrQQUQel5Zrdk0Seuh6Eypo?=
 =?us-ascii?Q?ckzygXCVMKyXEibrCCU4Ph4KmkqlbcY3SjaDczW2UUzXu/xyL98R8fxmc/P6?=
 =?us-ascii?Q?Slw5De57+rIiYmErACXzri+CuWvy6odJEU3D3eLUzPvbyNU+7vDoALcSw2fN?=
 =?us-ascii?Q?Fh1qxggWZwm4ccMmJiqRagD/vajD0vvE8qsbRT6sJCCr4s6mcxrlYHH2zGZM?=
 =?us-ascii?Q?aMHN3GAvYgLeAZ3v8KzxUIzhEYm7d8Dk2Th9r6bzsC6HdIHWqvFITZrXNzh7?=
 =?us-ascii?Q?SM1oojlouuGjAxpgvfV2nJhe21EpQOKNLNM47tD6WjbsrFi0sEfkBTs3RKl9?=
 =?us-ascii?Q?Hue2dPNRqqFW9W8jqLBgNLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jwa6rdmZMX1QTOD/uBmpduIHFUWv+VHNwuxsfE5hBgaVKM/i/xx1yAtVsWPx?=
 =?us-ascii?Q?e5UCt6oD73mIYVdX4e3Jw0yEQK1EHR1cy7sWhS/7ltTeysUfLWUBgj/6eN1k?=
 =?us-ascii?Q?a5qmvUbitSXS8lbqruUu/4z0RX+5lxaXR/7rld3kn9HP/1lHTySvpB+cHoHG?=
 =?us-ascii?Q?d+ZXgBSNzz/KXLJszqiZ/PU05zl7FcsdzvkU77wVeKSAThCaiQWvDd6wswtq?=
 =?us-ascii?Q?DF8Nyh6Oh0b8SmOsrQh2MNIzE+3jZBUzhsm+IdP9D5rCH/PSlIoT66SnOWwj?=
 =?us-ascii?Q?oiLflD6N+cwzFEbPOn6DNq4EtLpuGIsO+kAkxAlIR/bIzep5rjff7UgdzfiZ?=
 =?us-ascii?Q?itmsa9AxV0dWQiU34AfFG1JRYXpX+Cb39qNdjfCAu8yHRA9p+IU41Q4hRM/i?=
 =?us-ascii?Q?N1flfw/ZSVy+t0mgDhYWqgacVyy+WX8EgwR637nUm1jElAcAj0YshRUsgz6L?=
 =?us-ascii?Q?+m7WhK5FkDXPPzG7NPiQHoJxfWQIiVxaGYW0gt1zGdYtoxJ64hlIzGSLBUHz?=
 =?us-ascii?Q?6wGyAa7FHq112RQ1B2YtxRRPg4hcf226l0SFKobB10ziX7G67tbeczVXORWp?=
 =?us-ascii?Q?jBrRc+iZ2RPzwad5G4/Us1MscKVf5a5aoI/N32Z2LnvAkZNytNuJWqdYeLGF?=
 =?us-ascii?Q?lLnKR1IwQ3/g82XVILnJbPdQO7bAIjZK26cFGUUZrRQBwLha5DYa4Rbe3JR1?=
 =?us-ascii?Q?WfXQQ/+xReJ39O2VoQU4hsj0c+I6J4Mk8plE0i0zwVdLck2v1FfbkP6oeDIT?=
 =?us-ascii?Q?x5vW7XLH/9q4F5R1fVs8HxfIsjLEHoNrV4sMS8rGCxe6Jfjz2anv52zyfz0T?=
 =?us-ascii?Q?htEBNDEgkBfggPkwG7HLDpHt2hroI8SKPkAmNQfsZKavSA05ia8YnHy8H5t4?=
 =?us-ascii?Q?6JS6gkkaQSATxkgOb6MmWXcPkx0BmLWtMmE1Snw/EDXnyw4FNEAQ3pVUPLjV?=
 =?us-ascii?Q?q4SfnDxCOvVHk30tkxnTh1o2wEnsyyYT3CrTRuvfVS61Iat38yG4pIBPaeE3?=
 =?us-ascii?Q?XLH0VdSoVGPLlOtjHhWxHDUl5hf/qWon6MwAfXGJ3lpKRb53Yn1v30qKMnvh?=
 =?us-ascii?Q?+e+DNaFpPcNIlBJ1o2fNrABq7bv9c22Y0p3le1rvN2w3nQ+heqXOEhR95btt?=
 =?us-ascii?Q?XB1EG2WEK3m8eVNR7cg785IkJjoQg1ssGOYzAvwnQdItwauSmyrZEuXgd01m?=
 =?us-ascii?Q?L/gxczurLZkS7ld7MFJT27TU3dlo5OH+GzGMP9lnU/67vFuy4ITHZVCbbnEg?=
 =?us-ascii?Q?I6P4EccrW2TkxAHq/6f+i6y6NO0bx/KE1mnrR6wzwUWmiqV11CVlNN06Km+L?=
 =?us-ascii?Q?JyFHKXWSOmxwY8GdHm6JyGVUDSIlxzKgGNnNY34eEm6wAHyNiGAKUMfIj30P?=
 =?us-ascii?Q?xGpl2sHsvuCDfFRLOhiZCXgMjG3+kQAzBqlu+uzq6QjhXDvlPTdlTLNNJxEn?=
 =?us-ascii?Q?eFYE09kph8Y0n2sIhfe8WcP7ShwuHYAvTOiSYn8xCvvum5CNeso6QAOXjsxj?=
 =?us-ascii?Q?8kstYJ/uRB+DF2GpS1wu5wEIUTGFa6413LanBbNad+9/drMmGU4aMLK7IItF?=
 =?us-ascii?Q?V5GjKS/tq3gfjaqvmIupLr1qjmaLaObU6CNpN15UFyfEdxcCTKY0XJMK6/7l?=
 =?us-ascii?Q?eH02fSYUV+jX5F0TwGuaZD5VvhsAErUHGecQQ1FGkSehoGdiOgIzrSvKqtf9?=
 =?us-ascii?Q?JRNvGRVsBPD+TSx7VJ/dpSbwEMmkdNnwZx9BL4VyJve/miOezukcmHyhdKuN?=
 =?us-ascii?Q?qaEOJo7ChA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ee1e6a-faed-42e7-0aba-08de5773bfc2
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:59:38.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82BVFgYDFTsEc9W/0Z4fgXrXU1k5kkIjYV8Lwb4kCvB+GXs6BRAS1l+QJLD/oXi6aYyLp/svGFgV1uoIP14AVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9286

On Mon, Jan 19, 2026 at 09:09:11AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Frank
>
> Please check my comments inline.
>
> Regards,
> Devendra
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Thursday, January 15, 2026 9:51 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> > Support
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Jan 09, 2026 at 05:33:53PM +0530, Devendra K Verma wrote:
> > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > following
> > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > >   - AMD MDB specific driver data
> > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > >     base address.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v8:
> > > Changed the contant names to includer product vendor.
> > > Moved the vendor specific code to vendor specific functions.
> > >
> > > Changes in v7:
> > > Introduced vendor specific functions to retrieve the vsec data.
> > >
> > > Changes in v6:
> > > Included "sizes.h" header and used the appropriate definitions instead
> > > of constants.
> > >
> > > Changes in v5:
> > > Added the definitions for Xilinx specific VSEC header id, revision,
> > > and register offsets.
> > > Corrected the error type when no physical offset found for device side
> > > memory.
> > > Corrected the order of variables.
> > >
> > > Changes in v4:
> > > Configured 8 read and 8 write channels for Xilinx vendor Added checks
> > > to validate vendor ID for vendor specific vsec id.
> > > Added Xilinx specific vendor id for vsec specific to Xilinx Added the
> > > LL and data region offsets, size as input params to function
> > > dw_edma_set_chan_region_offset().
> > > Moved the LL and data region offsets assignment to function for Xilinx
> > > specific case.
> > > Corrected comments.
> > >
> > > Changes in v3:
> > > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > > condition check.
> > >
> > > Changes in v2:
> > > Reverted the devmem_phys_off type to u64.
> > > Renamed the function appropriately to suit the functionality for
> > > setting the LL & data region offsets.
> > >
> > > Changes in v1:
> > > Removed the pci device id from pci_ids.h file.
> > > Added the vendor id macro as per the suggested method.
> > > Changed the type of the newly added devmem_phys_off variable.
> > > Added to logic to assign offsets for LL and data region blocks in case
> > > more number of channels are enabled than given in amd_mdb_data struct.
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c | 192
> > > ++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 178 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 3371e0a7..2efd149 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -14,14 +14,35 @@
> > >  #include <linux/pci-epf.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/bitfield.h>
> > > +#include <linux/sizes.h>
> > >
> > >  #include "dw-edma-core.h"
> > >
> > > -#define DW_PCIE_VSEC_DMA_ID                  0x6
> > > -#define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> > > -#define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> > > -#define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> > > -#define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> > > +/* Synopsys */
> > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID         0x6
> > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR                GENMASK(10, 8)
> > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP                GENMASK(2, 0)
> > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH              GENMASK(9, 0)
> > > +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH              GENMASK(25, 16)
> >
> > Sorry, jump into at v8.
> > According to my understand 'DW' means 'Synopsys'.
> >
>
> Yes, DW means Designware representing Synopsys here.
> For the sake of clarity, a distinction was required to separate the names of macros
> having the similar purpose for other IP, Xilinx in this case. Otherwise, it is causing confusion
> which macros to use for which vendor. This also helps in future if any of the vendors
> try to retrieve a new or different VSEC IDs then all they need is to define macros which
> clearly show the association with the vendor, thus eliminating the confusion.

If want to reuse the driver, driver owner take reponsiblity to find the
difference.

If define a whole set of register, the reader is hard to find real
difference.

>
> > > +
> > > +/* AMD MDB (Xilinx) specific defines */
> > > +#define PCI_DEVICE_ID_XILINX_B054            0xb054
> > > +
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR              GENMASK(10, 8)
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP              GENMASK(2, 0)
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH    GENMASK(9, 0)
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH    GENMASK(25, 16)
> >
> > These defination is the same. Need redefine again
> >
>
> It is the similar case as explained for the previous comment. Please check.
>
> > > +
> > > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> > > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
> > > +#define DW_PCIE_XILINX_MDB_INVALID_ADDR              (~0ULL)
> >
> > I think XILINX_PCIE_MDB_DEVMEM_OFF_REG_HIGH
> >
> > > +
> > > +#define DW_PCIE_XILINX_MDB_LL_OFF_GAP                0x200000
> > > +#define DW_PCIE_XILINX_MDB_LL_SIZE           0x800
> > > +#define DW_PCIE_XILINX_MDB_DT_OFF_GAP                0x100000
> > > +#define DW_PCIE_XILINX_MDB_DT_SIZE           0x800
> > >
> > >  #define DW_BLOCK(a, b, c) \
> > >       { \
> > > @@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
> > >       u8                              irqs;
> > >       u16                             wr_ch_cnt;
> > >       u16                             rd_ch_cnt;
> > > +     u64                             devmem_phys_off;
> > >  };
> > >
> > >  static const struct dw_edma_pcie_data snps_edda_data = { @@ -90,6
> > > +112,64 @@ struct dw_edma_pcie_data {
> > >       .rd_ch_cnt                      = 2,
> > >  };
> > >
> > > +static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > > +     /* MDB registers location */
> > > +     .rg.bar                         = BAR_0,
> > > +     .rg.off                         = SZ_4K,        /*  4 Kbytes */
> > > +     .rg.sz                          = SZ_8K,        /*  8 Kbytes */
> > > +
> > > +     /* Other */
> > > +     .mf                             = EDMA_MF_HDMA_NATIVE,
> > > +     .irqs                           = 1,
> > > +     .wr_ch_cnt                      = 8,
> > > +     .rd_ch_cnt                      = 8,
> > > +};
> > > +
> > > +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> > *pdata,
> > > +                                        enum pci_barno bar, off_t start_off,
> > > +                                        off_t ll_off_gap, size_t ll_size,
> > > +                                        off_t dt_off_gap, size_t
> > > +dt_size) {
> > > +     u16 wr_ch = pdata->wr_ch_cnt;
> > > +     u16 rd_ch = pdata->rd_ch_cnt;
> > > +     off_t off;
> > > +     u16 i;
> > > +
> > > +     off = start_off;
> > > +
> > > +     /* Write channel LL region */
> > > +     for (i = 0; i < wr_ch; i++) {
> > > +             pdata->ll_wr[i].bar = bar;
> > > +             pdata->ll_wr[i].off = off;
> > > +             pdata->ll_wr[i].sz = ll_size;
> > > +             off += ll_off_gap;
> > > +     }
> > > +
> > > +     /* Read channel LL region */
> > > +     for (i = 0; i < rd_ch; i++) {
> > > +             pdata->ll_rd[i].bar = bar;
> > > +             pdata->ll_rd[i].off = off;
> > > +             pdata->ll_rd[i].sz = ll_size;
> > > +             off += ll_off_gap;
> > > +     }
> > > +
> > > +     /* Write channel data region */
> > > +     for (i = 0; i < wr_ch; i++) {
> > > +             pdata->dt_wr[i].bar = bar;
> > > +             pdata->dt_wr[i].off = off;
> > > +             pdata->dt_wr[i].sz = dt_size;
> > > +             off += dt_off_gap;
> > > +     }
> > > +
> > > +     /* Read channel data region */
> > > +     for (i = 0; i < rd_ch; i++) {
> > > +             pdata->dt_rd[i].bar = bar;
> > > +             pdata->dt_rd[i].off = off;
> > > +             pdata->dt_rd[i].sz = dt_size;
> > > +             off += dt_off_gap;
> > > +     }
> > > +}
> > > +
> > >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int
> > > nr)  {
> > >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -114,15 +194,15
> > > @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t
> > cpu_addr)
> > >       .pci_address = dw_edma_pcie_address,  };
> > >
> > > -static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > > -                                        struct dw_edma_pcie_data *pdata)
> > > +static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
> > > +                                            struct dw_edma_pcie_data
> > > +*pdata)
> > >  {
> > >       u32 val, map;
> > >       u16 vsec;
> > >       u64 off;
> > >
> > >       vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > > -                                     DW_PCIE_VSEC_DMA_ID);
> > > +                                     DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
> > >       if (!vsec)
> > >               return;
> > >
> > > @@ -131,9 +211,9 @@ static void
> > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >           PCI_VNDR_HEADER_LEN(val) != 0x18)
> > >               return;
> > >
> > > -     pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability
> > DMA\n");
> > > +     pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended
> > > + Capability DMA\n");
> > >       pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > -     map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> > > +     map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
> > >       if (map != EDMA_MF_EDMA_LEGACY &&
> > >           map != EDMA_MF_EDMA_UNROLL &&
> > >           map != EDMA_MF_HDMA_COMPAT && @@ -141,13 +221,13 @@
> > static
> > > void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >               return;
> > >
> > >       pdata->mf = map;
> > > -     pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> > > +     pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
> > >
> > >       pci_read_config_dword(pdev, vsec + 0xc, &val);
> > >       pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> > > -                              FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
> > > +
> > > + FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
> > >       pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> > > -                              FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
> > > +
> > > + FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
> >
> > If you don't change macro name, these change is not necessary. If really need
> > change macro name, make change macro name as sperated patch.
> >
>
> As explained above, the name change is required to avoid confusion.
> The trigger to have the separate names for each IP is the inclusion of Xilinx IP that
> is why no separate patch is created.

Separate patch renmae macro only. Reviewer can simple bypass this typo
trivial patch.

Then add new one.

Actually, Needn't rename at all.  You can directly use XLINNK_PCIE_*

Frank
>
> > >
> > >       pci_read_config_dword(pdev, vsec + 0x14, &val);
> > >       off = val;
> > > @@ -157,6 +237,67 @@ static void
> > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >       pdata->rg.off = off;
> > >  }
> > >
> > > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > +                                          struct dw_edma_pcie_data
> > > +*pdata) {
> > > +     u32 val, map;
> > > +     u16 vsec;
> > > +     u64 off;
> > > +
> > > +     pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > +
> > > +     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > +                                     DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > > +     if (!vsec)
> > > +             return;
> > > +
> > > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > > +     if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> > > +         PCI_VNDR_HEADER_LEN(val) != 0x18)
> > > +             return;
> > > +
> > > +     pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability
> > DMA\n");
> > > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > +     map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > +     if (map != EDMA_MF_EDMA_LEGACY &&
> > > +         map != EDMA_MF_EDMA_UNROLL &&
> > > +         map != EDMA_MF_HDMA_COMPAT &&
> > > +         map != EDMA_MF_HDMA_NATIVE)
> > > +             return;
> > > +
> > > +     pdata->mf = map;
> > > +     pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR,
> > val);
> > > +
> > > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > +     pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> > > +                              FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH,
> > val));
> > > +     pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> > > +
> > > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > +
> > > +     pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > +     off = val;
> > > +     pci_read_config_dword(pdev, vsec + 0x10, &val);
> > > +     off <<= 32;
> > > +     off |= val;
> > > +     pdata->rg.off = off;
> > > +
> > > +     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > > +     if (!vsec)
> > > +             return;
> > > +
> > > +     pci_read_config_dword(pdev,
> > > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > +                           &val);
> > > +     off = val;
> > > +     pci_read_config_dword(pdev,
> > > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > +                           &val);
> > > +     off <<= 32;
> > > +     off |= val;
> > > +     pdata->devmem_phys_off = off;
> > > +}
> > > +
> > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >                             const struct pci_device_id *pid)  { @@
> > > -184,7 +325,28 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >        * Tries to find if exists a PCIe Vendor-Specific Extended Capability
> > >        * for the DMA, if one exists, then reconfigures it.
> > >        */
> > > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > > +     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > > +
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> >
> > dw_edma_pcie_get_xilinx_dma_data() should be here.
> >
> > Frank
>
> Yes, this is good suggestion. Thanks!
>
> > > +             /*
> > > +              * There is no valid address found for the LL memory
> > > +              * space on the device side.
> > > +              */
> > > +             if (vsec_data->devmem_phys_off ==
> > DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > +                     return -ENOMEM;
> > > +
> > > +             /*
> > > +              * Configure the channel LL and data blocks if number of
> > > +              * channels enabled in VSEC capability are more than the
> > > +              * channels configured in xilinx_mdb_data.
> > > +              */
> > > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > +                                            DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > +                                            DW_PCIE_XILINX_MDB_LL_SIZE,
> > > +                                            DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > +                                            DW_PCIE_XILINX_MDB_DT_SIZE);
> > > +     }
> > >
> > >       /* Mapping PCI BAR regions */
> > >       mask = BIT(vsec_data->rg.bar);
> > > @@ -367,6 +529,8 @@ static void dw_edma_pcie_remove(struct pci_dev
> > > *pdev)
> > >
> > >  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> > >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > > +       (kernel_ulong_t)&xilinx_mdb_data },
> > >       { }
> > >  };
> > >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > > --
> > > 1.8.3.1
> > >

