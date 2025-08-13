Return-Path: <dmaengine+bounces-6004-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2AB241C5
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C343B74FC
	for <lists+dmaengine@lfdr.de>; Wed, 13 Aug 2025 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0582BD5B4;
	Wed, 13 Aug 2025 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gZAmTTeX"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464D29DB88;
	Wed, 13 Aug 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067441; cv=fail; b=XTM9d4NegQNyTiPNPy5nRExFXE/YT3Vs7JfKKoX4071pkZE74t+hAnFhlUF3uPBkl6G7wpOiFtN4khl+F4WkGQdru+MZxE7H0NjPTiBTJCCILibFyDhka27aY2GN1AXLvriEdtPH+Kvbcb/IMXAw1oQyhVVO+YTtVkmp2uUNfzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067441; c=relaxed/simple;
	bh=eV0FFJBmiBHgc7Tz3X5AjOSCMNOnjjabm0HbJXYAUjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4/qE24NcByiq3JslPB4GB5WCs0PtWmwgEWcBXoN8pKjsREqoORGLIRmyqZ5BL79bgO5yXHckj3G2L5KVhJ8lFMPW/Ux4KucrS00sapBL1xKEZPMJatx25K3Rxk7kknwW/piDPHMPetrKKL7cpExJug5Imp686px/l8CALpdp0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gZAmTTeX; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPTPfk7uB5NHAkqo925k3KNYuLfYVPaPIL+H5hUQMvc3nERzdJp+cYH7+BFFj8pGHz4B+ci+T+J3URziDKXTwVgXZiJ2JNn4jHsYNy9gYYr3N+vG/aLkhl9PjJh8pW1678IPBRMc2V4EWkcm17BVelzkao8e6TPK1Zfe/7toYf/r4/2TbmHBVtjD8Pti2xwLqpZoef+2/UFTxgYKwLbfDVDo08FSZmT5q6/C77fasQzvOmFfivtulOkgT264ZIAA8d0jcPaUBylmUPHiX5pJBVpBvUOQC2TAScmk7vOoJGb3ben79GzlSy2YiHijCtdkSl3G5ucr4AI4ye1nAEmJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWkc+xLy8M0Z6BqYXhqg8qrfBL1tViDhmRzJa/8B8qU=;
 b=vrWK4W5OMMIGFIF8SB7INEayu5AsO8Os/nRPY3XFkW7S9tic0b9kN6QGoPQ98subev+awLNArnxiSFoJ5hMZtx0SNwrT9+og9gv08A7vkiUFrE//hsUwQH1T7L2QztW7+y5d3jtShQPpsuXcx/7Z8Eeban65yd3ZZWJgRQBQfLsGlrRYdeQjYKJK5v6W6uN9r4741IXyejwzMG3vymcRLZsQo3oX4We3I3u2nBGGHXjFRMEWcmDklyEz2QvMey74uh+5G5eB5cogf2rONzSwCIZIL1BfH3OtKuttyM1LiI/vtrNWGPFcMg4N8JMo3/GKP+L2ICbYyuQTAMxvdhrsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWkc+xLy8M0Z6BqYXhqg8qrfBL1tViDhmRzJa/8B8qU=;
 b=gZAmTTeXf6JVNrm8rSnLGAAZcjOH0FCchLe2kDw9L5+6xJdhJmYh9CLYGN4yJq4385xE+mUUFK8yDSpY7OAEubFo31/iVrbvRR3gSQ1gzegywYX5bwTYFbcw5XhyXZu9Ygpg8KFUVabXY4OpEpCthyaI102NjVqABNUGnnd8ngI=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:43:57 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 06:43:57 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, Marek Vasut <marex@denx.de>
Subject: RE: [PATCH v3] dmaengine: xilinx_dma: Support descriptor setup from
 dma_vecs
Thread-Topic: [PATCH v3] dmaengine: xilinx_dma: Support descriptor setup from
 dma_vecs
Thread-Index: AQHcCvZZDppGcYzUEE2+xKcWZTm2BLRgJKmw
Date: Wed, 13 Aug 2025 06:43:57 +0000
Message-ID:
 <MN0PR12MB595370BBBB9AC8B2A81A1A6AB72AA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <DBZUIRI5Q4A3.1OIBMF9Z5EQ0X@folker-schwesinger.de>
In-Reply-To: <DBZUIRI5Q4A3.1OIBMF9Z5EQ0X@folker-schwesinger.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-13T06:43:29.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH3PR12MB7763:EE_
x-ms-office365-filtering-correlation-id: 991d9827-e293-43a5-0ac1-08ddda34c72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7Tfm42afPK8XXeLdI88pnRhnZ2uIpbHa+Ne7l2z00Rg8o1FGundd63qtWb?=
 =?iso-8859-1?Q?VKxUJN0jLVJtBIWnOD7A2g1hGk1Zk01i8KVqUhMp5lKdIR2P7jQaUYzw3+?=
 =?iso-8859-1?Q?J/iDg8aQ3xRVFRuuiOmYNhF456GSiCMyIvesc8GvmaPOmYnKyAJx5102TK?=
 =?iso-8859-1?Q?1Pn4BIeDcaf+vbhguiF7S426e5WCyx6O+GRKiPokzN2T1DAufYqDuTidcR?=
 =?iso-8859-1?Q?uoDS2Sd/t5gIubLbj3duHRsCF+sEs2RJgOwlzI2iQWdq+/wdyO+S6d/onC?=
 =?iso-8859-1?Q?wbBypJ6qGmgGyIBB0008CYlNLVq0lsPg6z0mcy1UxQFMN9hOVRgcbrCZWG?=
 =?iso-8859-1?Q?ap1VES1PXykH2HYw/P+imdnSZc29B51QYatKxZjOAP3FZBSSppUJ0Ji/5v?=
 =?iso-8859-1?Q?vuT/HLJxzE1ctOgdSQZTB5lZv5R+mBa+yZ7LmUd4ViUDf/vCvP8Mlrqr44?=
 =?iso-8859-1?Q?WR2ZNaFeD+bdWvHAmTe5kqwuGWXz3r8EoVhUD7tPcq93v7ncjOrOIgAn2H?=
 =?iso-8859-1?Q?yUZT9Fsm9spQ47mu0tqQGNDSkG9HCJHvlKNmroFgx6sGbyxliFAC4HMLKs?=
 =?iso-8859-1?Q?N2UzF32psF5gzsYxKYr4zuOnAPM4Qp4674qvubfZ5kbZ+s3sO+NlCo6Tzv?=
 =?iso-8859-1?Q?jIYRxxNWZr5dbW72GYI21ACLFCRFbXdVfg7tSB8dJhlspxpACm41uAbGfE?=
 =?iso-8859-1?Q?ceSjnMw6xqnfsZ/3yBj6fdFwhSOpgud0GyCWrXheda3abi5IuF/vDjzuT0?=
 =?iso-8859-1?Q?emjQzU4VsIS0oZFH8yWOd/Z2UUz0NmynHJjuDyUye1EhawdCC9jSyHjT3u?=
 =?iso-8859-1?Q?1eeKH5unJjY6CUCGEOsSS6Hlm/ewEaAifqPwvPbBrDer56l3Rkcr9x9S0b?=
 =?iso-8859-1?Q?HrD2ed4Fgqx3+0SCIN3FtaaJBCMFsfedmG169WElTxP1iFJaka96lT0HpB?=
 =?iso-8859-1?Q?qtYPKutCA+IETEqEOF0BOIij96lFZc9JvCUayxdue7np1FAIMpDOuYAB/3?=
 =?iso-8859-1?Q?LC2JogZPkmArzQdrVFXUzrFboralPyye0640hX1HuIq2sJ8tuzEBdbPt3C?=
 =?iso-8859-1?Q?fXZeb2lzuHqSexzNyIyai470d6pabgqR0N56rTpTay7xwD85lFcaA9U87e?=
 =?iso-8859-1?Q?B+AGZ2gkIF2lmfVWN2vPlOyG8DKihOUtGbhwA4Uw6tZxq5uRvlrPEQUjDd?=
 =?iso-8859-1?Q?6SIgf12crBgM1yhbPVBT5EkJSb+r2r7I6rm/PBriEMMdEWWVBMaaafayVM?=
 =?iso-8859-1?Q?imQs6VEWBOHLXvWzkAwRaF5jvJ+xSKXDE1jn05cOeIIxBvgUReoQvrAD8g?=
 =?iso-8859-1?Q?BZkNNK7g0tMiU4gYkDgq/WV3IV94W+rw/1Dv5u1g7rFVHfRS2v0fhetfkt?=
 =?iso-8859-1?Q?BrLcG8R7pfawT50qmNMHn/42WTQcwC25HkQMPOJ7CcsSMBzYRvpq1Ol1WB?=
 =?iso-8859-1?Q?1JUsfFNwdGFprLg9nU9debPPkbZEIAI73yLzKB7XnyGSwHo3wOf4DsR7vX?=
 =?iso-8859-1?Q?E47lvU30g4sIMAkHdWQ1ngUdLLFbUH7WpQ5A5XKIg8tOpvXTqIEZy3NSPY?=
 =?iso-8859-1?Q?tttSaSc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qApoTFpMwkNrnd/qvu5qqqCf6Ell4UtLEhVZVhrJqdeLw5YwXdkEXFN64u?=
 =?iso-8859-1?Q?yYAzhjhcUsudO2AibMHEk+mEcNwpWd3vTCMOXMQkKaL5m7M9pQVu2p9vOH?=
 =?iso-8859-1?Q?L4bwjBzwP4jQwd4pkVzAsq/kq4wseXcvagsKbn5O3btG8NQKOb3019B+8k?=
 =?iso-8859-1?Q?vPMpfg3KPTx0QSS2NkmHEzXLFKhCRxhvzccXcutQ+zUb7+81gWLo75tYzP?=
 =?iso-8859-1?Q?OitWmqduh/rCwvlL904GZFQpSpyaoaw244Hw3GXYC59hkVnBn3YjfuHCj3?=
 =?iso-8859-1?Q?pJlXfvW6ekLc8fRxOEIicTY+5cI8Rlc0Tj8r0WvmMSi6nDEa0svfZe2thj?=
 =?iso-8859-1?Q?UJK0mC5RNbvvg8wsE8TKtwuCbszJch0R+uLd/rXXbi6JsPIESC4irwf6DD?=
 =?iso-8859-1?Q?0q1oEMq7YB12aDfXwpNoJahmvXlw99m3GFMJLcQeJirUsOWO9jv5MHIma9?=
 =?iso-8859-1?Q?CnVWeRbhwBaH8gH1+zAYYD1psp340d5D4rLz9GXGyAv7AkDmuKlhaNwnbA?=
 =?iso-8859-1?Q?tUhwdAsn8cr1F4r/F5aw6E0xDmT9qgFsHg7LNQQ0J5xanXIq6KpMygoyB1?=
 =?iso-8859-1?Q?UZtlkMllYTxJC2gd7BFJ5j9GpBzEXnZLFFo2bUi1KNUYCc2MHjUvVDF85d?=
 =?iso-8859-1?Q?wH6vI54riTtRiCfYVAan0inO+omA5UXgcDTh7izteBmQbOHVlZ+nVa6r1p?=
 =?iso-8859-1?Q?SLBFym+CHdj+eIeIvj5UAH/fLXaijkzSj77Mi3ArJ/0bh/8/ygI+tvf1GU?=
 =?iso-8859-1?Q?bncGc0QcfwfZbKvtHJO2YGbQudgIvMsvFmj0jqY9VxaVpZ8+QhKcEjQhFH?=
 =?iso-8859-1?Q?VAsBvJxGjp8N5EPt7MKLTwNcpd+tXKWUfUxkNQZYYdunYTIZnW2JTDoCXK?=
 =?iso-8859-1?Q?GP/mKPmNAhb53tD3uVlHr6iHY/rprM3Q3jKxrdLD4AfXEXTdSH5oCHBLnK?=
 =?iso-8859-1?Q?rXzLMBTxN9pFhvR4T+o46pmTbs1aK5/kdEiZRr1XQxwhshTHAmLBk6+rgO?=
 =?iso-8859-1?Q?+43uJJ9mqcW/GV6sCcIOocpLfj4aF0Hkq+3F1EXQZdGqSBrA/AvXInWQc+?=
 =?iso-8859-1?Q?ON8rInNr97VY6wOdRhxwrAZ0HjtuQoYi4mql+mJlELpuorypiGBLRscvL9?=
 =?iso-8859-1?Q?QKyY/6n7I0ZYaCDAZwUWaZfgwlSSmquxUgSiWkgXLWXLVMjibQt7g6tYat?=
 =?iso-8859-1?Q?O5gFiqJTphaTUIAVm/ApoAeXjylcHENG15X6LjcG5uN8Z9eovON1uqsNEB?=
 =?iso-8859-1?Q?EQdtT8ZQquPMAcwNXVFwYdNWolzFwFXow2PNFrxqpu2mKUY//v55p0OSp8?=
 =?iso-8859-1?Q?LKP1gYPB6ZOCi6Ue6f6yu87gA6w4aBG0A0xPxTYc9ks/gIAmVpuyMyMgIh?=
 =?iso-8859-1?Q?DqGCL86CliZUKS8BAJKpaVZbbIBf1eu4S2j5r38LnTPes3J007f77fdN4f?=
 =?iso-8859-1?Q?rq45zFD7tFZv3+traMCfEfIBVF2n/OOe4X3525wdHL89k68yiQHaTex6EB?=
 =?iso-8859-1?Q?SUS+gkq4IUDC9dhR/Pnu462nCWETAbDc3HTb140ui/YH3JRPhTeRnMb5bT?=
 =?iso-8859-1?Q?rg2qtIZUX9uiJgmDYaMXKO/HmCZA3gB9zehBsj/TrRwad85Gii2Enwi7Wh?=
 =?iso-8859-1?Q?B7lH3nlyZJoIo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991d9827-e293-43a5-0ac1-08ddda34c72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:43:57.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0hGaVoY7pmdyILea1yoqLMyMzmMJvdRRkmSUJYNgwflrdV52c4wr0VZfXNta+//
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

[Public]

> -----Original Message-----
> From: Folker Schwesinger <dev@folker-schwesinger.de>
> Sent: Tuesday, August 12, 2025 12:53 AM
> To: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>; Simek, Michal <michal.simek@amd.com>;
> Jernej Skrabec <jernej.skrabec@gmail.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@baylibre.com>; Marek Vasut <marex@denx.de>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>
> Subject: [PATCH v3] dmaengine: xilinx_dma: Support descriptor setup from
> dma_vecs
>
> The DMAEngine provides an interface for obtaining DMA transaction descrip=
tors
> from an array of scatter gather buffers represented by struct dma_vec. Th=
is interface
> is used in the DMABUF API of the IIO framework [1].
> To enable DMABUF support through the IIO framework for the Xilinx DMA,
> implement callback .device_prep_peripheral_dma_vec() of struct dma_device=
 in the
> driver.
>
> [1]: https://elixir.bootlin.com/linux/v6.16-rc1/source/drivers/iio/buffer=
/industrialio-
> buffer-dmaengine.c#L104

Nit - avoid links for existing kernel sources instead can mention source fi=
le
name or commit id that introduced the change.

>
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
> Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>

Rest looks fine to me.
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>
> ---
> Changes in v3:
> - Collect R-b tags from v2.
> - Rebase onto v6.17-rc1.
> - Link to v2:
> https://lore.kernel.org/dmaengine/DAQB7EU7UXR3.Z07Q6JQ1V67Y@folker-
> schwesinger.de/
>
> Changes in v2:
> - Improve commit message to include reasoning behind the change.
> - Rebase onto v6.16-rc1.
> - Link to v1:
> https://lore.kernel.org/dmaengine/D8TV2MP99NTE.1842MMA04VB9N@folker-
> schwesinger.de/
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 94 +++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c index
> a34d8f0ceed8..fabff602065f 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2172,6 +2172,99 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan,
> dma_addr_t dma_dst,
>       return NULL;
>  }
>
> +/**
> + * xilinx_dma_prep_peripheral_dma_vec - prepare descriptors for a DMA_SL=
AVE
> + *   transaction from DMA vectors
> + * @dchan: DMA channel
> + * @vecs: Array of DMA vectors that should be transferred
> + * @nb: number of entries in @vecs
> + * @direction: DMA direction
> + * @flags: transfer ack flags
> + *
> + * Return: Async transaction descriptor on success and NULL on failure
> +*/ static struct dma_async_tx_descriptor
> +*xilinx_dma_prep_peripheral_dma_vec(
> +     struct dma_chan *dchan, const struct dma_vec *vecs, size_t nb,
> +     enum dma_transfer_direction direction, unsigned long flags) {
> +     struct xilinx_dma_chan *chan =3D to_xilinx_chan(dchan);
> +     struct xilinx_dma_tx_descriptor *desc;
> +     struct xilinx_axidma_tx_segment *segment, *head, *prev =3D NULL;
> +     size_t copy;
> +     size_t sg_used;
> +     unsigned int i;
> +
> +     if (!is_slave_direction(direction) || direction !=3D chan->directio=
n)
> +             return NULL;
> +
> +     desc =3D xilinx_dma_alloc_tx_descriptor(chan);
> +     if (!desc)
> +             return NULL;
> +
> +     dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +     desc->async_tx.tx_submit =3D xilinx_dma_tx_submit;
> +
> +     /* Build transactions using information from DMA vectors */
> +     for (i =3D 0; i < nb; i++) {
> +             sg_used =3D 0;
> +
> +             /* Loop until the entire dma_vec entry is used */
> +             while (sg_used < vecs[i].len) {
> +                     struct xilinx_axidma_desc_hw *hw;
> +
> +                     /* Get a free segment */
> +                     segment =3D xilinx_axidma_alloc_tx_segment(chan);
> +                     if (!segment)
> +                             goto error;
> +
> +                     /*
> +                      * Calculate the maximum number of bytes to transfe=
r,
> +                      * making sure it is less than the hw limit
> +                      */
> +                     copy =3D xilinx_dma_calc_copysize(chan, vecs[i].len=
,
> +                                     sg_used);
> +                     hw =3D &segment->hw;
> +
> +                     /* Fill in the descriptor */
> +                     xilinx_axidma_buf(chan, hw, vecs[i].addr, sg_used, =
0);
> +                     hw->control =3D copy;
> +
> +                     if (prev)
> +                             prev->hw.next_desc =3D segment->phys;
> +
> +                     prev =3D segment;
> +                     sg_used +=3D copy;
> +
> +                     /*
> +                      * Insert the segment into the descriptor segments
> +                      * list.
> +                      */
> +                     list_add_tail(&segment->node, &desc->segments);
> +             }
> +     }
> +
> +     head =3D list_first_entry(&desc->segments, struct xilinx_axidma_tx_=
segment,
> node);
> +     desc->async_tx.phys =3D head->phys;
> +
> +     /* For the last DMA_MEM_TO_DEV transfer, set EOP */
> +     if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
> +             segment->hw.control |=3D XILINX_DMA_BD_SOP;
> +             segment =3D list_last_entry(&desc->segments,
> +                                       struct xilinx_axidma_tx_segment,
> +                                       node);
> +             segment->hw.control |=3D XILINX_DMA_BD_EOP;
> +     }
> +
> +     if (chan->xdev->has_axistream_connected)
> +             desc->async_tx.metadata_ops =3D &xilinx_dma_metadata_ops;
> +
> +     return &desc->async_tx;
> +
> +error:
> +     xilinx_dma_free_tx_descriptor(chan, desc);
> +     return NULL;
> +}
> +
>  /**
>   * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transa=
ction
>   * @dchan: DMA channel
> @@ -3180,6 +3273,7 @@ static int xilinx_dma_probe(struct platform_device =
*pdev)
>       xdev->common.device_config =3D xilinx_dma_device_config;
>       if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
>               dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
> +             xdev->common.device_prep_peripheral_dma_vec =3D
> +xilinx_dma_prep_peripheral_dma_vec;
>               xdev->common.device_prep_slave_sg =3D xilinx_dma_prep_slave=
_sg;
>               xdev->common.device_prep_dma_cyclic =3D
>                                         xilinx_dma_prep_dma_cyclic;
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> --
> 2.50.1

