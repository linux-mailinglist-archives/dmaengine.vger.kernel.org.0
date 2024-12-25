Return-Path: <dmaengine+bounces-4074-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9F9FC307
	for <lists+dmaengine@lfdr.de>; Wed, 25 Dec 2024 02:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB4816513F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Dec 2024 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF15D610B;
	Wed, 25 Dec 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b+TPfmmN"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1595182;
	Wed, 25 Dec 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735088444; cv=fail; b=AHEB8K99UJRNwi1y8NcALvY5hOUDt9kHRMYIl4J5PdHMJV7jR9A6oDfl7X/2dl+i+z903OCaHYbyMhqw//Wa95CES0gQBVgI+s2+JFLAGkE2vX3/Rs8uua6U+5HMAodA2TTBRIQxDYOnB00wNa/M5zUe1QYMOW8mW6na3g2Cl2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735088444; c=relaxed/simple;
	bh=WRZ/ySpEDk4/BXLXlq7TakTd059B6cmBPEXgWDVJYmg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E8XWfKHBD9vIv68N8cSG2HZYxjqUhbMsikIAvK50wEb/SDNyS9hWWL1S3tD/yw6xqCErrCt40797z8P30KMD/NXMKJ6PI3B2NeCKmLWZtP8BJkK6DSolAJg4/m7nB8zVFXTFLBRu/i/gt5tTnkCHJ6e4wIlC0rew8a+HQ9lmNr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b+TPfmmN; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZXa5/cbJGZts+ZtqC+SPnEeHVjEVJ+655x6xHu00x+pTQVKORiP72ZREXY0WyzAx/NzotgDiIzQ1sedyCWRn8t6AQike3RS3t8E9HE2RC6Xd0I47O4oILPkKiOmWiQy3OsjKQKKpAiio2MT3EfLMbY+dgrVzSgrUqZ25P3cCeOAr0wibZVyCR4VYu/X5GhXUxuWMGNveuNti/ROjfrQvpAvfXhHteMi0TY9fPsii+2IjUtwW0eyM7R/2tBdQgcyE6ywyBzznMeZVo3WGom/gzsM33iN4m+2JtFscOuJI8bMmGmCOb6yOgwXkxJgr2EacYNIbOnmdXo+MhCePnVBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo9cWDmqWhi5Z2ibxTppR1kKZEaTfpIXG12He4FWdhU=;
 b=itYKVw7vLoiLlFXuGYgGTNUk0AG+K7wAEqFDvf3nePEBApT8P/p8EszfR3AkdmtTCBjWTbGV6FkT0ZNipdjF+hpJUdps4TESHdogD5RRYS/OxHY1wyv89j1L0vKFaDEOGm2d5ZqDNWqhZZqSyDxg13g7r+R2xdaI5CZ/CDAdLKZ/7+l98O8LOgaGOO3oBQB1kBKx2Adpzrf6m3Zn4xd3c9dJ2d4E1I4xI0wZ7Lu6voImu7jB8dlpKXsMA1kAvbiKRGp4Ugytl+nFXo3uybtKp1YcHgBHleqCpnYnyGxcry2VePkkInO48NzHcP56kqPe3wOveC2LpsT4TWq05efFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo9cWDmqWhi5Z2ibxTppR1kKZEaTfpIXG12He4FWdhU=;
 b=b+TPfmmNnGiN328nUpkbWw9xfTykaYQdimXcDzeCESQLc8esEbfC5eB6YwD7hGW9dhSjNuTIHc2uNlPq4YO7F7KEa3Hn65wqdeKlNvTEEP3idguCWIqwfQ/HxnGmJawcnkuAyk53zpvcpC37cnt0twZWBzKkH++exYuG/NG1X6B7gEoDltkoCi3w4EMtYNId1Wo4rq0WzeDrLTzdtmCOgrcbtTa3YoVBLc8Z0zmjC12qSGTJe2ErvtxXlyHQjg1iqm05cRK289QE+xfph62K/idtgiZ0sdllmsu6BAEq7v9Bs3Y58b1d73bTNVHfPv94IRg3XKRhAlGErE79EjM0eg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 01:00:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 01:00:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Frank Li <frank.li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, "open list:FREESCALE eDMA DRIVER"
	<imx@lists.linux.dev>, "open list:FREESCALE eDMA DRIVER"
	<dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Thread-Topic: [PATCH V4 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Thread-Index: AQHbR7uonzdNVCfKwUuC2pwokWmiMbL2QVUQ
Date: Wed, 25 Dec 2024 01:00:35 +0000
Message-ID:
 <PAXPR04MB84594DAC406C20E711A4F558880C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241206084817.3799312-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6806:EE_
x-ms-office365-filtering-correlation-id: 84978679-b399-48a0-e272-08dd247f8a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ImTIrfm4u2UBcV/6xoHKfJ/r875XINo2N0ZAexIoEKqO3XN5R7BrA6OtrW4v?=
 =?us-ascii?Q?UJ675FBntoPaEbTLPrvGwxwoVnHo7D9S+xYSU2kfBi5wNuntYhkuPxAuS52/?=
 =?us-ascii?Q?cgW71qcuJkTWw/jmzpPiJMvd/Vt+0nbZsLuif8PeajMSXwMCMBF6jKsmbvex?=
 =?us-ascii?Q?zrY6JcwYlWQfaSY+jZx0ZJMsnTc8d3QablKnQlwtYQq2kEKzkhgU7e21yXVD?=
 =?us-ascii?Q?BoEyYGoMdsGtNQ5pZ1KnBn83NKXkiDjRo24vFFdUxdanaX/yC+nhoQsTAV6U?=
 =?us-ascii?Q?vvDUJGUvR6oIiLjeAbvpuEYP1Sj4h6KdYYoh3BP/OAq1RZkRaNvIasKSrLdf?=
 =?us-ascii?Q?ORF93mXWuUiDCflsflN9wjgkgwdTEBgYKb332NEIB4EBw7c+ERswGrCiM/I1?=
 =?us-ascii?Q?3K/7KyQI1g8BoJSa16fM0h+YcrDoKfHyhDL9rzm/lt8b7dZwjnGAJ0/WyS6a?=
 =?us-ascii?Q?Pp2pwJ2VNF6UqVsu1MBvvJihEOhE1xKo9k4si0oMAN0OEX2GdxMFZe0TE6Nz?=
 =?us-ascii?Q?VZuFA5Dfy6lxZ0i8ree6wSASIiRlReXXfWy+aU5dT3hU4w7g3jJSPF1MiEZx?=
 =?us-ascii?Q?S8G49i6lkn+QIpSM0/iv/gTnyzzlkpQnYLIC09pIrBn83d+TqEhxMwSZgajq?=
 =?us-ascii?Q?U22f4tqxnCKRI0ZgY8r4G44+5nEFMquZ5/u8/cnrg+039LWNIpNWyvytS/FE?=
 =?us-ascii?Q?g7yXpLF0Lyyww8hz2L/Gr/Fyrk3MKJNdwGUHdgW8+eoA0gDzxP7dVr5W+J7P?=
 =?us-ascii?Q?QQdVgNZVMpjKcNWXCOkrYL0xDCCR//E5wyzN35lKcShJj9uxMARL78nB+F7K?=
 =?us-ascii?Q?Wi30bdeSiPG2mSzafQH2DDStKvZI9TsOfdIlZdKeiQJZhkcUFkJGPn0pPdjn?=
 =?us-ascii?Q?OBe0qZrevd2QZjtg/ViGkraeFaWei07BM8BapJ0biLdMwk0QyIVLdx4DFFcN?=
 =?us-ascii?Q?c00FKfsErRqJxZ/BkAInU2EdVaIkJNNnYR4HTmtcv/v4lBiiuTgzV/1svCoV?=
 =?us-ascii?Q?49VNBbmim2bgP+MaL72/AOosIE1dURYlJXuz02q2IOu2PYbOE8ohHeGK9MaX?=
 =?us-ascii?Q?YaMza45cHMXtbwpaTBtqMLQDwEx6lpGhKe+Dy2QUS1xhk4FCNOxQgvVz5avr?=
 =?us-ascii?Q?FJuRwg3Rr6zaDiQ9wDFt3X7J3YuWaFygc4mDfPHWmkcRrCabUmKUVCXwX692?=
 =?us-ascii?Q?z89x2IazvmzfQyMYYC0l4tOdVtdKIoLQHLYZOedUNnKLzg96KolJbgZZZ0tF?=
 =?us-ascii?Q?dgnyGnwRBs4I4QE6SWF1/jRlLGIOb4mu4kTzt0OaGi83V+f5i3aAT4X1C4cJ?=
 =?us-ascii?Q?FVfU5lwOr3YXHG+zADzDsYMZqY1C2BY+ScsrCpmigGB9Z9vCTLypWv+xyBDk?=
 =?us-ascii?Q?BbDBSj5KTg0OmVUb2fBmBsPUsZR0nYk3swBr+Rxm8R4SeC2LmKZn02Tq1CoS?=
 =?us-ascii?Q?Tful49RIekTru0KphV0RbQUNRte5IHBJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WdpQj0Pbtv0t0yaTNnu+El09ww1+6payZeJW2hDoBwUukAd+gtI/FOzSn04X?=
 =?us-ascii?Q?KjffH4tzQ4bX1cNPI38gEyTKaNPBiQptjOnE4Wp/lqwiEXLkzyob+4XbRMLz?=
 =?us-ascii?Q?sfafuuRIiB3lDoem4GwR78sikY2pLg75pyQz3Hn+RYqMpBstdzczGUfArVYo?=
 =?us-ascii?Q?WGQxpmsOjAI+mPUoAhhZMjOEyrBxrnAxuTo0bvkPxa8lah8RFcsCYYEs7hVz?=
 =?us-ascii?Q?l0tE+sTRjRo0b3CCDMgZ4C7u+TBl073JnZBLIm3lUxCVIhynwMzIV0J5M90L?=
 =?us-ascii?Q?s+uC8ffy/xa+q6EF5xxVsYfVorDoRLziTjCcFeonR8v7tZS5MGvqmLmmztrZ?=
 =?us-ascii?Q?hgFWbr6ioIYW4NVK42z1BF0XlLXxxFvPaoROtZryZ3DuAPX8OfZq9py/QxZV?=
 =?us-ascii?Q?An+Fr4yuECZcs4hFyLfySV8XvCwnBBGfdPigSNZ6oUPL3ugDqn7T9fE4IiHu?=
 =?us-ascii?Q?kA16a8vepTg1S/ga4pF7+5KcUlmBXfSldkYsK63EkM8OKP9rvwuKrQWuweFF?=
 =?us-ascii?Q?+U3/oK0b+S38mQv6ojqvy434OPo8sHSNxYVemdhSJYrXQ5b3SG15PzcMssLD?=
 =?us-ascii?Q?UfGqVxYKuBJXaxXcG0dhnQCzmg/A1dGsr7AZd8b5M59a2ZzdxZcpAKsqOL0f?=
 =?us-ascii?Q?dkWIav131uhtbch4bahfOM3SLeftBfmKlUFtayYm1QWTDatFr3Xj6HJxUe0Z?=
 =?us-ascii?Q?/BuiYIrbwiO5nmwMp7gaDoa6njMv4ospqcRWItw1yU/RdLiBxGYPDHGcABmj?=
 =?us-ascii?Q?mWzOrfPzIeIg+Mz/dLhPJWBE9ENq6IzfHH+ek91VrUmUJiyt9XbJV6bJ0Yxn?=
 =?us-ascii?Q?viEvwRVIbxH3tSlHH0tbNhFEJz4dBbrjJl02vF/AaNXPdbs+deThu8VTcqQ0?=
 =?us-ascii?Q?S/0eLkiJKwYjH+zQNnH2ak/82WD2UhojR1ezBJKUlquFFln7m0UWkynw1KgZ?=
 =?us-ascii?Q?vkajf9Bnyi34m5NlDl2xF8U+4vuw0G/iY85SQ+NkfKc3HaeOZcAPB+qjkRXW?=
 =?us-ascii?Q?VqT+lJ8FVeSPEePuRoieTlnVPP5hkzzkqBrcL+wuAPf78++igsvNDCss3Wc4?=
 =?us-ascii?Q?hVN8psH0ZdAlkb5kgEhgIYMkkA6Tp8TK8EOdJJIvK4p6eF2EZsJZq4X28BgI?=
 =?us-ascii?Q?zAQcTbaQwmsg2gZOkIgVTK2EMHp7spgRd+BwBl+lAf2oB1BgeOce/fpKlivm?=
 =?us-ascii?Q?xY7ediW04TVbQWuSnX/mL7ZgKHwvQJNIUOZGlreNkNOSu+GoT7BuFYkVfuzc?=
 =?us-ascii?Q?5Jus3nqtOF1RCtCrmC5MPtt1VWDesI+/ebHOMabXCmRZNXeqMl29Y4EVcDQD?=
 =?us-ascii?Q?fDdBHhB1i37PfJwTNG5lFDaIppF0QeDjBNBO9kB1Eiv936k82uEjdcWRaZNw?=
 =?us-ascii?Q?fmGAqBDJ/h8bySmv4S0mkDiWc1/GDkRiySGEut4d3pHCFEjQg+4BGUewYMQE?=
 =?us-ascii?Q?IwYFdAwPKqP6kkqeb1zd2PvkPJ5b5o+ml9/xvzkQXB/Q9sglpGtTrzwKksrL?=
 =?us-ascii?Q?I2pl+uxNnIItDUZJTWch1+hTAePJ2MkxMCpUhliEq9hY9C9wr7mYVcdYps/I?=
 =?us-ascii?Q?GbHFYyffdkIuBzDeBCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84978679-b399-48a0-e272-08dd247f8a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 01:00:35.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUoHlNnEHpLdZ4D2ammwEu/z96oaeefANbzkrborkVKUKKOCd2FcTSwZ/RaYZWMTADCcGLkPRI7AJpK0bxgCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

> Subject: [PATCH V4 1/2] dmaengine: fsl-edma: cleanup chan after
> dma_async_device_unregister

Ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There is kernel dump when do module test:
> sysfs: cannot create duplicate filename
> /devices/platform/soc@0/44000000.bus/44000000.dma-
> controller/dma/dma0chan0
>  __dma_async_device_channel_register+0x128/0x19c
>  dma_async_device_register+0x150/0x454
>  fsl_edma_probe+0x6cc/0x8a0
>  platform_probe+0x68/0xc8
>=20
> fsl_edma_cleanup_vchan will unlink vchan.chan.device_node, while
> dma_async_device_unregister  needs the link to do
> __dma_async_device_channel_unregister. So need move
> fsl_edma_cleanup_vchan after dma_async_device_unregister to make
> sure channel could be freed.
>=20
> So clean up chan after dma_async_device_unregister to address this.
>=20
> Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---


