Return-Path: <dmaengine+bounces-9630-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APk9I4fWwmllmgQAu9opvQ
	(envelope-from <dmaengine+bounces-9630-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:23:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85C31ABCD
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B92E2303F432
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174FF396566;
	Tue, 24 Mar 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OKACD1Va"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF1391E79;
	Tue, 24 Mar 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376539; cv=fail; b=Sxd6f1tgGWY7oE1wJj6Dm+QXNA8dmmXD7uzWyMZnJgLjFPE/6VtsHgKq8Ub/+wvkPi7dwv3z01/MjfUmku8if/kYRpT9CtKk49FPryZC87ziEXUbcueg38xCXEYPiC0ndRfxT8FPztxBu9YVhjHZlMI8TbG2hCH7hJv5O9Nt/nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376539; c=relaxed/simple;
	bh=/vtJJ2+beX6QfrIHch67ff6Rn+uzld1bQyVpqHv6dWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9hVMpSTLnTsLJMGGD7GqdCO40IGwjbYHlNOJ+Y1swP1dNV0j5I+9J2DoVpwmYfJ8aWqv7cqDd3i4X+FKXOEChnL22Vvky7eCf10m0fKhiU78ekWgrujMilNIQu/atGtAUt0AyBXTWr8U9QazxJnVm01l1tfxLjI18YLHX96lt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OKACD1Va; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYMox7xdD3T3PFM3RdukdTKXY4AOwUW7RXUul91jBTUpdQhIMDxiPkV7l9vhuiKUmp91P2td3Fcy/PcPJNJkRfzk5zYRxOIgnz0kZTEip0cr43zX9b0uJKY+LuBs2m1/JcWxl++QzTIZIWUPpCkaWGRuhei5rOceqm90R0id9ofc32WePspHBIBmFM0ajVn//D/kt0eqpwB2bDWD0zE9CsnKRuI6x2uJHIfi9lmK2If8mdrgeIlq4AEjfZg4DYZNH5eOd/z2ecHkemHaLjETLINSMISauMtBsS+PL1FpeiEQXBhc3/meA+AJ0MKkJphxj//feR53fYF76HeywrPdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN0L/uRXTNamEq0g33YLKFUD7Lusvw5d3v0oywo4i24=;
 b=GzgITcYqMBmzZDRGkcgToNtCfWYOnc3b68uRAV0ZCXxYTS1UiVXBS71/suGuw0qhZHoT3/+XAOcCBilH3aK77qaAx8oyBX/BI2UFZyrKehtF/5wyX+sgWffQxsdnDdJCfF+6p5sJKLmAI+UuU5QUDLFZIEp/7bSvM1j2F32k3AaKMdVzHYjHC6c5ZwFFt5nA2zJuR8dT1HwgrDeyZiu5gNpNyzYY+1ojayrZ2BDl2BPPJ/F7p82Au1X4VrNo5vQ1xYaxV1N7o3+0TQNcZY1Eje3JwFhkQd2NxwnLVBpt2xxzieOe6m/z3xFx7OW8qlVFFqvOnAaLPiGClPna65QzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN0L/uRXTNamEq0g33YLKFUD7Lusvw5d3v0oywo4i24=;
 b=OKACD1Va7NaxjmoIcCJ22vsHKX8ae8n27ip4fnLPSoYWx5SWwPlyaTZdCvzLv+jpPWMYv9RUG7WOBtPBNYSLKTekm0ZTkC06CuNoxBddvCZCC5tr5Inw9tsUTtQENzHbTcqhByqDuRI7EGvVzk3OSAqpGVlHhurmpuRCwRSwJsE=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB9280.jpnprd01.prod.outlook.com (2603:1096:604:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 18:22:11 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:22:11 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, magnus.damm <magnus.damm@gmail.com>, Thomas Gleixner
	<tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
Thread-Topic: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
Thread-Index: AQHct7jz2LaVerAx7UCPMGNW/Eh6sLW7WqaAgAKWbVA=
Date: Tue, 24 Mar 2026 18:22:11 +0000
Message-ID:
 <TY6PR01MB17377D3286CF6E22D27086FEAFF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-13-john.madieu.xa@bp.renesas.com>
 <87cy0v9vo0.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87cy0v9vo0.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OSZPR01MB9280:EE_
x-ms-office365-filtering-correlation-id: 1b9c589b-0070-4130-4c5a-08de89d24441
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 DVorKz1G5V3igz6yqdYQuQORVf/ACc+a86GA+zvuqezwnM+ZGbdbYNMdOgEAXFn1QpNiMehjTgjdzj9lCCjeSzxUWR2R/i/lsCWX8zWrVAalZRYGX+6hyqnfN6IRbZUD1YAhEtnZTjDpy2kDUbONakbC0uFwFdzC0e5Jowt3jSt0g/Duv7KBdRQTGCBVtwnm0TVXAmvme6KoGiYNCNjAVRIRaNqVLaGTNF+1gE5E9LttE0xkoGuuqf3f/otD5Q6l4ogMB+5k28Iq+QBQ0nPShOOdUaRa+0StU+M9Se/aYavNpqy+lO8fhTUjtdEijb+jkZRYc4qa0jh6ATax70GtVl4ZAJ3CBZmuVlDkLPtP+W3kkR6VWeULGGqsNoj0TpEOYYp27Avd62QFuPT0JyIlhJbJIBMw7Ykcytf2nT2MCEjNc4/edy2gUUB96fNjEKlATuFiKfZs/JrfROLehIsxfC5YPS9fcRkiO8IUoTJ3pdXVOLQcG13JD9E+t368eKXaP8uVXiTg84vAsCc7V6Ixcxq0VVoLDOymGJmGjS3FVO9iKu7Erd812EF/E97uwoESoWob2bawGAylF1islzzSmVKkkAhXIi9pS8ZvLSR3u3N/qIQDnUFcpt3e8XAQhi/XMNTpxYWLe2X48XIGGfIdZo8HVxpu8+vSgqhEAV7yKuVKAHWfuAkQY84aAOyh9GnnU9ufIqgFxtZevCxBC723L64yUwl8ZgTpYCFkFunqPCmNXOMy2blpyJtIwxZXCv1XX0Ivy1u7ESONTg+vwk0zZgOEKWLKR4s5MRwEebz1qmc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IUPE8ASKw8befjgQPp68JSezfyXHCKac2GG13oCsERtkllFbmmSyYXDUCn71?=
 =?us-ascii?Q?0zH+VJSDz17jyri1mM8COaWi1zejMTGgzh6F9BylhUraU3nfahQlwka6tN8u?=
 =?us-ascii?Q?Br5nazb4nDcPi8Na7aAYjMrKQDocVRLLwxXz9Qqkf41ef4Lv0o41/6V6K4ME?=
 =?us-ascii?Q?CmyqpU1y0Sm358hsmKKHiGt6swHAFY0DsBfkZh9mnHXNEGt7ZiHvOxoGArkm?=
 =?us-ascii?Q?tCtLGl/TH289pnhMTS9Y0LHC+kvaDDU/LA2FuJnN3zbLS5x6fMPMTEmsLmfA?=
 =?us-ascii?Q?NHgmFAKg8burnFM0Q3p5ap38rxdUGUXmKIK0OCLvGrxQtVZsT8N4DJJueDpn?=
 =?us-ascii?Q?6BgSKAVcig95YpdXYIZ5yqT5w/Y5JMrRh5OAMjJ9eWN6P0QP9rWULrMeMBcx?=
 =?us-ascii?Q?3QxBRGp3iVaHUIjiI73rDxO305xaTXxqM2cb+QeEPQhWmunQSf0cXlXqfI8S?=
 =?us-ascii?Q?0jBgckLG3dwXShEj//BsJBgCApwD9wl3P49vnyRhkQLIG00A0XxK6kGBZCIb?=
 =?us-ascii?Q?D0G0Fo6BmLuGQR3F95aD0ljkPkJ4nOMepyUYHQKM9wZRDyPHf0Wwb843TQCc?=
 =?us-ascii?Q?c5s1/GcfaJR9meEocZjPh+0l6HaHGwwpi/hbZ8NYKEsrenCD6jlrCMeJAd0a?=
 =?us-ascii?Q?ZlMv/iIzQVRkLzdigMRv5RTI3flUoIEXATkYXbiUX1az/dK2VOafFeNj/8g7?=
 =?us-ascii?Q?MdmeCLi8ouSrai7htP7Py0I8hztap9M+WphxF1qCmsrl9XEjAZqN9qGjhbFx?=
 =?us-ascii?Q?4DpXGCAz8mCRUlaXqv7ehOOkBv2WgBKiz3pCk/JIz/ovEnvEuliSDhuBEqtF?=
 =?us-ascii?Q?5ZWU5synOWkonyJmvBUi1Wt51IJpeFwIqDq2Skv/uMFCDIq2RiupzUDLpuTw?=
 =?us-ascii?Q?1jt3vQnpQAL0PPdEW3lPMRCoODLKuRB4n8ec8Y70KB4vh/V2hIcS2UgiWCMB?=
 =?us-ascii?Q?kAe6NoePm7hcsWOIghjWcn1Ewf9o7H16DqoVRdILsPMipC6CRR72+FxD4ekP?=
 =?us-ascii?Q?2gNJDt91czlw/eOlLHIrBd7jOjsAylp8leduMcPVHde6ZtDGNhYhOpJybrDp?=
 =?us-ascii?Q?MyuKb7/4eVDYe05N1pgxq9ig1wg7RJigqeXdVKbKXSNfDaEKlfpJ7JqlgkWj?=
 =?us-ascii?Q?F4qMg4GcZO8OSkK8Dr+PsocoAyof6uAipoZhrOdxcGMvtriGM1M+YpDFxeek?=
 =?us-ascii?Q?3WY8sjX6acAIkIaZbOsbdCmzP7/wzPgOeDWZdGvxW6tN7TChPPuoQQ+105Bf?=
 =?us-ascii?Q?V1bprcjsMqDZv19USBZctAILyhUH0ZV0+Zj2JoKCwD3vWldxF01cjIu0/lJt?=
 =?us-ascii?Q?C80erge9LifiDdd1S3haJHppcUfIrzUlGjHT2JDX3ERq+EhZt/VOVncyREYi?=
 =?us-ascii?Q?Spe1wPCnw7BxqSCjAIyy0lIHHQxVEQpfUuXUl3Y80lT6HRXIYv01SqdwPh9M?=
 =?us-ascii?Q?L9eZf0wv4f4Yn5kFZSfF3U862CClUd/w+uWGHppIKK9JzVb37qazqre9fnfv?=
 =?us-ascii?Q?bf64TNXP0sfipWcxjl4HuS7uw7O1e9wTnfZ45Hl1K4nbFwXfHsImHplFR6LI?=
 =?us-ascii?Q?AA5G4e3w0TVPFLrhdFmGyMCnowOkmoy6SYoxfG94ypZ0Q1NjskNaSZCH+6Y9?=
 =?us-ascii?Q?1TpR2cDCsZHCF9gzN7ohXv+q3MxDhVCDnmVAv6GqMIDuQHLq6OGuM6OMlfIb?=
 =?us-ascii?Q?vyv7j8KteWOGBXnxLBv8qYTsrQIKaWyVulhuw4h8KIAlRw36JiguAhLGbPNu?=
 =?us-ascii?Q?GUoi+TKRQH+tR16Bww49D0cvULsQXAQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9c589b-0070-4130-4c5a-08de89d24441
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 18:22:11.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g50etYsLp3miLBNTOpZLvYtsp11NFhCuK1v+44yb9ks0xPmq2Jcz/Hds8fK9e2DpPGPYTU+/kWsC50R8HsRxf3rVrNhGSRf2zkkHAJAC6YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9280
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9630-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 2D85C31ABCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 2:33 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
>=20
>=20
> Hi John
>=20
> > Add SSI support for the Renesas RZ/G3E SoC, which differs from earlier
> > generations in several ways:
> >
> >  - The SSI block always operates in BUSIF mode; RZ/G3E does not
> implement
> >    the SSITDR/SSIRDR registers used by R-Car Gen2/Gen3/Gen4 for direct
> SSI
> >    DMA.
> >    Consequently, all audio data must pass through BUSIF.
> >  - Each SSI instance has its own reset line, exposed using per-SSI name=
s
> >    such as "ssi0", "ssi1", etc., rather than a single shared reset.
> >
> > To support these differences, update rsnd_ssi_use_busif() to always
> > return 1 on RZ/G3E, ensuring that the driver consistently selects the
> > BUSIF DMA path. Also update the reset acquisition logic to request the
> > appropriate per-SSI reset controller based on the SSI instance name.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> (snip)
> > @@ -865,6 +872,8 @@ static int rsnd_ssi_common_remove(struct rsnd_mod
> *mod,
> >  		rsnd_flags_del(ssi, RSND_SSI_PROBED);
> >  	}
> >
> > +	rsnd_dma_detach(io, mod, &io->dma);
> > +
> >  	return 0;
> >  }
>=20
> Why do we need it ?

You are right. DMA modules are devm-allocated and have no
.remove callback, so cleanup is handled automatically. I'll
drop it in next version.

>=20
> > @@ -1207,6 +1217,16 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
> >  			goto rsnd_ssi_probe_done;
> >  		}
> >
> > +		/*
> > +		 * RZ/G3E uses per-SSI reset controllers.
> > +		 * R-Car platforms typically don't have SSI reset controls.
> > +		 */
> > +		rstc =3D devm_reset_control_get_optional(dev, name);
> > +		if (IS_ERR(rstc)) {
> > +			ret =3D PTR_ERR(rstc);
> > +			goto rsnd_ssi_probe_done;
> > +		}
>=20
> So, all R-Car platforms will be handled as error ?

No - devm_reset_control_get_optional() returns NULL when the reset
control is not found in the device tree (which is the case for R-Car
platforms). The IS_ERR() check only catches the actual errors. So,
R-Car platforms will simply get rstc =3D NULL and continue normally.

This is the same pattern used for audmac-pp clock/reset handling.

Regards,
John=20

>=20
> Thank you for your help !!
>=20
> Best regards
> ---
> Kuninori Morimoto

