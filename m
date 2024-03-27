Return-Path: <dmaengine+bounces-1541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7188D50A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 04:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2ADAB22A1A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7D224DC;
	Wed, 27 Mar 2024 03:27:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2120.outbound.protection.partner.outlook.cn [139.219.146.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B620DD0;
	Wed, 27 Mar 2024 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510056; cv=fail; b=r7/04S3WLHbrh8o//C95mu+sZdevWKWABTtLxq/8PPaemAu4J0MWRiq3iowrw9J9lGjAvRRsqKfpQDAmxb4QrqwWN6QJ1ak/LpP3mwaiYbFXJBkCfZ24amMxTSApe2O+BXEx6F8IKxPZpW3Tt+O7S9CuGSH38Jidh1UAwopgdQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510056; c=relaxed/simple;
	bh=6mNI4TS/DXPa4QYaZCp3GnabEiUkexi5OhQrqeGJcd0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tOTaEN+epgS0ZUsVRWzIw/KrAUUh7cg7jS5/QIosaeKSGFE/TzKpZ6M2y2iGDo0QQtEq9qMD2iZki3r6EN6KbUhusl9Ez7mmSHCk6+mIMplYPSaEfdGX3R3BLgBYbswcsT5qWfDpnzVNy66qPvH5/rB6xv5hwLBKf8RrmF21jzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuAEATmEazILeycjeKlXV3UfxGnVI0L0hkXOBmR2wf1tObMUIDb+co+xVrsrMARDvfNp7As2KfxRLTVjw9Zf2RUhMhjDo4Si0eH8quPEG+9ozhQWjkNhUVqOEuqE4HzoMd+skcVw83+c8cmtMMgtt6qKeNko/7A8h99itWxwxhN0tyRcasLsDUGxnHjX30kbMzTwAmYSa5IIE/S/WkEyUX5/Uc1nvmfkK/HLmN+58Z0htEsd9Z+12LFadT+0V3v4F0+kzjrKpaxwz8n7UHpM8Z7T4FNjAD+/XAVOk/wMthXdDXYmlvKzU6IaAmkrQO6E/xQImT2mAeuEfa4CKSYdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdcMCIcERo7vykoimDGDFyaeHTetpEMbQv7DVusPsTg=;
 b=PE6iihaZYjjAQFa1GUduJ8x8EWaohpZJTlUTun9zEI7gzus4VK+Vxd6bxbVpE2aDofKE1eR1wbWlu7j5b8653yoZh/rJmnRK8L5gTBLPUHLnlPY0ybyOush1rg1LNwyHngZ+bseR98cyLmBMSX33FIwsnSjJpCRE0bl41RDHD1PR46gWInS4NstVSUd/QX0fZeFKK0HHBERKyBL0B+6u2VoC5MqcvnTopveoKvUfqromk5xWtBdrW+TeAZULeErImw5FJ/m3s1+UmfrLnQAr26K5FYqowaea+SIHJhHxIm1wP2EZn74J19uC459SDqgX4dKs8Mco952L6fmAht25iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1264.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 01:55:04 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 01:55:04 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: 'Herbert Xu' <herbert@gondor.apana.org.au>, "'David S . Miller'"
	<davem@davemloft.net>, 'Rob Herring' <robh+dt@kernel.org>, 'Krzysztof
 Kozlowski' <krzysztof.kozlowski+dt@linaro.org>, 'Conor Dooley'
	<conor+dt@kernel.org>, 'Eugeniy Paltsev' <Eugeniy.Paltsev@synopsys.com>,
	'Vinod Koul' <vkoul@kernel.org>, "'linux-crypto@vger.kernel.org'"
	<linux-crypto@vger.kernel.org>, "'devicetree@vger.kernel.org'"
	<devicetree@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'dmaengine@vger.kernel.org'"
	<dmaengine@vger.kernel.org>
Subject: RE: [PATCH v4 0/7] crypto: starfive: Add support for JH8100
Thread-Topic: [PATCH v4 0/7] crypto: starfive: Add support for JH8100
Thread-Index: AQHabswuRP6vmqtmzUiwGSiP4uQyCbFK9DVg
Date: Wed, 27 Mar 2024 01:55:04 +0000
Message-ID:
 <NT0PR01MB1182C3CD53AA7CB251BDD99D8A34A@NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
In-Reply-To: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1182:EE_|NT0PR01MB1264:EE_
x-ms-office365-filtering-correlation-id: 6a58d795-5fa5-4a36-b113-08dc4e00ebf1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FyyoNmpx69xw9V6F3Jt920pD7QvFM+ZMzpIQdv6ykNn0D6skwysQRH4YvpstdfPsihqRitHVDbvlV9qqFXCHdjVG48wXRDhdVmcHLEYyZB+mwVnZ4Bl9Y8lPMq6syCzkrZSBB1wB3usSPiZN3vqa+gjD4nh72sHPhXEzaq9/M9v/lUDQF1NKICCacqRRpp80cVEeaXURxFVBcB+fHXUTv+hjpJYQW10DI/KP/h11zdcCnfuJWZSHWazjY/oI8WCEjASPp7RumyxzcTQFNAcpA8N1vWjYQrF+mIAdDbFlU9DsWx1Fq4IeYA/pKUmMmPKfhqxWv6PGow65OJqwBuVRqY22VtcGinau7qVEjK2Wg7CEtLudYCv2K7EB/jcAkQgTT0JWJGNKNEPaasmueARwHLh2HGHAw7XdIrTXghMdibhrQaDt/IcD7ubAJmLy9ZIMjicskxl6l+e2oa5VeFm0NLi14kIMlVUsi7SMdIP+r7KpY094W6H6NpeayYBCi6jlzgPMMS3ogbbdjRYlG9kjA2q+oh9Dd6cP9AnEeRibLgI89hbsv5cWQyyZ0bPiETmy7ixFoYz43pykDb9M7COqPe0sqIP+ekMHjjWLC/FTqb1XUic/9xln20/FMCQs+RmU/fbgbuYoScoNzg7dbAClfw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0qffVL/8J822Ra1K1k0+YVG8qTDkWO0Nx2xGdQanPSsVTL3TgN46tpWGnAD0?=
 =?us-ascii?Q?p6Kt+n4Y5Ou4SwMwdvQ3Z5RNcDUzgN0OaykSiOVdIPLL8n8TNbvg5vV+pEBz?=
 =?us-ascii?Q?mC46CThCr3XmFH+/Zh4Q8vdgsueO6hFVxvKnRrrjvj7wJhskhkH5EBRUwESc?=
 =?us-ascii?Q?gxCCFnigREePZW6MtEkYOn0fSG6vYdOVYFz7azy66ANFZfLX6TEwpTK7jBkR?=
 =?us-ascii?Q?ombdvLNDwyyWbmHajbCpJIpQWw2nbSCByUv+5vJXk3j/wl1wf8ed5/J0BLDO?=
 =?us-ascii?Q?3TFGSMpUf+bKbtsSrrwKuUHpuQmHf+Nx5gTXL2BFdAoN+l4RxOkzbqsqXCpN?=
 =?us-ascii?Q?kTxL0AUlA2GcKxD7N4VPEGauxGd1a01WbyiMHSy3+nv6YvuaiLusyLr083WM?=
 =?us-ascii?Q?Xej7RuyBgIkCHNt+3unAy2am5ZqcJO1SyxEoMkgiE1K6p9cilDR9a7mvsXOg?=
 =?us-ascii?Q?LhoK8sjXPLQr/LruH5Puf3RBu6AihKH6Qlhs71pIH05dlNoPjgZlKHN9LmZH?=
 =?us-ascii?Q?1y2ywn+YULz9SZUF8xC43D2StkJjdxEhsouQUGE3L2NKqkZuxJRfRf7tGXHc?=
 =?us-ascii?Q?97MQZ74uEloU9a8ko5TuMwg8OVnES4XrLGitXK5olVqmLK4lCyIAY+wxmqNM?=
 =?us-ascii?Q?eGrAat5NWaw4VTK3UzoajFQvgtaihUABVzaj3laPHx8KaBrnGiwU50Ace8gO?=
 =?us-ascii?Q?I2Rp+CDepmctahLm/lTV0irjJ2Npf6OcCsZApjG+U/BTomCuS1roGjgzj9jp?=
 =?us-ascii?Q?rdkdB34oK69r0LobGzxTCb3ol0a79GHpfdquo+cz3Zbk1TZRLOtYCRQJdA6d?=
 =?us-ascii?Q?DBNvuu0TOvzJplUJQrSGhRLlcOQhIU96Mzpynn2oqniBU5VNotIwrT8xROxa?=
 =?us-ascii?Q?A0z50/OgHF1nj4yUjL3ybe1VHf496FcBJc5RbTMxLyZho4xi4eP5o3iH2a9L?=
 =?us-ascii?Q?+7ht62Lq3eDTWx3ORlLdkm9NvxPizyJSbRTY5vttf09Y5bUav5MDyOlGI4E4?=
 =?us-ascii?Q?pAcIZC6p71s7D2VzQIXJP5Uv0RjnTkw2+unLPB8shJbAx2xj9/aU6CQAlKCL?=
 =?us-ascii?Q?1tOLKXr1LNUA0/kbGz7pcWHG6n1Jtye8JWBg8SCZ5cYoDVu+psR6tnuBU2bo?=
 =?us-ascii?Q?DyPobTDcgBTQYfirzftuO2y8MOTQuxZfXUBPIHrbsI8Weix+nH6quQFaOO+h?=
 =?us-ascii?Q?8dDF02qlDQPQ3zG7K0LWA5BvAC2AmhGOeGPfWFergFmOCyHHHwLY1cXgFffG?=
 =?us-ascii?Q?SQFBDEpjZH2qwWUW5ntx9eVf9bWPMISdyA7+/87yCq0T3nTpfUwROqWD2AW4?=
 =?us-ascii?Q?/NMYGg/cEg7kaj3GopAc8G+yTzGpb6eJvqic2fv/NErtJYr9fEHiSjv3tyFv?=
 =?us-ascii?Q?XbBRgktGXeF7frmAh9q9e6UvbbvD6uaQ4EX+soNErO8FMrfyaRMWV1NEDec9?=
 =?us-ascii?Q?tn7dYwpPj60TWPU5axo94r2d1AzVISA/2KHmf+F3cIjVUbrV8eTpCxZO5qUg?=
 =?us-ascii?Q?qhTDF81FCwiX+J2SXxZlCLIAnPOVqGL1g27upDwbrl12HQ2nbqxuMR/arwGG?=
 =?us-ascii?Q?8MhOFkJ4fqjcSoEmaneJHCIr+cBxZ/oe9dsQvHr7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a58d795-5fa5-4a36-b113-08dc4e00ebf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 01:55:04.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq5uJF/FrrP6BPyhFIA0I7tE6GQgaxqQnhJErKpXE/mwm64px77vsxj4kqjM0dlkf0O9EM4YvwGHb08yPeyVjtzZw0nEaB3GBJ/oMO/C2eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1264

> This patch series add driver support for StarFive JH8100 SoC crypto engin=
e.
> Patch 1 adds compatible string and update irq descriptions for
> JH8100 device. Subsequent patches update current driver implementations t=
o
> support both 7110 and 8100 variants.
>=20
> v3->v4:
> - Updated interrupts descriptions for jh8100-crypto compatible. (Rob)
> - Added patch 3 to skip unneeded key freeing for RSA module.
>=20
> v2->v3:
> - Use of device data instead of #ifdef CONFIG_ for different device
>   variants.
> - Updated dt bindings compatible and interrupts descriptions.
> - Added patch 4 to support hardware quirks for dw-axi-dmac driver.
>=20
> v1->v2:
> - Resolved build warnings reported by kernel test robot
>   https://lore.kernel.org/oe-kbuild-all/202312170614.24rtwf9x-
> lkp@intel.com/
>=20
> Jia Jie Ho (7):
>   dt-bindings: crypto: starfive: Add jh8100 support
>   crypto: starfive: Update hash dma usage
>   crypto: starfive: Skip unneeded key free
>   crypto: starfive: Use dma for aes requests
>   dmaengine: dw-axi-dmac: Support hardware quirks
>   crypto: starfive: Add sm3 support for JH8100
>   crypto: starfive: Add sm4 support for JH8100
>=20
>  .../crypto/starfive,jh7110-crypto.yaml        |   30 +-
>  drivers/crypto/starfive/Kconfig               |   30 +-
>  drivers/crypto/starfive/Makefile              |    5 +-
>  drivers/crypto/starfive/jh7110-aes.c          |  592 ++++++---
>  drivers/crypto/starfive/jh7110-cryp.c         |   77 +-
>  drivers/crypto/starfive/jh7110-cryp.h         |  114 +-
>  drivers/crypto/starfive/jh7110-hash.c         |  316 +++--
>  drivers/crypto/starfive/jh7110-rsa.c          |    3 +
>  drivers/crypto/starfive/jh8100-sm3.c          |  544 ++++++++
>  drivers/crypto/starfive/jh8100-sm4.c          | 1119 +++++++++++++++++
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   32 +-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |    2 +
>  include/linux/dma/dw_axi.h                    |   11 +
>  13 files changed, 2437 insertions(+), 438 deletions(-)  create mode 1006=
44
> drivers/crypto/starfive/jh8100-sm3.c
>  create mode 100644 drivers/crypto/starfive/jh8100-sm4.c
>  create mode 100644 include/linux/dma/dw_axi.h
>=20

Hi Herbert,
Could you please help review this patch series?

Thanks,
Jia Jie

