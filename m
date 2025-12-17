Return-Path: <dmaengine+bounces-7793-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DDCC954A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 19:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0352F303B4B2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301429898B;
	Wed, 17 Dec 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="B2DjRGPO"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189442AA3;
	Wed, 17 Dec 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997427; cv=fail; b=gFEoPiDe+kfq+px+4rxIalxRluHzFbOzew6HnkXe6dVD30I4nUqq186xbettKgr0Wv+c/mhapeUhdlnOsicnD8DLZulgSZQG+4WsGDobc3/7lIMTrqkraXKxs4FUv5KXMeIi13VdJ4iLk6hlCrkZQFYKkz57A9l8f+6926TMXY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997427; c=relaxed/simple;
	bh=60ulAAuCzHHcwl090V9q7zT+WbeKNkSQYFq7lrSTqiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYIfq8PYrAVHQa9zldT/lzIoAfeeArtkKv+a3PNaYD39v/pr1eF3Cz1ZxJmCH2PDxdBBp9DxbwBgip5A+2zKcZ3w7/qiR7KjsY17zzC1P4z1uqJgVkUH6YVGqio4jL0TEzfyzIPh8XZ/DFq36N9ODoDMa4Eoy5CM8zUPH8AEBWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=B2DjRGPO; arc=fail smtp.client-ip=52.101.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBONQGtgi0yokhk1dijoa8Oqa4joPhGK0lmEg3eCBuqq3sJvJrx+W3Qsfuw+3DEZksHiM1M2sBc7np7ZAq6F4kb95RO3PcuIvWne8U+aVPgTt23Fo5pWiEvsiFSX6yUv9Roy0RQNu2tTc7BTHmlLi+u3MCYWP8gdbFT4yw/6AqUkuxUd9axf2lmtSKYMU0yJSw3b0Q8jkDxi4vcQ+YnnrjVbuv9ed944GT8hDTk6VH08HiXJVt49XnY2tu5MtGDATL0mFuaYKjxu5J+qgQYUJwdUf+dBLv/4fGkPiPcjWzsJgyh3KxmjzjxOBNRolA/uV1JqrjYucVOZzRpa/E9EWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N83RKCvl1dedTKL4m+VMZpginID6OaF6el4XlYgz0A=;
 b=Ok2EsPN91B3E5PJNKKs9Ouqd81pmadN7WOizKBNmwSwR8+z5v7GK6Tyxi0gKEqGt+MmR9mfEfY4VC3+QwFlmfT85/AfTr0DrOiyhjD1ilfYUwmS56gZyJfejPXX7WjnO97fjkDVrK54+WPYgIa0k2OrwhqA5BL3PjVnLTO6GhhKoS6Qw/qN+YYvL+mdgEXDaOSLVk8URKcpE+gMCGdncVMsPLEJdzj3hxU4BNT181jLgkXO8t/uN5mmV+D1FtUhJu3Y5YQK0VijEu2X7mLd+9q5ZbtALXjG2kydWdTDuliWutRMG1UtqXafn93g6XGUNS28pce8FL8gO7QDtc81OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N83RKCvl1dedTKL4m+VMZpginID6OaF6el4XlYgz0A=;
 b=B2DjRGPOHx7nILdW6LDY5TqgCvYvXmheYDmZY5J4pA+ZZB6+zEBKE7NYGA4W5MfUfUPy2TdFABUFjyTM2v9gxYoVUXC2jH6m7j4muWnvx3m4OftdxfqdWWMqzFMyPudG2CQUmEL5Fhj6fTy5nWoQoEMOMjlVGfQouSXUhhnAWAU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB13778.jpnprd01.prod.outlook.com (2603:1096:405:1fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 16:16:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:16:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates
 under spinlock
Thread-Topic: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates
 under spinlock
Thread-Index: AQHcb1xlhp/+aQF2iEOVgbBl5tSyVLUmAFiQ
Date: Wed, 17 Dec 2025 16:16:39 +0000
Message-ID:
 <TY3PR01MB113463722674503F2B15F944786ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB13778:EE_
x-ms-office365-filtering-correlation-id: f8e35b76-e8f4-4544-9f61-08de3d87a8b1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NdHijYA8TAx0vRUoXFFppfbQqU4M4ajNPkNSGxIZiPeJo4mvlQihkVsVpiuK?=
 =?us-ascii?Q?yKdNuHR1UXNz8G/VvLR3pL5e8K7FmRZpx+5/2dONrxRw6TN4s5lL4DmREcdj?=
 =?us-ascii?Q?KNSt2MH7V1woeUSvBntZtDdeMULM6I0SgDkyfjiyuxdxILmzh+a6eeausFaU?=
 =?us-ascii?Q?+PaFF/4RPNWec+Py86tjEVSTNxoYFOMtIY3VLz1AMYTA6Bakf6M5h/dNVLN/?=
 =?us-ascii?Q?jtR8qQqFzAqzUNdLAwmRD8oA1roKosu1/NQelq5zdAqCa46gykx5jODfb2WC?=
 =?us-ascii?Q?NjPOqbWN1UpqxFQmX/QjLk2XGK3xyTBeh86bZClceo7ncJzi+KRMeLDU24ad?=
 =?us-ascii?Q?GFFNOvR3BC6s+9xzAyWJDyBrSsUZU+Lh8fk2aPwH2iCiikgvaoGQWFGTEhi5?=
 =?us-ascii?Q?FV8HpsNRJdg+wTPwsYP3dlP0Kj8BXNiM+eAcBs2ikSOcssznGr2dBOcwnYRz?=
 =?us-ascii?Q?uQdnG+WAV88o3E0Hw6Dgj9XnNRzjdjfRoEFOE9SknXvSyEKWymbMy0DS/7cR?=
 =?us-ascii?Q?n7ehAOG9E4UgPLCSyjvx/9uq3MX9Ive4tqX3H5Pj+CwMioJDl3gUSBtAXzVx?=
 =?us-ascii?Q?WhhWNiPATMT31TmNT89pWNQnoHe2yL2oUDPx/OnzxIX8YAFkcjpstBrrLqiE?=
 =?us-ascii?Q?B1qE5kMRMbD3oD9ySqzYPRKuqTdGuEKmizPrV8XgaO5VM4IO+8tsp6rwV0Va?=
 =?us-ascii?Q?F+1nmKbJqpenGLm4YFMAVoZAjxMDu64KRrCfXM/BOGWmI/7nXCpeSr0Eddbw?=
 =?us-ascii?Q?lcncbjRkW5mJ3eChadIvu62KLFJjcKG0SCbT8TzJDy3n4pYehE2V5zbl2qvw?=
 =?us-ascii?Q?sQ8YkA2lDVlM1UkTzAQZqnmJTDXHOfrluFpMghXaHIPgtHMvqGghUNbdmJ+g?=
 =?us-ascii?Q?wZLu680o/Xhbqz5lVZPb44qCVHD8xNw5QZji22elf+v347dTk5XmhaY7Bi9r?=
 =?us-ascii?Q?Y2RnFd2UbYdm+UijX0stmTLzvT4WaCbd2d10s43ROoeXBjcbpb6BrDIXQZc5?=
 =?us-ascii?Q?698+8OqIR/U+c/bu2PFBkYvzosOuJzhjo1q0DqCQd4grGS5/wCyCMK7x07Rj?=
 =?us-ascii?Q?dATbt2C+RPkGKa0xo/XbTnwPIFd+3hlgfgqcRwST3l/1z456GVHw/H4TPB1B?=
 =?us-ascii?Q?F0tHIFj/dWOMap++ZcMTEQeHaZA8vZ2vrak50XX+zJMbvGKE8flYmzuxVv8V?=
 =?us-ascii?Q?0U4xPL7Ib2O8JeaG0CyyyOEVGYZN1fO0At+ZON49hzpW0iWvFncR39axpRns?=
 =?us-ascii?Q?m9KDP0GyG0T3ky+gVvLm7HHS9SPqWmBND8+SsW33wYZhz099h2go9HhhU4g5?=
 =?us-ascii?Q?gnTYNfBSNEPaE9H68vk2tI6Fz9szS0NyXFPsu+zRCLZvD/apJoRd3K2NYZ7f?=
 =?us-ascii?Q?nhjum5yPWbei826PIzrIVixCAJSVSi7LvR8QC4QsXYV3nYr/s/d+WbMxgpMf?=
 =?us-ascii?Q?Gvx0UnMYyb+T8bHoySgCnjkuWiAtEaaHhXZQdObe77hTDosDh7VYLCVUnlbE?=
 =?us-ascii?Q?gG3y4D7xF0511zr5KAoEuVR/2XDY3IbJTYeM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b5Mk9vwxGn4G/Py8OVzpXn3slWPrXFrYxIz8JgHEvFkk7/3Ogu9s21i3oule?=
 =?us-ascii?Q?G//h/ct0RrX/PrCMFbKPTQ6FfV1dVjuv9l+5Fj7GyOO1vUa2k7c/y7psa+08?=
 =?us-ascii?Q?1no+ebEovVjRmwuxIDZQHHOHUy5/DthFq6tWmkrgn12wqSY8bAmRaeKyA1ZH?=
 =?us-ascii?Q?f13tLJqbZwRZmNO0Ta2M1JeD0a6qvr48EqRQWZejvEvKVt34UsvwzWzY32R0?=
 =?us-ascii?Q?x3poeRjEf2brWCDsHnkBSFM3TjjucXdUKqzwwa28e3nWf2/R30vafQqqO4iw?=
 =?us-ascii?Q?NdM5iiGGbQzfNAetcUFHP9+BnLUAYq4+0raJf9uVqsgyqxzIPYp1iD89B60s?=
 =?us-ascii?Q?EBxu4AnyQL6gQpsRZsO1WvQYDEav4ClQIyeyUG0KVpI2D/jdVejhh9KmOAuu?=
 =?us-ascii?Q?X0J5Abu2wycZD0qVPLQT/OJ8c8XRLiBWCGLsSERJWkcvBgAR1jo1yFQvb5+Z?=
 =?us-ascii?Q?uvlTN6vAGi1WC/YPTSzkHwOWOS5krjpw5mazyaW13sydg0ltaq39IhTwRMl1?=
 =?us-ascii?Q?ZeIR1rxRpcNgWnuaOMdURKJlclZ9/p3Ek72oDIc8R0W8QkD1z+kj3N0OVBao?=
 =?us-ascii?Q?7fa7o58vUpc6QidmJa+hLAhb9bOu7PY+MqjDLXx9Vf3SWyD1m8lz5KX49r/A?=
 =?us-ascii?Q?rl8JF0gKy+v9+1WFEZdff1kNKqcPYnKXwy7Jryc/b4vhzndflsGQjZvIIvGe?=
 =?us-ascii?Q?cMHFDI7QaMxAlYQB+BIvZWpjClYh/PVAsPwGajlyDrOSTLcBuFA+ISl/P2Jz?=
 =?us-ascii?Q?BPxtMimQNUCcZxBzbnCq4rybOKfUyk38ZDOLaMj5Bwmk5yFylnBt0v+96XXG?=
 =?us-ascii?Q?ocWALX8KpMpnMbd+tJKhD3ey8qaegBzuvfvFbyBQqeivJvL6yEnbKtR+a38I?=
 =?us-ascii?Q?Ta3wWh7n9rzQp6/EvfxMOF8i9ne8h46lPU//PlOkPrr1+uCS4124RZtuPvOO?=
 =?us-ascii?Q?bsQL2XT5whX1vUNE5H57toUIxwkSfCHg3hebf0MS9VWduwIWtGikYWGwjRUT?=
 =?us-ascii?Q?TuaJiDQQ+wlAVYcMgsAR8c3kxR9VLX06mVQXdey01wyxuQfbjEX/DrUZQnNN?=
 =?us-ascii?Q?nhZ40OHPf2VDrasoE7ndP5VDgtDILsALHdyt/TgjukNUysZS9cd6DDWPPwX0?=
 =?us-ascii?Q?os80en5x9pRKXkvAzzR5xBGtVQUbH+Ix/X/JbN8CnisNvhT4jA/UT8lPnRNN?=
 =?us-ascii?Q?Nk96yNwHlxU2MuJajWsIvhkmDuuew0TFgX2qpvGkx84qV7E6IUhxCbxRHm8f?=
 =?us-ascii?Q?sv5P+upjYcELPa+MuJwdOD5IElnh0FSKZpZHeohMNDDy6WpuBvGolu/9oDDw?=
 =?us-ascii?Q?ZL1ntItyRPKhKHrx7N2bHfx7NjaVUvoPAD7i5seSTzVvZz6Qkp2IdFZr3PhO?=
 =?us-ascii?Q?O4ea0sHDegBqqOZufP0T58tu6JNBHfdsZvgaDkd56X616XMWRkiestKNMCVX?=
 =?us-ascii?Q?zehSItMR8Q6Td/Y4gh0qxHar8qbkChB7ECX3kY82ue0jaHvzCGYlXsAYi6R9?=
 =?us-ascii?Q?v/Bd1L7oogDwALkY8+JUdswIJJBP+fo63ofqKaw2BzNjcmkM2lbgaXm5e+wI?=
 =?us-ascii?Q?T8uGvMvXeCTLOBFUGJGqKlZpcLL2Pr9tvAOAQJeLnUpJdRXUEpFxmyxsTkC3?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e35b76-e8f4-4544-9f61-08de3d87a8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 16:16:39.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH0NJVoxUPfaTedgtw1uPa1a+MsTfEuhVMLCqvOynuw4sXNlbKhofe++YXPHMol26IbVMDy5o28F1jW1oMLwrxvdzAqN4YRn3RYw8AH+Q+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13778

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 17 December 2025 13:52
> To: vkoul@kernel.org; Fabrizio Castro <fabrizio.castro.jz@renesas.com>; B=
iju Das
> <biju.das.jz@bp.renesas.com>; geert+renesas@glider.be; Prabhakar Mahadev =
Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Cc: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; dmaengine@vger.kernel.org;=
 linux-
> kernel@vger.kernel.org; Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>=
; stable@vger.kernel.org
> Subject: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates u=
nder spinlock
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the CHC=
TRL registers. To avoid
> concurrency issues when updating these registers, take the virtual channe=
l lock. All other CHCTRL
> updates were already protected by the same lock.
>=20
> Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, befo=
re accessing CHCTRL registers
> but this does not ensure race-free access.

Maybe I am missing some thing here about race-access:

	local_irq_save(flags);
  	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);

After local_irq_save there won't be any IRQ. So how there
can be a race in IRQ handler.

rz_dmac_irq_handle_channel(){

	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
}


Now adding a vc lock inside interrupt handler the IRQ routine is serialized

Cheers,
Biju

