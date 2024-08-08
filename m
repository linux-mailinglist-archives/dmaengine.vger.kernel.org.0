Return-Path: <dmaengine+bounces-2820-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FC94B52A
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 04:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0954EB233DF
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC21A291;
	Thu,  8 Aug 2024 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nlvWnl4c"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C39450
	for <dmaengine@vger.kernel.org>; Thu,  8 Aug 2024 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085409; cv=fail; b=Mudvi/8TvQpjk0ebTAa7HVXEFwiCF78YgiY83TlZte5ITS6v22Xv1LDjH0DHkAQG0lEXjl/hroK9RRslcYnYj1aHOOS5ybsQLSOKrBRsJsVETQKYF7Dxili2AXGyogmq2pLG2rQWoEz9/ZbB9JAF4R/XSnfKIOgDYH74MQY6zYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085409; c=relaxed/simple;
	bh=DqsUTkc8r5LjcIljU3ROzNZ7UY+6ZDj/3nIeOEUd5Dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVahWh2HB44VwSNw5mJVZeY33UiUJaV5X+eJFH4FDSufcdicenEu247VXODjxbeKu8EkdYdYmh3qknyU78IB4CxajCCkS2wMSB2ZiP3GP+jqbLeQ0LvY0sFDJLWqR3TGQcfLYEPpBCPX/Lu8qNV1pXo1rjEh1SW58IDv6HXLY6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nlvWnl4c; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGhGnCCK7V9IYQTW9N1jL94mxUSeogTSEBnvcGEpyP+fP21Ciu5i836zVQgy9PUfR7zv5LdgQiKNyBBtU+z+HntkXbBz7paqvTWay9j8mQ2ylQIHBnu4vXQA6un3+Tzk5e2xe+IM4dTYyrgJDZE2BaYp750iS4Xu4I9xvTampdOwIJfUiXYtBIOE03cbzGGmtZ5fxmWWtTpUzzgr7gZl0TBbjBzLdlx26WQgG5gTgafRyxG26kihZgytourOet0expf/95nOUMnavkeDv9lIcJLfx3d7Sry4sCJdIVeQRc681rpBB24IPjSXRHDPUxZZaGMSDULt//YxpiWoBIdDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqsUTkc8r5LjcIljU3ROzNZ7UY+6ZDj/3nIeOEUd5Dk=;
 b=HfzebWfZTJjLSdSWhciSVxKfFFwQ/ECOrErabeiCFxjcQGmWKQ/IF1yiNfS/FFECdWiACaL1MEvX54XOALFIzoEL9EEiWkhgUrDngNGmDx6AqwN9b3Kb9KDSGEB+vDQG8JmzlKXH64zK1/R3m+Y1mf3WXoSYeg0o6J4rCZc/wOfQoUxdb8z4WohbxBIWucqrqe7zMRelWGWZ8/5X/0WRb2INIpay2RD7zCiqVx3goX0x8H9P+1gDAbe1z3NIsk04OgDKg2e3yTLv+NHcto9zPGSiengM1K6952RBDebP5o+CCYXfyH2bES61r+WWaltL0SaDacrw7z3U4BUP1qe2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqsUTkc8r5LjcIljU3ROzNZ7UY+6ZDj/3nIeOEUd5Dk=;
 b=nlvWnl4cL1YDzV9QTTX971T8iVG9f51JCYplZFLbGAm/7tU3spLGZ5WLdc3YKckm4OAMKRiPioivz6z1iIj7lk0+9GSLdRCBq4ZjYQnY2yvtpVrGypmPvmikWCOI/TPDKvvXDbCcuXGLSt3Zdt40GXQk+NjvRDhUDwlJr8tBrVsnyKoiCDPYBS5/SYNMWZPKVAzivdvMOOB+wIOVbXwQzgcsdUnswJr/sbwNFzB55E7VYxPFwncL4fJTJ88nFc7ax4NAwILZLRcYAwVhOsnRNUaoClgCvNXtT5mMASmU3UCHT0cJC0I+yYxzmJJjYMAPUAP/GuAIyrKaBhoDFfTO2Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 02:50:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 02:50:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH v2] dmaengine: imx-dma: Remove i.MX21 support
Thread-Topic: [PATCH v2] dmaengine: imx-dma: Remove i.MX21 support
Thread-Index: AQHa56bemI0fi0XRWky7KK15rUApxrIcq6uA
Date: Thu, 8 Aug 2024 02:50:04 +0000
Message-ID:
 <PAXPR04MB845992EEF87D8C52AA259F3688B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240806021744.2524233-1-festevam@gmail.com>
In-Reply-To: <20240806021744.2524233-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10187:EE_
x-ms-office365-filtering-correlation-id: 560b5336-76b2-47d2-6878-08dcb754ce63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w+colkwyyxAKzbDlJVHqdWvOfHWQN5CvmwccRsqpXdNLJnBeU0J5nEhNdqEZ?=
 =?us-ascii?Q?dKIBt7OWa0QU6R9IvNbPd/5Jp1MKzF6xJXO8HqgBcm6ou44piDkOe9q6+uUk?=
 =?us-ascii?Q?xlWNOPdTZM5oDsCpBWnaedj0VDFGxI8cFb9G0SzFdOLf4hEXOtfTWEUcSDzE?=
 =?us-ascii?Q?t49XRT8M+q2Uf9A0fuSFNbElvZQkBdb6iITYDozDq9J46SrOb05QSNbr1H0F?=
 =?us-ascii?Q?M9ICsFio9XNEmTCZ03ha+oH1vrXfXV7K3m2brGgt2xx6ihXV+G8QCC6gJTlt?=
 =?us-ascii?Q?w2PXnpnKvkGDubFeUcKS6s8raRSXFDYBbeQZ3juBE3ixo9r7yOJybZG4ltID?=
 =?us-ascii?Q?vlLepf0uCdXAkkcKT9kQosaI/f8c3uAbC8hD65Rf3zvd6kaQpOK5lFDkE62w?=
 =?us-ascii?Q?6t357tjnReWnDBxXmwvPVwF/NuPGY0HTSSzNksOtAstZhY6u0PlFfaJFCuxR?=
 =?us-ascii?Q?ToYRMZ9gwl/Ph8fpUK5xBGrVMzehM7Qa02W2VIDHAku/wb32OCA5WhD9M68a?=
 =?us-ascii?Q?SozlJ9wcAJDOrWBfTI3m3jjjJdQzeV1bhMBYbqTS2kgYFUxXkHY8wnfuepOe?=
 =?us-ascii?Q?NDa9k4l8zfsEtuoi0JAtIrubNWwqg0m5PoqmbEyHEIwJVa7IxpvNkC/fJJ6T?=
 =?us-ascii?Q?9SerJDjpG5Kp2P+M+Mr21SuiAaAr+S5FlxtBTMoS4hdAGxxB25gok3+OQtUf?=
 =?us-ascii?Q?fzC2nr59RhJ/0qyTvzYyPDh6Q544bs99sKmxbOf/Ih7EvDaprJyFT1nCuGB+?=
 =?us-ascii?Q?CRXojRyYF6lNMQoNHInkmXTEZTuHdoWMcY+Ewd0C5Etm205AgJlOx79EBKkI?=
 =?us-ascii?Q?4v6k34dvxCJEVCnKRkYeaXbkB4s3VmZjUZgcDWFdEj7703ebLbGMJZDYiue7?=
 =?us-ascii?Q?ay+0vch/hIaK5eW6nOkk15J4yqREsUxViXaH9gV+5BTjv5h3sAiScJQO6xfn?=
 =?us-ascii?Q?EP9g8AI3aprwQ81cgxXCySCNCxHA/1c5L+vsLqCHHK5ViXfro9KMHonAh1wX?=
 =?us-ascii?Q?Ai6JynQ3M6Uz80oPXFehdnzTPGEwulMsbCjYNjLbAoRx6t15EBYPXgqZRHY+?=
 =?us-ascii?Q?1S4/yAkvwFT4yU/VzWMJoT9882r0EPn12OjlcquKcmvVaNm/WWaI6f57/Kn5?=
 =?us-ascii?Q?uJF0FucnYs4HNErc9Hnh9Oiuzp4tuQRCx/iFoKTFD4VlPQocd2Nmrmcr5FoY?=
 =?us-ascii?Q?mq6Py4ydqL+QW7sG4+klh/XgKUVYRIbWiAk5c/i0rk4kpuZWVz/O7AVGWZdO?=
 =?us-ascii?Q?43pGnpH2UD9rgLNzdWvndNlBddJmn2ovVLTcptOan8zsdWXKdWUW7Kj8QxXN?=
 =?us-ascii?Q?qMuACdDDQZupi9g++SfLHxi+CIsfhROBoWp0U5mKQV3ZhvA5F6VcJma0f+TE?=
 =?us-ascii?Q?QEadAQJs4XG/zhxT+rlkYsiqc8xaRMF6sFT+avOzA8skl0FhNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BNYSnnZB/tQVGuWtgr4A6qzaotc0QFp7/5aQEwcwNm4c8D9/zwAfma+/B0TB?=
 =?us-ascii?Q?VxKSHLkQzBaU0V1fZW3r7yAN2IeiaIv/XX7Ds2D2cBuC4EAYtdiixUbP204x?=
 =?us-ascii?Q?hJy8pIA/TVOUaJXLSG7cazNulu89Vu3atfAxu7sqBBF571yMgD9SMoWVcyvm?=
 =?us-ascii?Q?o7DbDgjFgMgqXBf970Axy1IwXO89jj7lPREn7PAeHshJW1p1KKkhcdbKnr4C?=
 =?us-ascii?Q?SyzDUrpjN1kdqbOVjeafdzDod8YwQnkXvYfNnk2Njc0nG22tJhUUFyMsfvSv?=
 =?us-ascii?Q?KbuXoIze62hUvNwWmBnjiBBRM6OKnNIr+R8ZX2EOouBMqGuV07ktU+6BCLcC?=
 =?us-ascii?Q?mTLFgH+Cf6POzYFVa/o3mM5sc3l+qAoj3/lS+9850kbBJHsMLphtEXq1Q0Fe?=
 =?us-ascii?Q?b7hIO1Oqsf5Dq48ghmEHWBBsVl23XnbeLDvn5n2j49dxMHt4mu9rhmtOldn7?=
 =?us-ascii?Q?POUtB0SyPyUdX46Jp14CQU1RPVt/bRl8pFnSfzBw5Nt3NGNpugchPZ5ILDEP?=
 =?us-ascii?Q?L/zJyrUU4WZM0m2lAPjczteFwT8v73MfButjkONxtNGgzqq2u3OMuL1aIxsV?=
 =?us-ascii?Q?/INeWUZNgmUctSzSLhiC4uV+uAALQzNRIOLv6/Fo5ItFSrgQ7PL5gXrfAs6P?=
 =?us-ascii?Q?oIi4ySrw/TL6+8GiZzwPwG7amUvwsUlwEaTbLCocNaLXMYtW1RMtSKbFRJ3C?=
 =?us-ascii?Q?NQ9xUj8iBNsuQJJ7r8KUtpEpAzvctQpc1q8GV4xivnJWlOOfJHEhEOxZNRZy?=
 =?us-ascii?Q?YYxat9PQXzplBCZyA2f6n89mSeCeOU8qIUNwOSAJFteFcY354zXCHZUKCzKz?=
 =?us-ascii?Q?W0+xmMLt6CE8JIR5idlgLrG8159UlYpAbDxwSRlYn99UPheWqAAdnX7Az8Dl?=
 =?us-ascii?Q?HmNPWUHnzPEiI7MtESSFeuPH/R75klcyvLeK0FRHi9wVNnXdu2rhhUKQea4e?=
 =?us-ascii?Q?WVkYOriH4n28mana/AYszkVbgV32uoXv0lJoagUj83n7/4SNwLwQ1BGjv3r3?=
 =?us-ascii?Q?IB4euDQV2qVpB8gfc4UeR6gnAq1yclJSU252Xm0m+KKZxN7oggr+aqYnDk1B?=
 =?us-ascii?Q?k6zlK6oTCxtqR+DXtnMIiXVqe2LYgGxzUxYwVgPIbQ1N5e3BOszDAozto9nF?=
 =?us-ascii?Q?xrylbKotphqxQawF725IIJi9fagoJvzkDg67W9C52WQGEOBvxwdLYXJz7eLC?=
 =?us-ascii?Q?PMddIm4xmLz38RGWPKJFpth/brcKYjfRecxZPMSjdSdnX8Yczs/vgCiNzTW9?=
 =?us-ascii?Q?3wUfXWlpTAQDEyJRHr5l2u+vunPS1Wdz5pjVCqJr0KSxnF14GRpgQh8RmIpg?=
 =?us-ascii?Q?SSUdGC7VIblcbuq504HEGgsZXKRw1D80PKa6YCu4w7poKYPtas24HqY1y5HJ?=
 =?us-ascii?Q?kqd2tEEUE38oelqQ6O/I5bHuP24rQrEpYQxge0lMZs6LCgLYF/Gen4oYgO/M?=
 =?us-ascii?Q?cARR37Geqox+9gwbrFLTpTmy6Ia2/ovtt2Qq/uFFU1HAe6JbPRwEEv7C9VKl?=
 =?us-ascii?Q?FPJ+nTWs0s0OS/RannR7DFyxhnIy03lJWkXOytYmlSH+BnRw4IHxQN8R603t?=
 =?us-ascii?Q?Fz3hHA0R09Km+nngaM0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560b5336-76b2-47d2-6878-08dcb754ce63
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:50:04.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClgfXnaLZbCOl9Tvc5jnTyCrBGdWfkaFevwBSALrUmj2zO/UUW+F8CLEBVOragucL4carz/+XbeLBDznEFA07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

> Subject: [PATCH v2] dmaengine: imx-dma: Remove i.MX21 support
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> i.MX21 support has been removed since commit 4b563a066611 ("ARM:
> imx:
> Remove imx21 support").
>=20
> Remove the i.MX21 support inside the imx-dma driver.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

