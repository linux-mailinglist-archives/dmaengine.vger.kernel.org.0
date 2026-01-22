Return-Path: <dmaengine+bounces-8452-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO6YLEmPcWkLJAAAu9opvQ
	(envelope-from <dmaengine+bounces-8452-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 03:45:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781C610FD
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 03:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7DB74832C8
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 02:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30B38F23B;
	Thu, 22 Jan 2026 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="t46NvV5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021094.outbound.protection.outlook.com [40.107.74.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40038F959;
	Thu, 22 Jan 2026 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049909; cv=fail; b=oQJ1Xl2XiKExBOd10v7bmSeP/oVQMGf9YkTifI9sFOsHknML3FTQRN+6xv+AbIkjEa5ZCK2XD+m4vQwXS3AsIj5rE59kESSHE35pLtzByufo0R4v3rrFY1UbA0OyUnTbzk5qT5ee4aXvsciRsTnwCPU6HAOjMzc0HCdir70smzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049909; c=relaxed/simple;
	bh=I7gTURczqGeW+Nim1GnAG3IvY7VInwnjK4coR6RXe6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WGuKYYY6HB4dHzwM7zKg0Z4syi2mcNiCIx/msg1Ul2No3PtibE1UEpja9GnLenOaZ10sfTv8HwlS2beB55/Xa1LxeODOvp9KIovInSsk2APCuMD6oh6K4UlUby/iqtQMI6cqFyeCfcLBKzmlIu7qX40zYOZVLF2BcZevk9xJW68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=t46NvV5P; arc=fail smtp.client-ip=40.107.74.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw+BYvUVMmVekBjLUFx5P7Nzun0YVCj/otTfQSSgUluv1AX5WDdJ5Tg3EByR91xdLzv8FUgQ+djBUYC83tHSjjvD2as+dgA+hgocMcsSDDjmFIGAL9GjVvO6HTryTpUp3FFZ+bw4hmkqTfm0dhRijEIqJQgG2gy6PQ4520CGqDXjeIo0jRIL2qYDS5sTvyFb2Q1mz1jLDKfI0CT1jLzhMaNaoBDQOitsIpPdTRuVd0sjq2D5xe7Wf/bKSzxyqDBzH2ewaxuYBd/RFbhwRYMeg2tuL3YOVKhOlErePfmQNrL51stUR6ax6imgKoq+w2iCYC0ibPs4lPGHDFeAw0PCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqWtMc7THSY1QrczuZxjNDiDeZH+w0H6sIYKEeueZUk=;
 b=BnQ12pdKRTSyE7TYawkb3TDO9gPpt/H7u3AdtWPb6wKLBlLMujLgyhr/w5RFn8OHygiF8EEgVhrL52FDKXEKZFfXJ+uNYPtWcNHIYw6V+UgRP02GuYSSK1LlduDoJfrEMG4V8wmpvO6iWezKYDqEkKZPGpdhN3XSBK8thBa2FZ8db2VHiAH4jFZuZUH+JIFStPj2svu9GRjrMwJE4Np69AVKWYmY/YcuzLmhNY5g42C42DqEqqBKq0NdX5jpkRo8CcuIXQfFK2a8HgbRJtPHhw6w+vMxJBsbtqjmyZYiiQjT1Jtg40XHBVtbR1LSXRprgHQtFu1GUgk8nkPuVkxZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqWtMc7THSY1QrczuZxjNDiDeZH+w0H6sIYKEeueZUk=;
 b=t46NvV5PW/EeJVB5qSQFtqabet+O7XuTAoW9k8ImwhlPf7TJwgoZelVSSthxLv3mFF+i27brB0GHvvjIGsEx84wDUVk//97TCOnGks07G0W1kJNOznefC08h/ZF8pz9urDTiMZvoeCkByEVfd5SYZZxjumQ1vd5rrNi7dknHwOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6555.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 02:44:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 02:44:54 +0000
Date: Thu, 22 Jan 2026 11:44:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>, mani@kernel.org
Cc: Frank Li <Frank.li@nxp.com>, dave.jiang@intel.com, cassel@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, iommu@lists.linux.dev, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com, 
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 02/38] dmaengine: dw-edma: Add per-channel
 interrupt routing control
Message-ID: <2bcksnyuxj33bjctjombrstfvjrcdtap6i3v6xhfxtqjmbdkwm@jcaoy2iuh5pr>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-3-den@valinux.co.jp>
 <aW0SVx11WCxfTHoY@lizhi-Precision-Tower-5810>
 <32egn4uhx3dll5es4nzpivg5rdv3hvvrceyznsnnnbbyze7qxu@5z6w45v3jwyf>
 <aXD4ncvjZWljUyxe@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXD4ncvjZWljUyxe@vaman>
X-ClientProxiedBy: TY4P286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 2591d0ce-ca4b-49d6-31d3-08de59603920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sR5IKVaqKwINMMH4NfA4UeEwDoFoww+riJsfveT13p5n5WBTM+hfcbrCUPhR?=
 =?us-ascii?Q?Dvic7xP+qdIcvqyzrRu0d348Hom+Jc7tEOBKY25uLPZPme88jBnaaxmTvWz8?=
 =?us-ascii?Q?nP5EIoXfecFlsJJQ7V5LAdcRFg8tM+LRwp/vXmQwOjteQJe/waGTnMXd+tSb?=
 =?us-ascii?Q?p6On2scaSKDN+Iylzj59keOi8h3GgdKCrTHsKaAxFKEStn3CQs6TK8qu8G+k?=
 =?us-ascii?Q?HGaf7EnmJGsB30IL7GnqmauM9Mi13Md8ZM3DGN6Z3ZBctUCDkDy8+XuPu7eR?=
 =?us-ascii?Q?Lmk1gl+AecfuyGPM08JvxCmEoJwNOYdmIbFu+baE2Y9onyZ0/l+F8cKwgVn5?=
 =?us-ascii?Q?YhSDRLOJgTJnZOPi9TUANSFy9Uy+XgsSp1FhmzOJwVPVPGUSL/gCx5kYo8mG?=
 =?us-ascii?Q?5R2LtwgPjIsAmwMTQsnOIq0NwBQEVphyaV4Rh7OvZCzo+2q913fp1CS/M0tG?=
 =?us-ascii?Q?plRMSN0gWzXILePCymjPUhXfsMcHIh7aYGYhLVEAigx2nIdIoDy5t5rpQfla?=
 =?us-ascii?Q?AMJ0M2XIWS2d9VKU5JrHMnDGeu61Bp6k+Kzne0CWEqEvvn1ZwW8RF3ydYFPE?=
 =?us-ascii?Q?7Sv9+T1ydHgLnwL9ZLfAKIcRdYSc/dAxPtfqjmE1QIkgvWso/r66XTjk5mhU?=
 =?us-ascii?Q?1xLfUaW+sMHAiAwhM535s7Q4dO93Xo81BnFabgbhhlkxcPnq7IXPvPT/Ackm?=
 =?us-ascii?Q?iVB84z7GnWAN5rIoTaHWTsDdXvjqILEN0XQtO+nFl5IHk8wxLPg2U9P+wpMR?=
 =?us-ascii?Q?4T15HkkDM4s8X2y7KcqtZaUreXGUwXLFgnYQ55Nfw1mhlX5qQQ8yBgh1b4Yf?=
 =?us-ascii?Q?eZ735QFDzIlb5KKtCunTU8LFCtz3Qqp6LJsthMLtuOL/iVsu2Mgb1PbVihAy?=
 =?us-ascii?Q?GJQlwOm1M01Uzzf/wPKyrsGtsh1P2Vw0tW+bsuh9ILIEb2OQNzlOPB0QnyGW?=
 =?us-ascii?Q?6vmPHR8QinbiOTRwgAe+FrZJ/YC3HargedpJLHKHPIYpHV4pM/AivZIot8mG?=
 =?us-ascii?Q?kSteg51e1t0mHsWlZXwgodtjRT6SQc6f29fVEUtMa9xnYTD2xOpZpPMys9Ai?=
 =?us-ascii?Q?UuyGYpxy4H5JysuTcPEw55tC9bLaADGR1k5GouX4o+9DbESTUV4GszQJvaK7?=
 =?us-ascii?Q?vEgjpeiYMpyFA8luSFi7zRSW1iUGbVN/A4A+gRHJb9UO/24Yapn9Bz4/bDkb?=
 =?us-ascii?Q?OXmA6X5+9zkXejEsPJNSS/stGqDyyrNifCDCuYUpneQq5LmEwha1Dw/kF93O?=
 =?us-ascii?Q?gyp1sst/jomDC8izUWBZF5Xj+lggzqADQSmM+qQhpa2Q+o1nsN3RAFIKJXnb?=
 =?us-ascii?Q?y+fqRPagxVOZvnAZpqDKkd8spoPY7Lu3jwSGGjaWqE7uzpe7rrmHOQGDQH03?=
 =?us-ascii?Q?vPEUvYg59oo0Kwvui9dEusSidHhXfHkou0KF2xL/CbtavPL2HyetFuNlUiT5?=
 =?us-ascii?Q?lnSLWi2ScH4hvtjppO7TbE2H8JGZpbxBR4vU54TbmVrjjQqMd8ttsXxmf+hJ?=
 =?us-ascii?Q?m/XGTI0awDSZt/ejV5d66SJ7q0E16iBOsp2/voYTZC4ZQ48Qjd4GeRHPQ/Yt?=
 =?us-ascii?Q?lP5x8k8cAosyq+Q9S44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oP06ncj7cHlYa2Do1Ap5a8XcXsIwNKFO15dpH5awV9S5G210OfSWRzNpZpRN?=
 =?us-ascii?Q?jdDkuKQRBu65sTqLYoWndhlN0ww6NCgYvb2TJZ99AoMPcYkYOfhEbSxGYKaN?=
 =?us-ascii?Q?5UkPYhnZN1z9rwv1/WTGhrS0lAxdUqAsRe9ivj8AUYEcLMs65jUP1L/OOkj0?=
 =?us-ascii?Q?s0lubFciocv2JTlWVz7yc7nC2lpjXQEP/iewqg3uyqPlmYi1BaNA+nTvwzWC?=
 =?us-ascii?Q?2YBGqoVbR3ll3GzsDVPhNvbs6ms3f/z6LnZWi7rVFpIuK6/s/PpwbEydOOab?=
 =?us-ascii?Q?5GHNmcTa3g+nnd/SM+/VLTFL6fLgoNTu0NvnF+/XPt0QUsLRnweVGsUf4fl5?=
 =?us-ascii?Q?x7q7GNfFKfAOYtfyS9XmAyXoy0cIzFvg9mmoRqHILYxd1/PRaabaycEFRFE2?=
 =?us-ascii?Q?kkrbdbjNqmAx8pzPerIW35TGGk4enljRwPQs+g7WH3/rU6XWlPMNk1T8WGrQ?=
 =?us-ascii?Q?oDsdov2E42QUcjeEjort8bDKBAqh6wBpTilEWaW/A83hMrIq4JQFsL1Fquv3?=
 =?us-ascii?Q?c2wVumxXIhcyC1/1ONfEbFRTzlmbxWSLU4No+OO8UvXPzHMLm19GIiNGKfIW?=
 =?us-ascii?Q?6QJ1wyVHVcJ36HC619sNS9ai5tRLitAgmVv3OuJIvNceiJvZQjuY7PN8HhJc?=
 =?us-ascii?Q?Uhm0I8gxoyBYpVuC9iF3hrt2RW4YQS9d6ZVrpqziWQsVwe2WVE5zY8rv2BD5?=
 =?us-ascii?Q?inH0gs5as63oHcw8/eojjmEA0M4z88uPl92J05YUAp6n61P5XCJhAD5ibPYu?=
 =?us-ascii?Q?vCSwRfRw5ef9CSqDvemP1RTZjRmlsRGhAX0y/Gr+WaYaU9eQk1TZvJyfvbS5?=
 =?us-ascii?Q?VBtDBiHSyndvqGVB+a52ihNKG7zS6S0u7gVaKCzwqstweoMezgdpMC/sp7Uc?=
 =?us-ascii?Q?VfKrsa33nXVWRMTTfTekM5EgKYb+ocyrUDMrCCxzarF2deliM88OA6Uwof5V?=
 =?us-ascii?Q?W/8DXg9JDIS4ovW0lSLD8GZPaEXM0U3pNv3kcjRYB50s7F+su4VwlatPPlTk?=
 =?us-ascii?Q?HL1aXJ3H809oHp2KHEIv6hzg5qc5rsu10BUNUmLEXnVI59o1uIJ4Q+flumbP?=
 =?us-ascii?Q?P6lGHs95QVi2VLKeadi1rLk+IECkrjOWSuEQshbonFrShjg3riyUxuypyBM7?=
 =?us-ascii?Q?n13JbaJpq5xcQZOJd/C8tT9RJs+f0Xo3tPcbZK7OwCU+Urd6JkyIofZiqQM6?=
 =?us-ascii?Q?WZ6IYeLeW9yeIa+9fm5Ymn0sh3JKI9uxjRcTDGDk9PSdaJ07wOC2IKvLQTSA?=
 =?us-ascii?Q?SERlkHh6YkcctWN8kASJ1oK+hMsIhWLbaugwm/IK8TJwugMTDaqPEiQV9B1U?=
 =?us-ascii?Q?YGc6MpGhz1aI4jJA1HcZmAVCs7fLwaSeIsRC1v6MF8E3fYujEARSzLAXLenQ?=
 =?us-ascii?Q?0sjXjqrEksYEN5DBL+xcHleZ5sscJ6UoVjEwOGb1fN73T3hgEbaltCtimUI0?=
 =?us-ascii?Q?Dky0tnEMZqj9eMbPVp0Hp9cy4Ej2Zd/7NDtasKtFIeGpYH1NPFtRywGA4b12?=
 =?us-ascii?Q?/GeJPgzOkJbjefb+DBk4dP90Jy6HWiFvRMPONbsEn8xLaBHPYKqG48fdNA3i?=
 =?us-ascii?Q?xNjFC9vrkSmGXRAvsCH0JrGtcYjZP7XHBsCq9WmF/6dHVPeBbDWW4XC1AYvr?=
 =?us-ascii?Q?RjmlVtKw1nD5qIFXlnsg5pPxTT1oS+pKQCwTgo/nvoK3FGXYnluq7TS5Qj6v?=
 =?us-ascii?Q?Y0ut6ssDl8yRuQa7U9M9/6AFoEKVxlUOfihIzwhtCe4sqlpRGIcglMEwEExY?=
 =?us-ascii?Q?Im2loV8Q7Om0hubVm1kE18jGjGXLaSuMBOHzNTwuguuNaUFiR/bR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2591d0ce-ca4b-49d6-31d3-08de59603920
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 02:44:54.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSw7GmGOYlPcC3bUoMKXaKvCoKIitKJ9F7rj+DHoWrg20E283VCQN7U7HV1e5RlqffCs3KQdFukEnwHA3rf2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6555
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8452-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6781C610FD
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 09:32:37PM +0530, Vinod Koul wrote:
> On 19-01-26, 23:26, Koichiro Den wrote:
> > On Sun, Jan 18, 2026 at 12:03:19PM -0500, Frank Li wrote:
> > > On Sun, Jan 18, 2026 at 10:54:04PM +0900, Koichiro Den wrote:
> > > > DesignWare EP eDMA can generate interrupts both locally and remotely
> > > > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > > > completions should be handled locally, remotely, or both. Unless
> > > > carefully configured, the endpoint and host would race to ack the
> > > > interrupt.
> > > >
> > > > Introduce a per-channel interrupt routing mode and export small APIs to
> > > > configure and query it. Update v0 programming so that RIE and local
> > > > done/abort interrupt masking follow the selected mode. The default mode
> > > > keeps the original behavior, so unless the new APIs are explicitly used,
> > > > no functional changes.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c    | 52 +++++++++++++++++++++++++++
> > > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
> > > >  include/linux/dma/edma.h              | 44 +++++++++++++++++++++++
> > > >  4 files changed, 116 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index b9d59c3c0cb4..059b3996d383 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -768,6 +768,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > > >  		chan->configured = false;
> > > >  		chan->request = EDMA_REQ_NONE;
> > > >  		chan->status = EDMA_ST_IDLE;
> > > > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> > > >
> > > >  		if (chan->dir == EDMA_DIR_WRITE)
> > > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > > > @@ -1062,6 +1063,57 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > > >
> > > > +int dw_edma_chan_irq_config(struct dma_chan *dchan,
> > > > +			    enum dw_edma_ch_irq_mode mode)
> > > > +{
> > > > +	struct dw_edma_chan *chan;
> > > > +
> > > > +	switch (mode) {
> > > > +	case DW_EDMA_CH_IRQ_DEFAULT:
> > > > +	case DW_EDMA_CH_IRQ_LOCAL:
> > > > +	case DW_EDMA_CH_IRQ_REMOTE:
> > > > +		break;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (!dchan || !dchan->device)
> > > > +		return -ENODEV;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +	if (!chan)
> > > > +		return -ENODEV;
> > > > +
> > > > +	chan->irq_mode = mode;
> > > > +
> > > > +	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
> > > > +		 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > > > +		 chan->id, mode);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
> > > > +
> > > > +bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
> > > > +{
> > > > +	struct dw_edma_chan *chan;
> > > > +	struct dw_edma *dw;
> > > > +
> > > > +	if (!dchan || !dchan->device)
> > > > +		return false;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +	if (!chan)
> > > > +		return false;
> > > > +
> > > > +	dw = chan->dw;
> > > > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> > > > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> > > > +	else
> > > > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
> > > > +
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > > > index 71894b9e0b15..8458d676551a 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > > @@ -81,6 +81,8 @@ struct dw_edma_chan {
> > > >
> > > >  	struct msi_msg			msi;
> > > >
> > > > +	enum dw_edma_ch_irq_mode	irq_mode;
> > > > +
> > > >  	enum dw_edma_request		request;
> > > >  	enum dw_edma_status		status;
> > > >  	u8				configured;
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > index 2850a9df80f5..80472148c335 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > > >  	for_each_set_bit(pos, &val, total) {
> > > >  		chan = &dw->chan[pos + off];
> > > >
> > > > -		dw_edma_v0_core_clear_done_int(chan);
> > > > -		done(chan);
> > > > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > > > +			dw_edma_v0_core_clear_done_int(chan);
> > > > +			done(chan);
> > > > +		}
> > > >
> > > >  		ret = IRQ_HANDLED;
> > > >  	}
> > > > @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > > >  	for_each_set_bit(pos, &val, total) {
> > > >  		chan = &dw->chan[pos + off];
> > > >
> > > > -		dw_edma_v0_core_clear_abort_int(chan);
> > > > -		abort(chan);
> > > > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > > > +			dw_edma_v0_core_clear_abort_int(chan);
> > > > +			abort(chan);
> > > > +		}
> > > >
> > > >  		ret = IRQ_HANDLED;
> > > >  	}
> > > > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > > >  		j--;
> > > >  		if (!j) {
> > > >  			control |= DW_EDMA_V0_LIE;
> > > > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > > > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> > > >  				control |= DW_EDMA_V0_RIE;
> > > >  		}
> > > >
> > > > @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > >  				break;
> > > >  			}
> > > >  		}
> > > > -		/* Interrupt unmask - done, abort */
> > > > +		/* Interrupt mask/unmask - done, abort */
> > > >  		raw_spin_lock_irqsave(&dw->lock, flags);
> > > >
> > > >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > > > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > > > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > +		} else {
> > > > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > +		}
> > > >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> > > >  		/* Linked list error */
> > > >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index ffad10ff2cd6..6f50165ac084 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -60,6 +60,23 @@ enum dw_edma_chip_flags {
> > > >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> > > >  };
> > > >
> > > > +/*
> > > > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > > > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > > > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> > > > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> > > > + *
> > > > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > > > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > > > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > > > + * Write Interrupt Generation".
> > > > + */
> > > > +enum dw_edma_ch_irq_mode {
> > > > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > > > +	DW_EDMA_CH_IRQ_LOCAL,
> > > > +	DW_EDMA_CH_IRQ_REMOTE,
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > > >   * @dev:		 struct device of the eDMA controller
> > > > @@ -105,6 +122,22 @@ struct dw_edma_chip {
> > > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > > +/**
> > > > + * dw_edma_chan_irq_config - configure per-channel interrupt routing
> > > > + * @chan: DMA channel obtained from dma_request_channel()
> > > > + * @mode: interrupt routing mode
> > > > + *
> > > > + * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
> > > > + * not belong to the DesignWare eDMA driver.
> > > > + */
> > > > +int dw_edma_chan_irq_config(struct dma_chan *chan,
> > > > +			    enum dw_edma_ch_irq_mode mode);
> > > > +
> > > > +/**
> > > > + * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
> > > > + * @chan: DMA channel obtained from dma_request_channel()
> > > > + */
> > > > +bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > > >  #else
> > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > >  {
> > > > @@ -115,6 +148,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > > >  {
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
> > > > +					  enum dw_edma_ch_irq_mode mode)
> > > > +{
> > > > +	return -ENODEV;
> > > > +}
> > > > +
> > > > +static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
> > > > +{
> > > > +	return false;
> > > > +}
> > > 
> > > I think it'd better go thought
> > > 
> > > struct dma_slave_config {
> > > 	...
> > >         void *peripheral_config;
> > > 	size_t peripheral_size;
> > > 
> > > };
> > > 
> > > So DMA consumer can use standard DMAengine API, dmaengine_slave_config().
> > 
> > Using .peripheral_config wasn't something I had initially considered, but I
> > agree that this is preferable in the sense that it avoids introducing the
> > additional exported APIs. I'm not entirely sure whether it's clean to use
> > it for non-peripheral settings in the strict sense, but there seem to be
> > precedents such as stm32_mdma_dma_config, so I guess it seems acceptable.
> > If I'm missing something, please correct me.
> 
> Strictly speaking slave config should be used for peripheral transfers.
> For memcpy users (this seems more like that), I would argue slave config
> does not make much sense.

Thank you for the comment. Understood, so it seems outside the intended
semantics of .peripheral_config.

Now I see two possible directions:

1. Keep my original approach (i.e. add a dw-edma specific exported helper in
   dw-edma-core, like dw_edma_chan_irq_config()).

2. Introduce a more generic mechanism than .peripheral_config/size (e.g.
   .hw_config/size), and use that instead.

If you see a better approach, I'd be glad to hear it. Also, Mani's input on
whether or not (1) is acceptable in the overall picture would be helpful
(from a dw-edma-core maintainer perspective).

Regards,
Koichiro

> 
> -- 
> ~Vinod

