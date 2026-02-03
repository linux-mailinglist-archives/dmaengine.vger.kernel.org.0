Return-Path: <dmaengine+bounces-8699-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKzEEvlWgmntSQMAu9opvQ
	(envelope-from <dmaengine+bounces-8699-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 21:13:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8693BDE639
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 21:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B2E3059FFA
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E30368294;
	Tue,  3 Feb 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tb5zZeEw"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43D7261C;
	Tue,  3 Feb 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149622; cv=fail; b=alx1ikC/hq/xoZMgDZ9TTdukdonw92+sGKjv9hZaE0m3UQYOb8o7xqUUxODoCY28/mT5fG7kRcUVBlS9UIH2sKUMpbj0ggny+VTITiv4k5+/lKDexW2ELkI+t36Ud1SSgBbe8xcFCQjjkjvntCiJxVeBrFLzjFmitEtBWowidnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149622; c=relaxed/simple;
	bh=cmyuOhpEWF1OUu5cf/XH0t+Mhmy4XsK9oyWxRZQw1Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZcgqrF5zjsNSLPmLMBYmBAYldGnSTsnHOVAXqy5OeM5FnWFgGREhzg79b1xEr6b52hqu4Mw4+TsJwY+qZMvxDvoaPFV/faGyuSoT2WsLbxKAEEln8RtOVbFZdNCfNPtnpumX964L351hSZ/ycmElDanVhV0C4JrMCOntWTCnCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tb5zZeEw; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2RupU99OVSj+vovrJQ8xhuyiTO3pbjG85qahe1v74KqEJp+YWn74y6SYx0f8a6HAkau1G3NytvcSyxs2JjWCepO5LPcYAueBsqWVSzD8FY+TupbhQ/jnbtIXdbNq+lxv3B+/HxKE4mIApjJzr2ghv46c5IwFHR4ViGtk3cUeJsAzdl/bRN2Aarw+EVwJx5VATjORZHuv7pWlrdELV/nWlcCNinEahyr4UHyvvcKiJJz2h9m/cR4Cg4gfKQ8dL7/6YmY0XNJGF4JuyaDIqyUza/J/n/6tUbSHNrKZIN3HFc1phrEFu3OKnFrQiS/BFyarLmQInHyx0Znoj9IKc/wTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB6DphP3BcfviNy0PXX5j52csyvx7amoUb9PFt5EPtw=;
 b=hez4tDsQB9TPuA+hiNXSfUfGmowDwQbP9GpEXoi/5M//4BtFoxYAQR6PRrQAxbtqmSQtftRx73NuYX4BGwS+jvHm9zU63rJRENbfrO1TYWtwVmBw63isd2AmU/jMzMPMfTqIiqobXCZld0drNvs1YKJVwk7lRln+l/wPAUaH0P/NPZMAiVtbeAg+HUxhww5KThtmibTyANTsZ8NPTEG4kN0C+FnwqfUmSixxoruoJBmsX2huaNVbZeHfHPUZnNVlIafNoA7yuG+bnEafpfQ2J5QPrVDGyoznmKQNscd13fXraPDRx1KVAfRK9tGRcDJZfasqUsQG3mvkw8BRQ5clsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB6DphP3BcfviNy0PXX5j52csyvx7amoUb9PFt5EPtw=;
 b=Tb5zZeEwAUt2hz0BV38i4E0WxIb6rs59WZZKkYqnvKTXIoAGc5vy6C5QVex0gVvPahGRiYc9LYmI6BW0lJwH6Kwfw0tUvjMZKd9SkxXoH8KstFHtiBR1L96NbfDNp4AB0QnyeqFEAaXibjtkfbf7/e/IWGk0UxIUjRRbFNa5G0AdjzgBy1BxcYWjOrVBVsPPFFdbzMpXo86zHg73VvOtM4ifpGyMfX27mE06OmeOjPQKMws0g1tYw45Mitamj409TaOVBMVIw2AOdUApMVF9+REmCrWj/uWowTs/rDyQ+5RnKxavT6T1HWAHYWhrKKBQ+XhOzudixhPrBFZaDuZC9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10900.eurprd04.prod.outlook.com (2603:10a6:150:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 20:13:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 20:13:36 +0000
Date: Tue, 3 Feb 2026 15:13:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
Message-ID: <aYJW5+975pmkyjne@lizhi-Precision-Tower-5810>
References: <cover.1770119693.git.zhoubinbin@loongson.cn>
 <20d52dd26c46f4850e7d5c5443c0efef6c4e4c1c.1770119693.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d52dd26c46f4850e7d5c5443c0efef6c4e4c1c.1770119693.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3982417d-c462-424d-ef46-08de6360b67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y85PCjLAAp6md7OKW/ZuJIvQc+XxHVid/Hqix4bWGOTRKiK7Tr91Xwcedad0?=
 =?us-ascii?Q?G2QXL4V++Uw8KPsrVxzR2KL5CeDhKidb4Pj4cNHSGmaX8HKfZUButz/h3Fj+?=
 =?us-ascii?Q?BOGl5/nzDGECoclTVG1pOT9cWbIO0aDgN9MM/412rTwtZSGdjs7XYj5FAQ9d?=
 =?us-ascii?Q?68gPW+4sWrtdJNVQtJEbqLrd4Nb1OoLzqBmh+xsZDJ2X21Yqq/REKjCF0QBp?=
 =?us-ascii?Q?QUEAUXgXdqwO0kEM2SgO1DQFA3LU73fKe578kewcR6wXwuUPCDkhcGozNiyE?=
 =?us-ascii?Q?uy5S9v++Hfb0vM99h58oGKS36XEfDZAXNr4vz++jS8l+clIzSfft/ShMI2mb?=
 =?us-ascii?Q?iWKAvBcUNy3Cbk6F383X+NvJ/NtVb+wHVNnXjXNI8WJvKQjYUnA5KGOg3UX3?=
 =?us-ascii?Q?AyJFUtjTwBtmmI+h9fAL4pu4/2BK5fH1cVclS17LH0QRlo9qf5THHZn55dRV?=
 =?us-ascii?Q?7n4cuMkZDPwcvrxOmcb0C1PKqoXUbx5rNZ0YBsiH/4j5+KBayEWKsUxkZFcr?=
 =?us-ascii?Q?mMhvqoEqMUKlpSs1g6SOf1sxSnRYJTSdcHQL4ZJ9krPVpsJruW7ceXu/so7i?=
 =?us-ascii?Q?jr4TmN7qPI9sG8NlzSmpA2C3HJ95rH8YV6YWrcIDvgpCxP95jXeuLJHGPFoW?=
 =?us-ascii?Q?54UpbMsGtGLnRQ65yykBG0RQ7HiCFmOJZoplGB+5rmXyHp7zGkaAhOtgBGe8?=
 =?us-ascii?Q?dCJ7xC586+O4exx63d6Qq/x8Hv2Bl24ILMajSyRSKpmRJ3S8q8+VeJ+fotxW?=
 =?us-ascii?Q?RnEEkJq01/qwlVbSzmuPrvaLIq+UHi1DSsKCVmcaRivwSSn8fa2vmqxFv/Dg?=
 =?us-ascii?Q?XzfVIrRR6a9CQC4L1E9pFesv7xHsyz63lyv7RU4LvtbGjASu+Ev8bqSuoGoU?=
 =?us-ascii?Q?Lgi+T42s3V1hId8nKH9A74Hy5sD3WOuBmX7crCj2Z7PJDrffA+YwINJ0VChI?=
 =?us-ascii?Q?OYe796LoJqcqL1kn54OOEtk9wsqaCfkVq51HCe/F+5u0IeNGZOStaTQ6IkkN?=
 =?us-ascii?Q?g0/ziGLYU2LYA07SSLr0WEK5r7hX260QVkTQuzSRqt5U8Ubr8ditjYSOz0Wb?=
 =?us-ascii?Q?xIxufSq6MOeoMMSJQFJp3Jb9yYxKWq3gXdBZYb4sdDGn4rtGkxLCAj37XKUQ?=
 =?us-ascii?Q?wafDnozE+NXgcCoecwp9EivlmkQ4Vqav+aoFTkx6IGwi1ZoARUpUyl4hcIMe?=
 =?us-ascii?Q?MbNVkxdz+jFKUWvVDvxBO9y66OL+LkMFpSBa3LbBfR/Ap5NslG7dQA3kUEyQ?=
 =?us-ascii?Q?6hsfoprOHlxMgqlS510d9tvXcZM7rBN7fvlsPG/cPA9Jct9oVL7+SdQyXXX9?=
 =?us-ascii?Q?8PahWqVa3pW0W09XkV1KgG0C2IcHpsdGht8LJvPInY4RYjloU6nhcJq4vFpl?=
 =?us-ascii?Q?CEwf3DB0fOXH3IYAU0cO4Og0edjhkHokUnEh4etcVJ7t967Evy8zqeog4qOz?=
 =?us-ascii?Q?SuWIpVU4MtdVWBqNTDHyjk/x/VSNKEDvvzYUnXcAw21KM8YOyDkKrnykQMEc?=
 =?us-ascii?Q?AqtQ1ehrDzbQD+wsYA8iXavjluXzZ+qyW2AWOYsYxGJ3wJB3fLr+3xywLig3?=
 =?us-ascii?Q?iWKk6VvlnMhh47zMfK8zrgN79GaRwALA24d/VcYB1uQLFMJEZdoRrlL3ivka?=
 =?us-ascii?Q?8s/4/qVdyYWVtmf5TKw3jT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3J6Wzi8zGV5VSkTSSJTp6huKF9e/rtbv6jKX5CVQKcf931JAjBfFfldAeCvy?=
 =?us-ascii?Q?UO/MhOHKy6DpHNsxaZ5LYj+eClvEeaR6ePCFiF7XvlUn232r7+nlw+O0fcxO?=
 =?us-ascii?Q?E5rtQWdBX2e+taIUtwORNZAWqm5ZfLK5sDbdtN2ttkLbGPFVerh5xHDp2VpI?=
 =?us-ascii?Q?AUeo7aJbc3D8nHbJP9KVf90TuP/0EXoe2T/D1pSo4NhdwED913IqNq39Dwt6?=
 =?us-ascii?Q?thxCd7lm8fPsrSZwx4/EhRu3UTWTbzNE0CEGdIuN9JCygnkW+KPIH62lpCKq?=
 =?us-ascii?Q?FwxqlhCZ9E6kIlSZ/9PQq+Wj86nqzHPX73BforRpYlqYc8lKjEqrpx53zrxD?=
 =?us-ascii?Q?aXlCgN5xBpZZT6e2c4Kz0NSsL+UjrNTWdmwEuj++h6S+smd+P8uREqK0fA49?=
 =?us-ascii?Q?oKcg2tZIxYnfMz/LZ4+w+r0/G7pFZPDuwL/jX4e2k4gJRdRz5zYm4XnYu3Kt?=
 =?us-ascii?Q?ydOaHU7RLpPlsefNVt5IgVlKOiujMg4J0oDRj9sK6AD9Eqt8CcFzPDPIpu2p?=
 =?us-ascii?Q?DhalKaAWq/BsXwqx9vAzZNhZzfpRICcCuZga5AK9p1oJpbnVoUuwiO119wiK?=
 =?us-ascii?Q?8c8ToCbDuCE0GuzRfxz83Dl1n5/AyWimwZopmE0YNNxbEtqms1H04vEZM7H7?=
 =?us-ascii?Q?jhWy6dOyUsAUubclHWLJlKMwKh0/zchdnMvjSVtm6VmT/YUSkWu+CZU/PHcl?=
 =?us-ascii?Q?clk2xZB9ScwyaMZaGd6KNOXPGDR3yz8g8SK0fnXZqCMEO/fw4AnacIjs/4Cv?=
 =?us-ascii?Q?minAfzSFXkdI8cFFVlUpE+1NGJas1Dxup7nZJVRzgvXQ8RQuxpzv9Kx3Pq37?=
 =?us-ascii?Q?ejOBn1ZCJ7ENi6GesDSxcpIhGcVJVsBEc/jCxey98I2qQA5p98Kfc5ADj+Br?=
 =?us-ascii?Q?nHajfuHX6uLaFSjzFmb0C3ik2mD/b+S3E8kfQyZiElxl1Pj1wVxFpw/T8hXU?=
 =?us-ascii?Q?FVIOFgGO0tt08jt9bflo059feI35lPmZ14Z8Str9AcAq4vtnBD/MPk+5vhNg?=
 =?us-ascii?Q?+t566AwCkbbqkjImeH2R8xHhvkPmZnr8Ife6qKwPmX+J+zJ0Iq9thjkcCdGx?=
 =?us-ascii?Q?L/0aVfltDPCaXyMuEveu9wxNki0k82SQppJsxv30hTxaeW9yEOyf2hL5jMNZ?=
 =?us-ascii?Q?1VEsUq/HBe2u0NtlPJghA+VA/8L+AjnFEyqByF3+39F7CiDqzuOGmJv7dZYN?=
 =?us-ascii?Q?0XApX+1iEF38t/ZNF5zq4f0bu+bdt+9QEsD5jKdFfNUhQCrTDzoGCcZp6JNK?=
 =?us-ascii?Q?vdXWz2DePxe9RxZUQTMd2ls1ly4ZIhjxzvB6ywZA7MR0DUN29rftnYXveZcq?=
 =?us-ascii?Q?doqCdbIjrv1Qq6IQl+Q9FaS4ie25oq9lZtPEQkYJ0LvbCp2cj5wIHetaTcMg?=
 =?us-ascii?Q?+nw8XKytQLxmgdWNDcnRmglHIdQmSnsurQrHhISkV3E0Rd7Vgawtvd/ZqqSF?=
 =?us-ascii?Q?DXNBjPg23Vg4FCEDi/51Q4Y2YByyePhys1y7vU8yqibLvaqs5KRRSEGNgxRh?=
 =?us-ascii?Q?O2DeUhEPUxdyMpooctuFUqtw71+FXF7MpF8gB+mdinYOzMG0DC0xj+yoSAcq?=
 =?us-ascii?Q?m6OX0wTVV2wtg7zZC2b/moiPZhMojQSxkulLsSHvt9Lh/GuBvOzS3XwZF/03?=
 =?us-ascii?Q?M/R3oMmwkDg/YTJeO2EnaBMr+kYyeQonqiGtJgmfVPjnEVl8vUyD8ic7RwcW?=
 =?us-ascii?Q?2f8TcYIA9NQjzPQKBJdr7crWilYN/HRYSapJEg1BBXEYsstWJsK2hYN1jSRD?=
 =?us-ascii?Q?x45NTsxP3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3982417d-c462-424d-ef46-08de6360b67a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 20:13:36.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqI+Eztbdx6qQPoM8yBrTV/Tc4Acfzu1yfykpCyhzcNCkHz9LpsxfOdid5TiHKIm27PgCU06XbAMKOE0kiq1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10900
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8699-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8693BDE639
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 08:30:12PM +0800, Binbin Zhou wrote:
> This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
>
> It is a multi-channel controller that enables data transfers from memory
> to memory, device to memory, and memory to device, as well as channel
> prioritization configurable through the channel configuration registers.
>
> In addition, there are slight differences between Loongson-2K0300 and
> Loongson-2K3000, such as channel register offsets and the number of
> channels.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                                 |   1 +
>  drivers/dma/loongson/Kconfig                |  10 +
>  drivers/dma/loongson/Makefile               |   1 +
>  drivers/dma/loongson/loongson2-apb-dma-v2.c | 759 ++++++++++++++++++++
>  4 files changed, 771 insertions(+)
>  create mode 100644 drivers/dma/loongson/loongson2-apb-dma-v2.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16fe66bebac1..0735a812f61b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14777,6 +14777,7 @@ L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> +F:	drivers/dma/loongson/loongson2-apb-dma-v2.c
>  F:	drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> index 9dbdaef5a59f..77eb63d75a05 100644
> --- a/drivers/dma/loongson/Kconfig
> +++ b/drivers/dma/loongson/Kconfig
> @@ -25,4 +25,14 @@ config LOONGSON2_APB_DMA
>  	  This DMA controller transfers data from memory to peripheral fifo.
>  	  It does not support memory to memory data transfer.
>
> +config LOONGSON2_APB_DMA_V2
> +	tristate "Loongson2 Multi-Channel DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the Loongson Multi-Channel DMA controller driver.
> +	  It is discovered on the Loongson-2K chip (Loongson-2K0300/Loongson-2K3000),
> +	  which has 4/8 channels internally, enabling bidirectional data transfer
> +	  between devices and memory.
> +
>  endif
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
> index 6cdd08065e92..f5af8bf537e6 100644
> --- a/drivers/dma/loongson/Makefile
> +++ b/drivers/dma/loongson/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
>  obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_DMA_V2) += loongson2-apb-dma-v2.o
> diff --git a/drivers/dma/loongson/loongson2-apb-dma-v2.c b/drivers/dma/loongson/loongson2-apb-dma-v2.c
> new file mode 100644
> index 000000000000..6533a089d904
> --- /dev/null
> +++ b/drivers/dma/loongson/loongson2-apb-dma-v2.c
> @@ -0,0 +1,759 @@
...
> +
> +struct loongson2_mdma_chan_reg {
> +	u32 dma_ccr;
> +	u32 dma_cndtr;
> +	u32 dma_cpar;
> +	u32 dma_cmar;
> +};

needn't 'dma_' prefix because it is already in loongson2_mdma_chan_reg.

> +
> +struct loongson2_mdma_sg_req {
> +	u32 len;
> +	struct loongson2_mdma_chan_reg chan_reg;
> +};
> +
...
> +
> +static struct loongson2_mdma_desc *loongson2_mdma_alloc_desc(u32 num_sgs)
> +{
> +	return kzalloc(sizeof(struct loongson2_mdma_desc) +
> +		       sizeof(struct loongson2_mdma_sg_req) * num_sgs, GFP_NOWAIT);

use struct_size()

> +}
> +
> +static int loongson2_mdma_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
> +{
> +	struct loongson2_mdma_chan *lchan = to_lmdma_chan(chan);
> +
> +	memcpy(&lchan->dma_sconfig, config, sizeof(*config));
> +
> +	return 0;
> +}
> +
...
> +
> +static int loongson2_mdma_probe(struct platform_device *pdev)
> +{
> +	const struct loongson2_mdma_config *config;
> +	struct loongson2_mdma_chan *lchan;
> +	struct loongson2_mdma_dev *lddev;
> +	struct device *dev = &pdev->dev;
> +	struct dma_device *ddev;
> +	int nr_chans, i, ret;
> +
> +	config = (const struct loongson2_mdma_config *)device_get_match_data(dev);
> +	if (!config)
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32(dev, "dma-channels", &nr_chans);
> +	if (ret || nr_chans > config->max_channels) {
> +		dev_err(dev, "missing or invalid dma-channels property\n");
> +		nr_chans = config->max_channels;
> +	}
> +
> +	lddev = devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), GFP_KERNEL);
> +	if (!lddev)
> +		return -ENOMEM;
> +
> +	lddev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lddev->base))
> +		return PTR_ERR(lddev->base);
> +
> +	platform_set_drvdata(pdev, lddev);
> +	lddev->nr_channels = nr_chans;
> +	lddev->chan_reg_offset = config->chan_reg_offset;
> +
> +	lddev->dma_clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(lddev->dma_clk))
> +		return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Failed to get dma clock\n");
> +
> +	ddev = &lddev->ddev;
> +	ddev->dev = dev;
> +
> +	dma_cap_zero(ddev->cap_mask);
> +	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> +
> +	ddev->device_free_chan_resources = loongson2_mdma_free_chan_resources;
> +	ddev->device_config = loongson2_mdma_slave_config;
> +	ddev->device_prep_slave_sg = loongson2_mdma_prep_slave_sg;
> +	ddev->device_prep_dma_cyclic = loongson2_mdma_prep_dma_cyclic;
> +	ddev->device_issue_pending = loongson2_mdma_issue_pending;
> +	ddev->device_synchronize = loongson2_mdma_synchronize;
> +	ddev->device_tx_status = loongson2_mdma_tx_status;
> +	ddev->device_terminate_all = loongson2_mdma_terminate_all;
> +
> +	ddev->src_addr_widths = LOONGSON2_MDMA_BUSWIDTHS;
> +	ddev->dst_addr_widths = LOONGSON2_MDMA_BUSWIDTHS;
> +	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	INIT_LIST_HEAD(&ddev->channels);
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		lchan = &lddev->chan[i];
> +
> +		lchan->id = i;
> +		lchan->vchan.desc_free = loongson2_mdma_desc_free;
> +		vchan_init(&lchan->vchan, ddev);
> +	}
> +
> +	ret = dma_async_device_register(ddev);

use dmaenginem_async_device_register() to avoid below goto

Frank

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		lchan = &lddev->chan[i];
> +
> +		lchan->irq = platform_get_irq(pdev, i);
> +		if (lchan->irq < 0) {
> +			ret = -EINVAL;
> +			goto unregister_dmac;
> +		}
> +
> +		ret = devm_request_irq(dev, lchan->irq, loongson2_mdma_chan_irq, IRQF_SHARED,
> +				       dev_name(chan2dev(lchan)), lchan);
> +		if (ret)
> +			goto unregister_dmac;
> +	}
> +
> +	ret = loongson2_mdma_acpi_controller_register(lddev);
> +	if (ret)
> +		goto unregister_dmac;
> +
> +	ret = loongson2_mdma_of_controller_register(lddev);
> +	if (ret)
> +		goto unregister_dmac;
> +
> +	dev_info(dev, "Loongson-2 Multi-Channel DMA Controller driver registered successfully.\n");
> +	return 0;
> +
> +unregister_dmac:
> +	dma_async_device_unregister(ddev);
> +
> +	return ret;
> +}
> +
> +static void loongson2_mdma_remove(struct platform_device *pdev)
> +{
> +	struct loongson2_mdma_dev *lddev = platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&lddev->ddev);
> +}
> +
> +static const struct of_device_id loongson2_mdma_of_match[] = {
> +	{ .compatible = "loongson,ls2k0300-dma", .data = &ls2k0300_mdma_config },
> +	{ .compatible = "loongson,ls2k3000-dma", .data = &ls2k3000_mdma_config },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson2_mdma_of_match);
> +
> +static const struct acpi_device_id loongson2_mdma_acpi_match[] = {
> +	{ "LOON0014", .driver_data = (kernel_ulong_t)&ls2k3000_mdma_config },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson2_mdma_acpi_match);
> +
> +static struct platform_driver loongson2_mdma_driver = {
> +	.driver = {
> +		.name = "loongson2-mdma",
> +		.of_match_table = loongson2_mdma_of_match,
> +		.acpi_match_table = loongson2_mdma_acpi_match,
> +	},
> +	.probe = loongson2_mdma_probe,
> +	.remove = loongson2_mdma_remove,
> +};
> +
> +module_platform_driver(loongson2_mdma_driver);
> +
> +MODULE_DESCRIPTION("Looongson-2 Multi-Channel DMA Controller driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> --
> 2.47.3
>

