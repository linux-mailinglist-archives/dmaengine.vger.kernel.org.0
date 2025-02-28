Return-Path: <dmaengine+bounces-4613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B90A4A062
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589033B5FE8
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EF1F09AD;
	Fri, 28 Feb 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZYM3xYK2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010036.outbound.protection.outlook.com [52.101.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D83597A;
	Fri, 28 Feb 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763730; cv=fail; b=qftjSR1HbFLtAhrNAWTP+Yx1GBf2UODEnCB9SYRvED77IzJ8CRnrJuUApsVStQp2S4/a4CltMi6RcZrXCznDMf6vMIn7NS4qmGIr/o0oFNYtZW2cjI+9RaStEzlyToPwxnJo1u376kkTVRngfajj53MyciVZ0+gDBf5Vgo6hmiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763730; c=relaxed/simple;
	bh=pPCEMgJqfkCJhBJuCOnIsNW6jUfC2+59yDKt8fwCsTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PwaxnjHvk00gHDB1nMjx5RLdf500t0esMfZhIF3tpNCyt9MuFw1u2lvA65/niaeET98Ld+71y99h/D1WvsKV0BsqDSd2YSOJoJqKmv/x6vIbEcEyasp6hAXKM29s0gjr59MYeG2aZd2CTIFBD+UHkp5/nvn60WcJDV31taxrB7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZYM3xYK2; arc=fail smtp.client-ip=52.101.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1OUowE30ijPslCP2bfnyVdX4oemmdFBEnaGQ0k9dH5Fe8H0pag77yiEXqKgyqjJQ2SgXZa0D8dOQ7OiyrTvbDtHrkZ/GIjY88cMnAJoLmt4kUle0RsQMdEsYoH/ptBJZJjpm1Jeps7fJOGQPKUp5DeZIKC8r1DsqdJNTZbuJWxDe93KHBocT9kOhJgAFNO4aZsGzE1mkKVsbpyNWjPH+nJpe292vDv+KlFsWPK8l6rFSRLMc0PgiuzdAL5p2mojeaWQ56IpyIoPZOojTHd3Dwu9aCngA6wrniCraXX45jaCqfPPyR1Io6YGgaj8qkG5P8OtN9UhCrfYR2j1drF3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGcpAXJLGqLz6yWsQ5QDG70bg7VvcBoqqm1d0eM//bk=;
 b=uIv2KLJ82GRVjOEPyZC7xxvWNJGdGMKj0nkSlOND8+qucC0Q67xytTwF46tCJzSDTSWCattufZ2UnIApzHGcVe0Ved7FDbSNKngsFgjso5wOwcLjXuVIPtiiQ4xlPsyb4o4ChammUUoJNq8GrYaeMdzTCj6UwZvaAM1cWNcR/KYve7C6M891LFkA/mPtzhio3A/7MgJw/5gwLPKjZvyB3mbzP68SHitDhUfLkwZ6oyXma/2+mHVa9hsYJNXuuyAF8yHlIOolAqz9lIiiPPz/3ntzsp8+MKtlw826CPnIQxhJAWqYRFQupoX/5sJZIU+G6tqzbcOI8fKCW5vfTXN+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGcpAXJLGqLz6yWsQ5QDG70bg7VvcBoqqm1d0eM//bk=;
 b=ZYM3xYK2hUlSS1eU8su1w6dIO5/HAl6hQAibqT8apNU8Sqa4m6z/XzFeiB+nphoS/76/0rrYGGI6/RIPIB65VdDYudmvn/Zd2dQnfEpk2wdHQU0HMscWBfqZ88M/xVMR2mCjjK14ML6Q1tEv2tWEgPW01JzjIWiT4VXc5FF3v0Y=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TYYPR01MB8095.jpnprd01.prod.outlook.com (2603:1096:400:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:28:44 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:28:44 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
 AQHbg6hTr6k5RmdmC0qfs3vIpDif/7NWbDgAgAUL6qCAARRzAIAAS6IwgAAH6wCAAAMrgIAACCMAgAAA8CCAAAw0AIAAA3QA
Date: Fri, 28 Feb 2025 17:28:44 +0000
Message-ID:
 <TYCPR01MB1209315DF46290CF62805F7B1C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
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
In-Reply-To:
 <CAMuHMdXaQ727Z9iTtZQ-jXfKV7=CN9Kootc8xtgqKazxP2XmAw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TYYPR01MB8095:EE_
x-ms-office365-filtering-correlation-id: cb9f01a7-27a7-4b6e-7b85-08dd581d59da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8fKXebf+sWmKMoBN3WsHz27Jq+3TT1tMbR4tseCcqkogtI9VaP7ILVfMn6Kw?=
 =?us-ascii?Q?P/q9450jn2FtOv3E9X7WvNddQ89SF48f9W6lClUGCdpTeK3d89kFOzExYhSN?=
 =?us-ascii?Q?Vvt6Yr+tC6NY5jm8jv2qv0oZ1bR9xGnkDWQC7ucbTkpfCFcBqQdDL+d5SJ6Q?=
 =?us-ascii?Q?E/9Rhl6p/bGUuVYwc0YEx9wmTTBItmrS7OnVRqiOkoDuObFliq16TDwAAIY3?=
 =?us-ascii?Q?cqyzwtlnqC7j7sf1oyyF3JvKVJL+KFEHYnDml0eIZtiqNAxsG9sd1u7vC7tE?=
 =?us-ascii?Q?ClK8ZjvDsnGdNL0SgAHAr5LzAATZbAoJXqGEIFO3TOoEoB05WDuDv5DWxByO?=
 =?us-ascii?Q?y8DbCGP95r0iDl9uRlKHiC6b4QcV2PWDWEAEnuAuyU8QGeY1TEnhziQhGmEh?=
 =?us-ascii?Q?iDJJQJQ3hYDLwEgueLv7Gh0WV9YpunIC+FKt1UhztcuGQKuxVKWJJaBSEbto?=
 =?us-ascii?Q?2mb5FZheyQ/lf8dWz79cKteEAZOpoePjW3qrIcE4lzl5wJhO9O8JYVltyxS+?=
 =?us-ascii?Q?H5bOdfk/dek/HGCF/UPhm6hug4Sn4y+dTVnZ7dRJQZgicxwBiMYpqFWdVMlY?=
 =?us-ascii?Q?4wc6/Z+aIaILqH58k2oq5TMUu/psnzvNXtHN5Xj6w7q837srn1Ya4+2vxrBp?=
 =?us-ascii?Q?AOap7ynl7EENIOMVf88pckAHN5CmOmilZ0+Zd++3MKQjlzHkbJUd9avnd2un?=
 =?us-ascii?Q?aCfZUN/4mTwvXH/Ocql9tFT1IIsGGkIeS+6+impMXumsXlVlvfxTFiy0bHuZ?=
 =?us-ascii?Q?KZzh2PUBazNGEVr4eiuDaa4r1JWuzKeG/VXOFUUwUeCTTi1ajLq3uQzr5j9U?=
 =?us-ascii?Q?k+/zbvJPnFuE6ZgKxqlsL4NtvkwrpqxVsh0UGpCD733khxuDA2K3A4+RNPab?=
 =?us-ascii?Q?wlfg5pX30Rtsaml0+3gr5StAPXeYMbHzyaSwy1hstLBOcyd4rtbasf+6NbXT?=
 =?us-ascii?Q?Wfnx96DiOREnBzWyg8+X6LIJ19QwoykOEYk3IosiV2JWzP3HMhOofC1zM+GW?=
 =?us-ascii?Q?I5SOUCYB3tx9LS8ukGHy70JdRPJWXycvANxcuJOssIn60Cqb8sJPbj51m6mL?=
 =?us-ascii?Q?kJkS6OJ2nbnGGqessDGGBmW8blM9nvFIR5hporRzPqLNlCNjrIxN2Yrq4VAR?=
 =?us-ascii?Q?SsrfOEb2i/KJwW/aUmdGKccLZ7Th8BC8RS4Pm9ZLmgQHD6QPPSxyKUAuVUxx?=
 =?us-ascii?Q?tQEN0k8Ho2SeFdfxqRLIx+X+xIgoFRkKgrEfU7jrEoFOkE58RTPAd+N3TSWW?=
 =?us-ascii?Q?ntHijr7e1X1GJwCEf8gSyZ6K/rWECOZRUoP9UO4LSdj2v9WFJJjAkaq9OYtp?=
 =?us-ascii?Q?9gNFLvnYzDkoi29T+o1Pn2VPaQm2v0sPx/rTd5AFknmavWPZjzwTLT2s7y38?=
 =?us-ascii?Q?yTPYEnhsZZH7Rlu9ji+VHvwI2lkPfPcTdMBgSvIx4IcoJI2GBnbkrZAJ5h5W?=
 =?us-ascii?Q?jmpHg05TqfUgsTtZV+X1YqhTvTG5bjIT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yO8A5Esm/moonvS6FtiLgo4FkrA+u5w7B9guilxEWOsj1cEwCv7etqRTbpG7?=
 =?us-ascii?Q?nvhPOIbrqvIT+R/Du2S0/SyUs+6YyiQURRWvT0GICmAroL5rSINaj8vOteH0?=
 =?us-ascii?Q?KrCYFTxrd4QvoPO7wf61FjT0ohI6CTHtsBVxVXJHjc2I4vUfWYHOjr8S0LVL?=
 =?us-ascii?Q?wzJloEM5RxMCPDgaMZuf0SFCKzcSKJuJxW7D07C+57CjaIrnYkBmQW9jB10q?=
 =?us-ascii?Q?TCJVeIdi4D7yQQY3DktqIpMNs/pqrLKlrBeBCvRDXxrRVdKysZhps2S4gLVn?=
 =?us-ascii?Q?pT6Tdcs5YNES4LCv5piyrCnttQ9orFhcJYnZmBUptyvSgiQbUtgssIHhGpwp?=
 =?us-ascii?Q?aQeV4/kb2d8pnM2dlHh4rt/1LR3cRFI4c3bweiM2dD3Sxy+MqRXWz3suMedH?=
 =?us-ascii?Q?p4zRxyUpekqnMyjkeGVFNn0c0zBvg4y34uSm9ffKWaQ3BjUHa52eACXIr+cr?=
 =?us-ascii?Q?ZqlegxkzIV1+ZKBQCW50RvDc7ONN+SglFyyD7YlThGYtCOSdN0HqAzKenIye?=
 =?us-ascii?Q?KftPYgcaO+SGALDLJTGV97JVY3i8tUc6u6wfBxX7V/2iiGtHUQFO9jUgGk1I?=
 =?us-ascii?Q?Qh5C3JBNx/ITLrSNEpT0jQ3dNevN+tAvcJpJ5ScTEn0FUI5XFSNbsIH8ZoTa?=
 =?us-ascii?Q?xO00e0lSxHTdn8omZGH8vVid7KVcWD63y2T/KWW83DWrkLgH0tB7LUBiHnOL?=
 =?us-ascii?Q?MjLL3fq9eUxXh/RBaT8TtjweyA++Cr6a3FgUaEvvlxAjiX2x+eCtpR2xKfW1?=
 =?us-ascii?Q?dZ3jZ/WwzY0aGvIQ2EE3FrAKevAulpRdQZMy44EwJtTfKWjx9dQ8z1ywkldz?=
 =?us-ascii?Q?aLnl3XYrc+HyN/o8A3WdNwaTYlonV/y7hlaafnkzthZYJUENSZca69q0JwKo?=
 =?us-ascii?Q?mkd63qLzg4KlshZke5F8mLbylUSaKdxUJ0VRZQ6XmAZP7inIt0xKoyp2atGq?=
 =?us-ascii?Q?nBHBC3mKkMEAMnlY0g00vrgvn+R4VlaGUqbSQs9ClQTZ5irHiiVDEzXLlqtP?=
 =?us-ascii?Q?J0zwJ0L0wepjeCS6p2zGsz4FF3rkreEUtwp5p74sNvSAF6EcsI+oduMX8Z0R?=
 =?us-ascii?Q?/u+dSEDV2xYplIDhs59k4tRCmmU+ny8SuE22vOyDUs12UJKmxkinWlOHBni0?=
 =?us-ascii?Q?/wJkQq3C6ZVVatoZguFIEaRepM2AZQnEJ3+7k8o5F/bTollj3MK2iG8ZYbl7?=
 =?us-ascii?Q?C4hUr3XIeUwTO+3BJJHxupc0zUABYK2hIvRLw2nD66ErcZCeLP9s9j5YDriO?=
 =?us-ascii?Q?hdhOiJzo+nSnPneArAV/ey2AfmasBGFIgdAluDu7/Uf/4H2EHbrF3tHkyX7l?=
 =?us-ascii?Q?rs9M2SKAGAd1l+XBtnFNTB6ypFDLCfx8mq++V7D80ay0z5WQLO+aZ8c9YntU?=
 =?us-ascii?Q?INeEx8qtAhXUyDRUuKzzE6onoGgCzwy4nGj+s6/6rPg5QuhwrdD1CjLsHDqi?=
 =?us-ascii?Q?sD0ZdZgIUhkKzxdMQWC/ba3RhYZ0RfAMjQl/p1oVGKjDkhOBSE4UJQTfZNR5?=
 =?us-ascii?Q?D7eo01B9LPE9fNxLa3OiMEYviz/UA3HQNlinpvvWx2HO5uOdPl7tG4zfnalR?=
 =?us-ascii?Q?7r0DVb3X9MlQ75dJoMEnvPYvaFFDTTlb7rfs9SqCcnbruSYtWGBgkHqlgMXz?=
 =?us-ascii?Q?4A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f01a7-27a7-4b6e-7b85-08dd581d59da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 17:28:44.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNprRJ9OBEr8A0qlrQV72ZqIRMlUK81KcXBxNUa8rZxjhL64mXQeUly9miMwYsarj4Ih2JU4+RDNkx6AXbyCNRBrIAJkWX4VobQ0w5sbqkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8095

Hi Geert,

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: 28 February 2025 16:44
> Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)=
 family of SoCs
>=20
> Hi Fabrizio,
>=20
> On Fri, 28 Feb 2025 at 17:32, Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:
> > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > On Fri, 28 Feb 2025 at 16:38, Fabrizio Castro
> > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > On Fri, 28 Feb 2025 at 15:55, Fabrizio Castro
> > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
> > > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > Sent: 24 February 2025 12:44
> > > > > > > > > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Do=
cument RZ/V2H(P) family of
> SoCs
> > > > > > > > >
> > > > > > > > > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > > > > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > > > Document the Renesas RZ/V2H(P) family of SoCs DMAC bloc=
k.
> > > > > > > > > > The Renesas RZ/V2H(P) DMAC is very similar to the one f=
ound on the
> > > > > > > > > > Renesas RZ/G2L family of SoCs, but there are some diffe=
rences:
> > > > > > > > > > * It only uses one register area
> > > > > > > > > > * It only uses one clock
> > > > > > > > > > * It only uses one reset
> > > > > > > > > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > > > > > > > > * It is connected to the Interrupt Control Unit (ICU)
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@rene=
sas.com>
> > > > > > > > >
> > > > > > > > > > v1->v2:
> > > > > > > > > > * Removed RZ/V2H DMAC example.
> > > > > > > > > > * Improved the readability of the `if` statement.
> > > > > > > > >
> > > > > > > > > Thanks for the update!
> > > > > > > > >
> > > > > > > > > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-=
dmac.yaml
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-=
dmac.yaml
> > > > > > > > > > @@ -61,14 +66,22 @@ properties:
> > > > > > > > > >    '#dma-cells':
> > > > > > > > > >      const: 1
> > > > > > > > > >      description:
> > > > > > > > > > -      The cell specifies the encoded MID/RID values of=
 the DMAC port
> > > > > > > > > > -      connected to the DMA client and the slave channe=
l configuration
> > > > > > > > > > -      parameters.
> > > > > > > > > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L,=
 and RZ/G3S SoCs, the cell
> > > > > > > > > > +      specifies the encoded MID/RID values of the DMAC=
 port connected to the
> > > > > > > > > > +      DMA client and the slave channel configuration p=
arameters.
> > > > > > > > > >        bits[0:9] - Specifies MID/RID value
> > > > > > > > > >        bit[10] - Specifies DMA request high enable (HIE=
N)
> > > > > > > > > >        bit[11] - Specifies DMA request detection type (=
LVL)
> > > > > > > > > >        bits[12:14] - Specifies DMAACK output mode (AM)
> > > > > > > > > >        bit[15] - Specifies Transfer Mode (TM)
> > > > > > > > > > +      For the RZ/V2H(P) SoC the cell specifies the REQ=
 NO, the ACK NO, and the
> > > > > > > > > > +      slave channel configuration parameters.
> > > > > > > > > > +      bits[0:9] - Specifies the REQ NO
> > > > > > > > >
> > > > > > > > > So REQ_NO is the new name for MID/RID.
> > > > > > >
> > > > > > > These are documented in Table 4.7-22 ("DMA Transfer Request D=
etection
> > > > > > > Operation Setting Table").
> > > > > >
> > > > > > REQ_NO is documented in both Table 4.7-22 and in Table 4.6-23 (=
column `DMAC No.`).
> > > > >
> > > > > Indeed. But not for all of them. E.g. RSPI is missing, IIC is pre=
sent.
> > > >
> > > > I can see the RSPI related `REQ No.` in the version of the manual I=
 am using,
> > > > although one must be very careful to look at the right entry in the=
 table,
> > > > as the table is quite big, and the entries are ordered by `SPI No.`=
.
> > > >
> > > > For some devices, the SPI numbers are not contiguous therefore the =
device specific
> > > > bits may end up scattered.
> > > > For example, for `Name` `RSPI_CH0_sp_rxintpls_n` (mind that the `pl=
s_n` substring
> > > > is on a new line in the table) you can see from Table 4.6-23 that
> > > > its `DMAC No.` is 140 (as you said, in decimal...).
> > >
> > > Thanks, I had missed it because the RSPI interrupts are spread across
> > > two places...
> > >
> > > > > And the numbers are shown in decimal instead of in hex ;-)
> > > > >
> > > > > > > > It's certainly similar. I would say that REQ_NO + ACK_NO is=
 the new MID_RID.
> > > > > > > >
> > > > > > > > > > +      bits[10:16] - Specifies the ACK NO
> > > > > > > > >
> > > > > > > > > This is a new field.
> > > > > > > > > However, it is not clear to me which value to specify her=
e, and if this
> > > > > > > > > is a hardware property at all, and thus needs to be speci=
fied in DT?
> > > > > > > >
> > > > > > > > It is a HW property. The value to set can be found in Table=
 4.6-27 from
> > > > > > > > the HW User Manual, column "Ack No".
> > > > > > >
> > > > > > > Thanks, but that table only shows values for SPDIF, SCU, SSIU=
 and PFC
> > > > > > > (for external DMA requests).  The most familiar DMA clients l=
isted
> > > > > > > in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0x8=
D, but
> > > > > > > which values does it need for ACK_NO?
> > > > > >
> > > > > > Only a handful of devices need it. For every other device (and =
use case) only the
> > > > > > default value is needed.
> > > > >
> > > > > The default value is RZV2H_ICU_DMAC_ACK_NO_DEFAULT =3D 0x7f?
> > >
> > > If you take this out, how to distinguish between ACK_NO =3D 0 and
> > > the default?
> >
> > I am not sure I understand what you mean, so my answer here may be comp=
letely off.
> >
> > ACK No. 0 corresponds to SPDIF, CH0, TX, while ACK No. 0x7F is not vali=
d.
>=20
> OK, that was my understanding, too.
>=20
> > My understanding of this is that there is a DACK_SEL field per ACK No (=
23 ICU_DMACKSELk
> > registers, 4 DACK_SEL fields per ICU_DMACKSELk registers -> 23 * 4 =3D =
92 DACK_SEL fields),
> > to match the 92 ACK numbers listed in Table 4.6-27.
> >
> > Each DACK_SEL field should contain the global channel index (5 DMACs, 1=
6 channels per DMAC
> > -> 5 * 16 =3D 80 channels in total) associated to the ACK No.
> > If DACK_SEL contains a valid channel number (0-79), then the correspond=
ing signal
> > gets controlled accordingly, otherwise a fixed output is generated inst=
ead.
> >
> > Mind that the code I sent wasn't dealing with it properly, but wasn't s=
potted due
> > to limited testing capabilities, and it's safe to take out, as the DACK=
_SEL fields
> > will all contain invalid channel numbers by default.
> >
> > Looking ahead, there is a similar scenario with the TEND signals as wel=
l.
> >
> > So for now the plan is to upstream support for memory/memory and device=
/memory (REQ No.,
> > tested with RSPI), add support for ACK No later (perhaps testing it wit=
h audio, or via
> > an external device), and finally TEND No if we get to it.
>=20
> So which values will you put in the dmas property for RSPI?
> I assume:
>        bits[0:9] - Specifies REQ_NO value
>        bit[10] - Specifies DMA request high enable (HIEN)
>        bit[11] - Specifies DMA request detection type (LVL)
>        bits[12:14] - Specifies DMAACK output mode (AM)
>        bit[15] - Specifies Transfer Mode (TM)
> i.e. all remaining bits will be zero?

I see what you mean now. And there would be an ABI mismatch between older D=
Ts and newer kernels,
newer kernels would interpret the values incorrectly (as you said, 0 is a v=
alid number).

>=20
> How do you plan to handle adding ACK_NO bits later?
> I.e. how to distinguish between remaining bits zero and remaining
> bits containing a valid ACK_NO value (which can be zero, for SPDIF)?

We could add the ACK No. and the TEND No. to the binding (after TM), and im=
plement it
later in the driver (once we have some practical use case for them)?

There are also a couple of alternatives:
* we could add 1 to ACK No. and TEND No.? At that point 0 would be an inval=
id number?
  In which case we could add DT and driver support later?
* we could fill up the remaining bits with 1s? We only have 5 TEND numbers,=
 so 0b111 would
  be invalid. Similarly, we have 92 ACK numbers, so 0b1111111 would also be=
 invalid. Also
  this shouldn't break the ABIs once we get around to add the rest?

>=20
> I hope I made myself clear this time.

Very clear! Thank you.

> If not, weekend time ;-)
>=20
> Have a nice weekend!

Thank you, and you!

Cheers,
Fab

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

