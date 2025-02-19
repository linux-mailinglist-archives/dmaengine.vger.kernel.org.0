Return-Path: <dmaengine+bounces-4538-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F67A3C719
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 19:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1141A18898C8
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CE214A79;
	Wed, 19 Feb 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mKulVsX/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010059.outbound.protection.outlook.com [52.101.228.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC81A7264;
	Wed, 19 Feb 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988705; cv=fail; b=VDNzBpkrE6g/2kfvTaXrz/jzDBxTT00lu27vOC6GCclk7v4gKYOEq22yKkWI2ccvrV6Vf+mI3ZGb1pWxpZyQfEu1+b229GGbiDkdtI2bOf63W8fvi7Syi10ukj5zu5p46rUpgwgAEHrGUsxmihA8OG/6VmCrcZjCNGY947nACj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988705; c=relaxed/simple;
	bh=GMFt+L1OPNFAZtQWeudDck/8yGrO1N+6tHXLfHVCpmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WL+3YTASJJN2A9QRQrdEDPFbxF09C45ohTnvlfMU52mj1IqYpQv20lFzqrxUPYwMz5sBs1EQyu3dAvjCaa0tNN68mFSFbyjkThFaEi/HVb8lL0bpjWi0lHrmTwRpqwo5sC2ibe/8jbgvsNb9uyzt0EuVB8+EjDa5VaYwsO4IOcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mKulVsX/; arc=fail smtp.client-ip=52.101.228.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwoD4SGQY5q3OoTRE1N/YYauwPDDGk/kJN1McYkdhyi6xB2MObui6UfWqL1IhU98o40KWimPGXkATbRXLIQRaF7EBiflNFr0/ip+r+uF6/EF91lKyu7wU80Aekj5PGKYIaKCpljO2NGlX9Vj/SFJ1AokmfMLjGhrsuMzsfqZs8E3Ib8/9pxtwMa4yThtD7l3QMB8kxLmgXnnIX+IqypSQTrc+snISaR3oghIxfgrEA6WcoeG4DsRmc74JP1AZPO8v+iMiqJILcz3iDYrF711mDGiY8mSitoiytsuGdD8oCjC28aakTkf9odZmggIPLSox/RTxQLT6TQGxu5eP4zOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZMmjb6fWLRazmRPEPJRYCel/2P08RMjUWEwdKKT4BM=;
 b=RNAg67b7NWjhz8cLWDPheNL2s4mVhDu7bNitMjkSXPCz9fEUddwXGK/35nFytKlUepLHjcxRG4eHzjlmAITK6k+TkIYl41q74gzvxdIro82EDLk1hBTjOZE0HOy5vLQYaAe/7InpcZoCOj+rx2h4lwE/Ya2Ct4Tjq1NomgCoV3D2hpqfUu6PO2UGqddboX5fEw9FwhevfZWtdij7Bp6TRd1Z21ojQbXqMYFQSMbsd8eMWuJlxdghhl6xQ3Upomy1DcYVxIbzSNwEZ3hTOvvnLMGthbXqmkdJTjD/2xl7C6J4Aq6YNirAFH+b6FoVvCIxK66CkwYCRwbuWHdy7immLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZMmjb6fWLRazmRPEPJRYCel/2P08RMjUWEwdKKT4BM=;
 b=mKulVsX/WE9MvjMPwyba53h2MOohjGA6py9WpFTkx4PgDvkyjdLqREagcTE08VfB97mFi/genF1+NgrKZEyGQV4lTH9wPgBEY+1Dm8BBYPKnBpoviCr2yOX3XGWbXerGn33TTuVLs6a5H2sQtLsiSnOBPzUnjbrNlMF88UbCoIQ=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS3PR01MB6021.jpnprd01.prod.outlook.com (2603:1096:604:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 19 Feb
 2025 18:11:39 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 18:11:39 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Vinod Koul
	<vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
CC: Magnus Damm <magnus.damm@gmail.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Topic: [PATCH v3 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Index: AQHbgl7vOOzXpYxx1kG2Wu1FC9xa5rNO7Sng
Date: Wed, 19 Feb 2025 18:11:39 +0000
Message-ID:
 <TYCPR01MB120932E90CFDA0D04F3E9D010C2C52@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250218234305.700317-1-fabrizio.castro.jz@renesas.com>
 <20250218234305.700317-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250218234305.700317-7-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS3PR01MB6021:EE_
x-ms-office365-filtering-correlation-id: 490a4a06-e525-483d-4782-08dd5110db5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FlZTKcqLdhSFl9GVISvIloPm5mkOpLtk3KstkVOXiH9pMCn4cHUkX4q1rL?=
 =?iso-8859-1?Q?omYW7ps6Fms3NoXIyW4EVHkTEPwBWbC8tQtNEdoKKjwjTra/YOhiiTnGm6?=
 =?iso-8859-1?Q?NOjTpQXvx+Sf/0Jvmf+fmGnw+vJC9vTqcfIMTP2LQmkUy8FaywVQkJddts?=
 =?iso-8859-1?Q?h7pJrfV+UGPh/0ZqMNgpNJfGeHLsHX8iEMPHbyY23cqCFrivK3SM26NRHd?=
 =?iso-8859-1?Q?1P02e5RSgQOYiPOPEfePwkScf8E0O9nH87xLHCu2PVddcO+dFJ0hx8nwNt?=
 =?iso-8859-1?Q?fI3iWpFe+C/Co9vy36ciBwurhnudv+7yjVO53JYXKk63IHaySG/++2A6Wg?=
 =?iso-8859-1?Q?irZHmf22NGgeIQN/H6pgox76dHsN/aNrKK4meacgvgg5KXpt+sHLaQub0H?=
 =?iso-8859-1?Q?yBZFGinZfzHvtSSLGDSKN/zF6IVaDYxXQgxPqdH1v3H8sjajQPnvakmJB3?=
 =?iso-8859-1?Q?2+Hrw4WCTPIFmhbarZZWdNMaXjjmG7hEwaeMVTyLy+/FIubY10XMAV7ZJh?=
 =?iso-8859-1?Q?XjB+lxjZLe7aAQgjtAbld7g9UH0DsS648kLC6tEpwpiLnrqckdYY8ilCgf?=
 =?iso-8859-1?Q?GYtdlupIIlWUIRCpXRrFiHQPUa9huSAPv8eingTOnYnrS9tguy1H7skB84?=
 =?iso-8859-1?Q?ZOr7lniGGmlfZSGPCFFuzGG8WGf+IQbbL2IXHFG17Q1la2GmNIX1IQRZw7?=
 =?iso-8859-1?Q?ohNgfbskTk5icmlBolyT4J6xSsJjBYu17oPV941yClcxPxY6ayqh25XUjC?=
 =?iso-8859-1?Q?4SgcwfkaVOErwfcUv8yBoPOKkWo66NKB6zTfycUDaSWInGq8/EbVS2xrq4?=
 =?iso-8859-1?Q?nE+4W0FOU32g+wfY2LIiwYO2iUpHxjUWu/aooKXEVbRHmD7bHXf92BLL+4?=
 =?iso-8859-1?Q?827AErOYzqs5H9LmKjD2vBmr4ka+Zykzew7ReXhz005LvRbW/vLlp0KBTY?=
 =?iso-8859-1?Q?sdbdu1sh2cHqt5mybOYcYNNrtkLEPdVhKXyLV6rdsLUr2h6aVBis/NN2Fy?=
 =?iso-8859-1?Q?BlFPb1B+bl0u4wOjKjDayhqBGvDy+4+7AMbwf1V8/Fe9kHHSoHoBmeeWeF?=
 =?iso-8859-1?Q?6qCklDpbu1+BKsflKKH/HdsTjtlsATcbGTFabpBg9kA0gH+R+bfEx71EL4?=
 =?iso-8859-1?Q?0T0IqJ2g3dCbess2RduK4F/uHe52XAvtHMiBukF1MO/cz7fMix1RFXujNu?=
 =?iso-8859-1?Q?mBXb40jth0jgNSTet/BhM/a+KGLOtItJFAjD8rPrI1TV0sqrn2uFyaYMrq?=
 =?iso-8859-1?Q?+T8JZUMWNbSv7kGlRCSULo+XMUFwO6QBUTx4BQnk69LMQi6jUiIql/EKLN?=
 =?iso-8859-1?Q?LxGPPdbmuBTXvbj3pawPfeurmsrPrB5SA1z+G7GnC1054m+UPUb4aaUsgd?=
 =?iso-8859-1?Q?kbOCYZeeMV9dFLakRKgrfJMduXKidDl8pVF90MQ+6HZxkBhjxtCFvGqjfz?=
 =?iso-8859-1?Q?nRgsKlSg2qK9daoacxyG6tO9P30VxyfEUhCs+ZHghS5HnLnnVMbm0XjQCX?=
 =?iso-8859-1?Q?WQPO+ehQxhglfoM7n8pZbg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iE1VLxPEZp3rKaMorralSVUD6tNW0JfwhTda0ShmOKMtPMcYlAZOMMhP4v?=
 =?iso-8859-1?Q?vk60K/L2J22iAfuUycR+UWKzdBBHy9j3CESI6Pl7kNM56F8OxO2dAFizqC?=
 =?iso-8859-1?Q?e4fy6EzZ6wwYDeSBOs9TBCGuPR73iGGN/VEcwEestTS7rNNna8CXJb8he8?=
 =?iso-8859-1?Q?2obdFqeM18KyFJdYweNj5whITaQWRLIaF60LOvjxU/jVZD+yng9RCABl0w?=
 =?iso-8859-1?Q?pqkEIFMMEBN1pN9BlNTYngjTFM4FfCUcELR/OAQpn7hbcAIChmzzzI+FhV?=
 =?iso-8859-1?Q?6wMybHk47gA+CcejG0rzJRRdgYi+iVrCG+hGJoBX2cxMfS51HsIPbx/XT+?=
 =?iso-8859-1?Q?x0vfthTGaGmpZbGBwD5eThEnRzB01JNCRMwqiW2jVPRll+kltyhcg2IeMc?=
 =?iso-8859-1?Q?OyppzFti0yJ78piZlzTaXdrvO5/hWmt5L1Dnlkvcf4hi/r34dM84LChcsd?=
 =?iso-8859-1?Q?GgMG8ARvrCTzO27q7J4o8YZnOU4ImxH/v+iY6kPPnEX6mqiLgOSPrDsszf?=
 =?iso-8859-1?Q?5S0fMNeB0b7iW7vI4+8KDseo3bImBqcrS5PS3tFmbdUH5OVgvcj/iM8DLh?=
 =?iso-8859-1?Q?OVPOM4cdt7mj/Yz8lbeDmQ8y6hpWcJA+KHygLw3izVeHLrJRHHT8fDtTT4?=
 =?iso-8859-1?Q?93ncXAN/lEmh0Y9vTEXwN6JHQrriaXfUcaDpE/5LA2K6kkNXE+AJIa85QA?=
 =?iso-8859-1?Q?t2HGcab2/Qfbcu7xLwvqzMDcsNgtgQm8cQ+J+AczyI7Gstwb13w48LSI4l?=
 =?iso-8859-1?Q?nU6CTVGAzFwYLbduzCgyLCYLD2UUomViV7UJXzbTp/q37kmwfA/EpxgBl8?=
 =?iso-8859-1?Q?65SjnLHIfNh0gsDze2HAQ5s/E/+pL8M4Sh/PbolcSGZgqviabtT92tOEtl?=
 =?iso-8859-1?Q?hKjA7TETr87E/lMujxoXV6UKtNooE9voCTBJz45zioLZEqkKAxcsP2GlsJ?=
 =?iso-8859-1?Q?3BbJD38zkfTWwLnPe6j3XAskl6w5dfEo9nDmeZc4PX9zzNULmKUg18x1Vh?=
 =?iso-8859-1?Q?FFPCl+q0JpHYb8u4TR37Yzd/dIbi1cXSYWnFh9PalUxquhHzbM74aw3p8/?=
 =?iso-8859-1?Q?ZWYlftstAppaSwmSr8Y23whBqamE3xjcm2AZqSTt1wtK5SY8HscBzSyJH9?=
 =?iso-8859-1?Q?5eoQC+okIVVTn1mPdbDwZADK60WY4CewJZQWFyYQqdn0Z2i/lg1FCj3y3e?=
 =?iso-8859-1?Q?izWwspef8Qsi85lLm9qnNtRSpyvAaF40svicXZbRtDzh4bkpyUwBK0fuy7?=
 =?iso-8859-1?Q?mTGhnpUYqc/KBqWkL4K4P94rKJGZ9raqIVPisrId3yEk/5C53I4DukcSjy?=
 =?iso-8859-1?Q?BS1xOaEPxlD9s/BLI5u9VUr7vsAUKS1C7vWAQjvNcQ38sgShaXu7uPxD9e?=
 =?iso-8859-1?Q?l89FwD3eJijpnrzbDpSTYE4gaB791Wdw5I84cED77lz2BjHlzDZeVT6aDm?=
 =?iso-8859-1?Q?TlV58y0weevotke63NowhzNv9iEuif9QdqD9gyVauZ1yovfr8YZU3JIJPA?=
 =?iso-8859-1?Q?HCHcKmxHinep0Vo6ZWiGp0ghJfxXhwcNl9Tzd1P1Q8p7FafgXt/gdMRgX0?=
 =?iso-8859-1?Q?4iD7aAmpp2gjc7hzb3Ur3CdEbFAiDcbWZO4Cf0VDLqOKRnHonLpeY610mw?=
 =?iso-8859-1?Q?gZ/eOAIft5OQ9MGHaJ5cdAgAohns3z9XHRoMfgbMWYmR9Io0yHAr6utg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490a4a06-e525-483d-4782-08dd5110db5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 18:11:39.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oa0s4f3jUNtUDvrOlqaMAB680k8/HuSmZm6wnUMf2uyNhxZCjrS+wGycjsWx82Z8lxdYShAs9zJh0bH6E95Z1s/oxhY8rYjUwP5tu4qEkOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6021

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 18 February 2025 23:43
> Subject: [PATCH v3 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
>=20
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>=20
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v2->v3:
> * Dropped change to Kconfig.
> * Replaced rz_dmac_type with has_icu flag.
> * Put req_no and ack_no in an anonymous struct, nested under an
>   anonymous union with mid_rid.
> * Dropped data field of_rz_dmac_match[], and added logic to determine
>   value of has_icu flag from DT parsing.
> v1->v2:
> * Switched to new macros for minimum values.
> ---

[..]

>=20
>  static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spe=
c,
> @@ -769,6 +849,8 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>=20
>  	channel->index =3D index;
>  	channel->mid_rid =3D -EINVAL;
> +	channel->req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> +	channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;

Actually, this should look like the below now that mid_rid and req_no/ack_n=
o
are mutually exclusive:

if (!dmac->has_icu) {
	channel->mid_rid =3D -EINVAL;
} else {
	channel->req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
	channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
}

I'll send a new version to address this.

Sorry for the noise.

Cheers,
Fab


