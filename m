Return-Path: <dmaengine+bounces-7682-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACEACC41CD
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C5A302EE5C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B010346AE6;
	Tue, 16 Dec 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIxWhb2p"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92252346AC2;
	Tue, 16 Dec 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900543; cv=fail; b=IzqI9H70AzLEfQ0hmHXAgn+9oRUTmpVjKnPSTZgVMjCOqa+JdAjK07pxxiS3ftkrycGbsRPURK9hEsUxsxYUZw1HPY9+kpoa7+EIW2D2osF2Bi/2NiddIpt2ED8qy1p546EQgcIEMs0F3122IDnLPkJDkWCehBZV79TzrZx3Yx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900543; c=relaxed/simple;
	bh=5Qix+p47pAyRLzNAcdLgWnZv1iu6g6ylbAJPUA4CLXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mSf6mHLccXMrp+utpOVQmKrXk5eFs2LkWG47nxNcRPLzxU9iiB9J6SJu5D8Y0oQZx5Zube5Jv0Ali51ECP+mFNe59fufCSi+XX0PqS7R8XzuYzzEwWad4Sn90hhjbU1sd72mtmglQIbbi5Ncxk/Lv5mf94/JOduo5TMq8EEn9DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MIxWhb2p; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khk6Kvyw0HvxDPeIJlky/ex/kZMmr93eGfIFg+DzRGEmJGvxb4eeoL81AxoJTQ3Z6Isof8sELimZ4NZgFS4TTqOEDUUdubgrdSyfR1EbOppd2dSg1HM1HAnO2bgTvrQCdkXwLKLU4NgoIJNydykakZlGzENqLRq77B3CyMkxbQh7aF5v+lcm2EhXHkz+oq29DENNO8m2lvcTxKEpLqbnuQILO/I6KWAlFLc4jd6EM7V9OcyMXoLNH0cTOm1QFPFLSQJC+2OAPVlu+DzVAOXgq69nEqgBoPaLK38epE5jIzlGA+GhoEj2qladPN1c1Zwyuc3k48rzY4Roe35Vq+4THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWKRvvQqrWnyJvD6H3w1zuqhISioJQivJla4pZjnjvs=;
 b=pGQlxv5sQibem6bIXN+c3BxmJJPHUjhOwEm/yK1zgf6BGEcekokuAfrKzFKxfP28wd22pcTiqJAtNZxPM7SzkJKj4pvpSLYRPFqhR025R/6pk/2+YBI0vFth2ZNxfPO5tRr++BopXqqpeluUTyYOLn8qZiPMAqtdIaM6bSyPHjC5C2dqmgliZjkF+Z0lg4sAJ8MrFTuoNe6V2HrDNhXd5ULABx8lWwJ/yMHbn9EfAF+BD5xler3s3GzzX3NAPmdb0kwCbrOF1bTc+TMbcIxItV0U2W0u+t1g4q0/bIaLOO6tMTnKtFOow7kwLszri6MEfl+GX/Lt/6k1Sfe3ZDKZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWKRvvQqrWnyJvD6H3w1zuqhISioJQivJla4pZjnjvs=;
 b=MIxWhb2pfGAo2dGS2wGP4AFdrnhCfJ4XFMKHZfg/uxHD/PVUcZ/lbQCvk3cvyDMbewgIfOJhCQOw1gxQJ5srhBSkEILnng6pEmrrvDqsOO5TwOIT7IGvF+QTxIXMM5WbzZBAYTblK/TVsBDB3qqaLbvkJ3uamw2FNNbtTWzX5PdAKZh6gZgpOH2CIip+dWzRgT6mbhQZEUXsCW8jJdzOeqJoh9gFJJsFPmoRSFhjx9t7blsc/hPhX3E8FtJus96kEkerhJh2oT+I53fTzFhyOj0FqhZCVT1tO5llMNyvvoubC0n+BYzx9P6rJWCR9FmpzPcOIqGHU4BsWFz6acgpSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:55:34 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:55:34 +0000
Date: Tue, 16 Dec 2025 10:55:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH 0/8] dmaengine: Add new API to combine onfiguration and
 descriptor preparation
Message-ID: <aUGA7tmDYm1MhRXn@lizhi-Precision-Tower-5810>
References: <20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com>
 <aUFUX0e_h7RGAecz@vaman>
 <aUF2SX/6bV2lHtF0@lizhi-Precision-Tower-5810>
 <aUF-C8iUCs-dYXGm@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUF-C8iUCs-dYXGm@vaman>
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM9PR04MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: f632ccca-1e06-4802-15bf-08de3cbb8c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b9YMGedgganElge629YlXO3Z5ArbwvhE9GEtmKg8WoG89zdHT4l4qhTnw/ip?=
 =?us-ascii?Q?p8BY3AK1ukYexiElBVJHRLlZPSCei2ymhyfoD3sfq9gGuzen8yRxNH8n7nT9?=
 =?us-ascii?Q?Tndz5LxWwD46HjHjEcI/ui2in+Ab0OxdDpTQuKXltq1JyVuGpbg90u8/+6aV?=
 =?us-ascii?Q?t14P7qwOob3TgL/SeT4xPatKEf/cJxqi4m1u+90Gme+n03zKmfhxYN58ue7b?=
 =?us-ascii?Q?6HRAmo8C5fzCXfvD0F8A2KOEfHEBnEUL9/GWj0I7M7oIqRFJAuAkhoRoHWf5?=
 =?us-ascii?Q?7+s0RBVM0vH6KBpSHWsWqVY0P7Vno4h4g70AJQ/V2BPHoyumXhl6chua7raY?=
 =?us-ascii?Q?g65zBsu633+4oK7NN1zSG47w0YO5i987qhBf7ts3RXCYfO47oW02S9Y9LbOt?=
 =?us-ascii?Q?kCB28kPKhR5GY/lhjsKZHiXGgphw+tEByH7qM2HHAAnSzIUK8li4DFGWuvRB?=
 =?us-ascii?Q?PuaROQsPJGU9I5C0VAaTcl29StRZDcKE8LqgRDdTjegdda6+sGMjCFnpdyWE?=
 =?us-ascii?Q?ienWbPGRegxsuMekAxLMmCyXdEgyncEmfj8PVErbtYa9wI8+ZqqOWNOxNfR6?=
 =?us-ascii?Q?21fV1M6uaQAxcr5lR6RR+i1s1xp3qEhuNmsG9oxzjbYb4r/wIPchgCbPJ1p8?=
 =?us-ascii?Q?qQ/HV+fDOS5RWyCPBQebZwQCk9wh6mj/XNpatTm3sMLBmc9CtTlcCiQ+YzH5?=
 =?us-ascii?Q?KaJLEun8nZMRSTmz8oLqXYqct67WsdtgYM8tkaXewWkDoDxUqeSw/U2Z5nRG?=
 =?us-ascii?Q?dabMCwoYWL1ogKlulWaOEqE+XbPlAD2AaQ5JtlNpA2MQi4SxO7KzAVx/gqk3?=
 =?us-ascii?Q?9NxCuxD1aEmA/fD/jSCJztLXXJPSgUymUlcvfLaHtG8usbxyGsjQqAlxksTc?=
 =?us-ascii?Q?TcOL041JcYNUAtNhoDwgkxr/gJ6QAV4XVR05pA0DSChNZ1wEyOIOGgNVBMKz?=
 =?us-ascii?Q?wiR/Y3bpEGe12lXGzgoGfFiOy7kDW/dESeJ0WBYF+Q6kYmUGSLSuMItCobfp?=
 =?us-ascii?Q?NTpVPZpZdOgEFTcFNCgBi4coe7vjpsUj4VKLYv9O7sCkIuZwh0+opF1NCQCe?=
 =?us-ascii?Q?rmNVvC6q3tyCPgrKityzO9h0rQQ7iaTr2nNKvD/SkXfXax6fGjHbYT4lmQVC?=
 =?us-ascii?Q?YF1O7y3MjQ5BHFpHUjWiV+ykGjNRlRyih8ku99q6ee41Gf55fAV2a2NwqJpX?=
 =?us-ascii?Q?GTF3m6KEQlCp+3ipN7PJNgT56oZ98rQ54+W2fGn5hyGCe1gnWG1HJU7t+03H?=
 =?us-ascii?Q?0lJhkM8zJ/IUsK7rurzeXzJPxE1hzTrRn2/gGIBLvZ3kEcGV8yQ93enNwmvn?=
 =?us-ascii?Q?U4VyBfgfP83C1RjWcJAvYCKC61y10YuJH/pSupZrF240OzZsakdPzSbF3Xb2?=
 =?us-ascii?Q?IlKQnfoiIbbnYMge+aHxvlIX0XCcaf3WDDB+sFrLQT9iLf1DNwtwjI0M3n1T?=
 =?us-ascii?Q?auG1gZKtLIyWX7k3uFHkVXJnwUtxlWsO7U/y34fznU1CMCFFIfHimzQbJAoC?=
 =?us-ascii?Q?frJS27drQXeT1hDbGr/pvMwni7+9pBnYVmT5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iB2L/0CIEBXx1PmYT7v9VCUKzc59mBuvpXG1BpauRoOhvxEoyOUqDHOOXM24?=
 =?us-ascii?Q?2sr4IHMvZOUIfo3OHTkVq9ytp4Z/57Y21JxYyzY6dtYHQhgeqUGkCZ9e+B0j?=
 =?us-ascii?Q?SXLBXAMoczBGq4FbzFTG9GdBQq7OP/H4qnGMW+3PwNnHXZ5L+D4yuBlhYx3F?=
 =?us-ascii?Q?sjmiTdiZutQm3f0TiDhSRkPmH7kU9zT8z7DZsSf0LI72x+fgKhGDtq1RyD4F?=
 =?us-ascii?Q?+EpwCrSKXFtMIeyNFDFZWKDd5RDJIJ+SCWBidBUhVWuKy8o5RPyJFhC85JLg?=
 =?us-ascii?Q?vme4n9FVH2k8QPOM2oiOB9+i+BIfMsuTdCvpOvRrLTKuJLkbqyc3Kl4lJVyR?=
 =?us-ascii?Q?GpIYGhDyB7gbjzwmL8ik3IkJbKnvhHKI2sInNJT4Rnkuzptwi0q1YKDxvGC2?=
 =?us-ascii?Q?Fvt2gWsNh9dbBqRvZp9Flq8pe4RHQYWRbIzvrtBhxlEvxM5oYrICD6rLzEGF?=
 =?us-ascii?Q?/GzRtKmHz775CXsnhRo/A5TyK5l7IgrQ0SLiK24TgJiADC15LyiiekFDkfAn?=
 =?us-ascii?Q?sm4VsMUjLcaoswFX3vQlfsIsf8Wx1YjdqA9hh3XunggYpfQ0ChyoZzGTz4Sk?=
 =?us-ascii?Q?nxbLVfc9io3IV6SlM6rWQYHxStrS/eGaltD7SAbp2MNxN8uK8X46A6Q3D2nW?=
 =?us-ascii?Q?7inRk0GCwrS1y4HGCqXOG5Nm0eo85xVykbg8/bWGD4GIvgiwnEQOr9pQpib4?=
 =?us-ascii?Q?e5VXEQ7kdAJI3OwtIAtl3gKU3jfvDF7Tx6b1Pgis1KHURVRl/4v090NW27fW?=
 =?us-ascii?Q?vVEs4yMcM6/76lj8/N8mDIhFUp4VZ1lRv9awGrVNtCASGbGCb60CSIrrxdSZ?=
 =?us-ascii?Q?Wt0aV4PHv9Zk2FnYiArnyel8s3H2l+fXY3NY7n3OTwC+XdoFOU7BRzT3wLD2?=
 =?us-ascii?Q?JqmrooINZD9StVE0JpdO7FH54WvnhZO8zmnWVxcq4kapDBN7uHd7aMkdY/pi?=
 =?us-ascii?Q?bKsImGLong9daMhBaX144GpJburnTgnx0zyYTV+L0iO9+yJGyw7ZRysqTSLs?=
 =?us-ascii?Q?3ykxz+0YwAKUILINgbc9JzPCpluLNqnlQ7NwsYBzEUxezjf7SHMbKJ+5fpGZ?=
 =?us-ascii?Q?w0KbTU85V0A7ZNT72tG2Xz89XROcdZXI7Pvn7tmdqRuQK0b9EOakt0pQmG4q?=
 =?us-ascii?Q?fADPwpW33jyPRfgFzzv1ADu53sSAvIh7fVO5YAAzKH6Pfp+W0GA5zkdWBJGX?=
 =?us-ascii?Q?e49zQj+YvAM2qEstqx5K7t+FHenem3bIDdUE/ULcp3d/KnNgGcobmrCzX6GD?=
 =?us-ascii?Q?bMdDdSZvpRsncQmzWaG4CD0g3h4Z05GigZcRFXdD76IyjD0SN3A7Lyj4c5p4?=
 =?us-ascii?Q?RU1bO58AkBSgw0t/xJ2HSLfnWSCRn3M3k2r0nmBAftB8410reA02tIOQsyzd?=
 =?us-ascii?Q?ZOP8vnBWZU5ya1aA6wbrc28Qi7MasHnuwqmkHPL8jzDvvNjqv3OYiBRRkYTt?=
 =?us-ascii?Q?4sGxPM5Vr3pc+lAIk9pixZfV3oTrbPP8unmsiAjnVHExXxfbx9Zqxor37A7Q?=
 =?us-ascii?Q?YI/AOsdareS6peLQbDnQUUSf/RVrNcoaoZaMDgW+YENxKxkietNXQjlg4alA?=
 =?us-ascii?Q?jq18+gDJCzrTfuarmWmjqOznpXBGfg3PQZgUMwBE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f632ccca-1e06-4802-15bf-08de3cbb8c1a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:55:34.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z55vdi7hIw/1NNMsD4xM83rlsi2JYA+NW9fLPc2Vxb/Q9cBelnwosPBimuKsYwFvkVN7Q6L/OlR/WYiVkedzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8954

On Tue, Dec 16, 2025 at 09:13:07PM +0530, Vinod Koul wrote:
> On 16-12-25, 10:10, Frank Li wrote:
> > On Tue, Dec 16, 2025 at 06:15:19PM +0530, Vinod Koul wrote:
> > > On 08-12-25, 12:09, Frank Li wrote:
> > >
> > > Spell check on subject please :-)
> > >
> > > > Previously, configuration and preparation required two separate calls. This
> > > > works well when configuration is done only once during initialization.
> > > >
> > > > However, in cases where the burst length or source/destination address must
> > > > be adjusted for each transfer, calling two functions is verbose.
> > > >
> > > > 	if (dmaengine_slave_config(chan, &sconf)) {
> > > > 		dev_err(dev, "DMA slave config fail\n");
> > > > 		return -EIO;
> > > > 	}
> > > >
> > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > > >
> > > > After new API added
> > > >
> > > > 	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags, &sconf);
> > >
> > > Nak, we cant change the API like this.
> >
> > Sorry, it is typo here. in patch
> > 	dmaengine_prep_slave_single_config(chan, dma_local, len, dir, flags, &sconf);
> >
> > > I agree that you can add a new way to call dmaengine_slave_config() and
> > > dmaengine_prep_slave_single() together.
> > > maybe dmaengine_prep_config_perip_single() (yes we can go away with slave, but
> > > cant drop it, as absence means something else entire).
> >
> > how about dmaengine_prep_peripheral_single() and dmaengine_prep_peripheral_sg()
> > to align recent added "dmaengine_prep_peripheral_dma_vec()"
>
> It doesnt imply config has been done, how does it differ from usual
> prep_ calls. I see confusions can be caused!

dmaengine_prep_peripheral_single(.., &sconf) and
dmaengine_prep_peripheral_sg(..., &sconf).

The above two funcitions have pass down &sconf.

The usual prep_ call have not sconf argument, which need depend on previous
config.

further, If passdown NULL for config, it means use previuos config.

>
> > I think "peripheral" also is reduntant. dmaengine_prep_single() and
> > dmaengine_prep_sg() should be enough because
>
> Then you are missing the basic premises of dmaengine that we have memcpy
> ops and peripheral dma ops (aka slave) Absence of peripheral always
> implies that it is memcpy

Okay, it is not big deal. is dmaengine_prep_dma_cyclic() exception? which
have not "peripheral" or "slave", but it is not for memcpy.

Frank
>
> > - dmaengine_prep_dma_cyclic() is actually work with prepiperial FIFO
> > - some prepierial FIFO work like memory, by use shared memory method, like
> > PCIe map windows.
> > - argument: config and dir already passdown information to indicate if it
> > is device preiperial. So needn't indicate at function name.
> > - maybe later extend to support mem to mem by config becuase adjust burst
> > size for difference alignment or difference bus fabric port to optimaze
> > performance.
> >
> > Frank
> >
> > >
> > > I would like to retain the dmaengine_prep_slave_single() as an API for
> > > users to call and invoke. There are users who configure channel once as
> > > well
> > >
> > > >
> > > > Additional, prevous two calls requires additional locking to ensure both
> > > > steps complete atomically.
> > > >
> > > >     mutex_lock()
> > > >     dmaengine_slave_config()
> > > >     dmaengine_prep_slave_single()
> > > >     mutex_unlock()
> > > >
> > > > after new API added, mutex lock can be moved. See patch
> > > >      nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Frank Li (8):
> > > >       dmaengine: Add API to combine configuration and preparation (sg and single)
> > > >       PCI: endpoint: pci-epf-test: use new DMA API to simple code
> > > >       dmaengine: dw-edma: Use new .device_prep_slave_sg_config() callback
> > > >       dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
> > > >       nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
> > > >       nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
> > > >       PCI: epf-mhi:Using new API dmaengine_prep_slave_single_config() to simple code.
> > > >       crypto: atmel: Use dmaengine_prep_slave_single_config() API
> > > >
> > > >  drivers/crypto/atmel-aes.c                    | 10 ++---
> > > >  drivers/dma/dw-edma/dw-edma-core.c            | 38 +++++++++++-----
> > > >  drivers/nvme/target/pci-epf.c                 | 21 +++------
> > > >  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 52 +++++++---------------
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c |  8 +---
> > > >  include/linux/dmaengine.h                     | 64 ++++++++++++++++++++++++---
> > > >  6 files changed, 111 insertions(+), 82 deletions(-)
> > > > ---
> > > > base-commit: bc04acf4aeca588496124a6cf54bfce3db327039
> > > > change-id: 20251204-dma_prep_config-654170d245a2
> > > >
> > > > Best regards,
> > > > --
> > > > Frank Li <Frank.Li@nxp.com>
> > >
> > > --
> > > ~Vinod
>
> --
> ~Vinod

