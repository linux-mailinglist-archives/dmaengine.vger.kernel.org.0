Return-Path: <dmaengine+bounces-4641-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC77A4E298
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 16:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A094819C40F0
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C2209686;
	Tue,  4 Mar 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="n/Vpt6Ni"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010032.outbound.protection.outlook.com [52.101.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2022204F6E;
	Tue,  4 Mar 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100553; cv=fail; b=U+zgbzIziDYPoB5njHsiKNEW8qMiNQuYDuAhD3ZfKCEvSjfQq9Jrc+3Sw36EnIgBZOb2QYYTdFeeOnRhIEXF9wyT0Q+UQ7xqv2PGJgOh9D+sTF38cX4WAYy3xXSrSOonvnWEKZEtTUwgaD3VaqPCmPHP/kSsoglnime27LCREJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100553; c=relaxed/simple;
	bh=yWRUNWoAdg3FOVHKHj1zzoU6ffbxEBsQwZgFrseI76Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QpQ/O/BYcW4Aa749T1AKBDOZ0wRp3zykfhb8G7q9E3QCrfnBezEcnK5AK8dxRmfEpyLV6uOYxVNtiebGt5fu0R0XtE5JfWPOz6cctYXD2TdJiOqLXLU0K7LlxgW4+dErq8KOa3PYgZgK6GOszmB1+dfldeLHn/7SPsvA0uLRDIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=n/Vpt6Ni; arc=fail smtp.client-ip=52.101.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNEJ/vAJUkqyHZHJmzXkIDA8NQJIp8okkZJs5NXAZimlJRRzZm/Pv2DY/sR8xaeYPWjW8T4iQ52GqhaKScb+z+QopAvJZh3+wjH05y6herL7YqZhlQoKKRxA3fr439ElFqzojLxB533QC2pSvoH+nrA2g3UC7K9AtIRdepq7wrUoIZ4st/3pLo9wmjcE+89dzL/OG3om8vRnOLCzPpOSCaTM5I1kSkHbEJfLdYMnFPCitEA1IAiOzTp4inWkB5OMWJZrhmhVwTFpawFQBxkFzuRNhyWaW8795dkmt0SKQscALP+R6Y2dNmfIANMEyZVlY/iYDf8apO+8wg5kv6LmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jQHDzk+G0/tzSn+7hF9LnJ5kieoOuKyUS3qhSR+xEM=;
 b=rfvniWmlXcSR7y3Px53j/2Xar/iYAiUm7BvubU7Aw27sZt/edaFeVOWn5V4ZkZfDO05Jgfik/4I8yKaLC66DZTjEvWn629WTcEd+1T1K68fuTidkto4XcOi2+eUdZsyDwmcOz6MyvWOXLbnNcCPCj1cNCi6Ljkgv1vH2BIDER+pLh4YzB3lcDo0W7HhX47W1+zI6sicruxfIqDwTvvCvMAaw1F4qRCCVPqtMMM1gstYLdTE87SjDW5Kk1Tyt93xKX1YIUr0D8R2LO8RJ/Q8a0Lf86obmMKlBLwdAjlrAlQcIXt8k5nvopwDq5RiumserxZw6KDwCOe9E8lpp49d62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jQHDzk+G0/tzSn+7hF9LnJ5kieoOuKyUS3qhSR+xEM=;
 b=n/Vpt6NiyzmCV/SBa9/gsSwTBDbR8kBjktA5QW4+SWEDeNi5ZpZN2KdIJX9OnouEo/0ePQUE5E7I3H+6Qf2op2/35N7uEr/4+F+Bqf/IMm1aDzij9yG22nFrh/iD6zsziJTXzEJA6Ec9iBvDLzDMMNj8k+iwsOJqk06mVreSo7o=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TYWPR01MB10225.jpnprd01.prod.outlook.com (2603:1096:400:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:02:26 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:02:26 +0000
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
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index:
 AQHbg6hTr6k5RmdmC0qfs3vIpDif/7NWbDgAgAUL6qCAARRzAIAAS6IwgAAH6wCAAAMrgIAACCMAgAAA8CCAAAw0AIAAA3QAgAYmUoA=
Date: Tue, 4 Mar 2025 15:02:26 +0000
Message-ID:
 <TYCPR01MB120933B8FABA915239FFC536DC2C82@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
 <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
 <TYCPR01MB12093BE16360C82F9CB853AF4C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdXkgK-EdGhyrE6PRzskRXkJ8u+xQ=c5x1-=couedtcmqw@mail.gmail.com>
 <TYCPR01MB120935A45DD8D9E414D869453C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdXaQ727Z9iTtZQ-jXfKV7=CN9Kootc8xtgqKazxP2XmAw@mail.gmail.com>
 <TYCPR01MB1209315DF46290CF62805F7B1C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1209315DF46290CF62805F7B1C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TYWPR01MB10225:EE_
x-ms-office365-filtering-correlation-id: c135a0f0-1347-41e2-d69a-08dd5b2d938e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6Jd5zCXI3GQQhr4+5SJeve/Uzvip1ts7pV/0wH6O2xXkaClXS0U96Lu4ZuF1?=
 =?us-ascii?Q?PwlW1aEIZ93j7xOmJs4vxl9yCG5BgbgW8zYoByN/rR4E8onWUVUw7qohslKV?=
 =?us-ascii?Q?+AAzorOPHQ2bVBubCIuPS9c9z2c6JbCysOdS5zdO+ovjm4noo4AhkUhOMtCd?=
 =?us-ascii?Q?uFvnxvitQHp6EtbPdk2ZJE7wpwGBUtiIFW+O7LiI/0rCddZfmwy+yTeE/X16?=
 =?us-ascii?Q?wiRhrJ6+a/e7MHpuoNTIJj9Q/1FhqgAcJpLP06Ql/fTMfF3wFbfumvIafDLM?=
 =?us-ascii?Q?IL1fSZCNFECXPJ+c7f0Kz2rR+X7sUy2klzE9fyuEg3z4MXH2MWVu3/wIdPU6?=
 =?us-ascii?Q?gVU8hkaF8s7nzCPubzuOauffi+MGsY4vTe2v/5A3WQqYmFn5z8gNjBcOjTIT?=
 =?us-ascii?Q?QNlqKG8AbDMPwaSCKA66TlywAFNpalFJV421lWC5KvDnp5UKIXXpbPZ1WFTl?=
 =?us-ascii?Q?YyOFkUpKT6FXNQVjI3/x8xC9DSU1QlyNTWyWytNNtZI2dr3rwSwJHUgXphZ2?=
 =?us-ascii?Q?S3YpalqaLPbHAr7ILsxp3O4y/hF/DsCtQ7EOiK9EWScjerUO4abHdcDwTzXH?=
 =?us-ascii?Q?p7eKvYCBXwdc5LQROg8bG9JMUEfLw23U4o1mcHPmHHJ1YjIshRO0/xcGcXz3?=
 =?us-ascii?Q?5V5Ji4o/MQ3HXyDG00v0KItm4LkoqxX9YTy3gAj4I+blx1U6o6tzXv0pJzg9?=
 =?us-ascii?Q?NKaRiGA48gpKKaACKANCAIWfrMMbV11wvLZ0pOvtb7cgoxwhXzPp8yKaA9M/?=
 =?us-ascii?Q?HnzziCwOL6t2TP+kbtjtWxqEnDMT2sTsMxc9bX4thw3Ejq6act3BjQYlQoPs?=
 =?us-ascii?Q?8S1QJs9UErBSRCEC33xeA2vpRHUiSyAink87TLGiDguiWXGWybCkTOqSlNJC?=
 =?us-ascii?Q?9HUXWSLM7ZW5Fnlr5yFQUThRcfd6rxD387tvszX0zphr3E3DuqRONfMQbHCw?=
 =?us-ascii?Q?DwzAX0v8ExdMhW8PtYflviIwcfmDpA5KCkVZIxmmw7HpcVs5SzV6d8h97i4M?=
 =?us-ascii?Q?vdaR9RPX9zfl9kEr/uDgC/G7p1kKCufdK46IizXm/lmCRxxzkj3EPvH+h5EV?=
 =?us-ascii?Q?9Smd00e3ycPSbR2SAIP4vwiJ2MYXBqJ3AnI2kNnpVy7h5feNtPJVIW88iyDq?=
 =?us-ascii?Q?5ugVQeq9pSL31aB5rcdkKfZhs2luneUPbRy83iV5PSDSCchw2dVdkvB2llWs?=
 =?us-ascii?Q?KPtKHXvHk0yAxNUjXYt70DAMJ4h6S/kdm8ONycHb8V+teKVD6xO4DU40TnAZ?=
 =?us-ascii?Q?T82hOxHkvFuHVSDRN8ms4Jcm92/wjc9dTK1SjvIRMVnI7pio5XGMwrUHGJXg?=
 =?us-ascii?Q?xAxgLnEfhIUAByJN9P3OpJshaE6GIJRi5YwxUIICkzBipuo3RWKz2hZWUwX3?=
 =?us-ascii?Q?4zQ/v7mr/juBRvk1zl1cvvLFsF5CY4WC/Qal+OMaHPBDiica0Ym0bnIuBg+6?=
 =?us-ascii?Q?0Kskk8/a81Pw4AUvrwKTJfI6IOnyIQbb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1elPl3No0r36oESSQR4IwPqwip0E+LaCB0+Nv9rvnERK7bEbIDn6SLJkB1mn?=
 =?us-ascii?Q?8hjI4ETvQmpoeVHuVztI6hEHhvruKriwaBpMRdEtoN7cT5V35NQDbh21Vycw?=
 =?us-ascii?Q?fYh2ZU1fYY7uenn3kM3X5DdhiBilR1Tyjq5c9X5Q/7XK0I9Lmbeho2vTaqVV?=
 =?us-ascii?Q?Pr4GhCWFOSM6pa89NGCPdebObnvYEBdffAkaWKPlBOS8C8uV+KprujtXs951?=
 =?us-ascii?Q?XjxOZa/fxw4vvBAhK4MlvYA8FlBpZh/aJPUNuQ+bVDUvGkZBeCXRMMG2nRJl?=
 =?us-ascii?Q?r/Y2NZ4kYzByEikpp9EsNJoH5SPaso/wIeJ5W3eCuq1lv3faaTwkZH7Kge/K?=
 =?us-ascii?Q?2lkCX6QZP6DH8CJQ4NOAeHaxKgMlI9u6aWrwPbejCcHWpBxjiSArfgCgsbxP?=
 =?us-ascii?Q?fUcO7p0FDZ3hkm5liRYe25gBx9WJRPk+H8dUDvi6cY6tj8+SvF3uM5DR6HwZ?=
 =?us-ascii?Q?Ufd/GW0yJrwacR8pcf4lo21mQiTSXRme9UoUNPuMt9Qt0/SW90AK1x6qcKv1?=
 =?us-ascii?Q?nIXNJv86KjO7M5ywLOhH0CnkQjFNnOjVtMfi36XZMgqt8fUosLH1PGf10fCY?=
 =?us-ascii?Q?rRPr14D70NXTVaBDRfQmOmNsAOjxsv7GkwR4ZFa/jkxwnsVkUoxa7osj5aDH?=
 =?us-ascii?Q?MB+lhwyiOyhloKzvKXVOdjeaczYvFDVKwqwV4FBMMAv3VSRtchUd7GX5LkJr?=
 =?us-ascii?Q?HAo/fqwBwEvJjueTWhXf48XiCSQ8+iQ1Au7tNS4l84ACH9QZBMKDmi4puqE9?=
 =?us-ascii?Q?s33N8m/NPSdTfcAz4+9DzZvuGJs3nWOo+77b5/UGhojEOGin9fgp3wPfepzB?=
 =?us-ascii?Q?9Q8NgYJCItFkahkJIS40uhwf97vMmQgSBXD8PsugTvOzqKXjKIe9HkQvxft8?=
 =?us-ascii?Q?B7oM73ys+Ej4yST9uqbjPR+KyhbavA4sB3QtFy87vRfvT4c6XsNaPIKwW97K?=
 =?us-ascii?Q?ihTj6XujNc6WpY1cBKT73buceHP/2h9aKa1sM04hpbUjA4f2CfHLYrYW8Zpd?=
 =?us-ascii?Q?Vg6NBIrtDJ7JeqbT28F4r/Hhkm18g3Y0QWV1kxNM5KZ7H7fQJw8lZSiRZj3d?=
 =?us-ascii?Q?5wPiizTpHCYGcWPI1RCAr/Bzqn9rOWoyoiM2y46XVAgMXjmjbAJWqnDAmqzo?=
 =?us-ascii?Q?rzZz+LvFGzCYBapc06UdlpX+chvfysAmF43j5drICuMJ3Jsv5cVlzAEk5wro?=
 =?us-ascii?Q?SuwrlB4F8kfirzT3d+KNFN5GNAkCbozXt5S14t+gD1AD/kAveMNGWjk9quQb?=
 =?us-ascii?Q?eTO34lYj02/UaHGRu8LvRUp3IQtthbu3YxfTbXs9tw1hbwTM25+QihUnJ5Cu?=
 =?us-ascii?Q?A8Ip3JE81RT5xNd8nGh+TjcctoxWy54W0F1Z5Js+y/wSAZ+/56Fw1K++DaIG?=
 =?us-ascii?Q?wrPa+RPAyxVtNQnSmJ7c6rxdaYqxaeoWWskDz00AMjUDFDD4/lo7Plbl++cq?=
 =?us-ascii?Q?BpBZupVzNv57Pwsy079ZXM1YSkFxqzqtqiUS+3pVEEyIP8/cepMFBVbZ9Dpm?=
 =?us-ascii?Q?ZQja2bzI/x4ZGDxxxy2eMK3RZ8QBOrUkSDAUNk3sdjIPo++79T9JQ5Iwsc6x?=
 =?us-ascii?Q?UrDm10yPNYoMrgJ+cpWAC+4JsWjfzGSMSj2uIHR6K0/Osb2KNvHBISizBkcv?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c135a0f0-1347-41e2-d69a-08dd5b2d938e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 15:02:26.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwHZfd0qsFNyykjU0WQ22ftgi5KrIBfrFn/kOS8LoG1xM8IS73ViIJpD5EhIIKss4hOLz4af1ZrVHgJnK5JookbL875DiPzpC0DY33nyVoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10225

Hi Geert,

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 28 February 2025 17:29
> Subject: RE: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)=
 family of SoCs
>=20
> Hi Geert,
>=20
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 28 February 2025 16:44
> > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(=
P) family of SoCs
> >
> > Hi Fabrizio,
> >
> > On Fri, 28 Feb 2025 at 17:32, Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > On Fri, 28 Feb 2025 at 16:38, Fabrizio Castro
> > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > On Fri, 28 Feb 2025 at 15:55, Fabrizio Castro
> > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
> > > > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > > Sent: 24 February 2025 12:44
> > > > > > > > > > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: =
Document RZ/V2H(P) family of
> > SoCs
> > > > > > > > > >
> > > > > > > > > > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > > > > > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > > > > Document the Renesas RZ/V2H(P) family of SoCs DMAC bl=
ock.
> > > > > > > > > > > The Renesas RZ/V2H(P) DMAC is very similar to the one=
 found on the
> > > > > > > > > > > Renesas RZ/G2L family of SoCs, but there are some dif=
ferences:
> > > > > > > > > > > * It only uses one register area
> > > > > > > > > > > * It only uses one clock
> > > > > > > > > > > * It only uses one reset
> > > > > > > > > > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > > > > > > > > > * It is connected to the Interrupt Control Unit (ICU)
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@re=
nesas.com>
> > > > > > > > > >
> > > > > > > > > > > v1->v2:
> > > > > > > > > > > * Removed RZ/V2H DMAC example.
> > > > > > > > > > > * Improved the readability of the `if` statement.
> > > > > > > > > >
> > > > > > > > > > Thanks for the update!
> > > > > > > > > >
> > > > > > > > > > > --- a/Documentation/devicetree/bindings/dma/renesas,r=
z-dmac.yaml
> > > > > > > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,r=
z-dmac.yaml
> > > > > > > > > > > @@ -61,14 +66,22 @@ properties:
> > > > > > > > > > >    '#dma-cells':
> > > > > > > > > > >      const: 1
> > > > > > > > > > >      description:
> > > > > > > > > > > -      The cell specifies the encoded MID/RID values =
of the DMAC port
> > > > > > > > > > > -      connected to the DMA client and the slave chan=
nel configuration
> > > > > > > > > > > -      parameters.
> > > > > > > > > > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2=
L, and RZ/G3S SoCs, the cell
> > > > > > > > > > > +      specifies the encoded MID/RID values of the DM=
AC port connected to the
> > > > > > > > > > > +      DMA client and the slave channel configuration=
 parameters.
> > > > > > > > > > >        bits[0:9] - Specifies MID/RID value
> > > > > > > > > > >        bit[10] - Specifies DMA request high enable (H=
IEN)
> > > > > > > > > > >        bit[11] - Specifies DMA request detection type=
 (LVL)
> > > > > > > > > > >        bits[12:14] - Specifies DMAACK output mode (AM=
)
> > > > > > > > > > >        bit[15] - Specifies Transfer Mode (TM)
> > > > > > > > > > > +      For the RZ/V2H(P) SoC the cell specifies the R=
EQ NO, the ACK NO, and the
> > > > > > > > > > > +      slave channel configuration parameters.
> > > > > > > > > > > +      bits[0:9] - Specifies the REQ NO
> > > > > > > > > >
> > > > > > > > > > So REQ_NO is the new name for MID/RID.
> > > > > > > >
> > > > > > > > These are documented in Table 4.7-22 ("DMA Transfer Request=
 Detection
> > > > > > > > Operation Setting Table").
> > > > > > >
> > > > > > > REQ_NO is documented in both Table 4.7-22 and in Table 4.6-23=
 (column `DMAC No.`).
> > > > > >
> > > > > > Indeed. But not for all of them. E.g. RSPI is missing, IIC is p=
resent.
> > > > >
> > > > > I can see the RSPI related `REQ No.` in the version of the manual=
 I am using,
> > > > > although one must be very careful to look at the right entry in t=
he table,
> > > > > as the table is quite big, and the entries are ordered by `SPI No=
.`.
> > > > >
> > > > > For some devices, the SPI numbers are not contiguous therefore th=
e device specific
> > > > > bits may end up scattered.
> > > > > For example, for `Name` `RSPI_CH0_sp_rxintpls_n` (mind that the `=
pls_n` substring
> > > > > is on a new line in the table) you can see from Table 4.6-23 that
> > > > > its `DMAC No.` is 140 (as you said, in decimal...).
> > > >
> > > > Thanks, I had missed it because the RSPI interrupts are spread acro=
ss
> > > > two places...
> > > >
> > > > > > And the numbers are shown in decimal instead of in hex ;-)
> > > > > >
> > > > > > > > > It's certainly similar. I would say that REQ_NO + ACK_NO =
is the new MID_RID.
> > > > > > > > >
> > > > > > > > > > > +      bits[10:16] - Specifies the ACK NO
> > > > > > > > > >
> > > > > > > > > > This is a new field.
> > > > > > > > > > However, it is not clear to me which value to specify h=
ere, and if this
> > > > > > > > > > is a hardware property at all, and thus needs to be spe=
cified in DT?
> > > > > > > > >
> > > > > > > > > It is a HW property. The value to set can be found in Tab=
le 4.6-27 from
> > > > > > > > > the HW User Manual, column "Ack No".
> > > > > > > >
> > > > > > > > Thanks, but that table only shows values for SPDIF, SCU, SS=
IU and PFC
> > > > > > > > (for external DMA requests).  The most familiar DMA clients=
 listed
> > > > > > > > in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0=
x8D, but
> > > > > > > > which values does it need for ACK_NO?
> > > > > > >
> > > > > > > Only a handful of devices need it. For every other device (an=
d use case) only the
> > > > > > > default value is needed.
> > > > > >
> > > > > > The default value is RZV2H_ICU_DMAC_ACK_NO_DEFAULT =3D 0x7f?
> > > >
> > > > If you take this out, how to distinguish between ACK_NO =3D 0 and
> > > > the default?
> > >
> > > I am not sure I understand what you mean, so my answer here may be co=
mpletely off.
> > >
> > > ACK No. 0 corresponds to SPDIF, CH0, TX, while ACK No. 0x7F is not va=
lid.
> >
> > OK, that was my understanding, too.
> >
> > > My understanding of this is that there is a DACK_SEL field per ACK No=
 (23 ICU_DMACKSELk
> > > registers, 4 DACK_SEL fields per ICU_DMACKSELk registers -> 23 * 4 =
=3D 92 DACK_SEL fields),
> > > to match the 92 ACK numbers listed in Table 4.6-27.
> > >
> > > Each DACK_SEL field should contain the global channel index (5 DMACs,=
 16 channels per DMAC
> > > -> 5 * 16 =3D 80 channels in total) associated to the ACK No.
> > > If DACK_SEL contains a valid channel number (0-79), then the correspo=
nding signal
> > > gets controlled accordingly, otherwise a fixed output is generated in=
stead.
> > >
> > > Mind that the code I sent wasn't dealing with it properly, but wasn't=
 spotted due
> > > to limited testing capabilities, and it's safe to take out, as the DA=
CK_SEL fields
> > > will all contain invalid channel numbers by default.
> > >
> > > Looking ahead, there is a similar scenario with the TEND signals as w=
ell.
> > >
> > > So for now the plan is to upstream support for memory/memory and devi=
ce/memory (REQ No.,
> > > tested with RSPI), add support for ACK No later (perhaps testing it w=
ith audio, or via
> > > an external device), and finally TEND No if we get to it.
> >
> > So which values will you put in the dmas property for RSPI?
> > I assume:
> >        bits[0:9] - Specifies REQ_NO value
> >        bit[10] - Specifies DMA request high enable (HIEN)
> >        bit[11] - Specifies DMA request detection type (LVL)
> >        bits[12:14] - Specifies DMAACK output mode (AM)
> >        bit[15] - Specifies Transfer Mode (TM)

I will switch to this layout for the next version.

> > i.e. all remaining bits will be zero?
>=20
> I see what you mean now. And there would be an ABI mismatch between older=
 DTs and newer kernels,
> newer kernels would interpret the values incorrectly (as you said, 0 is a=
 valid number).
>=20
> >
> > How do you plan to handle adding ACK_NO bits later?
> > I.e. how to distinguish between remaining bits zero and remaining
> > bits containing a valid ACK_NO value (which can be zero, for SPDIF)?
>=20
> We could add the ACK No. and the TEND No. to the binding (after TM), and =
implement it
> later in the driver (once we have some practical use case for them)?
>=20
> There are also a couple of alternatives:
> * we could add 1 to ACK No. and TEND No.? At that point 0 would be an inv=
alid number?
>   In which case we could add DT and driver support later?
> * we could fill up the remaining bits with 1s? We only have 5 TEND number=
s, so 0b111 would
>   be invalid. Similarly, we have 92 ACK numbers, so 0b1111111 would also =
be invalid. Also
>   this shouldn't break the ABIs once we get around to add the rest?

Considering that `ACK No.` and `TEND No`. are uniquely paired to `REQ No.`,=
 I think we can
omit them from the DT, and just look them up from a table in the correspond=
ing driver, and
we should be good to go.

Thanks!

Fab

>=20
> >
> > I hope I made myself clear this time.
>=20
> Very clear! Thank you.
>=20
> > If not, weekend time ;-)
> >
> > Have a nice weekend!
>=20
> Thank you, and you!
>=20
> Cheers,
> Fab
>=20
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds


