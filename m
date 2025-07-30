Return-Path: <dmaengine+bounces-5896-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F8B15AD7
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 10:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAA118C04F6
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F678262FC5;
	Wed, 30 Jul 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="yYUjyM60"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC972512C3
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865033; cv=fail; b=MwAgeQdnkVxn0FE7MOwS3HtBdC9dXNAUBWlp2VcGKdsWvB/liHGTflZZ5rpsog1hXOzx1awWSEZSbRJ2NvxBBdeqjMeJfXDq2czJcLg8LdkpqgpvB20TzOOEFbUZDhXK+fq9i8d5NnK/fQ5SpBzDjqzJ+zXf0RX33QeWfCroijM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865033; c=relaxed/simple;
	bh=9LDFiET1kjLX7N986fX8X3VV8nEm4XL99AK20FdgsZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGiqbdMzjbNTMqLYdClkrhOBEU0zU3PxtHH142GUa3vlJYa4P0l4ZI99lUnbe65AsDgazaXogfQMH1/eMzh8JcLnz4VNUF7tiz4MJsOgQr4SgtnyhuzXJYSXZXcgihfKJMlIplugxHFltWdrW3KgGbxz1opFfNpnc+QV//Pq+ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=yYUjyM60; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdntQtEAdTMZCOm7ZSyIp1BBRL+4cwKLw1SKbxZm7VWzmlwYnCZ846fq+bz9p2L0ShSTFaQwwy0j+blevALUL95gvLLsDsO0AX7dmInoak8yxPvg8dQ6xgcH69wKDhkrqq/LhjkhPmO84NZW20Sl1wBdVSI605is0+dTO/mgHjr6roBwr+5Lh9bgdunkz3VNy/eHNmXn3i+w6i4FifHWQMz3MBtIlOVvLZYsV0ovYcI9+Ggy0VCJiI5c3KTef4oaVBhuXFpL6quxHrPFOd9bfkNpvEn51sAZHGL8l8wUwhsGmfbwWYIcdcuK5dDgleHHh0i5939uRBNEYzV2Ds9rAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LDFiET1kjLX7N986fX8X3VV8nEm4XL99AK20FdgsZw=;
 b=JZma77vc66OVfgE4S4fXV7mqno7pKwgu0882RIUKqZYUi2pSydoPpsgjhEMicnBSUwLuij3wdt9ncugdZNmcBe2lbXSoUIeYtsUh6R/S7iTx14sjW8airGI5J62VAHovEmu4NGsctNkvkh0b+qwpfZ9TrqI82U10CdBECFtv7Rc5MD3EBo67MVbHd56TdHkjL+KcbcqhkVy0vX7srKBvLf7TNnXgHqOS+JbR2pseQAS1qKS+KxO4Pid+Uu4ZVyGioz1yTbOGDHoN7wIT9ExfYmoI4y3smALHEiV7MYk7CJJI7dGDVI7u/FG9ElC9blHd5jnwt5VxcxMZixttJ/dAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LDFiET1kjLX7N986fX8X3VV8nEm4XL99AK20FdgsZw=;
 b=yYUjyM60AjfCDsNKtASyU8Qzt6ifYn1ZQ+gL2+fnMjfXgQ+1ePmufzplQLgb99GeKZspKHVGz2jAZKiaTN7OA+8oLaHhAI5y+t1qXF74n0NZnEEQPNiqzW3ulPhEZKV0jrmLcvll17nSyWDs7Yv8/q6hv/pVNMO+5lSAPXL6X2gl9fPWKLJ8OfYPACwIpYBJLI74pdOi7MRbZ1+lwQFPeHoTL4GK862K/AFRrlLo1H7KabfFo8Y63r5jWUCaE0rJk+Nes4D1Q811D40ro90neKksZ9eiWgfD6PVfsNtuzdaeox+rsRGntrhU+3c5fkmqpKJX7dGAvrCqfwRm4R8efA==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by BLAPR19MB4356.namprd19.prod.outlook.com (2603:10b6:208:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 08:43:48 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.8964.021; Wed, 30 Jul 2025
 08:43:48 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: Jack Ping Chng <jchng@maxlinear.com>, Suresh Nagaraj
	<sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH 1/5] dmaengine: lgm-dma: Move platfrom data to device tree
Thread-Topic: [PATCH 1/5] dmaengine: lgm-dma: Move platfrom data to device
 tree
Thread-Index: AQHcAP2HvFG7jtDcskCEJSSNl1x0KbRKMfcAgAAmAYA=
Date: Wed, 30 Jul 2025 08:43:47 +0000
Message-ID:
 <SA1PR19MB490993CCD0F80D63501DAE92C224A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
 <62599303-fab0-4068-9d5e-55cebd093f90@kernel.org>
In-Reply-To: <62599303-fab0-4068-9d5e-55cebd093f90@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|BLAPR19MB4356:EE_
x-ms-office365-filtering-correlation-id: d37ebbb6-a429-4b00-2876-08ddcf45337a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nftuEJ3/vMRy6zU6cEQdgbmAXPEChk+q7fobUNwcB9uNoKBRKXQAs6WOo2Fr?=
 =?us-ascii?Q?Yh7/MgJ0kjPn+dSTut7FLhbzYZd0yEPg8riFrJqlk+sZmFrgg4jr55JhKfpL?=
 =?us-ascii?Q?dhCiqGS5SjNGWBTVGIv92P1b6tXaSb6YGKh/COVhQ4082KHwXtDn8mdsHExW?=
 =?us-ascii?Q?Gwnuh9Iq8sbp3UcYpyhGbW/+XwMIxf+fpVqVtfgHrf+MTlaFIcbCyX0o9Orb?=
 =?us-ascii?Q?zdcjwekKyaWNjF/T7OLaazyareAAYeWsBCsuh1TZKhYu7IpXcj2AJRb1mnvr?=
 =?us-ascii?Q?P2hZH8IOlOr4IPtIIzO+tKyFad+BzpbnBaNrTpJDz+cWw3JdnQEInU8/G+uh?=
 =?us-ascii?Q?DFDTLe0Q8e7P1ZvuhkUgf44aTLaHZsJObKOuI4YjXlgRZxB+M5kdENCjM5rS?=
 =?us-ascii?Q?Cy8VmBML8zGXtBzgh5OOZ7r99QVbCWNLcOkvTCrrNHS0vZLWU7L/7YB2IAK+?=
 =?us-ascii?Q?p+yIm5xGmYgVNkI9FBYXhs+WUCEyaZaabmo++P69YmrYMIiPWrvMMJ51ApWh?=
 =?us-ascii?Q?tBk2VZetxRbgmytcOTFKVlwb313KamqWcESNHekd/ZzZqhB9UMTCxOlQ6yMl?=
 =?us-ascii?Q?2th6KPVTqwOAXqwiv9n0CTIs6IGUMORCZ0t3Rtd7eYF0VqzFLEqkkRXAWO6J?=
 =?us-ascii?Q?aTZRg6rwffxUDU642KzKkDHx55dI6lqr0H+zLsvq9BIFSMRYEEjvYfntGsNN?=
 =?us-ascii?Q?sLpHkRTkhheWk71CLBDIW+Pa2NN6lZ55vycMRrv7Y6maYvV+DkWupMG00uiX?=
 =?us-ascii?Q?4dPqdHZTkHJTB1/IuvmnCUK7KYF+NmUPr9eRC2iH6ueaQB0qmndQ42kVF9Hn?=
 =?us-ascii?Q?MtbDoRWo21X9vLjDJqOAwPg3Wi7npIAbR5yJMyIXQ6vgrzOi2+y/Vw45gI5F?=
 =?us-ascii?Q?r6kZb5CqXNEv5dM889aHAXZt1nzU9SvaeKvGHdsA4sjQwT4LbTEZl3+nfrcN?=
 =?us-ascii?Q?BEzSZxD7prW403YwZgQrXxG706E/WvP/lbJ5/N7iZ6iSfn7ZFradYOrC2dkm?=
 =?us-ascii?Q?HH+sQBORACg2VNdy9P5Pxp5bRxVQxiopLNajxOcPHvjPxAONp1mpLUaUP7vt?=
 =?us-ascii?Q?vBwc2o/O95vYMqKuACwBgCJTgnwukr3Pl49VNT+DUFQBoKBu/urSmI4CA4cw?=
 =?us-ascii?Q?8sbZLTO2RuntbhOAeuC4UoqDDsQo6Ji1/ACz3NM1PeHr0Yf6cDXrDXTWxNcG?=
 =?us-ascii?Q?UxrEc0JWawQ0jh2vpR7RE734NiixMziXfDLmWCbMBCHLhGN34A/pTU7OTCDB?=
 =?us-ascii?Q?KY9CMQth//FQJoZLoqlrqEWVLecnyQ+2w29Fk9UOtkOMEj6I4AS4vRTq1epj?=
 =?us-ascii?Q?IAgpaCuSVBu6LCpY3F5ntc0j49EQvq5u1kotIJe4Zt/IpDEEJLG5Z+UxYpb5?=
 =?us-ascii?Q?TRq1hFUulZjJfzAQMbiCq+Iu7tyRg4raDTdqbJff4aNwjhoZDjyMKNW2UKQl?=
 =?us-ascii?Q?+IufdXfIiOlq23aU6DwLdbRURC4o11CeLbYL1JSKBLalVrHksaoLgA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tKy0G0qcFPjHGVNvsWPNLGd/Hc3TeMpqgBAt1rVI9U37ewFFwa6SOpjWY56I?=
 =?us-ascii?Q?Zvn9rBePr8Ja5ltODHsfqNiVgvvB2Qntyk6sxrZiWS77OGfQgQXAE2WNxXG6?=
 =?us-ascii?Q?XSW8TrIzl6HdZzA7TF7IqPGQKvA1HrVkxYDuXVZ9lPugBCGPiCn8RGWGGDfH?=
 =?us-ascii?Q?0pb03el1K67XDn37PdPKFlgwVl6qYdZ9WDpjo1szHQWJ2N5bFmZv3lnF160K?=
 =?us-ascii?Q?5MozB53l62pNqM5OEo2oBE5dv8lu7I3Zk4i7lR/vD7j6WVyJUtzR7t9uuhwX?=
 =?us-ascii?Q?zB7elFwxnTgzwQLdLduHQxkC+0QbwNyYvGgCVhntQaRaqP6VzmCrrEzCV2/D?=
 =?us-ascii?Q?DJwK/gmFdUaAs4xTWgsfTYNuFXSFF6Xg4olPecqgzXPWLMwxwSG48P7T5Z88?=
 =?us-ascii?Q?L3wk1U4qv7HfPlY56SazxCJ2qMJhHqLrAKrn5eavlx7FuBOO5LIbyQUlPpS+?=
 =?us-ascii?Q?q4tONJMaUjViq1J0Tij2tKU3afVkNiPXA+s790cAlsupwrnmoN9BJS37/yQX?=
 =?us-ascii?Q?fXg9ahA9A72sitSzT/uO71o98REZ8IPqf4WjIPTbdmvInxLMkkRb3ZQ555p1?=
 =?us-ascii?Q?X+Ycoh9CP5WxmmXvkKxyDt60JhXUIDWZRiX36DUaK2Xw3eu2o59XL3FdFwij?=
 =?us-ascii?Q?JkiOCZYsgjs6TlIaEPWeZSr4GXx0ly8ajiWuDzCgTfp+q+4k43uiPtYNkPpA?=
 =?us-ascii?Q?DdUijMyperD8Jypy0cX/LLjNgKndwlmRL5R/pyg9iAf0kwBJxpFVmgXf2lJ8?=
 =?us-ascii?Q?s0YtoNLMwvgjBIoWI+DVw00iJC3e92LXVu5JdFRe4nzRkFnqjAEYeRlRxC9w?=
 =?us-ascii?Q?7soNKcjjegfo1h0suYJoI/2R9FXd3sXI/IJMpJlUunkpcwC8TZ84XOlD/ysC?=
 =?us-ascii?Q?OJCZlAs+oef93ZO/hWyHxPH55XwoJm/BJtuLqJWOwi+vC3pty5lRMCO77ZV+?=
 =?us-ascii?Q?69CtBx4hpCYHippbXPj4mwHcEB+K8nAMQ9SwYAgEIaT0/Vg3TQcvLXHyEDDG?=
 =?us-ascii?Q?mpq+zWSve4RmaydhZkopbakucy0CyH43g2zywF6bDB3V1xNQ2UEFUB7h2SOV?=
 =?us-ascii?Q?VfBYXruvtY04WSIj+219t2qzjF78Sw/7EoR4Mjf1uzrg78nOm0rr7KA1BkAV?=
 =?us-ascii?Q?7cJuh+T2hQU0swJhC3TaA7KvDP+i4UBIKgQn9w9Ptq5FrC/SLcwkgi/JEE2W?=
 =?us-ascii?Q?IFAa4+O6X1vu6pomZSUAKMUQTvmuQbm6mdEPdYjLNUsMes+DRS8A1T80HDpG?=
 =?us-ascii?Q?xle1CKXwLjnax3215/Xmzm+LbrlXMtHLe4UlIS7+kp9VvLrlDvsPplZqrFub?=
 =?us-ascii?Q?yLPGBAlQFclMXw501egdfAKffgqbCGOzxF2ed+r/UchCoWYovAtRdB/lKk1P?=
 =?us-ascii?Q?Grkv9hfGGMQfdkPNv8RHt+ny12mck7m/+xOtUKm4+scE/OG/rB8G6aLnB5+w?=
 =?us-ascii?Q?xsq/bfbIVaMky7ltHrcx4XWDradoiD1irLUb4dcgbjgdYMw6PZq+yNUBQsqf?=
 =?us-ascii?Q?AT42MX/TL8RyNMKXcgumoZWBNMhTmnAcnB93RhcI6VYbGVKW0aqT3exUSb1D?=
 =?us-ascii?Q?EOt0HPPOT9S/s/G8oLudNMJyJpl3Xsop9r3svzu+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37ebbb6-a429-4b00-2876-08ddcf45337a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 08:43:47.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iorlSZ7GpS+Jwh3V8XDgjmmlHlxBvZE0+R8sbvBolK+uBFXuOq39kEpRn5VzyCuU+wmDauKtBAEgrDvbNgG72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4356

Hi Krzysztof,

On 30/07/2025 14:20, Krzysztof Kozlowski wrote:
> Please run scripts/checkpatch.pl on the patches and fix reported warnings=
.
> After that, run also 'scripts/checkpatch.pl --strict' on the patches and
> (probably) fix more warnings. Some warnings can be ignored, especially fr=
om -
> -strict run, but the code here looks like it needs a fix. Feel free to ge=
t in touch if
> the warning is not clear.

I'll run checkpatch.pl --strict on patches and submit an updated version.

On 30/07/2025 14:20, Krzysztof Kozlowski wrote:
> Nothing explains why you break the ABI.
>=20
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people a=
nd lists
> to CC. It might happen, that command when run on an older kernel, gives y=
ou
> outdated entries. Therefore please be sure you base your patches on recen=
t
> Linux kernel.
>=20
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of peo=
ple, so
> fix your workflow. Tools might also fail if you work on some ancient tree
> (don't, instead use mainline) or work on fork of kernel (don't, instead u=
se
> mainline). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>=20
> You missed at least devicetree list (maybe more), so this won't be tested=
 by
> automated tooling. Performing review on untested code might be a waste of
> time.
>=20
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
>=20
>=20
>=20
> Best regards,
> Krzysztof

I'll include detailed comments to explain why the compatible change is requ=
ired.=20
And correct the mailing list in the next patch submission.

Best regards,
Yixin

