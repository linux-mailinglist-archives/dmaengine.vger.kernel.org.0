Return-Path: <dmaengine+bounces-3242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5898AA04
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CC31C22AE3
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4E194138;
	Mon, 30 Sep 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BazMM9Qb"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010023.outbound.protection.outlook.com [52.101.228.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD4194080;
	Mon, 30 Sep 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714459; cv=fail; b=VNxQbr+B86fijNMk9pL4yuuvnFx73XqdXzgtQSfBy9HVj3wmUX6PvnN3TvmW1d7Cx+RklkJcqoYTq76/DPuCP8GvCnegx5pjbFZI6m8taC+iAaY7ahtqzbjD1W6j9k3UqCj2wSIYIczVOkFh7Ytz03nsGtGrIUt55XKaCu9iGmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714459; c=relaxed/simple;
	bh=sEIH4MvFG2uwIw4EYIJm+UjOLAcARFtX1/O+MkovAbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8EBBGjT3jnIr+j7zoGN/4EQaHKPGgAzAb6WNnbrYqvi2D5/rWyb099r9rVRaY1OoZTqvEd5LPeFFnzdMy5Z0/MxchlBtqoTbXx4/GJtXMTl8LNgM3ewnhNPSDJiX2CbERCgQeS/CMcPQT9ra4J1YO8dxAYT46awNnbXyFWIxos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BazMM9Qb; arc=fail smtp.client-ip=52.101.228.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYTAX0NNQ1YlZqxKtwdJeNsQ1WQPdu9kICxoW6z6KozXvSgJ64B+eNBsFW2QhR8wsj+amyXtaB0OMbJ3TEMnR0w3Vr0twAnnt4zOTQug3Rqi5yV90HWgPAN+QnwKDWKOroOlg0aUBHDabwj/JJ1xVrC9IhmZMulVYOX89HyCGtIgO0KatQffHZRO4kEswsc7lKYwbLDFM1uETa6+SYMzvgLZ6ZUMRAJ+PVbRNVqhzuLOjjKnyugC7qCrTPo5oIEXjRODHkWWzGXsZqSz/gBj1DA7HuKyGyoo/4Ik0UpQmS2EAFvdl4ikIAdBxE8A/Bv9b3UPsL3u36F2sXdGNGRFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrdMrQDXwTIJQqU97DHA02rS4EKZtY2z47oKfAUKoyw=;
 b=dnHh+XNkMZis7/mg8XB2/QB5BgNCzqd5w0msYsYBmDharvxh52/8ruS9J74OxrtSG6xbAVYxK780tMJwkYdvliaU+qlk5luepsDYgwowimqgUT2pc7MxZk2VNxTjnWf3iO25wY0Icq0uXjbJ4N8CeK7HdlFGDimfodXNsp5XPdJV+LgeDm+V1azsaLvf8ljrGxE2Grk6Gq7xG1MJCc+h0v20WYxoqdp8uLP/nN7ykoKK+wC+rOqpVn0Zrm01O8TyuNgv3xt3yASvdsUsLhK7NuG2vOzMSxIiMQ/Tt9TSqdfPSypMxOlGkBMYmKEHDNEb8vx5H4gpf7TKP+eovuvflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrdMrQDXwTIJQqU97DHA02rS4EKZtY2z47oKfAUKoyw=;
 b=BazMM9QbzYzGyB6z0HYfCEbQ03Tul9ENDeEoYtZEanS0Xj7yqgX4tyS/+h5A/4W0CprO7iBLVQl7dvhYW+WY1X+AvfhREXGq5Y8zTig1yruLUhIS/3WPbwNFvLuIEY0alDOaPLIYpUkaoiWE4gEZcI8YUBuTz9ngEB4aFLeBe3M=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYAPR01MB5945.jpnprd01.prod.outlook.com (2603:1096:404:8052::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 16:40:53 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 16:40:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
Thread-Topic: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
Thread-Index: AQHbE0lvnPRDT4hCO0iu7LLD2KS6vrJwiB3w
Date: Mon, 30 Sep 2024 16:40:52 +0000
Message-ID:
 <TY3PR01MB11346F2C786FD343B7B382CF386762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
 <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYAPR01MB5945:EE_
x-ms-office365-filtering-correlation-id: 37029763-ac7d-46f8-c750-08dce16ea623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LJnPrAkutIrnA0THvDi8bwqnWq9vrG55Fxtczucb719kOTdeQnLdI0iDSMCg?=
 =?us-ascii?Q?MiuKmONJh/maWMeemELO2q6WNNbJsqxXZ0AFlekELb4vXvyICwqVmSajx0CL?=
 =?us-ascii?Q?LnRNMWMOM/wfnEnAcypV+InIgXOh3EgOTk3NEW6LDtsPdPvX231t3zFrG+Ss?=
 =?us-ascii?Q?989yuP75ije8p9PHLvqK+tsOWYnxXULYgm4LgJfAZBYKLzLnfihXYwUPeNYk?=
 =?us-ascii?Q?A6Lge/9fQ6s7/SjV1qbamDhyc4UOK4/5dx3kNh/RPE5VL/e34etDgn0h9XLx?=
 =?us-ascii?Q?nxMiP2ml6+HDDpLfZ0pBW0S8xM1jAoktvZy0EVwmgAS/SGgfXC+ZC36y4uo0?=
 =?us-ascii?Q?8iiO9xROSkJCPPhiEGpVJa3p0frhsFosWrEqeVKiVxT67pHKotqTgMMrYOaE?=
 =?us-ascii?Q?mApMwIla6a5Z6IaduAx3TcckJHgUyCPLOp5hCZw23kdjEYhRZTOD7PdLcBXK?=
 =?us-ascii?Q?nrBtZMa+EZazGUiqM152V8GCb4Kn4uOd7xcAnC0bF+oj847/zNajptMyN8mB?=
 =?us-ascii?Q?WNfoVvVc7oS9jdc7OponcQUk2Jex77EGW9W7MUlnlf6NYhuY/AhwlHBADRsW?=
 =?us-ascii?Q?Hm/rdAzxNRIRXGYDX/3SzSPhpWsvYvq26UdOzFMK481QuL/s8qc7ievushwE?=
 =?us-ascii?Q?PJORW3KnSPEGSiXVT27UgAu7cf/0bqAnfx7MzSFBQnhUQt7eiyyRemDFj4UW?=
 =?us-ascii?Q?5lq46eHT6gwvB8pdzGpcyA849i5smi0EchYitvgs8s3/z4SUDlqdFkxx8s9R?=
 =?us-ascii?Q?k7prI2bcD82MTd3CPnwBra7PvI62KMakDam791IfPgoMlXEH5cb1JrrOLMHF?=
 =?us-ascii?Q?hrZ8uR2kMk9UEgZ+qDrQN925MHfgCU7ypKUYpiGTzty1kiSugYOT+NZV1D3N?=
 =?us-ascii?Q?g3HC4L64qKdT06TRUN16/HLHEiuBS+c7zWSDt49Ljw1AXFL54vPvW/lvbQYK?=
 =?us-ascii?Q?6Rb2FfltQgYgh4+/ig8wvCVRNJPy2Wt+NSMIItYRqDF+u66R+rgoED81fq3Y?=
 =?us-ascii?Q?PccC7DLBR7Em/SlfOCrg6OsByRNuxFiN4lnwCNljuL2OY9cD+673RbGsR3a8?=
 =?us-ascii?Q?S88HWIEUxqKMUP/StaRpjeLLOtlT4Z5CfKlm9Q9L0qZ6mkKzN1SZuL1o/xeU?=
 =?us-ascii?Q?E0Q5YndkLW2Fu6Wsszwq4lyI/L4sEE7Qy9ygjAU2E4SYXHinmjjbxNLgXVWW?=
 =?us-ascii?Q?xEayDz5JaSbuuZw7Dtrks4ARBMR9PSrQaYbqKa2vVfOs3rf+JSpChcdyCufO?=
 =?us-ascii?Q?g3ShR1hfFaqiyh34R8FW4mjXUjUg1Hbrx7z2Z2CH1VqeqqFT4NUC/xHaS9dU?=
 =?us-ascii?Q?OGfNYA0NxxYkyJfShs5qWA+GOUTDpKOzbY++OSXNrAJGw2d3stecZHmEK9Mg?=
 =?us-ascii?Q?D1hrj95DB7glnVonU81f0R3Wj2x3Si6i1zsH6N+/KRC6Pavhew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IXtlBQcjbYfXibE2x2t2PsLxLHn0PM2ND1UrCxgGHK/GFcn7GUx0WpZ2ZEvR?=
 =?us-ascii?Q?dts60RIB3DQBbIOSbEm4Vf+DseYcgvc/w4r4TA5iUySDjeIIFP7K/TEka+eO?=
 =?us-ascii?Q?oma785D38BZgtrEDt2xPcnK+QaBmAyBg0w3Ws/WU9h0MTexYmmbTg3PP+yl9?=
 =?us-ascii?Q?xHjmAxAKc+LqN479boj/eHBF51gKqDvlbbmXSVtztnZhgPhqSQ6AQA3lwwbp?=
 =?us-ascii?Q?s6RUUQZriI0lsQlFSuc+SgaygnDwpSV5Hfl2RosthG6kss9T+9pMQOGJrLWj?=
 =?us-ascii?Q?Guzsnv6S9dQvOXu9HCncKaPpDv31Vgp2/Da5+F4THKpYoBKrLRaaa8hwT1pp?=
 =?us-ascii?Q?x8AMuY7bJi1wx1DqPvDHb6bOymWvYHZRrK2ZWxvsZTtbvg802wyc/ArvJLUa?=
 =?us-ascii?Q?t5WRmqQdsq7rHVkQUHn1BeTt+kZfZGPV06mrl73f8jdH7sWUorCU2oN9p5Zu?=
 =?us-ascii?Q?Uhfwcofq/pAnaXW18CCQBv2fu3KL30ds8cpKE79VJX4kaFAdUlM3rtah9x1O?=
 =?us-ascii?Q?vEpLzhdiCjsquHv8h8m3ir63aQZzA34OFWxPXM0gM5Z2n5e2XyCeI/t3VTWW?=
 =?us-ascii?Q?X546ZFdvX0M992w7q9KLzOh8muiaYID9muJYaIeR50F5/HVAP0mpWR4n7cvy?=
 =?us-ascii?Q?mD4IgNkYUaYnYlzKNDPpMkLAmdAS3nZdYENiF2gf+JbhbN57IvcVd1+94WeZ?=
 =?us-ascii?Q?7lnpeOlP+IkPeb1//9ZQwegxUWyXQftrOS4kyXNQ7toye2gsiPmQB4RdZHiY?=
 =?us-ascii?Q?ohMe+EWjigx+jBSjHxl1mo8xk5Ntc5GDnHBfPfRuyffdydq93r4rcJ09CKE3?=
 =?us-ascii?Q?XtHcsFVM2ilf/hP929v6uoroBj1LnUdEnleNMxB8WOnf86uQdTi2NNlIAcw0?=
 =?us-ascii?Q?EAzPzDABMAxbZFnZn+PfqiqW/ahM4KdT+g8hJSltZ2LS9CF9P/QzejIaeTuz?=
 =?us-ascii?Q?G1bH2VuNBzeefmz7vOZovvX+xro8KyAPeWdDgt5NVXliQKrSkV6Wm6Zu0eTF?=
 =?us-ascii?Q?kU/4y0yI+7jpcQChsPckVI6F+IfC2QimQbkhnDF7rbOweAz+bLFFKZotliET?=
 =?us-ascii?Q?3WnVo7DAtKq33J90U+o7jw22QQE2TWLnci4354yT3uC0H8mdF6n/jQz5TCTD?=
 =?us-ascii?Q?KyFjRBzScgP+/Ru4PYYkr6PN7aTXrTT1CD3vgEzzs5g8sWGT/E3ohvjk3VXr?=
 =?us-ascii?Q?hGLM8QUZvdMODhhxPOnu2b4rl/o86cq15WaGr5sEnC2pgLGdXmK7WTi9cXF1?=
 =?us-ascii?Q?wvJg4Ue0NEtOeMCM3/gv2kf4SCsUb4kIYWNF+N/zoUgWNqhTfKeRCYrpl8AF?=
 =?us-ascii?Q?41may7wC2GttpHCVuf0lQovGEVMGw2kjy0eoRX2jWr31qRW3Xvv99aC8ft6z?=
 =?us-ascii?Q?tIok3yO0vQsWnWQRe1kq/ptfgueWmz/d0+MxJh0qJE+6M7UXnQV+ZaCglBIU?=
 =?us-ascii?Q?qasdeQcRxTvmEesYn5yaizKkpdc06UwmuoGQR4bphl3CGxE/ZfpFpjLZTf+k?=
 =?us-ascii?Q?atmMiwEtU/+WRHJiqcX6Tji5Dt4J7R7WJqKgo6ZihyHe1/6IV3qmNfjwAqqd?=
 =?us-ascii?Q?e/i2F2bahjtEHI1bFvtoPlYcdSMGhU4ukqQIZJYwEl9sR5/DyGvRdi3pHP4i?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37029763-ac7d-46f8-c750-08dce16ea623
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 16:40:52.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3HvjHk1Z31iLscZQmUN3HOWqsWQxOfmQ2p/Cv0hGFcI8eJcPXqknItj/2f7zU4LQ8sT76VuycIeC9+OEe3pY+0WEwgh4E7Cu9xg4YlQF4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5945

Hi Wolfram Sang,

Thanks for the patch.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: Monday, September 30, 2024 4:00 PM
> Subject: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one add=
ress is zero
>=20
> Configs like the ones coming from the MMC subsystem will have either 'src=
' or 'dst' zeroed, resulting
> in an unknown bus width. This will bail out on the RZ DMA driver because =
of the sanity check for a
> valid bus width. Reorder the code, so that the check will only be applied=
 when the corresponding
> address is non-zero.
>=20
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 65=
a27c5a7bce..811389fc9cb8
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -601,22 +601,25 @@ static int rz_dmac_config(struct dma_chan *chan,
>  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
>  	u32 val;
>=20
> -	channel->src_per_address =3D config->src_addr;
>  	channel->dst_per_address =3D config->dst_addr;
> -
> -	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> -	if (val =3D=3D CHCFG_DS_INVALID)
> -		return -EINVAL;
> -
>  	channel->chcfg &=3D ~CHCFG_FILL_DDS_MASK;
> -	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
> +	if (channel->dst_per_address) {
> +		val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> +		if (val =3D=3D CHCFG_DS_INVALID)
> +			return -EINVAL;
>=20
> -	val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> -	if (val =3D=3D CHCFG_DS_INVALID)
> -		return -EINVAL;
> +		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
> +	}
>=20
> +	channel->src_per_address =3D config->src_addr;
>  	channel->chcfg &=3D ~CHCFG_FILL_SDS_MASK;
> -	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
> +	if (channel->src_per_address) {
> +		val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> +		if (val =3D=3D CHCFG_DS_INVALID)
> +			return -EINVAL;
> +
> +		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
> +	}

Now both code paths are identical, not sure may be introducing a helper
by passing channel, CHCFG_FILL_*_MASK and *_addr_width
will save some code??

Anyway, current code LGTM. So,

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>


Cheers,
Biju

>=20
>  	return 0;
>  }
> --
> 2.45.2


