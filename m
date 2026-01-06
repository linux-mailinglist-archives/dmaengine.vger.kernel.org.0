Return-Path: <dmaengine+bounces-8082-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC03CF9909
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 190DF302A0C8
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D333C507;
	Tue,  6 Jan 2026 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r64R6/0m"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011070.outbound.protection.outlook.com [52.101.125.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8D33C1BF;
	Tue,  6 Jan 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718979; cv=fail; b=YJ4q3PpCjYYD58pxFykqfQbAwz2yc82Aei4MUNbGUDuPUzGF4LGf2LPXokj6k4puiuj9uJbYVBewy8LOL191vX57luirg/XsOSfESJMJtFqqySdoZr5V4I+8MsHuc0NMz78l0da1Dce0Q0UzT6cBNCRng0YingnMEAf/9PKB/Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718979; c=relaxed/simple;
	bh=NwKWQxM8zTBePC1WhADhXFp1zSNWxgZvduG9GngUW68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRx0A1swfMkyHWvt3ALvtItoLVb0k3eTMH6cutwnS4wlF5ZXdSwIFYnol0/riZAQvoJTQfFNdclIlgHerI15UICtRys7pVOzi2+Io/Tp/J0wSCLqN0PXQuaYxsnlz5vG2heP1XTWBStFhTG99UavA03XoMCX+pIBOZ8hfxBpxFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=r64R6/0m; arc=fail smtp.client-ip=52.101.125.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR+DpKQQ/HYYZgPfRcpQJr8XEXyK+PCtIYmu9EjiVoo8nZNa4eklFobZ9rWT2nDFA9l/8Ii9S5X0Awn59hnhbmky8DvGZIKmEbX3l+3r3prLMruEt38SERzOy7OGcSzbN1ZlsGq81A5RzqwXKK2r9qKL24NqLhi1UBNF6Vs0ZocB/eueZq48fdW1d/PUFN+tJeAVforOjUWDTmNTanXHEAmQWh16u3ZWngIg2IbO5G5kGBffoX78dUCiY6M1vXuuRC8DoxQ9GjFNExOLf776/VEvuROomU6YAL6Dyypo7hXv8J2OAOOFygUhIl9f8hYAFDPOBv8C/jiu8bWKS6KJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aejmHZTz7UQ9GWejI43hWiigpScEqAsR6wP4Zf2Pe+I=;
 b=jMkrUTZ8uKjkEl2MbIpiQaRUPoUH6cWivmxtLl2nFuTS9UBMjm9RDMdyf90v8JgXYCrsKPRfLC4lJZjreZQ/1bPhdXcp9m91z9kNWo8E693tNyuV/6fylKdTuRkJLcfDfQ+TuatHBNuh8lQ12O/JYqNO68Xc+sTaYEWUUBPKKBYGuLzpuWPsBymdivOaiFi60yOogQRdGMt64kYZ7ywzk1umGllz2Uck7OBnklFiC8qQ09q1+oLv2CJNes8WN8OyQlKy3rlHnxRk64XKnAUFKqefwJDEGxTfwziAKjlpXuEbmzeIVD4vbS2BSBc8xSc4jERMYF1FNA+vu+yU5anpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aejmHZTz7UQ9GWejI43hWiigpScEqAsR6wP4Zf2Pe+I=;
 b=r64R6/0mQOHUzPlXOhgKOeRCIkflTA7Rhgx+aT1UYEUhFsiB83viNUbKBsPLeCyfXJ5ruC6VUq2vdByI9FXka+F4o+fcNzAnMuR3M+Jk1NJsXmsVk71HaeUXhqzV1BKslno9E0zoD9NA4Dl9CqpNvoMfdC1GJrcVhFCHSjVvEpU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB7131.jpnprd01.prod.outlook.com (2603:1096:604:11b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 17:02:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 17:02:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul
	<vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: sh: rz-dmac: Make channel irq local
Thread-Topic: [PATCH] dmaengine: sh: rz-dmac: Make channel irq local
Thread-Index: AQHcfy3Y6IEZqnGUJUuvMX8argWUC7VFXdGg
Date: Tue, 6 Jan 2026 17:02:45 +0000
Message-ID:
 <TY3PR01MB113468F30E826F74FD84184B48687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <312c2e3349f4747e0bca861632bfc3592224b012.1767718556.git.geert+renesas@glider.be>
In-Reply-To:
 <312c2e3349f4747e0bca861632bfc3592224b012.1767718556.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB7131:EE_
x-ms-office365-filtering-correlation-id: 6d6166b0-886a-46db-49d0-08de4d45697a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TqtV8Nf5u83WHbml5NdccFUWZ+NUyUhubYydPImTqMnz5JMZIhmcaQ87vF8N?=
 =?us-ascii?Q?veESFdfBHQl0oxJXdtoNqhK0YONmijCOqQ1dyOgj/PfDM3ceXyhUzNilMtZk?=
 =?us-ascii?Q?+cStwlMTcacqpvs/6G1QbnpIumMY/G/lSzbvCSHSJzVMVSJ50o/AtLcdgGrU?=
 =?us-ascii?Q?yC7tm/04firkV0cO5byLK+TPceuX1UDhIWZaXlOiIGAyKkyN0SPqadyn1YRS?=
 =?us-ascii?Q?Lc5/YZsM1LwPjWMdCUHT1EUj/Nwv8Zz2miXAAKcEZq57rJUkahXM+SGotah4?=
 =?us-ascii?Q?hXapKNfHBCxPxvl+J11m7/zUfhTJCkOGuhLnpeN5jI1uov7jxN8UMzoboBgt?=
 =?us-ascii?Q?Tfr83Q+2Z65qaxKACbP51b5m2qSgB7YhJ9VbIOgn5AZRxtwP+BGpIrZW2lUe?=
 =?us-ascii?Q?ndxQkAkD6Vo/+x8OeMt/xpMfL7mNs0RD50GNt0VWy3WSysrkBdpFUXwq5hTt?=
 =?us-ascii?Q?usAEe2owJnNABo5B5780BklEuPRbqaoT+plKf6gxYz7pQ9Xh+q1TP9mM8/MR?=
 =?us-ascii?Q?LmiOPLI0hpEeWB13fDR15BfVbq+45WDhvxiP9LmckwUV/glGBTQm8tgxWdu0?=
 =?us-ascii?Q?rhnqUjpUf09qPv6RMDZHWBqrixAjytZDTyUOvORiqLsSYCD0hp2SC6fcSxWR?=
 =?us-ascii?Q?LYdkvPvgNvhhtIb4K/AQFwZaEUBUmnFiy3wIFrRiO6AnE9yTEEYB4qUUpr/o?=
 =?us-ascii?Q?yvpqzkw7s2A011lvFTmQWg+USFiV4RhFuHxUvEjtJQxS9ldg+zgy0ZHNMJx/?=
 =?us-ascii?Q?0hNSVwf1nroOE2Xos+EkE00/78DBZ9ZOWkzf/hZbM19ekqrfs98zFFKgyiBh?=
 =?us-ascii?Q?iYybrU+OWL8SRZ1KoyuyA1uP7UrsH0XlyLar8R7NmYPocdblgX7pHl4ibfzj?=
 =?us-ascii?Q?CngtoFwC2T2P3d3rRh8r5tFwHTCpmufVfXN1U3nbhOpuO/CPtBVhJMBcAiA8?=
 =?us-ascii?Q?+8XYURrhT+ErmE8matJtqY37aNNduUsL5pVdhJOMM10/dyF/Y0AaRDqD5P5V?=
 =?us-ascii?Q?551CArIGQ6+OjYjDYF6eHiJbOl45qMjaoRwLjdmJoQKIoWS5DDX1uZBaHs9C?=
 =?us-ascii?Q?A4TJY5bSpqRrLfWLgHKX6i1KnoUtlcNX3cogJ0hXo3ONxjxt5dLZotl+pB65?=
 =?us-ascii?Q?/ST+QyqDvgq5Exl7Og/Mpff2DiYQd9pSvkdtk3dnUrZ52j5/K3QlPtI5ipCG?=
 =?us-ascii?Q?VWvvi95/OewyD982/G7KRJlewC+5+T/73/AiZqWxyEjkstSHrImTSlDD2w9P?=
 =?us-ascii?Q?v6gOSuqzg1VYUYTa1/CgnQaY9dlZiNVPB/aeHtVJnFCsbK+gehq4BOlkWthZ?=
 =?us-ascii?Q?mTAodtiFwex6KuRMOJrYiCLHtRiDNua2xlXDxIfJwpzg7VMpF/w7HnI0bGsk?=
 =?us-ascii?Q?Mq5e8bSvGvh1RVUsbiZyfgiJfGbbgmvHIC8tA3fnUxmzx0Y7A78bDQmFAZNr?=
 =?us-ascii?Q?Zg7ZzAf2S0d1Fmd0FyESaEQb/DhenBhYDrZ9spVRlhn+K322GPEGeRb+JPpr?=
 =?us-ascii?Q?Qrh78+aRq4OjaE0f0sCV2zKAmEJnXY92jqxi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2sx5wp0J8F+J21J6BC2+3OnHuQeBEIYUKsjwPlc/Pb7Sit9CSnCG/N8uj1q6?=
 =?us-ascii?Q?/uv2peARA825Jzk6hgXIxi1pkKl68CJiXHhkp8Bm/32gqmlh4c5sEoNasF9I?=
 =?us-ascii?Q?cVfC0M0T3DSR3/NGzgTPTfqQnDFOuUfw4Ck0GDxEyrCRvFxFA62xdkjHJfCz?=
 =?us-ascii?Q?RZbMMbBzVW/FH+PIOaxklEUF7T1Z7+pFVamKwsNqe0i/5krAUJWvXfmsiIEs?=
 =?us-ascii?Q?wWS7KLLPoamFiN+yaAc7Jl5xKDlQ3OVeloXPnJuMy5C/wFeTqZWifVB24SqA?=
 =?us-ascii?Q?i59a9LsPmJsuEYwlalsB7uMiW6MmYVW1PTMNuUu5giUhn+3Xw0WHx9SlcxZQ?=
 =?us-ascii?Q?HS854mQn5+gnBAjlzFRc+rI40WpOyT/YFqMzWWm/WeOxIMjKrpL8P2WOHNXC?=
 =?us-ascii?Q?HBMeX01jfFDYT4pTSqHktbBC6ZUPB24jMWcwGjtYP2qjlqJLcRRdVdzr9LJ3?=
 =?us-ascii?Q?II/JCG7mxFgeoKLU3gZ/AuyNA2QvY6B/c8/Fa0C8Ajirw5VYb14ov5PHZv5S?=
 =?us-ascii?Q?VFOKmonzmpy0BsHRVDpTgcnM3i2o3YUzpJgmuodTBEaKc7HZK8v1AadFPxki?=
 =?us-ascii?Q?uCmTWHHLXu9ExPPYUxs/gpYEYOq3F22zWlnyeM+6/Ng5fR0Qak8SZSwUTKwQ?=
 =?us-ascii?Q?5bto8quBYKgWNkCQEzRob/Bb7G7oMfVNTVLl78HDNhDiPNB34RrmoqlzOgvh?=
 =?us-ascii?Q?i7E03oLU4ZLV4F35UU+IU7gpBXpIHYXkVU4sDnPQE4O1JmeTyqQ8c+EHHWXg?=
 =?us-ascii?Q?dTS8PqQLBP3AJ696qFR9IHOgEx2MDPe9OWHd0iQ06ei8Tro/2DoozgU7u4lk?=
 =?us-ascii?Q?CjiiNqTAcJ7IsB5wlUjIzEiy1EpFS0wJZqQGegSXcOfxdyW5ctpkZazktznx?=
 =?us-ascii?Q?lx+4UQdO3WnhcXbL9LEGCVdrsB2hTedaiSak3coI2KkjiE9OB4RYWyiDmetk?=
 =?us-ascii?Q?jlY1mosQXmfJq+QWeqecmjlVGbaVAX4pUzykdwlrv9+xS8HOewB0dyO2r++X?=
 =?us-ascii?Q?tpgWZXTRiZoBayf0mnrlMKoCn9oz13a89YJZPf1EiWSNhZFZaVM3YM3dVMnc?=
 =?us-ascii?Q?oYxvadXa2ibOivMNuldoD0nkBwDCEApGV0UItfoaj9tyNYXJYbO+siaT0Z8k?=
 =?us-ascii?Q?N8x6Ek3JbePAn5Bu8Qa3Ffq+QBMq0pd3KgYEbte05DQcOSNbX6AK52BsUfEG?=
 =?us-ascii?Q?zrnGhpmd1VYIzMBHnnU2gwIg7ByTHw1wMkmIqeB0c1yLSpLT8Ql85cS3ykVw?=
 =?us-ascii?Q?nCZjdRXYXxrswfmSI8/QJkZyy0069ln3jOOCkX88N42m6/1Fny89Y8sIxwW4?=
 =?us-ascii?Q?g4cXKsf8JPEpHPYYYi8pcNb6Vix+gbZwDUpPvUtHnzL4+SFpSOifCpKx3DZ+?=
 =?us-ascii?Q?27MTrMP1+obLpW0+MVcIwz07sqLgdVxs2MmzpUhul61Ch4/Wtk12qXOKBGLg?=
 =?us-ascii?Q?CJ3cgIC7QmY4fFGGCk6I8hIUreQMsu4ExyPpSQNEGGfGa8GD9UebQO2C+Dm8?=
 =?us-ascii?Q?fEyPwx4VKlJzzzsBmtbUnIYxXo2yOqr2Ouohn3pEsXPv5U4xHtCWbJKWNMU+?=
 =?us-ascii?Q?L1IQ+XTpk0zCRhtN0eNeMssWx7O7U0cNyqdNNABYVLuaCdzeFBsqUGNv0ckG?=
 =?us-ascii?Q?LbLUE6aSCX+uzekivLvL/WIAlthjCiCZtg+KAoDMT/RUwehRDkJk1kXfV2RD?=
 =?us-ascii?Q?iDRWxQ3uhRD++eAKdflgxmmeyD+j9QrpSd+r76l6rWeoL3v6cGSe64gpwut4?=
 =?us-ascii?Q?WBKK6Bpk2g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6166b0-886a-46db-49d0-08de4d45697a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 17:02:45.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ft+6L4Nao3X77t41b41340ueL3HWCwHOhpDGKpuutv/gL3UYd1zllUWEeOR9Rk6jY1fK9L93sgfw8C3wn4SuvKOcuy4A0JzkEdX60/DXfnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7131

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 06 January 2026 16:59
> To: Vinod Koul <vkoul@kernel.org>; Biju Das <biju.das.jz@bp.renesas.com>
> Cc: dmaengine@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Geert U=
ytterhoeven
> <geert+renesas@glider.be>
> Subject: [PATCH] dmaengine: sh: rz-dmac: Make channel irq local
>=20
> The channel IRQ is only used inside the function rz_dmac_chan_probe(), so=
 there is no need to store it
> in the rz_dmac_chan structure for later use.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/dma/sh/rz-dmac.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> 3087bbd11d59d597..fddeb827452f91cb 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -65,7 +65,6 @@ struct rz_dmac_chan {
>  	void __iomem *ch_base;
>  	void __iomem *ch_cmn_base;
>  	unsigned int index;
> -	int irq;
>  	struct rz_dmac_desc *desc;
>  	int descs_allocated;
>=20
> @@ -800,29 +799,27 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	struct rz_lmdesc *lmdesc;
>  	char pdev_irqname[6];
>  	char *irqname;
> -	int ret;
> +	int irq, ret;
>=20
>  	channel->index =3D index;
>  	channel->mid_rid =3D -EINVAL;
>=20
>  	/* Request the channel interrupt. */
>  	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> -	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> -	if (channel->irq < 0)
> -		return channel->irq;
> +	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> +	if (irq < 0)
> +		return irq;
>=20
>  	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
>  				 dev_name(dmac->dev), index);
>  	if (!irqname)
>  		return -ENOMEM;
>=20
> -	ret =3D devm_request_threaded_irq(dmac->dev, channel->irq,
> -					rz_dmac_irq_handler,
> +	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
>  					rz_dmac_irq_handler_thread, 0,
>  					irqname, channel);
>  	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
> -			channel->irq, ret);
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
>  		return ret;
>  	}
>=20
> --
> 2.43.0
>=20


