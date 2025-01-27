Return-Path: <dmaengine+bounces-4202-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C849A1CFFF
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06143A2B4D
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237C146D40;
	Mon, 27 Jan 2025 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M468V9BN"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27B224D4;
	Mon, 27 Jan 2025 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737950895; cv=fail; b=Q/h7JA7FMpga5QsmjWNYDyk5Wo+KHWsif8k/aquN+nkY8lMbLnKUyojmBg+w3/gC0pdpc6zEkqixGm8M48XXJ9EQE8ucz2r5hpLiNXGEHyXhqLJnSA68N1W9/yhauh8dHtFxfn6r5o4vd1R9IhNM5s6Acvbt1nVxi0eMkoPSgUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737950895; c=relaxed/simple;
	bh=+qnQm+Hl4AlyWszVU2faTc9hdpUqDaiMeLBShheCFbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bKZvGOZdZ0RxHJ3BToTi/Cpy+5fehuaAebAa3xZHr0X0C0dZUklkBPBO+7tKxi/3f8ymPc6qbhxHH0qeDg6T9VNmv0hXlcU3zrzmuEtSZJDJGTQgDzoFjzroXQ1ZaGnrvHOFzoOgk9GHqEXCVV5c85lHJKGOX4PDQG7E0e85/XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M468V9BN; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq7bwNq4z/L45JP3QJpNf/130BF4lkIH/sKv+Q1rOh8gad86uth9Z31Dpg0VKVVLYEFG4M3o2RrOEJ0NN1kvGsAdCszicuwkGnOo3KNsmoKSK33PFd19y/hzIBPVgmlzIpWywt8QzTL75ydI2IOLISJlJLPGSvRYoGFtI1led809IUbVDvAsAgbaCMEbmiJKLSQluz1wT4MJBoBuB5KzZjauPOptL8jbtkZMoyhaxJl7OoiusqJbbLc6SUysTfUR5DW9CG0KsrNP15gyROSVZ6siTT7z+MM8TKOJaQOmnnNcfO2vyXC8oJBbeJTArgzLnz3cf6JB7DNa5NDDg/B2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qnQm+Hl4AlyWszVU2faTc9hdpUqDaiMeLBShheCFbo=;
 b=gQSLXdoiYIYqlwKP0n9LhuA+Jm+OxVq1BMh4aZ+7ynMt/PBOd8RNopy2l/6oB8wrQ15AOJGEZXUsbt97kKuRXbF6wSroKw8yWJiXaSyoiupABjhmkB2p7Oe9cwH0bJxl1eGhqJt7ub2n4akrGBLobbGmz9BYwEZPY40ZiQoB9tXRM2i+cdT+kwDo1MjQOgDvEYpZEN5n/w89Johg50BUH2+GQBgaQ1Ak8nFPLx5intE+w8ICUvNn9Z2dvFqOXha/rItkiT0KhXYLDdA1Q96AJdnGEcoWOzjdAw4Aafj35wgmPxaLV6Pbai1zr5ywj7UK73LEHXgU4l3DKj0oX4BzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qnQm+Hl4AlyWszVU2faTc9hdpUqDaiMeLBShheCFbo=;
 b=M468V9BN+kAc7E4jthSrOeZoTUR7Dnd2tZRw26MqqakHfF5wHs5CISrsqg7/OMy8RBlP+IctOxJL7Pdoy1Dt+WgwZTum4JbNR5ae4UFTgsls/Hue18JrxSUkBLxxq6/ml5nJcmE/4M+toOTUHHTt6KWHo/f0+dkb1LATdOQqCVh7Z2Y2sTzgtr+ZpJn4jti0fSt/ffZwEj8FashAh3/xiJl82Jw+q0dK9XhWKePHWBNIEuvZQIPvK6diCMeISbA27BOOT4P0BKzxO2NU913LqKsequ9SqirmFwiEWroSm7kxWTD3sB1qLnZdDIY3pYgaSTS7J20shs7nTWA8gILD6A==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 04:08:09 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 04:08:09 +0000
From: <Charan.Pedumuru@microchip.com>
To: <tudor.ambarus@linaro.org>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Ludovic.Desroches@microchip.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<Durai.ManickamKR@microchip.com>
Subject: Re: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
Thread-Topic: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
Thread-Index: AQHbbXkyX8HL74N75UKu5TJuvhxmkLMliHIAgAR+wAA=
Date: Mon, 27 Jan 2025 04:08:09 +0000
Message-ID: <27d031b6-c732-47b2-942e-7877f3833080@microchip.com>
References: <20250123-dma-v1-1-054f1a77e733@microchip.com>
 <6057f88e-e690-44fb-b70f-97347f9decab@linaro.org>
In-Reply-To: <6057f88e-e690-44fb-b70f-97347f9decab@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|SA1PR11MB8327:EE_
x-ms-office365-filtering-correlation-id: 0a5cff5b-a0b5-498d-6278-08dd3e8835df
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWZCQ3pmZDJMZzRwc1FYYzVFS0RyZVdKbzVwRzZmOGpPSjhUbm5HSEhYbXcr?=
 =?utf-8?B?c3ZIU1E4dy9WUzVIelBHVDhSUFA5K2ZEQVh0RTN3RFNud1o1VzA5VjlZbTN1?=
 =?utf-8?B?b0t3ajFwc0lzUkRvN3hvQzIwYmhUUnVJYThmK29EZWhiaEdRZW5UREdNa1E3?=
 =?utf-8?B?YVg0RGVoUmtpY0lLRUtxRW5EaGhudW90Vm9CTmJPbXA0K3ZWb2JvUkxwNWlX?=
 =?utf-8?B?VjhtcHljNm5Mcys0ajgycCtpM25WZDZ2WkNSWVRaZFZkdzl3b0c3YmlZWGwz?=
 =?utf-8?B?Q05lQlFGeHE4WlFXc2w2RnV6ZlNtbzNNTzgzblBoaFk0eG5rSUQzNWpYUFoz?=
 =?utf-8?B?T2pUQjRSQm1QMU53djBGMVZnWTh5c1dPajZPUzlqRlBqeFNObm1yU0pTeTRE?=
 =?utf-8?B?R1N1VmNhajE3STQ5aWFMbmlkc1lJSnQyUGxxZHowOCtYUXpmVVlPSEp6U3k5?=
 =?utf-8?B?cktXVDcvMkFEazRKY3NlRzl6SGcxN2Q4UTg3SE45NjQ0ZlhKUzN1RmN0L0xm?=
 =?utf-8?B?d1pvT1M5Z1pFanYwWHJ5NzFZWUNxaXBGVGNzaVpiNU5TMUdKejg1c0ZXQTlp?=
 =?utf-8?B?VGNDTS9GeUZZR3E3Njh1OG5WOUUrMy85dVhPb0ovTUpaMlQ4TTFibXh5b1VJ?=
 =?utf-8?B?YTcwWjhFZDNXZEFwckZJQTR6S2g5MnZjSHh2TG8xZGkwV3hESndqT1QwM1pm?=
 =?utf-8?B?OW44a0NrckNzT1FKcUt6dVprMitnVG9CcDFWSlA4R2x6bjhiL1ZEQ3ZHb2RV?=
 =?utf-8?B?UG9BRTNPNzdmN1kwZGdwcm5vdGJ2cnA5NzNPQ3ZJaUtSMDZzZTFkc0tsTFFL?=
 =?utf-8?B?OWQrWThjdVpwQmI2Rlp6aW82dTQ3OWw3cjNjeHJneFpRRGtNajRMNFIyRlJQ?=
 =?utf-8?B?aHkxS1NlSW9yTVVhS2QwaVVnRFFvR1ZiUHRSYVJ6QXE1UU5vTzEwdlFVSDV4?=
 =?utf-8?B?d3NkRmxuT3ozS1ZJSDBLb3l3QTVHSWJtK3poOTYvL1RRRmpycFNUMWtJQVhq?=
 =?utf-8?B?NG1KMW9LQUt1QUlySmU2U0piS0JMblhxZnhVYmR0SURmbFJkcDhGMVVSNi9H?=
 =?utf-8?B?NlZTQlVJajdEUW9iNVBTN0dSWi9VS25iSy8zU0R1WFlDWlBndnBqWmJPQzQz?=
 =?utf-8?B?ZHhmTC92STMwZm1ZdE1Jc2JlZ1ltOXpXVnBlV2M0WExZWDlHeXRJczVWMG5T?=
 =?utf-8?B?NnlNRlJia2xUbmNZS2d2MTBzbkxQK1RLdGJBSzJDQ1F2OEVDZ2lsSlJHYitT?=
 =?utf-8?B?bkJIdEJxNktqaFQzRzJGSm94dFI2akdDZmVtbVphS1dJRS93eVoxSm9QWlRZ?=
 =?utf-8?B?SUVlSmJGREJtZlBMZ1luOTE5aW81MHdNeUhhVmhvNkRTandTSlZzUjRnaElJ?=
 =?utf-8?B?dW5NN1JkY3MzOE96SSt4UWxkbzIvVkIwNjlLNlpQQUlYeDZiNTdpTFBqOXZU?=
 =?utf-8?B?NHQ3ZVBnazVFbHNaVlZqUjlnWndTZ1ZNa2p6c245VHJsRlZ0NEIzTSsvSkNa?=
 =?utf-8?B?bFcwaE1HWERvbGx1Zyt2ZnRBRzd0bFlMNTZvck1XMXhNWmpHQ1kxenFhdTNn?=
 =?utf-8?B?MzZwZFovMENmNHQwRlcyM2NuTy80dnF5U2VyRGRyYUx1L09GWVFJVXZUOUth?=
 =?utf-8?B?UUFCVGdvTkRPRVdaREptWk1DWWNRa3BzNmwybVBSVE8vVUE3NnZsSWZ6VXVD?=
 =?utf-8?B?YjBxSW9DNnlkd3U3N3lOTkVsTE01VGJEN21XQlgyL3R5bFN6dEtZMWwwMzNB?=
 =?utf-8?B?MTZPcHkxelh5NzV4dllCRDUzV0w5cThlVVMwK1RPdDZuN0lwNHgrQlhMZVhY?=
 =?utf-8?B?NERTTm4yTW1tSHMvbStLQU4zSG9PZDVYRC9FTHVMMUNDNzI2TlgyemtCdm0x?=
 =?utf-8?B?OGNySmtaL090VVFYNjZqMVFLWksxZjAwRENMeUhBSTdlQ1V6K1A5Zm1GRHVq?=
 =?utf-8?Q?t+0JtCk7UCx0KODs3y3k6t/qOJiiHpAz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFRZZ1NTa3BKLzlDRGlMMkhzdWc4UmUrdERSdUQ1VG9HOTR3YzVubndMVEI5?=
 =?utf-8?B?dGlnbXRwVE1wV0ZXZkdVNDRFYnFNNGNtbHNpMCtDY3ZpVi92eXJpS25Ibm5X?=
 =?utf-8?B?TEZ3enpKRm8vVXA5SXhRK0JlWFR6MTN6V3YwZ1Fvb2IwblNEdjlXYVJRQTlN?=
 =?utf-8?B?WGk5S0RCMW5tUi96MzAvWHFRVkN5Y1hPWWhDRExwTXRoK21pYU5KYzdZcElU?=
 =?utf-8?B?QjFUTTY1bDdQdnVPcHp0b25NOERwR0JFKzY2d1RBNlg2VG5VcVZsSHZpVHdE?=
 =?utf-8?B?OVVIc2tRTHJ5M3pqNW5ESmg3TXl2ZjZkMHpDNnBhZXNDWElCeTkxdzJoQVhh?=
 =?utf-8?B?cHJXZTM1N1lpWVEyTzBRY2pmN002TUdUVDNqUkJSaVVEUSsvT2NpR1ZzdUdN?=
 =?utf-8?B?c0J6RTJqc2pPekpLQ28xTWtCVXY3aUZmVVVTeGtPRG9yRnMyWk1OYm9OdW9n?=
 =?utf-8?B?UjdmS3BJYTR1UzMrNzE4eHpsbGVENWRTRzhQbEQ2R3JpMkRwaUIxQmpJWE5l?=
 =?utf-8?B?MmJ3bStxbWV2UEgwTlZQaHVnb21mM1B1cjhKVW04QVdiR3dlTkJ4aW9mbzlx?=
 =?utf-8?B?RnhadEZ6ODBBUUk2dk0wNE5rS2k0QXRKb2tQUTA1MWhLZ0F2OU9yK2wrZmlu?=
 =?utf-8?B?eTZXYmc4NzczOWJJckNqMDhrNGZRVlY3b3VBc2paREFBYUlhTS9oUDJpNEJG?=
 =?utf-8?B?b1Q3Mi96UVZEYVE3UkVBVUxOcERDSmNlanhFalBWYjl6UHdJcXNhdHF2bkpl?=
 =?utf-8?B?RzJIQ01lUnpmOEFMR05iQ1V5bmEzbjRmK1NCQllrMXJldExxUTdFQ0dYb0Nn?=
 =?utf-8?B?THdyVGJ6ZlM2dlNYWHlsUDdyaFJwYmlvQkxyVmpsVEFUSnZPcktlUDFrZWps?=
 =?utf-8?B?QlYyNVZuK1p0NHBqeDVPZkRLQThrWS9PeXMrZzNrcmN3U0ZqYmJRZ2FWODZJ?=
 =?utf-8?B?NVlWL0JnZUtyKzF3V3pNbm1oK0hkQnBaNHJLUzNIdVEwV0pCdG9BV3BBVzFC?=
 =?utf-8?B?c3RIRzhKL2pMVnphTEcyLzVWd2VWQUpzaXFWd1FkMTZvdjlaMmlGZWFkZzdp?=
 =?utf-8?B?MkJ3U3c0YnZRV2FkdW1JRjZ6TDBnd01yWC9KMGJHODc1S1VUeW1pb0pOZllM?=
 =?utf-8?B?TkVJb1RHUGptRU5ObGxxK2JaYU9LMTludkU5dEJEdlUyVXJWek15aTcvVDVv?=
 =?utf-8?B?b1RHSUFsV3U2alBFcXprR2pTaGJXYnRSV3F3VmNYYXhxb01xNkpTTzg3Nmht?=
 =?utf-8?B?ZGR1ZXN5QkJ6TGc5emJmS2dya2pocDlZOWUxVmlZbUg4M3FFOHZQTFByN2dr?=
 =?utf-8?B?S1dWamlJYk1KL204Z3JaRS8rQmF0RzNDZVdUbU5LZk1QSDBlK1NqYlNueURF?=
 =?utf-8?B?akUwRXR1aEZiUXlQSXdqSGw4NTZzN3hGRk84NElNVWhDNlZFeVhNQjBGcGpZ?=
 =?utf-8?B?akFjQU95V0NTMWJoSWdzY0FaK3RCL3R3WmZpSVJtbmpCVVV0YXZXWHBSY2J6?=
 =?utf-8?B?NnpwVi8xMy9oK2oycytoU2I3Rlc0YkQwcnV2dXlnQlNhd3FDT2hQaGExZDRZ?=
 =?utf-8?B?VWxLNmdNdEdsTkUyUStaaERrMTkwelFmdld0YkJYVnVjZndramlrQzMyTWpE?=
 =?utf-8?B?RWJxRy9xLzBoRnNMdnZpbCtoRXcvNm1WTG11d1RFd3UxTjU4OXZRTHh3UllE?=
 =?utf-8?B?L1dqZUNxa0x0UGtjNXYwRW5yRVpod0hDRGFBZmd5WklZejdCNUp1S3lzOHBj?=
 =?utf-8?B?c2R5VURBc1RaelRuL3p1R09WNG9LamZyRDNNS3FVL29QdjVValh6ZWVSNFVl?=
 =?utf-8?B?SFVpUGFlYU9EaUZjUUI3UDNDUFJoVW1FREMzanBQcFhMcE9KK0g2WlNZM1dR?=
 =?utf-8?B?b1NscCthQnI1TFpNT2hIOHB3bW8yZDhzcWJPL3RydEtIWERaVFBMMFJKdjFp?=
 =?utf-8?B?MXQzR1JiUFh4eFJWQ3Z4dktQdktUelZuTTZUeGx6djJCZDRGcFZTT2dqSEx3?=
 =?utf-8?B?eEI0MDh0S0t5bGdhOWNyYVcrNnF2U09FNVdvVDB5TW1iZDErbGRkeWxDUVA3?=
 =?utf-8?B?RnY5REk1YzBKMXJxOERkZmxxc2krVWExLzdCRzFhK1ZQcHlPQTdNWEZyTC9a?=
 =?utf-8?B?Y0owS2J2UWJIQVJoN2hVZHJXU0JGNEViaTNnaHErWnJyU1IycjVPcEh6SXkr?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C94AE8C0D4C6C648A855167CDA75A772@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7410.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5cff5b-a0b5-498d-6278-08dd3e8835df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 04:08:09.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IkEGazAprw6hgwDnsOU5LJCCAAsrffNghzqNDiyQ4CThVJrYE4YMzLmCihY4Zbe178H4lofgvEABIz8bxZWzuVAdkmgXzkCrf4lDZsZ9skQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327

T24gMjQvMDEvMjUgMTI6NTksIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gdHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnLiBMZWFybiB3aHkgdGhp
cyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uIF0NCj4NCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9u
IDEvMjMvMjUgOToyOCBBTSwgQ2hhcmFuIFBlZHVtdXJ1IHdyb3RlOg0KPj4gK21haW50YWluZXJz
Og0KPj4gKyAgLSBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlw
LmNvbT4NCj4+ICsgIC0gVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0K
PiBJZiBzZW5kaW5nIHYzLCBwbGVhc2UgZHJvcCBtZSBmcm9tIHRoZSBtYWludGFpbmVycyBsaXN0
Lg0KDQpTdXJlLCBJIHdpbGwgZHJvcCB5b3UgbmFtZS4NCg0KPg0KPiBUaGFua3MsDQo+IHRhDQoN
Cg0KLS0gDQpCZXN0IFJlZ2FyZHMsDQpDaGFyYW4uDQoNCg==

