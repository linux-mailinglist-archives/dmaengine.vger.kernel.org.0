Return-Path: <dmaengine+bounces-2115-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B134A8CAA07
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435AC1F21905
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796255C33;
	Tue, 21 May 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEFltne8"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAC55E4B;
	Tue, 21 May 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280410; cv=fail; b=tFsl/coGhyUpRo5QY7u4JbhanJW5T0D7M5jUT+ICQhTXdES7RfSiCeCFgVVOT3CxXOLbl5mU/bBz6WVcK/PA6ZCLhP/jdBplMLbk7OMMWTa8r6xPSgrQac2Ikxuph+SvPAS3VwH8JSsFawtQqK2/a38HK0vZBYqWuo1hCtk9/JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280410; c=relaxed/simple;
	bh=xVp6oRYTEwjy2xYo1cxYWnKb19TLpeAJHqI0RQdl+PM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o19Xpl4GLvko65isDR8d1QNTk/gi3D+xVfcGVWMyNhiP3va0k3oM6TBC/h3XiKN47hMB3dHQpaA8Jjxec0kot29RXfbjOy47h385USUfLiWIpW4MMEeeR7t87KJv0mci/LO/Jbj1cn6X9nR8XPtUf0WNNWYhzifOoUloqIOOTQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AEFltne8; arc=fail smtp.client-ip=40.107.15.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIeWiLBZczi4416oYJUi5wj9SEw+pPmdjYTGR6hTdNGpTeB2W1kS7Bsyb2J3iq5q8/dXE7JhfXfoIxT+XZtQ7Lnw+11oNZCVh0MTgU0Ptn7nzIUhK4uoHZnSgk+KPVuukns9GJym73o+5pxe9aJ5l/VxB7kTo/fsM/d49jy1VEOdT/JFtihoRb8Qe1/At9/H6zcCxx00MSt9w67lzvbkUSoxPlMQDDV/fYJZgTbeYS0rEj+M6PuMWeXPCU4QK3CUqS5o11UHAxdT6Cam1rKUxLAPEg5BlQeXlu/9I0aLP5WOPS55hvgXpQo27LjeWiZmaR560KXUnJRYApVKhmv1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UclhlkJXxaidxuOSXjUVuwcrTWq6bdxGssnPrJP24Y=;
 b=nxaB+UwLy3pEktAmp8vSFb3fAX5/0uK3wvsZhQ6qrqJ5gt+e7+DmFsDRAe37Ckbml57sJBqZemSBnaqC8+tThNNi2CRcNArkr9DlnMFnhQv18VJT5xw0Zuzuf2CX87EILy9vX91v01I0DKii+qT0vGaGQNT+7Ug9C5T6wP5ZNyBCeDQLzfU16pWEk/WO1wjL1Yoxq0KQPKx9BIrEQClxvcTTpTfYV2IUJM2X+1d4c9bfZ5M4rtjdTKhBU8eK/5HaAgkEMOHThvTJeFlIqIkbro/WOG0ii0fmFLkFaMPKgMYnVku0g7S/ugekctxjDGAT5gdOFOBOrgoUddgXUmg7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UclhlkJXxaidxuOSXjUVuwcrTWq6bdxGssnPrJP24Y=;
 b=AEFltne8ArNauCBB5Jjvgjp0gvKhuTsvHOac1li/yY9glqh71lVxme2X2w/bGOalBBCiJdE2lx1zjgA98Z7YlUxD1Exa8h0hJt/8BmokveHmKPI6bkjVfz1LPhqIQRIPYBZ7K8jofGdQg777gtyiJVke2qUB7KApdAUTRofrgwg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:33:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 08:33:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Frank Li
	<frank.li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels constraints
Thread-Topic: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels constraints
Thread-Index: AQHaq1kjDnbeoX5QKUGZo+eg7wnX57GhXEFw
Date: Tue, 21 May 2024 08:33:24 +0000
Message-ID:
 <DU0PR04MB941776EC6B325EDA0A4F644588EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240521083002.23262-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7322:EE_
x-ms-office365-filtering-correlation-id: fe5fa922-7b03-4614-30e3-08dc7970ae20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009|921011;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nNt+EL0MoBJjtVN06X2TP3HV33CK1AzL9ZC+iz0ni4D8FtZVHgWOa+5Sg1XM?=
 =?us-ascii?Q?nCzl1TF1L9N7vhTYkahERzir1n/rJdaKwzZukzexvksbPCBdDkdv/u6FZTVr?=
 =?us-ascii?Q?NUUlIvfAj+1tanYwtPMOtxrkiDA2LeInqdfNTKRrMdKrIH7J1glOmBr68wZs?=
 =?us-ascii?Q?V7YKzsrfVgS0nyrOhU7cGuIKdv2IdiTZXU3ASx2wvd+8MzznH5d5vlDnThb8?=
 =?us-ascii?Q?9a02M8mBpITKrhn21MvqwMjc3TQ+OO6tGTy9dc1ip+av3yvV4aVzFj9lNdNT?=
 =?us-ascii?Q?VqnXfALie7iV9xXnEPS1RnbDjh+I1RGVlZGdjfWrXPDhhWKn1bV5dW4G1aI4?=
 =?us-ascii?Q?nYJY3l60qBiq9KIsQfi/JmQ1MsYXUJQy2eJo+4l/hJFoeNID/b3/prgEMxB7?=
 =?us-ascii?Q?EHpNMROmzqq0/Y2eRdI6wdlkoW6noSZYbq+yd3iU5j4/EFtwKSPMeIyuFHXi?=
 =?us-ascii?Q?FbaM0tpd2tgNrzz+5dxcXl6EwSGpv5P0hrq7hk6IgczYgKB/C8TTgH/GCTgp?=
 =?us-ascii?Q?UrVsXshv0wVMQtQfMClcSRFrM3mJugT1Xr8VfWigoW8AfeUXQZHSQyvcHj5L?=
 =?us-ascii?Q?9V9OdjVfZdGmazNnTHzauobPD9Zr4fXih96kzhFO4mZcQmb9X1sx8OmZ30WU?=
 =?us-ascii?Q?hzVrbuNzZEj89mBi5jQsBI1Hxv9WNJ5lKyIn1/ty21HoucQmsBaJKbjJs1aM?=
 =?us-ascii?Q?J6MjqU1w/YQ3UumpTbvIQZruwCrryla2KnhD34c60NwzoiSuv/XKqz9gJVzZ?=
 =?us-ascii?Q?Dn4kwSQbPomADyy1lYFN6lHosxpejnsjFohwotxvc7r0kKT8PMMSWSt+Ogkd?=
 =?us-ascii?Q?aqDFSdlzCMFQl5+kSX6yyRD60Zl79MMYcuEY9sIz2SEn2/Eo02zJDu/5vL0N?=
 =?us-ascii?Q?xkGvL+qrzBKbRegKfDHdphtBIGS33h+qEOgYmh6uN4m6MMim0W2+hw9dipBl?=
 =?us-ascii?Q?WTdSZ7mOS9fXntG8v9a2yirLBepKTtuGVu54Wh3SpFE/kUV2l1/FCyk8oLbW?=
 =?us-ascii?Q?jmQ7IgqK1ZqH4kVakxMtyvrd/1sZAD76R9528S0rQnF2Hgq+k3Kg5JlfGKlG?=
 =?us-ascii?Q?pvgW4N9ow07TzBjLt5yn62ehvvqCVPG0iJJ+K5rw6K0dNHXfH/nmN7t/ZbE0?=
 =?us-ascii?Q?hkY+KZsuobrNajErT6AfqoatSR8APuUKmRh7uUjfr+rSAQG/+pDwEeWivU+m?=
 =?us-ascii?Q?YyMgYaW5jLvwHSbmFTLwZ0wNPVrLxnQz7rn4j2RBWLtBZ7IlYGUoYanCz0pQ?=
 =?us-ascii?Q?tffb6NM/+Mt3y37tgnkpSXNnCBg65RqkSyVBRPRHO/KV0wreUBTA8QBexbpM?=
 =?us-ascii?Q?VQypOCNJEGRHdCbYorJPpQhmqjyywJYrEJHw9BZRPzRMXQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ViH8S63U8DzHUj5RlQzV/WgDZcyK7wdzKjeSGjVHIgUXecrhr1pk843BH4WZ?=
 =?us-ascii?Q?tK1p+X2vHH0erG5qcUWs9cgY0Z73FmifrN+BegUBmmUprtqF1QJtcSuT7F63?=
 =?us-ascii?Q?ZE4QCb4o43dUsJQWtyd/8Leht7e2W9HBp0BPS6XpZN5Szy0yUeN4hrl+14K2?=
 =?us-ascii?Q?GuTVjgsSBv3VyzzXLiRR6Qt5qg5kuFyGnq3p/kTkGlhLRs3Glh8HAm6W2dtr?=
 =?us-ascii?Q?5/JqKDZJsIO5j8Xi/FGrXQ/ENhuqQqW7DvBg18lI5Q87p9ZQ2fpglFhGYPW6?=
 =?us-ascii?Q?Juj7Hxm1SW9JVDlPcC2Rm+Uddd8N2CxkPcARbf14U7GWIlr/rQUZij0f6Udk?=
 =?us-ascii?Q?FG0AbTIVCaDzqRTAHQbbRW0AEYhoBaudx9gdzl4ENpiGZfKI/0vS04QjGt5J?=
 =?us-ascii?Q?XDRYJ/GeIXQ9QTBy0bFoJEnwRrsl3IAe+5fiiJntpIjvEczxUovx0/qODnxL?=
 =?us-ascii?Q?yZ5j45g73IAZu5rFLbhdAOwG6kiYX1A9apeV8CK8X9NHomiG1Dw93fXHW6Zc?=
 =?us-ascii?Q?xddcdzeS42hiNUbmo4kmdKboSnZTsDWbwaO1BHHd/XnGCwAPB2dGL3Iyptl5?=
 =?us-ascii?Q?1vGeBu9SfI5S69Yek0WPn+fOv7O1alr+ySzyxVlmQL7cylqcWmItxgUIi6y7?=
 =?us-ascii?Q?VojLkhoXljZA+mWjp6VvrPO9U8aaTYNUQgkb7KM81BWWgINemh4cMjRURKNa?=
 =?us-ascii?Q?qGCiorOPEEDnSE092kQXlXPuTweEu1UmvC81EUb1brRsMb1ZnE3wEKM7ekBj?=
 =?us-ascii?Q?oDPX3Mp2hyEwW1iSIsRacUDiRAxHv7ZqZRS/ThhKJXniULMNvkEVe6Vt4yP/?=
 =?us-ascii?Q?fU4ymGhBzgF0hz9xssN0pjVpyI0F3BWGSo9tuKYnda3iDR9MiiRD2LebnQ4N?=
 =?us-ascii?Q?pyI9zRSvc1Rvp5KeaLEwzZM4mqdXWTeyTSxZHZX/T+67I06foh26AUZ20+PH?=
 =?us-ascii?Q?tgcrm/150tfsv7gDU3XskAhgX8bmco7yU5EamYCfmByblp664VKkbmYd0FIN?=
 =?us-ascii?Q?DdXWN7VLdxVOEOjiB/0YcJgH8LH3XvtnMLMtjXYk83+T4bl5vzxnJTdTCXB9?=
 =?us-ascii?Q?pDa49S7vLNBvOkbHVyz09lTw4BbOH6ccrGJfVZeaRBAOSOAUpx75pVp5sNoO?=
 =?us-ascii?Q?+KCuM8ZLKd5fv6Z3MKXJ20wndwpGZs4K/j9CAIJxNDNgYORPbNs+5rSPrdU+?=
 =?us-ascii?Q?yjxgeQggKGOggXGUsoDUTNNozBJXKJqmUqlNX3N3NB6ZHjLKWO0f2zTI0kYZ?=
 =?us-ascii?Q?ngf0r8jZBQCei8P0E0NAD/wBO5gadXppfcwNxv8t5Zecwsuxk1uJCw2RGXMB?=
 =?us-ascii?Q?KP6N6WQOd8v5HmPeLWDfebT+JAymDALQYXXAapM/g++mE79q/nwvRONovDG5?=
 =?us-ascii?Q?0rXTd1bs6SP/GWUokIQa/Zaa1exISCyUTjgpLXnUXYuNcxTE7tHp3px0jTkL?=
 =?us-ascii?Q?59E2xBL02yqzaBm5yAoGBWMlp3zbuXYNo6vB5RHZNAgt0hzGWaiDamSATvH8?=
 =?us-ascii?Q?Uhx4ZWLSEyzmRHuj05yhjjhTepZs2pzNUlyoaGdA0l49lps7BHAGGeIdOl4U?=
 =?us-ascii?Q?QIN7t7C2oSQFKa8DQkc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5fa922-7b03-4614-30e3-08dc7970ae20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 08:33:24.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNuNv8FY8SfEnPTYIo2kSqTmkmHd9hMFauikql2fcRpolRtBYm4gRDFOsDpmzHjaL/HW1gDPUeU2xL8KOIve3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

> Subject: [PATCH] dt-bindings: dma: fsl-edma: fix dma-channels constraints
>=20
> dma-channels is a number, not a list.  Apply proper constraints on the ac=
tual
> number.
>=20
> Fixes: 6eb439dff645 ("dt-bindings: fsl-dma: fsl-edma: add edma3 compatibl=
e
> string")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

