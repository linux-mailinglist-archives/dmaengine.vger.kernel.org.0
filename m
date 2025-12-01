Return-Path: <dmaengine+bounces-7422-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542EAC97252
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 12:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9593A1A58
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940A2F5A25;
	Mon,  1 Dec 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="OYYGHbxb"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010028.outbound.protection.outlook.com [52.101.229.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C662F5A03;
	Mon,  1 Dec 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590083; cv=fail; b=V8An4lCx6bzl102wjc36CZpBwQmFQtFpfQ+33ODKQAdOvaJfOJehLlSaJJo6gjvg/9UMThvPJaVr2BsqT3z07H9raXeniYh/F1IwTThDJutAvSNvz+pYEIT3PjFkmEzvlSt1fJUPbFn9ahMhkhfCQ38L+2QldqsaMiQJeEt5qP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590083; c=relaxed/simple;
	bh=H2VwkjE8ljlgES1q0+lAz4Beb+4orv+IEc15u6PeSlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CLtIVVXmLoEqxDuRXTBG/yfdN2HgduJfV5sEm/D/roRTRMFsfthAfPFFOr450fZutFOqVprTlBLdT1mOTLg4cSl8Kv5AO4HNs/1bQA1vQeCUPThfAWRPJ1dJK6A+tMXiA0XNgsQTrA7Coc4Cd3p/52xZ7ekmhYQGqiDGQAkDdxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=OYYGHbxb; arc=fail smtp.client-ip=52.101.229.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwvHi7NWldj97H262d2B8U86MmvttiDMQrjAAjmWwM+dam/4Y66VNhpbigsoqDHIxLkScgdinnD9tJxzXfCtVFRxreL1NP7MiExdOWMSOWakIN9UMfdzF6VdTW7KTwTGgICFbIAJ0dnIQy9I9kQG1bQzSkjZdsjJm4pwRS7d7F6w1aXPo0fACUCNG7R+4dkeKqh57rCtyMdKLKJVi1NI/+XgZw2VFqo1PM3glZ20r5oBDOLKR90aKBeFlXw7P51fH7L8ev8hP7d+zba1LME2wcnJvRY/XGD4XOjxJyP3x6rEFf8g6AnAde4kPiZBEDMVpEyn+XOzi+yzPwrxLDek/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrYD1Uy56UW9fVinWtMha2mh1LukdYAQmV3hH4YgV+4=;
 b=yqaCoLocGpi+VpCQL3i5IrlXavmtBvhAfjpIvDZRcCroNq/BRHa5Fr4mC/A2NLYOHHPjZrFnVh6dGaZWgJ1lIAd+HDxbJMopX9uHvHM97R5NQJ8fGdOuI/luNrnKqF1nDOhtXAYOogiad1LslHIy642l/TJGwo2YuDU2gq0KsW8qNQCg3uwg2lvUai4o2EUDZYgBnqV5SBb4dHg7eKaVJwqTe/cFbiJZTJwll0iVPJLAYrQOwBbgwi5l3l1j4TOGE3WhRkJCU4zvRkmF8L9LJRScBeiX1Z82cW6rzNb5ajH9CVCNipgkP8Lxn1aCZFGh04BiuhET/yrGXyl+3F9srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrYD1Uy56UW9fVinWtMha2mh1LukdYAQmV3hH4YgV+4=;
 b=OYYGHbxbt2z7VpQ63YV8ZUMbVsA3QZn/kqH7zTOUBa6lkK8gGVaZdnANnv4hctQK/b0eQHMjRsAXcPgtSpmft9bTkuMe5/dxYPo2CKoJ7qqcXEwCbitQkx1aHCCOqchf4QWmmezkvp5fcUn4rsj/8WfqpVXLb5IxQIR5dJcMJ5U=
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com (2603:1096:405:1a6::6)
 by TYRPR01MB16003.jpnprd01.prod.outlook.com (2603:1096:405:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 11:54:38 +0000
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29]) by TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29%7]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 11:54:37 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Vinod
 Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 0/6] Add DMA support for RZ/T2H and RZ/N2H
Thread-Topic: [PATCH 0/6] Add DMA support for RZ/T2H and RZ/N2H
Thread-Index: AQHcYrihd1NnR22SPEKiXBONiAGKr7UMrNLA
Date: Mon, 1 Dec 2025 11:54:37 +0000
Message-ID:
 <TYYPR01MB13955B628879F3F18D157EBFD85DBA@TYYPR01MB13955.jpnprd01.prod.outlook.com>
References: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13955:EE_|TYRPR01MB16003:EE_
x-ms-office365-filtering-correlation-id: 156c45ac-94a4-413f-40cf-08de30d066ef
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p4kAZ1T9w2ODZO226ReZ4EoJAMWMFm4rrV9jEdXV+sTWiG52ytt3CWT4mGWv?=
 =?us-ascii?Q?y6VEg7yRFwIDZzkb+aY0H5Upc3MNsa1hiW3bUhm2blJfLMV1jTnX+wUzBt9G?=
 =?us-ascii?Q?r/H5h4c6m2OIKZ59EtJjTT6hMP2OPQRRjtvI59hRKhh1VoMycmAR3Pc/i4Zr?=
 =?us-ascii?Q?2bmCcuwwEUzB14iOOH1I6JSPPlJLdKjXV1bo/hqzrl4Se8YYAoCN3bLad+i1?=
 =?us-ascii?Q?LjjqtDqX7bnqBavcfzNopIl3JpLpPWNP2sBxIMS51oE7N8Ncxtl5Z8ndWTuW?=
 =?us-ascii?Q?Bcjc0MQBHAJY0F88hK/jx4XvHma9BIGOFnwvz2jw2HGNijCHs0du1ESycnTF?=
 =?us-ascii?Q?H9lkywoya4BzjOlniZ2c/2RYhcNL8S1Nyi7q9c4EDAuoCP06xS3JidrDkd1D?=
 =?us-ascii?Q?X4cPl31yHNoYwfvEUL9rfe3ppvLbglzusjvDejkzDj0pFbKMELzGa1d6Iar8?=
 =?us-ascii?Q?P4fuj8LlkqTgSqFatkHunjnHBQxOe+R2gbQCmPoepF/jxjUKo+posp4Kp/NO?=
 =?us-ascii?Q?Muz/XKEwBKYR1dplmlFhCkTSzFeswlymyEh/6TuseRlQSsyimlTGMkOCZzVh?=
 =?us-ascii?Q?5ok8m6j0ATabF8a0Oab0jZMM5QCVy3J1ZwaBzZtXvMoU9lTN53zK+av2vZjy?=
 =?us-ascii?Q?xsO0PK9FeSyQuA7Aq4RWm9CdMkz5FaXQGrFZbBmdhPaGIC0apqHn6EldYUrq?=
 =?us-ascii?Q?f8siyB2o2EXL3zRwa0yTcOqF0ZYnGNHwbf06u0wyAVVXJbmFvEpW4qZAfkok?=
 =?us-ascii?Q?Pw+0Foj2lvMGk/uwtRzD6G/CQY77TtIHOtgAmXeTTktqufIwjR/N0Ao1cCb6?=
 =?us-ascii?Q?Z/GuRT7HT9XfclqQYgNID9GxHBXocPlxUGXmTYgYoPr2PcW1doIyMJUpdPko?=
 =?us-ascii?Q?yMLwalvHr1Qp01L4KbwUCZ25pBA0Y9+Uy5CmgZBJaJ0lNS6o7N5DO+i/9ysC?=
 =?us-ascii?Q?8QJurGAJGwesoxlyStxHPbbAbGiQ3sb/9lTS0FBP985wzPmXFIGD17hEqdLB?=
 =?us-ascii?Q?LTz+3snagnHhajyyC5MHfwdrvTG5TLiNzKfqzdAAQsq0PFtzD/2IKkfPmHhK?=
 =?us-ascii?Q?jpN4MF2Fstjm0yuFhINdXmPVa6kTSRWVfCldx8GxCNEduTweszIf13YEqc2i?=
 =?us-ascii?Q?ANwnijj1Ea/PC/CizT0LfNdIbzVHw1ege1fIZiNsdes1DFzu5Mg8zZqKQrw7?=
 =?us-ascii?Q?6bmvICd+9IqKzw3Hpo8QedMqXXGp1YrbVKCO7uiOZK1FSHIcWALfE+VPrkQU?=
 =?us-ascii?Q?wdjVJzvY6recUnvGv9mf6iFyz8gej1LEHldrqAYNGdCWlZgtT3egWINB0G6e?=
 =?us-ascii?Q?gtzI+w1v+uzBvfD5KsCXhvYLSuFiwfMGGKWBbTeq4Wt70ZLb38Wp843kky+/?=
 =?us-ascii?Q?TFmU5S49/gz7LSw12EtyTS1z5lYYj8TsGGJ2+5xwyPRRLkBdxCQdOmeRReLW?=
 =?us-ascii?Q?uX1qUtlQ0li9GIPDyfLF74fxd4KzDakY1RYcEecgpdEAvB2BB9NeSi0C3bUQ?=
 =?us-ascii?Q?db0jJdJ2bz+7Ww4WvZSmPHvNT+pNdW3mBAaX8mLfzO0OPg7v+9Jvfu5/vA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13955.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DPIwg4nbB/TOR6iabV1m0bf5vN49pRnJ9RMHnpZcv8BNPu6ECVg4Kkm8N13E?=
 =?us-ascii?Q?Oc+hYYcFW80utdwyH1CFNZBYRcc99n9HP7e2cctknEZEUSDrvZnBgKehhrMb?=
 =?us-ascii?Q?FjK0vxFzroR+TnFP7zCpPltd0UsHRWvlJad0x9Xv5xSZ9lkbcLmq01CEG30s?=
 =?us-ascii?Q?kSKBPKEdWREfINy36Goli1DpXiJKbbaQDNIO0u58EVQ8HScCtJMapIlwZNdA?=
 =?us-ascii?Q?0qsbrvIC6gN6WIq+UiVuudIJM++jEcweYrQ45YBFsWSqFmKqD7q6WNK2N4+k?=
 =?us-ascii?Q?5yIPdbQwJydpNeAa1xNUhlX7PBG2IsI/NTeMcUcgjVrq4plC1rkSelpLEQdO?=
 =?us-ascii?Q?ugVb6HFjTup4BHOmbNdOvlY6KbYAnDSIO3DouMrwMOqr24khuzglD4SP/81e?=
 =?us-ascii?Q?HlaUGis2jvqosqoXM8vcjjfTyikVtTruK4EaZ/i30V8bDaQugLJhuWTAOk2C?=
 =?us-ascii?Q?T1fwVBhn+G/zcxKanmPt/kKhLTPSOC5xe2MIZkcYMs2TwpKTSNj9q2/vhGjL?=
 =?us-ascii?Q?NfjsbijbStFd7OL2TKFnSfy6cjgb6kvKk/YApEhcshIOeExz8WC5ZZ1w2lUO?=
 =?us-ascii?Q?l1OJAtHN78eeQDxkdaPwY6dsNjBuLbfTjh35kbTrrYYMkjvWmpT78PUvNGWM?=
 =?us-ascii?Q?A9pl3+M5tPwBB6KkzA6gDyJXNoJ0niwl78+0H+2e71xC5XcGpuWTSTaywnKL?=
 =?us-ascii?Q?1I/PWyOt72HCovQ/NvHGv65r6DC+BABZFn1TZGz57zGUoUSiMYpmPkBBC4yn?=
 =?us-ascii?Q?AYoeoOJlkRjs2OQjXYufBcrloPb15itv8VKzm+cx2/O1SrYWtfNv8VFJUIlj?=
 =?us-ascii?Q?hjb7XFH3aYLSAZwrxSohQW/0Te+fFOXEQHktn/9PsrHGmF/E6oHQqMArc7yn?=
 =?us-ascii?Q?npNlc8XACmcA3/07gLFtyJKaFNyBsNQw/2XKu9K/9XJxI+dMDZNTU2GG8imh?=
 =?us-ascii?Q?zwOLewpUzvY+oWHGVe7Cp8OzDBVuYP1LCLjtz8PROsX4jlMAjmVaZ0gVau4h?=
 =?us-ascii?Q?fBsnQYFsFMPk/n943GBmrCGevRp8czhbFsp908U712MmEOcpgurvtfj9pUC7?=
 =?us-ascii?Q?rrRxQyPhinwowXMIIPZqA3SF2bNSwGLD5y61P+Cdx4VH8QDL6d/umikbVNNi?=
 =?us-ascii?Q?2+/9WeCfsfaNXbGAp5HWiVOfEAfQze9+bEoEai+SHi+1aNDUwoKqa3oL8osU?=
 =?us-ascii?Q?jWJ6n+2b0FMFsw2z1yEnQCBlAhl3bdkT+/2szE/5WgeQqv9rIisEkHrDFB7d?=
 =?us-ascii?Q?uH3cQNfUi2GA5Y6+wpEw1HZOFPghd9gUVm8BTuBz+PYuBkv4kDGNk2TbhHbu?=
 =?us-ascii?Q?bRBnIqr6V33E89DvTLazNNT56lovSbFqoZKFKKV2X3JGza2+65OflQuBCrH1?=
 =?us-ascii?Q?YAJ0EAXGzMnGdBjiqimaTCvaqN+jAbNjFvFMuKeJ7Mm6bCKZtg3d0EyK/y+7?=
 =?us-ascii?Q?ffDPjewhfEqtO7upqZEPegyNc9X2BfJRFZyeukaSk0otqz5lltp/kOf76J7d?=
 =?us-ascii?Q?afOqh/z8T3zF72E68qYQgZzqUgfZ4rBk0L23/ndxU9Wstdenm6Fw7dCmCL87?=
 =?us-ascii?Q?VMadudcY6NI4x+ZFYuk0e+96yqn7Ysg2d2ryjVMBlHPBElu3y/rsCKqmp4eI?=
 =?us-ascii?Q?9C/LBTtlJR7sdHweAh1H3lg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13955.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156c45ac-94a4-413f-40cf-08de30d066ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 11:54:37.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjUOcxuPg2TnIt2HHP2/cA9kMApjOg/F8vqUXH9Sn1sPjaqoTyzKeySkUGci4Ugp/ImAQ1hVzBCxHQyWnmuvsqubdme5uHiceBTFx6aAm5TFfFRc62aCdYoGUAvLJe18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16003

Please ignore this series, I left some internal comments after the
separators. I will send V2.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Monday, December 1, 2025 1:49 PM
> To: Vinod Koul <vkoul@kernel.org>; Rob Herring <robh@kernel.org>; Krzyszt=
of Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Geert Uytterhoe=
ven
> <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.com>; Cosmin-Ga=
briel Tanislav <cosmin-
> gabriel.tanislav.xa@renesas.com>; Fabrizio Castro <fabrizio.castro.jz@ren=
esas.com>; Prabhakar Mahadev
> Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Johan Hovold <johan@kernel=
.org>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Cc: dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@v=
ger.kernel.org; linux-
> renesas-soc@vger.kernel.org
> Subject: [PATCH 0/6] Add DMA support for RZ/T2H and RZ/N2H
>
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
> DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
> are missing the error interrupt line and the reset lines, and they use
> a different ICU IP.
>
> This series depends on the ICU series [1].
>
> [1]:
> https://lore.kernel.org/lkml/20251201112
> 933.488801-1-cosmin-gabriel.tanislav.xa%40renesas.com%2F&data=3D05%7C02%7=
Ccosmin-
> gabriel.tanislav.xa%40renesas.com%7Caec47accb94f456209db08de30cfc1cc%7C53=
d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C639001866033085716%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlA
> iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzoN04o=
8jHJQ1O%2Be20h2F%2BDxeQ4LzPVoLD
> HvHQGOqH3A%3D&reserved=3D0
>
> Cosmin Tanislav (6):
>   dmaengine: sh: rz_dmac: make error interrupt optional
>   dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
>   dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
>   dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
>   arm64: dts: renesas: r9a09g077: add DMAC support
>   arm64: dts: renesas: r9a09g087: add DMAC support
>
>  .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  90 ++++++++++++++++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  90 ++++++++++++++++
>  drivers/dma/sh/rz-dmac.c                      |  94 +++++++++-------
>  4 files changed, 317 insertions(+), 57 deletions(-)
>
> --
> 2.52.0


