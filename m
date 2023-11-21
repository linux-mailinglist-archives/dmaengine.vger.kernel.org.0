Return-Path: <dmaengine+bounces-159-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C247F26AF
	for <lists+dmaengine@lfdr.de>; Tue, 21 Nov 2023 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345981C208B0
	for <lists+dmaengine@lfdr.de>; Tue, 21 Nov 2023 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D256E347B2;
	Tue, 21 Nov 2023 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kEdVk6AZ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Lvn+jTqe"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967210F;
	Mon, 20 Nov 2023 23:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700553152; x=1732089152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ZGF6D08zRB+LaUvIcVXzkLUOQm4Wx4EEjTg4IeXzCI=;
  b=kEdVk6AZ75naw4DWcyv9aGYINASrN1jD7iJFMJxyjW5eOVREjsZ3sGKm
   WIpF2z5X8j3/dlPPei6hc05QA2S7ob45luVljXpYlKqBDQPlnyfseh/G1
   sVuLv2gBk/f0yFsfJGHKoAzCv0EPgbxm9Pwn0qS4dftFeVcA9IW/ITrIi
   WwTzQJxuSOhCmUsP2NKr0fH1JcL+2vE+t3r6DA1qLfq4Wl2m+obfQ/vFs
   lWw4CJ9w0FpbO50S3g6JUi4veef7ragvdQuTtj43hBXC3g59xSNj62jSA
   wwFhYcFyT3KD+PRyaLYjfkykk1p9Lf1HtvRxHVVrdS+/mjGSwBsLkNkda
   Q==;
X-CSE-ConnectionGUID: K+dJqAMPQGiPKikBmoSrog==
X-CSE-MsgGUID: 22K/txD4SWeDLKj2WTZ02g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="242723296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 00:52:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Nov 2023 00:52:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Nov 2023 00:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCaAffRZdOBXN5m46y+nY90QK6sPL9+5Cw1n1EsVsHNqc7ie90cHW0kzqrhdZUbRxfKYaLpkaInGtICulLEcCHhPqtTEcAERDZv/g19rq2ye/q8w3VFHk3Uwaow++X8ao5W4/Ll5vsYFcn/mvf9qYjf2o/1rmeGYwFFs0LkrSAXG5aPQatjAsMixiIwBvXrSpf94GSpWxJksfFX3CdjxqbYk2EBcuYoNSTvMBxtgRGwn9KbJndDQqlnAoSAlRg5P/zkp5L973hPPwWHaexIDfKhxQ6KRIMikXzCY9jxVfh1wtuZCLHuJZvV1+IaFiDRVrmaayzIuit0jdxlmdBYhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaQuHgmUliQ5qZmJaZOov74taB4TUSUKjYYQR4DEp+Q=;
 b=mT+HXyUrv7sKtEF9BpT9qYEBIWLXKVDKFABlET1YqZ/k8c9hvsgsso0DwW9puoHZkOLLV59sYaL9r/l+B9k6TIJNvwTKgD8BqBjeAkDiDlNBfEn6AeR0epMEBo9+gE0vwlkHhZKbBVvG5ZhxqWTYsGFilvNQ9SLHZz5e7vobFNkNqrS00hrUjCAlzV1tE4hMBLr1RNtP0sczifT45e0N6NmJDz85MMLRcbw9O3G3XECmCoUPr6j+i+uis3y8my9uXZMIE9HxgFQgQ/HJ71eakIInHvH0NJJjnrAhcrthomXWlx99CeyYL7F6H6yrdWsK5jmyUM9+8h70lFw5cG07ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaQuHgmUliQ5qZmJaZOov74taB4TUSUKjYYQR4DEp+Q=;
 b=Lvn+jTqekzM2zWpUasaZyERF8lXZurQ7lfH3PNh93SDi/5Ts1zP3AdQ6u5+UHWq5y38AWb2VGlkw4BvqjSytDFUEL9BtCjqQAJLk0Tn0b3QmeFZ8uQU6zCzPhoYvYO2C4NLODctWp1L4i2G6CJbzb42XgDiZFWSj79BD7yv4TtbfyAaS8LXJKPBjqTyZp5egW27ucaDiIBr3s8em0TtQra8EIMnaS5xYGDVPZutBwUYrBv014giR5s5qNtynqkt61xlx006ANUE3iClVjD1BbMCp3rezcHS7VGWho0sQHLwcplDyRqmvP3bDb8ZT2rtUebmUcckJMy+bbWY4QWwfmg==
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Tue, 21 Nov
 2023 07:52:03 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::447:632:a9ce:152f]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::447:632:a9ce:152f%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 07:52:03 +0000
From: <Shravan.Chippa@microchip.com>
To: <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<Nagasuresh.Relli@microchip.com>, <Praveen.Kumar@microchip.com>,
	<Shravan.Chippa@microchip.com>
Subject: RE: [PATCH v4 0/4] dma: sf-pdma: various sf-pdma updates for the mpfs
 platform
Thread-Topic: [PATCH v4 0/4] dma: sf-pdma: various sf-pdma updates for the
 mpfs platform
Thread-Index: AQHaC7ryo0Utpq8cYU+3kvUzBUAwAbCEh1Kw
Date: Tue, 21 Nov 2023 07:52:03 +0000
Message-ID: <PH0PR11MB5611FB5D700B2AE5B215D7C181BBA@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231031052753.3430169-1-shravan.chippa@microchip.com>
In-Reply-To: <20231031052753.3430169-1-shravan.chippa@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|DS0PR11MB7559:EE_
x-ms-office365-filtering-correlation-id: 4d37263b-56b5-43ff-e735-08dbea66bffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMVg4mxIA93pgkdXROMOt8IAx8GqTYDSrBzsKmg4rUUM9c6MSA4mUFnm7bFKnhFdvy31CUg1fIeFeDT28vHIHDZZLlnKDNpMv6IPv2Adc421zeUDJWoXtOswf86DyNvaCUzAXyzJ/FCUzIiM/qJk2FSWQXPD5vOUyzMXAc6LAUHWGvChvLdo4YT9bMc5Y5/tGLL5CQkOIw8l9IxkKT7xiPyY5Lo1qD+U5TuHbpKAbrxnnMWhcXoL2/h5KLhcItdkTZMbZ0ooQH4ERvYrmSWl7kJV4PM+5XuuMzLfh5t1MWqBoJh9xVPhFFKVaRRRBB0uTn5dwY1XYVrHPyai2OHAVqy3K15hMVnb4mVz9BzeUDVpJuUFAgeFnqklnJip/3SFDAcooRnnwbvUAI4ff5PSiLNzg1FO9wBJcSHVWcWXuSpW87616eba3op9rPIYwa+TwaVl5MktoxpEFIsospNXH8iKRDZhyELaFutdfgVA5yUKSFn8+1lEMaHU2JBid4u6xnoxmKBPoWXM1OupV7ZZMM1Vs8y18Du56+ae2SzMzslVBoyekW6IE/A4pCO4USca+sYDwbcgBpiPtXpRM+ip3WnIb0EB02t5Vxsvs+41Pi4fzXJl73Mnjsbuk90wpxsf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(53546011)(26005)(9686003)(4326008)(8676002)(52536014)(8936002)(38100700002)(41300700001)(15650500001)(2906002)(7416002)(5660300002)(478600001)(6506007)(7696005)(71200400001)(110136005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(316002)(33656002)(122000001)(86362001)(38070700009)(107886003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2sT1PTSQgSqqRjbEhTothOK1yu68rIJx6DScCCnx1g/py+O9o5UwAzdIODI?=
 =?us-ascii?Q?y+yg+gekGF2KE/s46QTEr7pPWJeHlrEfr96DS7lyAZHALuNKnttalB+7WhgX?=
 =?us-ascii?Q?Ba6DkvZIDIFk0gPI8G8WEL7hiPCryFt3jYk/xLEsI0ddycp+MANFEY3WbYWF?=
 =?us-ascii?Q?Vr384GFaPTg1ISER4+4s57HSQuTLtHEvt38N6Pt++QEZDZFNV8op1S+mtfQY?=
 =?us-ascii?Q?8D8pmqV623piM/UQphI5IQbl0eSdkhpf1v1GiZMrmBBMIPqfKfsAnKFJfJqJ?=
 =?us-ascii?Q?WrA+d7v25A+zQDWmXdWmOX28APv2OeOiQ7brlrsL/CDrqjAylGTdYDPfkzm1?=
 =?us-ascii?Q?z08/WyHX+gSNZg2M/hxKHq3iPnd/wDVHItxFAZ3wcvwhmCpSzm8Acuxch2X5?=
 =?us-ascii?Q?U5hOqrGJqCBWFF4mmyf0WPC+6ZA4SjHvcuP5OKsReOuN5vLINkevV8alKmbH?=
 =?us-ascii?Q?aQfQ3PhWmxokHNfpQZeyzKnRLlZNeUbyG09VhzRXBsQXe61BFG13QPQPblrr?=
 =?us-ascii?Q?/s/M1puDBUxMEzir0CslPHL/S1v5szdXYavrNCJVZKT8wEjFNM8TObiYcsWL?=
 =?us-ascii?Q?Ij47UmIlcRb1GvfZWtUML1u43FTQ5w+ev7B1VY7YgvZdmPxieuQXsanb1/rm?=
 =?us-ascii?Q?kBHCc/Gc8RbaTdL3HPctwpM55D/4NpFaEs/s0WJOlXXoF0OTkq/PTDQvv8fC?=
 =?us-ascii?Q?WFsy3KdeseRX0mdn8Tm2Ls1JnqnGpbOgOo+2z3hKoSO1aSzzk0k6h/htiBUm?=
 =?us-ascii?Q?I9EhwncCjye3eBqUxKl5TZMHzcwWiJ8FvfbvrWbruUw/ijW2OrzpRDjpLmNe?=
 =?us-ascii?Q?TKPbjPSyhHamBANkib/WS7MQdNos3H2GqZUtAwfdxwb5GFA5bm736LfMriKc?=
 =?us-ascii?Q?Hh5DyXUueVbO6NFxCsI6RQA0P7Htsf+ZBH99lAM+VgcLJz2aQD3ugA3/VD9b?=
 =?us-ascii?Q?mLt4tdJCcYZTZHELng8W9/SQpezZ+1DRC8lZOFFr7bLHKnjr9U67ZmkNsmeA?=
 =?us-ascii?Q?pixOYYHAbUbbJszf+4EXwsgMYFYtDVUMoU+kjbqU2AP1UtckXT1j0nxj18X1?=
 =?us-ascii?Q?6W9KJBz1jFJH10jkTndCmoHWs9ENxqtwo+ekdJm+KLFAOi2spo39wuq3hg84?=
 =?us-ascii?Q?P7RfU4Zbo58HGJ6DYa2l2QCcQZMf/M5YEN6MLoAdw0xvfiQd5ehujN/GFje8?=
 =?us-ascii?Q?GxNe4zQLDALBTgYi3h+WSAdG1ySfkU3pFeLUb5GmHQqTUzqjtSnuY+lrW/SX?=
 =?us-ascii?Q?kuTuUlcIorrSph02w3WOfOeWXkInGA6i2LjC2kPvqbI0HzLSMK6n6Q1isChR?=
 =?us-ascii?Q?JifNRM3fBfp/VGL/8bbGM0JrVXLJz4jBKUY5D8nl7Zf4r+4AwijLnmoD0X7P?=
 =?us-ascii?Q?HySkSveIePAX8bHKMVYRV1xhrYozASqogPsBfjPOYz456hyZQDcvDrpVb1bU?=
 =?us-ascii?Q?HrJ9RlbO1+luX9vHFrYD4mPwleVmsX8Gwa8CDTTVMaWLhw+zSkIFvAtvT5NA?=
 =?us-ascii?Q?UmR3cv5tskY84ZNzlYbN9oMPdAy+te2tei/ka5NpeWXem9/WRmL7q77HfGsO?=
 =?us-ascii?Q?B9F3i+XceT9WcQkBI9iHx6w5lTvepEi/DsvrlJ0idjHg0iSE6KPCfIFaA3js?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d37263b-56b5-43ff-e735-08dbea66bffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 07:52:03.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bg+N0fIwUua+Fiq3paCHHwr4ouSX9pRxZ64nM5vjoH1yRU4p+EKv2tkbgCDDEG7RfcNSiHiDT0+9sNgDAt17f0r02nlNETBojrIAM/H2ZwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559

Hi,

Gentle ping!

Thanks,
Shravan

> -----Original Message-----
> From: shravan chippa <shravan.chippa@microchip.com>
> Sent: Tuesday, October 31, 2023 10:58 AM
> To: green.wan@sifive.com; vkoul@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; palmer@dabbelt.com;
> paul.walmsley@sifive.com; conor+dt@kernel.org
> Cc: dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Nagasuresh Relli=
 -
> I67208 <Nagasuresh.Relli@microchip.com>; Praveen Kumar - I30718
> <Praveen.Kumar@microchip.com>; shravan Chippa - I35088
> <Shravan.Chippa@microchip.com>
> Subject: [PATCH v4 0/4] dma: sf-pdma: various sf-pdma updates for the mpf=
s
> platform
>=20
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Changes from V3 -> V4:
>=20
> Removed unnecessary parentheses and extra space Added review tags
>=20
> Changes from V2 -> V3:
>=20
> Removed whitespace
> Change naming convention of the macros (modified code as per new macros)
> updated with new API device_get_match_data() modified dt-bindings as per
> the commmets from v2 modified compatible name string for mpfs platform
>=20
> Changes from V1 -> V2:
>=20
> Removed internal review tags
> Commit massages modified.
> Added devicetree patch with new compatible name for mpfs platform Added
> of_dma_controller_free() clenup call in sf_pdma_remove() function
>=20
> V1:
>=20
> This series does the following
> 1. Adds a PolarFire SoC specific compatible and code to support for out-o=
f-
> order dma transfers
>=20
> 2. Adds generic device tree bindings support by using
> of_dma_controller_register()
>=20
> Shravan Chippa (4):
>   dmaengine: sf-pdma: Support of_dma_controller_register()
>   dt-bindings: dma: sf-pdma: add new compatible name
>   dmaengine: sf-pdma: add mpfs-pdma compatible name
>   riscv: dts: microchip: add specific compatible for mpfs' pdma
>=20
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  |  1 +
>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |  2 +-
>  drivers/dma/sf-pdma/sf-pdma.c                 | 71 ++++++++++++++++++-
>  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-
>  4 files changed, 77 insertions(+), 5 deletions(-)
>=20
> --
> 2.34.1


