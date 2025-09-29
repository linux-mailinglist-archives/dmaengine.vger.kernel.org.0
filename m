Return-Path: <dmaengine+bounces-6722-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD6BA8041
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 07:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00695189AB49
	for <lists+dmaengine@lfdr.de>; Mon, 29 Sep 2025 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80716221265;
	Mon, 29 Sep 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hDIbHyZQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40617597;
	Mon, 29 Sep 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124683; cv=fail; b=uHSKnE/yF0OPn/G1Lh42o05uO5BxIZvjZa8yDvFpeuyFniXij7b+5XtOzdCGSIF39FoMFxNNaPJh1yDlyyTg1GPH+kseDpJRQJssBTnQlV2h5QN/s4okfq2HeaNuBAtg3598EN9dSwnO32d0rqfqu3Ji4u6SkGSdpuq4mUejcNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124683; c=relaxed/simple;
	bh=E48Ft4gDSRVB+6qao3i6h0wXNV+SG6uiKtjP8ZH7vqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yf9Hskoa3M1M/eeEzbKO7sXMdCltx616Gcf/4jOcSRZLwG0kC3dRQA5nKZl1KwqdwUVQV4Z/iY4Tg0xI6/omVmgwj8vuaZor4ohV2sWsh8SKttyC68Tyu8OsgCXqazNd6Vw9lqWtoxjIxvvBUNOWIH9k0OHbLYRwIL8muRBtk3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hDIbHyZQ; arc=fail smtp.client-ip=40.93.195.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIbmB9dgA7XfhgalL0HNeB/ob1PxeZO9D2gdO8OjhBL29pNDxZY331kfIRyCpThgCwQeH6Y7JiDbwShv+1ibqBx0zN94aAcLXAAzOR01lwmCtqXrdEcdvSEUWH008noqWixhPT0AaT6W0/w37hhq291g+/5xokCQEsuPkmjZTm0P0wehAHKAY8RYsZWfIYPN6nMlO4TT3C4Mxx94Sv13RB+WT6OKIDFd54zfkELxqy294fCCCvDEtuWhl0Jz2CAYKtZwdkmVdeyZ8hAPDEZitD5R5iNqJq4z7NUM8Bi8g6a7rNggVIbA7FqgPrqfDoeMjqbxaHRSZY6V34xNJo3Cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyk3hib54XW2uU5srh2GYX6+IhPJ2KvSHqdswli63GU=;
 b=MfpbvDS75EgNicEa55Z0ynq6i98o+pXBOiv3UPVc8WX53TeJYUbREhXNFAKbVu4L7ZXJzNv1d5yVHz7EXAHEUqLBZflEaoI2ztkxYsXba2MeiPzVDfIbRI1Nhr5hyTrtM+FW8802tB1yt6smK/YcV5zr/pClgSA81V9dC0wtsikuZfF0Htr5jLTZrhSI7/WcpqlZBCjSxyHy/rwGo1G3PqFxCe+ZBzySkS2VidaxTAC3JmcMP6zeGQGshsth3wp6+xSAi08dcTxDk7oFWKCqkZh/uj635oeOxH2wDXISvrTiae8m/6GDiyHmBZ4bihAEpcmWgzLApKLc6iuwtLd3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyk3hib54XW2uU5srh2GYX6+IhPJ2KvSHqdswli63GU=;
 b=hDIbHyZQzjtV8jGVAgyd5w/Ug/6NArgShzXshubcFzNoDzEUh1u5jOAgeFKTl+e8EIA5YYvgDc+x0VzwGqhLsf7xqSasuGylgXDnKde4sHAQXNOGMkP1oTvopOekJNa/Vc6pqTI0zoz/83foq4G/KY5HmxQbN5fjTqAMIapsm6E=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 29 Sep
 2025 05:44:38 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 05:44:38 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: xilinx_dma: Enable transfer chaining by
 removing idle restriction
Thread-Topic: [PATCH 2/3] dmaengine: xilinx_dma: Enable transfer chaining by
 removing idle restriction
Thread-Index: AQHcJ9gR2OMlDWLdT0G4hE8MYuId+bSptpHQ
Date: Mon, 29 Sep 2025 05:44:38 +0000
Message-ID:
 <MN0PR12MB59533CB998FCF1F6D5D343A0B71BA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
 <20250917133609.231316-3-suraj.gupta2@amd.com>
In-Reply-To: <20250917133609.231316-3-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-29T05:37:21.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH8PR12MB7112:EE_
x-ms-office365-filtering-correlation-id: 90bf6a36-1f7a-4fa8-abfc-08ddff1b4798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NXMInXSuXixN/VRABd+BrgbUUaUCQSpzQs9kY6oO55Cy/UdvwD0s++4bHqm/?=
 =?us-ascii?Q?Vg2tVSdN47dl+xgJr0ucLA9kuy0xLRFeM9zpc3UlXw/hh81bomVyPUz+fVLs?=
 =?us-ascii?Q?HYk2JkN9QXjf8iQVdjnC+cl70kUNjH7XOGzLQw3t6EKfySueQEodL8u5XrAF?=
 =?us-ascii?Q?ptQlSZfk5c+lWCItLptej5C91GJqZXsDfW8pAT9nP/TpotP0p//uCmFxiFGB?=
 =?us-ascii?Q?PeWIaHUAFBeRMvMyiv23plZB3+LU8KUS2O2fnPaexJ/HlJx/swAB4Y3AdpHu?=
 =?us-ascii?Q?bz6LF6OtL6rpxcHMVf7P0yxFArTNK68VAUwQK4hHgRyFUoV9nonuS6YzK7AX?=
 =?us-ascii?Q?rPNiZyodRQCZM8mD8ejCybwAKelX05tfliZreHK7Bqd1GkKMpdBQQQk5Ks9Z?=
 =?us-ascii?Q?tPbaclUTiTSdohjpadACcEtLOf5mYD602fyFCnrHo5MnnRQ4jonXnSrttvGq?=
 =?us-ascii?Q?ERU3S1HlQ0zhFveMatz4aMMvuFS5eY+0z+BxhZwuDlZfjZdY+zact5+71FZY?=
 =?us-ascii?Q?Np/YYSmK3uhEKM/RFwN510ceaYW4RVqjUeodHuOTxY6bjCEOW+SMhCDxRbo3?=
 =?us-ascii?Q?PeCY10walkvrKbSwl9K2UCaNv5Gum74IGkju1+yhcmgzUwm9fEKI2qCz1+lu?=
 =?us-ascii?Q?l5HtNNwDtmg0RwPw0wQRz9UcaN+jZEvnYgGr9z7ax1oxY1iKKV/Lf1SgMT9e?=
 =?us-ascii?Q?quUgcaLq+AgOHnVmZ1hES+YF6G7rXb6PAkBojg3hbPkGq5HVLiG6BSdgKIUZ?=
 =?us-ascii?Q?XGd6Q6n5+292MgRzJSB3/thL1T4pB8If11qWmHtN6Gw2Y1pUS3iTHdhg/Ro9?=
 =?us-ascii?Q?T3xQ+pf6z9iZ6gXC/oxzh3v2+VzHcvp1MrjHc/YDuq381FwJtnIQpp+ctqwy?=
 =?us-ascii?Q?khsfjNujZSJueNOesXS9zZVjJczU2/FVd6hQiPSVnUVcD1nnE/rLvuIuNm9S?=
 =?us-ascii?Q?4htOEB8MoOh8GtTbBbIlzO528jTUu4pWAIUv9yGgG5VpAdzAJyl50W/mpZob?=
 =?us-ascii?Q?0BMDjyC67KvtyvCRsHog7ylo8L3hN036/+FXhBadOQSi/BU/hQlGjPW+j3WW?=
 =?us-ascii?Q?15pZx/CSRAILtZB2ktmtpkm3wOzjNz3+F7dZVbZNV2iebZVB2RPhYgZUEdEh?=
 =?us-ascii?Q?lDOmgiEPjna3uLMAxkk49wiMhzAglKwI5v11zF4tBh8KaMztc/fyx6qAk9PX?=
 =?us-ascii?Q?GO+S7hjLma9iSVUz4F4NqkfaD3zcU2h/ITf20LTyQPBpH2lPEIBJKamUKNqe?=
 =?us-ascii?Q?wE9L4VBsUh/8i1wzDmT6IFEmyJAp7fOBmSVvt/38bSCCLEXuPCbHa58uFiJ+?=
 =?us-ascii?Q?CaFcSGbwkHodGMFd+5sTrDPwlB/gg66MgCth2UEFak8N0wKkYwcDj4nYr56f?=
 =?us-ascii?Q?di9RyTUGzuGLGHIRw5IBLTDMZJnT0/uh42/4jNrQpc1CgYcAgblIPn8I2cv3?=
 =?us-ascii?Q?C0bz6pUisnF5RAL89VMyOpmVOC+xlMprFk0AvnGEr16A6azt9kfkYmlOc08l?=
 =?us-ascii?Q?KeMjp74AJpfGQaIaaJavRSOWQKI1J167CLg9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Qw3LJHEx/pU/E3y3pfqsRRSBhmuTk61yei5qMNm97rDUYA3fBRmSse0uuh+?=
 =?us-ascii?Q?lAmu7ZYqFt5NAqi4kqmnj3JPlUY94ed9sRrt3BdIJbDAj4YdIhW9QFMZa0aa?=
 =?us-ascii?Q?GE/JA0xM7nUk3JipQP59GByAV+NnjHK4Jl5D3qHlahD2OSrXqyKW6GrECE7l?=
 =?us-ascii?Q?R/PGVavclVd9FVt9uGSZjMhbbyCZK+4KBpFZqJPdQdcScY9G7fSJQ2cJFDGr?=
 =?us-ascii?Q?KbovcpoXEI77G+Bp4I2BLiZ30g4IYY9E4H9lmj1EGCAzm5ZhNNZdRP47LqOh?=
 =?us-ascii?Q?WzQA6vBhnSFfBGhQPempgwmI2n5GUZHdHfLzq5USMKx8gW1Lm/49GAZpnfuj?=
 =?us-ascii?Q?rPlkyDG5nPQa7bso1MueQDrAvTqyAsvPGQzEBJ16zgtu9Yfn/rMDISEoHUEc?=
 =?us-ascii?Q?hXPyqUpFlBdpDv45fd4r7lXIGWKh2Zm/mO0X/+P/HCq6zc0LoJqp2TVXCvPb?=
 =?us-ascii?Q?DxMuG4FxfEIFlh8/qvTd5fG/IH4rXHSS5ebyJGu/n30KWLPGH+ICZH98LADy?=
 =?us-ascii?Q?2TcKXH9gBu61wKD2m8/fkijSJK7AfGc4QCz038lgc55SocNuoz1iL13Dp0Aj?=
 =?us-ascii?Q?dDMyu6iVAPBp/74WG7K117DWV0oj4YPt19yXdOKdynjoaAuJlxZ4uNtRTwjb?=
 =?us-ascii?Q?lq8sySVc3rtrJaiCtsWZEvWguRHrLwziQ0lHAKGx4URRCZjY8QLOgdfJi5B+?=
 =?us-ascii?Q?6w0TahvWKo1AId+s9ztYZuPTRQVAWudSx5Zd+v1/yZuzjkpiMV4lrz97EZGa?=
 =?us-ascii?Q?1iepiyKoys2H65JUamnuYgq0u1XmkB4BhcGRqcUVD1QkDALQrarYGIrkTP5i?=
 =?us-ascii?Q?msltk+F69MyKNgrlWkQm4KtqxckKpL1tW9MImOiE7L5UgZjjTQnZW6OWSgBe?=
 =?us-ascii?Q?fbU9XBMBQ4RrplVqr3BYUZH8OxFnQ3wf5wCtPURieodjm9NT0mt58i233KIX?=
 =?us-ascii?Q?vYplwca63GcH1lzFhcZ0mazJ+iK3hc/QhG4TekJ+0WO+XPzSihrketPLh332?=
 =?us-ascii?Q?KWtI7BtRDztakb+8fR7t/BOXkuWUElzVZIFhabxq/wF3/m5Ztn9ozGzdKkME?=
 =?us-ascii?Q?XjbM4YcL5t1tjJ8R8wrBBblHQqv/8ZUaFQ4M/JfDktBwX1Y6qN9WCwT9K2vE?=
 =?us-ascii?Q?VhjlxXZT/7MC/ENr+vtZJekQ3bay0oQ7vW89284E0kaRaRrVMHKuXrkcSxFG?=
 =?us-ascii?Q?Gf61TsjF7OYk3h3F0UWZGPogVGJnuFtgn45ulYVSn3meZ4q2O+gMsjElriXV?=
 =?us-ascii?Q?XWtRGrgr0UrLJ42uKKIAaVWXADLxD6f2ztHfDezx1NLU8v/HPn/09nuyhlKp?=
 =?us-ascii?Q?5/gRMMuYaYF5fgMRkwG0czkraWFu4EzxmsCzvo0Cq1ELSyCyn2hee+aSI36F?=
 =?us-ascii?Q?LU8zNpzpU8xf0Y6TCun4VNW9ff/bXaXRyTBsR5PnvKQbf4pLNV7iS0KUT1pc?=
 =?us-ascii?Q?U38Duv/2NH17jLaVaF/MWT73MEAl7m556eWRDuoTpX1splb015Ri4ncQYOuQ?=
 =?us-ascii?Q?UcrE/KW2BCXkp73jnmRAcnRcmYISIS17S6V7j39+DXh66Y6k35ktSsRUZ1DG?=
 =?us-ascii?Q?3wcN7ysd67C5/oH6RwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bf6a36-1f7a-4fa8-abfc-08ddff1b4798
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 05:44:38.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yn8ip3vg1mRU5HxW61lJrYOrK3bqthzaJVV6oACBUGTOf5pK5drzdCg2EGoSyogC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Wednesday, September 17, 2025 7:06 PM
> To: vkoul@kernel.org; Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> Simek, Michal <michal.simek@amd.com>
> Cc: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org
> Subject: [PATCH 2/3] dmaengine: xilinx_dma: Enable transfer chaining by r=
emoving
> idle restriction
>
> Remove the restrictive idle check in xilinx_dma_start_transfer() that pre=
vented new
> transfers from being queued when the channel was busy.
> Additionally, only update the CURDESC register when the active list is em=
pty to
> avoid interfering with transfers already in progress.
> When the active list contains transfers, the hardware tail pointer extens=
ion
> mechanism handles chaining automatically.

As we already have changes ready for MCDMA - please merge it in v2.
Both axidma /mcdma will support axistream connected.

>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c index
> 9f416eae33d0..7211c394cdca 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1548,9 +1548,6 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
>       if (list_empty(&chan->pending_list))
>               return;
>
> -     if (!chan->idle)
> -             return;
> -
>       head_desc =3D list_first_entry(&chan->pending_list,
>                                    struct xilinx_dma_tx_descriptor, node)=
;
>       tail_desc =3D list_last_entry(&chan->pending_list,
> @@ -1567,7 +1564,7 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
>               dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>       }
>
> -     if (chan->has_sg)
> +     if (chan->has_sg && list_empty(&chan->active_list))
>               xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>                            head_desc->async_tx.phys);
>       reg  &=3D ~XILINX_DMA_CR_DELAY_MAX;
> --
> 2.25.1


