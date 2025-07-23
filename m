Return-Path: <dmaengine+bounces-5846-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6788B0F199
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D908316F4B8
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE627991C;
	Wed, 23 Jul 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3Ive0iq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005115A87C;
	Wed, 23 Jul 2025 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271356; cv=fail; b=VULsLk7tUHvRvg5nmVyfn0lM2TyTIXpTzdZsUH/sd1K8ZbT17bys19CCkaa58KS7eM+g6Wh4PNvY/mLlxx1mUHgUOwnktYW36Q1s9S4tr+6k0G7m+r+pHmYtpk54uRUjmLJHfFrBSBKo0Utp+Zfgxr4TqzKV4oHg8RVRDWDhFzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271356; c=relaxed/simple;
	bh=zLGAjfuOkt9vJvvjvh/BHl6Y35E21pfuENO/JtpRULc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGXmhabFhEYEi+axN/ya3EOdWrGakNVvQJ/7XdyYGHl2Vb2vACQoBUNOwM8whfEBpWKFjAYh7OhFg9r7x9Z3qZcy42m01tDoU4Nj1o5kjKGRVKWbGnuEnN0djPonK8XFEreqlQV0ddT2sb7FieefRBfxw73PctIEI3QrFGlwZ4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3Ive0iq; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtlOSx92o2kRBOd9Eu0IJ1tnJsmQJSSCv1YDFrKAlwbbmoi0PUv95I/JGSyzqLk2CxnhO1YcWfZkvqYemQqSwP2KnkQAoiWDSBjI1odpdSBloAp2IvwuyRkz9LM9s0LLotkJOJcYk4lA1a6oG/74a6xaCWA4GtA2qHJaul+fdwcvn838sLIIU/tlEGTbbLXFGZAlv3BaunxSiEjO4NCNDmNPmGCCQP5NddWgNQPGCGG5eh9KgZ/EkexOcum6NFBTFzN2K4Syj0FyG0e3heFcQp60S/5HSh3/iwkS6R0ii1GLca6T8JQMI95asxpHlA4Obip5hbPqPVPCSHVi3r9DSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RD+/FGx0grKRhSt0u+v0Xirb80yvm3MNNaEa+dMW6g=;
 b=fQ+aKyiLbdGbIYa0NypYzyFouJKm/8/oDneTtrwLtaqHlkDjXT3fFzIXyXqFvW/NtMTBPz2UiUB9/ptV7oOUo45IvjnCLNcbBHBsU/SdjjQjNHOJdLpZuXrbdoWkuiluT/wcp16VNx3GaNr+eg76sGp7QxOpMPcqoMw2aPxS4FKM3ySRtMBeOvXc4qhQTQ5O/k8GTzeGczv/5oLWAHYAYt/1tZYWBB83fgiiPhlvXpqn+8W8pdIrmwVNiYtVqym/5bfaIrvVL1Hppia9fbPTJ4R3Tgp46sAGiZXtDqDbzmEl9n/kTwueGMamwLSkPCl1R1BfDw6ln7GmkRQT01AXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RD+/FGx0grKRhSt0u+v0Xirb80yvm3MNNaEa+dMW6g=;
 b=x3Ive0iqpziZ47GhKXTxaPOtd7t0Kla5nM+a4k3xJ9lJ83iU42RH2QC1S1GEqe7DvCM+AbfruQbETAIXlA7WIhBsrklwQBkicn5eC6et2lxMb+TdyF8YK0xXpxphtQRzQgKzyX6+eSSXRMpWeCcUEFls989Z2DgD2RdzCo1s6YA=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 11:49:11 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 11:49:10 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ
 coalescing parameters
Thread-Topic: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ
 coalescing parameters
Thread-Index: AQHb8YM8lgBJJ/PUwEqjiAtds0zT8rQ/ZD+AgABF+uA=
Date: Wed, 23 Jul 2025 11:49:10 +0000
Message-ID:
 <BL3PR12MB65713879CB569E3B330C1E76C95FA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-2-suraj.gupta2@amd.com> <aICPiS1_ITwELrxq@vaman>
In-Reply-To: <aICPiS1_ITwELrxq@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-23T11:41:30.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|SJ0PR12MB5635:EE_
x-ms-office365-filtering-correlation-id: 2064e7b1-b2c2-46e4-4098-08ddc9def029
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?496Mo1SOU0ttNtf9I1q/lSjHdB4fFk2Wy1P691Qs+nnfEVKguSQ9GXnhMKh8?=
 =?us-ascii?Q?WXoxcovS807OMdpGwpyl5OX0xeHGEyO2jTbOqG8MR2wMms6g5kRBho5XVAiP?=
 =?us-ascii?Q?ckpQnRgWKKsV6PX2yIv7TyylF0+SLFIvHpB00fxzAHpJ8xGL5ky9kN0OQPYb?=
 =?us-ascii?Q?C9Y5LstQhWng5UToNQHkR5m82RxHjhKys3mg3HSaL+uii18T8wA8vZoTGkHU?=
 =?us-ascii?Q?XVwnpam6qgg9xJWEnfvV+JYfq4z4Hh73ik3fA8fukP1xfzwzGP1MIYjmeHOZ?=
 =?us-ascii?Q?kw6n2c9nwuOt7hFIUxJMj3Bp/CAqtIbmBY1cwooVLZSBmicHdnaRQb0RCagQ?=
 =?us-ascii?Q?GKEMogsHw9I7RlboCIo1ukW2pMyRIkxxio/Sotei/QREQITpJk3GBGoug55H?=
 =?us-ascii?Q?eejWFD0B5aYdMv0mZ7HCNyNrEwdmcPrTijAySWK7gkwTu1eMpS8OkYhFQJa6?=
 =?us-ascii?Q?X15ec0L7GOD5AjnPLjCZB0YPZnY+lMq+HUhOWj4vXacm24Ke9DRmjfU423P6?=
 =?us-ascii?Q?3877CLU6XOPB6WblFiATHFZimlHhguR1lJRc7T5oKN/7IAHQl9o90uPtiuVK?=
 =?us-ascii?Q?b3GSfaPzs/CgjpIsciviSdwkFfVRc4X4fiCE9B4Sw1atq6UmT2AIzH/IhFrf?=
 =?us-ascii?Q?BbrcWwCKhtdQJhDQNV0q0LY3YgRoWBRNOXegD/GlQIWfEd8favFi4iXKdNGx?=
 =?us-ascii?Q?AAhm26FZL1CfHXBI0ZN2KpT0WDdm4VawPLf9ZyMjoJ8spulHnJkCxXiK7g9Q?=
 =?us-ascii?Q?BOHgVKNaEEvpudwq1hOHvEjKFit2NGrIQkTNWRIIi6PAgIEckFsbD3eQ/Un9?=
 =?us-ascii?Q?xQlSQJLBWanFpNBNjtCLzJftdXCYIMWwm7EVCYB6v1R9tjbVvxg3dgfI9poJ?=
 =?us-ascii?Q?Us+hKypsQfCPCgQMK/5A1dY6UYfeWHfND1pcFPn9MZOPSCf+vZG8XFSesOHN?=
 =?us-ascii?Q?hUCdWi0JR3BIlZZGb1fgL8nVa5VFkSEOt3aKvnNdnrkRIUbdQllNt4JZk05r?=
 =?us-ascii?Q?ziKtsNw3guv39/whFxMcD+Hu46tGhemW4JzIinVzLK2vzDKL7ir/d1MLkSGs?=
 =?us-ascii?Q?PXaDUIi4Z4ojJJYsi5IuYjuF9j+tZUrQUZHzJpfA4aNoRKfeNjDpA43NQsY2?=
 =?us-ascii?Q?XCwpl25M/KxAD/NRG+HoofAqSXswGs39dPgLjKRehot7jQ5BhqO8e3yt4e8P?=
 =?us-ascii?Q?vNAMZvO3JFD08YHZvlPhOxBdSTb3wx74WC4wVFF8Ib8oZzdLam+mLjeMq2/V?=
 =?us-ascii?Q?5hvXc1ekqnkyxb4vHRhJasgd9eKQYfd4iauwSPRboxVsGuSMKRvPE0luRxv6?=
 =?us-ascii?Q?KgG1AWpNXW3fA+Bx5kgcbMdMXvuNHS+fhiV9qvArltOsA9GEd+WbhyfRnZeO?=
 =?us-ascii?Q?IHCsN8Y+c/x1FepPloeAojcIqjCc+W6zLHgNZ2F3opZBqXncnFAR0XZ9M3uv?=
 =?us-ascii?Q?yVhdy8+3X0Xw0Ri7xZvy0E/99KFNh1GCGN3NfjORoETnWZAKsJb1ghn8JHxV?=
 =?us-ascii?Q?Sq9Qf6peZbT7ACo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rZMWCOOvka22NZ1gwn3l3GZc2wQAslJts8MXcnfe9poS5Za4Z4jr78eoqgFz?=
 =?us-ascii?Q?cz6tWdgtx0HWJxFUBBzm8HglkX2Twi9KK2ppOwQcJH66h3qH9nYaBXVQaH6/?=
 =?us-ascii?Q?zEywyXIEMlmyZ1vhTUoJR6Tv86nYY5rxPRZ9vlPJLCJhhr0kjhlDnkX94fTM?=
 =?us-ascii?Q?U1h6MQHDdjlvPoz4btCKFBegyDzwle0CaD91qZQUcpcifko8Ql/0TMCIKCmY?=
 =?us-ascii?Q?/MMtWhFgHiJ8mdHx/SvtZJHZhQ748tGc3I+NWldDamvhqFYzps06UYJFyJa4?=
 =?us-ascii?Q?hsmeDvCJn2kLanSwIyjuY1mskM69mLHLMY0FfIBetlLsgZzPGP+5/I4n1gZm?=
 =?us-ascii?Q?+1nHpR3acZwNbYZ3bXybuPPwRY+Y7SqW4XeFPC/4W6Utu2XZpwIp7+w9GCGc?=
 =?us-ascii?Q?zzLlL1rWlGnzM7kGZZA9GKZKvUJ2FnJf4saSX7gwUINSGmgj38SJvVmsyBL1?=
 =?us-ascii?Q?bzICpERMu3BgBeJX4IRn9pg6KebVskfd76Vgoo6mY1mzVZOsD6GKd0XQ9iC7?=
 =?us-ascii?Q?qwqwsubZk4bvp0dYDx2Os8qal3p0adHPE0Bt4HNxqd2Jk6oQi7UU+Toid5dL?=
 =?us-ascii?Q?XHlP9ABepgisR0ynOVRU9YduOLfIErNZDgMvAQN1IZOp6UKpX37oVIJxhHoM?=
 =?us-ascii?Q?c3XPXH9bmZNZZAxL0JKHOoTASx8f283nnmIJthqNN5WZknWiX9CWiGZTcLEj?=
 =?us-ascii?Q?WJQNBvQSMqGgbo3NO72e1+qnA8pyfxrPLuj0XfRqHqWtiT3I/WE0FfB2xsul?=
 =?us-ascii?Q?OhZlmalcYqHhlyxT5hodBCKX+weHrsUoLdFjHE62/CGWJR4LHw0KBlqCZGzi?=
 =?us-ascii?Q?mcI6LfxuKmbZMaaNkHECFjEdqdLir9Qra/0qtg3LzBNImSGip/TNwY1ST6V7?=
 =?us-ascii?Q?a3gMtu6fa8iPOg1TcbOGUTtn4pgBYh5rzk2GyJUkrtAFJ4FKd93tZLZhvnAr?=
 =?us-ascii?Q?XiM0Igf+zlatzmVAxH8ZWwmCrFY/v4oy2Oj2NqRuOvbMm8Fr4j3ioQNzPaTc?=
 =?us-ascii?Q?87sDvWglz5DV3pUjT+oOgDGMCLwptOjv2bzMLeN6o0VDkHzYTsZ3kr3amCfe?=
 =?us-ascii?Q?reTryJ1XTsTiblDJU7yaLzuUY6cYm2g4zdM3DQtKzK412IFrHcodd9a+PVRo?=
 =?us-ascii?Q?bk0WjT+u0/uVaKJ84mq4pWOY7AtToSMrtVoEaftD91LwOfgvHmRVsa4e7brP?=
 =?us-ascii?Q?MvWgaeysOyYAQiz6HFps6Ep9qIovh1YH+Sfq+Dba/b0LJzVG6slwYIiuU2n5?=
 =?us-ascii?Q?YHBuuqK3ouWnQAePCtdyeGioPR0lPpVjW7yOsRWB+5bTxB0l3wF7dnYucin7?=
 =?us-ascii?Q?IHer4stpw6gqlC/YxifRcJf4s4i04BNmXAwI1WwFyAUIaKRGZZuwildAr1Kt?=
 =?us-ascii?Q?gWxeJRStUFego6JIqPA17BDVnYDzbVO/VkGDjrY81imMV7N0laiS0ZAya2tE?=
 =?us-ascii?Q?/vptjOjnzTMG/6mx6x0x5cVvI/vkWz4qOq9aW0s/WNVrdhwcHrjC/YSbDh8d?=
 =?us-ascii?Q?LRp++w/S7nfu8x26xgf8VyPNwidw0aKShmKYuSBl4Z+4cxDIe+IcNquFAtTq?=
 =?us-ascii?Q?vsyESEDqQs03UUZDyBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2064e7b1-b2c2-46e4-4098-08ddc9def029
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 11:49:10.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAQJAzPegcFCSrPRTT3pm4FpFWGKo0TCN9jRuX4EP+GZXG56ECOyahHhpywE2Dp6wbca1EPwO2JO5W0fOgsKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

[Public]

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, July 23, 2025 1:00 PM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>; Pandey, Radhey
> Shyam <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> dmaengine@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
> Subject: Re: [PATCH V2 1/4] dmaengine: Add support to configure and read =
IRQ
> coalescing parameters
>
> Caution: This message originated from an External Source. Use proper caut=
ion when
> opening attachments, clicking links, or responding.
>
>
> On 10-07-25, 15:42, Suraj Gupta wrote:
> > Interrupt coalescing is a mechanism to reduce the number of hardware
> > interrupts triggered ether until a certain amount of work is pending,
> > or a timeout timer triggers. Tuning the interrupt coalesce settings
> > involves adjusting the amount of work and timeout delay.
> > Many DMA controllers support to configure coalesce count and delay.
> > Add support to configure them via dma_slave_config and read using
> > dma_slave_caps.
> >
> > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > ---
> >  include/linux/dmaengine.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index bb146c5ac3e4..c7c1adb8e571 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -431,6 +431,9 @@ enum dma_slave_buswidth {
> >   * @peripheral_config: peripheral configuration for programming periph=
eral
> >   * for dmaengine transfer
> >   * @peripheral_size: peripheral configuration buffer size
> > + * @coalesce_cnt: Maximum number of transfers before receiving an inte=
rrupt.
> > + * @coalesce_usecs: How many usecs to delay an interrupt after a
> > + transfer
> > + * is completed.
> >   *
> >   * This struct is passed in as configuration data to a DMA engine
> >   * in order to set up a certain channel for DMA transport at runtime.
> > @@ -457,6 +460,8 @@ struct dma_slave_config {
> >       bool device_fc;
> >       void *peripheral_config;
> >       size_t peripheral_size;
> > +     u32 coalesce_cnt;
> > +     u32 coalesce_usecs;
> >  };
> >
> >  /**
> > @@ -507,6 +512,9 @@ enum dma_residue_granularity {
> >   * @residue_granularity: granularity of the reported transfer residue
> >   * @descriptor_reuse: if a descriptor can be reused by client and
> >   * resubmitted multiple times
> > + * @coalesce_cnt: Maximum number of transfers before receiving an inte=
rrupt.
> > + * @coalesce_usecs: How many usecs to delay an interrupt after a
> > + transfer
> > + * is completed.
> >   */
> >  struct dma_slave_caps {
> >       u32 src_addr_widths;
> > @@ -520,6 +528,8 @@ struct dma_slave_caps {
> >       bool cmd_terminate;
> >       enum dma_residue_granularity residue_granularity;
> >       bool descriptor_reuse;
> > +     u32 coalesce_cnt;
> > +     u32 coalesce_usecs;
>
> Why not selectively set interrupts for the descriptor. The dma descriptor=
s are in order,
> so one a descriptor is notified and complete, you can also complete the d=
escriptors
> before that. I would suggest to use that rather than define a new interfa=
ce for this
>
> --
> ~Vinod

The reason I used struct dma_slave_config to pass coalesce and delay inform=
ation to DMA driver is that the coalesce count is configured per channel in=
 AXI DMA channel control register[1].
AXI DMA IP doesn't have provision to set interrupt per descriptor[2].
I can explore other ways to pass this information via struct dma_async_tx_d=
escriptor or metadata, or any other way.
Please let me know your thoughts.

References:
[1]: https://docs.amd.com/r/en-US/pg021_axi_dma/MM2S_DMACR-MM2S-DMA-Control=
-Register-Offset-00h ("IRQ Threshold" and "IRQ Delay" fields)
[2]: https://docs.amd.com/r/en-US/pg021_axi_dma/Scatter-Gather-Descriptor

Thanks,
Suraj

