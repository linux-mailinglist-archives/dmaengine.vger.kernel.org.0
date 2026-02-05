Return-Path: <dmaengine+bounces-8767-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HQVMmjWhGlo5gMAu9opvQ
	(envelope-from <dmaengine+bounces-8767-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 18:42:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C134F6122
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F42223003824
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E512FA0C6;
	Thu,  5 Feb 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KNGklGY2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010041.outbound.protection.outlook.com [52.101.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EF2F362D;
	Thu,  5 Feb 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313314; cv=fail; b=g68MjBy7ZhJNaELS7Y7speDbzoppiMMPBM+t2FXFianmaZ5fjiajOpk9umDNVOJ1qYIMQS/DLtp4AEEwokxkvLU8ASs1G+nyNCjyBA/sOEltANtuj0dW8CnCJaKEvfg8HBRQtFkfhZFOY9Vt1lnz7HlThyxcG5PjfYv8pblUC3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313314; c=relaxed/simple;
	bh=dxjSA06wyMRwEvrw/41Vk3srfTsamMZYmaUUaEQ0nXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NsySHQiIjqejDztizmIHSr7zJiuWyAQ9C5s2XeLHSHDUpnqDiVLoU6ljaR6QiZzzEE6SAhq+6ae4lULds3ED3RvrfUtG63BLtCVFeBpSvzEt/9rW0nfkv5MfafIQQFtv3Iw1Z7GwgUOpeomggzX0HmqVlrfrI+X0RR79AOOj00A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KNGklGY2; arc=fail smtp.client-ip=52.101.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKF+P1Zld/SA5iJNAK09LdsBCJhItMYiAZOJIWsFz9TSrXOkXl9EXle839YBFbRsjB4GcBckXqGdW5F/+/3Hmy1dt3EDRSEvcAlTxCph5WtChAHyu7FLkot8apdSMoKMFna9u75lDLG514edUTjr0OQM64c1ytCR4kGqnARp+CnFtvo71E8W7CCqv1qPPBw2K5XYs/OV19zyBowOAwwCORI//CsEn8rDD9kmAMKmZMicDG783kYW5bW27vfDu28JTtOUYUifPq8uP9FCbFoC9bC+hxe8PZz3LBf8I96aJKwbr5ZqNU0zgSEWz5YLi6SS4pp0PDIH472RDaPczKv4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxjSA06wyMRwEvrw/41Vk3srfTsamMZYmaUUaEQ0nXc=;
 b=CnSkiEs9G1tELHy4yRw+Yi5PjZHRKvZ10f7xRVnG4eAWUYIqiPmp4qSO6TVRc4LCOXEDFrGkoJukwpTBwJCNCjrGNwPKX7KTIEwqBaHXk3ekpwrW4Ht+8WjFDaUeG8cVtQgle0OloU45j6W13pey2whZWcVORcEg30ESUvWUJrowwQbuWj8BJ9aP4Fqa4BsTcI2ixpLhF5kCggx2dtqUr34xYEGpFD7wvActBmauGaVqYgapeT99TxsFa1i8gaU6sMguLR/Fqb5oOfhQxIYgTzMDUcpBfY1jHTh2/KtRg/40SM7vpvgwqKGp9caQGsG33evUaRK26Zm9FFejtFMtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxjSA06wyMRwEvrw/41Vk3srfTsamMZYmaUUaEQ0nXc=;
 b=KNGklGY2rHbAZgXbc/OXdhPvAXfDlix1nEc+vhSK7W/T+cBOb83yv7nW5SLn5n2u9fa7LlgeQvAQQhJ9l2OZOkjanlxOBfKXDpCEFE0/LJxS459rR3IVq0X5J+qhCnDNSEw5zgbKnv0IG+W2cobzxctVVvSZcwR0syO1jiOyURM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13086.jpnprd01.prod.outlook.com (2603:1096:604:32d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 17:41:48 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:41:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, geert <geert@linux-m68k.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Topic: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Index:
 AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcIAACGyAgAAC1MCAAAUUgIAAAEvggAAlpwCAD49ggIAAByHggAACRgCAAAWpgIAAOcKAgAAETGA=
Date: Thu, 5 Feb 2026 17:41:47 +0000
Message-ID:
 <TY3PR01MB113460619AE8C46BC674B28078699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
 <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev>
 <TY3PR01MB113460006A458AB2F8B96542C8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev>
 <TY3PR01MB11346321A9AAE93C7070C6E578699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWUpq1bUbNLu4WGheovQ1pYdEJGBMN3jdb6PZqXanN_GA@mail.gmail.com>
 <TY3PR01MB1134661E4B93CE785700FC5AF8699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <32ea84f2-621a-47d9-a661-9acd62d50662@tuxon.dev>
In-Reply-To: <32ea84f2-621a-47d9-a661-9acd62d50662@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13086:EE_
x-ms-office365-filtering-correlation-id: f583bd53-fe2f-4f7f-10b3-08de64ddd62e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UER4OGhpTkRsSUlmNmRxamVHQ2o1L0xscnJabDVRNkZGYTBQejlQaXBkVEo2?=
 =?utf-8?B?MWxPazRnL0FNd2w2Ynp6T204cHkrT1FMektEWnBaSW5NVnJaK2VLK0lGU1pG?=
 =?utf-8?B?bHpKeURpU2ZIdXl3MDN0bVJFMG5kcjdPZ0JJZUlxUTlIK1NGNGVRbDdTWFJx?=
 =?utf-8?B?SlNDZlBlRGRua05MOVF4YXVNZUhPaHlaNUVHcFB3a2dGMzVZdHdqUENENXRP?=
 =?utf-8?B?bFllTkZnQlJCNFp2NG1ydkdYaEpaaisxbWxnMElDWFdEMCtiS212SjVCempW?=
 =?utf-8?B?ZEpDWGlJOU1PQlFaVGV5eTVKdjkvR3NRQ0lKdU9FNUtCTk5mMWZ4WGVPYVFr?=
 =?utf-8?B?TXBxNVZxdEVhczFjZEI1MXFlL3kvL2h3K2krRi9Ob2R4cUdiMHRPVDFkMkRm?=
 =?utf-8?B?U0JDdDVDMGdXeXUrc0liOVBnY3VLV1A2YXZxYnpvQ3pFTXhqcXB2Wm85TzNC?=
 =?utf-8?B?WEpSZEI4MWoxdlhZSDAwcTFDQklQYmlWR2hYaUVxQ253MG15N3h6ZkhkVDI3?=
 =?utf-8?B?SUduS09oY3N4ckpHZllKQVYvS0E1MTg4ZVRpd3dBZlV5VU1jb3pJY2prOEor?=
 =?utf-8?B?MngzbnFES1JWZ3owUVVGM1FaM3FHdTZsK1Y4cCs3a2lsVWRtZ0NOMXduNkln?=
 =?utf-8?B?QUJvODVqNW5vU2hVbGt3NWRMUEtnM3M3VTVWYThFRXJnUHJZMy9Gb2c4Z21H?=
 =?utf-8?B?Zmhicm5EQzdJTmI3NWJySllIc0NoZlhEQ29MSEZKZjN2eEVSZHc3M1RZMmUv?=
 =?utf-8?B?NFBJL2tiT2ZUQkI2VytseG5GNENicHpFL3gzTlJjWXJwMTc5MWs4aTNDVmNu?=
 =?utf-8?B?WE9ENVpmS0I0a09IZ0JiODNPMGNWRVhKMFJ0eU4wV3BtOXdhVVJpdnJNdHBn?=
 =?utf-8?B?ZDlhNG9JeUpWOUoyZTFNZEo4YWVTY1RVUlZyYkxhTUhQWiswUEZyTHQvVGFy?=
 =?utf-8?B?WUxzdkw3SjFBMUJkMFprMGpQL21RK2JFOGlkT21vQmVpSkdvMlNEdUpWWFMx?=
 =?utf-8?B?VlBWRkQvcEczZEtzV3RXK1hINUVWLzFodXJac3ZmV2orTy9BMjlpeWNUdW9t?=
 =?utf-8?B?SGhiU09FaVhicCsyc3hZbXBiTXc5MmQyNzNJOTJ1ZEVESDV5TVdLNzZDd29i?=
 =?utf-8?B?UFVHRXFOaVZRdGd4NWRLTW05Y2lhR2lPTHhFU3d5dElTWW5DOEk2ZHBacU5H?=
 =?utf-8?B?d0FZS0JxZEdNRmlTU2RVTlFwZFN6a1hydGlra1ZHUDgrM0hEejVXQ0Y4N1Nq?=
 =?utf-8?B?T1NsMzNzSEhmNVFrR3g4RTFsNWp4dDFabkhwbGtjRjY3Y0xjdXVPWTZLaFlV?=
 =?utf-8?B?K0RQb3dkQXZveDZuZ2RFbUpMUjlYdVd0Q3VkdnRBSUJJR3h1MzNPVER6S21Y?=
 =?utf-8?B?LzFBOHQ2MFNtaGVvYUVZbVR6MXpTZzhmT1BlRGxIM09HVFNpTm94UmdNeGlN?=
 =?utf-8?B?SWpKYmQzRktRUTRNMjFGOXJ5SjlVam5pOVZ5SGZ5RXZFdy9OTnVwNVlLczZD?=
 =?utf-8?B?M0RWb0tCOEFqWkRYTDBhcDdqdUdBRE4xM3cybVh2MW5sdG5oblhFNmwwZk1o?=
 =?utf-8?B?WXI4QjVid3lSLzZRVGkrTWdoMHJUL3c0MlFmS1ZhYU9UU1pacFdaMndqTElo?=
 =?utf-8?B?NXFjSGtjSHZSTlpQNXhVekRZOU5BTCs5SjN6U3pKYmVVa2gzSXVKQlZ5Y2lR?=
 =?utf-8?B?aWlPUUhDNzFTZkExd2FEbDRhKzFRejlubWE5cFh3dEZ0WDkxbkJDdEM1N01I?=
 =?utf-8?B?MFZ5aHNXWUhHQTArVmt5TUpGZGpKRHdOc1M1SytBSW5rQkQzc0ljWVBMSGdn?=
 =?utf-8?B?aHRIRERNMFZlKzVKNGJmNnNZSitZTzg1bGZnTEEydVJBVzdITkRJbHE4NVFV?=
 =?utf-8?B?L2FxbkYxcGhWMUVIK1EwUk4xZzhQbVhNTGtCQ1lBc3g1R1RXYkgvNTZqTDha?=
 =?utf-8?B?RU4rNFdXU1FOZktpN2ZINHJsUXNFYllYOXdyb0lNb0d2bGFZRDNYcmhkT255?=
 =?utf-8?B?SVNDenRZbzg3cWpEaUN2THN4M3g3VjJ4MklYZzUxajA3TldGNEZ6ZHFDZ1N1?=
 =?utf-8?B?Vmw3dmRKQ3UrOElyeithTmpKNk5DZllKMGNGa1ZEMUFtaWNXTm9WL3B6Njcr?=
 =?utf-8?B?RUw1OUhweldMb0JRS0UxenE4Y2RyNHBSS0l6eTBZdThaeGNVUUNVNDYyWnNw?=
 =?utf-8?Q?ZFwPOyx+yWQATUT9Nch3XDM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVhGOUxhYkRpaHZoaFBxblVoczlEWkZ6aUpLbXRQa2F3TXQ4M1FDQnl6dStp?=
 =?utf-8?B?Q2lwZDlEODFFK2Q0aU4xbFEwN3JGUllFQXhEWGdHMmVwNnVUWGNpNm16ZXNw?=
 =?utf-8?B?QkRZTFVIUXZyeEFlNFZLdXo4RGhsdCtNaFdxeG5Gc0RJNHFNRUxVbllGUEtE?=
 =?utf-8?B?ekF4blkxTEtJZmpGbm1MKzRZWXAvMlFHckNQd2dUZitJU1hMeTIzT1MvOXEy?=
 =?utf-8?B?c3dMODNOWHkxdlpBYXJzODgzTGRtcG5XS0FKK2tiNWlRdENUb2Zla1ZKeTYx?=
 =?utf-8?B?OEpUZUVEZCtFN05KT1JwOCttVm1NZmpueWlWNWVQcWc0Tm9kQnhVdm94UjBS?=
 =?utf-8?B?Q0Y2bExkWUFKdHpwT0JSb3NDM0tpbVJGQlBqOFRFak41NVN5SHN6eFRVVGFz?=
 =?utf-8?B?aHNPci9KczFvYXRodDVnVVVOaUU1K2xRVzgrV09pRnJURjRHdzl3MFVaMzZv?=
 =?utf-8?B?bFBSUnIrRWx2Uk1ZZXhoZ3BsOFZDUmhEWXJLdEkyWDhkZCtXY2pvOGpIQWlG?=
 =?utf-8?B?MHNWSFdNVVNuNFBzMVdtelVkYUE3aGVTNnBySS9xczNzWDhYbjk5M3VsemVJ?=
 =?utf-8?B?eGZzd0c0U2E4bStrN1RFRmZlOXlnVDgxTERRdG1UeVM3Qkk4U2dVdXdOSlV0?=
 =?utf-8?B?azF4aldOR28vMkJFTXJ5YkpCNUhsZFg3NkVPckZaKzBlTldkWUR2WWlOaW12?=
 =?utf-8?B?T0tpU2dkSm9YYXVSMGpWS3FsNVVrNGhPU1g0UlJlcDh1MWhVVzRUUlRUM1ZV?=
 =?utf-8?B?TXRFSzlVcHBmS1JDSm1BcnAvUmx5R3lrU1A5MTBiYzNWUEdUemhFK3c5TkRU?=
 =?utf-8?B?c0JUR1N5dWFyV05RaFVQRm9QU3FEcVFmdXc5K0VLdUlTbS9wQXViNHdqSy9o?=
 =?utf-8?B?SjFwZUs5VG0yaDlnN3ozV0kwLzc0NFZxT0hVTE1iTVI4b1JYVXVaMkdhcDdB?=
 =?utf-8?B?NFM2RGdVWkgrdVNuYW9JbGJPZGR5TjFaSXc2ZFJOdFFPY09KNnJpWnZVcXVL?=
 =?utf-8?B?TVFvTU5FRVIrdy9WZ3daalJlVEN6aXFHd3Q1ZjYweWlCa081VG1MUTNaS2dI?=
 =?utf-8?B?Ris5a2IyYW1oOFNHR3R5QkQ2VGZlRjR4c09CaG0rbXY1SnNxaWU3dFFlRkVz?=
 =?utf-8?B?ckduS3FKVnBXUnBpdmJlUVd3OWR6RkN3dGRweHhiWXQxUVN6TUJtMmlVVVdz?=
 =?utf-8?B?d0VxTytRNGJnMnRhWkpWbE5jOFI4NDloMjNYelBnd1pSQUtnNXVyakI5ZUJt?=
 =?utf-8?B?cEVHUkh3Mko4RmpHbXE5bGM4T28wTTNsZHROZ1dUd3lhSXMzbWhYZ2hwbUkr?=
 =?utf-8?B?Z3psQlZrc2lPMFVYZUduMjFCLzFVUjVtaTZOMlN6amJKTXhsMjI5Q2svWnRQ?=
 =?utf-8?B?Q1o2THMyN3F1c1hMVzFMWXdYeE8yc3dCL1BENjV0SGQ0UEtlSlJINGQreS8y?=
 =?utf-8?B?TzRGR05sTFdPc2RqSU0veFNPOHVwbU41VzBEdE1nNTM4RERUQjJDcFRCbUtF?=
 =?utf-8?B?Q0lsaEVuUkN1L3ZoTkdTQzltNVc5b29TT0lvVG8zbERCanpKZU1NY1V0RlVo?=
 =?utf-8?B?WVJDRjVLajkrUmJYM3BBS3NuZCs4SWpRUkJXdHNBYnFESURXa0NqNnQrbWYr?=
 =?utf-8?B?U1lVVHJPQlc4U0x1Ujl0YmVHRlJkZ1RKUG5ubmxlMGovNDRQVG5Jb1hiZnIr?=
 =?utf-8?B?ZTIySHMvSWNNMmIyZUgxL29qWW16cXFNeVpVZzdXL0VRSjdrTkVwVHBXQm0y?=
 =?utf-8?B?akgwbm9OSTd2NDVjT3d6V3B0cTNLUmVZaE0vMnJ4bFV5VU5WMGRnZndKZjk1?=
 =?utf-8?B?dlJhKzdmbk11c25SQkNZZmIzWlB5b08xV0Z0RUtiSDR2a1htNkFuTU9TTUtm?=
 =?utf-8?B?RDk0Q2FOY1plTC9DSFpxZWNvdXltUHhoZ25Yb0R3RjgxakZNK1ZnbzF2SDRq?=
 =?utf-8?B?UFh0Z1R4S2J4Y3I4TXlSdzZOYkZBdEFKZ0dWZ3B2RVMwZktPTVJ0cllYVHha?=
 =?utf-8?B?cDA2Y0szSlpqTnI0UVpmekljTC93Wk1tTzE3OFhkc0VBUDh2UDRPOFp5cS9y?=
 =?utf-8?B?ZjVxZzBDdncwaHIreG9DWEF4T2dONEExeWxQK2ZuMHBldEVoUVpKbkgvY2Zz?=
 =?utf-8?B?U2UwRGNFTVB2LzBrN1NKWkVoNUJveFVkeXFnN2lCTW9oeGtOQnh2aS9uZnRz?=
 =?utf-8?B?SkRtRmQ1ZjBHU2xrb3BDZWxWaGNmcVZjVEJkTXdaZitMaVcreUtkNnBlSkFO?=
 =?utf-8?B?VTBIQkZpenNuOGxKUFMrb1hSZnF5YTVGREVDQzJ3d2tPOW5nQkNvek9aRTJD?=
 =?utf-8?B?TGxBRGhDYlhaazNtcVZ6WEFxSzBKZmx0d1VFeWloR3NVdWwwNmkzZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f583bd53-fe2f-4f7f-10b3-08de64ddd62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 17:41:47.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6h5qA3IrITTMKuOjhqr8t3eTyROkCFmg26DPmJ8Jroa07rH6dbFu1TbBhsjTu/5Mlx9xwA8CppdRffEwFQHW668Ahsm9T5TgwTjpsPv6Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8767-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tuxon.dev:email,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 1C134F6122
X-Rspamd-Action: no action

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAwNSBGZWJydWFy
eSAyMDI2IDE3OjIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83XSBkbWFlbmdpbmU6IHNoOiBy
ei1kbWFjOiBBZGQgc3VzcGVuZCB0byBSQU0gc3VwcG9ydA0KPiANCj4gSGksIEJpanUsDQo+IA0K
PiBPbiAyLzUvMjYgMTY6MDYsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhpIEdlZXJ0LA0KPiA+DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4+IFNlbnQ6IDA1IEZlYnJ1YXJ5IDIwMjYg
MTM6MzQNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzddIGRtYWVuZ2luZTogc2g6IHJ6LWRt
YWM6IEFkZCBzdXNwZW5kIHRvIFJBTQ0KPiA+PiBzdXBwb3J0DQo+ID4+DQo+ID4+IEhpIEJpanUs
DQo+ID4+DQo+ID4+IE9uIFRodSwgNSBGZWIgMjAyNiBhdCAxNDozMCwgQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPj4+PiBGcm9tOiBDbGF1ZGl1IEJlem5l
YSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2PiBPbiAxLzI2LzI2IDE3OjI4LA0KPiA+Pj4+IEJp
anUgRGFzIHdyb3RlOg0KPiA+Pj4+Pj4gRm9yIHMyaWRsZSBpc3N1ZSBvbiBSWi9HM0wgaXMgRE1B
IGRldmljZSBpcyBpbiBhc3NlcnRlZCBzdGF0ZSwNCj4gPj4+Pj4+IG5vdCBmb3J3YXJkaW5nIGFu
eSBJUlEgdG8gY3B1IGZvciB3YWtldXAuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gRm9yIFMyUkFNIGlz
c3VlIG9uIFJaL0czTCBpcyBkdXJpbmcgc3VzcGVuZCBoYXJkd2FyZSB0dXJucw0KPiA+Pj4+Pj4g
RE1BQUNMSyBvZmYvIEFzc2VydGVkIHN0YXRlLiBDbG9jayBmcmFtd29yayBpcyBub3QgdHVybmlu
ZyBPbiBETUFBQ0xLIGFzIGl0IGNyaXRpY2FsIGNsay4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBDYW4g
eW91IHBsZWFzZSBjaGVjayB5b3VyIFRGLUEgZm9yIHRoZSBzZWNvbmQgY2FzZT8gRmlyc3QgY2Fz
ZSwNCj4gPj4+Pj4+IFJaL0czUyBtYXkgb2sgZm9yIHJlc2V0IGFzc2VydCBzdGF0ZSwgaXQgY2Fu
IGZvcndhcmQgSVJRcyB0byBDUFUuDQo+ID4+Pj4+DQo+ID4+Pj4+IEp1c3QgdG8gc3VtbWFyaXpl
LCBjdXJyZW50bHkgdGhlcmUgYXJlIDIgZGlmZmVyZW5jZXMgaWRlbnRpZmllZCBiZXR3ZWVuIFJa
L0czUyBhbmQgUlovRzNMOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTb0MgZGlmZmVyZW5jZXMgZm9yIHMy
aWRsZToNCj4gPj4+Pj4NCj4gPj4+Pj4gUlovRzNTOiBDYW4gd2FrZSB0aGUgc3lzdGVtIGlmIHRo
ZSBETUEgZGV2aWNlIGlzIGluIHRoZSBhc3NlcnQNCj4gPj4+Pj4gc3RhdGUNCj4gPj4+Pj4NCj4g
Pj4+Pj4gUlovRzNMOiBDYW5ub3Qgd2FrZSB0aGUgc3lzdGVtIGlmIHRoZSBETUEgZGV2aWNlIGlz
IGluIHRoZSBhc3NlcnQgc3RhdGUuDQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+IFRGLUEgZGlm
ZmVyZW5jZXMgZm9yIHMycmFtOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBSWi9HM1M6IFRGX0EgdHVybnMg
b24gRE1BX0FDTEsgZHVyaW5nIGJvb3QvcmVzdW1lLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBSWi9HM0w6
IFRGX0EgZG9lcyBub3QgaGFuZGxlIERNQV9BQ0xLIGR1cmluZyBib290L3Jlc3VtZS4NCj4gPj4+
Pg0KPiA+Pj4+IEknbSBzZWVpbmcgYXQgWzFdIHlvdSBhcmUgYWRkcmVzc2luZyB0aGVzZSBkaWZm
ZXJlbmNlcyBpbiB0aGUNCj4gPj4+PiBjbG9jay9yZXNldCBkcml2ZXJzLiBXaXRoIHRoYXQsIGFy
ZSB5b3Ugc3RpbGwgY29uc2lkZXJpbmcgdGhpcyBwYXRjaCBpcyBicmVha2luZyB5b3VyIHN5c3Rl
bT8NCj4gPj4+DQo+ID4+PiBTdGlsbCwgdGhpbmtpbmcgd2hldGhlciB0byBhZGQgY3JpdGljYWwg
cmVzZXQgb3IgZ28gd2l0aCBTb0MgcXVpcmsgaW4gRE1BIGRyaXZlci4NCj4gPj4+IFNvbWUgU29D
cyBuZWVkIERNQSBzaG91bGQgYmUgZGVhc3NlcnRlZCBsaWtlIGNyaXRpY2FsIGNsb2NrIHRoYXQg
Y2FuDQo+ID4+PiBiZSBoYW5kbGVkIGVpdGhlcg0KPiA+Pj4NCj4gPj4+IDEpIEFkZCBhIHNpbXBs
ZSBTb0MgcXVpcmsgaW4gRE1BIGRyaXZlcg0KPiA+Pj4NCj4gPj4+IE9yDQo+ID4+Pg0KPiA+Pj4g
MikgSW1wbGVtZW50IGNyaXRpY2FsIHJlc2V0IGluIFNvQyBzcGVjaWZpYyBjbG9jayBkcml2ZXIg
YW5kIGNoZWNrIGZvciBhbGwgcmVzZXRzLg0KPiA+Pj4NCj4gPj4+IElzIHNpbXBsZSBTb0MgcXVp
cmsgaW4gRE1BIGRyaXZlciwgc29tZXRoaW5nIGNhbiBiZSBkb25lIGZvciBSWi9HMkwgZmFtaWx5
IFNvQ3M/DQo+ID4+DQo+ID4+IFdoYXQgaWYgdGhlIERNQSBkcml2ZXIgaXMgbm90IGVuYWJsZWQ/
DQo+ID4NCj4gPiBUaGUgYmVsb3cgdXNlIGNhc2VzIHdpbGwgd29yayAocGF0Y2hbMV0gLSByZW1v
dmluZyB0aGUgY29kZSBmb3INCj4gPiBkZWFzc2VydCBpbiBjcGdfcmVzdW1lKSBhcyB0aGVyZSBp
cyBubyBETUEgZHJpdmVyIHRvIGFzc2VydCB0aGUgcmVzZXQuDQo+ID4NCj4gPiAxKSBzeXN0ZW0g
d2lsbCBib290IHdpdGhvdXQgRE1BIGRyaXZlcg0KPiA+IDIpIHMyaWRsZSB3aWxsIHdvcmsgYXMg
dGhlcmUgaXMgbm8gRE1BIGRyaXZlciB0byBhc3NlcnQgdGhlIHJlc2V0Lg0KPiA+IDMpIHMycmFt
IHdpbGwgd29yayB3aXRob3V0IERNQSBkcml2ZXIuDQo+ID4NCj4gPiBJZiBETUEgZHJpdmVyIGlz
IGVuYWJsZWQsIHRoZW4gdGhlcmUgaXMgYW4gaXNzdWUgd2l0aCAgczJpZGxlIGFzIERNQQ0KPiA+
IGRyaXZlciBhc3NlcnQgdGhlIHJlc2V0IGFuZCB3ZSBjYW5ub3QgdXNlIHNlcmlhbCBjb25zb2xl
IGFzIHdha2V1cA0KPiA+IHNvdXJjZQ0KPiANCj4gSSB0aGluayB3ZSdyZSB0YWtpbmcgaGVyZSBh
Ym91dCBib3RoIERNQSBjbG9ja3MgYW5kIHJlc2V0cy4NCj4gDQo+IFdoYXQgaWYgdGhlIERNQSBj
bG9ja3MgYXJlIGRlY2xhcmVkIGNyaXRpY2FsIGluIExpbnV4IGFuZCBjbG9ja3MgYW5kIHJlc2V0
cyBhcmUgbm90IGhhbmRsZWQgYnkNCj4gYm9vdGxvYWRlciBpbiBwcm9iZSBvciByZXN1bWU/IFdo
byB3aWxsIHJlc3RvcmUgY3JpdGljYWwgY2xvY2tzPw0KDQpQYXRjaCBbMV0gd2lsbCByZXN0b3Jl
IGNyaXRpY2FsIGNsb2Nrcy4NCj4gDQo+ID4NCj4gPiBPbmUgc29sdXRpb24gaXMgU29DIHF1aXJr
IHdpbGwgcHJldmVudCBhc3NlcnQvZGVhc3NlcnQgIG9mIHRoZSBETUENCj4gPiByZXNldCBkdXJp
bmcNCj4gPiBzdXNwZW5kL3Jlc3VtZSgpIGZvciBhZmZlY3RlZCBTb0NzLg0KPiANCj4gVGhpcyBj
YW4ndCB3b3JrIHcvbyB0YWtpbmcgY2FyZSBvZiB0aGUgRE1BIGNsb2NrcyBpbiB0aGUgY2xvY2sg
ZHJpdmVyIHJlc3VtZSBmdW5jdGlvbiAoaW4gY2FzZSBETUENCj4gY2xvY2tzIGFyZSBjcml0aWNh
bCkuIElmIHNvLCB3aHkgaGFuZGxpbmcgRE1BIGNsb2NrcyBhbmQgcmVzZXRzIGRpZmZlcmVudGx5
Pw0KDQoNCldoYXQgd2lsbCB5b3UgcHJlZmVyIA0KDQphIHNpbmdsZSBjaGVjayBpbiBzdXNwZW5k
L3Jlc3VtZSBvZiBETUEgZHJpdmVyPw0KDQpPcg0KDQpBcm91bmQgMTAwIGNoZWNrcyBpbiBzdXNw
ZW5kL3Jlc3VtZSBpbiBjbG9jayBkcml2ZXIgZm9yIGNoZWNraW5nIGNyaXRpY2FsIHJlc2V0cyBm
b3Igc2tpcHBpbmcgRE1BIHJlc2V0Pw0KDQpDaGVlcnMsDQpCaWp1DQo=

