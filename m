Return-Path: <dmaengine+bounces-5092-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36AAAD39F
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 04:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98BC1C02E6B
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BEE1917F4;
	Wed,  7 May 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jkFlUOxh"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658312B73
	for <dmaengine@vger.kernel.org>; Wed,  7 May 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586384; cv=fail; b=sR6W2x7QPcCqdpNyqUfdl6XCj0Drbo8SvjO9hMxY1YR/rDp7BbXJieovt/KQhlMzrF1Vne6dj7B3xD1llVh90dNQOWRuEfYxCtpBmgtAgadErOXzCeF8/jA3Yw4mQ4Ilz6gEaqK9vjsUAf0SZvQEvSknt2yej2I2vcM7gAzcOw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586384; c=relaxed/simple;
	bh=FIDB2EWuXXRS79AOYw6d/tj/8jPNtPYbEKv27BPiU8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OY0hsLw5mhbpR4fr08AlS11Ex/GNZuUKUkZO2L7CJQu81Pngv5F4e0OOMwQmBoaPvgh64mHzvkuvCSFC2xpFpUgp/lMFlnN2kBAPNuejCgA8fG6UDTuYZWRPzpCRGMxpzP7z459e4Nfy/Vp8sKsg6jbanwnuJvr7mirYhHMT/08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jkFlUOxh; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXyXV72/h6ygEfrzEH5IlgeGpuqV1kHWwyyo8Gj+RilFZYafU4F1WPKoRxtViMJIFAtbaOoFx+6xSIXWZph6nVJYrma63Uhpgm0PK+LHYtCywEkHu77VxY/67dyVUvVT9SlZbINwbyZj//mvzMsY1Ho4ksEoPXG52CmKn9fSDIp58VXonKi/HfflWnDwXWk60V3l0R1Yf45bLrjtA094Ap28qMIHE+dEkC4+zZm0x7fEavgVe4ck8LdcHYbXi7V+lha38gc2gEgk+4+Vmx2dWOI9nvdiI2+btjaxsK1HP1Qz0pI31u/AQRXVoGZMgVY58+c2wipNFoeVA2IKGo/f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIDB2EWuXXRS79AOYw6d/tj/8jPNtPYbEKv27BPiU8A=;
 b=gbFHpktbqyEJEs2nCSvSh6rkPJ2ewdBgKxcFMeMf4AZ9RJsnykUAgADUUlTgrsgWvBlfEJVOfOo5n9L5RpT5wUqI7OyzNJLEjzhOeyLx0uuNZeL0eHZO2jp1Qs5nqsIvH9KHfDaeZ32LCEvfEvfwpH6d4V4jUtWcM+nliGt6uGcw8mJFH0GJnF/y7/tKGajaJ2Dw0lCCoasVe5v1o42WZW1BEioC+/sDashTHSRmFwy1JCBXs7iG8KnMVRMyIch7QMwf+pdbgVAMijxgHw39dJSWEWF8swqz6sfPGAV/RpMRP8RjTSeP9ArTvATk/b6oUe07iYlm6F6th6gNtTjXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIDB2EWuXXRS79AOYw6d/tj/8jPNtPYbEKv27BPiU8A=;
 b=jkFlUOxhQjK28isLUrRBeS+bprbweQINQftWvanGXLZpLcuaZgpiFQLRMmTeE0j9wdXK8goPS4WsngN9TVvCgb1JaNSNm7dkrG96lOKn/7HiOquzcmXV/gHYwHrFbmWpjtDVbo8eUeAuVVmFH1htB4tdsHkQUF327DzpwPEo6LZh91bNb9tL7qlc8I8+C0Ozjzg1sANQ6W10AnueE4mcVZXgNPfMynDfGHDHxC1YaR3p2qEnBBWl4d/gTsk8bYmNfJCtuYbDjaYOSEJS96BtNGaQ/0f+Dosb4qo84bpNcoxCqjQn3UbdmB5O/K1eMYdq/FDL7z/JTMM6jXd/gpVxmw==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:52:59 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 02:52:59 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, Frank Li <frank.li@nxp.com>, Vinod Koul
	<vkoul@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH RFC] dmaengine: fsl-edma: Fix return code for
 unhandled interrupts
Thread-Topic: [EXT] Re: [PATCH RFC] dmaengine: fsl-edma: Fix return code for
 unhandled interrupts
Thread-Index: AQHbvoai7PbSy9Fu+0KulVSw+UqgdbPGeL6w
Date: Wed, 7 May 2025 02:52:59 +0000
Message-ID:
 <AS4PR04MB938603846EA87824441719F8E188A@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250424114829.9055-1-wahrenst@gmx.net>
 <3e325980-f07c-4290-ada1-ccb23d1f8c65@gmx.net>
In-Reply-To: <3e325980-f07c-4290-ada1-ccb23d1f8c65@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PA4PR04MB9248:EE_
x-ms-office365-filtering-correlation-id: 2be9ae90-f085-43fd-0042-08dd8d1246c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXVVaDRXeWpxQkZGNmhoZVFBS21CY1A5Q2RoOGszdTYzaUJsNnZ4OTZsdkt2?=
 =?utf-8?B?WFNBTEVkdHB2bllQS1RzNHlsYTNxVkwxenplVkdVZXlFSUZ6eld6Nmw2MkRY?=
 =?utf-8?B?dk5qTVY5NUZlQVBWRnBMUFBtK2Zxa0pvS0FPSzgzamFGZlRJSzdic2FhWmpk?=
 =?utf-8?B?ajV5ZlFKRVA3QjgxS0pkK1hWSlB0VEN5ZFZCYUdWd0lDdktjNWg0LzFMaW9z?=
 =?utf-8?B?enU2cDhHNElTYUJLcHM0a3Fpb3czdDhwREoxNzFCcmtycFhNZGs2aG43SWFq?=
 =?utf-8?B?THpKY25iLzJUa1F0aE02TDZxVXY4ZGRMTmw0NDlLY3ErOUsycDFkT3Z3NWxm?=
 =?utf-8?B?a3Fsdnl1ZjVFSWlrSDh4a0ViendQQWwvY09pT1FOWTVzNUY5cExmVjNkQmxM?=
 =?utf-8?B?bjAvVnloUTdlMGNxYlI2eDRqSEZlM3hSR2ZDS0FES0xqL0V4WEdhVGRLRjBt?=
 =?utf-8?B?MXoyVmRsMTJqeCtWTTBkb1prOG9oWWFmalhIbGZDejlFZ2c1WGhsUU9Pd1Ar?=
 =?utf-8?B?ZmRlMjVHSGhLbHNTQ21nQzBBdFZtZFhxd3EyT1AxMEF6QUl2ZjFKZ1JYaTRM?=
 =?utf-8?B?K0YrQUZBYlN4cUt1SU9BVGdjV3BqMHB6czFSZEEwYWJCTUJoTzR6WXJ3M0Zq?=
 =?utf-8?B?MGFya3dMVWpROFFIYmpBWUN2bEp4L05zNDZnT0lNa2cxcTNPMWUyemRVbkZX?=
 =?utf-8?B?RXRna1lUaGFWZnI1VXZ2ZkZRbE9jVTZ4KzVEVmoxTTY5dW55RitORVNubzFW?=
 =?utf-8?B?b0drUXJmT2xra0Q4YU9lWVl5N1AyZUZnMDdtRUlrMVU1U0pJaFAzVFBCeUJY?=
 =?utf-8?B?SFNMTFR3bnN0TEppQTVRRVV1ZzJwbFNpektsamM4TDk2YmNPMTV6SGZSWlpM?=
 =?utf-8?B?VDV3dEUwaFVGQjhzREdLYkRwbUYvWFRTSCtaYm1LUFZqY3FDUGxRb2xMS0ZI?=
 =?utf-8?B?QlpXcVFlS0lQTjI1MndhdUdrZVQwbTNRQVNSQTFWbGhZSUxPdm1MYTEzS0Vw?=
 =?utf-8?B?Uk1MeE0vR3B0bElWUUttcE1GdDhRb3hnNkJMaHgvWUg2ZXJaYTNLUm5qTkYz?=
 =?utf-8?B?KzZYOVZhKzhoUytPTDV5QUhmQWFGWEkvZ3ZmZnpUUy9McnBKTTRGSk9Zakpn?=
 =?utf-8?B?bUtaa1F4U2NsVytrbkg1aGM5elppeUNRQ0tmeUp2dmRWSHRsODY4R3hQN0da?=
 =?utf-8?B?Z3lCRGhQS2M5SjQzL1RDU2Z0ZENGaU1ramVyNTZpTVZSbkNFWGhxRU5WK04r?=
 =?utf-8?B?T05zaHZyV0tYZXV1TmJ2Vndnb0xXbDBkdmNtVXZ6YkZwcnhBam1MUUZJVUdT?=
 =?utf-8?B?bTNybE9rU25xRHdoenNWelVlZjZ6WGhvZHc2d29xL0s5RU9GNUFOb0YxenRZ?=
 =?utf-8?B?WTkyR21ZTnMvTktxVFlTYjNxWmVIbExEVzBLTHlNcUgxV1RRRUZXbEZaOTNF?=
 =?utf-8?B?U0p6aXZQRjdQOEcxdDlVNjlhZXVLaEZMTWEzSDdsR1E4cVpZeDk1aWNNNjRH?=
 =?utf-8?B?MUorV1kvUHB6MmtTbjZuaWsvRk5iSlpvM1djT2dMOWFCQ3ZseFY4RVp2Z0xY?=
 =?utf-8?B?ZTNvY2lmQThCVWpPOUVuT3phVE1LWjFQcUpRa0MzZVFIUTJSRnpONlFPSjEv?=
 =?utf-8?B?eTVYdTVPZHNXMElaZ25nb3U1U0lrRDk3dzQ5ZWhTTVRDUkVqQTVUb3dBOEsz?=
 =?utf-8?B?SGtLekdGUGhRSEJ6ZzNRNFc0ajY5elBKWFNXbXBlRHJwUExSdEJ4Vnl0UGZE?=
 =?utf-8?B?c0V3L3NuYjc4cE4zbHZIdDQ1ZU5TWjVkMlJGOHRaQ2lIWmhsWXYyaUljU1dz?=
 =?utf-8?B?TjdBTjJIaloyakQ4RndPVDQyemRtc1JrRisrY1FDbE5IV3VUWWwySjJzcmZj?=
 =?utf-8?B?c3JvcWNSSHc1a1lEZXB6b2dRN3c5WVdXdkozb1F3eFFIWCtBUFZDM1hTYjhj?=
 =?utf-8?B?YzMvcGZadExRWDdHZnRhQ2plaGdDOElyOWtqSi9CeEtpR1lDdktXSGhLbEtV?=
 =?utf-8?B?Qk9PTEFhN09RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmlwaWprdWRkb3BIRXJWVjVXM201UnJXN3Y1enNYa0JSREJXOEpEdHVoTkpB?=
 =?utf-8?B?b2syN3JyOE94cHZTZHBLLzc0OGJuV3dFQTI5dVdHS2xCajBEa3Mza2N4eHZO?=
 =?utf-8?B?RU81M2tmNmJxWkFtL3JGeVdoOW9qczMvS1NjcCtzS2hYcWcrbXliTWRaZmJt?=
 =?utf-8?B?eWxQZmNXR1QzWXpEOFBNa0p0N0JtbmFGbjhsT3ZhQnMxTDhUU3BLT0tKN2t6?=
 =?utf-8?B?R3lWY2VFSDBDZEhmc0pYQXVTTlZUWkJRdGFvS1IybmN3NERSWmxYeHRodE1M?=
 =?utf-8?B?eFJTbEFpMjlGMEFDNS9xRnFWdmRHUHNVd3lDdTdXZWtHbTIzMzlXanRFaTFo?=
 =?utf-8?B?ZXpTeUY3eGhJWEdjYUZMQ1ZQczVXaGcwQWpHUVBqZjRFakRxSkRoSWpicHhz?=
 =?utf-8?B?SFpWYjdvV3NKWCtWaE82enFoR2JCbnkyOVRoUHVoSTZDUkhLRjlsTzNjWlRQ?=
 =?utf-8?B?ekY1dHh1bmxXQTFEblp2b1VNZk9hdEp0aXZRWkpVZFVkU1RNcFg4WnBSR1c2?=
 =?utf-8?B?M2NEK0NOYXBDZXFLeFFNWm15dHN0bkZMckM3d0FxNVlQUlZNWXFNZHRmNWwx?=
 =?utf-8?B?VU9ZRzZaTUQ1WUxQQzNpWlVqSzZFOFlVeVVCVUprQVZYc0xsMEdaQzY2TmNK?=
 =?utf-8?B?RFQyL0VTWlRjQUc2OWtLZGxnTEtoNFNwNTNwVmxEb3grcWhyZDF1emR2OUFI?=
 =?utf-8?B?Y0RtaE9uZ3JhU3ExZ0R6YnhhY1VBa1VTaWFlWjFxS0llTDN4M3djRnNCOWdC?=
 =?utf-8?B?eXBsUHJWTkxtbVhVMUs0NHRNeDRQNFBpYzFRdnAxTjJrN3EzWVpsdGc0Smdu?=
 =?utf-8?B?QnVCSDdwMHRKOFg2aVNtS0p5ZU1zbllhU2hTS3E3WjJMaWNZQXdwV0gzYzht?=
 =?utf-8?B?WUxLbGU0cFYwczNpVW51cnBUeXFFWmF5eXQzeVJabE1mcmVrZ09BdHdvQll4?=
 =?utf-8?B?QXBhL2pGYXFWQms0UmtTTWZPOXlJanA4aVdPU0JpTmxmQmhxcFhZWXAxOGd1?=
 =?utf-8?B?OUIvRXRNMGYxcFdrTzhmTlRFQjNxTDFmbHplMlBnMjZncjBNRTFxbUlNMVFV?=
 =?utf-8?B?T1BFaVVtVk1ib2lnQ09QaVRjbWtqRCtVUTBxUkhvaEZDTmlNeU1sczhLVm5O?=
 =?utf-8?B?dG1WT0FuUWl4REw2emFNRGVLVXBqOWszSHh1MmNTU1RWM1BPbDZsc1Z5cnU2?=
 =?utf-8?B?S2dyVlFEWkNJNjFxMUk4ZUpLM0xvMkxnZ1gvbW5JOFRONkVIYVpBTHZyVy8z?=
 =?utf-8?B?WXpiTC8wT3BJaGZVbkQ4bEp0dUNWL1hHclg5eTRrNWF2S2l0OU5tYnE4dmJN?=
 =?utf-8?B?cXdoSCthcDJoMjhDYzNiV1FxeWRRS1hwc3J2eVBrb1M4VFFVRVUzZFQxTmc2?=
 =?utf-8?B?UlhIeHlaakQwVTh6d0svZE5HSDcrSW5FZDdVRE1PZXFNcEhoKzhTbjhRaGQv?=
 =?utf-8?B?bUVzT045bGkycUgxKzE0V0Fjay9ueW5CSlZQdE55eDlDczFiVnRRelQzRzVI?=
 =?utf-8?B?U1dkeWM4eHBnZzRYZ2tRdDJ5Ryt2eHBoeUxMMFk3TXZORWltazI2bjJiM3dN?=
 =?utf-8?B?djQremw1dWJ0ZEpMSU9CZ2VVVmlZdjJFVXFlRWtyeXAzeXV5QXh2elBmOE9X?=
 =?utf-8?B?UXJOdXZSdDl1bWMrQU1rMzhWRkxFcXNkMW83RkV6WVRjVW5rcTIxNjZDVGRx?=
 =?utf-8?B?eUVvMWJKanVOYUJGZFJHb21oRW8yak9aT0hLL1d0bkx2UlhJTmtmV1NVRXJm?=
 =?utf-8?B?UG9lM0NTL29ZQXp2bW5sZmNuTlhpTGNqZmJ3aXlaTW1EOHp5MTV4SkZENklG?=
 =?utf-8?B?b2dYUitCR21tQ2k3MkZRU0tWOElwSGlMQzJJM2dsVmJHb3d6b1lOUmhUNHVX?=
 =?utf-8?B?TEQzT3RscHRmSkt4Wkx5a25jYXdKYTBVSnJCVFlOcElNZ0QxVzlRRDhnUzhy?=
 =?utf-8?B?dGV4bE1FUXA2U3E1am1yZFl2TGMvREZDWFZNdTVPWG5aSDVEZDl1OWh2ZHpp?=
 =?utf-8?B?TTdkOTNwenZhS1Y2NWVkTzlXd05FS2drbVFYMk13ak9wWXRlY0FVY0JTa1hr?=
 =?utf-8?B?UHpUamx0OUhFRVRzdk5nak5iVm5pQlRsSmlrTzNTY3FienNLS2FMa3NrK3dm?=
 =?utf-8?Q?lO08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be9ae90-f085-43fd-0042-08dd8d1246c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 02:52:59.2509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVhD0bGw6KP0PRrWHq8+UertAAqFVMDfSTR+a5GveEK6S5+CoMJeuEQWHDZZIgS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZWZhbiBXYWhyZW4gPHdh
aHJlbnN0QGdteC5uZXQ+DQo+IFNlbnQ6IDIwMjXlubQ15pyINuaXpSAyMDo1OQ0KPiBUbzogRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyBWaW5v
ZCBLb3VsDQo+IDx2a291bEBrZXJuZWwub3JnPg0KPiBDYzogaW14QGxpc3RzLmxpbnV4LmRldjsg
ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggUkZDXSBkbWFlbmdpbmU6IGZz
bC1lZG1hOiBGaXggcmV0dXJuIGNvZGUgZm9yDQo+IHVuaGFuZGxlZCBpbnRlcnJ1cHRzDQo+IA0K
PiANCj4gSGkgRnJhbmssDQo+IGhpIEpveSwNCj4gDQo+IEFtIDI0LjA0LjI1IHVtIDEzOjQ4IHNj
aHJpZWIgU3RlZmFuIFdhaHJlbjoNCj4gPiBGb3IgZnNsLGlteDkzLWVkbWE0IHR3byBETUEgY2hh
bm5lbHMgc2hhcmUgdGhlIHNhbWUgaW50ZXJydXB0Lg0KPiA+IFNvIGluIGNhc2UgZnNsX2VkbWEz
X3R4X2hhbmRsZXIgaXMgY2FsbGVkIGZvciB0aGUgIndyb25nIg0KPiA+IGNoYW5uZWwsIHRoZSBy
ZXR1cm4gY29kZSBtdXN0IGJlIElSUV9OT05FLiBUaGlzIHNpZ25hbGl6ZSB0aGF0IHRoZQ0KPiA+
IGludGVycnVwdCB3YXNuJ3QgaGFuZGxlZC4NCj4gPg0KPiA+IEZpeGVzOiA3MmY1ODAxYTRlMmIg
KCJkbWFlbmdpbmU6IGZzbC1lZG1hOiBpbnRlZ3JhdGUgdjMgc3VwcG9ydCIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogU3RlZmFuIFdhaHJlbiA8d2FocmVuc3RAZ214Lm5ldD4NCj4gYW55IGNvbW1lbnRz
IG9uIHRoaXM/DQo+IA0KPiBUaGFua3MNClJldmlld2VkLWJ5OiBKb3kgWm91IDxqb3kuem91QG54
cC5jb20+DQpCUg0KSm95IFpvdQ0KPiA+IC0tLQ0KPiA+DQo+ID4gSGksDQo+ID4gdGhpcyBpc3N1
ZSB3YXMgZm91bmQgb24gYSBjdXN0b20gaS5NWDkzIGJvYXJkLiBUaGlzIHBhdGNoIGhhcyBiZWVu
DQo+ID4gdGVzdGVkIG9uIHRoZSBzYW1lIHBsYXRmb3JtLg0KPiA+DQo+ID4gICBkcml2ZXJzL2Rt
YS9mc2wtZWRtYS1tYWluLmMgfCAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9m
c2wtZWRtYS1tYWluLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMNCj4gPiBpbmRleCA3
NTZkNjczMjVkYjUuLjY2YmZhMjhkOTg0ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9m
c2wtZWRtYS1tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMNCj4g
PiBAQCAtNTcsNyArNTcsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZnNsX2VkbWEzX3R4X2hhbmRs
ZXIoaW50IGlycSwNCj4gPiB2b2lkICpkZXZfaWQpDQo+ID4NCj4gPiAgICAgICBpbnRyID0gZWRt
YV9yZWFkbF9jaHJlZyhmc2xfY2hhbiwgY2hfaW50KTsNCj4gPiAgICAgICBpZiAoIWludHIpDQo+
ID4gLSAgICAgICAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gKyAgICAgICAgICAgICBy
ZXR1cm4gSVJRX05PTkU7DQo+ID4NCj4gPiAgICAgICBlZG1hX3dyaXRlbF9jaHJlZyhmc2xfY2hh
biwgMSwgY2hfaW50KTsNCj4gPg0KDQo=

