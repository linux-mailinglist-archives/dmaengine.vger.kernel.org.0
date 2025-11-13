Return-Path: <dmaengine+bounces-7171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3BC58E39
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605EA425583
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37003359711;
	Thu, 13 Nov 2025 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sf9IwacR"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011021.outbound.protection.outlook.com [52.101.125.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782782EF67F;
	Thu, 13 Nov 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051796; cv=fail; b=g+t1PhOKS4y+We6MnGTsbLavKd8Y4YqtLPyRU9ywqDJxIjoGcq36tcMCQ2DJl5XVEMZK64M7VQQ12Ce7sM1wKmH+GdNmp5454illQhi7CT8HtxSzIh0GMJGlBvM2cACOrFMoBXWWNQq6zdEtRthEaBGLSeXNqooAlAoSRobatbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051796; c=relaxed/simple;
	bh=q3JLNgba047xWDrQqEVRqNJF8sqjnZMee1xcAfSqov4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJbPGdAcAnYLRdamMp42rBhiykZYEF9nla3cBrnw53wGfR2jNGAMfzJx1F2wz+e/NTMm/wpzMgiutKpdlmbE5tDTjcS8xZnc1eGFTbdqLGb+TNasFsLgQ7j9Cms4LCjY19Mwio78ZOukWWgHLzxssNusKI+Os3b0Xach5I98+Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sf9IwacR; arc=fail smtp.client-ip=52.101.125.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4wWOqhqXs32hUa9VF5aRxbwsLixY0U8ANX7YUzjRjt+s/zdFAkgEoAal6Oc8g7AuBP+NGLr4XiWS7uB7rP7p912yygRP2FyKYP7rRJBl57aahc3xo6zQj+YtpsI7ewDQcYRkJcsaS/pvB6m1BEYe1j+ZakBKQxf48n8w+BqqTDs3REYiNKng7QfZoAtl2CFIvEWESQomGQx2SefUADUsHWvEBb29Zee2MMYkgHPgKDh5E64LBLKhVUMXlW61uDD5U4YkXjsIuKmwHxQinJO6CBMFeE/mXMNaQYYZeaNSdYY7kFaN2RZsB2l2AHqVgJIAWScnCSYflIMIDbWGMMzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3JLNgba047xWDrQqEVRqNJF8sqjnZMee1xcAfSqov4=;
 b=yHDlnq0CNHXx43jdx+MiUrFIWOgOzTEcQrKaF77akByTDfNyxTjC+TvPO2sNIe+5gOgkM2PlnhXE1FD2Zwu8Rm/wAoRHaSXiZUDaPkCL8uy+y/0YWt3fgTqwL4CBpFtYIm+Z+9a2qsOhs6FhLe1DbzggjSlnrYFAu9GEx5oHCx/g3lX8KpcWh8xu8axVjAzIBlcomN66cA+6g2b80f4/ZD18vzXb0gAAr26Ng+lqDpAkKXR1jyTyzcgmG7+Bby9Q3dap59W7+z/tXA5/yIjqkoaNg7EgOSWHu+KA1q+YTwXYR1Pj24DIfcdDo/ilxXa/FVkYqyUaTEUMM5qXUukPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3JLNgba047xWDrQqEVRqNJF8sqjnZMee1xcAfSqov4=;
 b=sf9IwacRuILRWI1XtcjGphox0jbTev1r3iNWB6+7AdVXbbSj9UTj5K5NDMBq9idcYnjBa6O1Xqh6fLc0dD4mfynFZFn4nc8WpJZM1PTOoibYxQQwtDNto63yw0dBYyqOAOvvBA9z/W15i3Bx6XRH3Oh2gz6OJesBdNvFuVPTDrg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB8262.jpnprd01.prod.outlook.com (2603:1096:400:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 16:36:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:36:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, biju.das.au <biju.das.au@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
Thread-Topic: [PATCH] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
Thread-Index: AQHcTxxQcPKXLxUNvEiVrNoV0W8k5LTw1VUAgAABbdA=
Date: Thu, 13 Nov 2025 16:36:29 +0000
Message-ID:
 <TY3PR01MB11346060F7E0DA5B21F822A1586CDA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVP3xOGa4gj6LRBU1fdGPbihAayGF8xUCCZjJctyR-DOQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVP3xOGa4gj6LRBU1fdGPbihAayGF8xUCCZjJctyR-DOQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB8262:EE_
x-ms-office365-filtering-correlation-id: 590f7170-c8cd-4019-eae8-08de22d2cc2e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFhTVUpQVjZ6THhETGgwM2hVOE9sQUNTYUY3RFI0QitNdmF2eHMyNlZQTUlM?=
 =?utf-8?B?MVZMVFRQdEJ3NjBwQ1gyNUxURXg1ZzhpTmdxUFM4N1dWbHEvd2xqb3dmQUdx?=
 =?utf-8?B?bXdnR2pweDFKUElYN0VaMHd5K205alVISGV0dU1LZndOVnJZM0crQ0VkZ2Rq?=
 =?utf-8?B?T2VlS05mSkwyQXFPaEc1K1UvRGVwMlQzOEhuSVM1bjdySTZvSWI0Z3JSck1o?=
 =?utf-8?B?RDBSVjIzWFB5WTdPSDNnd01sczMwckVXTHZLV3VQakh6RG51MCtIVmRma3VO?=
 =?utf-8?B?RkUzeW95aFh6M01pUnAvblBZRng5cGcrVVVobE9VYnNGOW5vYlVEWWFZeVBr?=
 =?utf-8?B?VUsvR2h5dStIQm1XdytCRVF5bnhSQXdRSHlydGJVa1h1RURDdFB4MzhRS25C?=
 =?utf-8?B?ZXBremZQSzk3YXBtbWNXR2owWW5TbXFZTUZVUXhUV2tLc2thL2lhR0hKWW1Z?=
 =?utf-8?B?cXZRL25pQkF1cUwrQzc3T0w0dkFpdnhGVmlEOFRQd1liczd6VHBPUEdwWmsy?=
 =?utf-8?B?Ny9KM3lmMWtXUzlueHdZSzYyMUI5UldYTTBIVGFpS1dHK09pS0JkNDk5UWlX?=
 =?utf-8?B?NllPb2VtSlQvOTJkMFkrMDJKLzM0NkVFQitvTjdwZXFqaEZ4cjRrR1l2WDdL?=
 =?utf-8?B?RStWMG9BZGt6RjBCWVA4c0JUMVBDOEdWdTYvaGJPaGEwbVJwdjJEYlM4SzFD?=
 =?utf-8?B?TmxoTVREdTFSc0tFQzlhZkdhMlBMOWZDM1VnUjg0SHc5TXM5b25aQVppaUl4?=
 =?utf-8?B?RHdpbytpZmJkdkQwSjIvRHQ2QlFINGIyVFJVWm5EMGFJRStMbC9TWVF6WE1i?=
 =?utf-8?B?dXJ1Nzd4UkRNamhhaTZNL1kyZ1V6YVF3NmVIMWxscXd0L3dTMmJHbS9kR0ZQ?=
 =?utf-8?B?Tlo0ejNPdzNTNWhWdGFub0FMZmc4VG1OMUFHOVI5M2dJSDBGbDlBNzFtQmFj?=
 =?utf-8?B?VklEL1ZaaUNmdjFxSDhTSFRLN2xBcytOcmdNbWhGYXU2M21pR1dtWjgra2M0?=
 =?utf-8?B?M1JYZU9VcUhsZGJqRElhSElOc0JXcjN1cGNkR1pGYzZQaEhYOFJWS3hJWDFF?=
 =?utf-8?B?dkg4R3k2ZjFUaEhwNUpiUW50U3JiMFpXMWV0TWtGc052dFhXaXhPSThsdy9W?=
 =?utf-8?B?NWt3ZmpWaUx0WmVCeWxocUlQYTc2aWg4OUhzVWtZUmF5V1JyWDQrc0E5alhS?=
 =?utf-8?B?bmgzaW5NdGtPZ1Bmd1FjY0dlMVp1TTBFTE9ocUhJWmNtYTdsbnBScGhLWDht?=
 =?utf-8?B?a3RUVnY5eURqZUFwVW5FY1ZZeTltRGNCbWRPb1lpemoxSXlPUTJnT3dVbWJj?=
 =?utf-8?B?Qm83RUFpaTU5OEtkaVpiYkI0WHVjVmZVR21IZ3QwWmhpTUxLaDdqVzE1THRi?=
 =?utf-8?B?TWQxaEpmYXA3RXdvTUtmSU1KWVIyRFNES3YwdGFWOHV6Qmo5b0lkZVlsVXZz?=
 =?utf-8?B?cE1YZlk2OExtTlJjZmJaVDIxSWVncnBmSDNJS3A3TXRydys2YlZhOWR3VkVO?=
 =?utf-8?B?TjZBSnA0VVhSekVUTDZaYXlhd1k1RUUyM0t3NEl1VEJIdVpLVUdvZWlwSHZL?=
 =?utf-8?B?SVpFTlh2MFF5ajZRNG9oSVozSUFKczNVaDdWaXpVS1NydDlER1NjVUlvV2JF?=
 =?utf-8?B?TUJRamV3TllJc3BjYjNCb0xXUzJLRjR3dHZuMmcxenVQS2hIWVY1aGcyTWhj?=
 =?utf-8?B?L2dPQU5QZUlqckZST2lwS3oySE4xcjRzT0J0M3lFWFB4S2J1blhNQXkzVlpa?=
 =?utf-8?B?MVlCTTJGZmQ2ampKNkpGMWhoeWVOYnBpZkdSOENaMkc5SmRKQTI2NmdXdmpK?=
 =?utf-8?B?UGhWaVFjc2JuU3lCbWZ2LzcwbjB4cTc4TTVSZzNQNWpuK2htdllZSmdybFNO?=
 =?utf-8?B?U2lIc2JrdkVDdjU5KzE5U2RZa3hRKy9ZaGJ6ejZwYzJmRko0cThUb1Qwdk56?=
 =?utf-8?B?VjFZdFR2SGFWOVdHVEFIYmNZQzB1ZjNGd3A5Z2ZrOUdHOE9oY1RIaU5idTB4?=
 =?utf-8?B?TGxSZkU2MnBqaDJIck02MXJtdUliOVhsMWJadmFUWWJuMDhxQ0hXUmJyODZP?=
 =?utf-8?Q?K6BAgP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3RqU1ltN2NodGE5Z1MwakdtLzFmSmU1dXNVRzVmZHgzTkI4S1VHdllCd2V4?=
 =?utf-8?B?bWtGS2NlUTRmckY1a09Dang2aU0reEhEN0lPVkd1TTl6a3NJeHhKdTZPK0M3?=
 =?utf-8?B?b1hSRy8wVlEzaEo4VUVzUUxrWmFjTkhtbVNOdUE0dWJscVdoMXh2REg3YStx?=
 =?utf-8?B?OW1wM01oZ1ZZYU1WOFdLZmF3dHo4ay9Ha3MxTlBuNFppQ1Q0V0llY0o5Tm1I?=
 =?utf-8?B?cXBnQ2U2dkk3ai9yc1VCaW1qZm4raG5VLzR6SHdXRnFONDV3TWJ1c2t0Mjli?=
 =?utf-8?B?WlZ4a1VUMkVHVzRXUDFWUGRraWo1c2lpdmpOVHBreDkrUG51SlRCLy9TanN4?=
 =?utf-8?B?MGJBYUlvbUFuV3E5bWZPVy92VzdWN2w2TVUvM1RXZE5kNVBGSm1zTis1SmJ2?=
 =?utf-8?B?amVIYTNEYzhaNEVoZFNPWWVhRGo0aEdzaXE2UGxDVUFEa1FpdFo5dFNqZGFt?=
 =?utf-8?B?R0VBeDBCMzRMNGRnWmlucDNIUkk3U0ZmcmZLQkdla1Vmc1Iza1pwUU56UWtz?=
 =?utf-8?B?RW5aRTlaS3NjZFNKMHdWQkdXbGZtbEczVmJqNzBOdlhhVzJqQi81TzdSbUVG?=
 =?utf-8?B?dzl1dytySGhjOW1YU1dyMitRalpLWXZTTDNFSDVoK0dHRjNRTWFPamVDOGZ6?=
 =?utf-8?B?WndQemZyYzlGN0RvY1ZhY0VDSSt6RW01eit4dXR0eHd3QVhwOXNPVk1WTzJy?=
 =?utf-8?B?MjFhUm9CNCsxRGtXdkRUWjY5Vml2cjREcXZzY1hIczZrbUtMM1ZBNllBZUph?=
 =?utf-8?B?RFNvbTBBblFKdm5MSmJnZS90R1FiV0pjWWY1ZTQ3R0J2ZEVuRmZVNFNEUWpG?=
 =?utf-8?B?WU5pVStWSGNBbUxHdEk0ZEl0S20rUGk0QzhxaDJvd284NW05c2cxUTFCc0s1?=
 =?utf-8?B?M0NNVEtEVkVyVUVXeDZmbW8yRzg3SmM1NFpZUEdYcTcrN1A1Qm01T2lhNWFR?=
 =?utf-8?B?MXViS1VWWHUyWm1VSnlrSkpjY2NUTjZvUjR1ZVdsL3VjSG5NcGR5djh0bldT?=
 =?utf-8?B?dlBpd1dZOUZicW9yN05ibHdDT2xoTklrbzd2a3NMMjg5OEdESE44bVhMOUd1?=
 =?utf-8?B?ODlWQll1QTdFSjlwdVhOaWYvQ1ltSjJVWlZTK0lLazR6MzlPMUt5elUxTmtB?=
 =?utf-8?B?L3NhVFhOdmZSaXhKMm5YQlpsTFNVMHl3aitZUU1jVDRreURxbHhoYUtJUk5i?=
 =?utf-8?B?UWJ1RWxEZU9BUXRXd2JqZVNmT2R0NGRVYWN5b0IzamJxQ0ZlSkVGdXRDa2tt?=
 =?utf-8?B?bFNkcVlDMEU3UENNUmltclBpbHRDWXIxRTNTSFZzM2gxbE1mQ2JGcDVkNndz?=
 =?utf-8?B?L1UwUnlaVzE2Q3o1d0hORzBRc0N6RlFGaS9TY2srTzcvSmc3bFBqbVVNZHB1?=
 =?utf-8?B?K0hvbG12YkVJd1VvWFYvdWplS0dYOUFFME1sU0lZTGthUHBZcm02NG1ZTjJz?=
 =?utf-8?B?cEs3TmFTR0FTNU8xZTV2S0t6bDdMV2Frd0M4bFo2SkhEQWNzdng2ZmdHMW9m?=
 =?utf-8?B?RitneXRlSHJpTXlGZEVpZU9sZGczZUI5K2NaVGJIVVZhS1F3anRvRlcybXlD?=
 =?utf-8?B?ckVVQzc1NmcvT1B2d0xPUi9ydEk3dkwyTUNmYW9LZ0NNN2d1Z2oreXJ0L1Z0?=
 =?utf-8?B?bFFYVkhzNUIrSlZrdG44OEE5WUwycnV2OHIweElPYXJ1anZicEZua203Y0dX?=
 =?utf-8?B?T2psdFVidlZjMnA2WDlReEo4V09SeDBlRlBaOUFUVnBzWFhBMkFiVHU3Znpl?=
 =?utf-8?B?Z2xCOTRCQU93SlZRTWlYeVdoQXMyYXZmSWJUSzYxanNyUlZJNGppbEs0OWNK?=
 =?utf-8?B?ck1MM2Z5YkZoYytUL2dPeUpJMEJVK3JuSkg3bUZsaWQrT0xUOUdTQTY5K3dv?=
 =?utf-8?B?Qk80S3lpYnUwZnYzeVpPdVRqK0x2TDM5WU10REJoSkVQWlhYNGw1dnVxV2RY?=
 =?utf-8?B?S0hnK3Y1MExvMnNSVzc3ejRCZXZzV0JMK2NKbW42VjJjWlBkRENSZEp6WEF1?=
 =?utf-8?B?Q2FSaUI1dE80bVNYSlIvcmpBUzN0QjBQREFHMjVXMnl4MEl5UjQyaG1uNk5j?=
 =?utf-8?B?TnNTenM2OU5TejdkUkVwdjNkVlkvSUh0d3hRdGpDckNYbWFsakdycjNmeUtu?=
 =?utf-8?B?N1ZVNEJ5OGdaTTUzSGtrT2daU21yOW80UlFpWUZqa3hVeWJ1VlptbjIwUTA1?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f7170-c8cd-4019-eae8-08de22d2cc2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 16:36:29.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Juz6hFPzyB1nSxYTSMRf6u9KqlOxj87epUFM9PnJ+idy7BTM3kC//095vV84r+DfZhnqp7fjZA5svOdDatNvRy6UUDS77CDps6zlyFdRns8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8262

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDEzIE5vdmVtYmVyIDIwMjUgMTY6MjMNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZG1hZW5naW5lOiBzaDogcnotZG1hYzogRml4IHJ6X2RtYWNfdGVybWluYXRlX2FsbCgp
DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gT24g
VGh1LCA2IE5vdiAyMDI1IGF0IDEzOjUzLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+IHdyb3RlOg0KPiA+IEFmdGVyIGF1ZGlvIGZ1bGwgZHVwbGV4IHRlc3RpbmcsIHBsYXlp
bmcgdGhlIHJlY29yZGVkIGZpbGUgY29udGFpbnMgYQ0KPiA+IGZldyBwbGF5YmFjayBmcmFtZXMg
Zm9yIHRoZSBmaXJzdCB0aW1lLiBUaGUgcnpfZG1hY190ZXJtaW5hdGVfYWxsKCkNCj4gPiBkb2Vz
IG5vdA0KPiANCj4gLi4uIGZyYW1lcyBmcm9tIHRoZSBwcmV2aW91cyB0aW1lPw0KDQpPSywgSSB3
aWxsIGZpeCB0aGUgY29tbWl0IG1lc3NhZ2UgYXMgImZldyBwbGF5YmFjayBmcmFtZXMgZnJvbSB0
aGUgcHJldmlvdXMgdGltZSIgdG8NCm1ha2UgaXQgY2xlYXIuDQoNCkJhc2ljYWxseSwgd2UgaGF2
ZSBhIGZ1bGwgZHVwbGV4IEMgdGVzdCBhcHAgd2hpY2ggb3V0cHV0IGRpZmZlcmVudCBtdXNpYyB0
bw0KTGVmdC9SaWdodCBhdWRpbyBjaGFubmVsIGFuZCBjYXB0dXJlIGF1ZGlvIGZyb20gTWljIGlu
IHBhcmFsbGVsIHRvIHRlc3QNCkF1ZGlvIGNoYW5uZWwgc3dhcCBpc3N1ZS4NCg0KQWZ0ZXIgY2Fw
dHVyaW5nIHRoZSBhdWRpbywgd2hlbiB3ZSBwbGF5ZWQgdGhlIGNhcHR1cmVkIGF1ZGlvLCBpdCBj
b250YWlucw0KZmV3IHBsYXliYWNrIGZyYW1lcyBmcm9tIHRoZSBwcmV2aW91cyB0aW1lLiBJZiB3
ZSBwbGF5IGFnYWluIHRoZSBzYW1lIA0KQ2FwdHVyZWQgYXVkaW8sIHRoZW4gaXQgaXMgT0suDQoN
CkNoZWVycywNCkJpanUNCg0KDQo+IA0KPiA+IHJlc2V0IGFsbCB0aGUgaGFyZHdhcmUgZGVzY3Jp
cHRvcnMgcXVldWVkIHByZXZpb3VzbHksIGxlYWRpbmcgdG8gdGhlDQo+ID4gd3JvbmcgZGVzY3Jp
cHRvciBiZWluZyBwaWNrZWQgdXAgZHVyaW5nIHRoZSBuZXh0IERNQSB0cmFuc2Zlci4gRml4DQo+
ID4gdGhpcyBpc3N1ZSBieSByZXNldHRpbmcgYWxsIGRlc2NyaXB0b3IgaGVhZGVycyBmb3IgYSBj
aGFubmVsIGluDQo+ID4gcnpfZG1hY190ZXJtaW5hdGVfYWxsKCkgYXMgcnpfZG1hY19sbWRlc2Nf
cmVjeWNsZSgpIHBvaW50cyB0byB0aGUNCj4gPiBwcm9wZXIgZGVzY3JpcHRvciBoZWFkZXIgZmls
bGVkIGJ5IHRoZSByel9kbWFjX3ByZXBhcmVfZGVzY3NfZm9yX3NsYXZlX3NnKCkuDQo+ID4NCj4g
PiBDYzogc3RhYmxlQGtlcm5lbC5vcmcNCj4gPiBGaXhlczogNTAwMGQzNzA0MmE2ICgiZG1hZW5n
aW5lOiBzaDogQWRkIERNQUMgZHJpdmVyIGZvciBSWi9HMkwgU29DIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGUgY29k
ZSBjaGFuZ2UgTEdUTSwgc28NCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2
ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02
OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBl
b3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8NCj4g
am91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhh
dC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

