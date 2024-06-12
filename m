Return-Path: <dmaengine+bounces-2354-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB39050B3
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2024 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92301F2414C
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4016E88B;
	Wed, 12 Jun 2024 10:47:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032F84A21;
	Wed, 12 Jun 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189238; cv=fail; b=gus+oKt7UU1H4ZNkeCAB1yfvM3Z4gGcC0gV35GsQ9G8ub6Mm00Zrut+HmzEh9acDbDAKp3CHHq0CpssSz/36OlW++q0IV4zfbDiEMUveUln5UpJBGqZfEzdaItqqz+WdRB+HIvt9kEjXsmMQMKDNSPUnJ+Vt7BR5yf81QuOpjjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189238; c=relaxed/simple;
	bh=oyU59uWBlhpz/dzB2XbZ8yS2oKF/Gg+L7snJYcG1WqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sgmt4UW3+RomKX21pB3HM+eyfjskJvOB873Tg6Z5futpk3X+uV7+utHuvDEM6mIf4OA7qPHSjbVs/U0ZuIAdhJyWPQ78n5j8JW2NoKFwCXCpC8TvXf7IjWwz6Gawvqxh+c5DkaSJ5dOJDX9HbnQT9VcZNdeFC2Rct6NE5YmBZxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDRU6lqY1/DolojgXzt27iZ3VwKZyUCCNHdb2T85p3eyYr9jb/PpjgyRYGZXPxm+Ur5LOJ9LAxLAt+8KxkmljtfOZUK8y5XBBP3SVLpTT21gfh/tfF0yb/SQplDTIHn3toPB/VxHe8k6+6AI+g1vUnIHX/VIePR4qbLCHGDstcMQ9AXDKqq1n6EEJ8Ue4D4Oedr2SyWzRNGpcRC+wex2lNF4N7aljNTumRJXBvbJToiKAq/srwxmigkaQtwFzvp+W2hFJaAANNrff03tZ2AnKKmmd+kks25igiFv6PiYWkzr2sCYGQZ8Mw9o9XE55s+Q7AZQPdl+359Gb4AvObAphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYC7lAMr84vaQfxhFj4YJDGk3n1eyG8mtZC7ZDEewNs=;
 b=jifHtrJghjNGTL3L/ThHzX1Apv+7jnWYz+tLbmNvpqUQg7ExozK484CKZNBBqrXUjHMs1VmbbeQwH8uAoA0kp9vNE40/A3ib6HXNnstzLcMEKubfTmdlaKXLrZz5IWX9vjLUt0D+EMGYrhttQq9KMeXuVpr/3AZhz18PzL1aHfCMKIUtutxlSY/5hwCw45/CKP5titGVjhmpLJWA1TfF2pr+QWUS8kMLQfEIh4h2ckbAESTc1XeKvASqfwtY5AnOks8K9krcFvhnD+8dVPGLGHsaaFZ2FNIMI6B8KL3JXDUg+8UxjmLhwrEziIsfkvJM0/r8gEfWFuXctICLrnbeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.38; Wed, 12 Jun
 2024 10:13:30 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce]) by NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce%7]) with mapi id 15.20.7611.039; Wed, 12 Jun 2024
 10:13:30 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] dmaengine: dw-axi-dmac: Support hardware quirks
Thread-Topic: [PATCH v5 1/3] dmaengine: dw-axi-dmac: Support hardware quirks
Thread-Index: AQHasj8OTzZ9CEf8H0CgWgm1ave3tbHC60wAgAD2s5A=
Date: Wed, 12 Jun 2024 10:13:30 +0000
Message-ID:
 <NT0PR01MB11826C9F142FCD1A1199A11B8AC02@NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn>
References: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
 <20240530031112.4952-2-jiajie.ho@starfivetech.com> <ZmiOemWQrG-3EdIB@matsya>
In-Reply-To: <ZmiOemWQrG-3EdIB@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1182:EE_|NT0PR01MB0976:EE_
x-ms-office365-filtering-correlation-id: 4da55e4d-2239-401f-1d49-08dc8ac84ee8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230032|1800799016|366008|41320700005|38070700010;
x-microsoft-antispam-message-info:
 8iPYnKZOuakbiVm3Ik2TSg8G7Yfm3uw55Kcsyj1GgGiTW+tAOq1YJvcYuSiBksxDu6VzznTy2Bim+JRNlkQEd7WE+h9kbJa0jDJAGBk/6qK3Gdxx+hzvwHsYnKQI+Bpcw55qsbvyK5UduLA964hrzdiq9KXzYYL5MIaXgYfFA/diVlKBJMl6x3TFPqEGcCKaTmdN0H1x+bAjRaGKzdqq0XIFP4Ij07ni2iU6Lc3ViKRgQqWeDCkYCpR0q5gWyLVF4AYWsZJmxx1yLJICS7TB/4YmqrHO8RUFlm1fUNG03Gc9ifxm1s6dtUXteAzqx4SFDDJNQAltgtfEhVn5l+kDMbj2YDF9mLw8nQMI6+Ntr7V7ty7ol4vG8AELtSQiz+BsZxTsvDSRhaXtQX2W0xdnG98HmLRhhF9N3/QLcMwcyiHu+fy0uJSd0uNG2RIu1ngPEFJRUYmuy9GTp/Gau8LSOTdS8kEJxhgS0FI1F5JDP+Aoe41qOv/crqxSEjhy7Pgf/VuSm2ervrAi9EG9vjBoFNSXnDgRAlFrqbmJfeo3W/Fc8NIZ+nTo7NGWoOsysoXpvF/sGE7a74kC+ZuPVDiPYCXWYnelpOFD+wwDJ4l3K0r4Bfk7szgBRXwGy/9dxOUc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(41320700005)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N7MMaoVQ+kFd/cXVfNKZnOicOPoV0UCbS2IqDuM1up/xUJ3IzV/xsiEaQD+H?=
 =?us-ascii?Q?nOANXakc1Sjj39THpAaotiwtU6gfdSXKrCH+jsOzQ98CKvsN42vJ+5DwHi79?=
 =?us-ascii?Q?ysNxgnbKpKOW756xhmMQPeCODIoubGJSRdS44anZCXPtvNLjlcWYltkIhKZW?=
 =?us-ascii?Q?MYnuv0iabBhFw5tPLmVVP2O3zEby6XKTU7u5WeYuMYCOUr+DRPhN+jpZH1qj?=
 =?us-ascii?Q?bjMiQ0vuGwT3gTe7IuL19EUsW8ytBmcNYlu4vmvaXLdIgBfQ4YbmTX7J0483?=
 =?us-ascii?Q?aWd9nYcwJqgSmSPDCSSFz2nh6FUBgQFTS/yLJoUcQxZi+BK79/vLXwPE5Aku?=
 =?us-ascii?Q?rusA6evO4MH07Q5ogEHG6x+3S3tZcwf6nm7nCrRJqwToqtrisaNmYS0lLY9B?=
 =?us-ascii?Q?ti5O+TyzUCrl32l9qA86IJZcwzgDp1+M9cPKoZZKK5fVVL3kqifmw0lyHN1f?=
 =?us-ascii?Q?uhxQjXyoJElh1su/NsJ31tlMTRea9ZBky0ZdIsOVGee6xwvOn2J3vCxDl4Zm?=
 =?us-ascii?Q?ihHPxUrOmDtxYq2KjHeUIaLjrRZC5snnhnFW/U7CVWQPlgEJ/rc4onlY+SU/?=
 =?us-ascii?Q?zPB58G5fcLFbkzDCIOOynlOv/H3h6vhI3zYOoNNOSKFIeDyMIW82OC/xD291?=
 =?us-ascii?Q?t12CMrS2WtiX9lqhn8j+xZWykWia52TR7y/aqok1bXvBdvDRDtGGsbYCXsku?=
 =?us-ascii?Q?S09I3eZSBSAQMaj7OqBOTC0SwJV4LuAI60MH5JlOgmTJ+JaGUSKLxK07q3n1?=
 =?us-ascii?Q?uP4D2wr/+uM0GuFFsQR1SWz8VNkmZOuzNX/esodT3R43qV6CnB8J9SzOq6/D?=
 =?us-ascii?Q?z4sq+9BZrQtBhzDFWReqfBHQifjkNuGFABQFAasm71xEaImwCnyvSXXBijBZ?=
 =?us-ascii?Q?tGN2/Hu+CVgi1jIoPrtDT59Y9cJvySLmqLk6g/nXQ9Xuhv6T6VkCE+xIGxt9?=
 =?us-ascii?Q?gP28UUeW7RAkxYpCzzlE90ICwSL/VpUdP4cQwYBhsR1f5m52rCu3AEv0PSao?=
 =?us-ascii?Q?poTgCueJnXO6NFQ1nHlkmO6EM+RaF9FdlZdTBcX7EmxJZj5zQ5y5s/UyKAdC?=
 =?us-ascii?Q?D5vHPYZNwFUWb4hDpkvFD0q9oJB11xUCwTmUDh95EY4OoIXvr+wfsHfO/uUX?=
 =?us-ascii?Q?F/3zhDf4eB35R7wKJPmUk+PO9s0gP5EEvf+mKzOLMeHlVk8KnlPSXwU4Po5k?=
 =?us-ascii?Q?kSh4LLtj2R/eWpuGg+Nx71bMcXBvpYJnih1uH6tKUnjOQNEL5u1FLTeul+TS?=
 =?us-ascii?Q?SkahqnNKz9KcQTR5J4k14uJ/+wKWNJwZ3ea4qBkXelGeSCSOc7OSorp1vKym?=
 =?us-ascii?Q?6ucwOGNI8FJLO2d99Ixys1r0AQ8nDnyK7vnVHzj14xAlVq2sMdn2/oDerUhd?=
 =?us-ascii?Q?ykLpRu1J/y0q0pse/flj+6LAANlmvN3StIy0w6kE2I+szuiPBVorHN8Jv0gV?=
 =?us-ascii?Q?aPDJ9D0Tj1ZXO/0afC03slH8IXFkfbmubzpImAgz0k6D4zEcmh/Ilfv/mXWv?=
 =?us-ascii?Q?JZuia86XfeqddoGwTKUav6YqKsOp4Mt1fjE6B+l/se75Px8G3ecbHEGmB3i1?=
 =?us-ascii?Q?ldCpegvp78NoSCwsuUKLfn3SvoCurdGj7U0YPU7oPbJizBSrCsizmUum38cP?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da55e4d-2239-401f-1d49-08dc8ac84ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 10:13:30.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OgE7UjI5WoQnBE/y2wNfXSDyRm9a42EWu71RqBm9UjapoDiYs2l+vfisZYoJI1PABgytSquvVcLZtALGHjvs82VAc2LGYMI80zKicfRL8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976

> On 30-05-24, 11:11, Jia Jie Ho wrote:
>=20
> > +
> > +struct dw_axi_peripheral_config {
> > +#define DWAXIDMAC_STARFIVE_SM_ALGO	BIT(0)
>=20
> what does this quirk mean?
>=20
> > +	u32 quirks;
>=20
> Can you explain why you need this to be exposed. I would prefer we use
> existing interfaces and not define a new one...
>=20

Hi Vinod,
Thanks for reviewing this.
This is a dedicated dma controller for the crypto engine.
I am adding this quirk to:
1. Select the src and dest AXI master for transfers between mem and dev.=20
    Driver currently only uses AXI0 for both.
2. Workaround a hardware limitation on the crypto engine to
     transfer data > 256B by incrementing the peripheral FIFO offset.

What is the recommended way to handle such cases besides using=20
peripheral_config in dma_slave_config?

Best regards,
Jia Jie

