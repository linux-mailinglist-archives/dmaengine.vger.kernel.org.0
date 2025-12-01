Return-Path: <dmaengine+bounces-7413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B73C96842
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE4D3A12E0
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96FA301012;
	Mon,  1 Dec 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oWYPTg4t"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576B207A20;
	Mon,  1 Dec 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583166; cv=fail; b=DaspgkgUu4hMUrm9gDC4/bC5glUln0bxpWxFs+I/2wNijFgALSk+jw3yqO9gXPEW3WMDuBSssKqRTDDdRnqr9SP3ooVA1oZh8boRSapO3AXeMISyIqscJxwNgDytzjp8ew2+snRJQBUDNAfwUTqIvTzq6B/M/o3z3oU8Xh9l/pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583166; c=relaxed/simple;
	bh=rqIv5h8IrOihVoO6rUM8Tky1ByCi2Ry08kqGliHhczs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TNlVuHOGSc4v3LjeDSDPzi1tt6xWa2kUPDPLgXD3kQdCtoonMl74iys1B9kx3UceKWFKfTuaryspPX6u9sgA8UJ49zsvp76mTKZf6+oHwp6tXpll1Jy2wglSBmK5VjBQtwnsTm1jqVdmKxmm3mJK9n2t8AciK4EkobnzccpcPoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oWYPTg4t; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0nze5p/sO50izz5rVB2Ou2LA0KNEn0mcrmUWCFF4c5OY0P+yDjVzpTmz53WntmZbnuJ6MHibIfbQ4HpMpVvPkE2+x4OcSIzrf1KoqK4xBXvbxnwFlhUjQlGtiGW3Q6RAqtgfAUjIyQWv05brUU9MzK3qTPvln+ZQy8fo4Y4aCm5t79swPodXzwARMHJYCopi/YIsHmJ/gANDnuhPsLlT1ZP+LBgw6zLsNXvj32Go0VqUTFYAUwZelwcKniIUvRDVtitwsHZJNzSiaHIu5TqTOkhlSA6+hcpVMMVIvDrPrpwlSfnYtqTWGFoBQvvD32SKkzkph0/Yb/1V8D0DI62YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJp15g2jx5NeyUNHzNnCCVSmXrVoAL2JgDIh/ECwww8=;
 b=dPtPl9y8R1pc/pf69msYdFKUkhcxQvK2oXh2hQOC4DGpBbowFQn4ynNkeNW5y85T5x8pk2d1WIsPz4d4DOVRy96LeO8pbq7GgLBTlp8H+2oyOGWOGshRaMkFB6mnxvEk7u1w39Ia5jQhjqqVh7dD8Nat49eCR3KKoxvApoL2H8hqJZ0GZE6BcUUh3VXMrKMnTN7ZXqu/8JofEMASwnsI85hWXs8Q44BtIoiFCqN7UoSL+fdbbrXBNrMDPtLBWKDs6DZFA01YmnjYkIZRwzI+x7hAi9ENmyASe4wAyOaRZYzhTTWMFcUD51DGodUr75FBfY9/YPDceUIQkxfeY5qwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJp15g2jx5NeyUNHzNnCCVSmXrVoAL2JgDIh/ECwww8=;
 b=oWYPTg4tzu8Mrco9y6lCFL1hwRvZ2LDZAVUQ7J9YP2fiBWHAGPW1hzg2zB6NqFVLje02IVgA1djLm6LKgeNejTfEcsT4+gg2X+RaZfXveG58uwjYHLf7P/MzytCsprYCdVACQ1R3fPzBVnuFS5gB7JbDkSGpxuIxA0NOvBpMwUE=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:58:13 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9366.009; Mon, 1 Dec 2025
 09:58:13 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcWtrmrcKa8eMzNE+aeiu6TdWOX7UMnEUQ
Date: Mon, 1 Dec 2025 09:58:13 +0000
Message-ID:
 <SA1PR12MB8120B42CB67E6A4F25318B4895DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-3-devendra.verma@amd.com>
In-Reply-To: <20251121113455.4029-3-devendra.verma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-01T09:58:06.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB8223:EE_
x-ms-office365-filtering-correlation-id: 4285b55c-c602-4c2b-8244-08de30c0242d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lxxQopV9XkbZrKbdwk0ihW3Hn1rynd41SDzlNsuP/U14+JXC5yOm2PnUwbuv?=
 =?us-ascii?Q?zNqs7JPw0brvjosyw9IKQMEIpeF4kFmo1h2c21tW7LCzesHZwpFnsevwTUGS?=
 =?us-ascii?Q?+H3fEN4rpRFiBy62Ixg58eNwY5yqTz0S3nFLvackx7FX0NYY9w6RTRv6n8gX?=
 =?us-ascii?Q?f7Gn1xFd3buqo6RmWDB++/b3IN6ZBYijsyT6wu4cjSaBWVwjM4ypXDMY1mrJ?=
 =?us-ascii?Q?gEQKp+EQYV9gYwsifd3HSkkRE8XUundgdZAdqdmqy1EHOC56A3kynHm9+OIO?=
 =?us-ascii?Q?zofDydZ7aD1/G3c/kUlafedmmA1WLsuqvrnQj4Tx2vCYhcDgBRwy0qWrSZsu?=
 =?us-ascii?Q?sq+UcgRSPpJy7UKy9fBn9khng+amYCi2Tb1x2MpHvy4WXZ4OoydfJiKPcIH0?=
 =?us-ascii?Q?hSmgrtZ5b5eUZB/NaloYh9k07v4qTXADaqfGOaPODz517E/x6oLowFzrMORY?=
 =?us-ascii?Q?WKTUKokWREP0me2p15mWdV6jaXYVDBNhgXWxZNKcFVPhyd2IZrWwfCfQSltU?=
 =?us-ascii?Q?9A3rr6QOfkSNk0uAE6pfjwAHisB72VQANVy9BwgrTvcLr+8suaZffv4dw+0N?=
 =?us-ascii?Q?bKJ9ws2l/fIdQgnAegOkXiFu5pke7R5J+YpsSP2Jew/hD+NVVEkOQUMaofgO?=
 =?us-ascii?Q?IiZjPYM9k5euAfP5Qlm1o11DiUNHfdqCK9qtGbtRawssLX23kYtGQ7H14QXX?=
 =?us-ascii?Q?ugOGxMo1NkLpPr3y/YVMeY9AOVsArr67gxcm3kjULPCBKQ/svp2r+hyWuJoA?=
 =?us-ascii?Q?XYVPsPPMX2DmFHfrXyt8pWLsWv7sJVpzkSDBL6OvfUqruqzrf3PNcFD6jjKR?=
 =?us-ascii?Q?45FTdvc2OgOYkgta7HT4hXHR303HBMtV+hFm/kXdRhKMVz0FO2C1utAk63Y0?=
 =?us-ascii?Q?IV9xOfLgvVsNx+Fq7MKGhhg37ZI4LwAyWzu0T8PIRK5kW4+q7jERxdNnASwP?=
 =?us-ascii?Q?xD8V1ick285SXjAExdMc2R1qU+RUF57XLfiBjNCeLsgDYgDk0C32ktepK7/Q?=
 =?us-ascii?Q?iHc6G5kbsTsWYozsfoy2Nuas54OaLYorSDpPIo2azwiV3chXyJylwCwVIegD?=
 =?us-ascii?Q?Vg0mbjngDfuV76gYVWra2E2twL+We9hF9A/PygAWmcTHhgg+PDcXxajiKCEo?=
 =?us-ascii?Q?YBhHZSB0tWQmASpe6/t+vm1zRGGrRDcIZJWcY9Tm+Wm8+ek8sPiDzvMO9M58?=
 =?us-ascii?Q?uqRcmSS8ak+/sfnHVJ1Sae+fuYd7tjlTAPf+hEj/HzFhgbTF5ynQaH94rsEV?=
 =?us-ascii?Q?JTSBhHM52SN9X6WPJVNkPki0VFEp7fcjOQ5b3BQom6NNHIgqO92Cx5x6KTzp?=
 =?us-ascii?Q?LHjDB+HzUkcdFL88hYYEyw4IzUF5UONVNzVXWsABN9zq6cL8hAkQTVwsUJgq?=
 =?us-ascii?Q?3nheWryENv4+N820oZix6ah8OSo6o/bXs0y94B1dg8tGRcgpsMel6S8/Or7K?=
 =?us-ascii?Q?4nVHNV+hvoKrvY+dswHzX/IeWzOqEeIQx4Z8JdfiQB6mADFroQn6CRX9aJfO?=
 =?us-ascii?Q?Z9q3CMCTxHHETDwFyIaOuicHE9Htim2VuerE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nQCcsr1WPt5dU4HZ+c/g52YGMLLvFoy0nGS07Yq+iShG3C4ju5gzy2pLD8B5?=
 =?us-ascii?Q?A4NoNwhSUE9M0BMfmiJMuKf/Cly3ExsFJ28lbhS7umRObvuNWARZ5uer+7l0?=
 =?us-ascii?Q?0geJ3NuFatknAp9MO6vgTiKAncfJVmk/laYw4sPOqngNAcYlsnxUUI1xv8uY?=
 =?us-ascii?Q?DC+P4WMpS+86/kWuDux8tvHJfwdiZPNKOXp50EAO2XTKGdTQn2e2AKUIfjMo?=
 =?us-ascii?Q?Bv1S8SVAYtPpSXR4vi932PRhpwEJgebXm+Q1XhCfhfYqJ/OeYNsApToRLpwt?=
 =?us-ascii?Q?3643WEA/TV++Mys0lwKcdXFXhSU2zXGR/7CEU8Y6ory2WmsA3LkL0Q/sblAW?=
 =?us-ascii?Q?cjXsg/A4IiwIpRp+nIKiRSN9imfh1Zv3muAwz+NXsWQz8QtBz5mi3gQQ7cji?=
 =?us-ascii?Q?pHax4pZQa54HLLpDyXhZnWGfToKU1wasrLOQtqcUMCoyyRqB7HwSafxdDrzH?=
 =?us-ascii?Q?CTEcaB7/1u6bKiVXtA691iiy6ozpkTvu2M0Nc9VPkD2DbPdaWxABt+zx5BsO?=
 =?us-ascii?Q?+dtQ8miEsHD4ytUIYsd9cQKCu+mk6zTcr+YUI8vEhj2iRxVSsGDBTSkogs+i?=
 =?us-ascii?Q?yGG6iRaG1zOjyOpPhYGgGI3xn81+qBt8PSO9i9w3nWnetYCdg0maSdjlPMKr?=
 =?us-ascii?Q?RPMPgjHUJerAqPV9KO34oVKmKDjVqW6sXQAielQbMpWwNSMApXc4U0VbgPtI?=
 =?us-ascii?Q?zN0PVqHuUyhtYuY9+QmDO0lCENY3zAwbuXIRc8wRMQNns4nDH0fOS3fV46bO?=
 =?us-ascii?Q?evnegyUs37GmTmzlZTcpJ/1QN13lx0omQ0zYjTyH98H3t4L6MKcYb6jyVKNI?=
 =?us-ascii?Q?1R2BgefAOjZyc92eWYxGXSQyaHBS3BzoNxjpKpWR1+2EN/iMFtxAVcN083EA?=
 =?us-ascii?Q?fPqYoWb8+R0NXldPUQRXtqNZi+HmHK2FPZnfycmssIgS34S3oAFquTKMiXXu?=
 =?us-ascii?Q?g0eyy/5dTPyQ+zzC6+yEVztMgZebTmjygprTa1SqWQWRtN1FXlg3HH9v+qJV?=
 =?us-ascii?Q?Z/9epwMGmr9fY15cAmguK95rfEwgO1FXKGZpZi6hooT3fzF8x22Pm0B1/aUi?=
 =?us-ascii?Q?8jZrOztbUKj5RHTRx0p2iRcmDjyOa7Al1xBuvOk2iTe26ciOsPGb3CCEoKmD?=
 =?us-ascii?Q?ygdSxc73/TiGn7xKYHfayMxi2fyiGooFUIQO+CJkXOtGuPXVv/Asprfv05lq?=
 =?us-ascii?Q?QumqpShH0cSY+0n4+7Hvj9bKZdtBE5V4JNxXtzlwcdcj/yOJ+m0fRG5XLArh?=
 =?us-ascii?Q?NOD9e/IrqfhtUtzBoPxkVrcQayFgOpJLoIQrtmwwbCTo0oR8sdC4ut3NUpQD?=
 =?us-ascii?Q?MdpFHfu+aPCUgvGHsjGtv5IqKcSoh47qllZbOzJ47h26u3grVA9z6XfSqN3w?=
 =?us-ascii?Q?DQHe0G3EuGo8g3DaUDkbag+lCqbEiIDR8baUNmXQTahThJzEJQYFl3QiW+F8?=
 =?us-ascii?Q?FDcMECJCbtEHn0d1skS1nGYD4yKRDEgprJvh1n2dM85a2x0kXTB2fpwrrgCU?=
 =?us-ascii?Q?vOuA8KMUkjR04S2eOg+odIj81maK6ud88UYsktbfOnLFY2W7J//C8RC4A5UO?=
 =?us-ascii?Q?9c7ElzoqJ1Y/SaeEQmI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4285b55c-c602-4c2b-8244-08de30c0242d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 09:58:13.1557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owpofzK0UZh6I4ix0PdMVLn2yfwPg7gDDaomclzPbjsBPcMIOaJ9tu8xhlzTyOdV7WA2KfBxVjMYFEm1avZnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

[AMD Official Use Only - AMD Internal Distribution Only]

Hi All

Could you all please review the following patch?

Regards,
Dev

> -----Original Message-----
> From: Devendra K Verma <devendra.verma@amd.com>
> Sent: Friday, November 21, 2025 5:05 PM
> To: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org
> Cc: dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
> Devendra <Devendra.Verma@amd.com>
> Subject: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
>
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the DMA
> transactions using the non-LL mode. The following two cases are added wit=
h
> this patch:
> - When a valid physical base address is not configured via the
>   Xilinx VSEC capability then the IP can still be used in non-LL
>   mode. The default mode for all the DMA transactions and for all
>   the DMA channels then is non-LL mode.
> - When a valid physical base address is configured but the client
>   wants to use the non-LL mode for DMA transactions then also the
>   flexibility is provided via the peripheral_config struct member of
>   dma_slave_config. In this case the channels can be individually
>   configured in non-LL mode. This use case is desirable for single
>   DMA transfer of a chunk, this saves the effort of preparing the
>   Link List. This particular scenario is applicable to AMD as well
>   as Synopsys IP.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v6
>   Gave definition to bits used for channel configuration.
>   Removed the comment related to doorbell.
>
> Changes in v5
>   Variable name 'nollp' changed to 'non_ll'.
>   In the dw_edma_device_config() WARN_ON replaced with dev_err().
>   Comments follow the 80-column guideline.
>
> Changes in v4
>   No change
>
> Changes in v3
>   No change
>
> Changes in v2
>   Reverted the function return type to u64 for
>   dw_edma_get_phys_addr().
>
> Changes in v1
>   Changed the function return type for dw_edma_get_phys_addr().
>   Corrected the typo raised in review.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> ++++++++++++++++++++++++++++++++++-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
>  include/linux/dma/edma.h              |  1 +
>  6 files changed, 130 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-
> edma/dw-edma-core.c
> index b43255f..60a3279 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct dma_chan
> *dchan,
>                                struct dma_slave_config *config)
>  {
>       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +     int non_ll =3D 0;
> +
> +     if (config->peripheral_config &&
> +         config->peripheral_size !=3D sizeof(int)) {
> +             dev_err(dchan->device->dev,
> +                     "config param peripheral size mismatch\n");
> +             return -EINVAL;
> +     }
>
>       memcpy(&chan->config, config, sizeof(*config));
> +
> +     /*
> +      * When there is no valid LLP base address available then the defau=
lt
> +      * DMA ops will use the non-LL mode.
> +      * Cases where LL mode is enabled and client wants to use the non-L=
L
> +      * mode then also client can do so via providing the peripheral_con=
fig
> +      * param.
> +      */
> +     if (config->peripheral_config)
> +             non_ll =3D *(int *)config->peripheral_config;
> +
> +     chan->non_ll =3D false;
> +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> +             chan->non_ll =3D true;
> +
>       chan->configured =3D true;
>
>       return 0;
> @@ -353,7 +376,7 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
>       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer->dchan);
>       enum dma_transfer_direction dir =3D xfer->direction;
>       struct scatterlist *sg =3D NULL;
> -     struct dw_edma_chunk *chunk;
> +     struct dw_edma_chunk *chunk =3D NULL;
>       struct dw_edma_burst *burst;
>       struct dw_edma_desc *desc;
>       u64 src_addr, dst_addr;
> @@ -419,9 +442,11 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
>       if (unlikely(!desc))
>               goto err_alloc;
>
> -     chunk =3D dw_edma_alloc_chunk(desc);
> -     if (unlikely(!chunk))
> -             goto err_alloc;
> +     if (!chan->non_ll) {
> +             chunk =3D dw_edma_alloc_chunk(desc);
> +             if (unlikely(!chunk))
> +                     goto err_alloc;
> +     }
>
>       if (xfer->type =3D=3D EDMA_XFER_INTERLEAVED) {
>               src_addr =3D xfer->xfer.il->src_start;
> @@ -450,7 +475,13 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
>               if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>                       break;
>
> -             if (chunk->bursts_alloc =3D=3D chan->ll_max) {
> +             /*
> +              * For non-LL mode, only a single burst can be handled
> +              * in a single chunk unlike LL mode where multiple bursts
> +              * can be configured in a single chunk.
> +              */
> +             if ((chunk && chunk->bursts_alloc =3D=3D chan->ll_max) ||
> +                 chan->non_ll) {
>                       chunk =3D dw_edma_alloc_chunk(desc);
>                       if (unlikely(!chunk))
>                               goto err_alloc;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-
> edma/dw-edma-core.h
> index 71894b9..c8e3d19 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -86,6 +86,7 @@ struct dw_edma_chan {
>       u8                              configured;
>
>       struct dma_slave_config         config;
> +     bool                            non_ll;
>  };
>
>  struct dw_edma_irq {
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-
> edma/dw-edma-pcie.c
> index 3d7247c..e7e95df 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -269,6 +269,15 @@ static void
> dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>       pdata->devmem_phys_off =3D off;
>  }
>
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +                              struct dw_edma_pcie_data *pdata,
> +                              enum pci_barno bar)
> +{
> +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> +             return pdata->devmem_phys_off;
> +     return pci_bus_address(pdev, bar);
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>                             const struct pci_device_id *pid)  { @@ -278,6
> +287,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>       struct dw_edma_chip *chip;
>       int err, nr_irqs;
>       int i, mask;
> +     bool non_ll =3D false;
>
>       vsec_data =3D kmalloc(sizeof(*vsec_data), GFP_KERNEL);
>       if (!vsec_data)
> @@ -302,21 +312,24 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
>       if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
>               /*
>                * There is no valid address found for the LL memory
> -              * space on the device side.
> +              * space on the device side. In the absence of LL base
> +              * address use the non-LL mode or simple mode supported
> by
> +              * the HDMA IP.
>                */
>               if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_AMD_MDB_INVALID_ADDR)
> -                     return -ENOMEM;
> +                     non_ll =3D true;
>
>               /*
>                * Configure the channel LL and data blocks if number of
>                * channels enabled in VSEC capability are more than the
>                * channels configured in amd_mdb_data.
>                */
> -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> -                                            DW_PCIE_XILINX_LL_OFF_GAP,
> -                                            DW_PCIE_XILINX_LL_SIZE,
> -                                            DW_PCIE_XILINX_DT_OFF_GAP,
> -                                            DW_PCIE_XILINX_DT_SIZE);
> +             if (!non_ll)
> +                     dw_edma_set_chan_region_offset(vsec_data, BAR_2,
> 0,
> +
> DW_PCIE_XILINX_LL_OFF_GAP,
> +                                                    DW_PCIE_XILINX_LL_SI=
ZE,
> +
> DW_PCIE_XILINX_DT_OFF_GAP,
> +
> DW_PCIE_XILINX_DT_SIZE);
>       }
>
>       /* Mapping PCI BAR regions */
> @@ -364,6 +377,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>       chip->mf =3D vsec_data->mf;
>       chip->nr_irqs =3D nr_irqs;
>       chip->ops =3D &dw_edma_pcie_plat_ops;
> +     chip->non_ll =3D non_ll;
>
>       chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
>       chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt; @@ -372,7 +386,7 @@ stati=
c
> int dw_edma_pcie_probe(struct pci_dev *pdev,
>       if (!chip->reg_base)
>               return -ENOMEM;
>
> -     for (i =3D 0; i < chip->ll_wr_cnt; i++) {
> +     for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>               struct dw_edma_region *ll_region =3D &chip->ll_region_wr[i]=
;
>               struct dw_edma_region *dt_region =3D &chip->dt_region_wr[i]=
;
>               struct dw_edma_block *ll_block =3D &vsec_data->ll_wr[i]; @@
> -383,7 +397,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>                       return -ENOMEM;
>
>               ll_region->vaddr.io +=3D ll_block->off;
> -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar);
> +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev,
> vsec_data,
> +                                                      ll_block->bar);
>               ll_region->paddr +=3D ll_block->off;
>               ll_region->sz =3D ll_block->sz;
>
> @@ -392,12 +407,13 @@ static int dw_edma_pcie_probe(struct pci_dev
> *pdev,
>                       return -ENOMEM;
>
>               dt_region->vaddr.io +=3D dt_block->off;
> -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar);
> +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev,
> vsec_data,
> +                                                      dt_block->bar);
>               dt_region->paddr +=3D dt_block->off;
>               dt_region->sz =3D dt_block->sz;
>       }
>
> -     for (i =3D 0; i < chip->ll_rd_cnt; i++) {
> +     for (i =3D 0; i < chip->ll_rd_cnt && !non_ll; i++) {
>               struct dw_edma_region *ll_region =3D &chip->ll_region_rd[i]=
;
>               struct dw_edma_region *dt_region =3D &chip->dt_region_rd[i]=
;
>               struct dw_edma_block *ll_block =3D &vsec_data->ll_rd[i]; @@=
 -
> 408,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>                       return -ENOMEM;
>
>               ll_region->vaddr.io +=3D ll_block->off;
> -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->bar);
> +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev,
> vsec_data,
> +                                                      ll_block->bar);
>               ll_region->paddr +=3D ll_block->off;
>               ll_region->sz =3D ll_block->sz;
>
> @@ -417,7 +434,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>                       return -ENOMEM;
>
>               dt_region->vaddr.io +=3D dt_block->off;
> -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->bar);
> +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev,
> vsec_data,
> +                                                      dt_block->bar);
>               dt_region->paddr +=3D dt_block->off;
>               dt_region->sz =3D dt_block->sz;
>       }
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-
> edma/dw-hdma-v0-core.c
> index e3f8db4..ee31c9a 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> dw_edma_chunk *chunk)
>               readl(chunk->ll_region.vaddr.io);
>  }
>
> -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> first)
> +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool
> +first)
>  {
>       struct dw_edma_chan *chan =3D chunk->chan;
>       struct dw_edma *dw =3D chan->dw;
> @@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct
> dw_edma_chunk *chunk, bool first)
>       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> HDMA_V0_DOORBELL_START);  }
>
> +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
> {
> +     struct dw_edma_chan *chan =3D chunk->chan;
> +     struct dw_edma *dw =3D chan->dw;
> +     struct dw_edma_burst *child;
> +     u32 val;
> +
> +     list_for_each_entry(child, &chunk->burst->list, list) {
> +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> HDMA_V0_CH_EN);
> +
> +             /* Source address */
> +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> +                       lower_32_bits(child->sar));
> +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> +                       upper_32_bits(child->sar));
> +
> +             /* Destination address */
> +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> +                       lower_32_bits(child->dar));
> +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> +                       upper_32_bits(child->dar));
> +
> +             /* Transfer size */
> +             SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz=
);
> +
> +             /* Interrupt setup */
> +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> +                             HDMA_V0_STOP_INT_MASK |
> +                             HDMA_V0_ABORT_INT_MASK |
> +                             HDMA_V0_LOCAL_STOP_INT_EN |
> +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> +
> +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> +             }
> +
> +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> +
> +             /* Channel control setup */
> +             val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> +             val &=3D ~HDMA_V0_LINKLIST_EN;
> +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> +
> +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> +                       HDMA_V0_DOORBELL_START);
> +     }
> +}
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> +first) {
> +     struct dw_edma_chan *chan =3D chunk->chan;
> +
> +     if (!chan->non_ll)
> +             dw_hdma_v0_core_ll_start(chunk, first);
> +     else
> +             dw_hdma_v0_core_non_ll_start(chunk);
> +}
> +
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
>       struct dw_edma *dw =3D chan->dw;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-
> edma/dw-hdma-v0-regs.h
> index eab5fd7..7759ba9 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>
>  #define HDMA_V0_MAX_NR_CH                    8
> +#define HDMA_V0_CH_EN                                BIT(0)
>  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> 3080747..78ce31b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -99,6 +99,7 @@ struct dw_edma_chip {
>       enum dw_edma_map_format mf;
>
>       struct dw_edma          *dw;
> +     bool                    non_ll;
>  };
>
>  /* Export to the platform drivers */
> --
> 1.8.3.1


