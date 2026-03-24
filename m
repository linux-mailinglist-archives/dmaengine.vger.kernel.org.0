Return-Path: <dmaengine+bounces-9627-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDX2OsanwmkyggQAu9opvQ
	(envelope-from <dmaengine+bounces-9627-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 16:03:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F83179A3
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 16:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E36316C6FD
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF2401A0D;
	Tue, 24 Mar 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OgQPgJZ/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010014.outbound.protection.outlook.com [52.101.228.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFA401493;
	Tue, 24 Mar 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364196; cv=fail; b=AfAvQo/B07C/25QZeolazxXDDv7Y4vAScHNsphT0Ju4b5DMxAPkIefhpsQU/k39plXSrH89fMddY74bX4Ftv4dXJWwkR/lZtorVePRWjRQ3QiwDJl0kBHKbbckJh/cjSB2ANyhVTALB3BeWFQvbAj4cRbyW+v89jql6mS1ldsE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364196; c=relaxed/simple;
	bh=3CiF5h/AeAo7IOjyyN9irAUyTsUQdLc8bDr1rDBLxDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=izPzUtnuZvqhw3Tyjpcz4Tg65yqxuPZw0Z4X5b9/doTtAVfy3OqXTjSL9XcHT9YVqJu11/OXcSD2sURUGFDxZU3F4c0Kfx07rxJQytFjS5l9SNuq5SNqszqU218dUBHDl2Bcv202Ik4YrrUJggdiifVIDuC7Q7T2gjtjZ3/YUdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OgQPgJZ/; arc=fail smtp.client-ip=52.101.228.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt3uQ5DZNIQXZ/8Aky/WSpQ4uzh21XeG4IuLjwJ/gvWPdlgUMQelxDusw6SmAkqvyGzL0VAXutaxBvSpZ8g8R6NK44sCoB00mTRUaG3Ht/PtGDYfIpspvM0Jcox2sC8aZ2QHlXvOf0F4/g/h5wuUQhwOrpGyXaXVAHp+QK1WOmgEpWY4bqcfQPIFdt4NIgtEY3mc3AB3L7ClPP4bUpiuFJngclnonBqwSQTI9jiHa78+ypPEWX52f2q5uKnyQ7n5G0/W530K3B8jl+Stc7cQI/KYzdI2p3Zo4gR2QRwoAhRZ9ui6ig0d7ODSJSF97he3b5oa+TGuyppPJcFr3VGLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw5MlVbECTH8tk1le+3d24CARYej6JdYAKoL6GS3eEE=;
 b=Z0DZfzYNO9VsO3QWgEbGNcIoL4bwnO55uiEWRt8m/oYoVo5JpujZgnca5AY69MqCS0fFVz8eVeXJNf0/WuSHg06uuCQGWtrCiF92wW+AUdnbV8KVkcPjnAXzcZTRSbkoEkY6tH7J2/ErqSgy3Rzt+0LWTN7l5pcbSAG0ifqyToY+tj0iXfzd5I7khjZrJEmG6uE5guh7yRAsPl+HS4ej2hweD+fG6wtnTC9xDhZ3aimACxAoA8c2RcBXHvStnCmQpMCt3wA2o9lLWGawMJ+6L6tfAKUNCgM+ASU2ae659Ic17eRTOEEs9N4xaq1BQhht6YbW98gAs8MTK5aTH5t9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw5MlVbECTH8tk1le+3d24CARYej6JdYAKoL6GS3eEE=;
 b=OgQPgJZ/Mjr3kI10IkQpHapYdhQ1s/64KjQaTTwPQ6ydOhgTvG+bVy97uROb9lgmbd0flffSzGm2kotBL4t+9BBeIFWmnA1FqTd/IUvxwhl2ZFeEBg6sWnU+TLppeUTDgGpEDgLToCA58tZcCQfLjhY0fPq/bVEnAVCGHcAbRRU=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB14915.jpnprd01.prod.outlook.com (2603:1096:405:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:56:27 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 14:56:27 +0000
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
Subject: RE: [PATCH 09/22] ASoC: rsnd: Add RZ/G3E SoC probing and register map
Thread-Topic: [PATCH 09/22] ASoC: rsnd: Add RZ/G3E SoC probing and register
 map
Thread-Index: AQHct7jjwhFoczrdQ0aCFW8UcaKRYbW7TbiAgAJ2muA=
Date: Tue, 24 Mar 2026 14:56:27 +0000
Message-ID:
 <TY6PR01MB173773C4F9DC58C78FC801F91FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-10-john.madieu.xa@bp.renesas.com>
 <87ldfj9xt3.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ldfj9xt3.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TY4PR01MB14915:EE_
x-ms-office365-filtering-correlation-id: d65e7b17-c1d3-4206-3fb1-08de89b586e5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 nkYlQ7Zi6OciNsobXL1Tpi7M8wswyMDKtNZK7oIeJJDOv4EF7pkQF8+W9USjBwdMyyD1qMvKHfw1mmZx4a4liKi96vpQr6bq44S+8AR9jty4Lo/00x9BMXNxRWHUwp4Ymy4SVe7N8VPCS7U7/DmnK5UZepcYlhiMV6ELgJbMmxP4sDReFl1vwjEiroctfG8LiJ9iP90j+yRn4owQo7lX4ETSwqtyMQbzIythTH35ytl7O7Eiwpi+qShzFQvhZgbXYopetx6TmC+2fWcsmKT3tV2lQjzV9M0WvnYFOMlp2h5dPOnNGPnfLDrFaZY4S2fgvGqrztUYWqE/Hml1X3xTmYmNKc1vn71X3dN9nA1NlrX9iKa/L+9GSdDMUpcGefZpmyDHfCfEzyboFsGmY0cabATNoAqei+NTq26HTI1ak0VAxnwDQZW4pm4Je4CnDy8DIvIJk7NVyaInR7SLmqKvCQFPbB20WVsaAELWqOEcJaSgHzEBjJ6qImHD9guidFpjEsQgBvEDZ+k0X7QCfNYXSJmanu0kbiEl9Q8dvijm9JnJ30ptJ2yyJOFBj4LwJXg7I/sC5iyzlPCAkZ3Euc6sDfZcuZ4TgfJaCBg93kj+fODk2u7ry4lHtY53i4xGkmRuEl+eTxSQag3C+zgcAzaVfEF16jJMxijh7rH70xH8YtF+cHvB5gNJ3DxK2LA6qdgcbVIL57hrkUI+iNO7EbeYLP4tqOsD1GHLRT22vdClLEC/IsIwWkLh+z+Ewv/SrJ5M6aUlbKYrgKlZgTuIM2rglIoGp3xWKzWJVYjYErSZV2A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h6yOexLb6OVNP/WRPyENX1lVfs4wm4n8N3SUdW1PJC9USR7cj9Q5W1X2v+GZ?=
 =?us-ascii?Q?+Rc01tTFRAg1XrIwhpisEtSVoQRnc1/3Bj9Q7gVkYoUOU0mSEEMw/badGz/w?=
 =?us-ascii?Q?zf/cQ99NxRa7HED1azyrNErVsqJi/EumCX7JEtcvu2wdRIFokaVGkZMATYUJ?=
 =?us-ascii?Q?12thoFkAsoy/motVeXU2Qx7IetbQlIvLy5vhi/DcOF+icwy0oio16ZwGCdxq?=
 =?us-ascii?Q?wv0iU9bjqO1mbWKrUO1FJzg8HiZK0w2FE5uJe6L7cqX9pWwSFnk/7on4RSSv?=
 =?us-ascii?Q?OI5VIv1rVX7hSjijWA9dvfivL/SJC++TXGRxwInPU0swL26BWp+JChx4XzbQ?=
 =?us-ascii?Q?dQrjyO4aEEfFdvFAjK7XToMZdAd984EUGeVfpUmJjKHuMvWKSnzPaM3KMbi4?=
 =?us-ascii?Q?+81oByHon1MNBZKRaJGzT8KlRN2gaEO1uvoNL3qsqXvBRZvRixnvB9ixVlAD?=
 =?us-ascii?Q?uAaQ0S0Y4NpLG8KtXKUHieyiTBxCZtzB1xKsZ1Hh2APsCNhH1ZNt4v2rKU1G?=
 =?us-ascii?Q?vsYikomzb3fQebNloLGZ60sdJLH8SgzlFdsCfTJL3MyARAI4y3522pFp4fGY?=
 =?us-ascii?Q?kzSbrqy7td9CRiu3b7dNF2vTDnfoaqVAgEfLKxqcd20kbgalVhQbzISmhX5o?=
 =?us-ascii?Q?6XA6cxUkVGTIsz+fkNZGg3CBrQN0kz3/4qtLNTpaKbMW8h0lL8NroNMLufjs?=
 =?us-ascii?Q?sB+vucEzMfLKYNANT385OlrIeMCE9/KbusrESvcCEM8EjZ1GOr7ntfUUA+Gu?=
 =?us-ascii?Q?PO6veP3VBv4pvOyXVRYuGgICpS6V0A9akqwajRmSkfefjVAUgsaMgWI+L+ln?=
 =?us-ascii?Q?VtWPIcwSX/b4PWe4fX9oP4092yACmg5jE4+zt1mPacS24kk5XLsSbX3332Wb?=
 =?us-ascii?Q?mtYc+wI9m37wqK2M8ci0Mz79P6XBqlH6JGyeiKDLgJXzRm3lgIg5+2ObhccI?=
 =?us-ascii?Q?1084YvJV0XRNCEyhl7Px7Lole53lNKZWmXyewx4dKbneA11QV6+qg/Ep4qwP?=
 =?us-ascii?Q?v97zvBx3ASH6mrapLfGtFRP0ecZWLTtiT5felaxMznWBRajwnsvIoG/G7+X+?=
 =?us-ascii?Q?rhwivdSaMoa97rOIntDJWr80lIWOjiPlmaYURg7ukMxM/RoIiy4/kGp4tLnd?=
 =?us-ascii?Q?ONGJVn9jy58v465PHx1BSapabgamu2m/2QOc7U93u9R/W5C8NPUW8KetupId?=
 =?us-ascii?Q?HLTDAABIVqrVOBTb+OFWkGS2rBspMffXX3/Cuo2qqhNfyI3KRzJ0NZUAzjQA?=
 =?us-ascii?Q?WkUH3bK+lBCWYjBky0iUDGBi6yQbNiMmsyzCK0ehVGx3oJouKo/MbhoTg3Eq?=
 =?us-ascii?Q?DeEj/cKbLJFhJZJneODxRKCRoTdw7a1LjbJdwqmonT9oXLhjAVZM2R2ynStd?=
 =?us-ascii?Q?Ap+5bEtupDqUJ9Rj0fAIHfaxO3cWZlmemZKgSfWAB0lIR2WRXc0PSiKPOSyg?=
 =?us-ascii?Q?PpghxT0foaliNFOxh8e3uEO2j0X2IYaW8TjXKmpERMvhjj2U3soq4Y+38yS6?=
 =?us-ascii?Q?jWXxocweYElt/rUfX5cF382bFVRtkHcXy2TNnZ2vGyxWECAC22yblvT4/ik5?=
 =?us-ascii?Q?vhxM6JkNpsr4uAVWJWY0A19xc6ztXxG0D3/fRdv/JG8c3rrAG0VMjqRjRi6A?=
 =?us-ascii?Q?k4vJkSe8yqrIOVZn/bIU7TbKF8PyPGHn8rWLYPs2A/GnHoUohH9PfWhv4b0A?=
 =?us-ascii?Q?rK+Zem+ufsiyubiQMkTmW7rmrt3ise5zqE9R+oJd+X1aIha7+4tNoNkwfTPO?=
 =?us-ascii?Q?mwABxOuD62+2wBtu/SK4OMPRSGMhuBw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d65e7b17-c1d3-4206-3fb1-08de89b586e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 14:56:27.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkaRvTQQB1QhQtZPMXUwrmIIKkaDCZy57Vcd+Ihd5InPxmr2p4NcDYz6yWVwfcqq7zL95SMQRq2CF7DIamC2433KHNkxsPB46yjtaQaGKKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14915
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9627-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 461F83179A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

Thanks for the review.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 1:47 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 09/22] ASoC: rsnd: Add RZ/G3E SoC probing and registe=
r
> map
>=20
>=20
> Hi John
>=20
> Thank you for the patch
>=20
> > RZ/G3E audio subsystem has a different register layout compared to
> > R-Car Gen2/Gen3/Gen4, as described below:
> >
> > - Different base address organization (SCU, ADG, SSIU, SSI as
> >   separate regions accessed by name)
> > - Additional registers: AUDIO_CLK_SEL3, SSI_MODE3, SSI_CONTROL2
> > - Different register offsets within each region
> >
> > Add RZ/G3E SoC's audio subsystem register layouts and probe support.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> (snip)
> > +	static const struct rsnd_regmap_field_conf conf_adg[] =3D {
> > +		RSND_GEN_S_REG(BRRA,			0x00),
> > +		RSND_GEN_S_REG(BRRB,			0x04),
> > +		RSND_GEN_S_REG(BRGCKR,			0x08),
> > +		RSND_GEN_S_REG(AUDIO_CLK_SEL0,		0x0c),
> > +		RSND_GEN_S_REG(AUDIO_CLK_SEL1,		0x10),
> > +		RSND_GEN_S_REG(AUDIO_CLK_SEL2,		0x14),
> > +		RSND_GEN_S_REG(AUDIO_CLK_SEL3,		0x18),
> > +		RSND_GEN_S_REG(DIV_EN,			0x30),
> > +		RSND_GEN_S_REG(SRCIN_TIMSEL0,		0x34),
> > +		RSND_GEN_S_REG(SRCIN_TIMSEL1,		0x38),
> > +		RSND_GEN_S_REG(SRCIN_TIMSEL2,		0x3c),
> > +		RSND_GEN_S_REG(SRCIN_TIMSEL3,		0x40),
> > +		RSND_GEN_S_REG(SRCIN_TIMSEL4,		0x44),
> > +		RSND_GEN_S_REG(SRCOUT_TIMSEL0,		0x48),
> > +		RSND_GEN_S_REG(SRCOUT_TIMSEL1,		0x4c),
> > +		RSND_GEN_S_REG(SRCOUT_TIMSEL2,		0x50),
> > +		RSND_GEN_S_REG(SRCOUT_TIMSEL3,		0x54),
> > +		RSND_GEN_S_REG(SRCOUT_TIMSEL4,		0x58),
> > +		RSND_GEN_S_REG(CMDOUT_TIMSEL,		0x5c),
> (snip)
> > +	ret =3D rsnd_gen_regmap_init(priv, 10, RSND_RZG3E_ADG,
> > +				   "adg", conf_adg);
>=20
> I don't think you need 10 ADG.
>=20
> And it can be 1 line here.

Agreed. Will update in v2.

>=20
> > --- a/sound/soc/renesas/rcar/rsnd.h
> > +++ b/sound/soc/renesas/rcar/rsnd.h
> > @@ -26,6 +26,11 @@
> >  #define RSND_BASE_SSIU	2
> >  #define RSND_BASE_SCU	3	// for Gen2/Gen3
> >  #define RSND_BASE_SDMC	3	// for Gen4	reuse
> > +
> > +#define RSND_RZG3E_SCU		0
> > +#define RSND_RZG3E_ADG		1
> > +#define RSND_RZG3E_SSIU		2
> > +#define RSND_RZG3E_SSI		3
> >  #define RSND_BASE_MAX	4
>=20
> You can reuse existing RSND_BASE_xxx

Indeed. I'll update accordingly =20

>=20
> >  	AUDIO_CLK_SEL2,
> > +	AUDIO_CLK_SEL3,
> >
> >  	/* SSIU */
> >  	SSI_MODE,
> >  	SSI_MODE0,
> >  	SSI_MODE1,
> >  	SSI_MODE2,
> > +	SSI_MODE3,
> >  	SSI_CONTROL,
> > +	SSI_CONTROL2,
> >  	SSI_CTRL,
> >  	SSI_BUSIF0_MODE,
> >  	SSI_BUSIF1_MODE,
>=20
> Do you really use these reg ?

Yes, they are being used.

>=20
> > @@ -627,6 +635,7 @@ struct rsnd_priv {
> >  #define RSND_GEN2	(2 << 0)
> >  #define RSND_GEN3	(3 << 0)
> >  #define RSND_GEN4	(4 << 0)
> > +#define RSND_RZG3E	(5 << 0)
> >  #define RSND_SOC_MASK	(0xFF << 4)
> >  #define RSND_SOC_E	(1 << 4) /* E1/E2/E3 */
> (snip)
> > +#define rsnd_is_rzg3e(priv)	(((priv)->flags & RSND_GEN_MASK) =3D=3D
> RSND_RZG3E)
>=20
> (5 << 0) will be used for Gen5.
> There is not detail rule yet, but I think we want to keep (x << 0) and (x
> << 4) for R-Car.
>=20
> Maybe you can use (xx << 8) and (xx << 12) for RZ ?
> Something like this
>=20
> 	#define RSND_RZ_MASK	(0xFF << 8)
> 	#define RSND_RZ1	(1 << 8)
> 	#define RSND_RZ2	(2 << 8)
> 	#define RSND_RZ3	(3 << 8)
>=20
> 	#define RSND_RZG3E	(1 << 12)
>=20
> 	#define rsnd_is_rzg3e(priv)	(((priv)->flags & RSND_RZ_MASK) =3D=3D
> (RSND_RZ3 | RSND_RZG3E))

I got the idea behind. I'll switch to it in v2.

Regards,
John.

>=20
>=20
> Thank you for your help !!
>=20
> Best regards
> ---
> Kuninori Morimoto

