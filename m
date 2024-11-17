Return-Path: <dmaengine+bounces-3746-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AC39D0330
	for <lists+dmaengine@lfdr.de>; Sun, 17 Nov 2024 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B82833AC
	for <lists+dmaengine@lfdr.de>; Sun, 17 Nov 2024 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8966213A27D;
	Sun, 17 Nov 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NdL0H25X"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86A11CAF;
	Sun, 17 Nov 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731841676; cv=fail; b=gWNhq4lCLsXBDRd+y97LDdqAKdvvMO9a9DbNhp2LaLjwQSUtz3DzkOBZPgUmYIRpy3qsEl32bFFqKB1Hmx41Gj1+voZtPBHU4JW3Ex1M6GIPwc26F0KaVy74oEmNFRMutgdMIVFvkVoTFMIJ0ENRHGfWf1mQfKTT7cxlKI98kKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731841676; c=relaxed/simple;
	bh=dTz3xU5ivIQjtGSXBjma7+m6+IHX7rewLsdzIBLCV2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sESTeuXwnHbKuA81vj3K/ZHzpwlbiNhT78iwj9kMfTPtNFQ60Lh3NDq20sE49j/o8gq4cOYXYq+Onh27zH7MoKqDLZz8pvcDc+l8EZfz2dsx5MmXazOpK1jrZxT7A04ImEaEhvA8ga0t/caYnVbXmErTMUEP97u9jdsOtZqB7u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NdL0H25X; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkjLj7yQkZxTE8qcvNPMJtYj4/jcqMJRG7JJjF4OsOBRD5Q0SEOyyVObDITejL2xW5kgOiDgG1VklPZ7l7n9cq9uaawEDq+HGVKIZuIORUEmjOuD5SyHWZZT+yhlLcJrkDOM8hw7qrUPO67OEvC/uZhELDyZgaddJvllcUpTDgptUon6zQKOdeCSBSxWf9dwnp+LdJuo3gsBIhMr4SpFZkRkZ+E1oGf7vmey9U3FzkWMmYVqLp90npsy7LQViwUAMpkTfbJ19NxUv4Ms041aO+NvB6E+hJm8aNh32kqGI2w5J91EQLgz6RcJ2kvoJ8Dp2s6SaYvvLwc/ZxiXPeFJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxJDx95bUmW+2VGDcpcO+lCDgR1zUplRfWZzIqcRW58=;
 b=RqnN6xnDy0KkuxNBabQkPdkR07vRwDav94JpL6kJfYjH15q3chsPzIa0NFdwZwGjLv4qC0JXJMxXl0Ni4FpdfNJjKOJGFpycH9rWGX/5tI+x5T+ziXL4WW2dP/fP1qJ/UouGJpzJUNb0aRs7YMbOmBHGJPoUjkFc6JyUzgzZOkxrCzS9D9Ak33zWSeRLmqwVhmqWY0QdPb11ZCD11zDQ/fJvPBvarIEr/Z7pYdQrYIm1e7Kb25bLX1GgOAgZRAVWoM6HZ8kZp4GRyunUMKfjDqT5ZERS5/oKrIN6W10Y5x2m87XEugfAQqbBFfN+K2Nc1mSr1A//3XyZcwPbWQ8E1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxJDx95bUmW+2VGDcpcO+lCDgR1zUplRfWZzIqcRW58=;
 b=NdL0H25XiGjd4xPXa+ohrzxIQhKOu6O9CWoNwy92MbJCXXLPLpnbmCwHyjHCZPaGFC9OYreykToIjJK/7E/tBAyBo9WDEpdWnQsxcWvZI8DJbP7ox1y/slppl/6BlxveqgMyil1c9G64XKNztLcH9PE3KvmpKEjXAyV+UZrSISxp2jdXhzErQs1tv4bdRjJtR3KFhldi3DvxX3ItTt54U0VCwYMm2+cbsyU4WyUdApJGHdhSPcbZeleeq8w5yusTbfHoI7Gfb4Yd3huvcdKFwJvzrTFTOhroS3dRyE6rYXjCHn5UG8DlcVvr2oFI5Inmgp3exynBYqNqet30Xdo5Zw==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sun, 17 Nov
 2024 11:07:51 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 11:07:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Vinod Koul <vkoul@kernel.org>, "open list:FREESCALE eDMA DRIVER"
	<imx@lists.linux.dev>, "open list:FREESCALE eDMA DRIVER"
	<dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in remove
 path
Thread-Topic: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in remove
 path
Thread-Index: AQHbN00YuLiEZEKAsEm+xXjVZKuTQLK4cwMAgALfyMA=
Date: Sun, 17 Nov 2024 11:07:51 +0000
Message-ID:
 <DB9PR04MB8461407FB15C100903EFEFB988262@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241115105629.748390-1-peng.fan@oss.nxp.com>
 <20241115105629.748390-2-peng.fan@oss.nxp.com>
 <Zzdk5qcUyhNhRZSR@lizhi-Precision-Tower-5810>
In-Reply-To: <Zzdk5qcUyhNhRZSR@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GV1PR04MB10560:EE_
x-ms-office365-filtering-correlation-id: 3e0b633b-bbe9-48d0-7eea-08dd06f81447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mFhGUAFicxj17CgqW3lAHwu4FlNVjHpDSxHtiHlxZY4aNGcXzcU8GYMWAmkq?=
 =?us-ascii?Q?p6EmVeccU0n/1F33i/XBFoDLGEeOrBsU3ScpKuhWYH6dLtOEE5l/TJcnaHQX?=
 =?us-ascii?Q?R1wl0kxQve5a2T0OtZJo9WcNKu4MmwQcIr0F88bro7ZUDORREE9R9etm1+jE?=
 =?us-ascii?Q?Y/n2N76D/M77Z1xLTWaPX9QexVye1XZLBag2RbyvfyndF6sfKp+x/H8McNK5?=
 =?us-ascii?Q?BSR3kTnlhPaStGTHUXTcqK7fRApbXV2L9FJJY4hQ0lg5teb4UEFSb1GFmw42?=
 =?us-ascii?Q?wmFwlrqZ2wmYJVyD6BUYY5HuLIhsshYq0qWcmgs/dAZ7795o9unrG7lZmcpy?=
 =?us-ascii?Q?w8G8WxVqJWtH9AQkF9nqVVykXQBEO7SW+HCuyF6YHYNr2B5spfcP3ED7RzCe?=
 =?us-ascii?Q?eE4NC5sK8g/2cxDTae6DhxIUWB01T7TZ1dtnWDCrPv1AHLEHWYaFNMqlaq5C?=
 =?us-ascii?Q?ThEUgW67TX7PgfRrQFFWBNL/i7bONZdRm2oA1jUzclXkH21myjLHJQGtEdYA?=
 =?us-ascii?Q?hloBlbd4kV4y5zAIOhJRdUI/y5FQYrDFRVhlLH1F4+74/7xnEFOW/5+uogyG?=
 =?us-ascii?Q?FXZx6Nc0E3//dllXai8KNmXesrRbhzZIowhkOVDuN1VllDjvYceAYeV+H/1s?=
 =?us-ascii?Q?7mUXu6vRR/97N4I8jJfBB3kxUFK42K18OjK9OX6WmywOejo9BSF2hBg6rePw?=
 =?us-ascii?Q?FsiVa9VSvMRCNoxJrMmnLZHXhczeEF6sMj6HH5mDpmfx8pJ5+Iggv4dS3W1O?=
 =?us-ascii?Q?uE+4ysHXcF17q3ag5nUcQ1uyzw4trHebfiV4uT8HRde3VYkGyEnsNIGxNFVT?=
 =?us-ascii?Q?+zMetL7hl5mkLgPCet4QKAyB7woYosVtcorIffziAZhlIsIZyBs6PBvQ/fNu?=
 =?us-ascii?Q?/FPMHjzq8abXL0fldjCoW5QG82kzqMMvHY0cLE7nq2k0os/j7W2iuthgXPBl?=
 =?us-ascii?Q?oL6n23bH1VwXJu0iRhJNx9nX1HauNhf5LJfGr7QpPJK76+P6oGVz4qweIm1y?=
 =?us-ascii?Q?r5X3UH0XklnF7h2nNRbPqNBog/TzkXcqFdbGUoJOc/aUSBSKL7gmOgbnw1Ys?=
 =?us-ascii?Q?QXkG9Kji54YKLGXmy2WoZQRj5IfgAaxqcvceGavImXzHuq2aG4ODIHXBmDzN?=
 =?us-ascii?Q?QpuOB14wIT7qqmTZHbWnGZtVWZj79JQwfj5ngT/mSAtpP8Jm9I6K+jU/vV/A?=
 =?us-ascii?Q?vzVnHuqmlg4T1nP+NvIBq3OoN4t0fQQdPPzMnDgSubpqMifkcL2IT4oWKbLv?=
 =?us-ascii?Q?XMQrZlmw95RJVrIosgHWxlVjQSI7jJXYZRmnhAHDTGmxdF9Zmgl948lCnnI0?=
 =?us-ascii?Q?ayGDRsJ+kvouD/DSmBR9qgU4bycPcgF7QwcRuvit4cp80d3LQBYTaWgHRewa?=
 =?us-ascii?Q?aW9cjRI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HPjps4v2C+Q3TP1Uwe/+Mj1iis2CWv24yNIn5vcBijwqp5DN+Q+tZ6tCIITj?=
 =?us-ascii?Q?5F5GaPM3rFGlvq41pRCTIfV7SB3cB3TITCxME6+86I9efMmeZdgq4llLKgGO?=
 =?us-ascii?Q?t1oVWqMznp79qx54f034zr+8vSEWIuY0nIvxMQY/BlnjeVAhWKllHbESKLLi?=
 =?us-ascii?Q?gV7OCtxrqBYV49PhBB7P2bruRtWcKYZx8hfRo0u2eLJmOnp81z7LEZfV6Bll?=
 =?us-ascii?Q?BUqbu+NqT48STrpvsNIH4ce7JjWi8ID8ohzLfGpSEC1rwENYJR9sYdu9boYw?=
 =?us-ascii?Q?nu5RTKJKD1QmomjzHkDzhcJB9akKgaovpooS90e2V2fbwnVgLpVM11jtuhn5?=
 =?us-ascii?Q?D8AMA4oH5ANAjhDpq83fl2Md5n1UaOFlv+R7BwxCmCKP1Rzfrv4f/uDVZOEh?=
 =?us-ascii?Q?Y9SCOGP0EPYvaZPtY9dvn0ktHhVkQhpe8NsviPI+urZdqtMIItz8Lfs0aql9?=
 =?us-ascii?Q?hKqUcrXy1FWcg3yZZd4e1iL6t0jAFjwnG664Vgz3get6ARtBTMwVM1jW+lc5?=
 =?us-ascii?Q?Hd8mG4dcz564wM6Auxh4QJISkQEuQMfBRDCFvs1Qj+7pAt1YCrfduFaubWQ6?=
 =?us-ascii?Q?OnwvFZfB6PsR2FcASnxQs2jX9uIjudFJt/fd7aYT+vt+Wm0lRk8DThEo7qQ3?=
 =?us-ascii?Q?0QjvC+QqvfZavJS0vZMl359fRQGEQwUbXHzMrexm9RZxUykJVyOiWmNHRJwx?=
 =?us-ascii?Q?CHOetQssZgNUmqT12pdzhwwDB6cIBc4VXKx/QdjauAGULUS+tV/rN7l8kCok?=
 =?us-ascii?Q?VawgMYAQZpb62Vk/y/2fxi/+ZSCBCrWMOdgXB6jFs6c/bxhD+nvHjnkIab0B?=
 =?us-ascii?Q?di61bs+eW0FIJbnZo+hLS1pGNtYQ3NJQiZrsVfFlEV0KBmCtJ187L8h/H38U?=
 =?us-ascii?Q?NarQUfPX9yeCtvoe2kdBHJ9hqehDsGh4L30WKgHVNHH7CopyH2It65RVRCgF?=
 =?us-ascii?Q?bU/Jfm008PRvwpMlfg3JcN/lvRElZ7UvE06hiYGVUOx2e44zC2RJn/ueAlIv?=
 =?us-ascii?Q?qa0R5BUAP28PhoePy5mIJxicRtAQeNmkIs8oEadOClkFHtc0PKkNAsvQ3LAD?=
 =?us-ascii?Q?U3vCjce7jokxjlzzP5oiHOFQbYGZWrEu6dRpLAKwTdOQhVIIjszsYM8+vOIh?=
 =?us-ascii?Q?V4Io48dPWHtj167YsjxRt2vyKUDvABS1TXZRH2y8pQS8TszM29XIPp4rcr78?=
 =?us-ascii?Q?DPl2FIXx2Fn6V9EMT0onP4T2MhITDMn6I3+Hz4Rgfjx6UQJUlTH52zO38RRb?=
 =?us-ascii?Q?uqkwhHHIw0l9wQbJMc3jr38y83pffJs00mmCGteCgBVnOIhFmD5TevbZ0IMo?=
 =?us-ascii?Q?SjgKu+0sDVdDvAWHsyxCbTjRYaFv3kRZTsMj0yKr2w1XL7mI7ldV6YFhAgx/?=
 =?us-ascii?Q?4LKJ46qTxFqvo+ie/rJteJiyYGlndq3kE5N5JtFn5rFyn9EmvT91asvvsL7b?=
 =?us-ascii?Q?YpBYRgrccAXySAZOpxA1rNt1k3vnXE5L7kQrZVdVAawo5oRUZZxEw5pqJAkU?=
 =?us-ascii?Q?q3+eQ2brhXIIAuMIb0JppspYRnv88sCbSuaT3dyGwkcp/5V7gTFVWA/VRjem?=
 =?us-ascii?Q?BH+TT9uP0SW+L1JRBVg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0b633b-bbe9-48d0-7eea-08dd06f81447
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2024 11:07:51.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix8iuP9WjUax82nz34oSo/SQdkWNAewcVxCU1koqIXqe9wr7lHNnB4k15iQMFxPzQ1OHU2VBR25BRYVvdchprw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

> Subject: Re: [PATCH V3 2/2] dmaengine: fsl-edma: free irq correctly in
> remove path
>=20
> On Fri, Nov 15, 2024 at 06:56:29PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> > fsl_edma_irq_exit to avoid issues. Otherwise there will be kernel
> dump:
>=20
> Nik:
>=20
> Add fsl_edma->txirq/errirq check to avoid below warning because no
> errirq at i.MX9 platform.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thanks, since this is minor commit update. Not sure Vinok could help
to update, or need me to update and send v4.

Thanks,
Peng.

>=20
> > WARNING: CPU: 0 PID: 11 at kernel/irq/devres.c:144
> > devm_free_irq+0x74/0x80 Modules linked in:
> > CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-
> rc7#18
> > Hardware name: NXP i.MX93 11X11 EVK board (DT)
> > Workqueue: events_unbound deferred_probe_work_func
> > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc :
> > devm_free_irq+0x74/0x80 lr : devm_free_irq+0x48/0x80 Call trace:
> >  devm_free_irq+0x74/0x80 (P)
> >  devm_free_irq+0x48/0x80 (L)
> >  fsl_edma_remove+0xc4/0xc8
> >  platform_remove+0x28/0x44
> >  device_remove+0x4c/0x80
> >
> > Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel
> IRQ
> > only when channel is allocated")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > V3:
> >  Update commit log
> > V2:
> >  None
> >
> >  drivers/dma/fsl-edma-main.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-
> main.c
> > index 3966320c3d73..03b684d7358c 100644
> > --- a/drivers/dma/fsl-edma-main.c
> > +++ b/drivers/dma/fsl-edma-main.c
> > @@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device
> *pdev,
> >
> >  		/* The last IRQ is for eDMA err */
> >  		if (i =3D=3D count - 1) {
> > +			fsl_edma->errirq =3D irq;
> >  			ret =3D devm_request_irq(&pdev->dev, irq,
> >
> 	fsl_edma_err_handler,
> >  						0, "eDMA2-ERR",
> fsl_edma);
> > @@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
> >  		struct platform_device *pdev, struct fsl_edma_engine
> *fsl_edma)  {
> >  	if (fsl_edma->txirq =3D=3D fsl_edma->errirq) {
> > -		devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> > +		if (fsl_edma->txirq >=3D 0)
> > +			devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> >  	} else {
> > -		devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> > -		devm_free_irq(&pdev->dev, fsl_edma->errirq,
> fsl_edma);
> > +		if (fsl_edma->txirq >=3D 0)
> > +			devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> > +		if (fsl_edma->errirq >=3D 0)
> > +			devm_free_irq(&pdev->dev, fsl_edma->errirq,
> fsl_edma);
> >  	}
> >  }
> >
> > @@ -485,6 +489,8 @@ static int fsl_edma_probe(struct
> platform_device *pdev)
> >  	if (!fsl_edma)
> >  		return -ENOMEM;
> >
> > +	fsl_edma->errirq =3D -EINVAL;
> > +	fsl_edma->txirq =3D -EINVAL;
> >  	fsl_edma->drvdata =3D drvdata;
> >  	fsl_edma->n_chans =3D chans;
> >  	mutex_init(&fsl_edma->fsl_edma_mutex);
> > --
> > 2.37.1
> >

