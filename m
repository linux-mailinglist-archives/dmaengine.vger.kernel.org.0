Return-Path: <dmaengine+bounces-7060-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B7C3592C
	for <lists+dmaengine@lfdr.de>; Wed, 05 Nov 2025 13:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4413A35FA
	for <lists+dmaengine@lfdr.de>; Wed,  5 Nov 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BA3009DD;
	Wed,  5 Nov 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Cbk5xk9u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF7261B65;
	Wed,  5 Nov 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344771; cv=fail; b=tYs5u0X1/QHOs97N7qNPzFFhMCRjeKz2RNZFebA978cherXU65b/9axD4llkuQdNbFhZ3MkuJ4cyULDpvLTQ0F5j35Z23Ff7F4JnKPcx8pUM9u9fQcvQ1/4OstJEChFWfN8mxNj/DUHFTLiwaPg6gHX3L+U8Q5pR8YJENHgiIZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344771; c=relaxed/simple;
	bh=CrOSmugM0CN8SBZt9ZBfEmHzPnLBX9JMTZePFYlsJUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7KELlSGfPAF/27oIgcQ3NUdg47W9fkUDgNw0hE03rSsQopqNYMVpArSzhbzFVJEGj7UVnrKm/O4nk68cqIuTBq4hPMjcsLoQAgOS7BCSGNbRT70oWMwYaqOCPUvzwMaAJOslPFXQo/kEk6nUV6C1TQZLMIwhsKgEx0jB5YCXo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Cbk5xk9u; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57wwtn3419132;
	Wed, 5 Nov 2025 07:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CrOSm
	ugM0CN8SBZt9ZBfEmHzPnLBX9JMTZePFYlsJUY=; b=Cbk5xk9uGSdKKHrxTfZXm
	5j0jHbos+duSTWelrvy1GPxkpe79lKmPNk3eTQouMAMgF9yfr3e4vc9/Wd5J4leE
	WMC1uURpm4mjQ+za0T0twkW/oTZ2DMIdD3a1/cTLprrjYHvepVODEIU0/vbDN7G0
	vodL85hpq9LbqdlQICe4q0cUNe+aEtSSn8su9TI61DBH5atZsBeNWsPHmZQ9ktTG
	5P5+ai2hJUpaSgua0fI0VQi2hxOgODoQWwbIwNp6tN8lDDYFLfgCtxc1m22InX8q
	rozdemxzqlV6s9K6QHBr+qanTI5RL9aJ5VX4E8D1EUA/HcQpp3N7tkcPCpqu2xSk
	A==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4a82p0101r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 07:12:18 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTys/c2yO49qRiNcbrb32hSjEmzlakJL2g6nWUX70TVW+PzFe3q13C0DShd/rm9qpel29C8WuvvfiIP3jhAszwkxpWXH9nkqKgImYpnNdCXchdyUfUTXKL0xwNppL12qLt4Pk4rnhv60yvVYvl3w3wyUxh5kiB5ODxaK7rH+O/jXdy5SIgbGSkQELJbyr8OqdADnP+TvBRGGZHzUvEVc4LEK3fa/zyhoJR8VQ6QolEdRnRvpsE2W7gazHH2Vfrwgj6BPyUjOr800ylJpIztv660hiA0ERbxNY/GbwjSA7EYWFWEXil7PPB1zao03qFZzXAxwI18LzMEWttcaitLMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrOSmugM0CN8SBZt9ZBfEmHzPnLBX9JMTZePFYlsJUY=;
 b=NuRVCyhBR6NLzyEGIAnEjniL/uZJQxFQQAIDU2W05J3R2GVeM2o6BKkZ7UNWxf81ZksRbunu07H9Bxu4u5sYwd677i+f1Vbi70aWmNxP1e1Z0wLJZZduoro0ef40TjYZ+Q8nzQK9bNLK7HNaiwKVrwKX3F0yppApwhd6vn53577zA4tfLGq83Y5ZJpTEIKpaqy0ugjDrm+U3Q3Y/bEbd9382h4Ihu+VSAAtiYN3AHCEzI/MpQCWjLluUhXSj+JySIywYFWPbdVjKZJAWq6SkARZj7d8tYEoczV8GbMKb6sTCfN/IF8k6NfH/y2UMc0SuyFi6J6q3QBR22FgO4QcWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS7PR03MB8218.namprd03.prod.outlook.com (2603:10b6:8:26b::16)
 by SA1PR03MB8118.namprd03.prod.outlook.com (2603:10b6:806:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 12:12:16 +0000
Received: from DS7PR03MB8218.namprd03.prod.outlook.com
 ([fe80::ec9b:9c48:faa6:ed6c]) by DS7PR03MB8218.namprd03.prod.outlook.com
 ([fe80::ec9b:9c48:faa6:ed6c%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 12:12:16 +0000
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Paul
 Cercueil <paul@crapouillou.net>, "Sa, Nuno" <Nuno.Sa@analog.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Thread-Topic: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Thread-Index: AQHcTacjvEIKpWKeEECduwwKOchlBLTj/0Tu
Date: Wed, 5 Nov 2025 12:12:16 +0000
Message-ID:
 <DS7PR03MB8218519BB264489282CC157F8EC5A@DS7PR03MB8218.namprd03.prod.outlook.com>
References: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
In-Reply-To:
 <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR03MB8218:EE_|SA1PR03MB8118:EE_
x-ms-office365-filtering-correlation-id: 3f059846-c70b-41cb-998c-08de1c648fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?H+/2vfqCuxyWvffcSgYNfr2/maLNcs754ceDvue5x4rY8IVsedUg0plM/L?=
 =?iso-8859-1?Q?KnRlx1pGdqadButbIg3NDLOXhZG57xq9r7uhsQ/ghOQ+w0v0agQsiCbtUX?=
 =?iso-8859-1?Q?WHs1e3lTxOq/X3AIadbyuWXAQJsBW6zAQ2yJFOfcNEa8tI82e4QjCCuAQW?=
 =?iso-8859-1?Q?v85qOdogg6I3rzRMifeYdk382GvgWpkQp2hhRbdqAtAayZPYcAr7LVqgj8?=
 =?iso-8859-1?Q?S6NZGRjtqnUQLYeptUxj4/ZxgJXxecPjitRt354XsaKY0YXPOKkRJMhzbG?=
 =?iso-8859-1?Q?1lCT4Bchyr8LGkO1mUvUw20mRBAvMbsmxSacEmCLw76X0c0+lV5UwB0wps?=
 =?iso-8859-1?Q?Ml/IqGuGUXEdDNJjl3jxkihse8iuPQPsJQfBxUFM6GlH9XM7uGsaG3uAPA?=
 =?iso-8859-1?Q?at5Pdk3yf6G5ecDZ7KhwPANdHjMSCOcU0PU0x2/Rt1Oo5TaBywpC7gPbJR?=
 =?iso-8859-1?Q?Y5bB8u13v5EUW6hmgRxc+jljhSih5mt0nQR/JvA5vVdsxcJ9n8k3y2KdMI?=
 =?iso-8859-1?Q?FE5tNWf73tRz+bEOoR+ak+HoJu7tAzspNb+CLVewcuW5h+C+63f3si2vNC?=
 =?iso-8859-1?Q?Qee13kn81UnTEsYJF/1z9i1y8vw1aXiTQfXAMreeGwbub00BP4Yn+afFFE?=
 =?iso-8859-1?Q?hfbfuTadvmRsbHMMSb905mBGZJYSd9cWoRVSUNIYju45lbeeMhZCUoQlGB?=
 =?iso-8859-1?Q?8zNmx6s4U5FIUfEVHIDYVzVvNzW6LUaeOObCoeqca2keYoFmBtag/Z4Cr2?=
 =?iso-8859-1?Q?sJPgulvRzxQ/Irf0/5WPucHTeTjGk1F0aN8eTTpA7Jt22kEhaEf7B4SlJY?=
 =?iso-8859-1?Q?VCKthnoA3R/3mgK+hyn6pJ1gENH/Sp+Th1nwGvoPhA3Hi7Kt/PexEsjbGu?=
 =?iso-8859-1?Q?jGG//bhaU9rTTtmec+hOlYNE81FT3hhumlpytBSHLs8W6e5AGXh7q4Nf/C?=
 =?iso-8859-1?Q?H0YFhmu4BX9ZtF6+IZgGnVV1kriewQfAh0y4QGF+7skOswXNkfMimYUQ/1?=
 =?iso-8859-1?Q?6sDiwmV9upA26bDOOudvLsts2b8OPBcQz2JqqdMjIRne8VNN0B1HHlHuf1?=
 =?iso-8859-1?Q?YPdMZ+l08sAb0/YXaCXvtL2wsyLxowHmTuvFkKVUrNiCXsR/Kg/px0hFPp?=
 =?iso-8859-1?Q?7jIR+rvgtaX8QYXjU46ef1+utBY1C0azSbhjMGy6Qd6J7mH2bK4dCNwcH3?=
 =?iso-8859-1?Q?MKgPx5WE7wyvIi8d39ZSQ62j8fxvqzzfNJq1rvU6Pp7z0ONY8buXdIU2Lt?=
 =?iso-8859-1?Q?Lbjmiy/Sox1X+DoISWa7rOmWXYDFgwEeILHwmcf0eU0T2qkkk0/LxN1/Wo?=
 =?iso-8859-1?Q?Rqa92VNCtRn1tlf8CKyqOFGTJ/GJ5ultd97ovC6h+oCYVRIGzFxMnDqb/+?=
 =?iso-8859-1?Q?owe/6P6TwpLR3HexC+mjzoojKRKRz7kybiN4qwSjpGQkJ4NpHu0iGD3NPv?=
 =?iso-8859-1?Q?8BA4rlX66YHQn06cPLriN3yG1FeyRb4yWaFddvtxHdHohjdIc96oCszX+2?=
 =?iso-8859-1?Q?K9Saj4JgPUX+Ia2jzoQwH983x+hmk/gNWJsdQrJZfVk4bfVhPxqd9hftwv?=
 =?iso-8859-1?Q?U0dkN+oh4X7lkBdGoFCbUbyKTf4K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB8218.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aE/NmUtb973g3v7yi6HwA4/Tcv7IAPuzqUiWtKqAnRSd95m+tv6aZ4PfBf?=
 =?iso-8859-1?Q?oVuUtUxPlmuqTEFogaWRscnPVw80UxGGGAxk7cCfPNbPctRuZF/ufLqn1V?=
 =?iso-8859-1?Q?AMSmVHR+8zfgyW56y3wBGfPGSmUzBCjdUqasUwcHXgvOME8D2vCMexzAt0?=
 =?iso-8859-1?Q?7fh/hRel4EOQZ0XEH9hEE8tWATieJfU7sqEVcohHlqHMZlXCbt88nQtUH2?=
 =?iso-8859-1?Q?xsRms5p6m+wCBlRmAKuWbH7qr9+8ulppUNclO/hx3Wd1dVfyERceIjMCb2?=
 =?iso-8859-1?Q?nwIBVHj8O2n2DsqmjZ31HxPt6OSUMDqyzgMYoap/v2gsrL2O7IStVhk9IL?=
 =?iso-8859-1?Q?n7wE4O6FvNaye9KTWpAu6WFKONa4Ye4aTHHpJ27Bl+JnoWtKxlxRAPWn1Q?=
 =?iso-8859-1?Q?hoJTqgOg5FDsab+ny5JUN2QBfmGWAt1PKdZHiGBbKJ3a1RzdibYTeSlbvX?=
 =?iso-8859-1?Q?URyZhm78KLZ8IYJWnr02psNBgDU7aBXETwd7Gno+KU+tzbLDHTI+cUcyai?=
 =?iso-8859-1?Q?yTK4V8cB0XTtVZxDSq3XiAMGz/BnMq9JX6+clnE5EfqkzJWUjmA6RGa8u/?=
 =?iso-8859-1?Q?c8Imobauhlko0G/dJ+vj8zh6AaZhm8bqqh/pAFujNMaB3Sq86UCizErCgu?=
 =?iso-8859-1?Q?QP8n/erw15Gptlz5ifWVWGWn2nWu46FIS8n+TavjBwkx9BQT/hsRRGHK4+?=
 =?iso-8859-1?Q?iKUWhpi4l/05a0ZHq35SHq/YNAoS6f9jSTOJ18CRidvP+iqpmzFaqGtdSi?=
 =?iso-8859-1?Q?vUQiSwrDnQCVJbL+MauEZYUynvT0jSgH/Y3bB0RLejO0FFDdfjwh16nHKs?=
 =?iso-8859-1?Q?gNopR4U/GIkXK1AO5tye9prun4TggjaHHYwl2j7xw3o+kNn2X3yT43jos0?=
 =?iso-8859-1?Q?jfNcgPPpsgJhnx9Jaug3WayuX/1oryViXHqTvJ1LiF3+9D7JVDSi1rvnSj?=
 =?iso-8859-1?Q?eTb4DHfeFmxzJRgZ2CZ9rLAXGQyImpSSqW551JSgeHAwvKi9v6A5rJNNDa?=
 =?iso-8859-1?Q?dGJmO/eN5r+wAtm7W8Ml4Ggj/KtWhboba6Ij7im2vUZIXQohFKfMbsyuNM?=
 =?iso-8859-1?Q?uVgW2N7U1xZU88JI55yBmAen61bwL36TmP/TSM3dRovAi9rnqj9yD0w3mb?=
 =?iso-8859-1?Q?neweQpERymcV5pVWAOmmHe2cNg6ZKa3rffvDSJvvuWq3xS7AsLiYPX/Rqs?=
 =?iso-8859-1?Q?ziLi+CTztpYtm4rVecKOILLzhgDcK5ZLxMjvmrrn9Fc64InYf7/inhLvxU?=
 =?iso-8859-1?Q?PXIgaUcqTScoS/KxQo1OYBTXtBgVMbpcDT1s40kw+xGKoXmWhfv8IQxDge?=
 =?iso-8859-1?Q?jx0SnDfi0dAmq/bYhPc2xGIKGcSbIiGvwnrgXfuDHw4NEAt0GTzFVII2QG?=
 =?iso-8859-1?Q?+fPuKAXZfTkE1FV4IfNnzBKdcA8JLDNN3qPuk6V9VsnYZjQWS7JWGjRyBk?=
 =?iso-8859-1?Q?ss/uWy1vfJP9j4NCm6UPLQO1D/MDDrZ/CLhlScZZjqwtULbczzPvhPqSc8?=
 =?iso-8859-1?Q?CePUny0wCERh1zKDSI33xHxZ8EPwWXtCK6sTevPdSa7hI/GdeSzm0XbJWW?=
 =?iso-8859-1?Q?7gA1Bmm+y6a9GZ1Bpq+MSh3tZ228Y2Y5sV9EMtPVmbbVyeYeYSnOliflVu?=
 =?iso-8859-1?Q?yu00xw+HMUuDAwBj3vKqDCFccqZuPUnAyX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB8218.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f059846-c70b-41cb-998c-08de1c648fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 12:12:16.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhXJyaN8GXquxBH/yX3NykUv2pvvJv+TVqvpkZSoRE3cT2AI/taUuTt4psspj79wos4y+ofRsJqc5JGp7mzb9u03D57NtfRq3vtvaEOT0TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA5MSBTYWx0ZWRfX/opctTqaufcl
 TNBsQxN5J4f0EiGdhbHjOvvcUko1mivj8O5AHSsTZWxJ2wl/YuviJ+ymQ8AhfYyukM995DECbpM
 DgjPF4ytE+yMdbrdAZIaGJJbfnuexsWrMgY/2EKP0eO6hGf2KN3d18UwKTes7prMSj8iJkURGlM
 gck5t4pPytwcMvYv/WAWNtEvgdBLGKzCVGULrMfMy9p5Vc1/IVLheDIN+T/vTZYDowmVpoGMl3n
 vPP165pOVKqvCxJMhV/0Jf5xdqrBzffh7/HHnD9MWsQltWRLfIOSQyFE5L3JWIAX99Yzgrf71qF
 cnOErO1/hdP/wnaVfIcbUmdrKxH1lo568sOtaNJbvYtc6AGy0tU4E4fokPI54O6OJtdcjikvq4s
 WhBgTYEhb+O+9AvdaY+82IVLul6i/g==
X-Proofpoint-ORIG-GUID: 0B5nQkMGy36KxO5moqBe-VU3M5l-frw6
X-Proofpoint-GUID: 0B5nQkMGy36KxO5moqBe-VU3M5l-frw6
X-Authority-Analysis: v=2.4 cv=GIwF0+NK c=1 sm=1 tr=0 ts=690b3f22 cx=c_pps
 a=r8gZD2gelFFA3OdVKTiE/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=ER_8r6IbAAAA:8
 a=gAnH3GRIAAAA:8 a=7x4XnuIr-6CP_Uy5PbAA:9 a=wPNLvfGTeEIA:10
 a=9LHmKk7ezEChjTCyhBa9:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050091

________________________________________=0A=
From:=A0Nuno S=E1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>=0A=
Sent:=A0Tuesday, November 04, 2025 17:22=0A=
To:=A0Vinod Koul <vkoul@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; =
Paul Cercueil <paul@crapouillou.net>=0A=
Cc:=A0Hennerich, Michael <Michael.Hennerich@analog.com>; dmaengine@vger.ker=
nel.org <dmaengine@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-ke=
rnel@vger.kernel.org>=0A=
Subject:=A0[PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
This series adds some fixes to the DMA core with respect with cyclic=0A=
=0A=
transfer and HW scatter gather.=0A=
=0A=
=0A=
=0A=
It also adds some improvements. Most notably for allowing bigger that=0A=
=0A=
32bits DMA masks so we do not have to rely on bounce buffers from=0A=
=0A=
swiotlb.=0A=
=0A=
=0A=
=0A=
---=0A=
=0A=
Nuno S=E1 (4):=0A=
=0A=
=A0=A0=A0=A0=A0 dma: dma-axi-dmac: fix SW cyclic transfers=0A=
=0A=
=A0=A0=A0=A0=A0 dma: dma-axi-dmac: fix HW scatter-gather not looking at the=
 queue=0A=
=0A=
=A0=A0=A0=A0=A0 dma: dma-axi-dmac: support bigger than 32bits addresses=0A=
=0A=
=A0=A0=A0=A0=A0 dma: dma-axi-dmac: simplify axi_dmac_parse_dt()=0A=
=0A=
=0A=
=0A=
=A0drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++---------=
------=0A=
=0A=
=A01 file changed, 33 insertions(+), 15 deletions(-)=0A=
=0A=
---=0A=
=0A=
base-commit: 398035178503bf662281bbffb4bebce1460a4bc5=0A=
=0A=
change-id: 20251104-axi-dmac-fixes-and-improvs-e3ad512a329c=0A=
=0A=
--=0A=
=0A=
Acked-by: Michael Hennerich <michael.hennerich@analog.com>=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

