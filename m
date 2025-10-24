Return-Path: <dmaengine+bounces-6985-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE5C074DB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FC98580512
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412831A044;
	Fri, 24 Oct 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gL1835xD"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010019.outbound.protection.outlook.com [52.101.229.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145A2DCF70;
	Fri, 24 Oct 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323075; cv=fail; b=KpxCXct0bGFF1VUaFKshkzMTgF1Jd0EUnPK/vtUrsZe4iF22lpJihFpI7ztNgCLKM4culC5NW6IAK/kB0+wly8mpNhsR/iT31630WZA6oB6fnc4qUVVP48ykQK1nOlreU4MH7vF5D4JDscyXk1TE8UCT61N0yYbNdGyv5eJfnY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323075; c=relaxed/simple;
	bh=ScpFeb52LQzwRk06rcbSfo95gWqiWoLZWwi9ZkQ8huA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l+RLdymyYZhJf9pXxFix5p7V8+c347bHdR/v38A90mi0PVSVJEzRdN/KG2g4IdZd4tfZ3UZqffWBKfeG9N1DRx2mBNfRLLmX3DVNhwmKKyXsidPLxzTvootmWDWv9pf/RnwZU28xr87VOaazETqxpgfJfFU2f+1Fu2RRRMDhtC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gL1835xD; arc=fail smtp.client-ip=52.101.229.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szP58OwrRFmUk24JaWgFU8WU0e+uyaZsH5vVjVRs40eO8/ZLGKE+e0S9P2lHMOm2i5Z9Yu4nor5ngG0dk5AutaTCgg0Br7krL2cC0rVRJla0whJBLEhW1TkVTYKvhtEsj65LPLcFHoxWYxnSBRBLOSOzjdoCAOUA01rGjDDeAEFYCtEmVnVYnFtewSp0CiKJvYDXrN765fqXqCavtm64H1xtzdvsiQYrV9X04Ch9EXcbcvOITaXFU+e/x1t+ErEi5Zo952JewVG7v2JnEMMslZ5trGEMxs+wFolTtOA3ZOEI2ceWqENJePrrHQTQrh7y10tkmatSZsK8Bmt8op/LrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd7K3Ytzyp8X4jm0cSdsTHbfiI85c0EQf1K5dwlkGO0=;
 b=ckWyj1gnuMZj04CP/GNUqOUCrW8dmJ/gsEQeawB1SdMfizklU2pn8JvfcXfeaUy8b1ZrIBv4geQ9AQ0klfdi8j8kA/2WyV7sDS2BfD3pfWNfOczbY7H296iBQU7eWdIvKoj2k/cbm0VywSloc92PgcaVM4lg0xscweRiGMgQjtowPWUr4qvnnGWGrfXiZnRw+tGTCtJdgPsyALuq3rc2cXe5283nI/prRdI+NdOc7GMY3b/ojuBXhJjBqzb5TbNdPJMe0T0BFP7QnIQZQfvAn2xl7r17ZjMH53P3qolMCaRLV7kLSV5wEdhNntkkhH7C6ma5foc3QdmxcIOC8vIwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd7K3Ytzyp8X4jm0cSdsTHbfiI85c0EQf1K5dwlkGO0=;
 b=gL1835xD4rfCoZTwBAVJPRPDZwDSFKDrFkYKjM0EbRAkKOTCVJ8e/9cYzF5/fdRL2QQDx8X6jBbfBk0Nzao0Oqm1cjhqVREJM9D3bpAp2Ju1LUvEtElG7anT6d2kvRvcOriHWTizfv8DI57V291Fh905o1DL9z9vTnJKhuGt7pA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS9P286MB6433.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:24:30 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:24:30 +0000
Date: Sat, 25 Oct 2025 01:24:29 +0900
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
Subject: Re: [RFC PATCH 01/25] PCI: endpoint: pci-epf-vntb: Use
 array_index_nospec() on mws_size[] access
Message-ID: <iskqrcn6z2bnfnzrfc7kyy3x3ng7djn4ygral5cjtz3xiet4or@ktapppsfpzo7>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <20251023071916.901355-2-den@valinux.co.jp>
 <aPrDEE80hSLbL57a@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPrDEE80hSLbL57a@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::18) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS9P286MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d2fba5-7689-407a-68af-08de1319ceec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIhMEiqKAQ7qrwjwgqEM/A7vi1fF/ISLTE5PZJ8r4NMaK45BfzoTlJBApaNM?=
 =?us-ascii?Q?FG7Xi+ORGWMWImi7Zj5ixouADxWAEPhrifD7Xx4FT7pOZj9Xv2dhwhp524Jp?=
 =?us-ascii?Q?DosPy/WYRxNm8Di/Yq4lhm+rQyf8j3mF7/jiDsBEWl8Zo5fhmlchT5Rq5zoo?=
 =?us-ascii?Q?dYVovlyiwsZZaYxq8pa6XcxB1VECqhyKBIfYWgt5AFGfCVjY06Qmzn64vRDc?=
 =?us-ascii?Q?a9ettF/C5nnA5NjIP3/wjfI2Exvyi1YAY8V2NyYJrHZGa/WLEqZF9oXsBYBA?=
 =?us-ascii?Q?TgbX31NSSY5GOdnLDcIavHf2uEhPL2k1F5ciI3ASajdFW/tMm/Y+oYHfCPTg?=
 =?us-ascii?Q?r2tBiMtDxDNZTufFlbxB0ImEh3TPdjme9n3nDOWNcGT/ai86Ggzm3Macm6eS?=
 =?us-ascii?Q?AoyzBI0w8d/vlzinOcACoIchBbuCzT7css6530is7jfsJ4pjuKj2GkEDS8i+?=
 =?us-ascii?Q?d6VWhMDBdsobvpKyQc/Ivrwl2s6XTjYqgZnaD1dKCGbiH3mU4F3cLP1Jve1j?=
 =?us-ascii?Q?oU1/C9FJBIGxxrdPvWi4ufVByrItQH9cvZhThtgdnYZ3UoyRoD181mhdIR6A?=
 =?us-ascii?Q?p5zKgdrUPWVxq3fjN+Eb3/gYKL/E0JcePpg83dxyZWmp1rOKhqs2rzcWtVUn?=
 =?us-ascii?Q?YbN43PxxB03PDGWWsDaOsIct/OtYGAtiMj+LccZ0xMFFM33Xm0mJs31YyMOw?=
 =?us-ascii?Q?TFsmoUradi/8PB7pp7lW0aVtz25pa3ZOv5qtGtsP93ND5+UDX+ck1yfUIvJd?=
 =?us-ascii?Q?kWtq9nqDxPN3mFAzr+eU22PvJcwU04v3ogB3IOchdCEDPAMWxI0rZpGzFYws?=
 =?us-ascii?Q?X5FJBDa0xCr16xGLfN5zsr8jayTdyjXPoDAwjK4kU1vYKZGGt5uDE+c0kQj8?=
 =?us-ascii?Q?gchXoh5mzAE8d1CkcNv6U3eljZS61TY/H75h2epAUMA75DstZ0m73Z6gwCnt?=
 =?us-ascii?Q?3FKgWXBiggMZMcKeYBIUcfJE1tXZEjaC+NQb3mmcyPeZpKLQDDhlQrh263WJ?=
 =?us-ascii?Q?HtyIo1KbHBGakfIdU/5kp5MYg7m9r92GnZ04Vpy7LoN7KyrXNcDbH62ddOwQ?=
 =?us-ascii?Q?w8vHsrQaw9XKKzaFxbzEU1KjSvoJpHxdTYSRkbGrhQB1HjO8jfDl4r8qENfI?=
 =?us-ascii?Q?mCElvXpI9nYhFwO0V4GOXI8wfo3g77Sp9Xy7j6M73Y9a6oPh045n2U3hKKos?=
 =?us-ascii?Q?LEd+CK/VREGIZl/QfHdWWd8Ca9YSJnSwWjJ5WJ+CxDunI8vwrP95GqBS2CTr?=
 =?us-ascii?Q?J1UY/gOsIc7vgO+BxROS2vV2ntLvAL+CEG/tDoOF8BwH4GnohIXleRcoC9FW?=
 =?us-ascii?Q?GcWpjh0m11jnsngpvxItYlglt/w18qxhPiiRqKU3ST1fWu0cYbRmAINIDXFh?=
 =?us-ascii?Q?jwmPz5nQzrwM8JhnbuspbCr7xqoq3iBM5gzEE29X/yM78b+V7RRhdcI4Ny7j?=
 =?us-ascii?Q?8dR35WRbkZM1JJop/soGHR2MGFzmCT2Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HufFpWbL5OtSHmU1lYZyd50LLg3Z5aksgazqbNmvf+nGfNTCklGT/ybTUu+p?=
 =?us-ascii?Q?ra7DcwMVPko98hdCtnGpQ2MG3jHKYMROJbZ7smrFhrbDkmQjsKCW+5EW32r5?=
 =?us-ascii?Q?FR9o86/XYu2UKzgDWfHwfxDe9Fwy2IzR22ZlfNjS1nnYPSyxMFoYnXU0gzXo?=
 =?us-ascii?Q?kDlUEXrP+DrHzRyJPDXPhekNUiR8BpKo2jTRi0I+hrz/xahEayVylZPx3qlQ?=
 =?us-ascii?Q?UFiN1JdpsfVpr9jyFvzNMCrXHQJxMy7Tya1wOZ25cDlD4Bt1tjtc/tva1wkw?=
 =?us-ascii?Q?OR9WvjLp+9Q04ZnzZU8GgIxjG52HfnxIrr0mxNHSBpBnSdmGSTjP50RJTmrV?=
 =?us-ascii?Q?kaA4RTM/RYQ9SBdGmMaleCAlf1KjNTpd7Xt0W93ltZS/zch9Bl/P0pw8ZqTM?=
 =?us-ascii?Q?6CjouVyp7bVYniRhg0Wy9dn/G9WAQ/joSRHOjrhznRHaEGhHh5EuFuuHK9Jc?=
 =?us-ascii?Q?xXreA522ChQk08mW0Wvph9fNVSjJDyvyGztagc4yBO5V5EJo86bB3Xtcxm+/?=
 =?us-ascii?Q?04XbKYmdudt7DqIdR/6zf+x8ZWjLHzzgNBHQ8SkILnO4FJPQv/z2Zl6hhH2a?=
 =?us-ascii?Q?O/pl+m/jes8TMB51wsF3RU3UtXy6GJ3bxPCV93G06OT/VI6dWuZOsYy1fsR1?=
 =?us-ascii?Q?FRHktQEVJ46t1KtCh6dp9zwXMFG546Pa+ZjYvWm/RxXNL9Vn2VJjgt4v0GMU?=
 =?us-ascii?Q?65ncka+bUZKFBEEhiJ6H/6AuxXy+Sqr1Z1ber3OimbRSMePqZL7MygChg2N5?=
 =?us-ascii?Q?yjFPnxBSIcpntsFfTdXJ6eIiiug6AodRhf0T75otT4bwOAYH5omjEq7fJt4z?=
 =?us-ascii?Q?FxhkMh+FudHpXelfYqw1sJ2tMke5kYnDEVoBQpVoHW9MM2XKNfCzaUE+6lH9?=
 =?us-ascii?Q?y5DDU3P8NHfxcAtT94He6g138Kudihlcyx5gtUnSZD+VVKsisGltP2ktrGtV?=
 =?us-ascii?Q?IdZxLfc9Uf2ZnOsRPSXoFLpbzmgIMjP/gDUeolXcfo4p7F3ksZvdc7Z69rr9?=
 =?us-ascii?Q?emd+1tHvncUVOiEwm+Q+trkIUS9k5l2MIDJoIGL8RR4O9yxuxsYMnygrZYnx?=
 =?us-ascii?Q?aS5387F2eimQZeQi3NtUhMV8QK6i+/NclKSW/c0zmwE4MM3BTVLu1ZVUwt7v?=
 =?us-ascii?Q?veXsv9MwxTU2F8XGRoLTmhrTlL6IGfN+AjNKiB1HUtl1d8/0JoMjL2RD6bZQ?=
 =?us-ascii?Q?08mC1rdAUd03PxW9Pi4YSYAoBCMDP8RTZEO3q5T8kjO6lqLAzwrwsptc+rSi?=
 =?us-ascii?Q?sLqU1l9cvD1ptm+5xXARqoug7HqreE6quw/ljMG1HsZussM4GygH2vhkQYot?=
 =?us-ascii?Q?//VehQ8n6HWHimhNGMU/f4WkoST8aDqeq6Fr21Q+KyugT7FWKtHwO3omL5yQ?=
 =?us-ascii?Q?zWpThZ/HX+Z1qcI1hUZVS0w+KadIBtaDJN4NdDlRF9D5+v0mlliwuHx5f9jf?=
 =?us-ascii?Q?t3j22mx5Z2UbyuvU2k+9lzmtHGXXxZ//B8w1R94UCLQsS+ZZQzM5Vx/KcIWS?=
 =?us-ascii?Q?WTNfrAkelUZWzlBsQJ7BMboAY1PzXkj0JhwflRdtwkSCIuUiBIePQoucrlz1?=
 =?us-ascii?Q?siT1U49IYZVNj2wmKHO5OEv0Ym7EE/MLCcWVQRDjrHt34PiDitKVV2ApLqAU?=
 =?us-ascii?Q?jiWYmFJ3a4GIxgZM4T7/pFY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d2fba5-7689-407a-68af-08de1319ceec
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:24:30.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q8xMrsoUK7joWpkMpBl+30OVXemVwugsbXmIyIrSjOd9/+Bl7mXEiKqKISHpV7wagwblVI2PpLUiNViQLRqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6433

On Thu, Oct 23, 2025 at 08:06:40PM -0400, Frank Li wrote:
> On Thu, Oct 23, 2025 at 04:18:52PM +0900, Koichiro Den wrote:
> > Follow common kernel idioms for indices derived from configfs attributes
> > and suppress Smatch warnings:
> >
> >   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
> >   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> >
> > No functional changes.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 23 +++++++++++--------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 83e9ab10f9c4..55307cd613c9 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> >  	struct config_group *group = to_config_group(item);		\
> >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> >  	struct device *dev = &ntb->epf->dev;				\
> > -	int win_no;							\
> > +	int win_no, idx;						\
> >  									\
> >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> >  		return -EINVAL;						\
> >  									\
> > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> >  		return -EINVAL;						\
> >  	}								\
> > -									\
> > -	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	return sprintf(page, "%lld\n", ntb->mws_size[idx]);		\
> 
> keep original check if (win_no <= 0 || win_no > ntb->num_mws)
> 
> just
> 	idx = array_index_nospec(win_no - 1, ntb->num_mws);
> 	return sprintf(page, "%lld\n", ntb->mws_size[idx]);
> 
> It should be more simple.

Thanks for the review.

For minimal changes, that makes sense. I'd also like to update the dev_err
message (the "num_nws" typo, and I think what's invalid is win_no, not
num_mws). So how about combining your suggestion with the log message
update?

-Koichiro

> 
> Frank
> >  }
> >
> >  #define EPF_NTB_MW_W(_name)						\
> > @@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >  	struct config_group *group = to_config_group(item);		\
> >  	struct epf_ntb *ntb = to_epf_ntb(group);			\
> >  	struct device *dev = &ntb->epf->dev;				\
> > -	int win_no;							\
> > +	int win_no, idx;						\
> >  	u64 val;							\
> >  	int ret;							\
> >  									\
> > @@ -907,12 +909,15 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >  	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
> >  		return -EINVAL;						\
> >  									\
> > -	if (win_no <= 0 || win_no > ntb->num_mws) {			\
> > -		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> >  		return -EINVAL;						\
> >  	}								\
> >  									\
> > -	ntb->mws_size[win_no - 1] = val;				\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	ntb->mws_size[idx] = val;					\
> >  									\
> >  	return len;							\
> >  }
> > --
> > 2.48.1
> >

