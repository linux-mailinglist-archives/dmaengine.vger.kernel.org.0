Return-Path: <dmaengine+bounces-4656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F48A551DB
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFF91884F73
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFC254AE0;
	Thu,  6 Mar 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jOXpOEUl"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010044.outbound.protection.outlook.com [52.101.229.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7F13635B;
	Thu,  6 Mar 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279970; cv=fail; b=pKzx7yUyl9VghwZR5ouDmtfok46Vw4faK8tlbIX3D75VjKC8XAtmprQBez+EfEkzCcg5UWAwycPwnJfu2KS1ZIXZ6otMLsCfmokP4mdBobQ6MC7yWJUp2/7FzOuTpqyYiDhIcDLBFY28x0f51WcstaSQrPUJ6vTZbSs8jfaYZNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279970; c=relaxed/simple;
	bh=r1wrLB8kUieQ5pw9qx9kmIhMJ3J8Q6U3yqbtbwVf/Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFrtoj3T/jdDP6xzDPsIsAzeOAhchcNp6PvXZdkuyvajgo822sEuQlA92xY3RbalusM0rBRq4YuEyGwxnppSDrWt2wO6Hiqje1npuLdXHOKeuS07XeSwt1ShDmvdmFjJV1Hj2mYDpwDvsCsO5VOCk21B6HoxVLN8zpTCX54viQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jOXpOEUl; arc=fail smtp.client-ip=52.101.229.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw+Ep7N9gh/XONJd5Y614l9aLDdUhZss6TOnQobOb1WSV2bIHTqt1welGj178I9GQGvqyqHLQYr/8UxthlJXSENk8g2kF3TLMymV0YJY7PR6/kKnuKWo4STJdlt6I8+T9uQIBzL/elLzWPeVC0aEZNIHBXvkJuRdYhHE6swAw2oXjlgcN6SWk6NiSYrSRQnP8B4w3fSpHglhPjT0kCwTqbDBX26dW9+vsPsJ6GUpFZ1KRzaQAB2pTbO/dESGFpb02jFA/OWIB/Swfdd4lDKY6tp2eAPdwSHmmaZtnnAs+eP6D6RklOQitTt/dowAIWcvG0oUOTmyXPeyYxb2Vh1h8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1wrLB8kUieQ5pw9qx9kmIhMJ3J8Q6U3yqbtbwVf/Ac=;
 b=d4GJXXHec36n0w5SKaloX1+7ULdDNDYXd5Tv+1B9stgM8ZynLz4K7ziUtwmpVPWes9uDxDpS/TaiYBOa0o+9yUPDnQDaGrzOmwjzqN4iNyXl9U5eRrcjo5VBsfZI9oLdgwp1vqeMgWlrji3VRNvt/vZKX6BJ0Cm70YEEKPTsIQUk6HrsuLOGelWcErO/53HIbszJtdocfETUK1FfkTeuRrtzRZZ9527TgwWnJ5w5C5QGE+nH5xf7uQpc8cUfgItIvfPZXQyRUm+CaAOutGFLhv3NhiaxoleY7+6dq9Og38CBsTeNRGsO80IgsZRO+7IIsIIPOWH+3XzAFwKfOI0RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1wrLB8kUieQ5pw9qx9kmIhMJ3J8Q6U3yqbtbwVf/Ac=;
 b=jOXpOEUlmZcXBAWyJPsyutH46PGw0XmpuLBJ/p9VCTOFs7LjgngRJgx8CdWGptrJKNbN4v9t7POYQL37MUGOR0CQFdLzT7eyYHU2i3NPdwoxB+1/PA99vCSxR8YLueSluK6oMlvv77WjFqEvx/3Ox6uEkOCUshI2aDG+oinCjRs=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY3PR01MB9875.jpnprd01.prod.outlook.com (2603:1096:400:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 16:52:44 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:52:44 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v5 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v5 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index: AQHbjWSPUX1HH0xRgUuEfUBuZoXkH7NmHB8AgAABvQCAADbOsA==
Date: Thu, 6 Mar 2025 16:52:43 +0000
Message-ID:
 <TYCPR01MB12093C546455E58419FF1B763C2CA2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
 <20250305002112.5289-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVeLiQKHm5BQXhqEjKTP4p7Y20b5ocsjvNCnicDQym19A@mail.gmail.com>
 <TYCPR01MB12093F6DB584A044473146B9AC2CA2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB12093F6DB584A044473146B9AC2CA2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY3PR01MB9875:EE_
x-ms-office365-filtering-correlation-id: 5e540e07-b9fc-43a3-09a7-08dd5ccf50cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFE4NWx1N1hSRHhOTzA4RWNFdUNYNEtxZ0hoVFd3RENheVVVUkxXRXA1c09U?=
 =?utf-8?B?bURSUFQvd0w1ZkVNVDFkUzZLYnlpOWp2OEYrUnRLTGdDL2I4YmZLR09weTI3?=
 =?utf-8?B?S0NLTlgwN3BTcUljYmZMeHR3Vy96ZGZRZTU0OFQwaXdWL1hiR041OXI4Yk9I?=
 =?utf-8?B?Rjk3WTg3RUExbWlNSHFDUVdYeHEzYmpGeSt6UlY5bkUrRW05RytLbUV4YkhS?=
 =?utf-8?B?ZkExQTlwMlJ5LzdiR0NoTmtuQkRtY1pNMHlyZFdIYWJ5c2IyMWM2UGlDK2Ju?=
 =?utf-8?B?ZVdTdk15ZU51ZXBjQXpvSjB2dmVFcnBHK0Zjb2tEbWdiK3IxaVFSZTkzSklK?=
 =?utf-8?B?OGJzQ1VYU2dGOFdhdmN6eWhOWDJtV250dE9QTGVwS0g4VmppbkJ1Tms1a1Q3?=
 =?utf-8?B?ZnFoN1JmMHlvK1A5dGczU3UyNEpyWW1oZDF1SEova1hDcGFscXdLRUVLUkxU?=
 =?utf-8?B?MTNLVGJTWSsvN1lMTlhMNC81dW5WeTkvS2NLeG8yRHhHQUxvcTRWc1JnTHlw?=
 =?utf-8?B?ZDBOa2JGUmErUlJwMXd2RjY3aDc3SkhUUk90QUVOVHVBOTFmYVlONXpsNjhH?=
 =?utf-8?B?OFdwYko5eVVRQUtwS3VVNHRvOVpIcXdub1FWaXo1dDRVMnpzbWcyUUJoNzJ3?=
 =?utf-8?B?bHgydmw3aUVFSFVJK0hzaHZpdCtMKzlqNXdieGZEa1Z5UnM0NnRISEdyU1dh?=
 =?utf-8?B?aFdseHBOQ2cwL1d3aVBScWJNenAvcTNNajY0QkQ3b1QrODh0dGw1OUdGYTdU?=
 =?utf-8?B?czY5SERPcjNjU3JrYTZGWXorWFFHcEs0Z1dRR0sybXFHL1lOTFZMMEF4ZFpX?=
 =?utf-8?B?aWUzYit6OWhtbEJ1bmViNzlaMEdJcWY1TXpLNkx3ZDlBMHF5MEl5c1YyNWRR?=
 =?utf-8?B?Y1A2ZzVZM2Y1UWhNMCtud0hFZlloRDJwUkN0UVlMa0FpYkJLb2dQTFhmeEJP?=
 =?utf-8?B?VmZjVXhkOS9EeUVMOU9Bc3JZZjFpb0JGdkZvZ0Fmd3NxWG5UbWZPdDRCZ1pr?=
 =?utf-8?B?dlBnUEg2T3N3b1ZwU3pXV1VmOEdZVVVMM1RhSjRGZ1h2amtrTGdiMDlqZVN4?=
 =?utf-8?B?R1lTMlkxc2dpYk11ZjliaWlKTDRONVJpM0Y5cUo3b1N6Mmd4S1FpKzVGR3FQ?=
 =?utf-8?B?NFJYVTRhYnhya0M3QnJUZUdvNWM1MHhmMHcrQlJYVnArNUlSNytxRlhBcW1R?=
 =?utf-8?B?cktEak4zRzlqOWJSVXJNWkFwREYrTERJeVlyTmUrVitadTdWR1oyV0daMnl1?=
 =?utf-8?B?Smh4VFN1UHB5M0FFc082Rm5mRmdRZDU0MmFxbGFQT1BEcGJSbjE5ZFdmTmRu?=
 =?utf-8?B?VzYyT0d5QmE3VGdUdDhMNFFVTkZZMzlpY3pRQjQvQ25pMnMvUytnWFhGSVBp?=
 =?utf-8?B?N3ZVaXlxYTZqM0g3ajBadi9VWG1STEt6TzdnTDNtd25LazlMb1Y4Z1VRL01z?=
 =?utf-8?B?WUcrb3cwalQ0M0JnQjc1VG1QMUVRNHVseFB6aUpZQ2xZSFF1cStud1pXTlJa?=
 =?utf-8?B?b2lLTS9DSmFmbXpKdXluT1Q0TW1NaTh3NXJzRjZ3RWFWQ3lkNmpwdzAxeVdV?=
 =?utf-8?B?MnJINXJVOEcrb0JNVVRJbnVvYUJscU90SVRidk4xNFcrbUdRU0Z1Z3Q0REJO?=
 =?utf-8?B?UGNCT2hFYitKeFlXSC9jSXpRWlUzU1NoTzBjem8vSzVLc3hFZHQxL2tRS1ls?=
 =?utf-8?B?RWhvWERsdzJUUFY5SWpvS0xmVWVJd0p6SnZNcFdEWmc1UU1EbzNRV0xqU095?=
 =?utf-8?B?ZTdoVkU0TmRsYXQyYUUrd3RFSCtvZDhsOG5ld21uQjFnQU9UaHFmdWtyQ2Nz?=
 =?utf-8?B?aEpvUGhhVDVRbDRpdE1nVEFuNFV5RWpWN1hGem0wb2h2bnRteXVqaGpIZ0NY?=
 =?utf-8?B?OTc0ak5UVytjR1lrY0xCVVp6bDRoa3lsQm9uVDIybWFHUU85ZFkycEgrelRm?=
 =?utf-8?Q?o+Ue+JgI8xECaPHWjKvchpvHM66oh+FD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk9DQjk5Ujd6VnI1UHhPNVZta0RaOERrcVNkcVIyVVRpcDFDNzBsaXl5NzBz?=
 =?utf-8?B?eEk4QnQ0OVdTRXZFZHVqM3c5bWE0dW5PRURzOUVWWGlEcDU0QkVpekZRTDdU?=
 =?utf-8?B?SENlWEQ0Y0t2RTI2aEJPb3hONHlqb3hmbGJ1RDBWY3lhUFRsS1JBR1hldU81?=
 =?utf-8?B?QnJBTmpJSDJ6N3htazU2NmJudklzaGNVc2swS2VrNmpzOWpoRk40N0hNa3B4?=
 =?utf-8?B?cWszbVcrQ2xtMVh2OGxtQ281K1JyNTIzTmtxS2o5WEtvMkxPZFFwNVI1dkpK?=
 =?utf-8?B?VitMRUIrdWpldFIxTEJLaWcya05aV2FjZWRaRXhRSGlQSWhIaTFWbS9Od2kr?=
 =?utf-8?B?cmRzT1FjcDY1QW55S0RFNVRaeGF3em1FUWkzS2d2QTNVTSthNW5VenpMOWZq?=
 =?utf-8?B?bXgwZzFGR2hGRlJiUmVaeC9wNkFTR2UzRnFKeXVLbG9ZczJLQkh1em9wcVhm?=
 =?utf-8?B?YlA0blgwYXVGUmI1V1l0dFBXZ0hFNDR3Y3djcHRucGFYbmt2ZkthZXZiVUl0?=
 =?utf-8?B?emNyWkYrTXJNUHY0Nnk3K3hzRUZmTG9pRjJ1Q0RCS3ZqRUE1YnduNHN3T0lV?=
 =?utf-8?B?TTk2V0thdzRFRnRFd2dOMnVDMnJaNzBGeGsrYUNCakcyR2tmWG9adXZFdklT?=
 =?utf-8?B?K2FwODRBMGVNb0pYRytKdWdWaks1eHlVdS9SS1lLNDcvUWF1a0ZXUm1XSjlI?=
 =?utf-8?B?NHkreGVMbGtkQ3ZwWGdWbERkOHpPZWhNNG4yRWdYa3hnbzRDNm5OMmVvMFlS?=
 =?utf-8?B?Ukh4NU13OWZ4cVFTOXp1TlVOcERKYVZaTGswWnlIOXU1V0FYUVhFb0RJbFEz?=
 =?utf-8?B?bWVuOVFkdm1pZFpFTlZKSkZVSHU5cDZCaFFJTzRMb0JSQXcrSE4rbHB0Yklx?=
 =?utf-8?B?TnY4d3NiVUNYamRYdGJNT0l4UmxhK0hlMEROblIrY3MzZTVOaFFKdWg1YVhy?=
 =?utf-8?B?Y1lTait4c3JGSWhIbHhOQldMVW9BLzBKOUJ6QUJyU1JkNFJsTnNmUXlFditF?=
 =?utf-8?B?dzNIYUNTL0NYNG5yM3pLUVAyN1JqNEEwVG5QdVhpeVplYW5kZFZOdjZRWVk3?=
 =?utf-8?B?b1J1OFliaVo3a3pRRnlUK2NVR2l3VCswd0VZUERPU2dvbzVEdGJyK2p5UVRE?=
 =?utf-8?B?bWJQM2lscnFsVlBVS3lpaU8zMUJrdStJWmkrQTdka3Zla2pSa0tBNUY0WlJB?=
 =?utf-8?B?SUdIQzlsZ24rMzd6SFo4aDZaVVZxQVM4SHFlU2NyZnBiamVPQm4va0xZc2Rk?=
 =?utf-8?B?cW1sTkd3dFBxaTAxZnVaMWxjOCtITmlUdmpWL0pWV2p6MFduZEZTb1JxdEtV?=
 =?utf-8?B?TFVjSi9GdU11bmg5YTFmS2RFd056SWJaZmN2THFwZVc1WGFac1IxQXdTVVl1?=
 =?utf-8?B?QlpxSm9BMU5zM0FOczlLQndJQ3QzVHdLYmYwazd6REd1ZFNrV1ZFdTZGR2pO?=
 =?utf-8?B?bTRudkQxMm5MRWd4YXBrbC9CTFlUakJWam8xQWUrSkw0clZEeHBhVGlQOER0?=
 =?utf-8?B?NWkwWW1rVllYSlh0UWE3bkt6bUhNRXhkYlZBOEVaYkhKNUcxUDJzelNnb25P?=
 =?utf-8?B?WVpRSm1HajY4SnNaaHhIVnI1YkVmeExhczJ0Tm5uMUNwMjl0S2RnM2phNXdy?=
 =?utf-8?B?aW9kNWtIZWM5c1VVcXlWaVIvczBsMmcrK0xRSjNXK0xKdWtWRFFUK0lBWDh4?=
 =?utf-8?B?NkJORDJ5WWtOYThaeS9EQ1RpZUs4NGFHL05CRy8wc3gvdFpsTDBycGpjNnkr?=
 =?utf-8?B?cG4zSTNuUTB6MGhsWWtJMS9sS25LeFVLM0Z0T1dLb2RLdXhnUmIxMWl2dHB6?=
 =?utf-8?B?bGJOU0dwNGJzNmJuTGVjbnN2RStDVHRzeUdxQ0hzU1lkUUFZRXpNVmIrSmJF?=
 =?utf-8?B?d09PeTdxNG5lMENqSmw4NXk4UkRnbTJiL00xR2xWSk83Z0dKbDBGOEQ2dXRv?=
 =?utf-8?B?QnVFOFRZNmlSYklGNlN4cElTOVVMREJEenlmVkpEcWpvdUhjZDBqWDBYeUYy?=
 =?utf-8?B?U2M0UWFnckdCMlNTMWplaFZEK05tVkVMVHd0UUZMOTRDckFuQ2l0eXozeGpn?=
 =?utf-8?B?am5mQVJmejVOODB3ZUpUVTdGaDh0NmFtRTdJbnpiM0dwOHl1OUo4S2x5Ylky?=
 =?utf-8?B?TWlTd1c5emd0YTFmTFBhZ2NpMmZMMWdjUHFNbGkzdHlTZXRNYXd4MDA4c3Av?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e540e07-b9fc-43a3-09a7-08dd5ccf50cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 16:52:43.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqtZwrTk6zoq4UCbV1oxQ+DxMz936gWcoJEkR2HqZtEDexG3WPaxBg4ypjkIkg1+lM5bGdSrofNEOxXejD+8uFhWLXDTqd3QfCI8cdGdbiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9875

SGkgR2VlcnQsDQoNCj4gRnJvbTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpA
cmVuZXNhcy5jb20+DQo+IFNlbnQ6IDA2IE1hcmNoIDIwMjUgMTM6NDENCj4gU3ViamVjdDogUkU6
IFtQQVRDSCB2NSAyLzZdIGR0LWJpbmRpbmdzOiBkbWE6IHJ6LWRtYWM6IERvY3VtZW50IFJaL1Yy
SChQKSBmYW1pbHkgb2YgU29Dcw0KPiANCj4gSGkgR2VlcnQsDQo+IA0KPiBUaGFua3MgZm9yIHlv
dXIgZmVlZGJhY2shDQo+IA0KPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGlu
dXgtbTY4ay5vcmc+DQo+ID4gU2VudDogMDYgTWFyY2ggMjAyNSAxMzoyNw0KPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjUgMi82XSBkdC1iaW5kaW5nczogZG1hOiByei1kbWFjOiBEb2N1bWVudCBS
Wi9WMkgoUCkgZmFtaWx5IG9mIFNvQ3MNCj4gPg0KPiA+IEhpIEZhYnJpemlvLA0KPiA+DQo+ID4g
T24gV2VkLCA1IE1hciAyMDI1IGF0IDAxOjIxLCBGYWJyaXppbyBDYXN0cm8NCj4gPiA8ZmFicml6
aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IERvY3VtZW50IHRoZSBSZW5l
c2FzIFJaL1YySChQKSBmYW1pbHkgb2YgU29DcyBETUFDIGJsb2NrLg0KPiA+ID4gVGhlIFJlbmVz
YXMgUlovVjJIKFApIERNQUMgaXMgdmVyeSBzaW1pbGFyIHRvIHRoZSBvbmUgZm91bmQgb24gdGhl
DQo+ID4gPiBSZW5lc2FzIFJaL0cyTCBmYW1pbHkgb2YgU29DcywgYnV0IHRoZXJlIGFyZSBzb21l
IGRpZmZlcmVuY2VzOg0KPiA+ID4gKiBJdCBvbmx5IHVzZXMgb25lIHJlZ2lzdGVyIGFyZWENCj4g
PiA+ICogSXQgb25seSB1c2VzIG9uZSBjbG9jaw0KPiA+ID4gKiBJdCBvbmx5IHVzZXMgb25lIHJl
c2V0DQo+ID4gPiAqIEluc3RlYWQgb2YgdXNpbmcgTUlEL0lSRCBpdCB1c2VzIFJFUSBObw0KPiA+
ID4gKiBJdCBpcyBjb25uZWN0ZWQgdG8gdGhlIEludGVycnVwdCBDb250cm9sIFVuaXQgKElDVSkN
Cj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNh
c3Ryby5qekByZW5lc2FzLmNvbT4NCj4gPiA+IEFja2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IExhZCBQcmFiaGFrYXIg
PHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gdjQtPnY1Og0KPiA+ID4gKiBSZW1vdmVkIEFDSyBObyBmcm9tIHRoZSBzcGVjaWZpY2F0aW9u
IG9mIHRoZSBkbWEgY2VsbC4NCj4gPiA+ICogSSBoYXZlIGtlcHQgdGhlIHRhZ3MgcmVjZWl2ZWQg
YXMgdGhpcyBpcyBhIG1pbm9yIGNoYW5nZSBhbmQgdGhlDQo+ID4gPiAgIHN0cnVjdHVyZSByZW1h
aW5zIHRoZSBzYW1lIGFzIHY0LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcw0KPiA+ID4g
ICBub3Qgb2theS4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZSENCj4gPg0KPiA+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6LWRt
YWMueWFtbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rt
YS9yZW5lc2FzLHJ6LWRtYWMueWFtbA0KPiA+ID4gQEAgLTYxLDE0ICs2NiwyMSBAQCBwcm9wZXJ0
aWVzOg0KPiA+ID4gICAgJyNkbWEtY2VsbHMnOg0KPiA+ID4gICAgICBjb25zdDogMQ0KPiA+ID4g
ICAgICBkZXNjcmlwdGlvbjoNCj4gPiA+IC0gICAgICBUaGUgY2VsbCBzcGVjaWZpZXMgdGhlIGVu
Y29kZWQgTUlEL1JJRCB2YWx1ZXMgb2YgdGhlIERNQUMgcG9ydA0KPiA+DQo+ID4gUGxlYXNlIGp1
c3QgaW5zZXJ0ICJvciB0aGUgUkVRIE5vIiBhbmQgYmUgZG9uZSB3aXRoIGl0Pw0KPiANCj4gV2ls
bCBkby4NCj4gDQo+ID4NCj4gPiA+IC0gICAgICBjb25uZWN0ZWQgdG8gdGhlIERNQSBjbGllbnQg
YW5kIHRoZSBzbGF2ZSBjaGFubmVsIGNvbmZpZ3VyYXRpb24NCj4gPiA+IC0gICAgICBwYXJhbWV0
ZXJzLg0KPiA+ID4gKyAgICAgIEZvciB0aGUgUlovQTFILCBSWi9GaXZlLCBSWi9HMntMLExDLFVM
fSwgUlovVjJMLCBhbmQgUlovRzNTIFNvQ3MsIHRoZSBjZWxsDQo+ID4gPiArICAgICAgc3BlY2lm
aWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQgdmFsdWVzIG9mIHRoZSBETUFDIHBvcnQgY29ubmVjdGVk
IHRvIHRoZQ0KPiA+ID4gKyAgICAgIERNQSBjbGllbnQgYW5kIHRoZSBzbGF2ZSBjaGFubmVsIGNv
bmZpZ3VyYXRpb24gcGFyYW1ldGVycy4NCj4gPiA+ICAgICAgICBiaXRzWzA6OV0gLSBTcGVjaWZp
ZXMgTUlEL1JJRCB2YWx1ZQ0KPiA+ID4gICAgICAgIGJpdFsxMF0gLSBTcGVjaWZpZXMgRE1BIHJl
cXVlc3QgaGlnaCBlbmFibGUgKEhJRU4pDQo+ID4gPiAgICAgICAgYml0WzExXSAtIFNwZWNpZmll
cyBETUEgcmVxdWVzdCBkZXRlY3Rpb24gdHlwZSAoTFZMKQ0KPiA+ID4gICAgICAgIGJpdHNbMTI6
MTRdIC0gU3BlY2lmaWVzIERNQUFDSyBvdXRwdXQgbW9kZSAoQU0pDQo+ID4gPiAgICAgICAgYml0
WzE1XSAtIFNwZWNpZmllcyBUcmFuc2ZlciBNb2RlIChUTSkNCj4gPiA+ICsgICAgICBGb3IgdGhl
IFJaL1YySChQKSBTb0MgdGhlIGNlbGwgc3BlY2lmaWVzIHRoZSBETUFDIFJFUSBObyBhbmQgdGhl
IHNsYXZlIGNoYW5uZWwNCj4gPiA+ICsgICAgICBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMuDQo+
ID4gPiArICAgICAgYml0c1swOjldIC0gU3BlY2lmaWVzIHRoZSBETUFDIFJFUSBObw0KPiA+ID4g
KyAgICAgIGJpdFsxMF0gLSBTcGVjaWZpZXMgRE1BIHJlcXVlc3QgaGlnaCBlbmFibGUgKEhJRU4p
DQo+ID4gPiArICAgICAgYml0WzExXSAtIFNwZWNpZmllcyBETUEgcmVxdWVzdCBkZXRlY3Rpb24g
dHlwZSAoTFZMKQ0KPiA+ID4gKyAgICAgIGJpdHNbMTI6MTRdIC0gU3BlY2lmaWVzIERNQUFDSyBv
dXRwdXQgbW9kZSAoQU0pDQo+ID4gPiArICAgICAgYml0WzE1XSAtIFNwZWNpZmllcyBUcmFuc2Zl
ciBNb2RlIChUTSkNCj4gPg0KPiA+IC4uLiBzbyB0aGUgY2FzdWFsIHJlYWRlciBkb2Vzbid0IGhh
dmUgdG8gbG9vayBmb3IgdGhlIChub25leGlzdGluZykNCj4gPiBkaWZmZXJlbmNlcyBpbiB0aGUg
b3RoZXIgYml0cy4NCj4gDQo+IEFncmVlZC4NCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiAgICBkbWEt
Y2hhbm5lbHM6DQo+ID4gPiAgICAgIGNvbnN0OiAxNg0KPiA+ID4gQEAgLTgwLDEyICs5MiwyOSBA
QCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgICBpdGVtczoNCj4gPiA+ICAgICAgICAtIGRlc2NyaXB0
aW9uOiBSZXNldCBmb3IgRE1BIEFSRVNFVE4gcmVzZXQgdGVybWluYWwNCj4gPiA+ICAgICAgICAt
IGRlc2NyaXB0aW9uOiBSZXNldCBmb3IgRE1BIFJTVF9BU1lOQyByZXNldCB0ZXJtaW5hbA0KPiA+
ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ID4NCj4gPiA+ICAgIHJlc2V0LW5hbWVzOg0KPiA+ID4g
ICAgICBpdGVtczoNCj4gPiA+ICAgICAgICAtIGNvbnN0OiBhcnN0DQo+ID4gPiAgICAgICAgLSBj
b25zdDogcnN0X2FzeW5jDQo+ID4gPg0KPiA+ID4gKyAgcmVuZXNhcyxpY3U6DQo+ID4gPiArICAg
IGRlc2NyaXB0aW9uOg0KPiA+ID4gKyAgICAgIE9uIHRoZSBSWi9WMkgoUCkgU29DIGNvbmZpZ3Vy
ZXMgdGhlIElDVSB0byB3aGljaCB0aGUgRE1BQyBpcyBjb25uZWN0ZWQgdG8uDQoNCkknbGwgdGFr
ZSBvdXQgdGhpcyBsaW5lLCBhcyB0aGUgcmVtYWluZGVyIG9mIHRoZSBkZXNjcmlwdGlvbiBpcyBz
dWZmaWNpZW50IGVub3VnaCBJIHRoaW5rLA0KYW5kIGl0J2xsIGJlIG1vcmUgZ2VuZXJpYy4NCg0K
PiA+DQo+ID4gQXJlIG90aGVyIFNvQ3Mgd2l0aCBJQ1UgcGxhbm5lZD8NCj4gDQo+IFllcy4NCj4g
QWxzbyB0aGUgRE1BQ3Mgb24gUlovRzNFIGFyZSBjb25uZWN0ZWQgdG8gdGhlIElDVSBpbiBhIHNp
bWlsYXIgZmFzaGlvbi4NCj4gDQo+ID4NCj4gPiA+ICsgICAgICBJdCBtdXN0IGNvbnRhaW4gdGhl
IHBoYW5kbGUgdG8gdGhlIElDVSwgYW5kIHRoZSBpbmRleCBvZiB0aGUgRE1BQyBhcyBzZWVuDQo+
ID4gPiArICAgICAgZnJvbSB0aGUgSUNVIChlLmcuIHBhcmFtZXRlciBrIGZyb20gcmVnaXN0ZXIg
SUNVX0RNa1NFTHkpLg0KPiA+DQo+ID4gVGhpcyBpcyBhbHJlYWR5IGRlc2NyaWJlZCBtb3JlIGZv
cm1hbGx5IGJlbG93DQo+ID4NCj4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+ID4gKyAgICBpdGVtczoNCj4gPiA+ICsgICAg
ICAtIGl0ZW1zOg0KPiA+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRvIHRo
ZSBJQ1Ugbm9kZS4NCj4gPiA+ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjogVGhlIERNQUMgaW5k
ZXguDQo+ID4gPiArICAgICAgICAgICAgICA0IGZvciBETUFDMA0KPiA+ID4gKyAgICAgICAgICAg
ICAgMCBmb3IgRE1BQzENCj4gPiA+ICsgICAgICAgICAgICAgIDEgZm9yIERNQUMyDQo+ID4gPiAr
ICAgICAgICAgICAgICAyIGZvciBETUFDMw0KPiA+ID4gKyAgICAgICAgICAgICAgMyBmb3IgRE1B
QzQNCj4gPg0KPiA+IE90aGVyIFNvQ3MgbWF5IGhhdmUgb3RoZXIgbWFwcGluZ3MuDQo+ID4gU28g
cGVyaGFwcyBsZWF2ZSBvdXQgdGhlIHRyYW5zbGF0aW9uIHRhYmxlLCBidXQgd3JpdGU6DQo+ID4N
Cj4gPiAgICAgVGhlIG51bWJlciBvZiB0aGUgRE1BQyBhcyBzZWVuIGZyb20gdGhlIElDVSwgaS5l
LiBwYXJhbWV0ZXIgayBmcm9tDQo+ID4gcmVnaXN0ZXIgSUNVX0RNa1NFTHkuDQo+ID4gICAgIFRo
aXMgbWF5IGRpZmZlciBmcm9tIHRoZSBhY3R1YWwgRE1BQyBpbnN0YW5jZSBudW1iZXIhDQo+IA0K
PiBHb29kIHNob3V0LCBJIHdpbGwgYWRqdXN0IGFjY29yZGluZ2x5Lg0KPiANCj4gSSdsbCB3YWl0
IGZvciB5b3VyIGZlZWRiYWNrIG9uIHRoZSBJQ1UgZHJpdmVyIHBhdGNoIGFuZCBvbiB0aGUgRE1B
QyBkcml2ZXIgcGF0Y2gNCj4gYmVmb3JlIHNlbmRpbmcgdjYuDQo+IA0KPiBUaGFua3MhDQo+IA0K
PiBDaGVlcnMsDQo+IEZhYg0KPiANCj4gDQo+ID4NCj4gPiA+ICsNCj4gPiA+ICByZXF1aXJlZDoN
Cj4gPiA+ICAgIC0gY29tcGF0aWJsZQ0KPiA+ID4gICAgLSByZWcNCj4gPiA+IEBAIC05OCwxMyAr
MTI3LDI1IEBAIGFsbE9mOg0KPiA+ID4gICAgLSAkcmVmOiBkbWEtY29udHJvbGxlci55YW1sIw0K
PiA+ID4NCj4gPiA+ICAgIC0gaWY6DQo+ID4gPiAtICAgICAgbm90Og0KPiA+ID4gLSAgICAgICAg
cHJvcGVydGllczoNCj4gPiA+IC0gICAgICAgICAgY29tcGF0aWJsZToNCj4gPiA+IC0gICAgICAg
ICAgICBjb250YWluczoNCj4gPiA+IC0gICAgICAgICAgICAgIGVudW06DQo+ID4gPiAtICAgICAg
ICAgICAgICAgIC0gcmVuZXNhcyxyN3M3MjEwMC1kbWFjDQo+ID4gPiArICAgICAgcHJvcGVydGll
czoNCj4gPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gPiArICAgICAgICAgIGNvbnRhaW5z
Og0KPiA+ID4gKyAgICAgICAgICAgIGVudW06DQo+ID4gPiArICAgICAgICAgICAgICAtIHJlbmVz
YXMscjlhMDdnMDQzLWRtYWMNCj4gPiA+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cw
NDQtZG1hYw0KPiA+ID4gKyAgICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA1NC1kbWFjDQo+
ID4gPiArICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDhnMDQ1LWRtYWMNCj4gPiA+ICAgICAg
dGhlbjoNCj4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgICAgcmVnOg0KPiA+
ID4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPiA+ID4gKyAgICAgICAgY2xvY2tzOg0KPiA+ID4g
KyAgICAgICAgICBtaW5JdGVtczogMg0KPiA+ID4gKyAgICAgICAgcmVzZXRzOg0KPiA+ID4gKyAg
ICAgICAgICBtaW5JdGVtczogMg0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgcmVuZXNhcyxpY3U6
IGZhbHNlDQo+ID4gPiArDQo+ID4gPiAgICAgICAgcmVxdWlyZWQ6DQo+ID4gPiAgICAgICAgICAt
IGNsb2Nrcw0KPiA+ID4gICAgICAgICAgLSBjbG9jay1uYW1lcw0KPiA+ID4gQEAgLTExMiwxMyAr
MTUzLDQyIEBAIGFsbE9mOg0KPiA+ID4gICAgICAgICAgLSByZXNldHMNCj4gPiA+ICAgICAgICAg
IC0gcmVzZXQtbmFtZXMNCj4gPiA+DQo+ID4gPiAtICAgIGVsc2U6DQo+ID4gPiArICAtIGlmOg0K
PiA+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+
ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiA+ICsgICAgICAgICAgICBjb25zdDogcmVuZXNh
cyxyN3M3MjEwMC1kbWFjDQo+ID4gPiArICAgIHRoZW46DQo+ID4gPiAgICAgICAgcHJvcGVydGll
czoNCj4gPg0KPiA+ICAgICByZWc6DQo+ID4gICAgICAgICBtaW5JdGVtczogMg0KDQpTb3JyeSBJ
IG1pc3NlZCB0aGlzLiBHb29kIHBvaW50Lg0KDQpJJ2xsIGFkZCBpdC4NCg0KVGhhbmtzIQ0KDQpD
aGVlcnMsDQpGYWINCg0KPiA+DQo+ID4gPiAgICAgICAgICBjbG9ja3M6IGZhbHNlDQo+ID4gPiAg
ICAgICAgICBjbG9jay1uYW1lczogZmFsc2UNCj4gPiA+ICAgICAgICAgIHBvd2VyLWRvbWFpbnM6
IGZhbHNlDQo+ID4gPiAgICAgICAgICByZXNldHM6IGZhbHNlDQo+ID4gPiAgICAgICAgICByZXNl
dC1uYW1lczogZmFsc2UNCj4gPiA+ICsgICAgICAgIHJlbmVzYXMsaWN1OiBmYWxzZQ0KPiA+ID4g
Kw0KPiA+ID4gKyAgLSBpZjoNCj4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAg
ICAgY29tcGF0aWJsZToNCj4gPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gPiArICAgICAg
ICAgICAgY29uc3Q6IHJlbmVzYXMscjlhMDlnMDU3LWRtYWMNCj4gPiA+ICsgICAgdGhlbjoNCj4g
PiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgICAgcmVnOg0KPiA+ID4gKyAgICAg
ICAgICBtYXhJdGVtczogMQ0KPiA+ID4gKyAgICAgICAgY2xvY2tzOg0KPiA+ID4gKyAgICAgICAg
ICBtYXhJdGVtczogMQ0KPiA+ID4gKyAgICAgICAgcmVzZXRzOg0KPiA+ID4gKyAgICAgICAgICBt
YXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgY2xvY2stbmFtZXM6IGZhbHNlDQo+
ID4gPiArICAgICAgICByZXNldC1uYW1lczogZmFsc2UNCj4gPiA+ICsNCj4gPiA+ICsgICAgICBy
ZXF1aXJlZDoNCj4gPiA+ICsgICAgICAgIC0gY2xvY2tzDQo+ID4gPiArICAgICAgICAtIHBvd2Vy
LWRvbWFpbnMNCj4gPiA+ICsgICAgICAgIC0gcmVuZXNhcyxpY3UNCj4gPiA+ICsgICAgICAgIC0g
cmVzZXRzDQo+ID4gPg0KPiA+ID4gIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+DQo+
ID4gR3J7b2V0amUsZWV0aW5nfXMsDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBH
ZWVydA0KPiA+DQo+ID4gLS0NCj4gPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+ID4NCj4gPiBJ
biBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15
c2VsZiBhIGhhY2tlci4gQnV0DQo+ID4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJ
IGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

