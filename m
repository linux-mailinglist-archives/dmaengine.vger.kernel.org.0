Return-Path: <dmaengine+bounces-7503-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8FFCA4B8D
	for <lists+dmaengine@lfdr.de>; Thu, 04 Dec 2025 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC5E30640CB
	for <lists+dmaengine@lfdr.de>; Thu,  4 Dec 2025 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14F2F532D;
	Thu,  4 Dec 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ByoJyDx4"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B22F12CC;
	Thu,  4 Dec 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868237; cv=fail; b=cM/lR93oDddMtHnVNOQojHdD1/0no314cyTRecndNkDAs5AzT348RjFyMzjQka9ntC+TGYObjoORZDl5g+Y0J53PRVpFMiYsOq6fk1j1nS/WKCwxbStRBHRAilphA5tUnZHelA2gAAKE/7NmLXB5QZ5o9gkKeXd5P5B2x6SVNwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868237; c=relaxed/simple;
	bh=Nmh0swTiaAjrEfu3fD5ShOcW39UrPJc+MIB107+UoUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INw9vjvKLieLuy8Hh33LjsPu843ajs2aUNoDsgs+0E+Q4vOusWfsSYo61TQL0BfcAB6rOG391qOYZc5YS7R+QmqjQyQ22tOMEvs4ZOEYLc+9jnrYuLFq3xBhXXVOQAIEio1/1agqcZG5H4+/rQ5PTxuVaWPLbjuY+ahrWxjUAQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ByoJyDx4; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCU3jkVW2HB2k1fds6/LjPd389ByKAT9qHUUN4RXSUFJ5Q8qTqmasIYWGJxkiLQjMlmp1phii+F7aJ43rUcD17w5wyyIo+Q40uZqHtEnc8J+U5QjUfPQwqAbqH6aIv9Lq6ont6mNZfVyn5h9HWqReG6N5ZyeZXISmjzEWB1ywJ42GwnDW9OrQlKAGaRvClr4itFVA7GhhgTWojacDPFIGKvOgiE1QX0yHLpuw6ZlA20byinrA37gKTQRTd/24WcbUVvAq6Q1KRDqqICEFSi0VDahv6dkU8VP0E8ma1lxV25Ukr97cUOvK/7F4zZGS97aw8777EPaDlP9oft90+qkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nmh0swTiaAjrEfu3fD5ShOcW39UrPJc+MIB107+UoUw=;
 b=nRSSoQE2HyDVieU/BySx9dQaOSXt8Qy5TO1Dm4/O0xZoyoO5YWriHoRyLmMUk3zhMxq4lhF4fe0N6PGxH6KHa5PEY8hTY3EGXvyX9UFDf/zlJ3hn9l46DTtE8nD2SC0xBzojhkK4N/EQG9U1UnUZ3hmks/u9iDqjTPrbrTw63QyXGOfkZlhROFRnocKlhHc7qtyHiVU5RhLf9+8SiqP1oL5H9iJI/FLuvVkguVt6AVowCnrlR6lgSVxR3UggEwAE3DTB8nkjBpFOXANlY4ahMfKeDxoWtcqKbc/ljLVgBwPi5FWgyumdsa2Xg5blQKgK5ABqhFgamXJKsJxrOaKTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmh0swTiaAjrEfu3fD5ShOcW39UrPJc+MIB107+UoUw=;
 b=ByoJyDx4aJBtVxtpwSdrS3ILybdxawNDW+xZ5f9eObLyn230CA+s65je4IU8LXK2uILBf0Rg8LdzA1YC4Fj/kzTHn6aQgLSCUeVGy4G1avJplWy9xQEE3ImJBrg8fcNUnb9ZbKHUUV0++BfDy9ZbhXolqzBK7xtFMlarm5qihQYif4a5abgCJYuHkhAaLQjxV+19AIDh1Ui1a09pqJMpZqhqxLLrnRzOq1MyiqfGqYw7HdQf6fCIUCka1aPqOqBkgn4yAyXzqJv9Ytuhq5l92ps7axpd3TNMksG3yCSi11tb5Xr0F/HYUA/cqZ8k7kVDtsY9jkvrhsFla4fgZiIHrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by GV2PR04MB11374.eurprd04.prod.outlook.com (2603:10a6:150:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 17:10:28 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:10:28 +0000
Date: Thu, 4 Dec 2025 12:10:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aTHAcesTmYkzGiZk@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
 <pxvbohmndr3ayktksocqhzhgxbmvpibg3kixqgch2grookrvgq@gx3iqjcskjcu>
 <aTATWZaiqwNfwymD@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTATWZaiqwNfwymD@ryzen>
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|GV2PR04MB11374:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b80f43a-cfff-48c9-c3ec-08de335802f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/bGQoDqn6P4hwiOJ6vTYcWFuyNMb0Qz8Iefc65OL2hfP/EcsUrsFY0oUS0T?=
 =?us-ascii?Q?S5RDhDBTntQU4Wq456zLHZ19N6GiPnRTFru/iCZNSEh3J+VXfz97f3dTrp0P?=
 =?us-ascii?Q?AWhcNCaWI9e6+O41Q2cvgW+g/RKjQLbH/lmgmLzZTq3KpD15fkPdDagqxO/W?=
 =?us-ascii?Q?/S0A9bJDemgwQ9lsOimlCjP8pQie6fpgt8QMH28M6h726JIElAm4LBgtBEQR?=
 =?us-ascii?Q?zCOX44Afmyn+HhziNMVBrZFJQ5TDOxuZqsqn27W+ebtmT0eJqFTqN7uV9ALT?=
 =?us-ascii?Q?+Oq1wGhvmYdGKPYJO/3sPhw+uD8PLiDIlaRHvTszizzXbrmX2ix7q1Feb7av?=
 =?us-ascii?Q?HKYGz0+MVfR2G7xWz0XcfhSQj07bqt6GUzHDvbOiZM3I0tZn4/aiWtkphMKa?=
 =?us-ascii?Q?hhctmylAeuqvKDCIoYBFbLZgT5DZ+sjFPLsh3tQEBWMFvJrCVIAcFitqhfDE?=
 =?us-ascii?Q?QzJJwCn0+luvVm+bDsrIsytW3tSdvx+Dc1rElcy8d3tvOmeJUUojoZgXVbQC?=
 =?us-ascii?Q?J8Zpsq6i63ER5eCRfhUS0bWD0wE1zlEoCMKdFl3ceBfmcu3AhXuKDsBzOj09?=
 =?us-ascii?Q?34Crc0JfmkOJTjsmcD4UOIhXfE3ZxAXCOG/8WYcPYGzCt8PmdTTLpoZNs5e2?=
 =?us-ascii?Q?vtbmHpn5kz9S4A0cmRYyAXCu3z+QMK6NXq5rFm0qPk3URercdTAmq9gKQUJ/?=
 =?us-ascii?Q?D+pS3HG6X9INtjVA8WOddXYzMScKLjSJUHluxE3N532lHPOYKFqViyjC5Beo?=
 =?us-ascii?Q?3vQ31438M9bGwRtrOyVo4z2UpHE7y0Krd2ooap3zTM9TggvjhKGePkbCWZ9w?=
 =?us-ascii?Q?VjZJoRKrQxlwTKIQ8TljqBSb/bHUWzG0WbZQidI7yg8GlmHLICft2XPk6dOb?=
 =?us-ascii?Q?XdpoiRgk3snTmjgX8znyvSph0RxvLnRjsjc/T77LhZh8uHnVNcGLQoX/1AIl?=
 =?us-ascii?Q?JG7MSLa62zGKd44RCTRvblQnMucbtWbfdc3kiNS2uHqCGOWV/CXAXBCnoou5?=
 =?us-ascii?Q?EK8+yhh1UzGpDyK8ELuydYxtE7zShKyeCsOLvf9anfIFk2Gxw7As0S9UYziW?=
 =?us-ascii?Q?xEWtdTgMEBC4vXsjVC9nZdaAxcqnPzCODUAIWZw7CXZ1QELyUdxzsWKZASgo?=
 =?us-ascii?Q?RXRlxsv4YitMRT/njFQ8ql1/uv8nZ3rxxC7CJvCbGpaLkDIERGBtd17pUOjJ?=
 =?us-ascii?Q?k9iiUF0MDHBNcwuUC47HQv2JybGAiZPbMq0kntJVBLXKco/AvhxAm267OZ7h?=
 =?us-ascii?Q?+/Fy08lDTYrtNZW3Jd51ZlQEzpsZnpJFmWAz01tPS+QeIWJzy4Ci06M3ccdr?=
 =?us-ascii?Q?unmIV7qGbUSqVCnkfMQn6Vqi/RTIgYDtRde8tztfiEttkVLxFhR79JHgJ+HN?=
 =?us-ascii?Q?q837bycWXcoZbi9WipvxDQJmtDMTatYMkNNrcJdOIBB0fUw7lXSPoyFM5920?=
 =?us-ascii?Q?vCSsBmldiu70YQ/BqlYk+QuJO2dkqQmuG6ZFXu8FZ4XPwBTabVG02w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KO1DNZyx4YD5RtjukEtl6CNJDiiUE3YTSudRfT7usFDyEg4WDiiFCNUp8SXj?=
 =?us-ascii?Q?+RIIeGUs1MCZhQQ0houL9ogl5TZL+SP1FUc/mBmkghnS/No4KE9IOMCJnWUk?=
 =?us-ascii?Q?igvva1UGFoc4jQt7Uk0HYVdjWmqdmFC0owPK6V7sNuewEy4WaKfPAns7GQPI?=
 =?us-ascii?Q?6myadd9nRnf00WECPZzKTtoTAM76/8kVoAE0fBtsblUjzRI/v6AG9sG76soV?=
 =?us-ascii?Q?LU+n+VyQgmd7Nm1R3uVv75voxL4XrGi6f2ALSQvj+i7x8dmJ19Up+gF81wvX?=
 =?us-ascii?Q?qPeXRONEDnh4zvRtLsvpzegpCLKOLP1jV4HrMWV8Ta2fLEcZZyxUoOiW46ci?=
 =?us-ascii?Q?oj4ZJVBi98m+1LSIu2wsy3CCygq0gVqzGJR8nmKn+tuz+lY1evpuFkjysE+y?=
 =?us-ascii?Q?NNIUdaC59aZSa86HW+x7Lcr7IFmCQPvYe57GJOz9BRcuTOSSonpDHwvmWmSC?=
 =?us-ascii?Q?d6wSzbzmmx+nd08VJf9tvhL8nm+ok66SMX5OmQnqCF1oHLay6USo3kyFzBVl?=
 =?us-ascii?Q?qIiCaOzcNLJj7nd2kQnRVpgJX8VikS3Qn0C98IJMSUAYrCEa596MYyY21aAI?=
 =?us-ascii?Q?pFrdbJ8qkxF8EHxt+UYy06HKUiwxAnHI6DcZzWnBchhnp9G42PYec/lTtHoK?=
 =?us-ascii?Q?fxFluQN9KCA4WFEmN9pOjBlpqlYPawhaWSEaqW4aVEUM9poR2q9ghGRvEVmN?=
 =?us-ascii?Q?0Ysky841y19gHT1K55ZrmxuGGol/hDsQ6Q7gnYqXfU6fn5eBdJEukrN5vZbk?=
 =?us-ascii?Q?E4Bed+o/osPgqazvK2aYX3t2rIudqnJxt2x1PuAfITf9hq4yKDl/KhibgdvX?=
 =?us-ascii?Q?yc1m2k80FrmK+HeBYbcmGAqMIL8YeoAbEyCKDUsXaC5RSEMvZmRpfVijH1z6?=
 =?us-ascii?Q?4gLOsetlc2LNo8NEFSeFKtRVoxdV1yelg6V2slOYyHy2zVGxkl8jB7GJoZv3?=
 =?us-ascii?Q?VgEllMZ9kzS2y/D/crzVRLIv6m5a77Csp5EVdd0/2lP4BbTqk+Eel8cVWkFr?=
 =?us-ascii?Q?EduOeMeQjV7cxTEmSmgFHwbz9qEm7g0WlHphK+34mObeNGKG36vcBofyg9uQ?=
 =?us-ascii?Q?U2V76k2W31F412jyezlwV2HriPpFGsD9Sx1UJ8fh7pCwv3+NyCCKsn6Lw/tn?=
 =?us-ascii?Q?vgLJBjHiiS8mO9Z3lUy13nChtZnAKHin5Or6KTQVRqXC3YU3RRQ7oGU0wly8?=
 =?us-ascii?Q?cN/Vt87/f3wHhMfZFIajYcjoy3m9qtMOaQ1mZun5/grnr5mXppmqzfC6PVWu?=
 =?us-ascii?Q?Rf3oymuNa0No+6IP7dneiLCpDV8nwLVe9skFMK99Ajuqu5s+1u0W1rzTewgV?=
 =?us-ascii?Q?0nRynkUGMfaM2BCLVpTSQHtOBAE/r0saacQxrps/LpnMvnUo4kUpWeDfNYAl?=
 =?us-ascii?Q?7+VGwjqZUpjbVCTSyqR71OOlFqHqRa6rFbeJubkSyHRQhenJsCgz+bT7B5Mj?=
 =?us-ascii?Q?TVhzBakQUoFZ46mImlkamTx2XzMf1s70dZ4g38RmK3+FOn/1FeAq2gnxyjXG?=
 =?us-ascii?Q?6oOIDrxGmiitjvDqzC4NrsUa8reth7ZaDZ06ky+/CBg5hoI9ErMLRHW36SuF?=
 =?us-ascii?Q?TL6Jm0d1doTVfAxs+tHWfUYOyNZdWu0je4Jd98R+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b80f43a-cfff-48c9-c3ec-08de335802f2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:10:28.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqDx/nkEJHsphxfq75Pg2au403r/aLByWoS22aBLUYdJTqFaQ/so9hShRfxEMrTyAyW1NI6sv4D0s9wRstyAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11374

On Wed, Dec 03, 2025 at 11:39:21AM +0100, Niklas Cassel wrote:
> On Wed, Dec 03, 2025 at 05:40:45PM +0900, Koichiro Den wrote:
> > >
> > > If we want to improve the dw-edma driver, so that an EPF driver can have
> > > multiple outstanding transfers, I think the best way forward would be to create
> > > a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> > > does not require dmaengine_slave_config() to be called before every
> > > _prep_slave_memcpy() call.
> >
> > Would dmaengine_prep_slave_single_config(), which Frank tolds us in this
> > thread, be sufficient?
>
> I think that Frank is suggesting a new dmaengine API,
> dmaengine_prep_slave_single_config(), which is like
> dmaengine_prep_slave_single(), but also takes a struct dma_slave_config *
> as a parameter.
>
>
> I really like the idea.
> I think it would allow us to remove the mutex in nvmet_pci_epf_dma_transfer():
> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429
>
> Frank you wrote: "Thanks, we also consider ..."
> Does that mean that you have any plans to work on this?
> I would definitely be interested.

Great, let me draft one version, I am seeking enough user case, which can
really reduce code or enough benenfit.

Frank

>
>
> Kind regards,
> Niklas

