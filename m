Return-Path: <dmaengine+bounces-3567-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA599AFCF2
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B04A283248
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FECB1CF7BE;
	Fri, 25 Oct 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ZYJ0YyU6"
X-Original-To: dmaengine@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2021.outbound.protection.outlook.com [40.92.102.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6918DF6E;
	Fri, 25 Oct 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845991; cv=fail; b=M1XDVWLxie4wvewvoQ7Xrs+yZHaA/09hIQMjTSvVqQWHG3wo+GlMm+NbsS6XuUV33Rn/f4tvFKMoIjJWvHRni1SZ7IjWIGAU5ZJK2FguikXfULw41SR2+aKFWnMc9lSmDSs74ky/7VWzgZHiNU1hc5O3wYv72b8zR4q74HAgIIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845991; c=relaxed/simple;
	bh=JKFPQmfZw1+qgzIKVcYl2RISQNf/So9eCTL264nq6H4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KHxa9rrjR219/nsHtSYMZPmGcut+fOs/+CImHBhC15+JUsEG2VYSTscFjZJQO2GoWpASsMH9q7TX8sZbOYrfF1Yasja8grFbzjSwOPkeQVCRufRrRmLDLktILt/tKT2ZQ8DWaLLYcRfhkv80AnARh5kt2dtoFNSXMpQjII8VQ9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ZYJ0YyU6; arc=fail smtp.client-ip=40.92.102.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDAoMGyCgUZIwfGp1VVFQ8J7SFaP79hPXEmy9QmvHbIrQk3VuXIC/IFr5tw/aoO4YpbxpW7xuuk9bSmeewyBmToGjbC3sPEf1MkIhIrq2qYkbHl+ZV0ntKtUXPoel/Ak/4tkYTpn6Long61dK6vCL2i5GhfmQyrU+m4wzm5A/5zf/DusXXm57jtlVNQ2UB1GqCl2nFrqmTWdgyMSI8rG4IXUl4zDk4Q6qtUfR0ZWlvlsldoBIpdeGrIRpfJ+d5t43EXOdZs3KoySWjf4NCrdkcrQlvm1axwm1h6kKKezD8evEQ1MQlI1YVmhtBgt8++/BDng76puGeh8Kg2YCIZXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKFPQmfZw1+qgzIKVcYl2RISQNf/So9eCTL264nq6H4=;
 b=WQgSnT5T0De1KhZ7K79pw+b7FE8nXJRY5PLrq+waFSX2qjO8cVHZ/EVXO+tEbs2YIO2LlAeeRu0XwNDv4AbJdQ4AXnEsgtBodnuWo+1f9QIV1cPxtF5sFsCKYEkSYyLUGw+jdhSs2SXm9nYVkwA45c4xiOX98z0g0x8Jbg01RXOPxl/stqPuBH47cJQVJ1CCS29ERdHrYNFXAjgGMphndj2bI5d93VBnFbW1Bn4cGo730aFxtwRBumSsy0EZLPe68xwjdGyzP/JOXAp0Jw32SOAI+akEmNEt/7nlGlsviSd/sssc7yNRxZea9PH7qIH+zXOEjMRc6EDuYLScQ66FEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKFPQmfZw1+qgzIKVcYl2RISQNf/So9eCTL264nq6H4=;
 b=ZYJ0YyU6g0k5Rhl/d5NmYEel5UDbFx9nQAeCD+qpVoypryFORYUXOF8pfYaqJP+i26LTMGUIukJUOC9tHoVXv2JfThTShSLNF8qYNfga0C0hkd726PwwA39I9esZ6KtIpfcVcEGDTmftVQGmRnrDkX547RGCbDmg5TL/AbgZVejHs+oAXD8pIKK5H99yFLO78ZnjEASAa/RAc+1X+ZyLFNHx/sruwdZevyE002ORYuUGh9iHv43WkLqaZl80aXxLuE7JQE2lNJAbBb8ke+/6SEWAXsiV8G9RoETCwsdwBXLIRLs0w2bJLoquin8dF2BK1JfGm7GKRlIlIIU89z/ncg==
Received: from MA0P287MB0594.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:119::13)
 by MAYP287MB3581.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 25 Oct
 2024 08:46:11 +0000
Received: from MA0P287MB0594.INDP287.PROD.OUTLOOK.COM
 ([fe80::621d:8529:f377:8921]) by MA0P287MB0594.INDP287.PROD.OUTLOOK.COM
 ([fe80::621d:8529:f377:8921%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:46:09 +0000
From: thomas superb <thomasdeutsch123@hotmail.com>
To: "nikolay@oldum.net" <nikolay@oldum.net>
CC: "aospan@netup.ru" <aospan@netup.ru>, "campaigns@fsf.org"
	<campaigns@fsf.org>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "ddrokosov@sberdevices.ru"
	<ddrokosov@sberdevices.ru>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "dushistov@mail.ru" <dushistov@mail.ru>,
	"fancer.lancer@gmail.com" <fancer.lancer@gmail.com>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "hoan@os.amperecomputing.com"
	<hoan@os.amperecomputing.com>, "ink@jurassic.park.msu.ru"
	<ink@jurassic.park.msu.ru>, "jeffbai@aosc.io" <jeffbai@aosc.io>,
	"kexybiscuit@aosc.io" <kexybiscuit@aosc.io>, "linux-alpha@vger.kernel.org"
	<linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "m.novosyolov@rosalinux.ru"
	<m.novosyolov@rosalinux.ru>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "mattst88@gmail.com"
	<mattst88@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"nikita@trvn.ru" <nikita@trvn.ru>, "ntb@lists.linux.dev"
	<ntb@lists.linux.dev>, "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"peter@typeblog.net" <peter@typeblog.net>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "rms@gnu.org" <rms@gnu.org>,
	"s.shtylyov@omp.ru" <s.shtylyov@omp.ru>, "serjk@netup.ru" <serjk@netup.ru>,
	"shc_work@mail.ru" <shc_work@mail.ru>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "torvic9@mailbox.org" <torvic9@mailbox.org>,
	"tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
	"v.georgiev@metrotek.ru" <v.georgiev@metrotek.ru>, "wangyuli@uniontech.com"
	<wangyuli@uniontech.com>, "wsa+renesas@sang-engineering.com"
	<wsa+renesas@sang-engineering.com>, "xeb@mail.ru" <xeb@mail.ru>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
Thread-Topic: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
Thread-Index: AQHbJrmTO2m52qT8oUye+I/sF+SUew==
Date: Fri, 25 Oct 2024 08:46:09 +0000
Message-ID:
 <MA0P287MB05942920747924ABB7B0365C8B4F2@MA0P287MB0594.INDP287.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0594:EE_|MAYP287MB3581:EE_
x-ms-office365-filtering-correlation-id: 6d727a70-1eac-4a40-f14e-08dcf4d178b6
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|15080799006|461199028|15030799003|19110799003|8062599003|8060799006|3430499032|4295299021|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 HDbMVXnnTopariHKmrNZ9Uw6miA/2ffBqzuKLZqtIQLj5TODNdaEmY9LIOQK+bcwEjX9j2aWB0fIeK3QkE4LYVLQZ7nP8dC1/iJy52Mk3Ea2SnTkcF9Z5Ai5QalgYrtjaeZoZ+FVsB6RX1i15qkwhrQHLjjOQwrXUIHTanFYq83umVI8XSxkYbOUEzY+7ryb74uHiHH57Ah7sRebjUNIjlQ6c4isWolr/ZHW5pLKbs0SuBCfBVeFtCZILUyt2Nk0cGZ4AGbD9YaixKVJrqA4ftJcLH6eJBxPo3bSGlRgBK0Itvf9qlHyZEuFK5NbrE/fF8WIXMZ88BMZ+PzJLlTSdl7Ebx6YYR9bD5NjtXPR2gkU0qYxjlG8r1FFzngEwZLGln9b0a4Bij7wWjHucDQjdqSPkcCZKOHm4oQIDQRXdQLdh+uiyT7yFmzgI7bwHrAeioDVGKYZPUAx3LCPlCVvW8+aDP69umbR9PnZBs2PG2FfGJkE+Km5JmkTYvvpUUTzMUDZ/7caKTOFIqbQbD5yjsXrwhzdP0jaypn7ZXssH0gsh8sbgq2xJOk5nRhwqu6zeL52JK4+73tbn9lR2xCOwffj+lyVvZVeWW/vrVf6qQUjRjgk3fyU3qOB3AlKaOWN7lcHy+dzhC3n2Ac4rpibuBA6/ewQk0ZClqb4G//eGeybOVc4epB7wY8AfPyDSDK2xeyPj7toH7qhqkMH2X37d/gZrwHXi0w9bTbdgOHwdWM6P5n5XJoiG89HqyFuHOjxl39w6rtSDh2Yud1tpDSoQw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?L9WFzDji0RbJrCBg+TK72DF+9CEeEys3VnbQZubdBF+A/gRFYLjTAFFS?=
 =?Windows-1252?Q?OQvwc4DirfTw0aIR8rJay5GQUtDZOdmMHvrbuzwq7Y6VK0xLNfDc/rtV?=
 =?Windows-1252?Q?IN5YKifb3GVCopS8Dj4tJSTUoB2mThQoDXNxORmFZ+YqUS9jYy+sNmD5?=
 =?Windows-1252?Q?YcX7Qy3FWxiD7Fem851MZy5jM2kEVB048vm5OyEvOYsfZH+/l/MnzGXV?=
 =?Windows-1252?Q?z4i/SfZWe122kFRxpete3xsTB+ke1Lo7vngXbKqfx/i1RAjLnvUwVTAT?=
 =?Windows-1252?Q?5NW5VzFsd8+Qm4HElctYMDLeo61sKwm8BZF3ET57XJYB6+ua3GbVd47f?=
 =?Windows-1252?Q?PUpuX3btSqYizZUHbg99WJYiWwjM+jDSKaedK9FiK4vcWo/PWsnrjq2Z?=
 =?Windows-1252?Q?zgf4xt3Yx5nbB6dgCuh3jLMX15ZW1r8El+a6uHrFNbp7IDeSijV2Uuq+?=
 =?Windows-1252?Q?PNZYRocScZsUamuo3TMenMxoi0HOjiscbcxumx/90+HCQh/680/dBXM3?=
 =?Windows-1252?Q?UKqb4eavf8js7OT3o0qoHzlBXoE0Ark8Vmtkz2NLHTvlWRqPopddUyM0?=
 =?Windows-1252?Q?QIq8gJKoWVYCCfgWVUpYzI/aOQEtQlDfGEWHH3oH3or04Nn33MiRn1oG?=
 =?Windows-1252?Q?blWoaQmFkEf51iiox9VuzAnjxZjttNNryf5sRD+iOy5BPdUfXV5fTRan?=
 =?Windows-1252?Q?g7AtrjIQPbsX/0aPZkHVx6DJzQ/Ie2shllpO4KylRTsFE/TLhJMsS9kY?=
 =?Windows-1252?Q?F+kRx0j10AOJjeQ1UnSaWLCnEqI3FsbL9GyGpPx5V9y120mNZu0LKgLf?=
 =?Windows-1252?Q?M5+J8RJIgKpgXKAEjT2RVtXtHASa1wuY6FIQDUV2oxhxr+ZLtJLRoH7k?=
 =?Windows-1252?Q?phQffGTDH3cKZymdnOlgyK4PvBq9l/gFEWjj7VGzXTu65fmfxOv09OKC?=
 =?Windows-1252?Q?K8LK6Cx2+nQe1EgOQLYTJnr0PSSOy/bmANLS6AY3fRDQuwmq0ZGgsIsg?=
 =?Windows-1252?Q?4aPRm9hhZeW/WIv83fmMXRo1ME5V9dFD0NE5eTTQVPN3KkflTpxG+tln?=
 =?Windows-1252?Q?Ho47Zz4p6FmFautLhT0cJJvgxJz+spTD+Tu7IoYAEdfpqad7X/O9mdn8?=
 =?Windows-1252?Q?kslmXcDAokbAgEsNOg8PPuq6ROG+EcTRk6On9NHhzVIyM8X6ZxLbc8l3?=
 =?Windows-1252?Q?KN3gj5jLMbVZjgBrfp96hX9oIYsD4NplJ6DYHnuHasfR/aq6RyyxFHOp?=
 =?Windows-1252?Q?x3d4yJwVgnQik0BX7RDyiKAcVe9RBap6NLXOCqXMS3dzj7tmtc7xOWPX?=
 =?Windows-1252?Q?/CBobQmf2GhMjH+0j8aQOLcFg14=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-24072.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0594.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d727a70-1eac-4a40-f14e-08dcf4d178b6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:46:09.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3581

=0A=
Hi folks,=0A=
it is very sad for me to see so many political nonsenses=A0here, therefore =
I need to express my view as a newbie here and a long time Linux user.=0A=
I understand the standing of Linus, but sanction against a certain group of=
 people is unbeneficial for open-source projects: at one hand it is technic=
ally impossible to stop them effectively from obtaining the new code and ke=
eping =93hitchhiking=94 the ecosystem(think how North Korea develop their o=
wn distribution and produce smartphones which probably also use Linux kerne=
l), on the other hand the upstream repo and community will probably permane=
ntly lost their contribution.=0A=
I think Linus and Greg need to reestablish the trust that their own politic=
al standing won=92t jeopardize the free essence of the Kernel, and the comm=
unity need to start considering how to defend the critical elements like Ke=
rnel of the digital world from political pressures (whoever do it) and keep=
 them free as the air.=0A=
Thanks,=0A=
A Linux user=0A=

